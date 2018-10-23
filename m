Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E61C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5187320651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5187320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbeJXDzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:55:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58557 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:55:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 07153806F5; Tue, 23 Oct 2018 21:30:13 +0200 (CEST)
Date:   Tue, 23 Oct 2018 21:30:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
Message-ID: <20181023193014.GA32003@amd>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
 <20181023185453.GA27397@amd>
 <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-10-23 21:09:54, Jacek Anaszewski wrote:
> On 10/23/2018 08:54 PM, Pavel Machek wrote:
> > Hi!
> >=20
> >>> +	led->field =3D devm_regmap_field_alloc(dev, regmap, conf);
> >>> +	if (IS_ERR(led->field))
> >>> +		return PTR_ERR(led->field);
> >>> +
> >>> +	led->cdev.max_brightness =3D 1;
> >>
> >> s/1/LED_ON/
> >=20
> > Actually, I prefer constant 1 here, as it makes it immediately obvious
> > this supports just 0/1.
> >=20
> > Yes, LED_ON is also 1, but I had to grep the header files for
> > that... (I thought it was 255).
>=20
> If we have the enum for that, let's use it.
> Here's the commit message of the patch adding LED_ON - it should
> be somehow familiar to you - see the ack.

Well .. brightness =3D LED_ON; is good usage. max_brightness =3D LED_ON is
IMO less readable than max_brightness =3D 1.

Looking at situation again... Having LED_ON and LED_FULL, with some
leds having max brightness of 1023, so LED_FULL is not really full
brightness any more... Maybe it is time to get rid of the enum, and
make it plain int. It does not really enumarate anything, and it does
not help readability, either.
								Pavel


> commit 4e552c8cb5bc9137e67e035bab8df6dddbca7384
> Author: Andi Shyti <andi.shyti@samsung.com>
> Date:   Thu Jan 5 11:34:12 2017 +0900
>=20
>     leds: add LED_ON brightness as boolean value
>=20
>     Some devices do not handle the led brightness or simply don't
>     care about it. Conceptually said devices want to just switch on
>     or off the led. It is useless in this case to have a 255 range
>     of brightness, while just having an LED_ON and LED_OFF improves
>     the boolean meaning of the led status.
>=20
>     Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>     Acked-by: Pavel Machek <pavel@ucw.cz>
>     Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvPdsYACgkQMOfwapXb+vImMACeKoO4h32MomIbcsmGThXHjn0m
JpMAoIRistLuJPRkZMrx48Yq29zep+xm
=MitW
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
