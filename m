Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A19220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A19220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLFUfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:35:53 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49490 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFUfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:35:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 82E7E211B3;
        Thu,  6 Dec 2018 20:35:52 +0000 (UTC)
Date:   Thu, 6 Dec 2018 20:35:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
Message-ID: <20181206203552.GA20162@dcvr>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <20181205234649.ssvmv4ulwevgdla4@dcvr>
 <39192b9caf1114c95cd23e786a9c3e60@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39192b9caf1114c95cd23e786a9c3e60@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Penyaev <rpenyaev@suse.de> wrote:
> On 2018-12-06 00:46, Eric Wong wrote:
> > Roman Penyaev <rpenyaev@suse.de> wrote:
> > > Hi all,
> > > 
> > > The goal of this patch is to reduce contention of ep_poll_callback()
> > > which
> > > can be called concurrently from different CPUs in case of high events
> > > rates and many fds per epoll.  Problem can be very well reproduced by
> > > generating events (write to pipe or eventfd) from many threads, while
> > > consumer thread does polling.  In other words this patch increases the
> > > bandwidth of events which can be delivered from sources to the
> > > poller by
> > > adding poll items in a lockless way to the list.
> > 
> > Hi Roman,
> > 
> > I also tried to solve this problem many years ago with help of
> > the well-tested-in-userspace wfcqueue from Mathieu's URCU.
> > 
> > I was also looking to solve contention with parallel epoll_wait
> > callers with this.  AFAIK, it worked well; but needed the
> > userspace tests from wfcqueue ported over to the kernel and more
> > review.
> > 
> > I didn't have enough computing power to show the real-world
> > benefits or funding to continue:
> > 
> > 	https://lore.kernel.org/lkml/?q=wfcqueue+d:..20130501
> 
> Hi Eric,
> 
> Nice work.  That was a huge change by itself and by dependency
> on wfcqueue.  I could not find any valuable discussion on this,
> what was the reaction of the community?

Hi Roman, AFAIK there wasn't much reaction.  Mathieu was VERY
helpful with wfcqueue but there wasn't much else.  Honestly, I'm
surprised wfcqueue hasn't made it into more places; I love it :)

(More recently, I started an effort to get glibc malloc to use wfcqueue:
https://public-inbox.org/libc-alpha/20180731084936.g4yw6wnvt677miti@dcvr/ )

> > It might not be too much trouble for you to brush up the wait-free
> > patches and test them against the rwlock implementation.
> 
> Ha :)  I may try to cherry-pick these patches, let's see how many
> conflicts I have to resolve, eventpoll.c has been changed a lot
> since that (6 years passed, right?)

AFAIK not, epoll remains a queue with a key-value mapping.
I'm not a regular/experienced kernel hacker and I had no trouble
understanding eventpoll.c years ago.

> But reading your work description I can assume that epoll_wait() calls
> should be faster, because they do not content with ep_poll_callback(),
> and I did not try to solve this, only contention between producers,
> which make my change tiny.

Yes, I recall that was it.  My real-world programs[1], even without
slow HDD access, didn't show it, though.

> I also found your https://yhbt.net/eponeshotmt.c , where you count
> number of bare epoll_wait() calls, which IMO is not correct, because
> we need to count how many events are delivered, but not how fast
> you've returned from epoll_wait().  But as I said no doubts that
> getting rid of contention between consumer and producers will show
> even better results.

"epoll_wait calls" == "events delivered" in my case since I (ab)use
epoll_wait with max_events=1 as a work-distribution mechanism
between threads.  Not a common use-case, I admit.

My design was terrible from a syscall overhead POV, but my
bottleneck for real-world use for cmogstored[1] was dozens of
rotational HDDs in JBOD configuration; so I favored elimination
of head-of-line blocking over throughput of epoll itself.

My motivation for hacking on epoll back then was only to look
better on synthetic benchmarks that didn't hit slow HDDs :)



[1] git clone https://bogomips.org/cmogstored.git/
    the Ragel-generated HTTP parser was also a bottleneck in
    synthetic benchmarks, as we
