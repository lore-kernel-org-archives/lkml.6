Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeD3JjP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:39:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38819 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751709AbeD3JjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:39:12 -0400
X-Google-Smtp-Source: AB8JxZpjbXjHkKxFg5It0GGjFzYxRzv3zJEIqyZOPdvATpOt3biqwLsizQPTJSuHPchWOxqxLw80HA==
Date: Mon, 30 Apr 2018 11:39:08 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Wesley W. Terpstra" <wesley@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Wesley W . Terpstra" <wesley@terpstra.ca>
Subject: Re: [PATCH 3/3] pwm-sifive: add a driver for SiFive SoC PWM
Message-ID: <20180430093907.GA2476@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-4-git-send-email-wesley@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <1524869998-2805-4-git-send-email-wesley@sifive.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 03:59:58PM -0700, Wesley W. Terpstra wrote:
> SiFive SoCs can contain one or more PWM IP blocks.
> This adds a driver for them. Tested on the HiFive Unleashed.
>=20
> Signed-off-by: Wesley W. Terpstra <wesley@terpstra.ca>
> ---
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-sifive.c | 259 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 271 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sifive.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 763ee50..49e9824 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -387,6 +387,17 @@ config PWM_SAMSUNG
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-samsung.
> =20
> +config PWM_SIFIVE
> +	tristate "SiFive PWM support"
> +	depends on OF
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for SiFive SoCs, such as those
> +          found on the HiFive Unleashed series boards.

There's an inconsistent use of tabs and spaces for indentation here.

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sifive.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0258a74..17c5eb9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> +obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SPEAR)		+=3D pwm-spear.o
>  obj-$(CONFIG_PWM_STI)		+=3D pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> new file mode 100644
> index 0000000..587d4d4
> --- /dev/null
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -0,0 +1,259 @@
> +/*
> + * SiFive PWM driver
> + *
> + * Copyright (C) 2018 SiFive, Inc
> + *
> + * Author: Wesley W. Terpstra <wesley@sifive.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2, as publi=
shed by
> + * the Free Software Foundation.
> + */

Please include a SPDX license identifier here. That's the preferred way
to specify the license these days.

> +
> +#include <dt-bindings/pwm/pwm.h>

