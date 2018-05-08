Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbeEHSFf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932457AbeEHSFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:31 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 30/76] fs/ext2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:50 -0700
Message-Id: <20180508180436.716-31-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ext2/balloc.c     | 10 +++----
 fs/ext2/dir.c        | 32 ++++++++++----------
 fs/ext2/file.c       |  6 ++--
 fs/ext2/ialloc.c     | 16 +++++-----
 fs/ext2/inode.c      | 82 +++++++++++++++++++++++++++-------------------------
 fs/ext2/ioctl.c      |  4 +--
 fs/ext2/namei.c      | 14 ++++-----
 fs/ext2/xattr.c      | 59 ++++++++++++++++++-------------------
 fs/ext2/xattr_user.c |  4 +--
 9 files changed, 115 insertions(+), 112 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 33db13365c5e..0ac54114ea9a 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -413,7 +413,7 @@ void ext2_init_block_alloc_info(struct inode *inode)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	struct ext2_block_alloc_info *block_i;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
 	if (block_i) {
@@ -455,7 +455,7 @@ void ext2_discard_reservation(struct inode *inode)
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	struct ext2_block_alloc_info *block_i = ei->i_block_alloc_info;
 	struct ext2_reserve_window_node *rsv;
-	spinlock_t *rsv_lock = &EXT2_SB(inode->i_sb)->s_rsv_window_lock;
+	spinlock_t *rsv_lock = &EXT2_SB(inode_sb(inode))->s_rsv_window_lock;
 
 	if (!block_i)
 		return;
@@ -464,7 +464,7 @@ void ext2_discard_reservation(struct inode *inode)
 	if (!rsv_is_empty(&rsv->rsv_window)) {
 		spin_lock(rsv_lock);
 		if (!rsv_is_empty(&rsv->rsv_window))
-			rsv_window_remove(inode->i_sb, rsv);
+			rsv_window_remove(inode_sb(inode), rsv);
 		spin_unlock(rsv_lock);
 	}
 }
