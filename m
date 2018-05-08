Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933071AbeEHSiC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:38:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755495AbeEHSFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:07 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 13/76] fs/affs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:33 -0700
Message-Id: <20180508180436.716-14-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/affs/amigaffs.c | 10 +++++-----
 fs/affs/bitmap.c   |  2 +-
 fs/affs/dir.c      |  2 +-
 fs/affs/file.c     | 28 ++++++++++++++--------------
 fs/affs/inode.c    | 16 ++++++++--------
 fs/affs/namei.c    | 12 ++++++------
 fs/affs/symlink.c  |  4 ++--
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index 14a6c1b90c9f..42dacf56dd0e 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -25,7 +25,7 @@
 int
 affs_insert_hash(struct inode *dir, struct buffer_head *bh)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct buffer_head *dir_bh;
 	u32 ino, hash_ino;
 	int offset;
@@ -80,7 +80,7 @@ affs_remove_hash(struct inode *dir, struct buffer_head *rem_bh)
 	__be32 ino;
 	int offset, retval;
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	rem_ino = rem_bh->b_blocknr;
 	offset = affs_hash_name(sb, AFFS_TAIL(sb, rem_bh)->name+1, AFFS_TAIL(sb, rem_bh)->name[0]);
 	pr_debug("%s(dir=%lu, ino=%d, hashval=%d)\n", __func__, dir->i_ino,
@@ -142,7 +142,7 @@ static int
 affs_remove_link(struct dentry *dentry)
 {
 	struct inode *dir, *inode = d_inode(dentry);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh, *link_bh = NULL;
 	u32 link_ino, ino;
 	int retval;
@@ -233,7 +233,7 @@ affs_remove_link(struct dentry *dentry)
 static int
 affs_empty_dir(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh;
 	int retval, size;
 
@@ -272,7 +272,7 @@ affs_remove_header(struct dentry *dentry)
 	int retval;
 
 	dir = d_inode(dentry->d_parent);
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 
 	retval = -ENOENT;
 	inode = d_inode(dentry);
diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
index 5ba9ef2742f6..b6f7955680c4 100644
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -122,7 +122,7 @@ affs_alloc_block(struct inode *inode, u32 goal)
 	u32 blk, bmap, bit, mask, mask2, tmp;
 	int i;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	sbi = AFFS_SB(sb);
 
 	pr_debug("balloc(inode=%lu,goal=%u): ", inode->i_ino, goal);
diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index b2bf7016e1b3..098b52a09634 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -45,7 +45,7 @@ static int
 affs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode		*inode = file_inode(file);
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	struct buffer_head	*dir_bh = NULL;
 	struct buffer_head	*fh_bh = NULL;
 	unsigned char		*name;
diff --git a/fs/affs/file.c b/fs/affs/file.c
index a85817f54483..e253f1137921 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -47,7 +47,7 @@ affs_file_release(struct inode *inode, struct file *filp)
 static int
 affs_grow_extcache(struct inode *inode, u32 lc_idx)
 {
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	struct buffer_head	*bh;
 	u32 lc_max;
 	int i, j, key;
@@ -117,7 +117,7 @@ affs_grow_extcache(struct inode *inode, u32 lc_idx)
 static struct buffer_head *
 affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *new_bh;
 	u32 blocknr, tmp;
 
@@ -169,7 +169,7 @@ affs_get_extblock(struct inode *inode, u32 ext)
 static struct buffer_head *
 affs_get_extblock_slow(struct inode *inode, u32 ext)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh;
 	u32 ext_key;
 	u32 lc_idx, lc_off, ac_idx;
@@ -294,7 +294,7 @@ affs_get_extblock_slow(struct inode *inode, u32 ext)
 static int
 affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_result, int create)
 {
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	struct buffer_head	*ext_bh;
 	u32			 ext;
 
@@ -353,7 +353,7 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 	return 0;
 
 err_big:
-	affs_error(inode->i_sb, "get_block", "strange block request %llu",
+	affs_error(inode_sb(inode), "get_block", "strange block request %llu",
 		   (unsigned long long)block);
 	return -EIO;
 err_ext:
@@ -451,7 +451,7 @@ affs_bread_ino(struct inode *inode, int block, int create)
 	tmp_bh.b_state = 0;
 	err = affs_get_block(inode, block, &tmp_bh, create);
 	if (!err) {
-		bh = affs_bread(inode->i_sb, tmp_bh.b_blocknr);
+		bh = affs_bread(inode_sb(inode), tmp_bh.b_blocknr);
 		if (bh) {
 			bh->b_state |= tmp_bh.b_state;
 			return bh;
@@ -470,7 +470,7 @@ affs_getzeroblk_ino(struct inode *inode, int block)
 	tmp_bh.b_state = 0;
 	err = affs_get_block(inode, block, &tmp_bh, 1);
 	if (!err) {
-		bh = affs_getzeroblk(inode->i_sb, tmp_bh.b_blocknr);
+		bh = affs_getzeroblk(inode_sb(inode), tmp_bh.b_blocknr);
 		if (bh) {
 			bh->b_state |= tmp_bh.b_state;
 			return bh;
@@ -489,7 +489,7 @@ affs_getemptyblk_ino(struct inode *inode, int block)
 	tmp_bh.b_state = 0;
 	err = affs_get_block(inode, block, &tmp_bh, 1);
 	if (!err) {
-		bh = affs_getemptyblk(inode->i_sb, tmp_bh.b_blocknr);
+		bh = affs_getemptyblk(inode_sb(inode), tmp_bh.b_blocknr);
 		if (bh) {
 			bh->b_state |= tmp_bh.b_state;
 			return bh;
@@ -503,7 +503,7 @@ static int
 affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 {
 	struct inode *inode = page->mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh;
 	char *data;
 	unsigned pos = 0;
@@ -539,7 +539,7 @@ affs_do_readpage_ofs(struct page *page, unsigned to, int create)
 static int
 affs_extent_file_ofs(struct inode *inode, u32 newsize)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh, *prev_bh;
 	u32 bidx, boff;
 	u32 size, bsize;
@@ -671,7 +671,7 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 				struct page *page, void *fsdata)
 {
 	struct inode *inode = mapping->host;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh, *prev_bh;
 	char *data;
 	u32 bidx, boff, bsize;
@@ -819,7 +819,7 @@ const struct address_space_operations affs_aops_ofs = {
 void
 affs_free_prealloc(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	pr_debug("free_prealloc(ino=%lu)\n", inode->i_ino);
 
@@ -834,7 +834,7 @@ affs_free_prealloc(struct inode *inode)
 void
 affs_truncate(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u32 ext, ext_key;
 	u32 last_blk, blkcnt, blk;
 	u32 size;
@@ -961,7 +961,7 @@ int affs_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 
 	inode_lock(inode);
 	ret = write_inode_now(inode, 0);
-	err = sync_blockdev(inode->i_sb->s_bdev);
+	err = sync_blockdev(inode_sb(inode)->s_bdev);
 	if (!ret)
 		ret = err;
 	inode_unlock(inode);
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 73598bff8506..f64d01e33a29 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -169,7 +169,7 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 int
 affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	struct buffer_head	*bh;
 	struct affs_tail	*tail;
 	uid_t			 uid;
@@ -228,13 +228,13 @@ affs_notify_change(struct dentry *dentry, struct iattr *attr)
 		goto out;
 
 	if (((attr->ia_valid & ATTR_UID) &&
-	      affs_test_opt(AFFS_SB(inode->i_sb)->s_flags, SF_SETUID)) ||
+	      affs_test_opt(AFFS_SB(inode_sb(inode))->s_flags, SF_SETUID)) ||
 	    ((attr->ia_valid & ATTR_GID) &&
-	      affs_test_opt(AFFS_SB(inode->i_sb)->s_flags, SF_SETGID)) ||
+	      affs_test_opt(AFFS_SB(inode_sb(inode))->s_flags, SF_SETGID)) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
-	     (AFFS_SB(inode->i_sb)->s_flags &
+	     (AFFS_SB(inode_sb(inode))->s_flags &
 	      (AFFS_MOUNT_SF_SETMODE | AFFS_MOUNT_SF_IMMUTABLE)))) {
-		if (!affs_test_opt(AFFS_SB(inode->i_sb)->s_flags, SF_QUIET))
+		if (!affs_test_opt(AFFS_SB(inode_sb(inode))->s_flags, SF_QUIET))
 			error = -EPERM;
 		goto out;
 	}
@@ -286,13 +286,13 @@ affs_evict_inode(struct inode *inode)
 	AFFS_I(inode)->i_ext_bh = NULL;
 
 	if (!inode->i_nlink)
-		affs_free_block(inode->i_sb, inode->i_ino);
+		affs_free_block(inode_sb(inode), inode->i_ino);
 }
 
 struct inode *
 affs_new_inode(struct inode *dir)
 {
-	struct super_block	*sb = dir->i_sb;
+	struct super_block	*sb = inode_sb(dir);
 	struct inode		*inode;
 	u32			 block;
 	struct buffer_head	*bh;
@@ -349,7 +349,7 @@ affs_new_inode(struct inode *dir)
 int
 affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s32 type)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct buffer_head *inode_bh = NULL;
 	struct buffer_head *bh;
 	u32 block = 0;
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index d8aa0ae3d037..3fb3c33618f6 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -169,7 +169,7 @@ affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len)
 static struct buffer_head *
 affs_find_entry(struct inode *dir, struct dentry *dentry)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct buffer_head *bh;
 	toupper_t toupper = affs_get_toupper(sb);
 	u32 key;
@@ -198,7 +198,7 @@ affs_find_entry(struct inode *dir, struct dentry *dentry)
 struct dentry *
 affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct buffer_head *bh;
 	struct inode *inode = NULL;
 
@@ -241,7 +241,7 @@ affs_unlink(struct inode *dir, struct dentry *dentry)
 int
 affs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct inode	*inode;
 	int		 error;
 
@@ -310,7 +310,7 @@ affs_rmdir(struct inode *dir, struct dentry *dentry)
 int
 affs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 {
-	struct super_block	*sb = dir->i_sb;
+	struct super_block	*sb = inode_sb(dir);
 	struct buffer_head	*bh;
 	struct inode		*inode;
 	char			*p;
@@ -399,7 +399,7 @@ static int
 affs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	    struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct super_block *sb = old_dir->i_sb;
+	struct super_block *sb = inode_sb(old_dir);
 	struct buffer_head *bh = NULL;
 	int retval;
 
@@ -447,7 +447,7 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	     struct inode *new_dir, struct dentry *new_dentry)
 {
 
-	struct super_block *sb = old_dir->i_sb;
+	struct super_block *sb = inode_sb(old_dir);
 	struct buffer_head *bh_old = NULL;
 	struct buffer_head *bh_new = NULL;
 	int retval;
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index a7531b26e8f0..c82618c32843 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -23,7 +23,7 @@ static int affs_symlink_readpage(struct file *file, struct page *page)
 
 	pr_debug("get_link(ino=%lu)\n", inode->i_ino);
 
-	bh = affs_bread(inode->i_sb, inode->i_ino);
+	bh = affs_bread(inode_sb(inode), inode->i_ino);
 	if (!bh)
 		goto fail;
 	i  = 0;
@@ -32,7 +32,7 @@ static int affs_symlink_readpage(struct file *file, struct page *page)
 	lc = 0;
 
 	if (strchr(lf->symname,':')) {	/* Handle assign or volume name */
-		struct affs_sb_info *sbi = AFFS_SB(inode->i_sb);
+		struct affs_sb_info *sbi = AFFS_SB(inode_sb(inode));
 		char *pf;
 		spin_lock(&sbi->symlink_lock);
 		pf = sbi->s_prefix ? sbi->s_prefix : "/";
-- 
2.15.1
