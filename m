Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B05D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbeGVXAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:00:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:00:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7702926BA64
Date:   Mon, 23 Jul 2018 00:02:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     David Lechner <david@lechnology.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: lego_ev3_battery: Don't ignore
 iio_read_channel_processed() return value
Message-ID: <20180722220211.qzlxawn63itxbjmc@earth.universe>
References: <20180720201944.20503-1-david@lechnology.com>
 <20180720201944.20503-2-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="unnuhg22akc6mbck"
Content-Disposition: inline
In-Reply-To: <20180720201944.20503-2-david@lechnology.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--unnuhg22akc6mbck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 20, 2018 at 03:19:43PM -0500, David Lechner wrote:
> This changes the LEGO MINDSTORMS EV3 power supply driver to return an
> error if iio_read_channel_processed() fails.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/lego_ev3_battery.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supp=
ly/lego_ev3_battery.c
> index 7b993d669f7f..6e3b3e384172 100644
> --- a/drivers/power/supply/lego_ev3_battery.c
> +++ b/drivers/power/supply/lego_ev3_battery.c
> @@ -39,7 +39,7 @@ static int lego_ev3_battery_get_property(struct power_s=
upply *psy,
>  					 union power_supply_propval *val)
>  {
>  	struct lego_ev3_battery *batt =3D power_supply_get_drvdata(psy);
> -	int val2;
> +	int ret, val2;
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
> @@ -47,11 +47,18 @@ static int lego_ev3_battery_get_property(struct power=
_supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		/* battery voltage is iio channel * 2 + Vce of transistor */
> -		iio_read_channel_processed(batt->iio_v, &val->intval);
> +		ret =3D iio_read_channel_processed(batt->iio_v, &val->intval);
> +		if (ret)
> +			return ret;
> +
>  		val->intval *=3D 2000;
>  		val->intval +=3D 200000;
> +
>  		/* plus adjust for shunt resistor drop */
> -		iio_read_channel_processed(batt->iio_i, &val2);
> +		ret =3D iio_read_channel_processed(batt->iio_i, &val2);
> +		if (ret)
> +			return ret;
> +
>  		val2 *=3D 1000;
>  		val2 /=3D 15;
>  		val->intval +=3D val2;
> @@ -64,7 +71,10 @@ static int lego_ev3_battery_get_property(struct power_=
supply *psy,
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		/* battery current is iio channel / 15 / 0.05 ohms */
> -		iio_read_channel_processed(batt->iio_i, &val->intval);
> +		ret =3D iio_read_channel_processed(batt->iio_i, &val->intval);
> +		if (ret)
> +			return ret;
> +
>  		val->intval *=3D 20000;
>  		val->intval /=3D 15;
>  		break;
> --=20
> 2.17.1
>=20

--unnuhg22akc6mbck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltU/uIACgkQ2O7X88g7
+poxBw/+PFhihh/m2VdPZQaT+eUdZ63d/njrXEZCdTHB0OJV16Kn8t8/NmfoS4nX
aBe1eZrpZaHEFC8swR01t67cPUGbRZ/lLvOT7hArhN+ovP0CiGomKBcScCDxnpaB
mhmBzqcBLMTFJabnjCwvFPfmBGbyzq/g+tQU0EwwC7SA2uwf8fGu7DMJO4gEFRgk
8TpM/zwmLtHC+bcXzpB89E9cbnNd3d9XGnxHXRXTuD0POpvclZ0ynVYnNthSmszo
nx2DbxgDaJqHbKt+f8GQBApuvYHT23KgQB9vCbEADgEaWZIbPSV49zIfrcQZb1ca
TU21+I1F+0YnXoYvUIzSQhjoB8fUaPJxA8arLnHYfb+BRXkKGSym+IiHWq4DwN0V
bS4TkeuPnhGDSH37PY0xV2RKewEJ586WsrbO+0rYYlu8JKht3E0W4Rn006Z1qkMX
C9sXjMFFqAIg0sBy1LCaSfqrQpHDkNaKthO9FZrPutonn6eEI9hP2H0ihdXTkp0X
5fgMAlubBNmqWJXm1z/bN2ugHl4FfyfLJNrHHyqL87corTt2KFnStyNOWGF8vv6J
9NGphZr3CQBnPCVqQV/r/Dq/WZ/1L1SVJk3lWYKmFqNbsP+zW3o6PnrgGzHECL6/
4YoOw+bcpUGKj1Vo92kVuIGNfSZgTk8nFS1mSMYForshRH2t0M4=
=XyMI
-----END PGP SIGNATURE-----

--unnuhg22akc6mbck--
