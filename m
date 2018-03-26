Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeCZRcG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:32:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbeCZRcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:32:03 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH 1/1] ida: Add new API
Date: Mon, 26 Mar 2018 10:30:37 -0700
Message-Id: <20180326173037.11824-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180326173037.11824-1-willy@infradead.org>
References: <20180326173037.11824-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Add ida_alloc(), ida_alloc_min(), ida_alloc_max(), ida_alloc_range()
and ida_free().  The ida_alloc_max() and ida_alloc_range() functions
differ from ida_simple_get() in that they take an inclusive 'max'
parameter instead of an exclusive 'end' parameter.  Callers are about
evenly split whether they'd like inclusive or exclusive parameters and
'max' is easier to document than 'end'.

Change the IDA allocation to first attempt to allocate a bit using
existing memory, and only allocate memory afterwards.  Also change the
behaviour of 'min' > INT_MAX from being a BUG() to returning -ENOSPC.

Leave compatibility wrappers in place for ida_simple_get() and
ida_simple_remove() to avoid changing all callers.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/idr.h | 59 +++++++++++++++++++++++++++++++++++++++++---
 lib/idr.c           | 70 ++++++++++++++++++++++++-----------------------------
 2 files changed, 87 insertions(+), 42 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 7d6a6313f0ab..b80bc1ede636 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -228,15 +228,68 @@ int ida_get_new_above(struct ida *ida, int starting_id, int *p_id);
 void ida_remove(struct ida *ida, int id);
 void ida_destroy(struct ida *ida);
 
-int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
-		   gfp_t gfp_mask);
-void ida_simple_remove(struct ida *ida, unsigned int id);
+int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
+void ida_free(struct ida *, unsigned int id);
+
+/**
+ * ida_alloc() - Allocate an unused ID.
+ * @ida: IDA handle.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate an ID between 0 and %INT_MAX, inclusive.
+ *
+ * Context: Any context.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
+ */
+static inline int ida_alloc(struct ida *ida, gfp_t gfp)
+{
+	return ida_alloc_range(ida, 0, ~0, gfp);
+}
+
+/**
+ * ida_alloc_min() - Allocate an unused ID.
+ * @ida: IDA handle.
+ * @min: Lowest ID to allocate.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate an ID between @min and %INT_MAX, inclusive.
+ *
+ * Context: Any context.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
+ */
+static inline int ida_alloc_min(struct ida *ida, unsigned int min, gfp_t gfp)
+{
+	return ida_alloc_range(ida, min, ~0, gfp);
+}
+
+/**
+ * ida_alloc_max() - Allocate an unused ID.
+ * @ida: IDA handle.
+ * @max: Highest ID to allocate.
+ * @gfp: Memory allocation flags.
+ *
+ * Allocate an ID between 0 and @max, inclusive.
+ *
+ * Context: Any context.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
+ */
+static inline int ida_alloc_max(struct ida *ida, unsigned int max, gfp_t gfp)
+{
+	return ida_alloc_range(ida, 0, max, gfp);
+}
 
 static inline void ida_init(struct ida *ida)
 {
 	INIT_RADIX_TREE(&ida->ida_rt, IDR_RT_MARKER | GFP_NOWAIT);
 }
 
