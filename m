Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E208218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUiEucCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbeLTR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:57:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33314 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733211AbeLTR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:57:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so2514794eds.0;
        Thu, 20 Dec 2018 09:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fTXnL4w7SphguGIdxnyMHivvmZhE6EALEGuSn5Oz+Zo=;
        b=dUiEucCX35iC+62dRJ2DmDvRxYVB/oeg69HHeXPOcN11NsP4KKm2V8I2pmUz1DWt5t
         AeBgAkF0hEFXNZ+I4w4mPRLaM0os9J6eCNzvhkwL/2zIVVhQxNR00upGFDHWTp49q6bk
         9JieHwOZwR7CoOE4234tufN7iNFf6ofcj8w09NW0qcl/JVrdzNZBEkEtL6eMG//aey0g
         tAlaU+1OKkqV5r23qI9i27mwCd//ENMBAWOSY/kb7h0K69LhG9au6L3hsIexDu2QLb/2
         QIBmNHPeCst3HqbOb6hqECvbz0OZyVL7HX+mtOo7w3HFZpVnn92QPEyOvbFFJhBdheks
         d+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fTXnL4w7SphguGIdxnyMHivvmZhE6EALEGuSn5Oz+Zo=;
        b=lQb5gyeWwJRrnlE6Nmp6UR4i6/KiYybX83QE1deDU4ICej8iUMod/7jeUyq1akjrz6
         Pt9lW87OJSfR7qN2ZeCmz2mLyJzsZV3QBWx3i3cjiSARped0NxXwBaDfujvbAaClE/Di
         wpVwdAs4HBi+JXzS+tE8B33y56Y++8rj2sqihe54GJBCJHTYGdXnZzLHX04FYdVe57uf
         A6/BrRLB861ZbriF4JiFX13wExF8Eo08WrfkNQOLRGauZvo6oiJT9xiekAWdSotFBrXo
         PYUYnzJzoyEzl+nHzizsQ4QGQM01NfhlN2BvchMimenJIbrzhRld9pXmBjEyK+wvAWQJ
         pq6g==
X-Gm-Message-State: AA+aEWb5+VDx6wLApbPfniTm9bXIjAKyh7cwx7sXvb+aaQQ8+MQ3rj1C
        OVQ81vDP55aQE3XG/SjWoIU=
X-Google-Smtp-Source: AFSGD/VT6nzno0bxmV8Xv+voM79d+6FDwlEfCpKASrMzSFAgF3BgfgPoSd20jitgWwl25WmglRqTmg==
X-Received: by 2002:a17:906:7d0:: with SMTP id m16-v6mr20472522ejc.32.1545328672428;
        Thu, 20 Dec 2018 09:57:52 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t18-v6sm3278237ejz.9.2018.12.20.09.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:57:51 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:57:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 6/6] ARM: PWM: add allwinner sun8i R40/T3/V40 PWM
 support.
