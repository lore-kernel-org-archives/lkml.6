Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD08C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764FE2190B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394444AbfBOLq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:46:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54934 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391983AbfBOLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:46:26 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 4176E8036F; Fri, 15 Feb 2019 12:46:16 +0100 (CET)
Date:   Fri, 15 Feb 2019 12:46:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pre-shared passcode: secure pairing for "no keyboard, no
 display" devices
Message-ID: <20190215114622.GA32198@amd>
References: <20190213224859.GA7151@amd>
 <CAO1O6sdyJbo0LR9Lak+6yP0FKda4o66+8vwx4fE1fe36z2mDNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <CAO1O6sdyJbo0LR9Lak+6yP0FKda4o66+8vwx4fE1fe36z2mDNQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Currently, "no keyboard, no display" devices can be paired, but
> > pairing is not secure against active attacker.
> >
> > Can we do better? Not for the first pairing; but for the next ones --
> > yes, I believe we can.
> >
> > BLE device in this case has internal storage, and Linux running
> > there. From factory, random 6-digit number is stored in the
> > flash. Legitimate user knows the number, and system is manipulated so
> > that pairing passkey will be this pre-shared passkey. After pairing,
> > user is allowed to change it.
> >
> > [Or maybe passkey is 000000 from the factory; this is still win for
> > the user, as long as he can change the key to something random in a
> > secure cave.]
> >
> > Fortunately, kernel support for this is rather easy; patch is attached
> > below.
> >
> > Does someone see a security issue with proposal above?
>=20
> Assuming "LE Secure Connections" is used, the protocol is only secure
> if the passkey is not reused. A 6 digit passkey means 20 bits. The
> protocol is performed in 20 steps, where one bit is compared and
> revealed in every step. This means the attacker will know for every
> attempt the first bit that is incorrect in the attempted passkey. If
> the passkey is reused, the attacker can just try the same passkey with
> the incorrect bit flipped. In average it takes 10 attempts to crack
> the key and maximum 20 attempts. Hence, a static key doesn't really
> add much security compared to Just Works and might give a false sense
> of security.

Thanks a lot for quick reply. And no, that is not good.

Just Works basically means that there's no security at all, anyone
within range can connect when owner is not around, and do whatever
they want.

Is there some common way this is solved?

We do have pre-shared passkey, if only 20 bits. If we set
passkey =3D sha( pre-shared passkey + pairing_attempt++ ), would we get
some kind of meaningful security? Perhaps with limiting pairing
attempt to say 10 a day?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxmpo4ACgkQMOfwapXb+vJAaACgmHH3XYqK8JGSdVe7OUxD6m7q
hqQAn22Yg6q9iiUap1fZJ9VCIkaX/LGI
=TjF9
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
