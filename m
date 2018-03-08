Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936101AbeCHQ61 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:58:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56242 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935923AbeCHQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:58:24 -0500
X-Google-Smtp-Source: AG47ELsANXfdh+vxGfIdAmOV/bzRRBfh872dw/jBYhE6OJYr6JCJaH2iF+jwZjN1PRh+jRAnqqKSQQ==
Subject: Re: [PATCH 1/2] backlight: Add RAVE SP backlight driver
To: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
        Aleksander Morgado <aleksander@aleksander.es>
References: <20180307024011.25033-1-andrew.smirnov@gmail.com>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <e90aba60-9126-17c2-7c70-66b5cab32d93@linaro.org>
Date: Thu, 8 Mar 2018 16:58:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307024011.25033-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 02:40, Andrey Smirnov wrote:
> This driver provides access to RAVE SP backlight control
> functionality.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Aleksander Morgado <aleksander@aleksander.es>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   drivers/video/backlight/Kconfig             |  6 +++
>   drivers/video/backlight/Makefile            |  1 +
>   drivers/video/backlight/rave-sp-backlight.c | 82 +++++++++++++++++++++++++++++
>   include/linux/mfd/rave-sp.h                 |  1 +
>   4 files changed, 90 insertions(+)
>   create mode 100644 drivers/video/backlight/rave-sp-backlight.c
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 4e1d2ad50ba1..5d2d0d7e8100 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -467,6 +467,12 @@ config BACKLIGHT_ARCXCNN
>   	  If you have an ARCxCnnnn family backlight say Y to enable
>   	  the backlight driver.
>   
> +config BACKLIGHT_RAVE_SP
> +	tristate "RAVE SP Backlight driver"
> +	depends on RAVE_SP_CORE
> +	help
> +	  Support for backlight control on RAVE SP device.
> +
>   endif # BACKLIGHT_CLASS_DEVICE
>   
>   endif # BACKLIGHT_LCD_SUPPORT
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 5e28f01c8391..19da71d518bf 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -57,3 +57,4 @@ obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
>   obj-$(CONFIG_BACKLIGHT_TPS65217)	+= tps65217_bl.o
>   obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
>   obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
> +obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
> diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
> new file mode 100644
> index 000000000000..62836ba561db
> --- /dev/null
> +++ b/drivers/video/backlight/rave-sp-backlight.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * LCD Backlight driver for RAVE SP
> + *
> + * Copyright (C) 2018 Zodiac Inflight Innovations
> + *
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/rave-sp.h>
> +#include <linux/platform_device.h>
> +
> +#define	RAVE_SP_BACKLIGHT_LCD_EN	BIT(7)
> +
> +static int rave_sp_backlight_update_status(struct backlight_device *bd)
> +{
> +	const struct backlight_properties *p = &bd->props;
> +	const u8 intensity =
> +		(p->power == FB_BLANK_UNBLANK) ? p->brightness : 0;
> +	struct rave_sp *sp = dev_get_drvdata(&bd->dev);
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_SET_BACKLIGHT,
> +		[1] = 0,
> +		[2] = intensity ? RAVE_SP_BACKLIGHT_LCD_EN | intensity : 0,
> +		[3] = 0,
> +		[4] = 0,
> +	};
> +
> +	return rave_sp_exec(sp, cmd, sizeof(cmd), NULL, 0);
> +}
> +
> +static const struct backlight_ops rave_sp_backlight_ops = {
> +	.options	= BL_CORE_SUSPENDRESUME,
> +	.update_status	= rave_sp_backlight_update_status,
> +};
> +
> +static struct backlight_properties rave_sp_backlight_props = {
> +	.type		= BACKLIGHT_FIRMWARE,

I would have thought BACKLIGHT_PLATFORM would be more suitable here. 
BACKLIGHT_FIRMWARE is used for things like the ACPI backlight driver.

Why did you select this one?


Daniel.


> +	.max_brightness = 100,
> +	.brightness	= 50,
> +};
> +
> +static int rave_sp_backlight_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct backlight_device *bd;
> +
> +	bd = devm_backlight_device_register(dev, pdev->name, dev->parent,
> +					    dev_get_drvdata(dev->parent),
> +					    &rave_sp_backlight_ops,
> +					    &rave_sp_backlight_props);
> +	if (IS_ERR(bd))
> +		return PTR_ERR(bd);
> +
> +	backlight_update_status(bd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rave_sp_backlight_of_match[] = {
> +	{ .compatible = "zii,rave-sp-backlight" },
> +	{}
> +};
> +
> +static struct platform_driver rave_sp_backlight_driver = {
> +	.probe = rave_sp_backlight_probe,
> +	.driver	= {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = rave_sp_backlight_of_match,
> +	},
> +};
> +module_platform_driver(rave_sp_backlight_driver);
> +
> +MODULE_DEVICE_TABLE(of, rave_sp_backlight_of_match);
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>");
> +MODULE_AUTHOR("Nikita Yushchenko <nikita.yoush@cogentembedded.com>");
> +MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
> +MODULE_DESCRIPTION("RAVE SP Backlight driver");
> diff --git a/include/linux/mfd/rave-sp.h b/include/linux/mfd/rave-sp.h
> index 796fb9794c9e..fe0ce7bc59cf 100644
> --- a/include/linux/mfd/rave-sp.h
> +++ b/include/linux/mfd/rave-sp.h
> @@ -21,6 +21,7 @@ enum rave_sp_command {
>   	RAVE_SP_CMD_STATUS			= 0xA0,
>   	RAVE_SP_CMD_SW_WDT			= 0xA1,
>   	RAVE_SP_CMD_PET_WDT			= 0xA2,
> +	RAVE_SP_CMD_SET_BACKLIGHT		= 0xA6,
>   	RAVE_SP_CMD_RESET			= 0xA7,
>   	RAVE_SP_CMD_RESET_REASON		= 0xA8,
>   
> 
