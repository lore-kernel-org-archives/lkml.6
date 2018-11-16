Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA55C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235F20858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3235F20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbeKQCe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:34:59 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34540 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728684AbeKQCe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:34:59 -0500
Received: (qmail 2262 invoked by uid 2102); 16 Nov 2018 11:21:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Nov 2018 11:21:57 -0500
Date:   Fri, 16 Nov 2018 11:21:57 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: hub: add I/O error retry & reset routine
In-Reply-To: <7f7ab25e6e1c9ff37edd46adfe12653d5c300778.camel@suse.de>
Message-ID: <Pine.LNX.4.44L0.1811161116210.1487-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Nicolas Saenz Julienne wrote:

> Hi Alan,
> thanks for the review.
> 
> On Thu, 2018-11-15 at 14:24 -0500, Alan Stern wrote:
> > On Thu, 15 Nov 2018, Nicolas Saenz Julienne wrote:
> > 
> > > An URB submission error in the HUB's endpoint completion function
> > > renders the whole HUB device unresponsive. This patch introduces a
> > > routine that retries the submission for 1s to then, as a last
> > resort,
> > > reset the whole device.
> > > 
> > > The implementation is based on usbhid/hid_core.c's, which
> > implements the
> > > same functionality. It was tested with the help of BCC's error
> > injection
> > > tool (inject.py).
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > Why do you think this is needed?  Are you experiencing these 
> > sorts of URB submission errors?
> 
> Sorry, I should have been more explicit on where I come from. I've been
> playing around injecting atomic allocation errors on the USB stack. For
> example any URB submission marked with GFP_ATOMIC that ends up into
> xhci will allocate some memory with that flag.
> 
> Most subsystems, after facing a burst of memory allocation failures,
> seem to recover well (usbnet/hid/uas/alsa/serial). But I found out that
> it's not the case for USB hubs: In the event of detecting a new device
> the hub will complete an int URB which was previously sent to it. The
> event data is saved by the host and the URB is resubmitted for further
> event passing. In the case that URB submission failed, we lose all
> further events.

Ah, I see.

> It is indeed pretty hard to find this issue in the wild, since you have
> to time plugging or unplugging an USB device with the system running
> out of memory. But I don't think it's unrealistic to think it might
> happen.
> 
> As I comment in the patch description, I'm injecting the errors using
> BCC and eBPF's function override capabilities.  
> 
> > 
> > Why do you handle only errors during submission but not during
> > completion?  And if you keep on getting errors during submission, why
> > would resetting the hub make any difference?
> 
> Well, as far as I know, errors during completion are handled. The error
> is marked in hub->error, which later-on, in hub-event(), triggers a
> device reset. 
> 
> While implementing the solution I took into account the hub's
> completion error processing behavior and HID's implementation of the
> submission error handling (see hid_irq_in() in usbhid/hid-core.c). My
> rationale was that since both HID and hub are USB devices with a
> similar behavior there was no point in reinventing a mechanism. That
> said I have no spec data to back the "1s retry window to then reset the
> device".
> 
> One could argue that in the event of an error having a timer running
> forever is not the best design. It has to stop sometime. If that's the
> case, the HUB will be in a unknown state, i.e. a device might have
> disappeared. Resetting the hub will at least unbind all the USB devices
> attached to it and retry the enumeration. Regardless of the
> enumeration's success we'll at least be in a "safe" state.

Well, the timer will get deleted when the hub is unplugged.  If that
doesn't happen, we can assume that the hub has retained its state and
so a reset isn't necessary.

I would just keep retrying at, say, 1-second intervals.  Don't even 
bother with the exponential slowdown that the HID driver does.

> > The patch doesn't delete the io_retry timer when the hub is removed.
> 
> Right, that was silly of me...

You could even rename the timer to something like irq_urb_retry; I 
think that would be a more accurate description of what it does.

So fix those things up, simplify the retries, and expand the patch
description -- then resubmit.  :-)

Alan Stern


