Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756149AbeEHSeE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:34:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:53949 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932295AbeEHSFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:24 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 25/76] fs/ecryptfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:45 -0700
Message-Id: <20180508180436.716-26-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ecryptfs/crypto.c |  5 ++---
 fs/ecryptfs/file.c   |  5 ++---
 fs/ecryptfs/inode.c  | 15 +++++++--------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 846ca150d52e..ae979420d9d1 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -800,8 +800,7 @@ int ecryptfs_new_file_context(struct inode *ecryptfs_inode)
 	struct ecryptfs_crypt_stat *crypt_stat =
 	    &ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
-	    &ecryptfs_superblock_to_private(
-		    ecryptfs_inode->i_sb)->mount_crypt_stat;
+	    &ecryptfs_superblock_to_private(inode_sb(ecryptfs_inode))->mount_crypt_stat;
 	int cipher_name_len;
 	int rc = 0;
 
@@ -1263,7 +1262,7 @@ void ecryptfs_i_size_init(const char *page_virt, struct inode *inode)
 
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
 	mount_crypt_stat =
-		&ecryptfs_superblock_to_private(inode->i_sb)->mount_crypt_stat;
+		&ecryptfs_superblock_to_private(inode_sb(inode))->mount_crypt_stat;
 	if (mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED) {
 		file_size = i_size_read(ecryptfs_inode_to_lower(inode));
 		if (crypt_stat->flags & ECRYPTFS_METADATA_IN_XATTR)
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index c74ed3ca3372..0fa5050bcbc2 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -109,7 +109,7 @@ static int ecryptfs_readdir(struct file *file, struct dir_context *ctx)
 	struct ecryptfs_getdents_callback buf = {
 		.ctx.actor = ecryptfs_filldir,
 		.caller = ctx,
-		.sb = inode->i_sb,
+		.sb = inode_sb(inode),
 	};
 	lower_file = ecryptfs_file_to_lower(file);
 	rc = iterate_dir(lower_file, &buf.ctx);
@@ -135,8 +135,7 @@ static int read_or_initialize_metadata(struct dentry *dentry)
 	int rc;
 
 	crypt_stat = &ecryptfs_inode_to_private(inode)->crypt_stat;
-	mount_crypt_stat = &ecryptfs_superblock_to_private(
-						inode->i_sb)->mount_crypt_stat;
+	mount_crypt_stat = &ecryptfs_superblock_to_private(inode_sb(inode))->mount_crypt_stat;
 	mutex_lock(&crypt_stat->cs_mutex);
 
 	if (crypt_stat->flags & ECRYPTFS_POLICY_APPLIED &&
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 847904aa63a9..ea205c666f5b 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -88,7 +88,7 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 {
 	struct inode *inode;
 
-	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
+	if (inode_sb(lower_inode) != ecryptfs_superblock_to_lower(sb))
 		return ERR_PTR(-EXDEV);
 	if (!igrab(lower_inode))
 		return ERR_PTR(-ESTALE);
@@ -194,7 +194,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 		goto out_lock;
 	}
 	inode = __ecryptfs_get_inode(d_inode(lower_dentry),
-				     directory_inode->i_sb);
+				     inode_sb(directory_inode));
 	if (IS_ERR(inode)) {
 		vfs_unlink(d_inode(lower_dir_dentry), lower_dentry, NULL);
 		goto out_lock;
@@ -441,7 +441,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		      lower_new_dentry, NULL);
 	if (rc || d_really_is_negative(lower_new_dentry))
 		goto out_lock;
-	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, dir->i_sb);
+	rc = ecryptfs_interpose(lower_new_dentry, new_dentry, inode_sb(dir));
 	if (rc)
 		goto out_lock;
 	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
@@ -474,8 +474,7 @@ static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
 	lower_dentry = ecryptfs_dentry_to_lower(dentry);
 	dget(lower_dentry);
 	lower_dir_dentry = lock_parent(lower_dentry);
-	mount_crypt_stat = &ecryptfs_superblock_to_private(
-		dir->i_sb)->mount_crypt_stat;
+	mount_crypt_stat = &ecryptfs_superblock_to_private(inode_sb(dir))->mount_crypt_stat;
 	rc = ecryptfs_encrypt_and_encode_filename(&encoded_symname,
 						  &encoded_symlen,
 						  mount_crypt_stat, symname,
@@ -487,7 +486,7 @@ static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
 	kfree(encoded_symname);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out_lock;
-	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
+	rc = ecryptfs_interpose(lower_dentry, dentry, inode_sb(dir));
 	if (rc)
 		goto out_lock;
 	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
@@ -511,7 +510,7 @@ static int ecryptfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	rc = vfs_mkdir(d_inode(lower_dir_dentry), lower_dentry, mode);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
-	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
+	rc = ecryptfs_interpose(lower_dentry, dentry, inode_sb(dir));
 	if (rc)
 		goto out;
 	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
@@ -559,7 +558,7 @@ ecryptfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev
 	rc = vfs_mknod(d_inode(lower_dir_dentry), lower_dentry, mode, dev);
 	if (rc || d_really_is_negative(lower_dentry))
 		goto out;
-	rc = ecryptfs_interpose(lower_dentry, dentry, dir->i_sb);
+	rc = ecryptfs_interpose(lower_dentry, dentry, inode_sb(dir));
 	if (rc)
 		goto out;
 	fsstack_copy_attr_times(dir, d_inode(lower_dir_dentry));
-- 
2.15.1
