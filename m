Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936905AbeE2QV6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935416AbeE2QVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:21:48 -0400
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: clean up symbol namespace
Date: Wed, 30 May 2018 00:20:41 +0800
Message-Id: <20180529162041.16005-3-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180529162041.16005-1-chao@kernel.org>
References: <20180529162041.16005-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Ted reported:

"Hi, I was looking at f2fs's sources recently, and I noticed that there
is a very large number of non-static symbols which don't have a f2fs
prefix.  There's well over a hundred (see attached below).

As one example, in fs/f2fs/dir.c there is:

unsigned char get_de_type(struct f2fs_dir_entry *de)

This function is clearly only useful for f2fs, but it has a generic
name.  This means that if any other file system tries to have the same
symbol name, there will be a symbol conflict and the kernel would not
successfully build.  It also means that when someone is looking f2fs
sources, it's not at all obvious whether a function such as
read_data_page(), invalidate_blocks(), is a generic kernel function
found in the fs, mm, or block layers, or a f2fs specific function.

You might want to fix this at some point.  Hopefully Kent's bcachefs
isn't similarly using genericly named functions, since that might
cause conflicts with f2fs's functions --- but just as this would be a
problem that we would rightly insist that Kent fix, this is something
that we should have rightly insisted that f2fs should have fixed
before it was integrated into the mainline kernel.

acquire_orphan_inode
add_ino_entry
add_orphan_inode
allocate_data_block
allocate_new_segments
alloc_nid
alloc_nid_done
alloc_nid_failed
available_free_memory
...."

This patch adds "f2fs_" prefix for all non-static symbols in order to:
a) avoid conflict with other kernel generic symbols;
b) to indicate the function is f2fs specific one instead of generic
one;

Reported-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c   | 126 ++++++++++-----------
 fs/f2fs/data.c         | 115 +++++++++----------
 fs/f2fs/dir.c          |  62 +++++------
 fs/f2fs/extent_cache.c |  22 ++--
 fs/f2fs/f2fs.h         | 297 +++++++++++++++++++++++++------------------------
 fs/f2fs/file.c         | 136 +++++++++++-----------
 fs/f2fs/gc.c           |  60 +++++-----
 fs/f2fs/inline.c       |  69 ++++++------
 fs/f2fs/inode.c        |  52 ++++-----
 fs/f2fs/namei.c        |  51 ++++-----
 fs/f2fs/node.c         | 223 +++++++++++++++++++------------------
 fs/f2fs/recovery.c     |  61 +++++-----
 fs/f2fs/segment.c      | 206 +++++++++++++++++-----------------
 fs/f2fs/shrinker.c     |   4 +-
 fs/f2fs/super.c        |  94 ++++++++--------
 fs/f2fs/sysfs.c        |   4 +-
 fs/f2fs/xattr.c        |  26 ++---
 17 files changed, 819 insertions(+), 789 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index e38221d96564..078c2d5c5b2e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -36,7 +36,7 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io)
 /*
  * We guarantee no failure on the returned page.
  */
-struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
+struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
 	struct page *page = NULL;
@@ -108,18 +108,19 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 	return page;
 }
 
-struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
+struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	return __get_meta_page(sbi, index, true);
 }
 
 /* for POR only */
-struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
+struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	return __get_meta_page(sbi, index, false);
 }
 
-bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
+bool f2fs_is_valid_meta_blkaddr(struct f2fs_sb_info *sbi,
+					block_t blkaddr, int type)
 {
 	switch (type) {
 	case META_NAT:
@@ -153,7 +154,7 @@ bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type)
 /*
  * Readahead CP/NAT/SIT/SSA pages
  */
-int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
+int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 							int type, bool sync)
 {
 	struct page *page;
@@ -175,7 +176,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	blk_start_plug(&plug);
 	for (; nrpages-- > 0; blkno++) {
 
-		if (!is_valid_meta_blkaddr(sbi, blkno, type))
+		if (!f2fs_is_valid_meta_blkaddr(sbi, blkno, type))
 			goto out;
 
 		switch (type) {
@@ -219,7 +220,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 	return blkno - start;
 }
 
-void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
+void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
 {
 	struct page *page;
 	bool readahead = false;
@@ -230,7 +231,7 @@ void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
 	f2fs_put_page(page, 0);
 
 	if (readahead)
-		ra_meta_pages(sbi, index, BIO_MAX_PAGES, META_POR, true);
+		f2fs_ra_meta_pages(sbi, index, BIO_MAX_PAGES, META_POR, true);
 }
 
 static int __f2fs_write_meta_page(struct page *page,
@@ -251,7 +252,7 @@ static int __f2fs_write_meta_page(struct page *page,
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
 		goto redirty_out;
 
-	write_meta_page(sbi, page, io_type);
+	f2fs_do_write_meta_page(sbi, page, io_type);
 	dec_page_count(sbi, F2FS_DIRTY_META);
 
 	if (wbc->for_reclaim)
@@ -296,7 +297,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 
 	trace_f2fs_writepages(mapping->host, wbc, META);
 	diff = nr_pages_to_write(sbi, META, wbc);
-	written = sync_meta_pages(sbi, META, wbc->nr_to_write, FS_META_IO);
+	written = f2fs_sync_meta_pages(sbi, META, wbc->nr_to_write, FS_META_IO);
 	mutex_unlock(&sbi->cp_mutex);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - written - diff);
 	return 0;
@@ -307,7 +308,7 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 	return 0;
 }
 
-long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
+long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
@@ -457,20 +458,20 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
-void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* add new dirty ino entry into list */
 	__add_ino_entry(sbi, ino, 0, type);
 }
 
-void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
+void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
 	/* remove dirty ino entry from list */
 	__remove_ino_entry(sbi, ino, type);
 }
 
 /* mode should be APPEND_INO or UPDATE_INO */
-bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
+bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 {
 	struct inode_management *im = &sbi->im[mode];
 	struct ino_entry *e;
@@ -481,7 +482,7 @@ bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 	return e ? true : false;
 }
 
-void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
+void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 {
 	struct ino_entry *e, *tmp;
 	int i;
@@ -500,13 +501,13 @@ void release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	}
 }
 
-void set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+void f2fs_set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type)
 {
 	__add_ino_entry(sbi, ino, devidx, type);
 }
 
-bool is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type)
 {
 	struct inode_management *im = &sbi->im[type];
@@ -521,7 +522,7 @@ bool is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 	return is_dirty;
 }
 
-int acquire_orphan_inode(struct f2fs_sb_info *sbi)
+int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
 {
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
 	int err = 0;
@@ -544,7 +545,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void release_orphan_inode(struct f2fs_sb_info *sbi)
+void f2fs_release_orphan_inode(struct f2fs_sb_info *sbi)
 {
 	struct inode_management *im = &sbi->im[ORPHAN_INO];
 
@@ -554,14 +555,14 @@ void release_orphan_inode(struct f2fs_sb_info *sbi)
 	spin_unlock(&im->ino_lock);
 }
 
-void add_orphan_inode(struct inode *inode)
+void f2fs_add_orphan_inode(struct inode *inode)
 {
 	/* add new orphan ino entry into list */
 	__add_ino_entry(F2FS_I_SB(inode), inode->i_ino, 0, ORPHAN_INO);
-	update_inode_page(inode);
+	f2fs_update_inode_page(inode);
 }
 
-void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
+void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	/* remove orphan entry from orphan list */
 	__remove_ino_entry(sbi, ino, ORPHAN_INO);
@@ -571,7 +572,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct inode *inode;
 	struct node_info ni;
-	int err = acquire_orphan_inode(sbi);
+	int err = f2fs_acquire_orphan_inode(sbi);
 
 	if (err)
 		goto err_out;
@@ -599,7 +600,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	/* truncate all the data during iput */
 	iput(inode);
 
-	get_node_info(sbi, ino, &ni);
+	f2fs_get_node_info(sbi, ino, &ni);
 
 	/* ENOMEM was fully retried in f2fs_evict_inode. */
 	if (ni.blk_addr != NULL_ADDR) {
@@ -617,7 +618,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	return err;
 }
 
-int recover_orphan_inodes(struct f2fs_sb_info *sbi)
+int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 {
 	block_t start_blk, orphan_blocks, i, j;
 	unsigned int s_flags = sbi->sb->s_flags;
@@ -645,10 +646,10 @@ int recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
 	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
 
-	ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP, true);
+	f2fs_ra_meta_pages(sbi, start_blk, orphan_blocks, META_CP, true);
 
 	for (i = 0; i < orphan_blocks; i++) {
-		struct page *page = get_meta_page(sbi, start_blk + i);
+		struct page *page = f2fs_get_meta_page(sbi, start_blk + i);
 		struct f2fs_orphan_block *orphan_blk;
 
 		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
@@ -698,7 +699,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	/* loop for each orphan inode entry and write them in Jornal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
-			page = grab_meta_page(sbi, start_blk++);
+			page = f2fs_grab_meta_page(sbi, start_blk++);
 			orphan_blk =
 				(struct f2fs_orphan_block *)page_address(page);
 			memset(orphan_blk, 0, sizeof(*orphan_blk));
@@ -740,7 +741,7 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 	size_t crc_offset = 0;
 	__u32 crc = 0;
 
-	*cp_page = get_meta_page(sbi, cp_addr);
+	*cp_page = f2fs_get_meta_page(sbi, cp_addr);
 	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
@@ -793,7 +794,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
 	return NULL;
 }
 
-int get_valid_checkpoint(struct f2fs_sb_info *sbi)
+int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp_block;
 	struct f2fs_super_block *fsb = sbi->raw_super;
@@ -837,7 +838,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
 	/* Sanity checking of checkpoint */
-	if (sanity_check_ckpt(sbi))
+	if (f2fs_sanity_check_ckpt(sbi))
 		goto free_fail_no_cp;
 
 	if (cur_page == cp1)
@@ -856,7 +857,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		void *sit_bitmap_ptr;
 		unsigned char *ckpt = (unsigned char *)sbi->ckpt;
 
-		cur_page = get_meta_page(sbi, cp_blk_no + i);
+		cur_page = f2fs_get_meta_page(sbi, cp_blk_no + i);
 		sit_bitmap_ptr = page_address(cur_page);
 		memcpy(ckpt + i * blk_size, sit_bitmap_ptr, blk_size);
 		f2fs_put_page(cur_page, 1);
@@ -901,7 +902,7 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
-void update_dirty_page(struct inode *inode, struct page *page)
+void f2fs_update_dirty_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
@@ -920,7 +921,7 @@ void update_dirty_page(struct inode *inode, struct page *page)
 	f2fs_trace_pid(page);
 }
 
-void remove_dirty_inode(struct inode *inode)
+void f2fs_remove_dirty_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
@@ -937,7 +938,7 @@ void remove_dirty_inode(struct inode *inode)
 	spin_unlock(&sbi->inode_lock[type]);
 }
 
-int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
+int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type)
 {
 	struct list_head *head;
 	struct inode *inode;
@@ -1020,7 +1021,7 @@ int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 
 			/* it's on eviction */
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
-				update_inode_page(inode);
+				f2fs_update_inode_page(inode);
 			iput(inode);
 		}
 	}
@@ -1060,7 +1061,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	/* write all the dirty dentry pages */
 	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
 		f2fs_unlock_all(sbi);
-		err = sync_dirty_inodes(sbi, DIR_INODE);
+		err = f2fs_sync_dirty_inodes(sbi, DIR_INODE);
 		if (err)
 			goto out;
 		cond_resched();
@@ -1088,7 +1089,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
-		err = sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
+		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		if (err) {
 			up_write(&sbi->node_change);
 			f2fs_unlock_all(sbi);
@@ -1182,10 +1183,10 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 
 	/*
 	 * pagevec_lookup_tag and lock_page again will take
-	 * some extra time. Therefore, update_meta_pages and
-	 * sync_meta_pages are combined in this function.
+	 * some extra time. Therefore, f2fs_update_meta_pages and
+	 * f2fs_sync_meta_pages are combined in this function.
 	 */
-	struct page *page = grab_meta_page(sbi, blk_addr);
+	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 	int err;
 
 	memcpy(page_address(page), src, PAGE_SIZE);
@@ -1223,7 +1224,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Flush all the NAT/SIT pages */
 	while (get_pages(sbi, F2FS_DIRTY_META)) {
-		sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 		if (unlikely(f2fs_cp_error(sbi)))
 			return -EIO;
 	}
@@ -1252,7 +1253,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 
 	/* 2 cp  + n data seg summary + orphan inode blocks */
-	data_sum_blocks = npages_for_summary_flush(sbi, false);
+	data_sum_blocks = f2fs_npages_for_summary_flush(sbi, false);
 	spin_lock_irqsave(&sbi->cp_lock, flags);
 	if (data_sum_blocks < NR_CURSEG_DATA_TYPE)
 		__set_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
@@ -1297,22 +1298,23 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		blk = start_blk + sbi->blocks_per_seg - nm_i->nat_bits_blocks;
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
-			update_meta_page(sbi, nm_i->nat_bits +
+			f2fs_update_meta_page(sbi, nm_i->nat_bits +
 					(i << F2FS_BLKSIZE_BITS), blk + i);
 
 		/* Flush all the NAT BITS pages */
 		while (get_pages(sbi, F2FS_DIRTY_META)) {
-			sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
+							FS_CP_META_IO);
 			if (unlikely(f2fs_cp_error(sbi)))
 				return -EIO;
 		}
 	}
 
 	/* write out checkpoint buffer at block 0 */
-	update_meta_page(sbi, ckpt, start_blk++);
+	f2fs_update_meta_page(sbi, ckpt, start_blk++);
 
 	for (i = 1; i < 1 + cp_payload_blks; i++)
-		update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
+		f2fs_update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
 							start_blk++);
 
 	if (orphan_num) {
@@ -1320,7 +1322,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		start_blk += orphan_blocks;
 	}
 
-	write_data_summaries(sbi, start_blk);
+	f2fs_write_data_summaries(sbi, start_blk);
 	start_blk += data_sum_blocks;
 
 	/* Record write statistics in the hot node summary */
@@ -1331,7 +1333,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	seg_i->journal->info.kbytes_written = cpu_to_le64(kbytes_written);
 
 	if (__remain_node_summaries(cpc->reason)) {
-		write_node_summaries(sbi, start_blk);
+		f2fs_write_node_summaries(sbi, start_blk);
 		start_blk += NR_CURSEG_NODE_TYPE;
 	}
 
@@ -1340,7 +1342,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
-	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
 
 	/* wait for previous submitted meta pages writeback */
 	wait_on_all_pages_writeback(sbi);
@@ -1357,7 +1359,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	commit_checkpoint(sbi, ckpt, start_blk);
 	wait_on_all_pages_writeback(sbi);
 
-	release_ino_entry(sbi, false);
+	f2fs_release_ino_entry(sbi, false);
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -1382,7 +1384,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 /*
  * We guarantee that this checkpoint procedure will not fail.
  */
-int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	unsigned long long ckpt_ver;
@@ -1415,7 +1417,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* this is the case of multiple fstrims without any changes */
 	if (cpc->reason & CP_DISCARD) {
-		if (!exist_trim_candidates(sbi, cpc)) {
+		if (!f2fs_exist_trim_candidates(sbi, cpc)) {
 			unblock_operations(sbi);
 			goto out;
 		}
@@ -1423,8 +1425,8 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		if (NM_I(sbi)->dirty_nat_cnt == 0 &&
 				SIT_I(sbi)->dirty_sentries == 0 &&
 				prefree_segments(sbi) == 0) {
-			flush_sit_entries(sbi, cpc);
-			clear_prefree_segments(sbi, cpc);
+			f2fs_flush_sit_entries(sbi, cpc);
+			f2fs_clear_prefree_segments(sbi, cpc);
 			unblock_operations(sbi);
 			goto out;
 		}
@@ -1439,15 +1441,15 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	ckpt->checkpoint_ver = cpu_to_le64(++ckpt_ver);
 
 	/* write cached NAT/SIT entries to NAT/SIT area */
-	flush_nat_entries(sbi, cpc);
-	flush_sit_entries(sbi, cpc);
+	f2fs_flush_nat_entries(sbi, cpc);
+	f2fs_flush_sit_entries(sbi, cpc);
 
 	/* unlock all the fs_lock[] in do_checkpoint() */
 	err = do_checkpoint(sbi, cpc);
 	if (err)
-		release_discard_addrs(sbi);
+		f2fs_release_discard_addrs(sbi);
 	else
-		clear_prefree_segments(sbi, cpc);
+		f2fs_clear_prefree_segments(sbi, cpc);
 
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
@@ -1464,7 +1466,7 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	return err;
 }
 
-void init_ino_entry_info(struct f2fs_sb_info *sbi)
+void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi)
 {
 	int i;
 
@@ -1482,7 +1484,7 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
 				F2FS_ORPHANS_PER_BLOCK;
 }
 
-int __init create_checkpoint_caches(void)
+int __init f2fs_create_checkpoint_caches(void)
 {
 	ino_entry_slab = f2fs_kmem_cache_create("f2fs_ino_entry",
 			sizeof(struct ino_entry));
@@ -1497,7 +1499,7 @@ int __init create_checkpoint_caches(void)
 	return 0;
 }
 
-void destroy_checkpoint_caches(void)
+void f2fs_destroy_checkpoint_caches(void)
 {
 	kmem_cache_destroy(ino_entry_slab);
 	kmem_cache_destroy(inode_entry_slab);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 10aa4d9a4b7c..a2e30c403ef2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -247,7 +247,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
 	} else {
 		bio->bi_end_io = f2fs_write_end_io;
 		bio->bi_private = sbi;
-		bio->bi_write_hint = io_type_to_rw_hint(sbi, type, temp);
+		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, type, temp);
 	}
 	if (wbc)
 		wbc_init_bio(wbc, bio);
@@ -604,7 +604,7 @@ static void __set_data_blkaddr(struct dnode_of_data *dn)
  *  ->node_page
  *    update block addresses in the node page
  */
-void set_data_blkaddr(struct dnode_of_data *dn)
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn)
 {
 	f2fs_wait_on_page_writeback(dn->node_page, NODE, true);
 	__set_data_blkaddr(dn);
@@ -615,12 +615,12 @@ void set_data_blkaddr(struct dnode_of_data *dn)
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	dn->data_blkaddr = blkaddr;
-	set_data_blkaddr(dn);
+	f2fs_set_data_blkaddr(dn);
 	f2fs_update_extent_cache(dn);
 }
 
 /* dn->ofs_in_node will be returned with up-to-date last block pointer */
-int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
+int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	int err;
@@ -654,12 +654,12 @@ int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 }
 
 /* Should keep dn->ofs_in_node unchanged */
-int reserve_new_block(struct dnode_of_data *dn)
+int f2fs_reserve_new_block(struct dnode_of_data *dn)
 {
 	unsigned int ofs_in_node = dn->ofs_in_node;
 	int ret;
 
-	ret = reserve_new_blocks(dn, 1);
+	ret = f2fs_reserve_new_blocks(dn, 1);
 	dn->ofs_in_node = ofs_in_node;
 	return ret;
 }
@@ -669,12 +669,12 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	bool need_put = dn->inode_page ? false : true;
 	int err;
 
-	err = get_dnode_of_data(dn, index, ALLOC_NODE);
+	err = f2fs_get_dnode_of_data(dn, index, ALLOC_NODE);
 	if (err)
 		return err;
 
 	if (dn->data_blkaddr == NULL_ADDR)
-		err = reserve_new_block(dn);
+		err = f2fs_reserve_new_block(dn);
 	if (err || need_put)
 		f2fs_put_dnode(dn);
 	return err;
@@ -693,7 +693,7 @@ int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 	return f2fs_reserve_block(dn, index);
 }
 
-struct page *get_read_data_page(struct inode *inode, pgoff_t index,
+struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 						int op_flags, bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -712,7 +712,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 	}
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
 	if (err)
 		goto put_err;
 	f2fs_put_dnode(&dn);
@@ -731,7 +731,8 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 	 * A new dentry page is allocated but not able to be written, since its
 	 * new inode page couldn't be allocated due to -ENOSPC.
 	 * In such the case, its blkaddr can be remained as NEW_ADDR.
-	 * see, f2fs_add_link -> get_new_data_page -> init_inode_metadata.
+	 * see, f2fs_add_link -> f2fs_get_new_data_page ->
+	 * f2fs_init_inode_metadata.
 	 */
 	if (dn.data_blkaddr == NEW_ADDR) {
 		zero_user_segment(page, 0, PAGE_SIZE);
@@ -751,7 +752,7 @@ struct page *get_read_data_page(struct inode *inode, pgoff_t index,
 	return ERR_PTR(err);
 }
 
-struct page *find_data_page(struct inode *inode, pgoff_t index)
+struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
@@ -761,7 +762,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index)
 		return page;
 	f2fs_put_page(page, 0);
 
-	page = get_read_data_page(inode, index, 0, false);
+	page = f2fs_get_read_data_page(inode, index, 0, false);
 	if (IS_ERR(page))
 		return page;
 
@@ -781,13 +782,13 @@ struct page *find_data_page(struct inode *inode, pgoff_t index)
  * Because, the callers, functions in dir.c and GC, should be able to know
  * whether this page exists or not.
  */
-struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
+struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 							bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
 repeat:
