Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C2D20836
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C2D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeH3UoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:44:00 -0400
Received: from muru.com ([72.249.23.125]:55070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeH3UoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:44:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2B73280BD;
        Thu, 30 Aug 2018 16:44:55 +0000 (UTC)
Date:   Thu, 30 Aug 2018 09:40:57 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: [PATCH] leds: add TI LMU backlight driver
Message-ID: <20180830164057.GV7523@atomide.com>
References: <20180829212032.GB15786@amd>
 <20180830082219.GA10133@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830082219.GA10133@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180830 08:26]:
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
...
> +struct ti_lmu_bank {
> +	struct device *dev;
> +	int bank_id;
> +	const struct ti_lmu_bl_cfg *cfg;
> +	struct ti_lmu *lmu;
> +	const char *label;
> +	int leds;
> +	int current_brightness;
> +	u32 default_brightness;
> +	u32 ramp_up_msec;
> +	u32 ramp_down_msec;
> +
> +	struct notifier_block nb;
> +
> +	struct led_classdev *led;
> +};
> +
> +static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	unsigned long enable_time = lmu_bank->cfg->reginfo->enable_usec;
> +	u8 *reg = lmu_bank->cfg->reginfo->enable;
> +	u8 mask = BIT(lmu_bank->bank_id);
> +	u8 val = (enable == true) ? mask : 0;
> +	int ret;
> +
> +	if (!reg)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(regmap, *reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	if (enable_time > 0)
> +		usleep_range(enable_time, enable_time + 100);
> +
> +	return 0;
> +}

If it's a led driver, should you just s/ti_lmu_bl/ti_lmu_led/g?

Regards,

Tony
