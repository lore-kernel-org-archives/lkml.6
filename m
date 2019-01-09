Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D24720859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfAIQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:40:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbfAIQkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A039AF82;
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
Subject: [RFC PATCH 09/15] epoll: introduce stand-alone helpers for polling from userspace
Date:   Wed,  9 Jan 2019 17:40:19 +0100
Message-Id: <20190109164025.24554-10-rpenyaev@suse.de>
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

ep_vrealloc*()
    realloc user header, user index or bitmap memory

ep_get_bit()
    gets free bit from bitmap, if free bit is not found - bitmap is
    expanded on PAGE_SIZE

ep_expand_user_is_required()
    helper which returna true if expand for different memory chunks
    is required

ep_shrink_user_is_required()
    helper which returna new size if shrink for different memory chunks
    is required

ep_expand_user_*()
    expands user header or user index

ep_shrink_user_*()
    shrinks user header, user index or bitmaps.  In case of srink there
    is an important procedure of moving sparsed bits at the end to the
    beginning of the bitmap, in order to free pages at the end.

ep_route_events_to_*()
    routes events to klists or to uring.  Should be called under write
    lock, when all events are stopped.

ep_free_user_item()
    marks item inside user pointer as freed, i.e. atomically exchanges
    ready_events to 0.  Also puts item bit or postponed it to period,
    when user goes to kernel.

ep_add_event_to_uring()
    adds new event to user ring.  Firstly mark user item as ready and if
    item was observed as not ready - fill in user index.

ep_transfer_events_and_shrunk_uring()
    shrinks if needed and transfers events in klists to uring under the
    write lock.

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
 fs/eventpoll.c | 420 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 420 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index bdaec59a847e..36c451c26681 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -929,6 +929,238 @@ static void epi_rcu_free(struct rcu_head *head)
 	kmem_cache_free(epi_cache, epi);
 }
 
