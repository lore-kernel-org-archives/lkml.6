Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1691C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A1520865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A1520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeKXVaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:30:10 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55305 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeKXVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:30:10 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 032A680977; Sat, 24 Nov 2018 11:41:55 +0100 (CET)
Date:   Sat, 24 Nov 2018 11:41:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Message-ID: <20181124104157.GA17954@amd>
References: <s5hbm6kf6gi.wl-tiwai@suse.de>
 <20181120093610.GF16916@amd>
 <s5h4lccf58f.wl-tiwai@suse.de>
 <20181120115159.GG16916@amd>
 <s5hzhu4c569.wl-tiwai@suse.de>
 <CAHp75VddanEB-7qQutSWkbSZW4srRzGXkigCMxEP7zJ=KC6iKw@mail.gmail.com>
 <20181122131802.GB13339@amd>
 <s5h8t1l5ish.wl-tiwai@suse.de>
 <20181123233309.GA4340@amd>
 <s5hftvq99qe.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <s5hftvq99qe.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > > > > > You have general-purpose LED, yet you are treating it as =
"something
> > > > > > > > > special". That means ugly code (quoted above) and lack of=
 flexibility.
> > > > > > > > >
> >=20
> > > > I'd prefer this to be normal LED and "mic muted" to become normal
> > > > trigger.
> > >=20
> > > But how would you solve the existing problem?
> > >=20
> > > As already mentioned, you'll need to hook the LED trigger and the
> > > actual mixer value change.  This is the biggest missing piece, and
> > > it's the very reason we have the exported symbol from the platform
> > > driver side.
> > >=20
> > > So, if you prefer in that way, please implement that for the existing
> > > driver (thinkpad_acpi and dell-laptop) at first.  I'll be really happy
> > > to get rid of the present ugly solution!  But it's been there just
> > > because it's not so trivial at all.  FWIW, this must be all done
> > > inside the kernel; otherwise you'll hit a regression.
> >=20
> > Ok, what about something like this?
> >=20
> > Tested, and it did not work. I guess I hooked it up at the wrong place
> > in LED subsystem... or maybe thinkpad x60 is wrong machine to test on.

I meant to say "wrong place in ALSA subsystem".

> > Anyway, it looks less ugly than current code in alsa. We should not
> > really be using mixer settings to turn LED on and off.
> >=20
> > Plus, it works in similar way triggers and LEDs "usually" do, and has
> > all the flexibility.
>=20
> Yes, thanks, that's something similar as what I had in mind, too.
> I guess it's just a matter of thinkpad_acpi side implementation that
> differs from your expectation.
>=20
> However, one remaining problem is that the state will be inconsistent
> depending on the driver module order, if we get rid of the dynamic
> symbol binding.  Then both modules become completely individual and
> thinkpad_acpi can be loaded at anytime later than HD-audio codec.
> If a mixer state is already changed before loading thinkpad_acpi, this
> event is lost and the state may be different in both sides.



> So, we'd need to record the state in the mute-trigger side, and add a
> function to return the current state.  Then thinkpad_acpi will query
> the state at the initialization time.

We want to record state at mute-trigger side, yes. Should not be
really different from other triggers.

> Also, we'll need also the normal mute LED in addition to the mic mute
> LED, so there need to be two triggers.

Yes.

> In anyway, moving to this direction requires the leds class
> implementation for dell-laptop.c as well as the new huawei stuff.  So,
> I'd really like to have the "already good working" code before
> actually hacking this, so that we can see and track the functional
> regression more obviously.

As well as thinkpad; note I did not do that part, because I don't have
that LED on my test machine.

Anyway, normally we get the architecture right and only then we merge
the drivers.

All Huawei hackers need to do is to convert their driver into normal
LED driver, and test it with some other trigger (like heartbeat). Then
we can be fairly sure it will work when we get the micmute done.

> I can start hacking this in the next week.  At least I have a Dell
> laptop and I can check the part of the changes locally.
>=20
> Since the changes will be fairly cross-tree, it's better to have an
> immutable branch to start with.  I'd branch off at 4.20-rc3 (or rc4),
> apply the current patches, so that it can be merged to all relevant
> trees cleanly.

As you will not change any core LED code, I don't think any heavy
synchronization with LED tree should be neccessary. We have LED
triggers living outside drivers/leds/triggers, too, such as
drivers/usb/common/led.c .

(Actually, that's the beauty of the LED subsystem. You have standard
trigger. You have standard LED -- which says it prefers that trigger if
available. They are really independend, so you can test and merge them
separately).

Let me know if you need any more help.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlv5KvUACgkQMOfwapXb+vIWUACgo9XFD+cSHR467QJO5t/Qxr8N
FqQAmwbVs/CvpqDfPYzkubV/vFMCztZq
=xDts
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
