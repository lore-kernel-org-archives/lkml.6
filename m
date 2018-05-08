Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeEHSaR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:30:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932740AbeEHSFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:42 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 37/76] fs/hfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:57 -0700
Message-Id: <20180508180436.716-38-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/hfs/attr.c    |  4 ++--
 fs/hfs/catalog.c | 10 +++++-----
 fs/hfs/dir.c     | 11 ++++++-----
 fs/hfs/extent.c  | 10 +++++-----
 fs/hfs/inode.c   | 32 ++++++++++++++++----------------
 5 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 74fa62643136..60075ee27192 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -30,7 +30,7 @@ static int __hfs_setxattr(struct inode *inode, enum hfs_xattr_type type,
 	if (!S_ISREG(inode->i_mode) || HFS_IS_RSRC(inode))
 		return -EOPNOTSUPP;
 
-	res = hfs_find_init(HFS_SB(inode->i_sb)->cat_tree, &fd);
+	res = hfs_find_init(HFS_SB(inode_sb(inode))->cat_tree, &fd);
 	if (res)
 		return res;
 	fd.search_key->cat = HFS_I(inode)->cat_key;
@@ -77,7 +77,7 @@ static ssize_t __hfs_getxattr(struct inode *inode, enum hfs_xattr_type type,
 		return -EOPNOTSUPP;
 
 	if (size) {
-		res = hfs_find_init(HFS_SB(inode->i_sb)->cat_tree, &fd);
+		res = hfs_find_init(HFS_SB(inode_sb(inode))->cat_tree, &fd);
 		if (res)
 			return res;
 		fd.search_key->cat = HFS_I(inode)->cat_key;
diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 8a66405b0f8b..790d488a2c24 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -56,8 +56,8 @@ static int hfs_cat_build_record(hfs_cat_rec *rec, u32 cnid, struct inode *inode)
 		rec->file.CrDat = mtime;
 		rec->file.MdDat = mtime;
 		rec->file.BkDat = 0;
-		rec->file.UsrWds.fdType = HFS_SB(inode->i_sb)->s_type;
-		rec->file.UsrWds.fdCreator = HFS_SB(inode->i_sb)->s_creator;
+		rec->file.UsrWds.fdType = HFS_SB(inode_sb(inode))->s_type;
+		rec->file.UsrWds.fdCreator = HFS_SB(inode_sb(inode))->s_creator;
 		return sizeof(struct hfs_cat_file);
 	}
 }
@@ -92,7 +92,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
 	if (dir->i_size >= HFS_MAX_VALENCE)
 		return -ENOSPC;
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	err = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
@@ -218,7 +218,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	int res, type;
 
 	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	res = hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
 	if (res)
 		return res;
@@ -289,7 +289,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	hfs_dbg(CAT_MOD, "rename_cat: %u - %lu,%s - %lu,%s\n",
 		cnid, src_dir->i_ino, src_name->name,
 		dst_dir->i_ino, dst_name->name);
-	sb = src_dir->i_sb;
+	sb = inode_sb(src_dir);
 	err = hfs_find_init(HFS_SB(sb)->cat_tree, &src_fd);
 	if (err)
 		return err;
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 75b254280ff6..ae29580b3d0c 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -25,10 +25,11 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	int res;
 
-	res = hfs_find_init(HFS_SB(dir->i_sb)->cat_tree, &fd);
+	res = hfs_find_init(HFS_SB(inode_sb(dir))->cat_tree, &fd);
 	if (res)
 		return ERR_PTR(res);
-	hfs_cat_build_key(dir->i_sb, fd.search_key, dir->i_ino, &dentry->d_name);
+	hfs_cat_build_key(inode_sb(dir), fd.search_key, dir->i_ino,
+			  &dentry->d_name);
 	res = hfs_brec_read(&fd, &rec, sizeof(rec));
 	if (res) {
 		hfs_find_exit(&fd);
@@ -39,7 +40,7 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 		}
 		return ERR_PTR(res);
 	}
