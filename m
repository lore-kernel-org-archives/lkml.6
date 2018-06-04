Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeFDKWz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:22:55 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41606 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeFDKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:22:53 -0400
X-Google-Smtp-Source: ADUXVKLCQtrGNBDpbgvsJ+NIdkqXu3Db4O3h3KStk1STj4k2+LBjbljY05cCHmpIyw6Ivpg1rGdF0w==
Date: Mon, 4 Jun 2018 12:22:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180604102238.GC13775@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
 <20180601122217.GB13775@localhost>
 <20180601162645.GA30792@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162645.GA30792@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:26:46PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > So you have serial line + pm + protocol type. Nothing GNSS specific
> > > really, it would be useful to (for example) say this is modem with AT
> > > commands. Or this is QMI modem.
> > 
> > It's a matter of finding the right abstraction level. A user space
> > location service will now have easy access to the class of devices it
> > cares about, without having to go through a list of other random devices
> > which happen to use a similar underlying interface (e.g. a modem or
> > whatever).
> 
> udev solves device discovery pretty well; I don't think that's good
> thing to optimize for.

It's about grouping related devices together, devices which share some
common functionality. In this case, providing location data from some
satellite system. I really don't understand how you can find having a
class type named "gnss" for this to be controversial in any way.

> (And.. I'd really prefer /dev/nmeaX and /dev/sirfX in that situation;
> and yes that makes it _even easier_ for location service to find right
> devices). 

As I've already explained, you may not know which protocol is currently
active when the device start and you typically switch from NMEA to a
vendor protocol during runtime (e.g. for configuration or to access raw
GNSS data).

Trying to encode the GNSS protocol in the character-device node name is
just a bad idea.

> > Point is, you can't write a subsystem for everything. If it later turns
> > out some part of the code can be shared internally, fine.
> 
> True. But you can pick reasonable name for the subsystem :-).

I find naming a subsystem for GNSS receivers "gnss" to be very
reasonable. ;)

> > > > Finally, the GNSS subsystem is clearly not serial (as in UART) specific
> > > > and works just as fine with I2C, SPI, USB, iomem, rproc or whatever
> > > > interface the GNSS uses.
> > > 
> > > Ok, true. It is "we pass tty-like data across". Again, it would be
> > > useful for AT commands, too, and yes, they go over serials and usbs
> > > and more, too. 
> > 
> > Modems and GNSS devices would have different characteristics for buffers
> > and throughput for starters.
> > 
> > The GNSS interface uses a synchronous writes for commands to the
> > receiver, something which may not be appropriate for an outgoing data
> > channel, for example.
> 
> Well, these days AT modems really have separate channels for commands
> and data.
> 
> > As mentioned in the cover letter, we may eventually want to add support
> > for some kinds of configuration from within the kernel (e.g. protocol
> > and line speed changes).
> 
> I believe we'll eventually want "real" GPS drivers, with common
> interface. input was in this situation before...

As we also already discussed, there's nothing preventing you from trying
to move gpsd into the kernel later. I doubt this is something we want,
and it may turn out not to be feasible for other reasons.

And as you already acknowledged, this series does solve a problem we
have today.

> > > > > This will never handle devices like Nokia N900, where GPS is connected
> > > > > over netlink.
> > > > 
> > > > Marcel already suggested adding a ugnss interface, which would allow
> > > > feeding GNSS data through the generic GNSS interface from user space for
> > > > use cases where it's not (yet) feasible to implement a kernel
> > > > driver.
> > > 
> > > Yes, and ugnss would be at wrong layer for N900. First, lets take a
> > > look at N900 gps driver:
> > > https://github.com/postmarketOS/gps-nokia-n900
> > > 
> > > Got it? I'll eventually like to see it in the kernel, but your "GNSS"
> > > subsystem is unsuitable for it, as it does not talk well-known
> > > protocol.
> > 
> > Seriously? If you can't be arsed to summarise your use case, why would I
> > bother reading your random user space code?
> 
> You are trying to push subsystem to kernel. I believe asking you to do
> little research is not unexpected.

Waving your hands, saying this will never work, and pointing to some 600
lines of user-space code for an old phone isn't an argument. That is, at
best, just you being lazy.