-	page = get_read_data_page(inode, index, 0, for_write);
+	page = f2fs_get_read_data_page(inode, index, 0, for_write);
 	if (IS_ERR(page))
 		return page;
 
@@ -813,7 +814,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
  * Note that, ipage is set only by make_empty_dir, and if any error occur,
  * ipage should be released by this function.
  */
-struct page *get_new_data_page(struct inode *inode,
+struct page *f2fs_get_new_data_page(struct inode *inode,
 		struct page *ipage, pgoff_t index, bool new_i_size)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -852,7 +853,7 @@ struct page *get_new_data_page(struct inode *inode,
 
 		/* if ipage exists, blkaddr should be NEW_ADDR */
 		f2fs_bug_on(F2FS_I_SB(inode), ipage);
-		page = get_lock_data_page(inode, index, true);
+		page = f2fs_get_lock_data_page(inode, index, true);
 		if (IS_ERR(page))
 			return page;
 	}
@@ -884,15 +885,15 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 		return err;
 
 alloc:
-	get_node_info(sbi, dn->nid, &ni);
+	f2fs_get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 
-	allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
+	f2fs_allocate_data_block(sbi, NULL, dn->data_blkaddr, &dn->data_blkaddr,
 					&sum, seg_type, NULL, false);
-	set_data_blkaddr(dn);
+	f2fs_set_data_blkaddr(dn);
 
 	/* update i_size */
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
+	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 							dn->ofs_in_node;
 	if (i_size_read(dn->inode) < ((loff_t)(fofs + 1) << PAGE_SHIFT))
 		f2fs_i_size_write(dn->inode,
@@ -930,7 +931,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (direct_io) {
-		map.m_seg_type = rw_hint_to_seg_type(iocb->ki_hint);
+		map.m_seg_type = f2fs_rw_hint_to_seg_type(iocb->ki_hint);
 		flag = f2fs_force_buffered_io(inode, WRITE) ?
 					F2FS_GET_BLOCK_PRE_AIO :
 					F2FS_GET_BLOCK_PRE_DIO;
@@ -1020,7 +1021,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, pgofs, mode);
+	err = f2fs_get_dnode_of_data(&dn, pgofs, mode);
 	if (err) {
 		if (flag == F2FS_GET_BLOCK_BMAP)
 			map->m_pblk = 0;
@@ -1028,10 +1029,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			err = 0;
 			if (map->m_next_pgofs)
 				*map->m_next_pgofs =
-					get_next_page_offset(&dn, pgofs);
+					f2fs_get_next_page_offset(&dn, pgofs);
 			if (map->m_next_extent)
 				*map->m_next_extent =
-					get_next_page_offset(&dn, pgofs);
+					f2fs_get_next_page_offset(&dn, pgofs);
 		}
 		goto unlock_out;
 	}
@@ -1117,7 +1118,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			(pgofs == end || dn.ofs_in_node == end_offset)) {
 
 		dn.ofs_in_node = ofs_in_node;
-		err = reserve_new_blocks(&dn, prealloc);
+		err = f2fs_reserve_new_blocks(&dn, prealloc);
 		if (err)
 			goto sync_out;
 
@@ -1236,7 +1237,7 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
 {
 	return __get_data_block(inode, iblock, bh_result, create,
 						F2FS_GET_BLOCK_DEFAULT, NULL,
-						rw_hint_to_seg_type(
+						f2fs_rw_hint_to_seg_type(
 							inode->i_write_hint));
 }
 
@@ -1281,7 +1282,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!page)
 			return -ENOMEM;
 
-		get_node_info(sbi, inode->i_ino, &ni);
+		f2fs_get_node_info(sbi, inode->i_ino, &ni);
 
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
@@ -1308,7 +1309,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		if (!page)
 			return -ENOMEM;
 
-		get_node_info(sbi, xnid, &ni);
+		f2fs_get_node_info(sbi, xnid, &ni);
 
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
@@ -1612,12 +1613,12 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
-	if (policy & (0x1 << F2FS_IPU_SSR) && need_SSR(sbi))
+	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_UTIL) &&
 			utilization(sbi) > SM_I(sbi)->min_ipu_util)
 		return true;
-	if (policy & (0x1 << F2FS_IPU_SSR_UTIL) && need_SSR(sbi) &&
+	if (policy & (0x1 << F2FS_IPU_SSR_UTIL) && f2fs_need_SSR(sbi) &&
 			utilization(sbi) > SM_I(sbi)->min_ipu_util)
 		return true;
 
@@ -1638,7 +1639,7 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 	return false;
 }
 
-bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
+bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 {
 	if (f2fs_is_pinned_file(inode))
 		return true;
@@ -1650,7 +1651,7 @@ bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
 	return check_inplace_update_policy(inode, fio);
 }
 
-bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
+bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -1673,13 +1674,13 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 {
 	struct inode *inode = fio->page->mapping->host;
 
-	if (should_update_outplace(inode, fio))
+	if (f2fs_should_update_outplace(inode, fio))
 		return false;
 
-	return should_update_inplace(inode, fio);
+	return f2fs_should_update_inplace(inode, fio);
 }
 
-int do_write_data_page(struct f2fs_io_info *fio)
+int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
@@ -1704,7 +1705,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
 		return -EAGAIN;
 
-	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
 		goto out;
 
@@ -1731,7 +1732,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
-		err = rewrite_data_page(fio);
+		err = f2fs_inplace_write_data(fio);
 		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
@@ -1753,7 +1754,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	ClearPageError(page);
 
 	/* LFS mode write path */
-	write_data_page(&dn, fio);
+	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(page, OPU);
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (page->index == 0)
@@ -1829,13 +1830,13 @@ static int __write_data_page(struct page *page, bool *submitted,
 	/* we should not write 0'th page having journal header */
 	if (f2fs_is_volatile_file(inode) && (!page->index ||
 			(!wbc->for_reclaim &&
-			available_free_memory(sbi, BASE_CHECK))))
+			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
 	/* Dentry blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode)) {
 		fio.need_lock = LOCK_DONE;
-		err = do_write_data_page(&fio);
+		err = f2fs_do_write_data_page(&fio);
 		goto done;
 	}
 
@@ -1854,10 +1855,10 @@ static int __write_data_page(struct page *page, bool *submitted,
 	}
 
 	if (err == -EAGAIN) {
-		err = do_write_data_page(&fio);
+		err = f2fs_do_write_data_page(&fio);
 		if (err == -EAGAIN) {
 			fio.need_lock = LOCK_REQ;
-			err = do_write_data_page(&fio);
+			err = f2fs_do_write_data_page(&fio);
 		}
 	}
 
@@ -1882,7 +1883,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 	if (wbc->for_reclaim) {
 		f2fs_submit_merged_write_cond(sbi, inode, 0, page->index, DATA);
 		clear_inode_flag(inode, FI_HOT_DATA);
-		remove_dirty_inode(inode);
+		f2fs_remove_dirty_inode(inode);
 		submitted = NULL;
 	}
 
@@ -2095,7 +2096,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 
 	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
 			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
-			available_free_memory(sbi, DIRTY_DENTS))
+			f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
 	/* skip writing during file defragment */
@@ -2121,7 +2122,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	 * to detect pending bios.
 	 */
 
-	remove_dirty_inode(inode);
+	f2fs_remove_dirty_inode(inode);
 	return ret;
 
 skip_write:
@@ -2148,7 +2149,7 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
 	if (to > i_size) {
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 		truncate_pagecache(inode, i_size);
-		truncate_blocks(inode, i_size, true);
+		f2fs_truncate_blocks(inode, i_size, true);
 		up_write(&F2FS_I(inode)->i_mmap_sem);
 	}
 }
@@ -2180,7 +2181,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	}
 restart:
 	/* check inline_data */
-	ipage = get_node_page(sbi, inode->i_ino);
+	ipage = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
 		err = PTR_ERR(ipage);
 		goto unlock_out;
@@ -2190,7 +2191,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			read_inline_data(page, ipage);
+			f2fs_do_read_inline_data(page, ipage);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
 				set_inline_node(ipage);
@@ -2208,7 +2209,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			dn.data_blkaddr = ei.blk + index - ei.fofs;
 		} else {
 			/* hole case */
-			err = get_dnode_of_data(&dn, index, LOOKUP_NODE);
+			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
 			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
 				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
@@ -2245,7 +2246,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	trace_f2fs_write_begin(inode, pos, len, flags);
 
 	if (f2fs_is_atomic_file(inode) &&
-			!available_free_memory(sbi, INMEM_PAGES)) {
+			!f2fs_available_free_memory(sbi, INMEM_PAGES)) {
 		err = -ENOMEM;
 		drop_atomic = true;
 		goto fail;
@@ -2329,7 +2330,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	f2fs_put_page(page, 1);
 	f2fs_write_failed(mapping, pos + len);
 	if (drop_atomic)
-		drop_inmem_pages_all(sbi, false);
+		f2fs_drop_inmem_pages_all(sbi, false);
 	return err;
 }
 
@@ -2451,13 +2452,13 @@ void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			dec_page_count(sbi, F2FS_DIRTY_NODES);
 		} else {
 			inode_dec_dirty_pages(inode);
-			remove_dirty_inode(inode);
+			f2fs_remove_dirty_inode(inode);
 		}
 	}
 
 	/* This is atomic written page, keep Private */
 	if (IS_ATOMIC_WRITTEN_PAGE(page))
-		return drop_inmem_page(inode, page);
+		return f2fs_drop_inmem_page(inode, page);
 
 	set_page_private(page, 0);
 	ClearPagePrivate(page);
@@ -2490,7 +2491,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
-			register_inmem_page(inode, page);
+			f2fs_register_inmem_page(inode, page);
 			return 1;
 		}
 		/*
@@ -2502,7 +2503,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 	if (!PageDirty(page)) {
 		__set_page_dirty_nobuffers(page);
-		update_dirty_page(inode, page);
+		f2fs_update_dirty_page(inode, page);
 		return 1;
 	}
 	return 0;
@@ -2598,7 +2599,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 #endif
 };
 
-void clear_radix_tree_dirty_tag(struct page *page)
+void f2fs_clear_radix_tree_dirty_tag(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	unsigned long flags;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5b6996129e29..eedfa2a13786 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -65,7 +65,7 @@ static void set_de_type(struct f2fs_dir_entry *de, umode_t mode)
 	de->file_type = f2fs_type_by_mode[(mode & S_IFMT) >> S_SHIFT];
 }
 
-unsigned char get_de_type(struct f2fs_dir_entry *de)
+unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de)
 {
 	if (de->file_type < F2FS_FT_MAX)
 		return f2fs_filetype_table[de->file_type];
@@ -97,14 +97,14 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
 	make_dentry_ptr_block(NULL, &d, dentry_blk);
-	de = find_target_dentry(fname, namehash, max_slots, &d);
+	de = f2fs_find_target_dentry(fname, namehash, max_slots, &d);
 	if (de)
 		*res_page = dentry_page;
 
 	return de;
 }
 
-struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
+struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d)
 {
@@ -171,7 +171,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 	for (; bidx < end_block; bidx++) {
 		/* no need to allocate new dentry pages to all the indices */
-		dentry_page = find_data_page(dir, bidx);
+		dentry_page = f2fs_find_data_page(dir, bidx);
 		if (IS_ERR(dentry_page)) {
 			if (PTR_ERR(dentry_page) == -ENOENT) {
 				room = true;
@@ -210,7 +210,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 	if (f2fs_has_inline_dentry(dir)) {
 		*res_page = NULL;
-		de = find_in_inline_dir(dir, fname, res_page);
+		de = f2fs_find_in_inline_dir(dir, fname, res_page);
 		goto out;
 	}
 
@@ -319,7 +319,7 @@ static void init_dent_inode(const struct qstr *name, struct page *ipage)
 	set_page_dirty(ipage);
 }
 
-void do_make_empty_dir(struct inode *inode, struct inode *parent,
+void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
 					struct f2fs_dentry_ptr *d)
 {
 	struct qstr dot = QSTR_INIT(".", 1);
@@ -340,23 +340,23 @@ static int make_empty_dir(struct inode *inode,
 	struct f2fs_dentry_ptr d;
 
 	if (f2fs_has_inline_dentry(inode))
-		return make_empty_inline_dir(inode, parent, page);
+		return f2fs_make_empty_inline_dir(inode, parent, page);
 
-	dentry_page = get_new_data_page(inode, page, 0, true);
+	dentry_page = f2fs_get_new_data_page(inode, page, 0, true);
 	if (IS_ERR(dentry_page))
 		return PTR_ERR(dentry_page);
 
 	dentry_blk = page_address(dentry_page);
 
 	make_dentry_ptr_block(NULL, &d, dentry_blk);
-	do_make_empty_dir(inode, parent, &d);
+	f2fs_do_make_empty_dir(inode, parent, &d);
 
 	set_page_dirty(dentry_page);
 	f2fs_put_page(dentry_page, 1);
 	return 0;
 }
 
-struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
+struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			const struct qstr *new_name, const struct qstr *orig_name,
 			struct page *dpage)
 {
@@ -365,7 +365,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	int err;
 
 	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
-		page = new_inode_page(inode);
+		page = f2fs_new_inode_page(inode);
 		if (IS_ERR(page))
 			return page;
 
@@ -395,7 +395,7 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 				goto put_error;
 		}
 	} else {
-		page = get_node_page(F2FS_I_SB(dir), inode->i_ino);
+		page = f2fs_get_node_page(F2FS_I_SB(dir), inode->i_ino);
 		if (IS_ERR(page))
 			return page;
 	}
@@ -418,19 +418,19 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 		 * we should remove this inode from orphan list.
 		 */
 		if (inode->i_nlink == 0)
-			remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
+			f2fs_remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
 		f2fs_i_links_write(inode, true);
 	}
 	return page;
 
 put_error:
 	clear_nlink(inode);
-	update_inode(inode, page);
+	f2fs_update_inode(inode, page);
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
 
-void update_parent_metadata(struct inode *dir, struct inode *inode,
+void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 						unsigned int current_depth)
 {
 	if (inode && is_inode_flag_set(inode, FI_NEW_INODE)) {
@@ -448,7 +448,7 @@ void update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_INC_LINK);
 }
 
-int room_for_filename(const void *bitmap, int slots, int max_slots)
+int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots)
 {
 	int bit_start = 0;
 	int zero_start, zero_end;
@@ -537,12 +537,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 				(le32_to_cpu(dentry_hash) % nbucket));
 
 	for (block = bidx; block <= (bidx + nblock - 1); block++) {
-		dentry_page = get_new_data_page(dir, NULL, block, true);
+		dentry_page = f2fs_get_new_data_page(dir, NULL, block, true);
 		if (IS_ERR(dentry_page))
 			return PTR_ERR(dentry_page);
 
 		dentry_blk = page_address(dentry_page);
-		bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
+		bit_pos = f2fs_room_for_filename(&dentry_blk->dentry_bitmap,
 						slots, NR_DENTRY_IN_BLOCK);
 		if (bit_pos < NR_DENTRY_IN_BLOCK)
 			goto add_dentry;
@@ -558,7 +558,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, new_name,
+		page = f2fs_init_inode_metadata(inode, dir, new_name,
 						orig_name, NULL);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -576,7 +576,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 		f2fs_put_page(page, 1);
 	}
 
-	update_parent_metadata(dir, inode, current_depth);
+	f2fs_update_parent_metadata(dir, inode, current_depth);
 fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
@@ -651,7 +651,7 @@ int f2fs_do_tmpfile(struct inode *inode, struct inode *dir)
 	int err = 0;
 
 	down_write(&F2FS_I(inode)->i_sem);
-	page = init_inode_metadata(inode, dir, NULL, NULL, NULL);
+	page = f2fs_init_inode_metadata(inode, dir, NULL, NULL, NULL);
 	if (IS_ERR(page)) {
 		err = PTR_ERR(page);
 		goto fail;
@@ -683,9 +683,9 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
 	up_write(&F2FS_I(inode)->i_sem);
 
 	if (inode->i_nlink == 0)
-		add_orphan_inode(inode);
+		f2fs_add_orphan_inode(inode);
 	else
-		release_orphan_inode(sbi);
+		f2fs_release_orphan_inode(sbi);
 }
 
 /*
@@ -703,7 +703,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
 
 	if (F2FS_OPTION(F2FS_I_SB(dir)).fsync_mode == FSYNC_MODE_STRICT)
-		add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
+		f2fs_add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry, page, dir, inode);
@@ -729,13 +729,13 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 		f2fs_drop_nlink(dir, inode);
 
 	if (bit_pos == NR_DENTRY_IN_BLOCK &&
-			!truncate_hole(dir, page->index, page->index + 1)) {
-		clear_radix_tree_dirty_tag(page);
+		!f2fs_truncate_hole(dir, page->index, page->index + 1)) {
+		f2fs_clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
 		ClearPagePrivate(page);
 		ClearPageUptodate(page);
 		inode_dec_dirty_pages(dir);
-		remove_dirty_inode(dir);
+		f2fs_remove_dirty_inode(dir);
 	}
 	f2fs_put_page(page, 1);
 }
@@ -752,7 +752,7 @@ bool f2fs_empty_dir(struct inode *dir)
 		return f2fs_empty_inline_dir(dir);
 
 	for (bidx = 0; bidx < nblock; bidx++) {
-		dentry_page = get_lock_data_page(dir, bidx, false);
+		dentry_page = f2fs_get_lock_data_page(dir, bidx, false);
 		if (IS_ERR(dentry_page)) {
 			if (PTR_ERR(dentry_page) == -ENOENT)
 				continue;
@@ -800,7 +800,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			continue;
 		}
 
-		d_type = get_de_type(de);
+		d_type = f2fs_get_de_type(de);
 
 		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
@@ -824,7 +824,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			return 1;
 
 		if (sbi->readdir_ra == 1)
-			ra_node_page(sbi, le32_to_cpu(de->ino));
+			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
@@ -874,7 +874,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
 				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
 
-		dentry_page = get_lock_data_page(inode, n, false);
+		dentry_page = f2fs_get_lock_data_page(inode, n, false);
 		if (IS_ERR(dentry_page)) {
 			err = PTR_ERR(dentry_page);
 			if (err == -ENOENT) {
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index d5a861bf2b42..231b77ef5a53 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -49,7 +49,7 @@ static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
 	return NULL;
 }
 
-struct rb_entry *__lookup_rb_tree(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree(struct rb_root *root,
 				struct rb_entry *cached_re, unsigned int ofs)
 {
 	struct rb_entry *re;
@@ -61,7 +61,7 @@ struct rb_entry *__lookup_rb_tree(struct rb_root *root,
 	return re;
 }
 
-struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root *root, struct rb_node **parent,
 				unsigned int ofs)
 {
@@ -92,7 +92,7 @@ struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * in order to simpfy the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
-struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
 				struct rb_entry *cached_re,
 				unsigned int ofs,
 				struct rb_entry **prev_entry,
@@ -159,7 +159,7 @@ struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
 	return re;
 }
 
-bool __check_rb_tree_consistence(struct f2fs_sb_info *sbi,
+bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 						struct rb_root *root)
 {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -390,7 +390,7 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 		goto out;
 	}
 
-	en = (struct extent_node *)__lookup_rb_tree(&et->root,
+	en = (struct extent_node *)f2fs_lookup_rb_tree(&et->root,
 				(struct rb_entry *)et->cached_en, pgofs);
 	if (!en)
 		goto out;
@@ -470,7 +470,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 		goto do_insert;
 	}
 
-	p = __lookup_rb_tree_for_insert(sbi, &et->root, &parent, ei->fofs);
+	p = f2fs_lookup_rb_tree_for_insert(sbi, &et->root, &parent, ei->fofs);
 do_insert:
 	en = __attach_extent_node(sbi, et, ei, parent, p);
 	if (!en)
@@ -520,7 +520,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	__drop_largest_extent(inode, fofs, len);
 
 	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
-	en = (struct extent_node *)__lookup_rb_tree_ret(&et->root,
+	en = (struct extent_node *)f2fs_lookup_rb_tree_ret(&et->root,
 					(struct rb_entry *)et->cached_en, fofs,
 					(struct rb_entry **)&prev_en,
 					(struct rb_entry **)&next_en,
@@ -773,7 +773,7 @@ void f2fs_update_extent_cache(struct dnode_of_data *dn)
 	else
 		blkaddr = dn->data_blkaddr;
 
-	fofs = start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
+	fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page), dn->inode) +
 								dn->ofs_in_node;
 	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, 1);
 }
@@ -788,7 +788,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
 	f2fs_update_extent_tree_range(dn->inode, fofs, blkaddr, len);
 }
 
-void init_extent_cache_info(struct f2fs_sb_info *sbi)
+void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi)
 {
 	INIT_RADIX_TREE(&sbi->extent_tree_root, GFP_NOIO);
 	mutex_init(&sbi->extent_tree_lock);
@@ -800,7 +800,7 @@ void init_extent_cache_info(struct f2fs_sb_info *sbi)
 	atomic_set(&sbi->total_ext_node, 0);
 }
 
-int __init create_extent_cache(void)
+int __init f2fs_create_extent_cache(void)
 {
 	extent_tree_slab = f2fs_kmem_cache_create("f2fs_extent_tree",
 			sizeof(struct extent_tree));
@@ -815,7 +815,7 @@ int __init create_extent_cache(void)
 	return 0;
 }
 
-void destroy_extent_cache(void)
+void f2fs_destroy_extent_cache(void)
 {
 	kmem_cache_destroy(extent_node_slab);
 	kmem_cache_destroy(extent_tree_slab);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ab6f1877069f..966288314f79 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2675,14 +2675,14 @@ static inline bool is_valid_blkaddr(block_t blkaddr)
  * file.c
  */
 int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
