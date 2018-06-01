Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeFAQ0v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:26:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49726 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFAQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:26:48 -0400
Date: Fri, 1 Jun 2018 18:26:46 +0200
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
Message-ID: <20180601162645.GA30792@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
 <20180601122217.GB13775@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20180601122217.GB13775@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So you have serial line + pm + protocol type. Nothing GNSS specific
> > really, it would be useful to (for example) say this is modem with AT
> > commands. Or this is QMI modem.
>=20
> It's a matter of finding the right abstraction level. A user space
> location service will now have easy access to the class of devices it
> cares about, without having to go through a list of other random devices
> which happen to use a similar underlying interface (e.g. a modem or
> whatever).

udev solves device discovery pretty well; I don't think that's good
thing to optimize for.

(And.. I'd really prefer /dev/nmeaX and /dev/sirfX in that situation;
and yes that makes it _even easier_ for location service to find right devi=
ces).=20

> Point is, you can't write a subsystem for everything. If it later turns
> out some part of the code can be shared internally, fine.

True. But you can pick reasonable name for the subsystem :-).

> > > Finally, the GNSS subsystem is clearly not serial (as in UART) specif=
ic
> > > and works just as fine with I2C, SPI, USB, iomem, rproc or whatever
> > > interface the GNSS uses.
> >=20
> > Ok, true. It is "we pass tty-like data across". Again, it would be
> > useful for AT commands, too, and yes, they go over serials and usbs
> > and more, too.=20
>=20
> Modems and GNSS devices would have different characteristics for buffers
> and throughput for starters.
>=20
> The GNSS interface uses a synchronous writes for commands to the
> receiver, something which may not be appropriate for an outgoing data
> channel, for example.

Well, these days AT modems really have separate channels for commands
and data.

> As mentioned in the cover letter, we may eventually want to add support
> for some kinds of configuration from within the kernel (e.g. protocol
> and line speed changes).

I believe we'll eventually want "real" GPS drivers, with common
interface. input was in this situation before...

>=20
> > > > This will never handle devices like Nokia N900, where GPS is connec=
ted
> > > > over netlink.
> > >=20
> > > Marcel already suggested adding a ugnss interface, which would allow
> > > feeding GNSS data through the generic GNSS interface from user space =
for
> > > use cases where it's not (yet) feasible to implement a kernel
> > > driver.
> >=20
> > Yes, and ugnss would be at wrong layer for N900. First, lets take a
> > look at N900 gps driver:
> > https://github.com/postmarketOS/gps-nokia-n900
> >=20
> > Got it? I'll eventually like to see it in the kernel, but your "GNSS"
> > subsystem is unsuitable for it, as it does not talk well-known
> > protocol.
>=20
> Seriously? If you can't be arsed to summarise your use case, why would I
> bother reading your random user space code?

You are trying to push subsystem to kernel. I believe asking you to do
little research is not unexpected.

Anyway, it is trivial binary protocol over packets that are used for
modem communication. Handling it is like 40? lines of code.

> > I'd like to see "datapipe" devices (what you currently call GNSS) and
> > "gps" devices, which would have common interface to the userland.
>=20
> You keep talking about this "gps" interface, which based on your
> earlier comments I assume you mean a NMEA 0183 interface? Again,
> converting a vendor-specific binary protocol may not be feasible. Please
> try to be more be specific.

I'm pretty sure we should have one protocol for communicating position
data to userland. I don't want to go into details at the moment, as
they are not important at the moment (and we could spend lot of time
discussing details).

NMEA would not be my first choice, really. I'd propose something very
similar to existing /dev/input/eventX, but with wider data types.

> > N900 would not have any datapipe devices, but would have /dev/gps0
> > exposing common GPS interface.
> >=20
> > Droid4 would have /dev/datapipe0 (usb, AT protocol), /dev/datapipe1
> > (usb, QMI protocol), /dev/datapipe2 (gsmtty over serial, custom AT
> > protocol), /dev/datapipe3 (gsmtty over serial, NMEA wrapped in AT
> > protocol) (and more, it is complex hardware). And if we really wanted,
> > we'd have /dev/gps0, too, exposing common GPS interface.
> >=20
> > Your devices would have /dev/datapipe0 with sirf or ublox or nmea
> > protocol. In we really wanted, we'd have /dev/gps0, too, again,
> > exposing common GPS interface.
>=20
> This does not seem like the right abstraction level and doesn't appear
> to provide much more than what we currently have with ttys.

I don't see what you are saying here. I've described your proposal but
replaced /dev/gnss0 with /dev/datapipe0.

> > I believe we really want to use your code for AT commands, too. And we
> > really should keep GNSS/GPS names for future layer that actually
> > provides single interface for userland.
>=20
> Specifics, please. What would such an interface look like? I'm pretty
> sure, we do not want to move every GNSS middleware protocol handler into
> the kernel.

Maybe we don't want to move _every_ GNSS protocol handler into kernel,
but I'm pretty sure we need to move _some_ of them there. It is
certainly best place for Nokia N900's protocol.

And I'm trying to make sure we have suitable names available when that
happens.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsRc8UACgkQMOfwapXb+vIUYQCfWBRdptVzx7ihIA84xlWbmLtK
LKUAn2yw5qvx7skw8Gen9Uc45eNq4yW0
=oYjG
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