@@ -484,7 +484,7 @@ void ext2_free_blocks (struct inode * inode, unsigned long block,
 	unsigned long bit;
 	unsigned long i;
 	unsigned long overflow;
-	struct super_block * sb = inode->i_sb;
+	struct super_block * sb = inode_sb(inode);
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_group_desc * desc;
 	struct ext2_super_block * es = sbi->s_es;
@@ -1255,7 +1255,7 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 	int ret;
 
 	*errp = -ENOSPC;
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 
 	/*
 	 * Check quota for allocation of this block.
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 3b8114def693..b9565d7b86e8 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -63,7 +63,7 @@ static inline __le16 ext2_rec_len_to_disk(unsigned len)
  */
 static inline unsigned ext2_chunk_size(struct inode *inode)
 {
-	return inode->i_sb->s_blocksize;
+	return inode_sb(inode)->s_blocksize;
 }
 
 static inline void ext2_put_page(struct page *page)
@@ -115,7 +115,7 @@ static int ext2_commit_chunk(struct page *page, loff_t pos, unsigned len)
 static bool ext2_check_page(struct page *page, int quiet)
 {
 	struct inode *dir = page->mapping->host;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	unsigned chunk_size = ext2_chunk_size(dir);
 	char *kaddr = page_address(page);
 	u32 max_inumber = le32_to_cpu(EXT2_SB(sb)->s_es->s_inodes_count);
@@ -277,7 +277,7 @@ static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
 static inline void ext2_set_de_type(ext2_dirent *de, struct inode *inode)
 {
 	umode_t mode = inode->i_mode;
-	if (EXT2_HAS_INCOMPAT_FEATURE(inode->i_sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
+	if (EXT2_HAS_INCOMPAT_FEATURE(inode_sb(inode), EXT2_FEATURE_INCOMPAT_FILETYPE))
 		de->file_type = ext2_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
 	else
 		de->file_type = 0;
@@ -288,7 +288,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 {
 	loff_t pos = ctx->pos;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned int offset = pos & ~PAGE_MASK;
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
@@ -392,8 +392,8 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 			kaddr += ext2_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (de->rec_len == 0) {
-					ext2_error(dir->i_sb, __func__,
-						"zero-length directory entry");
+					ext2_error(inode_sb(dir), __func__,
+						   "zero-length directory entry");
 					ext2_put_page(page);
 					goto out;
 				}
@@ -409,10 +409,10 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
 			n = 0;
 		/* next page is past the blocks we've got */
 		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
-			ext2_error(dir->i_sb, __func__,
-				"dir %lu size %lld exceeds block count %llu",
-				dir->i_ino, dir->i_size,
-				(unsigned long long)dir->i_blocks);
+			ext2_error(inode_sb(dir), __func__,
+				   "dir %lu size %lld exceeds block count %llu",
+				   dir->i_ino, dir->i_size,
+				   (unsigned long long)dir->i_blocks);
 			goto out;
 		}
 	} while (n != start);
@@ -524,8 +524,8 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			}
 			if (de->rec_len == 0) {
-				ext2_error(dir->i_sb, __func__,
-					"zero-length directory entry");
+				ext2_error(inode_sb(dir), __func__,
+					   "zero-length directory entry");
 				err = -EIO;
 				goto out_unlock;
 			}
@@ -594,8 +594,8 @@ int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
 
 	while ((char*)de < (char*)dir) {
 		if (de->rec_len == 0) {
-			ext2_error(inode->i_sb, __func__,
-				"zero-length directory entry");
+			ext2_error(inode_sb(inode), __func__,
+				   "zero-length directory entry");
 			err = -EIO;
 			goto out;
 		}
@@ -686,8 +686,8 @@ int ext2_empty_dir (struct inode * inode)
 
 		while ((char *)de <= kaddr) {
 			if (de->rec_len == 0) {
-				ext2_error(inode->i_sb, __func__,
-					"zero-length directory entry");
+				ext2_error(inode_sb(inode), __func__,
+					   "zero-length directory entry");
 				printk("kaddr=%p, de=%p\n", kaddr, de);
 				goto not_empty;
 			}
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 09640220fda8..b7279d6ad130 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -95,7 +95,7 @@ static int ext2_dax_fault(struct vm_fault *vmf)
 	int ret;
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
-		sb_start_pagefault(inode->i_sb);
+		sb_start_pagefault(inode_sb(inode));
 		file_update_time(vmf->vma->vm_file);
 	}
 	down_read(&ei->dax_sem);
@@ -104,7 +104,7 @@ static int ext2_dax_fault(struct vm_fault *vmf)
 
 	up_read(&ei->dax_sem);
 	if (vmf->flags & FAULT_FLAG_WRITE)
-		sb_end_pagefault(inode->i_sb);
+		sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 
@@ -151,7 +151,7 @@ static int ext2_release_file (struct inode * inode, struct file * filp)
 int ext2_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	int ret;
-	struct super_block *sb = file->f_mapping->host->i_sb;
+	struct super_block *sb = inode_sb(file->f_mapping->host);
 
 	ret = generic_file_fsync(file, start, end, datasync);
 	if (ret == -EIO)
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 6484199b35d1..549a0e7efec1 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -103,7 +103,7 @@ static void ext2_release_inode(struct super_block *sb, int group, int dir)
  */
 void ext2_free_inode (struct inode * inode)
 {
-	struct super_block * sb = inode->i_sb;
+	struct super_block * sb = inode_sb(inode);
 	int is_directory;
 	unsigned long ino;
 	struct buffer_head *bitmap_bh;
@@ -177,19 +177,19 @@ static void ext2_preread_inode(struct inode *inode)
 	if (bdi_write_congested(bdi))
 		return;
 
-	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
-	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
+	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode_sb(inode));
+	gdp = ext2_get_group_desc(inode_sb(inode), block_group, NULL);
 	if (gdp == NULL)
 		return;
 
 	/*
 	 * Figure out the offset within the block group inode table
 	 */
-	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode->i_sb)) *
-				EXT2_INODE_SIZE(inode->i_sb);
+	offset = ((inode->i_ino - 1) % EXT2_INODES_PER_GROUP(inode_sb(inode))) *
+				EXT2_INODE_SIZE(inode_sb(inode));
 	block = le32_to_cpu(gdp->bg_inode_table) +
-				(offset >> EXT2_BLOCK_SIZE_BITS(inode->i_sb));
-	sb_breadahead(inode->i_sb, block);
+				(offset >> EXT2_BLOCK_SIZE_BITS(inode_sb(inode)));
+	sb_breadahead(inode_sb(inode), block);
 }
 
 /*
@@ -443,7 +443,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 	struct ext2_sb_info *sbi;
 	int err;
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 9b2ac55ac34f..47b7129f2db7 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -48,7 +48,7 @@ static int __ext2_write_inode(struct inode *inode, int do_sync);
 static inline int ext2_inode_is_fast_symlink(struct inode *inode)
 {
 	int ea_blocks = EXT2_I(inode)->i_file_acl ?
-		(inode->i_sb->s_blocksize >> 9) : 0;
+		(inode_sb(inode)->s_blocksize >> 9) : 0;
 
 	return (S_ISLNK(inode->i_mode) &&
 		inode->i_blocks - ea_blocks == 0);
@@ -84,7 +84,7 @@ void ext2_evict_inode(struct inode * inode)
 	truncate_inode_pages_final(&inode->i_data);
 
 	if (want_delete) {
-		sb_start_intwrite(inode->i_sb);
+		sb_start_intwrite(inode_sb(inode));
 		/* set dtime */
 		EXT2_I(inode)->i_dtime	= get_seconds();
 		mark_inode_dirty(inode);
@@ -107,7 +107,7 @@ void ext2_evict_inode(struct inode * inode)
 
 	if (want_delete) {
 		ext2_free_inode(inode);
-		sb_end_intwrite(inode->i_sb);
+		sb_end_intwrite(inode_sb(inode));
 	}
 }
 
