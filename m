Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1775C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C492089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546878797;
	bh=3SJHRzAYzwGOUCZJKLg0pNRyB7MJMXVa0JWraZaVOls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eOqZP9Dp5Ar7ZG22SRXO7hl9rJ3rVNZxd76qfqE0lnQEe9N/GxkHyeaqMHNP41kqr
	 W/aowqliFVrFYwZkFkM7qA6STRE3qJ8rN9fMHqZW1O+dUNFDxEWPZtzkvzfFuFoshC
	 G4LFLDxZV8rrX1fgZ0rhqwnZpIL2DGsBwfAupHTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfAGQdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfAGQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:33:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F142089F;
        Mon,  7 Jan 2019 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546878792;
        bh=3SJHRzAYzwGOUCZJKLg0pNRyB7MJMXVa0JWraZaVOls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pkt5/9orX15Zz641EkMHFJq+CDdEsQ93mJSIdh7JcEaDnWcNdbTcxBPGL6MFnMAJm
         SgeheOLuDmzBxPhQpuL1ZItChP/I3p6vjitOqVob+FdGN7MIin5LCOfnIUJSUY46ho
         mCUVKDCOSRzX+z21bAKV93kVxCpcT7WjZEWBdwL8=
Date:   Mon, 7 Jan 2019 17:33:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     oneukum@suse.com, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb: hub: add retry routine after intr URB submit
 error
Message-ID: <20190107163310.GA17519@kroah.com>
References: <20181120143438.18296-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143438.18296-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:34:38PM +0100, Nicolas Saenz Julienne wrote:
> The hub sends hot-plug events to the host trough it's interrupt URB. The
> driver takes care of completing the URB and re-submitting it. Completion
> errors are handled in the hub_event() work, yet submission errors are
> ignored, rendering the device unresponsive. All further events are lost.
> 
> It is fairly hard to find this issue in the wild, since you have to time
> the USB hot-plug event with the URB submission failure. For instance it
> could be the system running out of memory or some malfunction in the USB
> controller driver. Nevertheless, it's pretty reasonable to think it'll
> happen sometime. One can trigger this issue using eBPF's function
> override feature (see BCC's inject.py script).
> 
> This patch adds a retry routine to the event of a submission error. The
> HUB driver will try to re-submit the URB once every second until it's
> successful or the HUB is disconnected.
> 
> As some USB subsystems already take care of this issue, the
> implementation was inspired from usbhid/hid_core.c's.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---

What ever happened to this patch?  Is it still needed?  Oliver and Alan,
any objections about it anymore?

thanks,

greg k-h

> 
> v3: As per Oliver's request:
>   - Take care of race condition between disconnect and irq
> 
> v2: as per Alan's and Oliver's comments:
>   - Rename timer
>   - Delete the timer on disconnect
>   - Don't reset HUB nor exponential slowdown the timer, 1s fixed retry
>     period
>   - Check for -ESHUTDOWN prior kicking the timer
> 
>  drivers/usb/core/hub.c | 45 ++++++++++++++++++++++++++++++++++++------
>  drivers/usb/core/hub.h |  2 ++
>  2 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c6077d582d29..630490a35301 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -607,6 +607,38 @@ static int hub_port_status(struct usb_hub *hub, int port1,
>  				   status, change, NULL);
>  }
>  
> +static void hub_resubmit_irq_urb(struct usb_hub *hub)
> +{
> +	unsigned long flags;
> +	int status;
> +
> +	spin_lock_irqsave(&hub->irq_urb_lock, flags);
> +
> +	if (hub->quiescing) {
> +		spin_unlock_irqrestore(&hub->irq_urb_lock, flags);
> +		return;
> +	}
> +
> +	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> +	if (status && status != -ENODEV && status != -EPERM &&
> +	    status != -ESHUTDOWN) {
> +		dev_err(hub->intfdev, "resubmit --> %d\n", status);
> +		mod_timer(&hub->irq_urb_retry,
> +			  jiffies + msecs_to_jiffies(MSEC_PER_SEC));
> +
> +	}
> +
> +	spin_unlock_irqrestore(&hub->irq_urb_lock, flags);
> +}
> +
> +static void hub_retry_irq_urb(struct timer_list *t)
> +{
> +	struct usb_hub *hub = from_timer(hub, t, irq_urb_retry);
> +
> +	hub_resubmit_irq_urb(hub);
> +}
> +
> +
>  static void kick_hub_wq(struct usb_hub *hub)
>  {
>  	struct usb_interface *intf;
> @@ -709,12 +741,7 @@ static void hub_irq(struct urb *urb)
>  	kick_hub_wq(hub);
>  
>  resubmit:
> -	if (hub->quiescing)
> -		return;
> -
> -	status = usb_submit_urb(hub->urb, GFP_ATOMIC);
> -	if (status != 0 && status != -ENODEV && status != -EPERM)
> -		dev_err(hub->intfdev, "resubmit --> %d\n", status);
> +	hub_resubmit_irq_urb(hub);
>  }
>  
>  /* USB 2.0 spec Section 11.24.2.3 */
> @@ -1254,10 +1281,13 @@ enum hub_quiescing_type {
>  static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
>  {
>  	struct usb_device *hdev = hub->hdev;
> +	unsigned long flags;
>  	int i;
>  
>  	/* hub_wq and related activity won't re-trigger */
> +	spin_lock_irqsave(&hub->irq_urb_lock, flags);
>  	hub->quiescing = 1;
> +	spin_unlock_irqrestore(&hub->irq_urb_lock, flags);
>  
>  	if (type != HUB_SUSPEND) {
>  		/* Disconnect all the children */
> @@ -1268,6 +1298,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
>  	}
>  
>  	/* Stop hub_wq and related activity */
> +	del_timer_sync(&hub->irq_urb_retry);
>  	usb_kill_urb(hub->urb);
>  	if (hub->has_indicators)
>  		cancel_delayed_work_sync(&hub->leds);
> @@ -1800,6 +1831,8 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	INIT_DELAYED_WORK(&hub->leds, led_work);
>  	INIT_DELAYED_WORK(&hub->init_work, NULL);
>  	INIT_WORK(&hub->events, hub_event);
> +	spin_lock_init(&hub->irq_urb_lock);
> +	timer_setup(&hub->irq_urb_retry, hub_retry_irq_urb, 0);
>  	usb_get_intf(intf);
>  	usb_get_dev(hdev);
>  
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 4accfb63f7dc..a9e24e4b8df1 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -69,6 +69,8 @@ struct usb_hub {
>  	struct delayed_work	leds;
>  	struct delayed_work	init_work;
>  	struct work_struct      events;
> +	spinlock_t		irq_urb_lock;
> +	struct timer_list	irq_urb_retry;
>  	struct usb_port		**ports;
>  };
>  
> -- 
> 2.19.1
> 
