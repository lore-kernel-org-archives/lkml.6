Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95109C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541F1208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541F1208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934434AbeFLQDb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:03:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933137AbeFLQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:03:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7D3B77884;
        Tue, 12 Jun 2018 16:03:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7EEE10F1BE8;
        Tue, 12 Jun 2018 16:03:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5CG3RCR030763;
        Tue, 12 Jun 2018 12:03:27 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5CG3RhW030759;
        Tue, 12 Jun 2018 12:03:27 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Jun 2018 12:03:27 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alan Stern <stern@rowland.harvard.edu>,
        Ming Lei <ming.lei@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@canonical.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: don't offload isochronous urb completions to
 ksoftirq
In-Reply-To: <Pine.LNX.4.44L0.1806121108350.1582-100000@iolanthe.rowland.org>
Message-ID: <alpine.LRH.2.02.1806121145040.26084@file01.intranet.prod.int.rdu2.redhat.com>
References: <Pine.LNX.4.44L0.1806121108350.1582-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 16:03:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 12 Jun 2018 16:03:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2018, Alan Stern wrote:

> On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> 
> > 
> > 
> > On Tue, 12 Jun 2018, Alan Stern wrote:
> > 
> > > On Tue, 12 Jun 2018, Mikulas Patocka wrote:
> > > 
> > > > I have a single-core machine with usb2 soundcard. When I increase mplayer
> > > > priority (to real-time or high non-realtime priority), the sound is
> > > > stuttering. The reason for the stuttering is that mplayer at high priority
> > > > preempts the softirq thread, preventing URBs from being completed. It was
> > > > caused by the patch 428aac8a81058 that offloads URB completion to softirq.
> > > > 
> > > > This patch prevents offloading isochronous URBs to softirq to fix the
> > > > stuttering.
> > > 
> > > How about just not running mplayer at such a high priority?
> > 
> > I need to run mplayer at a high priority so that other work doesn't 
> > preempt mplayer and cause stuttering.
> 
> Think about this a little more...  You _want_ the softirq thread to 
> preempt mplayer.  Or at least, you don't want mplayer to use so much 
> CPU time that the softirq thread doesn't get a chance to run.

I had usb1 sound card before - and there was no problem with high-priority 
mplayer. I could set mplayer to real time and it played solid. Because the 
UHCI driver doesn't offload URB callbacks to softirq.

When I bought usb2 sound card, this problem with softirq arised. If I set 
it to realtime or -20, it skips, if I set it to -15, it skips less, 
perhaps there is some boundary between 0 and -15 where it stops skipping - 
but it seems quite stupid that music player skips more often with higher 
priority.

> > > Or raising the priority of the softirq thread?
> > 
> > Do you want to coordinate that with the softirq maintainers? I don't know 
> > if they would be happy to add an extra real-time softirq thread.
> 
> How about making the softirq thread's priority adjustable?

But you would have to argue with softirq maintainers about it - and you 
say that you don't have time for that.

> As for coordinating with the softirq maintainers -- whether I want to 
> or not isn't the issue.  Right now I don't have _time_ to do it.
> 
> Alan Stern

I am wondering - whats the purpose of that patch 
428aac8a81058e2303677a8fbf26670229e51d3a at all? The patch shows some 
performance difference, but they are minor, about 1%.

If you want to call the urb callback as soon as possible - why don't you 
just call it? Why do you need to offload the callback to a softirq thread?

Mikulas
