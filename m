Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93543C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1379521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiGx1KFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1379521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeJDKJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:09:52 -0400
Received: from localhost.localdomain (unknown [58.212.179.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8384420645;
        Thu,  4 Oct 2018 03:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538623122;
        bh=ySTrTC7KmrP4kqm6d+g0lnb1Zm9O+YIrUvB55bqq81k=;
        h=From:To:Cc:Subject:Date:From;
        b=IiGx1KFPEcWlkvzESq0huUyiS/mt+bMA8gAgQk08xibdeeldOoSwVTSeybW7k3VOS
         9iXHlcoT4YXuE9+6BMV03HBnd4pQfV9wNGBvarO6S8ZdjxIt3cQqwPjaf4MNxRADbX
         GN8fyg5xkF5lcGqjOmtNaFxRevo3ziFs9FwN5yBE=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: use rb_*_cached friends
Date:   Thu,  4 Oct 2018 11:18:30 +0800
Message-Id: <20181004031830.4297-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As rbtree supports caching leftmost node natively, update f2fs codes
to use rb_*_cached helpers to speed up leftmost node visiting.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix f2fs_lookup_rb_tree_ret() case.
 fs/f2fs/extent_cache.c | 78 +++++++++++++++++++++++++-----------------
 fs/f2fs/f2fs.h         | 17 ++++-----
 fs/f2fs/segment.c      | 22 +++++++-----
 3 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 904ad7ba5a45..1cb0fcc67d2d 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -27,10 +27,10 @@ static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
 	return NULL;
 }
 
-static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
+static struct rb_entry *__lookup_rb_tree_slow(struct rb_root_cached *root,
 							unsigned int ofs)
 {
-	struct rb_node *node = root->rb_node;
+	struct rb_node *node = root->rb_root.rb_node;
 	struct rb_entry *re;
 
 	while (node) {
@@ -46,7 +46,7 @@ static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
 	return NULL;
 }
 
-struct rb_entry *f2fs_lookup_rb_tree(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs)
 {
 	struct rb_entry *re;
@@ -59,22 +59,25 @@ struct rb_entry *f2fs_lookup_rb_tree(struct rb_root *root,
 }
 
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
-				struct rb_root *root, struct rb_node **parent,
-				unsigned int ofs)
+				struct rb_root_cached *root,
+				struct rb_node **parent,
+				unsigned int ofs, bool *leftmost)
 {
-	struct rb_node **p = &root->rb_node;
+	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_entry *re;
 
 	while (*p) {
 		*parent = *p;
 		re = rb_entry(*parent, struct rb_entry, rb_node);
 
-		if (ofs < re->ofs)
+		if (ofs < re->ofs) {
 			p = &(*p)->rb_left;
-		else if (ofs >= re->ofs + re->len)
+		} else if (ofs >= re->ofs + re->len) {
 			p = &(*p)->rb_right;
-		else
+			*leftmost = false;
+		} else {
 			f2fs_bug_on(sbi, 1);
+		}
 	}
 
 	return p;
@@ -89,16 +92,16 @@ struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * in order to simpfy the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
-struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 				struct rb_entry *cached_re,
 				unsigned int ofs,
 				struct rb_entry **prev_entry,
 				struct rb_entry **next_entry,
 				struct rb_node ***insert_p,
 				struct rb_node **insert_parent,
-				bool force)
+				bool force, bool *leftmost)
 {
-	struct rb_node **pnode = &root->rb_node;
+	struct rb_node **pnode = &root->rb_root.rb_node;
 	struct rb_node *parent = NULL, *tmp_node;
 	struct rb_entry *re = cached_re;
 
@@ -107,7 +110,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
 	*prev_entry = NULL;
 	*next_entry = NULL;
 
-	if (RB_EMPTY_ROOT(root))
+	if (RB_EMPTY_ROOT(&root->rb_root))
 		return NULL;
 
 	if (re) {
@@ -115,16 +118,22 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
 			goto lookup_neighbors;
 	}
 
+	if (leftmost)
+		*leftmost = true;
+
 	while (*pnode) {
 		parent = *pnode;
 		re = rb_entry(*pnode, struct rb_entry, rb_node);
 
-		if (ofs < re->ofs)
+		if (ofs < re->ofs) {
 			pnode = &(*pnode)->rb_left;
-		else if (ofs >= re->ofs + re->len)
+		} else if (ofs >= re->ofs + re->len) {
 			pnode = &(*pnode)->rb_right;
-		else
+			if (leftmost)
+				*leftmost = false;
+		} else {
 			goto lookup_neighbors;
+		}
 	}
 
 	*insert_p = pnode;
@@ -157,10 +166,10 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
 }
 
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-						struct rb_root *root)
+						struct rb_root_cached *root)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
-	struct rb_node *cur = rb_first(root), *next;
+	struct rb_node *cur = rb_first_cached(root), *next;
 	struct rb_entry *cur_re, *next_re;
 
 	if (!cur)
