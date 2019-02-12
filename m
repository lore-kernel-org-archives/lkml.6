Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD0C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AB4222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbfBLVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:46:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43748 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfBLVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:46:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DED7B27EC2B
Received: by earth.universe (Postfix, from userid 1000)
        id A3EBA3C08DD; Tue, 12 Feb 2019 22:46:48 +0100 (CET)
Date:   Tue, 12 Feb 2019 22:46:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, moritz.fischer@ettus.com
Subject: Re: [RFC 4/6] power: supply: Ettus Research E31x charger driver
Message-ID: <20190212214648.77lzvexfs2v46ejn@earth.universe>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-5-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zju52o37iaea74zq"
Content-Disposition: inline
In-Reply-To: <20190212010143.3729-5-virendra.kakade@ni.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zju52o37iaea74zq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 11, 2019 at 07:01:41PM -0600, Virendra Kakade wrote:
> Add support for E31x devices charger which is a sub-device of E31X-PMU.
> Enables query of charger properties from device tree.
>=20
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  drivers/power/supply/Kconfig        |   6 +
>  drivers/power/supply/Makefile       |   1 +
>  drivers/power/supply/e31x-charger.c | 190 ++++++++++++++++++++++++++++
>  include/linux/mfd/e31x-pmu.h        |   4 +
>  4 files changed, 201 insertions(+)
>  create mode 100644 drivers/power/supply/e31x-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..3d043b8fd49c 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,10 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
> =20
> +config E31X_CHARGER
> +	tristate "Ettus Research E31x charger support"
> +	depends on MFD_E31X_PMU
> +	help
> +	 This adds support for the battery charger in Ettus Research E31x PMU.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..6f4f8ca5484e 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> +obj-$(CONFIG_E31X_CHARGER)	+=3D e31x-charger.o
> diff --git a/drivers/power/supply/e31x-charger.c b/drivers/power/supply/e=
31x-charger.c
> new file mode 100644
> index 000000000000..f154482bf95e
> --- /dev/null
> +++ b/drivers/power/supply/e31x-charger.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0

This specifies GPLv2 only, but MODULE_LICENSE("GPL") specifies GPL2
or later. Please fix one of them.

