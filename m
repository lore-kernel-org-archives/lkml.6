Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869E7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BA219DA
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442BA219DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeGFHX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753476AbeGFHXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:23:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66588AFD0;
        Fri,  6 Jul 2018 07:23:22 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 06 Jul 2018 17:22:30 +1000
Subject: [PATCH 3/5] rhashtable: allow rht_bucket_var to return NULL.
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <153086175012.24852.12288342670006044159.stgit@noble>
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

Rather than returning a pointer a static nulls, rht_bucket_var()
now returns NULL if the bucket doesn't exist.
This will make the next patch, which stores a bitlock in the
bucket pointer, somewhat cleaner.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |   11 +++++++++--
 lib/rhashtable.c           |   29 ++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 26ed3b299028..a4ff6ae524a0 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -284,6 +284,8 @@ void rhashtable_destroy(struct rhashtable *ht);
 
 struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 					    unsigned int hash);
+struct rhash_head __rcu **__rht_bucket_nested(const struct bucket_table *tbl,
+					      unsigned int hash);
 struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 						   struct bucket_table *tbl,
 						   unsigned int hash);
@@ -313,7 +315,7 @@ static inline struct rhash_head __rcu *const *rht_bucket(
 static inline struct rhash_head __rcu **rht_bucket_var(
 	struct bucket_table *tbl, unsigned int hash)
 {
-	return unlikely(tbl->nest) ? rht_bucket_nested(tbl, hash) :
+	return unlikely(tbl->nest) ? __rht_bucket_nested(tbl, hash) :
 				     &tbl->buckets[hash];
 }
 
@@ -916,6 +918,8 @@ static inline int __rhashtable_remove_fast_one(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_continue(he, *pprev, tbl, hash) {
 		struct rhlist_head *list;
 
@@ -960,6 +964,7 @@ static inline int __rhashtable_remove_fast_one(
 		break;
 	}
 
+out:
 	spin_unlock_bh(lock);
 
 	if (err > 0) {
@@ -1068,6 +1073,8 @@ static inline int __rhashtable_replace_fast(
 	spin_lock_bh(lock);
 
 	pprev = rht_bucket_var(tbl, hash);
+	if (!pprev)
+		goto out;
 	rht_for_each_continue(he, *pprev, tbl, hash) {
 		if (he != obj_old) {
 			pprev = &he->next;
@@ -1079,7 +1086,7 @@ static inline int __rhashtable_replace_fast(
 		err = 0;
 		break;
 	}
-
+out:
 	spin_unlock_bh(lock);
 
 	return err;
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 27a5ffa993d4..7a68c1f0b6d0 100644
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
@@ -1160,11 +1164,10 @@ void rhashtable_destroy(struct rhashtable *ht)
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
@@ -1182,15 +1185,23 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
 		subhash >>= shift;
 	}
 
-	if (!ntbl) {
-		if (!rhnull)
-			INIT_RHT_NULLS_HEAD(rhnull, NULL, 0);
-		return &rhnull;
-	}
+	if (!ntbl)
+		return NULL;
 
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


