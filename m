Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC4C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537F721898
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537F721898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeHEUhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 16:37:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56947 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726447AbeHEUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 16:37:21 -0400
Received: (qmail 29800 invoked by uid 500); 5 Aug 2018 14:31:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2018 14:31:53 -0400
Date:   Sun, 5 Aug 2018 14:31:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
In-Reply-To: <20180804191956.GA5639@roeck-us.net>
Message-ID: <Pine.LNX.4.44L0.1808051424440.29532-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2018, Guenter Roeck wrote:

> On Sat, Aug 04, 2018 at 10:50:15AM -0400, Alan Stern wrote:
> > On Fri, 3 Aug 2018, Guenter Roeck wrote:
> > 
> > > Testing an USB drive connected to ohci-sm501 results in a large number
> > > of runtime warnings.
> > > 
> > > WARNING: CPU: 0 PID: 0 at ./include/linux/dma-mapping.h:541
> > > hcd_buffer_free+0x148/0x178
> > > Modules linked in:
> > > 
> > > CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc7-00014-g7ec386e4c991-dirty
> > > PC is at hcd_buffer_free+0x148/0x178
> > > PR is at hcd_buffer_free+0x66/0x178
> > > PC  : 8c26cbb0 SP  : 8c481da8 SR  : 400080f1
> > > TEA : c00c8fe0
> > > R0  : 000000f0 R1  : 000000f0 R2  : 8f9bb890 R3  : 00000000
> > > R4  : 8f9c8800 R5  : 00001004 R6  : b07c6000 R7  : 007c6000
> > > R8  : 00001004 R9  : 8f9bb814 R10 : 8c388104 R11 : 007c6000
> > > R12 : b07c6000 R13 : 8f875680 R14 : 00000000
> > > MACH: 000002fe MACL: 0000017c GBR : 00000000 PR  : 8c26cace
> > > 
> > > Call trace:
> > >  [<(ptrval)>] usb_hcd_unmap_urb_for_dma+0xf4/0x13c
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] __usb_hcd_giveback_urb+0x2e/0xdc
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] finish_urb+0x8a/0x164
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] printk+0x0/0x48
> > >  [<(ptrval)>] ohci_work.part.11+0x150/0x41c
> > >  [<(ptrval)>] td_done.isra.4+0x0/0x11c
> > >  [<(ptrval)>] vprintk_default+0x14/0x20
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] ohci_irq+0x20c/0x314
> > >  [<(ptrval)>] usb_hcd_irq+0x16/0x28
> > > 
> > > Code analysis shows that interrupts are indeed disabled in ohci_irq().
> > > Handle the situation by setting the HCD_BH flag in the ohci-sm501 driver.
> > > With this flag set, urbs are released in a tasklet and not by the
> > > interrupt handler.
> > > 
> > > Fixes: f54aab6ebcecd ("usb: ohci-sm501 driver")
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Unfortunately, one must not simply turn on this flag.  Doing so will
> > violate some of the documented requirements for scheduling of periodic
> > transfers.  Significantly deeper changes to the OHCI driver are
> > necessary before the flag is set.
> > 
> 
> Well, it was worth a try. Note that I did try to figure out if there are
> any pitfalls when setting HCD_BH, but I didn't find anything. Reminds me
> of Hitchhiker through the Galaxy for some reason.

The interactions are pretty subtle, and the descriptions are hidden in
the kerneldoc for usb_submit_urb and usb_unlink_urb.  ehci-hcd, for
example, required a number of non-obvious changes when it was converted
to use HCD_BH.  If anyone wants to write something similar for
ohci-hcd I'll be happy to review it, but I don't want to write it
myself.  (Besides, speeding up the time spent in interrupt handling 
seems less urgent for OHCI, which runs much slower than EHCI and is 
not getting used very much in new hardware.)

Another way to attack this problem would be to allow DMA unmapping in 
interrupt context.  I have never understood why DMA mapping is okay 
with this but unmapping isn't.

Alan Stern

