Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BD7218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGKRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:17:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45643 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:17:08 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grgjq-0005ge-1p; Thu, 07 Feb 2019 11:16:58 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grgjp-0003KZ-7R; Thu, 07 Feb 2019 11:16:57 +0100
Date:   Thu, 7 Feb 2019 11:16:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com
Subject: Re: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190207101657.rfzcq6xdv6ocvubg@pengutronix.de>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
 <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 29, 2019 at 05:13:19PM +0530, Yash Shah wrote:
> Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Various fixes and code cleanup]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sifive.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sifive.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index a8f47df..4a61d1a 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -380,6 +380,17 @@ config PWM_SAMSUNG
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-samsung.
>  
> +config PWM_SIFIVE
> +	tristate "SiFive PWM support"
> +	depends on OF
> +	depends on COMMON_CLK
> +	depends on RISCV || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for SiFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sifive.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0..30089ca 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
> +obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> new file mode 100644
> index 0000000..2b516f7
> --- /dev/null
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017-2018 SiFive
> + * For SiFive's PWM IP block documentation please refer Chapter 14 of
> + * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> + */
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +
> +/* Register offsets */
> +#define PWM_SIFIVE_PWMCFG		0x0
> +#define PWM_SIFIVE_PWMCOUNT		0x8
> +#define PWM_SIFIVE_PWMS			0x10
> +#define PWM_SIFIVE_PWMCMP0		0x20
> +
> +/* PWMCFG fields */
> +#define PWM_SIFIVE_PWMCFG_SCALE		0
> +#define PWM_SIFIVE_PWMCFG_STICKY	8
> +#define PWM_SIFIVE_PWMCFG_ZERO_CMP	9
> +#define PWM_SIFIVE_PWMCFG_DEGLITCH	10
> +#define PWM_SIFIVE_PWMCFG_EN_ALWAYS	12
> +#define PWM_SIFIVE_PWMCFG_EN_ONCE	13
> +#define PWM_SIFIVE_PWMCFG_CENTER	16
> +#define PWM_SIFIVE_PWMCFG_GANG		24
> +#define PWM_SIFIVE_PWMCFG_IP		28
> +
> +/* SIZE_PWMCMP is used to calculate the offset for pwmcmpX registers */
> +#define SIZE_PWMCMP		4
> +#define CMPWIDTH		16

Please add a PWM_SIFIVE_ prefix to these two.

> +struct pwm_sifive_ddata {
> +	struct pwm_chip	chip;
> +	struct notifier_block notifier;
> +	struct clk *clk;
> +	void __iomem *regs;
> +	unsigned int approx_period;
> +	unsigned int real_period;
> +};
> +
> +static inline struct pwm_sifive_ddata *to_pwm_sifive_chip(struct pwm_chip *c)

even though this is inlined I would like this to have use the
pwm_sifive_ prefix, too.