There should be no need to include this in a driver.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#define MAX_PWM			4
> +
> +/* Register offsets */
> +#define REG_PWMCFG		0x0
> +#define REG_PWMCOUNT		0x8
> +#define REG_PWMS		0x10
> +#define	REG_PWMCMP0		0x20
> +
> +/* PWMCFG fields */
> +#define BIT_PWM_SCALE		0
> +#define BIT_PWM_STICKY		8
> +#define BIT_PWM_ZERO_ZMP	9
> +#define BIT_PWM_DEGLITCH	10
> +#define BIT_PWM_EN_ALWAYS	12
> +#define BIT_PWM_EN_ONCE		13
> +#define BIT_PWM0_CENTER		16
> +#define BIT_PWM0_GANG		24
> +#define BIT_PWM0_IP		28
> +
> +#define SIZE_PWMCMP		4
> +#define MASK_PWM_SCALE		0xf
> +
> +struct sifive_pwm_device {
> +	struct pwm_chip		chip;
> +	struct notifier_block	notifier;
> +	struct clk		*clk;
> +	void __iomem		*regs;
> +	int			irq;
> +	unsigned int		approx_period;
> +	unsigned int		real_period;
> +};
> +
> +static inline struct sifive_pwm_device *chip_to_sifive(struct pwm_chip *=
c)
> +{
> +	return container_of(c, struct sifive_pwm_device, chip);
> +}
> +
> +static inline struct sifive_pwm_device *notifier_to_sifive(struct notifi=
er_block *nb)
> +{
> +	return container_of(nb, struct sifive_pwm_device, notifier);
> +}
> +
> +static int sifive_pwm_apply(struct pwm_chip *chip,
> +			    struct pwm_device *dev,
> +			    struct pwm_state *state)
> +{
> +	struct sifive_pwm_device *pwm =3D chip_to_sifive(chip);
> +	unsigned int duty_cycle;
> +	u32 frac;
> +
> +	duty_cycle =3D state->duty_cycle;
> +	if (!state->enabled)
> +		duty_cycle =3D 0;
> +	if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +		duty_cycle =3D state->period - duty_cycle;
> +
> +	frac =3D ((u64)duty_cycle << 16) / state->period;
> +	frac =3D min(frac, 0xFFFFU);
> +
> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> +
> +	if (state->enabled) {
> +		state->period =3D pwm->real_period;
> +		state->duty_cycle =3D ((u64)frac * pwm->real_period) >> 16;
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			state->duty_cycle =3D state->period - state->duty_cycle;

That's not the right way to handle polarity. The above often has the
same effect as inversed polarity, but it's not generally the right thing
to do. Please only support polarity if your hardware can actually really
reverse it. The above is something that PWM consumers (such as the
backlight driver) should take care of.

> +	}
> +
> +	return 0;
> +}
> +
> +static void sifive_pwm_get_state(struct pwm_chip *chip,
> +				 struct pwm_device *dev,
> +				 struct pwm_state *state)
> +{
> +	struct sifive_pwm_device *pwm =3D chip_to_sifive(chip);
> +	unsigned long duty;
> +
> +	duty =3D ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> +
> +	state->period     =3D pwm->real_period;
> +	state->duty_cycle =3D ((u64)duty * pwm->real_period) >> 16;
> +	state->polarity   =3D PWM_POLARITY_INVERSED;

Is the polarity really reversed by default on this IP?

> +	state->enabled    =3D duty > 0;
> +}
> +
> +static const struct pwm_ops sifive_pwm_ops =3D {
> +	.get_state	=3D sifive_pwm_get_state,
> +	.apply		=3D sifive_pwm_apply,
> +	.owner		=3D THIS_MODULE,
> +};
> +
> +static struct pwm_device *sifive_pwm_xlate(struct pwm_chip *chip,
> +					   const struct of_phandle_args *args)
> +{
> +	struct sifive_pwm_device *pwm =3D chip_to_sifive(chip);
> +	struct pwm_device *dev;
> +
> +	if (args->args[0] >=3D chip->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	dev =3D pwm_request_from_chip(chip, args->args[0], NULL);
> +	if (IS_ERR(dev))
> +		return dev;
> +
> +	/* The period cannot be changed on a per-PWM basis */
> +	dev->args.period   =3D pwm->real_period;
> +	dev->args.polarity =3D PWM_POLARITY_NORMAL;
> +	if (args->args[1] & PWM_POLARITY_INVERTED)
> +		dev->args.polarity =3D PWM_POLARITY_INVERSED;
> +
> +	return dev;
> +}
> +
> +static void sifive_pwm_update_clock(struct sifive_pwm_device *pwm,
> +				    unsigned long rate)
> +{
> +	/* (1 << (16+scale)) * 10^9/rate =3D real_period */
> +	unsigned long scalePow =3D (pwm->approx_period * (u64)rate) / 100000000=
0;
> +	int scale =3D ilog2(scalePow) - 16;
> +
> +	scale =3D clamp(scale, 0, 0xf);
> +	iowrite32((1 << BIT_PWM_EN_ALWAYS) | (scale << BIT_PWM_SCALE),
> +		  pwm->regs + REG_PWMCFG);
> +
> +	pwm->real_period =3D (1000000000ULL << (16 + scale)) / rate;
> +}
> +
> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
> +				     unsigned long event,
> +				     void *data)
> +{
> +	struct clk_notifier_data *ndata =3D data;
> +	struct sifive_pwm_device *pwm =3D notifier_to_sifive(nb);
> +
> +	if (event =3D=3D POST_RATE_CHANGE)
> +		sifive_pwm_update_clock(pwm, ndata->new_rate);
> +
> +	return NOTIFY_OK;
> +}

I don't think this is a good idea. Nobody should be allowed to just
change the PWM period without letting the PWM controller have a say in
the matter. Is this ever really an issue? Does the PWM controller use
a shared clock that changes rate frequently?

