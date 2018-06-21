Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A2C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F194522415
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpp1bkKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F194522415
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbeFUVac (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:30:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933994AbeFUV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OA1HRAXFZvI4j1rFLzREHtl3P0DnYLjXh6PDxAVOVcE=; b=mpp1bkKRZ66tf+rRj+GaA8gEA
        Ed+HpF3iOdT3K28sfzg3DrngYFBrcPz7VUiX8ooi8Dkau0E1BIHuUyLqnARjBTEkvaHyI4xNpyxAi
        3lOw12YlHaDqk8eaYoru+RXf3PizreWe7K1TB9JBE+LKbAWGb4C8Q4VFeGaqBeq/TUkt7EU554ViL
        rVbDgYE/vWls6XqwXMUJKtn7I4cFTJAZcvaMMtFBCZ1Jzkwv9pK66S8x4/o9dtN9DnqW1ajviVzQc
        Q3GmD1RUo3T4cKzY424RKtkwSXdr3JonGlPJbTlhimgawZuan9t64/PJqnvMqhr5ytFkWujV1ZtN7
        BbcwLJicQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78h-0001dM-IK; Thu, 21 Jun 2018 21:29:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Jiri Pirko <jiri@mellanox.com>, Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 25/26] ida: Remove old API
Date:   Thu, 21 Jun 2018 14:28:34 -0700
Message-Id: <20180621212835.5636-26-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete ida_pre_get(), ida_get_new(), ida_get_new_above() and ida_remove()
from the public API.  Some of these functions still exist as internal
helpers, but they should not be called by consumers.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/idr.h | 21 ++++--------------
 lib/idr.c           | 52 ++++++++-------------------------------------
 lib/radix-tree.c    |  9 --------
 3 files changed, 13 insertions(+), 69 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index cd339da0b1aa..2e1db0e36486 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -225,13 +225,9 @@ struct ida {
 }
 #define DEFINE_IDA(name)	struct ida name = IDA_INIT(name)
 
-int ida_pre_get(struct ida *ida, gfp_t gfp_mask);
-int ida_get_new_above(struct ida *ida, int starting_id, int *p_id);
-void ida_remove(struct ida *ida, int id);
-void ida_destroy(struct ida *ida);
-
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
 void ida_free(struct ida *, unsigned int id);
+void ida_destroy(struct ida *ida);
 
 /**
  * ida_alloc() - Allocate an unused ID.
@@ -292,20 +288,11 @@ static inline void ida_init(struct ida *ida)
 			ida_alloc_range(ida, start, (end) - 1, gfp)
 #define ida_simple_remove(ida, id)	ida_free(ida, id)
 
-/**
- * ida_get_new - allocate new ID
- * @ida:	idr handle
- * @p_id:	pointer to the allocated handle
- *
- * Simple wrapper around ida_get_new_above() w/ @starting_id of zero.
- */
-static inline int ida_get_new(struct ida *ida, int *p_id)
-{
-	return ida_get_new_above(ida, 0, p_id);
-}
-
 static inline bool ida_is_empty(const struct ida *ida)
 {
 	return radix_tree_empty(&ida->ida_rt);
 }
+
+/* in lib/radix-tree.c */
+int ida_pre_get(struct ida *ida, gfp_t gfp_mask);
 #endif /* __IDR_H__ */
diff --git a/lib/idr.c b/lib/idr.c
index 8b3a5e7eb734..1dc52191acb6 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -317,19 +317,12 @@ EXPORT_SYMBOL(idr_replace);
  * bit per ID, and so is more space efficient than an IDR.  To use an IDA,
  * define it using DEFINE_IDA() (or embed a &struct ida in a data structure,
  * then initialise it using ida_init()).  To allocate a new ID, call
- * ida_alloc(), ida_alloc_max() or ida_alloc_range().  To free an ID, call
- * ida_free().
+ * ida_alloc(), ida_alloc_min(), ida_alloc_max() or ida_alloc_range().
+ * To free an ID, call ida_free().
  *
