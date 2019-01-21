Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A2D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfAUNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:24:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33739 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbfAUNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:24:04 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glZYS-0005VZ-Lx; Mon, 21 Jan 2019 14:23:56 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glZYR-0002gt-ER; Mon, 21 Jan 2019 14:23:55 +0100
Date:   Mon, 21 Jan 2019 14:23:55 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yash Shah <yash.shah@sifive.com>, palmer@sifive.com,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190121132355.vqwmwzzcwrqgcxrm@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <20190121113039.GI16756@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121113039.GI16756@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:30:39PM +0100, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:00:46PM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Fri, Jan 11, 2019 at 01:52:44PM +0530, Yash Shah wrote:
> > > Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> > > 
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > [Atish: Various fixes and code cleanup]
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  drivers/pwm/Kconfig      |  10 ++
> > >  drivers/pwm/Makefile     |   1 +
> > >  drivers/pwm/pwm-sifive.c | 246 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 257 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sifive.c
> > > 
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index a8f47df..3bcaf6a 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -380,6 +380,16 @@ config PWM_SAMSUNG
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-samsung.
> > >  
> > > +config PWM_SIFIVE
> > > +	tristate "SiFive PWM support"
> > > +	depends on OF
> > > +	depends on COMMON_CLK
> > 
> > I'd say add:
> > 
> > 	depends on MACH_SIFIVE || COMPILE_TEST
> > 
> > (I guess "MACH_SIFIVE" is wrong, but I assume you get what I mean.)
> > 
> > > +	help
> > > +	  Generic PWM framework driver for SiFive SoCs.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-sifive.
> > > +
> > >  config PWM_SPEAR
> > >  	tristate "STMicroelectronics SPEAr PWM support"
> > >  	depends on PLAT_SPEAR
> > > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index 9c676a0..30089ca 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
> > > +obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
> > >  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> > >  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
> > > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > > new file mode 100644
> > > index 0000000..7fee809
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sifive.c
> > > @@ -0,0 +1,246 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2017-2018 SiFive
> > > + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> > > + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> > 
> > I wonder if such an instance should be only a single PWM instead of
> > four. Then you were more flexible with the period lengths (using
> > pwmcfg.pwmzerocmp) and could do stuff like inverted and uninverted mode.
> 
> I thought this IP only allowed a single period for all PWM channels in
> the IP. If so, splitting this into four different devices is going to
> complicate things because you'd have to coordinate between all four as
> to which period is currently set.

Take a look at the above link, figure 6 is depicting how this IP works
(page 92 of the pdf). If you have pwmzerocmp=0 (and pwmcmpXgang=0) the
four outputs (pwmcmpXgpio) are independant and the counter only resets
on overflow of pwms. Then you have 4 outputs that can have their
duty_cycle (but not period) set individually. So period is restricted to
a count of clk cycles that is a power of two.

With pwmzerocmp=1, pwmcmp0 resets the counter with the following
effects:

 - pwmcmp0gpio is always 0 (bad?)
 - more finegrained control over the period length as the restriction to
   powers of two is gone (good)

The other three output can then either be used as 3 PWM outputs with the
more flexible (but identical) period or only pwmcmp1gpio is used as a
single output (my favourite) and with pwmcmp2, pwmcmp3 and pwmcmp2gang=1
the output pwmcmp2gpio can be used as a secondary output to implement
stuff that was called "complementary mode" or "Push-pull mode" by
Claudiu Beznea.

> > > +struct sifive_pwm_device {
> > > +	struct pwm_chip	chip;
> > > +	struct notifier_block notifier;
> > > +	struct clk *clk;
> > > +	void __iomem *regs;
> > > +	unsigned int approx_period;
> > > +	unsigned int real_period;
> > > +};
> > 
> > I'd call this pwm_sifive_ddata. The prefix because the driver is called
> > pwm-sifive and ddata because this is driver data and not a device.
> 
> I don't think there's a need to have an extra suffix. Just call this
> sifive_pwm or pwm_sifive. There's no ambiguity in that name and it's
> short and crisp.

fine for me if "_device" goes away.

> > > +	if (state->enabled)
> > > +		sifive_pwm_get_state(chip, dev, state);
> > 
> > @Thierry: Should we bless this correction of state?
> 
> I'm not sure I understand why this correction is necessary. Is it okay
> to request a state to be applied and when we're not able to set that
> state we just set anything as close as possible? Sounds a bit risky to
> me. What if somebody wants to use this in a case where precision
> matters?

There is always rounding involved. Where should we draw a line then?
Consider a parent clk running at 1000000001 Hz. Can you provide a duty
cycle of 1 ps? Of if the clk runs at 500000000 Hz, I can implement even
periods, but not the uneven. Should the driver fail if an uneven period
is requested? What should a user do if setting

	.duty_cycle = 55, .period = 100,

fails? Assume the pwm can set only even duty_cycles? Or maybe duty_cycle
and period must be dividable by 3? Or maybe only periods that are a
power of two are possible? To get both, an API that can actually be
worked with and that provides precision, the driver needs to be allowed
to round (preferably in some defined way that is used for all devices)
and we need a function to determine the result without actually
configuring. That's how it works in the clk_* universe. There is
clk_round_rate and clk_set_rate and the explicit condition that

	clk_set_rate(clk, somerate)

has the same effect as

	clk_set_rate(clk, clk_round_rate(clk, somerate))

and after one of them we have

	clk_get_rate(clk) = clk_round_rate(clk, somerate))

> Now, if you're saying that there can't be such cases and we should
> support this, then why restrict the state correction to when the PWM is
> enabled? What's wrong with correcting it in either case?

Either the correction should be done always or never.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
