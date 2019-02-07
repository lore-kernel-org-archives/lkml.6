Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552DFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C9721721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfBGUA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:00:29 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:52152 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBGUA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:00:28 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 66F243A4687;
        Thu,  7 Feb 2019 20:51:03 +0100 (CET)
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3566A200004;
        Thu,  7 Feb 2019 19:50:57 +0000 (UTC)
Date:   Thu, 7 Feb 2019 20:50:57 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel@vger.kernel.org, sjg@chromium.org,
        dmitry.torokhov@gmail.com, sre@kernel.org,
        linux-input@vger.kernel.org, groeck@chromium.org,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v4 4/9] platform/chrome: rtc: Add RTC driver
Message-ID: <20190207195057.GA5015@piout.net>
References: <20190123183325.92946-1-ncrews@chromium.org>
 <20190123183325.92946-5-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123183325.92946-5-ncrews@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2019 11:33:20-0700, Nick Crews wrote:
> From: Duncan Laurie <dlaurie@google.com>
> 
> This Embedded Controller has an internal RTC that is exposed
> as a standard RTC class driver with read/write functionality.
> 
> The driver is added to the drivers/rtc/ so that the maintainer of that
> directory will be able to comment on this change, as that maintainer is
> the expert on this system. In addition, the driver code is called
> indirectly after a corresponding device is registered from core.c,
> as opposed to core.c registering the driver callbacks directly.
> 
> > hwclock --show --rtc /dev/rtc1
> 2007-12-31 16:01:20.460959-08:00
> > hwclock --systohc --rtc /dev/rtc1
> > hwclock --show --rtc /dev/rtc1
> 2018-11-29 17:08:00.780793-08:00
> 
> Signed-off-by: Duncan Laurie <dlaurie@google.com>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Changes in v4:
> - Change me email to @chromium.org from @google.com
> - Move "Add RTC driver" before "Add sysfs attributes" so that
>   it could get accepted earlier, since it is less contentious
> 
> Changes in v3:
> - rm #define for driver name
> - Don't compute weekday when reading from RTC.
>   Still set weekday when writing, as RTC needs this
>   to control advanced power scheduling
> - rm check for invalid month data
> - Set range_min and range_max on rtc_device
> 
> Changes in v2:
> - rm license boiler plate
> - rm "wilco_ec_rtc -" prefix in docstring
> - Make rtc driver its own module within the drivers/rtc/ directory
> - Register a rtc device from core.c that is picked up by this driver
> 
>  drivers/platform/chrome/wilco_ec/core.c |  14 ++
>  drivers/rtc/Kconfig                     |  11 ++
>  drivers/rtc/Makefile                    |   1 +
>  drivers/rtc/rtc-wilco-ec.c              | 177 ++++++++++++++++++++++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 drivers/rtc/rtc-wilco-ec.c
> 
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> index e036d88b6dd8..7cfb047e2c89 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -87,6 +87,20 @@ static int wilco_ec_probe(struct platform_device *pdev)
>  		goto destroy_mec;
>  	}
>  
> +	/*
> +	 * Register a RTC platform device that will get picked up by the RTC
> +	 * subsystem. This platform device will get freed when its parent device
> +	 * dev is unregistered.
> +	 */
> +	child_pdev = platform_device_register_data(dev, "rtc-wilco-ec",
> +						   PLATFORM_DEVID_AUTO,
> +						   NULL, 0);
> +	if (IS_ERR(child_pdev)) {
> +		dev_err(dev, "Failed to create RTC platform device\n");
> +		ret = PTR_ERR(child_pdev);
> +		goto destroy_mec;
> +	}
> +
>  	return 0;
>  
>  destroy_mec:
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 225b0b8516f3..d5063c791515 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1814,4 +1814,15 @@ config RTC_DRV_GOLDFISH
>  	  Goldfish is a code name for the virtual platform developed by Google
>  	  for Android emulation.
>  
> +config RTC_DRV_WILCO_EC
> +	tristate "Wilco EC RTC"
> +	depends on WILCO_EC
> +	default m
> +	help
> +	  If you say yes here, you get read/write support for the Real Time
> +	  Clock on the Wilco Embedded Controller (Wilco is a kind of Chromebook)
> +
> +	  This can also be built as a module. If so, the module will
> +	  be named "rtc_wilco_ec".
> +
>  endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index df022d820bee..6255ea78da25 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -172,6 +172,7 @@ obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
>  obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
>  obj-$(CONFIG_RTC_DRV_VRTC)	+= rtc-mrst.o
>  obj-$(CONFIG_RTC_DRV_VT8500)	+= rtc-vt8500.o
> +obj-$(CONFIG_RTC_DRV_WILCO_EC)	+= rtc-wilco-ec.o
>  obj-$(CONFIG_RTC_DRV_WM831X)	+= rtc-wm831x.o
>  obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
>  obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> new file mode 100644
> index 000000000000..35cc56114c1c
> --- /dev/null
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RTC interface for Wilco Embedded Controller with R/W abilities
> + *
> + * Copyright 2018 Google LLC
> + *
> + * The corresponding platform device is typically registered in
> + * drivers/platform/chrome/wilco_ec/core.c
> + */
> +
> +#include <linux/bcd.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/wilco-ec.h>
> +#include <linux/rtc.h>
> +#include <linux/timekeeping.h>
> +
> +#define EC_COMMAND_CMOS			0x7c
> +#define EC_CMOS_TOD_WRITE		0x02
> +#define EC_CMOS_TOD_READ		0x08
> +
> +/**
> + * struct ec_rtc_read - Format of RTC returned by EC.
> + * @second: Second value (0..59)
> + * @minute: Minute value (0..59)
> + * @hour: Hour value (0..23)
> + * @day: Day value (1..31)
> + * @month: Month value (1..12)
> + * @year: Year value (full year % 100)
> + * @century: Century value (full year / 100)
> + *
> + * All values are presented in binary (not BCD).
> + */
> +struct ec_rtc_read {
> +	u8 second;
> +	u8 minute;
> +	u8 hour;
> +	u8 day;
> +	u8 month;
> +	u8 year;
> +	u8 century;
> +} __packed;
> +
> +/**
> + * struct ec_rtc_write - Format of RTC sent to the EC.
> + * @param: EC_CMOS_TOD_WRITE
> + * @century: Century value (full year / 100)
> + * @year: Year value (full year % 100)
> + * @month: Month value (1..12)
> + * @day: Day value (1..31)
> + * @hour: Hour value (0..23)
> + * @minute: Minute value (0..59)
> + * @second: Second value (0..59)
> + * @weekday: Day of the week (0=Saturday)
> + *
> + * All values are presented in BCD.
> + */
> +struct ec_rtc_write {
> +	u8 param;
> +	u8 century;
> +	u8 year;
> +	u8 month;
> +	u8 day;
> +	u8 hour;
> +	u8 minute;
> +	u8 second;
> +	u8 weekday;
> +} __packed;
> +
> +int wilco_ec_rtc_read(struct device *dev, struct rtc_time *tm)
> +{
> +	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> +	u8 param = EC_CMOS_TOD_READ;
> +	struct ec_rtc_read rtc;
> +	struct wilco_ec_message msg = {
> +		.type = WILCO_EC_MSG_LEGACY,
> +		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
> +		.command = EC_COMMAND_CMOS,
> +		.request_data = &param,
> +		.request_size = sizeof(param),
> +		.response_data = &rtc,
> +		.response_size = sizeof(rtc),
> +	};
> +	int ret;
> +
> +	ret = wilco_ec_mailbox(ec, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	tm->tm_sec	= rtc.second;
> +	tm->tm_min	= rtc.minute;
> +	tm->tm_hour	= rtc.hour;
> +	tm->tm_mday	= rtc.day;
> +	tm->tm_mon	= rtc.month - 1;
> +	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
> +	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> +
> +	/* Don't compute day of week, we don't need it. */
> +	tm->tm_wday = -1;
> +
> +	return 0;
> +}
> +
> +int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm)
> +{
> +	struct wilco_ec_device *ec = dev_get_drvdata(dev->parent);
> +	struct ec_rtc_write rtc;
> +	struct wilco_ec_message msg = {
> +		.type = WILCO_EC_MSG_LEGACY,
> +		.flags = WILCO_EC_FLAG_RAW_RESPONSE,
> +		.command = EC_COMMAND_CMOS,
> +		.request_data = &rtc,
> +		.request_size = sizeof(rtc),
> +	};
> +	int year = tm->tm_year + 1900;
> +	/*
> +	 * Convert from 0=Sunday to 0=Saturday for the EC
> +	 * We DO need to set weekday because the EC controls battery charging
> +	 * schedules that depend on the day of the week.
> +	 */
> +	int wday = tm->tm_wday == 6 ? 0 : tm->tm_wday + 1;
> +	int ret;
> +
> +	rtc.param	= EC_CMOS_TOD_WRITE;
> +	rtc.century	= bin2bcd(year / 100);
> +	rtc.year	= bin2bcd(year % 100);
> +	rtc.month	= bin2bcd(tm->tm_mon + 1);
> +	rtc.day		= bin2bcd(tm->tm_mday);
> +	rtc.hour	= bin2bcd(tm->tm_hour);
> +	rtc.minute	= bin2bcd(tm->tm_min);
> +	rtc.second	= bin2bcd(tm->tm_sec);
> +	rtc.weekday	= bin2bcd(wday);
> +
> +	ret = wilco_ec_mailbox(ec, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops wilco_ec_rtc_ops = {
> +	.read_time = wilco_ec_rtc_read,
> +	.set_time = wilco_ec_rtc_write,
> +};
> +
> +static int wilco_ec_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtc;
> +
> +	rtc = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc))
> +		return PTR_ERR(rtc);
> +
> +	rtc->ops = &wilco_ec_rtc_ops;
> +	/* EC only supports this century */
> +	rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	rtc->range_max = RTC_TIMESTAMP_END_2099;
> +	rtc->owner = THIS_MODULE;
> +
> +	return rtc_register_device(rtc);
> +}
> +
> +static struct platform_driver wilco_ec_rtc_driver = {
> +	.driver = {
> +		.name = "rtc-wilco-ec",
> +	},
> +	.probe = wilco_ec_rtc_probe,
> +};
> +
> +module_platform_driver(wilco_ec_rtc_driver);
> +
> +MODULE_ALIAS("platform:rtc-wilco-ec");
> +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Wilco EC RTC driver");
> -- 
> 2.20.1.321.g9e740568ce-goog
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
