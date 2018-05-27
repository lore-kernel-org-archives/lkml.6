Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeE0Xgo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 19:36:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeE0Xgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 19:36:42 -0400
Subject: Re: [PATCH v2 2/3] Documentation: usb: add documentation for USB CCID
 Gadget Device
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180526211940.25474-1-marcus.folkesson@gmail.com>
 <20180526211940.25474-2-marcus.folkesson@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2225254e-a8f1-570e-8b1c-f68168376784@infradead.org>
Date: Sun, 27 May 2018 16:36:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180526211940.25474-2-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a few documentation comments below...

On 05/26/2018 02:19 PM, Marcus Folkesson wrote:
> Add documentation to give a brief description on how to use the
> CCID Gadget Device.
> This includes a description for all attributes followed by an example on
> how to setup the device with ConfigFS.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/usb/gadget_ccid.rst | 267 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
>  create mode 100644 Documentation/usb/gadget_ccid.rst
> 
> diff --git a/Documentation/usb/gadget_ccid.rst b/Documentation/usb/gadget_ccid.rst
> new file mode 100644
> index 000000000000..5ac806b14604
> --- /dev/null
> +++ b/Documentation/usb/gadget_ccid.rst
> @@ -0,0 +1,267 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
> +CCID Gadget
> +============
> +
> +:Author: Marcus Folkesson <marcus.folkesson@gmail.com>
> +
> +Introduction
> +============
> +
> +The CCID Gadget will present itself as a CCID device to the host system.
> +The device supports two endpoints for now; BULK IN and BULK OUT.
> +These endpoints is exposed to userspace via /dev/ccidg*.

                   are exposed

> +
> +All CCID commands are sent on the BULK-OUT endpoint. Each command sent to the CCID
> +has an associated ending response. Some commands can also have intermediate
> +responses. The response is sent on the BULK-IN endpoint.
> +See Figure 3-3 in the CCID Specification [1]_ for more details.
> +
> +The CCID commands must be handled in userspace since the driver is only working
> +as a transport layer for the TPDUs.
> +
> +
> +CCID Commands
> +--------------
> +
> +All CCID commands begins with a 10 bytes header followed by an optional

                            with a 10-byte header
(or maybe that's a locale difference)

> +data field depending on message type.
> +
> ++--------+--------------+-------+----------------------------------+
> +| Offset | Field        | Size  | Description                      |
> ++========+==============+=======+==================================+
> +| 0      | bMessageType | 1     | Type of message                  |
> ++--------+--------------+-------+----------------------------------+
> +| 1      | dwLength     | 4     | Message specific data length     |
> +|        |              |       |                                  |
> ++--------+--------------+-------+----------------------------------+
> +| 5      | bSlot        | 1     | Identifies the slot number       |
> +|        |              |       | for this command                 |
> ++--------+--------------+-------+----------------------------------+
> +| 6      | bSeq         | 1     | Sequence number for command      |
> ++--------+--------------+-------+----------------------------------+
> +| 7      | ...          | 3     | Fields depends on message type   |
> ++--------+--------------+-------+----------------------------------+
> +| 10     | abData       | array | Message specific data (OPTIONAL) |
> ++--------+--------------+-------+----------------------------------+
> +
> +
> +Multiple CCID gadgets
> +----------------------
> +
> +It is possible to create multiple instances of the CCID gadget, however,
> +a much more flexible way is to create one gadget and set the `nslots` attribute
> +to the number of desired CCID devices.
> +
> +All CCID commands specifies which slot that is the receiver in the `bSlot` field

                     specify which slot is the receiver

> +of the CCID header.
> +
> +Usage
> +=====
> +
> +Access from userspace
> +----------------------
> +All communication is by read(2) and write(2) to the corresponding /dev/ccidg* device.
> +Only one filedescriptor is allowed to be open to the device at a time.

            file descriptor

> +
> +The buffer size provided to read(2) **must be at least** 522 (10 bytes header + 512 bytes payload)
> +bytes as we are working with whole commands.
> +
> +The buffer size provided to write(2) **may not exceed** 522 (10 bytes header + 512 bytes payload)
> +bytes as we are working with whole commands.
> +
> +
> +Configuration with configfs
> +----------------------------
> +
> +ConfigFS is used to create and configure the CCID gadget.
> +In order to get a device to work as intended, a few attributes must
> +be considered.
> +
> +The attributes is described below followed by an example.

                  are

> +
> +features
> +~~~~~~~~~
> +
> +The `feature` attribute writes to the dwFeatures field in the class descriptor.
> +See Table 5.1-1 Smart Card Device Descriptors in the CCID Specification [1]_.
> +
> +The value indicates what intelligent features the CCID has.
> +These values are available to user application as defines in ccid.h [2]_.

                                                  as defined

> +The default value is 0x00000000.


[snip]

HTH.
-- 
~Randy
