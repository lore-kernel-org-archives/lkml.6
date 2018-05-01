Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755872AbeEAM4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755225AbeEAM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:56:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C08722DC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Tue, 1 May 2018 14:56:28 +0200
From: Sebastian Reichel <sre@kernel.org>
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        matthias.bgg@gmail.com, eddie.huang@mediatek.com,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/17] power: reset: mt6323: add a driver for MT6323
 power controller
Message-ID: <20180501125628.44nyx25tqsrxkvsl@earth.universe>
References: <cover.1524646231.git.sean.wang@mediatek.com>
 <51d4fbe0d6a22986ddd2df66c9db39aa1eaab74a.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xjqcbc7ra2xrdtp"
Content-Disposition: inline
In-Reply-To: <51d4fbe0d6a22986ddd2df66c9db39aa1eaab74a.1524646231.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xjqcbc7ra2xrdtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 25, 2018 at 05:32:41PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> The power device is responsible for externally down or up the power
> of the remote MediaTek SoC through the tiny circuit BBPU inside PMIC RTC.
>=20
> Though it's a part of RTC device, it would be better to be a standalone
> driver than to be a part of existent RTC driver so as to let us make
> concentration on works about power-controlling topic and to obtain
> improvements while the subsystem power/reset constantly growing.

I don't understand the above sentence. (I'm fine with adding the
driver)

> Currently, the most basic functionality supported is to just power off
> the system by writing to a special bit field in BBPU register after the
> system has reached pm_poweroff.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/power/reset/Kconfig           | 10 ++++
>  drivers/power/reset/Makefile          |  1 +
>  drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/mt6397/rtc.h        |  1 +
>  4 files changed, 109 insertions(+)
>  create mode 100644 drivers/power/reset/mt6323-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index df58fc8..7b49d71 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -128,6 +128,16 @@ config POWER_RESET_LTC2952
>  	  This driver supports an external powerdown trigger and board power
>  	  down via the LTC2952. Bindings are made in the device tree.
> =20
> +config POWER_RESET_MT6323
> +	bool "MediaTek MT6323 power-off driver"
> +	depends on MFD_MT6397
> +	help
> +	  The power-off driver is responsible for externally shutdown down
> +	  the power of a remote MediaTek SoC MT6323 is connected to through
> +	  controlling a tiny circuit BBPU inside MT6323 RTC.
> +
> +	  Say Y if you have a board where MT6323 could be found.
> +
>  config POWER_RESET_QNAP
>  	bool "QNAP power-off driver"
>  	depends on OF_GPIO && PLAT_ORION
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 7778c74..8836172 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
>  obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
> diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/=
mt6323-poweroff.c
> new file mode 100644
> index 0000000..c195766
> --- /dev/null
> +++ b/drivers/power/reset/mt6323-poweroff.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Power off through MediaTek PMIC
> + *
> + * Copyright (C) 2018 MediaTek Inc.
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Not needed