> Anyway, it is trivial binary protocol over packets that are used for
> modem communication. Handling it is like 40? lines of code.

Ok, so I did read the damn thing along with the overview of the N900 GPS
hardware and reverse-engineered protocol (why didn't you point me to
those instead?) and I'm still not sure what the point you're trying to
make is.

The n900 service you link to above, parses phonet data, does some
*floating point* calculations and generates NMEA sentences which it
feeds to a pseudo terminal whose slave side is opened by gpsd.

That NMEA data could just as easily be fed through a different kernel
subsystem, namely gnss instead of tty, where it could be accessed
through a common interface (for now, a raw gnss interface, with some
associated meta data). [ And from what I can tell, ugnss would also
allow you to get rid of some hacks related to finding out when the GNSS
is opened and needs to be powered on. ]

So the ugnss interface looks like it will work for N900 just as it will
for other phones.

> > > I'd like to see "datapipe" devices (what you currently call GNSS) and
> > > "gps" devices, which would have common interface to the userland.
> > 
> > You keep talking about this "gps" interface, which based on your
> > earlier comments I assume you mean a NMEA 0183 interface? Again,
> > converting a vendor-specific binary protocol may not be feasible. Please
> > try to be more be specific.
> 
> I'm pretty sure we should have one protocol for communicating position
> data to userland. I don't want to go into details at the moment, as
> they are not important at the moment (and we could spend lot of time
> discussing details).
> 
> NMEA would not be my first choice, really. I'd propose something very
> similar to existing /dev/input/eventX, but with wider data types.

Fine, you pursue that idea if you want then. I can see many problems
with trying to so, but the point is, this series doesn't prevent you
from doing so.

If you think you'll one day be able to parse and repackage the various
vendor protocols within the kernel, you can consider the raw gnss
interface as an intermediate step (which may continue to exist in
parallel just as say hidraw).

As I've already mentioned, I considered naming the device nodes
/dev/gnssraw0 partly because it would leave /dev/gnss namespace free for
any such future development. I ultimately found that idea to be too
implausible for it to be worth the potential confusion arising from the
fact that "raw" GNSS data is already has an established meaning.

But in the end, this is just name bike shedding.

> > > N900 would not have any datapipe devices, but would have /dev/gps0
> > > exposing common GPS interface.
> > > 
> > > Droid4 would have /dev/datapipe0 (usb, AT protocol), /dev/datapipe1
> > > (usb, QMI protocol), /dev/datapipe2 (gsmtty over serial, custom AT
> > > protocol), /dev/datapipe3 (gsmtty over serial, NMEA wrapped in AT
> > > protocol) (and more, it is complex hardware). And if we really wanted,
> > > we'd have /dev/gps0, too, exposing common GPS interface.
> > > 
> > > Your devices would have /dev/datapipe0 with sirf or ublox or nmea
> > > protocol. In we really wanted, we'd have /dev/gps0, too, again,
> > > exposing common GPS interface.
> > 
> > This does not seem like the right abstraction level and doesn't appear
> > to provide much more than what we currently have with ttys.
> 
> I don't see what you are saying here. I've described your proposal but
> replaced /dev/gnss0 with /dev/datapipe0.

You're grouping unrelated devices into a new class with the descriptive
name "datapipe" (sarcasm).

Maybe one day we'll have a QMI subsystem, for example, but until someone
determines what that may end up looking like, I think we should stick
with the character device and tty abstractions we already have.

> > > I believe we really want to use your code for AT commands, too. And we
> > > really should keep GNSS/GPS names for future layer that actually
> > > provides single interface for userland.
> > 
> > Specifics, please. What would such an interface look like? I'm pretty
> > sure, we do not want to move every GNSS middleware protocol handler into
> > the kernel.
> 
> Maybe we don't want to move _every_ GNSS protocol handler into kernel,
> but I'm pretty sure we need to move _some_ of them there. It is
> certainly best place for Nokia N900's protocol.
> 
> And I'm trying to make sure we have suitable names available when that
> happens.

If that's the concern, we could reconsider naming the raw protocol
interface /dev/gnnsraw0 as mentioned above.

Thanks,
Johan