@@ -193,7 +202,8 @@ static struct kmem_cache *extent_node_slab;
 
 static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
-				struct rb_node *parent, struct rb_node **p)
+				struct rb_node *parent, struct rb_node **p,
+				bool leftmost)
 {
 	struct extent_node *en;
 
@@ -206,7 +216,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 	en->et = et;
 
 	rb_link_node(&en->rb_node, parent, p);
-	rb_insert_color(&en->rb_node, &et->root);
+	rb_insert_color_cached(&en->rb_node, &et->root, leftmost);
 	atomic_inc(&et->node_cnt);
 	atomic_inc(&sbi->total_ext_node);
 	return en;
@@ -215,7 +225,7 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
 static void __detach_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_node *en)
 {
-	rb_erase(&en->rb_node, &et->root);
+	rb_erase_cached(&en->rb_node, &et->root);
 	atomic_dec(&et->node_cnt);
 	atomic_dec(&sbi->total_ext_node);
 
@@ -254,7 +264,7 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 		f2fs_radix_tree_insert(&sbi->extent_tree_root, ino, et);
 		memset(et, 0, sizeof(struct extent_tree));
 		et->ino = ino;
-		et->root = RB_ROOT;
+		et->root = RB_ROOT_CACHED;
 		et->cached_en = NULL;
 		rwlock_init(&et->lock);
 		INIT_LIST_HEAD(&et->list);
@@ -275,10 +285,10 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei)
 {
-	struct rb_node **p = &et->root.rb_node;
+	struct rb_node **p = &et->root.rb_root.rb_node;
 	struct extent_node *en;
 
-	en = __attach_extent_node(sbi, et, ei, NULL, p);
+	en = __attach_extent_node(sbi, et, ei, NULL, p, true);
 	if (!en)
 		return NULL;
 
@@ -294,7 +304,7 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 	struct extent_node *en;
 	unsigned int count = atomic_read(&et->node_cnt);
 
-	node = rb_first(&et->root);
+	node = rb_first_cached(&et->root);
 	while (node) {
 		next = rb_next(node);
 		en = rb_entry(node, struct extent_node, rb_node);
@@ -452,7 +462,8 @@ static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct rb_node **insert_p,
-				struct rb_node *insert_parent)
+				struct rb_node *insert_parent,
+				bool leftmost)
 {
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
@@ -464,9 +475,12 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 		goto do_insert;
 	}
 
-	p = f2fs_lookup_rb_tree_for_insert(sbi, &et->root, &parent, ei->fofs);
+	leftmost = true;
+
+	p = f2fs_lookup_rb_tree_for_insert(sbi, &et->root, &parent,
+						ei->fofs, &leftmost);
 do_insert:
-	en = __attach_extent_node(sbi, et, ei, parent, p);
+	en = __attach_extent_node(sbi, et, ei, parent, p, leftmost);
 	if (!en)
 		return NULL;
 
@@ -492,6 +506,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	unsigned int end = fofs + len;
 	unsigned int pos = (unsigned int)fofs;
 	bool updated = false;
+	bool leftmost;
 
 	if (!et)
 		return;
@@ -519,7 +534,8 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 					(struct rb_entry *)et->cached_en, fofs,
 					(struct rb_entry **)&prev_en,
 					(struct rb_entry **)&next_en,
-					&insert_p, &insert_parent, false);
+					&insert_p, &insert_parent, false,
+					&leftmost);
 	if (!en)
 		en = next_en;
 
