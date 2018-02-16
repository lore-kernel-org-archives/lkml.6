Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeBPHlJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753697AbeBPHlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:41:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC333217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=mst@redhat.com
Date: Fri, 16 Feb 2018 09:40:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, David Miller <davem@davemloft.net>
Subject: [RFC PATCH] ptr_ring: linked list fallback
Message-ID: <20180216094054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.8.0.287.g0deeb61
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So pointer rings work fine, but they have a problem:
make them too small and not enough entries fit.
Make them too large and you start flushing your cache
and running out of memory.

This is a new idea of mine: a ring backed by a
linked list. Once you run out of rin entries,
instead of a drop you fall back on a list with
a common lock.

Should work well for the case where the ring is typically sized
correctly, but will help address the fact that some user try to set e.g.
tx queue length to 1000000.

My hope this will move us closer to direction where e.g. fw codel can
use ptr rings without locking at all.
The API is still very rough, and I really need to take a hard look
at lock nesting.

Completely untested, sending for early feedback/flames.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/ptr_ring.h | 64 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index d72b2e7..7bf2b7b 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -31,11 +31,18 @@
 #include <asm/errno.h>
 #endif
 
+/* entries must start with the following structure */
+struct plist {
+	struct plist *next;
+	struct plist *last; /* only valid in the 1st entry */
+};
+
 struct ptr_ring {
 	int producer ____cacheline_aligned_in_smp;
 	spinlock_t producer_lock;
 	int consumer_head ____cacheline_aligned_in_smp; /* next valid entry */
 	int consumer_tail; /* next entry to invalidate */
+	struct plist *consumer_list;
 	spinlock_t consumer_lock;
 	/* Shared consumer/producer data */
 	/* Read-only by both the producer and the consumer */
@@ -120,10 +127,40 @@ static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 }
 
 /*
- * Note: resize (below) nests producer lock within consumer lock, so if you
- * consume in interrupt or BH context, you must disable interrupts/BH when
- * calling this.
+ * Note: resize API with the _fallback should be used when calling this.
  */
+static inline int ptr_ring_produce_fallback(struct ptr_ring *r, void *ptr)
+{
+	int ret;
+	unsigned long flags;
+	plit *p = ptr;
+
+	p->next = NULL;
+	p->last = p;
+
+	spin_lock_irqsave(&r->producer_lock, flags);
+	ret = __ptr_ring_produce(r, ptr);
+	if (ret) {
+		spin_lock(&r->consumer_lock);
+		ret = __ptr_ring_produce(r, ptr);
+		if (ret) {
+			int producer = r->producer ? r->producer - 1 :
+				r->size - 1;
+			plist *first = r->queue[producer];
+
+			BUG_ON(!first);
+
+			first->last->next = p;
+			first->last = p;
+		}
+		spin_unlock(&r->consumer_lock);
+	}
+
+	spin_unlock_irqrestore(&r->producer_lock, flags);
+
+	return ret;
+}
+
 static inline int ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
 	int ret;
@@ -135,6 +172,7 @@ static inline int ptr_ring_produce(struct ptr_ring *r, void *ptr)
 	return ret;
 }
 
+
 static inline int ptr_ring_produce_irq(struct ptr_ring *r, void *ptr)
 {
 	int ret;
@@ -359,6 +397,26 @@ static inline void *ptr_ring_consume_bh(struct ptr_ring *r)
 	return ptr;
 }
 
+static inline void *ptr_ring_consume_fallback(struct ptr_ring *r)
+{
+	unsigned long flags;
+	struct plist *ptr;
+
+	spin_lock_irqsave(&r->consumer_lock, flags);
+	if (r->consumer_list) {
+		ptr = r->consumer_list;
+		r->consumer_list = ptr->next;
+	} else {
+		ptr = __ptr_ring_consume(r);
+		if (ptr) {
+			r->consumer_list = ptr->next;
+		}
+	}
+	spin_unlock_irqrestore(&r->consumer_lock, flags);
+
+	return ptr;
+}
+
 static inline int ptr_ring_consume_batched(struct ptr_ring *r,
 					   void **array, int n)
 {
-- 
MST