@@ -147,7 +147,7 @@ static inline int verify_chain(Indirect *from, Indirect *to)
  *
  *	Note: function doesn't find node addresses, so no IO is needed. All
  *	we need to know is the capacity of indirect blocks (taken from the
- *	inode->i_sb).
+ *	inode_sb(inode)).
  */
 
 /*
@@ -163,8 +163,8 @@ static inline int verify_chain(Indirect *from, Indirect *to)
 static int ext2_block_to_path(struct inode *inode,
 			long i_block, int offsets[4], int *boundary)
 {
-	int ptrs = EXT2_ADDR_PER_BLOCK(inode->i_sb);
-	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode->i_sb);
+	int ptrs = EXT2_ADDR_PER_BLOCK(inode_sb(inode));
+	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode_sb(inode));
 	const long direct_blocks = EXT2_NDIR_BLOCKS,
 		indirect_blocks = ptrs,
 		double_blocks = (1 << (ptrs_bits * 2));
@@ -172,8 +172,8 @@ static int ext2_block_to_path(struct inode *inode,
 	int final = 0;
 
 	if (i_block < 0) {
-		ext2_msg(inode->i_sb, KERN_WARNING,
-			"warning: %s: block < 0", __func__);
+		ext2_msg(inode_sb(inode), KERN_WARNING,
+			 "warning: %s: block < 0", __func__);
 	} else if (i_block < direct_blocks) {
 		offsets[n++] = i_block;
 		final = direct_blocks;
@@ -193,8 +193,8 @@ static int ext2_block_to_path(struct inode *inode,
 		offsets[n++] = i_block & (ptrs - 1);
 		final = ptrs;
 	} else {
-		ext2_msg(inode->i_sb, KERN_WARNING,
-			"warning: %s: block is too big", __func__);
+		ext2_msg(inode_sb(inode), KERN_WARNING,
+			 "warning: %s: block is too big", __func__);
 	}
 	if (boundary)
 		*boundary = final - 1 - (i_block & (ptrs - 1));
@@ -237,7 +237,7 @@ static Indirect *ext2_get_branch(struct inode *inode,
 				 Indirect chain[4],
 				 int *err)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	Indirect *p = chain;
 	struct buffer_head *bh;
 
@@ -312,9 +312,10 @@ static ext2_fsblk_t ext2_find_near(struct inode *inode, Indirect *ind)
 	 * It is going to be referred from inode itself? OK, just put it into
 	 * the same cylinder group then.
 	 */
-	bg_start = ext2_group_first_block_no(inode->i_sb, ei->i_block_group);
+	bg_start = ext2_group_first_block_no(inode_sb(inode),
+					     ei->i_block_group);
 	colour = (current->pid % 16) *
-			(EXT2_BLOCKS_PER_GROUP(inode->i_sb) / 16);
+			(EXT2_BLOCKS_PER_GROUP(inode_sb(inode)) / 16);
 	return bg_start + colour;
 }
 
