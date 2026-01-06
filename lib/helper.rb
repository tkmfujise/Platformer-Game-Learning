module Helper
  def header_title
    @config[:title] || @items['/index.*']&.[](:application_name) || 'gd-doc'
  end

  def categories
    %w[scenes scripts resources assets]
  end
  
  def current_category
    category_of(@item)
  end

  def category_of(item)
    categories.find{|c| item.path.start_with? "/#{c}" } || categories[0]
  end

  def all_items_of(category)
    @items.find_all("/#{category}/**/*.adoc")
  end

  def siblings_of(item)
    all_items_of(category_of(item))
  end

  def prev_item_of(item)
    list = siblings_of(item)
    idx = list.index(item)
    idx && idx > 0 ? list[idx - 1] : nil
  end

  def next_item_of(item)
    list = siblings_of(item)
    idx = list.index(item)
    idx ? list[idx + 1] : nil
  end


  def link_text_of(item)
    item.path.delete_prefix("/#{category_of(item)}/")[0..-2]
  end
end

