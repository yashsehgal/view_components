# frozen_string_literal: true

# :nocov:
Rails.application.routes.draw do
  if Rails.env.production?
    get "/view-components", to: redirect("/view-components/lookbook/")
    get "/", to: redirect("/view-components/lookbook/")
  else
    get "/", to: redirect("/lookbook/")
  end

  scope path: Rails.env.production? ? "/view-components/rails-app/" : "/" do
    get "/auto_complete", to: "auto_complete_test#index", as: :autocomplete_index

    resources :toggle_switch, only: [:create]
    resources :nav_list_items, only: [:index]
    resources :multi, only: [:create]

    post "/example_check/ok", to: "auto_check#ok", as: :example_check_ok
    post "/example_check/error", to: "auto_check#error", as: :example_check_error
    post "/example_check/random", to: "auto_check#random", as: :example_check_random

    get "/action_menu/deferred", to: "action_menu#deferred", as: :action_menu_deferred
    get "/action_menu/deferred_preload", to: "action_menu#deferred_preload", as: :action_menu_deferred_preload
  end

  scope path: Rails.env.production? ? "/view-components/lookbook/" : "/lookbook" do
    mount Lookbook::Engine, at: "/" if defined?(Lookbook)
  end
end
