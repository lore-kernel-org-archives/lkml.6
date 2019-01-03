Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846E12070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbfACPBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:01:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:33150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730684AbfACPBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:01:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB303AE55;
        Thu,  3 Jan 2019 15:01:13 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] epoll: use rwlock in order to reduce ep_poll_callback() contention
Date:   Thu,  3 Jan 2019 16:01:04 +0100
Message-Id: <20190103150104.17128-5-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103150104.17128-1-rpenyaev@suse.de>
References: <20190103150104.17128-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this patch is to reduce contention of ep_poll_callback() which
can be called concurrently from different CPUs in case of high events
rates and many fds per epoll.  Problem can be very well reproduced by
generating events (write to pipe or eventfd) from many threads, while
consumer thread does polling.  In other words this patch increases the
bandwidth of events which can be delivered from sources to the poller by
adding poll items in a lockless way to the list.

The main change is in replacement of the spinlock with a rwlock, which is
taken on read in ep_poll_callback(), and then by adding poll items to the
tail of the list using xchg atomic instruction.  Write lock is taken
everywhere else in order to stop list modifications and guarantee that list
updates are fully completed (I assume that write side of a rwlock does not
starve, it seems qrwlock implementation has these guarantees).

The following are some microbenchmark results based on the test [1] which
starts threads which generate N events each.  The test ends when all
events are successfully fetched by the poller thread:

 spinlock
 ========

 threads  events/ms  run-time ms
       8       6402        12495
      16       7045        22709
      32       7395        43268

 rwlock + xchg
 =============

 threads  events/ms  run-time ms
       8      10038         7969
      16      12178        13138
      32      13223        24199

According to the results bandwidth of delivered events is significantly
increased, thus execution time is reduced.

This patch was tested with different sort of microbenchmarks and
artificial delays (e.g. "udelay(get_random_int() & 0xff)") introduced
in kernel on paths where items are added to lists.

[1] https://github.com/rouming/test-tools/blob/master/stress-epoll.c

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

v2:
 o I was wrong saying that ep_poll_callback() can't be called 
   concurrently for the same epi: several wait queues can be
   attached to the single epoll item, thus several event sources
   can signal in parallel.  To cover this case lockless element
   addition has to detect that the same @epi is not yet in the
   list.  This is done by extra cmpxchg() operation.


 fs/eventpoll.c | 156 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 121 insertions(+), 35 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0122b9147542..339627074948 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -50,10 +50,10 @@
  *
  * 1) epmutex (mutex)
  * 2) ep->mtx (mutex)
- * 3) ep->wq.lock (spinlock)
+ * 3) ep->lock (rwlock)
  *
  * The acquire order is the one listed above, from 1 to 3.
- * We need a spinlock (ep->wq.lock) because we manipulate objects
+ * We need a rwlock (ep->lock) because we manipulate objects
  * from inside the poll callback, that might be triggered from
  * a wake_up() that in turn might be called from IRQ context.
  * So we can't sleep inside the poll callback and hence we need
@@ -85,7 +85,7 @@
  * of epoll file descriptors, we use the current recursion depth as
  * the lockdep subkey.
  * It is possible to drop the "ep->mtx" and to use the global
- * mutex "epmutex" (together with "ep->wq.lock") to have it working,
+ * mutex "epmutex" (together with "ep->lock") to have it working,
  * but having "ep->mtx" will make the interface more scalable.
  * Events that require holding "epmutex" are very rare, while for
  * normal operations the epoll private "ep->mtx" will guarantee
@@ -182,8 +182,6 @@ struct epitem {
  * This structure is stored inside the "private_data" member of the file
  * structure and represents the main data structure for the eventpoll
  * interface.
- *
- * Access to it is protected by the lock inside wq.
  */
 struct eventpoll {
 	/*
@@ -203,13 +201,16 @@ struct eventpoll {
 	/* List of ready file descriptors */
 	struct list_head rdllist;
 
+	/* Lock which protects rdllist and ovflist */
+	rwlock_t lock;
+
 	/* RB tree root used to store monitored fd structs */
 	struct rb_root_cached rbr;
 
 	/*
 	 * This is a single linked list that chains all the "struct epitem" that
 	 * happened while transferring ready events to userspace w/out
-	 * holding ->wq.lock.
+	 * holding ->lock.
 	 */
 	struct epitem *ovflist;
 
@@ -697,17 +698,17 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 * because we want the "sproc" callback to be able to do it
 	 * in a lockless way.
 	 */
-	spin_lock_irq(&ep->wq.lock);
+	write_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, &txlist);
 	WRITE_ONCE(ep->ovflist, NULL);
-	spin_unlock_irq(&ep->wq.lock);
+	write_unlock_irq(&ep->lock);
 
 	/*
 	 * Now call the callback function.
 	 */
 	res = (*sproc)(ep, &txlist, priv);
 
-	spin_lock_irq(&ep->wq.lock);
+	write_lock_irq(&ep->lock);
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
@@ -749,11 +750,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		 * the ->poll() wait list (delayed after we release the lock).
 		 */
 		if (waitqueue_active(&ep->wq))
-			wake_up_locked(&ep->wq);
+			wake_up(&ep->wq);
 		if (waitqueue_active(&ep->poll_wait))
 			pwake++;
 	}
