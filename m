Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeC0Bvm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39021 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752397AbeC0Bvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:39 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 4/6] rhashtable: allow a walk of the hash table without
 missing objects.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210718430.11435.5761213978298714527.stgit@noble>
In-Reply-To: <152210688405.11435.13010923693146415942.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a walk of the hashtable can be done entirely under RCU,
no objects will be missed - though seeing duplicates is possible.
This is because a cursor is kept in iter->p.
Without the cursor we depend on the ->skip counter.  If an object
before the current location in hash chain is removed, the ->skip
counter will be too large and would could miss a later object.

In many cases where the walker needs to drop out of RCU protection,
it will take a reference to the object and this can prevent it from
being removed from the hash table.  In those cases, the last-returned
object can still be used as a cursor.  rhashtable cannot detect
these cases itself.

This patch adds a new rhashtable_walk_start_continue() interface which
is passed the last object returned.  This can be used if the caller
knows that the object is still in the hash table.  When it is used,
a walk of the hash table will return every object that was in the
hastable for the duration of the walk, at least once.  This can be
used, for example, to selectively delete objects from the table.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   28 ++++++++++++++++++++++++++--
 lib/rhashtable.c           |   42 ++++++++++++++++++++++++++----------------
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 3bd19d29f46b..4ffd96949d4f 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -387,11 +387,35 @@ void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 void rhashtable_walk_enter(struct rhashtable *ht,
 			   struct rhashtable_iter *iter);
 void rhashtable_walk_exit(struct rhashtable_iter *iter);
-int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires(RCU);
+int rhashtable_walk_start_continue(struct rhashtable_iter *iter,
+				   struct rhash_head *obj) __acquires(RCU);
+
+/**
+ * rhashtable_walk_start_check - Start a hash table walk
+ * @iter:	Hash table iterator
+ *
+ * Start a hash table walk at the current iterator position.  Note that we take
+ * the RCU lock in all cases including when we return an error.  So you must
+ * always call rhashtable_walk_stop to clean up.
+ *
+ * Returns zero if successful.
+ *
+ * Returns -EAGAIN if resize event occured.  Note that the iterator
+ * will rewind back to the beginning and you may use it immediately
+ * by calling rhashtable_walk_next.
+ *
+ * rhashtable_walk_start is defined as an inline variant that returns
+ * void. This is preferred in cases where the caller would ignore
+ * resize events and always continue.
+ */
+static inline int rhashtable_walk_start_check(struct rhashtable_iter *iter)
+{
+	return rhashtable_walk_start_continue(iter, NULL);
+}
 
 static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
 {
-	(void)rhashtable_walk_start_check(iter);
+	(void)rhashtable_walk_start_continue(iter, NULL);
 }
 
 void *rhashtable_walk_next(struct rhashtable_iter *iter);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 08018198f045..fd6f320b9704 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -702,30 +702,41 @@ void rhashtable_walk_exit(struct rhashtable_iter *iter)
 EXPORT_SYMBOL_GPL(rhashtable_walk_exit);
 
 /**
- * rhashtable_walk_start_check - Start a hash table walk
- * @iter:	Hash table iterator
+ * rhashtable_walk_start_continue - Restart a hash table walk from last object
+ * @iter:	Hask table iterator
+ * @obj:	pointer to rhash_head in last object returned.
+ *
+ * Restart a hash table walk, ensuring not to miss any objects.  The
+ * previously returned object must still be in the hash table, and must be
+ * provided as an argument.
  *
- * Start a hash table walk at the current iterator position.  Note that we take
- * the RCU lock in all cases including when we return an error.  So you must
- * always call rhashtable_walk_stop to clean up.
+ * When rhashtable_walk_start() or rhashtable_walk_start_check() is used,
+ * a deletion since the previous walk_start can result in objects being missed
+ * as a hash chain might be shorter than expected.  This can be avoided by
+ * using the last returned object as a cursor.
  *
- * Returns zero if successful.
+ * If the @obj passed is NULL, or not the most recently returned object,
+ * rhashtable_walk_start_continue() will act like rhashtable_walk_start_check();
  *
- * Returns -EAGAIN if resize event occured.  Note that the iterator
- * will rewind back to the beginning and you may use it immediately
- * by calling rhashtable_walk_next.
+ * Returns -EAGAIN if a resize event was detected.  The iterator will
+ * rewind back to the beginning and can be used immediately.  Seeing duplicates
+ * is possible but missing objects isn't.
+ * Returns zero if no resize event was detected.  This does not guarantee
+ * that no duplicates will be seen.
  *
- * rhashtable_walk_start is defined as an inline variant that returns
- * void. This is preferred in cases where the caller would ignore
- * resize events and always continue.
+ * Always takes the RCU read lock, so rhashtable_walk_stop() must always be called
+ * to clean up.
  */
-int rhashtable_walk_start_check(struct rhashtable_iter *iter)
+int rhashtable_walk_start_continue(struct rhashtable_iter *iter, struct rhash_head *obj)
 	__acquires(RCU)
 {
 	struct rhashtable *ht = iter->ht;
 
 	rcu_read_lock();
 
+	if (!obj || iter->p != obj)
+		iter->p = NULL;
+
 	spin_lock(&ht->lock);
 	if (iter->walker.tbl)
 		list_del(&iter->walker.list);
@@ -733,6 +744,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	if (!iter->walker.tbl && !iter->end_of_table) {
 		iter->walker.tbl = rht_dereference_rcu(ht->tbl, ht);
+		iter->p = NULL;
 		iter->slot = 0;
 		iter->skip = 0;
 		return -EAGAIN;
@@ -740,7 +752,7 @@ int rhashtable_walk_start_check(struct rhashtable_iter *iter)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rhashtable_walk_start_check);
+EXPORT_SYMBOL_GPL(rhashtable_walk_start_continue);
 
 /**
  * __rhashtable_walk_find_next - Find the next element in a table (or the first
@@ -922,8 +934,6 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
 		iter->walker.tbl = NULL;
 	spin_unlock(&ht->lock);
 
-	iter->p = NULL;
-
 out:
 	rcu_read_unlock();
 }
