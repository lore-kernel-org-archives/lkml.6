Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2EC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2920833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeKDEYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:24:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42891 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeKDEYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:24:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9D33C8092F; Sat,  3 Nov 2018 20:11:58 +0100 (CET)
Date:   Sat, 3 Nov 2018 20:12:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Gracefully handle power supplies with disabled PM
Message-ID: <20181103191200.GE31179@amd>
References: <20180917121041.21084-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Content-Disposition: inline
In-Reply-To: <20180917121041.21084-1-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 14:10:41, Lubomir Rintel wrote:
> This allows use of SPI when power management is disables, such as on
> early boot;

disabled
boot.

> See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
> with disabled runtime PM")
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Plus.. I'm not sure.

I thought you'd cause imbalance between _put and _get, but that one is
probably ok.

On early boot, you probably need to proceed, but is ret =3D=3D -EACCESS
the right test?
									Pavel

> index ec395a6baf9c..6546564e41d0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1212,7 +1212,7 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
> =20
>  	if (!was_busy && ctlr->auto_runtime_pm) {
>  		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
> -		if (ret < 0) {
> +		if (ret < 0 && ret !=3D -EACCES) {
>  			pm_runtime_put_noidle(ctlr->dev.parent);
>  			dev_err(&ctlr->dev, "Failed to power device: %d\n",
>  				ret);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd8wAACgkQMOfwapXb+vKItgCfWcm4iN84KxRwQqZ0yJVpARNc
7KIAoK6qpoLBDhkD5veduIkcgxSH2fGs
=HGEW
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
