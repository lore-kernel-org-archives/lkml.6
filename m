Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FE9222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392980AbfBMXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:07:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48061 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392790AbfBMXHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:07:34 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C44798031B; Thu, 14 Feb 2019 00:07:25 +0100 (CET)
Date:   Thu, 14 Feb 2019 00:07:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190213230731.GA8557@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On 12-02-19 21:59, Yauhen Kharuzhy wrote:
> >Add support for LEDs connected to the Intel Cherry Trail Whiskey Cove
> >PMIC. Charger and general-purpose leds are supported. Hardware blinking
> >is implemented, breathing is not.
> >
> >This driver was tested with Lenovo Yoga Book notebook.
>=20
> Thank you for working on this. The CHT Whiskey Cove PMIC is
> also used on the GPD win and GPD pocket devices and there LED1
> by default indicates the charging status.
>=20
> Since your driver forces the LED into SWCTL mode on probe()
> this means that any kernel with it enabled will break the
> charging LEDs OOTB function, this is undesirable.

Agreed.

> I believe it would be best to add a custom "mode" attribute
> to the led classdev, with "manual" and "on-when-charging"
> modes, this would then control bits 0-1 of reg 0x5e1f and
> by default these bits should be left as is when the driver
> loads.

No. This is not first hardware when we have something like this, and
we need something generic here.

One possibility would be magic "hardware drives this led"
trigger. Hmm? (Jacek disliked this idea before, but maybe we can
convince him).

Generic "is this driven by hardware or not" attribute might be
possible, too... but its interaction with triggers/brightness/etc
would be confusing.

> Note that in my experience the "charging" mode only works
> when bits 0-1 have the value 10. I've some written notes from
> when I played with this myself and they say:
>=20
>    -CHT WC powerled control 0x5e1f: bits 0-1:
>     0: ????
>     1: Off
>     2: On when charging
>     3: On
>    -CHT WC powerled pattern control 0x5e20: bits 1-2:
>     0: Off
>     1: On
>     2: Blinking
>     3: Glowing
>=20

> As for the 0x5e20 settings, I believe another custom
> sysfs attribute, called "breathing" would be a good idea to
> export the breathing functionality.

We have "pattern" trigger that can do this kind of stuff in
software. But I'm not sure if this is worth supporting.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxkozMACgkQMOfwapXb+vLOSACdGeG4DIvszLQfMOVHwdjnB5iP
8lQAoIRlf65tt/uk4eD4cAPeyYj8jJIC
=CeJk
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