> +static int sifive_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct sifive_pwm_device *pwm;
> +	struct pwm_chip *chip;
> +	struct resource *res;
> +	int ret;
> +
> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip =3D &pwm->chip;
> +	chip->dev =3D dev;
> +	chip->ops =3D &sifive_pwm_ops;
> +	chip->of_xlate =3D sifive_pwm_xlate;
> +	chip->of_pwm_n_cells =3D 2;
> +	chip->base =3D -1;
> +
> +	ret =3D of_property_read_u32(node, "sifive,npwm", &chip->npwm);
> +	if (ret < 0 || chip->npwm > MAX_PWM)
> +		chip->npwm =3D MAX_PWM;

I don't see this documented in the DT bindings. I also don't see a need
for it. Under what circumstances would you want to change this?

> +
> +	ret =3D of_property_read_u32(node, "sifive,approx-period",
> +				   &pwm->approx_period);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to read sifive,approx-period from DTS\n");
> +		return -ENOENT;
> +	}
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwm->regs =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pwm->regs)) {
> +		dev_err(dev, "Unable to map IO resources\n");
> +		return PTR_ERR(pwm->regs);
> +	}
> +
> +	pwm->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pwm->clk)) {
> +		dev_err(dev, "Unable to find controller clock\n");
> +		return PTR_ERR(pwm->clk);
> +	}
> +
> +	pwm->irq =3D platform_get_irq(pdev, 0);
> +	if (pwm->irq < 0) {
> +		dev_err(dev, "Unable to find interrupt\n");
> +		return pwm->irq;
> +	}

You don't do anything with this, why bother retrieving it?

> +
> +	/* Watch for changes to underlying clock frequency */
> +	pwm->notifier.notifier_call =3D sifive_pwm_clock_notifier;
> +	clk_notifier_register(pwm->clk, &pwm->notifier);
> +
> +	/* Initialize PWM config */
> +	sifive_pwm_update_clock(pwm, clk_get_rate(pwm->clk));
> +
> +	ret =3D pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot register PWM: %d\n", ret);
> +		clk_notifier_unregister(pwm->clk, &pwm->notifier);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +	dev_info(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);

Please don't do this. Having informational messages like this show up in
the boot log only makes it more difficult to find actually relevant
messages like warnings or errors.

Note that it is expected that a driver will succeed to probe, that's not
something to brag about. Let the user know when something unexpected
happens.

If you really want to have this for debugging purposes, make it a
dev_dbg() message. But I'd still suggest dropping it, there are better
ways to check that your driver was successfully loaded (by inspecting
sysfs for example).

Thierry

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm5DsACgkQ3SOs138+
s6GSrA/+ICHRgSwbHmhgJGYydUP67tXBJ1EKgr64WDmAcFQ1GWxsAuJMhBHPcz73
t+8Qx7ytfLDa4uRmSPMN7Fz3JDRlk2oNQCBiEslfukgMdAZYYMy9vIuu94x0vLOU
uuFff8ldD/5yrSGx3FxhYJ+Fushj/q40EY8HN8TWEncXQ029zKVrDQBPqTvNxjtg
3HL7Dwjv/31qymq4Sxr9bR44wSXSzZqkuJBYo47LaCnem3pKolcchlwBGZaCcb05
4ulu0otPtxBWxo7bsmqNiCeJA0jDLjfo+zwO0tDgIaaWBtQUSfuBx4tcSAQXkmF7
fC92LFy4gvMrBWoXYzA1BlFVwE1X0HHOXItoPuR+fyD2GhH14MEPk4DjXo+xeLlS
3l6enlp2B7N/wMlECTxxFxYi5OQGAXFklstfE+NuI2CEJIJSH64jJRiyI29Z5ltK
X0XK+20XVBVdTf5AcICh4GEAAGjejPSPrKg9vTs778SZLGloQkfPrzKLFcRhAQYS
xsOe574P06qw51E4PERT4vAB9IX3tm0uawkAv+GH0N87PeHkiDRgS1/NReqcVif2
7HaJ9BVacMxZ3gNydFDGIEyNK6ODBxNPUpLGXrZX9CU5erlcxyEu/w6HPHElQNGu
Su4F8e5C+UIP0FKVFNP/oy5I15tL4fvFajUdTqblMjSkFjcuzBc=
=mGqu
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
