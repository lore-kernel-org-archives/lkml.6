Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F50C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826BD20652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826BD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeJEP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:27:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34979 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbeJEP1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:27:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3BD77208B7; Fri,  5 Oct 2018 10:29:30 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 485B820DE0;
        Fri,  5 Oct 2018 10:29:13 +0200 (CEST)
Date:   Fri, 5 Oct 2018 10:29:13 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] power: supply: add AXP803/AXP813 AC and battery
 power supply support
Message-ID: <20181005082913.b5pwqa7loyoms2wm@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181004193410.7265-5-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="otdsf6lwwmkmmtep"
Content-Disposition: inline
In-Reply-To: <20181004193410.7265-5-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--otdsf6lwwmkmmtep
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Thu, Oct 04, 2018 at 10:34:10PM +0300, Oskari Lemmela wrote:
> AXP803 PMIC is register compatible with AXP813.
>=20
> Added support for AXP803/AXP813 AC power supply.
> AXP8x3 is capable to limit input current and minimum input voltage.
> Both of these register values are writeable.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/iio/adc/axp20x_adc.c           |   1 +
>  drivers/mfd/axp20x.c                   |  22 ++-
>  drivers/pinctrl/pinctrl-axp209.c       |   1 +
>  drivers/power/supply/axp20x_ac_power.c | 194 +++++++++++++++++++++++++
>  drivers/power/supply/axp20x_battery.c  |   3 +
>  include/linux/mfd/axp20x.h             |   1 +
>  6 files changed, 221 insertions(+), 1 deletion(-)
>=20

We usually want one commit per logical change. e.g. here, we would want
*at least* one commit for the ADC, one for the MFD, one for the pinctrl,
one for the battery, one for the AC.

> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 5be789269353..f919a16a8533 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -641,6 +641,7 @@ static const struct axp_data axp813_data =3D {
>  static const struct of_device_id axp20x_adc_of_match[] =3D {
>  	{ .compatible =3D "x-powers,axp209-adc", .data =3D (void *)&axp20x_data=
, },
>  	{ .compatible =3D "x-powers,axp221-adc", .data =3D (void *)&axp22x_data=
, },
> +	{ .compatible =3D "x-powers,axp803-adc", .data =3D (void *)&axp813_data=
, },
>  	{ .compatible =3D "x-powers,axp813-adc", .data =3D (void *)&axp813_data=
, },
>  	{ /* sentinel */ }
>  };

Then it means AXP813 and AXP803 ADCs are identical. Use the compatible
of the AXP813, no need to add a compatible for each and every PMIC's ADC
that'll be compatible with one that already exists.

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 0be511dd93d0..c540f17549d5 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -731,8 +731,23 @@ static const struct mfd_cell axp803_cells[] =3D {
>  		.name			=3D "axp221-pek",
>  		.num_resources		=3D ARRAY_SIZE(axp803_pek_resources),
>  		.resources		=3D axp803_pek_resources,
> +	}, {
> +		.name			=3D "axp20x-regulator"
> +	}, {
> +		.name			=3D "axp20x-gpio",
> +		.of_compatible		=3D "x-powers,axp803-gpio",
> +	}, {
> +		.name			=3D "axp813-adc",
> +		.of_compatible		=3D "x-powers,axp803-adc",
> +	}, {
> +		.name		=3D "axp20x-battery-power-supply",
> +		.of_compatible	=3D "x-powers,axp803-battery-power-supply",
> +	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp803-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	=3D axp20x_ac_power_supply_resources,
>  	},
> -	{	.name			=3D "axp20x-regulator" },
>  };
> =20
>  static const struct mfd_cell axp806_self_working_cells[] =3D {
> @@ -778,6 +793,11 @@ static const struct mfd_cell axp813_cells[] =3D {
>  	}, {
>  		.name		=3D "axp20x-battery-power-supply",
>  		.of_compatible	=3D "x-powers,axp813-battery-power-supply",
> +	}, {
> +		.name		=3D "axp20x-ac-power-supply",
> +		.of_compatible	=3D "x-powers,axp813-ac-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_ac_power_supply_resources),
> +		.resources	=3D axp20x_ac_power_supply_resources,
>  	},
>  };
> =20
> diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-a=
xp209.c
> index afd0b533c40a..21859579e0a2 100644
> --- a/drivers/pinctrl/pinctrl-axp209.c
> +++ b/drivers/pinctrl/pinctrl-axp209.c
> @@ -387,6 +387,7 @@ static int axp20x_build_funcs_groups(struct platform_=
device *pdev)
> =20
>  static const struct of_device_id axp20x_pctl_match[] =3D {
>  	{ .compatible =3D "x-powers,axp209-gpio", .data =3D &axp20x_data, },
> +	{ .compatible =3D "x-powers,axp803-gpio", .data =3D &axp813_data, },
>  	{ .compatible =3D "x-powers,axp813-gpio", .data =3D &axp813_data, },
>  	{ }
>  };