-void truncate_data_blocks(struct dnode_of_data *dn);
-int truncate_blocks(struct inode *inode, u64 from, bool lock);
+void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
+int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
 int f2fs_getattr(const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags);
 int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
-int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
-void truncate_data_blocks_range(struct dnode_of_data *dn, int count);
+int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
+void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
 long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
@@ -2696,37 +2696,37 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
-int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
-void update_inode(struct inode *inode, struct page *node_page);
-void update_inode_page(struct inode *inode);
+int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
+void f2fs_update_inode(struct inode *inode, struct page *node_page);
+void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
 void f2fs_evict_inode(struct inode *inode);
-void handle_failed_inode(struct inode *inode);
+void f2fs_handle_failed_inode(struct inode *inode);
 
 /*
  * namei.c
  */
-int update_extension_list(struct f2fs_sb_info *sbi, const char *name,
+int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
 
 /*
  * dir.c
  */
-unsigned char get_de_type(struct f2fs_dir_entry *de);
-struct f2fs_dir_entry *find_target_dentry(struct fscrypt_name *fname,
+unsigned char f2fs_get_de_type(struct f2fs_dir_entry *de);
+struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d);
 int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
-void do_make_empty_dir(struct inode *inode, struct inode *parent,
+void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
 			struct f2fs_dentry_ptr *d);
-struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
+struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			const struct qstr *new_name,
 			const struct qstr *orig_name, struct page *dpage);
-void update_parent_metadata(struct inode *dir, struct inode *inode,
+void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			unsigned int current_depth);
-int room_for_filename(const void *bitmap, int slots, int max_slots);
+int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots);
 void f2fs_drop_nlink(struct inode *dir, struct inode *inode);
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 			struct fscrypt_name *fname, struct page **res_page);
@@ -2769,7 +2769,7 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
-int sanity_check_ckpt(struct f2fs_sb_info *sbi);
+int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
@@ -2783,141 +2783,148 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
 struct dnode_of_data;
 struct node_info;
 
-int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
-bool available_free_memory(struct f2fs_sb_info *sbi, int type);
-int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
-bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
-bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
-void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni);
-pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
-int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
-int truncate_inode_blocks(struct inode *inode, pgoff_t from);
-int truncate_xattr_node(struct inode *inode);
-int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
-int remove_inode_page(struct inode *inode);
-struct page *new_inode_page(struct inode *inode);
-struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs);
-void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
-struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
-struct page *get_node_page_ra(struct page *parent, int start);
-void move_node_page(struct page *node_page, int gc_type);
-int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
+int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
+bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
+int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
+bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
+bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
+void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
+						struct node_info *ni);
+pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
+int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
+int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
+int f2fs_truncate_xattr_node(struct inode *inode);
+int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
+int f2fs_remove_inode_page(struct inode *inode);
+struct page *f2fs_new_inode_page(struct inode *inode);
+struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
+void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
+struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
+struct page *f2fs_get_node_page_ra(struct page *parent, int start);
+void f2fs_move_node_page(struct page *node_page, int gc_type);
+int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic);
-int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
+int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
+			struct writeback_control *wbc,
 			bool do_balance, enum iostat_type io_type);
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
-void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
-void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
-int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
-void recover_inline_xattr(struct inode *inode, struct page *page);
-int recover_xattr_data(struct inode *inode, struct page *page);
-int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
-void restore_node_summary(struct f2fs_sb_info *sbi,
+void f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
+bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
+void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
+void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
+int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
+void f2fs_recover_inline_xattr(struct inode *inode, struct page *page);
+int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
+int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
+void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
-void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-int build_node_manager(struct f2fs_sb_info *sbi);
-void destroy_node_manager(struct f2fs_sb_info *sbi);
-int __init create_node_manager_caches(void);
-void destroy_node_manager_caches(void);
+void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
+void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
+int __init f2fs_create_node_manager_caches(void);
+void f2fs_destroy_node_manager_caches(void);
 
 /*
  * segment.c
  */
-bool need_SSR(struct f2fs_sb_info *sbi);
-void register_inmem_page(struct inode *inode, struct page *page);
-void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure);
-void drop_inmem_pages(struct inode *inode);
-void drop_inmem_page(struct inode *inode, struct page *page);
-int commit_inmem_pages(struct inode *inode);
+bool f2fs_need_SSR(struct f2fs_sb_info *sbi);
+void f2fs_register_inmem_page(struct inode *inode, struct page *page);
+void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure);
+void f2fs_drop_inmem_pages(struct inode *inode);
+void f2fs_drop_inmem_page(struct inode *inode, struct page *page);
+int f2fs_commit_inmem_pages(struct inode *inode);
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need);
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi);
 int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino);
-int create_flush_cmd_control(struct f2fs_sb_info *sbi);
+int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
-void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
-void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
-bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
-void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
+void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
+void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
+bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
+void f2fs_init_discard_policy(struct discard_policy *dpolicy, int discard_type,
 						unsigned int granularity);
-void drop_discard_cmd(struct f2fs_sb_info *sbi);
-void stop_discard_thread(struct f2fs_sb_info *sbi);
+void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
+void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
 bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
-void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-void release_discard_addrs(struct f2fs_sb_info *sbi);
-int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
-void allocate_new_segments(struct f2fs_sb_info *sbi);
+void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
+					struct cp_control *cpc);
+void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
+int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
+void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
-bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
-void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr);
-void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
+					struct cp_control *cpc);
+struct page *f2fs_get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno);
+void f2fs_update_meta_page(struct f2fs_sb_info *sbi, void *src,
+						block_t blk_addr);
+void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 						enum iostat_type io_type);
-void write_node_page(unsigned int nid, struct f2fs_io_info *fio);
-void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio);
-int rewrite_data_page(struct f2fs_io_info *fio);
-void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio);
+void f2fs_outplace_write_data(struct dnode_of_data *dn,
+					struct f2fs_io_info *fio);
+int f2fs_inplace_write_data(struct f2fs_io_info *fio);
+void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			block_t old_blkaddr, block_t new_blkaddr,
 			bool recover_curseg, bool recover_newaddr);
 void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
-void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio, bool add_list);
 void f2fs_wait_on_page_writeback(struct page *page,
 			enum page_type type, bool ordered);
 void f2fs_wait_on_block_writeback(struct f2fs_sb_info *sbi, block_t blkaddr);
-void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
-void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
-int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
+void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
+int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 			unsigned int val, int alloc);
-void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-int build_segment_manager(struct f2fs_sb_info *sbi);
-void destroy_segment_manager(struct f2fs_sb_info *sbi);
-int __init create_segment_manager_caches(void);
-void destroy_segment_manager_caches(void);
-int rw_hint_to_seg_type(enum rw_hint hint);
-enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi, enum page_type type,
-				enum temp_type temp);
+void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+int f2fs_build_segment_manager(struct f2fs_sb_info *sbi);
+void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
+int __init f2fs_create_segment_manager_caches(void);
+void f2fs_destroy_segment_manager_caches(void);
+int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+				enum page_type type, enum temp_type temp);
 
 /*
  * checkpoint.c
  */
 void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io);
-struct page *grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
-struct page *get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
-struct page *get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
-bool is_valid_meta_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr, int type);
-int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
+struct page *f2fs_grab_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
+struct page *f2fs_get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index);
+struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
+bool f2fs_is_valid_meta_blkaddr(struct f2fs_sb_info *sbi,
+						block_t blkaddr, int type);
+int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 			int type, bool sync);
-void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
-long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
+void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
+long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 			long nr_to_write, enum iostat_type io_type);
-void add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
-void remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
-void release_ino_entry(struct f2fs_sb_info *sbi, bool all);
-bool exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode);
-void set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
+void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
+void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all);
+bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode);
+void f2fs_set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type);
-bool is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
+bool f2fs_is_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type);
 int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi);
-int acquire_orphan_inode(struct f2fs_sb_info *sbi);
-void release_orphan_inode(struct f2fs_sb_info *sbi);
-void add_orphan_inode(struct inode *inode);
-void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
-int recover_orphan_inodes(struct f2fs_sb_info *sbi);
-int get_valid_checkpoint(struct f2fs_sb_info *sbi);
-void update_dirty_page(struct inode *inode, struct page *page);
-void remove_dirty_inode(struct inode *inode);
-int sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
-int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-void init_ino_entry_info(struct f2fs_sb_info *sbi);
-int __init create_checkpoint_caches(void);
-void destroy_checkpoint_caches(void);
+int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi);
+void f2fs_release_orphan_inode(struct f2fs_sb_info *sbi);
+void f2fs_add_orphan_inode(struct inode *inode);
+void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
+int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
+int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
+void f2fs_update_dirty_page(struct inode *inode, struct page *page);
+void f2fs_remove_dirty_inode(struct inode *inode);
+int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type);
+int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc);
+void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi);
+int __init f2fs_create_checkpoint_caches(void);
+void f2fs_destroy_checkpoint_caches(void);
 
 /*
  * data.c
@@ -2934,27 +2941,27 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio);
 struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
 			block_t blk_addr, struct bio *bio);
 int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr);
-void set_data_blkaddr(struct dnode_of_data *dn);
+void f2fs_set_data_blkaddr(struct dnode_of_data *dn);
 void f2fs_update_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr);
-int reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
-int reserve_new_block(struct dnode_of_data *dn);
+int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
+int f2fs_reserve_new_block(struct dnode_of_data *dn);
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
-struct page *get_read_data_page(struct inode *inode, pgoff_t index,
+struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 			int op_flags, bool for_write);
-struct page *find_data_page(struct inode *inode, pgoff_t index);
-struct page *get_lock_data_page(struct inode *inode, pgoff_t index,
+struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index);
+struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
 			bool for_write);
-struct page *get_new_data_page(struct inode *inode,
+struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
-int do_write_data_page(struct f2fs_io_info *fio);
+int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			int create, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
-bool should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
-bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
+bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio);
+bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio);
 void f2fs_invalidate_page(struct page *page, unsigned int offset,
 			unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
@@ -2963,23 +2970,23 @@ int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
 #endif
 bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len);
-void clear_radix_tree_dirty_tag(struct page *page);
+void f2fs_clear_radix_tree_dirty_tag(struct page *page);
 
 /*
  * gc.c
  */
-int start_gc_thread(struct f2fs_sb_info *sbi);
-void stop_gc_thread(struct f2fs_sb_info *sbi);
-block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
+int f2fs_start_gc_thread(struct f2fs_sb_info *sbi);
+void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
+block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
 			unsigned int segno);
-void build_gc_manager(struct f2fs_sb_info *sbi);
+void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
 
 /*
  * recovery.c
  */
-int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only);
-bool space_for_roll_forward(struct f2fs_sb_info *sbi);
+int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only);
+bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi);
 
 /*
  * debug.c
@@ -3191,22 +3198,24 @@ extern struct kmem_cache *inode_entry_slab;
  */
 bool f2fs_may_inline_data(struct inode *inode);
 bool f2fs_may_inline_dentry(struct inode *inode);
-void read_inline_data(struct page *page, struct page *ipage);
-void truncate_inline_inode(struct inode *inode, struct page *ipage, u64 from);
+void f2fs_do_read_inline_data(struct page *page, struct page *ipage);
+void f2fs_truncate_inline_inode(struct inode *inode,
+						struct page *ipage, u64 from);
 int f2fs_read_inline_data(struct inode *inode, struct page *page);
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page);
 int f2fs_convert_inline_inode(struct inode *inode);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
-bool recover_inline_data(struct inode *inode, struct page *npage);
-struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
+bool f2fs_recover_inline_data(struct inode *inode, struct page *npage);
+struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 			struct fscrypt_name *fname, struct page **res_page);
-int make_empty_inline_dir(struct inode *inode, struct inode *parent,
+int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 			struct page *ipage);
 int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 			const struct qstr *orig_name,
 			struct inode *inode, nid_t ino, umode_t mode);
-void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry, struct page *page,
-			struct inode *dir, struct inode *inode);
+void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
+				struct page *page, struct inode *dir,
+				struct inode *inode);
 bool f2fs_empty_inline_dir(struct inode *dir);
 int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 			struct fscrypt_str *fstr);
@@ -3227,17 +3236,17 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
-struct rb_entry *__lookup_rb_tree(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree(struct rb_root *root,
 				struct rb_entry *cached_re, unsigned int ofs);
-struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
+struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
 				struct rb_root *root, struct rb_node **parent,
 				unsigned int ofs);
-struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
+struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root *root,
 		struct rb_entry *cached_re, unsigned int ofs,
 		struct rb_entry **prev_entry, struct rb_entry **next_entry,
 		struct rb_node ***insert_p, struct rb_node **insert_parent,
 		bool force);
-bool __check_rb_tree_consistence(struct f2fs_sb_info *sbi,
+bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
 						struct rb_root *root);
 unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
 bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
@@ -3249,9 +3258,9 @@ bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
 void f2fs_update_extent_cache(struct dnode_of_data *dn);
 void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
 			pgoff_t fofs, block_t blkaddr, unsigned int len);
-void init_extent_cache_info(struct f2fs_sb_info *sbi);
-int __init create_extent_cache(void);
-void destroy_extent_cache(void);
+void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
+int __init f2fs_create_extent_cache(void);
+void f2fs_destroy_extent_cache(void);
 
 /*
  * sysfs.c
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 694ef319f979..610ecc7e3864 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -157,17 +157,18 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 		cp_reason = CP_SB_NEED_CP;
 	else if (file_wrong_pino(inode))
 		cp_reason = CP_WRONG_PINO;
-	else if (!space_for_roll_forward(sbi))
+	else if (!f2fs_space_for_roll_forward(sbi))
 		cp_reason = CP_NO_SPC_ROLL;
-	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
+	else if (!f2fs_is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
 		cp_reason = CP_NODE_NEED_CP;
 	else if (test_opt(sbi, FASTBOOT))
 		cp_reason = CP_FASTBOOT_MODE;
 	else if (F2FS_OPTION(sbi).active_logs == 2)
 		cp_reason = CP_SPEC_LOG_NUM;
 	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
-		need_dentry_mark(sbi, inode->i_ino) &&
-		exist_written_data(sbi, F2FS_I(inode)->i_pino, TRANS_DIR_INO))
+		f2fs_need_dentry_mark(sbi, inode->i_ino) &&
+		f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
+							TRANS_DIR_INO))
 		cp_reason = CP_RECOVER_DIR;
 
 	return cp_reason;
@@ -178,7 +179,7 @@ static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
 	struct page *i = find_get_page(NODE_MAPPING(sbi), ino);
 	bool ret = false;
 	/* But we need to avoid that there are some inode updates */
-	if ((i && PageDirty(i)) || need_inode_block_update(sbi, ino))
+	if ((i && PageDirty(i)) || f2fs_need_inode_block_update(sbi, ino))
 		ret = true;
 	f2fs_put_page(i, 0);
 	return ret;
@@ -238,14 +239,14 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	 * if there is no written data, don't waste time to write recovery info.
 	 */
 	if (!is_inode_flag_set(inode, FI_APPEND_WRITE) &&
-			!exist_written_data(sbi, ino, APPEND_INO)) {
+			!f2fs_exist_written_data(sbi, ino, APPEND_INO)) {
 
 		/* it may call write_inode just prior to fsync */
 		if (need_inode_page_update(sbi, ino))
 			goto go_write;
 
 		if (is_inode_flag_set(inode, FI_UPDATE_WRITE) ||
-				exist_written_data(sbi, ino, UPDATE_INO))
+				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
 	}
@@ -272,7 +273,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto out;
 	}
 sync_nodes:
-	ret = fsync_node_pages(sbi, inode, &wbc, atomic);
+	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic);
 	if (ret)
 		goto out;
 
@@ -282,7 +283,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto out;
 	}
 
-	if (need_inode_block_update(sbi, ino)) {
+	if (f2fs_need_inode_block_update(sbi, ino)) {
 		f2fs_mark_inode_dirty_sync(inode, true);
 		f2fs_write_inode(inode, NULL);
 		goto sync_nodes;
@@ -297,21 +298,21 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	 * given fsync mark.
 	 */
 	if (!atomic) {
-		ret = wait_on_node_pages_writeback(sbi, ino);
+		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
 		if (ret)
 			goto out;
 	}
 
 	/* once recovery info is written, don't need to tack this */
-	remove_ino_entry(sbi, ino, APPEND_INO);
+	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
 	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
 		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
-		remove_ino_entry(sbi, ino, UPDATE_INO);
+		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
 		clear_inode_flag(inode, FI_UPDATE_WRITE);
-		remove_ino_entry(sbi, ino, FLUSH_INO);
+		f2fs_remove_ino_entry(sbi, ino, FLUSH_INO);
 	}
 	f2fs_update_time(sbi, REQ_TIME);
 out:
@@ -392,13 +393,13 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
 		if (err && err != -ENOENT) {
 			goto fail;
 		} else if (err == -ENOENT) {
 			/* direct node does not exists */
 			if (whence == SEEK_DATA) {
-				pgofs = get_next_page_offset(&dn, pgofs);
+				pgofs = f2fs_get_next_page_offset(&dn, pgofs);
 				continue;
 			} else {
 				goto found;
@@ -486,7 +487,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	return dquot_file_open(inode, filp);
 }
 
-void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
+void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct f2fs_node *raw_node;
@@ -506,8 +507,8 @@ void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 			continue;
 
 		dn->data_blkaddr = NULL_ADDR;
-		set_data_blkaddr(dn);
-		invalidate_blocks(sbi, blkaddr);
+		f2fs_set_data_blkaddr(dn);
+		f2fs_invalidate_blocks(sbi, blkaddr);
 		if (dn->ofs_in_node == 0 && IS_INODE(dn->node_page))
 			clear_inode_flag(dn->inode, FI_FIRST_BLOCK_WRITTEN);
 		nr_free++;
@@ -519,7 +520,7 @@ void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 * once we invalidate valid blkaddr in range [ofs, ofs + count],
 		 * we will invalidate all blkaddr in the whole range.
 		 */
-		fofs = start_bidx_of_node(ofs_of_node(dn->node_page),
+		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_page),
 							dn->inode) + ofs;
 		f2fs_update_extent_cache_range(dn, fofs, 0, len);
 		dec_valid_block_count(sbi, dn->inode, nr_free);
@@ -531,9 +532,9 @@ void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 					 dn->ofs_in_node, nr_free);
 }
 
-void truncate_data_blocks(struct dnode_of_data *dn)
+void f2fs_truncate_data_blocks(struct dnode_of_data *dn)
 {
-	truncate_data_blocks_range(dn, ADDRS_PER_BLOCK);
+	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK);
 }
 
 static int truncate_partial_data_page(struct inode *inode, u64 from,
@@ -555,7 +556,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return 0;
 	}
 
-	page = get_lock_data_page(inode, index, true);
+	page = f2fs_get_lock_data_page(inode, index, true);
 	if (IS_ERR(page))
 		return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
 truncate_out:
@@ -570,7 +571,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	return 0;
 }
 
-int truncate_blocks(struct inode *inode, u64 from, bool lock)
+int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
@@ -589,21 +590,21 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	if (lock)
 		f2fs_lock_op(sbi);
 
-	ipage = get_node_page(sbi, inode->i_ino);
+	ipage = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
 		err = PTR_ERR(ipage);
 		goto out;
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		truncate_inline_inode(inode, ipage, from);
+		f2fs_truncate_inline_inode(inode, ipage, from);
 		f2fs_put_page(ipage, 1);
 		truncate_page = true;
 		goto out;
 	}
 
 	set_new_dnode(&dn, inode, ipage, NULL, 0);
-	err = get_dnode_of_data(&dn, free_from, LOOKUP_NODE_RA);
+	err = f2fs_get_dnode_of_data(&dn, free_from, LOOKUP_NODE_RA);
 	if (err) {
 		if (err == -ENOENT)
 			goto free_next;
@@ -616,13 +617,13 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 	f2fs_bug_on(sbi, count < 0);
 
 	if (dn.ofs_in_node || IS_INODE(dn.node_page)) {
-		truncate_data_blocks_range(&dn, count);
+		f2fs_truncate_data_blocks_range(&dn, count);
 		free_from += count;
 	}
 
 	f2fs_put_dnode(&dn);
 free_next:
-	err = truncate_inode_blocks(inode, free_from);
+	err = f2fs_truncate_inode_blocks(inode, free_from);
 out:
 	if (lock)
 		f2fs_unlock_op(sbi);
@@ -661,7 +662,7 @@ int f2fs_truncate(struct inode *inode)
 			return err;
 	}
 
-	err = truncate_blocks(inode, i_size_read(inode), true);
+	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
 	if (err)
 		return err;
 
@@ -850,7 +851,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-	page = get_new_data_page(inode, NULL, index, false);
+	page = f2fs_get_new_data_page(inode, NULL, index, false);
 	f2fs_unlock_op(sbi);
 
 	if (IS_ERR(page))
@@ -863,7 +864,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	return 0;
 }
 
