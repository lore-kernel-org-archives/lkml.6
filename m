Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FFC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0B20873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 05:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A0B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeG0GzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:55:11 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:33835 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0GzK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 27 Jul 2018 02:55:10 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 26 Jul 2018 23:34:59 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] fs/epoll: loosen irq safety in ep_poll()
Date:   Thu, 26 Jul 2018 22:34:31 -0700
Message-Id: <20180727053432.16679-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180727053432.16679-1-dave@stgolabs.net>
References: <20180727053432.16679-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other calls, ep_poll() is not called with interrupts
disabled, and we can therefore avoid the irq save/restore dance
and just disable local irqs. In fact, the call should never be
called in irq context at all, considering that the only path is

epoll_wait(2) -> do_epoll_wait() -> ep_poll().

When running on a 2 socket 40-core (ht) IvyBridge a common pipe
based epoll_wait(2) microbenchmark, the following performance
improvements are seen:

    # threads       vanilla         dirty
	 1          1805587	    2106412
	 2          1854064	    2090762
	 4          1805484	    2017436
	 8          1751222	    1974475
	 16         1725299	    1962104
	 32         1378463	    1571233
	 64          787368	     900784

Which is a pretty constantly near 15%.

Also add a lockdep check such that we detect any mischief
before deadlocking.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b5e43e11f1e3..88473e6271ef 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1746,11 +1746,12 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		   int maxevents, long timeout)
 {
 	int res = 0, eavail, timed_out = 0;
-	unsigned long flags;
 	u64 slack = 0;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
 
+	lockdep_assert_irqs_enabled();
+
 	if (timeout > 0) {
 		struct timespec64 end_time = ep_set_mstimeout(timeout);
 
@@ -1763,7 +1764,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 * caller specified a non blocking operation.
 		 */
 		timed_out = 1;
-		spin_lock_irqsave(&ep->wq.lock, flags);
+		spin_lock_irq(&ep->wq.lock);
 		goto check_events;
 	}
 
@@ -1772,7 +1773,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	if (!ep_events_available(ep))
 		ep_busy_loop(ep, timed_out);
 
-	spin_lock_irqsave(&ep->wq.lock, flags);
+	spin_lock_irq(&ep->wq.lock);
 
 	if (!ep_events_available(ep)) {
 		/*
@@ -1814,11 +1815,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 				break;
 			}
 
-			spin_unlock_irqrestore(&ep->wq.lock, flags);
+			spin_unlock_irq(&ep->wq.lock);
 			if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
 				timed_out = 1;
 
-			spin_lock_irqsave(&ep->wq.lock, flags);
+			spin_lock_irq(&ep->wq.lock);
 		}
 
 		__remove_wait_queue(&ep->wq, &wait);
@@ -1828,7 +1829,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	/* Is it worth to try to dig for events ? */
 	eavail = ep_events_available(ep);
 
-	spin_unlock_irqrestore(&ep->wq.lock, flags);
+	spin_unlock_irq(&ep->wq.lock);
 
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
-- 
2.16.4

