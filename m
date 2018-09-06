Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA802077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA802077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbeIFULy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:11:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51113 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbeIFULy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:11:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 24FAB805DA; Thu,  6 Sep 2018 17:35:49 +0200 (CEST)
Date:   Thu, 6 Sep 2018 17:35:48 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jerome Brunet <jbrunet@baylibre.com>, sre@kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: pwm: silently error out on EPROBE_DEFER
Message-ID: <20180906153548.GA10088@amd>
References: <20180906135904.13803-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20180906135904.13803-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-09-06 15:59:04, Jerome Brunet wrote:
> When probing, if we fail to get the pwm due to probe deferal, we shouldn't
> print an error message. Just be silent in this case.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/leds/leds-pwm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index df80c89ebe7f..5d3faae51d59 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -100,8 +100,9 @@ static int led_pwm_add(struct device *dev, struct led=
_pwm_priv *priv,
>  		led_data->pwm =3D devm_pwm_get(dev, led->name);
>  	if (IS_ERR(led_data->pwm)) {
>  		ret =3D PTR_ERR(led_data->pwm);
> -		dev_err(dev, "unable to request PWM for %s: %d\n",
> -			led->name, ret);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "unable to request PWM for %s: %d\n",
> +				led->name, ret);
>  		return ret;
>  	}

Hmm, sometimes probing is deffered forever, and in such case debug
message is useful.

Do you see excessive number of these?
								=09
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluRSVQACgkQMOfwapXb+vK+YgCfUI4NqQjSSwLFdtosQU/WwyBR
/CwAniFEtMy49wZsLFs5DZuz30f8hAtu
=QU1u
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
