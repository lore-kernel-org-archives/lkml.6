Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6250C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D8320866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D8320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeILKy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:54:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbeILKyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:54:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9713267DC2A3;
        Wed, 12 Sep 2018 13:51:58 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 13:51:53 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: submit cached bio to avoid endless PageWriteback
Date:   Wed, 12 Sep 2018 13:51:40 +0800
Message-ID: <20180912055140.30699-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migrating encrypted block from background GC thread, we only add
them into f2fs inner bio cache, but forget to submit the cached bio, it
may cause potential deadlock when we are waiting page writebacked, fix
it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- cover node path suggested by Jaegeuk.

 fs/f2fs/f2fs.h |  4 ++-
 fs/f2fs/gc.c   | 72 +++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/node.c | 14 +++++++---
 3 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8c8ce6b8f45a..da60e283ad1b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -523,6 +523,8 @@ enum {
 					 */
 };
 
+#define WAIT_WRITEBACK		1	/* indicate page is set dirty in GC */
+
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
 
 /* maximum retry quota flush count */
@@ -2876,7 +2878,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
-void f2fs_move_node_page(struct page *node_page, int gc_type);
+int f2fs_move_node_page(struct page *node_page, int gc_type);
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a4c1a419611d..1ee287b7b94b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -461,7 +461,7 @@ static int check_valid_map(struct f2fs_sb_info *sbi,
  * On validity, copy that node with cold status, otherwise (invalid node)
  * ignore that.
  */
-static void gc_node_segment(struct f2fs_sb_info *sbi,
+static int gc_node_segment(struct f2fs_sb_info *sbi,
 		struct f2fs_summary *sum, unsigned int segno, int gc_type)
 {
 	struct f2fs_summary *entry;
@@ -469,6 +469,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 	int off;
 	int phase = 0;
 	bool fggc = (gc_type == FG_GC);
+	int submitted = 0;
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -482,10 +483,11 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 		nid_t nid = le32_to_cpu(entry->nid);
 		struct page *node_page;
 		struct node_info ni;
+		int err;
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
-			return;
+			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -522,7 +524,9 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 			continue;
 		}
 
-		f2fs_move_node_page(node_page, gc_type);
+		err = f2fs_move_node_page(node_page, gc_type);
+		if (!err)
+			submitted++;
 		stat_inc_node_blk_count(sbi, 1, gc_type);
 	}
 
@@ -531,6 +535,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 
 	if (fggc)
 		atomic_dec(&sbi->wb_sync_req[NODE]);
+	return submitted;
 }
 
 /*
@@ -666,7 +671,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
  * Move data block via META_MAPPING while keeping locked data page.
  * This can be used to move blocks, aka LBAs, directly on disk.
  */
-static void move_data_block(struct inode *inode, block_t bidx,
+static int move_data_block(struct inode *inode, block_t bidx,
 				int gc_type, unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
@@ -685,25 +690,29 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	struct node_info ni;
 	struct page *page, *mpage;
 	block_t newaddr;
-	int err;
+	int err = 0;
 	bool lfs_mode = test_opt(fio.sbi, LFS);
 
 	/* do not read out */
 	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
 	if (!page)
-		return;
+		return -ENOMEM;
 
-	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
+	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
+		err = -ENOENT;
 		goto out;
+	}
 
 	if (f2fs_is_atomic_file(inode)) {
 		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
 		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
+		err = -EAGAIN;
 		goto out;
 	}
 
 	if (f2fs_is_pinned_file(inode)) {
 		f2fs_pin_file_control(inode, true);
+		err = -EAGAIN;
 		goto out;
 	}
 
@@ -714,6 +723,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 
 	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
 		ClearPageUptodate(page);
+		err = -ENOENT;
 		goto put_out;
 	}
 
@@ -796,6 +806,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_write(&fio);
 	if (fio.retry) {
+		err = -EAGAIN;
 		if (PageWriteback(fio.encrypted_page))
 			end_page_writeback(fio.encrypted_page);
 		goto put_page_out;
@@ -819,36 +830,46 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_put_page(page, 1);
+	return err;
 }
 
-static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
+static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 							unsigned int segno, int off)
 {
 	struct page *page;
+	int err = 0;
 
 	page = f2fs_get_lock_data_page(inode, bidx, true);
 	if (IS_ERR(page))
-		return;
+		return PTR_ERR(page);
 
-	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
+	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
+		err = -ENOENT;
 		goto out;
+	}
 
 	if (f2fs_is_atomic_file(inode)) {
 		F2FS_I(inode)->i_gc_failures[GC_FAILURE_ATOMIC]++;
 		F2FS_I_SB(inode)->skipped_atomic_files[gc_type]++;
+		err = -EAGAIN;
 		goto out;
 	}
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
 			f2fs_pin_file_control(inode, true);