+static int ep_vrealloc(void **pptr, unsigned int size)
+{
+	void *old = *pptr, *new;
+
+	new = vrealloc(old, size);
+	if (unlikely(!new))
+		return -ENOMEM;
+	if (unlikely(new == old))
+		return 0;
+
+	*pptr = new;
+	vfree(old);
+
+	return 0;
+}
+
+static int ep_vrealloc_bm(struct eventpoll *ep, unsigned int bm_len)
+{
+	unsigned long *bm, *removed_bm;
+
+	/* Reallocate all at once */
+	bm = vrealloc(ep->items_bm, bm_len);
+	removed_bm = vrealloc(ep->removed_items_bm, bm_len);
+
+	if (unlikely(!bm || !removed_bm)) {
+		vfree(bm);
+		vfree(removed_bm);
+
+		return -ENOMEM;
+	}
+	ep->items_bm = bm;
+	ep->removed_items_bm = removed_bm;
+	ep->items_bm_length = bm_len;
+
+	return 0;
+}
+
+static int ep_get_bit(struct eventpoll *ep)
+{
+	unsigned int max_nr;
+	int bit, start_bit;
+	bool was_set;
+
+	lockdep_assert_held(&ep->mtx);
+
+	start_bit = 0;
+again:
+	max_nr = ep_max_items_bm_nr(ep);
+	bit = find_next_zero_bit(ep->items_bm, max_nr, start_bit);
+	if (bit >= max_nr) {
+		unsigned int bm_len;
+		int rc;
+
+		start_bit = max_nr;
+		bm_len = ep->items_bm_length + PAGE_SIZE;
+
+		rc = ep_vrealloc_bm(ep, bm_len);
+		if (unlikely(rc))
+			return rc;
+
+		goto again;
+	}
+
+	was_set = test_and_set_bit(bit, ep->items_bm);
+	WARN_ON(was_set);
+
+	return bit;
+}
+
+static inline bool ep_expand_user_items_is_required(struct eventpoll *ep)
+{
+	return (ep->items_nr >= ep_max_items_nr(ep));
+}
+
+static inline bool ep_expand_user_index_is_required(struct eventpoll *ep)
+{
+	return (ep->items_nr + EPOLL_USER_EXTRA_INDEX_NR)
+		>= ep_max_index_nr(ep);
+}
+
+static inline bool ep_expand_user_is_required(struct eventpoll *ep)
+{
+	return ep_expand_user_items_is_required(ep) ||
+		ep_expand_user_index_is_required(ep);
+}
+
+static inline unsigned int ep_shrunk_user_index_length(struct eventpoll *ep)
+{
+	unsigned int len, nr;
+
+	nr = ep->items_nr + EPOLL_USER_EXTRA_INDEX_NR;
+	len = PAGE_ALIGN(to_index_length(nr) + (PAGE_SIZE >> 1));
+	if (len < ep->index_length)
+		return len;
+
+	return 0;
+}
+
+static inline unsigned int ep_shrunk_user_items_length(struct eventpoll *ep)
+{
+	unsigned int len;
+
+	len = PAGE_ALIGN(to_items_length(ep->items_nr) + (PAGE_SIZE >> 1));
+	if (len < ep->header_length)
+		return len;
+
+	return 0;
+}
+
+static inline unsigned int ep_shrunk_items_bm_length(struct eventpoll *ep)
+{
+	unsigned int len;
+
+	len = PAGE_ALIGN(to_items_bm_length(ep->items_nr) + (PAGE_SIZE >> 1));
+	if (len < ep->items_bm_length)
+		return len;
+
+	return 0;
+}
+
+static inline bool ep_shrink_user_is_required(struct eventpoll *ep)
+{
+	return ep_shrunk_user_items_length(ep) != 0 ||
+		ep_shrunk_user_index_length(ep) != 0 ||
+		ep_shrunk_items_bm_length(ep) != 0;
+}
+
+static inline void ep_route_events_to_klists(struct eventpoll *ep)
+{
+	WARN_ON(!ep_polled_by_user(ep));
+	ep->events_to_uring = false;
+	ep->user_header->state = EPOLL_USER_POLL_INACTIVE;
+	/* Make sure userspace sees INACTIVE state ASAP */
+	smp_wmb();
+}
+
+static inline void ep_route_events_to_uring(struct eventpoll *ep)
+{
+	WARN_ON(!ep_polled_by_user(ep));
+	ep->events_to_uring = true;
+	/* Commit all previous writes to user header */
+	smp_wmb();
+	ep->user_header->state = EPOLL_USER_POLL_ACTIVE;
+}
+
+static inline bool ep_events_routed_to_klists(struct eventpoll *ep)
+{
+	return !ep->events_to_uring;
+}
+
+static inline bool ep_events_routed_to_uring(struct eventpoll *ep)
+{
+	return ep->events_to_uring;
+}
+
+static inline bool ep_free_user_item(struct epitem *epi)
+{
+	struct eventpoll *ep = epi->ep;
+	struct user_epitem *uitem;
+
+	bool events_to_klist = false;
+
+	lockdep_assert_held(&ep->mtx);
+
+	ep->items_nr--;
+
+	uitem = &ep->user_header->items[epi->bit];
+
+	/* Firstly drop item events passed from userland */
+	memset(&uitem->event, 0, sizeof(uitem->event));
+
+	/*
+	 * If event is not signaled yet and has been already consumed by
+	 * userspace it is safe to reuse the bit immediately, i.e. just
+	 * put it.  If userspace has not been yet consumed this event
+	 * we set the bit in removed bitmap in order to put it later.
+	 */
+	if (xchg(&uitem->ready_events, 0)) {
+		set_bit(epi->bit, ep->removed_items_bm);
+		events_to_klist = true;
+	} else {
+		/*
+		 * Should not be reordered with memset above, thus unlock
+		 * semantics.
+		 */
+		clear_bit_unlock(epi->bit, ep->items_bm);
+		events_to_klist = ep_shrink_user_is_required(ep);
+	}
+
+	return events_to_klist;
+}
+
+static bool ep_add_event_to_uring(struct epitem *epi, __poll_t pollflags)
+{
+	struct eventpoll *ep = epi->ep;
+	struct user_epitem *uitem;
+	bool added = false;
+
+	if (WARN_ON(!pollflags))
+		return false;
+
+	uitem = &ep->user_header->items[epi->bit];
+	if (!__atomic_fetch_or(&uitem->ready_events, pollflags,
+			       __ATOMIC_ACQUIRE)) {
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
@@ -1695,6 +1927,44 @@ static noinline void ep_destroy_wakeup_source(struct epitem *epi)
 	wakeup_source_unregister(ws);
 }
 
+static int ep_expand_user_items(struct eventpoll *ep)
+{
+	unsigned int len;
+	int rc;
+
+	if (!ep_expand_user_items_is_required(ep))
+		/* Expanding is not needed */
+		return 0;
+
+	len = ep->header_length + PAGE_SIZE;
+	rc = ep_vrealloc((void **)&ep->user_header, len);
+	if (unlikely(rc))
+		return rc;
+
+	ep->header_length = len;
+
+	return 0;
+}
+
+static int ep_expand_user_index(struct eventpoll *ep)
+{
+	unsigned int len;
+	int rc;
+
+	if (!ep_expand_user_index_is_required(ep))
+		/* Expanding is not needed */
+		return 0;
+
+	len = ep->index_length + PAGE_SIZE;
+	rc = ep_vrealloc((void **)&ep->user_index, len);
+	if (unlikely(rc))
+		return rc;
+
+	ep->index_length = len;
+
+	return 0;
+}
+
 /*
  * Must be called with "mtx" held.
  */
@@ -2010,6 +2280,156 @@ static inline struct timespec64 ep_set_mstimeout(long ms)
 	return timespec64_add_safe(now, ts);
 }
 
