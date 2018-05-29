Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966756AbeE2U1f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:27:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbeE2U1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:27:31 -0400
Subject: Re: [PATCH v3 2/3] Documentation: usb: add documentation for USB CCID
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
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <20180529185021.13738-2-marcus.folkesson@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4cdc62c-8bbe-28f9-0e7a-b4943d6f6a4f@infradead.org>
Date: Tue, 29 May 2018 13:27:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180529185021.13738-2-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 11:50 AM, Marcus Folkesson wrote:
> Add documentation to give a brief description on how to use the
> CCID Gadget Device.
> This includes a description for all attributes followed by an example on
> how to setup the device with ConfigFS.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v3:
>     	- correct the grammer (thanks Randy)
>     v2:
>     	- add the missing changelog text
> 
>  Documentation/usb/gadget_ccid.rst | 267 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
>  create mode 100644 Documentation/usb/gadget_ccid.rst
> 
> diff --git a/Documentation/usb/gadget_ccid.rst b/Documentation/usb/gadget_ccid.rst
> new file mode 100644
> index 000000000000..524fe9e6ac19
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
> +These endpoints are exposed to userspace via /dev/ccidg*.
> +
> +All CCID commands are sent on the BULK-OUT endpoint. Each command sent to the CCID
> +has an associated ending response. Some commands can also have intermediate
> +responses. The response is sent on the BULK-IN endpoint.
> +See Figure 3-3 in the CCID Specification [1]_ for more details.
> +
> +The CCID commands must be handled in userspace since the driver is only working
> +as a transport layer for the TPDUs.

I think that it would be helpful to tell us what the naming of the /dev/ccidg*
endpoints looks like.  Also, how to distinguish the BULK-IN from the BULK-OUT
endpoint.

> +
> +
> +CCID Commands
> +--------------
> +
> +All CCID commands begins with a 10-byte header followed by an optional
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
> +All CCID commands specify which slot is the receiver in the `bSlot` field
> +of the CCID header.
> +
> +Usage
> +=====
> +
> +Access from userspace
> +----------------------
> +All communication is by read(2) and write(2) to the corresponding /dev/ccidg* device.
> +Only one file descriptor is allowed to be open to the device at a time.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


thanks,
-- 
~Randy
