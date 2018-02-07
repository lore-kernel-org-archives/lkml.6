Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeBGPH3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:07:29 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56233 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754108AbeBGPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:07:27 -0500
X-Google-Smtp-Source: AH8x226R3fMCgbutbQZGcc86fVzcNqFXAD0zbMdyAMbWSw0YMrUYmdptr3rnn+5kKn5NBes04xpVow==
Date: Wed, 7 Feb 2018 15:07:22 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] backlight: pwm_bl: linear interpolation between
 brightness-levels
Message-ID: <20180207150722.zblz6dnfcmrvlxa4@oak.lan>
References: <20180207141337.22247-1-enric.balletbo@collabora.com>
 <20180207141337.22247-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207141337.22247-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 03:13:34PM +0100, Enric Balletbo i Serra wrote:
> Setting num-interpolated-steps in the dts will allow you to have linear
> interpolation between values of brightness-levels. This way a high
> resolution pwm duty cycle can be used without having to list out every
> possible value in the dts. This system also allows for gamma corrected
> values.
> 
> The most simple example is interpolate between two brightness values a
> number of steps, this can be done setting the following in the dts:
> 
>   brightness-levels = <0 65535>;
>   num-interpolated-steps = <1024>;
>   default-brightness-level = <512>;
> 
> This will create a brightness-level table with the following values:
> 
>   <0 63 126 189 252 315 378 441 ... 64260 64323 64386 64449 65535>
> 
> Another use case can be describe a gamma corrected curve, as we have
> better sensitivity at low luminance than high luminance we probably
> want have smaller steps for low brightness levels values and bigger
> steps for high brightness levels values. This can be achieved with
> the following in the dts:
> 
>   brightness-levels = <0 4096 65535>;
>   num-interpolated-steps = <1024>;
>   default-brightness-level = <512>;
> 
> This will create a brightness-levels table with the following values:
> 
>   <0 4 8 12 16 20 ... 4096 4156 4216 4276 ... 65535>
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I'd really like to ack this one (especially so given I'm extremely late 
with a review) but unfortunately...


> ---
> Changes since v1:
> - None.
> 
>  drivers/video/backlight/pwm_bl.c | 86 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 8e3f1245f5c5..9dbf0b3e806f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -147,7 +147,11 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  				  struct platform_pwm_backlight_data *data)
>  {
>  	struct device_node *node = dev->of_node;
> +	unsigned int num_levels = 0;
> +	unsigned int levels_count;
> +	unsigned int num_steps;
>  	struct property *prop;
> +	unsigned int *table;
>  	int length;
>  	u32 value;
>  	int ret;
> @@ -167,6 +171,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  	/* read brightness levels from DT property */
>  	if (data->max_brightness > 0) {
>  		size_t size = sizeof(*data->levels) * data->max_brightness;
> +		unsigned int i, j, n = 0;
>  
>  		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
>  		if (!data->levels)
> @@ -184,6 +189,87 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			return ret;
>  
>  		data->dft_brightness = value;
> +
> +		/*
> +		 * This property is optional, if is set enables linear
> +		 * interpolation between each of the values of brightness levels
> +		 * and creates a new pre-computed table.
> +		 */
> +		of_property_read_u32(node, "num-interpolated-steps",
> +				     &num_steps);
> +
> +		/*
> +		 * Make sure that there is at least two entries in the
> +		 * brightness-levels table, otherwise we can't interpolate
> +		 * between two points.
> +		 */
> +		if (num_steps) {
> +			if (data->max_brightness < 2) {
> +				dev_err(dev, "can't interpolate\n");
> +				return -EINVAL;
> +			}
> +
> +			/*
> +			 * Recalculate the number of brightness levels, now
> +			 * taking in consideration the number of interpolated
> +			 * steps between two levels.
> +			 */
> +			for (i = 0; i < data->max_brightness - 1; i++) {
> +				if ((data->levels[i + 1] - data->levels[i]) /
> +				   num_steps)
> +					num_levels += num_steps;
> +				else
> +					num_levels++;
> +			}
> +			num_levels++;
> +			dev_dbg(dev, "new number of brightness levels: %d\n",
> +				num_levels);
> +
> +			/*
> +			 * Create a new table of brightness levels with all the
> +			 * interpolated steps.
> +			 */
> +			table = kcalloc(num_levels, sizeof(*table), GFP_KERNEL);
> +			if (!table)
> +				return -ENOMEM;
> +
> +			/* Fill the interpolated table. */
> +			levels_count = 0;
> +			for (i = 0; i < data->max_brightness - 1; i++) {
> +				value = data->levels[i];
> +				n = (data->levels[i + 1] - value) / num_steps;
> +				if (n > 0) {
> +					for (j = 0; j < num_steps; j++) {
> +						table[levels_count] = value;
> +						value += n;
> +						levels_count++;
> +					}
> +				} else {
> +					table[levels_count] = data->levels[i];
> +					levels_count++;
> +				}
> +			}
> +			table[levels_count] = data->levels[i];
> +
> +			/*
> +			 * As we use interpolation lets remove current
> +			 * brightness levels table for the new interpolated
> +			 * table.
> +			 */
> +			devm_kfree(dev, data->levels);
> +			data->levels = devm_kcalloc(dev, num_levels,
> +						    sizeof(*data->levels),
> +						    GFP_KERNEL);
> +			memcpy(data->levels, table,
> +			       num_levels * sizeof(*table));

... this looks a bit too odd.

I think I can live we a pre-calculated table (not my preference... but I
can live with it). However the way table is allocated, then allocated 
again and copied without a NULL check isn't OK.

Can't we just switch the first allocation over to a devres alloc and
then just swap pointers here?

And a minor nit: do we need calloc?  The loop should initialize every 
element anyway.


Daniel.


> +			kfree(table);
> +			/*
> +			 * Reassign max_brightness value to the new total number
> +			 * of brightness levels.
> +			 */
> +			data->max_brightness = num_levels;
> +		}
> +
>  		data->max_brightness--;
>  	}
>  
> -- 
> 2.15.1
> 
