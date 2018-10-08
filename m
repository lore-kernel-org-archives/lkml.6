Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDEAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61ED20645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61ED20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeJHOyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:54:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33869 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeJHOyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:54:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4D5AC207CC; Mon,  8 Oct 2018 09:44:10 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3A33206A2;
        Mon,  8 Oct 2018 09:44:09 +0200 (CEST)
Date:   Mon, 8 Oct 2018 09:44:09 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] power: supply: add AC power supply driver for
 AXP813
Message-ID: <20181008074409.5g73zrfm6nbn6vpp@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
 <20181006211836.28253-7-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m6savxunrnv5uhcs"
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-7-oskari@lemmela.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m6savxunrnv5uhcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:36AM +0300, Oskari Lemmela wrote:
> AXP813 and AXP803 PMICs can control input current and
> minimum voltage.
>=20
> Both of these values are configurable.
>=20
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  drivers/power/supply/axp20x_ac_power.c | 92 ++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>=20
> diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/suppl=
y/axp20x_ac_power.c
> index 0771f951b11f..92a92354f6f0 100644
> --- a/drivers/power/supply/axp20x_ac_power.c
> +++ b/drivers/power/supply/axp20x_ac_power.c
> @@ -27,6 +27,16 @@
>  #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
>  #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
> =20
> +#define AXP813_VHOLD_MASK		GENMASK(5, 3)
> +#define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
> +#define AXP813_VHOLD_REG_TO_UV(x)	\
> +	(((((x) & AXP813_VHOLD_MASK) >> 3) + 40) * 100000)
> +
> +#define AXP813_CURR_LIMIT_MASK		GENMASK(2, 0)
> +#define AXP813_CURR_LIMIT_UA_TO_BIT(x)	(((x) / 500000) - 3)
> +#define AXP813_CURR_LIMIT_REG_TO_UA(x)	\
> +	((((x) & AXP813_CURR_LIMIT_MASK) + 3) * 500000)
> +
>  #define DRVNAME "axp20x-ac-power-supply"
> =20
>  struct axp20x_ac_power {
> @@ -102,6 +112,55 @@ static int axp20x_ac_power_get_property(struct power=
_supply *psy,
> =20
>  		return 0;
> =20
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_VHOLD_REG_TO_UV(reg);
> +
> +		return 0;
> +
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D regmap_read(power->regmap, AXP813_ACIN_PATH_CTRL, &reg);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D AXP813_CURR_LIMIT_REG_TO_UA(reg);
> +
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int axp20x_ac_power_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{

Argh, missed this one in the first version. Since you're introducing it
with the AXP813 and it isn't used with the AXP20X, I'd name it
axp813_ac_power_set_property. I'll let Maxime or Chen-Yu confirm though.

With the modification in the header from the previous patch in this
patch,

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>

Thanks!
Quentin

--m6savxunrnv5uhcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7CskACgkQhLiadT7g
8aMUHg//RrUQjS7a+hWMfDiWAHIllZpaZuXftDgKPQr21NFxcVm152TCsfgf8Wqr
nykx2jmJ5uooczCqTJLnFOsT2sUwHOc4mSNbSXYg/RXzm/GYPudOnxFW8OTaz+tf
dZ22pXikUJg7DsedEQstG1gwD/13kfJCXkJUyMSm3zqLrngCTibViCL/elhqD/FA
PIuayVMWmscuDcTS5ISoygk9L7XYKQWCRuN5Nb/slxgfeUiaWFnx8s6kXwIDPst+
xffUc3U5s3eWyK0U5U/qiJIhJscquDHYfnGa8XpsZREwqVwNoC0RZg4kpUMRVHXV
Ha6pc6+a/4xZvbC33BuoI/DES0ZiYcv+CidqZdGLAGaeUVIualxxl0Tu3F9tZDJC
OGjvCW1BeLG3s7+SHcnaRm9DRQqIGeHbWmikyTJTjo+F82Uy+WFvz/RGjycTpUkl
OGFP6+g9JWu5/3Fr/urJmA26ZxHflEpw6t1stXcSGnnrG5ov58odYIxWkuH9SnQ8
uWc6u7VIjuEiEi6O2JTJImQLOhb7MUj3M3du+RhsSAg7Q2wZa5ngHx6VvGH9EX+j
Hi2Iy5O6lu2LjXPpaZzG8W0gxACOyYqHKgVIlCvCGilyO/QwCETbS1oFmUC9t4fP
2I0gEnM9rEB7Dhpiw5TBgQ/Su9eZijD4rlP8w4Ge8D3u4xmGMFA=
=pnaj
-----END PGP SIGNATURE-----

--m6savxunrnv5uhcs--
