Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B692E2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B692E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeJZWpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:45:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42750 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726014AbeJZWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:45:06 -0400
Received: (qmail 2386 invoked by uid 2102); 26 Oct 2018 10:07:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Oct 2018 10:07:52 -0400
Date:   Fri, 26 Oct 2018 10:07:52 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Dennis Wassenberg <dennis.wassenberg@secunet.com>
cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: USB-C device hotplug issue
In-Reply-To: <8e750341-8fe5-9c66-0653-3c92d4a60505@secunet.com>
Message-ID: <Pine.LNX.4.44L0.1810261000040.1467-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018, Dennis Wassenberg wrote:

> >> --- a/drivers/usb/core/hub.c
> >> +++ b/drivers/usb/core/hub.c
> >> @@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
> >>  					USB_PORT_FEAT_C_BH_PORT_RESET);
> >>  			usb_clear_port_feature(hub->hdev, port1,
> >>  					USB_PORT_FEAT_C_PORT_LINK_STATE);
> >> -			usb_clear_port_feature(hub->hdev, port1,
> >> +
> >> +			if (!warm)
> >> +				usb_clear_port_feature(hub->hdev, port1,
> >>  					USB_PORT_FEAT_C_CONNECTION);
> >>  
> >>  			/*
> > 
> > The key fact is that connection events can get lost if they happen to 
> > occur during a port reset.
> Yes.
> > 
> > I'm not entirely certain of the logic here, but it looks like the
> > correct test to add should be "if (udev != NULL)", not "if (!warm)".  
> > Perhaps Mathias can confirm this
> I don't know if clearing the USB_PORT_FEAT_C_CONNECTION bit is
> correct in case of a non warm reset. In my case I always observed a
> warm reset because of the link state change.
> Thats why I checked the warm variable to not change the behavoir for
> cases a didn't checked for the first shot.

(The syntax of that last sentence is pretty mangled; I can't understand 
it.)

Think of it this way:

	If a device was not attached before the reset, we don't want
	to clear the connect-change status because then we wouldn't
	recognize a device that was plugged in during the reset.

	If a device was attached before the reset, we don't want any
	connect-change status which might be provoked by the reset to
	last, because we don't want the core to think that the device
	was unplugged and replugged when all that happened was a reset.

So the important criterion is whether or not a device was attached to 
the port when the reset started.  It's something of a coincidence that 
you only observe warm resets when there's nothing attached.

> During the first run of usb_hub_reset the udev is NULL because in
> this situation the device is not attached logically.
> 
> [  112.889810] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
> [  113.201192] usb 4-1-port1: XXX: hub_port_reset: udev:            (nil)!
> [  113.201198] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
> [  113.253612] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
> [  113.377208] usb 4-1-port1: XXX: hub_port_reset: udev: ffff88046b302800!
> [  113.377214] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
> [  113.429478] usb 4-1.1: new SuperSpeed USB device number 7 using xhci_hcd
> [  113.442370] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5596
> [  113.442376] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [  113.442381] usb 4-1.1: Product: Ultra T C 
> [  113.442385] usb 4-1.1: Manufacturer: SanDisk
> [  113.442388] usb 4-1.1: SerialNumber: 4C530001131013121031
> 
> Or maybe we can skip clearing the USB_PORT_FEAT_C_CONNECTION bit in
> case of hub_port_reset completely without any other check?

See above.

Alan Stern

