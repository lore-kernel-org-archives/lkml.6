Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeFAEqi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeFAEqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:46:33 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 14/18] rhashtable: allow rht_bucket_var to return NULL.
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824980.30340.9114769240731180970.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than returning a pointer a static nulls, rht_bucket_var()
now returns NULL if the bucket doesn't exist.
This will make the next patch, which stores a bitlock in the
bucket pointer, somewhat cleaner.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   11 +++++++++--
 lib/rhashtable.c           |   26 +++++++++++++++++++-------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 5f0511bd5a39..81ca3ed2927b 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -256,6 +256,8 @@ void rhashtable_destroy(struct rhashtable *ht);
 
 struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 					    unsigned int hash);
+struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+					      unsigned int hash);
 struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 						   struct bucket_table *tbl,
 						   unsigned int hash);
@@ -285,7 +287,7 @@ static inline struct rhash_head __rcu *const *rht_bucket(
 static inline struct rhash_head __rcu **rht_bucket_var(
 	struct bucket_table *tbl, unsigned int hash)
 {
-	return unlikely(tbl->nest) ? rht_bucket_nested(tbl, hash) :
+	return unlikely(tbl->nest) ? __rht_bucket_nested(tbl, hash) :
 				     &tbl->buckets[hash];
 }
 
@@ -888,6 +890,8 @@ static inline int __rhashtable_remove_fast_one(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_continue(he, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 
@@ -932,6 +936,7 @@ static inline int __rhashtable_remove_fast_one(
 		break;
 	}
 
+out:
 	spin_unlock_bh(lock);
 
 	if (err > 0) {
@@ -1040,6 +1045,8 @@ static inline int __rhashtable_replace_fast(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_continue(he, *pprev, tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
@@ -1051,7 +1058,7 @@ static inline int __rhashtable_replace_fast(
 		err = 0;
 		break;
 	}
-
+out:
 	spin_unlock_bh(lock);
 
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 919eebd6757d..bac2493808f0 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -240,8 +240,10 @@ static int rhashtable_rehash_one(struct rhashtable *ht, unsigned int old_hash)
 		goto out;
 
 	err = -ENOENT;
+	if (!pprev)
+		goto out;
 
-	rht_for_each(entry, old_tbl, old_hash) {
+	rht_for_each_continue(entry, *pprev, old_tbl, old_hash) {
 		err = 0;
 		next = rht_dereference_bucket(entry->next, old_tbl, old_hash);
 
@@ -498,6 +500,8 @@ static void *rhashtable_lookup_one(struct rhashtable *ht,
 
 	elasticity = RHT_ELASTICITY;
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		return ERR_PTR(-ENOENT);
 	rht_for_each_continue(head, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 		struct rhlist_head *plist;
@@ -1161,11 +1165,10 @@ void rhashtable_destroy(struct rhashtable *ht)
 }
 EXPORT_SYMBOL_GPL(rhashtable_destroy);
 
-struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
-					    unsigned int hash)
+struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+					      unsigned int hash)
 {
 	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
-	static struct rhash_head __rcu *rhnull;
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	unsigned int subhash = hash;
@@ -1184,14 +1187,23 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 	}
 
 	if (!ntbl) {
-		if (!rhnull)
-			INIT_RHT_NULLS_HEAD(rhnull);
-		return &rhnull;
+		return NULL;
 	}
 
 	return &ntbl[subhash].bucket;
 
 }
+EXPORT_SYMBOL_GPL(__rht_bucket_nested);
+
+struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
+					    unsigned int hash)
+{
+	static struct rhash_head __rcu *rhnull;
+
+	if (!rhnull)
+		INIT_RHT_NULLS_HEAD(rhnull);
+	return __rht_bucket_nested(tbl, hash) ?: &rhnull;
+}
 EXPORT_SYMBOL_GPL(rht_bucket_nested);
 
 struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
