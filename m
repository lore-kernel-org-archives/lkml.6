Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933301AbeEWOZX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933174AbeEWOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:25:21 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up with is_valid_blkaddr()
Date: Wed, 23 May 2018 22:25:08 +0800
Message-Id: <20180523142509.17905-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

- rename is_valid_blkaddr() to is_valid_meta_blkaddr() for readability.
- introduce is_valid_blkaddr() for cleanup.

No logic change in this patch.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 18 +++++-------------
 fs/f2fs/f2fs.h       |  9 ++++++++-
 fs/f2fs/file.c       |  2 +-
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  5 ++---
 fs/f2fs/recovery.c   |  6 +++---
 fs/f2fs/segment.c    |  4 ++--
 fs/f2fs/segment.h    |  2 +-
 9 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 33d2da006789..e38221d96564 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -119,7 +119,7 @@ struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 	return __get_meta_page(sbi, index, false);
 }
 
-bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
@@ -175,7 +175,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!is_valid_blkaddr(sbi, blkno, type))
+		if (!is_valid_meta_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c368e651d3fd..feb4c224b305 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -428,7 +428,7 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
 		spin_unlock(&io->io_lock);
 	}
 
-	if (fio->old_blkaddr != NEW_ADDR)
+	if (is_valid_blkaddr(fio->old_blkaddr))
 		verify_block_addr(fio, fio->old_blkaddr);
 	verify_block_addr(fio, fio->new_blkaddr);
 
@@ -984,7 +984,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 next_block:
 	blkaddr = datablock_addr(dn.inode, dn.node_page, dn.ofs_in_node);
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
+	if (!is_valid_blkaddr(blkaddr)) {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
 				err = -EIO;
@@ -1619,15 +1619,6 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 	return should_update_inplace(inode, fio);
 }
 
-static inline bool valid_ipu_blkaddr(struct f2fs_io_info *fio)
-{
-	if (fio->old_blkaddr == NEW_ADDR)
-		return false;
-	if (fio->old_blkaddr == NULL_ADDR)
-		return false;
-	return true;
-}
-
 int do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
@@ -1642,7 +1633,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
 		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
 
-		if (valid_ipu_blkaddr(fio)) {
+		if (is_valid_blkaddr(fio->old_blkaddr)) {
 			ipu_force = true;
 			fio->need_lock = LOCK_DONE;
 			goto got_it;
@@ -1669,7 +1660,8 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 * If current allocation needs SSR,
 	 * it had better in-place writes for updated data.
 	 */
-	if (ipu_force || (valid_ipu_blkaddr(fio) && need_inplace_update(fio))) {
+	if (ipu_force || (is_valid_blkaddr(fio->old_blkaddr) &&
+					need_inplace_update(fio))) {
 		err = encrypt_one_page(fio);
 		if (err)
 			goto out_writepage;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 76d8de0f21a7..49cd6c30843c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2658,6 +2658,13 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	spin_unlock(&sbi->iostat_lock);
 }
 
+static inline bool is_valid_blkaddr(block_t blkaddr)
+{
+	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+		return false;
+	return true;
+}
+
 /*
  * file.c
  */
@@ -2878,7 +2885,7 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
 struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
 struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
-bool is_valid_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
+bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
 int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
 void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index da13ea3e190a..b569c7c5db6d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -352,7 +352,7 @@ static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
 	switch (whence) {
 	case SEEK_DATA:
 		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			(blkaddr != NEW_ADDR && blkaddr != NULL_ADDR))
+			is_valid_blkaddr(blkaddr))
 			return true;
 		break;
 	case SEEK_HOLE:
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 4b9dce9029ac..ffb7e8266db9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -72,7 +72,7 @@ static bool __written_first_block(struct f2fs_inode *ri)
 {
 	block_t addr = le32_to_cpu(ri->i_addr[offset_in_addr(ri)]);
 
-	if (addr != NEW_ADDR && addr != NULL_ADDR)
+	if (is_valid_blkaddr(addr))
 		return true;
 	return false;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 62ce49984a9e..67b3e89975af 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -379,8 +379,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			new_blkaddr == NULL_ADDR);
 	f2fs_bug_on(sbi, nat_get_blkaddr(e) == NEW_ADDR &&
 			new_blkaddr == NEW_ADDR);
-	f2fs_bug_on(sbi, nat_get_blkaddr(e) != NEW_ADDR &&
-			nat_get_blkaddr(e) != NULL_ADDR &&
+	f2fs_bug_on(sbi, is_valid_blkaddr(nat_get_blkaddr(e)) &&
 			new_blkaddr == NEW_ADDR);
 
 	/* increment version no as node is removed */
@@ -391,7 +390,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 
 	/* change address */
 	nat_set_blkaddr(e, new_blkaddr);
-	if (new_blkaddr == NEW_ADDR || new_blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(new_blkaddr))
 		set_nat_flag(e, IS_CHECKPOINTED, false);
 	__set_nat_cache_dirty(nm_i, e);
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 709dd4daaf29..bb519ba2558e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -252,7 +252,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
 		page = get_tmp_page(sbi, blkaddr);
@@ -506,7 +506,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_blkaddr(sbi, dest, META_POR)) {
+		if (is_valid_meta_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
@@ -567,7 +567,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_blkaddr(sbi, blkaddr, META_POR))
+		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
 		ra_meta_pages_cond(sbi, blkaddr);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5816ab471c41..ce60378cf93c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1954,7 +1954,7 @@ bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 	struct seg_entry *se;
 	bool is_cp = false;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return true;
 
 	down_read(&sit_i->sentry_lock);
@@ -2948,7 +2948,7 @@ void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct page *cpage;
 
-	if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR)
+	if (!is_valid_blkaddr(blkaddr))
 		return;
 
 	cpage = find_lock_page(META_MAPPING(sbi), blkaddr);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index c385daabcb67..c574131ac7e1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -85,7 +85,7 @@
 	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
 
 #define GET_SEGNO(sbi, blk_addr)					\
-	((((blk_addr) == NULL_ADDR) || ((blk_addr) == NEW_ADDR)) ?	\
+	((!is_valid_blkaddr(blk_addr)) ?			\
 	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
 		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
 #define BLKS_PER_SEC(sbi)					\
-- 
2.16.2.17.g38e79b1fd
