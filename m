Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A27C43444
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CFD21915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfAET5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:57:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfAET5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:57:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gfs4V-0007aT-7h; Sat, 05 Jan 2019 20:57:27 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gfs4T-0003Kv-SL; Sat, 05 Jan 2019 20:57:25 +0100
Date:   Sat, 5 Jan 2019 20:57:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v9 14/27] pwm: jz4740: Improve algorithm of clock
 calculation
Message-ID: <20190105195725.cuxfge6zkpbt3cyk@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-15-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181227181319.31095-15-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 07:13:06PM +0100, Paul Cercueil wrote:
> The previous algorithm hardcoded details about how the TCU clocks work.
> The new algorithm will use clk_round_rate to find the perfect clock rate
> for the PWM channel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v9: New patch
> 
>  drivers/pwm/pwm-jz4740.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index c6136bd4434b..dd80a2cf6528 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -110,23 +110,27 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
>  	struct clk *clk = jz4740->clks[pwm->hwpwm],
>  		   *parent_clk = clk_get_parent(clk);
> -	unsigned long rate, period, duty;
> +	unsigned long rate, new_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned int prescaler = 0;
>  
>  	rate = clk_get_rate(parent_clk);
> -	tmp = (unsigned long long)rate * state->period;
> -	do_div(tmp, 1000000000);
> -	period = tmp;
>  
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>= 2;
> -		rate >>= 2;
> -		++prescaler;
> +	for (;;) {
> +		tmp = (unsigned long long)rate * state->period;
> +		do_div(tmp, 1000000000);

NSEC_PER_SEC?

> +
> +		if (tmp <= 0xffff)
> +			break;
> +
> +		new_rate = clk_round_rate(clk, rate - 1);
> +
> +		if (new_rate < rate)
> +			rate = new_rate;
> +		else
> +			return -EINVAL;

You are assuming stuff here about the parent clk which isn't guaranteed
(AFAICT) by the clk framework: If you call clk_round_rate(clk, rate - 1)
this might well return rate even if the clock could run slower than
rate.

Wouldn't it make sense to start iterating with rate = 0xffff * 1e9 /
period? Otherwise you get bad configurations if rate is considerable
slower than necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
