Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04E5C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62251206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfAIQlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726553AbfAIQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CE40B008;
        Wed,  9 Jan 2019 16:40:41 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/15] epoll: offload polling to a work in case of epfd polled from userspace
Date:   Wed,  9 Jan 2019 17:40:21 +0100
Message-Id: <20190109164025.24554-12-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109164025.24554-1-rpenyaev@suse.de>
References: <20190109164025.24554-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every device reports pollflags on wake_up(), expecting that it will be
polled later.  vfs_poll() can't be called from ep_poll_callback(), because
ep_poll_callback() is called under the spinlock.  Obviously userspace can't
call vfs_poll(), thus epoll has to offload vfs_poll() to a work and then to
call ep_poll_callback() with pollflags in a hand.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 111 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 24 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4618db9c077c..2af849e6c7a5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1624,9 +1624,8 @@ static inline bool chain_epi_lockless(struct epitem *epi)
 }
 
 /*
- * This is the callback that is passed to the wait queue wakeup
- * mechanism. It is called by the stored file descriptors when they
- * have events to report.
+ * This is the callback that is called directly from wake queue wakeup or
+ * from a work.
  *
  * This callback takes a read lock in order not to content with concurrent
  * events from another file descriptors, thus all modifications to ->rdllist
@@ -1641,14 +1640,11 @@ static inline bool chain_epi_lockless(struct epitem *epi)
  * queues are used should be detected accordingly.  This is detected using
  * cmpxchg() operation.
  */
-static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
+static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 {
-	int pwake = 0;
-	struct epitem *epi = ep_item_from_wait(wait);
 	struct eventpoll *ep = epi->ep;
-	__poll_t pollflags = key_to_poll(key);
+	int pwake = 0, ewake = 0;
 	unsigned long flags;
-	int ewake = 0;
 
 	read_lock_irqsave(&ep->lock, flags);
 
@@ -1666,12 +1662,32 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	/*
 	 * Check the events coming with the callback. At this stage, not
 	 * every device reports the events in the "key" parameter of the
-	 * callback. We need to be able to handle both cases here, hence the
-	 * test for "key" != NULL before the event match test.
+	 * callback (for ep_poll_callback() case special worker is used).
+	 * We need to be able to handle both cases here, hence the test
+	 * for "key" != NULL before the event match test.
 	 */
 	if (pollflags && !(pollflags & epi->event.events))
 		goto out_unlock;
 
+	if (ep_polled_by_user(ep)) {
+		__poll_t revents;
+
+		if (ep_events_routed_to_uring(ep)) {
+			ep_add_event_to_uring(epi, pollflags);
+			goto wakeup;
+		}
+
+		WARN_ON(!pollflags);
+		revents = (epi->event.events & ~EP_PRIVATE_BITS) & pollflags;
+
+		/*
+		 * Keep active events up-to-date for further transfer from
+		 * klists to uring.
+		 */
+		__atomic_fetch_or(&epi->ready_events, revents,
+				  __ATOMIC_RELAXED);
+	}
+
 	/*
 	 * If we are transferring events to userspace, we can hold no locks
 	 * (because we're accessing user memory, and because of linux f_op->poll()
@@ -1679,6 +1695,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
+		WARN_ON(ep_polled_by_user(ep));
 		if (epi->next == EP_UNACTIVE_PTR &&
 		    chain_epi_lockless(epi))
 			ep_pm_stay_awake_rcu(epi);
@@ -1691,6 +1708,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		ep_pm_stay_awake_rcu(epi);
 	}
 
+wakeup:
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
@@ -1727,23 +1745,67 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	if (!(epi->event.events & EPOLLEXCLUSIVE))
 		ewake = 1;
 
-	if (pollflags & POLLFREE) {
-		/*
-		 * If we race with ep_remove_wait_queue() it can miss
-		 * ->whead = NULL and do another remove_wait_queue() after
-		 * us, so we can't use __remove_wait_queue().
-		 */
-		list_del_init(&wait->entry);
+	return ewake;
+}
+
+static void ep_poll_callback_work(struct work_struct *work)
+{
+	struct epitem *epi = container_of(work, typeof(*epi), work);
+	__poll_t pollflags;
+	poll_table pt;
+
+	WARN_ON(!ep_polled_by_user(epi->ep));
+
+	init_poll_funcptr(&pt, NULL);
+	pollflags = ep_item_poll(epi, &pt, 1);
+
+	(void)ep_poll_callback(epi, pollflags);
+}
+
+/*
+ * This is the callback that is passed to the wait queue wakeup
+ * mechanism. It is called by the stored file descriptors when they
+ * have events to report.
+ */
+static int ep_poll_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+			  int sync, void *key)
+{
+
+	struct epitem *epi = ep_item_from_wait(wait);
+	struct eventpoll *ep = epi->ep;
+	__poll_t pollflags = key_to_poll(key);
+	int rc;
+
+	if (!ep_polled_by_user(ep) || pollflags) {
+		rc = ep_poll_callback(epi, pollflags);
+
+		if (pollflags & POLLFREE) {
+			/*
+			 * If we race with ep_remove_wait_queue() it can miss
+			 * ->whead = NULL and do another remove_wait_queue()
+			 * after us, so we can't use __remove_wait_queue().
+			 */
+			list_del_init(&wait->entry);
+			/*
+			 * ->whead != NULL protects us from the race with
+			 * ep_free() or ep_remove(), ep_remove_wait_queue()
+			 * takes whead->lock held by the caller. Once we nullify
+			 * it, nothing protects ep/epi or even wait.
+			 */
+			smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
+		}
+	} else {
+		schedule_work(&epi->work);
+
 		/*
-		 * ->whead != NULL protects us from the race with ep_free()
-		 * or ep_remove(), ep_remove_wait_queue() takes whead->lock
-		 * held by the caller. Once we nullify it, nothing protects
-		 * ep/epi or even wait.
+		 * Here on this path we are absolutely sure that for file
+		 * descriptors* which are pollable from userspace we do not
+		 * support EPOLLEXCLUSIVE, so it is safe to return 1.
 		 */
-		smp_store_release(&ep_pwq_from_wait(wait)->whead, NULL);
+		rc = 1;
 	}
 
-	return ewake;
+	return rc;
 }
 
 /*
@@ -1757,7 +1819,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	struct eppoll_entry *pwq;
 
 	if (epi->nwait >= 0 && (pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL))) {
-		init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
+		init_waitqueue_func_entry(&pwq->wait, ep_poll_wakeup);
 		pwq->whead = whead;
 		pwq->base = epi;
 		if (epi->event.events & EPOLLEXCLUSIVE)
@@ -1990,6 +2052,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	INIT_LIST_HEAD(&epi->rdllink);
 	INIT_LIST_HEAD(&epi->fllink);
 	INIT_LIST_HEAD(&epi->pwqlist);
+	INIT_WORK(&epi->work, ep_poll_callback_work);
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
-- 
2.19.1

