Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D2BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811620870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 19:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSXAzck7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5811620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407178AbeKWGhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 01:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbeKWGhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 01:37:03 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0376A20864;
        Thu, 22 Nov 2018 19:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542916570;
        bh=XGApC75tsE0a/HLhg1A1seQEfABEBPrukrY9pXv8FnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSXAzck7SCNmk0Ba/jkQZsrCvJDwaTZDxYouqqrW/d5eZQTn8O3/TERXw7bCXnxLG
         7hSaAmHEg4Wi4An7ej+nUG9HVmjNFLA3s+/rJ78nh/VdLwThu/x/bicRmu9WNdmGFY
         iDzEILqHqy/we4Q7U3lc0hrsVBvIovXnyHqGZCVQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Vitaly Wool <vitaly.vul@sony.com>,
        Jongseok Kim <ks77sj@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.14 19/21] z3fold: fix possible reclaim races
Date:   Thu, 22 Nov 2018 14:54:50 -0500
Message-Id: <20181122195452.13520-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122195452.13520-1-sashal@kernel.org>
References: <20181122195452.13520-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Wool <vitalywool@gmail.com>

[ Upstream commit ca0246bb97c23da9d267c2107c07fb77e38205c9 ]

Reclaim and free can race on an object which is basically fine but in
order for reclaim to be able to map "freed" object we need to encode
object length in the handle.  handle_to_chunks() is then introduced to
extract object length from a handle and use it during mapping.

Moreover, to avoid racing on a z3fold "headless" page release, we should
not try to free that page in z3fold_free() if the reclaim bit is set.
Also, in the unlikely case of trying to reclaim a page being freed, we
should not proceed with that page.

While at it, fix the page accounting in reclaim function.

This patch supersedes "[PATCH] z3fold: fix reclaim lock-ups".

