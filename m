Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D1DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFCC2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFCC2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeLMJbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:31:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57627 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:31:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXNKV-00073L-4E; Thu, 13 Dec 2018 10:30:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gXNKT-0006Vw-9B; Thu, 13 Dec 2018 10:30:49 +0100
Date:   Thu, 13 Dec 2018 10:30:49 +0100
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
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH v8 11/26] pwm: jz4740: Use regmap and clocks from TCU
 driver
Message-ID: <20181213093049.rxdvf6tip7iqdj3c@pengutronix.de>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212220922.18759-12-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 12, 2018 at 11:09:06PM +0100, Paul Cercueil wrote:
> [...]
>  static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
> +	struct jz4740_pwm_chip *jz = to_jz4740(chip);
>  
> -	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
> -	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
> -	jz4740_timer_enable(pwm->hwpwm);
> +	/* Enable PWM output */
> +	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
> +				TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);

Usually follow-up lines are indented to the matching parenthesis.

> [...]
>  static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			     int duty_ns, int period_ns)
>  {
>  	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> +	struct clk *clk = jz4740->clks[pwm->hwpwm];
> +	unsigned long rate, new_rate, period, duty;
>  	unsigned long long tmp;
> -	unsigned long period, duty;
> -	unsigned int prescaler = 0;
> -	uint16_t ctrl;
> +	unsigned int tcsr;
>  	bool is_enabled;
>  
> -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
> -	do_div(tmp, 1000000000);
> -	period = tmp;
> +	rate = clk_get_rate(clk);
> +
> +	for (;;) {
> +		tmp = (unsigned long long) rate * period_ns;
> +		do_div(tmp, 1000000000);
>  
> -	while (period > 0xffff && prescaler < 6) {
> -		period >>= 2;
> -		++prescaler;
> +		if (tmp <= 0xffff)
> +			break;
> +
> +		new_rate = clk_round_rate(clk, rate / 2);
> +
> +		if (new_rate < rate)
> +			rate = new_rate;
> +		else
> +			return -EINVAL;
>  	}
>  
> -	if (prescaler == 6)
> -		return -EINVAL;
> +	clk_set_rate(clk, rate);

Maybe this could better live in a separate patch. If you split still
further to have the conversion to regmap in a single patch, then the
conversion to the clk_* functions and then improve the algorithm for the
clk settings each of the patches is easier to review than this one patch
that does all three things at once.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
