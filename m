Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED5E5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ED6208CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2ED6208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935420AbeFMSy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:54:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60462 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1754484AbeFMSy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:54:57 -0400
Received: (qmail 5375 invoked by uid 2102); 13 Jun 2018 14:54:56 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Jun 2018 14:54:56 -0400
Date:   Wed, 13 Jun 2018 14:54:56 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to ksoftirq
In-Reply-To: <alpine.LRH.2.02.1806131104570.16525@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <Pine.LNX.4.44L0.1806131442230.1476-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Steve: Sorry for dumping you into the middle of this discussion.  
Please see especially the last two paragraphs below.  Mikulas is
getting dropouts with USB audio because part of the processing uses a
tasklet.]

On Wed, 13 Jun 2018, Mikulas Patocka wrote:

> > > +		spin_unlock(&ehci->lock);
> > > +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > > +		spin_lock(&ehci->lock);
> > > +	} else {
> > > +		usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
> > > +	}
> > >  }
> > 
> > I'm not at all sure about this.  Have you audited all of ehci-hcd to 
> > make sure the driver doesn't assume that ehci->lock remains held while 
> > an URB is given back?  It's been so long since I worked on this area 
> > that I don't remember the answer offhand.
> > 
> > Alan Stern
> 
> I compared the current ehci code the code in the kernel 3.11 (that was the 
> last kernel that didn't offload callbacks) and it is very similar. So, we 
> can assume that if it was ok in the kernel 3.11, it is ok now.
> 
> itd_complete and sitd_complete are the same except for small formatting 
> changes.
> 
> itd_submit and sitd_submit newly call ehci_urb_done, but it drops the 
> spinlock after the call, therefore it tolerates that ehci_urb_done drops 
> the spinlock.
> 
> qh_completions is almost the same in the kernel 3.11 and upstream, so if 
> it tolerated dropped spinlock and resubmission in 3.11, it should tolerate 
> it now.

It's also necessary to check the places these routines get called from:
scan_isoc, scan_intr, scan_async, and ehci_work.  However, the comments
in those routines say that they expect the lock might be dropped, so
they're probably okay.  ehci_work, in particular, is very careful about
this -- it started out that way, and I decided not to remove the
safeguards when the driver switched over to tasklets.

> BTW - if you think that dropping the spinlock could cause trouble - should 
> we add the urbs to temporary list and call the callbacks just after the 
> spinlock is dropped? But that would just add a lot of junk code to the 
> ehci driver.

I don't think this will be needed.

> Another possibility is to hack the softirq subsystem so that tasklet_hi is 
> never offloaded - but I don't know if it makes sense to make this change 
> jsut because of ehci.

I don't know.  But it isn't just ehci-hcd; _anything_ that tries to use
tasklets for bounded-latency applications will have the same problem.  
This sounds like the sort of thing the RT kernels must have addressed 
long ago.

Alan Stern