+#define ida_simple_get(ida, start, end, gfp)	\
+			ida_alloc_range(ida, start, (end) - 1, gfp)
+#define ida_simple_remove(ida, id)	ida_free(ida, id)
+
 /**
  * ida_get_new - allocate new ID
  * @ida:	idr handle
diff --git a/lib/idr.c b/lib/idr.c
index 823b813f08f8..fab3763e8c2a 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -317,7 +317,8 @@ EXPORT_SYMBOL(idr_replace);
  * bit per ID, and so is more space efficient than an IDR.  To use an IDA,
  * define it using DEFINE_IDA() (or embed a &struct ida in a data structure,
  * then initialise it using ida_init()).  To allocate a new ID, call
- * ida_simple_get().  To free an ID, call ida_simple_remove().
+ * ida_alloc(), ida_alloc_max() or ida_alloc_range().  To free an ID, call
+ * ida_free().
  *
  * If you have more complex locking requirements, use a loop around
  * ida_pre_get() and ida_get_new() to allocate a new ID.  Then use
@@ -378,7 +379,7 @@ EXPORT_SYMBOL(idr_replace);
  * Allocate new ID above or equal to @start.  It should be called
  * with any required locks to ensure that concurrent calls to
  * ida_get_new_above() / ida_get_new() / ida_remove() are not allowed.
- * Consider using ida_simple_get() if you do not have complex locking
+ * Consider using ida_alloc_range() if you do not have complex locking
  * requirements.
  *
  * If memory is required, it will return %-EAGAIN, you should unlock
@@ -546,43 +547,34 @@ void ida_destroy(struct ida *ida)
 EXPORT_SYMBOL(ida_destroy);
 
 /**
- * ida_simple_get - get a new id.
- * @ida: the (initialized) ida.
- * @start: the minimum id (inclusive, < 0x8000000)
- * @end: the maximum id (exclusive, < 0x8000000 or 0)
- * @gfp_mask: memory allocation flags
- *
- * Allocates an id in the range start <= id < end, or returns -ENOSPC.
- * On memory allocation failure, returns -ENOMEM.
+ * ida_alloc_range() - Allocate an unused ID.
+ * @ida: IDA handle.
+ * @min: Lowest ID to allocate.
+ * @max: Highest ID to allocate.
+ * @gfp: Memory allocation flags.
  *
- * Compared to ida_get_new_above() this function does its own locking, and
- * should be used unless there are special requirements.
+ * Allocate an ID between @min and @max, inclusive.  The allocated ID will
+ * not exceed %INT_MAX, even if @max is larger.
  *
- * Use ida_simple_remove() to get rid of an id.
+ * Context: Any context.
+ * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
+ * or %-ENOSPC if there are no free IDs.
  */
-int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
-		   gfp_t gfp_mask)
+int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
+			gfp_t gfp)
 {
 	int ret, id;
-	unsigned int max;
 	unsigned long flags;
 
-	BUG_ON((int)start < 0);
-	BUG_ON((int)end < 0);
+	if ((int)min < 0)
+		return -ENOSPC;
 
-	if (end == 0)
-		max = 0x80000000;
-	else {
-		BUG_ON(end < start);
-		max = end - 1;
-	}
+	if ((int)max < 0)
+		max = INT_MAX;
 
 again:
-	if (!ida_pre_get(ida, gfp_mask))
-		return -ENOMEM;
-
 	spin_lock_irqsave(&simple_ida_lock, flags);
-	ret = ida_get_new_above(ida, start, &id);
+	ret = ida_get_new_above(ida, min, &id);
 	if (!ret) {
 		if (id > max) {
 			ida_remove(ida, id);
@@ -593,24 +585,24 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 	}
 	spin_unlock_irqrestore(&simple_ida_lock, flags);
 
-	if (unlikely(ret == -EAGAIN))
+	if (unlikely(ret == -EAGAIN)) {
+		if (!ida_pre_get(ida, gfp))
+			return -ENOMEM;
 		goto again;
+	}
 
 	return ret;
 }
-EXPORT_SYMBOL(ida_simple_get);
+EXPORT_SYMBOL(ida_alloc_range);
 
 /**
- * ida_simple_remove - remove an allocated id.
- * @ida: the (initialized) ida.
- * @id: the id returned by ida_simple_get.
- *
- * Use to release an id allocated with ida_simple_get().
+ * ida_free() - Release an allocated ID.
+ * @ida: IDA handle.
+ * @id: Previously allocated ID.
  *
- * Compared to ida_remove() this function does its own locking, and should be
- * used unless there are special requirements.
+ * Context: Any context.
  */
-void ida_simple_remove(struct ida *ida, unsigned int id)
+void ida_free(struct ida *ida, unsigned int id)
 {
 	unsigned long flags;
 
@@ -619,4 +611,4 @@ void ida_simple_remove(struct ida *ida, unsigned int id)
 	ida_remove(ida, id);
 	spin_unlock_irqrestore(&simple_ida_lock, flags);
 }
-EXPORT_SYMBOL(ida_simple_remove);
+EXPORT_SYMBOL(ida_free);
-- 
2.16.2
