Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB309C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CD220873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfARACj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:02:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58938 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfARACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:02:39 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 316B680789; Fri, 18 Jan 2019 01:02:30 +0100 (CET)
Date:   Fri, 18 Jan 2019 01:02:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dachaac@gmail.com, robh+dt@kernel.org
Subject: RGB LED class Re: [PATCH v2 2/2] leds: lp50xx: Add the LP50XX family
 of the RGB LED driver
Message-ID: <20190118000235.GB27661@amd>
References: <20190114211723.11186-1-dmurphy@ti.com>
 <20190114211723.11186-2-dmurphy@ti.com>
 <ce911fdf-c7c2-63e8-5c7a-b0be965ab69b@gmail.com>
 <20190115222223.GA17363@amd>
 <79394d17-3124-75b2-ccac-dc1046499d14@ti.com>
 <20190116105537.GA1803@amd>
 <86299268-3202-814a-134b-04bd2170faab@ti.com>
 <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <8dfa2854-2814-6874-ab8e-1858e9a18acf@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >I am willing to work with you on the HSV and adapting the LP50xx part to=
 this framework.
> >Or any RGB framework for that matter.  I still don't agree with the kern=
el needing to declare colors
> >  maybe color capabilities but not specific colors.
>=20
> Dan, if you have a bandwidth for LED RGB class implementation
> then please go ahead. It would be good to compare colors produced
> by software HSV->RGB algorithm to what can be achieved with
> LEDn_BRIGHTNESS feature.

Don't get me wrong, I'd like to see LED RGB class implementation. But
it will delay merge of this driver.

If we want to do that, we should first discuss the requirements, and
then come up with interface.. and only then we can talk about the
driver code.

That's why I believe preferable way would be to merge the driver using
the existing interface.

Of course, first designing RGB LED class and then merging the
driver.. is okay with me. But lets not rush the class because there's
driver waiting for it.

> The requirements for LED RGB class as I would see it:
>=20
> sysfs interface:
>=20
> brightness-model: space separated list of available options:
> - rgb (default):
>   - creates color file with "red green blue" decimal values
>   - creates brightness file
> 	a) for devices with hardware support for adjusting color
>            intensity it maps to corresponding register
>         b) for the rest writing any value greater than 0 will result
>            in setting all color registers to max
> - hsv:
>   - creates color file with "h s v" values - it shall
>     use software HSV->RGB algorithm for setting color registers
>=20
> - any other custom color ranges defined in DT, but it can be covered
>   later
> - other options?

First, I think we want to decide if RGB LED should be presented as
3 LEDs or as 1 LED... and what to do with existing RGB leds being
presented as 3 LEDs.

I don't think we want to support both RGB and HSV in the kernel. It is
math, and not a nice one.

Yes, both have advantages and disadvantages, but having _both_ in
kernel has disadvantages of both.

One way I could imagine the interface:

    RGB LED presented as one LED.

    brightness -- controls brightness of whole RGB module.

    pwm_channels -- "1000 240 300" -- "red part should be full on, green
    should be pwm controlled to 240/1000, blue should be 300/1000"

    pwm_white -- "1000 500 400" -- tells userspace what to write to PWM
    channels to get approximately white color.

    This would assume that RGB LEDs are always pwm controlled. That
    seems to be true for hardware I seen.

    + no complex math in kernel

    + userspace knows enough to display arbitrary colors

    + userspace can use full range of available PWM intensities

    + existing triggers will work nicely

    - userland needs to do non-trivial math to get colors it wants

    - not sure how to migrate existing devices

Thoughts? Other possible interfaces?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxBF5sACgkQMOfwapXb+vLk7ACggrnpo4GT4crCmLiKiC8Lan/F
m2YAn2pa5S/YMpk7b2XpOyHfzqRZiJws
=Rwmp
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