-int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
+int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 {
 	int err;
 
@@ -872,10 +873,11 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 		pgoff_t end_offset, count;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
 		if (err) {
 			if (err == -ENOENT) {
-				pg_start = get_next_page_offset(&dn, pg_start);
+				pg_start = f2fs_get_next_page_offset(&dn,
+								pg_start);
 				continue;
 			}
 			return err;
@@ -886,7 +888,7 @@ int truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 
 		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
 
-		truncate_data_blocks_range(&dn, count);
+		f2fs_truncate_data_blocks_range(&dn, count);
 		f2fs_put_dnode(&dn);
 
 		pg_start += count;
@@ -942,7 +944,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 					blk_end - 1);
 
 			f2fs_lock_op(sbi);
-			ret = truncate_hole(inode, pg_start, pg_end);
+			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
 			f2fs_unlock_op(sbi);
 			up_write(&F2FS_I(inode)->i_mmap_sem);
 		}
@@ -960,7 +962,7 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 
 next_dnode:
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	ret = get_dnode_of_data(&dn, off, LOOKUP_NODE_RA);
+	ret = f2fs_get_dnode_of_data(&dn, off, LOOKUP_NODE_RA);
 	if (ret && ret != -ENOENT) {
 		return ret;
 	} else if (ret == -ENOENT) {
@@ -977,7 +979,7 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
 		*blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
-		if (!is_checkpointed_data(sbi, *blkaddr)) {
+		if (!f2fs_is_checkpointed_data(sbi, *blkaddr)) {
 
 			if (test_opt(sbi, LFS)) {
 				f2fs_put_dnode(&dn);
@@ -1010,10 +1012,10 @@ static int __roll_back_blkaddrs(struct inode *inode, block_t *blkaddr,
 			continue;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		ret = get_dnode_of_data(&dn, off + i, LOOKUP_NODE_RA);
+		ret = f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_NODE_RA);
 		if (ret) {
 			dec_valid_block_count(sbi, inode, 1);
-			invalidate_blocks(sbi, *blkaddr);
+			f2fs_invalidate_blocks(sbi, *blkaddr);
 		} else {
 			f2fs_update_data_blkaddr(&dn, *blkaddr);
 		}
@@ -1043,18 +1045,18 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			pgoff_t ilen;
 
 			set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
-			ret = get_dnode_of_data(&dn, dst + i, ALLOC_NODE);
+			ret = f2fs_get_dnode_of_data(&dn, dst + i, ALLOC_NODE);
 			if (ret)
 				return ret;
 
-			get_node_info(sbi, dn.nid, &ni);
+			f2fs_get_node_info(sbi, dn.nid, &ni);
 			ilen = min((pgoff_t)
 				ADDRS_PER_PAGE(dn.node_page, dst_inode) -
 						dn.ofs_in_node, len - i);
 			do {
 				dn.data_blkaddr = datablock_addr(dn.inode,
 						dn.node_page, dn.ofs_in_node);
-				truncate_data_blocks_range(&dn, 1);
+				f2fs_truncate_data_blocks_range(&dn, 1);
 
 				if (do_replace[i]) {
 					f2fs_i_blocks_write(src_inode,
@@ -1077,10 +1079,11 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 		} else {
 			struct page *psrc, *pdst;
 
-			psrc = get_lock_data_page(src_inode, src + i, true);
+			psrc = f2fs_get_lock_data_page(src_inode,
+							src + i, true);
 			if (IS_ERR(psrc))
 				return PTR_ERR(psrc);
-			pdst = get_new_data_page(dst_inode, NULL, dst + i,
+			pdst = f2fs_get_new_data_page(dst_inode, NULL, dst + i,
 								true);
 			if (IS_ERR(pdst)) {
 				f2fs_put_page(psrc, 1);
@@ -1091,7 +1094,8 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
-			ret = truncate_hole(src_inode, src + i, src + i + 1);
+			ret = f2fs_truncate_hole(src_inode,
+						src + i, src + i + 1);
 			if (ret)
 				return ret;
 			i++;
@@ -1208,7 +1212,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	new_size = i_size_read(inode) - len;
 	truncate_pagecache(inode, new_size);
 
-	ret = truncate_blocks(inode, new_size, true);
+	ret = f2fs_truncate_blocks(inode, new_size, true);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
 out_unlock:
@@ -1233,7 +1237,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 	}
 
 	dn->ofs_in_node = ofs_in_node;
-	ret = reserve_new_blocks(dn, count);
+	ret = f2fs_reserve_new_blocks(dn, count);
 	if (ret)
 		return ret;
 
@@ -1242,7 +1246,7 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 		dn->data_blkaddr = datablock_addr(dn->inode,
 					dn->node_page, dn->ofs_in_node);
 		/*
-		 * reserve_new_blocks will not guarantee entire block
+		 * f2fs_reserve_new_blocks will not guarantee entire block
 		 * allocation.
 		 */
 		if (dn->data_blkaddr == NULL_ADDR) {
@@ -1250,9 +1254,9 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 			break;
 		}
 		if (dn->data_blkaddr != NEW_ADDR) {
-			invalidate_blocks(sbi, dn->data_blkaddr);
+			f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
 			dn->data_blkaddr = NEW_ADDR;
-			set_data_blkaddr(dn);
+			f2fs_set_data_blkaddr(dn);
 		}
 	}
 
@@ -1318,7 +1322,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_lock_op(sbi);
 
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
-			ret = get_dnode_of_data(&dn, index, ALLOC_NODE);
+			ret = f2fs_get_dnode_of_data(&dn, index, ALLOC_NODE);
 			if (ret) {
 				f2fs_unlock_op(sbi);
 				goto out;
@@ -1392,7 +1396,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
 	down_write(&F2FS_I(inode)->i_mmap_sem);
-	ret = truncate_blocks(inode, i_size_read(inode), true);
+	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
 	if (ret)
 		goto out;
 
@@ -1553,7 +1557,7 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
 
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
-		drop_inmem_pages(inode);
+		f2fs_drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(inode, FI_VOLATILE_FILE);
 		stat_dec_volatile_write(inode);
@@ -1576,7 +1580,7 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	 */
 	if (f2fs_is_atomic_file(inode) &&
 			F2FS_I(inode)->inmem_task == current)
-		drop_inmem_pages(inode);
+		f2fs_drop_inmem_pages(inode);
 	return 0;
 }
 
@@ -1732,7 +1736,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	}
 
 	if (f2fs_is_atomic_file(inode)) {
-		ret = commit_inmem_pages(inode);
+		ret = f2fs_commit_inmem_pages(inode);
 		if (ret)
 			goto err_out;
 
@@ -1835,7 +1839,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	inode_lock(inode);
 
 	if (f2fs_is_atomic_file(inode))
-		drop_inmem_pages(inode);
+		f2fs_drop_inmem_pages(inode);
 	if (f2fs_is_volatile_file(inode)) {
 		clear_inode_flag(inode, FI_VOLATILE_FILE);
 		stat_dec_volatile_write(inode);
@@ -1892,7 +1896,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		f2fs_stop_checkpoint(sbi, false);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
-		sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
+		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
 		f2fs_stop_checkpoint(sbi, false);
 		break;
 	default:
@@ -1900,10 +1904,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	stop_gc_thread(sbi);
-	stop_discard_thread(sbi);
+	f2fs_stop_gc_thread(sbi);
+	f2fs_stop_discard_thread(sbi);
 
-	drop_discard_cmd(sbi);
+	f2fs_drop_discard_cmd(sbi);
 	clear_opt(sbi, DISCARD);
 
 	f2fs_update_time(sbi, REQ_TIME);
@@ -2096,7 +2100,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
+static int f2fs_ioc_f2fs_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -2134,7 +2138,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	int err;
 
 	/* if in-place-update policy is enabled, don't waste time here */
-	if (should_update_inplace(inode, NULL))
+	if (f2fs_should_update_inplace(inode, NULL))
 		return -EINVAL;
 
 	pg_start = range->start >> PAGE_SHIFT;
@@ -2229,7 +2233,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
 			struct page *page;
 
-			page = get_lock_data_page(inode, idx, true);
+			page = f2fs_get_lock_data_page(inode, idx, true);
 			if (IS_ERR(page)) {
 				err = PTR_ERR(page);
 				goto clear_out;
@@ -2569,7 +2573,7 @@ static int f2fs_ioc_setproject(struct file *filp, __u32 projid)
 	if (IS_NOQUOTA(inode))
 		goto out_unlock;
 
-	ipage = get_node_page(sbi, inode->i_ino);
+	ipage = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
 		err = PTR_ERR(ipage);
 		goto out_unlock;
@@ -2764,7 +2768,7 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (should_update_outplace(inode, NULL)) {
+	if (f2fs_should_update_outplace(inode, NULL)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -2877,7 +2881,7 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 		return f2fs_ioc_gc_range(filp, arg);
 	case F2FS_IOC_WRITE_CHECKPOINT:
-		return f2fs_ioc_write_checkpoint(filp, arg);
+		return f2fs_ioc_f2fs_write_checkpoint(filp, arg);
 	case F2FS_IOC_DEFRAGMENT:
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5e632ed27dcd..c43eb3902e62 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -114,7 +114,7 @@ static int gc_thread_func(void *data)
 	return 0;
 }
 
-int start_gc_thread(struct f2fs_sb_info *sbi)
+int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_gc_kthread *gc_th;
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
@@ -146,7 +146,7 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void stop_gc_thread(struct f2fs_sb_info *sbi)
+void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
 	if (!gc_th)
@@ -492,34 +492,34 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
 			continue;
 
 		if (phase == 0) {
-			ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
 							META_NAT, true);
 			continue;
 		}
 
 		if (phase == 1) {
-			ra_node_page(sbi, nid);
+			f2fs_ra_node_page(sbi, nid);
 			continue;
 		}
 
 		/* phase == 2 */
-		node_page = get_node_page(sbi, nid);
+		node_page = f2fs_get_node_page(sbi, nid);
 		if (IS_ERR(node_page))
 			continue;
 
-		/* block may become invalid during get_node_page */
+		/* block may become invalid during f2fs_get_node_page */
 		if (check_valid_map(sbi, segno, off) == 0) {
 			f2fs_put_page(node_page, 1);
 			continue;
 		}
 
-		get_node_info(sbi, nid, &ni);
+		f2fs_get_node_info(sbi, nid, &ni);
 		if (ni.blk_addr != start_addr + off) {
 			f2fs_put_page(node_page, 1);
 			continue;
 		}
 
-		move_node_page(node_page, gc_type);
+		f2fs_move_node_page(node_page, gc_type);
 		stat_inc_node_blk_count(sbi, 1, gc_type);
 	}
 
@@ -534,7 +534,7 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
  * as indirect or double indirect node blocks, are given, it must be a caller's
  * bug.
  */
-block_t start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
+block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 {
 	unsigned int indirect_blks = 2 * NIDS_PER_BLOCK + 4;
 	unsigned int bidx;
@@ -565,11 +565,11 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	nid = le32_to_cpu(sum->nid);
 	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
 
-	node_page = get_node_page(sbi, nid);
+	node_page = f2fs_get_node_page(sbi, nid);
 	if (IS_ERR(node_page))
 		return false;
 
-	get_node_info(sbi, nid, dni);
+	f2fs_get_node_info(sbi, nid, dni);
 
 	if (sum->version != dni->version) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
@@ -633,7 +633,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	}
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
 	if (err)
 		goto out;
 
@@ -648,7 +648,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
-	get_node_info(fio.sbi, dn.nid, &ni);
+	f2fs_get_node_info(fio.sbi, dn.nid, &ni);
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
 	/* read page */
@@ -658,7 +658,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (lfs_mode)
 		down_write(&fio.sbi->io_order_lock);
 
-	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
+	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 					&sum, CURSEG_COLD_DATA, NULL, false);
 
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
@@ -717,7 +717,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (lfs_mode)
 		up_write(&fio.sbi->io_order_lock);
 	if (err)
-		__f2fs_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
+		f2fs_do_replace_block(fio.sbi, &sum, newaddr, fio.old_blkaddr,
 								true, true);
 put_out:
 	f2fs_put_dnode(&dn);
@@ -730,7 +730,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 {
 	struct page *page;
 
-	page = get_lock_data_page(inode, bidx, true);
+	page = f2fs_get_lock_data_page(inode, bidx, true);
 	if (IS_ERR(page))
 		return;
 
@@ -775,12 +775,12 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page)) {
 			inode_dec_dirty_pages(inode);
-			remove_dirty_inode(inode);
+			f2fs_remove_dirty_inode(inode);
 		}
 
 		set_cold_data(page);
 
-		err = do_write_data_page(&fio);
+		err = f2fs_do_write_data_page(&fio);
 		if (err) {
 			clear_cold_data(page);
 			if (err == -ENOMEM) {
@@ -832,13 +832,13 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			continue;
 
 		if (phase == 0) {
-			ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
+			f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), 1,
 							META_NAT, true);
 			continue;
 		}
 
 		if (phase == 1) {
-			ra_node_page(sbi, nid);
+			f2fs_ra_node_page(sbi, nid);
 			continue;
 		}
 
@@ -847,7 +847,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			continue;
 
 		if (phase == 2) {
-			ra_node_page(sbi, dni.ino);
+			f2fs_ra_node_page(sbi, dni.ino);
 			continue;
 		}
 
@@ -870,8 +870,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				continue;
 			}
 
-			start_bidx = start_bidx_of_node(nofs, inode);
-			data_page = get_read_data_page(inode,
+			start_bidx = f2fs_start_bidx_of_node(nofs, inode);
+			data_page = f2fs_get_read_data_page(inode,
 					start_bidx + ofs_in_node, REQ_RAHEAD,
 					true);
 			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -905,7 +905,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				inode_dio_wait(inode);
 			}
 
-			start_bidx = start_bidx_of_node(nofs, inode)
+			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_post_read_required(inode))
 				move_data_block(inode, start_bidx, gc_type,
@@ -955,12 +955,12 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 	/* readahead multi ssa blocks those have contiguous address */
 	if (sbi->segs_per_sec > 1)
-		ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
+		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
 					sbi->segs_per_sec, META_SSA, true);
 
 	/* reference all summary page */
 	while (segno < end_segno) {
-		sum_page = get_sum_page(sbi, segno++);
+		sum_page = f2fs_get_sum_page(sbi, segno++);
 		unlock_page(sum_page);
 	}
 
@@ -1056,7 +1056,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		 * secure free segments which doesn't need fggc any more.
 		 */
 		if (prefree_segments(sbi)) {
-			ret = write_checkpoint(sbi, &cpc);
+			ret = f2fs_write_checkpoint(sbi, &cpc);
 			if (ret)
 				goto stop;
 		}
@@ -1093,13 +1093,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
 			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
 				skipped_round * 2 >= round)
-				drop_inmem_pages_all(sbi, true);
+				f2fs_drop_inmem_pages_all(sbi, true);
 			segno = NULL_SEGNO;
 			goto gc_more;
 		}
 
 		if (gc_type == FG_GC)
-			ret = write_checkpoint(sbi, &cpc);
+			ret = f2fs_write_checkpoint(sbi, &cpc);
 	}
 stop:
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
@@ -1123,7 +1123,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	return ret;
 }
 
-void build_gc_manager(struct f2fs_sb_info *sbi)
+void f2fs_build_gc_manager(struct f2fs_sb_info *sbi)
 {
 	DIRTY_I(sbi)->v_ops = &default_v_ops;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 83e6881fd21e..043830be5662 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -42,7 +42,7 @@ bool f2fs_may_inline_dentry(struct inode *inode)
 	return true;
 }
 
-void read_inline_data(struct page *page, struct page *ipage)
+void f2fs_do_read_inline_data(struct page *page, struct page *ipage)
 {
 	struct inode *inode = page->mapping->host;
 	void *src_addr, *dst_addr;
@@ -64,7 +64,8 @@ void read_inline_data(struct page *page, struct page *ipage)
 		SetPageUptodate(page);
 }
 
-void truncate_inline_inode(struct inode *inode, struct page *ipage, u64 from)
+void f2fs_truncate_inline_inode(struct inode *inode,
+					struct page *ipage, u64 from)
 {
 	void *addr;
 
@@ -85,7 +86,7 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 {
 	struct page *ipage;
 
-	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage)) {
 		unlock_page(page);
 		return PTR_ERR(ipage);
@@ -99,7 +100,7 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	if (page->index)
 		zero_user_segment(page, 0, PAGE_SIZE);
 	else
-		read_inline_data(page, ipage);
+		f2fs_do_read_inline_data(page, ipage);
 
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
@@ -131,7 +132,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 
 	f2fs_bug_on(F2FS_P_SB(page), PageWriteback(page));
 
-	read_inline_data(page, dn->inode_page);
+	f2fs_do_read_inline_data(page, dn->inode_page);
 	set_page_dirty(page);
 
 	/* clear dirty state */
@@ -142,18 +143,18 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	ClearPageError(page);
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
-	write_data_page(dn, &fio);
+	f2fs_outplace_write_data(dn, &fio);
 	f2fs_wait_on_page_writeback(page, DATA, true);
 	if (dirty) {
 		inode_dec_dirty_pages(dn->inode);
-		remove_dirty_inode(dn->inode);
+		f2fs_remove_dirty_inode(dn->inode);
 	}
 
 	/* this converted inline_data should be recovered. */
 	set_inode_flag(dn->inode, FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	truncate_inline_inode(dn->inode, dn->inode_page, 0);
+	f2fs_truncate_inline_inode(dn->inode, dn->inode_page, 0);
 	clear_inline_node(dn->inode_page);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
@@ -178,7 +179,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
 
 	f2fs_lock_op(sbi);
 
-	ipage = get_node_page(sbi, inode->i_ino);
+	ipage = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage)) {
 		err = PTR_ERR(ipage);
 		goto out;
@@ -207,7 +208,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	int err;
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, 0, LOOKUP_NODE);
 	if (err)
 		return err;
 
@@ -225,7 +226,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	kunmap_atomic(src_addr);
 	set_page_dirty(dn.inode_page);
 
-	clear_radix_tree_dirty_tag(page);
+	f2fs_clear_radix_tree_dirty_tag(page);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
@@ -235,7 +236,7 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	return 0;
 }
 
-bool recover_inline_data(struct inode *inode, struct page *npage)
+bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode *ri = NULL;
@@ -256,7 +257,7 @@ bool recover_inline_data(struct inode *inode, struct page *npage)
 	if (f2fs_has_inline_data(inode) &&
 			ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 process_inline:
-		ipage = get_node_page(sbi, inode->i_ino);
+		ipage = f2fs_get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
 
 		f2fs_wait_on_page_writeback(ipage, NODE, true);
@@ -274,20 +275,20 @@ bool recover_inline_data(struct inode *inode, struct page *npage)
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		ipage = get_node_page(sbi, inode->i_ino);
+		ipage = f2fs_get_node_page(sbi, inode->i_ino);
 		f2fs_bug_on(sbi, IS_ERR(ipage));
-		truncate_inline_inode(inode, ipage, 0);
+		f2fs_truncate_inline_inode(inode, ipage, 0);
 		clear_inode_flag(inode, FI_INLINE_DATA);
 		f2fs_put_page(ipage, 1);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
-		if (truncate_blocks(inode, 0, false))
+		if (f2fs_truncate_blocks(inode, 0, false))
 			return false;
 		goto process_inline;
 	}
 	return false;
 }
 
-struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
+struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 			struct fscrypt_name *fname, struct page **res_page)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
@@ -298,7 +299,7 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 	void *inline_dentry;
 	f2fs_hash_t namehash;
 
-	ipage = get_node_page(sbi, dir->i_ino);
+	ipage = f2fs_get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage)) {
 		*res_page = ipage;
 		return NULL;
@@ -309,7 +310,7 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 	inline_dentry = inline_data_addr(dir, ipage);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
-	de = find_target_dentry(fname, namehash, NULL, &d);
+	de = f2fs_find_target_dentry(fname, namehash, NULL, &d);
 	unlock_page(ipage);
 	if (de)
 		*res_page = ipage;
@@ -319,7 +320,7 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 	return de;
 }
 
