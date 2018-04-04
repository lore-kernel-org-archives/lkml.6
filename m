Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeDDTEf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:04:35 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:58270 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeDDTEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:04:33 -0400
Subject: Re: [PATCHv4 06/10] mfd: ti-lmu: add PWM support
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
CC: Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-7-sebastian.reichel@collabora.co.uk>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <e2b6ec34-c5b8-2ff1-ee05-4c41fc255295@ti.com>
Date: Wed, 4 Apr 2018 14:04:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180330172414.26575-7-sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian

-Milo

On 03/30/2018 12:24 PM, Sebastian Reichel wrote:
> This adds support to acquire the optional PWM channel,
> that can be used by some of the LMU variants.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/ti-lmu.c       | 11 +++++++++++
>  include/linux/mfd/ti-lmu.h |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> index ce16c896879b..f43b8acc30e1 100644
> --- a/drivers/mfd/ti-lmu.c
> +++ b/drivers/mfd/ti-lmu.c
> @@ -183,6 +183,17 @@ static int ti_lmu_probe(struct i2c_client *cl, const struct i2c_device_id *id)
>  		return ret;
>  	}
>  
> +	lmu->pwm = devm_pwm_get(dev, "lmu-backlight");

Patch 9 of this series, or a derivative of it, should technically be before Patch 6 so that the binding is correct.
Otherwise the binding will not match the code

Dan



> +	if (IS_ERR(lmu->pwm)) {
> +		ret = PTR_ERR(lmu->pwm);
> +		if (ret != -EINVAL) {
> +			dev_err(dev, "Failed to get PWM: %d\n", ret);
> +			return ret;
> +		}
> +
> +		lmu->pwm = NULL;
> +	}
> +
>  	ret = ti_lmu_enable_hw(lmu, id->driver_data);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
> index 1ef51ed36be5..246ab5145dff 100644
> --- a/include/linux/mfd/ti-lmu.h
> +++ b/include/linux/mfd/ti-lmu.h
> @@ -17,6 +17,7 @@
>  #include <linux/notifier.h>
>  #include <linux/regmap.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/pwm.h>
>  
>  /* Notifier event */
>  #define LMU_EVENT_MONITOR_DONE		0x01
> @@ -77,12 +78,14 @@ enum lm363x_regulator_id {
>   * @dev:	Parent device pointer
>   * @regmap:	Used for i2c communcation on accessing registers
>   * @en_gpio:	GPIO for HWEN pin [Optional]
> + * @pwm:	PWM for module [Optional]
>   * @notifier:	Notifier for reporting hwmon event
>   */
>  struct ti_lmu {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct gpio_desc *en_gpio;
> +	struct pwm_device *pwm;
>  	struct blocking_notifier_head notifier;
>  };
>  #endif
> 


-- 
------------------
Dan Murphy
