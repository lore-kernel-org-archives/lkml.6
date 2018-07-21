Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BDECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC68520858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC68520858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeGUTZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727854AbeGUTZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:25:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26F2FAD9D;
        Sat, 21 Jul 2018 18:31:32 +0000 (UTC)
Date:   Sat, 21 Jul 2018 11:31:27 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jbaron@akamai.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180721183127.3busfa335zlcjeox@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
 <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
 <20180721172120.kbdu4euc2wn4xzgf@linux-r8p5>
 <20180721173944.GV2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180721173944.GV2494@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018, Peter Zijlstra wrote:

>On Sat, Jul 21, 2018 at 10:21:20AM -0700, Davidlohr Bueso wrote:
>> On Fri, 20 Jul 2018, Andrew Morton wrote:
>>
>> > We could open-code it locally.  Add a couple of
>> > WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
>> > Xen but surely just reading the thing isn't too expensive?
>>
>> We could also pass on the responsibility to lockdep and just use
>> lockdep_assert_irqs_disabled(). But I guess that would be less effective
>> than to just open code it in epoll without lockdep -- note that over 80
>> places in the kernel do this.
>
>The lockdep thing is relatively recent. I think someone proposed to go
>replace a bunch of the open-coded ones at some point.

For the open coded checks, I'm seeing a small (1-2% ish) cost for bare
metal on workload 1). I don't see (via code inspection) any additional
overhead in xen either. While negligible in the overall of things, I do
like the idea of lockdep handling it nonetheless.

I can add the open coded version if people really feel that it would catch
more bugs (no lockdep users out there in production afaik :) in the long
term; but if lockdep is where things are headed...

Thanks,
Davidlohr

-------8<--------------------------------------------------------
[PATCH -next 3/2] fs/epoll: robustify irq safety with  lockdep_assert_irqs_enabled()

Sprinkle lockdep_assert_irqs_enabled() checks in the functions that
do not save and restore interrupts when dealing with the ep->wq.lock.
These are ep_scan_ready_list() and those called by epoll_ctl():
ep_insert, ep_modify and ep_remove.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b1abc461fc0..97b9b73dfec8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -670,6 +670,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
+	/* must not be called with irqs off */
+	lockdep_assert_irqs_enabled();
+
 	/*
 	 * We need to lock this because we could be hit by
 	 * eventpoll_release_file() and epoll_ctl().
@@ -764,6 +767,9 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
 
+	/* must not be called with irqs off */
+	lockdep_assert_irqs_enabled();
+
 	/*
 	 * Removes poll wait queue hooks.
 	 */
@@ -1412,6 +1418,9 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
+	/* must not be called with irqs off */
+	lockdep_assert_irqs_enabled();
+
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
 	if (unlikely(user_watches >= max_user_watches))
 		return -ENOSPC;
@@ -1540,6 +1549,9 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	int pwake = 0;
 	poll_table pt;
 
+	/* must not be called with irqs off */
+	lockdep_assert_irqs_enabled();
+
 	init_poll_funcptr(&pt, NULL);
 
 	/*
-- 
2.16.4

