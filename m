Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D4FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C597520883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfAHW74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 17:59:56 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37897 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAHW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 17:59:56 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 93E92807FE; Tue,  8 Jan 2019 23:59:47 +0100 (CET)
Date:   Tue, 8 Jan 2019 23:59:52 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: Generic RGB LED support was Re: [PATCH 2/2] leds: lp5024: Add
 the LP5024/18 RGB LED driver
Message-ID: <20190108225952.GA13299@amd>
References: <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com>
 <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com>
 <20190105123146.GA16354@amd>
 <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com>
 <20190105221254.GA22322@amd>
 <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <dac50714-9caf-2496-3208-fb62f886e31f@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>Grab yourself an RGB LED and play with it; you'll see what the
> >>>problems are. It is hard to explain colors over email...
> >>
> >>Video [0] gives some overview of lp5024 capabilities.
> >>
> >>I don't see any problems in exposing separate red,green,blue
> >>files and brightness for the devices with hardware support for
> >>that.
> >
> >Well, that's what we do today, as three separate LEDs, right?
>=20
> No. It doesn't allow for setting color intensity by having
> the color fixed beforehand. Below is relevant excerpt from
> the lp5024 documentation. This is not something that can be
> mapped to RGB color space, but rather to HSV/HSL, with the
> reservation that the hardware implementation uses PWM
> for setting color intensity.

So they have feature where they have independent controls for each
channel, then one common control per three channels. Other chips have
common control for all the LEDs, for example. We don't support that
currently; lets focus on the RGB thing first.

> >I don't have problem with that, either; other drivers already do
> >that. He's free to use existing same interface.
> >
> >But that is insufficient, as it does not allow simple stuff, such as
> >turning led "white".
> >
> >So... perhaps we should agree on requirements, first, and then we can
> >discuss solutions?
> >
> >Requirements for RGB LED interface:
> >
> >1) Userspace should be able to set the white color
> >
> >2) Userspace should be able to arbitrary color from well known list
> >and it should approximately match what would CRT, LCD or OLED monitor di=
splay
>=20
> The difference is that monitor display driver is pre-calibrated
> for given display by the manufacturer. With the LED controllers the
> manufacturer has no control over what LEDs will be connected to the
> iouts. Therefore it should be not surprising that colors produced
> by custom LEDs are not as user would expect when comparing to
> the RGB color displayed on the monitor display.

It is true that _chip_ manufacturer can not know what LEDs will be
connected. But _system_ manufacturer can and should know that, and
should tell be able to tell us in the dts.

> This renders your requirement 2) infeasible with use of custom LEDs
> any fixed algorithm, since the final effect will always heavily depend
> on the LED circuit design.

Depending on LED circuit design and actual LEDs connected is okay.. we
just need to get information from _system_ designer (not chip
designer), and pass it to a place where color is computed.

> >a) RGB LEDs are usually not balanced. Setting 100% PWM on
> >red/green/blue channels will result in nothing close to white
> >light. In fact, to get white light on N900, blue and green channel's
> >PWM needs to be set pretty low, as in 5%.
> >
> >b) LED class does not define any relation between "brightness" in
> >sysfs and ammount of light in lumens. Some drivers use close to linear
> >relation, some use exponential relation. Human eyes percieve logarithm
> >of lumens. RGB color model uses even more complex function.
>=20
> One general question: do you have any solutions in store?

I played with LEDs on N900 over the weekend, yes.

And getting reasonable colors seems to be possible, when a) and b) are
solved... a) seems to be more important than b).

Now... this does not tell us how we should design kernel<->user
interface, but it should tell us that main goals - 1) and 2) are
possible.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw1K2cACgkQMOfwapXb+vJssgCdECJUPj0Ru8PJgm0ldaRU90TT
GYUAmwTaWvDbd+1OXIli2bRoOI4qIjjb
=SrHH
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
