Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B7FC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBE620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfAUUPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:55638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbfAUUPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F56BAFFA;
        Mon, 21 Jan 2019 20:15:15 +0000 (UTC)
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
Subject: [RFC PATCH v2 08/13] epoll: support polling from userspace for ep_insert()
Date:   Mon, 21 Jan 2019 21:14:51 +0100
Message-Id: <20190121201456.28338-9-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121201456.28338-1-rpenyaev@suse.de>
References: <20190121201456.28338-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When epfd is polled by userspace and new item is inserted new bit
should be get from a bitmap and then user item is set accordingly.

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
 fs/eventpoll.c | 78 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1d0039b334b8..628a2cadfad6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -865,6 +865,23 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+static inline int ep_get_bit(struct eventpoll *ep)
+{
+	bool was_set;
+	int bit;
+
+	lockdep_assert_held(&ep->mtx);
+
+	bit = find_first_zero_bit(ep->items_bm, ep->max_items_nr);
+	if (bit >= ep->max_items_nr)
+		return -ENOSPC;
+
+	was_set = test_and_set_bit(bit, ep->items_bm);
+	WARN_ON(was_set);
+
+	return bit;
+}
+
 #define atomic_set_unless_zero(ptr, flags)			\
 ({								\
 	typeof(ptr) _ptr = (ptr);				\
@@ -1874,6 +1891,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
+	lockdep_assert_held(&ep->mtx);
 	lockdep_assert_irqs_enabled();
 
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
@@ -1900,6 +1918,28 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		RCU_INIT_POINTER(epi->ws, NULL);
 	}
 
+	if (ep_polled_by_user(ep)) {
+		struct epoll_uitem *uitem;
+		int bit;
+
+		bit = ep_get_bit(ep);
+		if (unlikely(bit < 0)) {
+			error = bit;
+			goto error_get_bit;
+		}
+		epi->bit = bit;
+
+		/*
+		 * Now fill-in user item.  Do not touch ready_events, since
+		 * it can be EPOLLREMOVED (has been set by previous user
+		 * item), thus user index entry can be not yet consumed
+		 * by userspace.  See ep_remove_user_item() and
+		 * ep_add_event_to_uring() for details.
+		 */
+		uitem = &ep->user_header->items[epi->bit];
+		uitem->event = *event;
+	}
+
 	/* Initialize the poll table using the queue callback */
 	epq.epi = epi;
 	init_poll_funcptr(&epq.pt, ep_ptable_queue_proc);
@@ -1944,16 +1984,23 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
 
-	/* If the file is already "ready" we drop it inside the ready list */
-	if (revents && !ep_is_linked(epi)) {
-		list_add_tail(&epi->rdllink, &ep->rdllist);
-		ep_pm_stay_awake(epi);
+	if (revents) {
+		bool added = false;
 
-		/* Notify waiting tasks that events are available */
-		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
-		if (waitqueue_active(&ep->poll_wait))
-			pwake++;
+		if (ep_polled_by_user(ep)) {
+			added = ep_add_event_to_uring(epi, revents);
+		} else if (!ep_is_linked(epi)) {
+			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_pm_stay_awake(epi);
+			added = true;
+		}
+		if (added) {
+			/* Notify waiting tasks that events are available */
+			if (waitqueue_active(&ep->wq))
+				wake_up(&ep->wq);
+			if (waitqueue_active(&ep->poll_wait))
+				pwake++;
+		}
 	}
 
 	write_unlock_irq(&ep->lock);
@@ -1982,11 +2029,16 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * list, since that is used/cleaned only inside a section bound by "mtx".
 	 * And ep_insert() is called with "mtx" held.
 	 */
-	write_lock_irq(&ep->lock);
-	if (ep_is_linked(epi))
-		list_del_init(&epi->rdllink);
-	write_unlock_irq(&ep->lock);
+	if (ep_polled_by_user(ep)) {
+		ep_remove_user_item(epi);
+	} else {
+		write_lock_irq(&ep->lock);
+		if (ep_is_linked(epi))
+			list_del_init(&epi->rdllink);
+		write_unlock_irq(&ep->lock);
+	}
 
+error_get_bit:
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
 error_create_wakeup_source:
-- 
2.19.1