@@ -546,7 +562,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 						end - dei.fofs + dei.blk,
 						org_end - end);
 				en1 = __insert_extent_tree(sbi, et, &ei,
-							NULL, NULL);
+							NULL, NULL, true);
 				next_en = en1;
 			} else {
 				en->ei.fofs = end;
@@ -587,7 +603,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 		set_extent_info(&ei, fofs, blkaddr, len);
 		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
 			__insert_extent_tree(sbi, et, &ei,
-						insert_p, insert_parent);
+					insert_p, insert_parent, leftmost);
 
 		/* give up extent_cache, if split and small updates happen */
 		if (dei.len >= 1 &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1c039965f22e..c4d30c090399 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -327,7 +327,7 @@ struct discard_cmd_control {
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
-	struct rb_root root;			/* root of discard rb-tree */
+	struct rb_root_cached root;		/* root of discard rb-tree */
 	bool rbtree_check;			/* config for consistence check */
 };
 
@@ -569,7 +569,7 @@ struct extent_node {
 
 struct extent_tree {
 	nid_t ino;			/* inode number */
-	struct rb_root root;		/* root of extent info rb-tree */
+	struct rb_root_cached root;	/* root of extent info rb-tree */
 	struct extent_node *cached_en;	/* recently accessed extent node */
 	struct extent_info largest;	/* largested extent info */
 	struct list_head list;		/* to be used by sbi->zombie_list */
@@ -3365,18 +3365,19 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
-struct rb_entry *f2fs_lookup_rb_tree(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
 				struct rb_entry *cached_re, unsigned int ofs);
 struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
-				struct rb_root *root, struct rb_node **parent,
-				unsigned int ofs);
-struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
+				struct rb_root_cached *root,
+				struct rb_node **parent,
+				unsigned int ofs, bool *leftmost);
+struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
 		struct rb_entry *cached_re, unsigned int ofs,
 		struct rb_entry **prev_entry, struct rb_entry **next_entry,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
-		bool force);
+		bool force, bool *leftmost);
 bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
-						struct rb_root *root);
+						struct rb_root_cached *root);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
 bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
 void f2fs_drop_extent_tree(struct inode *inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b3cf00348918..ef9dfa06c6c8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -897,7 +897,8 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len,
-				struct rb_node *parent, struct rb_node **p)
+				struct rb_node *parent, struct rb_node **p,
+				bool leftmost)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *dc;
@@ -905,7 +906,7 @@ static struct discard_cmd *__attach_discard_cmd(struct f2fs_sb_info *sbi,
 	dc = __create_discard_cmd(sbi, bdev, lstart, start, len);
 
 	rb_link_node(&dc->rb_node, parent, p);
-	rb_insert_color(&dc->rb_node, &dcc->root);
+	rb_insert_color_cached(&dc->rb_node, &dcc->root, leftmost);
 
 	return dc;
 }
@@ -917,7 +918,7 @@ static void __detach_discard_cmd(struct discard_cmd_control *dcc,
 		atomic_sub(dc->issuing, &dcc->issing_discard);
 
 	list_del(&dc->list);
-	rb_erase(&dc->rb_node, &dcc->root);
+	rb_erase_cached(&dc->rb_node, &dcc->root);
 	dcc->undiscard_blks -= dc->len;
 
 	kmem_cache_free(discard_cmd_slab, dc);
@@ -1154,6 +1155,7 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct discard_cmd *dc = NULL;
+	bool leftmost = true;
 
 	if (insert_p && insert_parent) {
 		parent = insert_parent;
@@ -1161,9 +1163,11 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 		goto do_insert;
 	}
 
-	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
+	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent,
+							lstart, &leftmost);
 do_insert:
-	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent, p);
+	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent,
+								p, leftmost);
 	if (!dc)
 		return NULL;
 
@@ -1231,7 +1235,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 					NULL, lstart,
 					(struct rb_entry **)&prev_dc,
 					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true);
+					&insert_p, &insert_parent, true, NULL);
 	if (dc)
 		prev_dc = dc;
 
@@ -1339,7 +1343,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 					NULL, pos,
 					(struct rb_entry **)&prev_dc,
 					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true);
+					&insert_p, &insert_parent, true, NULL);
 	if (!dc)
 		dc = next_dc;
 
@@ -1971,7 +1975,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
 	dcc->next_pos = 0;
-	dcc->root = RB_ROOT;
+	dcc->root = RB_ROOT_CACHED;
 	dcc->rbtree_check = false;
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
@@ -2635,7 +2639,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 					NULL, start,
 					(struct rb_entry **)&prev_dc,
 					(struct rb_entry **)&next_dc,
-					&insert_p, &insert_parent, true);
+					&insert_p, &insert_parent, true, NULL);
 	if (!dc)
 		dc = next_dc;
 
-- 
2.18.0

