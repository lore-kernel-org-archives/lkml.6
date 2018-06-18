Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE28C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B512208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B512208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeFRC4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:56:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754666AbeFRC4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D18CAEC2;
        Mon, 18 Jun 2018 02:56:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Date:   Mon, 18 Jun 2018 12:52:50 +1000
Subject: [PATCH 5/7] rhashtable: simplify nested_table_alloc() and
 rht_bucket_nested_insert()
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <152929037048.23173.1713873344580842520.stgit@noble>
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

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 lib/rhashtable.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index a81cd27d518c..2aa41c15df17 100644
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
@@ -1207,24 +1207,18 @@ struct rhash_head __rcu **rht_bucket_nested_insert(struct rhashtable *ht,
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


