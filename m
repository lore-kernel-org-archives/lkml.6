Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeFEJpJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:45:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751498AbeFEJpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:45:08 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RESEND] f2fs: introduce and spread verify_blkaddr
Date: Tue, 5 Jun 2018 17:44:11 +0800
Message-ID: <20180605094411.16002-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces verify_blkaddr to check meta/data block address
with valid range to detect bug earlier.

In addition, once we encounter an invalid blkaddr, notice user to run
fsck to fix, and let the kernel panic.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 10 ++++++++--
 fs/f2fs/data.c       |  8 ++++----
 fs/f2fs/f2fs.h       | 33 +++++++++++++++++++++++++++++----
 fs/f2fs/file.c       |  9 +++++----
 fs/f2fs/inode.c      |  7 ++++---
 fs/f2fs/node.c       |  4 ++--
 fs/f2fs/recovery.c   |  6 +++---
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    |  8 +++-----
 9 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9624a8f7254b..9910a1ad3c68 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -119,7 +119,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
-bool f2fs_is_valid_meta_blkaddr(struct f2fs_sb_info *sbi,
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
 	switch (type) {
@@ -140,10 +140,16 @@ bool f2fs_is_valid_meta_blkaddr(struct f2fs_sb_info *sbi,
 			return false;
 		break;
 	case META_POR:
+	case DATA_GENERIC:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi)))
 			return false;
 		break;
+	case META_GENERIC:
+		if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
+			blkaddr >= MAIN_BLKADDR(sbi)))
+			return false;
+		break;
 	default:
 		BUG();
 	}
@@ -176,7 +182,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!f2fs_is_valid_meta_blkaddr(sbi, blkno, type))
+		if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8f931d699287..71ab85193403 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -485,7 +485,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		spin_unlock(&io->io_lock);
 	}
 
-	if (is_valid_blkaddr(fio->old_blkaddr))
+	if (__is_valid_data_blkaddr(fio->old_blkaddr))
 		verify_block_addr(fio, fio->old_blkaddr);
 	verify_block_addr(fio, fio->new_blkaddr);
 
@@ -1045,7 +1045,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 next_block:
 	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
-	if (!is_valid_blkaddr(blkaddr)) {
+	if (!is_valid_data_blkaddr(sbi, blkaddr)) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -1694,7 +1694,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
-		if (is_valid_blkaddr(fio->old_blkaddr)) {
+		if (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr)) {
 			ipu_force = true;
 			fio->need_lock = LOCK_DONE;
 			goto got_it;
@@ -1721,7 +1721,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (is_valid_blkaddr(fio->old_blkaddr) &&
+	if (ipu_force || (is_valid_data_blkaddr(fio->sbi, fio->old_blkaddr) &&
 					need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 656fe4bd16d5..6b7facf8d93e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -194,7 +194,7 @@ struct cp_control {
 };
 
 /*
- * For CP/NAT/SIT/SSA readahead
+ * indicate meta/data type
  */
 enum {
 	META_CP,
@@ -202,6 +202,8 @@ enum {
 	META_SIT,
 	META_SSA,
 	META_POR,
+	DATA_GENERIC,
+	META_GENERIC,
 };
 
 /* for the list of ino */
@@ -2668,13 +2670,36 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_unlock(&sbi->iostat_lock);
 }
 
-static inline bool is_valid_blkaddr(block_t blkaddr)
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type);
+void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
+static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
+{
+	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"invalid blkaddr: %u, type: %d, run fsck to fix.",
+			blkaddr, type);
+		f2fs_bug_on(sbi, 1);
+	}
+}
+
+static inline bool __is_valid_data_blkaddr(block_t blkaddr)
 {
 	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
 		return false;
 	return true;
 }
 
+static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
+						block_t blkaddr)
+{
+	if (!__is_valid_data_blkaddr(blkaddr))
+		return false;
+	verify_blkaddr(sbi, blkaddr, DATA_GENERIC);
+	return true;
+}
+
 /*
  * file.c
  */
@@ -2898,8 +2923,8 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
 struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
-bool f2fs_is_valid_meta_blkaddr(struct f2fs_sb_info *sbi,
-			block_t blkaddr, int type);
+bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type);
 int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 13f2f6845e87..f3166c9663a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -350,13 +350,13 @@ static pgoff_t __get_first_dirty_index(struct address_space *mapping,
 	return pgofs;
 }
 
