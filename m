Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELv6ONweJkTiIkSzLazOwuJv3GfDuhg9pnMPVki4wjH3yXSTMmSS9NXkWkwRAV0MBLXhz3Qa
ARC-Seal: i=1; a=rsa-sha256; t=1521316468; cv=none;
        d=google.com; s=arc-20160816;
        b=wT8CAhBeVnrElfF/JeqYyaiwRxE/dUgkN38U+7oNC60gJYKyd9FYqIyUA157AybMb1
         n8jIjSiqY466PnQ0dknPAmmfFFOy86NWptrlNQX38FkBdNxueUgq1V4Pc8OW+T0yOFCZ
         3FqJrCaJUx5gjdzGVRsaoxf+E4bdrgtCSJ3cWMNDByCCy4jebpkLYFA9W+MeJCL4fmzG
         XgCq/hTMJ6lU8dZFul8vXBx3/IabBQbSbl3QrksuapcRFfbRziSWllMK6xs9/pnCILjJ
         5RsE4WsRhw2w4mgTEbHGo0/vRMOr+Mz4Oul2GVI64UybERY2IszIWtH9zfFzk2CL6GDm
         wz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=Lpn2dGuM0vux9I3PZVlytpD70K99WK3x+VvgbeBxTGg=;
        b=EDYlhNnlfjL4aSdboXOtefRXb0W+NKYtm3kqsjeYBhIHDub9HGJx0+GYr1OuyrJAHf
         QecS0KF376Y6/LHPiJXTyxRC53J/7D5wX4DsOdUeaWTzrlP93bqZXvz0EFSC5KOVpoIp
         I6/04OuY6xX0DL9+pwE11Au2/zddmU/AJXT+qx8v8OWrp+peNiXlJcu+KqWyf84AiUMc
         6D4b2wDmOLeTJ9eeJ1BB7kIT7ixRj9Rb4q1mz0Z1UPpnWW6OSPTzxnyqa4VSYUB9Ixl4
         5uoBA9hcrvnxCvxHA0hXQ3sugZuEX18thSfTz+/BCA+BAzfgXtFTj68V64PrxIOT7Pxo
         XxiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CF521720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 19:54:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>, Quentin Schulz
 <quentin.schulz@free-electrons.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/gyro/bmg160_core: Improve unlocking of a mutex in
 five functions
Message-ID: <20180317195422.037a8b57@archlinux>
In-Reply-To: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1595215936962683427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Mar 2018 16:15:32 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 14 Mar 2018 16:06:49 +0100
> 
> * Add jump targets so that a call of the function "mutex_unlock" is stored
>   only once in these function implementations.
> 
> * Replace 19 calls by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

Some of these are good and sensible changes - others break the code.
Please be careful to fully check all the resulting paths and ensure
we don't change wether the lock is still held in all exit paths.
Note a function that isn't lockdep annotated should not be holding
any locks, that it took, upon exit.

