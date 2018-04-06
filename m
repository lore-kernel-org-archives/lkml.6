Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDFPqk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:46:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38481 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbeDFPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:46:37 -0400
X-Google-Smtp-Source: AIpwx4/MSatvUZ5BB9Qeb75/I5MOU0h3KdnHH9d2IAWm6hCcCneju6wIQb4W3e6caGC06X31E69Dkg==
Date: Fri, 6 Apr 2018 16:46:32 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 1/4] backlight: pwm_bl: linear interpolation between
 brightness-levels
Message-ID: <20180406154632.ttt5qgsbwsveipwh@holly.lan>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208113032.27810-2-enric.balletbo@collabora.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 12:30:29PM +0100, Enric Balletbo i Serra wrote:
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

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> Changes since v2:
> Requested by Daniel Thompson:
>  - Use a devres alloc for table creatiion and then just swap pointers.
>  - No need to use calloc because the loop initializes every element.
> Changes since v1:
> - None.
> 
>  drivers/video/backlight/pwm_bl.c | 83 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 8e3f1245f5c5..f0a108ab570a 100644
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
> @@ -184,6 +189,84 @@ static int pwm_backlight_parse_dt(struct device *dev,
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
> +			size = sizeof(*table) * num_levels;
> +			table = devm_kzalloc(dev, size, GFP_KERNEL);
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
> +			 * brightness levels table and replace for the
> +			 * new interpolated table.
> +			 */
> +			devm_kfree(dev, data->levels);
> +			data->levels = table;
> +
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
