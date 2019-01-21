Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8152C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADB020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAUUQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:16:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:55614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727867AbfAUUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA05CAFF8;
        Mon, 21 Jan 2019 20:15:14 +0000 (UTC)
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
Subject: [RFC PATCH v2 06/13] epoll: introduce helpers for adding/removing events to uring
Date:   Mon, 21 Jan 2019 21:14:49 +0100
Message-Id: <20190121201456.28338-7-rpenyaev@suse.de>
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

Both add and remove events are lockless and can be called in parallel.

ep_add_event_to_uring():
	o user item is marked atomically as ready
	o if on previous stem user item was observed as not ready,
	  then new entry is created for the index uring.

ep_remove_user_item():
	o user item is marked as EPOLLREMOVED only if it was ready,
	  thus userspace will obseve previously added entry in index
	  uring and correct "removed" state of the item.

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
 fs/eventpoll.c                 | 129 +++++++++++++++++++++++++++++++++
 include/uapi/linux/eventpoll.h |   3 +
 2 files changed, 132 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 891cc7db8f8d..26d837252ba4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -189,6 +189,9 @@ struct epitem {
 
 	/* Work for offloading event callback */
 	struct work_struct work;
+
+	/* Bit in user bitmap for user polling */
+	unsigned int bit;
 };
 
 /*
@@ -427,6 +430,11 @@ static inline unsigned int ep_to_items_bm_length(unsigned int nr)
 	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
 }
 
+static inline unsigned int ep_max_index_nr(struct eventpoll *ep)
+{
+	return ep->index_length >> ilog2(sizeof(*ep->user_index));
+}
+
 static inline bool ep_polled_by_user(struct eventpoll *ep)
 {
 	return !!ep->user_header;
@@ -857,6 +865,127 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+#define atomic_set_unless_zero(ptr, flags)			\
+({								\
+	typeof(ptr) _ptr = (ptr);				\
+	typeof(flags) _flags = (flags);				\
+	typeof(*_ptr) _old, _val = READ_ONCE(*_ptr);		\
+								\
+	for (;;) {						\
+		if (!_val)					\
+			break;					\
+		_old = cmpxchg(_ptr, _val, _flags);		\
+		if (_old == _val)				\
+			break;					\
+		_val = _old;					\
+	}							\
+	_val;							\
+})
+
+static inline void ep_remove_user_item(struct epitem *epi)
+{
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+
+	lockdep_assert_held(&ep->mtx);
+
+	/* Event should not have any attached queues */
+	WARN_ON(!list_empty(&epi->pwqlist));
+
+	uitem = &ep->user_header->items[epi->bit];
+
+	/*
+	 * User item can be in two states: signaled (read_events is set
+	 * and userspace has not yet consumed this event) and not signaled
+	 * (no events yet fired or already consumed by userspace).
+	 * We reset ready_events to EPOLLREMOVED only if ready_events is
+	 * in signaled state (we expect that userspace will come soon and
+	 * fetch this event).  In case of not signaled leave read_events
+	 * as 0.
+	 *
+	 * Why it is important to mark read_events as EPOLLREMOVED in case
+	 * of already signaled state?  ep_insert() op can be immediately
+	 * called after ep_remove(), thus the same bit can be reused and
+	 * then new event comes, which corresponds to the same entry inside
+	 * user items array.  For this particular case ep_add_event_to_uring()
+	 * does not allocate a new index entry, but simply masks EPOLLREMOVED,
+	 * and userspace uses old index entry, but meanwhile old user item
+	 * has been removed, new item has been added and event updated.
+	 */
+	atomic_set_unless_zero(&uitem->ready_events, EPOLLREMOVED);
+	clear_bit(epi->bit, ep->items_bm);
+}
+
+#define atomic_or_with_mask(ptr, flags, mask)			\
+({								\
+	typeof(ptr) _ptr = (ptr);				\
+	typeof(flags) _flags = (flags);				\
+	typeof(flags) _mask = (mask);				\
+	typeof(*_ptr) _old, _new, _val = READ_ONCE(*_ptr);	\
+								\
+	for (;;) {						\
+		_new = (_val & ~_mask) | _flags;		\
+		_old = cmpxchg(_ptr, _val, _new);		\
+		if (_old == _val)				\
+			break;					\
+		_val = _old;					\
+	}							\
+	_val;							\
+})
+
+static inline bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
+{
+	struct eventpoll *ep = epi->ep;
+	struct epoll_uitem *uitem;
+	bool added = false;
+
+	if (WARN_ON(!pollflags))
+		return false;
+
+	uitem = &ep->user_header->items[epi->bit];
+	/*
+	 * Can be represented as:
+	 *
+	 *    was_ready = uitem->ready_events;
+	 *    uitem->ready_events &= ~EPOLLREMOVED;
+	 *    uitem->ready_events |= pollflags;
+	 *    if (!was_ready) {
+	 *         // create index entry
+	 *    }
+	 *
+	 * See the big comment inside ep_remove_user_item(), why it is
+	 * important to mask EPOLLREMOVED.
+	 */
+	if (!atomic_or_with_mask(&uitem->ready_events,
+				 pollflags, EPOLLREMOVED)) {
+		unsigned int i, *item_idx, index_mask;
+
+		/*
+		 * Item was not ready before, thus we have to insert
+		 * new index to the ring.
+		 */
+
+		index_mask = ep_max_index_nr(ep) - 1;
+		i = __atomic_fetch_add(&ep->user_header->tail, 1,
+				       __ATOMIC_ACQUIRE);
+		item_idx = &ep->user_index[i & index_mask];
+
+		/* Signal with a bit, which is > 0 */
+		*item_idx = epi->bit + 1;
+
+		/*
+		 * Want index update be flushed from CPU write buffer and
+		 * immediately visible on userspace side to avoid long busy
+		 * loops.
+		 */
+		smp_wmb();
+
+		added = true;
+	}
+
+	return added;
+}
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index fd06efe5d07e..2008d445b62e 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -42,6 +42,9 @@
 #define EPOLLMSG	(__force __poll_t)0x00000400
 #define EPOLLRDHUP	(__force __poll_t)0x00002000
 
+/* User item marked as removed for EPOLL_USERPOLL */
+#define EPOLLREMOVED	((__force __poll_t)(1U << 27))
+
 /* Set exclusive wakeup mode for the target file descriptor */
 #define EPOLLEXCLUSIVE	((__force __poll_t)(1U << 28))
 
-- 
2.19.1

