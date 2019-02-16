Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB851222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbfBPThc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:37:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50994 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfBPThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:37:31 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F131F8050E; Sat, 16 Feb 2019 20:37:20 +0100 (CET)
Date:   Sat, 16 Feb 2019 20:37:27 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190216193727.GA14305@amd>
References: <92cf09b8-726d-4f1b-94ba-368a66af2246@redhat.com>
 <2b6faaa5-b21e-a512-de7d-ca21be5045fc@gmail.com>
 <20190214230307.GA17358@amd>
 <2a5e2002-e5f1-6da3-8a43-317801b69657@redhat.com>
 <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>I think that should work fine, which means that we can use the timer =
and
> >>>>pattern trigger support for the blinking and breathing modes.
> >>>>
> >>>>That still leaves the switching between user and hw-control modes,
> >>>>as discussed the hw-controlled mode could be modelled as a new "hardw=
are"
> >>>>trigger, but then we cannot choose between on/blink/breathing when
> >>>>in hw-controlled mode. As Pavel mentioned, that would require some
> >>>>sort of composed trigger, where we have both the hardware and
> >>>>timer triggers active for example.
> >>>>
> >>>>I think it might be easier to just allow turning on/off the hardware
> >>>>control mode through a special "hardware_control" sysfs attribute and
> >>>>then use the existing timer and pattern triggers for blinking / breat=
hing.
> >>>
> >>>Pattern trigger exposes pattern file by default and hw_pattern if
> >>>pattern_set/get ops are provided. Writing them enables software and
> >>>hardware pattern respectively.
> >>
> >>This is not about software vs hardware pattern.
> >>
> >>There are 2 *orthogonal*, separate problems/challenges with this LED co=
ntroller:
> >>
> >>1) It has hardware blinking and breathing, as discussed this can be
> >>controlled through the timer and pattern triggers, so this problem
> >>is solved.
> >>
> >>2) It has 2 operating modes:
> >>
> >>a) Automatic/hardware controlled, in this mode the LED is turned
> >>off or on (where on can be continues on, blinking or breathing)
> >>by the hardware itself, when in this mode we / userspace is not
> >>in control of the LED
> >>
> >>b) Manual/user controlled mode, in this mode we / userspace can
> >>control of the LED.
> >>
> >>Currently there is no API in the ledclass to switch a LED from
> >>automatic controlled to user controlled and back, This is what
> >>the proposed hardware trigger was for, to switch to automatic
> >>mode. A problem with this is that we still want to be able
> >>to chose between continues on, blinking or breathing (when on),
> >>configure the max brightness, etc.
> >
> >Yes, we do have the API to switch a LED from automatic (hardware
> >accelerated) control to software control and back. This is pattern
> >trigger, which exposes two files for setting pattern: pattern
> >and hw_pattern. Writing pattern file switches the device to software
> >control mode and writing hw_pattern switches it to the hardware control,
> >with the possibility of defining device specific ABI syntax to enable
> >particular pattern (blinking, breathing or event permanently on
> >in case of this device).
>=20
> OK, I see. So we would use the hw_pattern for this and the driver
> would implement the pattern_set led_classdev callback.
>=20
> The pattern_set callback would then expect 6 brightness/time tuples
> with the following meaning for the time part of each tupple
>=20
> tupple0: charging blinking_on_time
> tupple1: charging blinking_off_time
> tupple2: charging breathing_time
> tupple3: manual blinking_on_time
> tupple4: manual blinking_off_time
> tupple5: manual breathing_time
>=20
> Where only the times in tupple 0-2; or the times in 3-5 can be
> non-zero. Having non zero times for both some charging and some
> manual values is not allowed.
>=20
> If a breathing time is set, none of the other times may be non
> 0. If blinkig_on and blinking_off are used then breathing_time
> must be 0.
>=20
> When configured to blink then blinking_off must be either 0
> (continuously on); or it must be the same as blinking_on.
>=20
>=20
> I believe this will work, does this sound ok to you ?

I don't pretend to fully understand it, _but_ hw_pattern should really
describe the pattern LED should do, not whether it reacts to charging
or not.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxoZncACgkQMOfwapXb+vLrpQCgt8lkPVSljfLh6fSB7u7kUA0C
JrYAoILDy70WvEqn5t4gqczB1uydVL4d
=k38V
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