Message-ID: <20181220175750.GG9408@ulmo>
References: <20181125162319.GA5422@arx-s1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
Content-Disposition: inline
In-Reply-To: <20181125162319.GA5422@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 12:23:19AM +0800, Hao Zhang wrote:
> The sun8i R40/T3/V40 PWM has 8 PWM channals and divides to 4 PWM pairs,
> each PWM pair built-in 1 clock module, 2 timer logic module and 1
> programmable dead-time generator, it also support waveform capture.
> It has 2 clock sources OSC24M and APB1, it is different with the
> sun4i-pwm driver, Therefore add a new driver for it.
>=20
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  drivers/pwm/Kconfig     |  12 +-
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun8i.c | 418 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 430 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 504d252..6105ac8 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -426,7 +426,7 @@ config PWM_STMPE
>  	  expanders.
> =20
>  config PWM_SUN4I
> -	tristate "Allwinner PWM support"
> +	tristate "Allwinner SUN4I PWM support"
>  	depends on ARCH_SUNXI || COMPILE_TEST
>  	depends on HAS_IOMEM && COMMON_CLK
>  	help
> @@ -435,6 +435,16 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN8I
> +	tristate "Allwinner SUN8I (R40/V40/T3) PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner R40/V40/T3 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i.
> +
>  config PWM_TEGRA
>  	tristate "NVIDIA Tegra PWM support"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9c676a0..32c8d2d 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I)		+=3D pwm-sun8i.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> new file mode 100644
> index 0000000..d8597e4
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hao Zhang <hao5781286@gmail.com>
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +#include <linux/regmap.h>
> +
> +#define PWM_IRQ_ENABLE_REG	0x0000
> +#define PCIE(ch)		BIT(ch)
> +
> +#define PWM_IRQ_STATUS_REG	0x0004
> +#define PIS(ch)			BIT(ch)
> +
> +#define CAPTURE_IRQ_ENABLE_REG	0x0010
> +#define CRIE(ch)		BIT((ch) * 2)
> +#define CFIE(ch)		BIT((ch) * 2 + 1)
> +
> +#define CAPTURE_IRQ_STATUS_REG	0x0014
> +#define CRIS(ch)		BIT((ch) * 2)
> +#define CFIS(ch)		BIT((ch) * 2 + 1)
> +
> +#define CLK_CFG_REG(ch)		(0x0020 + ((ch) >> 1) * 4)
> +#define CLK_SRC_SEL		GENMASK(8, 7)
> +#define CLK_SRC_BYPASS_SEC	BIT(6)
> +#define CLK_SRC_BYPASS_FIR	BIT(5)
> +#define CLK_GATING		BIT(4)
> +#define CLK_DIV_M		GENMASK(3, 0)
> +
> +#define PWM_DZ_CTR_REG(ch)	(0x0030 + ((ch) >> 1) * 4)
> +#define PWM_DZ_INTV		GENMASK(15, 8)
> +#define PWM_DZ_EN		BIT(0)
> +
> +#define PWM_ENABLE_REG		0x0040
> +#define PWM_EN(ch)		BIT(ch)
> +
> +#define CAPTURE_ENABLE_REG	0x0044
> +#define CAP_EN(ch)		BIT(ch)
> +
> +#define PWM_CTR_REG(ch)		(0x0060 + (ch) * 0x20)
> +#define PWM_PERIOD_RDY		BIT(11)
> +#define PWM_PUL_START		BIT(10)
> +#define PWM_MODE		BIT(9)
> +#define PWM_ACT_STA		BIT(8)
> +#define PWM_PRESCAL_K		GENMASK(7, 0)
> +
> +#define PWM_PERIOD_REG(ch)	(0x0064 + (ch) * 0x20)
> +#define PWM_ENTIRE_CYCLE	GENMASK(31, 16)
> +#define PWM_ACT_CYCLE		GENMASK(15, 0)
> +
> +#define PWM_CNT_REG(ch)		(0x0068 + (ch) * 0x20)
> +#define PWM_CNT_VAL		GENMASK(15, 0)
> +
> +#define CAPTURE_CTR_REG(ch)	(0x006c + (ch) * 0x20)
> +#define CAPTURE_CRLF		BIT(2)
> +#define CAPTURE_CFLF		BIT(1)
> +#define CAPINV			BIT(0)
> +
> +#define CAPTURE_RISE_REG(ch)	(0x0070 + (ch) * 0x20)
> +#define CAPTURE_CRLR		GENMASK(15, 0)
> +
> +#define CAPTURE_FALL_REG(ch)	(0x0074 + (ch) * 0x20)
> +#define CAPTURE_CFLR		GENMASK(15, 0)
> +
> +struct sun8i_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *base;
> +	const struct sun8i_pwm_data *data;
> +	struct regmap *regmap;
> +};
> +
> +static struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sun8i_pwm_chip, chip);
> +}
> +
> +static u32 sun8i_pwm_read(struct sun8i_pwm_chip *sun8i_pwm,
> +			  unsigned long offset)
> +{
> +	u32 val;
> +
> +	regmap_read(sun8i_pwm->regmap, offset, &val);
> +	return val;
> +}
> +
> +static void sun8i_pwm_set_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +			      unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, bit);
> +}
> +
> +static void sun8i_pwm_clear_bit(struct sun8i_pwm_chip *sun8i_pwm,
> +				unsigned long reg, u32 bit)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, bit, 0);
> +}
> +
> +static void sun8i_pwm_set_value(struct sun8i_pwm_chip *sun8i_pwm,
> +				unsigned long reg, u32 mask, u32 val)
> +{
> +	regmap_update_bits(sun8i_pwm->regmap, reg, mask, val);
> +}
> +
> +static void sun8i_pwm_set_polarity(struct sun8i_pwm_chip *chip, u32 ch,
> +				   enum pwm_polarity polarity)
> +{
> +	if (polarity =3D=3D PWM_POLARITY_NORMAL)
> +		sun8i_pwm_set_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +	else
> +		sun8i_pwm_clear_bit(chip, PWM_CTR_REG(ch), PWM_ACT_STA);
> +}
> +
> +static int sun8i_pwm_config(struct sun8i_pwm_chip *sun8i_pwm, u8 ch,
> +			    struct pwm_state *state)
> +{
> +	u64 clk_rate, clk_div, val;
> +	u16 prescaler =3D 0;
> +	u16 div_id =3D 0;
> +	struct clk *clk;
> +	bool is_clk;
> +	int ret;
> +
> +	clk_rate =3D clk_get_rate(sun8i_pwm->clk);
> +
> +	/* check period and select clock source */
> +	val =3D state->period * clk_rate;
> +	do_div(val, NSEC_PER_SEC);
> +	is_clk =3D devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> +	if (val <=3D 1 && is_clk) {
> +		clk =3D devm_clk_get(sun8i_pwm->chip.dev, "mux-1");
> +		if (IS_ERR(clk)) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Period expects a larger value\n");
> +			return -EINVAL;
> +		}

You should never try to get resources at this point. You should have
requested them already at ->probe() time. Otherwise, how are you going
to handle failures here?

> +
> +		clk_rate =3D clk_get_rate(clk);
> +		val =3D state->period * clk_rate;
> +		do_div(val, NSEC_PER_SEC);
> +		if (val <=3D 1) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Period expects a larger value\n");
> +			return -EINVAL;
> +		}
> +
> +		/* change clock source to "mux-1" */
> +		clk_disable_unprepare(sun8i_pwm->clk);
> +		devm_clk_put(sun8i_pwm->chip.dev, sun8i_pwm->clk);
> +		sun8i_pwm->clk =3D clk;
> +
> +		ret =3D clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(sun8i_pwm->chip.dev,
> +				"Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +
> +	} else {
> +		dev_err(sun8i_pwm->chip.dev,
> +			"Period expects a larger value\n");
> +		return -EINVAL;
> +	}
> +
> +	is_clk =3D devm_clk_name_match(sun8i_pwm->clk, "mux-0");
> +	if (is_clk)
> +		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +				    CLK_SRC_SEL, 0 << 7);
> +	else
> +		sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +				    CLK_SRC_SEL, 1 << 7);
> +
> +	dev_info(sun8i_pwm->chip.dev, "clock source freq:%lldHz\n", clk_rate);
> +
> +	/* calculate and set prescaler, div table, PWM entire cycle */
> +	clk_div =3D val;
> +	while (clk_div > 65535) {
> +		prescaler++;
> +		clk_div =3D val;
> +		do_div(clk_div, 1U << div_id);
> +		do_div(clk_div, prescaler + 1);
> +
> +		if (prescaler =3D=3D 255) {
> +			prescaler =3D 0;
> +			div_id++;
> +			if (div_id =3D=3D 9) {
> +				dev_err(sun8i_pwm->chip.dev,
> +					"unsupport period value\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			    PWM_ENTIRE_CYCLE, clk_div << 16);
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_CTR_REG(ch),
> +			    PWM_PRESCAL_K, prescaler << 0);
> +	sun8i_pwm_set_value(sun8i_pwm, CLK_CFG_REG(ch),
> +			    CLK_DIV_M, div_id << 0);
> +
> +	/* set duty cycle */
> +	val =3D state->period;
> +	do_div(val, clk_div);
> +	clk_div =3D state->duty_cycle;
> +	do_div(clk_div, val);
> +	if (clk_div > 65535)
> +		clk_div =3D 65535;
> +
> +	sun8i_pwm_set_value(sun8i_pwm, PWM_PERIOD_REG(ch),
> +			    PWM_ACT_CYCLE, clk_div << 0);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   struct pwm_state *state)
> +{
> +	int ret;
> +	struct sun8i_pwm_chip *sun8i_pwm =3D to_sun8i_pwm_chip(chip);
> +	struct pwm_state cstate;
> +
> +	pwm_get_state(pwm, &cstate);
> +	if (!cstate.enabled) {
> +		ret =3D clk_prepare_enable(sun8i_pwm->clk);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to enable PWM clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	if ((cstate.period !=3D state->period) ||
> +	    (cstate.duty_cycle !=3D state->duty_cycle)) {
> +		ret =3D sun8i_pwm_config(sun8i_pwm, pwm->hwpwm, state);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to config PWM\n");
> +			return ret;
> +		}
> +	}

So this isn't really how atomic is supposed to work. The whole point of
the single callback is to allow the driver to apply the changes in an
atomic way, which means that either everything is applied or nothing is
applied.

That's not what you do here. In the above you can end up with an enabled
clock but the settings not being applied. Similarly sun8i_pwm_config()
can abort in a number of places, which would leave you with a half-
configured PWM channel.

Instead, what you should be doing is precompute everything and check
that the configuration can be applied before touching any registers or
enabling clocks. Once you've validate the new state, you need to write
everything and there should be no more risk of failure.

Thierry

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb2B4ACgkQ3SOs138+
s6GmgRAAwvTyhaFa0jWmUftz+0FS5JTXADm9VusyhbSlmHV7UNkqkQuLnaT1WoGi
gGW5ZMLA+wSPWrXqGsw1HuzLc57c1/eDQdxLmlqBz0Lwribn75+0kisEvV3CRCEL
P9UiTgMualhTe0DGKZmcHJvV56sEhx7b2WQ81sOn5nZvCP/iFTURp5WSyk+phAyb
ss9i5bjwuxC34wLC0wCVNvr2XlpdD7CTy0R/nap1Za2nf6Cm0TnzGGPIYki1/gM2
fUtYT/zCvfGp+JG5+R2755XdomXzj0vmXD7Omv75eKzMb+HivolmLPJEfUiP8c+x
SElT/F/jIkwvdBzyeQ/sA8ybh4N0DVapnUxBjrUBLOMlrNDlh+ApjUOOpwylQBXQ
6JKmjoHoBg31lK9QEPxoIoNP0FdZBr6+lAaZeQNx95PeICxD21IvPtuLEp4ksbX7
fJsOxbkBzbIMpKuxLM3vkl89/O9IhPbVoyvMASCPMmdwAIH+LSy3SvIFWbGQ0nXS
gwjTzN4r1AWmdXIN+faT6khnNY64WoPd896AyJSQ5mQsl42IMKRi42kpfeN3/f8y
x4d07WSTCRB4v+OehJEVP2WJNsbI3EvtClbngn66xSac7kGSbg4cpbW0NzkrFj+T
dOG2p9wUMibPBXzS+V7JzTsDgR9JG2fzxG8PhEesaG/Bt32Hg0Y=
=S1Wz
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--
