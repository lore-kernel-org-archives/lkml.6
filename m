Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeCGQcU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:32:20 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37134 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933545AbeCGQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:32:15 -0500
X-Google-Smtp-Source: AG47ELtHpOlBNbDNN0yaiiIWHdcmdza6nuNiJXtmUN82NuPM3B7XIby5s9S1uwkF63pAZWMDvtppxg==
Date: Wed, 7 Mar 2018 16:32:11 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Message-ID: <20180307163211.rytfli5tb47yhtug@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2018, Sebastian Reichel wrote:

> From: Sebastian Reichel <sre@kernel.org>
> 
> Add support for the audio-codec node by converting from
> devm_of_platform_populate() to devm_mfd_add_devices().
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/motorola-cpcap.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> index d2cc1eabac05..f6c79a4ccb55 100644
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -18,6 +18,7 @@
>  #include <linux/regmap.h>
>  #include <linux/sysfs.h>
>  
> +#include <linux/mfd/core.h>
>  #include <linux/mfd/motorola-cpcap.h>
>  #include <linux/spi/spi.h>
>  
> @@ -216,6 +217,53 @@ static const struct regmap_config cpcap_regmap_config = {
>  	.val_format_endian = REGMAP_ENDIAN_LITTLE,
>  };
>  
> +static const struct mfd_cell cpcap_mfd_devices[] = {
> +	{
> +		.name          = "cpcap_adc",
> +		.of_compatible = "motorola,mapphone-cpcap-adc",
> +	}, {
> +		.name          = "cpcap_battery",
> +		.of_compatible = "motorola,cpcap-battery",
> +	}, {
> +		.name          = "cpcap-charger",
> +		.of_compatible = "motorola,mapphone-cpcap-charger",
> +	}, {
> +		.name          = "cpcap-regulator",
> +		.of_compatible = "motorola,mapphone-cpcap-regulator",
> +	}, {
> +		.name          = "cpcap-rtc",
> +		.of_compatible = "motorola,cpcap-rtc",
> +	}, {
> +		.name          = "cpcap-pwrbutton",
> +		.of_compatible = "motorola,cpcap-pwrbutton",
> +	}, {
> +		.name          = "cpcap-usb-phy",
> +		.of_compatible = "motorola,mapphone-cpcap-usb-phy",
> +	}, {
> +		.name          = "cpcap-led",
> +		.id            = 0,
> +		.of_compatible = "motorola,cpcap-led-red",
> +	}, {
> +		.name          = "cpcap-led",
> +		.id            = 1,
> +		.of_compatible = "motorola,cpcap-led-green",
> +	}, {
> +		.name          = "cpcap-led",
> +		.id            = 2,
> +		.of_compatible = "motorola,cpcap-led-blue",
> +	}, {
> +		.name          = "cpcap-led",
> +		.id            = 3,
> +		.of_compatible = "motorola,cpcap-led-adl",
> +	}, {
> +		.name          = "cpcap-led",
> +		.id            = 4,
> +		.of_compatible = "motorola,cpcap-led-cp",
> +	}, {
> +		.name          = "cpcap-codec",
> +	}
> +};

With none of the entries containing platform_data /me wonders why you
can't still use devm_of_platform_populate()?

>  static int cpcap_probe(struct spi_device *spi)
>  {
>  	const struct of_device_id *match;
> @@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	return devm_of_platform_populate(&cpcap->spi->dev);
> +	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> +				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
>  }
>  
>  static struct spi_driver cpcap_driver = {

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
