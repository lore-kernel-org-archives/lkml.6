Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeEDDzO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeEDDzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:55:11 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 5/8] rhashtable: remove rhashtable_walk_peek()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605435.18473.12657571579874985957.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has a somewhat confused behavior that is not properly
described by the documentation.
Sometimes is returns the previous object, sometimes it returns the
next one.
Sometimes it changes the iterator, sometimes it doesn't.

This function is not currently used and is not worth keeping, so
remove it.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    1 -
 lib/rhashtable.c           |   34 ----------------------------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 8822924dd05a..5091abf975a1 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -366,7 +366,6 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
-void *rhashtable_walk_peek(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 114e6090228a..83f5d1ebf452 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -897,40 +897,6 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
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
  * rhashtable_walk_stop - Finish a hash table walk
  * @iter:	Hash table iterator