> +#include <linux/platform_device.h>
> +#include <linux/mfd/mt6397/core.h>
> +#include <linux/mfd/mt6397/rtc.h>
> +
> +struct mt6323_pwrc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	u32 base;
> +};
> +
> +static struct mt6323_pwrc *mt_pwrc;
> +
> +static void mt6323_do_pwroff(void)
> +{
> +	struct mt6323_pwrc *pwrc =3D mt_pwrc;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
> +	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
> +
> +	ret =3D regmap_read_poll_timeout(pwrc->regmap,
> +				       pwrc->base + RTC_BBPU, val,
> +				       !(val & RTC_BBPU_CBUSY),
> +				       MTK_RTC_POLL_DELAY_US,
> +				       MTK_RTC_POLL_TIMEOUT);
> +	if (ret)
> +		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
> +
> +	/* Wait some time until system down, otherwise, notice with a warn */
> +	mdelay(1000);
> +
> +	WARN_ONCE(1, "Unable to power off system\n");
> +}
> +
> +static int mt6323_pwrc_probe(struct platform_device *pdev)
> +{
> +	struct mt6397_chip *mt6397_chip =3D dev_get_drvdata(pdev->dev.parent);
> +	struct mt6323_pwrc *pwrc;
> +	struct resource *res;
> +
> +	pwrc =3D devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
> +	if (!pwrc)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pwrc->base =3D res->start;
> +	pwrc->regmap =3D mt6397_chip->regmap;
> +	pwrc->dev =3D &pdev->dev;
> +	mt_pwrc =3D pwrc;
> +
> +	pm_power_off =3D &mt6323_do_pwroff;
> +
> +	return 0;
> +}
> +
> +static int mt6323_pwrc_remove(struct platform_device *pdev)
> +{
> +	if (pm_power_off =3D=3D &mt6323_do_pwroff)
> +		pm_power_off =3D NULL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mt6323_pwrc_dt_match[] =3D {
> +	{ .compatible =3D "mediatek,mt6323-pwrc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);

Don't forget to remove the DT table when you respin the series for
the requested binding changes.

> +static struct platform_driver mt6323_pwrc_driver =3D {
> +	.probe		=3D mt6323_pwrc_probe,
> +	.remove		=3D mt6323_pwrc_remove,
> +	.driver		=3D {
> +		.name	=3D "mt6323-pwrc",
> +		.of_match_table =3D mt6323_pwrc_dt_match,
> +	},
> +};
> +
> +module_platform_driver(mt6323_pwrc_driver);
> +
> +MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rt=
c.h
> index 480977c..ac932c9 100644
> --- a/include/linux/mfd/mt6397/rtc.h
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -16,6 +16,7 @@
> =20
>  #define RTC_BBPU		0x0000
>  #define RTC_BBPU_CBUSY		BIT(6)
> +#define RTC_BBPU_KEY            (0x43 << 8)
> =20
>  #define RTC_WRTGR		0x003c

The driver looks fine otherwise.

-- Sebastian

--2xjqcbc7ra2xrdtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlroY/kACgkQ2O7X88g7
+pp98g/7BSK8woCYmjvXst7kOG9S9fJijnbJ3ClpKKZNlTj+F8QhN17BFhz6Xbyw
NttirFOSLb+vbVTle1f0UcpnU2hET4pLo70DzaXlIHGTM3rSa2cGebNRmbARolVQ
UqT11rgCHFE9pn/8dgRhne8l/Mzxks91zc31fEGTcV1G+3iqrTdCrInxqm9oOUa0
fVGk9T7u0GqVwowxoFM5l4EgdoHbVwPPeYxg7uPz+YHYR/nTsBRHRiu7ROnjDJbB
XQIuuNlwKSBxgDEjmz/bNAHpk4qpsOx5ccKAbxpNkR3Ujbde+Pgh7mUu5zrY0ZG2
4ZoYI6wbFlhtqP4yJAxVi59stthrEvCYBorPfzg7uVW093deZNloAcOsuK6tpElu
idmpSAUH6YWIG9pRSSHpgqIpBkUWMGvDjglEXrg+BbCBlVbTN072hN2IQwqZ/aPr
z3RtalfvEWiJvGKdI2lUwuCmg23r7lzI8KsNDRn1EdYWX0aZlTcbB9uGp7aph/Ky
cSIuHuWo5s4dquuDghsYMwx83JbynDjxW1P6Uiqk2fmo5sMBs/Hs/TIY8QctovRs
EgMtRZvJVdqKLRV2xv0fboPnU18Gknci+sVxV1ebNZGlWFjlVJbXQCySU5nO4V+L
N2c8TiRV2bZNqJWJWgL9nmFzbwApmcB3J8QnKbSv1LuO7GxW1d4=
=JauM
-----END PGP SIGNATURE-----

--2xjqcbc7ra2xrdtp--
