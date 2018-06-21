Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9590C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9011E22443
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ecfNn78o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9011E22443
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933960AbeFUVgV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:36:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933888AbeFUV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MS+9FjqSxq10BaYCpZQnvxs11jd2CJSnPxoyQ4UJ4LQ=; b=ecfNn78o96oGZSgvfDRj311tv
        hgOZ1vUCXEaVHRCLugNxvvI5V9uoKwoJzaacutm4w02RbXvDpeMmfSc5BlvlJfcTnzXH7OPhlK8TW
        rA7RT89gyFbQ+rSdx/ffOQ0Mh6titP76TYkTdKkYDFG81hX/rPCRx+gIiBOfVb4ItAX0m8ovrX51p
        Wlzt3R+6v6i8Gv9y7OnSNNcMCSEH/PYmBaSPCLuFc/ULWaBSFaLHiiS7U0FZzOmcjaEmJm/RVr5gj
        NinK/rMtjMEo8eazP3d16fLt2Q5oWuFaVHpYvoJXVtPmHfA+M+pmNm8rie2b2ZozA9p3l4ub69Hx4
        ZlOsG5ZyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78Y-0001a6-2g; Thu, 21 Jun 2018 21:29:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 03/26] ida: Add new API
Date:   Thu, 21 Jun 2018 14:28:12 -0700
Message-Id: <20180621212835.5636-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h | 59 ++++++++++++++++++++++++++++++++++++--
 lib/idr.c           | 70 ++++++++++++++++++++-------------------------
 2 files changed, 87 insertions(+), 42 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index e856f4e0ab35..cd339da0b1aa 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -230,15 +230,68 @@ int ida_get_new_above(struct ida *ida, int starting_id, int *p_id);
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
index 352c6160e2e0..8b3a5e7eb734 100644
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
@@ -551,43 +552,34 @@ void ida_destroy(struct ida *ida)
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
 	xa_lock_irqsave(&ida->ida_rt, flags);
-	ret = ida_get_new_above(ida, start, &id);
+	ret = ida_get_new_above(ida, min, &id);
 	if (!ret) {
 		if (id > max) {
 			ida_remove(ida, id);
@@ -598,24 +590,24 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 	}
 	xa_unlock_irqrestore(&ida->ida_rt, flags);
 
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
 
@@ -624,4 +616,4 @@ void ida_simple_remove(struct ida *ida, unsigned int id)
 	ida_remove(ida, id);
 	xa_unlock_irqrestore(&ida->ida_rt, flags);
 }
-EXPORT_SYMBOL(ida_simple_remove);
+EXPORT_SYMBOL(ida_free);
-- 
2.17.1

