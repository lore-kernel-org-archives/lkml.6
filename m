Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeE3LfK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:35:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40452 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeE3LfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:35:04 -0400
X-Google-Smtp-Source: ADUXVKJY+qEPIkfynzr2V8Rs65Vk+eMMAZRAelvIvl2rINH/9yU7+kuBOLsfRlHgprRv25Oep6rFGA==
Date: Wed, 30 May 2018 13:34:59 +0200
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
Subject: Re: [PATCH v3 2/3] Documentation: usb: add documentation for USB
 CCID Gadget Device
Message-ID: <20180530113459.GC2939@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <20180529185021.13738-2-marcus.folkesson@gmail.com>
 <f4cdc62c-8bbe-28f9-0e7a-b4943d6f6a4f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4cdc62c-8bbe-28f9-0e7a-b4943d6f6a4f@infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, May 29, 2018 at 01:27:23PM -0700, Randy Dunlap wrote:
> On 05/29/2018 11:50 AM, Marcus Folkesson wrote:
> > Add documentation to give a brief description on how to use the
> > CCID Gadget Device.
> > This includes a description for all attributes followed by an example on
> > how to setup the device with ConfigFS.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> > 
> > Notes:
> >     v3:
> >     	- correct the grammer (thanks Randy)
> >     v2:
> >     	- add the missing changelog text
> > 
> >  Documentation/usb/gadget_ccid.rst | 267 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 267 insertions(+)
> >  create mode 100644 Documentation/usb/gadget_ccid.rst
> > 
> > diff --git a/Documentation/usb/gadget_ccid.rst b/Documentation/usb/gadget_ccid.rst
> > new file mode 100644
> > index 000000000000..524fe9e6ac19
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
> > +These endpoints are exposed to userspace via /dev/ccidg*.
> > +
> > +All CCID commands are sent on the BULK-OUT endpoint. Each command sent to the CCID
> > +has an associated ending response. Some commands can also have intermediate
> > +responses. The response is sent on the BULK-IN endpoint.
> > +See Figure 3-3 in the CCID Specification [1]_ for more details.
> > +
> > +The CCID commands must be handled in userspace since the driver is only working
> > +as a transport layer for the TPDUs.
> 
> I think that it would be helpful to tell us what the naming of the /dev/ccidg*
> endpoints looks like.  Also, how to distinguish the BULK-IN from the BULK-OUT
> endpoint.

You are right, it is not clear.

The devices are named as /dev/ccidg[0-4] and is per device.
Writing/reading to the device is using BULK-IN/BULK-OUT, the /dev/ccidg*
device is not bound to a particular endpoint.

I will come up with something that make it more clear.

Thank you!


> 
> > +
> > +
> > +CCID Commands
> > +--------------
> > +
> > +All CCID commands begins with a 10-byte header followed by an optional
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
> > +All CCID commands specify which slot is the receiver in the `bSlot` field
> > +of the CCID header.
> > +
> > +Usage
> > +=====
> > +
> > +Access from userspace
> > +----------------------
> > +All communication is by read(2) and write(2) to the corresponding /dev/ccidg* device.
> > +Only one file descriptor is allowed to be open to the device at a time.
> 
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> 
> thanks,
> -- 
> ~Randy

Best regards,
Marcus Folkesson
