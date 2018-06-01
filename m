Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeFAMWa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:22:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:47041 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFAMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:22:25 -0400
X-Google-Smtp-Source: ADUXVKIsKHhaGiUWpvkRN7gQ3ncT842Fi6i7kn/j9SifRupEazuSScIf1oMlnHdDp7AnB55sW2+1Mw==
Date: Fri, 1 Jun 2018 14:22:17 +0200
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
Message-ID: <20180601122217.GB13775@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
 <20180601094959.GA13775@localhost>
 <20180601102612.GC31639@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601102612.GC31639@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:26:12PM +0200, Pavel Machek wrote:
> On Fri 2018-06-01 11:49:59, Johan Hovold wrote:
> > On Fri, Jun 01, 2018 at 11:33:11AM +0200, Pavel Machek wrote:

> > This series adds an abstraction for GNSS receivers so that they can be
> > detected by userspace without resorting to probing hacks. That is GNSS
> > specific.
> > 
> > Furthermore, (since v2) we export a GNSS receiver type, which allows
> > further protocol detection hacks to be dropped, something which is also
> > GNSS specific.
> 
> So you have serial line + pm + protocol type. Nothing GNSS specific
> really, it would be useful to (for example) say this is modem with AT
> commands. Or this is QMI modem.

It's a matter of finding the right abstraction level. A user space
location service will now have easy access to the class of devices it
cares about, without having to go through a list of other random devices
which happen to use a similar underlying interface (e.g. a modem or
whatever).

> > The two drivers and library added are for GNSS devices and their
> > specific power management needs, while a random serial-connected device
> > may need to manage power differently. Also GNSS specific.
> 
> Or maybe it will need to manager power in the same way. How would the
> AT modem be different?

Point is, you can't write a subsystem for everything. If it later turns
out some part of the code can be shared internally, fine.

> > Finally, the GNSS subsystem is clearly not serial (as in UART) specific
> > and works just as fine with I2C, SPI, USB, iomem, rproc or whatever
> > interface the GNSS uses.
> 
> Ok, true. It is "we pass tty-like data across". Again, it would be
> useful for AT commands, too, and yes, they go over serials and usbs
> and more, too. 

Modems and GNSS devices would have different characteristics for buffers
and throughput for starters.

The GNSS interface uses a synchronous writes for commands to the
receiver, something which may not be appropriate for an outgoing data
channel, for example.

As mentioned in the cover letter, we may eventually want to add support
for some kinds of configuration from within the kernel (e.g. protocol
and line speed changes).

> > > This will never handle devices like Nokia N900, where GPS is connected
> > > over netlink.
> > 
> > Marcel already suggested adding a ugnss interface, which would allow
> > feeding GNSS data through the generic GNSS interface from user space for
> > use cases where it's not (yet) feasible to implement a kernel
> > driver.
> 
> Yes, and ugnss would be at wrong layer for N900. First, lets take a
> look at N900 gps driver:
> https://github.com/postmarketOS/gps-nokia-n900
> 
> Got it? I'll eventually like to see it in the kernel, but your "GNSS"
> subsystem is unsuitable for it, as it does not talk well-known
> protocol.

Seriously? If you can't be arsed to summarise your use case, why would I
bother reading your random user space code?

> I'd like to see "datapipe" devices (what you currently call GNSS) and
> "gps" devices, which would have common interface to the userland.

You keep talking about this "gps" interface, which based on your
earlier comments I assume you mean a NMEA 0183 interface? Again,
converting a vendor-specific binary protocol may not be feasible. Please
try to be more be specific.

> N900 would not have any datapipe devices, but would have /dev/gps0
> exposing common GPS interface.
> 
> Droid4 would have /dev/datapipe0 (usb, AT protocol), /dev/datapipe1
> (usb, QMI protocol), /dev/datapipe2 (gsmtty over serial, custom AT
> protocol), /dev/datapipe3 (gsmtty over serial, NMEA wrapped in AT
> protocol) (and more, it is complex hardware). And if we really wanted,
> we'd have /dev/gps0, too, exposing common GPS interface.
> 
> Your devices would have /dev/datapipe0 with sirf or ublox or nmea
> protocol. In we really wanted, we'd have /dev/gps0, too, again,
> exposing common GPS interface.

This does not seem like the right abstraction level and doesn't appear
to provide much more than what we currently have with ttys.

> I believe we really want to use your code for AT commands, too. And we
> really should keep GNSS/GPS names for future layer that actually
> provides single interface for userland.

Specifics, please. What would such an interface look like? I'm pretty
sure, we do not want to move every GNSS middleware protocol handler into
the kernel.

Johan
