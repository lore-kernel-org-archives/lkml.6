Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756110AbeEHSce (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:32:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932493AbeEHSFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:35 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 32/76] fs/f2fs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:52 -0700
Message-Id: <20180508180436.716-33-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/f2fs/data.c     |  6 +++---
 fs/f2fs/f2fs.h     |  2 +-
 fs/f2fs/file.c     | 36 ++++++++++++++++++------------------
 fs/f2fs/inline.c   |  4 ++--
 fs/f2fs/inode.c    |  6 +++---
 fs/f2fs/namei.c    | 11 ++++++-----
 fs/f2fs/recovery.c | 11 ++++++-----
 fs/f2fs/super.c    |  6 +++---
 fs/f2fs/trace.c    |  7 ++++---
 fs/f2fs/xattr.c    |  4 ++--
 10 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7578ed1a85e0..f3e29f386f6e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1129,7 +1129,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 
 	err = f2fs_map_blocks(inode, &map, create, flag);
 	if (!err) {
-		map_bh(bh, inode->i_sb, map.m_pblk);
+		map_bh(bh, inode_sb(inode), map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
 		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
@@ -1225,7 +1225,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		get_node_info(sbi, xnid, &ni);
 
 		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
-		len = inode->i_sb->s_blocksize;
+		len = inode_sb(inode)->s_blocksize;
 
 		f2fs_put_page(page, 1);
 
@@ -2272,7 +2272,7 @@ static int f2fs_write_end(struct file *file,
 static int check_direct_IO(struct inode *inode, struct iov_iter *iter,
 			   loff_t offset)
 {
-	unsigned blocksize_mask = inode->i_sb->s_blocksize - 1;
+	unsigned blocksize_mask = inode_sb(inode)->s_blocksize - 1;
 
 	if (offset & blocksize_mask)
 		return -EINVAL;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6300ac5bcbe4..504c84b68636 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1331,7 +1331,7 @@ static inline struct f2fs_sb_info *F2FS_SB(struct super_block *sb)
 
 static inline struct f2fs_sb_info *F2FS_I_SB(struct inode *inode)
 {
-	return F2FS_SB(inode->i_sb);
+	return F2FS_SB(inode_sb(inode));
 }
 
 static inline struct f2fs_sb_info *F2FS_M_SB(struct address_space *mapping)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542e5464..837333b9153d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -58,7 +58,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto err;
 	}
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
@@ -117,7 +117,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	f2fs_update_time(sbi, REQ_TIME);
 err:
 	return block_page_mkwrite_return(err);
@@ -211,7 +211,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		.for_reclaim = 0,
 	};
 
-	if (unlikely(f2fs_readonly(inode->i_sb)))
+	if (unlikely(f2fs_readonly(inode_sb(inode))))
 		return 0;
 
 	trace_f2fs_sync_file_enter(inode);
@@ -259,7 +259,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
-		ret = f2fs_sync_fs(inode->i_sb, 1);
+		ret = f2fs_sync_fs(inode_sb(inode), 1);
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -365,7 +365,7 @@ static bool __found_offset(block_t blkaddr, pgoff_t dirty, pgoff_t pgofs,
 static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = inode_sb(inode)->s_maxbytes;
 	struct dnode_of_data dn;
 	pgoff_t pgofs, end_offset, dirty;
 	loff_t data_ofs = offset;
@@ -437,7 +437,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = inode_sb(inode)->s_maxbytes;
 
 	switch (whence) {
 	case SEEK_SET:
@@ -569,7 +569,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 int truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int blocksize = inode->i_sb->s_blocksize;
+	unsigned int blocksize = inode_sb(inode)->s_blocksize;
 	struct dnode_of_data dn;
 	pgoff_t free_from;
 	int count = 0, err = 0;
@@ -676,7 +676,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 	unsigned int flags;
 
 	if (f2fs_has_extra_attr(inode) &&
-			f2fs_sb_has_inode_crtime(inode->i_sb) &&
+			f2fs_sb_has_inode_crtime(inode_sb(inode)) &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_crtime)) {
 		stat->result_mask |= STATX_BTIME;
 		stat->btime.tv_sec = fi->i_crtime.tv_sec;
@@ -722,13 +722,13 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
 		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
 		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -1891,7 +1891,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct request_queue *q = bdev_get_queue(sb->s_bdev);
 	struct fstrim_range range;
 	int ret;
@@ -1938,7 +1938,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	if (!f2fs_sb_has_crypto(inode->i_sb))
+	if (!f2fs_sb_has_crypto(inode_sb(inode)))
 		return -EOPNOTSUPP;
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
@@ -1948,7 +1948,7 @@ static int f2fs_ioc_set_encryption_policy(struct file *filp, unsigned long arg)
 
 static int f2fs_ioc_get_encryption_policy(struct file *filp, unsigned long arg)
 {
-	if (!f2fs_sb_has_crypto(file_inode(filp)->i_sb))
+	if (!f2fs_sb_has_crypto(inode_sb(file_inode(filp))))
 		return -EOPNOTSUPP;
 	return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
 }
@@ -1959,7 +1959,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int err;
 
-	if (!f2fs_sb_has_crypto(inode->i_sb))
+	if (!f2fs_sb_has_crypto(inode_sb(inode)))
 		return -EOPNOTSUPP;
 
 	if (uuid_is_nonzero(sbi->raw_super->encrypt_pw_salt))
@@ -2290,10 +2290,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	int ret;
 
 	if (file_in->f_path.mnt != file_out->f_path.mnt ||
-				src->i_sb != dst->i_sb)
+				inode_sb(src) != inode_sb(dst))
 		return -EXDEV;
 
-	if (unlikely(f2fs_readonly(src->i_sb)))
+	if (unlikely(f2fs_readonly(inode_sb(src))))
 		return -EROFS;
 
 	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
@@ -2644,7 +2644,7 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
 				(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL));
 
-	if (f2fs_sb_has_project_quota(inode->i_sb))
+	if (f2fs_sb_has_project_quota(inode_sb(inode)))
 		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
 							fi->i_projid);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 90e38d8ea688..eb8b1a085974 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -294,7 +294,7 @@ bool recover_inline_data(struct inode *inode, struct page *npage)
 struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
 			struct fscrypt_name *fname, struct page **res_page)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(inode_sb(dir));
 	struct qstr name = FSTR_TO_QSTR(&fname->disk_name);
 	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_ptr d;
