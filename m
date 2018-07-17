Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5432020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5432020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeGQVlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:41:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58594 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730571AbeGQVle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:41:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0F79A8028C; Tue, 17 Jul 2018 23:07:03 +0200 (CEST)
Date:   Tue, 17 Jul 2018 23:07:00 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Message-ID: <20180717210700.GA9090@amd>
References: <CAMz4kuKZ6Z1h=yzFYJihEH1ARC5FKtDC6RLz0u8SmaekOZ=utw@mail.gmail.com>
 <20180714212033.GA31950@amd>
 <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd>
 <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com>
 <20180716215616.GB10734@amd>
 <8c07a016-d77d-4799-b005-6a9ea94954ce@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <8c07a016-d77d-4799-b005-6a9ea94954ce@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>- different hardware means via which brightness is set (MMIO, I2C, SPI,
> >>   PWM and other pulsed fashion based protocols),
> >>- the need for deferring brightness setting to a workqueue task to
> >>   allow for setting LED brightness from atomic context,
> >>- contention on locks
> >
> >I disagree here. Yes, it would be hard to synchronize blinking down to
> >microseconds, but it would be easy to get synchronization right down
> >to miliseconds and humans will not be able to tell the difference.
>=20
> There have been problems with blink interval stability close to
> 1ms, and thus there were some attempts of employing hr timers,
> which in turn introduced a new class of issues related to
> system performance etc.

Yeah, well. This is LED subsystem. Noone should program blink
intervals at 1 msec.

> >>For the LEDs driven by the same chip it would make more sense
> >>to allow for synchronization, but it can be achieved on driver
> >>level, with help of some subsystem level interface to indicate
> >>which LEDs should be synchronized.
> >>
> >>However, when we start to pretend that we can synchronize the
> >>devices, we must answer how accurate we can be. The accuracy
> >>will decrease as blink frequency rises. We'd need to define
> >>reliability limit.
> >
> >We don't need _that_ ammount of overengineering. We just need to
> >synchronize them well enough :-).
>=20
> Well, it would be disappointing for the users to realize that
> they don't get the effect advertised by the ABI documentation.

Linux is always best-effort, w.r.t. timing. And we can do well enough
that user will not see anything bad on "normal" systems.

> >>We've had few attempts of approaching the subject of synchronized
> >>blinking but none of them proved to be good enough to be merged.
> >
> >I'm sure interested person could do something like that in less than
> >two weeks fulltime... It is not rocket science, just a lot of work in
> >kernel...
> >
> >But patterns are few years overdue and I believe we should not delay
> >them any further.
> >
> >So... I guess I agree with Jacek in the end :-).
>=20
> How about taking Baolin's patches as of v5? Later, provided that
> the pattern trigger yet to be implemented will create pattern file
> on activation, we'll need to initialize default-trigger DT property,
> to keep the interface unchanged.

I have yet to look at the v5 of patches. But I agree that we do not
need to design synchronization at this moment.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltOWnQACgkQMOfwapXb+vK+BgCgi8BFHlK77ZlmasnTYuSICrbz
uc8AoMCy1B/YoIs4mGUQwRRpUrFC11SW
=kX9A
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
