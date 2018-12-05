Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5070FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F4120879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F4120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeLEV4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:56:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51526 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEV4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:56:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8AA2726A028
Received: by earth.universe (Postfix, from userid 1000)
        id 207603C08D6; Wed,  5 Dec 2018 22:56:44 +0100 (CET)
Date:   Wed, 5 Dec 2018 22:56:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 4/7] power: supply: bq24190_charger: add extcon
 support for USB OTG
Message-ID: <20181205215644.icx7jpisfhpd2edb@earth.universe>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxuayx6qoqhqiddd"
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-5-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxuayx6qoqhqiddd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 08:11:46PM -0400, Brian Masney wrote:
> Add extcon support so that we can notify USB drivers of cable state
> changes. Based on work from Jonathan Marek. USB OTG was tested on a LG
> Nexus 5 (hammerhead) phone.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 37 +++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 9e7f3e33458a..4e64e6ac95c5 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -21,6 +21,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
> +#include <linux/extcon-provider.h>
> =20
>  #define	BQ24190_MANUFACTURER	"Texas Instruments"
> =20
> @@ -159,6 +160,7 @@
>  struct bq24190_dev_info {
>  	struct i2c_client		*client;
>  	struct device			*dev;
> +	struct extcon_dev		*edev;
>  	struct power_supply		*charger;
>  	struct power_supply		*battery;
>  	struct delayed_work		input_current_limit_work;
> @@ -174,6 +176,11 @@ struct bq24190_dev_info {
>  	u8				watchdog;
>  };
> =20
> +static const unsigned int bq24190_usb_extcon_cable[] =3D {
> +	EXTCON_USB,
> +	EXTCON_NONE,
> +};
> +
>  /*
>   * The tables below provide a 2-way mapping for the value that goes in
>   * the register field and the real-world value that it represents.
> @@ -1528,6 +1535,20 @@ static const struct power_supply_desc bq24190_batt=
ery_desc =3D {
>  	.property_is_writeable	=3D bq24190_battery_property_is_writeable,
>  };
> =20
> +static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss=
_reg)
> +{
> +	bool otg_enabled;
> +	int ret;
> +
> +	otg_enabled =3D !!(ss_reg & BQ24190_REG_SS_VBUS_STAT_MASK);
> +	ret =3D extcon_set_state_sync(bdi->edev, EXTCON_USB, otg_enabled);
> +	if (ret < 0)
> +		dev_err(bdi->dev, "Can't set extcon state to %d: %d\n",
> +			otg_enabled, ret);
> +
> +	return ret;
> +}
> +
>  static void bq24190_check_status(struct bq24190_dev_info *bdi)
>  {
>  	const u8 battery_mask_ss =3D BQ24190_REG_SS_CHRG_STAT_MASK;
> @@ -1597,8 +1618,10 @@ static void bq24190_check_status(struct bq24190_de=
v_info *bdi)
>  		bdi->ss_reg =3D ss_reg;
>  	}
> =20
> -	if (alert_charger || alert_battery)
> +	if (alert_charger || alert_battery) {
>  		power_supply_changed(bdi->charger);
> +		bq24190_configure_usb_otg(bdi, ss_reg);
> +	}
>  	if (alert_battery && bdi->battery)
>  		power_supply_changed(bdi->battery);
> =20
> @@ -1732,6 +1755,14 @@ static int bq24190_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
> =20
> +	bdi->edev =3D devm_extcon_dev_allocate(dev, bq24190_usb_extcon_cable);
> +	if (IS_ERR(bdi->edev))
> +		return PTR_ERR(bdi->edev);
> +
> +	ret =3D devm_extcon_dev_register(dev, bdi->edev);
> +	if (ret < 0)
> +		return ret;
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_autosuspend_delay(dev, 600);
> @@ -1778,6 +1809,10 @@ static int bq24190_probe(struct i2c_client *client,
>  		goto out_charger;
>  	}
> =20
> +	ret =3D bq24190_configure_usb_otg(bdi, bdi->ss_reg);
> +	if (ret < 0)
> +		goto out_charger;
> +
>  	ret =3D bq24190_sysfs_create_group(bdi);
>  	if (ret < 0) {
>  		dev_err(dev, "Can't create sysfs entries\n");
> --=20
> 2.17.2
>=20

--pxuayx6qoqhqiddd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISZsACgkQ2O7X88g7
+pp7Ig//RFKKi1+HQ2lMv/3spEdJZK9mtsO6/vt7JRvHN9DTj1a1y8bMaqP3OJ1n
E45GxJ+KkvVhBqyxu3wZfyfgbh1kpXXu/JJYO2t3F2FfsT+7/YBdm2/mAMJM1DTt
GZiFOy9VBYjsA7KreyimN1L3BGOhI1DUItvzFFHZGQqft1ic2yuA/9eLNn5bUgm0
TxLX86e0RsOWS2msMjNoIt53d+8+sLtdlaQjpO7xMdmgqxtCUtsJkH75XyP7CxA0
ehWY38bdtvV4s+QQyBNXKmZ9MJ+gZAahdvi0s1gzJcRZaut8EXN5ps+pjAdKpro6
zR//Ofhk13ZFN9/SuTafiJx5vqUEFPXFzn8t7xCw1fsD4OLiy7sFMe37X/YAQypD
EynyXAhAjsidSsRgfCpHH2igJzmi/0PLch4us4bjAvL2mpgHiDs5iN/C8ot3bU0B
uo/lHwhbQtD4GNQq7U2C/pmgeLSkHzfyiaP/2k1GaBUVclDoXcD4cHc8BwNWeAlX
bXfS56yj/gDUGEz0ZkGNt71vLqhY4nzHFpFeHNdIC7HrU6U6FiJOVyMsbfwDlsZq
K4xBVWhy8dhS/8XeDlyY/yVimaMKItpCsVh+Ow0HBM+8eW6XeqyNvsz5cBvgLl/W
LbtHnsrLN+UD5cHvUyNb3pr0vf0g5ThpUvYU/SaG9s6HCrHUBCY=
=4yC/
-----END PGP SIGNATURE-----

--pxuayx6qoqhqiddd--
