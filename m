Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D1B2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7iYv6kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D1B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeKLJT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbeKLIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF99223C8;
        Sun, 11 Nov 2018 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975434;
        bh=8Yat/2EzjQOKqWOknIMO0J5KNCi+qgLRWHIMjWimoyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7iYv6kjr1Zqls8cA5HGI2vW+EazrneV3eWyMHOViwxjf1QBl0Y4Ox8dFXZj47bVL
         LNcpyLM+2xIKn24k4BN6S6dAbRV1gwKmkK2Uh2UXy2EmShuQWPA84+sXrzFlESZlI6
         S6b7SqlkluwJCP5zWSPFQSIhHfzsOtIOQGQRRFF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhikang Zhang <zhangzhikang1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 180/350] f2fs: avoid sleeping under spin_lock
Date:   Sun, 11 Nov 2018 14:20:44 -0800
Message-Id: <20181111221715.566327093@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhikang Zhang <zhangzhikang1@huawei.com>

[ Upstream commit b430f7263673eab1dc40e662ae3441a9619d16b8 ]

In the call trace below, we might sleep in function dput().

So in order to avoid sleeping under spin_lock, we remove f2fs_mark_inode_dirty_sync
from __try_update_largest_extent && __drop_largest_extent.

BUG: sleeping function called from invalid context at fs/dcache.c:796
Call trace:
	dump_backtrace+0x0/0x3f4
	show_stack+0x24/0x30
	dump_stack+0xe0/0x138
	___might_sleep+0x2a8/0x2c8
	__might_sleep+0x78/0x10c
	dput+0x7c/0x750
	block_dump___mark_inode_dirty+0x120/0x17c
	__mark_inode_dirty+0x344/0x11f0
	f2fs_mark_inode_dirty_sync+0x40/0x50
	__insert_extent_tree+0x2e0/0x2f4
	f2fs_update_extent_tree_range+0xcf4/0xde8
	f2fs_update_extent_cache+0x114/0x12c
	f2fs_update_data_blkaddr+0x40/0x50
	write_data_page+0x150/0x314
	do_write_data_page+0x648/0x2318
	__write_data_page+0xdb4/0x1640
	f2fs_write_cache_pages+0x768/0xafc
	__f2fs_write_data_pages+0x590/0x1218
	f2fs_write_data_pages+0x64/0x74
	do_writepages+0x74/0xe4
	__writeback_single_inode+0xdc/0x15f0
	writeback_sb_inodes+0x574/0xc98
	__writeback_inodes_wb+0x190/0x204
	wb_writeback+0x730/0xf14
	wb_check_old_data_flush+0x1bc/0x1c8
	wb_workfn+0x554/0xf74
	process_one_work+0x440/0x118c
	worker_thread+0xac/0x974
	kthread+0x1a0/0x1c8
	ret_from_fork+0x10/0x1c

Signed-off-by: Zhikang Zhang <zhangzhikang1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/extent_cache.c |   51 ++++++++++++++++++++++++++++++-------------------
 fs/f2fs/f2fs.h         |    7 +++---
 2 files changed, 36 insertions(+), 22 deletions(-)

--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -308,14 +308,13 @@ static unsigned int __free_extent_tree(s
 	return count - atomic_read(&et->node_cnt);
 }
 