-	spin_unlock_irq(&ep->wq.lock);
+	write_unlock_irq(&ep->lock);
 
 	if (!ep_locked)
 		mutex_unlock(&ep->mtx);
@@ -793,10 +794,10 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-	spin_lock_irq(&ep->wq.lock);
+	write_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
-	spin_unlock_irq(&ep->wq.lock);
+	write_unlock_irq(&ep->lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 	/*
@@ -846,7 +847,7 @@ static void ep_free(struct eventpoll *ep)
 	 * Walks through the whole tree by freeing each "struct epitem". At this
 	 * point we are sure no poll callbacks will be lingering around, and also by
 	 * holding "epmutex" we can be sure that no file cleanup code will hit
-	 * us during this operation. So we can avoid the lock on "ep->wq.lock".
+	 * us during this operation. So we can avoid the lock on "ep->lock".
 	 * We do not need to lock ep->mtx, either, we only do it to prevent
 	 * a lockdep warning.
 	 */
@@ -1027,6 +1028,7 @@ static int ep_alloc(struct eventpoll **pep)
 		goto free_uid;
 
 	mutex_init(&ep->mtx);
+	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
@@ -1116,10 +1118,96 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 }
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
+/**
+ * Adds a new entry to the tail of the list in a lockless way, i.e.
+ * multiple CPUs are allowed to call this function concurrently.
+ *
+ * Beware: it is necessary to prevent any other modifications of the
+ *         existing list until all changes are completed, in other words
+ *         concurrent list_add_tail_lockless() calls should be protected
+ *         with a read lock, where write lock acts as a barrier which
+ *         makes sure all list_add_tail_lockless() calls are fully
+ *         completed.
+ *
+ *        Also an element can be locklessly added to the list only in one
+ *        direction i.e. either to the tail either to the head, otherwise
+ *        concurrent access will corrupt the list.
+ *
+ * Returns %false if element has been already added to the list, %true
+ * otherwise.
+ */
+static inline bool list_add_tail_lockless(struct list_head *new,
+					  struct list_head *head)
+{
+	struct list_head *prev;
+
+	/*
+	 * This is simple 'new->next = head' operation, but cmpxchg()
+	 * is used in order to detect that same element has been just
+	 * added to the list from another CPU: the winner observes
+	 * new->next == new.
+	 */
+	if (cmpxchg(&new->next, new, head) != new)
+		return false;
+
+	/*
+	 * Initially ->next of a new element must be updated with the head
+	 * (we are inserting to the tail) and only then pointers are atomically
+	 * exchanged.  XCHG guarantees memory ordering, thus ->next should be
+	 * updated before pointers are actually swapped and pointers are
+	 * swapped before prev->next is updated.
+	 */
+
+	prev = xchg(&head->prev, new);
+
+	/*
+	 * It is safe to modify prev->next and new->prev, because a new element
+	 * is added only to the tail and new->next is updated before XCHG.
+	 */
+
+	prev->next = new;
+	new->prev = prev;
+
+	return true;
+}
+
+/**
+ * Chains a new epi entry to the tail of the ep->ovflist in a lockless way,
+ * i.e. multiple CPUs are allowed to call this function concurrently.
+ *
+ * Returns %false if epi element has been already chained, %true otherwise.
+ */
+static inline bool chain_epi_lockless(struct epitem *epi)
+{
+	struct eventpoll *ep = epi->ep;
+
+	/* Check that the same epi has not been just chained from another CPU */
+	if (cmpxchg(&epi->next, EP_UNACTIVE_PTR, NULL) != EP_UNACTIVE_PTR)
+		return false;
+
+	/* Atomically exchange tail */
+	epi->next = xchg(&ep->ovflist, epi);
+
+	return true;
+}
+
 /*
  * This is the callback that is passed to the wait queue wakeup
  * mechanism. It is called by the stored file descriptors when they
  * have events to report.
+ *
+ * This callback takes a read lock in order not to content with concurrent
+ * events from another file descriptors, thus all modifications to ->rdllist
+ * or ->ovflist are lockless.  Read lock is paired with the write lock from
+ * ep_scan_ready_list(), which stops all list modifications and guarantees
+ * that lists state is seen correctly.
+ *
+ * Another thing worth to mention is that ep_poll_callback() can be called
+ * concurrently for the same @epi from different CPUs if poll table was inited
+ * with several wait queues entries.  Plural wakeup from different CPUs of a
+ * single wait queue is serialized by wq.lock, but the case when multiple wait
+ * queues are used should be detected accordingly.  This is detected using
+ * cmpxchg() operation.
  */
 static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 {
@@ -1135,7 +1223,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 */
 	lockdep_assert_irqs_disabled();
 
-	spin_lock(&ep->wq.lock);
+	read_lock(&ep->lock);
 
 	ep_set_busy_poll_napi_id(epi);
 
@@ -1164,17 +1252,15 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * chained in ep->ovflist and requeued later on.
 	 */
 	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-		if (epi->next == EP_UNACTIVE_PTR) {
-			epi->next = READ_ONCE(ep->ovflist);
-			WRITE_ONCE(ep->ovflist, epi);
+		if (epi->next == EP_UNACTIVE_PTR &&
+		    chain_epi_lockless(epi))
 			ep_pm_stay_awake_rcu(epi);
-		}
 		goto out_unlock;
 	}
 
 	/* If this file is already in the ready list we exit soon */
