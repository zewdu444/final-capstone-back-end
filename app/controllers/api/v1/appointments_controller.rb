class Api::V1::AppointmentsController < ApplicationController
    def index
        @appointments = Appointment.all
        if @appointments.empty?
            render json: { error: @appointments.errors.full_messages }, status: :unprocessable_entity
        else
            render json: @appointments
        end
    end
    
    def show
        @appointment = Appointment.find_by(id: params[id])
        if @appointment.present?
            render json: @appointment
        else
            render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def create
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
            render json: @appointment, status: :created
          else
            render json: @appointment.errors, status: :unprocessable_entity
        end
    end

    def update
        if @appointment.update(appointment_params)
          render json: @appointment
        else
          render json: @appointment.errors, status: :unprocessable_entity
        end
    end

    private

    def appointment_params
        params.require(:appointment).permit(:date, :status, :user_id, :therapist_id)
    end
end