-int make_empty_inline_dir(struct inode *inode, struct inode *parent,
+int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
 							struct page *ipage)
 {
 	struct f2fs_dentry_ptr d;
@@ -328,7 +329,7 @@ int make_empty_inline_dir(struct inode *inode, struct inode *parent,
 	inline_dentry = inline_data_addr(inode, ipage);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
-	do_make_empty_dir(inode, parent, &d);
+	f2fs_do_make_empty_dir(inode, parent, &d);
 
 	set_page_dirty(ipage);
 
@@ -386,7 +387,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	set_page_dirty(page);
 
 	/* clear inline dir and flag after data writeback */
-	truncate_inline_inode(dir, ipage, 0);
+	f2fs_truncate_inline_inode(dir, ipage, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
@@ -429,7 +430,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		new_name.len = le16_to_cpu(de->name_len);
 
 		ino = le32_to_cpu(de->ino);
-		fake_mode = get_de_type(de) << S_SHIFT;
+		fake_mode = f2fs_get_de_type(de) << S_SHIFT;
 
 		err = f2fs_add_regular_entry(dir, &new_name, NULL, NULL,
 							ino, fake_mode);
@@ -441,8 +442,8 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 	return 0;
 punch_dentry_pages:
 	truncate_inode_pages(&dir->i_data, 0);
-	truncate_blocks(dir, 0, false);
-	remove_dirty_inode(dir);
+	f2fs_truncate_blocks(dir, 0, false);
+	f2fs_remove_dirty_inode(dir);
 	return err;
 }
 
@@ -460,7 +461,7 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 	}
 
 	memcpy(backup_dentry, inline_dentry, MAX_INLINE_DATA(dir));
-	truncate_inline_inode(dir, ipage, 0);
+	f2fs_truncate_inline_inode(dir, ipage, 0);
 
 	unlock_page(ipage);
 
@@ -509,14 +510,14 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	struct page *page = NULL;
 	int err = 0;
 
-	ipage = get_node_page(sbi, dir->i_ino);
+	ipage = f2fs_get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
 	inline_dentry = inline_data_addr(dir, ipage);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 
-	bit_pos = room_for_filename(d.bitmap, slots, d.max);
+	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 	if (bit_pos >= d.max) {
 		err = f2fs_convert_inline_dir(dir, ipage, inline_dentry);
 		if (err)
@@ -527,7 +528,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	if (inode) {
 		down_write(&F2FS_I(inode)->i_sem);
-		page = init_inode_metadata(inode, dir, new_name,
+		page = f2fs_init_inode_metadata(inode, dir, new_name,
 						orig_name, ipage);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
@@ -548,7 +549,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 		f2fs_put_page(page, 1);
 	}
 
-	update_parent_metadata(dir, inode, 0);
+	f2fs_update_parent_metadata(dir, inode, 0);
 fail:
 	if (inode)
 		up_write(&F2FS_I(inode)->i_sem);
@@ -594,7 +595,7 @@ bool f2fs_empty_inline_dir(struct inode *dir)
 	void *inline_dentry;
 	struct f2fs_dentry_ptr d;
 
-	ipage = get_node_page(sbi, dir->i_ino);
+	ipage = f2fs_get_node_page(sbi, dir->i_ino);
 	if (IS_ERR(ipage))
 		return false;
 
@@ -625,7 +626,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (ctx->pos == d.max)
 		return 0;
 
-	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
@@ -651,7 +652,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	struct page *ipage;
 	int err = 0;
 
-	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
@@ -667,7 +668,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 		ilen = start + len;
 	ilen -= start;
 
-	get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
+	f2fs_get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
 	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ffb7e8266db9..30a777369d2b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -209,10 +209,10 @@ static int do_read_inode(struct inode *inode)
 	projid_t i_projid;
 
 	/* Check if ino is within scope */
-	if (check_nid_range(sbi, inode->i_ino))
+	if (f2fs_check_nid_range(sbi, inode->i_ino))
 		return -EINVAL;
 
-	node_page = get_node_page(sbi, inode->i_ino);
+	node_page = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(node_page))
 		return PTR_ERR(node_page);
 
@@ -278,7 +278,7 @@ static int do_read_inode(struct inode *inode)
 	if (__written_first_block(ri))
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
-	if (!need_inode_block_update(sbi, inode->i_ino))
+	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
 
 	if (fi->i_flags & F2FS_PROJINHERIT_FL)
@@ -390,7 +390,7 @@ struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 	return inode;
 }
 
-void update_inode(struct inode *inode, struct page *node_page)
+void f2fs_update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
@@ -476,12 +476,12 @@ void update_inode(struct inode *inode, struct page *node_page)
 	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
 }
 
-void update_inode_page(struct inode *inode)
+void f2fs_update_inode_page(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct page *node_page;
 retry:
-	node_page = get_node_page(sbi, inode->i_ino);
+	node_page = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(node_page)) {
 		int err = PTR_ERR(node_page);
 		if (err == -ENOMEM) {
@@ -492,7 +492,7 @@ void update_inode_page(struct inode *inode)
 		}
 		return;
 	}
-	update_inode(inode, node_page);
+	f2fs_update_inode(inode, node_page);
 	f2fs_put_page(node_page, 1);
 }
 
@@ -511,7 +511,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
-	update_inode_page(inode);
+	f2fs_update_inode_page(inode);
 	if (wbc && wbc->nr_to_write)
 		f2fs_balance_fs(sbi, true);
 	return 0;
@@ -528,7 +528,7 @@ void f2fs_evict_inode(struct inode *inode)
 
 	/* some remained atomic pages should discarded */
 	if (f2fs_is_atomic_file(inode))
-		drop_inmem_pages(inode);
+		f2fs_drop_inmem_pages(inode);
 
 	trace_f2fs_evict_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
@@ -538,7 +538,7 @@ void f2fs_evict_inode(struct inode *inode)
 		goto out_clear;
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
-	remove_dirty_inode(inode);
+	f2fs_remove_dirty_inode(inode);
 
 	f2fs_destroy_extent_tree(inode);
 
@@ -547,9 +547,9 @@ void f2fs_evict_inode(struct inode *inode)
 
 	dquot_initialize(inode);
 
-	remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
-	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
-	remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
+	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
+	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	f2fs_remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
 
 	sb_start_intwrite(inode->i_sb);
 	set_inode_flag(inode, FI_NO_ALLOC);
@@ -566,7 +566,7 @@ void f2fs_evict_inode(struct inode *inode)
 #endif
 	if (!err) {
 		f2fs_lock_op(sbi);
-		err = remove_inode_page(inode);
+		err = f2fs_remove_inode_page(inode);
 		f2fs_unlock_op(sbi);
 		if (err == -ENOENT)
 			err = 0;
@@ -579,7 +579,7 @@ void f2fs_evict_inode(struct inode *inode)
 	}
 
 	if (err)
-		update_inode_page(inode);
+		f2fs_update_inode_page(inode);
 	dquot_free_inode(inode);
 	sb_end_intwrite(inode->i_sb);
 no_delete:
@@ -602,18 +602,18 @@ void f2fs_evict_inode(struct inode *inode)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
 	if (inode->i_nlink) {
 		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
-			add_ino_entry(sbi, inode->i_ino, APPEND_INO);
+			f2fs_add_ino_entry(sbi, inode->i_ino, APPEND_INO);
 		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
-			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+			f2fs_add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	}
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
-		alloc_nid_failed(sbi, inode->i_ino);
+		f2fs_alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
 	} else {
 		/*
 		 * If xattr nid is corrupted, we can reach out error condition,
-		 * err & !exist_written_data(sbi, inode->i_ino, ORPHAN_INO)).
-		 * In that case, check_nid_range() is enough to give a clue.
+		 * err & !f2fs_exist_written_data(sbi, inode->i_ino, ORPHAN_INO)).
+		 * In that case, f2fs_check_nid_range() is enough to give a clue.
 		 */
 	}
 out_clear:
@@ -622,7 +622,7 @@ void f2fs_evict_inode(struct inode *inode)
 }
 
 /* caller should call f2fs_lock_op() */
-void handle_failed_inode(struct inode *inode)
+void f2fs_handle_failed_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct node_info ni;
@@ -637,7 +637,7 @@ void handle_failed_inode(struct inode *inode)
 	 * we must call this to avoid inode being remained as dirty, resulting
 	 * in a panic when flushing dirty inodes in gdirty_list.
 	 */
-	update_inode_page(inode);
+	f2fs_update_inode_page(inode);
 	f2fs_inode_synced(inode);
 
 	/* don't make bad inode, since it becomes a regular file. */
@@ -648,18 +648,18 @@ void handle_failed_inode(struct inode *inode)
 	 * so we can prevent losing this orphan when encoutering checkpoint
 	 * and following suddenly power-off.
 	 */
-	get_node_info(sbi, inode->i_ino, &ni);
+	f2fs_get_node_info(sbi, inode->i_ino, &ni);
 
 	if (ni.blk_addr != NULL_ADDR) {
-		int err = acquire_orphan_inode(sbi);
+		int err = f2fs_acquire_orphan_inode(sbi);
 		if (err) {
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_msg(sbi->sb, KERN_WARNING,
 				"Too many orphan inodes, run fsck to fix.");
 		} else {
-			add_orphan_inode(inode);
+			f2fs_add_orphan_inode(inode);
 		}
-		alloc_nid_done(sbi, inode->i_ino);
+		f2fs_alloc_nid_done(sbi, inode->i_ino);
 	} else {
 		set_inode_flag(inode, FI_FREE_NID);
 	}
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bcfc4219b29e..fe90202a95c1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -37,7 +37,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 		return ERR_PTR(-ENOMEM);
 
 	f2fs_lock_op(sbi);
-	if (!alloc_nid(sbi, &ino)) {
+	if (!f2fs_alloc_nid(sbi, &ino)) {
 		f2fs_unlock_op(sbi);
 		err = -ENOSPC;
 		goto fail;
@@ -196,7 +196,7 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
 	up_read(&sbi->sb_lock);
 }
 
-int update_extension_list(struct f2fs_sb_info *sbi, const char *name,
+int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set)
 {
 	__u8 (*extlist)[F2FS_EXTENSION_LEN] = sbi->raw_super->extension_list;
@@ -295,7 +295,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		goto out;
 	f2fs_unlock_op(sbi);
 
-	alloc_nid_done(sbi, ino);
+	f2fs_alloc_nid_done(sbi, ino);
 
 	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
@@ -306,7 +306,7 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	f2fs_balance_fs(sbi, true);
 	return 0;
 out:
-	handle_failed_inode(inode);
+	f2fs_handle_failed_inode(inode);
 	return err;
 }
 
@@ -524,7 +524,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-	err = acquire_orphan_inode(sbi);
+	err = f2fs_acquire_orphan_inode(sbi);
 	if (err) {
 		f2fs_unlock_op(sbi);
 		f2fs_put_page(page, 0);
@@ -589,9 +589,9 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	f2fs_lock_op(sbi);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
-		goto out_handle_failed_inode;
+		goto out_f2fs_handle_failed_inode;
 	f2fs_unlock_op(sbi);
-	alloc_nid_done(sbi, inode->i_ino);
+	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
 	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
 	if (err)
@@ -625,8 +625,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	f2fs_balance_fs(sbi, true);
 	goto out_free_encrypted_link;
 
-out_handle_failed_inode:
-	handle_failed_inode(inode);
+out_f2fs_handle_failed_inode:
+	f2fs_handle_failed_inode(inode);
 out_free_encrypted_link:
 	if (disk_link.name != (unsigned char *)symname)
 		kfree(disk_link.name);
@@ -662,7 +662,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out_fail;
 	f2fs_unlock_op(sbi);
 
-	alloc_nid_done(sbi, inode->i_ino);
+	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
 	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
@@ -675,7 +675,7 @@ static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 
 out_fail:
 	clear_inode_flag(inode, FI_INC_LINK);
-	handle_failed_inode(inode);
+	f2fs_handle_failed_inode(inode);
 	return err;
 }
 
@@ -714,7 +714,7 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 		goto out;
 	f2fs_unlock_op(sbi);
 
-	alloc_nid_done(sbi, inode->i_ino);
+	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
 	unlock_new_inode(inode);
 	d_instantiate(dentry, inode);
@@ -725,7 +725,7 @@ static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
 	f2fs_balance_fs(sbi, true);
 	return 0;
 out:
-	handle_failed_inode(inode);
+	f2fs_handle_failed_inode(inode);
 	return err;
 }
 
@@ -754,7 +754,7 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	}
 
 	f2fs_lock_op(sbi);
-	err = acquire_orphan_inode(sbi);
+	err = f2fs_acquire_orphan_inode(sbi);
 	if (err)
 		goto out;
 
@@ -766,8 +766,8 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	 * add this non-linked tmpfile to orphan list, in this way we could
 	 * remove all unused data of tmpfile after abnormal power-off.
 	 */
-	add_orphan_inode(inode);
-	alloc_nid_done(sbi, inode->i_ino);
+	f2fs_add_orphan_inode(inode);
+	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
 	if (whiteout) {
 		f2fs_i_links_write(inode, false);
@@ -783,9 +783,9 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	return 0;
 
 release_out:
-	release_orphan_inode(sbi);
+	f2fs_release_orphan_inode(sbi);
 out:
-	handle_failed_inode(inode);
+	f2fs_handle_failed_inode(inode);
 	return err;
 }
 
@@ -892,7 +892,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 		f2fs_lock_op(sbi);
 
-		err = acquire_orphan_inode(sbi);
+		err = f2fs_acquire_orphan_inode(sbi);
 		if (err)
 			goto put_out_dir;
 
@@ -906,9 +906,9 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		up_write(&F2FS_I(new_inode)->i_sem);
 
 		if (!new_inode->i_nlink)
-			add_orphan_inode(new_inode);
+			f2fs_add_orphan_inode(new_inode);
 		else
-			release_orphan_inode(sbi);
+			f2fs_release_orphan_inode(sbi);
 	} else {
 		f2fs_balance_fs(sbi, true);
 
@@ -977,9 +977,10 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, false);
 	}
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
-		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+		f2fs_add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 		if (S_ISDIR(old_inode->i_mode))
-			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
+			f2fs_add_ino_entry(sbi, old_inode->i_ino,
+							TRANS_DIR_INO);
 	}
 
 	f2fs_unlock_op(sbi);
@@ -1131,8 +1132,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_mark_inode_dirty_sync(new_dir, false);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
-		add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
+		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
+		f2fs_add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
 	}
 
 	f2fs_unlock_op(sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 59041acbf7ac..513f03d823b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -23,7 +23,7 @@
 #include "trace.h"
 #include <trace/events/f2fs.h>
 
-#define on_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
+#define on_f2fs_build_free_nids(nmi) mutex_is_locked(&(nm_i)->build_lock)
 
 static struct kmem_cache *nat_entry_slab;
 static struct kmem_cache *free_nid_slab;
@@ -32,7 +32,7 @@ static struct kmem_cache *nat_entry_set_slab;
 /*
  * Check whether the given nid is within node id range.
  */
-int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
+int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	if (unlikely(nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -44,7 +44,7 @@ int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 	return 0;
 }
 
-bool available_free_memory(struct f2fs_sb_info *sbi, int type)
+bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct sysinfo val;
@@ -103,7 +103,7 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 static void clear_node_page_dirty(struct page *page)
 {
 	if (PageDirty(page)) {
-		clear_radix_tree_dirty_tag(page);
+		f2fs_clear_radix_tree_dirty_tag(page);
 		clear_page_dirty_for_io(page);
 		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 	}
@@ -113,7 +113,7 @@ static void clear_node_page_dirty(struct page *page)
 static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	pgoff_t index = current_nat_addr(sbi, nid);
-	return get_meta_page(sbi, index);
+	return f2fs_get_meta_page(sbi, index);
 }
 
 static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
@@ -130,8 +130,8 @@ static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 	dst_off = next_nat_addr(sbi, src_off);
 
 	/* get current nat block page with lock */
-	src_page = get_meta_page(sbi, src_off);
-	dst_page = grab_meta_page(sbi, dst_off);
+	src_page = f2fs_get_meta_page(sbi, src_off);
+	dst_page = f2fs_grab_meta_page(sbi, dst_off);
 	f2fs_bug_on(sbi, PageDirty(src_page));
 
 	src_addr = page_address(src_page);
@@ -267,7 +267,7 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
+int f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
@@ -284,7 +284,7 @@ int need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 	return need;
 }
 
-bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
+bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
@@ -298,7 +298,7 @@ bool is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 	return is_cp;
 }
 
-bool need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
+bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
@@ -397,7 +397,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	up_write(&nm_i->nat_tree_lock);
 }
 
-int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
+int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int nr = nr_shrink;
@@ -419,7 +419,8 @@ int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 /*
  * This function always returns success
  */
-void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
+void f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
+						struct node_info *ni)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -449,7 +450,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 
 	/* Check current segment summary */
 	down_read(&curseg->journal_rwsem);
-	i = lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
+	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
@@ -464,7 +465,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	index = current_nat_addr(sbi, nid);
 	up_read(&nm_i->nat_tree_lock);
 
-	page = get_meta_page(sbi, index);
+	page = f2fs_get_meta_page(sbi, index);
 	nat_blk = (struct f2fs_nat_block *)page_address(page);
 	ne = nat_blk->entries[nid - start_nid];
 	node_info_from_raw_nat(ni, &ne);
@@ -477,7 +478,7 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 /*
  * readahead MAX_RA_NODE number of node pages.
  */
-static void ra_node_pages(struct page *parent, int start, int n)
+static void f2fs_ra_node_pages(struct page *parent, int start, int n)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
 	struct blk_plug plug;
@@ -491,13 +492,13 @@ static void ra_node_pages(struct page *parent, int start, int n)
 	end = min(end, NIDS_PER_BLOCK);
 	for (i = start; i < end; i++) {
 		nid = get_nid(parent, i, false);
-		ra_node_page(sbi, nid);
+		f2fs_ra_node_page(sbi, nid);
 	}
 
 	blk_finish_plug(&plug);
 }
 
-pgoff_t get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
+pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
 {
 	const long direct_index = ADDRS_PER_INODE(dn->inode);
 	const long direct_blks = ADDRS_PER_BLOCK;
@@ -612,7 +613,7 @@ static int get_node_path(struct inode *inode, long block,
  * f2fs_unlock_op() only if ro is not set RDONLY_NODE.
  * In the case of RDONLY_NODE, we don't need to care about mutex.
  */
-int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
+int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct page *npage[4];
@@ -631,7 +632,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	npage[0] = dn->inode_page;
 
 	if (!npage[0]) {
-		npage[0] = get_node_page(sbi, nids[0]);
+		npage[0] = f2fs_get_node_page(sbi, nids[0]);
 		if (IS_ERR(npage[0]))
 			return PTR_ERR(npage[0]);
 	}
@@ -655,24 +656,24 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
-			if (!alloc_nid(sbi, &(nids[i]))) {
+			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
 				err = -ENOSPC;
 				goto release_pages;
 			}
 
 			dn->nid = nids[i];
-			npage[i] = new_node_page(dn, noffset[i]);
+			npage[i] = f2fs_new_node_page(dn, noffset[i]);
 			if (IS_ERR(npage[i])) {
-				alloc_nid_failed(sbi, nids[i]);
+				f2fs_alloc_nid_failed(sbi, nids[i]);
 				err = PTR_ERR(npage[i]);
 				goto release_pages;
 			}
 
 			set_nid(parent, offset[i - 1], nids[i], i == 1);
-			alloc_nid_done(sbi, nids[i]);
+			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
-			npage[i] = get_node_page_ra(parent, offset[i - 1]);
+			npage[i] = f2fs_get_node_page_ra(parent, offset[i - 1]);
 			if (IS_ERR(npage[i])) {
 				err = PTR_ERR(npage[i]);
 				goto release_pages;
@@ -687,7 +688,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		}
 
 		if (!done) {
-			npage[i] = get_node_page(sbi, nids[i]);
+			npage[i] = f2fs_get_node_page(sbi, nids[i]);
 			if (IS_ERR(npage[i])) {
 				err = PTR_ERR(npage[i]);
 				f2fs_put_page(npage[0], 0);
@@ -726,15 +727,15 @@ static void truncate_node(struct dnode_of_data *dn)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info ni;
 
-	get_node_info(sbi, dn->nid, &ni);
+	f2fs_get_node_info(sbi, dn->nid, &ni);
 
 	/* Deallocate node address */
-	invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, dn->inode, dn->nid == dn->inode->i_ino);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
 	if (dn->nid == dn->inode->i_ino) {
-		remove_orphan_inode(sbi, dn->nid);
+		f2fs_remove_orphan_inode(sbi, dn->nid);
 		dec_valid_inode_count(sbi);
 		f2fs_inode_synced(dn->inode);
 	}
@@ -759,7 +760,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 		return 1;
 
 	/* get direct node */
-	page = get_node_page(F2FS_I_SB(dn->inode), dn->nid);
+	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
 	if (IS_ERR(page) && PTR_ERR(page) == -ENOENT)
 		return 1;
 	else if (IS_ERR(page))
@@ -768,7 +769,7 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	/* Make dnode_of_data for parameter */
 	dn->node_page = page;
 	dn->ofs_in_node = 0;
-	truncate_data_blocks(dn);
+	f2fs_truncate_data_blocks(dn);
 	truncate_node(dn);
 	return 1;
 }
@@ -789,13 +790,13 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);
 
-	page = get_node_page(F2FS_I_SB(dn->inode), dn->nid);
+	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
 	if (IS_ERR(page)) {
 		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(page));
 		return PTR_ERR(page);
 	}
 
-	ra_node_pages(page, ofs, NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(page, ofs, NIDS_PER_BLOCK);
 
 	rn = F2FS_NODE(page);
 	if (depth < 3) {
@@ -865,7 +866,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	/* get indirect nodes in the path */
 	for (i = 0; i < idx + 1; i++) {
 		/* reference count'll be increased */
-		pages[i] = get_node_page(F2FS_I_SB(dn->inode), nid[i]);
+		pages[i] = f2fs_get_node_page(F2FS_I_SB(dn->inode), nid[i]);
 		if (IS_ERR(pages[i])) {
 			err = PTR_ERR(pages[i]);
 			idx = i - 1;
@@ -874,7 +875,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 		nid[i + 1] = get_nid(pages[i], offset[i + 1], false);
 	}
 
-	ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK);
 
 	/* free direct nodes linked to a partial indirect node */
 	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
@@ -911,7 +912,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 /*
  * All the block addresses of data and nodes should be nullified.
  */
-int truncate_inode_blocks(struct inode *inode, pgoff_t from)
+int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err = 0, cont = 1;
@@ -927,7 +928,7 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	if (level < 0)
 		return level;
 
-	page = get_node_page(sbi, inode->i_ino);
+	page = f2fs_get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(page)) {
 		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(page));
 		return PTR_ERR(page);
@@ -1007,7 +1008,7 @@ int truncate_inode_blocks(struct inode *inode, pgoff_t from)
 }
 
 /* caller must lock inode page */
