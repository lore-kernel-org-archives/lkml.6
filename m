Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeFAEps (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 00:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbeFAEpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 00:45:42 -0400
From: NeilBrown <neilb@suse.com>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Jun 2018 14:44:09 +1000
Subject: [PATCH 06/18] rhashtable: simplify nested_table_alloc() and
 rht_bucket_nested_insert()
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152782824950.30340.10831876745236207066.stgit@noble>
In-Reply-To: <152782754287.30340.4395718227884933670.stgit@noble>
References: <152782754287.30340.4395718227884933670.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't use the hash value or shift in nested_table_alloc()
there is room for simplification.
We only need to pass a "is this a leaf" flag to nested_table_alloc(),
and don't need to track as much information in
rht_bucket_nested_insert().

Note there is another minor cleanup in nested_table_alloc() here.
The number of elements in a page of "union nested_tables" is most naturally

  PAGE_SIZE / sizeof(ntbl[0])

The previous code had

  PAGE_SIZE / sizeof(ntbl[0].bucket)

which happens to be the correct value only because the bucket uses all
the space in the union.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 8582e1916c2d..e209069f1d74 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -116,7 +116,7 @@ static void bucket_table_free_rcu(struct rcu_head *head)
 
 static union nested_table *nested_table_alloc(struct rhashtable *ht,
 					      union nested_table __rcu **prev,
-					      unsigned int shifted)
+					      bool leaf)
 {
 	union nested_table *ntbl;
 	int i;
@@ -127,8 +127,8 @@ static union nested_table *nested_table_alloc(struct rhashtable *ht,
 
 	ntbl = kzalloc(PAGE_SIZE, GFP_ATOMIC);
 
-	if (ntbl && shifted) {
-		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0].bucket); i++)
+	if (ntbl && leaf) {
+		for (i = 0; i < PAGE_SIZE / sizeof(ntbl[0]); i++)
 			INIT_RHT_NULLS_HEAD(ntbl[i].bucket);
 	}
 
@@ -155,7 +155,7 @@ static struct bucket_table *nested_bucket_table_alloc(struct rhashtable *ht,
 		return NULL;
 
 	if (!nested_table_alloc(ht, (union nested_table __rcu **)tbl->buckets,
-				0)) {
+				false)) {
 		kfree(tbl);
 		return NULL;
 	}
@@ -1209,24 +1209,18 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 	unsigned int index = hash & ((1 << tbl->nest) - 1);
 	unsigned int size = tbl->size >> tbl->nest;
 	union nested_table *ntbl;
-	unsigned int shifted;
-	unsigned int nhash;
 
 	ntbl = (union nested_table *)rcu_dereference_raw(tbl->buckets[0]);
 	hash >>= tbl->nest;
-	nhash = index;
-	shifted = tbl->nest;
 	ntbl = nested_table_alloc(ht, &ntbl[index].table,
-				  size <= (1 << shift) ? shifted : 0);
+				  size <= (1 << shift));
 
 	while (ntbl && size > (1 << shift)) {
 		index = hash & ((1 << shift) - 1);
 		size >>= shift;
 		hash >>= shift;
-		nhash |= index << shifted;
-		shifted += shift;
 		ntbl = nested_table_alloc(ht, &ntbl[index].table,
-					  size <= (1 << shift) ? shifted : 0);
+					  size <= (1 << shift));
 	}
 
 	if (!ntbl)