Link: http://lkml.kernel.org/r/20181105162225.74e8837d03583a9b707cf559@gmail.com
Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
Reported-by-by: Jongseok Kim <ks77sj@gmail.com>
Reviewed-by: Snild Dolkow <snild@sony.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/z3fold.c | 101 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index f33403d718ac..2813cdfa46b9 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -99,6 +99,7 @@ struct z3fold_header {
 #define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
 
 #define BUDDY_MASK	(0x3)
+#define BUDDY_SHIFT	2
 
 /**
  * struct z3fold_pool - stores metadata for each z3fold pool
@@ -145,7 +146,7 @@ enum z3fold_page_flags {
 	MIDDLE_CHUNK_MAPPED,
 	NEEDS_COMPACTING,
 	PAGE_STALE,
-	UNDER_RECLAIM
+	PAGE_CLAIMED, /* by either reclaim or free */
 };
 
 /*****************
@@ -174,7 +175,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	clear_bit(PAGE_STALE, &page->private);
-	clear_bit(UNDER_RECLAIM, &page->private);
+	clear_bit(PAGE_CLAIMED, &page->private);
 
 	spin_lock_init(&zhdr->page_lock);
 	kref_init(&zhdr->refcount);
@@ -223,8 +224,11 @@ static unsigned long encode_handle(struct z3fold_header *zhdr, enum buddy bud)
 	unsigned long handle;
 
 	handle = (unsigned long)zhdr;
-	if (bud != HEADLESS)
-		handle += (bud + zhdr->first_num) & BUDDY_MASK;
+	if (bud != HEADLESS) {
+		handle |= (bud + zhdr->first_num) & BUDDY_MASK;
+		if (bud == LAST)
+			handle |= (zhdr->last_chunks << BUDDY_SHIFT);
+	}
 	return handle;
 }
 
@@ -234,6 +238,12 @@ static struct z3fold_header *handle_to_z3fold_header(unsigned long handle)
 	return (struct z3fold_header *)(handle & PAGE_MASK);
 }
 
+/* only for LAST bud, returns zero otherwise */
+static unsigned short handle_to_chunks(unsigned long handle)
+{
+	return (handle & ~PAGE_MASK) >> BUDDY_SHIFT;
+}
+
 /*
  * (handle & BUDDY_MASK) < zhdr->first_num is possible in encode_handle
  *  but that doesn't matter. because the masking will result in the
@@ -717,37 +727,39 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	page = virt_to_page(zhdr);
 
 	if (test_bit(PAGE_HEADLESS, &page->private)) {
-		/* HEADLESS page stored */
-		bud = HEADLESS;
-	} else {
-		z3fold_page_lock(zhdr);
-		bud = handle_to_buddy(handle);
-
-		switch (bud) {
-		case FIRST:
-			zhdr->first_chunks = 0;
-			break;
-		case MIDDLE:
-			zhdr->middle_chunks = 0;
-			zhdr->start_middle = 0;
-			break;
-		case LAST:
-			zhdr->last_chunks = 0;
-			break;
-		default:
-			pr_err("%s: unknown bud %d\n", __func__, bud);
-			WARN_ON(1);
-			z3fold_page_unlock(zhdr);
-			return;
+		/* if a headless page is under reclaim, just leave.
+		 * NB: we use test_and_set_bit for a reason: if the bit
+		 * has not been set before, we release this page
+		 * immediately so we don't care about its value any more.
+		 */
+		if (!test_and_set_bit(PAGE_CLAIMED, &page->private)) {
+			spin_lock(&pool->lock);
+			list_del(&page->lru);
+			spin_unlock(&pool->lock);
+			free_z3fold_page(page);
+			atomic64_dec(&pool->pages_nr);
 		}
+		return;
 	}
 
-	if (bud == HEADLESS) {
-		spin_lock(&pool->lock);
-		list_del(&page->lru);
-		spin_unlock(&pool->lock);
-		free_z3fold_page(page);
-		atomic64_dec(&pool->pages_nr);
+	/* Non-headless case */
+	z3fold_page_lock(zhdr);
+	bud = handle_to_buddy(handle);
+
+	switch (bud) {
+	case FIRST:
+		zhdr->first_chunks = 0;
+		break;
+	case MIDDLE:
+		zhdr->middle_chunks = 0;
+		break;
+	case LAST:
+		zhdr->last_chunks = 0;
+		break;
+	default:
+		pr_err("%s: unknown bud %d\n", __func__, bud);
+		WARN_ON(1);
+		z3fold_page_unlock(zhdr);
 		return;
 	}
 
@@ -755,7 +767,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		atomic64_dec(&pool->pages_nr);
 		return;
 	}
-	if (test_bit(UNDER_RECLAIM, &page->private)) {
+	if (test_bit(PAGE_CLAIMED, &page->private)) {
 		z3fold_page_unlock(zhdr);
 		return;
 	}
@@ -833,20 +845,30 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 		list_for_each_prev(pos, &pool->lru) {
 			page = list_entry(pos, struct page, lru);
+
+			/* this bit could have been set by free, in which case
+			 * we pass over to the next page in the pool.
+			 */
+			if (test_and_set_bit(PAGE_CLAIMED, &page->private))
+				continue;
+
+			zhdr = page_address(page);
 			if (test_bit(PAGE_HEADLESS, &page->private))
-				/* candidate found */
 				break;
 
-			zhdr = page_address(page);
-			if (!z3fold_page_trylock(zhdr))
+			if (!z3fold_page_trylock(zhdr)) {
+				zhdr = NULL;
 				continue; /* can't evict at this point */
+			}
 			kref_get(&zhdr->refcount);
 			list_del_init(&zhdr->buddy);
 			zhdr->cpu = -1;
-			set_bit(UNDER_RECLAIM, &page->private);
 			break;
 		}
 
+		if (!zhdr)
+			break;
+
 		list_del_init(&page->lru);
 		spin_unlock(&pool->lock);
 
@@ -895,6 +917,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		if (test_bit(PAGE_HEADLESS, &page->private)) {
 			if (ret == 0) {
 				free_z3fold_page(page);
+				atomic64_dec(&pool->pages_nr);
 				return 0;
 			}
 			spin_lock(&pool->lock);
@@ -902,7 +925,7 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 			spin_unlock(&pool->lock);
 		} else {
 			z3fold_page_lock(zhdr);
-			clear_bit(UNDER_RECLAIM, &page->private);
+			clear_bit(PAGE_CLAIMED, &page->private);
 			if (kref_put(&zhdr->refcount,
 					release_z3fold_page_locked)) {
 				atomic64_dec(&pool->pages_nr);
@@ -961,7 +984,7 @@ static void *z3fold_map(struct z3fold_pool *pool, unsigned long handle)
 		set_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 		break;
 	case LAST:
-		addr += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
+		addr += PAGE_SIZE - (handle_to_chunks(handle) << CHUNK_SHIFT);
 		break;
 	default:
 		pr_err("unknown buddy id %d\n", buddy);
-- 
2.17.1

