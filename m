Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3C6C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D551720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D551720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeKHOoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 09:44:08 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:55028 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeKHOoI (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 8 Nov 2018 09:44:08 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 07 Nov 2018 22:10:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk, dave@stgolabs.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/6] fs/epoll: reduce the scope of wq lock in epoll_wait()
Date:   Wed,  7 Nov 2018 21:10:05 -0800
Message-Id: <20181108051006.18751-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181108051006.18751-1-dave@stgolabs.net>
References: <20181108051006.18751-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims at reducing ep wq.lock hold times in epoll_wait(2).
For the blocking case, there is no need to constantly take and drop
the spinlock, which is only needed to manipulate the waitqueue.

The call to ep_events_available() is now lockless, and only exposed
to benign races. Here, if false positive (returns available events
and does not see another thread deleting an epi from the list) we call
into send_events and then the list's state is correctly seen. Otoh,
if a false negative and we don't see a list_add_tail(), for example,
from irq callback, then it is rechecked again before blocking, which
will see the correct state.

In order for more accuracy to see concurrent list_del_init(), use
the list_empty_careful() variant  -- of course, this won't the safe
against insertions from wakeup.

For the overflow list we obviously need to prevent load/store tearing
as we don't want to see partial values while the ready list is disabled.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 114 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 54 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 6a0c2591e57e..f6c023f085f6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -381,7 +381,8 @@ static void ep_nested_calls_init(struct nested_calls *ncalls)
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty(&ep->rdllist) || ep->ovflist != EP_UNACTIVE_PTR;
+	return !list_empty(&ep->rdllist) ||
+		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -698,7 +699,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 */
 	spin_lock_irq(&ep->wq.lock);
 	list_splice_init(&ep->rdllist, &txlist);
-	ep->ovflist = NULL;
+	WRITE_ONCE(ep->ovflist, NULL);
 	spin_unlock_irq(&ep->wq.lock);
 
 	/*
@@ -712,7 +713,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 * other events might have been queued by the poll callback.
 	 * We re-insert them inside the main ready-list here.
 	 */
-	for (nepi = ep->ovflist; (epi = nepi) != NULL;
+	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
 	     nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
 		/*
 		 * We need to check if the item is already in the list.
@@ -730,7 +731,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 * releasing the lock, events will be queued in the normal way inside
 	 * ep->rdllist.
 	 */
-	ep->ovflist = EP_UNACTIVE_PTR;
+	WRITE_ONCE(ep->ovflist, EP_UNACTIVE_PTR);
 
 	/*
 	 * Quickly re-inject items left on "txlist".
@@ -1153,10 +1154,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * semantics). All the events that happen during that period of time are
 	 * chained in ep->ovflist and requeued later on.
 	 */
-	if (ep->ovflist != EP_UNACTIVE_PTR) {
+	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
 		if (epi->next == EP_UNACTIVE_PTR) {
-			epi->next = ep->ovflist;
-			ep->ovflist = epi;
+			epi->next = READ_ONCE(ep->ovflist);
+			WRITE_ONCE(ep->ovflist, epi);
 			if (epi->ws) {
 				/*
 				 * Activate ep->ws since epi->ws may get
@@ -1762,10 +1763,17 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	} else if (timeout == 0) {
 		/*
 		 * Avoid the unnecessary trip to the wait queue loop, if the
-		 * caller specified a non blocking operation.
+		 * caller specified a non blocking operation. We still need
+		 * lock because we could race and not see an epi being added
+		 * to the ready list while in irq callback. Thus incorrectly
+		 * returning 0 back to userspace.
 		 */
 		timed_out = 1;
+
 		spin_lock_irq(&ep->wq.lock);
+		eavail = ep_events_available(ep);
+		spin_unlock_irq(&ep->wq.lock);
+
 		goto check_events;
 	}
 
@@ -1774,64 +1782,62 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	if (!ep_events_available(ep))
 		ep_busy_loop(ep, timed_out);
 
+	eavail = ep_events_available(ep);
+	if (eavail)
+		goto check_events;
+
+	/*
+	 * Busy poll timed out.  Drop NAPI ID for now, we can add
+	 * it back in when we have moved a socket with a valid NAPI
+	 * ID onto the ready list.
+	 */
+	ep_reset_busy_poll_napi_id(ep);
+
+	/*
+	 * We don't have any available event to return to the caller.
+	 * We need to sleep here, and we will be wake up by
+	 * ep_poll_callback() when events will become available.
+	 */
+	init_waitqueue_entry(&wait, current);
 	spin_lock_irq(&ep->wq.lock);
+	__add_wait_queue_exclusive(&ep->wq, &wait);
+	spin_unlock_irq(&ep->wq.lock);
 
-	if (!ep_events_available(ep)) {
+	for (;;) {
 		/*
-		 * Busy poll timed out.  Drop NAPI ID for now, we can add
-		 * it back in when we have moved a socket with a valid NAPI
-		 * ID onto the ready list.
+		 * We don't want to sleep if the ep_poll_callback() sends us
+		 * a wakeup in between. That's why we set the task state
+		 * to TASK_INTERRUPTIBLE before doing the checks.
 		 */
-		ep_reset_busy_poll_napi_id(ep);
-
+		set_current_state(TASK_INTERRUPTIBLE);
 		/*
-		 * We don't have any available event to return to the caller.
-		 * We need to sleep here, and we will be wake up by
-		 * ep_poll_callback() when events will become available.
+		 * Always short-circuit for fatal signals to allow
+		 * threads to make a timely exit without the chance of
+		 * finding more events available and fetching
+		 * repeatedly.
 		 */
-		init_waitqueue_entry(&wait, current);
-		__add_wait_queue_exclusive(&ep->wq, &wait);
-
-		for (;;) {
-			/*
-			 * We don't want to sleep if the ep_poll_callback() sends us
-			 * a wakeup in between. That's why we set the task state
-			 * to TASK_INTERRUPTIBLE before doing the checks.
-			 */
-			set_current_state(TASK_INTERRUPTIBLE);
-			/*
-			 * Always short-circuit for fatal signals to allow
-			 * threads to make a timely exit without the chance of
-			 * finding more events available and fetching
-			 * repeatedly.
-			 */
-			if (fatal_signal_pending(current)) {
-				res = -EINTR;
-				break;
-			}
-			if (ep_events_available(ep) || timed_out)
-				break;
-			if (signal_pending(current)) {
-				res = -EINTR;
-				break;
-			}
-
-			spin_unlock_irq(&ep->wq.lock);
-			if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
-				timed_out = 1;
-
-			spin_lock_irq(&ep->wq.lock);
+		if (fatal_signal_pending(current)) {
+			res = -EINTR;
+			break;
+		}
+		if (ep_events_available(ep) || timed_out)
+			break;
+		if (signal_pending(current)) {
+			res = -EINTR;
+			break;
 		}
 
-		__remove_wait_queue(&ep->wq, &wait);
-		__set_current_state(TASK_RUNNING);
+		if (!schedule_hrtimeout_range(to, slack, HRTIMER_MODE_ABS))
+			timed_out = 1;
 	}
-check_events:
-	/* Is it worth to try to dig for events ? */
-	eavail = ep_events_available(ep);
 
+	__set_current_state(TASK_RUNNING);
+
+	spin_lock_irq(&ep->wq.lock);
+	__remove_wait_queue(&ep->wq, &wait);
 	spin_unlock_irq(&ep->wq.lock);
 
+check_events:
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
 	 * there's still timeout left over, we go trying again in search of
-- 
2.16.4

