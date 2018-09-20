Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B905C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030B22146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030B22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeITGnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:43:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeITGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 02:43:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E3F01263B12
Received: by earth.universe (Postfix, from userid 1000)
        id 0BAB93C0A85; Thu, 20 Sep 2018 03:02:29 +0200 (CEST)
Date:   Thu, 20 Sep 2018 03:02:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, yuanjiang.yu@spreadtrum.com, krzk@kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: Add Spreadtrum SC2731 charger
 support
Message-ID: <20180920010228.nk4mencg6q5t3nlu@earth.universe>
References: <8a8d31119bc723a0012afa8e517015dbba68fee9.1537214465.git.baolin.wang@linaro.org>
 <57bf9920abdcd58b21833105cc7f3a98a3f7d45a.1537214465.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dlgnt7vddiditrxq"
Content-Disposition: inline
In-Reply-To: <57bf9920abdcd58b21833105cc7f3a98a3f7d45a.1537214465.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlgnt7vddiditrxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 01:03:31PM -0700, Baolin Wang wrote:
> This patch adds the SC2731 PMIC switch charger support.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, queued.

-- Sebastian

> Changes from v2:
>  - Add reviewed tag from Krzysztof.
>  - Change current unit to uA instead of mA.
>=20
> Changes from v1:
>  - Remove some redundant head files.
>  - Add one mutex to make sure getting the charger status is correct.
>  - Fix some coding style issues.
>  - Use standard DT properties.
> ---
>  drivers/power/supply/Kconfig          |   7 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/sc2731_charger.c | 504 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 drivers/power/supply/sc2731_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ff6dab0..f27cf07 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -645,4 +645,11 @@ config CHARGER_CROS_USBPD
>  	  what is connected to USB PD ports from the EC and converts
>  	  that into power_supply properties.
> =20
> +config CHARGER_SC2731
> +	tristate "Spreadtrum SC2731 charger driver"
> +	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +	help
> +	 Say Y here to enable support for battery charging with SC2731
> +	 PMIC chips.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a26b402..767105b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -85,3 +85,4 @@ obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
>  obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o
>  obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
> +obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply=
/sc2731_charger.c
> new file mode 100644
> index 0000000..525a820
> --- /dev/null
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Spreadtrum Communications Inc.
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/usb/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +
> +/* PMIC global registers definition */
> +#define SC2731_CHARGE_STATUS		0xedc
> +#define SC2731_CHARGE_FULL		BIT(4)
> +#define SC2731_MODULE_EN1		0xc0c
> +#define SC2731_CHARGE_EN		BIT(5)
> +
> +/* SC2731 switch charger registers definition */
> +#define SC2731_CHG_CFG0			0x0
> +#define SC2731_CHG_CFG1			0x4
> +#define SC2731_CHG_CFG2			0x8
> +#define SC2731_CHG_CFG3			0xc
> +#define SC2731_CHG_CFG4			0x10
> +#define SC2731_CHG_CFG5			0x28
> +
> +/* SC2731_CHG_CFG0 register definition */
> +#define SC2731_PRECHG_RNG_SHIFT		11
> +#define SC2731_PRECHG_RNG_MASK		GENMASK(12, 11)
> +
> +#define SC2731_TERMINATION_VOL_MASK	GENMASK(2, 1)
> +#define SC2731_TERMINATION_VOL_SHIFT	1
> +#define SC2731_TERMINATION_VOL_CAL_MASK	GENMASK(8, 3)
> +#define SC2731_TERMINATION_VOL_CAL_SHIFT	3
> +#define SC2731_TERMINATION_CUR_MASK	GENMASK(2, 0)
> +
> +#define SC2731_CC_EN			BIT(13)
> +#define SC2731_CHARGER_PD		BIT(0)
> +
> +/* SC2731_CHG_CFG1 register definition */
> +#define SC2731_CUR_MASK			GENMASK(5, 0)
> +
> +/* SC2731_CHG_CFG5 register definition */
> +#define SC2731_CUR_LIMIT_SHIFT		8
> +#define SC2731_CUR_LIMIT_MASK		GENMASK(9, 8)
> +
> +/* Default current definition (unit is mA) */
> +#define SC2731_CURRENT_LIMIT_100	100
> +#define SC2731_CURRENT_LIMIT_500	500
> +#define SC2731_CURRENT_LIMIT_900	900
> +#define SC2731_CURRENT_LIMIT_2000	2000
> +#define SC2731_CURRENT_PRECHG		450
> +#define SC2731_CURRENT_STEP		50
> +
> +struct sc2731_charger_info {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct usb_phy *usb_phy;
> +	struct notifier_block usb_notify;
> +	struct power_supply *psy_usb;
> +	struct mutex lock;
> +	bool charging;
> +	u32 base;
> +};
> +
> +static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
> +{
> +	regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +			   SC2731_CC_EN, 0);
> +
> +	regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +			   SC2731_CHARGER_PD, SC2731_CHARGER_PD);
> +}
> +
> +static int sc2731_charger_start_charge(struct sc2731_charger_info *info)
> +{
> +	int ret;
> +
> +	/* Enable charger constant current mode */
> +	ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +				 SC2731_CC_EN, SC2731_CC_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Start charging */
> +	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +				  SC2731_CHARGER_PD, 0);
> +}
> +
> +static int sc2731_charger_set_current_limit(struct sc2731_charger_info *=
info,
> +					    u32 limit)
> +{
> +	u32 val;
> +
> +	if (limit <=3D SC2731_CURRENT_LIMIT_100)
> +		val =3D 0;
> +	else if (limit <=3D SC2731_CURRENT_LIMIT_500)
> +		val =3D 3;
> +	else if (limit <=3D SC2731_CURRENT_LIMIT_900)
> +		val =3D 2;
> +	else
> +		val =3D 1;
> +
> +	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG5,
> +				  SC2731_CUR_LIMIT_MASK,
> +				  val << SC2731_CUR_LIMIT_SHIFT);
> +}
> +
> +static int sc2731_charger_set_current(struct sc2731_charger_info *info, =
u32 cur)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (cur > SC2731_CURRENT_LIMIT_2000)
> +		cur =3D SC2731_CURRENT_LIMIT_2000;
> +	else if (cur < SC2731_CURRENT_PRECHG)
> +		cur =3D SC2731_CURRENT_PRECHG;
> +
> +	/* Calculate the step value, each step is 50 mA */
> +	val =3D (cur - SC2731_CURRENT_PRECHG) / SC2731_CURRENT_STEP;
> +
> +	/* Set pre-charge current as 450 mA */
> +	ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +				 SC2731_PRECHG_RNG_MASK,
> +				 0x3 << SC2731_PRECHG_RNG_SHIFT);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG1,
> +				  SC2731_CUR_MASK, val);
> +}
> +
> +static int sc2731_charger_get_status(struct sc2731_charger_info *info)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, SC2731_CHARGE_STATUS, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & SC2731_CHARGE_FULL)
> +		return POWER_SUPPLY_STATUS_FULL;
> +
> +	return POWER_SUPPLY_STATUS_CHARGING;
> +}
> +
> +static int sc2731_charger_get_current(struct sc2731_charger_info *info,
> +				      u32 *cur)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(info->regmap, info->base + SC2731_CHG_CFG1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &=3D SC2731_CUR_MASK;
> +	*cur =3D val * SC2731_CURRENT_STEP + SC2731_CURRENT_PRECHG;
> +
> +	return 0;
> +}
> +
> +static int sc2731_charger_get_current_limit(struct sc2731_charger_info *=
info,
> +					    u32 *cur)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(info->regmap, info->base + SC2731_CHG_CFG5, &val);
> +	if (ret)
> +		return ret;
> +
> +	val =3D (val & SC2731_CUR_LIMIT_MASK) >> SC2731_CUR_LIMIT_SHIFT;
> +
> +	switch (val) {
> +	case 0:
> +		*cur =3D SC2731_CURRENT_LIMIT_100;
> +		break;
> +
> +	case 1:
> +		*cur =3D SC2731_CURRENT_LIMIT_2000;
> +		break;
> +
> +	case 2:
> +		*cur =3D SC2731_CURRENT_LIMIT_900;
> +		break;
> +
> +	case 3:
> +		*cur =3D SC2731_CURRENT_LIMIT_500;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +sc2731_charger_usb_set_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct sc2731_charger_info *info =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	mutex_lock(&info->lock);
> +
> +	if (!info->charging) {
> +		mutex_unlock(&info->lock);
> +		return -ENODEV;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D sc2731_charger_set_current(info, val->intval / 1000);
> +		if (ret < 0)
> +			dev_err(info->dev, "set charge current failed\n");
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D sc2731_charger_set_current_limit(info,
> +						       val->intval / 1000);
> +		if (ret < 0)
> +			dev_err(info->dev, "set input current limit failed\n");
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	mutex_unlock(&info->lock);
> +	return ret;
> +}
> +
> +static int sc2731_charger_usb_get_property(struct power_supply *psy,
> +					   enum power_supply_property psp,
> +					   union power_supply_propval *val)
> +{
> +	struct sc2731_charger_info *info =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +	u32 cur;
> +
> +	mutex_lock(&info->lock);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (info->charging)
> +			val->intval =3D sc2731_charger_get_status(info);
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		if (!info->charging) {
> +			val->intval =3D 0;
> +		} else {
> +			ret =3D sc2731_charger_get_current(info, &cur);
> +			if (ret)
> +				goto out;
> +
> +			val->intval =3D cur * 1000;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		if (!info->charging) {
> +			val->intval =3D 0;
> +		} else {
> +			ret =3D sc2731_charger_get_current_limit(info, &cur);
> +			if (ret)
> +				goto out;
> +
> +			val->intval =3D cur * 1000;
> +		}
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	mutex_unlock(&info->lock);
> +	return ret;
> +}
> +
> +static int sc2731_charger_property_is_writeable(struct power_supply *psy,
> +						enum power_supply_property psp)
> +{
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D 1;
> +		break;
> +
> +	default:
> +		ret =3D 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static enum power_supply_property sc2731_usb_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
> +static const struct power_supply_desc sc2731_charger_desc =3D {
> +	.name			=3D "sc2731_charger",
> +	.type			=3D POWER_SUPPLY_TYPE_USB,
> +	.properties		=3D sc2731_usb_props,
> +	.num_properties		=3D ARRAY_SIZE(sc2731_usb_props),
> +	.get_property		=3D sc2731_charger_usb_get_property,
> +	.set_property		=3D sc2731_charger_usb_set_property,
> +	.property_is_writeable	=3D sc2731_charger_property_is_writeable,
> +};
> +
> +static int sc2731_charger_usb_change(struct notifier_block *nb,
> +				     unsigned long limit, void *data)
> +{
> +	struct sc2731_charger_info *info =3D
> +		container_of(nb, struct sc2731_charger_info, usb_notify);
> +	int ret =3D 0;
> +
> +	mutex_lock(&info->lock);
> +
> +	if (limit > 0) {
> +		/* set current limitation and start to charge */
> +		ret =3D sc2731_charger_set_current_limit(info, limit);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D sc2731_charger_set_current(info, limit);
> +		if (ret)
> +			goto out;
> +
> +		ret =3D sc2731_charger_start_charge(info);
> +		if (ret)
> +			goto out;
> +
> +		info->charging =3D true;
> +	} else {
> +		/* Stop charging */
> +		info->charging =3D false;
> +		sc2731_charger_stop_charge(info);
> +	}
> +
> +out:
> +	mutex_unlock(&info->lock);
> +	return ret;
> +}
> +
> +static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
> +{
> +	struct power_supply_battery_info bat_info =3D { };
> +	u32 term_currrent, term_voltage, cur_val, vol_val;
> +	int ret;
> +
> +	/* Enable charger module */
> +	ret =3D regmap_update_bits(info->regmap, SC2731_MODULE_EN1,
> +				 SC2731_CHARGE_EN, SC2731_CHARGE_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D power_supply_get_battery_info(info->psy_usb, &bat_info);
> +	if (ret) {
> +		dev_warn(info->dev, "no battery information is supplied\n");
> +
> +		/*
> +		 * If no battery information is supplied, we should set
> +		 * default charge termination current to 120 mA, and default
> +		 * charge termination voltage to 4.35V.
> +		 */
> +		cur_val =3D 0x2;
> +		vol_val =3D 0x1;
> +	} else {
> +		term_currrent =3D bat_info.charge_term_current_ua / 1000;
> +
> +		if (term_currrent <=3D 90)
> +			cur_val =3D 0;
> +		else if (term_currrent >=3D 265)
> +			cur_val =3D 0x7;
> +		else
> +			cur_val =3D ((term_currrent - 90) / 25) + 1;
> +
> +		term_voltage =3D bat_info.constant_charge_voltage_max_uv / 1000;
> +
> +		if (term_voltage > 4500)
> +			term_voltage =3D 4500;
> +
> +		if (term_voltage > 4200)
> +			vol_val =3D (term_voltage - 4200) / 100;
> +		else
> +			vol_val =3D 0;
> +	}
> +
> +	/* Set charge termination current */
> +	ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG2,
> +				 SC2731_TERMINATION_CUR_MASK, cur_val);
> +	if (ret)
> +		goto error;
> +
> +	/* Set charge termination voltage */
> +	ret =3D regmap_update_bits(info->regmap, info->base + SC2731_CHG_CFG0,
> +				 SC2731_TERMINATION_VOL_MASK |
> +				 SC2731_TERMINATION_VOL_CAL_MASK,
> +				 (vol_val << SC2731_TERMINATION_VOL_SHIFT) |
> +				 (0x6 << SC2731_TERMINATION_VOL_CAL_SHIFT));
> +	if (ret)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	regmap_update_bits(info->regmap, SC2731_MODULE_EN1, SC2731_CHARGE_EN, 0=
);
> +	return ret;
> +}
> +
> +static int sc2731_charger_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct sc2731_charger_info *info;
> +	struct power_supply_config charger_cfg =3D { };
> +	int ret;
> +
> +	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	mutex_init(&info->lock);
> +	info->dev =3D &pdev->dev;
> +
> +	info->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!info->regmap) {
> +		dev_err(&pdev->dev, "failed to get charger regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D of_property_read_u32(np, "reg", &info->base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to get register address\n");
> +		return -ENODEV;
> +	}
> +
> +	charger_cfg.drv_data =3D info;
> +	charger_cfg.of_node =3D np;
> +	info->psy_usb =3D devm_power_supply_register(&pdev->dev,
> +						   &sc2731_charger_desc,
> +						   &charger_cfg);
> +	if (IS_ERR(info->psy_usb)) {
> +		dev_err(&pdev->dev, "failed to register power supply\n");
> +		return PTR_ERR(info->psy_usb);
> +	}
> +
> +	ret =3D sc2731_charger_hw_init(info);
> +	if (ret)
> +		return ret;
> +
> +	info->usb_phy =3D devm_usb_get_phy_by_phandle(&pdev->dev, "phys", 0);
> +	if (IS_ERR(info->usb_phy)) {
> +		dev_err(&pdev->dev, "failed to find USB phy\n");
> +		return PTR_ERR(info->usb_phy);
> +	}
> +
> +	info->usb_notify.notifier_call =3D sc2731_charger_usb_change;
> +	ret =3D usb_register_notifier(info->usb_phy, &info->usb_notify);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register notifier: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sc2731_charger_remove(struct platform_device *pdev)
> +{
> +	struct sc2731_charger_info *info =3D platform_get_drvdata(pdev);
> +
> +	usb_unregister_notifier(info->usb_phy, &info->usb_notify);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sc2731_charger_of_match[] =3D {
> +	{ .compatible =3D "sprd,sc2731-charger", },
> +	{ }
> +};
> +
> +static struct platform_driver sc2731_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "sc2731-charger",
> +		.of_match_table =3D sc2731_charger_of_match,
> +	},
> +	.probe =3D sc2731_charger_probe,
> +	.remove =3D sc2731_charger_remove,
> +};
> +
> +module_platform_driver(sc2731_charger_driver);
> +
> +MODULE_DESCRIPTION("Spreadtrum SC2731 Charger Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.9.1
>=20

--dlgnt7vddiditrxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui8aQACgkQ2O7X88g7
+pqPdw/+JTnMvwqRFOyreLxwGnRS8bPibLZImnJxLwHpRZPxRBAzwMxNINCdGcR/
FyOsfFAFvt8rg3EYa9qZls9jTiiMSCmcGTzFZb6tXA5gPeNsiXG2mMHK9IQQvDDO
nAClq9UVDqq+j3a4HYt0OdF4runUvZeAKYfzxPCORIJT1PyogUW6lqnA4K19DbSg
WPuIBOXg3jvpPP5jeElA/l23U0qFYymtCzmkf5KH4rprs/PBb5fCazbxaGrDgGYN
jHjGmujIddDKHvKsdi0C1+cQVrFjU8TlCUehvLwp7slruDFBJMciravdK37GNxGQ
2gmWj8pmgQ5w3z5PHeaUwNQDGG6ZJqA+UiokvsLCClxFHmIToqIbm8pmGWmuyj98
QlNaEA+27MiKlAkeY3tkQ+b+cJSn8zEhv0h/QF6wtZb390bTIptxMN6xFg1744Vw
Yy1OAw3njOhEf+MwyyGlAvblih8VD+uEnI+g0/RW7IIvrUZuk9zFZ3G05OuKOKxE
3QupEYMGpA0qyyqWu6cSccx6PCNdLL4asSG3u9ydt6ZWnGK1S9Ad64brizu3IMMW
KQQCCRfB7RsYcSc+XrcB7Zy33vNRocQYAp4tBbEHxdTjXuzeBm/HKS8RI0mjvf6m
fuvYj8aFth3TZaNqhfCNbjmOzkotila+xk93Av4qUJuas72X2YE=
=oZsn
-----END PGP SIGNATURE-----

--dlgnt7vddiditrxq--
