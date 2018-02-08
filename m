Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBHWc6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeBHWc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:32:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A97D21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Thu, 8 Feb 2018 23:32:52 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/8] power: reset: Add a driver for the Microsemi
 Ocelot reset
Message-ID: <20180208223252.oldyitedhjnpixfw@earth.universe>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-4-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elfl32zc3amnzwwo"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-4-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elfl32zc3amnzwwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 16, 2018 at 11:12:35AM +0100, Alexandre Belloni wrote:
> The Microsemi Ocelot SoC has a register allowing to reset the MIPS core.
> Unfortunately, the syscon-reboot driver can't be used directly (but almos=
t)
> as the reset control may be disabled using another register.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Thanks, queued. My for-next branch is waiting for 4.16-rc1 tag, though.

-- Sebastian

>  drivers/power/reset/Kconfig        |  7 +++
>  drivers/power/reset/Makefile       |  1 +
>  drivers/power/reset/ocelot-reset.c | 88 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 drivers/power/reset/ocelot-reset.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index ca0de1a78e85..2372f8e1040d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -113,6 +113,13 @@ config POWER_RESET_MSM
>  	help
>  	  Power off and restart support for Qualcomm boards.
> =20
> +config POWER_RESET_OCELOT_RESET
> +	bool "Microsemi Ocelot reset driver"
> +	depends on MSCC_OCELOT || COMPILE_TEST
> +	select MFD_SYSCON
> +	help
> +	  This driver supports restart for Microsemi Ocelot SoC.
> +
>  config POWER_RESET_PIIX4_POWEROFF
>  	tristate "Intel PIIX4 power-off driver"
>  	depends on PCI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index aeb65edb17b7..df9d92291c67 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restar=
t.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
>  obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
> diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/oce=
lot-reset.c
> new file mode 100644
> index 000000000000..5a13a5cc8188
> --- /dev/null
> +++ b/drivers/power/reset/ocelot-reset.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Microsemi MIPS SoC reset driver
> + *
> + * License: Dual MIT/GPL
> + * Copyright (c) 2017 Microsemi Corporation
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/notifier.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/regmap.h>
> +
> +struct ocelot_reset_context {
> +	void __iomem *base;
> +	struct regmap *cpu_ctrl;
> +	struct notifier_block restart_handler;
> +};
> +
> +#define ICPU_CFG_CPU_SYSTEM_CTRL_RESET 0x20
> +#define CORE_RST_PROTECT BIT(2)
> +
> +#define SOFT_CHIP_RST BIT(0)
> +
> +static int ocelot_restart_handle(struct notifier_block *this,
> +				 unsigned long mode, void *cmd)
> +{
> +	struct ocelot_reset_context *ctx =3D container_of(this, struct
> +							ocelot_reset_context,
> +							restart_handler);
> +
> +	/* Make sure the core is not protected from reset */
> +	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
> +			   CORE_RST_PROTECT, 0);
> +
> +	writel(SOFT_CHIP_RST, ctx->base);
> +
> +	pr_emerg("Unable to restart system\n");
> +	return NOTIFY_DONE;
> +}
> +
> +static int ocelot_reset_probe(struct platform_device *pdev)
> +{
> +	struct ocelot_reset_context *ctx;
> +	struct resource *res;
> +
> +	struct device *dev =3D &pdev->dev;
> +	int err;
> +
> +	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctx->base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ctx->base))
> +		return PTR_ERR(ctx->base);
> +
> +	ctx->cpu_ctrl =3D syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-s=
yscon");
> +	if (IS_ERR(ctx->cpu_ctrl))
> +		return PTR_ERR(ctx->cpu_ctrl);
> +
> +	ctx->restart_handler.notifier_call =3D ocelot_restart_handle;
> +	ctx->restart_handler.priority =3D 192;
> +	err =3D register_restart_handler(&ctx->restart_handler);
> +	if (err)
> +		dev_err(dev, "can't register restart notifier (err=3D%d)\n", err);
> +
> +	return err;
> +}
> +
> +static const struct of_device_id ocelot_reset_of_match[] =3D {
> +	{ .compatible =3D "mscc,ocelot-chip-reset" },
> +	{}
> +};
> +
> +static struct platform_driver ocelot_reset_driver =3D {
> +	.probe =3D ocelot_reset_probe,
> +	.driver =3D {
> +		.name =3D "ocelot-chip-reset",
> +		.of_match_table =3D ocelot_reset_of_match,
> +	},
> +};
> +builtin_platform_driver(ocelot_reset_driver);
> --=20
> 2.15.1
>=20

--elfl32zc3amnzwwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp80BQACgkQ2O7X88g7
+pqGkxAAlKqfq9/Gz3C1hr/DQJnZjboBeYaX6Q0QBsNQwOEwDXiOtFFBD988ktR0
KYi2nRkuAqMvABG4fwLbYXSnU/9+oZn57VLqBgT4mxDskEiIEzqIt4nI7rQZfqcv
wIEjLTmMLN2RNGfkBQ+RFOldGxf5rOW11wt4cgNIPtbyXSQ9cJHRp2kkVR/yj2hL
Exm8ROh88YwFLKfvknFR7g/kJ3UGIzc3M+a6hMO17tfCb9+5U2C7p7I0tctjeVqA
7g9ZyKsmJxC+Xw7mmSZ9FzK9/xPS3snljrjDn+mQRqxIbC8SPKRmsnWTEZZ1qa5n
cKRAEVAvxJbmgi421cHWoc+3Q5oYyVutnINC+FnHQ6/3M9uQFN2Te/+asy7XA68+
mH5Y6n3y6RHCA3mmCEYbqs6YDXPGYQdm7rUmo1cndZoYAbum/1x4mUG+hoKfktqL
XduRsq8McwHqBUq8DVGPKOHWM+JkmWrLRp/8b3WpBuWjWxdxIGIIiZzu/KNC/Uwz
OZBapUIkSyuvTgyhVIpvzKqT06ZkRPFbJXciwZ61geb9vOhtI8qrUB8Hs7Tu0ddj
9RMUN+Px5BSmN3Hkzc8COxvonR+/K9I31IdTQXnyE+BqGw4HGyRHlOxkFDbzJTuu
Ipzk0XfNyJJ9Ek1Y6gxPqGaQd9X9DpDqhsGhrj0Iyt3Y3U+TPaI=
=UJtJ
-----END PGP SIGNATURE-----

--elfl32zc3amnzwwo--
