Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeCIQJr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCIQJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:09:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5500720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Fri, 9 Mar 2018 17:09:42 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 5/6] power: supply: axp20x_battery: add support for
 AXP813
Message-ID: <20180309160942.fp6vrjnvis3kiarb@earth.universe>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
 <3969fa859a80afba1fe3c9b71cf3147111582520.1519813976.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftaiz767pliwrnwg"
Content-Disposition: inline
In-Reply-To: <3969fa859a80afba1fe3c9b71cf3147111582520.1519813976.git-series.quentin.schulz@bootlin.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftaiz767pliwrnwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2018 at 11:36:00AM +0100, Quentin Schulz wrote:
> The X-Powers AXP813 PMIC has got some slight differences from
> AXP20X/AXP22X PMICs:
>  - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
>  for AXP20X/AXP22X,
>  - the constant charge current formula is different,
>=20
> It also has a bit to tell whether the battery percentage returned by the
> PMIC is valid.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 04a0d91..4f69c0e 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -49,6 +49,8 @@
>  #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
>  #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
> =20
> +#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
> +
>  #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
> =20
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> @@ -133,6 +135,35 @@ static int axp22x_battery_get_max_voltage(struct axp=
20x_batt_ps *axp20x_batt,
>  	return 0;
>  }
> =20
> +static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
> +					  int *val)
> +{
> +	int ret, reg;
> +
> +	ret =3D regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> +	case AXP20X_CHRG_CTRL1_TGT_4_1V:
> +		*val =3D 4100000;
> +		break;
> +	case AXP20X_CHRG_CTRL1_TGT_4_15V:
> +		*val =3D 4150000;
> +		break;
> +	case AXP20X_CHRG_CTRL1_TGT_4_2V:
> +		*val =3D 4200000;
> +		break;
> +	case AXP813_CHRG_CTRL1_TGT_4_35V:
> +		*val =3D 4350000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
>  					      int *val)
>  {
> @@ -491,6 +522,14 @@ static const struct axp_data axp221_data =3D {
>  	.set_max_voltage =3D axp22x_battery_set_max_voltage,
>  };
> =20
> +static const struct axp_data axp813_data =3D {
> +	.ccc_scale =3D 200000,
> +	.ccc_offset =3D 200000,
> +	.has_fg_valid =3D true,
> +	.get_max_voltage =3D axp813_battery_get_max_voltage,
> +	.set_max_voltage =3D axp20x_battery_set_max_voltage,
> +};
> +
>  static const struct of_device_id axp20x_battery_ps_id[] =3D {
>  	{
>  		.compatible =3D "x-powers,axp209-battery-power-supply",
> @@ -498,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id=
[] =3D {
>  	}, {
>  		.compatible =3D "x-powers,axp221-battery-power-supply",
>  		.data =3D (void *)&axp221_data,
> +	}, {
> +		.compatible =3D "x-powers,axp813-battery-power-supply",
> +		.data =3D (void *)&axp813_data,
>  	}, { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> --=20
> git-series 0.9.1

--ftaiz767pliwrnwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqiscMACgkQ2O7X88g7
+poD2A/+L0oQNjidAEFADiNl9pka3D7rFXw3uXnQ/LG7rkuT6fle79atdUX4b/P4
XSBygpz/Jxxnz/TecJXG7JPULt6fws185TIuJNEJhOlJvg5wQxZLVCceZMCcY7Dv
+Pzai9iEhM41XPOZJhLK98ux1va/A+/cgX79NuL8NaW4UkjvvwJ18lmsmPLZJnPB
0hSXfZuA3wYn3HZhV967gZxpfeuwGrxxpODUzUWM2w5ELj9qD4eXtawZ9wdGgSmK
Wum39waFC95vEbTx0ky3g3VTlqVimUw38IFj6zS85bcGLnRF8bAN2AfDcwOy3/B7
vaHT/+4Keexwd8iRv7MDK9awgHdE5HmpgzUL7TChhgUzOcUHqzi5IfNFT1wG8wSt
SlLo7YTjsQNrChGzeU7V9+7t2W0VIzIt4qf3A5pHCuSbC402FyM0dGHmYs3p1muE
p2KahiZYIkWCwnU1j8Vqe9m+VrFigMdPr4QnlB5+qGnYsDy5856ggzFKCm/Zdfwf
McBLv18CwUbXUEKdg1ToyapMy1VcDTKVuo88C0nTPMKhY3H2AoTB3kh2x+Uk+kQW
IHPn+dDixrXhL56ERcyFJL71h/odNNgxM7pyYtdb1i0tNSPPADqHAllPzkzyHKDi
C33CfE5n9u3Hl1Gbzx9/59oDjB487Q/u5so+VqGvlXJq0HdtQuY=
=gSpD
-----END PGP SIGNATURE-----

--ftaiz767pliwrnwg--
