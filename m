Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41059C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0105F208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0105F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935783AbeFMONN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:13:13 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59796 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S935656AbeFMONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:13:10 -0400
Received: (qmail 1608 invoked by uid 2102); 13 Jun 2018 10:13:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jun 2018 10:13:09 -0400
Date:   Wed, 13 Jun 2018 10:13:09 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to ksoftirq
In-Reply-To: <alpine.LRH.2.02.1806130930550.15845@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <Pine.LNX.4.44L0.1806131010060.1476-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018, Mikulas Patocka wrote:

[Skipping lots of material...]

> BTW I found this piece of code in sound/usb/usx2y/usbusx2yaudio.c:
>                         urb->transfer_buffer_length = subs->maxpacksize * nr_of_packs();
>                         if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
>                                 snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
>                                 err = -EPIPE;
>                                 goto cleanup;
>                         } else
>                                 if (i == 0)
>                                         usX2Y->wait_iso_frame = urb->start_frame;
>                         urb->transfer_flags = 0;
> It seems like a bug to modify transfer_flags after the urb is submitted.

Yes, it is definitely a bug.

> I have a single-core machine with usb2 soundcard. When I increase mplayer
> priority (to real-time or high non-realtime priority), the sound is
> stuttering. The reason for the stuttering is that mplayer at high priority
> preempts the softirq thread, preventing URBs from being completed. It was
> caused by the patch 428aac8a81058 that offloads URB completion to softirq.
> --- linux-4.17.orig/drivers/usb/host/ehci-q.c	2018-06-12 22:35:21.000000000 +0200
> +++ linux-4.17/drivers/usb/host/ehci-q.c	2018-06-12 22:44:09.000000000 +0200
> @@ -238,6 +238,8 @@ static int qtd_copy_status (
>  
>  static void
>  ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
> +__releases(ehci->lock)
> +__acquires(ehci->lock)
>  {
>  	if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
>  		/* ... update hc-wide periodic stats */
> @@ -264,7 +266,17 @@ ehci_urb_done(struct ehci_hcd *ehci, str
>  #endif
>  
>  	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
> -	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> +	if (urb->transfer_flags & URB_FAST_COMPLETION) {
> +		/*
> +		 * USB audio experiences skipping of we offload completion
> +		 * to ksoftirq.
> +		 */

This comment seems unnecessary.

> +		spin_unlock(&ehci->lock);
> +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> +		spin_lock(&ehci->lock);
> +	} else {
> +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> +	}
>  }

I'm not at all sure about this.  Have you audited all of ehci-hcd to 
make sure the driver doesn't assume that ehci->lock remains held while 
an URB is given back?  It's been so long since I worked on this area 
that I don't remember the answer offhand.

Alan Stern

