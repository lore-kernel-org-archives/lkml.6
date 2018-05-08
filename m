Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbeEHSZe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:25:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755019AbeEHSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:02 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 51/76] fs/nilfs2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:11 -0700
Message-Id: <20180508180436.716-52-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/nilfs2/alloc.c   | 10 ++++-----
 fs/nilfs2/bmap.c    |  4 ++--
 fs/nilfs2/btnode.c  |  6 +++---
 fs/nilfs2/btree.c   | 12 +++++------
 fs/nilfs2/cpfile.c  |  6 +++---
 fs/nilfs2/dat.c     |  2 +-
 fs/nilfs2/dir.c     | 24 ++++++++++-----------
 fs/nilfs2/direct.c  |  4 ++--
 fs/nilfs2/file.c    | 19 ++++++++--------
 fs/nilfs2/gcinode.c |  6 +++---
 fs/nilfs2/ifile.c   |  2 +-
 fs/nilfs2/inode.c   | 62 ++++++++++++++++++++++++++---------------------------
 fs/nilfs2/ioctl.c   | 60 +++++++++++++++++++++++++--------------------------
 fs/nilfs2/mdt.c     | 10 ++++-----
 fs/nilfs2/mdt.h     |  2 +-
 fs/nilfs2/namei.c   | 54 +++++++++++++++++++++++-----------------------
 fs/nilfs2/page.c    |  2 +-
 fs/nilfs2/sufile.c  | 20 ++++++++---------
 fs/nilfs2/sufile.h  |  2 +-
 19 files changed, 154 insertions(+), 153 deletions(-)

diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 03b8ba933eb2..3b3af2e7b2fb 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -622,7 +622,7 @@ void nilfs_palloc_commit_free_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(inode), KERN_WARNING,
 			  "%s (ino=%lu): entry number %llu already freed",
 			  __func__, inode->i_ino,
 			  (unsigned long long)req->pr_entry_nr);
