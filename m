Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeDRHPN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:15:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753352AbeDRHPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:15:11 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 18 Apr 2018 16:47:02 +1000
Subject: [PATCH 6/6] rhashtable: add rhashtable_walk_prev()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152403402206.16895.14563720960374849428.stgit2@noble>
In-Reply-To: <152403346237.16895.8767189357062722046.stgit2@noble>
References: <152403346237.16895.8767189357062722046.stgit2@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_walk_prev() returns the object returned by
the previous rhashtable_walk_next(), providing it is still in the
table (or was during this grace period).
This works even if rhashtable_walk_stop() and rhashtable_talk_start()
have been called since the last rhashtable_walk_next().

If there have been no calls to rhashtable_walk_next(), or if the
object is gone from the table, then NULL is returned.

This can usefully be used in a seq_file ->start() function.
If the pos is the same as was returned by the last ->next() call,
then rhashtable_walk_prev() can be used to re-establish the
current location in the table.  If it returns NULL, then
rhashtable_walk_next() should be used.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    1 +
 lib/rhashtable.c           |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 5ce6201f246e..b1ad2b6a3f3f 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -397,6 +397,7 @@ static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
 void *rhashtable_walk_peek(struct rhashtable_iter *iter);
+void *rhashtable_walk_prev(struct rhashtable_iter *iter);
 void rhashtable_walk_stop(struct rhashtable_iter *iter) __releases(RCU);
 
 void rhashtable_free_and_destroy(struct rhashtable *ht,
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index be7eb57d9398..d2f941146ea3 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -910,6 +910,36 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
 
+/**
+ * rhashtable_walk_prev - Return the previously returned object, if available
+ * @iter:	Hash table iterator
+ *
+ * If rhashtable_walk_next() has previously been called and the object
+ * it returned is still in the hash table, that object is returned again,
+ * otherwise %NULL is returned.
+ *
+ * If the recent rhashtable_walk_next() call was since the most recent
+ * rhashtable_walk_start() call then the returned object may not, strictly
+ * speaking, still be in the table.  It will be safe to dereference.
+ *
+ * Note that the iterator is not changed and in particular it does not
+ * step backwards.
+ */
+void *rhashtable_walk_prev(struct rhashtable_iter *iter)
+{
+	struct rhashtable *ht = iter->ht;
+	struct rhash_head *p = iter->p;
+
+	if (!p)
+		return NULL;
+	if (!iter->p_is_unsafe || ht->rhlist)
+		return p;
+	rht_for_each_rcu(p, iter->walker.tbl, iter->slot)
+		if (p == iter->p)
+			return p;
+	return NULL;
+}
+
 /**
  * rhashtable_walk_peek - Return the next object but don't advance the iterator
  * @iter:	Hash table iterator
