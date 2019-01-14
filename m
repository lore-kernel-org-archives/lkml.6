Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E90620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfANW0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:26:04 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfANW0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:26:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B08C82074F; Mon, 14 Jan 2019 23:26:01 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7DC85206A6;
        Mon, 14 Jan 2019 23:25:51 +0100 (CET)
Date:   Mon, 14 Jan 2019 23:25:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nick Crews <ncrews@google.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        sjg@chromium.org, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v2 5/9] platform/chrome: rtc: Add RTC driver for Wilco EC
Message-ID: <20190114222551.GC2589@piout.net>
References: <20190114220356.108916-1-ncrews@google.com>
 <20190114220356.108916-6-ncrews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114220356.108916-6-ncrews@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 14/01/2019 15:03:52-0700, Nick Crews wrote:
> diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
> new file mode 100644
> index 000000000000..d8ed791da82d
> --- /dev/null
> +++ b/drivers/rtc/rtc-wilco-ec.c
> @@ -0,0 +1,178 @@
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
> +#define DRV_NAME "rtc-wilco-ec"

Please get rid of that define.

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
> +	struct rtc_time calc_tm;
> +	unsigned long time;
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
> +	/*
> +	 * The RTC stores the month value as 1-12 but the kernel expects 0-11,
> +	 * so ensure invalid/zero month value from RTC is not converted to -1.

I'm pretty sure this is not necessary and will certainly make the core
think the date is valid when it has obviously been corrupted.

> +	 */
> +	tm->tm_mon	= rtc.month ? rtc.month - 1 : 0;
> +	tm->tm_year	= rtc.year + (rtc.century * 100) - 1900;
> +	tm->tm_yday	= rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_year);
> +
> +	/* Compute day of week */
> +	rtc_tm_to_time(tm, &time);
> +	rtc_time_to_tm(time, &calc_tm);
> +	tm->tm_wday = calc_tm.tm_wday;

Do you really need an accurate wday? There are no userspace applications
that I know of that care and converting back and forth is quite
expensive.

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
> +	/* Convert from 0=Sunday to 0=Saturday for the EC */
> +	int wday = tm->tm_wday == 6 ? 0 : tm->tm_wday + 1;

I'm not sure how useful it is to set an accurate wday when the RTC is
not able to give it back.

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
> +	struct rtc_device *rtc = devm_rtc_device_register(&pdev->dev,
> +							  DRV_NAME,
> +							  &wilco_ec_rtc_ops,
> +							  THIS_MODULE);

Please use devm_rtc_allocate_device() and set rtc->range_min and
rtc->range_max before registering with rtc_register_device().

> +	if (IS_ERR(rtc))
> +		return PTR_ERR(rtc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver wilco_ec_rtc_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = wilco_ec_rtc_probe,
> +};
> +
> +module_platform_driver(wilco_ec_rtc_driver);
> +
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_AUTHOR("Nick Crews <ncrews@google.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Wilco EC RTC driver");
> -- 
> 2.20.1.97.g81188d93c3-goog
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
