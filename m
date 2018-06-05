Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeFEVr6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:47:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52335 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeFEVrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:47:55 -0400
Date: Tue, 5 Jun 2018 23:47:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180605214752.GB28143@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
 <20180601122217.GB13775@localhost>
 <20180601162645.GA30792@amd>
 <20180604102238.GC13775@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20180604102238.GC13775@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > udev solves device discovery pretty well; I don't think that's good
> > thing to optimize for.
>=20
> It's about grouping related devices together, devices which share some
> common functionality. In this case, providing location data from some
> satellite system. I really don't understand how you can find having a
> class type named "gnss" for this to be controversial in any way.

We normally group devices by interface, not by functionality.

> > (And.. I'd really prefer /dev/nmeaX and /dev/sirfX in that situation;
> > and yes that makes it _even easier_ for location service to find right
> > devices).=20
>=20
> As I've already explained, you may not know which protocol is currently
> active when the device start and you typically switch from NMEA to a
> vendor protocol during runtime (e.g. for configuration or to access raw
> GNSS data).
>=20
> Trying to encode the GNSS protocol in the character-device node name is
> just a bad idea.

I thought idea was to switch to the "best" protocol in kernel.

> > > Point is, you can't write a subsystem for everything. If it later tur=
ns
> > > out some part of the code can be shared internally, fine.
> >=20
> > True. But you can pick reasonable name for the subsystem :-).
>=20
> I find naming a subsystem for GNSS receivers "gnss" to be very
> reasonable. ;)

I don't. I'll explain why below.

> > Well, these days AT modems really have separate channels for commands
> > and data.
> >=20
> > > As mentioned in the cover letter, we may eventually want to add suppo=
rt
> > > for some kinds of configuration from within the kernel (e.g. protocol
> > > and line speed changes).
> >=20
> > I believe we'll eventually want "real" GPS drivers, with common
> > interface. input was in this situation before...
>=20
> As we also already discussed, there's nothing preventing you from trying
> to move gpsd into the kernel later. I doubt this is something we want,
> and it may turn out not to be feasible for other reasons.

Well -- I believe we want "gpsd in kernel". If you take /dev/gnss0 and
drivers/gnss now, where do I put them?

> And as you already acknowledged, this series does solve a problem we
> have today.

Yes. I'm not disputing that.

> > Anyway, it is trivial binary protocol over packets that are used for
> > modem communication. Handling it is like 40? lines of code.
>=20
> Ok, so I did read the damn thing along with the overview of the N900 GPS
> hardware and reverse-engineered protocol (why didn't you point me to
> those instead?) and I'm still not sure what the point you're trying to
> make is.

Umm. Where did you find the hardware overview/protocol overview?

> The n900 service you link to above, parses phonet data, does some
> *floating point* calculations and generates NMEA sentences which it
> feeds to a pseudo terminal whose slave side is opened by gpsd.
>=20
> That NMEA data could just as easily be fed through a different kernel
> subsystem, namely gnss instead of tty, where it could be accessed
> through a common interface (for now, a raw gnss interface, with some
> associated meta data). [ And from what I can tell, ugnss would also
> allow you to get rid of some hacks related to finding out when the GNSS
> is opened and needs to be powered on. ]
>=20
> So the ugnss interface looks like it will work for N900 just as it will
> for other phones.

Not NMEA please. First, NMEA has strange format of latitude/longitude
-- that's those calculations IIRC. NMEA has other problems, too --
like not atomically providing speeds and accuracies. Plus it is crazy
text protoco with CRCs.

> > NMEA would not be my first choice, really. I'd propose something very
> > similar to existing /dev/input/eventX, but with wider data types.
>=20
> Fine, you pursue that idea if you want then. I can see many problems
> with trying to so, but the point is, this series doesn't prevent you
> from doing so.

> If you think you'll one day be able to parse and repackage the various
> vendor protocols within the kernel, you can consider the raw gnss
> interface as an intermediate step (which may continue to exist in
> parallel just as say hidraw).
>=20
> As I've already mentioned, I considered naming the device nodes
> /dev/gnssraw0 partly because it would leave /dev/gnss namespace free for
> any such future development. I ultimately found that idea to be too
> implausible for it to be worth the potential confusion arising from the
> fact that "raw" GNSS data is already has an established meaning.
>=20
> But in the end, this is just name bike shedding.

So I agree /dev/gnssraw is not great. But /dev/gnss is even worse. And
yes, it is "just" a naming, but it will be impossible to fix later.

/dev/serdev? /dev/gnssproto?

> > Maybe we don't want to move _every_ GNSS protocol handler into kernel,
> > but I'm pretty sure we need to move _some_ of them there. It is
> > certainly best place for Nokia N900's protocol.
> >=20
> > And I'm trying to make sure we have suitable names available when that
> > happens.
>=20
> If that's the concern, we could reconsider naming the raw protocol
> interface /dev/gnnsraw0 as mentioned above.

I prfer /dev/gnssraw0 to /dev/gnss0.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsXBQgACgkQMOfwapXb+vIj6wCfSK+BIeSgiZRHGxC/UuDND3Px
Cr8AoKqhgmRGZWrH/5VQPyZIg0v2bet2
=k/LH
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
