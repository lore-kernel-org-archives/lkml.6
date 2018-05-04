Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEDDze (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:55:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbeEDDza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:55:30 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 04 May 2018 13:54:14 +1000
Subject: [PATCH 8/8] rhashtable: don't hold lock on first table throughout
 insertion.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152540605444.18473.9591316658457316578.stgit@noble>
In-Reply-To: <152540595840.18473.11298241115621799037.stgit@noble>
References: <152540595840.18473.11298241115621799037.stgit@noble>
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
setting the ->size to 1.  This still allows lookup code to work (and
correctly not find anything) but can never happen on an active bucket
table (as the minimum size is 4).

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   13 -------------
 lib/rhashtable.c           |   42 ++++++++++--------------------------------
 2 files changed, 10 insertions(+), 45 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 82d061ff96d6..0529925af41d 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -73,7 +73,6 @@ struct rhlist_head {
 struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
-	unsigned int		rehash;
 	u32			hash_rnd;
 	unsigned int		locks_mask;
 	spinlock_t		*locks;
@@ -885,12 +884,6 @@ static inline int rhltable_insert(
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
@@ -946,12 +939,6 @@ static inline void *rhashtable_lookup_get_insert_fast(
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
index d0267e37e7e1..4f7a7423a675 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -293,10 +293,9 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
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
@@ -345,6 +344,9 @@ static int rhashtable_rehash_table(struct rhashtable *ht)
 	spin_lock(&ht->lock);
 	list_for_each_entry(walker, &old_tbl->walkers, list)
 		walker->tbl = NULL;
+
+	/* Ensure rhashtable_walk_stop() doesn't relink this table */
+	old_tbl->size = 1;
 	spin_unlock(&ht->lock);
 
 	/* Wait for readers. All new readers will see the new
@@ -597,36 +599,14 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
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
-		tbl = rcu_dereference(tbl->future_tbl);
-	}
-
-	data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
-	new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
-	if (PTR_ERR(new_tbl) != -EEXIST)
-		data = ERR_CAST(new_tbl);
+	new_tbl = rcu_dereference(ht->tbl);
 
-	while (!IS_ERR_OR_NULL(new_tbl)) {
+	do {
 		tbl = new_tbl;
 		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		spin_lock_nested(rht_bucket_lock(tbl, hash),
-				 SINGLE_DEPTH_NESTING);
+		spin_lock(rht_bucket_lock(tbl, hash));
 
 		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
 		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
@@ -634,9 +614,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			data = ERR_CAST(new_tbl);
 
 		spin_unlock(rht_bucket_lock(tbl, hash));
-	}
-
-	spin_unlock_bh(lock);
+	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
 		data = ERR_PTR(rhashtable_insert_rehash(ht, tbl) ?:
@@ -971,7 +949,7 @@ void rhashtable_walk_stop(struct rhashtable_iter *iter)
 	ht = iter->ht;
 
 	spin_lock(&ht->lock);
-	if (tbl->rehash < tbl->size)
+	if (tbl->size > 1)
 		list_add(&iter->walker.list, &tbl->walkers);
 	else
 		iter->walker.tbl = NULL;
