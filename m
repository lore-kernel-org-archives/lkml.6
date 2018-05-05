Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AB8JxZo3vB44orljiGTg+BW5OD3EnVIUOV0koJIKatE+He6dac7XcUTMmMADMYdDMKowd5U7D1UR
ARC-Seal: i=1; a=rsa-sha256; t=1525554690; cv=none;
        d=google.com; s=arc-20160816;
        b=l9hIkXdCsttssUrGbZo0aL4qcRfSzws9cSwwyvVnz0tkQuTZyeENxPzYlnNftlv/AV
         psv2zzdUnoPZq5Ev1RSXTZom+5gbvBDIZTEwRy1+ox5DlRM0Z0IU7fSMZMnx4jZ/o/o7
         aZDkv34QuSwQ6zCWTYTgMLyWQg3HXEc946rwVWKwHCrppKEWiZdVWMooTaBJPcuj37vv
         qqF1CPcyrvAc70uSGIO4nxrNrCQvQy7KFlFmKYn/i6C+RvzDIFhHO/PSYe4hebsfj31J
         X/4wdqd2IqEZJ1lStjgqOw8G1B3CS18DD4aDOVzENB6nbcf9GmgEI5NfGHayN5W/zgNy
         pB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6FM6jXIfnfDkgyouNczYV2veW5MuHgXWGwuTshGQdgs=;
        b=BnzhqT6iU7l718BJ/zyiy4IMBF39wIEjCaim1yEa4SFELLp/CsIhmaqFRgbRV1zkwe
         K+K8mvmyLR8/p/rlfF4jcVUD5bXUG23q4KQCAJ8PA9HHTapY73x0yBfA5/vJFfQUUE9F
         RUjrPhRc1xCbjUCGhi15Dv1ijEhDJk15vhXD9bt8+ngK8rxLX18EOGl+0mMVDwIeW+6i
         P2EgTng0P73B5o89uKDbpsX8SL4lpzKeSBfcMsc48RKwCkKd7/j6Vg7vrSxNw5M6b2lm
         wzgWYcJMAosb1Clgo3TUCSz9e3O2mOhSNKJfI29EqQ8EmmRck/ZpEKz4boN0TM8MJFBG
         A0qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Sat, 5 May 2018 23:11:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180505211129.GA762@amd>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180504200315.GA22519@amd>
 <20180505172847.qqpqkrfspak53sc6@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20180505172847.qqpqkrfspak53sc6@earth.universe>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599660035267793455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > (*) I have those in mind:
> > >=20
> > > Nokia N900: The phone has GPS integrated into the modem and uses
> > > ISI encapsulated data. The protocol has been reverse engineered
> > > and it should be possible to write a kernel driver for handling
> > > the GPS packets and dumping the raw data to /dev/gnss0. I don't
> > > think this is particularly useful without a non-raw interface,
> > > though. It would still require a custom userspace implementation.
> >=20
> > Actually... in this case it would be nice to do the protocol
> > processing in kernel and just present reasonable interface to
> > userland... or maybe NMEA.
>=20
> Converting a binary protocol to NMEA, which needs to be string
> parsed is not very nice. I think first step would be to write a
> simple driver, which exposes the binary location protocol without
> ISI header. Then in a second step we can think about a reasonable
> interface, that should be supported by all GNSS devices.

Well, most of the userspace expects NMEA. So yes, its an ugly
protocol, but .. it is not really a high-performance device.

I'd suggest modeling this over input subsystem. We could use similar
tag/value/sync protocol (evdev). In similar way /dev/input/mice was
used for running legacy apps during transition, we'd have /dev/...//nmea.

> > > Droid 4: GPS is similar to N900, but different protocol and QMI
> > > encapsulated. This one also has known protocol with userspace
> > > implementation. I did not yet have a detailed look, if its possible
> > > to (un)wrap this in the kernel.
> >=20
> > So, this is actually NMEA over QMI. I do have patches libqmi that
> > provides NMEA on stdout.
>=20
> Ok. So raw data is NMEA for this one. Should be reasonably easy to
> write a driver exposing this via /dev/gnss device.

If we have qmi implementation somewhere in kernel. Do we?

> > But there seems to be another possibile interface (yes, that modem is
> > crazy, and you can talk to it over few different interfaces), and
> > that's NMEA over GSM07.10. That one should be feasible to decode in
> > kernel and just provide NMEA to userland.
>=20
> I think both should be feasible. I suggest to wait a bit more
> until you and Tony figured out some more details. You've got
> the libqmi patch as workaround for now and we want a stable API
> later.

I do have the gsm07.10 one now, too. That one is certainly simple
enough (and should eat less power -- no need to keep USB running).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlruHgEACgkQMOfwapXb+vJk1gCeMYvDY4pls3Zdi4tZvHvF5ox4
bIIAmwR23q1w4QTtHnXRq8T4qcEh3J9M
=z0kI
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