-int truncate_xattr_node(struct inode *inode)
+int f2fs_truncate_xattr_node(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t nid = F2FS_I(inode)->i_xattr_nid;
@@ -1017,7 +1018,7 @@ int truncate_xattr_node(struct inode *inode)
 	if (!nid)
 		return 0;
 
-	npage = get_node_page(sbi, nid);
+	npage = f2fs_get_node_page(sbi, nid);
 	if (IS_ERR(npage))
 		return PTR_ERR(npage);
 
@@ -1032,17 +1033,17 @@ int truncate_xattr_node(struct inode *inode)
  * Caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
  */
-int remove_inode_page(struct inode *inode)
+int f2fs_remove_inode_page(struct inode *inode)
 {
 	struct dnode_of_data dn;
 	int err;
 
 	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
-	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
+	err = f2fs_get_dnode_of_data(&dn, 0, LOOKUP_NODE);
 	if (err)
 		return err;
 
-	err = truncate_xattr_node(inode);
+	err = f2fs_truncate_xattr_node(inode);
 	if (err) {
 		f2fs_put_dnode(&dn);
 		return err;
@@ -1051,7 +1052,7 @@ int remove_inode_page(struct inode *inode)
 	/* remove potential inline_data blocks */
 	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
 				S_ISLNK(inode->i_mode))
-		truncate_data_blocks_range(&dn, 1);
+		f2fs_truncate_data_blocks_range(&dn, 1);
 
 	/* 0 is possible, after f2fs_new_inode() has failed */
 	f2fs_bug_on(F2FS_I_SB(inode),
@@ -1062,7 +1063,7 @@ int remove_inode_page(struct inode *inode)
 	return 0;
 }
 
-struct page *new_inode_page(struct inode *inode)
+struct page *f2fs_new_inode_page(struct inode *inode)
 {
 	struct dnode_of_data dn;
 
@@ -1070,10 +1071,10 @@ struct page *new_inode_page(struct inode *inode)
 	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
 
 	/* caller should f2fs_put_page(page, 1); */
-	return new_node_page(&dn, 0);
+	return f2fs_new_node_page(&dn, 0);
 }
 
-struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
+struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info new_ni;
@@ -1091,7 +1092,7 @@ struct page *new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		goto fail;
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	get_node_info(sbi, dn->nid, &new_ni);
+	f2fs_get_node_info(sbi, dn->nid, &new_ni);
 	f2fs_bug_on(sbi, new_ni.blk_addr != NULL_ADDR);
 #endif
 	new_ni.nid = dn->nid;
@@ -1143,7 +1144,7 @@ static int read_node_page(struct page *page, int op_flags)
 	if (PageUptodate(page))
 		return LOCKED_PAGE;
 
-	get_node_info(sbi, page->index, &ni);
+	f2fs_get_node_info(sbi, page->index, &ni);
 
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
 		ClearPageUptodate(page);
@@ -1157,14 +1158,14 @@ static int read_node_page(struct page *page, int op_flags)
 /*
  * Readahead a node page
  */
-void ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
+void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct page *apage;
 	int err;
 
 	if (!nid)
 		return;
-	if (check_nid_range(sbi, nid))
+	if (f2fs_check_nid_range(sbi, nid))
 		return;
 
 	rcu_read_lock();
@@ -1189,7 +1190,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	if (!nid)
 		return ERR_PTR(-ENOENT);
-	if (check_nid_range(sbi, nid))
+	if (f2fs_check_nid_range(sbi, nid))
 		return ERR_PTR(-EINVAL);
 repeat:
 	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), nid, false);
@@ -1206,7 +1207,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	}
 
 	if (parent)
-		ra_node_pages(parent, start + 1, MAX_RA_NODE);
+		f2fs_ra_node_pages(parent, start + 1, MAX_RA_NODE);
 
 	lock_page(page);
 
@@ -1240,12 +1241,12 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	return page;
 }
 
-struct page *get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
+struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
 	return __get_node_page(sbi, nid, NULL, 0);
 }
 
-struct page *get_node_page_ra(struct page *parent, int start)
+struct page *f2fs_get_node_page_ra(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
 	nid_t nid = get_nid(parent, start, false);
@@ -1280,7 +1281,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 
 	ret = f2fs_write_inline_data(inode, page);
 	inode_dec_dirty_pages(inode);
-	remove_dirty_inode(inode);
+	f2fs_remove_dirty_inode(inode);
 	if (ret)
 		set_page_dirty(page);
 page_out:
@@ -1384,7 +1385,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		down_read(&sbi->node_write);
 	}
 
-	get_node_info(sbi, nid, &ni);
+	f2fs_get_node_info(sbi, nid, &ni);
 
 	/* This page is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
@@ -1401,7 +1402,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	set_page_writeback(page);
 	ClearPageError(page);
 	fio.old_blkaddr = ni.blk_addr;
-	write_node_page(nid, &fio);
+	f2fs_do_write_node_page(nid, &fio);
 	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	up_read(&sbi->node_write);
@@ -1430,7 +1431,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-void move_node_page(struct page *node_page, int gc_type)
+void f2fs_move_node_page(struct page *node_page, int gc_type)
 {
 	if (gc_type == FG_GC) {
 		struct writeback_control wbc = {
@@ -1467,7 +1468,7 @@ static int f2fs_write_node_page(struct page *page,
 	return __write_node_page(page, false, NULL, wbc, false, FS_NODE_IO);
 }
 
-int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
+int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic)
 {
 	pgoff_t index;
@@ -1534,9 +1535,9 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				if (IS_INODE(page)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
-						update_inode(inode, page);
+						f2fs_update_inode(inode, page);
 					set_dentry_mark(page,
-						need_dentry_mark(sbi, ino));
+						f2fs_need_dentry_mark(sbi, ino));
 				}
 				/*  may be written by other thread */
 				if (!PageDirty(page))
@@ -1586,7 +1587,8 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	return ret ? -EIO: 0;
 }
 
-int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
+int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
+				struct writeback_control *wbc,
 				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
@@ -1687,7 +1689,7 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 	return ret;
 }
 
-int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
+int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index = 0;
 	struct pagevec pvec;
@@ -1741,7 +1743,7 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	diff = nr_pages_to_write(sbi, NODE, wbc);
 	wbc->sync_mode = WB_SYNC_NONE;
 	blk_start_plug(&plug);
-	sync_node_pages(sbi, wbc, true, FS_NODE_IO);
+	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
 	blk_finish_plug(&plug);
 	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
 	return 0;
@@ -1889,20 +1891,20 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 		 *   Thread A             Thread B
 		 *  - f2fs_create
 		 *   - f2fs_new_inode
-		 *    - alloc_nid
+		 *    - f2fs_alloc_nid
 		 *     - __insert_nid_to_list(PREALLOC_NID)
 		 *                     - f2fs_balance_fs_bg
-		 *                      - build_free_nids
-		 *                       - __build_free_nids
+		 *                      - f2fs_build_free_nids
+		 *                       - __f2fs_build_free_nids
 		 *                        - scan_nat_page
 		 *                         - add_free_nid
 		 *                          - __lookup_nat_cache
 		 *  - f2fs_add_link
-		 *   - init_inode_metadata
-		 *    - new_inode_page
-		 *     - new_node_page
+		 *   - f2fs_init_inode_metadata
+		 *    - f2fs_new_inode_page
+		 *     - f2fs_new_node_page
 		 *      - set_node_addr
-		 *  - alloc_nid_done
+		 *  - f2fs_alloc_nid_done
 		 *   - __remove_nid_from_list(PREALLOC_NID)
 		 *                         - __insert_nid_to_list(FREE_NID)
 		 */
@@ -2034,7 +2036,8 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	up_read(&nm_i->nat_tree_lock);
 }
 
-static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
+static void __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
+						bool sync, bool mount)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int i = 0;
@@ -2047,7 +2050,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
 		return;
 
-	if (!sync && !available_free_memory(sbi, FREE_NIDS))
+	if (!sync && !f2fs_available_free_memory(sbi, FREE_NIDS))
 		return;
 
 	if (!mount) {
@@ -2059,7 +2062,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 	}
 
 	/* readahead nat pages to be scanned */
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
+	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
 
 	down_read(&nm_i->nat_tree_lock);
@@ -2089,14 +2092,14 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 
 	up_read(&nm_i->nat_tree_lock);
 
-	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
+	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
 }
 
-void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
+void f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
 {
 	mutex_lock(&NM_I(sbi)->build_lock);
-	__build_free_nids(sbi, sync, mount);
+	__f2fs_build_free_nids(sbi, sync, mount);
 	mutex_unlock(&NM_I(sbi)->build_lock);
 }
 
@@ -2105,7 +2108,7 @@ void build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
  * from second parameter of this function.
  * The returned nid could be used ino as well as nid when inode is created.
  */
-bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
+bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
@@ -2123,8 +2126,8 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		return false;
 	}
 
-	/* We should not use stale free nids created by build_free_nids */
-	if (nm_i->nid_cnt[FREE_NID] && !on_build_free_nids(nm_i)) {
+	/* We should not use stale free nids created by f2fs_build_free_nids */
+	if (nm_i->nid_cnt[FREE_NID] && !on_f2fs_build_free_nids(nm_i)) {
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
@@ -2141,14 +2144,14 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	build_free_nids(sbi, true, false);
+	f2fs_build_free_nids(sbi, true, false);
 	goto retry;
 }
 
 /*
- * alloc_nid() should be called prior to this function.
+ * f2fs_alloc_nid() should be called prior to this function.
  */
-void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
+void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
@@ -2163,9 +2166,9 @@ void alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid)
 }
 
 /*
- * alloc_nid() should be called prior to this function.
+ * f2fs_alloc_nid() should be called prior to this function.
  */
-void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
+void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
@@ -2178,7 +2181,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 	i = __lookup_free_nid_list(nm_i, nid);
 	f2fs_bug_on(sbi, !i);
 
-	if (!available_free_memory(sbi, FREE_NIDS)) {
+	if (!f2fs_available_free_memory(sbi, FREE_NIDS)) {
 		__remove_free_nid(sbi, i, PREALLOC_NID);
 		need_free = true;
 	} else {
@@ -2195,7 +2198,7 @@ void alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid)
 		kmem_cache_free(free_nid_slab, i);
 }
 
-int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
+int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *next;
@@ -2223,14 +2226,14 @@ int try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink)
 	return nr - nr_shrink;
 }
 
-void recover_inline_xattr(struct inode *inode, struct page *page)
+void f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
 {
 	void *src_addr, *dst_addr;
 	size_t inline_size;
 	struct page *ipage;
 	struct f2fs_inode *ri;
 
-	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
+	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	f2fs_bug_on(F2FS_I_SB(inode), IS_ERR(ipage));
 
 	ri = F2FS_INODE(page);
@@ -2248,11 +2251,11 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
 	f2fs_wait_on_page_writeback(ipage, NODE, true);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
-	update_inode(inode, ipage);
+	f2fs_update_inode(inode, ipage);
 	f2fs_put_page(ipage, 1);
 }
 
-int recover_xattr_data(struct inode *inode, struct page *page)
+int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
@@ -2265,25 +2268,25 @@ int recover_xattr_data(struct inode *inode, struct page *page)
 		goto recover_xnid;
 
 	/* 1: invalidate the previous xattr nid */
-	get_node_info(sbi, prev_xnid, &ni);
-	invalidate_blocks(sbi, ni.blk_addr);
+	f2fs_get_node_info(sbi, prev_xnid, &ni);
+	f2fs_invalidate_blocks(sbi, ni.blk_addr);
 	dec_valid_node_count(sbi, inode, false);
 	set_node_addr(sbi, &ni, NULL_ADDR, false);
 
 recover_xnid:
 	/* 2: update xattr nid in inode */
-	if (!alloc_nid(sbi, &new_xnid))
+	if (!f2fs_alloc_nid(sbi, &new_xnid))
 		return -ENOSPC;
 
 	set_new_dnode(&dn, inode, NULL, NULL, new_xnid);
-	xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
+	xpage = f2fs_new_node_page(&dn, XATTR_NODE_OFFSET);
 	if (IS_ERR(xpage)) {
-		alloc_nid_failed(sbi, new_xnid);
+		f2fs_alloc_nid_failed(sbi, new_xnid);
 		return PTR_ERR(xpage);
 	}
 
-	alloc_nid_done(sbi, new_xnid);
-	update_inode_page(inode);
+	f2fs_alloc_nid_done(sbi, new_xnid);
+	f2fs_update_inode_page(inode);
 
 	/* 3: update and set xattr node page dirty */
 	memcpy(F2FS_NODE(xpage), F2FS_NODE(page), VALID_XATTR_BLOCK_SIZE);
@@ -2294,14 +2297,14 @@ int recover_xattr_data(struct inode *inode, struct page *page)
 	return 0;
 }
 
-int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
+int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 {
 	struct f2fs_inode *src, *dst;
 	nid_t ino = ino_of_node(page);
 	struct node_info old_ni, new_ni;
 	struct page *ipage;
 
-	get_node_info(sbi, ino, &old_ni);
+	f2fs_get_node_info(sbi, ino, &old_ni);
 
 	if (unlikely(old_ni.blk_addr != NULL_ADDR))
 		return -EINVAL;
@@ -2355,7 +2358,7 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	return 0;
 }
 
