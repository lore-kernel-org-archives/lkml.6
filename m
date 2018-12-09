Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F442C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC092081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 08:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC092081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeLIIpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 03:45:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51645 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 03:45:02 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8680B80842; Sun,  9 Dec 2018 09:44:55 +0100 (CET)
Date:   Sun, 9 Dec 2018 09:44:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Benson Leung <bleung@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Message-ID: <20181209084458.GC7561@amd>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
 <20181201150934.GA7052@amd>
 <20181203195845.GA120704@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20181203195845.GA120704@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Sat, Dec 01, 2018 at 04:09:34PM +0100, Pavel Machek wrote:
> > > I think that handle this via dt / ACPI is not possible for our use ca=
se. It can
> > > be a hardware bug or a hardware/user constrain, let me try to explain=
 better
> > > with an example.
> > >=20
> > > On Pixel C's devices, userspace uses this to set a USB input limit of=
 5V when
> > > the screen is on for thermal reasons, but those go away when the scre=
en is
> > > off/system is sleeping, so we allow 9V and 12V levels when sleeping.
> >=20
> > So, on pixel C, what happens if userland ignores the constraint, keeps
> > display on and sets charger to 12V?
>=20
> I was the software tech lead for the Google Pixel C and was involved in t=
his
> particular code change in 2015 before the release of the product.
>=20
> So there's nothing fundamentally broken about the hardware that would cau=
se
> the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V
> when the screen is on, ie if userspace doesn't change this.
>=20
> This is part of the Pixel C's thermal management strategy to effectively
> limit the input power to 5V 3A when the screen is on. When the screen is =
on,
> the display, the CPU, and the GPU all contribute more heat to the system
> than while the screen is off, and we made a tradeoff to throttle the char=
ger
> in order to give more of the thermal budget to those other components.
>=20
> What would happen is that you wouldn't meet Google's skin temperature tar=
gets
> on the system if the charger was allowed to run at 9V or 12V with the scr=
een
> on.

So... the system is still guaranteed to work. It may be hot but not
dangerously so, and lifetime of internal components is not going to be
decreased by heat...?

Ok, I guess in such case we can do it from userspace.

> For folks hacking on Pixel Cs (which is now outside of Google's official =
support
> window for Android) and customizing their own kernel and userspace
> this would be acceptable, but we wanted to expose this feature in the pow=
er
> supply properties because the feature does exist in the Emedded Controller
> firmware of the Pixel C and all of Google's Chromebooks with USB-C made s=
ince
> 2015 in case someone running an up to date kernel wanted to limit the cha=
rging
> power for thermal or other reasons.

Few concerns:

1) You are basically using voltage limit to limit power. We already
have current limits, but what both you and existing user really want
are power limits. Should we have power limit instead? Would be way
more logical.

(If your charger can do 5V 1A, 5V 2.5A, 5V 3A, 9V 1A, you may want to
limit to first two, not first three).

2) Should the policy be based not on "screen is on or off" but on real
temperatures? We already have a thermal framework, and other machines
have "limit charging power when hot" constraints IIRC...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwM1goACgkQMOfwapXb+vJv0gCgsr7ZDS0A6iriYG+VFsldqQRI
7z8AnjBp0j1pAdISFg1ZxkwoDpNRRlvA
=3b1Z
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
