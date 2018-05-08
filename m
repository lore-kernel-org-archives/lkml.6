Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755571AbeEHSFK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:53858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755428AbeEHSFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:00 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 08/76] mm: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:28 -0700
Message-Id: <20180508180436.716-9-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 mm/cleancache.c     | 10 +++++-----
 mm/filemap.c        | 12 ++++++------
 mm/hugetlb.c        |  2 +-
 mm/memory-failure.c |  2 +-
 mm/shmem.c          | 29 +++++++++++++++--------------
 mm/swapfile.c       |  4 ++--
 6 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/mm/cleancache.c b/mm/cleancache.c
index f7b9fdc79d97..b4cabc316aea 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -147,7 +147,7 @@ static int cleancache_get_key(struct inode *inode,
 {
 	int (*fhfn)(struct inode *, __u32 *fh, int *, struct inode *);
 	int len = 0, maxlen = CLEANCACHE_KEY_MAX;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	key->u.ino = inode->i_ino;
 	if (sb->s_export_op != NULL) {
@@ -186,7 +186,7 @@ int __cleancache_get_page(struct page *page)
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	pool_id = page->mapping->host->i_sb->cleancache_poolid;
+	pool_id = inode_sb(page->mapping->host)->cleancache_poolid;
 	if (pool_id < 0)
 		goto out;
 
@@ -224,7 +224,7 @@ void __cleancache_put_page(struct page *page)
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	pool_id = page->mapping->host->i_sb->cleancache_poolid;
+	pool_id = inode_sb(page->mapping->host)->cleancache_poolid;
 	if (pool_id >= 0 &&
 		cleancache_get_key(page->mapping->host, &key) >= 0) {
 		cleancache_ops->put_page(pool_id, key, page->index, page);
@@ -245,7 +245,7 @@ void __cleancache_invalidate_page(struct address_space *mapping,
 					struct page *page)
 {
 	/* careful... page->mapping is NULL sometimes when this is called */
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
+	int pool_id = inode_sb(mapping->host)->cleancache_poolid;
 	struct cleancache_filekey key = { .u.key = { 0 } };
 
 	if (!cleancache_ops)
@@ -273,7 +273,7 @@ EXPORT_SYMBOL(__cleancache_invalidate_page);
  */
 void __cleancache_invalidate_inode(struct address_space *mapping)
 {
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
+	int pool_id = inode_sb(mapping->host)->cleancache_poolid;
 	struct cleancache_filekey key = { .u.key = { 0 } };
 
 	if (!cleancache_ops)
diff --git a/mm/filemap.c b/mm/filemap.c
index 693f62212a59..c81943b5ab3d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2064,9 +2064,9 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	unsigned int prev_offset;
 	int error = 0;
 
-	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
+	if (unlikely(*ppos >= inode_sb(inode)->s_maxbytes))
 		return 0;
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode_sb(inode)->s_maxbytes);
 
 	index = *ppos >> PAGE_SHIFT;
 	prev_index = ra->prev_pos >> PAGE_SHIFT;
@@ -2702,7 +2702,7 @@ int filemap_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	int ret = VM_FAULT_LOCKED;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 	file_update_time(vmf->vma->vm_file);
 	lock_page(page);
 	if (page->mapping != inode->i_mapping) {
@@ -2718,7 +2718,7 @@ int filemap_page_mkwrite(struct vm_fault *vmf)
 	set_page_dirty(page);
 	wait_for_stable_page(page);
 out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 EXPORT_SYMBOL(filemap_page_mkwrite);
@@ -2965,10 +2965,10 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	 * exceeded without writing data we send a signal and return EFBIG.
 	 * Linus frestrict idea will clean these up nicely..
 	 */
-	if (unlikely(pos >= inode->i_sb->s_maxbytes))
+	if (unlikely(pos >= inode_sb(inode)->s_maxbytes))
 		return -EFBIG;
 
-	iov_iter_truncate(from, inode->i_sb->s_maxbytes - pos);
+	iov_iter_truncate(from, inode_sb(inode)->s_maxbytes - pos);
 	return iov_iter_count(from);
 }
 EXPORT_SYMBOL(generic_write_checks);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 976bbc5646fe..350ca2f2a05e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -209,7 +209,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
 
 static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
 {
-	return HUGETLBFS_SB(inode->i_sb)->spool;
+	return HUGETLBFS_SB(inode_sb(inode))->spool;
 }
 
 static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8291b75f42c8..08e2367985f8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -98,7 +98,7 @@ static int hwpoison_filter_dev(struct page *p)
 	if (mapping == NULL || mapping->host == NULL)
 		return -EINVAL;
 
-	dev = mapping->host->i_sb->s_dev;
+	dev = inode_sb(mapping->host)->s_dev;
 	if (hwpoison_filter_dev_major != ~0U &&
 	    hwpoison_filter_dev_major != MAJOR(dev))
 		return -EINVAL;
diff --git a/mm/shmem.c b/mm/shmem.c
index b85919243399..29ad457b4774 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -192,7 +192,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 
 	if (shmem_acct_block(info->flags, pages))
 		return false;
@@ -214,7 +214,7 @@ static inline bool shmem_inode_acct_block(struct inode *inode, long pages)
 static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 
 	if (sbinfo->max_blocks)
 		percpu_counter_sub(&sbinfo->used_blocks, pages);
@@ -1002,7 +1002,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 	int error;
 
 	error = setattr_prepare(dentry, attr);
@@ -1068,7 +1068,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 static void shmem_evict_inode(struct inode *inode)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 
 	if (inode->i_mapping->a_ops == &shmem_aops) {
 		shmem_unacct_size(info->flags, inode->i_size);
@@ -1091,7 +1091,7 @@ static void shmem_evict_inode(struct inode *inode)
 
 	simple_xattrs_free(&info->xattrs);
 	WARN_ON(inode->i_blocks);
-	shmem_free_inode(inode->i_sb);
+	shmem_free_inode(inode_sb(inode));
 	clear_inode(inode);
 }
 
@@ -1654,7 +1654,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	 * Fast cache lookup did not find it:
 	 * bring it back from swap or allocate.
 	 */
-	sbinfo = SHMEM_SB(inode->i_sb);
+	sbinfo = SHMEM_SB(inode_sb(inode));
 	charge_mm = vma ? vma->vm_mm : current->mm;
 
 	if (swap.val) {
@@ -2056,7 +2056,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 
 		if (file) {
 			VM_BUG_ON(file->f_op != &shmem_file_operations);
-			sb = file_inode(file)->i_sb;
+			sb = inode_sb(file_inode(file));
 		} else {
 			/*
 			 * Called directly from mm/mmap.c, or drivers/char/mem.c
@@ -2852,7 +2852,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 							 loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_falloc shmem_falloc;
 	pgoff_t start, index, end;
@@ -3010,7 +3010,7 @@ shmem_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(inode_sb(dir), dir, mode, dev, VM_NORESERVE);
 	if (inode) {
 		error = simple_acl_create(dir, inode);
 		if (error)
@@ -3039,7 +3039,7 @@ shmem_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(inode_sb(dir), dir, mode, 0, VM_NORESERVE);
 	if (inode) {
 		error = security_inode_init_security(inode, dir,
 						     NULL,
@@ -3086,7 +3086,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	 * but each new link needs a new dentry, pinning lowmem, and
 	 * tmpfs dentries cannot be pruned until they are unlinked.
 	 */
-	ret = shmem_reserve_inode(inode->i_sb);
+	ret = shmem_reserve_inode(inode_sb(inode));
 	if (ret)
 		goto out;
 
@@ -3105,7 +3105,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
-		shmem_free_inode(inode->i_sb);
+		shmem_free_inode(inode_sb(inode));
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
@@ -3230,7 +3230,8 @@ static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *s
 	if (len > PAGE_SIZE)
 		return -ENAMETOOLONG;
 
-	inode = shmem_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0, VM_NORESERVE);
+	inode = shmem_get_inode(inode_sb(dir), dir, S_IFLNK|S_IRWXUGO, 0,
+				VM_NORESERVE);
 	if (!inode)
 		return -ENOSPC;
 
@@ -4093,7 +4094,7 @@ struct kobj_attribute shmem_enabled_attr =
 bool shmem_huge_enabled(struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(vma->vm_file);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode_sb(inode));
 	loff_t i_size;
 	pgoff_t off;
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c7a33717d079..e2316b4ad91e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2446,7 +2446,7 @@ static int swap_node(struct swap_info_struct *p)
 	if (p->bdev)
 		bdev = p->bdev;
 	else
-		bdev = p->swap_file->f_inode->i_sb->s_bdev;
+		bdev = inode_sb(p->swap_file->f_inode)->s_bdev;
 
 	return bdev ? bdev->bd_disk->node_id : NUMA_NO_NODE;
 }
@@ -2899,7 +2899,7 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
 			return error;
 		p->flags |= SWP_BLKDEV;
 	} else if (S_ISREG(inode->i_mode)) {
-		p->bdev = inode->i_sb->s_bdev;
+		p->bdev = inode_sb(inode)->s_bdev;
 		inode_lock(inode);
 		if (IS_SWAPFILE(inode))
 			return -EBUSY;
-- 
2.15.1
