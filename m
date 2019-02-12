Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE7DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCE720811
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfBLO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:28:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfBLO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:28:55 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtZ3K-0000mM-Rr; Tue, 12 Feb 2019 15:28:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gtZ3K-00037h-5g; Tue, 12 Feb 2019 15:28:50 +0100
Date:   Tue, 12 Feb 2019 15:28:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Message-ID: <20190212142850.iwgi4n6v6oep4oin@pengutronix.de>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
 <20190212094927.5900-2-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212094927.5900-2-m.othacehe@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:49:27AM +0100, Mathieu Othacehe wrote:
> Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
> platforms. They require a special quirk: pwm has to be enabled again
> to force duty_cycle refresh.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
> index 27c107e78d59..bf33aa24433c 100644
> --- a/drivers/pwm/pwm-hibvt.c
> +++ b/drivers/pwm/pwm-hibvt.c
> @@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
>  	struct clk *clk;
>  	void __iomem *base;
>  	struct reset_control *rstc;
> +	bool quirk_force_enable;
>  };
>  
>  struct hibvt_pwm_soc {
> @@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
>  };
>  
>  static const struct hibvt_pwm_soc pwm_soc[2] = {
> +	{ .num_pwms = 2 },
>  	{ .num_pwms = 4 },
>  	{ .num_pwms = 8 },

The members of this struct are used as of-data (in struct
of_device_id::data below). When looking at the usage:

	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[1] },
	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[2] },
	{ .compatible = "hisilicon,hi3559v100-shub-pwm", .data = &pwm_soc[2] },
	{ .compatible = "hisilicon,hi3559v100-pwm", .data = &pwm_soc[0] },

this isn't exactly easy to understand. I would prefer to do it as
follows:

	static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
		.num_pwms = 2,
	};
	...

	static const struct of_device_id hibvt_pwm_of_match[] = {
		{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &hi3516cv300_soc_info },
		...
	};

Then you could also add a member to hibvt_pwm_soc to signal if that
force_enable quirk is necessary and would not need to use
of_device_is_compatible() to determine this. The result is that you have
a description of all relevant differences in a single place.

@Thierry: Also this is yet another driver instance where a num-pwms
property would simplify the driver because up to before this patch this
was the only difference between the different variants.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
