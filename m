Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCIQIa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:08:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCIQI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:08:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935AB20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Mar 2018 17:08:25 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 3/6] power: supply: axp20x_battery: use data struct
 for variant specific code
Message-ID: <20180309160825.fde2am6jo6qs6vp6@earth.universe>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <c157320cf4c443e6904346c9072f46e713498161.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ph74mhtynjdkcjwp"
Content-Disposition: inline
In-Reply-To: <c157320cf4c443e6904346c9072f46e713498161.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ph74mhtynjdkcjwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

On Wed, Feb 28, 2018 at 11:35:58AM +0100, Quentin Schulz wrote:
> We used to use IDs to select a function or a feature depending on the
> variant. It's easier to maintain the code by adding data structure
> storing the few differences between variants so that we don't add a pile
> of if conditions.
>=20
> Let's use this data structure and update the code to use it.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---

I applied this, but modified the patch slightly, so that
it actually calls your new set_max_voltage() callback in
axp20x_battery_set_prop(). Please check that the resulting
patch looks correct to you:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/=
commit/?h=3Dfor-next&id=3D648badd797c762a713b48afc3b67d56abdd0073b

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 100 +++++++++++++++++----------
>  1 file changed, 66 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 7494f0f..04a0d91 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -53,6 +53,16 @@
> =20
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> =20
> +struct axp20x_batt_ps;
> +
> +struct axp_data {
> +	int	ccc_scale;
> +	int	ccc_offset;
> +	bool	has_fg_valid;
> +	int	(*get_max_voltage)(struct axp20x_batt_ps *batt, int *val);
> +	int	(*set_max_voltage)(struct axp20x_batt_ps *batt, int val);
> +};
> +
>  struct axp20x_batt_ps {
>  	struct regmap *regmap;
>  	struct power_supply *batt;
> @@ -62,7 +72,7 @@ struct axp20x_batt_ps {
>  	struct iio_channel *batt_v;
>  	/* Maximum constant charge current */
>  	unsigned int max_ccc;
> -	u8 axp_id;
> +	const struct axp_data	*data;
>  };
> =20
>  static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> @@ -123,22 +133,6 @@ static int axp22x_battery_get_max_voltage(struct axp=
20x_batt_ps *axp20x_batt,
>  	return 0;
>  }
> =20
> -static void raw_to_constant_charge_current(struct axp20x_batt_ps *axp, i=
nt *val)
> -{
> -	if (axp->axp_id =3D=3D AXP209_ID)
> -		*val =3D *val * 100000 + 300000;
> -	else
> -		*val =3D *val * 150000 + 300000;
> -}
> -
> -static void constant_charge_current_to_raw(struct axp20x_batt_ps *axp, i=
nt *val)
> -{
> -	if (axp->axp_id =3D=3D AXP209_ID)
> -		*val =3D (*val - 300000) / 100000;
> -	else
> -		*val =3D (*val - 300000) / 150000;
> -}
> -
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  					      int *val)
>  {
> @@ -150,7 +144,7 @@ static int axp20x_get_constant_charge_current(struct =
axp20x_batt_ps *axp,
> =20
>  	*val &=3D AXP20X_CHRG_CTRL1_TGT_CURR;
> =20
> -	raw_to_constant_charge_current(axp, val);
> +	*val =3D *val * axp->data->ccc_scale + axp->data->ccc_offset;
> =20
>  	return 0;
>  }
> @@ -269,8 +263,7 @@ static int axp20x_battery_get_prop(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		if (axp20x_batt->axp_id =3D=3D AXP221_ID &&
> -		    !(reg & AXP22X_FG_VALID))
> +		if (axp20x_batt->data->has_fg_valid && !(reg & AXP22X_FG_VALID))
>  			return -EINVAL;
> =20
>  		/*
> @@ -281,11 +274,8 @@ static int axp20x_battery_get_prop(struct power_supp=
ly *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -		if (axp20x_batt->axp_id =3D=3D AXP209_ID)
> -			return axp20x_battery_get_max_voltage(axp20x_batt,
> -							      &val->intval);
> -		return axp22x_battery_get_max_voltage(axp20x_batt,
> -						      &val->intval);
> +		return axp20x_batt->data->get_max_voltage(axp20x_batt,
> +							  &val->intval);
>
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
> @@ -312,6 +302,32 @@ static int axp20x_battery_get_prop(struct power_supp=
ly *psy,
>  	return 0;
>  }
> =20
> +static int axp22x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> +					  int val)
> +{
> +	switch (val) {
> +	case 4100000:
> +		val =3D AXP20X_CHRG_CTRL1_TGT_4_1V;
> +		break;
> +
> +	case 4200000:
> +		val =3D AXP20X_CHRG_CTRL1_TGT_4_2V;
> +		break;
> +
> +	default:
> +		/*
> +		 * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
> +		 * can be set to 4.22V and 4.24V, but these voltages are too
> +		 * high for Lithium based batteries (AXP PMICs are supposed to
> +		 * be used with these kinds of battery).
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> +				  AXP20X_CHRG_CTRL1_TGT_VOLT, val);
> +}
> +
>  static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
>  					  int val)
>  {
> @@ -321,9 +337,6 @@ static int axp20x_battery_set_max_voltage(struct axp2=
0x_batt_ps *axp20x_batt,
>  		break;
> =20
>  	case 4150000:
> -		if (axp20x_batt->axp_id =3D=3D AXP221_ID)
> -			return -EINVAL;
> -
>  		val =3D AXP20X_CHRG_CTRL1_TGT_4_15V;
>  		break;
> =20
> @@ -351,7 +364,8 @@ static int axp20x_set_constant_charge_current(struct =
axp20x_batt_ps *axp_batt,
>  	if (charge_current > axp_batt->max_ccc)
>  		return -EINVAL;
> =20
> -	constant_charge_current_to_raw(axp_batt, &charge_current);
> +	charge_current =3D (charge_current - axp_batt->data->ccc_offset) /
> +		axp_batt->data->ccc_scale;
> =20
>  	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>  		return -EINVAL;
> @@ -365,12 +379,14 @@ static int axp20x_set_max_constant_charge_current(s=
truct axp20x_batt_ps *axp,
>  {
>  	bool lower_max =3D false;
> =20
> -	constant_charge_current_to_raw(axp, &charge_current);
> +	charge_current =3D (charge_current - axp->data->ccc_offset) /
> +		axp->data->ccc_scale;
> =20
>  	if (charge_current > AXP20X_CHRG_CTRL1_TGT_CURR || charge_current < 0)
>  		return -EINVAL;
> =20
> -	raw_to_constant_charge_current(axp, &charge_current);
> +	charge_current =3D charge_current * axp->data->ccc_scale +
> +		axp->data->ccc_offset;
> =20
>  	if (charge_current > axp->max_ccc)
>  		dev_warn(axp->dev,
> @@ -460,13 +476,28 @@ static const struct power_supply_desc axp20x_batt_p=
s_desc =3D {
>  	.set_property =3D axp20x_battery_set_prop,
>  };
> =20
> +static const struct axp_data axp209_data =3D {
> +	.ccc_scale =3D 100000,
> +	.ccc_offset =3D 300000,
> +	.get_max_voltage =3D axp20x_battery_get_max_voltage,
> +	.set_max_voltage =3D axp20x_battery_set_max_voltage,
> +};
> +
> +static const struct axp_data axp221_data =3D {
> +	.ccc_scale =3D 150000,
> +	.ccc_offset =3D 300000,
> +	.has_fg_valid =3D true,
> +	.get_max_voltage =3D axp22x_battery_get_max_voltage,
> +	.set_max_voltage =3D axp22x_battery_set_max_voltage,
> +};
> +
>  static const struct of_device_id axp20x_battery_ps_id[] =3D {
>  	{
>  		.compatible =3D "x-powers,axp209-battery-power-supply",
> -		.data =3D (void *)AXP209_ID,
> +		.data =3D (void *)&axp209_data,
>  	}, {
>  		.compatible =3D "x-powers,axp221-battery-power-supply",
> -		.data =3D (void *)AXP221_ID,
> +		.data =3D (void *)&axp221_data,
>  	}, { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> @@ -476,6 +507,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  	struct axp20x_batt_ps *axp20x_batt;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct power_supply_battery_info info;
> +	struct device *dev =3D &pdev->dev;
> =20
>  	if (!of_device_is_available(pdev->dev.of_node))
>  		return -ENODEV;
> @@ -516,7 +548,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  	psy_cfg.drv_data =3D axp20x_batt;
>  	psy_cfg.of_node =3D pdev->dev.of_node;
> =20
> -	axp20x_batt->axp_id =3D (uintptr_t)of_device_get_match_data(&pdev->dev);
> +	axp20x_batt->data =3D (struct axp_data *)of_device_get_match_data(dev);
> =20
>  	axp20x_batt->batt =3D devm_power_supply_register(&pdev->dev,
>  						       &axp20x_batt_ps_desc,
> --=20
> git-series 0.9.1

--ph74mhtynjdkcjwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqisXgACgkQ2O7X88g7
+ppnZBAAj1Xa4HotRQ0JdEC46L37aPp0eEROa2SlJgle9SI7sgqK32LDwVEsYInu
SN89TsUKYTpMmkNO5Wt3M8XUbD99yfsgsZ7u0j4S+j4bu1NMGf6h+xKpKgxBqULI
kkpvMGCedXqvN6aCOJD1/LBRNJWhPWDwttJZd9OWLjIK0kXZEVZIuhGph0Ol2G6K
h0xGHnlD4NYBCucw1nL90IkNC7kVAv9BfmwcgLfQ4Liki9GWbIG1BCiqao40x2Bd
OQzvTOAimUaiEI9wqUi0x/je/Z1zlFxAwqEJlQyoYd5MmEIO3lAITh7ELReOBm9b
+ecY0WOAqnMxSAy8XiQG1IJYaLkIb9fNjbffBs/R5a90jALZgtg3SK8ljIUUYD61
mm4SoegfMH1iuSEaLJ1LsBUGnBuSfvhRFq8AKixvdAA/pdCPcTTw/4/zcmCsXI/A
vMNusFks/D+hqQIU5kw/GSUYIH+pvxCHrdqxXTF/jaxI3sntwgwMGbKjPjt9w//A
4JK5lmZWdmNtgs4Cl8TSVJm2iv0ZswtSczUODCwpDN6LK2OZdnp3I+vW6WmgfFoI
qqiGoyDcsFB6rgLOeWVc7n76XgFcsB0aUDqqKfEt7QnpdHsQsLskoLbT1+RBvtWl
whtQiCP5I4qzVCdUOGByP4UkcYhg9zJ+QQR5FI6EFrrOFXztjDs=
=4uJA
-----END PGP SIGNATURE-----

--ph74mhtynjdkcjwp--
