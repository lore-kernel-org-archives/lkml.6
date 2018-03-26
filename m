Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbeC0Bvs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 21:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752469AbeC0Bvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 21:51:46 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 27 Mar 2018 10:33:04 +1100
Subject: [PATCH 5/6] rhashtable: support guaranteed successful insertion.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152210718434.11435.6551477417902631683.stgit@noble>
In-Reply-To: <152210688405.11435.13010923693146415942.stgit@noble>
References: <152210688405.11435.13010923693146415942.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rhashtable will fail an insertion if the hashtable
it "too full", one of:
 - table already has 2^31 elements (-E2BIG)
 - a max_size was specified and table already has that
   many elements (rounded up to power of 2) (-E2BIG)
 - a single chain has more than 16 elements (-EBUSY)
 - table has more elements than the current table size,
   and allocating a new table fails (-ENOMEM)
 - a new page needed to be allocated for a nested table,
   and the memory allocation failed (-ENOMEM).

A traditional hash table does not have a concept of "too full", and
insertion only fails if the key already exists.  Many users of hash
tables have separate means of limiting the total number of entries,
and are not susceptible to an attack which could cause unusually large
hash chains.  For those users, the need to check for errors when
inserting objects to an rhashtable is an unnecessary burden and hence
a potential source of bugs (as these failures are likely to be rare).

This patch adds a "never_fail_insert" configuration parameter which
ensures that insertion will only fail if the key already exists.

When this option is in effect:
 - nelems is capped at INT_MAX and will never decrease once it reaches
   that value
 - max_size is largely ignored
 - elements will be added to a table that is nominally "full", though
   a rehash will be scheduled
 - a new table will never be allocated directly by the insert
   function, that is always left for the worker.
   For this to trigger a rehash when long chains are detected (possibly
   still useful) an extra field in the table records if a long chain
   has been seen.  This shares a word with the 'nest' value.  As
   'nest' is never changed once the table is created, updating the
   new ->long_chain without locking cannot cause any corruption.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   18 +++++++++++++++---
 lib/rhashtable.c           |   27 +++++++++++++++++++--------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 4ffd96949d4f..abdeb1f3f378 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -77,6 +77,7 @@ struct rhlist_head {
  * struct bucket_table - Table of hash buckets
  * @size: Number of hash buckets
  * @nest: Number of bits of first-level nested table.
+ * @long_chain: %true when a chain longer than RHT_ELASTICITY seen.
  * @rehash: Current bucket being rehashed
  * @hash_rnd: Random seed to fold into hash
  * @locks_mask: Mask to apply before accessing locks[]
@@ -89,7 +90,8 @@ struct rhlist_head {
  */
 struct bucket_table {
 	unsigned int		size;
-	unsigned int		nest;
+	unsigned short		nest;
+	bool			long_chain;
 	unsigned int		rehash;
 	u32			hash_rnd;
 	unsigned int		locks_mask;
@@ -129,6 +131,9 @@ struct rhashtable;
  * @min_size: Minimum size while shrinking
  * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
  * @automatic_shrinking: Enable automatic shrinking of tables
+ * @never_fail_insert: Insert will always succeed, even if table will become
+ *           unbalanced.  Without this, -E2BIG, -EBUSY, and -ENOMEM are possible
+ *           errors from rhashtable_*insert*()
  * @nulls_base: Base value to generate nulls marker
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
@@ -142,6 +147,7 @@ struct rhashtable_params {
 	unsigned int		max_size;
 	u16			min_size;
 	bool			automatic_shrinking;
+	bool			never_fail_insert;
 	u8			locks_mul;
 	u32			nulls_base;
 	rht_hashfn_t		hashfn;
@@ -832,7 +838,10 @@ static inline void *__rhashtable_insert_fast(
 
 	rcu_assign_pointer(*pprev, obj);
 
-	atomic_inc(&ht->nelems);
+	if (params.never_fail_insert)
+		atomic_add_unless(&ht->nelems, 1, INT_MAX);
+	else
+		atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
 
@@ -1104,7 +1113,10 @@ static inline int __rhashtable_remove_fast_one(
 	spin_unlock_bh(lock);
 
 	if (err > 0) {
-		atomic_dec(&ht->nelems);
+		if (params.never_fail_insert)
+			atomic_add_unless(&ht->nelems, -1, INT_MAX);
+		else
+			atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
 			     rht_shrink_below_30(ht, tbl)))
 			schedule_work(&ht->run_work);
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index fd6f320b9704..427836aace60 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -424,7 +424,7 @@ static void rht_deferred_worker(struct work_struct *work)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size * 2);
 	else if (ht->p.automatic_shrinking && rht_shrink_below_30(ht, tbl))
 		err = rhashtable_shrink(ht);
-	else if (tbl->nest)
+	else if (tbl->nest || tbl->long_chain)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size);
 
 	if (!err)
@@ -549,14 +549,22 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (new_tbl)
 		return new_tbl;
 
-	if (PTR_ERR(data) != -ENOENT)
-		return ERR_CAST(data);
+	if (ht->p.never_fail_insert) {
+		if (PTR_ERR(data) == -EAGAIN &&
+		    atomic_read(&ht->nelems) != INT_MAX) {
+			tbl->long_chain = true;
+			schedule_work(&ht->run_work);
+		}
+	} else {
+		if (PTR_ERR(data) != -ENOENT)
+			return ERR_CAST(data);
 
-	if (unlikely(rht_grow_above_max(ht, tbl)))
-		return ERR_PTR(-E2BIG);
+		if (unlikely(rht_grow_above_max(ht, tbl)))
+			return ERR_PTR(-E2BIG);
 
-	if (unlikely(rht_grow_above_100(ht, tbl)))
-		return ERR_PTR(-EAGAIN);
+		if (unlikely(rht_grow_above_100(ht, tbl)))
+			return ERR_PTR(-EAGAIN);
+	}
 
 	pprev = rht_bucket_insert(ht, tbl, hash);
 	if (!pprev)
@@ -574,7 +582,10 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 
 	rcu_assign_pointer(*pprev, obj);
 
-	atomic_inc(&ht->nelems);
+	if (ht->p.never_fail_insert)
+		atomic_add_unless(&ht->nelems, 1, INT_MAX);
+	else
+		atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
 		schedule_work(&ht->run_work);
 
