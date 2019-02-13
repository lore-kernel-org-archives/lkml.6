Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC13C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236162146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390749AbfBMXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:38:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49037 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbfBMXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:38:10 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D383A80323; Thu, 14 Feb 2019 00:38:00 +0100 (CET)
Date:   Thu, 14 Feb 2019 00:38:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190213233806.GA11867@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> >Agreed.
> >
> >>I believe it would be best to add a custom "mode" attribute
> >>to the led classdev, with "manual" and "on-when-charging"
> >>modes, this would then control bits 0-1 of reg 0x5e1f and
> >>by default these bits should be left as is when the driver
> >>loads.
> >
> >No. This is not first hardware when we have something like this, and
> >we need something generic here.
> >
> >One possibility would be magic "hardware drives this led"
> >trigger. Hmm? (Jacek disliked this idea before, but maybe we can
> >convince him).
> >
> >Generic "is this driven by hardware or not" attribute might be
> >possible, too... but its interaction with triggers/brightness/etc
> >would be confusing.
>=20
> In this case the interaction is not that tricky, but it will
> likely be different per led controller, so I do not think that
> we can ever come up with a truely generic solution.
>=20
> Basically the charge led has 3 states:
>=20
> 1) Off
> 2) On
> 3) On when charging
>=20
> And then when on it has 4 patterns:
>=20
> 1) Permanently off (so still not really on)
> 2) Permanently on
> 3) Blinking
> 4) Breathing

Ok, so you don't really need to support _both_ off methods.

Still sounds like a normal LED, with special "yoga-charging" and
"yoga-breathing" triggers. (All the normal triggers should still work,
too.)

> These 4 patterns can be selected when on, independent
> of being perma-on or ondemand-on

Yeah, but we don't really want to expose that to userspace.

> >>As for the 0x5e20 settings, I believe another custom
> >>sysfs attribute, called "breathing" would be a good idea to
> >>export the breathing functionality.
> >
> >We have "pattern" trigger that can do this kind of stuff in
> >software. But I'm not sure if this is worth supporting.
>=20
> The problem is that any changes made are permanent, they
> survice reboots and the default is Breathing, so we need
> a way to restore that which does not involve removing
> the internal battery of these devices.

Wow. Now that's a broken hardware.

Anyway, in such case I'd propose having rmmod/reboot/poweroff hook
that just sets it to breathing. No need to expose it to userspace.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxkql4ACgkQMOfwapXb+vKOPQCeNzzI8MH1QkwygTqYdginoCew
tigAniui8tZizirvnN0Z4zG8dgSZHmtg
=5tRy
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
