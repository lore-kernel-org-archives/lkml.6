Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41053C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C141222FB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfAETmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:42:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35595 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfAETmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:42:42 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gfrq1-0006Qh-61; Sat, 05 Jan 2019 20:42:29 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gfrpy-0002yV-7L; Sat, 05 Jan 2019 20:42:26 +0100
Date:   Sat, 5 Jan 2019 20:42:26 +0100
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
Subject: Re: [PATCH v9 12/27] pwm: jz4740: Use regmap from TCU driver
Message-ID: <20190105194226.pe4huzynz4civ3lm@pengutronix.de>
References: <20181227181319.31095-1-paul@crapouillou.net>
 <20181227181319.31095-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181227181319.31095-13-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 07:13:04PM +0100, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.

Does it change behaviour? If so, how?

> @@ -113,26 +117,37 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	jz4740_pwm_disable(chip, pwm);
>  
> -	jz4740_timer_set_count(pwm->hwpwm, 0);
> -	jz4740_timer_set_duty(pwm->hwpwm, duty);
> -	jz4740_timer_set_period(pwm->hwpwm, period);
> +	/* Set abrupt shutdown */
> +	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
> +			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);

I think I already pointed that out before: abrupt mode is wrong. If
.apply is called with a new set of parameters the currently running
period with the old values is expected to complete before the new values
take effect.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
