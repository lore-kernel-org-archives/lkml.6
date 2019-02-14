Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D31222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393725AbfBNLO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:14:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40355 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfBNLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:14:27 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id AB1508034A; Thu, 14 Feb 2019 12:14:17 +0100 (CET)
Date:   Thu, 14 Feb 2019 12:14:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190214111423.GE6132@amd>
References: <20190212205901.13037-1-jekhor@gmail.com>
 <20190212205901.13037-2-jekhor@gmail.com>
 <1df39a63-533f-bb68-a056-a0241f148be9@redhat.com>
 <20190213230731.GA8557@amd>
 <42078a81-e32e-81b7-528f-d1adb60d31c3@redhat.com>
 <20190213233806.GA11867@amd>
 <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <562e2acd-a60a-2aea-4050-6d9414d23a4e@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>Basically the charge led has 3 states:
> >>
> >>1) Off
> >>2) On
> >>3) On when charging
> >>
> >>And then when on it has 4 patterns:
> >>
> >>1) Permanently off (so still not really on)
> >>2) Permanently on
> >>3) Blinking
> >>4) Breathing
> >
> >Ok, so you don't really need to support _both_ off methods.
> >
> >Still sounds like a normal LED, with special "yoga-charging" and
> >"yoga-breathing" triggers. (All the normal triggers should still work,
> >too.)
>=20
> Except that when in yoga-charging mode, the user should
> still be able to select if the LED is simply on when charging,
> blinking when charging, or breathing when charging.
>=20
> Given that there are 2 independent settings model-ing this
> as a trigger does not work well. Also the trigger names should
> not contain yoga as the PMIC in question is used in other
> devices too.
>=20
> I really think we should not try to shoe-horn special cases
> like this into the generic API and just use custom sysfs
> attributes for this. Like for example how the kbd-backlight

This is not really that much of a special case. I have LEDs on
thinkpads that can be either hardware controlled or sw controlled with
various functions. Both Droid 4 and N900 have hardware support for
showing charging state on the notification LED. N900 additionaly has
debug functionality for keyboard backlight...

> led classdev from the dell-laptop has custom attributes to
> select if the timeout for going off on keyboard/mouse activity
> and another custom attribute to select if only the keyboard or
> both the keyboard and mouse count as relevant activity.

Yeah well more stuff to fix :-(.

> Triggers are great for when we actually want to add a link
> between an event coming from some part of code in the kernel,
> to a LED classdevice, so that that event can control the LED.

Well, triggers are also useful because userspace should already know
about them.... and because your hardware already behaves as if it had
"trigger" implemented in hardware...

> >Anyway, in such case I'd propose having rmmod/reboot/poweroff hook
> >that just sets it to breathing. No need to expose it to userspace.
>=20
> That assumes that breathing is the default setting on all hardware
> and again I don't see why not to export this functionality to

Save the status on boot, then restore it on rmmod/reboot/poweroff? :-).

> userspace. Just because something does not fit in the existing
> API is IMHO not a good reason to not expose it to userspace.
>=20
> I suggest that we deal with this special case by adding 3 custom
> sysfs attributes:
>=20
> 1) "mode" which when read, prints, e.g. :
> manual [on-when-charging]

While this allows _user on console_ to control everything using echo,
it is not suitable for applications trying to control LEDs.

As there's nothing special about the case here, I believe we should
have generic solution here.

My preffered solution would be "hardware" trigger that leaves the LED
in hardware control.

Alternatively I could imagine "hardware" sysfs attribute, containing
0/1, with 0=3D=3Dsoftware controlled, 1=3D=3Dhardware controlled.

The rest of attributes would have to be Cove-specific, yes (but still
should fit with the rest of LED subsystem).

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxlTY8ACgkQMOfwapXb+vJzowCcDBSgjX9a8r05/K8QsFoR0E2Q
+ikAnR9jy6i2r0Xx2WH2KjLctFqQmCYc
=knIQ
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
