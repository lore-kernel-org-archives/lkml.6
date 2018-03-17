Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753011AbeCQWax (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 18:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeCQWau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 18:30:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A69B21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 22:30:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/accel/kxcjk-1013: Improve unlocking of a mutex in
 three functions
Message-ID: <20180317223044.42c963b9@archlinux>
In-Reply-To: <a4522ea5-78dc-4746-054a-7477d395630f@users.sourceforge.net>
References: <a4522ea5-78dc-4746-054a-7477d395630f@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 13:47:20 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Mar 2018 13:40:12 +0100
> 
> * Add jump targets so that a call of the function "mutex_unlock" is stored
>   less often in these function implementations.
> 
> * Replace eight calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
A few minor comments inline, but at first glance at least these look
to be fine in principle.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 46 ++++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index af53a1084ee5..4adf38b6d939 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -765,19 +765,18 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
>  			ret = -EBUSY;
>  		else {
>  			ret = kxcjk1013_set_power_state(data, true);
> -			if (ret < 0) {
> -				mutex_unlock(&data->mutex);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				goto unlock;
> +
>  			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
>  			if (ret < 0) {
>  				kxcjk1013_set_power_state(data, false);
> -				mutex_unlock(&data->mutex);
> -				return ret;
> +				goto unlock;
>  			}
>  			*val = sign_extend32(ret >> 4, 11);
>  			ret = kxcjk1013_set_power_state(data, false);
>  		}
> +unlock:
>  		mutex_unlock(&data->mutex);
>  
>  		if (ret < 0)
> @@ -905,8 +904,8 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
>  
>  	if (!state && data->motion_trigger_on) {
>  		data->ev_enable_state = 0;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> +		ret = 0;
do this where it is orginally defined rather than here.

int ret = 0;
> +		goto unlock;
>  	}
>  
>  	/*
> @@ -919,23 +918,20 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
>  	 * is always on so sequence doesn't matter
>  	 */
>  	ret = kxcjk1013_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
>  	if (ret < 0) {
>  		kxcjk1013_set_power_state(data, false);
>  		data->ev_enable_state = 0;
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	data->ev_enable_state = state;
> +unlock:
>  	mutex_unlock(&data->mutex);
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
> @@ -1086,32 +1082,30 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  	if (!state && data->ev_enable_state && data->motion_trigger_on) {
>  		data->motion_trigger_on = false;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> +		ret = 0;
> +		goto unlock;
>  	}
>  
>  	ret = kxcjk1013_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
> +
>  	if (data->motion_trig == trig)
>  		ret = kxcjk1013_setup_any_motion_interrupt(data, state);
>  	else
>  		ret = kxcjk1013_setup_new_data_interrupt(data, state);
>  	if (ret < 0) {
>  		kxcjk1013_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  	if (data->motion_trig == trig)
>  		data->motion_trigger_on = state;
>  	else
>  		data->dready_trigger_on = state;
>  
> +unlock:
>  	mutex_unlock(&data->mutex);
> -
Please leave the blank line.  It makes it slightly easier for the eye
to pick up on the return.

> -	return 0;
> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