-static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
-							int whence)
+static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
+				pgoff_t dirty, pgoff_t pgofs, int whence)
 {
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			is_valid_blkaddr(blkaddr))
+			is_valid_data_blkaddr(sbi, blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
@@ -420,7 +420,8 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 			blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
 
-			if (__found_offset(blkaddr, dirty, pgofs, whence)) {
+			if (__found_offset(F2FS_I_SB(inode), blkaddr, dirty,
+							pgofs, whence)) {
 				f2fs_put_dnode(&dn);
 				goto found;
 			}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 30a777369d2b..e2f7d8581037 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -68,11 +68,12 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 	}
 }
 
-static bool __written_first_block(struct f2fs_inode *ri)
+static bool __written_first_block(struct f2fs_sb_info *sbi,
+					struct f2fs_inode *ri)
 {
 	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
 
-	if (is_valid_blkaddr(addr))
+	if (is_valid_data_blkaddr(sbi, addr))
 		return true;
 	return false;
 }
@@ -275,7 +276,7 @@ static int do_read_inode(struct inode *inode)
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
-	if (__written_first_block(ri))
+	if (__written_first_block(sbi, ri))
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 47d0e64a95a8..4a3311be4003 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -371,7 +371,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, is_valid_blkaddr(nat_get_blkaddr(e)) &&
+	f2fs_bug_on(sbi, is_valid_data_blkaddr(sbi, nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -382,7 +382,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (!is_valid_blkaddr(new_blkaddr))
+	if (!is_valid_data_blkaddr(sbi, new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 38f25f0b193a..3051a5e5dfc7 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -252,7 +252,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!f2fs_is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = f2fs_get_tmp_page(sbi, blkaddr);
@@ -507,7 +507,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (f2fs_is_valid_meta_blkaddr(sbi, dest, META_POR)) {
+		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = f2fs_reserve_new_block(&dn);
@@ -568,7 +568,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!f2fs_is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		f2fs_ra_meta_pages_cond(sbi, blkaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 97a471e9782a..957226707cb2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1931,7 +1931,7 @@ bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (!is_valid_blkaddr(blkaddr))
+	if (!is_valid_data_blkaddr(sbi, blkaddr))
 		return true;
 
 	down_read(&sit_i->sentry_lock);
@@ -3004,7 +3004,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct page *cpage;
 
-	if (!is_valid_blkaddr(blkaddr))
+	if (!is_valid_data_blkaddr(sbi, blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f18fc82fbe99..a7460da9af43 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -85,7 +85,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((!is_valid_blkaddr(blk_addr)) ?			\
+	((!is_valid_data_blkaddr(sbi, blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
@@ -647,11 +647,9 @@ static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
 
 	if (PAGE_TYPE_OF_BIO(fio->type) == META &&
 				(!is_read_io(fio->op) || fio->is_meta))
-		BUG_ON(blk_addr < SEG0_BLKADDR(sbi) ||
-				blk_addr >= MAIN_BLKADDR(sbi));
+		verify_blkaddr(sbi, blk_addr, META_GENERIC);
 	else
-		BUG_ON(blk_addr < MAIN_BLKADDR(sbi) ||
-				blk_addr >= MAX_BLKADDR(sbi));
+		verify_blkaddr(sbi, blk_addr, DATA_GENERIC);
 }
 
 /*
-- 
2.18.0.rc1
