Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeFAEqc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34165 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751678AbeFAEq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:26 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 13/18] rhashtable: don't hold lock on first table throughout
 insertion.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824977.30340.18178969534076298760.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_try_insert() currently hold a lock on the bucket in
the first table, while also locking buckets in subsequent tables.
This is unnecessary and looks like a hold-over from some earlier
version of the implementation.

As insert and remove always lock a bucket in each table in turn, and
as insert only inserts in the final table, there cannot be any races
that are not covered by simply locking a bucket in each table in turn.

When an insert call reaches that last table it can be sure that there
is no match entry in any other table as it has searched them all, and
insertion never happens anywhere but in the last table.  The fact that
code tests for the existence of future_tbl while holding a lock on
the relevant bucket ensures that two threads inserting the same key
will make compatible decisions about which is the "last" table.

This simplifies the code and allows the ->rehash field to be
discarded.

We still need a way to ensure that a dead bucket_table is never
re-linked by rhashtable_walk_stop().  This can be achieved by
calling call_rcu() inside the locked region, and checking
->rcu.func in rhashtable_walk_stop().  If it is not NULL, then
the bucket table is empty and dead.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   13 -------------
 lib/rhashtable.c           |   44 +++++++++++---------------------------------
 2 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 1b70d690ab65..5f0511bd5a39 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -63,7 +63,6 @@
 struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
-	unsigned int		rehash;
 	u32			hash_rnd;
 	unsigned int		locks_mask;
 	spinlock_t		*locks;
@@ -774,12 +773,6 @@ static inline int rhltable_insert(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Locks down the bucket chain in both the old and new table if a resize
- * is in progress to ensure that writers can't remove from the old table
- * and can't insert to the new table during the atomic operation of search
- * and insertion. Searches for duplicates in both the old and new table if
- * a resize is in progress.
- *
  * This lookup function may only be used for fixed key hash table (key_len
  * parameter set). It will BUG() if used inappropriately.
  *
@@ -835,12 +828,6 @@ static inline void *rhashtable_lookup_get_insert_fast(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Locks down the bucket chain in both the old and new table if a resize
- * is in progress to ensure that writers can't remove from the old table
- * and can't insert to the new table during the atomic operation of search
- * and insertion. Searches for duplicates in both the old and new table if
- * a resize is in progress.
- *
  * Lookups may occur in parallel with hashtable mutations and resizing.
  *
  * Will trigger an automatic deferred table resizing if residency in the
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index a185f5a8b34d..919eebd6757d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -289,10 +289,9 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 	while (!(err = rhashtable_rehash_one(ht, old_hash)))
 		;
 
-	if (err == -ENOENT) {
-		old_tbl->rehash++;
+	if (err == -ENOENT)
 		err = 0;
-	}
+
 	spin_unlock_bh(old_bucket_lock);
 
 	return err;
@@ -339,13 +338,16 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 	spin_lock(&ht->lock);
 	list_for_each_entry(walker, &old_tbl->walkers, list)
 		walker->tbl = NULL;
-	spin_unlock(&ht->lock);
 
 	/* Wait for readers. All new readers will see the new
 	 * table, and thus no references to the old table will
 	 * remain.
+	 * We do this inside the locked region so that
+	 * rhashtable_walk_stop() can check ->rcu.func and know
+	 * not to re-link the table.
 	 */
 	call_rcu(&old_tbl->rcu, bucket_table_free_rcu);
+	spin_unlock(&ht->lock);
 
 	return rht_dereference(new_tbl->future_tbl, ht) ? -EAGAIN : 0;
 }
@@ -591,36 +593,14 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
 	unsigned int hash;
-	spinlock_t *lock;
 	void *data;
 
-	tbl = rcu_dereference(ht->tbl);
-
-	/* All insertions must grab the oldest table containing
-	 * the hashed bucket that is yet to be rehashed.
-	 */
-	for (;;) {
-		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		lock = rht_bucket_lock(tbl, hash);
-		spin_lock_bh(lock);
-
-		if (tbl->rehash <= hash)
-			break;
-
-		spin_unlock_bh(lock);
-		tbl = rht_dereference_rcu(tbl->future_tbl, ht);
-	}
+	new_tbl = rcu_dereference(ht->tbl);
 
-	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
-	new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
-	if (PTR_ERR(new_tbl) != -EEXIST)
-		data = ERR_CAST(new_tbl);
-
-	while (!IS_ERR_OR_NULL(new_tbl)) {
+	do {
 		tbl = new_tbl;
 		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		spin_lock_nested(rht_bucket_lock(tbl, hash),
-				 SINGLE_DEPTH_NESTING);
+		spin_lock(rht_bucket_lock(tbl, hash));
 
 		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
 		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
@@ -628,9 +608,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			data = ERR_CAST(new_tbl);
 
 		spin_unlock(rht_bucket_lock(tbl, hash));
-	}
-
-	spin_unlock_bh(lock);
+	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
 		data = ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
@@ -965,7 +943,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
 	ht = iter->ht;
 
 	spin_lock(&ht->lock);
-	if (tbl->rehash < tbl->size)
+	if (tbl->rcu.func == NULL)
 		list_add(&iter->walker.list, &tbl->walkers);
 	else
 		iter->walker.tbl = NULL;
