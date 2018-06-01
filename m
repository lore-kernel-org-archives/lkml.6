Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeFAJuJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:50:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44314 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeFAJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:50:07 -0400
X-Google-Smtp-Source: ADUXVKKMjKFUzc8l4yio6rwdqAqr5ZKnQZUm8KBY0z+pfhmF27IcgtISwFGW16DTTT02YItavYq5FQ==
Date: Fri, 1 Jun 2018 11:49:59 +0200
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
Message-ID: <20180601094959.GA13775@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180601093311.GA31639@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601093311.GA31639@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:33:11AM +0200, Pavel Machek wrote:
> Hi!
> 
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers).
> > 
> > While GNSS receivers are typically accessed using a UART interface they
> > often also support other I/O interfaces such as I2C, SPI and USB, while
> > yet other devices use iomem or even some form of remote-processor
> > messaging (rpmsg).
> > 
> > The new GNSS subsystem abstracts the underlying interface and provides a
> > new "gnss" class type, which exposes a character-device interface (e.g.
> > /dev/gnss0) to user space. This allows GNSS receivers to have a
> > representation in the Linux device model, something which is important
> > not least for power management purposes and which also allows for easy
> > detection and identification of GNSS devices.
> > 
> > Note that the character-device interface provides raw access to whatever
> > protocol the receiver is (currently) using, such as NMEA 0183, UBX or
> > SiRF Binary. These protocols are expected to be continued to be handled
> > by user space for the time being, even if some hybrid solutions are also
> > conceivable (e.g. to have kernel drivers issue management commands).
> 
> So.. while you did good work on serial power management, this is
> grossly misnamed. There's nothing GNSS specific in the code, and you
> are not presenting consistent interface to the userland.
> 
> This is _not_ GNSS subsystem. This is serial power management
> subsystem, or something like that. GPS/GNSS subsystem will need to be
> built on top of this.

I thought we had this discussion already.

This series adds an abstraction for GNSS receivers so that they can be
detected by userspace without resorting to probing hacks. That is GNSS
specific.

Furthermore, (since v2) we export a GNSS receiver type, which allows
further protocol detection hacks to be dropped, something which is also
GNSS specific.

The two drivers and library added are for GNSS devices and their
specific power management needs, while a random serial-connected device
may need to manage power differently. Also GNSS specific.

Finally, the GNSS subsystem is clearly not serial (as in UART) specific
and works just as fine with I2C, SPI, USB, iomem, rproc or whatever
interface the GNSS uses.

> This will never handle devices like Nokia N900, where GPS is connected
> over netlink.

Marcel already suggested adding a ugnss interface, which would allow
feeding GNSS data through the generic GNSS interface from user space for
use cases where it's not (yet) feasible to implement a kernel driver.

> > Another possible extension is to add generic 1PPS support.
> 
> And there's nothing GNSS specific in the patches.

I disagree.

Johan
