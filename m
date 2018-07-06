Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5062C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634E620693
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634E620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeGFHXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:23:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754298AbeGFHXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:23:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA4F9AFCC;
        Fri,  6 Jul 2018 07:23:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 06 Jul 2018 17:22:30 +1000
Subject: [PATCH 4/5] rhashtable: use bit_spin_locks to protect hash bucket.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086175015.24852.9251625654345111968.stgit@noble>
In-Reply-To: <153086169828.24852.10332573315056854948.stgit@noble>
References: <153086169828.24852.10332573315056854948.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes rhashtables to use a bit_spin_lock (BIT(1))
the bucket pointer to lock the hash chain for that bucket.

The benefits of a bit spin_lock are:
 - no need to allocate a separate array of locks.
 - no need to have a configuration option to guide the
   choice of the size of this array
 - locking cost if often a single test-and-set in a cache line
   that will have to be loaded anyway.  When inserting at, or removing
   from, the head of the chain, the unlock is free - writing the new
   address in the bucket head implicitly clears the lock bit.
 - even when lockings costs 2 updates (lock and unlock), they are
   in a cacheline that needs to be read anyway.

The cost of using a bit spin_lock is a little bit of code complexity,
which I think is quite manageable.

Bit spin_locks are sometimes inappropriate because they are not fair -
if multiple CPUs repeatedly contend of the same lock, one CPU can
easily be starved.  This is not a credible situation with rhashtable.
Multiple CPUs may want to repeatedly add or remove objects, but they
will typically do so at different buckets, so they will attempt to
acquire different locks.

As we have more bit-locks than we previously had spinlocks (by at
least a factor of two) we can expect slightly less contention to
go with the slightly better cache behavior and reduced memory
consumption.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable-types.h |    2 
 include/linux/rhashtable.h       |  190 +++++++++++++++++++++++++-------------
 ipc/util.c                       |    1 
 lib/rhashtable.c                 |  118 ++++++++++++------------
 net/bridge/br_fdb.c              |    1 
 net/bridge/br_vlan.c             |    1 
 net/bridge/br_vlan_tunnel.c      |    1 
 net/ipv4/ipmr.c                  |    1 
 net/ipv6/ip6mr.c                 |    1 
 net/netfilter/nf_tables_api.c    |    1 
 10 files changed, 184 insertions(+), 133 deletions(-)

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-types.h
index bc3e84547ba7..39e5e1fb9b65 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -48,7 +48,6 @@ typedef int (*rht_obj_cmpfn_t)(struct rhashtable_compare_arg *arg,
  * @head_offset: Offset of rhash_head in struct to be hashed
  * @max_size: Maximum size while expanding
  * @min_size: Minimum size while shrinking
- * @locks_mul: Number of bucket locks to allocate per cpu (default: 32)
  * @automatic_shrinking: Enable automatic shrinking of tables
  * @hashfn: Hash function (default: jhash2 if !(key_len % 4), or jhash)
  * @obj_hashfn: Function to hash object
@@ -62,7 +61,6 @@ struct rhashtable_params {
 	unsigned int		max_size;
 	u16			min_size;
 	bool			automatic_shrinking;
-	u8			locks_mul;
 	rht_hashfn_t		hashfn;
 	rht_obj_hashfn_t	obj_hashfn;
 	rht_obj_cmpfn_t		obj_cmpfn;
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index a4ff6ae524a0..b683dc336be1 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -24,6 +24,7 @@
 #include <linux/list_nulls.h>
 #include <linux/workqueue.h>
 #include <linux/rculist.h>
+#include <linux/bit_spinlock.h>
 
 #include <linux/rhashtable-types.h>
 /*
@@ -52,8 +53,6 @@
  * @nest: Number of bits of first-level nested table.
  * @rehash: Current bucket being rehashed
  * @hash_rnd: Random seed to fold into hash
- * @locks_mask: Mask to apply before accessing locks[]
- * @locks: Array of spinlocks protecting individual buckets
  * @walkers: List of active walkers
  * @rcu: RCU structure for freeing the table
  * @future_tbl: Table under construction during rehashing
@@ -64,8 +63,6 @@ struct bucket_table {
 	unsigned int		size;
 	unsigned int		nest;
 	u32			hash_rnd;
-	unsigned int		locks_mask;
-	spinlock_t		*locks;
 	struct list_head	walkers;
 	struct rcu_head		rcu;
 
@@ -74,6 +71,61 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
+/*
+ * We lock a bucket by setting BIT(1) in the pointer - this is always
+ * zero in real pointers and in the nulls marker.
+ * bit_spin_locks do not handle contention well, but the whole point
+ * of the hashtable design is to achieve minimum per-bucket contention.
+ * A nested hash table might not have a bucket pointer.  In that case
+ * we cannot get a lock.  For remove and replace the bucket cannot be
+ * interesting and doesn't need locking.
+ * For insert we allocate the bucket if this is the last bucket_table,
+ * and then take the lock.
+ * Sometimes we unlock a bucket by writing a new pointer there.  In that
+ * case we don't need to unlock, but we do need to reset state such as
+ * local_bh. For that we have rht_unlocked().  This doesn't include
+ * the memory barrier that bit_spin_unlock() provides, but rcu_assign_pointer()
+ * will have provided that.
+ */
+
+static inline void rht_lock(struct rhash_head **bucket)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+}
+
+static inline void rht_unlock(struct rhash_head **bucket)
+{
+	bit_spin_unlock(1, (unsigned long *)bucket);
+	local_bh_enable();
+}
+
+static inline void rht_unlocked(void)
+{
+	preempt_enable();
+	__release(bitlock);
+	local_bh_enable();
+}
+
+/*
+ * If 'p' is a bucket head and might be locked, rht_ptr returns
+ * the address without the lock bit.
+ */
+static inline struct rhash_head __rcu *rht_ptr(const struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) & ~2UL);
+}
+
+static inline struct rhash_head __rcu *rht_ptr_locked(const struct rhash_head *p)
+{
+	return (void *)(((unsigned long)p) | 2UL);
+}
+
+static inline bool rht_is_locked(const struct rhash_head *p)
+{
+	return rht_ptr_locked(p) == p;
+}
+
 #define	RHT_NULLS_MARKER(ptr)	\
 	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
 #define INIT_RHT_NULLS_HEAD(ptr)	\
