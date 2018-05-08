Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933240AbeEHSJj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:09:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755876AbeEHSG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:29 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 69/76] fs/ubifs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:29 -0700
Message-Id: <20180508180436.716-70-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ubifs/crypto.c |  4 ++--
 fs/ubifs/dir.c    | 30 +++++++++++++++---------------
 fs/ubifs/file.c   | 42 +++++++++++++++++++++---------------------
 fs/ubifs/ioctl.c  |  4 ++--
 fs/ubifs/super.c  |  4 ++--
 fs/ubifs/xattr.c  | 10 +++++-----
 6 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/fs/ubifs/crypto.c b/fs/ubifs/crypto.c
index 616a688f5d8f..3c8122065ed5 100644
--- a/fs/ubifs/crypto.c
+++ b/fs/ubifs/crypto.c
@@ -35,7 +35,7 @@ static unsigned int ubifs_crypt_max_namelen(struct inode *inode)
 int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
 		  unsigned int in_len, unsigned int *out_len, int block)
 {
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	void *p = &dn->data;
 	struct page *ret;
 	unsigned int pad_len = round_up(in_len, UBIFS_CIPHER_BLOCK_SIZE);
@@ -61,7 +61,7 @@ int ubifs_encrypt(const struct inode *inode, struct ubifs_data_node *dn,
 int ubifs_decrypt(const struct inode *inode, struct ubifs_data_node *dn,
 		  unsigned int *out_len, int block)
 {
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	int err;
 	unsigned int clen = le16_to_cpu(dn->compr_size);
 	unsigned int dlen = *out_len;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9d7fb88e172e..6d168f5cc8ff 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -215,7 +215,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	union ubifs_key key;
 	struct inode *inode = NULL;
 	struct ubifs_dent_node *dent;
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct fscrypt_name nm;
 
 	dbg_gen("'%pd' in dir ino %lu", dentry, dir->i_ino);
@@ -262,7 +262,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_dent;
 	}
 
-	inode = ubifs_iget(dir->i_sb, le64_to_cpu(dent->inum));
+	inode = ubifs_iget(inode_sb(dir), le64_to_cpu(dent->inum));
 	if (IS_ERR(inode)) {
 		/*
 		 * This should not happen. Probably the file-system needs
@@ -307,7 +307,7 @@ static int ubifs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			bool excl)
 {
 	struct inode *inode;
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
 					.dirtied_ino = 1 };
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
@@ -376,7 +376,7 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 		      umode_t mode, struct inode **whiteout)
 {
 	struct inode *inode;
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1};
 	struct ubifs_budget_req ino_req = { .dirtied_ino = 1 };
 	struct ubifs_inode *ui, *dir_ui = ubifs_inode(dir);
@@ -525,7 +525,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 	union ubifs_key key;
 	struct ubifs_dent_node *dent;
 	struct inode *dir = file_inode(file);
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	bool encrypted = ubifs_crypt_is_encrypted(dir);
 
 	dbg_gen("dir ino %lu, f_pos %#llx", dir->i_ino, ctx->pos);
@@ -712,7 +712,7 @@ static void unlock_2_inodes(struct inode *inode1, struct inode *inode2)
 static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 		      struct dentry *dentry)
 {
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct inode *inode = d_inode(old_dentry);
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
@@ -786,7 +786,7 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
 
 static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct inode *inode = d_inode(dentry);
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
 	int err, sz_change, budgeted = 1;
@@ -873,7 +873,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
  */
 int ubifs_check_dir_empty(struct inode *dir)
 {
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct fscrypt_name nm = { 0 };
 	struct ubifs_dent_node *dent;
 	union ubifs_key key;
@@ -894,7 +894,7 @@ int ubifs_check_dir_empty(struct inode *dir)
 
 static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	struct inode *inode = d_inode(dentry);
 	int err, sz_change, budgeted = 1;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
@@ -973,7 +973,7 @@ static int ubifs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	int err, sz_change;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1 };
 	struct fscrypt_name nm;
@@ -1046,7 +1046,7 @@ static int ubifs_mknod(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	struct ubifs_inode *ui;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	union ubifs_dev_desc *dev = NULL;
 	int sz_change;
 	int err, devlen = 0;
@@ -1135,7 +1135,7 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	struct ubifs_inode *ui;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
-	struct ubifs_info *c = dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(dir)->s_fs_info;
 	int err, len = strlen(symname);
 	int sz_change = CALC_DENT_SIZE(len);
 	struct fscrypt_str disk_link;
@@ -1276,7 +1276,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 		     struct inode *new_dir, struct dentry *new_dentry,
 		     unsigned int flags)
 {
-	struct ubifs_info *c = old_dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(old_dir)->s_fs_info;
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *whiteout = NULL;
@@ -1470,7 +1470,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (release)
 		ubifs_release_budget(c, &ino_req);
 	if (IS_SYNC(old_inode))
-		err = old_inode->i_sb->s_op->write_inode(old_inode, NULL);
+		err = inode_sb(old_inode)->s_op->write_inode(old_inode, NULL);
 
 	fscrypt_free_filename(&old_nm);
 	fscrypt_free_filename(&new_nm);
@@ -1511,7 +1511,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
 static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct ubifs_info *c = old_dir->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(old_dir)->s_fs_info;
 	struct ubifs_budget_req req = { .new_dent = 1, .mod_dent = 1,
 				.dirtied_ino = 2 };
 	int sync = IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cf348ba99238..c2bf005a576b 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -57,7 +57,7 @@
 static int read_block(struct inode *inode, void *addr, unsigned int block,
 		      struct ubifs_data_node *dn)
 {
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	int err, len, out_len;
 	union ubifs_key key;
 	unsigned int dlen;
@@ -167,7 +167,7 @@ static int do_readpage(struct page *page)
 		addr += UBIFS_BLOCK_SIZE;
 	}
 	if (err) {
-		struct ubifs_info *c = inode->i_sb->s_fs_info;
+		struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 		if (err == -ENOENT) {
 			/* Not found, so it must be a hole */
 			SetPageChecked(page);
@@ -230,7 +230,7 @@ static int write_begin_slow(struct address_space *mapping,
 			    unsigned flags)
 {
 	struct inode *inode = mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	struct ubifs_budget_req req = { .new_page = 1 };
 	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
@@ -434,7 +434,7 @@ static int ubifs_write_begin(struct file *file, struct address_space *mapping,
 			     struct page **pagep, void **fsdata)
 {
 	struct inode *inode = mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = pos >> PAGE_SHIFT;
 	int uninitialized_var(err), appending = !!(pos + len > inode->i_size);
@@ -550,7 +550,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ubifs_inode *ui = ubifs_inode(inode);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	loff_t end_pos = pos + len;
 	int appending = !!(end_pos > inode->i_size);
 
@@ -836,7 +836,7 @@ static int ubifs_do_bulk_read(struct ubifs_info *c, struct bu_info *bu,
 static int ubifs_bulk_read(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	pgoff_t index = page->index, last_page_read = ui->last_page_read;
 	struct bu_info *bu;
@@ -915,7 +915,7 @@ static int do_writepage(struct page *page, int len)
 	void *addr;
 	union ubifs_key key;
 	struct inode *inode = page->mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 
 #ifdef UBIFS_DEBUG
 	struct ubifs_inode *ui = ubifs_inode(inode);
@@ -1037,7 +1037,7 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 	/* Is the page fully inside @i_size? */
 	if (page->index < end_index) {
 		if (page->index >= synced_i_size >> PAGE_SHIFT) {
-			err = inode->i_sb->s_op->write_inode(inode, NULL);
+			err = inode_sb(inode)->s_op->write_inode(inode, NULL);
 			if (err)
 				goto out_unlock;
 			/*
@@ -1065,7 +1065,7 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 	kunmap_atomic(kaddr);
 
 	if (i_size > synced_i_size) {
-		err = inode->i_sb->s_op->write_inode(inode, NULL);
+		err = inode_sb(inode)->s_op->write_inode(inode, NULL);
 		if (err)
 			goto out_unlock;
 	}
@@ -1090,13 +1090,13 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
 		inode->i_gid = attr->ia_gid;
 	if (attr->ia_valid & ATTR_ATIME)
 		inode->i_atime = timespec_trunc(attr->ia_atime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (attr->ia_valid & ATTR_MTIME)
 		inode->i_mtime = timespec_trunc(attr->ia_mtime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (attr->ia_valid & ATTR_CTIME)
 		inode->i_ctime = timespec_trunc(attr->ia_ctime,
-						inode->i_sb->s_time_gran);
+						inode_sb(inode)->s_time_gran);
 	if (attr->ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
@@ -1264,7 +1264,7 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 	if (release)
 		ubifs_release_budget(c, &req);
 	if (IS_SYNC(inode))
-		err = inode->i_sb->s_op->write_inode(inode, NULL);
+		err = inode_sb(inode)->s_op->write_inode(inode, NULL);
 	return err;
 }
 
@@ -1272,7 +1272,7 @@ int ubifs_setattr(struct dentry *dentry, struct iattr *attr)
 {
 	int err;
 	struct inode *inode = d_inode(dentry);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 
 	dbg_gen("ino %lu, mode %#x, ia_valid %#x",
 		inode->i_ino, inode->i_mode, attr->ia_valid);
@@ -1301,7 +1301,7 @@ static void ubifs_invalidatepage(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 
 	ubifs_assert(PagePrivate(page));
 	if (offset || length < PAGE_SIZE)
@@ -1321,7 +1321,7 @@ static void ubifs_invalidatepage(struct page *page, unsigned int offset,
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	int err;
 
 	dbg_gen("syncing inode %lu", inode->i_ino);
@@ -1340,7 +1340,7 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	/* Synchronize the inode unless this is a 'datasync()' call. */
 	if (!datasync || (inode->i_state & I_DIRTY_DATASYNC)) {
-		err = inode->i_sb->s_op->write_inode(inode, NULL);
+		err = inode_sb(inode)->s_op->write_inode(inode, NULL);
 		if (err)
 			goto out;
 	}
@@ -1384,7 +1384,7 @@ int ubifs_update_time(struct inode *inode, struct timespec *time,
 			     int flags)
 {
 	struct ubifs_inode *ui = ubifs_inode(inode);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
 	int iflags = I_DIRTY_TIME;
@@ -1402,7 +1402,7 @@ int ubifs_update_time(struct inode *inode, struct timespec *time,
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
+	if (!(inode_sb(inode)->s_flags & SB_LAZYTIME))
 		iflags |= I_DIRTY_SYNC;
 
 	release = ui->dirty;
@@ -1426,7 +1426,7 @@ static int update_mctime(struct inode *inode)
 {
 	struct timespec now = current_time(inode);
 	struct ubifs_inode *ui = ubifs_inode(inode);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 
 	if (mctime_update_needed(inode, &now)) {
 		int err, release;
@@ -1517,7 +1517,7 @@ static int ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct timespec now = current_time(inode);
 	struct ubifs_budget_req req = { .new_page = 1 };
 	int err, update_time;
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 0164bcc827f8..78859adf6302 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -106,7 +106,7 @@ static int setflags(struct inode *inode, int flags)
 {
 	int oldflags, err, release;
 	struct ubifs_inode *ui = ubifs_inode(inode);
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 					.dirtied_ino_d = ui->data_len };
 
@@ -186,7 +186,7 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 #ifdef CONFIG_UBIFS_FS_ENCRYPTION
-		struct ubifs_info *c = inode->i_sb->s_fs_info;
+		struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 
 		err = ubifs_enable_encryption(c);
 		if (err)
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b16ef162344a..6568653ee596 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -293,7 +293,7 @@ static void ubifs_destroy_inode(struct inode *inode)
 static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	int err = 0;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
 	ubifs_assert(!ui->xattr);
@@ -337,7 +337,7 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 static void ubifs_evict_inode(struct inode *inode)
 {
 	int err;
-	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(inode)->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 
 	if (ui->xattr)
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 759f1a209dbb..2e2de2f3f290 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -284,7 +284,7 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 		    size_t size, int flags, bool check_lock)
 {
 	struct inode *inode;
-	struct ubifs_info *c = host->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(host)->s_fs_info;
 	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
 	struct ubifs_dent_node *xent;
 	union ubifs_key key;
@@ -345,7 +345,7 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 			size_t size)
 {
 	struct inode *inode;
-	struct ubifs_info *c = host->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(host)->s_fs_info;
 	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
 	struct ubifs_inode *ui;
 	struct ubifs_dent_node *xent;
@@ -415,7 +415,7 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	union ubifs_key key;
 	struct inode *host = d_inode(dentry);
-	struct ubifs_info *c = host->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(host)->s_fs_info;
 	struct ubifs_inode *host_ui = ubifs_inode(host);
 	struct ubifs_dent_node *xent, *pxent = NULL;
 	int err, len, written = 0;
@@ -532,7 +532,7 @@ void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum)
 static int ubifs_xattr_remove(struct inode *host, const char *name)
 {
 	struct inode *inode;
-	struct ubifs_info *c = host->i_sb->s_fs_info;
+	struct ubifs_info *c = inode_sb(host)->s_fs_info;
 	struct fscrypt_name nm = { .disk_name = FSTR_INIT((char *)name, strlen(name))};
 	struct ubifs_dent_node *xent;
 	union ubifs_key key;
@@ -614,7 +614,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 	err = security_inode_init_security(inode, dentry, qstr,
 					   &init_xattrs, 0);
 	if (err) {
-		struct ubifs_info *c = dentry->i_sb->s_fs_info;
+		struct ubifs_info *c = inode_sb(dentry)->s_fs_info;
 		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
 			  inode->i_ino, err);
 	}
-- 
2.15.1
