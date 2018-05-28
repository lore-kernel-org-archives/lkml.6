Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeE1Hna (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:43:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38305 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbeE1HnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:43:25 -0400
X-Google-Smtp-Source: AB8JxZqiM1MKldCxZZg9jAYfxqK4qrDBayHr3HmpQCEDiZiuZOF4ACKRVcEYfix7FcNJa709WX6UNQ==
Date: Mon, 28 May 2018 09:42:58 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Documentation: usb: add documentation for USB
 CCID Gadget Device
Message-ID: <20180528074258.GA4651@gmail.com>
References: <20180526211940.25474-1-marcus.folkesson@gmail.com>
 <20180526211940.25474-2-marcus.folkesson@gmail.com>
 <2225254e-a8f1-570e-8b1c-f68168376784@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2225254e-a8f1-570e-8b1c-f68168376784@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, May 27, 2018 at 04:36:24PM -0700, Randy Dunlap wrote:
> Hi,
> 
> I have a few documentation comments below...
> 
> On 05/26/2018 02:19 PM, Marcus Folkesson wrote:
> > Add documentation to give a brief description on how to use the
> > CCID Gadget Device.
> > This includes a description for all attributes followed by an example on
> > how to setup the device with ConfigFS.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  Documentation/usb/gadget_ccid.rst | 267 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 267 insertions(+)
> >  create mode 100644 Documentation/usb/gadget_ccid.rst
> > 
> > diff --git a/Documentation/usb/gadget_ccid.rst b/Documentation/usb/gadget_ccid.rst
> > new file mode 100644
> > index 000000000000..5ac806b14604
> > --- /dev/null
> > +++ b/Documentation/usb/gadget_ccid.rst
> > @@ -0,0 +1,267 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============
> > +CCID Gadget
> > +============
> > +
> > +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> > +
> > +Introduction
> > +============
> > +
> > +The CCID Gadget will present itself as a CCID device to the host system.
> > +The device supports two endpoints for now; BULK IN and BULK OUT.
> > +These endpoints is exposed to userspace via /dev/ccidg*.
> 
>                    are exposed
> 
> > +
> > +All CCID commands are sent on the BULK-OUT endpoint. Each command sent to the CCID
> > +has an associated ending response. Some commands can also have intermediate
> > +responses. The response is sent on the BULK-IN endpoint.
> > +See Figure 3-3 in the CCID Specification [1]_ for more details.
> > +
> > +The CCID commands must be handled in userspace since the driver is only working
> > +as a transport layer for the TPDUs.
> > +
> > +
> > +CCID Commands
> > +--------------
> > +
> > +All CCID commands begins with a 10 bytes header followed by an optional
> 
>                             with a 10-byte header
> (or maybe that's a locale difference)
> 
> > +data field depending on message type.
> > +
> > ++--------+--------------+-------+----------------------------------+
> > +| Offset | Field        | Size  | Description                      |
> > ++========+==============+=======+==================================+
> > +| 0      | bMessageType | 1     | Type of message                  |
> > ++--------+--------------+-------+----------------------------------+
> > +| 1      | dwLength     | 4     | Message specific data length     |
> > +|        |              |       |                                  |
> > ++--------+--------------+-------+----------------------------------+
> > +| 5      | bSlot        | 1     | Identifies the slot number       |
> > +|        |              |       | for this command                 |
> > ++--------+--------------+-------+----------------------------------+
> > +| 6      | bSeq         | 1     | Sequence number for command      |
> > ++--------+--------------+-------+----------------------------------+
> > +| 7      | ...          | 3     | Fields depends on message type   |
> > ++--------+--------------+-------+----------------------------------+
> > +| 10     | abData       | array | Message specific data (OPTIONAL) |
> > ++--------+--------------+-------+----------------------------------+
> > +
> > +
> > +Multiple CCID gadgets
> > +----------------------
> > +
> > +It is possible to create multiple instances of the CCID gadget, however,
> > +a much more flexible way is to create one gadget and set the `nslots` attribute
> > +to the number of desired CCID devices.
> > +
> > +All CCID commands specifies which slot that is the receiver in the `bSlot` field
> 
>                      specify which slot is the receiver
> 
> > +of the CCID header.
> > +
> > +Usage
> > +=====
> > +
> > +Access from userspace
> > +----------------------
> > +All communication is by read(2) and write(2) to the corresponding /dev/ccidg* device.
> > +Only one filedescriptor is allowed to be open to the device at a time.
> 
>             file descriptor
> 
> > +
> > +The buffer size provided to read(2) **must be at least** 522 (10 bytes header + 512 bytes payload)
> > +bytes as we are working with whole commands.
> > +
> > +The buffer size provided to write(2) **may not exceed** 522 (10 bytes header + 512 bytes payload)
> > +bytes as we are working with whole commands.
> > +
> > +
> > +Configuration with configfs
> > +----------------------------
> > +
> > +ConfigFS is used to create and configure the CCID gadget.
> > +In order to get a device to work as intended, a few attributes must
> > +be considered.
> > +
> > +The attributes is described below followed by an example.
> 
>                   are
> 
> > +
> > +features
> > +~~~~~~~~~
> > +
> > +The `feature` attribute writes to the dwFeatures field in the class descriptor.
> > +See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
> > +
> > +The value indicates what intelligent features the CCID has.
> > +These values are available to user application as defines in ccid.h [2]_.
> 
>                                                   as defined
> 
> > +The default value is 0x00000000.
> 
> 
> [snip]
> 
> HTH.
> -- 
> ~Randy

Thank you for your comments, I will take it with me for v3.

Best regards
Marcus Folkesson