Same here. No need for a new compatible.

> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/suppl=
y/axp20x_ac_power.c
> index 0771f951b11f..3247efb81cd1 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,23 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
> =20
> +#define AXP8X3_PWR_ACIN_VHOLD		GENMASK(5, 3)

I would add _MASK at the end to be extra explicit.

> +#define AXP8X3_PWR_ACIN_VHOLD_4_0V	(0 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_1V	(1 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_2V	(2 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_3V	(3 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_4V	(4 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_5V	(5 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_6V	(6 << 3)
> +#define AXP8X3_PWR_ACIN_VHOLD_4_7V	(7 << 3)

You could define a macro for that, e.g.:
#define AXP8X3_PWR_ACIN_VHOLD_mV_reg(x)	((((x) - 4000) / 100) << 3)
#define AXP8X3_PWR_ACIN_VHOLD_reg_mV(x)	(((x) >> 3) * 100 + 4000)

> +#define AXP8X3_PWR_ACIN_CURR_LIMIT	GENMASK(2, 0)

I would add _MASK at the end to be extra explicit.

> +#define AXP8X3_PWR_ACIN_CURR_1_5A	0
> +#define AXP8X3_PWR_ACIN_CURR_2_0A	1
> +#define AXP8X3_PWR_ACIN_CURR_2_5A	2
> +#define AXP8X3_PWR_ACIN_CURR_3_0A	3
> +#define AXP8X3_PWR_ACIN_CURR_3_5A	4
> +#define AXP8X3_PWR_ACIN_CURR_4_0A	5
> +

#define AXP8X3_PWR_ACIN_CURR_mA_reg(x)	(((x) / 500) - 3)
#define AXP8X3_PWR_ACIN_CURR_reg_mA(x)	(((x) + 3 ) * 500)

They are not very pretty macro names but I'll let you figure out one
that are easier to understand :)

Also, you might want to use =B5A/=B5V so that it returns directly the value
wanted by the power-supply subsystem.