@@ -663,7 +663,7 @@ void nilfs_palloc_abort_alloc_entry(struct inode *inode,
 	lock = nilfs_mdt_bgl_lock(inode, group);
 
 	if (!nilfs_clear_bit_atomic(lock, group_offset, bitmap))
-		nilfs_msg(inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(inode), KERN_WARNING,
 			  "%s (ino=%lu): entry number %llu already freed",
 			  __func__, inode->i_ino,
 			  (unsigned long long)req->pr_entry_nr);
@@ -772,7 +772,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		do {
 			if (!nilfs_clear_bit_atomic(lock, group_offset,
 						    bitmap)) {
-				nilfs_msg(inode->i_sb, KERN_WARNING,
+				nilfs_msg(inode_sb(inode), KERN_WARNING,
 					  "%s (ino=%lu): entry number %llu already freed",
 					  __func__, inode->i_ino,
 					  (unsigned long long)entry_nrs[j]);
@@ -817,7 +817,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 			ret = nilfs_palloc_delete_entry_block(inode,
 							      last_nrs[k]);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
+				nilfs_msg(inode_sb(inode), KERN_WARNING,
 					  "error %d deleting block that object (entry=%llu, ino=%lu) belongs to",
 					  ret, (unsigned long long)last_nrs[k],
 					  inode->i_ino);
@@ -835,7 +835,7 @@ int nilfs_palloc_freev(struct inode *inode, __u64 *entry_nrs, size_t nitems)
 		if (nfree == nilfs_palloc_entries_per_group(inode)) {
 			ret = nilfs_palloc_delete_bitmap_block(inode, group);
 			if (ret && ret != -ENOENT)
-				nilfs_msg(inode->i_sb, KERN_WARNING,
+				nilfs_msg(inode_sb(inode), KERN_WARNING,
 					  "error %d deleting bitmap block of group=%lu, ino=%lu",
 					  ret, group, inode->i_ino);
 		}
diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 01fb1831ca25..9d466fb6e65f 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -30,7 +30,7 @@
 
 struct inode *nilfs_bmap_get_dat(const struct nilfs_bmap *bmap)
 {
-	struct the_nilfs *nilfs = bmap->b_inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(bmap->b_inode)->s_fs_info;
 
 	return nilfs->ns_dat;
 }
@@ -41,7 +41,7 @@ static int nilfs_bmap_convert_error(struct nilfs_bmap *bmap,
 	struct inode *inode = bmap->b_inode;
 
 	if (err == -EINVAL) {
-		__nilfs_error(inode->i_sb, fname,
+		__nilfs_error(inode_sb(inode), fname,
 			      "broken bmap (inode number=%lu)", inode->i_ino);
 		err = -EIO;
 	}
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index c21e0b4454a6..87bc94f23271 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -51,7 +51,7 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 		BUG();
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->b_bdev = inode_sb(inode)->s_bdev;
 	bh->b_blocknr = blocknr;
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
@@ -83,7 +83,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 	if (pblocknr == 0) {
 		pblocknr = blocknr;
 		if (inode->i_ino != NILFS_DAT_INO) {
-			struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+			struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 
 			/* blocknr is a virtual block number */
 			err = nilfs_dat_translate(nilfs->ns_dat, blocknr,
@@ -110,7 +110,7 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		goto found;
 	}
 	set_buffer_mapped(bh);
-	bh->b_bdev = inode->i_sb->s_bdev;
+	bh->b_bdev = inode_sb(inode)->s_bdev;
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 16a7a67a11c9..e8c90e0b3f1f 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -360,7 +360,7 @@ static int nilfs_btree_node_broken(const struct nilfs_btree_node *node,
 		     (flags & NILFS_BTREE_NODE_ROOT) ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_NODE_NCHILDREN_MAX(size))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(inode), KERN_CRIT,
 			  "bad btree node (ino=%lu, blocknr=%llu): level = %d, flags = 0x%x, nchildren = %d",
 			  inode->i_ino, (unsigned long long)blocknr, level,
 			  flags, nchildren);
@@ -390,7 +390,7 @@ static int nilfs_btree_root_broken(const struct nilfs_btree_node *node,
 		     level >= NILFS_BTREE_LEVEL_MAX ||
 		     nchildren < 0 ||
 		     nchildren > NILFS_BTREE_ROOT_NCHILDREN_MAX)) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(inode), KERN_CRIT,
 			  "bad btree root (ino=%lu): level = %d, flags = 0x%x, nchildren = %d",
 			  inode->i_ino, level, flags, nchildren);
 		ret = 1;
@@ -459,7 +459,7 @@ static int nilfs_btree_bad_node(const struct nilfs_bmap *btree,
 {
 	if (unlikely(nilfs_btree_node_get_level(node) != level)) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(btree->b_inode), KERN_CRIT,
 			  "btree level mismatch (ino=%lu): %d != %d",
 			  btree->b_inode->i_ino,
 			  nilfs_btree_node_get_level(node), level);
@@ -517,7 +517,7 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 
  out_no_wait:
 	if (!buffer_uptodate(bh)) {
-		nilfs_msg(btree->b_inode->i_sb, KERN_ERR,
+		nilfs_msg(inode_sb(btree->b_inode), KERN_ERR,
 			  "I/O error reading b-tree node block (ino=%lu, blocknr=%llu)",
 			  btree->b_inode->i_ino, (unsigned long long)ptr);
 		brelse(bh);
@@ -2083,7 +2083,7 @@ static int nilfs_btree_propagate(struct nilfs_bmap *btree,
 	ret = nilfs_btree_do_lookup(btree, path, key, NULL, level + 1, 0);
 	if (ret < 0) {
 		if (unlikely(ret == -ENOENT))
-			nilfs_msg(btree->b_inode->i_sb, KERN_CRIT,
+			nilfs_msg(inode_sb(btree->b_inode), KERN_CRIT,
 				  "writing node/leaf block does not appear in b-tree (ino=%lu) at key=%llu, level=%d",
 				  btree->b_inode->i_ino,
 				  (unsigned long long)key, level);
@@ -2123,7 +2123,7 @@ static void nilfs_btree_add_dirty_buffer(struct nilfs_bmap *btree,
 	if (level < NILFS_BTREE_LEVEL_NODE_MIN ||
 	    level >= NILFS_BTREE_LEVEL_MAX) {
 		dump_stack();
-		nilfs_msg(btree->b_inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(btree->b_inode), KERN_WARNING,
 			  "invalid btree level: %d (key=%llu, ino=%lu, blocknr=%llu)",
 			  level, (unsigned long long)key,
 			  btree->b_inode->i_ino,
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index a15a1601e931..c63985f7955e 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -331,7 +331,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 	int ret, ncps, nicps, nss, count, i;
 
 	if (unlikely(start == 0 || start > end)) {
-		nilfs_msg(cpfile->i_sb, KERN_ERR,
+		nilfs_msg(inode_sb(cpfile), KERN_ERR,
 			  "cannot delete checkpoints: invalid range [%llu, %llu)",
 			  (unsigned long long)start, (unsigned long long)end);
 		return -EINVAL;
@@ -385,7 +385,7 @@ int nilfs_cpfile_delete_checkpoints(struct inode *cpfile,
 								   cpfile, cno);
 					if (ret == 0)
 						continue;
-					nilfs_msg(cpfile->i_sb, KERN_ERR,
+					nilfs_msg(inode_sb(cpfile), KERN_ERR,
 						  "error %d deleting checkpoint block",
 						  ret);
 					break;
@@ -918,7 +918,7 @@ int nilfs_cpfile_change_cpmode(struct inode *cpfile, __u64 cno, int mode)
 
 	switch (mode) {
 	case NILFS_CHECKPOINT:
-		if (nilfs_checkpoint_is_mounted(cpfile->i_sb, cno))
+		if (nilfs_checkpoint_is_mounted(inode_sb(cpfile), cno))
 			/*
 			 * Current implementation does not have to protect
 			 * plain read-only mounts since they are exclusive
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index dffedb2f8817..7f90bce3750b 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -349,7 +349,7 @@ int nilfs_dat_move(struct inode *dat, __u64 vblocknr, sector_t blocknr)
 	kaddr = kmap_atomic(entry_bh->b_page);
 	entry = nilfs_palloc_block_get_entry(dat, vblocknr, entry_bh, kaddr);
 	if (unlikely(entry->de_blocknr == cpu_to_le64(0))) {
-		nilfs_msg(dat->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(dat), KERN_CRIT,
 			  "%s: invalid vblocknr = %llu, [%llu, %llu)",
 			  __func__, (unsigned long long)vblocknr,
 			  (unsigned long long)le64_to_cpu(entry->de_start),
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 582831ab3eb9..c805564d6893 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -70,7 +70,7 @@ static inline __le16 nilfs_rec_len_to_disk(unsigned int len)
  */
 static inline unsigned int nilfs_chunk_size(struct inode *inode)
 {
-	return inode->i_sb->s_blocksize;
+	return inode_sb(inode)->s_blocksize;
 }
 
 static inline void nilfs_put_page(struct page *page)
@@ -125,7 +125,7 @@ static void nilfs_commit_chunk(struct page *page,
 static bool nilfs_check_page(struct page *page)
 {
 	struct inode *dir = page->mapping->host;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	unsigned int chunk_size = nilfs_chunk_size(dir);
 	char *kaddr = page_address(page);
 	unsigned int offs, rec_len;
@@ -273,7 +273,7 @@ static int nilfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	loff_t pos = ctx->pos;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	unsigned int offset = pos & ~PAGE_MASK;
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
@@ -363,8 +363,8 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 			kaddr += nilfs_last_byte(dir, n) - reclen;
 			while ((char *) de <= kaddr) {
 				if (de->rec_len == 0) {
-					nilfs_error(dir->i_sb,
-						"zero-length directory entry");
+					nilfs_error(inode_sb(dir),
+						    "zero-length directory entry");
 					nilfs_put_page(page);
 					goto out;
 				}
@@ -378,10 +378,10 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 			n = 0;
 		/* next page is past the blocks we've got */
 		if (unlikely(n > (dir->i_blocks >> (PAGE_SHIFT - 9)))) {
-			nilfs_error(dir->i_sb,
-			       "dir %lu size %lld exceeds block count %llu",
-			       dir->i_ino, dir->i_size,
-			       (unsigned long long)dir->i_blocks);
+			nilfs_error(inode_sb(dir),
+				    "dir %lu size %lld exceeds block count %llu",
+				    dir->i_ino, dir->i_size,
+				    (unsigned long long)dir->i_blocks);
 			goto out;
 		}
 	} while (n != start);
@@ -487,7 +487,7 @@ int nilfs_add_link(struct dentry *dentry, struct inode *inode)
 				goto got_it;
 			}
 			if (de->rec_len == 0) {
-				nilfs_error(dir->i_sb,
+				nilfs_error(inode_sb(dir),
 					    "zero-length directory entry");
 				err = -EIO;
 				goto out_unlock;
@@ -559,7 +559,7 @@ int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
 
 	while ((char *)de < (char *)dir) {
 		if (de->rec_len == 0) {
-			nilfs_error(inode->i_sb,
+			nilfs_error(inode_sb(inode),
 				    "zero-length directory entry");
 			err = -EIO;
 			goto out;
@@ -646,7 +646,7 @@ int nilfs_empty_dir(struct inode *inode)
 
 		while ((char *)de <= kaddr) {
 			if (de->rec_len == 0) {
-				nilfs_error(inode->i_sb,
+				nilfs_error(inode_sb(inode),
 					    "zero-length directory entry (kaddr=%p, de=%p)",
 					    kaddr, de);
 				goto not_empty;
diff --git a/fs/nilfs2/direct.c b/fs/nilfs2/direct.c
index 96e3ed0d9652..5feca9aa47f4 100644
--- a/fs/nilfs2/direct.c
+++ b/fs/nilfs2/direct.c
@@ -337,14 +337,14 @@ static int nilfs_direct_assign(struct nilfs_bmap *bmap,
 
 	key = nilfs_bmap_data_get_key(bmap, *bh);
 	if (unlikely(key > NILFS_DIRECT_KEY_MAX)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(bmap->b_inode), KERN_CRIT,
 			  "%s (ino=%lu): invalid key: %llu", __func__,
 			  bmap->b_inode->i_ino, (unsigned long long)key);
 		return -EINVAL;
 	}
 	ptr = nilfs_direct_get_ptr(bmap, key);
 	if (unlikely(ptr == NILFS_BMAP_INVALID_PTR)) {
-		nilfs_msg(bmap->b_inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(bmap->b_inode), KERN_CRIT,
 			  "%s (ino=%lu): invalid pointer: %llu", __func__,
 			  bmap->b_inode->i_ino, (unsigned long long)ptr);
 		return -EINVAL;
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index c5fa3dee72fc..a4f813024483 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -38,13 +38,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	if (nilfs_inode_dirty(inode)) {
 		if (datasync)
-			err = nilfs_construct_dsync_segment(inode->i_sb, inode,
+			err = nilfs_construct_dsync_segment(inode_sb(inode),
+							    inode,
 							    start, end);
 		else
-			err = nilfs_construct_segment(inode->i_sb);
+			err = nilfs_construct_segment(inode_sb(inode));
 	}
 
-	nilfs = inode->i_sb->s_fs_info;
+	nilfs = inode_sb(inode)->s_fs_info;
 	if (!err)
 		err = nilfs_flush_device(nilfs);
 
@@ -59,10 +60,10 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	struct nilfs_transaction_info ti;
 	int ret = 0;
 
-	if (unlikely(nilfs_near_disk_full(inode->i_sb->s_fs_info)))
+	if (unlikely(nilfs_near_disk_full(inode_sb(inode)->s_fs_info)))
 		return VM_FAULT_SIGBUS; /* -ENOSPC */
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 	lock_page(page);
 	if (page->mapping != inode->i_mapping ||
 	    page_offset(page) >= i_size_read(inode) || !PageUptodate(page)) {
@@ -99,7 +100,7 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	/*
 	 * fill hole blocks
 	 */
-	ret = nilfs_transaction_begin(inode->i_sb, &ti, 1);
+	ret = nilfs_transaction_begin(inode_sb(inode), &ti, 1);
 	/* never returns -ENOMEM, but may return -ENOSPC */
 	if (unlikely(ret))
 		goto out;
@@ -107,16 +108,16 @@ static int nilfs_page_mkwrite(struct vm_fault *vmf)
 	file_update_time(vma->vm_file);
 	ret = block_page_mkwrite(vma, vmf, nilfs_get_block);
 	if (ret) {
-		nilfs_transaction_abort(inode->i_sb);
+		nilfs_transaction_abort(inode_sb(inode));
 		goto out;
 	}
 	nilfs_set_file_dirty(inode, 1 << (PAGE_SHIFT - inode->i_blkbits));
-	nilfs_transaction_commit(inode->i_sb);
+	nilfs_transaction_commit(inode_sb(inode));
 
  mapped:
 	wait_for_stable_page(page);
  out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return block_page_mkwrite_return(ret);
 }
 
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 853a831dcde0..af751dd4fa54 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -79,7 +79,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		goto out;
 
 	if (pbn == 0) {
-		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+		struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
 		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
@@ -95,7 +95,7 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	}
 
 	if (!buffer_mapped(bh)) {
-		bh->b_bdev = inode->i_sb->s_bdev;
+		bh->b_bdev = inode_sb(inode)->s_bdev;
 		set_buffer_mapped(bh);
 	}
 	bh->b_blocknr = pbn;
@@ -151,7 +151,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
 	if (!buffer_uptodate(bh)) {
 		struct inode *inode = bh->b_page->mapping->host;
 
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_msg(inode_sb(inode), KERN_ERR,
 			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
 			  buffer_nilfs_node(bh) ? "node" : "data",
 			  inode->i_ino, (unsigned long long)bh->b_blocknr);
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index b8fa45c20c63..841f7f6c5e29 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -141,7 +141,7 @@ int nilfs_ifile_delete_inode(struct inode *ifile, ino_t ino)
 int nilfs_ifile_get_inode_block(struct inode *ifile, ino_t ino,
 				struct buffer_head **out_bh)
 {
-	struct super_block *sb = ifile->i_sb;
+	struct super_block *sb = inode_sb(ifile);
 	int err;
 
 	if (unlikely(!NILFS_VALID_INODE(sb, ino))) {
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6a612d832e7d..88f590eccdaa 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -80,7 +80,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 		    struct buffer_head *bh_result, int create)
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	__u64 blknum = 0;
 	int err = 0, ret;
 	unsigned int maxblocks = bh_result->b_size >> inode->i_blkbits;
@@ -89,7 +89,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 	ret = nilfs_bmap_lookup_contig(ii->i_bmap, blkoff, &blknum, maxblocks);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 	if (ret >= 0) {	/* found */
-		map_bh(bh_result, inode->i_sb, blknum);
+		map_bh(bh_result, inode_sb(inode), blknum);
 		if (ret > 0)
 			bh_result->b_size = (ret << inode->i_blkbits);
 		goto out;
@@ -99,7 +99,7 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 		struct nilfs_transaction_info ti;
 
 		bh_result->b_blocknr = 0;
-		err = nilfs_transaction_begin(inode->i_sb, &ti, 1);
+		err = nilfs_transaction_begin(inode_sb(inode), &ti, 1);
 		if (unlikely(err))
 			goto out;
 		err = nilfs_bmap_insert(ii->i_bmap, blkoff,
@@ -112,21 +112,21 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 				 * However, the page having this block must
 				 * be locked in this case.
 				 */
-				nilfs_msg(inode->i_sb, KERN_WARNING,
+				nilfs_msg(inode_sb(inode), KERN_WARNING,
 					  "%s (ino=%lu): a race condition while inserting a data block at offset=%llu",
 					  __func__, inode->i_ino,
 					  (unsigned long long)blkoff);
 				err = 0;
 			}
-			nilfs_transaction_abort(inode->i_sb);
+			nilfs_transaction_abort(inode_sb(inode));
 			goto out;
 		}
 		nilfs_mark_inode_dirty_sync(inode);
-		nilfs_transaction_commit(inode->i_sb); /* never fails */
+		nilfs_transaction_commit(inode_sb(inode)); /* never fails */
 		/* Error handling should be detailed */
 		set_buffer_new(bh_result);
 		set_buffer_delay(bh_result);
-		map_bh(bh_result, inode->i_sb, 0);
+		map_bh(bh_result, inode_sb(inode), 0);
 		/* Disk block number must be changed to proper value */
 
 	} else if (ret == -ENOENT) {
@@ -174,13 +174,13 @@ static int nilfs_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int err = 0;
 
-	if (sb_rdonly(inode->i_sb)) {
+	if (sb_rdonly(inode_sb(inode))) {
 		nilfs_clear_dirty_pages(mapping, false);
 		return -EROFS;
 	}
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
-		err = nilfs_construct_dsync_segment(inode->i_sb, inode,
+		err = nilfs_construct_dsync_segment(inode_sb(inode), inode,
 						    wbc->range_start,
 						    wbc->range_end);
 	return err;
@@ -191,7 +191,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 	struct inode *inode = page->mapping->host;
 	int err;
 
-	if (sb_rdonly(inode->i_sb)) {
+	if (sb_rdonly(inode_sb(inode))) {
 		/*
 		 * It means that filesystem was remounted in read-only
 		 * mode because of error or metadata corruption. But we
@@ -207,11 +207,11 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 	unlock_page(page);
 
 	if (wbc->sync_mode == WB_SYNC_ALL) {
-		err = nilfs_construct_segment(inode->i_sb);
+		err = nilfs_construct_segment(inode_sb(inode));
 		if (unlikely(err))
 			return err;
 	} else if (wbc->for_reclaim)
-		nilfs_flush_segment(inode->i_sb, inode->i_ino);
+		nilfs_flush_segment(inode_sb(inode), inode->i_ino);
 
 	return 0;
 }
@@ -268,7 +268,7 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 
 {
 	struct inode *inode = mapping->host;
-	int err = nilfs_transaction_begin(inode->i_sb, NULL, 1);
+	int err = nilfs_transaction_begin(inode_sb(inode), NULL, 1);
 
 	if (unlikely(err))
 		return err;
@@ -277,7 +277,7 @@ static int nilfs_write_begin(struct file *file, struct address_space *mapping,
 				nilfs_get_block);
 	if (unlikely(err)) {
 		nilfs_write_failed(mapping, pos + len);
-		nilfs_transaction_abort(inode->i_sb);
+		nilfs_transaction_abort(inode_sb(inode));
 	}
 	return err;
 }
@@ -296,7 +296,7 @@ static int nilfs_write_end(struct file *file, struct address_space *mapping,
 	copied = generic_write_end(file, mapping, pos, len, copied, page,
 				   fsdata);
 	nilfs_set_file_dirty(inode, nr_dirty);
-	err = nilfs_transaction_commit(inode->i_sb);
+	err = nilfs_transaction_commit(inode_sb(inode));
 	return err ? : copied;
 }
 
@@ -339,7 +339,7 @@ static int nilfs_insert_inode_locked(struct inode *inode,
 
 struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct the_nilfs *nilfs = sb->s_fs_info;
 	struct inode *inode;
 	struct nilfs_inode_info *ii;
@@ -651,7 +651,7 @@ void nilfs_write_inode_common(struct inode *inode,
 	raw_inode->i_generation = cpu_to_le32(inode->i_generation);
 
 	if (NILFS_ROOT_METADATA_FILE(inode->i_ino)) {
-		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+		struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 
 		/* zero-fill unused portion in the case of super root block */
 		raw_inode->i_xattr = 0;
@@ -717,13 +717,13 @@ static void nilfs_truncate_bmap(struct nilfs_inode_info *ii,
 
 	b -= min_t(__u64, NILFS_MAX_TRUNCATE_BLOCKS, b - from);
 	ret = nilfs_bmap_truncate(ii->i_bmap, b);
-	nilfs_relax_pressure_in_lock(ii->vfs_inode.i_sb);
+	nilfs_relax_pressure_in_lock(inode_sb(&ii->vfs_inode));
 	if (!ret || (ret == -ENOMEM &&
 		     nilfs_bmap_truncate(ii->i_bmap, b) == 0))
 		goto repeat;
 
 failed:
-	nilfs_msg(ii->vfs_inode.i_sb, KERN_WARNING,
+	nilfs_msg(inode_sb(&ii->vfs_inode), KERN_WARNING,
 		  "error %d truncating bmap (ino=%lu)", ret,
 		  ii->vfs_inode.i_ino);
 }
@@ -733,7 +733,7 @@ void nilfs_truncate(struct inode *inode)
 	unsigned long blkoff;
 	unsigned int blocksize;
 	struct nilfs_transaction_info ti;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 
 	if (!test_bit(NILFS_I_BMAP, &ii->i_state))
@@ -788,7 +788,7 @@ static void nilfs_clear_inode(struct inode *inode)
 void nilfs_evict_inode(struct inode *inode)
 {
 	struct nilfs_transaction_info ti;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	int ret;
 
@@ -826,7 +826,7 @@ int nilfs_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	struct nilfs_transaction_info ti;
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int err;
 
 	err = setattr_prepare(dentry, iattr);
@@ -873,7 +873,7 @@ int nilfs_permission(struct inode *inode, int mask)
 
 int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_inode_info *ii = NILFS_I(inode);
 	int err;
 
@@ -902,7 +902,7 @@ int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
 int nilfs_inode_dirty(struct inode *inode)
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	int ret = 0;
 
 	if (!list_empty(&ii->i_dirty)) {
@@ -917,7 +917,7 @@ int nilfs_inode_dirty(struct inode *inode)
 int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 {
 	struct nilfs_inode_info *ii = NILFS_I(inode);
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 
 	atomic_add(nr_dirty, &nilfs->ns_ndirtyblks);
 
@@ -936,7 +936,7 @@ int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty)
 			 * This will happen when somebody is freeing
 			 * this inode.
 			 */
-			nilfs_msg(inode->i_sb, KERN_WARNING,
+			nilfs_msg(inode_sb(inode), KERN_WARNING,
 				  "cannot set file dirty (ino=%lu): the file is being freed",
 				  inode->i_ino);
 			spin_unlock(&nilfs->ns_inode_lock);
@@ -959,7 +959,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 
 	err = nilfs_load_inode_block(inode, &ibh);
 	if (unlikely(err)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(inode), KERN_WARNING,
 			  "cannot mark inode dirty (ino=%lu): error %d loading inode block",
 			  inode->i_ino, err);
 		return err;
@@ -987,7 +987,7 @@ void nilfs_dirty_inode(struct inode *inode, int flags)
 	struct nilfs_mdt_info *mdi = NILFS_MDT(inode);
 
 	if (is_bad_inode(inode)) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(inode), KERN_WARNING,
 			  "tried to mark bad_inode dirty. ignored.");
 		dump_stack();
 		return;
@@ -996,15 +996,15 @@ void nilfs_dirty_inode(struct inode *inode, int flags)
 		nilfs_mdt_mark_dirty(inode);
 		return;
 	}
-	nilfs_transaction_begin(inode->i_sb, &ti, 0);
+	nilfs_transaction_begin(inode_sb(inode), &ti, 0);
 	__nilfs_mark_inode_dirty(inode, flags);
-	nilfs_transaction_commit(inode->i_sb); /* never fails */
+	nilfs_transaction_commit(inode_sb(inode)); /* never fails */
 }
 
 int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 __u64 start, __u64 len)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	__u64 logical = 0, phys = 0, size = 0;
 	__u32 flags = 0;
 	loff_t isize;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 1d2c3d7711fe..7f1877f959d7 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -166,7 +166,7 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		goto out;
 
-	ret = nilfs_transaction_begin(inode->i_sb, &ti, 0);
+	ret = nilfs_transaction_begin(inode_sb(inode), &ti, 0);
 	if (ret)
 		goto out;
 
@@ -179,7 +179,7 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
 		nilfs_set_transaction_flag(NILFS_TI_SYNC);
 
 	nilfs_mark_inode_dirty(inode);
-	ret = nilfs_transaction_commit(inode->i_sb);
+	ret = nilfs_transaction_commit(inode_sb(inode));
 out:
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
@@ -216,7 +216,7 @@ static int nilfs_ioctl_getversion(struct inode *inode, void __user *argp)
 static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
 				     unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_transaction_info ti;
 	struct nilfs_cpmode cpmode;
 	int ret;
@@ -234,13 +234,13 @@ static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
 
 	mutex_lock(&nilfs->ns_snapshot_mount_mutex);
 
-	nilfs_transaction_begin(inode->i_sb, &ti, 0);
+	nilfs_transaction_begin(inode_sb(inode), &ti, 0);
 	ret = nilfs_cpfile_change_cpmode(
 		nilfs->ns_cpfile, cpmode.cm_cno, cpmode.cm_mode);
 	if (unlikely(ret < 0))
-		nilfs_transaction_abort(inode->i_sb);
+		nilfs_transaction_abort(inode_sb(inode));
 	else
-		nilfs_transaction_commit(inode->i_sb); /* never fails */
+		nilfs_transaction_commit(inode_sb(inode)); /* never fails */
 
 	mutex_unlock(&nilfs->ns_snapshot_mount_mutex);
 out:
@@ -271,7 +271,7 @@ static int
 nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
 			      unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_transaction_info ti;
 	__u64 cno;
 	int ret;
@@ -287,12 +287,12 @@ nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
 	if (copy_from_user(&cno, argp, sizeof(cno)))
 		goto out;
 
-	nilfs_transaction_begin(inode->i_sb, &ti, 0);
+	nilfs_transaction_begin(inode_sb(inode), &ti, 0);
 	ret = nilfs_cpfile_delete_checkpoint(nilfs->ns_cpfile, cno);
 	if (unlikely(ret < 0))
-		nilfs_transaction_abort(inode->i_sb);
+		nilfs_transaction_abort(inode_sb(inode));
 	else
-		nilfs_transaction_commit(inode->i_sb); /* never fails */
+		nilfs_transaction_commit(inode_sb(inode)); /* never fails */
 out:
 	mnt_drop_write_file(filp);
 	return ret;
@@ -350,7 +350,7 @@ nilfs_ioctl_do_get_cpinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
 static int nilfs_ioctl_get_cpstat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_cpstat cpstat;
 	int ret;
 
@@ -417,7 +417,7 @@ nilfs_ioctl_do_get_suinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
 static int nilfs_ioctl_get_sustat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_sustat sustat;
 	int ret;
 
@@ -526,7 +526,7 @@ nilfs_ioctl_do_get_bdescs(struct the_nilfs *nilfs, __u64 *posp, int flags,
 static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_argv argv;
 	int ret;
 
@@ -583,7 +583,7 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
-			nilfs_msg(inode->i_sb, KERN_CRIT,
+			nilfs_msg(inode_sb(inode), KERN_CRIT,
 				  "%s: invalid virtual block address (%s): ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
 				  __func__, vdesc->vd_flags ? "node" : "data",
 				  (unsigned long long)vdesc->vd_ino,
@@ -594,7 +594,7 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 		return ret;
 	}
 	if (unlikely(!list_empty(&bh->b_assoc_buffers))) {
-		nilfs_msg(inode->i_sb, KERN_CRIT,
+		nilfs_msg(inode_sb(inode), KERN_CRIT,
 			  "%s: conflicting %s buffer: ino=%llu, cno=%llu, offset=%llu, blocknr=%llu, vblocknr=%llu",
 			  __func__, vdesc->vd_flags ? "node" : "data",
 			  (unsigned long long)vdesc->vd_ino,
@@ -916,7 +916,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 		ret = PTR_ERR(kbufs[4]);
 		goto out;
 	}
-	nilfs = inode->i_sb->s_fs_info;
+	nilfs = inode_sb(inode)->s_fs_info;
 
 	for (n = 0; n < 4; n++) {
 		ret = -EINVAL;
@@ -959,15 +959,15 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 		goto out_free;
 	}
 
-	ret = nilfs_ioctl_move_blocks(inode->i_sb, &argv[0], kbufs[0]);
+	ret = nilfs_ioctl_move_blocks(inode_sb(inode), &argv[0], kbufs[0]);
 	if (ret < 0) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_msg(inode_sb(inode), KERN_ERR,
 			  "error %d preparing GC: cannot read source blocks",
 			  ret);
 	} else {
 		if (nilfs_sb_need_update(nilfs))
 			set_nilfs_discontinued(nilfs);
-		ret = nilfs_clean_segments(inode->i_sb, argv, kbufs);
+		ret = nilfs_clean_segments(inode_sb(inode), argv, kbufs);
 	}
 
 	nilfs_remove_all_gcinodes(nilfs);
@@ -1016,11 +1016,11 @@ static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
 	int ret;
 	struct the_nilfs *nilfs;
 
-	ret = nilfs_construct_segment(inode->i_sb);
+	ret = nilfs_construct_segment(inode_sb(inode));
 	if (ret < 0)
 		return ret;
 
-	nilfs = inode->i_sb->s_fs_info;
+	nilfs = inode_sb(inode)->s_fs_info;
 	ret = nilfs_flush_device(nilfs);
 	if (ret < 0)
 		return ret;
@@ -1060,7 +1060,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
 	if (copy_from_user(&newsize, argp, sizeof(newsize)))
 		goto out_drop_write;
 
-	ret = nilfs_resize_fs(inode->i_sb, newsize);
+	ret = nilfs_resize_fs(inode_sb(inode), newsize);
 
 out_drop_write:
 	mnt_drop_write_file(filp);
@@ -1081,7 +1081,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
  */
 static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct request_queue *q = bdev_get_queue(nilfs->ns_bdev);
 	struct fstrim_range range;
 	int ret;
@@ -1123,7 +1123,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
  */
 static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	__u64 range[2];
 	__u64 minseg, maxseg;
 	unsigned long segbytes;
@@ -1137,7 +1137,7 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 		goto out;
 
 	ret = -ERANGE;
-	if (range[1] > i_size_read(inode->i_sb->s_bdev->bd_inode))
+	if (range[1] > i_size_read(inode_sb(inode)->s_bdev->bd_inode))
 		goto out;
 
 	segbytes = nilfs->ns_blocks_per_segment * nilfs->ns_blocksize;
@@ -1183,7 +1183,7 @@ static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
 						  void *, size_t, size_t))
 
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_argv argv;
 	int ret;
 
@@ -1229,7 +1229,7 @@ static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
 static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 				unsigned int cmd, void __user *argp)
 {
-	struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(inode)->s_fs_info;
 	struct nilfs_transaction_info ti;
 	struct nilfs_argv argv;
 	size_t len;
@@ -1276,13 +1276,13 @@ static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 		goto out_free;
 	}
 
-	nilfs_transaction_begin(inode->i_sb, &ti, 0);
+	nilfs_transaction_begin(inode_sb(inode), &ti, 0);
 	ret = nilfs_sufile_set_suinfo(nilfs->ns_sufile, kbuf, argv.v_size,
 			argv.v_nmembs);
 	if (unlikely(ret < 0))
-		nilfs_transaction_abort(inode->i_sb);
+		nilfs_transaction_abort(inode_sb(inode));
 	else
-		nilfs_transaction_commit(inode->i_sb); /* never fails */
+		nilfs_transaction_commit(inode_sb(inode)); /* never fails */
 
 out_free:
 	vfree(kbuf);
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c6bc1033e7d2..d208de0e8fd4 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -78,7 +78,7 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 						     struct buffer_head *,
 						     void *))
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct nilfs_transaction_info ti;
 	struct buffer_head *bh;
 	int err;
@@ -153,7 +153,7 @@ nilfs_mdt_submit_block(struct inode *inode, unsigned long blkoff,
 		unlock_buffer(bh);
 		goto failed_bh;
 	}
-	map_bh(bh, inode->i_sb, (sector_t)blknum);
+	map_bh(bh, inode_sb(inode), (sector_t)blknum);
 
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
@@ -208,7 +208,7 @@ static int nilfs_mdt_read_block(struct inode *inode, unsigned long block,
  out_no_wait:
 	err = -EIO;
 	if (!buffer_uptodate(first_bh)) {
-		nilfs_msg(inode->i_sb, KERN_ERR,
+		nilfs_msg(inode_sb(inode), KERN_ERR,
 			  "I/O error reading meta-data file (ino=%lu, block-offset=%lu)",
 			  inode->i_ino, block);
 		goto failed_bh;
@@ -413,7 +413,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 	struct super_block *sb;
 	int err = 0;
 
-	if (inode && sb_rdonly(inode->i_sb)) {
+	if (inode && sb_rdonly(inode_sb(inode))) {
 		/*
 		 * It means that filesystem was remounted in read-only
 		 * mode because of error or metadata corruption. But we
@@ -431,7 +431,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 	if (!inode)
 		return 0;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		err = nilfs_construct_segment(sb);
diff --git a/fs/nilfs2/mdt.h b/fs/nilfs2/mdt.h
index 3f67f3932097..cf9f18dd0b66 100644
--- a/fs/nilfs2/mdt.h
+++ b/fs/nilfs2/mdt.h
@@ -114,7 +114,7 @@ static inline void nilfs_mdt_clear_dirty(struct inode *inode)
 
 static inline __u64 nilfs_mdt_cno(struct inode *inode)
 {
-	return ((struct the_nilfs *)inode->i_sb->s_fs_info)->ns_cno;
+	return ((struct the_nilfs *) inode_sb(inode)->s_fs_info)->ns_cno;
 }
 
 static inline spinlock_t *
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 1a2894aa0194..a66c98a508be 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -70,7 +70,7 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = nilfs_inode_by_name(dir, &dentry->d_name);
-	inode = ino ? nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino) : NULL;
+	inode = ino ? nilfs_iget(inode_sb(dir), NILFS_I(dir)->i_root, ino) : NULL;
 	return d_splice_alias(inode, dentry);
 }
 
@@ -89,7 +89,7 @@ static int nilfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 1);
 	if (err)
 		return err;
 	inode = nilfs_new_inode(dir, mode);
@@ -102,9 +102,9 @@ static int nilfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		err = nilfs_add_nondir(dentry, inode);
 	}
 	if (!err)
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 }
@@ -116,7 +116,7 @@ nilfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 1);
 	if (err)
 		return err;
 	inode = nilfs_new_inode(dir, mode);
@@ -127,9 +127,9 @@ nilfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
 		err = nilfs_add_nondir(dentry, inode);
 	}
 	if (!err)
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 }
@@ -138,7 +138,7 @@ static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
 			 const char *symname)
 {
 	struct nilfs_transaction_info ti;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	unsigned int l = strlen(symname) + 1;
 	struct inode *inode;
 	int err;
@@ -146,7 +146,7 @@ static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
 	if (l > sb->s_blocksize)
 		return -ENAMETOOLONG;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 1);
 	if (err)
 		return err;
 
@@ -169,9 +169,9 @@ static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
 	err = nilfs_add_nondir(dentry, inode);
 out:
 	if (!err)
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 
@@ -190,7 +190,7 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 1);
 	if (err)
 		return err;
 
@@ -201,11 +201,11 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	err = nilfs_add_link(dentry, inode);
 	if (!err) {
 		d_instantiate(dentry, inode);
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	} else {
 		inode_dec_link_count(inode);
 		iput(inode);
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 	}
 
 	return err;
@@ -217,7 +217,7 @@ static int nilfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 1);
 	if (err)
 		return err;
 
@@ -247,9 +247,9 @@ static int nilfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	unlock_new_inode(inode);
 out:
 	if (!err)
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 
@@ -283,7 +283,7 @@ static int nilfs_do_unlink(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	if (!inode->i_nlink) {
-		nilfs_msg(inode->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(inode), KERN_WARNING,
 			  "deleting nonexistent file (ino=%lu), %d",
 			  inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
@@ -304,7 +304,7 @@ static int nilfs_unlink(struct inode *dir, struct dentry *dentry)
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 0);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 0);
 	if (err)
 		return err;
 
@@ -313,9 +313,9 @@ static int nilfs_unlink(struct inode *dir, struct dentry *dentry)
 	if (!err) {
 		nilfs_mark_inode_dirty(dir);
 		nilfs_mark_inode_dirty(d_inode(dentry));
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	} else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 }
@@ -326,7 +326,7 @@ static int nilfs_rmdir(struct inode *dir, struct dentry *dentry)
 	struct nilfs_transaction_info ti;
 	int err;
 
-	err = nilfs_transaction_begin(dir->i_sb, &ti, 0);
+	err = nilfs_transaction_begin(inode_sb(dir), &ti, 0);
 	if (err)
 		return err;
 
@@ -342,9 +342,9 @@ static int nilfs_rmdir(struct inode *dir, struct dentry *dentry)
 		}
 	}
 	if (!err)
-		err = nilfs_transaction_commit(dir->i_sb);
+		err = nilfs_transaction_commit(inode_sb(dir));
 	else
-		nilfs_transaction_abort(dir->i_sb);
+		nilfs_transaction_abort(inode_sb(dir));
 
 	return err;
 }
@@ -365,7 +365,7 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	err = nilfs_transaction_begin(old_dir->i_sb, &ti, 1);
+	err = nilfs_transaction_begin(inode_sb(old_dir), &ti, 1);
 	if (unlikely(err))
 		return err;
 
@@ -425,7 +425,7 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-	err = nilfs_transaction_commit(old_dir->i_sb);
+	err = nilfs_transaction_commit(inode_sb(old_dir));
 	return err;
 
 out_dir:
@@ -437,7 +437,7 @@ static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	kunmap(old_page);
 	put_page(old_page);
 out:
-	nilfs_transaction_abort(old_dir->i_sb);
+	nilfs_transaction_abort(inode_sb(old_dir));
 	return err;
 }
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 68241512d7c1..2c0a5bd69d72 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -397,7 +397,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 void nilfs_clear_dirty_page(struct page *page, bool silent)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	BUG_ON(!PageLocked(page));
 
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index c7fa139d50e8..c280be52cea3 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -180,7 +180,7 @@ int nilfs_sufile_updatev(struct inode *sufile, __u64 *segnumv, size_t nsegs,
 	down_write(&NILFS_MDT(sufile)->mi_sem);
 	for (seg = segnumv; seg < segnumv + nsegs; seg++) {
 		if (unlikely(*seg >= nilfs_sufile_get_nsegments(sufile))) {
-			nilfs_msg(sufile->i_sb, KERN_WARNING,
+			nilfs_msg(inode_sb(sufile), KERN_WARNING,
 				  "%s: invalid segment number: %llu",
 				  __func__, (unsigned long long)*seg);
 			nerr++;
@@ -239,7 +239,7 @@ int nilfs_sufile_update(struct inode *sufile, __u64 segnum, int create,
 	int ret;
 
 	if (unlikely(segnum >= nilfs_sufile_get_nsegments(sufile))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(sufile), KERN_WARNING,
 			  "%s: invalid segment number: %llu",
 			  __func__, (unsigned long long)segnum);
 		return -EINVAL;
@@ -419,7 +419,7 @@ void nilfs_sufile_do_cancel_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (unlikely(!nilfs_segment_usage_clean(su))) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(sufile), KERN_WARNING,
 			  "%s: segment %llu must be clean", __func__,
 			  (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
@@ -477,7 +477,7 @@ void nilfs_sufile_do_free(struct inode *sufile, __u64 segnum,
 	kaddr = kmap_atomic(su_bh->b_page);
 	su = nilfs_sufile_block_get_segment_usage(sufile, segnum, su_bh, kaddr);
 	if (nilfs_segment_usage_clean(su)) {
-		nilfs_msg(sufile->i_sb, KERN_WARNING,
+		nilfs_msg(inode_sb(sufile), KERN_WARNING,
 			  "%s: segment %llu is already clean",
 			  __func__, (unsigned long long)segnum);
 		kunmap_atomic(kaddr);
@@ -575,7 +575,7 @@ int nilfs_sufile_get_stat(struct inode *sufile, struct nilfs_sustat *sustat)
 {
 	struct buffer_head *header_bh;
 	struct nilfs_sufile_header *header;
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	void *kaddr;
 	int ret;
 
@@ -649,7 +649,7 @@ void nilfs_sufile_do_set_error(struct inode *sufile, __u64 segnum,
 static int nilfs_sufile_truncate_range(struct inode *sufile,
 				       __u64 start, __u64 end)
 {
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	struct buffer_head *header_bh;
 	struct buffer_head *su_bh;
 	struct nilfs_segment_usage *su, *su2;
@@ -752,7 +752,7 @@ static int nilfs_sufile_truncate_range(struct inode *sufile,
  */
 int nilfs_sufile_resize(struct inode *sufile, __u64 newnsegs)
 {
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	struct buffer_head *header_bh;
 	struct nilfs_sufile_header *header;
 	struct nilfs_sufile_info *sui = NILFS_SUI(sufile);
@@ -825,7 +825,7 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 	struct nilfs_segment_usage *su;
 	struct nilfs_suinfo *si = buf;
 	size_t susz = NILFS_MDT(sufile)->mi_entry_size;
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	void *kaddr;
 	unsigned long nsegs, segusages_per_block;
 	ssize_t n;
@@ -899,7 +899,7 @@ ssize_t nilfs_sufile_get_suinfo(struct inode *sufile, __u64 segnum, void *buf,
 ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
 				unsigned int supsz, size_t nsup)
 {
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	struct buffer_head *header_bh, *bh;
 	struct nilfs_suinfo_update *sup, *supend = buf + supsz * nsup;
 	struct nilfs_segment_usage *su;
@@ -1025,7 +1025,7 @@ ssize_t nilfs_sufile_set_suinfo(struct inode *sufile, void *buf,
  */
 int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 {
-	struct the_nilfs *nilfs = sufile->i_sb->s_fs_info;
+	struct the_nilfs *nilfs = inode_sb(sufile)->s_fs_info;
 	struct buffer_head *su_bh;
 	struct nilfs_segment_usage *su;
 	void *kaddr;
diff --git a/fs/nilfs2/sufile.h b/fs/nilfs2/sufile.h
index 673a891350f4..0ed86ae80b32 100644
--- a/fs/nilfs2/sufile.h
+++ b/fs/nilfs2/sufile.h
@@ -26,7 +26,7 @@
 
 static inline unsigned long nilfs_sufile_get_nsegments(struct inode *sufile)
 {
-	return ((struct the_nilfs *)sufile->i_sb->s_fs_info)->ns_nsegments;
+	return ((struct the_nilfs *) inode_sb(sufile)->s_fs_info)->ns_nsegments;
 }
 
 unsigned long nilfs_sufile_get_ncleansegs(struct inode *sufile);
-- 
2.15.1