- * If you have more complex locking requirements, use a loop around
- * ida_pre_get() and ida_get_new() to allocate a new ID.  Then use
- * ida_remove() to free an ID.  You must make sure that ida_get_new() and
- * ida_remove() cannot be called at the same time as each other for the
- * same IDA.
- *
- * You can also use ida_get_new_above() if you need an ID to be allocated
- * above a particular number.  ida_destroy() can be used to dispose of an
- * IDA without needing to free the individual IDs in it.  You can use
- * ida_is_empty() to find out whether the IDA has any IDs currently allocated.
+ * ida_destroy() can be used to dispose of an IDA without needing to
+ * free the individual IDs in it.  You can use ida_is_empty() to find
+ * out whether the IDA has any IDs currently allocated.
  *
  * IDs are currently limited to the range [0-INT_MAX].  If this is an awkward
  * limitation, it should be quite straightforward to raise the maximum.
@@ -370,25 +363,7 @@ EXPORT_SYMBOL(idr_replace);
 
 #define IDA_MAX (0x80000000U / IDA_BITMAP_BITS - 1)
 
-/**
- * ida_get_new_above - allocate new ID above or equal to a start id
- * @ida: ida handle
- * @start: id to start search at
- * @id: pointer to the allocated handle
- *
- * Allocate new ID above or equal to @start.  It should be called
- * with any required locks to ensure that concurrent calls to
- * ida_get_new_above() / ida_get_new() / ida_remove() are not allowed.
- * Consider using ida_alloc_range() if you do not have complex locking
- * requirements.
- *
- * If memory is required, it will return %-EAGAIN, you should unlock
- * and go back to the ida_pre_get() call.  If the ida is full, it will
- * return %-ENOSPC.  On success, it will return 0.
- *
- * @id returns a value in the range @start ... %0x7fffffff.
- */
-int ida_get_new_above(struct ida *ida, int start, int *id)
+static int ida_get_new_above(struct ida *ida, int start, int *id)
 {
 	struct radix_tree_root *root = &ida->ida_rt;
 	void __rcu **slot;
@@ -473,16 +448,8 @@ int ida_get_new_above(struct ida *ida, int start, int *id)
 		return 0;
 	}
 }
-EXPORT_SYMBOL(ida_get_new_above);
 
-/**
- * ida_remove - Free the given ID
- * @ida: ida handle
- * @id: ID to free
- *
- * This function should not be called at the same time as ida_get_new_above().
- */
-void ida_remove(struct ida *ida, int id)
+static void ida_remove(struct ida *ida, int id)
 {
 	unsigned long index = id / IDA_BITMAP_BITS;
 	unsigned offset = id % IDA_BITMAP_BITS;
@@ -519,9 +486,8 @@ void ida_remove(struct ida *ida, int id)
 	}
 	return;
  err:
-	WARN(1, "ida_remove called for id=%d which is not allocated.\n", id);
+	WARN(1, "ida_free called for id=%d which is not allocated.\n", id);
 }
-EXPORT_SYMBOL(ida_remove);
 
 /**
  * ida_destroy() - Free all IDs.
@@ -568,7 +534,7 @@ EXPORT_SYMBOL(ida_destroy);
 int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
 			gfp_t gfp)
 {
-	int ret, id;
+	int ret, id = 0;
 	unsigned long flags;
 
 	if ((int)min < 0)
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index a9e41aed6de4..c12b87981778 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -2106,14 +2106,6 @@ void idr_preload(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(idr_preload);
 
-/**
- * ida_pre_get - reserve resources for ida allocation
- * @ida: ida handle
- * @gfp: memory allocation flags
- *
- * This function should be called before calling ida_get_new_above().  If it
- * is unable to allocate memory, it will return %0.  On success, it returns %1.
- */
 int ida_pre_get(struct ida *ida, gfp_t gfp)
 {
 	/*
@@ -2134,7 +2126,6 @@ int ida_pre_get(struct ida *ida, gfp_t gfp)
 
 	return 1;
 }
-EXPORT_SYMBOL(ida_pre_get);
 
 void __rcu **idr_get_free(struct radix_tree_root *root,
 			      struct radix_tree_iter *iter, gfp_t gfp,
-- 
2.17.1