> +{
> +	return container_of(c, struct pwm_sifive_ddata, chip);
> +}
> +
> +static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *dev,
> +				 struct pwm_state *state)
> +{
> +	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
> +	u32 duty;
> +
> +	duty = readl(pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
> +
> +	state->period = pwm->real_period;
> +	state->duty_cycle = ((u64)duty * pwm->real_period) >> CMPWIDTH;
> +	state->polarity = PWM_POLARITY_INVERSED;
> +	state->enabled = duty > 0;
> +}
> +
> +static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
> +			    struct pwm_state *state)
> +{
> +	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
> +	unsigned int duty_cycle;
> +	u32 frac, val;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (state->period != pwm->real_period)
> +		return -EINVAL;
> +
> +	duty_cycle = state->duty_cycle;
> +	if (!state->enabled)
> +		duty_cycle = 0;
> +
> +	frac = div_u64((u64)duty_cycle * 0xFFFF, state->period);
> +	frac = min(frac, 0xFFFFU);

If CMPWIDTH was only 8, we'd need 0xff here instead of 0xffff, right? So
better use

	(1 << PWM_SIFIVE_CMPWIDTH) - 1

here, maybe "hidden" behind a cpp define.

In a previous review round I had doubts about the calculation of frac
and I think they were addressed wrongly.
Looking at the figure at the start of chapter 14.9 in the reference
manual: They use (different than the driver here) pwmcmp0=6 and
pwmzerocmp=1. Then a period is 7 clock cycles long and pwmcmpX must be 7
(for X > 0) to yield a 100% signal. So pwmcmpX must be greater than or
equal to the period (in clock cycles).

Here we're using pwmzerocmp=0, still the constraint

	pwmcmpX >= period

must be true for a 100% cycle. (Right?) With pwmzerocmp=0 the period is
0x10000 clock cycles, so pwmcmpX must be >= 0x10000 to yield a 100%
signal. As this is not possible (pwmcmpX is a 16 bit value that can only
hold up to 0xffff) the output cannot yield 100%.

So I think the most correct implementation here is:

	frac = (duty_cycle * (1 << PWM_SIFIVE_CMPWIDTH) + (1 << PWM_SIFIVE_CMPWIDTH) / 2) / period;
	/* Sorry, we cannot do 100% :-( */
	frac = min(frac, (1 << PWM_SIFIVE_CMPWIDTH) - 1);

Thierry: What is the correct rounding strategy? I assumed "round to
nearest" (with round half up). If we want something like clk_round_rate
for PWMs in the future rounding down might be easier to handle.

Note that pwm_sifive_get_state is already (well, or still) using this as
it has:

	state->duty_cycle = ((u64)duty * pwm->real_period) >> CMPWIDTH;

which always yields something smaller than read_period as duty is
smaller than 1 << PWM_SIFIVE_CMPWIDTH.

I tried to understand the IP source at
https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/pwm/PWM.scala
to confirm (or disprove) this theory, but I failed.

Assuming my analysis is true, I'd like to have it documented
prominently in the driver that the hardware cannot generate a 100% duty
cycle.

> +	val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
> +	val |= (1 << PWM_SIFIVE_PWMCFG_DEGLITCH);

No parenthesis necessary. You might want to consider using the BIT macro
here, maybe already in the definition of PWM_SIFIVE_PWMCFG_DEGLITCH.

> +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> +
> +	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
> +
> +	val &= ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
> +	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> +
> +	pwm_sifive_get_state(chip, dev, state);

Thierry: This changes the pwm_state. Is this how this should be done?

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_sifive_ops = {
> +	.get_state = pwm_sifive_get_state,
> +	.apply = pwm_sifive_apply,
> +	.owner = THIS_MODULE,
> +};
> +
> +static struct pwm_device *pwm_sifive_xlate(struct pwm_chip *chip,
> +					   const struct of_phandle_args *args)
> +{
> +	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
> +	struct pwm_device *dev;
> +
> +	if (args->args[0] >= chip->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	dev = pwm_request_from_chip(chip, args->args[0], NULL);
> +	if (IS_ERR(dev))
> +		return dev;
> +
> +	/* The period cannot be changed on a per-PWM basis */
> +	dev->args.period = pwm->real_period;
> +	dev->args.polarity = PWM_POLARITY_NORMAL;
> +	if (args->args[1] & PWM_POLARITY_INVERSED)
> +		dev->args.polarity = PWM_POLARITY_INVERSED;

The driver does only support PWM_POLARITY_INVERSED. So I guess this
should be:

	dev->args.polarity = PWM_POLARITY_INVERSED;
	if (!(args->args[1] & PWM_POLARITY_INVERSED))
		dev_warn(dev, "...");

> +
> +	return dev;
> +}
> +
> +static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
> +				    unsigned long rate)
> +{
> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
> +	unsigned long scale_pow =
> +			(pwm->approx_period * (u64)rate) / NSEC_PER_SEC;
> +	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);

is this 16 in reality PWM_SIFIVE_CMPWIDTH?

> +	writel((1 << PWM_SIFIVE_PWMCFG_EN_ALWAYS) | (scale <<
> +	       PWM_SIFIVE_PWMCFG_SCALE), pwm->regs + PWM_SIFIVE_PWMCFG);
> +
> +	/* As scale <= 15 the shift operation cannot overflow. */
> +	pwm->real_period = div64_ul(1000000000ULL << (16 + scale), rate);
> +	dev_dbg(pwm->chip.dev, "New real_period = %u ns\n", pwm->real_period);
> +}
> +
> +static int pwm_sifive_clock_notifier(struct notifier_block *nb,
> +				     unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct pwm_sifive_ddata *pwm =
> +		container_of(nb, struct pwm_sifive_ddata, notifier);
> +
> +	if (event == POST_RATE_CHANGE)
> +		pwm_sifive_update_clock(pwm, ndata->new_rate);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int pwm_sifive_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct pwm_sifive_ddata *pwm;
> +	struct pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip = &pwm->chip;
> +	chip->dev = dev;
> +	chip->ops = &pwm_sifive_ops;
> +	chip->of_xlate = pwm_sifive_xlate;
> +	chip->of_pwm_n_cells = 2;
> +	chip->base = -1;
> +	chip->npwm = 4;
> +
> +	ret = of_property_read_u32(node, "sifive,period-ns",
> +				   &pwm->approx_period);
> +
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to read sifive,period-ns from DTS\n");
> +		return ret;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pwm->regs)) {
> +		dev_err(dev, "Unable to map IO resources\n");
> +		return PTR_ERR(pwm->regs);
> +	}
> +
> +	pwm->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk)) {
> +		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Unable to find controller clock\n");
> +		return PTR_ERR(pwm->clk);
> +	}
> +
> +	ret = clk_prepare_enable(pwm->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Watch for changes to underlying clock frequency */
> +	pwm->notifier.notifier_call = pwm_sifive_clock_notifier;
> +	ret = clk_notifier_register(pwm->clk, &pwm->notifier);
> +	if (ret) {
> +		dev_err(dev, "failed to register clock notifier: %d\n", ret);
> +		goto disable_clk;
> +	}

Would it make sense to only enable the clock when the pwm is enabled?
(If yes, how does the output behave if the clock is disabled while the
hardware is enabled? I assume the output just freezes at the state where
it happens to be?)

> +	/* Initialize PWM config */
> +	pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
> +
> +	ret = pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot register PWM: %d\n", ret);
> +		goto unregister_clk;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
> +
> +	return 0;
> +
> +unregister_clk:
> +	clk_notifier_unregister(pwm->clk, &pwm->notifier);
> +disable_clk:
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return ret;
> +}
> +
> +static int pwm_sifive_remove(struct platform_device *dev)
> +{
> +	struct pwm_sifive_ddata *pwm = platform_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pwmchip_remove(&pwm->chip);
> +	clk_notifier_unregister(pwm->clk, &pwm->notifier);
> +	clk_disable_unprepare(pwm->clk);
> +	return ret;
> +}
> +
> +static const struct of_device_id pwm_sifive_of_match[] = {
> +	{ .compatible = "sifive,pwm0" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
> +
> +static struct platform_driver pwm_sifive_driver = {
> +	.probe = pwm_sifive_probe,
> +	.remove = pwm_sifive_remove,
> +	.driver = {
> +		.name = "pwm-sifive",
> +		.of_match_table = pwm_sifive_of_match,
> +	},
> +};
> +module_platform_driver(pwm_sifive_driver);
> +
> +MODULE_DESCRIPTION("SiFive PWM driver");
> +MODULE_LICENSE("GPL v2");

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