-	if (!ep_is_linked(epi)) {
-		list_add_tail(&epi->rdllink, &ep->rdllist);
+	if (!ep_is_linked(epi) &&
+	    list_add_tail_lockless(&epi->rdllink, &ep->rdllist)) {
 		ep_pm_stay_awake_rcu(epi);
 	}
 
@@ -1199,13 +1285,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up_locked(&ep->wq);
+		wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
 
 out_unlock:
-	spin_unlock(&ep->wq.lock);
+	read_unlock(&ep->lock);
 
 	/* We have to call this outside the lock */
 	if (pwake)
@@ -1490,7 +1576,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		goto error_remove_epi;
 
 	/* We have to drop the new item inside our item list to keep track of it */
-	spin_lock_irq(&ep->wq.lock);
+	write_lock_irq(&ep->lock);
 
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
@@ -1502,12 +1588,12 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 
 		/* Notify waiting tasks that events are available */
 		if (waitqueue_active(&ep->wq))
-			wake_up_locked(&ep->wq);
+			wake_up(&ep->wq);
 		if (waitqueue_active(&ep->poll_wait))
 			pwake++;
 	}
 
-	spin_unlock_irq(&ep->wq.lock);
+	write_unlock_irq(&ep->lock);
 
 	atomic_long_inc(&ep->user->epoll_watches);
 
@@ -1533,10 +1619,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * list, since that is used/cleaned only inside a section bound by "mtx".
 	 * And ep_insert() is called with "mtx" held.
 	 */
-	spin_lock_irq(&ep->wq.lock);
+	write_lock_irq(&ep->lock);
 	if (ep_is_linked(epi))
 		list_del_init(&epi->rdllink);
-	spin_unlock_irq(&ep->wq.lock);
+	write_unlock_irq(&ep->lock);
 
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
@@ -1580,9 +1666,9 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * 1) Flush epi changes above to other CPUs.  This ensures
 	 *    we do not miss events from ep_poll_callback if an
 	 *    event occurs immediately after we call f_op->poll().
-	 *    We need this because we did not take ep->wq.lock while
+	 *    We need this because we did not take ep->lock while
 	 *    changing epi above (but ep_poll_callback does take
-	 *    ep->wq.lock).
+	 *    ep->lock).
 	 *
 	 * 2) We also need to ensure we do not miss _past_ events
 	 *    when calling f_op->poll().  This barrier also
@@ -1601,18 +1687,18 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * list, push it inside.
 	 */
 	if (ep_item_poll(epi, &pt, 1)) {
-		spin_lock_irq(&ep->wq.lock);
+		write_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
 
 			/* Notify waiting tasks that events are available */
 			if (waitqueue_active(&ep->wq))
-				wake_up_locked(&ep->wq);
+				wake_up(&ep->wq);
 			if (waitqueue_active(&ep->poll_wait))
 				pwake++;
 		}
-		spin_unlock_irq(&ep->wq.lock);
+		write_unlock_irq(&ep->lock);
 	}
 
 	/* We have to call this outside the lock */
@@ -1773,9 +1859,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 		 */
 		timed_out = 1;
 
-		spin_lock_irq(&ep->wq.lock);
+		write_lock_irq(&ep->lock);
 		eavail = ep_events_available(ep);
-		spin_unlock_irq(&ep->wq.lock);
+		write_unlock_irq(&ep->lock);
 
 		goto send_events;
 	}
-- 
2.19.1

