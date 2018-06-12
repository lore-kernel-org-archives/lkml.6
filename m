Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 50EDEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D6E208B5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D6E208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFLPLd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:11:33 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47118 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932919AbeFLPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:11:32 -0400
Received: (qmail 3650 invoked by uid 2102); 12 Jun 2018 11:11:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2018 11:11:31 -0400
Date:   Tue, 12 Jun 2018 11:11:31 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to ksoftirq
In-Reply-To: <alpine.LRH.2.02.1806121041420.10769@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <Pine.LNX.4.44L0.1806121108350.1582-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Mikulas Patocka wrote:

> 
> 
> On Tue, 12 Jun 2018, Alan Stern wrote:
> 
> > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > 
> > > I have a single-core machine with usb2 soundcard. When I increase mplayer
> > > priority (to real-time or high non-realtime priority), the sound is
> > > stuttering. The reason for the stuttering is that mplayer at high priority
> > > preempts the softirq thread, preventing URBs from being completed. It was
> > > caused by the patch 428aac8a81058 that offloads URB completion to softirq.
> > > 
> > > This patch prevents offloading isochronous URBs to softirq to fix the
> > > stuttering.
> > 
> > How about just not running mplayer at such a high priority?
> 
> I need to run mplayer at a high priority so that other work doesn't 
> preempt mplayer and cause stuttering.

Think about this a little more...  You _want_ the softirq thread to 
preempt mplayer.  Or at least, you don't want mplayer to use so much 
CPU time that the softirq thread doesn't get a chance to run.

> > Or raising the priority of the softirq thread?
> 
> Do you want to coordinate that with the softirq maintainers? I don't know 
> if they would be happy to add an extra real-time softirq thread.

How about making the softirq thread's priority adjustable?

As for coordinating with the softirq maintainers -- whether I want to 
or not isn't the issue.  Right now I don't have _time_ to do it.

Alan Stern

> > Alan Stern
> 
> Mikulas
> 
> > > Fixes: c04ee4b1136e ("Revert "Revert "USB: EHCI: support running URB giveback in tasklet context""")
> > > Cc: stable@vger.kernel.org
> > > 
> > > ---
> > >  drivers/usb/core/hcd.c    |   10 ++++++++++
> > >  drivers/usb/host/ehci-q.c |   11 ++++++++++-
> > >  include/linux/usb/hcd.h   |    2 ++
> > >  3 files changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > Index: linux-4.17/drivers/usb/core/hcd.c
> > > ===================================================================
> > > --- linux-4.17.orig/drivers/usb/core/hcd.c	2018-06-12 16:06:23.000000000 +0200
> > > +++ linux-4.17/drivers/usb/core/hcd.c	2018-06-12 16:07:51.000000000 +0200
> > > @@ -1858,6 +1858,16 @@ void usb_hcd_giveback_urb(struct usb_hcd
> > >  }
> > >  EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
> > >  
> > > +void _usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
> > > +{
> > > +	/* pass status to tasklet via unlinked */
> > > +	if (likely(!urb->unlinked))
> > > +		urb->unlinked = status;
> > > +
> > > +	__usb_hcd_giveback_urb(urb);
> > > +}
> > > +EXPORT_SYMBOL_GPL(_usb_hcd_giveback_urb);
> > > +
> > >  /*-------------------------------------------------------------------------*/
> > >  
> > >  /* Cancel all URBs pending on this endpoint and wait for the endpoint's
> > > Index: linux-4.17/drivers/usb/host/ehci-q.c
> > > ===================================================================
> > > --- linux-4.17.orig/drivers/usb/host/ehci-q.c	2018-06-12 16:06:23.000000000 +0200
> > > +++ linux-4.17/drivers/usb/host/ehci-q.c	2018-06-12 16:09:28.000000000 +0200
> > > @@ -238,6 +238,8 @@ static int qtd_copy_status (
> > >  
> > >  static void
> > >  ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
> > > +__releases(ehci->lock)
> > > +__acquires(ehci->lock)
> > >  {
> > >  	if (usb_pipetype(urb->pipe) == PIPE_INTERRUPT) {
> > >  		/* ... update hc-wide periodic stats */
> > > @@ -264,7 +266,14 @@ ehci_urb_done(struct ehci_hcd *ehci, str
> > >  #endif
> > >  
> > >  	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
> > > -	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > > +	if (usb_pipeisoc(urb->pipe)) {
> > > +		/* complete() can reenter this HCD */
> > > +		spin_unlock(&ehci->lock);
> > > +		_usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > > +		spin_lock(&ehci->lock);
> > > +	} else {
> > > +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > > +	}
> > >  }
> > >  
> > >  static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
> > > Index: linux-4.17/include/linux/usb/hcd.h
> > > ===================================================================
> > > --- linux-4.17.orig/include/linux/usb/hcd.h	2018-06-05 21:07:27.000000000 +0200
> > > +++ linux-4.17/include/linux/usb/hcd.h	2018-06-12 16:07:11.000000000 +0200
> > > @@ -428,6 +428,8 @@ extern int usb_hcd_submit_urb(struct urb
> > >  extern int usb_hcd_unlink_urb(struct urb *urb, int status);
> > >  extern void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb,
> > >  		int status);
> > > +extern void _usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb,
> > > +		int status);
> > >  extern int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > >  		gfp_t mem_flags);
> > >  extern void usb_hcd_unmap_urb_setup_for_dma(struct usb_hcd *, struct urb *);
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > 
> 
> 

