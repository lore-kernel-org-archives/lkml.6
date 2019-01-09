Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEBC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfAIQlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:57600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726613AbfAIQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADA53AF74;
        Wed,  9 Jan 2019 16:40:40 +0000 (UTC)
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
Subject: [RFC PATCH 10/15] epoll: support polling from userspace for ep_insert()
Date:   Wed,  9 Jan 2019 17:40:20 +0100
Message-Id: <20190109164025.24554-11-rpenyaev@suse.de>
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

When epfd is polled by userspace and new item is inserted:

1. Get free bit for a new item.
2. If expand for user items or user index is required - route all events
   to kernel lists and do expand.
3. If events are ready for newly inserted item - add event to uring,
   if events have been just routed to klists - add item to rdllist.
4. On error path mark user item as freed and route events to klist
   if ready event has not yet been observed by userspace.  That is
   needed to postpone bit put, otherwise newly allocated bit will
   corrupt user item.

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
 fs/eventpoll.c | 74 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 36c451c26681..4618db9c077c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1977,6 +1977,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	struct epitem *epi;
 	struct ep_pqueue epq;
 
+	lockdep_assert_held(&ep->mtx);
 	lockdep_assert_irqs_enabled();
 
 	user_watches = atomic_long_read(&ep->user->epoll_watches);
@@ -2002,6 +2003,43 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		RCU_INIT_POINTER(epi->ws, NULL);
 	}
 
+	if (ep_polled_by_user(ep)) {
+		struct user_epitem *uitem;
+		int bit;
+
+		bit = ep_get_bit(ep);
+		if (unlikely(bit < 0)) {
+			error = bit;
+			goto error_get_bit;
+		}
+		epi->bit = bit;
+		ep->items_nr++;
+
+		if (ep_expand_user_is_required(ep)) {
+			/*
+			 * Expand of user header or user index is required,
+			 * thus reroute all events to klists and then safely
+			 * vrealloc() the memory.
+			 */
+			write_lock_irq(&ep->lock);
+			ep_route_events_to_klists(ep);
+			write_unlock_irq(&ep->lock);
+
+			error = ep_expand_user_items(ep);
+			if (unlikely(error))
+				goto error_expand;
+
+			error = ep_expand_user_index(ep);
+			if (unlikely(error))
+				goto error_expand;
+		}
+
+		/* Now fill-in user item */
+		uitem = &ep->user_header->items[epi->bit];
+		uitem->ready_events = 0;
+		uitem->event = *event;
+	}
+
 	/* Initialize the poll table using the queue callback */
 	epq.epi = epi;
 	init_poll_funcptr(&epq.pt, ep_ptable_queue_proc);
@@ -2046,16 +2084,23 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
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
+		if (ep_events_routed_to_uring(ep))
+			added = ep_add_event_to_uring(epi, revents);
+		else if (!ep_is_linked(epi)) {
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
@@ -2089,6 +2134,17 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		list_del_init(&epi->rdllink);
 	write_unlock_irq(&ep->lock);
 
+	if (ep_polled_by_user(ep)) {
+error_expand:
+		/*
+		 * No need to check return value: if events are routed to
+		 * klists, that is done by code above, where we've expanded
+		 * memory, but here, on rollback, we do not care.
+		 */
+		(void)ep_free_user_item(epi);
+	}
+
+error_get_bit:
 	wakeup_source_unregister(ep_wakeup_source(epi));
 
 error_create_wakeup_source:
-- 
2.19.1

