Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE2FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAF9208E2
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V/VP50i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF9208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934866AbeFQCBs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:01:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934735AbeFQCBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tlIfOaZD65OibIYNa71Eb6Qj73wPp5+FWyuOeHJmT1I=; b=V/VP50i1eGq1JBQnXZQYQRIOA
        5LuYCBaKRl82oGGXEJmt+4m8/2BmzbrRhIUa2JSfJEleDINrEiAbIHVA6fM/JtH3iG6Lh5AJtSWbW
        11k0991Zkcqc8hwTeen1vgdanb9r1NhVoL1JSpFGDBqORQWeRjMIoaAN9fcTyx4i7kzp8oA0cIYZs
        8F7vBGmx56kmQjmyjuB4B/B0oSNVzKAE/x11+j18U9GJail1FJJy0ci+y1qkPTJycDDUDTM4ksRgW
        s5pT0JujDsHjOG6BM4OcnLEQcdiKsiC/vNHIcnnt0g4pId8rJsNZ11XXrQWXHDwJjkl2zsWF4JxMw
        vsK9H5MmA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fUN0f-0001j4-8d; Sun, 17 Jun 2018 02:01:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
Subject: [PATCH v14 74/74] radix tree: Remove radix_tree_clear_tags
Date:   Sat, 16 Jun 2018 19:00:52 -0700
Message-Id: <20180617020052.4759-75-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180617020052.4759-1-willy@infradead.org>
References: <20180617020052.4759-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page cache was the only user of this interface and it has now
been converted to the XArray.  Transform the test into a test of
xas_init_tags().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/radix-tree.h           |  2 --
 lib/radix-tree.c                     | 13 -----------
 lib/test_xarray.c                    | 33 ++++++++++++++++++++++++++++
 tools/testing/radix-tree/tag_check.c | 29 ------------------------
 4 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index f8ef267e4975..27c15990951d 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -252,8 +252,6 @@ void radix_tree_iter_delete(struct radix_tree_root *,
 			struct radix_tree_iter *iter, void __rcu **slot);
 void *radix_tree_delete_item(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
-void radix_tree_clear_tags(struct radix_tree_root *, struct radix_tree_node *,
-			   void __rcu **slot);
 unsigned int radix_tree_gang_lookup(const struct radix_tree_root *,
 			void **results, unsigned long first_index,
 			unsigned int max_items);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index ad03dc0c562f..101f1c28e1b6 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1711,19 +1711,6 @@ void *radix_tree_delete(struct radix_tree_root *root, unsigned long index)
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
-void radix_tree_clear_tags(struct radix_tree_root *root,
-			   struct radix_tree_node *node,
-			   void __rcu **slot)
-{
-	if (node) {
-		unsigned int tag, offset = get_slot_offset(node, slot);
-		for (tag = 0; tag < RADIX_TREE_MAX_TAGS; tag++)
-			node_tag_clear(root, node, tag, offset);
-	} else {
-		root_tag_clear_all(root);
-	}
-}
-
 /**
  *	radix_tree_tagged - test whether any items in the tree are tagged
  *	@root:		radix tree root
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0ac0c8108ef4..98c0efdd27a0 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -170,12 +170,45 @@ static void check_xa_tag_1(struct xarray *xa, unsigned long index)
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static void check_xa_tag_2(struct xarray *xa)
+{
+	XA_STATE(xas, xa, 0);
+	unsigned long index;
+	unsigned int count = 0;
+	void *entry;
+
+	xa_store_value(xa, 0, GFP_KERNEL);
+	xa_set_tag(xa, 0, XA_TAG_0);
+	xas_load(&xas);
+	xas_init_tags(&xas);
+	XA_BUG_ON(xa, !xa_get_tag(xa, 0, XA_TAG_0) == 0);
+
+	for (index = 3500; index < 4500; index++) {
+		xa_store_value(xa, index, GFP_KERNEL);
+		xa_set_tag(xa, index, XA_TAG_0);
+	}
+
+	xas_reset(&xas);
+	xas_for_each_tagged(&xas, entry, ULONG_MAX, XA_TAG_0)
+		count++;
+	XA_BUG_ON(xa, count != 1000);
+
+	xas_for_each(&xas, entry, ULONG_MAX) {
+		xas_init_tags(&xas);
+		XA_BUG_ON(xa, !xa_get_tag(xa, xas.xa_index, XA_TAG_0));
+		XA_BUG_ON(xa, !xas_get_tag(&xas, XA_TAG_0));
+	}
+
+	xa_destroy(xa);
+}
+
 static void check_xa_tag(struct xarray *xa)
 {
 	check_xa_tag_1(xa, 0);
 	check_xa_tag_1(xa, 4);
 	check_xa_tag_1(xa, 64);
 	check_xa_tag_1(xa, 4096);
+	check_xa_tag_2(xa);
 }
 
 static void check_xa_shrink(struct xarray *xa)
diff --git a/tools/testing/radix-tree/tag_check.c b/tools/testing/radix-tree/tag_check.c
index 543181e4847b..56a42f1c5ab0 100644
--- a/tools/testing/radix-tree/tag_check.c
+++ b/tools/testing/radix-tree/tag_check.c
@@ -331,34 +331,6 @@ static void single_check(void)
 	item_kill_tree(&tree);
 }
 
-void radix_tree_clear_tags_test(void)
-{
-	unsigned long index;
-	struct radix_tree_node *node;
-	struct radix_tree_iter iter;
-	void **slot;
-
-	RADIX_TREE(tree, GFP_KERNEL);
-
-	item_insert(&tree, 0);
-	item_tag_set(&tree, 0, 0);
-	__radix_tree_lookup(&tree, 0, &node, &slot);
-	radix_tree_clear_tags(&tree, node, slot);
-	assert(item_tag_get(&tree, 0, 0) == 0);
-
-	for (index = 0; index < 1000; index++) {
-		item_insert(&tree, index);
-		item_tag_set(&tree, index, 0);
-	}
-
-	radix_tree_for_each_slot(slot, &tree, &iter, 0) {
-		radix_tree_clear_tags(&tree, iter.node, slot);
-		assert(item_tag_get(&tree, iter.index, 0) == 0);
-	}
-
-	item_kill_tree(&tree);
-}
-
 void tag_check(void)
 {
 	single_check();
@@ -376,5 +348,4 @@ void tag_check(void)
 	thrash_tags();
 	rcu_barrier();
 	printv(2, "after thrash_tags: %d allocated\n", nr_allocated);
-	radix_tree_clear_tags_test();
 }
-- 
2.17.1

