Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68645C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391221D08
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1391221D08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeGBRTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:19:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39506 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752445AbeGBRTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:19:46 -0400
Received: (qmail 4343 invoked by uid 2102); 2 Jul 2018 13:19:45 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Jul 2018 13:19:45 -0400
Date:   Mon, 2 Jul 2018 13:19:45 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb/host/pci-quirks: Only reset USB bus on NVIDIA devices
In-Reply-To: <Pine.LNX.4.44L0.1807021233400.1574-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1807021302210.1574-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, Alan Stern wrote:

> > >> The problem is, that currently 100 ms sleep is over 10 % of the overall
> > >> execution time of the Linux kernel here. So I really like to not sleep
> > >> if it’s not needed.
> > > 
> > > It would be nice to execute the probes in parallel; that would reduce
> > > the total delay to 50 ms.  However, that is the subject of a separate
> > > discussion.
> > > 
> > >>> Besides, doesn't it seem like a bad idea to reset the controller while
> > >>> leaving devices on the USB bus in whatever state they happened to be?
> > >>
> > >> Yes, it’s probably not optimal.
> > >>
> > >> I wonder if the reset is needed, if the firmware has already initialized
> > >> the device.
> > > 
> > > The devices on the bus need to be reset, because the OS has no idea of
> > > what they are and what the firmware has them doing.
> > > 
> > > For example, the firmware may have assigned bus address 2 to a
> > > keyboard.  But the OS can initialize the devices in a different order,
> > > and it might want to assign bus address 2 to a USB drive.  Then you'd
> > > have two devices trying to use the same address at the same time, which
> > > would not be a good thing.
> > 
> > Understood.
> > 
> > So, what would be a way forward? Add a whitelist for boards or chipsets
> > not needing the 50 ms delay?
> 
> The 50-ms delay isn't for the board or the chipset; it is for the USB 
> devices that are plugged into the controller.  It is required by the 
> USB spec, so we can't get rid of it.

I may have been too hasty.  The drivers for other types of USB host
controllers do not perform a USB bus reset during startup, so maybe
OHCI doesn't really need it either.

We still need to put the controller into the correct state, but what 
happens to the bus shouldn't matter.  This is because reinitializing 
the controller disables all its ports, and the only way to enable a 
port is by sending a reset signal through it.  So the attached devices 
will end up getting reset one way or another, even if we don't do it 
explicitly during the handoff.

Therefore in theory we should be okay without the 50-ms delay at all.  
And we might as well tell the controller to go into the USB_RESET even
if it already is in that state; testing the current state is more
effort than just doing setting it.  Something like the patch below
ought to work, although I wouldn't submit it for the -stable kernels
since it doesn't fix a real bug.

It's not clear why OHCI has both a USB_RESET state and a 
HostControllerReset command, especially since the command changes the 
state to USB_SUSPEND instead of USB_RESET.  This is just one of several 
odd things in the OHCI specification.

Alan Stern



Index: usb-4.x/drivers/usb/host/pci-quirks.c
===================================================================
--- usb-4.x.orig/drivers/usb/host/pci-quirks.c
+++ usb-4.x/drivers/usb/host/pci-quirks.c
@@ -783,15 +783,9 @@ static void quirk_usb_handoff_ohci(struc
 	/* disable interrupts */
 	writel((u32) ~0, base + OHCI_INTRDISABLE);
 
-	/* Reset the USB bus, if the controller isn't already in RESET */
-	if (control & OHCI_HCFS) {
-		/* Go into RESET, preserving RWC (and possibly IR) */
-		writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
-		readl(base + OHCI_CONTROL);
-
-		/* drive bus reset for at least 50 ms (7.1.7.5) */
-		msleep(50);
-	}
+	/* Go into the USB_RESET state, preserving RWC (and possibly IR) */
+	writel(control & OHCI_CTRL_MASK, base + OHCI_CONTROL);
+	readl(base + OHCI_CONTROL);
 
 	/* software reset of the controller, preserving HcFmInterval */
 	if (!no_fminterval)