@@ -197,25 +249,6 @@ static inline bool rht_grow_above_max(const struct rhashtable *ht,
 	return atomic_read(&ht->nelems) >= ht->max_elems;
 }
 
-/* The bucket lock is selected based on the hash and protects mutations
- * on a group of hash buckets.
- *
- * A maximum of tbl->size/2 bucket locks is allocated. This ensures that
- * a single lock always covers both buckets which may both contains
- * entries which link to the same bucket of the old table during resizing.
- * This allows to simplify the locking as locking the bucket in both
- * tables during resize always guarantee protection.
- *
- * IMPORTANT: When holding the bucket lock of both the old and new table
- * during expansions and shrinking, the old bucket lock must always be
- * acquired first.
- */
-static inline spinlock_t *rht_bucket_lock(const struct bucket_table *tbl,
-					  unsigned int hash)
-{
-	return &tbl->locks[hash & tbl->locks_mask];
-}
-
 #ifdef CONFIG_PROVE_LOCKING
 int lockdep_rht_mutex_is_held(struct rhashtable *ht);
 int lockdep_rht_bucket_is_held(const struct bucket_table *tbl, u32 hash);
@@ -345,7 +378,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @hash:	the hash value / bucket index
  */
 #define rht_for_each(pos, tbl, hash) \
-	rht_for_each_continue(pos, *rht_bucket(tbl, hash), tbl, hash)
+	rht_for_each_continue(pos, rht_ptr(*rht_bucket(tbl, hash)), tbl, hash)
 
 /**
  * rht_for_each_entry_continue - continue iterating over hash chain
@@ -370,7 +403,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * @member:	name of the &struct rhash_head within the hashable struct.
  */
 #define rht_for_each_entry(tpos, pos, tbl, hash, member)		\