-void restore_node_summary(struct f2fs_sb_info *sbi,
+void f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
 	struct f2fs_node *rn;
@@ -2372,10 +2375,10 @@ void restore_node_summary(struct f2fs_sb_info *sbi,
 		nrpages = min(last_offset - i, BIO_MAX_PAGES);
 
 		/* readahead node pages */
-		ra_meta_pages(sbi, addr, nrpages, META_POR, true);
+		f2fs_ra_meta_pages(sbi, addr, nrpages, META_POR, true);
 
 		for (idx = addr; idx < addr + nrpages; idx++) {
-			struct page *page = get_tmp_page(sbi, idx);
+			struct page *page = f2fs_get_tmp_page(sbi, idx);
 
 			rn = F2FS_NODE(page);
 			sum_entry->nid = rn->footer.nid;
@@ -2517,7 +2520,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
 
 		if (to_journal) {
-			offset = lookup_journal_in_cursum(journal,
+			offset = f2fs_lookup_journal_in_cursum(journal,
 							NAT_JOURNAL, nid, 1);
 			f2fs_bug_on(sbi, offset < 0);
 			raw_ne = &nat_in_journal(journal, offset);
@@ -2554,7 +2557,7 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 /*
  * This function is called during the checkpointing process.
  */
-void flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
@@ -2617,7 +2620,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
 						nm_i->nat_bits_blocks;
 	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
-		struct page *page = get_meta_page(sbi, nat_bits_addr++);
+		struct page *page = f2fs_get_meta_page(sbi, nat_bits_addr++);
 
 		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
 					page_address(page), F2FS_BLKSIZE);
@@ -2760,7 +2763,7 @@ static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
-int build_node_manager(struct f2fs_sb_info *sbi)
+int f2fs_build_node_manager(struct f2fs_sb_info *sbi)
 {
 	int err;
 
@@ -2780,11 +2783,11 @@ int build_node_manager(struct f2fs_sb_info *sbi)
 	/* load free nid status from nat_bits table */
 	load_free_nid_bitmap(sbi);
 
-	build_free_nids(sbi, true, true);
+	f2fs_build_free_nids(sbi, true, true);
 	return 0;
 }
 
-void destroy_node_manager(struct f2fs_sb_info *sbi)
+void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i, *next_i;
@@ -2856,7 +2859,7 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	kfree(nm_i);
 }
 
-int __init create_node_manager_caches(void)
+int __init f2fs_create_node_manager_caches(void)
 {
 	nat_entry_slab = f2fs_kmem_cache_create("nat_entry",
 			sizeof(struct nat_entry));
@@ -2882,7 +2885,7 @@ int __init create_node_manager_caches(void)
 	return -ENOMEM;
 }
 
-void destroy_node_manager_caches(void)
+void f2fs_destroy_node_manager_caches(void)
 {
 	kmem_cache_destroy(nat_entry_set_slab);
 	kmem_cache_destroy(free_nid_slab);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index bb519ba2558e..d7f20af33206 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -47,7 +47,7 @@
 
 static struct kmem_cache *fsync_entry_slab;
 
-bool space_for_roll_forward(struct f2fs_sb_info *sbi)
+bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi)
 {
 	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
 
@@ -162,7 +162,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 			goto out_put;
 		}
 
-		err = acquire_orphan_inode(F2FS_I_SB(inode));
+		err = f2fs_acquire_orphan_inode(F2FS_I_SB(inode));
 		if (err) {
 			iput(einode);
 			goto out_put;
@@ -252,10 +252,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			return 0;
 
-		page = get_tmp_page(sbi, blkaddr);
+		page = f2fs_get_tmp_page(sbi, blkaddr);
 
 		if (!is_recoverable_dnode(page))
 			break;
@@ -269,7 +269,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 
 			if (!check_only &&
 					IS_INODE(page) && is_dent_dnode(page)) {
-				err = recover_inode_page(sbi, page);
+				err = f2fs_recover_inode_page(sbi, page);
 				if (err)
 					break;
 				quota_inode = true;
@@ -310,7 +310,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 		blkaddr = next_blkaddr_of_node(page);
 		f2fs_put_page(page, 1);
 
-		ra_meta_pages_cond(sbi, blkaddr);
+		f2fs_ra_meta_pages_cond(sbi, blkaddr);
 	}
 	f2fs_put_page(page, 1);
 	return err;
@@ -353,7 +353,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	sum_page = get_sum_page(sbi, segno);
+	sum_page = f2fs_get_sum_page(sbi, segno);
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	sum = sum_node->entries[blkoff];
 	f2fs_put_page(sum_page, 1);
@@ -373,7 +373,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	}
 
 	/* Get the node page */
-	node_page = get_node_page(sbi, nid);
+	node_page = f2fs_get_node_page(sbi, nid);
 	if (IS_ERR(node_page))
 		return PTR_ERR(node_page);
 
@@ -398,7 +398,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		inode = dn->inode;
 	}
 
-	bidx = start_bidx_of_node(offset, inode) + le16_to_cpu(sum.ofs_in_node);
+	bidx = f2fs_start_bidx_of_node(offset, inode) +
+				le16_to_cpu(sum.ofs_in_node);
 
 	/*
 	 * if inode page is locked, unlock temporarily, but its reference
@@ -408,11 +409,11 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		unlock_page(dn->inode_page);
 
 	set_new_dnode(&tdn, inode, NULL, NULL, 0);
-	if (get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
+	if (f2fs_get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
 		goto out;
 
 	if (tdn.data_blkaddr == blkaddr)
-		truncate_data_blocks_range(&tdn, 1);
+		f2fs_truncate_data_blocks_range(&tdn, 1);
 
 	f2fs_put_dnode(&tdn);
 out:
@@ -425,7 +426,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 truncate_out:
 	if (datablock_addr(tdn.inode, tdn.node_page,
 					tdn.ofs_in_node) == blkaddr)
-		truncate_data_blocks_range(&tdn, 1);
+		f2fs_truncate_data_blocks_range(&tdn, 1);
 	if (dn->inode->i_ino == nid && !dn->inode_page_locked)
 		unlock_page(dn->inode_page);
 	return 0;
@@ -441,25 +442,25 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 	/* step 1: recover xattr */
 	if (IS_INODE(page)) {
-		recover_inline_xattr(inode, page);
+		f2fs_recover_inline_xattr(inode, page);
 	} else if (f2fs_has_xattr_block(ofs_of_node(page))) {
-		err = recover_xattr_data(inode, page);
+		err = f2fs_recover_xattr_data(inode, page);
 		if (!err)
 			recovered++;
 		goto out;
 	}
 
 	/* step 2: recover inline data */
-	if (recover_inline_data(inode, page))
+	if (f2fs_recover_inline_data(inode, page))
 		goto out;
 
 	/* step 3: recover data indices */
-	start = start_bidx_of_node(ofs_of_node(page), inode);
+	start = f2fs_start_bidx_of_node(ofs_of_node(page), inode);
 	end = start + ADDRS_PER_PAGE(page, inode);
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 retry_dn:
-	err = get_dnode_of_data(&dn, start, ALLOC_NODE);
+	err = f2fs_get_dnode_of_data(&dn, start, ALLOC_NODE);
 	if (err) {
 		if (err == -ENOMEM) {
 			congestion_wait(BLK_RW_ASYNC, HZ/50);
@@ -470,7 +471,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
 
-	get_node_info(sbi, dn.nid, &ni);
+	f2fs_get_node_info(sbi, dn.nid, &ni);
 	f2fs_bug_on(sbi, ni.ino != ino_of_node(page));
 	f2fs_bug_on(sbi, ofs_of_node(dn.node_page) != ofs_of_node(page));
 
@@ -486,7 +487,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 
 		/* dest is invalid, just invalidate src block */
 		if (dest == NULL_ADDR) {
-			truncate_data_blocks_range(&dn, 1);
+			f2fs_truncate_data_blocks_range(&dn, 1);
 			continue;
 		}
 
@@ -500,19 +501,19 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 * and then reserve one new block in dnode page.
 		 */
 		if (dest == NEW_ADDR) {
-			truncate_data_blocks_range(&dn, 1);
-			reserve_new_block(&dn);
+			f2fs_truncate_data_blocks_range(&dn, 1);
+			f2fs_reserve_new_block(&dn);
 			continue;
 		}
 
 		/* dest is valid block, try to recover from src to dest */
-		if (is_valid_meta_blkaddr(sbi, dest, META_POR)) {
+		if (f2fs_is_valid_meta_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = reserve_new_block(&dn);
+				err = f2fs_reserve_new_block(&dn);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 				while (err)
-					err = reserve_new_block(&dn);
+					err = f2fs_reserve_new_block(&dn);
 #endif
 				/* We should not get -ENOSPC */
 				f2fs_bug_on(sbi, err);
@@ -567,12 +568,12 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 	while (1) {
 		struct fsync_inode_entry *entry;
 
-		if (!is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
+		if (!f2fs_is_valid_meta_blkaddr(sbi, blkaddr, META_POR))
 			break;
 
-		ra_meta_pages_cond(sbi, blkaddr);
+		f2fs_ra_meta_pages_cond(sbi, blkaddr);
 
-		page = get_tmp_page(sbi, blkaddr);
+		page = f2fs_get_tmp_page(sbi, blkaddr);
 
 		if (!is_recoverable_dnode(page)) {
 			f2fs_put_page(page, 1);
@@ -610,11 +611,11 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		f2fs_put_page(page, 1);
 	}
 	if (!err)
-		allocate_new_segments(sbi);
+		f2fs_allocate_new_segments(sbi);
 	return err;
 }
 
-int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
+int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 {
 	struct list_head inode_list;
 	struct list_head dir_list;
@@ -689,7 +690,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 		struct cp_control cpc = {
 			.reason = CP_RECOVERY,
 		};
-		err = write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	kmem_cache_destroy(fsync_entry_slab);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 50c781448a72..39a0d7270080 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -169,7 +169,7 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
 	return result - size + __reverse_ffz(tmp);
 }
 
-bool need_SSR(struct f2fs_sb_info *sbi)
+bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
 {
 	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
 	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
@@ -184,7 +184,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
 			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
 }
 
-void register_inmem_page(struct inode *inode, struct page *page)
+void f2fs_register_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -239,7 +239,8 @@ static int __revoke_inmem_pages(struct inode *inode,
 			trace_f2fs_commit_inmem_page(page, INMEM_REVOKE);
 retry:
 			set_new_dnode(&dn, inode, NULL, NULL, 0);
-			err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+			err = f2fs_get_dnode_of_data(&dn, page->index,
+								LOOKUP_NODE);
 			if (err) {
 				if (err == -ENOMEM) {
 					congestion_wait(BLK_RW_ASYNC, HZ/50);
@@ -249,9 +250,9 @@ static int __revoke_inmem_pages(struct inode *inode,
 				err = -EAGAIN;
 				goto next;
 			}
-			get_node_info(sbi, dn.nid, &ni);
+			f2fs_get_node_info(sbi, dn.nid, &ni);
 			if (cur->old_addr == NEW_ADDR) {
-				invalidate_blocks(sbi, dn.data_blkaddr);
+				f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
 				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
 			} else
 				f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
@@ -273,7 +274,7 @@ static int __revoke_inmem_pages(struct inode *inode,
 	return err;
 }
 
-void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
+void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 {
 	struct list_head *head = &sbi->inode_list[ATOMIC_FILE];
 	struct inode *inode;
@@ -296,7 +297,7 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 		}
 drop:
 		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
-		drop_inmem_pages(inode);
+		f2fs_drop_inmem_pages(inode);
 		iput(inode);
 	}
 skip:
@@ -305,7 +306,7 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 	goto next;
 }
 
-void drop_inmem_pages(struct inode *inode)
+void f2fs_drop_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -323,7 +324,7 @@ void drop_inmem_pages(struct inode *inode)
 	stat_dec_atomic_write(inode);
 }
 
-void drop_inmem_page(struct inode *inode, struct page *page)
+void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -353,7 +354,7 @@ void drop_inmem_page(struct inode *inode, struct page *page)
 	trace_f2fs_commit_inmem_page(page, INMEM_INVALIDATE);
 }
 
-static int __commit_inmem_pages(struct inode *inode)
+static int __f2fs_commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -383,14 +384,14 @@ static int __commit_inmem_pages(struct inode *inode)
 			f2fs_wait_on_page_writeback(page, DATA, true);
 			if (clear_page_dirty_for_io(page)) {
 				inode_dec_dirty_pages(inode);
-				remove_dirty_inode(inode);
+				f2fs_remove_dirty_inode(inode);
 			}
 retry:
 			fio.page = page;
 			fio.old_blkaddr = NULL_ADDR;
 			fio.encrypted_page = NULL;
 			fio.need_lock = LOCK_DONE;
-			err = do_write_data_page(&fio);
+			err = f2fs_do_write_data_page(&fio);
 			if (err) {
 				if (err == -ENOMEM) {
 					congestion_wait(BLK_RW_ASYNC, HZ/50);
@@ -431,7 +432,7 @@ static int __commit_inmem_pages(struct inode *inode)
 	return err;
 }
 
-int commit_inmem_pages(struct inode *inode)
+int f2fs_commit_inmem_pages(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -443,7 +444,7 @@ int commit_inmem_pages(struct inode *inode)
 	set_inode_flag(inode, FI_ATOMIC_COMMIT);
 
 	mutex_lock(&fi->inmem_lock);
-	err = __commit_inmem_pages(inode);
+	err = __f2fs_commit_inmem_pages(inode);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
@@ -490,24 +491,24 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 		return;
 
 	/* try to shrink extent cache when there is no enough memory */
-	if (!available_free_memory(sbi, EXTENT_CACHE))
+	if (!f2fs_available_free_memory(sbi, EXTENT_CACHE))
 		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);
 
 	/* check the # of cached NAT entries */
-	if (!available_free_memory(sbi, NAT_ENTRIES))
-		try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
+	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES))
+		f2fs_try_to_free_nats(sbi, NAT_ENTRY_PER_BLOCK);
 
-	if (!available_free_memory(sbi, FREE_NIDS))
-		try_to_free_nids(sbi, MAX_FREE_NIDS);
+	if (!f2fs_available_free_memory(sbi, FREE_NIDS))
+		f2fs_try_to_free_nids(sbi, MAX_FREE_NIDS);
 	else
-		build_free_nids(sbi, false, false);
+		f2fs_build_free_nids(sbi, false, false);
 
 	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
 		return;
 
 	/* checkpoint is the only way to shrink partial cached entries */
-	if (!available_free_memory(sbi, NAT_ENTRIES) ||
-			!available_free_memory(sbi, INO_ENTRIES) ||
+	if (!f2fs_available_free_memory(sbi, NAT_ENTRIES) ||
+			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
 			f2fs_time_over(sbi, CP_TIME)) {
@@ -515,7 +516,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			struct blk_plug plug;
 
 			blk_start_plug(&plug);
-			sync_dirty_inodes(sbi, FILE_INODE);
+			f2fs_sync_dirty_inodes(sbi, FILE_INODE);
 			blk_finish_plug(&plug);
 		}
 		f2fs_sync_fs(sbi->sb, true);
@@ -548,7 +549,7 @@ static int submit_flush_wait(struct f2fs_sb_info *sbi, nid_t ino)
 		return __submit_flush_wait(sbi, sbi->sb->s_bdev);
 
 	for (i = 0; i < sbi->s_ndevs; i++) {
-		if (!is_dirty_device(sbi, ino, i, FLUSH_INO))
+		if (!f2fs_is_dirty_device(sbi, ino, i, FLUSH_INO))
 			continue;
 		ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 		if (ret)
@@ -659,7 +660,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 	return cmd.ret;
 }
 
-int create_flush_cmd_control(struct f2fs_sb_info *sbi)
+int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct flush_cmd_control *fcc;
@@ -696,7 +697,7 @@ int create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
+void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
 {
 	struct flush_cmd_control *fcc = SM_I(sbi)->fcc_info;
 
@@ -986,7 +987,7 @@ static struct discard_cmd *__insert_discard_tree(struct f2fs_sb_info *sbi,
 		goto do_insert;
 	}
 
-	p = __lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
+	p = f2fs_lookup_rb_tree_for_insert(sbi, &dcc->root, &parent, lstart);
 do_insert:
 	dc = __attach_discard_cmd(sbi, bdev, lstart, start, len, parent, p);
 	if (!dc)
@@ -1051,7 +1052,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 
 	mutex_lock(&dcc->cmd_lock);
 
-	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
+	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, lstart,
 					(struct rb_entry **)&prev_dc,
 					(struct rb_entry **)&next_dc,
@@ -1162,7 +1163,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		mutex_lock(&dcc->cmd_lock);
 		if (list_empty(pend_list))
 			goto next;
-		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
+		f2fs_bug_on(sbi,
+			!f2fs_check_rb_tree_consistence(sbi, &dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -1193,7 +1195,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	return issued;
 }
 
-static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
+static bool __f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *pend_list;
@@ -1215,9 +1217,9 @@ static bool __drop_discard_cmd(struct f2fs_sb_info *sbi)
 	return dropped;
 }
 
-void drop_discard_cmd(struct f2fs_sb_info *sbi)
+void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi)
 {
-	__drop_discard_cmd(sbi);
+	__f2fs_drop_discard_cmd(sbi);
 }
 
 static unsigned int __wait_one_discard_bio(struct f2fs_sb_info *sbi,
@@ -1292,9 +1294,9 @@ static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 	}
 
 	/* wait all */
-	init_discard_policy(&dp, DPOLICY_FSTRIM, 1);
+	f2fs_init_discard_policy(&dp, DPOLICY_FSTRIM, 1);
 	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
-	init_discard_policy(&dp, DPOLICY_UMOUNT, 1);
+	f2fs_init_discard_policy(&dp, DPOLICY_UMOUNT, 1);
 	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 }
 
@@ -1306,7 +1308,8 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 	bool need_wait = false;
 
 	mutex_lock(&dcc->cmd_lock);
-	dc = (struct discard_cmd *)__lookup_rb_tree(&dcc->root, NULL, blkaddr);
+	dc = (struct discard_cmd *)f2fs_lookup_rb_tree(&dcc->root,
+							NULL, blkaddr);
 	if (dc) {
 		if (dc->state == D_PREP) {
 			__punch_discard_cmd(sbi, dc, blkaddr);
@@ -1321,7 +1324,7 @@ static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
 		__wait_one_discard_bio(sbi, dc);
 }
 
-void stop_discard_thread(struct f2fs_sb_info *sbi)
+void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
@@ -1340,9 +1343,10 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
 	struct discard_policy dpolicy;
 	bool dropped;
 
-	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
+	f2fs_init_discard_policy(&dpolicy, DPOLICY_UMOUNT,
+					dcc->discard_granularity);
 	__issue_discard_cmd(sbi, &dpolicy);
-	dropped = __drop_discard_cmd(sbi);
+	dropped = __f2fs_drop_discard_cmd(sbi);
 
 	/* just to make sure there is no pending discard commands */
 	__wait_all_discard_cmd(sbi, NULL);
@@ -1361,7 +1365,7 @@ static int issue_discard_thread(void *data)
 	set_freezable();
 
 	do {
-		init_discard_policy(&dpolicy, DPOLICY_BG,
+		f2fs_init_discard_policy(&dpolicy, DPOLICY_BG,
 					dcc->discard_granularity);
 
 		wait_event_interruptible_timeout(*q,
@@ -1384,7 +1388,7 @@ static int issue_discard_thread(void *data)
 		}
 
 		if (sbi->gc_mode == GC_URGENT)
-			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
+			f2fs_init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
 
 		sb_start_intwrite(sbi->sb);
 
@@ -1568,7 +1572,7 @@ static void release_discard_addr(struct discard_entry *entry)
 	kmem_cache_free(discard_entry_slab, entry);
 }
 
-void release_discard_addrs(struct f2fs_sb_info *sbi)
+void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi)
 {
 	struct list_head *head = &(SM_I(sbi)->dcc_info->entry_list);
 	struct discard_entry *entry, *this;
@@ -1579,7 +1583,7 @@ void release_discard_addrs(struct f2fs_sb_info *sbi)
 }
 
 /*
- * Should call clear_prefree_segments after checkpoint is done.
+ * Should call f2fs_clear_prefree_segments after checkpoint is done.
  */
 static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 {
@@ -1592,7 +1596,8 @@ static void set_prefree_as_free_segments(struct f2fs_sb_info *sbi)
 	mutex_unlock(&dirty_i->seglist_lock);
 }
 
-void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
+						struct cp_control *cpc)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *head = &dcc->entry_list;
@@ -1682,7 +1687,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	wake_up_discard_thread(sbi, false);
 }
 
-void init_discard_policy(struct discard_policy *dpolicy,
+void f2fs_init_discard_policy(struct discard_policy *dpolicy,
 				int discard_type, unsigned int granularity)
 {
 	/* common policy */
@@ -1764,7 +1769,7 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 	if (!dcc)
 		return;
 
-	stop_discard_thread(sbi);
+	f2fs_stop_discard_thread(sbi);
 
 	kfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
@@ -1880,7 +1885,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		get_sec_entry(sbi, segno)->valid_blocks += del;
 }
 
-void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
+void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 {
 	unsigned int segno = GET_SEGNO(sbi, addr);
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -1900,7 +1905,7 @@ void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
 	up_write(&sit_i->sentry_lock);
 }
 
-bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
+bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned int segno, offset;
@@ -1939,7 +1944,7 @@ static void __add_sum_entry(struct f2fs_sb_info *sbi, int type,
 /*
  * Calculate the number of current summary pages for writing
  */
-int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
+int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
 {
 	int valid_sum_count = 0;
 	int i, sum_in_page;
@@ -1969,14 +1974,15 @@ int npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra)
 /*
  * Caller should put this summary page
  */
-struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
+struct page *f2fs_get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 {
-	return get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
+	return f2fs_get_meta_page(sbi, GET_SUM_BLOCK(sbi, segno));
 }
 
-void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr)
+void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
+					void *src, block_t blk_addr)
 {
-	struct page *page = grab_meta_page(sbi, blk_addr);
+	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 
 	memcpy(page_address(page), src, PAGE_SIZE);
 	set_page_dirty(page);
@@ -1986,14 +1992,14 @@ void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr)
 static void write_sum_page(struct f2fs_sb_info *sbi,
 			struct f2fs_summary_block *sum_blk, block_t blk_addr)
 {
-	update_meta_page(sbi, (void *)sum_blk, blk_addr);
+	f2fs_update_meta_page(sbi, (void *)sum_blk, blk_addr);
 }
 
 static void write_current_sum_page(struct f2fs_sb_info *sbi,
 						int type, block_t blk_addr)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	struct page *page = grab_meta_page(sbi, blk_addr);
+	struct page *page = f2fs_grab_meta_page(sbi, blk_addr);
 	struct f2fs_summary_block *src = curseg->sum_blk;
 	struct f2fs_summary_block *dst;
 
@@ -2238,7 +2244,7 @@ static void change_curseg(struct f2fs_sb_info *sbi, int type)
 	curseg->alloc_type = SSR;
 	__next_free_blkoff(sbi, curseg, 0);
 
-	sum_page = get_sum_page(sbi, new_segno);
+	sum_page = f2fs_get_sum_page(sbi, new_segno);
 	sum_node = (struct f2fs_summary_block *)page_address(sum_page);
 	memcpy(curseg->sum_blk, sum_node, SUM_ENTRY_SIZE);
 	f2fs_put_page(sum_page, 1);
@@ -2252,7 +2258,7 @@ static int get_ssr_segment(struct f2fs_sb_info *sbi, int type)
 	int i, cnt;
 	bool reversed = false;
 
-	/* need_SSR() already forces to do this */
+	/* f2fs_need_SSR() already forces to do this */
 	if (v_ops->get_victim(sbi, &segno, BG_GC, type, SSR)) {
 		curseg->next_segno = segno;
 		return 1;
@@ -2304,7 +2310,7 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 		new_curseg(sbi, type, false);
 	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
 		new_curseg(sbi, type, false);
-	else if (need_SSR(sbi) && get_ssr_segment(sbi, type))
+	else if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
 		change_curseg(sbi, type);
 	else
 		new_curseg(sbi, type, false);
@@ -2312,7 +2318,7 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
 	stat_inc_seg_type(sbi, curseg);
 }
 
-void allocate_new_segments(struct f2fs_sb_info *sbi)
+void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 {
 	struct curseg_info *curseg;
 	unsigned int old_segno;
@@ -2334,7 +2340,8 @@ static const struct segment_allocation default_salloc_ops = {
 	.allocate_segment = allocate_segment_by_default,
 };
 
-bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
+						struct cp_control *cpc)
 {
 	__u64 trim_start = cpc->trim_start;
 	bool has_candidate = false;
@@ -2367,9 +2374,9 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	issued = 0;
 
 	mutex_lock(&dcc->cmd_lock);
-	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
+	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi, &dcc->root));
 
-	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
+	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
 					(struct rb_entry **)&prev_dc,
 					(struct rb_entry **)&next_dc,
@@ -2450,7 +2457,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		goto out;
 
 	mutex_lock(&sbi->gc_mutex);
-	err = write_checkpoint(sbi, &cpc);
+	err = f2fs_write_checkpoint(sbi, &cpc);
 	mutex_unlock(&sbi->gc_mutex);
 	if (err)
 		goto out;
@@ -2458,7 +2465,7 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	start_block = START_BLOCK(sbi, start_segno);
 	end_block = START_BLOCK(sbi, end_segno + 1);
 
-	init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
+	f2fs_init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
 	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
 	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
@@ -2475,7 +2482,7 @@ static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-int rw_hint_to_seg_type(enum rw_hint hint)
+int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
 {
 	switch (hint) {
 	case WRITE_LIFE_SHORT:
@@ -2548,7 +2555,7 @@ int rw_hint_to_seg_type(enum rw_hint hint)
  * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  */
 
-enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
+enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 				enum page_type type, enum temp_type temp)
 {
 	if (F2FS_OPTION(sbi).whint_mode == WHINT_MODE_USER) {
@@ -2619,7 +2626,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 				is_inode_flag_set(inode, FI_ATOMIC_FILE) ||
 				is_inode_flag_set(inode, FI_VOLATILE_FILE))
 			return CURSEG_HOT_DATA;
-		return rw_hint_to_seg_type(inode->i_write_hint);
+		return f2fs_rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
 		if (IS_DNODE(fio->page))
 			return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
@@ -2655,7 +2662,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
 	return type;
 }
 
-void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
 		struct f2fs_io_info *fio, bool add_list)
@@ -2738,7 +2745,7 @@ static void update_device_state(struct f2fs_io_info *fio)
 	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
 
 	/* update device state for fsync */
-	set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
+	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
 
 	/* update device state for checkpoint */
 	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
@@ -2756,7 +2763,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	if (keep_order)
 		down_read(&fio->sbi->io_order_lock);
 reallocate:
-	allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
+	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio, true);
 
 	/* writeout dirty page into bdev */
@@ -2772,7 +2779,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		up_read(&fio->sbi->io_order_lock);
 }
 
-void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
+void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 					enum iostat_type io_type)
 {
 	struct f2fs_io_info fio = {
@@ -2798,7 +2805,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
 	f2fs_update_iostat(sbi, io_type, F2FS_BLKSIZE);
 }
 
-void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
+void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 {
 	struct f2fs_summary sum;
 
@@ -2808,14 +2815,15 @@ void write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
 }
 
-void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
+void f2fs_outplace_write_data(struct dnode_of_data *dn,
+					struct f2fs_io_info *fio)
 {
 	struct f2fs_sb_info *sbi = fio->sbi;
 	struct f2fs_summary sum;
 	struct node_info ni;
 
 	f2fs_bug_on(sbi, dn->data_blkaddr == NULL_ADDR);
-	get_node_info(sbi, dn->nid, &ni);
+	f2fs_get_node_info(sbi, dn->nid, &ni);
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
@@ -2823,7 +2831,7 @@ void write_data_page(struct dnode_of_data *dn, struct f2fs_io_info *fio)
 	f2fs_update_iostat(sbi, fio->io_type, F2FS_BLKSIZE);
 }
 
-int rewrite_data_page(struct f2fs_io_info *fio)
+int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 {
 	int err;
 	struct f2fs_sb_info *sbi = fio->sbi;
@@ -2858,7 +2866,7 @@ static inline int __f2fs_get_curseg(struct f2fs_sb_info *sbi,
 	return i;
 }
 
-void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+void f2fs_do_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 				block_t old_blkaddr, block_t new_blkaddr,
 				bool recover_curseg, bool recover_newaddr)
 {
@@ -2943,7 +2951,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 
 	set_summary(&sum, dn->nid, dn->ofs_in_node, version);
 
-	__f2fs_replace_block(sbi, &sum, old_addr, new_addr,
+	f2fs_do_replace_block(sbi, &sum, old_addr, new_addr,
 					recover_curseg, recover_newaddr);
 
 	f2fs_update_data_blkaddr(dn, new_addr);
@@ -2989,7 +2997,7 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 	start = start_sum_block(sbi);
 
-	page = get_meta_page(sbi, start++);
+	page = f2fs_get_meta_page(sbi, start++);
 	kaddr = (unsigned char *)page_address(page);
 
 	/* Step 1: restore nat cache */
@@ -3029,7 +3037,7 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 			f2fs_put_page(page, 1);
 			page = NULL;
 
-			page = get_meta_page(sbi, start++);
+			page = f2fs_get_meta_page(sbi, start++);
 			kaddr = (unsigned char *)page_address(page);
 			offset = 0;
 		}
@@ -3068,7 +3076,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 			blk_addr = GET_SUM_BLOCK(sbi, segno);
 	}
 
-	new = get_meta_page(sbi, blk_addr);
+	new = f2fs_get_meta_page(sbi, blk_addr);
 	sum = (struct f2fs_summary_block *)page_address(new);
 
 	if (IS_NODESEG(type)) {
@@ -3080,7 +3088,7 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 				ns->ofs_in_node = 0;
 			}
 		} else {
-			restore_node_summary(sbi, segno, sum);
+			f2fs_restore_node_summary(sbi, segno, sum);
 		}
 	}
 
