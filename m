Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40147C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB960208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB960208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeFMQfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:35:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754096AbeFMQfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:35:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C804440704A2;
        Wed, 13 Jun 2018 16:35:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 710AE1C665;
        Wed, 13 Jun 2018 16:35:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5DGZllR002093;
        Wed, 13 Jun 2018 12:35:47 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5DGZlEv002089;
        Wed, 13 Jun 2018 12:35:47 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 13 Jun 2018 12:35:47 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <Pine.LNX.4.44L0.1806131010060.1476-100000@iolanthe.rowland.org>
Message-ID: <alpine.LRH.2.02.1806131104570.16525@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806131010060.1476-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 13 Jun 2018 16:35:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 13 Jun 2018 16:35:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jun 2018, Alan Stern wrote:

> On Wed, 13 Jun 2018, Mikulas Patocka wrote:
> 
> [Skipping lots of material...]
> 
> > BTW I found this piece of code in sound/usb/usx2y/usbusx2yaudio.c:
> >                         urb->transfer_buffer_length = subs->maxpacksize * nr_of_packs();
> >                         if ((err = usb_submit_urb(urb, GFP_ATOMIC)) < 0) {
> >                                 snd_printk (KERN_ERR "cannot submit datapipe for urb %d, err = %d\n", i, err);
> >                                 err = -EPIPE;
> >                                 goto cleanup;
> >                         } else
> >                                 if (i == 0)
> >                                         usX2Y->wait_iso_frame = urb->start_frame;
> >                         urb->transfer_flags = 0;
> > It seems like a bug to modify transfer_flags after the urb is submitted.
> 
> Yes, it is definitely a bug.
> 
> > I have a single-core machine with usb2 soundcard. When I increase mplayer
> > priority (to real-time or high non-realtime priority), the sound is
> > stuttering. The reason for the stuttering is that mplayer at high priority
> > preempts the softirq thread, preventing URBs from being completed. It was
> > caused by the patch 428aac8a81058 that offloads URB completion to softirq.
> > --- linux-4.17.orig/drivers/usb/host/ehci-q.c	2018-06-12 22:35:21.000000000 +0200
> > +++ linux-4.17/drivers/usb/host/ehci-q.c	2018-06-12 22:44:09.000000000 +0200
> > @@ -238,6 +238,8 @@ static int qtd_copy_status (
> >  
> >  static void
> >  ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
> > +__releases(ehci->lock)
> > +__acquires(ehci->lock)
> >  {
> >  	if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
> >  		/* ... update hc-wide periodic stats */
> > @@ -264,7 +266,17 @@ ehci_urb_done(struct ehci_hcd *ehci, str
> >  #endif
> >  
> >  	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
> > -	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > +	if (urb->transfer_flags & URB_FAST_COMPLETION) {
> > +		/*
> > +		 * USB audio experiences skipping of we offload completion
> > +		 * to ksoftirq.
> > +		 */
> 
> This comment seems unnecessary.
> 
> > +		spin_unlock(&ehci->lock);
> > +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > +		spin_lock(&ehci->lock);
> > +	} else {
> > +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > +	}
> >  }
> 
> I'm not at all sure about this.  Have you audited all of ehci-hcd to 
> make sure the driver doesn't assume that ehci->lock remains held while 
> an URB is given back?  It's been so long since I worked on this area 
> that I don't remember the answer offhand.
> 
> Alan Stern

I compared the current ehci code the code in the kernel 3.11 (that was the 
last kernel that didn't offload callbacks) and it is very similar. So, we 
can assume that if it was ok in the kernel 3.11, it is ok now.

itd_complete and sitd_complete are the same except for small formatting 
changes.

itd_submit and sitd_submit newly call ehci_urb_done, but it drops the 
spinlock after the call, therefore it tolerates that ehci_urb_done drops 
the spinlock.

qh_completions is almost the same in the kernel 3.11 and upstream, so if 
it tolerated dropped spinlock and resubmission in 3.11, it should tolerate 
it now.


BTW - if you think that dropping the spinlock could cause trouble - should 
we add the urbs to temporary list and call the callbacks just after the 
spinlock is dropped? But that would just add a lot of junk code to the 
ehci driver.

Another possibility is to hack the softirq subsystem so that tasklet_hi is 
never offloaded - but I don't know if it makes sense to make this change 
jsut because of ehci.

Mikulas
