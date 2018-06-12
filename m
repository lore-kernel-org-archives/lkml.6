Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C3DBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E298020891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E298020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932849AbeFLSo6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:44:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:47756 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932343AbeFLSo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:44:56 -0400
Received: (qmail 4999 invoked by uid 2102); 12 Jun 2018 14:44:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jun 2018 14:44:55 -0400
Date:   Tue, 12 Jun 2018 14:44:55 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mikulas Patocka <mpatocka@redhat.com>
cc:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to ksoftirq
In-Reply-To: <alpine.LRH.2.02.1806121304530.1848@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <Pine.LNX.4.44L0.1806121433290.1582-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Mikulas Patocka wrote:

> On Tue, 12 Jun 2018, Alan Stern wrote:
> 
> > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > 
> > > > How about making the softirq thread's priority adjustable?
> > > 
> > > But you would have to argue with softirq maintainers about it - and you 
> > > say that you don't have time for that.
> > 
> > But maybe _you_ do...
> 
> ksoftirqd has priority 0 - it is not suitable for real-time tasks, such as 
> audio.

There have been suggestions posted to this mailing list for changing 
the USB stack to use a threaded interrupt routine instead of a tasklet
for this purpose.  Would that make your situation any better?

> In my opinion, it is much easier to fix this in the ehci driver (by not 
> offloading isochronous completions), than to design a new 
> real-time-capable ksoftirqd.

You probably never noticed this, but in fact we use _two_ bottom-half 
handlers for URB completions: one scheduled with normal priority and 
one scheduled with high priority (tasklet_hi_schedule()).  Isochronous 
URB completions go to the high-priority handler.

Shouldn't a high-priority tasklet be up to the job of handling audio?

> > > > As for coordinating with the softirq maintainers -- whether I want to 
> > > > or not isn't the issue.  Right now I don't have _time_ to do it.
> > > > 
> > > > Alan Stern
> > > 
> > > I am wondering - whats the purpose of that patch 
> > > 428aac8a81058e2303677a8fbf26670229e51d3a at all? The patch shows some 
> > > performance difference, but they are minor, about 1%.
> > > 
> > > If you want to call the urb callback as soon as possible - why don't you 
> > > just call it? Why do you need to offload the callback to a softirq thread?
> > 
> > Please read the Changelog entry for commit 94dfd7edfd5c.  Basically the 
> > idea was to reduce overall latency by not doing as much work in an 
> > interrupt handler.
> > 
> > Alan Stern
> 
> snd_complete_urb is doing nothing but submitting the same urb again. Is 
> resubmitting the urb really causing so much latency that you can't do it 
> in the interrupt handler?

Perhaps snd_complete_urb doesn't doing very much, but other drivers
most definitely do.  In particular, the completion handler for the USB
video class driver can be very time consuming.  Your proposed change
would make things worse for people using USB video.

Alan Stern

