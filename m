Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EFC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895E20874
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A895E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757027AbeFQBSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:18:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:34872 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756932AbeFQBSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:18:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5H1HhOk015814;
        Sat, 16 Jun 2018 20:17:44 -0500
Message-ID: <f2421fad1ea210b32a6813454832c0ed66770bf5.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 5/5] fsi/scom: Major overhaul
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun, 17 Jun 2018 11:17:43 +1000
In-Reply-To: <CACPK8Xcp4gEVOrNdcZhbDx9LU1K6d=tV0vmJ9nLut4Fjwp0Xpg@mail.gmail.com>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
         <20180612051911.20690-6-benh@kernel.crashing.org>
         <CACPK8Xcp4gEVOrNdcZhbDx9LU1K6d=tV0vmJ9nLut4Fjwp0Xpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-16 at 14:34 +0930, Joel Stanley wrote:
> On 12 June 2018 at 14:49, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > This was too hard to split ... this adds a number of features
> > to the SCOM user interface:
> > 
> >  - Support for indirect SCOMs
> > 
> >  - read()/write() interface now handle errors and retries
> > 
> >  - New ioctl() "raw" interface for use by debuggers
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Looks okay to me. I will put it in the openbmc tree with Eddie's ack
> for more testing.
> 
> I got a warning from the 0day infra, I made comments below.
> 
> We should get Alistair review the ioctl interface to ensure we have
> everything that pdbg might need.

We have everything that cronus needs and more than pdbg needs afaik :-)

That said, cronus does a bunch of other stupid things that I'm still
trying to figure out how to fix.

We might need to create a /dev/cfam rather than going through that
magic sysfs "raw" file, and I wouldn't mind using a single IDA so that
all the devices below a given FSI slace (cfam itself, sbefifo, occ,
...) have the same "number".

> 
> > +++ b/include/uapi/linux/fsi.h
> > @@ -0,0 +1,56 @@
> > +#ifndef _UAPI_LINUX_FSI_H
> > +#define _UAPI_LINUX_FSI_H
> > +
> > +#include <linux/ioctl.h>
> 
> This needs to include <linux/types.h> for the __u64 etc types.
> 
> We should also put a licence in the header. Probably:
> 
> /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */

Yup.

Cheers,
Ben.

> 
> Cheers,
> 
> Joel
> 
> > +
> > +/*
> > + * /dev/scom "raw" ioctl interface
> > + *
> > + * The driver supports a high level "read/write" interface which
> > + * handles retries and converts the status to Linux error codes,
> > + * however low level tools an debugger need to access the "raw"
> > + * HW status information and interpret it themselves, so this
> > + * ioctl interface is also provided for their use case.
> > + */
> > +
> > +/* Structure for SCOM read/write */
> > +struct scom_access {
> > +       __u64   addr;           /* SCOM address, supports indirect */
> > +       __u64   data;           /* SCOM data (in for write, out for read) */
> > +       __u64   mask;           /* Data mask for writes */
> > +       __u32   intf_errors;    /* Interface error flags */
> > +#define SCOM_INTF_ERR_PARITY           0x00000001 /* Parity error */
> > +#define SCOM_INTF_ERR_PROTECTION       0x00000002 /* Blocked by secure boot */
> > +#define SCOM_INTF_ERR_ABORT            0x00000004 /* PIB reset during access */
> > +#define SCOM_INTF_ERR_UNKNOWN          0x80000000 /* Unknown error */
> > +       /*
> > +        * Note: Any other bit set in intf_errors need to be considered as an
> > +        * error. Future implementations may define new error conditions. The
> > +        * pib_status below is only valid if intf_errors is 0.
> > +        */
> > +       __u8    pib_status;     /* 3-bit PIB status */
> > +#define SCOM_PIB_SUCCESS       0       /* Access successful */
> > +#define SCOM_PIB_BLOCKED       1       /* PIB blocked, pls retry */
> > +#define SCOM_PIB_OFFLINE       2       /* Chiplet offline */
> > +#define SCOM_PIB_PARTIAL       3       /* Partial good */
> > +#define SCOM_PIB_BAD_ADDR      4       /* Invalid address */
> > +#define SCOM_PIB_CLK_ERR       5       /* Clock error */
> > +#define SCOM_PIB_PARITY_ERR    6       /* Parity error on the PIB bus */
> > +#define SCOM_PIB_TIMEOUT       7       /* Bus timeout */
> > +       __u8    pad;
> > +};
> > +
> > +/* Flags for SCOM check */
> > +#define SCOM_CHECK_SUPPORTED   0x00000001      /* Interface supported */
> > +#define SCOM_CHECK_PROTECTED   0x00000002      /* Interface blocked by secure boot */
> > +
> > +/* Flags for SCOM reset */
> > +#define SCOM_RESET_INTF                0x00000001      /* Reset interface */
> > +#define SCOM_RESET_PIB         0x00000002      /* Reset PIB */
> > +
> > +#define FSI_SCOM_CHECK _IOR('s', 0x00, __u32)
> > +#define FSI_SCOM_READ  _IOWR('s', 0x01, struct scom_access)
> > +#define FSI_SCOM_WRITE _IOWR('s', 0x02, struct scom_access)
> > +#define FSI_SCOM_RESET _IOW('s', 0x03, __u32)
> > +
> > +#endif /* _UAPI_LINUX_FSI_H */
> > --
> > 2.17.0
> > 
