Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFAErF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:47:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:34223 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751792AbeFAErB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:47:01 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 18/18] rhashtable: add rhashtable_walk_delay_rehash()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824995.30340.13986786072491794873.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function allows an rhashtable walk to complete
without any restarts as long as it progresses reasonably
quickly.
Any current rehash is waited for, then a counter is incremented
to stop any further rehash from happening until the 100%
occupancy mark is reached.
This particularly ensures that restarts won't happen due to
the hash table shrinking as shrinking is delayed indefinitely.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    3 ++
 include/linux/rhashtable.h       |   14 ++++++++--
 lib/rhashtable.c                 |   54 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index c08c3bcfb5ad..43de8d10638e 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -76,6 +76,7 @@ struct rhashtable_params {
  * @max_elems: Maximum number of elements in table
  * @p: Configuration parameters
  * @rhlist: True if this is an rhltable
+ * @rehash_delayers: number of walkers asking for rehash to be delayed.
  * @run_work: Deferred worker to expand/shrink asynchronously
  * @mutex: Mutex to protect current/future table swapping
  * @lock: Spin lock to protect walker list
@@ -90,6 +91,7 @@ struct rhashtable {
 	unsigned int			max_elems;
 	struct rhashtable_params	p;
 	bool				rhlist;
+	atomic_t			rehash_delayers;
 	struct work_struct		run_work;
 	struct mutex                    mutex;
 	spinlock_t			lock;
@@ -134,6 +136,7 @@ struct rhashtable_iter {
 	unsigned int skip;
 	bool p_is_unsafe;
 	bool end_of_table;
+	bool delay_rehash;
 };
 
 int rhashtable_init(struct rhashtable *ht,
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index e148f72d4a89..42b5d037ad2e 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -233,7 +233,8 @@ static inline bool __rht_grow_above_75(const struct rhashtable *ht,
 				       unsigned int nelems)
 {
 	return nelems > (tbl->size / 4 * 3) &&
-	       (!ht->p.max_size || tbl->size < ht->p.max_size);
+	       (!ht->p.max_size || tbl->size < ht->p.max_size) &&
+		atomic_read(&ht->rehash_delayers) == 0;
 }
 /**
  * rht_grow_above_75 - returns true if nelems > 0.75 * table-size
@@ -263,7 +264,8 @@ static inline bool __rht_shrink_below_30(const struct rhashtable *ht,
 {
 	/* Shrink table beneath 30% load */
 	return nelems < (tbl->size * 3 / 10) &&
-	       tbl->size > ht->p.min_size;
+	       tbl->size > ht->p.min_size &&
+	       atomic_read(&ht->rehash_delayers) == 0;
 }
 /**
  * rht_shrink_below_30 - returns true if nelems < 0.3 * table-size
@@ -285,9 +287,14 @@ static inline bool rht_shrink_below_30(const struct rhashtable *ht,
 	return __rht_shrink_below_30(ht, tbl, nelems);
 }
 
+/**
+ * rht_grow_above_100 - returns true if nelems > table-size
+ * @ht:		hash table
+ * @tbl:	current table
+ */
 static inline bool __rht_grow_above_100(const struct rhashtable *ht,
 					const struct bucket_table *tbl,
-					unsigned int nelems)
+					const unsigned int nelems)
 {
 	return nelems > tbl->size &&
 		(!ht->p.max_size || tbl->size < ht->p.max_size);
@@ -357,6 +364,7 @@ void *rhashtable_insert_slow(struct rhashtable *ht, const void *key,
 void rhashtable_walk_enter(struct rhashtable *ht,
 			   struct rhashtable_iter *iter);
 void rhashtable_walk_exit(struct rhashtable_iter *iter);
+void rhashtable_walk_delay_rehash(struct rhashtable_iter *iter);
 int rhashtable_walk_start_check(struct rhashtable_iter *iter) __acquires(RCU);
 
 static inline void rhashtable_walk_start(struct rhashtable_iter *iter)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 84288142ddf6..aa1e7be8fc5b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -436,8 +436,16 @@ static void rht_deferred_worker(struct work_struct *work)
 	tbl = rhashtable_last_table(ht, tbl);
 
 	nelems = check_nelems(ht);
+	if (atomic_read(&ht->rehash_delayers) &&
+	    tbl == ht->tbl &&
+	    !__rht_grow_above_100(ht, tbl, nelems))
+		goto out;
 
-	if (__rht_grow_above_75(ht, tbl, nelems)) {
+	/* Need to test both _75 and _100 and _75 always
+	 * says "no need to grow" if ->rehash_delayers
+	 */
+	if (__rht_grow_above_75(ht, tbl, nelems) ||
+	    __rht_grow_above_100(ht, tbl, nelems)) {
 		unsigned int size = roundup_pow_of_two(nelems * 4 / 3);
 
 		if (ht->p.max_size && size > ht->p.max_size)
@@ -453,6 +461,7 @@ static void rht_deferred_worker(struct work_struct *work)
 	if (!err)
 		err = rhashtable_rehash_table(ht);
 
+out:
 	mutex_unlock(&ht->mutex);
 
 	if (err)
@@ -711,6 +720,7 @@ void rhashtable_walk_enter(struct rhashtable *ht, struct rhashtable_iter *iter)
 	iter->slot = 0;
 	iter->skip = 0;
 	iter->end_of_table = 0;
+	iter->delay_rehash = false;
 
 	spin_lock(&ht->lock);
 	iter->walker.tbl =
@@ -732,9 +742,50 @@ void rhashtable_walk_exit(struct rhashtable_iter *iter)
 	if (iter->walker.tbl)
 		list_del(&iter->walker.list);
 	spin_unlock(&iter->ht->lock);
+	if (iter->delay_rehash &&
+	    atomic_dec_and_test(&iter->ht->rehash_delayers))
+		schedule_work(&iter->ht->run_work);
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_exit);
 
+/**
+ * rhashtable_walk_delay_rehash - ask for rehash to be delayed
+ * @iter:	Hash table Iterator
+ *
+ * If a rehash happens during a table walk, the walk can
+ * see duplicate entries and need to restart.
+ * If the walk calls this function immediately after
+ * rhashtable_walk_enter(), the chance of this happening is
+ * substantially reduced.  It waits for any
+ * current rehash to complete, then temporarily disables
+ * shinking and blocks and growth of the table until it
+ * reaches 100% occupancy, rather than the normal 70%.
+ *
+ * This function can be useful when walking a table to
+ * produce a debugfs file.  It should probably *not* be
+ * used when the file is access by an unprivileged process
+ * as that could conceivably result in a minor denial for service.
+ */
+void rhashtable_walk_delay_rehash(struct rhashtable_iter *iter)
+{
+	if (!iter->delay_rehash) {
+		struct rhashtable *ht = iter->ht;
+
+		atomic_inc(&ht->rehash_delayers);
+		iter->delay_rehash = true;
+		/* make sure any schedule rehash has finished */
+		flush_work(&ht->run_work);
+		mutex_lock(&ht->mutex);
+		/* Make double-sure there is only one table */
+		while (rhashtable_rehash_table(ht) == -EAGAIN)
+			;
+		mutex_unlock(&ht->mutex);
+		/* Need to swallow any -EAGAIN */
+		rhashtable_walk_start(iter);
+		rhashtable_walk_stop(iter);
+	}
+}
+
 /**
  * rhashtable_walk_start_check - Start a hash table walk
  * @iter:	Hash table iterator
@@ -1113,6 +1164,7 @@ int rhashtable_init(struct rhashtable *ht,
 			bucket_table_free(tbl);
 			return -ENOMEM;
 		}
+	atomic_set(&ht->rehash_delayers, 0);
 
 	RCU_INIT_POINTER(ht->tbl, tbl);
 
