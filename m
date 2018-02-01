Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752439AbeBAMSC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:18:02 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37750 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeBAMR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:17:58 -0500
X-Google-Smtp-Source: AH8x224k2mfLz9MXccaT/u28qBnyB/0+0Ulyz6LoDXtSAJBx93/9SDpynfdt5z138JGGxzIqSxi50A==
Date: Thu, 1 Feb 2018 13:17:53 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
Message-ID: <20180201121753.GB690@gmail.com>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

On Tue, Jan 30, 2018 at 08:07:43PM +0800, Baolin Wang wrote:
> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> each group contains 16 GPIOs. Each GPIO can set input/output and has
> the interrupt capability.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> new file mode 100644
> index 0000000..af59b9f
> --- /dev/null
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Spreadtrum Communications Inc.
> + * Copyright (c) 2018 Linaro Ltd.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +
> +/* GPIO registers definition */
> +#define SPRD_GPIO_DATA		0x0
> +#define SPRD_GPIO_DMSK		0x4
> +#define SPRD_GPIO_DIR		0x8
> +#define SPRD_GPIO_IS		0xc
> +#define SPRD_GPIO_IBE		0x10
> +#define SPRD_GPIO_IEV		0x14
> +#define SPRD_GPIO_IE		0x18
> +#define SPRD_GPIO_RIS		0x1c
> +#define SPRD_GPIO_MIS		0x20
> +#define SPRD_GPIO_IC		0x24
> +#define SPRD_GPIO_INEN		0x28
> +
> +/* We have 16 groups GPIOs and each group contain 16 GPIOs */
> +#define SPRD_GPIO_GROUP_NR	16
> +#define SPRD_GPIO_NR		256
> +#define SPRD_GPIO_GROUP_SIZE	0x80
> +#define SPRD_GPIO_GROUP_MASK	GENMASK(15, 0)
> +#define SPRD_GPIO_BIT(x)	((x) & (SPRD_GPIO_GROUP_NR - 1))
> +
> +struct sprd_gpio {
> +	struct gpio_chip chip;
> +	void __iomem *base;
> +	spinlock_t lock;
> +	int irq;
> +};
> +
> +static inline void __iomem *sprd_gpio_group_base(struct sprd_gpio *sprd_=
gpio,
> +						 unsigned int group)
> +{
> +	return sprd_gpio->base + SPRD_GPIO_GROUP_SIZE * group;
> +}
> +
> +static void sprd_gpio_update(struct gpio_chip *chip, unsigned int offset,
> +			     unsigned int reg, unsigned int val)
> +{
> +	struct sprd_gpio *sprd_gpio =3D gpiochip_get_data(chip);
> +	void __iomem *base =3D sprd_gpio_group_base(sprd_gpio,
> +						  offset / SPRD_GPIO_GROUP_NR);
> +	u32 shift =3D SPRD_GPIO_BIT(offset);
> +	unsigned long flags;
> +	u32 orig, tmp;
> +
> +	spin_lock_irqsave(&sprd_gpio->lock, flags);
> +	orig =3D readl_relaxed(base + reg);
> +
> +	tmp =3D (orig & ~BIT(shift)) | (val << shift);
> +	writel_relaxed(tmp, base + reg);
> +	spin_unlock_irqrestore(&sprd_gpio->lock, flags);
> +}
> +
> +static int sprd_gpio_read(struct gpio_chip *chip, unsigned int offset,
> +			  unsigned int reg)
> +{
> +	struct sprd_gpio *sprd_gpio =3D gpiochip_get_data(chip);
> +	void __iomem *base =3D sprd_gpio_group_base(sprd_gpio,
> +						  offset / SPRD_GPIO_GROUP_NR);
> +	u32 value =3D readl_relaxed(base + reg) & SPRD_GPIO_GROUP_MASK;
> +	u32 shift =3D SPRD_GPIO_BIT(offset);
> +
> +	return !!(value & BIT(shift));
> +}
> +
> +static int sprd_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 1);
> +	return 0;
> +}

Better to change the function to void since the return value is not
valueable.

> +
> +static void sprd_gpio_free(struct gpio_chip *chip, unsigned int offset)
> +{
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_DMSK, 0);
> +}
> +
> +static int sprd_gpio_direction_input(struct gpio_chip *chip,
> +				     unsigned int offset)
> +{
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 0);
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 1);
> +	return 0;
> +}

Same here


> +
> +static int sprd_gpio_direction_output(struct gpio_chip *chip,
> +				      unsigned int offset, int value)
> +{
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_DIR, 1);
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_INEN, 0);
> +	sprd_gpio_update(chip, offset, SPRD_GPIO_DATA, value);
> +	return 0;
> +}

and here.


Thanks,
Marcus Folkesson




--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpzBWwACgkQiIBOb1ld
UjIGng/9HW0QXWylsPPRhKII4zxA72gXQIwh7QPstYT+6pnfNc/zR0VMvPXGBA3X
v8wS05JvKmQWmQDd9ZJHGw0m2PtYeJ3RybVsdqvXuYu8Tq6rZ/lolcoI1ljvzGIH
z0vBaCHt4BP0jkVeiz2mtLBQoYaUBvbhOb/Kv5EYVz1Lffpn7Srmq4+cxcmwj6TH
mbkCcMZ+E+ve7XFNl9Z0kjTQ9VNycur3etsITNoM/JeeuiHthDPwqvpX2s1QLcqC
qZGoQbL1el4xvOr9m5y/9vqUAUjrAwAR46kbm4RdyPoUWDa5qdQYJNsot2Fb2Fqy
MQL1K+tz/XrMt9mLmnY6dKvOwfLneZpCFtcceUqvfOUu+THZwAa32AoHIz60V8+o
QN3gZTrBcIVvc3JNmQj6+rEbxpzDmh9YjJl6CpOin8VgyYUrt/F1p4D2HVvsT9VO
/q8PF6ArsYrmJ41pdCltbP9HflJpMofTgC3r4OrKniG8YlvVGZz2qwnlmtJsQ45I
MbCjPPF82A1F85r7zUIN0kxIpeQpb89lU9C97toUMzMsCxYt5IpBWSY1MqsRg2Qb
BDeqwYpt/L0M/zRMVCcBtWe8x5DOgmQ0wVd6qxSrtApYWG9IlfqClEBD5enp7RJT
3godEJ7c3lP5H3U8MvziMwIqd9LmFWOcz80cqfxe4yqbBzIHFTo=
=yquO
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