+		err = -EAGAIN;
 		goto out;
 	}
 
 	if (gc_type == BG_GC) {
-		if (PageWriteback(page))
+		if (PageWriteback(page)) {
+			err = -EAGAIN;
 			goto out;
+		}
 		set_page_dirty(page);
 		set_cold_data(page);
+
+		err = WAIT_WRITEBACK;
 	} else {
 		struct f2fs_io_info fio = {
 			.sbi = F2FS_I_SB(inode),
@@ -864,7 +885,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.io_type = FS_GC_DATA_IO,
 		};
 		bool is_dirty = PageDirty(page);
-		int err;
 
 retry:
 		set_page_dirty(page);
@@ -889,6 +909,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	}
 out:
 	f2fs_put_page(page, 1);
+	return err;
 }
 
 /*
@@ -898,7 +919,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
  * If the parent node is not valid or the data block address is different,
  * the victim data block is ignored.
  */
-static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct gc_inode_list *gc_list, unsigned int segno, int gc_type)
 {
 	struct super_block *sb = sbi->sb;
@@ -906,6 +927,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	block_t start_addr;
 	int off;
 	int phase = 0;
+	int submitted = 0;
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -922,7 +944,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 		/* stop BG_GC if there is not enough free sections. */
 		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
-			return;
+			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
 			continue;
@@ -994,6 +1016,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		if (inode) {
 			struct f2fs_inode_info *fi = F2FS_I(inode);
 			bool locked = false;
+			int err;
 
 			if (S_ISREG(inode->i_mode)) {
 				if (!down_write_trylock(&fi->i_gc_rwsem[READ]))
@@ -1013,12 +1036,15 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_post_read_required(inode))
-				move_data_block(inode, start_bidx, gc_type,
-								segno, off);
+				err = move_data_block(inode, start_bidx,
+							gc_type, segno, off);
 			else
-				move_data_page(inode, start_bidx, gc_type,
+				err = move_data_page(inode, start_bidx, gc_type,
 								segno, off);
 
+			if (!err)
+				submitted++;
+
 			if (locked) {
 				up_write(&fi->i_gc_rwsem[WRITE]);
 				up_write(&fi->i_gc_rwsem[READ]);
@@ -1030,6 +1056,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 	if (++phase < 5)
 		goto next_step;
+
+	return submitted;
 }
 
 static int __get_victim(struct f2fs_sb_info *sbi, unsigned int *victim,
@@ -1057,6 +1085,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	int seg_freed = 0;
 	unsigned char type = IS_DATASEG(get_seg_entry(sbi, segno)->type) ?
 						SUM_TYPE_DATA : SUM_TYPE_NODE;
+	int submitted = 0;
 
 	/* readahead multi ssa blocks those have contiguous address */
 	if (sbi->segs_per_sec > 1)
@@ -1100,10 +1129,11 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		 *                                  - lock_page(sum_page)
 		 */
 		if (type == SUM_TYPE_NODE)
-			gc_node_segment(sbi, sum->entries, segno, gc_type);
-		else
-			gc_data_segment(sbi, sum->entries, gc_list, segno,
+			submitted += gc_node_segment(sbi, sum->entries, segno,
 								gc_type);
+		else
+			submitted += gc_data_segment(sbi, sum->entries, gc_list,
+							segno, gc_type);
 
 		stat_inc_seg_count(sbi, type, gc_type);
 
@@ -1114,7 +1144,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		f2fs_put_page(sum_page, 0);
 	}
 
-	if (gc_type == FG_GC)
+	if (submitted)
 		f2fs_submit_merged_write(sbi,
 				(type == SUM_TYPE_NODE) ? NODE : DATA);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fa2381c0bc47..5594765f4a71 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1584,8 +1584,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-void f2fs_move_node_page(struct page *node_page, int gc_type)
+int f2fs_move_node_page(struct page *node_page, int gc_type)
 {
+	int err = 0;
+
 	if (gc_type == FG_GC) {
 		struct writeback_control wbc = {
 			.sync_mode = WB_SYNC_ALL,
@@ -1597,22 +1599,28 @@ void f2fs_move_node_page(struct page *node_page, int gc_type)
 		f2fs_wait_on_page_writeback(node_page, NODE, true);
 
 		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
-		if (!clear_page_dirty_for_io(node_page))
+		if (!clear_page_dirty_for_io(node_page)) {
+			err = -EAGAIN;
 			goto out_page;
+		}
 
 		if (__write_node_page(node_page, false, NULL,
-					&wbc, false, FS_GC_NODE_IO, NULL))
+					&wbc, false, FS_GC_NODE_IO, NULL)) {
+			err = -EAGAIN;
 			unlock_page(node_page);
+		}
 		goto release_page;
 	} else {
 		/* set page dirty and write it */
 		if (!PageWriteback(node_page))
 			set_page_dirty(node_page);
+		err = WAIT_WRITEBACK;
 	}
 out_page:
 	unlock_page(node_page);
 release_page:
 	f2fs_put_page(node_page, 0);
+	return err;
 }
 
 static int f2fs_write_node_page(struct page *page,
-- 
2.18.0.rc1

