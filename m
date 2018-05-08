Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeEHSFu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932759AbeEHSFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:43 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 38/76] fs/hfsplus: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:58 -0700
Message-Id: <20180508180436.716-39-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/hfsplus/attributes.c | 12 ++++++------
 fs/hfsplus/bnode.c      |  2 +-
 fs/hfsplus/catalog.c    | 12 ++++++------
 fs/hfsplus/dir.c        | 22 +++++++++++-----------
 fs/hfsplus/extents.c    | 11 ++++++-----
 fs/hfsplus/inode.c      | 18 +++++++++---------
 fs/hfsplus/ioctl.c      |  2 +-
 fs/hfsplus/super.c      | 14 ++++++++------
 fs/hfsplus/xattr.c      | 41 +++++++++++++++++++++--------------------
 9 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index 2bab6b3cdba4..24af5a496912 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -169,7 +169,7 @@ int hfsplus_find_attr(struct super_block *sb, u32 cnid,
 int hfsplus_attr_exists(struct inode *inode, const char *name)
 {
 	int err = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_find_data fd;
 
 	if (!HFSPLUS_SB(sb)->attr_tree)
@@ -195,7 +195,7 @@ int hfsplus_create_attr(struct inode *inode,
 				const char *name,
 				const void *value, size_t size)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_find_data fd;
 	hfsplus_attr_entry *entry_ptr;
 	int entry_size;
@@ -298,7 +298,7 @@ static int __hfsplus_delete_attr(struct inode *inode, u32 cnid,
 int hfsplus_delete_attr(struct inode *inode, const char *name)
 {
 	int err = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_find_data fd;
 
 	hfs_dbg(ATTR_MOD, "delete_attr: %s,%ld\n",
@@ -344,17 +344,17 @@ int hfsplus_delete_all_attrs(struct inode *dir, u32 cnid)
 
 	hfs_dbg(ATTR_MOD, "delete_all_attrs: %d\n", cnid);
 
-	if (!HFSPLUS_SB(dir->i_sb)->attr_tree) {
+	if (!HFSPLUS_SB(inode_sb(dir))->attr_tree) {
 		pr_err("attributes file doesn't exist\n");
 		return -EINVAL;
 	}
 
-	err = hfs_find_init(HFSPLUS_SB(dir->i_sb)->attr_tree, &fd);
+	err = hfs_find_init(HFSPLUS_SB(inode_sb(dir))->attr_tree, &fd);
 	if (err)
 		return err;
 
 	for (;;) {
-		err = hfsplus_find_attr(dir->i_sb, cnid, NULL, &fd);
+		err = hfsplus_find_attr(inode_sb(dir), cnid, NULL, &fd);
 		if (err) {
 			if (err != -ENOENT)
 				pr_err("xattr search failed\n");
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 177fae4e6581..9da98a7955a0 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -656,7 +656,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
  */
 bool hfs_bnode_need_zeroout(struct hfs_btree *tree)
 {
-	struct super_block *sb = tree->inode->i_sb;
+	struct super_block *sb = inode_sb(tree->inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	const u32 volume_attr = be32_to_cpu(sbi->s_vhdr->attributes);
 
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index a196369ba779..23336c614b64 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -105,7 +105,7 @@ void hfsplus_cat_set_perms(struct inode *inode, struct hfsplus_perm *perms)
 static int hfsplus_cat_build_record(hfsplus_cat_entry *entry,
 		u32 cnid, struct inode *inode)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(inode));
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct hfsplus_cat_folder *folder;
@@ -222,7 +222,7 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 
 static void hfsplus_subfolders_inc(struct inode *dir)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 
 	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags)) {
 		/*
@@ -235,7 +235,7 @@ static void hfsplus_subfolders_inc(struct inode *dir)
 
 static void hfsplus_subfolders_dec(struct inode *dir)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 
 	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags)) {
 		/*
@@ -253,7 +253,7 @@ static void hfsplus_subfolders_dec(struct inode *dir)
 int hfsplus_create_cat(u32 cnid, struct inode *dir,
 		const struct qstr *str, struct inode *inode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 	int entry_size;
@@ -321,7 +321,7 @@ int hfsplus_create_cat(u32 cnid, struct inode *dir,
 
 int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct hfs_find_data fd;
 	struct hfsplus_fork_raw fork;
 	struct list_head *pos;
@@ -419,7 +419,7 @@ int hfsplus_rename_cat(u32 cnid,
 		       struct inode *src_dir, const struct qstr *src_name,
 		       struct inode *dst_dir, const struct qstr *dst_name)
 {
-	struct super_block *sb = src_dir->i_sb;
+	struct super_block *sb = inode_sb(src_dir);
 	struct hfs_find_data src_fd, dst_fd;
 	hfsplus_cat_entry entry;
 	int entry_size, type;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 15e06fb552da..9d824fcc6185 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -39,7 +39,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 	u32 cnid, linkid = 0;
 	u16 type;
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 
 	dentry->d_fsdata = NULL;
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
@@ -116,7 +116,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 		goto fail;
 	}
 	hfs_find_exit(&fd);
-	inode = hfsplus_iget(dir->i_sb, cnid);
+	inode = hfsplus_iget(inode_sb(dir), cnid);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 	if (S_ISREG(inode->i_mode))
@@ -132,7 +132,7 @@ static struct dentry *hfsplus_lookup(struct inode *dir, struct dentry *dentry,
 static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int len, err;
 	char *strbuf;
 	hfsplus_cat_entry entry;
@@ -302,7 +302,7 @@ static int hfsplus_dir_release(struct inode *inode, struct file *file)
 static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 			struct dentry *dst_dentry)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dst_dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dst_dir));
 	struct inode *inode = d_inode(src_dentry);
 	struct inode *src_dir = d_inode(src_dentry->d_parent);
 	struct qstr str;
@@ -351,7 +351,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 	inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
 	sbi->file_count++;
-	hfsplus_mark_mdb_dirty(dst_dir->i_sb);
+	hfsplus_mark_mdb_dirty(inode_sb(dst_dir));
 out:
 	mutex_unlock(&sbi->vh_mutex);
 	return res;
@@ -359,7 +359,7 @@ static int hfsplus_link(struct dentry *src_dentry, struct inode *dst_dir,
 
 static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 	struct inode *inode = d_inode(dentry);
 	struct qstr str;
 	char name[32];
@@ -416,7 +416,7 @@ static int hfsplus_unlink(struct inode *dir, struct dentry *dentry)
 
 static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 	struct inode *inode = d_inode(dentry);
 	int res;
 
@@ -439,12 +439,12 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 static int hfsplus_symlink(struct inode *dir, struct dentry *dentry,
 			   const char *symname)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 	struct inode *inode;
 	int res = -ENOMEM;
 
 	mutex_lock(&sbi->vh_mutex);
-	inode = hfsplus_new_inode(dir->i_sb, dir, S_IFLNK | S_IRWXUGO);
+	inode = hfsplus_new_inode(inode_sb(dir), dir, S_IFLNK | S_IRWXUGO);
 	if (!inode)
 		goto out;
 
@@ -481,12 +481,12 @@ static int hfsplus_symlink(struct inode *dir, struct dentry *dentry,
 static int hfsplus_mknod(struct inode *dir, struct dentry *dentry,
 			 umode_t mode, dev_t rdev)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(dir));
 	struct inode *inode;
 	int res = -ENOMEM;
 
 	mutex_lock(&sbi->vh_mutex);
-	inode = hfsplus_new_inode(dir->i_sb, dir, mode);
+	inode = hfsplus_new_inode(inode_sb(dir), dir, mode);
 	if (!inode)
 		goto out;
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index e8770935ce6d..288ae891ed8d 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -129,7 +129,8 @@ static int hfsplus_ext_write_extent_locked(struct inode *inode)
 	if (HFSPLUS_I(inode)->extent_state & HFSPLUS_EXT_DIRTY) {
 		struct hfs_find_data fd;
 
-		res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
+		res = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->ext_tree,
+				    &fd);
 		if (res)
 			return res;
 		res = __hfsplus_ext_write_extent(inode, &fd);
@@ -209,7 +210,7 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	    block < hip->cached_start + hip->cached_blocks)
 		return 0;
 
-	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
+	res = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->ext_tree, &fd);
 	if (!res) {
 		res = __hfsplus_ext_cache_extent(&fd, inode, block);
 		hfs_find_exit(&fd);
@@ -221,7 +222,7 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		      struct buffer_head *bh_result, int create)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	int res = -EIO;
@@ -428,7 +429,7 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 
 int hfsplus_file_extend(struct inode *inode, bool zeroout)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	u32 start, len, goal;
@@ -531,7 +532,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 
 void hfsplus_file_truncate(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	struct hfs_find_data fd;
 	u32 alloc_cnt, blk_cnt, start;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index c0c8d433864f..9ba18604c11f 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -67,7 +67,7 @@ static sector_t hfsplus_bmap(struct address_space *mapping, sector_t block)
 static int hfsplus_releasepage(struct page *page, gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_btree *tree;
 	struct hfs_bnode *node;
 	u32 nidx;
@@ -182,7 +182,7 @@ const struct dentry_operations hfsplus_dentry_operations = {
 static void hfsplus_get_perms(struct inode *inode,
 		struct hfsplus_perm *perms, int dir)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(inode));
 	u16 mode;
 
 	mode = be16_to_cpu(perms->mode);
@@ -225,7 +225,7 @@ static int hfsplus_file_open(struct inode *inode, struct file *file)
 
 static int hfsplus_file_release(struct inode *inode, struct file *file)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (HFSPLUS_IS_RSRC(inode))
 		inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -281,7 +281,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct inode *inode = file->f_mapping->host;
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(inode));
 	int error = 0, error2;
 
 	error = file_write_and_wait_range(file, start, end);
@@ -326,7 +326,7 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	}
 
 	if (!test_bit(HFSPLUS_SB_NOBARRIER, &sbi->flags))
-		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		blkdev_issue_flush(inode_sb(inode)->s_bdev, GFP_KERNEL, NULL);
 
 	inode_unlock(inode);
 
@@ -415,7 +415,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 
 void hfsplus_delete_inode(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (S_ISDIR(inode->i_mode)) {
 		HFSPLUS_SB(sb)->folder_count--;
@@ -437,7 +437,7 @@ void hfsplus_delete_inode(struct inode *inode)
 
 void hfsplus_inode_read_fork(struct inode *inode, struct hfsplus_fork_raw *fork)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	u32 count;
@@ -554,11 +554,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(HFSPLUS_SB(inode_sb(main_inode))->cat_tree, &fd))
 		/* panic? */
 		return -EIO;
 
-	if (hfsplus_find_cat(main_inode->i_sb, main_inode->i_ino, &fd))
+	if (hfsplus_find_cat(inode_sb(main_inode), main_inode->i_ino, &fd))
 		/* panic? */
 		goto out;
 
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index 5e6502ef7415..25f5cb0c6416 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -28,7 +28,7 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode *inode = d_inode(dentry);
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(inode));
 	struct hfsplus_vh *vh = sbi->s_vhdr;
 	struct hfsplus_vh *bvh = sbi->s_backup_vhdr;
 	u32 cnid = (unsigned long)dentry->d_fsdata;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 513c357c734b..b34f3110f46a 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -25,7 +25,7 @@ static void hfsplus_destroy_inode(struct inode *inode);
 
 static int hfsplus_system_read_inode(struct inode *inode)
 {
-	struct hfsplus_vh *vhdr = HFSPLUS_SB(inode->i_sb)->s_vhdr;
+	struct hfsplus_vh *vhdr = HFSPLUS_SB(inode_sb(inode))->s_vhdr;
 
 	switch (inode->i_ino) {
 	case HFSPLUS_EXT_CNID:
@@ -76,9 +76,11 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
-		err = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &fd);
+		err = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->cat_tree,
+				    &fd);
 		if (!err) {
-			err = hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd);
+			err = hfsplus_find_cat(inode_sb(inode), inode->i_ino,
+					       &fd);
 			if (!err)
 				err = hfsplus_cat_read_inode(inode, &fd);
 			hfs_find_exit(&fd);
@@ -98,7 +100,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 
 static int hfsplus_system_write_inode(struct inode *inode)
 {
-	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode_sb(inode));
 	struct hfsplus_vh *vhdr = sbi->s_vhdr;
 	struct hfsplus_fork_raw *fork;
 	struct hfs_btree *tree = NULL;
@@ -128,7 +130,7 @@ static int hfsplus_system_write_inode(struct inode *inode)
 
 	if (fork->total_size != cpu_to_be64(inode->i_size)) {
 		set_bit(HFSPLUS_SB_WRITEBACKUP, &sbi->flags);
-		hfsplus_mark_mdb_dirty(inode->i_sb);
+		hfsplus_mark_mdb_dirty(inode_sb(inode));
 	}
 	hfsplus_inode_write_fork(inode, fork);
 	if (tree) {
@@ -254,7 +256,7 @@ static void delayed_sync_fs(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	err = hfsplus_sync_fs(sbi->alloc_file->i_sb, 1);
+	err = hfsplus_sync_fs(inode_sb(sbi->alloc_file), 1);
 	if (err)
 		pr_err("delayed sync fs err %d\n", err);
 }
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index e538b758c448..0d03fcee78ae 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -281,13 +281,13 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	if (value == NULL)
 		return hfsplus_removexattr(inode, name);
 
-	err = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &cat_fd);
+	err = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->cat_tree, &cat_fd);
 	if (err) {
 		pr_err("can't init xattr find struct\n");
 		return err;
 	}
 
-	err = hfsplus_find_cat(inode->i_sb, inode->i_ino, &cat_fd);
+	err = hfsplus_find_cat(inode_sb(inode), inode->i_ino, &cat_fd);
 	if (err) {
 		pr_err("catalog searching failed\n");
 		goto end_setxattr;
@@ -334,8 +334,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 		goto end_setxattr;
 	}
 
-	if (!HFSPLUS_SB(inode->i_sb)->attr_tree) {
-		err = hfsplus_create_attributes_file(inode->i_sb);
+	if (!HFSPLUS_SB(inode_sb(inode))->attr_tree) {
+		err = hfsplus_create_attributes_file(inode_sb(inode));
 		if (unlikely(err))
 			goto end_setxattr;
 	}
@@ -456,12 +456,13 @@ static ssize_t hfsplus_getxattr_finder_info(struct inode *inode,
 	u8 file_finder_info[sizeof(struct FInfo) + sizeof(struct FXInfo)];
 
 	if (size >= record_len) {
-		res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &fd);
+		res = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->cat_tree,
+				    &fd);
 		if (res) {
 			pr_err("can't init xattr find struct\n");
 			return res;
 		}
-		res = hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd);
+		res = hfsplus_find_cat(inode_sb(inode), inode->i_ino, &fd);
 		if (res)
 			goto end_getxattr_finder_info;
 		entry_type = hfs_bnode_read_u16(fd.bnode, fd.entryoffset);
@@ -511,7 +512,7 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 	if (!strcmp_xattr_finder_info(name))
 		return hfsplus_getxattr_finder_info(inode, value, size);
 
-	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
+	if (!HFSPLUS_SB(inode_sb(inode))->attr_tree)
 		return -EOPNOTSUPP;
 
 	entry = hfsplus_alloc_attr_entry();
@@ -520,13 +521,13 @@ ssize_t __hfsplus_getxattr(struct inode *inode, const char *name,
 		return -ENOMEM;
 	}
 
-	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->attr_tree, &fd);
+	res = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->attr_tree, &fd);
 	if (res) {
 		pr_err("can't init xattr find struct\n");
 		goto failed_getxattr_init;
 	}
 
-	res = hfsplus_find_attr(inode->i_sb, inode->i_ino, name, &fd);
+	res = hfsplus_find_attr(inode_sb(inode), inode->i_ino, name, &fd);
 	if (res) {
 		if (res == -ENOENT)
 			res = -ENODATA;
@@ -622,13 +623,13 @@ static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 	unsigned long len, found_bit;
 	int xattr_name_len, symbols_count;
 
-	res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &fd);
+	res = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->cat_tree, &fd);
 	if (res) {
 		pr_err("can't init xattr find struct\n");
 		return res;
 	}
 
-	res = hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd);
+	res = hfsplus_find_cat(inode_sb(inode), inode->i_ino, &fd);
 	if (res)
 		goto end_listxattr_finder_info;
 
@@ -697,10 +698,10 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	res = hfsplus_listxattr_finder_info(dentry, buffer, size);
 	if (res < 0)
 		return res;
-	else if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
+	else if (!HFSPLUS_SB(inode_sb(inode))->attr_tree)
 		return (res == 0) ? -EOPNOTSUPP : res;
 
-	err = hfs_find_init(HFSPLUS_SB(inode->i_sb)->attr_tree, &fd);
+	err = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->attr_tree, &fd);
 	if (err) {
 		pr_err("can't init xattr find struct\n");
 		return err;
@@ -713,7 +714,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		goto out;
 	}
 
-	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
+	err = hfsplus_find_attr(inode_sb(inode), inode->i_ino, NULL, &fd);
 	if (err) {
 		if (err == -ENOENT) {
 			if (res == 0)
@@ -740,9 +741,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			goto end_listxattr;
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
-		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+		if (hfsplus_uni2asc(inode_sb(inode),
+				    (const struct hfsplus_unistr *)&fd.key->attr.key_name,
+				    strbuf, &xattr_name_len)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
@@ -780,19 +781,19 @@ static int hfsplus_removexattr(struct inode *inode, const char *name)
 	int is_xattr_acl_deleted = 0;
 	int is_all_xattrs_deleted = 0;
 
-	if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
+	if (!HFSPLUS_SB(inode_sb(inode))->attr_tree)
 		return -EOPNOTSUPP;
 
 	if (!strcmp_xattr_finder_info(name))
 		return -EOPNOTSUPP;
 
-	err = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &cat_fd);
+	err = hfs_find_init(HFSPLUS_SB(inode_sb(inode))->cat_tree, &cat_fd);
 	if (err) {
 		pr_err("can't init xattr find struct\n");
 		return err;
 	}
 
-	err = hfsplus_find_cat(inode->i_sb, inode->i_ino, &cat_fd);
+	err = hfsplus_find_cat(inode_sb(inode), inode->i_ino, &cat_fd);
 	if (err) {
 		pr_err("catalog searching failed\n");
 		goto end_removexattr;
-- 
2.15.1