-	rht_for_each_entry_continue(tpos, pos, *rht_bucket(tbl, hash),	\
+	rht_for_each_entry_continue(tpos, pos, rht_ptr(*rht_bucket(tbl, hash)), \
 				    tbl, hash, member)
 
 /**
@@ -386,7 +419,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * remove the loop cursor from the list.
  */
 #define rht_for_each_entry_safe(tpos, pos, next, tbl, hash, member)	      \
-	for (pos = rht_dereference_bucket(*rht_bucket(tbl, hash), tbl, hash), \
+	for (pos = rht_dereference_bucket(rht_ptr(*rht_bucket(tbl, hash)),    \
+					  tbl, hash),			      \
 	     next = !rht_is_a_nulls(pos) ?				      \
 		       rht_dereference_bucket(pos->next, tbl, hash) : NULL;   \
 	     (!rht_is_a_nulls(pos)) && rht_entry(tpos, pos, member);	      \
@@ -407,7 +441,7 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  */
 #define rht_for_each_rcu_continue(pos, head, tbl, hash)			\
 	for (({barrier(); }),						\
-	     pos = rht_dereference_bucket_rcu(head, tbl, hash);		\
+		pos = rht_ptr(rht_dereference_bucket_rcu(head, tbl, hash)); \
 	     !rht_is_a_nulls(pos);					\
 	     pos = rcu_dereference_raw(pos->next))
 
@@ -422,7 +456,11 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_rcu(pos, tbl, hash)				\
-	rht_for_each_rcu_continue(pos, *rht_bucket(tbl, hash), tbl, hash)
+	for (({barrier(); }),						\
+	     pos = rht_ptr(rht_dereference_bucket_rcu(*rht_bucket(tbl, hash), \
+						      tbl, hash));	\
+	     !rht_is_a_nulls(pos);					\
+	     pos = rcu_dereference_raw(pos->next))
 
 /**
  * rht_for_each_entry_rcu_continue - continue iterating over rcu hash chain
@@ -456,7 +494,8 @@ static inline struct rhash_head __rcu **rht_bucket_insert(
  * traversal is guarded by rcu_read_lock().
  */
 #define rht_for_each_entry_rcu(tpos, pos, tbl, hash, member)		   \
-	rht_for_each_entry_rcu_continue(tpos, pos, *rht_bucket(tbl, hash), \
+	rht_for_each_entry_rcu_continue(tpos, pos,			   \
+					rht_ptr(*rht_bucket(tbl, hash)),   \
 					tbl, hash, member)
 
 /**
@@ -620,9 +659,9 @@ static inline void *__rhashtable_insert_fast(
 	};
 	struct rhash_head __rcu **headp;
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
-	spinlock_t *lock;
 	unsigned int hash;
 	int elasticity;
 	void *data;
@@ -631,24 +670,23 @@ static inline void *__rhashtable_insert_fast(
 
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
-	spin_lock_bh(lock);
+	elasticity = RHT_ELASTICITY;
+	headp = rht_bucket_insert(ht, tbl, hash);
+	data = ERR_PTR(-ENOMEM);
+	if (!headp)
+		goto out;
+	lock = pprev = headp;
+	rht_lock(lock);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		spin_unlock_bh(lock);
+		rht_unlock(lock);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
 
-	elasticity = RHT_ELASTICITY;
-	headp = rht_bucket_insert(ht, tbl, hash);
-	pprev = headp;
-	data = ERR_PTR(-ENOMEM);
-	if (!pprev)
-		goto out;
 
-	rht_for_each_continue(head, *headp, tbl, hash) {
+	rht_for_each_continue(head, rht_ptr(*headp), tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -679,6 +717,8 @@ static inline void *__rhashtable_insert_fast(
 		head = rht_dereference_bucket(head->next, tbl, hash);
 		RCU_INIT_POINTER(list->rhead.next, head);
 		rcu_assign_pointer(*pprev, obj);
+		/* This is where we inserted */
+		headp = pprev;
 
 		goto good;
 	}
@@ -695,7 +735,7 @@ static inline void *__rhashtable_insert_fast(
 
 	head = rht_dereference_bucket(*headp, tbl, hash);
 
-	RCU_INIT_POINTER(obj->next, head);
+	RCU_INIT_POINTER(obj->next, rht_ptr(head));
 	if (rhlist) {
 		struct rhlist_head *list;
 
@@ -712,8 +752,15 @@ static inline void *__rhashtable_insert_fast(
 good:
 	data = NULL;
 
+	if (headp == lock) {
+		/* Assigning to *headp unlocked the chain, so we
+		 * don't need to do it again.
+		 */
+		rht_unlocked();
+	} else {
 out:
-	spin_unlock_bh(lock);
+		rht_unlock(lock);
+	}
 	rcu_read_unlock();
 
 	return data;
@@ -725,9 +772,9 @@ static inline void *__rhashtable_insert_fast(
  * @obj:	pointer to hash head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -754,9 +801,9 @@ static inline int rhashtable_insert_fast(
  * @list:	pointer to hash list head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -777,9 +824,9 @@ static inline int rhltable_insert_key(
  * @list:	pointer to hash list head inside object
  * @params:	hash table parameters
  *
- * Will take a per bucket spinlock to protect against mutual mutations
+ * Will take the per bucket bitlock to protect against mutual mutations
  * on the same bucket. Multiple insertions may occur in parallel unless
- * they map to the same bucket lock.
+ * they map to the same bucket.
  *
  * It is safe to call this function from atomic context.
  *
@@ -907,20 +954,19 @@ static inline int __rhashtable_remove_fast_one(
 	bool rhlist)
 {
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct rhash_head *he;
-	spinlock_t * lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
 	hash = rht_head_hashfn(ht, tbl, obj, params);
-	lock = rht_bucket_lock(tbl, hash);
-
-	spin_lock_bh(lock);
-
 	pprev = rht_bucket_var(tbl, hash);
 	if (!pprev)
-		goto out;
-	rht_for_each_continue(he, *pprev, tbl, hash) {
+		return -ENOENT;
+	lock = pprev;
+	rht_lock(lock);
+
+	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 
 		list = container_of(he, struct rhlist_head, rhead);
@@ -961,12 +1007,16 @@ static inline int __rhashtable_remove_fast_one(
 		}
 
 		rcu_assign_pointer(*pprev, obj);
+		if (lock == pprev) {
+			/* That rcu_assign_pointer() unlocked the chain */
+			rht_unlocked();
+			goto unlocked;
+		}
 		break;
 	}
 
-out:
-	spin_unlock_bh(lock);
-
+	rht_unlock(lock);
+unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
 		if (unlikely(ht->p.automatic_shrinking &&
@@ -1056,8 +1106,8 @@ static inline int __rhashtable_replace_fast(
 	const struct rhashtable_params params)
 {
 	struct rhash_head __rcu **pprev;
+	struct rhash_head __rcu **lock;
 	struct rhash_head *he;
-	spinlock_t *lock;
 	unsigned int hash;
 	int err = -ENOENT;
 
@@ -1068,14 +1118,14 @@ static inline int __rhashtable_replace_fast(
 	if (hash != rht_head_hashfn(ht, tbl, obj_new, params))
 		return -EINVAL;
 
-	lock = rht_bucket_lock(tbl, hash);
-
-	spin_lock_bh(lock);
-
 	pprev = rht_bucket_var(tbl, hash);
 	if (!pprev)
-		goto out;
-	rht_for_each_continue(he, *pprev, tbl, hash) {
+		return -ENOENT;
+
+	lock = pprev;
+	rht_lock(lock);
+
+	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
 			continue;
@@ -1084,11 +1134,17 @@ static inline int __rhashtable_replace_fast(
 		rcu_assign_pointer(obj_new->next, obj_old->next);
 		rcu_assign_pointer(*pprev, obj_new);
 		err = 0;
+		if (pprev == lock) {
+			/* We just unlocked the chain by assigning to *pprev */
+			rht_unlocked();
+			goto unlocked;
+		}
 		break;
 	}
-out:
-	spin_unlock_bh(lock);
 
+	rht_unlock(lock);
+
+unlocked:
 	return err;
 }
 
diff --git a/ipc/util.c b/ipc/util.c
index fdffff41f65b..cc78eb76df8b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -105,7 +105,6 @@ static const struct rhashtable_params ipc_kht_params = {
 	.head_offset		= offsetof(struct kern_ipc_perm, khtnode),
 	.key_offset		= offsetof(struct kern_ipc_perm, key),
 	.key_len		= FIELD_SIZEOF(struct kern_ipc_perm, key),
-	.locks_mul		= 1,
 	.automatic_shrinking	= true,
 };
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 7a68c1f0b6d0..9b0ca9e1f6b5 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -32,7 +32,6 @@
 
 #define HASH_DEFAULT_SIZE	64UL
 #define HASH_MIN_SIZE		4U
-#define BUCKET_LOCKS_PER_CPU	32UL
 
 union nested_table {
 	union nested_table __rcu *table;
@@ -57,9 +56,11 @@ EXPORT_SYMBOL_GPL(lockdep_rht_mutex_is_held);
 
 int lockdep_rht_bucket_is_held(const struct bucket_table *tbl, u32 hash)
 {
-	spinlock_t *lock = rht_bucket_lock(tbl, hash);
-
-	return (debug_locks) ? lockdep_is_held(lock) : 1;
+	if (!debug_locks)
+		return 1;
+	if (unlikely(tbl->nest))
+		return 1;
+	return bit_spin_is_locked(1, (unsigned long *)&tbl->buckets[hash]);
 }
 EXPORT_SYMBOL_GPL(lockdep_rht_bucket_is_held);
 #else
@@ -105,7 +106,6 @@ static void bucket_table_free(const struct bucket_table *tbl)
 	if (tbl->nest)
 		nested_bucket_table_free(tbl);
 
-	free_bucket_spinlocks(tbl->locks);
 	kvfree(tbl);
 }
 
@@ -172,7 +172,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 					       gfp_t gfp)
 {
 	struct bucket_table *tbl = NULL;
-	size_t size, max_locks;
+	size_t size;
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
@@ -192,16 +192,6 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	tbl->size = size;
 
-	max_locks = size >> 1;
-	if (tbl->nest)
-		max_locks = min_t(size_t, max_locks, 1U << tbl->nest);
-
-	if (alloc_bucket_spinlocks(&tbl->locks, &tbl->locks_mask, max_locks,
-				   ht->p.locks_mul, gfp) < 0) {
-		bucket_table_free(tbl);
-		return NULL;
-	}
-
 	INIT_LIST_HEAD(&tbl->walkers);
 
 	tbl->hash_rnd = get_random_u32();
@@ -225,25 +215,24 @@ static struct bucket_table *rhashtable_last_table(struct rhashtable *ht,
 	return new_tbl;
 }
 
-static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
+static int rhashtable_rehash_one(struct rhashtable *ht,
+				 struct rhash_head __rcu **pprev,
+				 unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
 	struct bucket_table *new_tbl = rhashtable_last_table(ht, old_tbl);
-	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	struct rhash_head __rcu **inspos;
+	struct rhash_head __rcu **lock;
 	int err = -EAGAIN;
 	struct rhash_head *head, *next, *entry;
-	spinlock_t *new_bucket_lock;
 	unsigned int new_hash;
 
 	if (new_tbl->nest)
 		goto out;
 
 	err = -ENOENT;
-	if (!pprev)
-		goto out;
 
-	rht_for_each_continue(entry, *pprev, old_tbl, old_hash) {
+	rht_for_each_continue(entry, rht_ptr(*pprev), old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -258,11 +247,11 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 
 	new_hash = head_hashfn(ht, new_tbl, entry);
 
-	new_bucket_lock = rht_bucket_lock(new_tbl, new_hash);
-
-	spin_lock_nested(new_bucket_lock, SINGLE_DEPTH_NESTING);
 	inspos = &new_tbl->buckets[new_hash];
-	head = rht_dereference_bucket(*inspos, new_tbl, new_hash);
+	lock = inspos;
+	rht_lock(lock);
+
+	head = rht_ptr(rht_dereference_bucket(*inspos, new_tbl, new_hash));
 	while (!rht_is_a_nulls(head) && head < entry) {
 		inspos = &head->next;
 		head = rht_dereference_bucket(*inspos, new_tbl, new_hash);
@@ -270,7 +259,14 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 	RCU_INIT_POINTER(entry->next, head);
 
 	rcu_assign_pointer(*inspos, entry);
-	spin_unlock(new_bucket_lock);
+	if (inspos != lock)
+		rht_unlock(lock);
+	else
+		rht_unlocked();
+
+	/* Need to preserved the bit lock. */
+	if (rht_is_locked(*pprev))
+		next = rht_ptr_locked(next);
 
 	rcu_assign_pointer(*pprev, next);
 
@@ -282,19 +278,19 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 				    unsigned int old_hash)
 {
 	struct bucket_table *old_tbl = rht_dereference(ht->tbl, ht);
-	spinlock_t *old_bucket_lock;
+	struct rhash_head __rcu **pprev = rht_bucket_var(old_tbl, old_hash);
 	int err;
 
-	old_bucket_lock = rht_bucket_lock(old_tbl, old_hash);
+	if (!pprev)
+		return 0;
+	rht_lock(pprev);
 
-	spin_lock_bh(old_bucket_lock);
-	while (!(err = rhashtable_rehash_one(ht, old_hash)))
+	while (!(err = rhashtable_rehash_one(ht, pprev, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-
-	spin_unlock_bh(old_bucket_lock);
+	rht_unlock(pprev);
 
 	return err;
 }
@@ -487,6 +483,7 @@ static int rhashtable_insert_rehash(struct rhashtable *ht,
 }
 
 static void *rhashtable_lookup_one(struct rhashtable *ht,
+				   struct rhash_head __rcu **pprev,
 				   struct bucket_table *tbl, unsigned int hash,
 				   const void *key, struct rhash_head *obj)
 {
@@ -494,15 +491,12 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		.ht = ht,
 		.key = key,
 	};
-	struct rhash_head __rcu **pprev;
+	struct rhash_head **lock = pprev;
 	struct rhash_head *head;
 	int elasticity;
 
 	elasticity = RHT_ELASTICITY;
-	pprev = rht_bucket_var(tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOENT);
-	rht_for_each_continue(head, *pprev, tbl, hash) {
+	rht_for_each_continue(head, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
 
@@ -524,6 +518,9 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, plist);
 		head = rht_dereference_bucket(head->next, tbl, hash);
 		RCU_INIT_POINTER(list->rhead.next, head);
+		if (pprev == lock)
+			/* Need to preserve the bit lock */
+			obj = rht_ptr_locked(obj);
 		rcu_assign_pointer(*pprev, obj);
 
 		return NULL;
@@ -536,12 +533,13 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 }
 
 static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
+						  struct rhash_head __rcu **pprev,
 						  struct bucket_table *tbl,
 						  unsigned int hash,
 						  struct rhash_head *obj,
 						  void *data)
 {
-	struct rhash_head __rcu **pprev;
+	struct rhash_head **lock = pprev;
 	struct bucket_table *new_tbl;
 	struct rhash_head *head;
 
@@ -564,11 +562,7 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		return ERR_PTR(-EAGAIN);
 
-	pprev = rht_bucket_insert(ht, tbl, hash);
-	if (!pprev)
-		return ERR_PTR(-ENOMEM);
-
-	head = rht_dereference_bucket(*pprev, tbl, hash);
+	head = rht_ptr(rht_dereference_bucket(*pprev, tbl, hash));
 	while (!ht->rhlist && !rht_is_a_nulls(head) && head < obj) {
 		pprev = &head->next;
 		head = rht_dereference_bucket(*pprev, tbl, hash);
@@ -582,6 +576,9 @@ static struct bucket_table *rhashtable_insert_one(struct rhashtable *ht,
 		RCU_INIT_POINTER(list->next, NULL);
 	}
 
+	if (pprev == lock)
+		/* Need to preserve the bit lock */
+		obj = (void *)(2UL | (unsigned long)obj);
 	rcu_assign_pointer(*pprev, obj);
 
 	atomic_inc(&ht->nelems);
@@ -596,6 +593,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 {
 	struct bucket_table *new_tbl;
 	struct bucket_table *tbl;
+	struct rhash_head __rcu **pprev;
 	unsigned int hash;
 	void *data;
 
@@ -604,14 +602,25 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 	do {
 		tbl = new_tbl;
 		hash = rht_head_hashfn(ht, tbl, obj, ht->p);
-		spin_lock(rht_bucket_lock(tbl, hash));
-
-		data = rhashtable_lookup_one(ht, tbl, hash, key, obj);
-		new_tbl = rhashtable_insert_one(ht, tbl, hash, obj, data);
-		if (PTR_ERR(new_tbl) != -EEXIST)
-			data = ERR_CAST(new_tbl);
-
-		spin_unlock(rht_bucket_lock(tbl, hash));
+		if (rcu_access_pointer(tbl->future_tbl))
+			/* Failure is OK */
+			pprev = rht_bucket_var(tbl, hash);
+		else
+			pprev = rht_bucket_insert(ht, tbl, hash);
+		if (pprev == NULL) {
+			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
+			data = ERR_PTR(-EAGAIN);
+		} else {
+			rht_lock(pprev);
+			data = rhashtable_lookup_one(ht, pprev, tbl,
+						     hash, key, obj);
+			new_tbl = rhashtable_insert_one(ht, pprev, tbl,
+							hash, obj, data);
+			if (PTR_ERR(new_tbl) != -EEXIST)
+				data = ERR_CAST(new_tbl);
+
+			rht_unlock(pprev);
+		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 
 	if (PTR_ERR(data) == -EAGAIN)
@@ -1044,11 +1053,6 @@ int rhashtable_init(struct rhashtable *ht,
 	if (params->nelem_hint)
 		size = rounded_hashtable_size(&ht->p);
 
-	if (params->locks_mul)
-		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
-	else
-		ht->p.locks_mul = BUCKET_LOCKS_PER_CPU;
-
 	ht->key_len = ht->p.key_len;
 	if (!params->hashfn) {
 		ht->p.hashfn = jhash;
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 502f66349530..3ad6c080ebdd 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -33,7 +33,6 @@ static const struct rhashtable_params br_fdb_rht_params = {
 	.key_offset = offsetof(struct net_bridge_fdb_entry, key),
 	.key_len = sizeof(struct net_bridge_fdb_key),
 	.automatic_shrinking = true,
-	.locks_mul = 1,
 };
 
 static struct kmem_cache *br_fdb_cache __read_mostly;
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 7df269092103..b3d940fbfc11 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -21,7 +21,6 @@ static const struct rhashtable_params br_vlan_rht_params = {
 	.key_offset = offsetof(struct net_bridge_vlan, vid),
 	.key_len = sizeof(u16),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.max_size = VLAN_N_VID,
 	.obj_cmpfn = br_vlan_cmp,
 	.automatic_shrinking = true,
diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 6d2c4eed2dc8..758151863669 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -34,7 +34,6 @@ static const struct rhashtable_params br_vlan_tunnel_rht_params = {
 	.key_offset = offsetof(struct net_bridge_vlan, tinfo.tunnel_id),
 	.key_len = sizeof(__be64),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = br_vlan_tunid_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 82f914122f1b..d847d3e4df1f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -372,7 +372,6 @@ static const struct rhashtable_params ipmr_rht_params = {
 	.key_offset = offsetof(struct mfc_cache, cmparg),
 	.key_len = sizeof(struct mfc_cache_cmp_arg),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = ipmr_hash_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index d0b7e0249c13..f2ab8a29f53e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -346,7 +346,6 @@ static const struct rhashtable_params ip6mr_rht_params = {
 	.key_offset = offsetof(struct mfc6_cache, cmparg),
 	.key_len = sizeof(struct mfc6_cache_cmp_arg),
 	.nelem_hint = 3,
-	.locks_mul = 1,
 	.obj_cmpfn = ip6mr_hash_cmp,
 	.automatic_shrinking = true,
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3f211e1025c1..c4e62382f6b0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -45,7 +45,6 @@ static const struct rhashtable_params nft_chain_ht_params = {
 	.hashfn			= nft_chain_hash,
 	.obj_hashfn		= nft_chain_hash_obj,
 	.obj_cmpfn		= nft_chain_hash_cmp,
-	.locks_mul		= 1,
 	.automatic_shrinking	= true,
 };
 