-static void __drop_largest_extent(struct inode *inode,
+static void __drop_largest_extent(struct extent_tree *et,
 					pgoff_t fofs, unsigned int len)
 {
-	struct extent_info *largest = &F2FS_I(inode)->extent_tree->largest;
-
-	if (fofs < largest->fofs + largest->len && fofs + len > largest->fofs) {
-		largest->len = 0;
-		f2fs_mark_inode_dirty_sync(inode, true);
+	if (fofs < et->largest.fofs + et->largest.len &&
+			fofs + len > et->largest.fofs) {
+		et->largest.len = 0;
+		et->largest_updated = true;
 	}
 }
 
@@ -416,12 +415,11 @@ out:
 	return ret;
 }
 
-static struct extent_node *__try_merge_extent_node(struct inode *inode,
+static struct extent_node *__try_merge_extent_node(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct extent_node *prev_ex,
 				struct extent_node *next_ex)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_node *en = NULL;
 
 	if (prev_ex && __is_back_mergeable(ei, &prev_ex->ei)) {
@@ -443,7 +441,7 @@ static struct extent_node *__try_merge_e
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(inode, et, en);
+	__try_update_largest_extent(et, en);
 
 	spin_lock(&sbi->extent_lock);
 	if (!list_empty(&en->list)) {
@@ -454,12 +452,11 @@ static struct extent_node *__try_merge_e
 	return en;
 }
 
-static struct extent_node *__insert_extent_tree(struct inode *inode,
+static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
 				struct extent_tree *et, struct extent_info *ei,
 				struct rb_node **insert_p,
 				struct rb_node *insert_parent)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
@@ -476,7 +473,7 @@ do_insert:
 	if (!en)
 		return NULL;
 
-	__try_update_largest_extent(inode, et, en);
+	__try_update_largest_extent(et, en);
 
 	/* update in global extent list */
 	spin_lock(&sbi->extent_lock);
@@ -497,6 +494,7 @@ static void f2fs_update_extent_tree_rang
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	unsigned int end = fofs + len;
 	unsigned int pos = (unsigned int)fofs;
+	bool updated = false;
 
 	if (!et)
 		return;
@@ -517,7 +515,7 @@ static void f2fs_update_extent_tree_rang
 	 * drop largest extent before lookup, in case it's already
 	 * been shrunk from extent tree
 	 */
-	__drop_largest_extent(inode, fofs, len);
+	__drop_largest_extent(et, fofs, len);
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
 	en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
@@ -550,7 +548,7 @@ static void f2fs_update_extent_tree_rang
 				set_extent_info(&ei, end,
 						end - dei.fofs + dei.blk,
 						org_end - end);
-				en1 = __insert_extent_tree(inode, et, &ei,
+				en1 = __insert_extent_tree(sbi, et, &ei,
 							NULL, NULL);
 				next_en = en1;
 			} else {
@@ -570,7 +568,7 @@ static void f2fs_update_extent_tree_rang
 		}
 
 		if (parts)
-			__try_update_largest_extent(inode, et, en);
+			__try_update_largest_extent(et, en);
 		else
 			__release_extent_node(sbi, et, en);
 
@@ -590,15 +588,16 @@ static void f2fs_update_extent_tree_rang
 	if (blkaddr) {
 
 		set_extent_info(&ei, fofs, blkaddr, len);
-		if (!__try_merge_extent_node(inode, et, &ei, prev_en, next_en))
-			__insert_extent_tree(inode, et, &ei,
+		if (!__try_merge_extent_node(sbi, et, &ei, prev_en, next_en))
+			__insert_extent_tree(sbi, et, &ei,
 						insert_p, insert_parent);
 
 		/* give up extent_cache, if split and small updates happen */
 		if (dei.len >= 1 &&
 				prev.len < F2FS_MIN_EXTENT_LEN &&
 				et->largest.len < F2FS_MIN_EXTENT_LEN) {
-			__drop_largest_extent(inode, 0, UINT_MAX);
+			et->largest.len = 0;
+			et->largest_updated = true;
 			set_inode_flag(inode, FI_NO_EXTENT);
 		}
 	}
@@ -606,7 +605,15 @@ static void f2fs_update_extent_tree_rang
 	if (is_inode_flag_set(inode, FI_NO_EXTENT))
 		__free_extent_tree(sbi, et);
 
+	if (et->largest_updated) {
+		et->largest_updated = false;
+		updated = true;
+	}
+
 	write_unlock(&et->lock);
+
+	if (updated)
+		f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
@@ -705,6 +712,7 @@ void f2fs_drop_extent_tree(struct inode
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
+	bool updated = false;
 
 	if (!f2fs_may_extent_tree(inode))
 		return;
@@ -713,8 +721,13 @@ void f2fs_drop_extent_tree(struct inode
 
 	write_lock(&et->lock);
 	__free_extent_tree(sbi, et);
-	__drop_largest_extent(inode, 0, UINT_MAX);
+	if (et->largest.len) {
+		et->largest.len = 0;
+		updated = true;
+	}
 	write_unlock(&et->lock);
+	if (updated)
+		f2fs_mark_inode_dirty_sync(inode, true);
 }
 
 void f2fs_destroy_extent_tree(struct inode *inode)
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -556,6 +556,7 @@ struct extent_tree {
 	struct list_head list;		/* to be used by sbi->zombie_list */
 	rwlock_t lock;			/* protect extent info rb-tree */
 	atomic_t node_cnt;		/* # of extent node in rb-tree*/
+	bool largest_updated;		/* largest extent updated */
 };
 
 /*
@@ -736,12 +737,12 @@ static inline bool __is_front_mergeable(
 }
 
 extern void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync);
-static inline void __try_update_largest_extent(struct inode *inode,
-			struct extent_tree *et, struct extent_node *en)
+static inline void __try_update_largest_extent(struct extent_tree *et,
+						struct extent_node *en)
 {
 	if (en->ei.len > et->largest.len) {
 		et->largest = en->ei;
-		f2fs_mark_inode_dirty_sync(inode, true);
+		et->largest_updated = true;
 	}
 }
 