-	inode = hfs_iget(dir->i_sb, &fd.search_key->cat, &rec);
+	inode = hfs_iget(inode_sb(dir), &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
 	if (!inode)
 		return ERR_PTR(-EACCES);
@@ -54,7 +55,7 @@ static struct dentry *hfs_lookup(struct inode *dir, struct dentry *dentry,
 static int hfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int len, err;
 	char strbuf[HFS_MAX_NAMELEN];
 	union hfs_cat_rec entry;
@@ -305,7 +306,7 @@ static int hfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   old_dir, &old_dentry->d_name,
 			   new_dir, &new_dentry->d_name);
 	if (!res)
-		hfs_cat_build_key(old_dir->i_sb,
+		hfs_cat_build_key(inode_sb(old_dir),
 				  (btree_key *)&HFS_I(d_inode(old_dentry))->cat_key,
 				  new_dir->i_ino, &new_dentry->d_name);
 	return res;
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 5d0182654580..03e1f49fee30 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -134,7 +134,7 @@ int hfs_ext_write_extent(struct inode *inode)
 	int res = 0;
 
 	if (HFS_I(inode)->flags & HFS_FLG_EXT_DIRTY) {
-		res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
+		res = hfs_find_init(HFS_SB(inode_sb(inode))->ext_tree, &fd);
 		if (res)
 			return res;
 		res = __hfs_ext_write_extent(inode, &fd);
@@ -193,7 +193,7 @@ static int hfs_ext_read_extent(struct inode *inode, u16 block)
 	    block < HFS_I(inode)->cached_start + HFS_I(inode)->cached_blocks)
 		return 0;
 
-	res = hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
+	res = hfs_find_init(HFS_SB(inode_sb(inode))->ext_tree, &fd);
 	if (!res) {
 		res = __hfs_ext_cache_extent(&fd, inode, block);
 		hfs_find_exit(&fd);
@@ -336,7 +336,7 @@ int hfs_get_block(struct inode *inode, sector_t block,
 	u16 dblock, ablock;
 	int res;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	/* Convert inode block to disk allocation block */
 	ablock = (u32)block / HFS_SB(sb)->fs_div;
 
@@ -384,7 +384,7 @@ int hfs_get_block(struct inode *inode, sector_t block,
 
 int hfs_extend_file(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u32 start, len, goal;
 	int res;
 
@@ -469,7 +469,7 @@ int hfs_extend_file(struct inode *inode)
 
 void hfs_file_truncate(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_find_data fd;
 	u16 blk_cnt, alloc_cnt, start;
 	u32 size;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2538b49cc349..1d8e35f3f72d 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -72,7 +72,7 @@ static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 static int hfs_releasepage(struct page *page, gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct hfs_btree *tree;
 	struct hfs_bnode *node;
 	u32 nidx;
@@ -181,7 +181,7 @@ const struct address_space_operations hfs_aops = {
  */
 struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode *inode = new_inode(sb);
 	if (!inode)
 		return NULL;
@@ -207,7 +207,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		inode->i_mode |= S_IRWXUGO;
-		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_dir_umask;
+		inode->i_mode &= ~HFS_SB(inode_sb(inode))->s_dir_umask;
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		HFS_SB(sb)->file_count++;
@@ -219,7 +219,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		inode->i_mode |= S_IRUGO|S_IXUGO;
 		if (mode & S_IWUSR)
 			inode->i_mode |= S_IWUGO;
-		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_file_umask;
+		inode->i_mode &= ~HFS_SB(inode_sb(inode))->s_file_umask;
 		HFS_I(inode)->phys_size = 0;
 		HFS_I(inode)->alloc_blocks = 0;
 		HFS_I(inode)->first_blocks = 0;
@@ -238,7 +238,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 
 void hfs_delete_inode(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
@@ -265,7 +265,7 @@ void hfs_delete_inode(struct inode *inode)
 void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 			 __be32 __log_size, __be32 phys_size, u32 clump_size)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u32 log_size = be32_to_cpu(__log_size);
 	u16 count;
 	int i;
@@ -313,7 +313,7 @@ static int hfs_test_inode(struct inode *inode, void *data)
 static int hfs_read_inode(struct inode *inode, void *data)
 {
 	struct hfs_iget_data *idata = data;
-	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
+	struct hfs_sb_info *hsb = HFS_SB(inode_sb(inode));
 	hfs_cat_rec *rec;
 
 	HFS_I(inode)->flags = 0;
@@ -412,7 +412,7 @@ void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
 		*log_size = cpu_to_be32(inode->i_size);
 	if (phys_size)
 		*phys_size = cpu_to_be32(HFS_I(inode)->alloc_blocks *
-					 HFS_SB(inode->i_sb)->alloc_blksz);
+					 HFS_SB(inode_sb(inode))->alloc_blksz);
 }
 
 int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -432,10 +432,10 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		case HFS_ROOT_CNID:
 			break;
 		case HFS_EXT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
+			hfs_btree_write(HFS_SB(inode_sb(inode))->ext_tree);
 			return 0;
 		case HFS_CAT_CNID:
-			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
+			hfs_btree_write(HFS_SB(inode_sb(inode))->cat_tree);
 			return 0;
 		default:
 			BUG();
@@ -449,7 +449,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (!main_inode->i_nlink)
 		return 0;
 
-	if (hfs_find_init(HFS_SB(main_inode->i_sb)->cat_tree, &fd))
+	if (hfs_find_init(HFS_SB(inode_sb(main_inode))->cat_tree, &fd))
 		/* panic? */
 		return -EIO;
 
@@ -518,11 +518,11 @@ static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
 	if (inode)
 		goto out;
 
-	inode = new_inode(dir->i_sb);
+	inode = new_inode(inode_sb(dir));
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	res = hfs_find_init(HFS_SB(dir->i_sb)->cat_tree, &fd);
+	res = hfs_find_init(HFS_SB(inode_sb(dir))->cat_tree, &fd);
 	if (res) {
 		iput(inode);
 		return ERR_PTR(res);
@@ -568,7 +568,7 @@ static int hfs_file_open(struct inode *inode, struct file *file)
 
 static int hfs_file_release(struct inode *inode, struct file *file)
 {
-	//struct super_block *sb = inode->i_sb;
+	//struct super_block *sb = inode_sb(inode);
 
 	if (HFS_IS_RSRC(inode))
 		inode = HFS_I(inode)->rsrc_inode;
@@ -604,7 +604,7 @@ static int hfs_file_release(struct inode *inode, struct file *file)
 int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
+	struct hfs_sb_info *hsb = HFS_SB(inode_sb(inode));
 	int error;
 
 	error = setattr_prepare(dentry, attr); /* basic permission checks */
@@ -665,7 +665,7 @@ static int hfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	ret = write_inode_now(inode, 0);
 
 	/* sync the superblock to buffers */
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	flush_delayed_work(&HFS_SB(sb)->mdb_work);
 	/* .. finally sync the buffers to disk */
 	err = sync_blockdev(sb->s_bdev);
-- 
2.15.1
