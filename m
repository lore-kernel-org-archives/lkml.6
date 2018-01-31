Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeAaUvW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:51:22 -0500
Received: from smtp-18-i6.italiaonline.it ([213.209.14.18]:37036 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751674AbeAaUvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:51:21 -0500
x-libjamoibt: 1601
X-CNFS-Analysis: v=2.2 cv=cZCiljLM c=1 sm=1 tr=0
 a=XeJ7lniyEEjQtHijZ6FjDA==:117 a=XeJ7lniyEEjQtHijZ6FjDA==:17
 a=0AziEfc1YemQC-xtIeAA:9
From: Goffredo Baroncelli <kreijack@libero.it>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] Rename make inode_cmp_iversion{+raw} to inode_eq_iversion{+raw}
Date: Wed, 31 Jan 2018 21:43:09 +0100
Message-Id: <20180131204309.32474-1-kreijack@libero.it>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfDpPMQbOwvfMhQ+s72KMs4DtngHerPuXPsYU6GZ6L04Kq+B1KzzDBfw2ZDlmW7kzedGHxIqpI18itSjWLPCaSyGsRMrmod46w/PkcdynXIDVPe5fusXT
 iWWytD6toXm4oZixhHfRb5rmG0tyawCinarqpdWIw9yWRHBaxBomn1NYWE48FvNbuq8t8zRz0Z/XLU8zMIusCUKSIOSUB21Y3Y3KgWB1haXiEmKPImnV6le8
 1irlNkRX6ox3Ag6TXaVzLwGySINhZ9HNwur201k5MyOG3eNmHHZSe774GRHc53n/7mlSvQ01I76q4aqQmcn5hA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The function inode_cmp_iversion{+raw} is counter-intuitive, because it
returns true when the counters are different and false when these are equal.

Rename it to inode_eq_iversion{+raw}, which will returns true when
the counters are equal and false otherwise.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/affs/dir.c                     |  2 +-
 fs/exofs/dir.c                    |  2 +-
 fs/ext2/dir.c                     |  2 +-
 fs/ext4/dir.c                     |  4 ++--
 fs/ext4/inline.c                  |  2 +-
 fs/fat/namei_vfat.c               |  2 +-
 fs/nfs/inode.c                    |  6 +++---
 fs/ocfs2/dir.c                    |  4 ++--
 fs/ufs/dir.c                      |  2 +-
 include/linux/iversion.h          | 22 +++++++++++-----------
 security/integrity/ima/ima_main.c |  2 +-
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index d180b46453cf..b2bf7016e1b3 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -81,7 +81,7 @@ affs_readdir(struct file *file, struct dir_context *ctx)
 	 * we can jump directly to where we left off.
 	 */
 	ino = (u32)(long)file->private_data;
