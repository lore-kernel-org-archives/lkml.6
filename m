Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xZwdEJqCHls/DAAAmS7hNA
	; Mon, 11 Jun 2018 14:09:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2573060351; Mon, 11 Jun 2018 14:09:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYb1tBGs"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 891ED607E4;
	Mon, 11 Jun 2018 14:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 891ED607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933799AbeFKOJ1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:09:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933639AbeFKOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FLt+uuv8x4/brk+GgaQwJBuXMctM8W14N4Xfz3gb9PA=; b=nYb1tBGsWBpzv9MuXzojicTxC
        hZ0LHskREnfZ4C0bykm7mc9jcuBVk9eS9E3VgCN658IMlzwokzyPok0AKoyZmUIarWlhokfxVgenW
        O0h+we4ZRo6Ugrip4Axjpbh/tRs4nyqFK7Aao+zNwefFpsk3mjhy2m7NIOtDsg/AwqfmaW2iXRPTT
        EMUC/09mR4giGBZMBvl3/SUI/fgtaNRJV6zeLzcz8Mw7TqQxNSkKiI7inPezQkKiBquwS86J/1cOw
        ZSf7vKAHlWkhGSTqZHT5Y2n7ITYOB+rv7YceEXXJ2nm+yYPyieM+Dhhh9jvC4US9SrUnYyJp7nI0V
        egVGze0Tg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTY-00055d-IL; Mon, 11 Jun 2018 14:07:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v13 71/72] radix tree: Remove radix_tree_maybe_preload_order
Date: Mon, 11 Jun 2018 07:06:38 -0700
Message-Id: <20180611140639.17215-72-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This function was only used by the page cache which is now converted
to the XArray.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/radix-tree.h |  1 -
 lib/radix-tree.c           | 74 --------------------------------------
 2 files changed, 75 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index b882d644cc47..f8ef267e4975 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -259,7 +259,6 @@ unsigned int radix_tree_gang_lookup(const struct radix_tree_root *,
 			unsigned int max_items);
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
-int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order);
 void radix_tree_init(void);
 void *radix_tree_tag_set(struct radix_tree_root *,
 			unsigned long index, unsigned int tag);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index c472ceeb6a97..ad03dc0c562f 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -41,9 +41,6 @@
 #include <linux/xarray.h>
 
 
-/* Number of nodes in fully populated tree of given height */
-static unsigned long height_to_maxnodes[RADIX_TREE_MAX_PATH + 1] __read_mostly;
-
 /*
  * Radix tree node cache.
  */
@@ -463,51 +460,6 @@ int radix_tree_maybe_preload(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(radix_tree_maybe_preload);
 
-/*
- * The same as function above, but preload number of nodes required to insert
- * (1 << order) continuous naturally-aligned elements.
- */
-int radix_tree_maybe_preload_order(gfp_t gfp_mask, int order)
-{
-	unsigned long nr_subtrees;
-	int nr_nodes, subtree_height;
-
-	/* Preloading doesn't help anything with this gfp mask, skip it */
-	if (!gfpflags_allow_blocking(gfp_mask)) {
-		preempt_disable();
-		return 0;
-	}
-
-	/*
-	 * Calculate number and height of fully populated subtrees it takes to
-	 * store (1 << order) elements.
-	 */
-	nr_subtrees = 1 << order;
-	for (subtree_height = 0; nr_subtrees > RADIX_TREE_MAP_SIZE;
-			subtree_height++)
-		nr_subtrees >>= RADIX_TREE_MAP_SHIFT;
-
-	/*
-	 * The worst case is zero height tree with a single item at index 0 and
-	 * then inserting items starting at ULONG_MAX - (1 << order).
-	 *
-	 * This requires RADIX_TREE_MAX_PATH nodes to build branch from root to
-	 * 0-index item.
-	 */
-	nr_nodes = RADIX_TREE_MAX_PATH;
-
-	/* Plus branch to fully populated subtrees. */
-	nr_nodes += RADIX_TREE_MAX_PATH - subtree_height;
-
-	/* Root node is shared. */
-	nr_nodes--;
-
-	/* Plus nodes required to build subtrees. */
-	nr_nodes += nr_subtrees * height_to_maxnodes[subtree_height];
-
-	return __radix_tree_preload(gfp_mask, nr_nodes);
-}
-
 static unsigned radix_tree_load_root(const struct radix_tree_root *root,
 		struct radix_tree_node **nodep, unsigned long *maxindex)
 {
@@ -1928,31 +1880,6 @@ radix_tree_node_ctor(void *arg)
 	INIT_LIST_HEAD(&node->private_list);
 }
 
-static __init unsigned long __maxindex(unsigned int height)
-{
-	unsigned int width = height * RADIX_TREE_MAP_SHIFT;
-	int shift = RADIX_TREE_INDEX_BITS - width;
-
-	if (shift < 0)
-		return ~0UL;
-	if (shift >= BITS_PER_LONG)
-		return 0UL;
-	return ~0UL >> shift;
-}
-
-static __init void radix_tree_init_maxnodes(void)
-{
-	unsigned long height_to_maxindex[RADIX_TREE_MAX_PATH + 1];
-	unsigned int i, j;
-
-	for (i = 0; i < ARRAY_SIZE(height_to_maxindex); i++)
-		height_to_maxindex[i] = __maxindex(i);
-	for (i = 0; i < ARRAY_SIZE(height_to_maxnodes); i++) {
-		for (j = i; j > 0; j--)
-			height_to_maxnodes[i] += height_to_maxindex[j - 1] + 1;
-	}
-}
-
 static int radix_tree_cpu_dead(unsigned int cpu)
 {
 	struct radix_tree_preload *rtp;
@@ -1982,7 +1909,6 @@ void __init radix_tree_init(void)
 			sizeof(struct radix_tree_node), 0,
 			SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
 			radix_tree_node_ctor);
-	radix_tree_init_maxnodes();
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);
 	WARN_ON(ret < 0);
-- 
2.17.1
