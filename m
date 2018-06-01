Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeFAEpm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:34047 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751206AbeFAEpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:36 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 05/18] rhashtable: simplify INIT_RHT_NULLS_HEAD()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824947.30340.2254332178823222989.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ht' and 'hash' arguments to INIT_RHT_NULLS_HEAD() are
no longer used - so drop them.  This allows us to also
from the nhash argument from nested_table_alloc().

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    2 +-
 lib/rhashtable.c           |   17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 25d839881ae5..49f80506d02e 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -77,7 +77,7 @@ struct bucket_table {
 
 #define	RHT_NULLS_MARKER(ptr)	\
 	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
-#define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
+#define INIT_RHT_NULLS_HEAD(ptr)	\
 	((ptr) = RHT_NULLS_MARKER(&(ptr)))
 
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 69f05cf9e9e8..8582e1916c2d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -116,8 +116,7 @@ static void bucket_table_free_rcu(struct rcu_head *head)
 
 static union nested_table *nested_table_alloc(struct rhashtable *ht,
 					      union nested_table __rcu **prev,
-					      unsigned int shifted,
-					      unsigned int nhash)
+					      unsigned int shifted)
 {
 	union nested_table *ntbl;
 	int i;
@@ -130,8 +129,7 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 
 	if (ntbl && shifted) {
 		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0].bucket); i++)
-			INIT_RHT_NULLS_HEAD(ntbl[i].bucket, ht,
-					    (i << shifted) | nhash);
+			INIT_RHT_NULLS_HEAD(ntbl[i].bucket);
 	}
 
 	rcu_assign_pointer(*prev, ntbl);
@@ -157,7 +155,7 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 		return NULL;
 
 	if (!nested_table_alloc(ht, (union nested_table __rcu **)tbl->buckets,
-				0, 0)) {
+				0)) {
 		kfree(tbl);
 		return NULL;
 	}
@@ -207,7 +205,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	tbl->hash_rnd = get_random_u32();
 
 	for (i = 0; i < nbuckets; i++)
-		INIT_RHT_NULLS_HEAD(tbl->buckets[i], ht, i);
+		INIT_RHT_NULLS_HEAD(tbl->buckets[i]);
 
 	return tbl;
 }
@@ -1194,7 +1192,7 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 
 	if (!ntbl) {
 		if (!rhnull)
-			INIT_RHT_NULLS_HEAD(rhnull, NULL, 0);
+			INIT_RHT_NULLS_HEAD(rhnull);
 		return &rhnull;
 	}
 
@@ -1219,7 +1217,7 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 	nhash = index;
 	shifted = tbl->nest;
 	ntbl = nested_table_alloc(ht, &ntbl[index].table,
-				  size <= (1 << shift) ? shifted : 0, nhash);
+				  size <= (1 << shift) ? shifted : 0);
 
 	while (ntbl && size > (1 << shift)) {
 		index = hash & ((1 << shift) - 1);
@@ -1228,8 +1226,7 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 		nhash |= index << shifted;
 		shifted += shift;
 		ntbl = nested_table_alloc(ht, &ntbl[index].table,
-					  size <= (1 << shift) ? shifted : 0,
-					  nhash);
+					  size <= (1 << shift) ? shifted : 0);
 	}
 
 	if (!ntbl)
