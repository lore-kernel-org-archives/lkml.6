Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FD6222C7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfAEWbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 17:31:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38446 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfAEWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 17:31:05 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DA4C2809AA; Sat,  5 Jan 2019 23:12:49 +0100 (CET)
Date:   Sat, 5 Jan 2019 23:12:54 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add the
 LP5024/18 RGB LED driver
Message-ID: <20190105221254.GA22322@amd>
References: <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com>
 <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com>
 <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Grab yourself an RGB LED and play with it; you'll see what the
> >problems are. It is hard to explain colors over email...
>=20
> Video [0] gives some overview of lp5024 capabilities.
>=20
> I don't see any problems in exposing separate red,green,blue
> files and brightness for the devices with hardware support for
> that.

Well, that's what we do today, as three separate LEDs, right?

I don't have problem with that, either; other drivers already do
that. He's free to use existing same interface.

But that is insufficient, as it does not allow simple stuff, such as
turning led "white".

So... perhaps we should agree on requirements, first, and then we can
discuss solutions?

Requirements for RGB LED interface:

1) Userspace should be able to set the white color

2) Userspace should be able to arbitrary color from well known list
and it should approximately match what would CRT, LCD or OLED monitor displ=
ay

    2a) LEDs probably slightly change color as they age. That's out of
    scope, unless the variation is much greater than on monitors.

    2b) Manufacturing differences cause small color variation. Again,
    that's out of scope, unless the variation is much greater than on
    monitors.

Nice to have features:

3) Full range of available colors/intensities should be available to
userspace

4) Interface should work well with existing triggers

5) It would be nice if userland knew how many lumens are produced at
each wavelength for each setting (again, minus aging and manufacturing
variations).

6) Complexity of math in kernel should be low, and preferably it
should be integer or fixed point

Problems:

a) RGB LEDs are usually not balanced. Setting 100% PWM on
red/green/blue channels will result in nothing close to white
light. In fact, to get white light on N900, blue and green channel's
PWM needs to be set pretty low, as in 5%.

b) LED class does not define any relation between "brightness" in
sysfs and ammount of light in lumens. Some drivers use close to linear
relation, some use exponential relation. Human eyes percieve logarithm
of lumens. RGB color model uses even more complex function.

c) Except for white LEDs, LEDs are basically sources of single
wavelength of light, while CRTs and LCDs produce broader
spectrums.

d) RG, RGBW and probably other LED combinations exist.

e) Not all "red" LEDs will produce same wavelength. Similar
differences will exist for other colors.

f) We have existing RGB LEDs represented as three separate
monochromatic LEDs in sysfs.


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwxK+YACgkQMOfwapXb+vILFgCgxOnOlQp18Z6SjAygRd9g2tSi
+T4An2pAO1RIQFE+zBc98noNikm5JT4S
=CbTN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
