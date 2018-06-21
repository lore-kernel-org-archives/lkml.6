Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4604CC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DDB2243F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DDB2243F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeFUV3E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:04 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:60559 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeFUV3A (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Jun 2018 17:29:00 -0400
Received: from linux-r8p5.suse.cz (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 21 Jun 2018 15:28:50 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/4] lib/rhashtable: guarantee initial hashtable allocation
Date:   Thu, 21 Jun 2018 14:28:23 -0700
Message-Id: <20180621212825.3059-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621212825.3059-1-dave@stgolabs.net>
References: <20180621212825.3059-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_init() may fail due to -ENOMEM, thus making the
entire api unusable. This patch removes this scenario,
however unlikely. In order to guarantee memory allocation,
this patch always ends up doing GFP_KERNEL|__GFP_NOFAIL
for both the tbl as well as alloc_bucket_spinlocks().

Upon the first table allocation failure, we shrink the
size to the smallest value that makes sense and retry with
__GFP_NOFAIL semantics. With the defaults, this means that
from 64 buckets, we retry with only 4. Any later issues
regarding performance due to collisions or larger table
resizing (when more memory becomes available) is the least
of our problems.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 26c9cd8a985a..411c4041ce83 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -179,10 +179,11 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	size = nbuckets;
 
-	if (tbl == NULL && gfp != GFP_KERNEL) {
+	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}
+
 	if (tbl == NULL)
 		return NULL;
 
@@ -1065,9 +1066,16 @@ int rhashtable_init(struct rhashtable *ht,
 		}
 	}
 
+	/*
+	 * This is api initialization and thus we need to guarantee the
+	 * initial rhashtable allocation. Upon failure, retry with the
+	 * smallest possible size with __GFP_NOFAIL semantics.
+	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
-	if (tbl == NULL)
-		return -ENOMEM;
+	if (unlikely(tbl == NULL)) {
+		size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL | __GFP_NOFAIL);
+	}
 
 	atomic_set(&ht->nelems, 0);
 
-- 
2.16.4

