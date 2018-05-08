Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756203AbeEHSfP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932127AbeEHSFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:19 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 21/76] fs/coda: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:41 -0700
Message-Id: <20180508180436.716-22-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/coda/dir.c     | 25 +++++++++++++------------
 fs/coda/file.c    |  7 ++++---
 fs/coda/inode.c   |  4 ++--
 fs/coda/pioctl.c  |  4 ++--
 fs/coda/symlink.c |  2 +-
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876ddadb43..89deb3532f5e 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -40,7 +40,7 @@ static int coda_return_EIO(void)
 /* access routines: lookup, readlink, permission */
 static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsigned int flags)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	const char *name = entry->d_name.name;
 	size_t length = entry->d_name.len;
 	struct inode *inode;
@@ -91,7 +91,7 @@ int coda_permission(struct inode *inode, int mask)
 	if (coda_cache_check(inode, mask))
 		return 0;
 
-	error = venus_access(inode->i_sb, coda_i2f(inode), mask);
+	error = venus_access(inode_sb(inode), coda_i2f(inode), mask);
     
 	if (!error)
 		coda_cache_enter(inode, mask);
@@ -144,12 +144,12 @@ static int coda_create(struct inode *dir, struct dentry *de, umode_t mode, bool
 	if (is_root_inode(dir) && coda_iscontrol(name, length))
 		return -EPERM;
 
-	error = venus_create(dir->i_sb, coda_i2f(dir), name, length, 
+	error = venus_create(inode_sb(dir), coda_i2f(dir), name, length, 
 				0, mode, &newfid, &attrs);
 	if (error)
 		goto err_out;
 
-	inode = coda_iget(dir->i_sb, &newfid, &attrs);
+	inode = coda_iget(inode_sb(dir), &newfid, &attrs);
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto err_out;
@@ -177,12 +177,12 @@ static int coda_mkdir(struct inode *dir, struct dentry *de, umode_t mode)
 		return -EPERM;
 
 	attrs.va_mode = mode;
-	error = venus_mkdir(dir->i_sb, coda_i2f(dir), 
+	error = venus_mkdir(inode_sb(dir), coda_i2f(dir), 
 			       name, len, &newfid, &attrs);
 	if (error)
 		goto err_out;
          
-	inode = coda_iget(dir->i_sb, &newfid, &attrs);
+	inode = coda_iget(inode_sb(dir), &newfid, &attrs);
 	if (IS_ERR(inode)) {
 		error = PTR_ERR(inode);
 		goto err_out;
@@ -210,7 +210,7 @@ static int coda_link(struct dentry *source_de, struct inode *dir_inode,
 	if (is_root_inode(dir_inode) && coda_iscontrol(name, len))
 		return -EPERM;
 
-	error = venus_link(dir_inode->i_sb, coda_i2f(inode),
+	error = venus_link(inode_sb(dir_inode), coda_i2f(inode),
 			   coda_i2f(dir_inode), (const char *)name, len);
 	if (error) {
 		d_drop(de);
@@ -245,7 +245,8 @@ static int coda_symlink(struct inode *dir_inode, struct dentry *de,
 	 * an inode for the entry we have to drop it.
 	 */
 	d_drop(de);
-	error = venus_symlink(dir_inode->i_sb, coda_i2f(dir_inode), name, len,
+	error = venus_symlink(inode_sb(dir_inode), coda_i2f(dir_inode), name,
+			      len,
 			      symname, symlen);
 
 	/* mtime is no good anymore */
@@ -262,7 +263,7 @@ static int coda_unlink(struct inode *dir, struct dentry *de)
 	const char *name = de->d_name.name;
 	int len = de->d_name.len;
 
-	error = venus_remove(dir->i_sb, coda_i2f(dir), name, len);
+	error = venus_remove(inode_sb(dir), coda_i2f(dir), name, len);
 	if (error)
 		return error;
 
@@ -277,7 +278,7 @@ static int coda_rmdir(struct inode *dir, struct dentry *de)
 	int len = de->d_name.len;
 	int error;
 
-	error = venus_rmdir(dir->i_sb, coda_i2f(dir), name, len);
+	error = venus_rmdir(inode_sb(dir), coda_i2f(dir), name, len);
 	if (!error) {
 		/* VFS may delete the child */
 		if (d_really_is_positive(de))
@@ -304,7 +305,7 @@ static int coda_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (flags)
 		return -EINVAL;
 
-	error = venus_rename(old_dir->i_sb, coda_i2f(old_dir),
+	error = venus_rename(inode_sb(old_dir), coda_i2f(old_dir),
 			     coda_i2f(new_dir), old_length, new_length,
 			     (const char *) old_name, (const char *)new_name);
 	if (!error) {
@@ -529,7 +530,7 @@ int coda_revalidate_inode(struct inode *inode)
 		return 0;
 
 	if (cii->c_flags & (C_VATTR | C_PURGE | C_FLUSH)) {
-		error = venus_getattr(inode->i_sb, &(cii->c_fid), &attr);
+		error = venus_getattr(inode_sb(inode), &(cii->c_fid), &attr);
 		if (error)
 			return -EIO;
 
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 1cbc1f2298ee..6f84de9d1197 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -112,7 +112,8 @@ int coda_open(struct inode *coda_inode, struct file *coda_file)
 	if (!cfi)
 		return -ENOMEM;
 
-	error = venus_open(coda_inode->i_sb, coda_i2f(coda_inode), coda_flags,
+	error = venus_open(inode_sb(coda_inode), coda_i2f(coda_inode),
+			   coda_flags,
 			   &host_file);
 	if (!host_file)
 		error = -EIO;
@@ -145,7 +146,7 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	cfi = CODA_FTOC(coda_file);
 	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
 
-	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
+	err = venus_close(inode_sb(coda_inode), coda_i2f(coda_inode),
 			  coda_flags, coda_file->f_cred->fsuid);
 
 	host_inode = file_inode(cfi->cfi_container);
@@ -191,7 +192,7 @@ int coda_fsync(struct file *coda_file, loff_t start, loff_t end, int datasync)
 
 	err = vfs_fsync(host_file, datasync);
 	if (!err && !datasync)
-		err = venus_fsync(coda_inode->i_sb, coda_i2f(coda_inode));
+		err = venus_fsync(inode_sb(coda_inode), coda_i2f(coda_inode));
 	inode_unlock(coda_inode);
 
 	return err;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 97424cf206c0..b4f3f9ace9fc 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -218,7 +218,7 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 	} 
 
 	pr_info("%s: rootinode is %ld dev %s\n",
-		__func__, root->i_ino, root->i_sb->s_id);
+		__func__, root->i_ino, inode_sb(root)->s_id);
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root) {
 		error = -EINVAL;
@@ -275,7 +275,7 @@ int coda_setattr(struct dentry *de, struct iattr *iattr)
 	vattr.va_type = C_VNON; /* cannot set type */
 
 	/* Venus is responsible for truncating the container-file!!! */
-	error = venus_setattr(inode->i_sb, coda_i2f(inode), &vattr);
+	error = venus_setattr(inode_sb(inode), coda_i2f(inode), &vattr);
 
 	if (!error) {
 	        coda_vattr_to_iattr(inode, &vattr); 
diff --git a/fs/coda/pioctl.c b/fs/coda/pioctl.c
index e0c17b7dccce..c7158c04aba7 100644
--- a/fs/coda/pioctl.c
+++ b/fs/coda/pioctl.c
@@ -75,7 +75,7 @@ static long coda_pioctl(struct file *filp, unsigned int cmd,
 	target_inode = d_inode(path.dentry);
 
 	/* return if it is not a Coda inode */
-	if (target_inode->i_sb != inode->i_sb) {
+	if (inode_sb(target_inode) != inode_sb(inode)) {
 		error = -EINVAL;
 		goto out;
 	}
@@ -83,7 +83,7 @@ static long coda_pioctl(struct file *filp, unsigned int cmd,
 	/* now proceed to make the upcall */
 	cnp = ITOC(target_inode);
 
-	error = venus_pioctl(inode->i_sb, &(cnp->c_fid), cmd, &data);
+	error = venus_pioctl(inode_sb(inode), &(cnp->c_fid), cmd, &data);
 out:
 	path_put(&path);
 	return error;
diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 202297d156df..68dff2c5df74 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -31,7 +31,7 @@ static int coda_symlink_filler(struct file *file, struct page *page)
 
 	cii = ITOC(inode);
 
-	error = venus_readlink(inode->i_sb, &cii->c_fid, p, &len);
+	error = venus_readlink(inode_sb(inode), &cii->c_fid, p, &len);
 	if (error)
 		goto fail;
 	SetPageUptodate(page);
-- 
2.15.1
