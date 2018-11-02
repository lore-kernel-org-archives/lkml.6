Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B3CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760162082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760162082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeKCHZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:25:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40815 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbeKCHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:25:13 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D2C3E80919; Fri,  2 Nov 2018 23:16:13 +0100 (CET)
Date:   Fri, 2 Nov 2018 23:16:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 01/15] power: supply: olpc_battery: correct the
 temperature units
Message-ID: <20181102221615.GB5322@amd>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20181010172300.317643-2-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-10 19:22:46, Lubomir Rintel wrote:
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
>=20
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
>=20
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
>=20
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvczK8ACgkQMOfwapXb+vK+VQCfcgyq3cidqXHQN1SQVFGn9ZBk
kjgAn0TYj1SDQaMTLx294PzTSslABpR5
=qO4G
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
