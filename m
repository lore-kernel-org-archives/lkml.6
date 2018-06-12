Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3B82DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9222089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9222089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeFLTDn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:03:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932926AbeFLTDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:03:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 023C24000B8A;
        Tue, 12 Jun 2018 19:03:41 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E81732026DEF;
        Tue, 12 Jun 2018 19:03:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5CJ3eCV030776;
        Tue, 12 Jun 2018 15:03:40 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5CJ3eSw030772;
        Tue, 12 Jun 2018 15:03:40 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Jun 2018 15:03:40 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <Pine.LNX.4.44L0.1806121433290.1582-100000@iolanthe.rowland.org>
Message-ID: <alpine.LRH.2.02.1806121450330.14879@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806121433290.1582-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 19:03:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 12 Jun 2018 19:03:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2018, Alan Stern wrote:

> On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> 
> > On Tue, 12 Jun 2018, Alan Stern wrote:
> > 
> > > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > > 
> > > > > How about making the softirq thread's priority adjustable?
> > > > 
> > > > But you would have to argue with softirq maintainers about it - and you 
> > > > say that you don't have time for that.
> > > 
> > > But maybe _you_ do...
> > 
> > ksoftirqd has priority 0 - it is not suitable for real-time tasks, such as 
> > audio.
> 
> There have been suggestions posted to this mailing list for changing 
> the USB stack to use a threaded interrupt routine instead of a tasklet
> for this purpose.  Would that make your situation any better?

If you set real-time priority to the interrupt thread, then yes, I think 
it would solve the problem.

> > In my opinion, it is much easier to fix this in the ehci driver (by not 
> > offloading isochronous completions), than to design a new 
> > real-time-capable ksoftirqd.
> 
> You probably never noticed this, but in fact we use _two_ bottom-half 
> handlers for URB completions: one scheduled with normal priority and 
> one scheduled with high priority (tasklet_hi_schedule()).  Isochronous 
> URB completions go to the high-priority handler.
> 
> Shouldn't a high-priority tasklet be up to the job of handling audio?

I noticed the function tasklet_hi_schedule. It has higher priority than 
other softirqs - but it gets offloaded to the ksoftirqd thread that has 
priority 0. So it can be preempted by anything - and it doesn't protect 
against skipping.

If we raise the priority of ksoftirqd, people will start complaining such 
as "my machine is unuseable when it receives too many network packets". 
So, you basically need two ksoftirqds, one for networking (with regular 
priority) and one for audio (with high priority).

> > > > > As for coordinating with the softirq maintainers -- whether I want to 
> > > > > or not isn't the issue.  Right now I don't have _time_ to do it.
> > > > > 
> > > > > Alan Stern
> > > > 
> > > > I am wondering - whats the purpose of that patch 
> > > > 428aac8a81058e2303677a8fbf26670229e51d3a at all? The patch shows some 
> > > > performance difference, but they are minor, about 1%.
> > > > 
> > > > If you want to call the urb callback as soon as possible - why don't you 
> > > > just call it? Why do you need to offload the callback to a softirq thread?
> > > 
> > > Please read the Changelog entry for commit 94dfd7edfd5c.  Basically the 
> > > idea was to reduce overall latency by not doing as much work in an 
> > > interrupt handler.
> > > 
> > > Alan Stern
> > 
> > snd_complete_urb is doing nothing but submitting the same urb again. Is 
> > resubmitting the urb really causing so much latency that you can't do it 
> > in the interrupt handler?
> 
> Perhaps snd_complete_urb doesn't doing very much, but other drivers
> most definitely do.  In particular, the completion handler for the USB
> video class driver can be very time consuming.  Your proposed change
> would make things worse for people using USB video.

In that case we can avoid offloading just for snd_complete_urb. Would you 
agree to adding a flag such as URB_FAST_COMPLETION that is set just by the 
audio driver?

Do the video usb devices use isochronous or bulk transfers?

> Alan Stern

Mikulas
