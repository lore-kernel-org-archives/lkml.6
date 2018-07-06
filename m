Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BBC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41975219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41975219AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeGFHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753667AbeGFHNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:13:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3CA8AD80;
        Fri,  6 Jul 2018 07:13:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Date:   Fri, 06 Jul 2018 17:11:32 +1000
Subject: [PATCH 3/3] rhashtable: implement rhashtable_walk_peek() using
 rhashtable_walk_last_seen()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086109264.2825.11991390917806468054.stgit@noble>
In-Reply-To: <153086101070.2825.6850140624411927465.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_walk_last_seen() does most of the work that
rhashtable_walk_peek() needs done, so use it and put
it in a "static inline".
Also update the documentation for rhashtable_walk_peek() to clarify
the expected use case.

Acked-by: Tom Herbert <tom@quantonium.net>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   29 ++++++++++++++++++++++++++++-
 lib/rhashtable.c           |   34 ----------------------------------
 2 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index d63b472e9d50..96ebc2690027 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -247,10 +247,37 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
-void *rhashtable_walk_peek(struct rhashtable_iter *iter);
 void *rhashtable_walk_last_seen(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
 
+/**
+ * rhashtable_walk_peek - Return the next object to use in an interrupted walk
+ * @iter:	Hash table iterator
+ *
+ * Returns the "current" object or NULL when the end of the table is reached.
+ * When an rhashtable_walk is interrupted with rhashtable_walk_stop(),
+ * it is often because an object was found that could not be processed
+ * immediately, possible because there is no more space to encode details
+ * of the object (e.g. when producing a seq_file from the table).
+ * When the walk is restarted, the same object needs to be processed again,
+ * if possible.  The object might have been removed from the table while
+ * the walk was paused, so it might not be available.  In that case, the
+ * normal "next" object should be treated as "current".
+ *
+ * To support this common case, rhashtable_walk_peek() returns the
+ * appropriate object to process after an interrupted walk, either the
+ * one that was most recently returned, or if that doesn't exist - the
+ * next one.
+ *
+ * Returns -EAGAIN if resize event occurred.  In that case the iterator
+ * will rewind back to the beginning and you may continue to use it.
+ */
+static inline void *rhashtable_walk_peek(struct rhashtable_iter *iter)
+{
+	return rhashtable_walk_last_seen(iter) ?:
+		rhashtable_walk_next(iter);
+}
+
 void rhashtable_free_and_destroy(struct rhashtable *ht,
 				 void (*free_fn)(void *ptr, void *arg),
 				 void *arg);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 2d0227822262..9ddb7134285e 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -913,40 +913,6 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
 
-/**
- * rhashtable_walk_peek - Return the next object but don't advance the iterator
- * @iter:	Hash table iterator
- *
- * Returns the next object or NULL when the end of the table is reached.
- *
- * Returns -EAGAIN if resize event occurred.  Note that the iterator
- * will rewind back to the beginning and you may continue to use it.
- */
-void *rhashtable_walk_peek(struct rhashtable_iter *iter)
-{
-	struct rhlist_head *list = iter->list;
-	struct rhashtable *ht = iter->ht;
-	struct rhash_head *p = iter->p;
-
-	if (p)
-		return rht_obj(ht, ht->rhlist ? &list->rhead : p);
-
-	/* No object found in current iter, find next one in the table. */
-
-	if (iter->skip) {
-		/* A nonzero skip value points to the next entry in the table
-		 * beyond that last one that was found. Decrement skip so
-		 * we find the current value. __rhashtable_walk_find_next
-		 * will restore the original value of skip assuming that
-		 * the table hasn't changed.
-		 */
-		iter->skip--;
-	}
-
-	return __rhashtable_walk_find_next(iter);
-}
-EXPORT_SYMBOL_GPL(rhashtable_walk_peek);
-
 /**
  * rhashtable_walk_last_seen - Return the previously returned object, if available
  * @iter:	Hash table iterator


