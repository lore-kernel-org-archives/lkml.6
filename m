Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703FAC5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3527A208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3527A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeFRC4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:47668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754645AbeFRC4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 20992AEBB;
        Mon, 18 Jun 2018 02:56:43 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 4/7] rhashtable: simplify INIT_RHT_NULLS_HEAD()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037045.23173.13462142326594567373.stgit@noble>
In-Reply-To: <152929034948.23173.8671757672560065344.stgit@noble>
References: <152929034948.23173.8671757672560065344.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'ht' and 'hash' arguments to INIT_RHT_NULLS_HEAD() are
no longer used - so drop them.  This allows us to also
remove the nhash argument from nested_table_alloc().

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/rhashtable.h |    2 +-
 lib/rhashtable.c           |   15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index d9f719af7936..3f3a182bd0b4 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -75,7 +75,7 @@ struct bucket_table {
 	struct rhash_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
 
-#define INIT_RHT_NULLS_HEAD(ptr, ht, hash) \
+#define INIT_RHT_NULLS_HEAD(ptr)	\
 	((ptr) = (typeof(ptr)) NULLS_MARKER(0))
 
 static inline bool rht_is_a_nulls(const struct rhash_head *ptr)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 688693c919be..a81cd27d518c 100644
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
@@ -1217,7 +1215,7 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 	nhash = index;
 	shifted = tbl->nest;
 	ntbl = nested_table_alloc(ht, &ntbl[index].table,
-				  size <= (1 << shift) ? shifted : 0, nhash);
+				  size <= (1 << shift) ? shifted : 0);
 
 	while (ntbl && size > (1 << shift)) {
 		index = hash & ((1 << shift) - 1);
@@ -1226,8 +1224,7 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
 		nhash |= index << shifted;
 		shifted += shift;
 		ntbl = nested_table_alloc(ht, &ntbl[index].table,
-					  size <= (1 << shift) ? shifted : 0,
-					  nhash);
+					  size <= (1 << shift) ? shifted : 0);
 	}
 
 	if (!ntbl)


