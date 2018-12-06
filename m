Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03033C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB43120838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB43120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeLFV6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:58:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLFV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:58:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0EAAD260441
Received: by earth.universe (Postfix, from userid 1000)
        id 47FE93C08D6; Thu,  6 Dec 2018 22:58:29 +0100 (CET)
Date:   Thu, 6 Dec 2018 22:58:29 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v2] power: supply: sc27xx: Save last battery capacity
Message-ID: <20181206215829.kmykasyp2nurwpkt@earth.universe>
References: <271ebbae85bc544cbcb6925a10de30267f8eb3ee.1544066225.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bdvnz5ydqusftk5f"
Content-Disposition: inline
In-Reply-To: <271ebbae85bc544cbcb6925a10de30267f8eb3ee.1544066225.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bdvnz5ydqusftk5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2018 at 11:20:39AM +0800, Baolin Wang wrote:
> From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>=20
> Our charger manager can optimize the battery capacity periodically, so
> we can save last battery capacity into registers. Then next system
> power-on, we can read the last saved battery capacity as the initial
> battery capacity, which can make the battery capacity more accurate.
>=20
> Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

> Changes from v1:
>  - Simplify the logics for sc27xx_fgu_set_property() and
>    sc27xx_fgu_property_is_writeable().
> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c |  135 ++++++++++++++++++++++++=
+++++-
>  1 file changed, 134 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index 8c52e29..76da189 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -39,6 +39,9 @@
>  #define SC27XX_FGU_CLBCNT_VALH		0x68
>  #define SC27XX_FGU_CLBCNT_VALL		0x6c
>  #define SC27XX_FGU_CLBCNT_QMAXL		0x74
> +#define SC27XX_FGU_USER_AREA_SET	0xa0
> +#define SC27XX_FGU_USER_AREA_CLEAR	0xa4
> +#define SC27XX_FGU_USER_AREA_STATUS	0xa8
> =20
>  #define SC27XX_WRITE_SELCLB_EN		BIT(0)
>  #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
> @@ -49,6 +52,14 @@
>  #define SC27XX_FGU_LOW_OVERLOAD_INT	BIT(0)
>  #define SC27XX_FGU_CLBCNT_DELTA_INT	BIT(2)
> =20
> +#define SC27XX_FGU_MODE_AREA_MASK	GENMASK(15, 12)
> +#define SC27XX_FGU_CAP_AREA_MASK	GENMASK(11, 0)
> +#define SC27XX_FGU_MODE_AREA_SHIFT	12
> +
> +#define SC27XX_FGU_FIRST_POWERTON	GENMASK(3, 0)
> +#define SC27XX_FGU_DEFAULT_CAP		GENMASK(11, 0)
> +#define SC27XX_FGU_NORMAIL_POWERTON	0x5
> +
>  #define SC27XX_FGU_CUR_BASIC_ADC	8192
>  #define SC27XX_FGU_SAMPLE_HZ		2
> =20
> @@ -119,6 +130,80 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_f=
gu_data *data, int vol)
>  	return DIV_ROUND_CLOSEST(vol * data->vol_1000mv_adc, 1000);
>  }
> =20
> +static bool sc27xx_fgu_is_first_poweron(struct sc27xx_fgu_data *data)
> +{
> +	int ret, status, cap, mode;
> +
> +	ret =3D regmap_read(data->regmap,
> +			  data->base + SC27XX_FGU_USER_AREA_STATUS, &status);
> +	if (ret)
> +		return false;
> +
> +	/*
> +	 * We use low 4 bits to save the last battery capacity and high 12 bits
> +	 * to save the system boot mode.
> +	 */
> +	mode =3D (status & SC27XX_FGU_MODE_AREA_MASK) >> SC27XX_FGU_MODE_AREA_S=
HIFT;
> +	cap =3D status & SC27XX_FGU_CAP_AREA_MASK;
> +
> +	/*
> +	 * When FGU has been powered down, the user area registers became
> +	 * default value (0xffff), which can be used to valid if the system is
> +	 * first power on or not.
> +	 */
> +	if (mode =3D=3D SC27XX_FGU_FIRST_POWERTON || cap =3D=3D SC27XX_FGU_DEFA=
ULT_CAP)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int sc27xx_fgu_save_boot_mode(struct sc27xx_fgu_data *data,
> +				     int boot_mode)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(data->regmap,
> +				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
> +				 SC27XX_FGU_MODE_AREA_MASK,
> +				 SC27XX_FGU_MODE_AREA_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap,
> +				  data->base + SC27XX_FGU_USER_AREA_SET,
> +				  SC27XX_FGU_MODE_AREA_MASK,
> +				  boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
> +}
> +
> +static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int ca=
p)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(data->regmap,
> +				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
> +				 SC27XX_FGU_CAP_AREA_MASK,
> +				 SC27XX_FGU_CAP_AREA_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap,
> +				  data->base + SC27XX_FGU_USER_AREA_SET,
> +				  SC27XX_FGU_CAP_AREA_MASK, cap);
> +}
> +
> +static int sc27xx_fgu_read_last_cap(struct sc27xx_fgu_data *data, int *c=
ap)
> +{
> +	int ret, value;
> +
> +	ret =3D regmap_read(data->regmap,
> +			  data->base + SC27XX_FGU_USER_AREA_STATUS, &value);
> +	if (ret)
> +		return ret;
> +
> +	*cap =3D value & SC27XX_FGU_CAP_AREA_MASK;
> +	return 0;
> +}
> +
>  /*
>   * When system boots on, we can not read battery capacity from coulomb
>   * registers, since now the coulomb registers are invalid. So we should
> @@ -128,6 +213,20 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_f=
gu_data *data, int vol)
>  static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, in=
t *cap)
>  {
>  	int volt, cur, oci, ocv, ret;
> +	bool is_first_poweron =3D sc27xx_fgu_is_first_poweron(data);
> +
> +	/*
> +	 * If system is not the first power on, we should use the last saved
> +	 * battery capacity as the initial battery capacity. Otherwise we should
> +	 * re-calculate the initial battery capacity.
> +	 */
> +	if (!is_first_poweron) {
> +		ret =3D sc27xx_fgu_read_last_cap(data, cap);
> +		if (ret)
> +			return ret;
> +
> +		return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
> +	}
> =20
>  	/*
>  	 * After system booting on, the SC27XX_FGU_CLBCNT_QMAXL register saved
> @@ -160,7 +259,11 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27x=
x_fgu_data *data, int *cap)
>  	*cap =3D power_supply_ocv2cap_simple(data->cap_table, data->table_len,
>  					   ocv);
> =20
> -	return 0;
> +	ret =3D sc27xx_fgu_save_last_cap(data, *cap);
> +	if (ret)
> +		return ret;
> +
> +	return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
>  }
> =20
>  static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcn=
t)
> @@ -418,6 +521,28 @@ static int sc27xx_fgu_get_property(struct power_supp=
ly *psy,
>  	return ret;
>  }
> =20
> +static int sc27xx_fgu_set_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	if (psp !=3D POWER_SUPPLY_PROP_CAPACITY)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D sc27xx_fgu_save_last_cap(data, val->intval);
> +
> +	mutex_unlock(&data->lock);
> +
> +	if (ret < 0)
> +		dev_err(data->dev, "failed to save battery capacity\n");
> +
> +	return ret;
> +}
> +
>  static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
>  {
>  	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> @@ -425,6 +550,12 @@ static void sc27xx_fgu_external_power_changed(struct=
 power_supply *psy)
>  	power_supply_changed(data->battery);
>  }
> =20
> +static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
> +					    enum power_supply_property psp)
> +{
> +	return psp =3D=3D POWER_SUPPLY_PROP_CAPACITY;
> +}
> +
>  static enum power_supply_property sc27xx_fgu_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_HEALTH,
> @@ -444,7 +575,9 @@ static void sc27xx_fgu_external_power_changed(struct =
power_supply *psy)
>  	.properties		=3D sc27xx_fgu_props,
>  	.num_properties		=3D ARRAY_SIZE(sc27xx_fgu_props),
>  	.get_property		=3D sc27xx_fgu_get_property,
> +	.set_property		=3D sc27xx_fgu_set_property,
>  	.external_power_changed	=3D sc27xx_fgu_external_power_changed,
> +	.property_is_writeable	=3D sc27xx_fgu_property_is_writeable,
>  };
> =20
>  static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
> --=20
> 1.7.9.5
>=20

--bdvnz5ydqusftk5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwJm4EACgkQ2O7X88g7
+pqsTg//XzERU0vsmHPaaLAxmwNTJp1eqW/ZCnKLDwARY6I8W1+X5Ujz3w88RcNA
BWgKjXJSsQKFWkPch/QlI+iYS8NwDRfx1puB/MNEV5LHl8zISOxx01gnAGFo3jio
EknFjvsphZcKtGCO63EpERJD0GsPsTxM5nFwrO5yg5hAeg7m8wPH+38pKZMmTbRv
9PZx3lmDuIxc3awTIDVahN1zrsDxak+BEs7mDTxpnwaoAWoyHL8xLgHRioHozU6D
w4+92KJtwuESvm0W3x1IKjmrH7nYuoIuvt5DNy3CfnZD5+FERcsY6ZMBZpzaPevS
VFNHuwR5axUa/eBjuhvJndPAvG26kzxqLHLPs3hVLPsaMb+A9cwMTbOz4G9udAb6
yvNOjaMdzla0q7DcAnaiavkMyt8W3IzqNTeWDUzX+PaiWMzil5uRrpTytG8DfF8I
1GgKwdFgROeEIcuNhwp9X04nTP41xin7788u/j6243Z3LGomfY8noY+rHM2bsUjp
5QFqhm50hG0zfOodPTPu1wVPGjQizxXEiF50MlL8w5MBBH2c2wT49bRnOK2/2np3
ZjpBVdQIIczhtWpfmh7f6hmBi+P6xxV4cKPi2jMSrN2cTSAkYFRKTdTYrL/h+EgN
qc9YVCXWPQKoV+xk6/O7p9IlOyzjljxRrypD9WGv+SrcYONfaso=
=4h6q
-----END PGP SIGNATURE-----

--bdvnz5ydqusftk5f--
