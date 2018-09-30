Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E7C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E0206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8E0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJACvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:51:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39323 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbeJACvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:51:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 56AD0807FB; Sun, 30 Sep 2018 22:16:43 +0200 (CEST)
Date:   Sun, 30 Sep 2018 22:16:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] twl4030_charger: fix charging current
 out-of-bounds
Message-ID: <20180930201642.GC23554@amd>
References: <20180917052035.12234-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <20180917052035.12234-1-andreas@kemnade.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 07:20:35, Andreas Kemnade wrote:
> the charging current uses unsigned int variables, if we step back
> if the current is still low, we would run into negative which
> means setting the target to a huge value.
> Better add checks here.

Do you expect this to happen in practice? Too high current while
charging seems bad, right?

Cc: stable?
								Pavel

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/power/supply/twl4030_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/suppl=
y/twl4030_charger.c
> index b72838663872..c954b7234393 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -421,7 +421,8 @@ static void twl4030_current_worker(struct work_struct=
 *data)
> =20
>  	if (v < USB_MIN_VOLT) {
>  		/* Back up and stop adjusting. */
> -		bci->usb_cur -=3D USB_CUR_STEP;
> +		if (bci->usb_cur >=3D USB_CUR_STEP)
> +			bci->usb_cur -=3D USB_CUR_STEP;
>  		bci->usb_cur_target =3D bci->usb_cur;
>  	} else if (bci->usb_cur >=3D bci->usb_cur_target ||
>  		   bci->usb_cur + USB_CUR_STEP > USB_MAX_CURRENT) {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluxLyoACgkQMOfwapXb+vLUdQCcCw2lUChh9QF8KfmJ8mbNNEDq
JHwAnRlP32MAnHnP4hLLBC0Zrzm5fO4Z
=G8F0
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
