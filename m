Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB00C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE52F223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE52F223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeKMBkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:40:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51324 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbeKMBkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:40:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 01489208BE; Mon, 12 Nov 2018 16:46:32 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id C49B9207B0;
        Mon, 12 Nov 2018 16:46:31 +0100 (CET)
Date:   Mon, 12 Nov 2018 16:46:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     zoro <long17.cool@163.com>
Cc:     a.zummo@towertech.it, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rtc: sd3078: new driver.
Message-ID: <20181112154632.GA26341@piout.net>
References: <1542001514-8167-1-git-send-email-long17.cool@163.com>
 <1542001514-8167-2-git-send-email-long17.cool@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542001514-8167-2-git-send-email-long17.cool@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A few things I missed in the previous review but this look mostly good.

On 12/11/2018 13:45:13+0800, zoro wrote:
> diff --git a/drivers/rtc/rtc-sd3078.c b/drivers/rtc/rtc-sd3078.c
> new file mode 100644
> index 0000000..97e8f4b
> --- /dev/null
> +++ b/drivers/rtc/rtc-sd3078.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Real Time Clock (RTC) Driver for sd3078
> + * Copyright (C) 2018 Zoro Li
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/bcd.h>
> +#include <linux/rtc.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>

The includes have to be sorted alphabetically.

> +
> +#define SD3078_REG_SC			0x00
> +#define SD3078_REG_MN			0x01
> +#define SD3078_REG_HR			0x02
> +#define SD3078_REG_DW			0x03
> +#define SD3078_REG_DM			0x04
> +#define SD3078_REG_MO			0x05
> +#define SD3078_REG_YR			0x06
> +
> +#define SD3078_REG_CTRL1		0x0f
> +#define SD3078_REG_CTRL2		0x10
> +#define SD3078_REG_CTRL3		0x11
> +
> +#define KEY_WRITE1		0x80
> +#define KEY_WRITE2		0x04
> +#define KEY_WRITE3		0x80
> +
> +#define NUM_TIME_REGS   (SD3078_REG_YR - SD3078_REG_SC + 1)
> +
> +/*
> + * The sd3078 has write protection
> + * and we can choose whether or not to use it.
> + * Write protection is turned off by default.
> + */
> +#define WRITE_PROTECT_EN	0
> +
> +struct sd3078 {
> +	struct rtc_device	*rtc;
> +	struct regmap		*regmap;
> +};
> +
> +/*
> + * In order to prevent arbitrary modification of the time register,
> + * when modification of the register,
> + * the "write" bit needs to be written in a certain order.
> + * 1. set WRITE1 bit
> + * 2. set WRITE2 bit
> + * 3. set WRITE3 bit
> + */
> +static void sd3078_enable_reg_write(struct sd3078 *sd3078)
> +{
> +	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL2,
> +		KEY_WRITE1, KEY_WRITE1);

This is not properly aligned. Please run checkpatch.pl --strict, you
have a bunch of lines that are not correctly aligned and a few
whitespace issues.

> +	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
> +		KEY_WRITE2, KEY_WRITE2);
> +	regmap_update_bits(sd3078->regmap, SD3078_REG_CTRL1,
> +		KEY_WRITE3, KEY_WRITE3);
> +}

[..]

> +static int sd3078_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct sd3078 *sd3078;
> +
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +	sd3078 = devm_kzalloc(&client->dev, sizeof(*sd3078), GFP_KERNEL);
> +	if (!sd3078)
> +		return -ENOMEM;
> +
> +	sd3078->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +	if (IS_ERR(sd3078->regmap)) {
> +		dev_err(&client->dev, "regmap allocation failed\n");
> +		return PTR_ERR(sd3078->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, sd3078);
> +
> +	sd3078->rtc = devm_rtc_allocate_device(&client->dev);
> +	if (IS_ERR(sd3078->rtc))
> +		return PTR_ERR(sd3078->rtc);
> +
> +	sd3078->rtc->ops = &sd3078_rtc_ops;
> +	sd3078->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
> +	sd3078->rtc->range_max = RTC_TIMESTAMP_END_2099;
> +	sd3078->rtc->start_secs = RTC_TIMESTAMP_BEGIN_2000;
> +	sd3078->rtc->set_start_time = true;
> +

You mustn't set start_secs and set_start_time here as this match what
your hardware is doing. setting it from the driver is reserved for
legacy drivers.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
