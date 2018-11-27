Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BF0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CFC20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CFC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbeK0Vbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:31:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41997 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeK0Vbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:31:32 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gRagn-0008Kv-D5; Tue, 27 Nov 2018 11:33:57 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gRagk-00070b-W1; Tue, 27 Nov 2018 11:33:54 +0100
Date:   Tue, 27 Nov 2018 11:33:54 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Message-ID: <20181127103354.mdisx2qy42faep3s@pengutronix.de>
References: <20181125162319.GA5422@arx-s1>
 <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126213158.q5m5bbwnmewud2gb@pengutronix.de>
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

On Mon, Nov 26, 2018 at 10:31:58PM +0100, Uwe Kleine-König wrote:
> On Mon, Nov 26, 2018 at 12:23:19AM +0800, Hao Zhang wrote:
> > The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
> > each PWM pair built-in 1 clock module, 2 timer logic module and 1
> > programmable dead-time generator, it also support waveform capture.
> > It has 2 clock sources OSC24M and APB1, it is different with the
> > sun4i-pwm driver, Therefore add a new driver for it.
> > 
> > Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> > ---
> >  drivers/pwm/Kconfig     |  12 +-
> >  drivers/pwm/Makefile    |   1 +
> >  drivers/pwm/pwm-sun8i.c | 418 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 430 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pwm/pwm-sun8i.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 504d252..6105ac8 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -426,7 +426,7 @@ config PWM_STMPE
> >  	  expanders.
> >  
> >  config PWM_SUN4I
> > -	tristate "Allwinner PWM support"
> > +	tristate "Allwinner SUN4I PWM support"
> >  	depends on ARCH_SUNXI || COMPILE_TEST
> >  	depends on HAS_IOMEM && COMMON_CLK
> >  	help
> > @@ -435,6 +435,16 @@ config PWM_SUN4I
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-sun4i.
> >  
> > +config PWM_SUN8I
> > +	tristate "Allwinner SUN8I (R40/V40/T3) PWM support"
> > +	depends on ARCH_SUNXI || COMPILE_TEST
> > +	depends on HAS_IOMEM && COMMON_CLK
> > +	help
> > +	  Generic PWM framework driver for Allwinner R40/V40/T3 SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-sun8i.
> > +
> >  config PWM_TEGRA
> >  	tristate "NVIDIA Tegra PWM support"
> >  	depends on ARCH_TEGRA
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 9c676a0..32c8d2d 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
> >  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> >  obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
> >  obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
> > +obj-$(CONFIG_PWM_SUN8I)		+= pwm-sun8i.o
> >  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> > diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> > new file mode 100644
> > index 0000000..d8597e4
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-sun8i.c
> > @@ -0,0 +1,418 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>

Given that the documentation is publically available, I suggest to add a
link to it in a comment here.
(http://linux-sunxi.org/File:Allwinner_R40_User_Manual_V1.0.pdf)

> > +	/* calculate and set prescaler, div table, PWM entire cycle */
> > +	clk_div = val;
> > +	while (clk_div > 65535) {
> > +		prescaler++;
> > +		clk_div = val;
> > +		do_div(clk_div, 1U << div_id);
> > +		do_div(clk_div, prescaler + 1);
> > +
> > +		if (prescaler == 255) {
> > +			prescaler = 0;
> > +			div_id++;
> > +			if (div_id == 9) {
> > +				dev_err(sun8i_pwm->chip.dev,
> > +					"unsupport period value\n");
> > +				return -EINVAL;
> > +			}
> > +		}
> > +	}
> 
> Noting the underlying formula for the calculation and the bitwidth for
> the related register fields above would be good.
> 
> > +
> > +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> > +			    PWM_ENTIRE_CYCLE, clk_div << 16);
> > +	sun8i_pwm_set_value(sun8i_pwm, PWM_CTR_REG(ch),
> > +			    PWM_PRESCAL_K, prescaler << 0);
> > +	sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> > +			    CLK_DIV_M, div_id << 0);
> > +
> > +	/* set duty cycle */
> > +	val = state->period;
> > +	do_div(val, clk_div);
> > +	clk_div = state->duty_cycle;
> > +	do_div(clk_div, val);
> > +	if (clk_div > 65535)
> > +		clk_div = 65535;
> > +
> > +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> > +			    PWM_ACT_CYCLE, clk_div << 0);
> 
> Why "<< 0"?
> 
> > +	return 0;
> > +}
> > +
> > +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			   struct pwm_state *state)
> > +{
> > +	int ret;
> > +	struct sun8i_pwm_chip *sun8i_pwm = to_sun8i_pwm_chip(chip);
> > +	struct pwm_state cstate;
> > +
> > +	pwm_get_state(pwm, &cstate);
> > +	if (!cstate.enabled) {
> > +		ret = clk_prepare_enable(sun8i_pwm->clk);
> > +		if (ret) {
> > +			dev_err(chip->dev, "Failed to enable PWM clock\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if ((cstate.period != state->period) ||
> > +	    (cstate.duty_cycle != state->duty_cycle)) {
> > +		ret = sun8i_pwm_config(sun8i_pwm, pwm->hwpwm, state);
> > +		if (ret) {
> > +			dev_err(chip->dev, "Failed to config PWM\n");
> > +			return ret;
> > +		}
> > +	}
> 
> sun8i_pwm_config writes the registers that are relevant for period and
> duty_cycle. When do these values take effect? If it's already here,
> switching the polarity below might introduce a glitch.

I think this is the case after taking a look into the reference manual.

There are two 16 bit fields in the PWM_PERIOD_REG. One specifies the
number of clock ticks defining the period ("PWM_ENTIRE_CYCLE") and the
other the duty cycle ("PWM_ACT_CYCLE").

So if you go from duty_cycle=5 + period=10 + POLARITY_NORMAL to
duty_cycle=3 + period=10 + POLARITY_INVERTED this might generate:

 ____      __           ______
/    \____/  \_________/      \__/
^         ^         ^         ^

Also there is a PWM_PERIOD_RDY bit field that probably has to be
consulted before writing to the PWM_PERIOD_REG register.

It's not entirely clear to me if the PWM_ACT_STA bit that is used for
inversion is shadowed until the next period, too. That's what I assumed
above. If it's not the wave might look as follows:

 ____      __  _____    ______
/    \____/  \/     \__/      \__/
^         ^   *     ^         ^

Where * marks the point where the inversion starts to take effect.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
