class IncomesController < ApplicationController

  def new
    @income = Income.new
    @income.tax = 23
  end

  def index
    @incomes = current_user.incomes.order('id DESC').paginate(page: params[:page], per_page: 10)
    @total = current_user.incomes_sum
  end

  def create
    @income = Income.new(params[:income])
    @income.user_id = current_user.id
    if @income.save
      redirect_to incomes_path, notice: t('flash.success_one', model: t('activerecord.models.income'))
    else
      render action: "new"
    end
  end
end