@@ -3112,10 +3120,10 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	int err;
 
 	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG)) {
-		int npages = npages_for_summary_flush(sbi, true);
+		int npages = f2fs_npages_for_summary_flush(sbi, true);
 
 		if (npages >= 2)
-			ra_meta_pages(sbi, start_sum_block(sbi), npages,
+			f2fs_ra_meta_pages(sbi, start_sum_block(sbi), npages,
 							META_CP, true);
 
 		/* restore for compacted data summary */
@@ -3124,7 +3132,7 @@ static int restore_curseg_summaries(struct f2fs_sb_info *sbi)
 	}
 
 	if (__exist_node_summaries(sbi))
-		ra_meta_pages(sbi, sum_blk_addr(sbi, NR_CURSEG_TYPE, type),
+		f2fs_ra_meta_pages(sbi, sum_blk_addr(sbi, NR_CURSEG_TYPE, type),
 					NR_CURSEG_TYPE - type, META_CP, true);
 
 	for (; type <= CURSEG_COLD_NODE; type++) {
@@ -3150,7 +3158,7 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 	int written_size = 0;
 	int i, j;
 
-	page = grab_meta_page(sbi, blkaddr++);
+	page = f2fs_grab_meta_page(sbi, blkaddr++);
 	kaddr = (unsigned char *)page_address(page);
 	memset(kaddr, 0, PAGE_SIZE);
 
@@ -3175,7 +3183,7 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
 
 		for (j = 0; j < blkoff; j++) {
 			if (!page) {
-				page = grab_meta_page(sbi, blkaddr++);
+				page = f2fs_grab_meta_page(sbi, blkaddr++);
 				kaddr = (unsigned char *)page_address(page);
 				memset(kaddr, 0, PAGE_SIZE);
 				written_size = 0;
@@ -3212,7 +3220,7 @@ static void write_normal_summaries(struct f2fs_sb_info *sbi,
 		write_current_sum_page(sbi, i, blkaddr + (i - type));
 }
 
-void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
+void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	if (is_set_ckpt_flags(sbi, CP_COMPACT_SUM_FLAG))
 		write_compacted_summaries(sbi, start_blk);
@@ -3220,12 +3228,12 @@ void write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 		write_normal_summaries(sbi, start_blk, CURSEG_HOT_DATA);
 }
 
-void write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
+void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 {
 	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
 }
 
-int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 					unsigned int val, int alloc)
 {
 	int i;
@@ -3250,7 +3258,7 @@ int lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 static struct page *get_current_sit_page(struct f2fs_sb_info *sbi,
 					unsigned int segno)
 {
-	return get_meta_page(sbi, current_sit_addr(sbi, segno));
+	return f2fs_get_meta_page(sbi, current_sit_addr(sbi, segno));
 }
 
 static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
@@ -3263,7 +3271,7 @@ static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
 	src_off = current_sit_addr(sbi, start);
 	dst_off = next_sit_addr(sbi, src_off);
 
-	page = grab_meta_page(sbi, dst_off);
+	page = f2fs_grab_meta_page(sbi, dst_off);
 	seg_info_to_sit_page(sbi, page, start);
 
 	set_page_dirty(page);
@@ -3359,7 +3367,7 @@ static void remove_sits_in_journal(struct f2fs_sb_info *sbi)
  * CP calls this function, which flushes SIT entries including sit_journal,
  * and moves prefree segs to free segs.
  */
-void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	unsigned long *bitmap = sit_i->dirty_sentries_bitmap;
@@ -3431,7 +3439,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			}
 
 			if (to_journal) {
-				offset = lookup_journal_in_cursum(journal,
+				offset = f2fs_lookup_journal_in_cursum(journal,
 							SIT_JOURNAL, segno, 1);
 				f2fs_bug_on(sbi, offset < 0);
 				segno_in_journal(journal, offset) =
@@ -3647,7 +3655,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	block_t total_node_blocks = 0;
 
 	do {
-		readed = ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
+		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
 							META_SIT, true);
 
 		start = start_blk * sit_i->sents_per_block;
@@ -3865,7 +3873,7 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 	up_write(&sit_i->sentry_lock);
 }
 
-int build_segment_manager(struct f2fs_sb_info *sbi)
+int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
@@ -3902,7 +3910,7 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
 	init_rwsem(&sm_info->curseg_lock);
 
 	if (!f2fs_readonly(sbi->sb)) {
-		err = create_flush_cmd_control(sbi);
+		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
 			return err;
 	}
@@ -4027,13 +4035,13 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
 	kfree(sit_i);
 }
 
-void destroy_segment_manager(struct f2fs_sb_info *sbi)
+void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_sm_info *sm_info = SM_I(sbi);
 
 	if (!sm_info)
 		return;
-	destroy_flush_cmd_control(sbi, true);
+	f2fs_destroy_flush_cmd_control(sbi, true);
 	destroy_discard_cmd_control(sbi);
 	destroy_dirty_segmap(sbi);
 	destroy_curseg(sbi);
@@ -4043,7 +4051,7 @@ void destroy_segment_manager(struct f2fs_sb_info *sbi)
 	kfree(sm_info);
 }
 
-int __init create_segment_manager_caches(void)
+int __init f2fs_create_segment_manager_caches(void)
 {
 	discard_entry_slab = f2fs_kmem_cache_create("discard_entry",
 			sizeof(struct discard_entry));
@@ -4076,7 +4084,7 @@ int __init create_segment_manager_caches(void)
 	return -ENOMEM;
 }
 
-void destroy_segment_manager_caches(void)
+void f2fs_destroy_segment_manager_caches(void)
 {
 	kmem_cache_destroy(sit_entry_set_slab);
 	kmem_cache_destroy(discard_cmd_slab);
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 0b5664a1a6cc..36cfd816c160 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -109,11 +109,11 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 
 		/* shrink clean nat cache entries */
 		if (freed < nr)
-			freed += try_to_free_nats(sbi, nr - freed);
+			freed += f2fs_try_to_free_nats(sbi, nr - freed);
 
 		/* shrink free nids cache entries */
 		if (freed < nr)
-			freed += try_to_free_nids(sbi, nr - freed);
+			freed += f2fs_try_to_free_nids(sbi, nr - freed);
 
 		spin_lock(&f2fs_list_lock);
 		p = p->next;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 12282b144651..d5a3a63a8e40 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -865,7 +865,7 @@ static int f2fs_drop_inode(struct inode *inode)
 
 			/* some remained atomic pages should discarded */
 			if (f2fs_is_atomic_file(inode))
-				drop_inmem_pages(inode);
+				f2fs_drop_inmem_pages(inode);
 
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
@@ -1002,7 +1002,7 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT,
 		};
-		write_checkpoint(sbi, &cpc);
+		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
 	/* be sure to wait for any on-going discard commands */
@@ -1012,17 +1012,17 @@ static void f2fs_put_super(struct super_block *sb)
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
-		write_checkpoint(sbi, &cpc);
+		f2fs_write_checkpoint(sbi, &cpc);
 	}
 
-	/* write_checkpoint can update stat informaion */
+	/* f2fs_write_checkpoint can update stat informaion */
 	f2fs_destroy_stats(sbi);
 
 	/*
 	 * normally superblock is clean, so we need to release this.
 	 * In addition, EIO will skip do checkpoint, we need this as well.
 	 */
-	release_ino_entry(sbi, true);
+	f2fs_release_ino_entry(sbi, true);
 
 	f2fs_leave_shrinker(sbi);
 	mutex_unlock(&sbi->umount_mutex);
@@ -1034,8 +1034,8 @@ static void f2fs_put_super(struct super_block *sb)
 	iput(sbi->meta_inode);
 
 	/* destroy f2fs internal modules */
-	destroy_node_manager(sbi);
-	destroy_segment_manager(sbi);
+	f2fs_destroy_node_manager(sbi);
+	f2fs_destroy_segment_manager(sbi);
 
 	kfree(sbi->ckpt);
 
@@ -1077,7 +1077,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 		cpc.reason = __get_cp_reason(sbi);
 
 		mutex_lock(&sbi->gc_mutex);
-		err = write_checkpoint(sbi, &cpc);
+		err = f2fs_write_checkpoint(sbi, &cpc);
 		mutex_unlock(&sbi->gc_mutex);
 	}
 	f2fs_trace_ios(NULL, 1);
@@ -1480,11 +1480,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	if ((*flags & SB_RDONLY) || !test_opt(sbi, BG_GC)) {
 		if (sbi->gc_thread) {
-			stop_gc_thread(sbi);
+			f2fs_stop_gc_thread(sbi);
 			need_restart_gc = true;
 		}
 	} else if (!sbi->gc_thread) {
-		err = start_gc_thread(sbi);
+		err = f2fs_start_gc_thread(sbi);
 		if (err)
 			goto restore_opts;
 		need_stop_gc = true;
@@ -1507,9 +1507,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	if ((*flags & SB_RDONLY) || !test_opt(sbi, FLUSH_MERGE)) {
 		clear_opt(sbi, FLUSH_MERGE);
-		destroy_flush_cmd_control(sbi, false);
+		f2fs_destroy_flush_cmd_control(sbi, false);
 	} else {
-		err = create_flush_cmd_control(sbi);
+		err = f2fs_create_flush_cmd_control(sbi);
 		if (err)
 			goto restore_gc;
 	}
@@ -1527,11 +1527,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	return 0;
 restore_gc:
 	if (need_restart_gc) {
-		if (start_gc_thread(sbi))
+		if (f2fs_start_gc_thread(sbi))
 			f2fs_msg(sbi->sb, KERN_WARNING,
 				"background gc thread has stopped");
 	} else if (need_stop_gc) {
-		stop_gc_thread(sbi);
+		f2fs_stop_gc_thread(sbi);
 	}
 restore_opts:
 #ifdef CONFIG_QUOTA
@@ -1955,7 +1955,7 @@ static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	struct inode *inode;
 
-	if (check_nid_range(sbi, ino))
+	if (f2fs_check_nid_range(sbi, ino))
 		return ERR_PTR(-ESTALE);
 
 	/*
@@ -2281,7 +2281,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
-int sanity_check_ckpt(struct f2fs_sb_info *sbi)
+int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
 {
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -2830,7 +2830,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_io_dummy;
 	}
 
-	err = get_valid_checkpoint(sbi);
+	err = f2fs_get_valid_checkpoint(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR, "Failed to get valid F2FS checkpoint");
 		goto free_meta_inode;
@@ -2860,18 +2860,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		spin_lock_init(&sbi->inode_lock[i]);
 	}
 
-	init_extent_cache_info(sbi);
+	f2fs_init_extent_cache_info(sbi);
 
-	init_ino_entry_info(sbi);
+	f2fs_init_ino_entry_info(sbi);
 
 	/* setup f2fs internal modules */
-	err = build_segment_manager(sbi);
+	err = f2fs_build_segment_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
 			"Failed to initialize F2FS segment manager");
 		goto free_sm;
 	}
-	err = build_node_manager(sbi);
+	err = f2fs_build_node_manager(sbi);
 	if (err) {
 		f2fs_msg(sb, KERN_ERR,
 			"Failed to initialize F2FS node manager");
@@ -2889,7 +2889,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->kbytes_written =
 			le64_to_cpu(seg_i->journal->info.kbytes_written);
 
-	build_gc_manager(sbi);
+	f2fs_build_gc_manager(sbi);
 
 	/* get an inode for node space */
 	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
@@ -2941,7 +2941,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 #endif
 	/* if there are nt orphan nodes free them */
-	err = recover_orphan_inodes(sbi);
+	err = f2fs_recover_orphan_inodes(sbi);
 	if (err)
 		goto free_meta;
 
@@ -2963,7 +2963,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (!retry)
 			goto skip_recovery;
 
-		err = recover_fsync_data(sbi, false);
+		err = f2fs_recover_fsync_data(sbi, false);
 		if (err < 0) {
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
@@ -2971,7 +2971,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 		}
 	} else {
-		err = recover_fsync_data(sbi, true);
+		err = f2fs_recover_fsync_data(sbi, true);
 
 		if (!f2fs_readonly(sb) && err > 0) {
 			err = -EINVAL;
@@ -2981,7 +2981,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 skip_recovery:
-	/* recover_fsync_data() cleared this already */
+	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
 	/*
@@ -2990,7 +2990,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	if (test_opt(sbi, BG_GC) && !f2fs_readonly(sb)) {
 		/* After POR, we can run background GC thread.*/
-		err = start_gc_thread(sbi);
+		err = f2fs_start_gc_thread(sbi);
 		if (err)
 			goto free_meta;
 	}
@@ -3021,10 +3021,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 	f2fs_sync_inode_meta(sbi);
 	/*
-	 * Some dirty meta pages can be produced by recover_orphan_inodes()
+	 * Some dirty meta pages can be produced by f2fs_recover_orphan_inodes()
 	 * failed by EIO. Then, iput(node_inode) can trigger balance_fs_bg()
-	 * followed by write_checkpoint() through f2fs_write_node_pages(), which
-	 * falls into an infinite loop in sync_meta_pages().
+	 * followed by f2fs_write_checkpoint() through f2fs_write_node_pages(), which
+	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
 #ifdef CONFIG_QUOTA
@@ -3037,13 +3037,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_node_inode:
-	release_ino_entry(sbi, true);
+	f2fs_release_ino_entry(sbi, true);
 	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
 free_nm:
-	destroy_node_manager(sbi);
+	f2fs_destroy_node_manager(sbi);
 free_sm:
-	destroy_segment_manager(sbi);
+	f2fs_destroy_segment_manager(sbi);
 free_devices:
 	destroy_device_list(sbi);
 	kfree(sbi->ckpt);
@@ -3089,8 +3089,8 @@ static void kill_f2fs_super(struct super_block *sb)
 {
 	if (sb->s_root) {
 		set_sbi_flag(F2FS_SB(sb), SBI_IS_CLOSE);
-		stop_gc_thread(F2FS_SB(sb));
-		stop_discard_thread(F2FS_SB(sb));
+		f2fs_stop_gc_thread(F2FS_SB(sb));
+		f2fs_stop_discard_thread(F2FS_SB(sb));
 	}
 	kill_block_super(sb);
 }
@@ -3133,16 +3133,16 @@ static int __init init_f2fs_fs(void)
 	err = init_inodecache();
 	if (err)
 		goto fail;
-	err = create_node_manager_caches();
+	err = f2fs_create_node_manager_caches();
 	if (err)
 		goto free_inodecache;
-	err = create_segment_manager_caches();
+	err = f2fs_create_segment_manager_caches();
 	if (err)
 		goto free_node_manager_caches;
-	err = create_checkpoint_caches();
+	err = f2fs_create_checkpoint_caches();
 	if (err)
 		goto free_segment_manager_caches;
-	err = create_extent_cache();
+	err = f2fs_create_extent_cache();
 	if (err)
 		goto free_checkpoint_caches;
 	err = f2fs_init_sysfs();
@@ -3171,13 +3171,13 @@ static int __init init_f2fs_fs(void)
 free_sysfs:
 	f2fs_exit_sysfs();
 free_extent_cache:
-	destroy_extent_cache();
+	f2fs_destroy_extent_cache();
 free_checkpoint_caches:
-	destroy_checkpoint_caches();
+	f2fs_destroy_checkpoint_caches();
 free_segment_manager_caches:
-	destroy_segment_manager_caches();
+	f2fs_destroy_segment_manager_caches();
 free_node_manager_caches:
-	destroy_node_manager_caches();
+	f2fs_destroy_node_manager_caches();
 free_inodecache:
 	destroy_inodecache();
 fail:
@@ -3191,10 +3191,10 @@ static void __exit exit_f2fs_fs(void)
 	unregister_filesystem(&f2fs_fs_type);
 	unregister_shrinker(&f2fs_shrinker_info);
 	f2fs_exit_sysfs();
-	destroy_extent_cache();
-	destroy_checkpoint_caches();
-	destroy_segment_manager_caches();
-	destroy_node_manager_caches();
+	f2fs_destroy_extent_cache();
+	f2fs_destroy_checkpoint_caches();
+	f2fs_destroy_segment_manager_caches();
+	f2fs_destroy_node_manager_caches();
 	destroy_inodecache();
 	f2fs_destroy_trace_ios();
 }
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ac3ea6044936..8423c71747f4 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -201,13 +201,13 @@ static ssize_t __f2fs_sbi_store(struct f2fs_attr *a,
 
 		down_write(&sbi->sb_lock);
 
-		ret = update_extension_list(sbi, name, hot, set);
+		ret = f2fs_update_extension_list(sbi, name, hot, set);
 		if (ret)
 			goto out;
 
 		ret = f2fs_commit_super(sbi, false);
 		if (ret)
-			update_extension_list(sbi, name, hot, !set);
+			f2fs_update_extension_list(sbi, name, hot, !set);
 out:
 		up_write(&sbi->sb_lock);
 		return ret ? ret : count;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae2dfa709f5d..708271871f94 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -252,7 +252,7 @@ static int read_inline_xattr(struct inode *inode, struct page *ipage,
 	if (ipage) {
 		inline_addr = inline_xattr_addr(inode, ipage);
 	} else {
-		page = get_node_page(sbi, inode->i_ino);
+		page = f2fs_get_node_page(sbi, inode->i_ino);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 
@@ -273,7 +273,7 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 	void *xattr_addr;
 
 	/* The inode already has an extended attribute block. */
-	xpage = get_node_page(sbi, xnid);
+	xpage = f2fs_get_node_page(sbi, xnid);
 	if (IS_ERR(xpage))
 		return PTR_ERR(xpage);
 
@@ -397,7 +397,7 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	int err = 0;
 
 	if (hsize > inline_size && !F2FS_I(inode)->i_xattr_nid)
-		if (!alloc_nid(sbi, &new_nid))
+		if (!f2fs_alloc_nid(sbi, &new_nid))
 			return -ENOSPC;
 
 	/* write to inline xattr */
@@ -405,9 +405,9 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 		if (ipage) {
 			inline_addr = inline_xattr_addr(inode, ipage);
 		} else {
-			in_page = get_node_page(sbi, inode->i_ino);
+			in_page = f2fs_get_node_page(sbi, inode->i_ino);
 			if (IS_ERR(in_page)) {
-				alloc_nid_failed(sbi, new_nid);
+				f2fs_alloc_nid_failed(sbi, new_nid);
 				return PTR_ERR(in_page);
 			}
 			inline_addr = inline_xattr_addr(inode, in_page);
@@ -417,8 +417,8 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 							NODE, true);
 		/* no need to use xattr node block */
 		if (hsize <= inline_size) {
-			err = truncate_xattr_node(inode);
-			alloc_nid_failed(sbi, new_nid);
+			err = f2fs_truncate_xattr_node(inode);
+			f2fs_alloc_nid_failed(sbi, new_nid);
 			if (err) {
 				f2fs_put_page(in_page, 1);
 				return err;
@@ -431,10 +431,10 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 	/* write to xattr node block */
 	if (F2FS_I(inode)->i_xattr_nid) {
-		xpage = get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
+		xpage = f2fs_get_node_page(sbi, F2FS_I(inode)->i_xattr_nid);
 		if (IS_ERR(xpage)) {
 			err = PTR_ERR(xpage);
-			alloc_nid_failed(sbi, new_nid);
+			f2fs_alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
 		f2fs_bug_on(sbi, new_nid);
@@ -442,13 +442,13 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	} else {
 		struct dnode_of_data dn;
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-		xpage = new_node_page(&dn, XATTR_NODE_OFFSET);
+		xpage = f2fs_new_node_page(&dn, XATTR_NODE_OFFSET);
 		if (IS_ERR(xpage)) {
 			err = PTR_ERR(xpage);
-			alloc_nid_failed(sbi, new_nid);
+			f2fs_alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
-		alloc_nid_done(sbi, new_nid);
+		f2fs_alloc_nid_done(sbi, new_nid);
 	}
 	xattr_addr = page_address(xpage);
 
@@ -693,7 +693,7 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 	if (err)
 		return err;
 
-	/* this case is only from init_inode_metadata */
+	/* this case is only from f2fs_init_inode_metadata */
 	if (ipage)
 		return __f2fs_setxattr(inode, index, name, value,
 						size, ipage, flags);
-- 
2.16.2.17.g38e79b1fd
