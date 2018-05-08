Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbeEHS2E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:28:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54115 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755692AbeEHSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:52 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 44/76] fs/jffs2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:04 -0700
Message-Id: <20180508180436.716-45-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/jffs2/dir.c   | 16 ++++++++--------
 fs/jffs2/file.c  |  8 ++++----
 fs/jffs2/fs.c    |  8 ++++----
 fs/jffs2/xattr.c |  6 +++---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 0a754f38462e..e539bb4e4687 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -106,7 +106,7 @@ static struct dentry *jffs2_lookup(struct inode *dir_i, struct dentry *target,
 		ino = fd->ino;
 	mutex_unlock(&dir_f->sem);
 	if (ino) {
-		inode = jffs2_iget(dir_i->i_sb, ino);
+		inode = jffs2_iget(inode_sb(dir_i), ino);
 		if (IS_ERR(inode))
 			pr_warn("iget() failed for ino #%u\n", ino);
 	}
@@ -170,7 +170,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 	if (!ri)
 		return -ENOMEM;
 
-	c = JFFS2_SB_INFO(dir_i->i_sb);
+	c = JFFS2_SB_INFO(inode_sb(dir_i));
 
 	jffs2_dbg(1, "%s()\n", __func__);
 
@@ -224,7 +224,7 @@ static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
 
 static int jffs2_unlink(struct inode *dir_i, struct dentry *dentry)
 {
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(dir_i->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(dir_i));
 	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
 	struct jffs2_inode_info *dead_f = JFFS2_INODE_INFO(d_inode(dentry));
 	int ret;
@@ -300,7 +300,7 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 	if (!ri)
 		return -ENOMEM;
 
-	c = JFFS2_SB_INFO(dir_i->i_sb);
+	c = JFFS2_SB_INFO(inode_sb(dir_i));
 
 	/* Try to reserve enough space for both node and dirent.
 	 * Just the node will do for now, though
@@ -459,7 +459,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	if (!ri)
 		return -ENOMEM;
 
-	c = JFFS2_SB_INFO(dir_i->i_sb);
+	c = JFFS2_SB_INFO(inode_sb(dir_i));
 
 	/* Try to reserve enough space for both node and dirent.
 	 * Just the node will do for now, though
@@ -586,7 +586,7 @@ static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode
 
 static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 {
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(dir_i->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(dir_i));
 	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(d_inode(dentry));
 	struct jffs2_full_dirent *fd;
@@ -627,7 +627,7 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	if (!ri)
 		return -ENOMEM;
 
-	c = JFFS2_SB_INFO(dir_i->i_sb);
+	c = JFFS2_SB_INFO(inode_sb(dir_i));
 
 	if (S_ISBLK(mode) || S_ISCHR(mode))
 		devlen = jffs2_encode_dev(&dev, rdev);
@@ -761,7 +761,7 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
 			 unsigned int flags)
 {
 	int ret;
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dir_i->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(old_dir_i));
 	struct jffs2_inode_info *victim_f = NULL;
 	uint8_t type;
 	uint32_t now;
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index bd0428bebe9b..cfab0b294897 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -32,7 +32,7 @@ static int jffs2_readpage (struct file *filp, struct page *pg);
 int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	int ret;
 
 	ret = file_write_and_wait_range(filp, start, end);
@@ -79,7 +79,7 @@ const struct address_space_operations jffs2_file_address_operations =
 static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	unsigned char *pg_buf;
 	int ret;
 
@@ -148,7 +148,7 @@ static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 
 	if (pageofs > inode->i_size) {
 		/* Make new hole frag from old EOF to new page */
-		struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+		struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 		struct jffs2_raw_inode ri;
 		struct jffs2_full_dnode *fn;
 		uint32_t alloc_len;
@@ -241,7 +241,7 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 	 */
 	struct inode *inode = mapping->host;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_raw_inode *ri;
 	unsigned start = pos & (PAGE_SIZE - 1);
 	unsigned end = start + copied;
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04eca95a3..2e03accff2f5 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -32,7 +32,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 {
 	struct jffs2_full_dnode *old_metadata, *new_metadata;
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_raw_inode *ri;
 	union jffs2_device_node dev;
 	unsigned char *mdata = NULL;
@@ -238,7 +238,7 @@ void jffs2_evict_inode (struct inode *inode)
 	/* We can forget about this inode for now - drop all
 	 *  the nodelists associated with it, etc.
 	 */
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
 
 	jffs2_dbg(1, "%s(): ino #%lu mode %o\n",
@@ -267,7 +267,7 @@ struct inode *jffs2_iget(struct super_block *sb, unsigned long ino)
 		return inode;
 
 	f = JFFS2_INODE_INFO(inode);
-	c = JFFS2_SB_INFO(inode->i_sb);
+	c = JFFS2_SB_INFO(inode_sb(inode));
 
 	jffs2_init_inode_info(f);
 	mutex_lock(&f->sem);
@@ -420,7 +420,7 @@ int jffs2_do_remount_fs(struct super_block *sb, int *flags, char *data)
 struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode, struct jffs2_raw_inode *ri)
 {
 	struct inode *inode;
-	struct super_block *sb = dir_i->i_sb;
+	struct super_block *sb = inode_sb(dir_i);
 	struct jffs2_sb_info *c;
 	struct jffs2_inode_info *f;
 	int ret;
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index da3e18503c65..880c32676ffc 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -962,7 +962,7 @@ ssize_t jffs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_inode_cache *ic = f->inocache;
 	struct jffs2_xattr_ref *ref, **pref;
 	struct jffs2_xattr_datum *xd;
@@ -1032,7 +1032,7 @@ int do_jffs2_getxattr(struct inode *inode, int xprefix, const char *xname,
 		      char *buffer, size_t size)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_inode_cache *ic = f->inocache;
 	struct jffs2_xattr_datum *xd;
 	struct jffs2_xattr_ref *ref, **pref;
@@ -1094,7 +1094,7 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		      const char *buffer, size_t size, int flags)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode->i_sb);
+	struct jffs2_sb_info *c = JFFS2_SB_INFO(inode_sb(inode));
 	struct jffs2_inode_cache *ic = f->inocache;
 	struct jffs2_xattr_datum *xd;
 	struct jffs2_xattr_ref *ref, *newref, **pref;
-- 
2.15.1
