Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380C206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfAGS7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:59:53 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:57964 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729018AbfAGS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:59:21 -0500
Received: (qmail 4933 invoked by uid 2102); 7 Jan 2019 13:59:20 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jan 2019 13:59:20 -0500
Date:   Mon, 7 Jan 2019 13:59:20 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        <oneukum@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
In-Reply-To: <20190107163310.GA17519@kroah.com>
Message-ID: <Pine.LNX.4.44L0.1901071357040.1399-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2019, Greg KH wrote:

> On Tue, Nov 20, 2018 at 03:34:38PM +0100, Nicolas Saenz Julienne wrote:
> > The hub sends hot-plug events to the host trough it's interrupt URB. The
> > driver takes care of completing the URB and re-submitting it. Completion
> > errors are handled in the hub_event() work, yet submission errors are
> > ignored, rendering the device unresponsive. All further events are lost.
> > 
> > It is fairly hard to find this issue in the wild, since you have to time
> > the USB hot-plug event with the URB submission failure. For instance it
> > could be the system running out of memory or some malfunction in the USB
> > controller driver. Nevertheless, it's pretty reasonable to think it'll
> > happen sometime. One can trigger this issue using eBPF's function
> > override feature (see BCC's inject.py script).
> > 
> > This patch adds a retry routine to the event of a submission error. The
> > HUB driver will try to re-submit the URB once every second until it's
> > successful or the HUB is disconnected.
> > 
> > As some USB subsystems already take care of this issue, the
> > implementation was inspired from usbhid/hid_core.c's.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > 
> > ---
> 
> What ever happened to this patch?  Is it still needed?  Oliver and Alan,
> any objections about it anymore?

I have just one very minor nit to pick (see below).  Mostly I've been
waiting to hear from Oliver.

Alan Stern

> 
> thanks,
> 
> greg k-h
> 
> > 
> > v3: As per Oliver's request:
> >   - Take care of race condition between disconnect and irq
> > 
> > v2: as per Alan's and Oliver's comments:
> >   - Rename timer
> >   - Delete the timer on disconnect
> >   - Don't reset HUB nor exponential slowdown the timer, 1s fixed retry
> >     period
> >   - Check for -ESHUTDOWN prior kicking the timer
> > 
> >  drivers/usb/core/hub.c | 45 ++++++++++++++++++++++++++++++++++++------
> >  drivers/usb/core/hub.h |  2 ++
> >  2 files changed, 41 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index c6077d582d29..630490a35301 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -607,6 +607,38 @@ static int hub_port_status(struct usb_hub *hub, int port1,
> >  				   status, change, NULL);
> >  }
> >  
> > +static void hub_resubmit_irq_urb(struct usb_hub *hub)
> > +{
> > +	unsigned long flags;
> > +	int status;
> > +
> > +	spin_lock_irqsave(&hub->irq_urb_lock, flags);
> > +
> > +	if (hub->quiescing) {
> > +		spin_unlock_irqrestore(&hub->irq_urb_lock, flags);
> > +		return;
> > +	}
> > +
> > +	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> > +	if (status && status != -ENODEV && status != -EPERM &&
> > +	    status != -ESHUTDOWN) {
> > +		dev_err(hub->intfdev, "resubmit --> %d\n", status);
> > +		mod_timer(&hub->irq_urb_retry,
> > +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));

This can be written more simply as:

		mod_timer(&hub->irq_urb_retry, jiffies + HZ);

