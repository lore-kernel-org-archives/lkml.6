Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCEEC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68822395
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE68822395
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeGFHXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:23:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754329AbeGFHXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:23:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD280AFAC;
        Fri,  6 Jul 2018 07:23:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 06 Jul 2018 17:22:30 +1000
Subject: [PATCH 5/5] rhashtable: add lockdep tracking to bucket
 bit-spin-locks.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086175019.24852.6842758948705963403.stgit@noble>
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

Native bit_spin_locks are not tracked by lockdep.

The bit_spin_locks used for rhashtable buckets are local
to the rhashtable implementation, so there is little opportunity
for the sort of misuse that lockdep might detect.
However locks are held while a hash function or compare
function is called, and if one of these took a lock,
a misbehaviour is possible.

As it is quite easy to add lockdep support this unlikely
possibility seems to be enough justification.

So create a lockdep class for bucket bit_spin_lock as attach
through a lockdep_map in each bucket_table.

With the 'nested' annotation in rhashtable_rehash_one(), lockdep
correctly reports a possible problem as this lock it taken
while another bucket lock (in another table) is held.  This
confirms that the added support works.
With the correct nested annotation in place, lockdep reports
no problems.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   40 +++++++++++++++++++++++++++-------------
 lib/rhashtable.c           |   17 ++++++++++-------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index b683dc336be1..7568b94f6c87 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -68,6 +68,8 @@ struct bucket_table {
 
 	struct bucket_table __rcu *future_tbl;
 
+	struct lockdep_map	dep_map;
+
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
@@ -88,20 +90,32 @@ struct bucket_table {
  * will have provided that.
  */
 
-static inline void rht_lock(struct rhash_head **bucket)
+static inline void rht_lock(struct bucket_table *tbl, struct rhash_head **bucket)
+{
+	local_bh_disable();
+	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_map_acquire(&tbl->dep_map);
+}
+
+static inline void rht_lock_nested(struct bucket_table *tbl,
+				   struct rhash_head **bucket,
+				   unsigned int subclass)
 {
 	local_bh_disable();
 	bit_spin_lock(1, (unsigned long *)bucket);
+	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
 }
 
-static inline void rht_unlock(struct rhash_head **bucket)
+static inline void rht_unlock(struct bucket_table *tbl, struct rhash_head **bucket)
 {
+	lock_map_release(&tbl->dep_map);
 	bit_spin_unlock(1, (unsigned long *)bucket);
 	local_bh_enable();
 }
 
-static inline void rht_unlocked(void)
+static inline void rht_unlocked(struct bucket_table *tbl)
 {
+	lock_map_release(&tbl->dep_map);
 	preempt_enable();
 	__release(bitlock);
 	local_bh_enable();
@@ -676,11 +690,11 @@ static inline void *__rhashtable_insert_fast(
 	if (!headp)
 		goto out;
 	lock = pprev = headp;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	if (unlikely(rcu_access_pointer(tbl->future_tbl))) {
 slow_path:
-		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 		rcu_read_unlock();
 		return rhashtable_insert_slow(ht, key, obj);
 	}
@@ -756,10 +770,10 @@ static inline void *__rhashtable_insert_fast(
 		/* Assigning to *headp unlocked the chain, so we
 		 * don't need to do it again.
 		 */
-		rht_unlocked();
+		rht_unlocked(tbl);
 	} else {
 out:
-		rht_unlock(lock);
+		rht_unlock(tbl, lock);
 	}
 	rcu_read_unlock();
 
@@ -964,7 +978,7 @@ static inline int __rhashtable_remove_fast_one(
 	if (!pprev)
 		return -ENOENT;
 	lock = pprev;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
 		struct rhlist_head *list;
@@ -1009,13 +1023,13 @@ static inline int __rhashtable_remove_fast_one(
 		rcu_assign_pointer(*pprev, obj);
 		if (lock == pprev) {
 			/* That rcu_assign_pointer() unlocked the chain */
-			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
 
-	rht_unlock(lock);
+	rht_unlock(tbl, lock);
 unlocked:
 	if (err > 0) {
 		atomic_dec(&ht->nelems);
@@ -1123,7 +1137,7 @@ static inline int __rhashtable_replace_fast(
 		return -ENOENT;
 
 	lock = pprev;
-	rht_lock(lock);
+	rht_lock(tbl, lock);
 
 	rht_for_each_continue(he, rht_ptr(*pprev), tbl, hash) {
 		if (he != obj_old) {
@@ -1136,13 +1150,13 @@ static inline int __rhashtable_replace_fast(
 		err = 0;
 		if (pprev == lock) {
 			/* We just unlocked the chain by assigning to *pprev */
-			rht_unlocked();
+			rht_unlocked(tbl);
 			goto unlocked;
 		}
 		break;
 	}
 
-	rht_unlock(lock);
+	rht_unlock(tbl, lock);
 
 unlocked:
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9b0ca9e1f6b5..068e6dfcb249 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -174,6 +174,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	struct bucket_table *tbl = NULL;
 	size_t size;
 	int i;
+	static struct lock_class_key __key;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
 	if (gfp != GFP_KERNEL)
@@ -190,6 +191,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	if (tbl == NULL)
 		return NULL;
 
+	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", &__key, 0);
+
 	tbl->size = size;
 
 	INIT_LIST_HEAD(&tbl->walkers);
@@ -249,7 +252,7 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	inspos = &new_tbl->buckets[new_hash];
 	lock = inspos;
-	rht_lock(lock);
+	rht_lock_nested(new_tbl, lock, SINGLE_DEPTH_NESTING);
 
 	head = rht_ptr(rht_dereference_bucket(*inspos, new_tbl, new_hash));
 	while (!rht_is_a_nulls(head) && head < entry) {
@@ -260,9 +263,9 @@ static int rhashtable_rehash_one(struct rhashtable *ht,
 
 	rcu_assign_pointer(*inspos, entry);
 	if (inspos != lock)
-		rht_unlock(lock);
+		rht_unlock(new_tbl, lock);
 	else
-		rht_unlocked();
+		rht_unlocked(new_tbl);
 
 	/* Need to preserved the bit lock. */
 	if (rht_is_locked(*pprev))
@@ -283,14 +286,14 @@ static int rhashtable_rehash_chain(struct rhashtable *ht,
 
 	if (!pprev)
 		return 0;
-	rht_lock(pprev);
+	rht_lock(old_tbl, pprev);
 
 	while (!(err = rhashtable_rehash_one(ht, pprev, old_hash)))
 		;
 
 	if (err == -ENOENT)
 		err = 0;
-	rht_unlock(pprev);
+	rht_unlock(old_tbl, pprev);
 
 	return err;
 }
@@ -611,7 +614,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			new_tbl = rht_dereference_rcu(tbl->future_tbl, ht);
 			data = ERR_PTR(-EAGAIN);
 		} else {
-			rht_lock(pprev);
+			rht_lock(tbl, pprev);
 			data = rhashtable_lookup_one(ht, pprev, tbl,
 						     hash, key, obj);
 			new_tbl = rhashtable_insert_one(ht, pprev, tbl,
@@ -619,7 +622,7 @@ static void *rhashtable_try_insert(struct rhashtable *ht, const void *key,
 			if (PTR_ERR(new_tbl) != -EEXIST)
 				data = ERR_CAST(new_tbl);
 
-			rht_unlock(pprev);
+			rht_unlock(tbl, pprev);
 		}
 	} while (!IS_ERR_OR_NULL(new_tbl));
 


