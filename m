Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A339C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72416218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502467AbfBNP7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:59:11 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42669 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392172AbfBNP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:59:10 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guJPk-0005T9-Uj; Thu, 14 Feb 2019 16:59:04 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1guJPj-0004KM-Rg; Thu, 14 Feb 2019 16:59:04 +0100
Date:   Thu, 14 Feb 2019 16:59:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190214155903.7h3b7v3nbhj57uy2@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
 <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
 <20190213123703.GE647@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190213123703.GE647@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:37:03PM +0100, Thierry Reding wrote:
> On Thu, Feb 07, 2019 at 11:16:57AM +0100, Uwe Kleine-König wrote:
> > On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> [...]
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> [...]
> > > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
> > > +
> > > +	val &= ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
> > > +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> > > +
> > > +	pwm_sifive_get_state(chip, dev, state);
> > 
> > Thierry: This changes the pwm_state. Is this how this should be done?
> 
> Yes, I think that's fine. The PWM state should always reflect the
> current hardware state. If the configuration that we program does not
> reflect the state that was requested, that should be reflected in the
> PWM state.

I'm not sure you blessed what is really done here. If I do:

	state.duty_cycle = state.period;
	pwm_apply_state(pwm, &state);

the call in question doesn't only result in pwm->state.duty_cycle <
pwm->state.period, but it also corrects my local state variable (i.e. I
have state.duty_cycle < state.period afterwards).

Is this what you thought to be fine?

Also note that v6 dropped that call because of my doubts.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
