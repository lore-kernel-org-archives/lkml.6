Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B47C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A05C213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A05C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeLEU76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:59:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51238 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:59:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 852482761E9
Received: by earth.universe (Postfix, from userid 1000)
        id A8A7B3C08D6; Wed,  5 Dec 2018 21:59:51 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:59:51 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 16/17] power: supply: olpc_battery: Avoid using
 platform_info
Message-ID: <20181205205951.gzbezcu7s7ahuvm4@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-17-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rjcgjqrw5veodl3"
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-17-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rjcgjqrw5veodl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:24:02PM +0100, Lubomir Rintel wrote:
> This wouldn't work on the DT-based ARM platform. Let's read the EC version
> directly from the EC driver instead.
>=20
> This makes the driver no longer x86 specific.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---
> Changes since v1:
> - Use uint8_t instead of unsigned char [1] for ecver
>=20
>  drivers/power/supply/Kconfig        |  2 +-
>  drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f27cf0709500..dd7ae1431098 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -151,7 +151,7 @@ config BATTERY_PMU
> =20
>  config BATTERY_OLPC
>  	tristate "One Laptop Per Child battery"
> -	depends on X86_32 && OLPC
> +	depends on OLPC
>  	help
>  	  Say Y to enable support for the battery on the OLPC laptop.
> =20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 4433eb10a23d..ec5dfb8fcb8a 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -20,8 +20,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
> -
> =20
>  #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
>  #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
> @@ -57,6 +55,7 @@ struct olpc_battery_data {
>  	struct power_supply *olpc_ac;
>  	struct power_supply *olpc_bat;
>  	char bat_serial[17];
> +	int new_proto;
>  };
> =20
>  /*********************************************************************
> @@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
>  static int olpc_bat_get_status(struct olpc_battery_data *data,
>  		union power_supply_propval *val, uint8_t ec_byte)
>  {
> -	if (olpc_platform_info.ecver > 0x44) {
> +	if (data->new_proto) {
>  		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else if (ec_byte & BAT_STAT_DISCHARGING)
> @@ -608,14 +607,32 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  	struct power_supply_config psy_cfg =3D {};
>  	struct olpc_battery_data *data;
>  	uint8_t status;
> +	uint8_t ecver;
> +	int ret;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, data);

This ended up in the wrong patch. Otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> +	/* See if the EC is already there and get the EC revision */
> +	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
> +	if (ret) {
> +		if (ret =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return ret;
> +	}
> =20
> -	/*
> -	 * We've seen a number of EC protocol changes; this driver requires
> -	 * the latest EC protocol, supported by 0x44 and above.
> -	 */
> -	if (olpc_platform_info.ecver < 0x44) {
> +	if (ecver > 0x44) {
> +		/* XO 1 or 1.5 with a new EC firmware. */
> +		data->new_proto =3D 1;
> +	} else if (ecver < 0x44) {
> +		/*
> +		 * We've seen a number of EC protocol changes; this driver
> +		 * requires the latest EC protocol, supported by 0x44 and above.
> +		 */
>  		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
> -			"battery driver.\n", olpc_platform_info.ecver);
> +			"battery driver.\n", ecver);
>  		return -ENXIO;
>  	}
> =20
> --=20
> 2.19.1
>=20

--3rjcgjqrw5veodl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIPEcACgkQ2O7X88g7
+poUzA/+MDKKWBLbx8Hr90WRMNMTUHVfYF2XegkIstwfOqovl3XcAyC3jsKp4NRO
YZWy6ukWIzcjQGQWJdl1SoyLILwj8lC5tCbfUuKnrN1+1tWlPdAfS97lwpUow59Y
LCsQduI5YdlM0GM+ti9OdPm8a8dp2SwNWDzP2kteMnxl9CqM7E/7vWEUZposcO2V
9xFlAnApHktpE7vTu9KQnip7rJspBGIvBjnTyKj5NtbPppQghl9tsT9ylQgtkRim
bbUfDI1qdmMa2Gdc4l2u3g/6rTBuNB3yvB17A68HUoSSpFsws6CG+3PqiqtMi9Dd
3oB3q7yknxpRSfpE63y7nQlt6/v6SZy6fAx9t8P7PrkLG3ckeTK0LPHwTWK6z5yH
olgOCIeCjAkOa7RYdVwOzATCMx9kHX6Vib+EW/0fu924Bms43wTPkNAptjD+IbXS
bpK5JazHW39MbhiVQs5wVTZRFs+DEZ7k7fJ7GHKeEjtwMoTzz55K9+R9cn7JAkxb
27A4X9MOlzycRmFOkv6qri9sX3g2P64EwBljNT5NaOrQQ90NT743okGBl6DGtQei
LHeB6052XD+MwuAkQ7gLpWmpONqBL4x9Qsr9RvBB1DDhsAFOQx+NuxSlPlerukr/
R+Pc+2o/gyBI4FMOrGuhQh7q9Tqp2lmtaDublYj3UvjYDHoP9D4=
=z5pl
-----END PGP SIGNATURE-----

--3rjcgjqrw5veodl3--
