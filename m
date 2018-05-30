Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeE3K0t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:26:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33823 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeE3K0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:26:44 -0400
X-Google-Smtp-Source: ADUXVKLT2cCZ8YeGl94v7h86952RM1R7Hg/TWx4lAP42FSjmx4aP6HIJGGDD+Xa0GekLf5KNMGrL+w==
Date: Wed, 30 May 2018 12:26:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180530102639.GC3259@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180507102056.GU2285@localhost>
 <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
 <20180508070153.GX2285@localhost>
 <C8F35484-132F-466C-B87F-B209B2BC8B37@holtmann.org>
 <20180508124817.GZ2285@localhost>
 <0EFEDDD9-C21B-458B-884D-FC23F3D38B94@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EFEDDD9-C21B-458B-884D-FC23F3D38B94@holtmann.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Sorry about the late reply. I got side-tracked with other things.

On Tue, May 08, 2018 at 10:03:57PM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >>>>>> I have one concern, though. While providing raw data by
> >>>>>> default is fine generally, it is a problem with device
> >>>>>> auto-discovery. I think there should be some IOCTL from
> >>>>>> the start, that can be used to inform userspace about
> >>>>>> the raw protocol being used (i.e. "NMEA"). I fear, that
> >>>>>> userspace may start to just assume raw = NMEA without
> >>>>>> having this (especially since all initial drivers provide
> >>>>>> NMEA).
> >>>>> 
> >>>>> One problem I see here would be that the driver does not necessarily
> >>>>> know either what protocol is currently being used. Some devices have
> >>>>> boot-pins which can be used to configure the initial protocol used (and
> >>>>> this could perhaps be reflected in DT), but this can often later be
> >>>>> changed (by user space) and even be made persistent using battery-backed
> >>>>> ram or eeproms.
> >>>>> 
> >>>>> Also note that at least u-blox devices supports having more than one
> >>>>> protocol active on the same port...
> >>>> 
> >>>> as long as userspace can determine that it is GNSS hardware and what
> >>>> hardware it is, then you deal with the rest in userspace.
> >>> 
> >>> Yeah, I think that will do for now.
> >> 
> >> I forgot to mention that this part should be simple. So providing a
> >> DEVTYPE attribute that can be easily associated to the /dev/gnssX
> >> nodes is a must have here. Doing complex mapping of USB or DT layouts
> >> to figure out this is NMEA vs some vendor vs I need extra code to
> >> change the mode etc.
> > 
> > Yes, as I mentioned in the cover letter some kind of generic interface
> > for identifying the device type (and its features) should be defined
> > eventually.
> 
> I think this needs to be present from the start. Half backed
> subsystems are dangerous. And I really want to avoid hacking in
> userspace to figure out details about the hardware.

Fair enough. I've now added support for determining the GNSS type, which
reflects the protocol(s) supported by the device and which should allow,
for example, the gpsd protocol probing hack to be dropped.

Currently, there are three types defined:

	"NMEA"  NMEA 0183
        "SiRF"  SiRF Binary
        "UBX"   UBX

Note that both SiRF and UBX type devices typically support a subset of
NMEA 0183 with vendor extensions (e.g. to allow switching to the vendor
protocol).

> > Note that this is not necessarily something that is needed from the
> > start however as, for example, gpsd implements protocol detection.
> 
> That might be, but that is a total hack. Lets get this right from the
> get-go.

I agree; it's horrid.

Thanks,
Johan