> ---
>  drivers/iio/gyro/bmg160_core.c | 103 ++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 63ca31628a93..fa367fd7bc8c 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -499,21 +499,19 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
>  
>  	mutex_lock(&data->mutex);
>  	ret = bmg160_set_power_state(data, true);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading reg_temp\n");
>  		bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	*val = sign_extend32(raw_val, 7);
>  	ret = bmg160_set_power_state(data, false);
> +unlock:
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
> @@ -529,22 +527,20 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
>  
>  	mutex_lock(&data->mutex);
>  	ret = bmg160_set_power_state(data, true);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
>  			       sizeof(raw_val));
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading axis %d\n", axis);
>  		bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	*val = sign_extend32(le16_to_cpu(raw_val), 15);
>  	ret = bmg160_set_power_state(data, false);
> +unlock:
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0)
>  		return ret;
> @@ -632,19 +628,16 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
>  		 * mode to power on for other writes.
>  		 */
>  		ret = bmg160_set_power_state(data, true);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto unlock;
> +
>  		ret = bmg160_set_bw(data, val);
>  		if (ret < 0) {
>  			bmg160_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			goto unlock;
>  		}
> -		ret = bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +
> +		goto set_power_state;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		if (val2)
>  			return -EINVAL;
> @@ -653,18 +646,15 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
>  		ret = bmg160_set_power_state(data, true);
>  		if (ret < 0) {
>  			bmg160_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			goto unlock;
>  		}
>  		ret = bmg160_set_filter(data, val);
>  		if (ret < 0) {
>  			bmg160_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			goto unlock;
>  		}
> -		ret = bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +
> +		goto set_power_state;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (val)
>  			return -EINVAL;
> @@ -672,24 +662,27 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&data->mutex);
>  		/* Refer to comments above for the suspend mode ops */
>  		ret = bmg160_set_power_state(data, true);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			goto unlock;
> +
>  		ret = bmg160_set_scale(data, val2);
>  		if (ret < 0) {
>  			bmg160_set_power_state(data, false);
> -			mutex_unlock(&data->mutex);
> -			return ret;
> +			goto unlock;
>  		}
> -		ret = bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
Please keep the mutex_unlock in the same scope as the
mutex_lock.

I may make sense to take both outside the switch statement but
that needs careful consideration.

> -		return ret;
> +
> +		goto set_power_state;
>  	default:
>  		return -EINVAL;
We exit with the mutex locked now and it should not be.

>  	}
>  
>  	return -EINVAL;
Mutex is still locked here and the return is wrong.
> +
> +set_power_state:
> +	ret = bmg160_set_power_state(data, false);
> +unlock:
> +	mutex_unlock(&data->mutex);
blank line before the return.

> +	return ret;
>  }
>  
>  static int bmg160_read_event(struct iio_dev *indio_dev,
> @@ -763,8 +756,8 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  
>  	if (!state && data->motion_trigger_on) {
>  		data->ev_enable_state = 0;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> +		ret = 0;
Put this in as the value at instantiation.
int ret = 0;
> +		goto unlock;
>  	}
>  	/*
>  	 * We will expect the enable and disable to do operation in
> @@ -776,22 +769,19 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
>  	 * is always on so sequence doesn't matter
>  	 */
>  	ret = bmg160_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
>  
>  	ret =  bmg160_setup_any_motion_interrupt(data, state);
>  	if (ret < 0) {
>  		bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  
>  	data->ev_enable_state = state;
> +unlock:
>  	mutex_unlock(&data->mutex);
> -
Blank line preferred before the return ret.
> -	return 0;
> +	return ret;
>  }
>  
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
> @@ -919,8 +909,8 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  
>  	if (!state && data->ev_enable_state && data->motion_trigger_on) {
>  		data->motion_trigger_on = false;
> -		mutex_unlock(&data->mutex);
> -		return 0;
> +		ret = 0;
Setting ret where it is originally defined to 0 would be tidier.

int ret = 0;

> +		goto unlock;
>  	}
>  
>  	/*
> @@ -928,27 +918,24 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	 * enable/disable operation order
>  	 */
>  	ret = bmg160_set_power_state(data, state);
> -	if (ret < 0) {
> -		mutex_unlock(&data->mutex);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto unlock;
> +
>  	if (data->motion_trig == trig)
>  		ret =  bmg160_setup_any_motion_interrupt(data, state);
>  	else
>  		ret = bmg160_setup_new_data_interrupt(data, state);
>  	if (ret < 0) {
>  		bmg160_set_power_state(data, false);
> -		mutex_unlock(&data->mutex);
> -		return ret;
> +		goto unlock;
>  	}
>  	if (data->motion_trig == trig)
>  		data->motion_trigger_on = state;
>  	else
>  		data->dready_trigger_on = state;
> -
> +unlock:
>  	mutex_unlock(&data->mutex);
> -
> -	return 0;
I would prefer a blank line between the mutex_unlock and the return.

> +	return ret;
>  }
>  
>  static const struct iio_trigger_ops bmg160_trigger_ops = {
