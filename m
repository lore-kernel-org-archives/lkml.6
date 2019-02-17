Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE5C2177E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfBQRpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:45:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60822 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:45:52 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 513BA8052B; Sun, 17 Feb 2019 18:45:42 +0100 (CET)
Date:   Sun, 17 Feb 2019 18:45:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 1/2] leds: Add Intel Cherry Trail Whiskey Cove PMIC
 LEDs
Message-ID: <20190217174549.GA13301@amd>
References: <3d5407a7-9458-f071-a1d5-511b09678e20@gmail.com>
 <87a21c4e-8e5e-c180-2ff3-eb8170746e71@redhat.com>
 <80971bc3-1193-83ed-913a-12f6217016c8@gmail.com>
 <b15fd048-8206-4057-a354-07dc14ca15e3@redhat.com>
 <8a263266-a41f-c916-e990-02d04de9b5d0@gmail.com>
 <af5bec7b-0da1-ee19-cdf4-0240f56221ad@redhat.com>
 <20190216193727.GA14305@amd>
 <7be63b6b-8d8d-90b8-fb17-d219b87a101f@redhat.com>
 <20190217000851.GA29803@amd>
 <81cc42f5-1f3d-c7f2-eb13-c2f8c4f9bfb4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <81cc42f5-1f3d-c7f2-eb13-c2f8c4f9bfb4@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >I see... and yes, that would be the easiest solution.
> >
> >But somehow I see "this LED is controlled by charging state" as
> >primary and "it shows pulses instead of staying on" as secondary
> >eye-candy.
> >
> >This week there was another driver for charger LED.. but that one does
> >not do pulses. Ideally, we'd like consistent interface to the
> >userland.
> >
> >(To make it complex, the other driver supports things like:
> >   LED solid on -- fully charged
> >   LED blinking slowly -- charging
> >   LED blinking fast -- charge error
> >   LED off -- not charging).
>=20
> Something like that could be supported with my original hw_pattern
> proposal where we simply encode all of this in the hw-pattern file:
>=20
> tupple0: charging blinking_on_time
> tupple1: charging blinking_off_time
> tupple2: charging breathing_time
> tupple3: manual blinking_on_time
> tupple4: manual blinking_off_time
> tupple5: manual breathing_time

So the userland would need to know "I'm on yoga, so 3rd tupple sets up
breathing when charging"?

> So for this chip you mention, we do not need the breathing time (no breat=
hing support),
> so we would get the following tupples:
>=20
> tupple0: not charging blinking_on_time
> tupple1: not charging blinking_off_time
> tupple2: slow charging blinking_on_time
> tupple3: slow charging blinking_off_time
> tupple4: fast charging blinking_on_time
> tupple5: fast charging blinking_off_time
> tupple6: charging error blinking_on_time
> tupple7: charging error blinking_off_time

Patterns and their meanings are fixed (or almost) on that driver, so
fortunately that will not be neccessary.

> Where by solid on/off can be done by setting one
> of the blinking times to 0.
>=20
> Having hw_pattern ABIs like this where some of
> the tupples only activate on certain conditions
> might be better then a hardware_control sysfs
> file as it offers more flexibility.

Agreed about flexibility, but I don't think it does enough to provide
hardware abstraction. It might be too much flexibility.

Also it only works with hw controlled LEDs.

With RGB LED multiple patterns per LED make a lot of sense (as there's
typically just one led.

For example on N900, we have

green: fully charged.
yellow pulsing: charging.
solid yellow: hardware feature, emergency charging.
white pulsing: happy phone, no events
blue fast pulses: message waiting

On N900, I'm handling that in userspace, but...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxpnc0ACgkQMOfwapXb+vLf4QCeO6zbHGc5WCQbHTPq74Hw/b63
xLEAn204WDUgvQJkslmfGmO70OF/G+QM
=FrBN
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
