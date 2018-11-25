Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AB2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73120672
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E73120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKZIka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:40:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49884 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKZIka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:40:30 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 1495780525; Sun, 25 Nov 2018 22:48:21 +0100 (CET)
Date:   Sun, 25 Nov 2018 22:48:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        broonie@kernel.org
Subject: Re: [PATCH 5/5] power: supply: sc27xx: Save last battery capacity
Message-ID: <20181125214823.GB9913@amd>
References: <cover.1542185618.git.baolin.wang@linaro.org>
 <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Our charger manager can optimize the battery capacity periodically, so
> we can save last battery capacity into registers. Then next system
> power-on, we can read the last saved battery capacity as the initial
> battery capacity, which can make the battery capacity more accurate.
>=20
> Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/power/supply/sc27xx_fuel_gauge.c |  143 ++++++++++++++++++++++++=
+++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>=20

> +static int sc27xx_fgu_set_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   const union power_supply_propval *val)
> +{
> +	struct sc27xx_fgu_data *data =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D sc27xx_fgu_save_last_cap(data, val->intval);
> +		if (ret < 0)
> +			dev_err(data->dev, "failed to save battery capacity\n");
> +		break;
> +
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +	return ret;

if (psp !=3D ....) return -EINVAL; And you can do that outside
lock...

Ok, OTOH this is easier to extend in future. Do you expect more
writable properties?

> +static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
> +					    enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		return 1;
> +
> +	default:
> +		return 0;
> +	}
> +}


Same here. return psp =3D=3D POWER_SUPPLY_PROP_CAPACITY; really looks
strange written like this.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv7GKcACgkQMOfwapXb+vJz8QCaA9Ld/LHJlKBMeAS7juHWIl4g
25sAn2HVSfhXQMz9n3HTxTTORvQ42RQd
=kMZ1
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
