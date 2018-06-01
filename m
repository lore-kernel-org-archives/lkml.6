Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeFAK0U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:26:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38580 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeFAK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:26:14 -0400
Date: Fri, 1 Jun 2018 12:26:12 +0200
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
Message-ID: <20180601102612.GC31639@amd>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20180601094959.GA13775@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-06-01 11:49:59, Johan Hovold wrote:
> On Fri, Jun 01, 2018 at 11:33:11AM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > > receivers).
> > >=20
> > > While GNSS receivers are typically accessed using a UART interface th=
ey
> > > often also support other I/O interfaces such as I2C, SPI and USB, whi=
le
> > > yet other devices use iomem or even some form of remote-processor
> > > messaging (rpmsg).
> > >=20
> > > The new GNSS subsystem abstracts the underlying interface and provide=
s a
> > > new "gnss" class type, which exposes a character-device interface (e.=
g.
> > > /dev/gnss0) to user space. This allows GNSS receivers to have a
> > > representation in the Linux device model, something which is important
> > > not least for power management purposes and which also allows for easy
> > > detection and identification of GNSS devices.
> > >=20
> > > Note that the character-device interface provides raw access to whate=
ver
> > > protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> > > SiRF Binary. These protocols are expected to be continued to be handl=
ed
> > > by user space for the time being, even if some hybrid solutions are a=
lso
> > > conceivable (e.g. to have kernel drivers issue management commands).
> >=20
> > So.. while you did good work on serial power management, this is
> > grossly misnamed. There's nothing GNSS specific in the code, and you
> > are not presenting consistent interface to the userland.
> >=20
> > This is _not_ GNSS subsystem. This is serial power management
> > subsystem, or something like that. GPS/GNSS subsystem will need to be
> > built on top of this.
>=20
> I thought we had this discussion already.

I don't remember useful discussion.

> This series adds an abstraction for GNSS receivers so that they can be
> detected by userspace without resorting to probing hacks. That is GNSS
> specific.
>=20
> Furthermore, (since v2) we export a GNSS receiver type, which allows
> further protocol detection hacks to be dropped, something which is also
> GNSS specific.

So you have serial line + pm + protocol type. Nothing GNSS specific
really, it would be useful to (for example) say this is modem with AT
commands. Or this is QMI modem.

> The two drivers and library added are for GNSS devices and their
> specific power management needs, while a random serial-connected device
> may need to manage power differently. Also GNSS specific.

Or maybe it will need to manager power in the same way. How would the
AT modem be different?

> Finally, the GNSS subsystem is clearly not serial (as in UART) specific
> and works just as fine with I2C, SPI, USB, iomem, rproc or whatever
> interface the GNSS uses.

Ok, true. It is "we pass tty-like data across". Again, it would be
useful for AT commands, too, and yes, they go over serials and usbs
and more, too.=20

> > This will never handle devices like Nokia N900, where GPS is connected
> > over netlink.
>=20
> Marcel already suggested adding a ugnss interface, which would allow
> feeding GNSS data through the generic GNSS interface from user space for
> use cases where it's not (yet) feasible to implement a kernel
> driver.

Yes, and ugnss would be at wrong layer for N900. First, lets take a
look at N900 gps driver:
https://github.com/postmarketOS/gps-nokia-n900

Got it? I'll eventually like to see it in the kernel, but your "GNSS"
subsystem is unsuitable for it, as it does not talk well-known
protocol.

I'd like to see "datapipe" devices (what you currently call GNSS) and
"gps" devices, which would have common interface to the userland.

N900 would not have any datapipe devices, but would have /dev/gps0
exposing common GPS interface.

Droid4 would have /dev/datapipe0 (usb, AT protocol), /dev/datapipe1
(usb, QMI protocol), /dev/datapipe2 (gsmtty over serial, custom AT
protocol), /dev/datapipe3 (gsmtty over serial, NMEA wrapped in AT
protocol) (and more, it is complex hardware). And if we really wanted,
we'd have /dev/gps0, too, exposing common GPS interface.

Your devices would have /dev/datapipe0 with sirf or ublox or nmea
protocol. In we really wanted, we'd have /dev/gps0, too, again,
exposing common GPS interface.

I believe we really want to use your code for AT commands, too. And we
really should keep GNSS/GPS names for future layer that actually
provides single interface for userland.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsRH0QACgkQMOfwapXb+vLpJACfX3PKHkTbEnqnKW8n2K9OBw5j
rqoAoLyZnYQV1o+iTZatpq92jFsoMSua
=wDg9
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