@@ -674,7 +674,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	ilen -= start;
 
 	get_node_info(F2FS_I_SB(inode), inode->i_ino, &ni);
-	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+	byteaddr = (__u64)ni.blk_addr << inode_sb(inode)->s_blocksize_bits;
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 205add3d0f3a..4bc24cf161d3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -195,7 +195,7 @@ static int do_read_inode(struct inode *inode)
 
 	/* Check if ino is within scope */
 	if (check_nid_range(sbi, inode->i_ino)) {
-		f2fs_msg(inode->i_sb, KERN_ERR, "bad inode number: %lu",
+		f2fs_msg(inode_sb(inode), KERN_ERR, "bad inode number: %lu",
 			 (unsigned long) inode->i_ino);
 		WARN_ON(1);
 		return -EINVAL;
@@ -522,7 +522,7 @@ void f2fs_evict_inode(struct inode *inode)
 	remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	remove_ino_entry(sbi, inode->i_ino, FLUSH_INO);
 
-	sb_start_intwrite(inode->i_sb);
+	sb_start_intwrite(inode_sb(inode));
 	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
 retry:
@@ -552,7 +552,7 @@ void f2fs_evict_inode(struct inode *inode)
 	if (err)
 		update_inode_page(inode);
 	dquot_free_inode(inode);
-	sb_end_intwrite(inode->i_sb);
+	sb_end_intwrite(inode_sb(inode));
 no_delete:
 	dquot_drop(inode);
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b68e7b03959f..17a171d258cb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -32,7 +32,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	int xattr_size = 0;
 	int err;
 
-	inode = new_inode(dir->i_sb);
+	inode = new_inode(inode_sb(dir));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
@@ -380,7 +380,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	f2fs_dentry_kunmap(dir, page);
 	f2fs_put_page(page, 0);
 
-	inode = f2fs_iget(dir->i_sb, ino);
+	inode = f2fs_iget(inode_sb(dir), ino);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		goto out;
@@ -400,7 +400,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	if (f2fs_encrypted_inode(dir) &&
 	    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 	    !fscrypt_has_permitted_context(dir, inode)) {
-		f2fs_msg(inode->i_sb, KERN_WARNING,
+		f2fs_msg(inode_sb(inode), KERN_WARNING,
 			 "Inconsistent encryption contexts: %lu/%lu",
 			 dir->i_ino, inode->i_ino);
 		err = -EPERM;
@@ -492,7 +492,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
 
-	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
+	err = fscrypt_prepare_symlink(dir, symname, len,
+				      inode_sb(dir)->s_blocksize,
 				      &disk_link);
 	if (err)
 		return err;
@@ -1125,7 +1126,7 @@ static const char *f2fs_encrypted_get_link(struct dentry *dentry,
 		return ERR_CAST(page);
 
 	target = fscrypt_get_symlink(inode, page_address(page),
-				     inode->i_sb->s_blocksize, done);
+				     inode_sb(inode)->s_blocksize, done);
 	put_page(page);
 	return target;
 }
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 337f3363f48f..060d8259224d 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -147,7 +147,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 		goto out_unmap_put;
 
 	if (de) {
-		einode = f2fs_iget_retry(inode->i_sb, le32_to_cpu(de->ino));
+		einode = f2fs_iget_retry(inode_sb(inode),
+					 le32_to_cpu(de->ino));
 		if (IS_ERR(einode)) {
 			WARN_ON(1);
 			err = PTR_ERR(einode);
@@ -188,7 +189,7 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
 		name = "<encrypted>";
 	else
 		name = raw_inode->i_name;
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
+	f2fs_msg(inode_sb(inode), KERN_NOTICE,
 			"%s: ino = %x, name = %s, dir = %lx, err = %d",
 			__func__, ino_of_node(ipage), name,
 			IS_ERR(dir) ? 0 : dir->i_ino, err);
@@ -232,9 +233,9 @@ static void recover_inode(struct inode *inode, struct page *page)
 	else
 		name = F2FS_INODE(page)->i_name;
 
-	f2fs_msg(inode->i_sb, KERN_NOTICE,
-		"recover_inode: ino = %x, name = %s, inline = %x",
-			ino_of_node(page), name, raw->i_inline);
+	f2fs_msg(inode_sb(inode), KERN_NOTICE,
+		 "recover_inode: ino = %x, name = %s, inline = %x",
+		 ino_of_node(page), name, raw->i_inline);
 }
 
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8173ae688814..76cc211194c8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -776,13 +776,13 @@ static int f2fs_drop_inode(struct inode *inode)
 			/* should remain fi->extent_tree for writepage */
 			f2fs_destroy_extent_node(inode);
 
-			sb_start_intwrite(inode->i_sb);
+			sb_start_intwrite(inode_sb(inode));
 			f2fs_i_size_write(inode, 0);
 
 			if (F2FS_HAS_BLOCKS(inode))
 				f2fs_truncate(inode);
 
-			sb_end_intwrite(inode->i_sb);
+			sb_end_intwrite(inode_sb(inode));
 
 			spin_lock(&inode->i_lock);
 			atomic_dec(&inode->i_count);
@@ -1805,7 +1805,7 @@ static int f2fs_set_context(struct inode *inode, const void *ctx, size_t len,
 static unsigned f2fs_max_namelen(struct inode *inode)
 {
 	return S_ISLNK(inode->i_mode) ?
-			inode->i_sb->s_blocksize : F2FS_NAME_LEN;
+			inode_sb(inode)->s_blocksize : F2FS_NAME_LEN;
 }
 
 static const struct fscrypt_operations f2fs_cryptops = {
diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index a1fcd00bbb2b..235a3bca1f5f 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -74,7 +74,8 @@ void f2fs_trace_pid(struct page *page)
 	f2fs_radix_tree_insert(&pids, pid, current);
 
 	trace_printk("%3x:%3x %4x %-16s\n",
-			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
+			MAJOR(inode_sb(inode)->s_dev),
+			MINOR(inode_sb(inode)->s_dev),
 			pid, current->comm);
 out:
 	mutex_unlock(&pids_lock);
@@ -95,8 +96,8 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 	inode = fio->page->mapping->host;
 	pid = page_private(fio->page);
 
-	major = MAJOR(inode->i_sb->s_dev);
-	minor = MINOR(inode->i_sb->s_dev);
+	major = MAJOR(inode_sb(inode)->s_dev);
+	minor = MINOR(inode_sb(inode)->s_dev);
 
 	if (last_io.major == major && last_io.minor == minor &&
 			last_io.pid == pid &&
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index ae2dfa709f5d..9d445f4f5d8b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -29,7 +29,7 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 		struct dentry *unused, struct inode *inode,
 		const char *name, void *buffer, size_t size)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(inode_sb(inode));
 
 	switch (handler->flags) {
 	case F2FS_XATTR_INDEX_USER:
@@ -54,7 +54,7 @@ static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
 		const char *name, const void *value,
 		size_t size, int flags)
 {
-	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct f2fs_sb_info *sbi = F2FS_SB(inode_sb(inode));
 
 	switch (handler->flags) {
 	case F2FS_XATTR_INDEX_USER:
-- 
2.15.1