+static int ep_shrink_user_index(struct eventpoll *ep)
+{
+	unsigned int len;
+	int rc;
+
+	len = ep_shrunk_user_index_length(ep);
+	if (!len)
+		/* Shrinking is not needed */
+		return 0;
+
+	rc = ep_vrealloc((void **)&ep->user_index, len);
+	if (unlikely(rc))
+		return rc;
+
+	ep->index_length = len;
+
+	return 0;
+}
+
+static int ep_shrink_user_items_and_bm(struct eventpoll *ep)
+{
+	unsigned int header_len, bm_len;
+	unsigned int bit, last_bit = UINT_MAX;
+	int rc;
+
+	struct rb_node *rbp;
+	struct epitem *epi;
+
+	lockdep_assert_held(&ep->mtx);
+
+	header_len = ep_shrunk_user_items_length(ep);
+	bm_len = ep_shrunk_items_bm_length(ep);
+	if (!header_len && !bm_len)
+		/* Shrinking is not needed */
+		return 0;
+
+	/*
+	 * Find left most last bit
+	 */
+	if (header_len)
+		last_bit = to_items_nr(header_len);
+	if (bm_len)
+		last_bit = min(last_bit, to_items_bm_nr(header_len));
+
+	if (WARN_ON(last_bit <= ep->items_nr))
+		return -EINVAL;
+
+	/*
+	 * Find bits from the right and move them to the left in order to
+	 * free space on the right.
+	 *
+	 * This is not nice, because O(n), but frankly this operation should
+	 * be quite rare.  If not - let's switch to idr or something similar
+	 * (but that obviously will consume more memory).
+	 *
+	 */
+	bit = 0;
+	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
+		epi = rb_entry(rbp, struct epitem, rbn);
+
+		if (epi->bit >= last_bit) {
+			/* Find first available bit from left */
+			bit = find_next_zero_bit(ep->items_bm, last_bit, bit);
+			if (WARN_ON(bit >= last_bit))
+				return -EINVAL;
+
+			/* Clear old bit from right */
+			clear_bit(epi->bit, ep->items_bm);
+
+			/*
+			 * Set item bit and advance an iterator for the
+			 * following find_next_zero_bit() call.
+			 */
+			epi->bit = bit++;
+		}
+	}
+
+	/*
+	 * Reallocate memory and commit lengths
+	 */
+	if (header_len) {
+		rc = ep_vrealloc((void **)&ep->user_header, header_len);
+		if (unlikely(rc))
+			return rc;
+
+		ep->header_length = header_len;
+	}
+	if (bm_len) {
+		rc = ep_vrealloc_bm(ep, bm_len);
+		if (unlikely(rc))
+			return rc;
+	}
+
+	return 0;
+}
+
+static inline void ep_put_postponed_user_items_bits(struct eventpoll *ep)
+{
+	size_t sz, i;
+
+	lockdep_assert_held(&ep->mtx);
+
+	sz = ep->items_bm_length >> ilog2(sizeof(ep->items_bm[0]));
+	for (i = 0; i < sz; i++) {
+		ep->items_bm[i] &= ~(ep->removed_items_bm[i]);
+		ep->removed_items_bm[i] = 0ul;
+	}
+}
+
+static int ep_transfer_events_and_shrink_uring(struct eventpoll *ep)
+{
+	struct epitem *epi, *tmp;
+	int rc = 0;
+
+	mutex_lock(&ep->mtx);
+	if (ep_events_routed_to_uring(ep))
+		/* A bit late */
+		goto unlock;
+
+	/* Here at this point we are sure uring is empty */
+	ep_put_postponed_user_items_bits(ep);
+
+	rc = ep_shrink_user_index(ep);
+	if (unlikely(rc))
+		goto unlock;
+
+	rc = ep_shrink_user_items_and_bm(ep);
+	if (unlikely(rc))
+		goto unlock;
+
+	/* Commit lengths to userspace, but state is not yet ACTIVE */
+	ep->user_header->index_length = ep->index_length;
+	ep->user_header->header_length = ep->header_length;
+
+	write_lock_irq(&ep->lock);
+	/* Atomically transfer events from klists to uring */
+	list_for_each_entry_safe(epi, tmp, &ep->rdllist, rdllink) {
+		ep_add_event_to_uring(epi, epi->ready_events);
+		list_del_init(&epi->rdllink);
+		epi->ready_events = 0;
+	}
+	ep_route_events_to_uring(ep);
+	write_unlock_irq(&ep->lock);
+
+unlock:
+	mutex_unlock(&ep->mtx);
+
+	return rc;
+}
+
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller supplied
  *           event buffer.
-- 
2.19.1