>  #define DRVNAME "axp20x-ac-power-supply"
> =20
>  struct axp20x_ac_power {
> @@ -102,6 +119,72 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
> =20
>  		return 0;
> =20
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret =3D regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +

val->intval =3D AXP8X3_PWR_ACIN_VHOLD_reg_mV(reg & AXP8X3_PWR_ACIN_VHOLD) *=
 1000;

return 0;

> +		switch (reg & AXP8X3_PWR_ACIN_VHOLD) {
> +		case AXP8X3_PWR_ACIN_VHOLD_4_0V:
> +			val->intval =3D 4000000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_1V:
> +			val->intval =3D 4100000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_2V:
> +			val->intval =3D 4200000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_3V:
> +			val->intval =3D 4300000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_4V:
> +			val->intval =3D 4400000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_5V:
> +			val->intval =3D 4500000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_6V:
> +			val->intval =3D 4600000;
> +			break;
> +		case AXP8X3_PWR_ACIN_VHOLD_4_7V:
> +			val->intval =3D 4700000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D regmap_read(power->regmap, AXP803_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +

val->intval =3D AXP8X3_PWR_ACIN_CURR_reg_mA(reg & AXP8X3_PWR_ACIN_CURR_LIMI=
T) * 1000;

return 0;

> +		switch (reg & AXP8X3_PWR_ACIN_CURR_LIMIT) {
> +		case AXP8X3_PWR_ACIN_CURR_1_5A:
> +			val->intval =3D 1500000;
> +			break;
> +		case AXP8X3_PWR_ACIN_CURR_2_0A:
> +			val->intval =3D 2000000;
> +			break;
> +		case AXP8X3_PWR_ACIN_CURR_2_5A:
> +			val->intval =3D 2500000;
> +			break;
> +		case AXP8X3_PWR_ACIN_CURR_3_0A:
> +			val->intval =3D 3000000;
> +			break;
> +		case AXP8X3_PWR_ACIN_CURR_3_5A:
> +			val->intval =3D 3500000;
> +			break;
> +		case AXP8X3_PWR_ACIN_CURR_4_0A:
> +			val->intval =3D 4000000;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -109,6 +192,88 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
>  	return -EINVAL;
>  }
> =20
> +static int axp20x_ac_power_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct axp20x_ac_power *power =3D power_supply_get_drvdata(psy);
> +	int setval;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		switch (val->intval) {
> +		case 4000000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_0V;
> +			break;
> +		case 4100000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_1V;
> +			break;
> +		case 4200000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_2V;
> +			break;
> +		case 4300000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_3V;
> +			break;
> +		case 4400000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_4V;
> +			break;
> +		case 4500000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_5V;
> +			break;
> +		case 4600000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_6V;
> +			break;
> +		case 4700000:
> +			setval =3D AXP8X3_PWR_ACIN_VHOLD_4_7V;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
> +					  AXP8X3_PWR_ACIN_VHOLD, setval);
> +

return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
			  AXP8X3_PWR_ACIN_VHOLD,
			  AXP8X3_PWR_ACIN_VHOLD_mV_reg(val->intval / 1000));

> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +
> +		switch (val->intval) {
> +		case 1500000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_1_5A;
> +			break;
> +		case 2000000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_2_0A;
> +			break;
> +		case 2500000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_2_5A;
> +			break;
> +		case 3000000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_3_0A;
> +			break;
> +		case 3500000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_3_5A;
> +			break;
> +		case 4000000:
> +			setval =3D AXP8X3_PWR_ACIN_CURR_4_0A;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
> +					  AXP8X3_PWR_ACIN_CURR_LIMIT, setval);
return regmap_update_bits(power->regmap, AXP803_ACIN_PATH_CTRL,
			  AXP8X3_PWR_ACIN_CURR_LIMIT,
			  AXP8X3_PWR_ACIN_CURR_LIMIT_mA_reg(val->intval / 1000));
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axp20x_ac_power_prop_writeable(struct power_supply *psy,
> +					  enum power_supply_property psp)
> +{
> +	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> +	       psp =3D=3D POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
> +}
> +
>  static enum power_supply_property axp20x_ac_power_properties[] =3D {
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_PRESENT,
> @@ -123,6 +288,14 @@ static enum power_supply_property axp22x_ac_power_pr=
operties[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  };
> =20
> +static enum power_supply_property axp8x3_ac_power_properties[] =3D {

I'll let Maxime or Chen-Yu confirm but I think we use the name of the
first PMIC in the family, so it would be axp813_ac_power_properties
even if it applies to multiple variants of the PMIC.

> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
>  static const struct power_supply_desc axp20x_ac_power_desc =3D {
>  	.name =3D "axp20x-ac",
>  	.type =3D POWER_SUPPLY_TYPE_MAINS,
> @@ -139,6 +312,16 @@ static const struct power_supply_desc axp22x_ac_powe=
r_desc =3D {
>  	.get_property =3D axp20x_ac_power_get_property,
>  };
> =20
> +static const struct power_supply_desc axp8x3_ac_power_desc =3D {
> +	.name =3D "axp8x3-ac",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D axp8x3_ac_power_properties,
> +	.num_properties =3D ARRAY_SIZE(axp8x3_ac_power_properties),

Naming convention here for the above.

> +	.property_is_writeable =3D axp20x_ac_power_prop_writeable,

I think we would want axp813_ac_power_prop_writeable if it's applicable
only for the AXP813 and not the AXP20X.

> +	.get_property =3D axp20x_ac_power_get_property,
> +	.set_property =3D axp20x_ac_power_set_property,
> +};
> +
>  struct axp_data {
>  	const struct power_supply_desc	*power_desc;
>  	bool				acin_adc;
> @@ -154,6 +337,11 @@ static const struct axp_data axp22x_data =3D {
>  	.acin_adc =3D false,
>  };
> =20
> +static const struct axp_data axp8x3_data =3D {
> +	.power_desc =3D &axp8x3_ac_power_desc,
> +	.acin_adc =3D false,
> +};
> +
>  static int axp20x_ac_power_probe(struct platform_device *pdev)
>  {
>  	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> @@ -234,6 +422,12 @@ static const struct of_device_id axp20x_ac_power_mat=
ch[] =3D {
>  	}, {
>  		.compatible =3D "x-powers,axp221-ac-power-supply",
>  		.data =3D &axp22x_data,
> +	}, {
> +		.compatible =3D "x-powers,axp803-ac-power-supply",
> +		.data =3D &axp8x3_data,
> +	}, {
> +		.compatible =3D "x-powers,axp813-ac-power-supply",
> +		.data =3D &axp8x3_data,

So AXP813 and AXP803 AC drivers are identical, use the same compatible,
no need to add two.

>  	}, { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index e84b6e4da14a..932027f4a993 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -537,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id=
[] =3D {
>  	}, {
>  		.compatible =3D "x-powers,axp221-battery-power-supply",
>  		.data =3D (void *)&axp221_data,
> +	}, {
> +		.compatible =3D "x-powers,axp803-battery-power-supply",
> +		.data =3D (void *)&axp813_data,

Ditto.

>  	}, {
>  		.compatible =3D "x-powers,axp813-battery-power-supply",
>  		.data =3D (void *)&axp813_data,
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 517e60eecbcb..23d58e243d01 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -266,6 +266,7 @@ enum axp20x_variants {
>  #define AXP288_RT_BATT_V_H		0xa0
>  #define AXP288_RT_BATT_V_L		0xa1
> =20
> +#define AXP803_ACIN_PATH_CTRL		0x3a
>  #define AXP813_ADC_RATE			0x85
> =20

Basically, the only changes you need to keep are those in
drivers/power/supply/axp20x_ac_power.c and include/linux/mfd/axp20x.h.

Thanks,
Quentin

--otdsf6lwwmkmmtep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu3INgACgkQhLiadT7g
8aM2OxAAimSccnw0cctvqTZ+4EN4FxfjCmuwtVfAkcBYcPiEnpmsElUUyQ5cClPb
DEtePtIHOTiwiK1d1OeWete4mJpk0wBsawZhdaoFIz82wml9q7r5LZDpzGHGF4tJ
Vw8rsu0B3bvAS4oqEVZ87JNyNxsc8jQmSAkz92FMqQ1tRCM9x/xKPwm+SImlRip6
5n4DcGTSzvsmeITUrUtYbgF/xb7Y9EVy0w7GKFTXGuxxk1gRIHDJXRjj9vsK8Igf
FAC/kL/QkQjnTFcON8rTLeixoZhN/dUz4RaKeXC04ARf/z+vC3obHk6CK6mnHzoV
VNO54dltTNdvvJLnmZymkrOfgLKgm4ST10Iwi/pCWaheKS1ntIGbwl8GvWa5cVip
HfvD76WYG5KcoRJWnJI1F0brlNBgtu0cfGFVeYDnxBuUvz5gWpLNo2js6qvfSm5k
OruxX5/VTPwr6YOZ+nwVWufYIHLU/j7th8n/dhlnt6DjBTfAsLrr0jzV5aKRufYj
JJdt0vLPIxJGTkS6RtTChQ7HfcJRiu1gL22qk6ybram8TkjLxLmBPip9HoPf4n6m
J79XUxZa7FzNeJngTcfHyxrJZ8x7mOAOkPQoRlDD8SS/vYFDBvRfhpMNBO4sWw3y
dqk1m1K/Hdp9SzhvOm2EcBkYgQR0QCGUUuSpSBBypgB1qNmFKMg=
=4ApI
-----END PGP SIGNATURE-----

--otdsf6lwwmkmmtep--
