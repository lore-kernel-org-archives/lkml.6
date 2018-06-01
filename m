Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeFAEpf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeFAEpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:31 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 04/18] rhashtable: detect when object movement might have
 invalidated a lookup
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824943.30340.8224535954517915320.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users of rhashtable might need to change the key
of an object and move it to a different location in the table.
Other users might want to allocate objects using
SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
being used for a different (type-compatible) purpose and similarly
end up in a different hash-chain.

To support these, we store a unique NULLS_MARKER at the end of
each chain, and when a search fails to find a match, we check
if the NULLS marker found was the expected one.  If not,
the search is repeated.

The unique NULLS_MARKER is derived from the address of the
head of the chain.

If an object is removed and re-added to the same hash chain, we won't
notice by looking that the NULLS marker.  In this case we must be sure
that it was not re-added *after* its original location, or a lookup may
incorrectly fail.  The easiest solution is to ensure it is inserted at
the start of the chain.  insert_slow() already does that,
insert_fast() does not.  So this patch changes insert_fast to always
insert at the head of the chain.

Note that such a user must do their own double-checking of
the object found by rhashtable_lookup_fast() after ensuring
mutual exclusion which anything that might change the key, such as
successfully taking a new reference.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   35 +++++++++++++++++++++++------------
 lib/rhashtable.c           |    8 +++++---
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index d9f719af7936..25d839881ae5 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -75,8 +75,10 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
+#define	RHT_NULLS_MARKER(ptr)	\
+	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
 #define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
-	((ptr) = (typeof(ptr)) NULLS_MARKER(0))
+	((ptr) = RHT_NULLS_MARKER(&(ptr)))
 
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
 {
@@ -471,6 +473,7 @@ static inline struct rhash_head *__rhashtable_lookup(
 		.ht = ht,
 		.key = key,
 	};
+	struct rhash_head __rcu * const *head;
 	struct bucket_table *tbl;
 	struct rhash_head *he;
 	unsigned int hash;
@@ -478,13 +481,19 @@ static inline struct rhash_head *__rhashtable_lookup(
 	tbl = rht_dereference_rcu(ht->tbl, ht);
 restart:
 	hash = rht_key_hashfn(ht, tbl, key, params);
-	rht_for_each_rcu(he, tbl, hash) {
-		if (params.obj_cmpfn ?
-		    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
-		    rhashtable_compare(&arg, rht_obj(ht, he)))
-			continue;
-		return he;
-	}
+	head = rht_bucket(tbl, hash);
+	do {
+		rht_for_each_rcu_continue(he, *head, tbl, hash) {
+			if (params.obj_cmpfn ?
+			    params.obj_cmpfn(&arg, rht_obj(ht, he)) :
+			    rhashtable_compare(&arg, rht_obj(ht, he)))
+				continue;
+			return he;
+		}
+		/* An object might have been moved to a different hash chain,
+		 * while we walk along it - better check and retry.
+		 */
+	} while (he != RHT_NULLS_MARKER(head));
 
 	/* Ensure we see any new tables. */
 	smp_rmb();
@@ -580,6 +589,7 @@ static inline void *__rhashtable_insert_fast(
 		.ht = ht,
 		.key = key,
 	};
+	struct rhash_head __rcu **headp;
 	struct rhash_head __rcu **pprev;
 	struct bucket_table *tbl;
 	struct rhash_head *head;
@@ -603,12 +613,13 @@ static inline void *__rhashtable_insert_fast(
 	}
 
 	elasticity = RHT_ELASTICITY;
-	pprev = rht_bucket_insert(ht, tbl, hash);
+	headp = rht_bucket_insert(ht, tbl, hash);
+	pprev = headp;
 	data = ERR_PTR(-ENOMEM);
 	if (!pprev)
 		goto out;
 
-	rht_for_each_continue(head, *pprev, tbl, hash) {
+	rht_for_each_continue(head, *headp, tbl, hash) {
 		struct rhlist_head *plist;
 		struct rhlist_head *list;
 
@@ -648,7 +659,7 @@ static inline void *__rhashtable_insert_fast(
 	if (unlikely(rht_grow_above_100(ht, tbl)))
 		goto slow_path;
 
-	head = rht_dereference_bucket(*pprev, tbl, hash);
+	head = rht_dereference_bucket(*headp, tbl, hash);
 
 	RCU_INIT_POINTER(obj->next, head);
 	if (rhlist) {
@@ -658,7 +669,7 @@ static inline void *__rhashtable_insert_fast(
 		RCU_INIT_POINTER(list->next, NULL);
 	}
 
-	rcu_assign_pointer(*pprev, obj);
+	rcu_assign_pointer(*headp, obj);
 
 	atomic_inc(&ht->nelems);
 	if (rht_grow_above_75(ht, tbl))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 688693c919be..69f05cf9e9e8 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1174,8 +1174,7 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 					    unsigned int hash)
 {
 	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
-	static struct rhash_head __rcu *rhnull =
-		(struct rhash_head __rcu *)NULLS_MARKER(0);
+	static struct rhash_head __rcu *rhnull;
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	unsigned int subhash = hash;
@@ -1193,8 +1192,11 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 		subhash >>= shift;
 	}
 
-	if (!ntbl)
+	if (!ntbl) {
+		if (!rhnull)
+			INIT_RHT_NULLS_HEAD(rhnull, NULL, 0);
 		return &rhnull;
+	}
 
 	return &ntbl[subhash].bucket;
 