-	if (ino && inode_cmp_iversion(inode, file->f_version) == 0) {
+	if (ino && inode_eq_iversion(inode, file->f_version)) {
 		pr_debug("readdir() left off=%d\n", ino);
 		goto inside;
 	}
diff --git a/fs/exofs/dir.c b/fs/exofs/dir.c
index c5a53fcc43ea..f0138674c1ed 100644
--- a/fs/exofs/dir.c
+++ b/fs/exofs/dir.c
@@ -242,7 +242,7 @@ exofs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(exofs_chunk_size(inode)-1);
-	bool need_revalidate = inode_cmp_iversion(inode, file->f_version);
+	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 
 	if (pos > inode->i_size - EXOFS_DIR_REC_LEN(1))
 		return 0;
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 4111085a129f..3b8114def693 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -294,7 +294,7 @@ ext2_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(ext2_chunk_size(inode)-1);
 	unsigned char *types = NULL;
-	bool need_revalidate = inode_cmp_iversion(inode, file->f_version);
+	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 
 	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
 		return 0;
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index afda0a0499ce..da87cf757f7d 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -209,7 +209,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
-		if (inode_cmp_iversion(inode, file->f_version)) {
+		if (!inode_eq_iversion(inode, file->f_version)) {
 			for (i = 0; i < sb->s_blocksize && i < offset; ) {
 				de = (struct ext4_dir_entry_2 *)
 					(bh->b_data + i);
@@ -569,7 +569,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 		 * cached entries.
 		 */
 		if ((!info->curr_node) ||
-		    inode_cmp_iversion(inode, file->f_version)) {
+		    !inode_eq_iversion(inode, file->f_version)) {
 			info->curr_node = NULL;
 			free_rb_tree_fname(&info->root);
 			file->f_version = inode_query_iversion(inode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a8b987b71173..adfc1f360dae 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1495,7 +1495,7 @@ int ext4_read_inline_dir(struct file *file,
 	 * dirent right now.  Scan from the start of the inline
 	 * dir to make sure.
 	 */
-	if (inode_cmp_iversion(inode, file->f_version)) {
+	if (!inode_eq_iversion(inode, file->f_version)) {
 		for (i = 0; i < extra_size && i < offset;) {
 			/*
 			 * "." is with offset 0 and
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index cefea792cde8..2649759c478a 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -46,7 +46,7 @@ static int vfat_revalidate_shortname(struct dentry *dentry)
 {
 	int ret = 1;
 	spin_lock(&dentry->d_lock);
-	if (inode_cmp_iversion(d_inode(dentry->d_parent), vfat_d_version(dentry)))
+	if (!inode_eq_iversion(d_inode(dentry->d_parent), vfat_d_version(dentry)))
 		ret = 0;
 	spin_unlock(&dentry->d_lock);
 	return ret;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 93552c482992..011d6bc8e27b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1289,7 +1289,7 @@ static unsigned long nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr
 
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECHANGE)
 			&& (fattr->valid & NFS_ATTR_FATTR_CHANGE)
-			&& !inode_cmp_iversion_raw(inode, fattr->pre_change_attr)) {
+			&& inode_eq_iversion_raw(inode, fattr->pre_change_attr)) {
 		inode_set_iversion_raw(inode, fattr->change_attr);
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
@@ -1348,7 +1348,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 
 	if (!nfs_file_has_buffered_writers(nfsi)) {
 		/* Verify a few of the more important attributes */
-		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && inode_cmp_iversion_raw(inode, fattr->change_attr))
+		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && !inode_eq_iversion_raw(inode, fattr->change_attr))
 			invalid |= NFS_INO_INVALID_ATTR | NFS_INO_REVAL_PAGECACHE;
 
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec_equal(&inode->i_mtime, &fattr->mtime))
@@ -1778,7 +1778,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	/* More cache consistency checks */
 	if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
-		if (inode_cmp_iversion_raw(inode, fattr->change_attr)) {
+		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
 			dprintk("NFS: change_attr change on server for file %s/%ld\n",
 					inode->i_sb->s_id, inode->i_ino);
 			/* Could it be a race with writeback? */
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 32f9c72dff17..1a3a5b0ea44b 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1776,7 +1776,7 @@ static int ocfs2_dir_foreach_blk_id(struct inode *inode,
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
-		if (inode_cmp_iversion(inode, *f_version)) {
+		if (!inode_eq_iversion(inode, *f_version)) {
 			for (i = 0; i < i_size_read(inode) && i < offset; ) {
 				de = (struct ocfs2_dir_entry *)
 					(data->id_data + i);
@@ -1870,7 +1870,7 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
 		 * readdir(2), then we might be pointing to an invalid
 		 * dirent right now.  Scan from the start of the block
 		 * to make sure. */
-		if (inode_cmp_iversion(inode, *f_version)) {
+		if (!inode_eq_iversion(inode, *f_version)) {
 			for (i = 0; i < sb->s_blocksize && i < offset; ) {
 				de = (struct ocfs2_dir_entry *) (bh->b_data + i);
 				/* It's too expensive to do a full
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 50dfce000864..b721d0bda5e5 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -429,7 +429,7 @@ ufs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long n = pos >> PAGE_SHIFT;
 	unsigned long npages = dir_pages(inode);
 	unsigned chunk_mask = ~(UFS_SB(sb)->s_uspi->s_dirblksize - 1);
-	bool need_revalidate = inode_cmp_iversion(inode, file->f_version);
+	bool need_revalidate = !inode_eq_iversion(inode, file->f_version);
 	unsigned flags = UFS_SB(sb)->s_flags;
 
 	UFSD("BEGIN\n");
diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3d2fd06495ec..be50ef7cedab 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -45,7 +45,7 @@
  *
  * With this implementation, the value should always appear to observers to
  * increase over time if the file has changed. It's recommended to use
- * inode_cmp_iversion() helper to compare values.
+ * inode_eq_iversion() helper to compare values.
  *
  * Note that some filesystems (e.g. NFS and AFS) just use the field to store
  * a server-provided value (for the most part). For that reason, those
@@ -305,33 +305,33 @@ inode_query_iversion(struct inode *inode)
 }
 
 /**
- * inode_cmp_iversion_raw - check whether the raw i_version counter has changed
+ * inode_eq_iversion_raw - check whether the raw i_version counter has changed
  * @inode: inode to check
  * @old: old value to check against its i_version
  *
- * Compare the current raw i_version counter with a previous one. Returns false
- * if they are the same or true if they are different.
+ * Compare the current raw i_version counter with a previous one. Returns true
+ * if they are the same or false if they are different.
  */
 static inline bool
-inode_cmp_iversion_raw(const struct inode *inode, u64 old)
+inode_eq_iversion_raw(const struct inode *inode, u64 old)
 {
-	return inode_peek_iversion_raw(inode) != old;
+	return inode_peek_iversion_raw(inode) == old;
 }
 
 /**
- * inode_cmp_iversion - check whether the i_version counter has changed
+ * inode_eq_iversion - check whether the i_version counter has changed
  * @inode: inode to check
  * @old: old value to check against its i_version
  *
- * Compare an i_version counter with a previous one. Returns false if they are
- * the same, and true if they are different.
+ * Compare an i_version counter with a previous one. Returns true if they are
+ * the same, and false if they are different.
  *
  * Note that we don't need to set the QUERIED flag in this case, as the value
  * in the inode is not being recorded for later use.
  */
 static inline bool
-inode_cmp_iversion(const struct inode *inode, u64 old)
+inode_eq_iversion(const struct inode *inode, u64 old)
 {
-	return inode_peek_iversion(inode) != old;
+	return inode_peek_iversion(inode) == old;
 }
 #endif
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06a70c5a2329..20b9959a3ac0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,7 +129,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 	inode_lock(inode);
 	if (atomic_read(&inode->i_writecount) == 1) {
 		if (!IS_I_VERSION(inode) ||
-		    inode_cmp_iversion(inode, iint->version) ||
+		    !inode_eq_iversion(inode, iint->version) ||
 		    (iint->flags & IMA_NEW_FILE)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
-- 
2.15.1