> +/*
> + * Copyright (c) 2018 National Instruments Corp
> + * Author: Virendra Kakade <virendra.kakade@ni.com>
> + *
> + * Ettus Research E31x charger driver
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/power_supply.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/e31x-pmu.h>

Please check the includes. Quite a few seem to be unused.

> +
> +#define E31X_PMU_CHARGER_HEALTH_MASK		GENMASK(1, 0)
> +#define E31X_PMU_CHARGER_HEALTH_SHIFT		0
> +#define E31X_PMU_CHARGER_CHARGE_TYPE_MASK	GENMASK(4, 3)
> +#define E31X_PMU_CHARGER_CHARGE_TYPE_SHIFT	3
> +
> +struct e31x_charger_dev {
> +	struct regmap *regmap;
> +	struct power_supply *supply;
> +};
> +
> +static int e31x_charger_get_health(struct e31x_charger_dev *charger,
> +				   union power_supply_propval *val)
> +{
> +	u32 value;
> +	int err;
> +
> +	err =3D regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
> +	if (err)
> +		return err;
> +
> +	value =3D E31X_PMU_GET_FIELD(CHARGER_HEALTH, value);
> +	switch (value) {
> +	case 0x0:
> +		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x1:
> +		val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +		break;
> +	case 0x2:
> +		val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	case 0x3:
> +		val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		break;
> +	default:
> +		val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	};
> +
> +	return 0;
> +}
> +
> +static int e31x_charger_get_type(struct e31x_charger_dev *charger,
> +				 union power_supply_propval *val)
> +{
> +	u32 value;
> +	int err;
> +
> +	err =3D regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
> +	if (err)
> +		return err;
> +
> +	value =3D E31X_PMU_GET_FIELD(CHARGER_CHARGE_TYPE, value);
> +	switch (value) {
> +	case 0x0:
> +		val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	case 0x1:
> +		val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case 0x2:
> +		val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	default:
> +		val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	};
> +	return 0;
> +}
> +
> +static int e31x_charger_get_online(struct e31x_charger_dev *charger,
> +				   union power_supply_propval *val)
> +{
> +	u32 value;
> +	int err;
> +
> +	err =3D regmap_read(charger->regmap, E31X_PMU_REG_CHARGER, &value);
> +	if (err)
> +		return err;
> +
> +	value =3D E31X_PMU_GET_FIELD(CHARGER_ONLINE, value);
> +	val->intval =3D !!value;
> +
> +	return 0;
> +}
> +
> +static int e31x_charger_get_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +	struct e31x_charger_dev *charger =3D power_supply_get_drvdata(psy);
> +	int err =3D -EINVAL;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		return e31x_charger_get_health(charger, val);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return e31x_charger_get_type(charger, val);
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return e31x_charger_get_online(charger, val);
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static enum power_supply_property e31x_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_SCOPE,
> +};
> +
> +static const struct power_supply_desc e31x_charger_desc =3D {
> +	.name =3D "e31x-charger",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D e31x_charger_properties,
> +	.num_properties =3D ARRAY_SIZE(e31x_charger_properties),
> +	.get_property =3D e31x_charger_get_property,
> +};
> +
> +static const struct of_device_id e31x_charger_id[] =3D {
> +	{ .compatible =3D "ni,e31x-charger" },
> +	{ },
> +};
> +
> +static int e31x_charger_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct e31x_charger_dev *charger;
> +
> +	if (!of_device_is_available(pdev->dev.of_node))
> +		return -ENODEV;
> +
> +	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->regmap =3D syscon_regmap_lookup_by_phandle(\

useless \

> +			pdev->dev.parent->of_node, "regmap");
> +
> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D charger;
> +
> +	charger->supply =3D devm_power_supply_register(&pdev->dev,
> +						     &e31x_charger_desc,
> +						     &psy_cfg);
> +
> +	if (IS_ERR(charger->supply))
> +		return PTR_ERR(charger->supply);
> +	return 0;
> +}
> +
> +static struct platform_driver e31x_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "e31x-charger",
> +		.of_match_table =3D e31x_charger_id,
> +	},
> +	.probe =3D e31x_charger_probe,
> +};
> +module_platform_driver(e31x_charger_driver);
> +
> +MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
> +MODULE_DESCRIPTION("E31x charger driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
> index c57d5a8c1aad..e0649845fe4d 100644
> --- a/include/linux/mfd/e31x-pmu.h
> +++ b/include/linux/mfd/e31x-pmu.h
> @@ -12,9 +12,13 @@
>  #include <linux/bitops.h>
> =20
>  #define E31X_PMU_REG_MISC      0x04
> +#define E31X_PMU_REG_CHARGER   0x0c
> =20
>  #define E31X_PMU_GET_FIELD(name, reg) \
>  	(((reg) & E31X_PMU_## name ##_MASK) >> \
>  	E31X_PMU_## name ##_SHIFT)
> =20
> +#define E31X_PMU_CHARGER_ONLINE_MASK	BIT(2)
> +#define E31X_PMU_CHARGER_ONLINE_SHIFT	2
> +
>  #endif /* MFD_E31X_PMU_H */

Otherwise this looks good.

-- Sebastian

--zju52o37iaea74zq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxjPsUACgkQ2O7X88g7
+pqPdA//UlODPX4uiVWGpoOU2iAxdEDSTzGHW+dHAc/LZ5/v2NeXP588CHR+Zltp
cF1S//KK7Si/59b6xig2/yIi5mr2XKLHZRc6FPGASUBXhg7LbhFbZb5wFmLz9w2V
yyi1DOAiLA1dNVAul1dJMDzOVcGHtLehjMtblvdtIx0MYi8DNcHGXT5r/f3MHeCX
gqgD+4V3QATAXtGCZiKjPX5oVUzsss8+Dy4qVAARRWT70rnWvddhQXAfXMLgH0yb
oyH74eCIhNMIgpVy7tgJeRRwtp6MQn5LCSPyW+Eobxma3IMhWziT94xbhB0LFa7n
swycRFtbFpMDJx/XGE5GFL3UP6PUGTSHqmfL5wrcgT/AheS7Ij8L+DMPptvSGb9h
LxzHOpDHXTugwGUwdUnhOgF1+Lc/+C8dSEmznRjP++RdqSxbHk275hE89RGBcGJ5
SWLzbzVJFpewnTO6CDlm7GBvvw5uMPDKQGnWA0hkoO/Bq5j4lHugGOZ17e5LDB3Q
Un9gvdeiG7bdBzMomK4qfy/1BG8DU7VAVaQPRQmhxWl9xCydQ+8gP1VoU8nYLbCk
bnhSm6mI9rSE5LehoDAV8K9p8D7fiC9O6NVz3VxxTBflIMOoD3qy1HKcL9rkqrd5
3Kt1WdVaCseQO4y31mopMtouS+nOYSprzxlGStVgIdTYjDG7vaY=
=+osu
-----END PGP SIGNATURE-----

--zju52o37iaea74zq--
