Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C07C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500D720834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500D720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeLBCWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:22:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56654 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeLBCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:22:21 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6A63F80A46; Sat,  1 Dec 2018 16:09:31 +0100 (CET)
Date:   Sat, 1 Dec 2018 16:09:34 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com,
        bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Message-ID: <20181201150934.GA7052@amd>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> We have a problem with USBPD chargers which under certain conditions
> >> can result in system overheating if the voltage provided by the USBPD
> >> port is too high. While the preferred means to control this would be
> >> through devicetree or ACPI settings, this is not always possible, and
> >> we need to have a means to set a voltage limit.
> >>
> >> This patch exposes a new property, similar to input current limit, to
> >> re-configure the maximum voltage from the external supply at runtime
> >> based on system-level knowledge or user input.
> >=20
> > First, this should really be handled by dt / ACPI. If it is broken,
> > that's a hardware bug, and we can do DMI-based blacklists in kernel.
> >=20
>=20
> I think that handle this via dt / ACPI is not possible for our use case. =
It can
> be a hardware bug or a hardware/user constrain, let me try to explain bet=
ter
> with an example.
>=20
> On Pixel C's devices, userspace uses this to set a USB input limit of 5V =
when
> the screen is on for thermal reasons, but those go away when the screen is
> off/system is sleeping, so we allow 9V and 12V levels when sleeping.

So, on pixel C, what happens if userland ignores the constraint, keeps
display on and sets charger to 12V?

> > How are you supposed to fsck a system, for example?
> >=20
>=20
> hmm, I'm not sure I get the question, sorry, could you rephrase?

Ok, so I have just booted with init=3D/bin/bash, and would like to run
fsck.ext4 on my root filesystem.

> >> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> >> +Date:		Nov 2018
> >> +Contact:	linux-pm@vger.kernel.org
> >> +Description:
> >> +		Details the incoming VBUS voltage limit currently set in the
> >> +		supply. Normally this is configured based on the type of
> >> +		connection made.
> >=20
> > "Details"?
> >=20
> > Who can write to this value and when? What is the limit? If USB
> > charger is plugged in, should it show 5.0V (because that's nominal on
> > the USB) or 5.25V (because that is the real limit)?
>=20
> The voltages here refer to the Typical or Nominal values defined by the U=
SB
> specification for a Fixed power supply (or Fixed PDO). 5.0V, 5.25V, 4.75V,
> 5.5V... all of those are considered "5V" according to the USB specificati=
ons.
>=20
> At the 5V level (defined in the USB PD specification as vSafe5V), a nomin=
al
> power source is allowed to have a voltage between 4.75V and 5.50V (5V -5%/
> +10%). For simplicity, we refer to this range as 5V, the typical value.
> For all higher voltage levels other than vSafe5V, MIN voltage is PDO Volt=
age *
> 0.95, and MAX voltage is PDO Voltage * 1.05, where PDO Voltage is the Typ=
ical
> value (9V, 12V, 15V, 20V). [1]

> > Who can write to this and when. And what happens on write? What
> > happens if I write value that charger can't provide there?
> >=20
> > Does it set the voltage power supply should produce? Or maximal it can
> > choose to produce?
> >=20
>=20
> This defines a maximal voltage. If you write a value it can't provide,
> it should go down to the next lowest level, and barring that, 5V is
> always allowed.
>=20
> That makes me think that maybe I should also improve the implementation.
>=20
> > This really needs better documentation.
>=20
> Ack, I'll send a next version improving that.

Thanks.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwCpC4ACgkQMOfwapXb+vJ7uACcCRDA8FIQmuQCK/hagMsggeRk
D5kAnA+7vLPHIhWH3NHCkoY8AhnasD5b
=Rpx/
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