@@ -477,7 +478,7 @@ static int ext2_alloc_branch(struct inode *inode,
 			int indirect_blks, int *blks, ext2_fsblk_t goal,
 			int *offsets, Indirect *branch)
 {
-	int blocksize = inode->i_sb->s_blocksize;
+	int blocksize = inode_sb(inode)->s_blocksize;
 	int i, n = 0;
 	int err = 0;
 	struct buffer_head *bh;
@@ -500,7 +501,7 @@ static int ext2_alloc_branch(struct inode *inode,
 		 * and set the pointer to new one, then send
 		 * parent to disk.
 		 */
-		bh = sb_getblk(inode->i_sb, new_blocks[n-1]);
+		bh = sb_getblk(inode_sb(inode), new_blocks[n-1]);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			goto failed;
@@ -738,7 +739,7 @@ static int ext2_get_blocks(struct inode *inode,
 		 * We must unmap blocks before zeroing so that writeback cannot
 		 * overwrite zeros with stale data from block device page cache.
 		 */
-		clean_bdev_aliases(inode->i_sb->s_bdev,
+		clean_bdev_aliases(inode_sb(inode)->s_bdev,
 				   le32_to_cpu(chain[depth-1].key),
 				   count);
 		/*
@@ -746,9 +747,9 @@ static int ext2_get_blocks(struct inode *inode,
 		 * so that it's not found by another thread before it's
 		 * initialised
 		 */
-		err = sb_issue_zeroout(inode->i_sb,
-				le32_to_cpu(chain[depth-1].key), count,
-				GFP_NOFS);
+		err = sb_issue_zeroout(inode_sb(inode),
+				       le32_to_cpu(chain[depth-1].key), count,
+				       GFP_NOFS);
 		if (err) {
 			mutex_unlock(&ei->truncate_mutex);
 			goto cleanup;
@@ -787,7 +788,7 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
 	if (ret <= 0)
 		return ret;
 
-	map_bh(bh_result, inode->i_sb, bno);
+	map_bh(bh_result, inode_sb(inode), bno);
 	bh_result->b_size = (ret << inode->i_blkbits);
 	if (new)
 		set_buffer_new(bh_result);
@@ -804,7 +805,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block = offset >> blkbits;
 	unsigned long max_blocks = (length + (1 << blkbits) - 1) >> blkbits;
-	struct ext2_sb_info *sbi = EXT2_SB(inode->i_sb);
+	struct ext2_sb_info *sbi = EXT2_SB(inode_sb(inode));
 	bool new = false, boundary = false;
 	u32 bno;
 	int ret;
@@ -815,7 +816,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return ret;
 
 	iomap->flags = 0;
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev = inode_sb(inode)->s_bdev;
 	iomap->offset = (u64)first_block << blkbits;
 	iomap->dax_dev = sbi->s_daxdev;
 
@@ -955,7 +956,7 @@ ext2_writepages(struct address_space *mapping, struct writeback_control *wbc)
 #ifdef CONFIG_FS_DAX
 	if (dax_mapping(mapping)) {
 		return dax_writeback_mapping_range(mapping,
-						   mapping->host->i_sb->s_bdev,
+						   inode_sb(mapping->host)->s_bdev,
 						   wbc);
 	}
 #endif
@@ -1142,21 +1143,22 @@ static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int de
 	unsigned long nr;
 
 	if (depth--) {
-		int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
+		int addr_per_block = EXT2_ADDR_PER_BLOCK(inode_sb(inode));
 		for ( ; p < q ; p++) {
 			nr = le32_to_cpu(*p);
 			if (!nr)
 				continue;
 			*p = 0;
-			bh = sb_bread(inode->i_sb, nr);
+			bh = sb_bread(inode_sb(inode), nr);
 			/*
 			 * A read failure? Report error and clear slot
 			 * (should be rare).
 			 */ 
 			if (!bh) {
-				ext2_error(inode->i_sb, "ext2_free_branches",
-					"Read failure, inode=%ld, block=%ld",
-					inode->i_ino, nr);
+				ext2_error(inode_sb(inode),
+				           "ext2_free_branches",
+				           "Read failure, inode=%ld, block=%ld",
+				           inode->i_ino, nr);
 				continue;
 			}
 			ext2_free_branches(inode,
@@ -1176,7 +1178,7 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 {
 	__le32 *i_data = EXT2_I(inode)->i_data;
 	struct ext2_inode_info *ei = EXT2_I(inode);
-	int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
+	int addr_per_block = EXT2_ADDR_PER_BLOCK(inode_sb(inode));
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
@@ -1184,8 +1186,8 @@ static void __ext2_truncate_blocks(struct inode *inode, loff_t offset)
 	int n;
 	long iblock;
 	unsigned blocksize;
-	blocksize = inode->i_sb->s_blocksize;
-	iblock = (offset + blocksize-1) >> EXT2_BLOCK_SIZE_BITS(inode->i_sb);
+	blocksize = inode_sb(inode)->s_blocksize;
+	iblock = (offset + blocksize-1) >> EXT2_BLOCK_SIZE_BITS(inode_sb(inode));
 
 #ifdef CONFIG_FS_DAX
 	WARN_ON(!rwsem_is_locked(&ei->dax_sem));
@@ -1300,7 +1302,7 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 		error = iomap_zero_range(inode, newsize,
 					 PAGE_ALIGN(newsize) - newsize, NULL,
 					 &ext2_iomap_ops);
-	} else if (test_opt(inode->i_sb, NOBH))
+	} else if (test_opt(inode_sb(inode), NOBH))
 		error = nobh_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
 	else
@@ -1384,7 +1386,7 @@ void ext2_set_inode_flags(struct inode *inode)
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT2_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
-	if (test_opt(inode->i_sb, DAX) && S_ISREG(inode->i_mode))
+	if (test_opt(inode_sb(inode), DAX) && S_ISREG(inode->i_mode))
 		inode->i_flags |= S_DAX;
 }
 
@@ -1408,7 +1410,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	ei = EXT2_I(inode);
 	ei->i_block_alloc_info = NULL;
 
-	raw_inode = ext2_get_inode(inode->i_sb, ino, &bh);
+	raw_inode = ext2_get_inode(inode_sb(inode), ino, &bh);
 	if (IS_ERR(raw_inode)) {
 		ret = PTR_ERR(raw_inode);
  		goto bad_inode;
@@ -1417,7 +1419,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
-	if (!(test_opt (inode->i_sb, NO_UID32))) {
+	if (!(test_opt (inode_sb(inode), NO_UID32))) {
 		i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
 	}
@@ -1469,7 +1471,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	ei->i_dtime = 0;
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
 	ei->i_state = 0;
-	ei->i_block_group = (ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
+	ei->i_block_group = (ino - 1) / EXT2_INODES_PER_GROUP(inode_sb(inode));
 	ei->i_dir_start_lookup = 0;
 
 	/*
@@ -1481,7 +1483,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext2_file_inode_operations;
-		if (test_opt(inode->i_sb, NOBH)) {
+		if (test_opt(inode_sb(inode), NOBH)) {
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 			inode->i_fop = &ext2_file_operations;
 		} else {
@@ -1491,7 +1493,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext2_dir_inode_operations;
 		inode->i_fop = &ext2_dir_operations;
-		if (test_opt(inode->i_sb, NOBH))
+		if (test_opt(inode_sb(inode), NOBH))
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
@@ -1504,7 +1506,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 		} else {
 			inode->i_op = &ext2_symlink_inode_operations;
 			inode_nohighmem(inode);
-			if (test_opt(inode->i_sb, NOBH))
+			if (test_opt(inode_sb(inode), NOBH))
 				inode->i_mapping->a_ops = &ext2_nobh_aops;
 			else
 				inode->i_mapping->a_ops = &ext2_aops;
@@ -1531,7 +1533,7 @@ struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
 static int __ext2_write_inode(struct inode *inode, int do_sync)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	ino_t ino = inode->i_ino;
 	uid_t uid = i_uid_read(inode);
 	gid_t gid = i_gid_read(inode);
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 0367c0039e68..d927a865d13e 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -113,7 +113,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ret;
 	}
 	case EXT2_IOC_GETRSVSZ:
-		if (test_opt(inode->i_sb, RESERVATION)
+		if (test_opt(inode_sb(inode), RESERVATION)
 			&& S_ISREG(inode->i_mode)
 			&& ei->i_block_alloc_info) {
 			rsv_window_size = ei->i_block_alloc_info->rsv_window_node.rsv_goal_size;
@@ -122,7 +122,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return -ENOTTY;
 	case EXT2_IOC_SETRSVSZ: {
 
-		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
+		if (!test_opt(inode_sb(inode), RESERVATION) ||!S_ISREG(inode->i_mode))
 			return -ENOTTY;
 
 		if (!inode_owner_or_capable(inode))
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index e078075dc66f..2e5f7d3d371b 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -66,9 +66,9 @@ static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry, uns
 	ino = ext2_inode_by_name(dir, &dentry->d_name);
 	inode = NULL;
 	if (ino) {
-		inode = ext2_iget(dir->i_sb, ino);
+		inode = ext2_iget(inode_sb(dir), ino);
 		if (inode == ERR_PTR(-ESTALE)) {
-			ext2_error(dir->i_sb, __func__,
+			ext2_error(inode_sb(dir), __func__,
 					"deleted inode referenced: %lu",
 					(unsigned long) ino);
 			return ERR_PTR(-EIO);
@@ -108,7 +108,7 @@ static int ext2_create (struct inode * dir, struct dentry * dentry, umode_t mode
 		return PTR_ERR(inode);
 
 	inode->i_op = &ext2_file_inode_operations;
-	if (test_opt(inode->i_sb, NOBH)) {
+	if (test_opt(inode_sb(inode), NOBH)) {
 		inode->i_mapping->a_ops = &ext2_nobh_aops;
 		inode->i_fop = &ext2_file_operations;
 	} else {
@@ -126,7 +126,7 @@ static int ext2_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 		return PTR_ERR(inode);
 
 	inode->i_op = &ext2_file_inode_operations;
-	if (test_opt(inode->i_sb, NOBH)) {
+	if (test_opt(inode_sb(inode), NOBH)) {
 		inode->i_mapping->a_ops = &ext2_nobh_aops;
 		inode->i_fop = &ext2_file_operations;
 	} else {
@@ -164,7 +164,7 @@ static int ext2_mknod (struct inode * dir, struct dentry *dentry, umode_t mode,
 static int ext2_symlink (struct inode * dir, struct dentry * dentry,
 	const char * symname)
 {
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	int err = -ENAMETOOLONG;
 	unsigned l = strlen(symname)+1;
 	struct inode * inode;
@@ -185,7 +185,7 @@ static int ext2_symlink (struct inode * dir, struct dentry * dentry,
 		/* slow symlink */
 		inode->i_op = &ext2_symlink_inode_operations;
 		inode_nohighmem(inode);
-		if (test_opt(inode->i_sb, NOBH))
+		if (test_opt(inode_sb(inode), NOBH))
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
@@ -254,7 +254,7 @@ static int ext2_mkdir(struct inode * dir, struct dentry * dentry, umode_t mode)
 
 	inode->i_op = &ext2_dir_inode_operations;
 	inode->i_fop = &ext2_dir_operations;
-	if (test_opt(inode->i_sb, NOBH))
+	if (test_opt(inode_sb(inode), NOBH))
 		inode->i_mapping->a_ops = &ext2_nobh_aops;
 	else
 		inode->i_mapping->a_ops = &ext2_aops;
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 62d9a659a8ff..613cfcae7b48 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -73,7 +73,8 @@
 #ifdef EXT2_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
 		printk(KERN_DEBUG "inode %s:%ld: ", \
-			inode->i_sb->s_id, inode->i_ino); \
+			inode_sb(inode)->s_id,
+		       inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
 	} while (0)
@@ -122,7 +123,7 @@ const struct xattr_handler *ext2_xattr_handlers[] = {
 	NULL
 };
 
-#define EA_BLOCK_CACHE(inode)	(EXT2_SB(inode->i_sb)->s_ea_block_cache)
+#define EA_BLOCK_CACHE(inode)	(EXT2_SB(inode_sb(inode))->s_ea_block_cache)
 
 static inline const struct xattr_handler *
 ext2_xattr_handler(int name_index)
@@ -169,7 +170,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
 	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
-	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
 		goto cleanup;
@@ -178,9 +179,9 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
 	end = bh->b_data + bh->b_size;
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT2_I(inode)->i_file_acl);
+bad_block:	ext2_error(inode_sb(inode), "ext2_xattr_get",
+			     "inode %ld: bad block %d", inode->i_ino,
+			     EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
 	}
@@ -207,8 +208,8 @@ bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
 	if (entry->e_value_block != 0)
 		goto bad_block;
 	size = le32_to_cpu(entry->e_value_size);
-	if (size > inode->i_sb->s_blocksize ||
-	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
+	if (size > inode_sb(inode)->s_blocksize ||
+	    le16_to_cpu(entry->e_value_offs) + size > inode_sb(inode)->s_blocksize)
 		goto bad_block;
 
 	if (ext2_xattr_cache_insert(ea_block_cache, bh))
@@ -259,7 +260,7 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
 	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
-	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
 		goto cleanup;
@@ -268,9 +269,9 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	end = bh->b_data + bh->b_size;
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT2_I(inode)->i_file_acl);
+bad_block:	ext2_error(inode_sb(inode), "ext2_xattr_list",
+			     "inode %ld: bad block %d", inode->i_ino,
+			     EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
 	}
@@ -363,7 +364,7 @@ int
 ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	       const void *value, size_t value_len, int flags)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_header *header = NULL;
 	struct ext2_xattr_entry *here, *last;
@@ -627,7 +628,7 @@ static int
 ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 		struct ext2_xattr_header *header)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *new_bh = NULL;
 	int error;
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
@@ -762,32 +763,32 @@ void
 ext2_xattr_delete_inode(struct inode *inode)
 {
 	struct buffer_head *bh = NULL;
-	struct ext2_sb_info *sbi = EXT2_SB(inode->i_sb);
+	struct ext2_sb_info *sbi = EXT2_SB(inode_sb(inode));
 
 	down_write(&EXT2_I(inode)->xattr_sem);
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
 
 	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 0)) {
-		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: xattr block %d is out of data blocks range",
-			inode->i_ino, EXT2_I(inode)->i_file_acl);
+		ext2_error(inode_sb(inode), "ext2_xattr_delete_inode",
+			   "inode %ld: xattr block %d is out of data blocks range",
+			   inode->i_ino, EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 
-	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT2_I(inode)->i_file_acl);
 	if (!bh) {
-		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: block %d read error", inode->i_ino,
-			EXT2_I(inode)->i_file_acl);
+		ext2_error(inode_sb(inode), "ext2_xattr_delete_inode",
+			   "inode %ld: block %d read error", inode->i_ino,
+			   EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	ea_bdebug(bh, "b_count=%d", atomic_read(&(bh->b_count)));
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
-		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: bad block %d", inode->i_ino,
-			EXT2_I(inode)->i_file_acl);
+		ext2_error(inode_sb(inode), "ext2_xattr_delete_inode",
+			   "inode %ld: bad block %d", inode->i_ino,
+			   EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	lock_buffer(bh);
@@ -910,11 +911,11 @@ ext2_xattr_cache_find(struct inode *inode, struct ext2_xattr_header *header)
 	while (ce) {
 		struct buffer_head *bh;
 
-		bh = sb_bread(inode->i_sb, ce->e_value);
+		bh = sb_bread(inode_sb(inode), ce->e_value);
 		if (!bh) {
-			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
-				"inode %ld: block %ld read error",
-				inode->i_ino, (unsigned long) ce->e_value);
+			ext2_error(inode_sb(inode), "ext2_xattr_cache_find",
+				   "inode %ld: block %ld read error",
+				   inode->i_ino, (unsigned long) ce->e_value);
 		} else {
 			lock_buffer(bh);
 			/*
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index c243a3b4d69d..e2ca8f4829b1 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -22,7 +22,7 @@ ext2_xattr_user_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, void *buffer, size_t size)
 {
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!test_opt(inode_sb(inode), XATTR_USER))
 		return -EOPNOTSUPP;
 	return ext2_xattr_get(inode, EXT2_XATTR_INDEX_USER,
 			      name, buffer, size);
@@ -34,7 +34,7 @@ ext2_xattr_user_set(const struct xattr_handler *handler,
 		    const char *name, const void *value,
 		    size_t size, int flags)
 {
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!test_opt(inode_sb(inode), XATTR_USER))
 		return -EOPNOTSUPP;
 
 	return ext2_xattr_set(inode, EXT2_XATTR_INDEX_USER,
-- 
2.15.1
