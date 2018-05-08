Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756213AbeEHSfq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:35:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755615AbeEHSFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:17 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 20/76] fs/cifs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:40 -0700
Message-Id: <20180508180436.716-21-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/cifs/cifsacl.c   |  4 ++--
 fs/cifs/cifsfs.c    |  4 ++--
 fs/cifs/cifsglob.h  |  2 +-
 fs/cifs/dir.c       | 29 ++++++++++++++++-------------
 fs/cifs/file.c      | 42 ++++++++++++++++++++++--------------------
 fs/cifs/fscache.c   |  4 ++--
 fs/cifs/inode.c     | 43 +++++++++++++++++++++++--------------------
 fs/cifs/ioctl.c     |  2 +-
 fs/cifs/link.c      | 10 +++++-----
 fs/cifs/readdir.c   |  2 +-
 fs/cifs/smb1ops.c   |  4 ++--
 fs/cifs/smb2inode.c |  2 +-
 fs/cifs/smb2ops.c   |  4 ++--
 13 files changed, 80 insertions(+), 72 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 13a8a77322c9..d7b37ff7d57f 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1081,7 +1081,7 @@ int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	unsigned int xid;
 	int rc, access_flags, create_options = 0;
 	struct cifs_tcon *tcon;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
@@ -1178,7 +1178,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 nmode,
 	__u32 secdesclen = 0;
 	struct cifs_ntsd *pntsd = NULL; /* acl obtained from server */
 	struct cifs_ntsd *pnntsd = NULL; /* modified acl to be sent to server */
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct smb_version_operations *ops;
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 32cdea67bbfd..54741739c5e6 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -231,7 +231,7 @@ static int cifs_permission(struct inode *inode, int mask)
 {
 	struct cifs_sb_info *cifs_sb;
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM) {
 		if ((mask & MAY_EXEC) && !execute_ok(inode))
@@ -581,7 +581,7 @@ static int cifs_remount(struct super_block *sb, int *flags, char *data)
 
 static int cifs_drop_inode(struct inode *inode)
 {
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 
 	/* no serverino => unconditional eviction */
 	return !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) ||
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 48f7c197cd2d..35910ece3526 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1265,7 +1265,7 @@ CIFS_SB(struct super_block *sb)
 static inline struct cifs_sb_info *
 CIFS_FILE_SB(struct file *file)
 {
-	return CIFS_SB(file_inode(file)->i_sb);
+	return CIFS_SB(inode_sb(file_inode(file)));
 }
 
 static inline char CIFS_DIR_SEP(const struct cifs_sb_info *cifs_sb)
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 81ba6e0d88d8..201ec5c3d4fe 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -231,7 +231,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
 	int desired_access;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifs_tcon *tcon = tlink_tcon(tlink);
 	char *full_path = NULL;
 	FILE_ALL_INFO *buf = NULL;
@@ -253,7 +253,8 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	if (tcon->unix_ext && cap_unix(tcon->ses) && !tcon->broken_posix_open &&
 	    (CIFS_UNIX_POSIX_PATH_OPS_CAP &
 			le64_to_cpu(tcon->fsUnixInfo.Capability))) {
-		rc = cifs_posix_open(full_path, &newinode, inode->i_sb, mode,
+		rc = cifs_posix_open(full_path, &newinode, inode_sb(inode),
+				     mode,
 				     oflags, oplock, &fid->netfid, xid);
 		switch (rc) {
 		case 0:
@@ -414,10 +415,12 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 cifs_create_get_file_info:
 	/* server might mask mode so we have to query for it */
 	if (tcon->unix_ext)
-		rc = cifs_get_inode_info_unix(&newinode, full_path, inode->i_sb,
+		rc = cifs_get_inode_info_unix(&newinode, full_path,
+					      inode_sb(inode),
 					      xid);
 	else {
-		rc = cifs_get_inode_info(&newinode, full_path, buf, inode->i_sb,
+		rc = cifs_get_inode_info(&newinode, full_path, buf,
+					 inode_sb(inode),
 					 xid, fid);
 		if (newinode) {
 			if (server->ops->set_lease_key)
@@ -511,7 +514,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_dbg(FYI, "parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
 
-	tlink = cifs_sb_tlink(CIFS_SB(inode->i_sb));
+	tlink = cifs_sb_tlink(CIFS_SB(inode_sb(inode)));
 	if (IS_ERR(tlink)) {
 		rc = PTR_ERR(tlink);
 		goto out_free_xid;
@@ -550,8 +553,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	}
 
 	if (file->f_flags & O_DIRECT &&
-	    CIFS_SB(inode->i_sb)->mnt_cifs_flags & CIFS_MOUNT_STRICT_IO) {
-		if (CIFS_SB(inode->i_sb)->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
+	    CIFS_SB(inode_sb(inode))->mnt_cifs_flags & CIFS_MOUNT_STRICT_IO) {
+		if (CIFS_SB(inode_sb(inode))->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
 			file->f_op = &cifs_file_direct_nobrl_ops;
 		else
 			file->f_op = &cifs_file_direct_ops;
@@ -595,7 +598,7 @@ int cifs_create(struct inode *inode, struct dentry *direntry, umode_t mode,
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
 
-	tlink = cifs_sb_tlink(CIFS_SB(inode->i_sb));
+	tlink = cifs_sb_tlink(CIFS_SB(inode_sb(inode)));
 	rc = PTR_ERR(tlink);
 	if (IS_ERR(tlink))
 		goto out_free_xid;
@@ -640,7 +643,7 @@ int cifs_mknod(struct inode *inode, struct dentry *direntry, umode_t mode,
 	if (!old_valid_dev(device_number))
 		return -EINVAL;
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -677,7 +680,7 @@ int cifs_mknod(struct inode *inode, struct dentry *direntry, umode_t mode,
 			goto mknod_out;
 
 		rc = cifs_get_inode_info_unix(&newinode, full_path,
-						inode->i_sb, xid);
+						inode_sb(inode), xid);
 
 		if (rc == 0)
 			d_instantiate(direntry, newinode);
@@ -775,7 +778,7 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 
 	/* check whether path exists */
 
-	cifs_sb = CIFS_SB(parent_dir_inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(parent_dir_inode));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink)) {
 		free_xid(xid);
@@ -806,10 +809,10 @@ cifs_lookup(struct inode *parent_dir_inode, struct dentry *direntry,
 
 	if (pTcon->unix_ext) {
 		rc = cifs_get_inode_info_unix(&newInode, full_path,
-					      parent_dir_inode->i_sb, xid);
+					      inode_sb(parent_dir_inode), xid);
 	} else {
 		rc = cifs_get_inode_info(&newInode, full_path, NULL,
-				parent_dir_inode->i_sb, xid, NULL);
+				inode_sb(parent_dir_inode), xid, NULL);
 	}
 
 	if ((rc == 0) && (newInode != NULL)) {
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 7cee97b93a61..ecb3bf22bfa0 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -246,10 +246,12 @@ cifs_nt_open(char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
 		goto out;
 
 	if (tcon->unix_ext)
-		rc = cifs_get_inode_info_unix(&inode, full_path, inode->i_sb,
+		rc = cifs_get_inode_info_unix(&inode, full_path,
+					      inode_sb(inode),
 					      xid);
 	else
-		rc = cifs_get_inode_info(&inode, full_path, buf, inode->i_sb,
+		rc = cifs_get_inode_info(&inode, full_path, buf,
+					 inode_sb(inode),
 					 xid, fid);
 
 out:
@@ -314,7 +316,7 @@ cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	mutex_init(&cfile->fh_mutex);
 	spin_lock_init(&cfile->file_info_lock);
 
-	cifs_sb_active(inode->i_sb);
+	cifs_sb_active(inode_sb(inode));
 
 	/*
 	 * If the server returned a read oplock and we have mandatory brlocks,
@@ -369,7 +371,7 @@ void cifsFileInfo_put(struct cifsFileInfo *cifs_file)
 	struct cifs_tcon *tcon = tlink_tcon(cifs_file->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifsLockInfo *li, *tmp;
 	struct cifs_fid fid;
@@ -466,7 +468,7 @@ int cifs_open(struct inode *inode, struct file *file)
 
 	xid = get_xid();
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink)) {
 		free_xid(xid);
@@ -501,9 +503,9 @@ int cifs_open(struct inode *inode, struct file *file)
 	    cap_unix(tcon->ses) && (CIFS_UNIX_POSIX_PATH_OPS_CAP &
 				le64_to_cpu(tcon->fsUnixInfo.Capability))) {
 		/* can not refresh inode info since size could be stale */
-		rc = cifs_posix_open(full_path, &inode, inode->i_sb,
-				cifs_sb->mnt_file_mode /* ignored */,
-				file->f_flags, &oplock, &fid.netfid, xid);
+		rc = cifs_posix_open(full_path, &inode, inode_sb(inode),
+				     cifs_sb->mnt_file_mode /* ignored */,
+				     file->f_flags, &oplock, &fid.netfid, xid);
 		if (rc == 0) {
 			cifs_dbg(FYI, "posix open succeeded\n");
 			posix_open_ok = true;
@@ -634,7 +636,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	}
 
 	inode = d_inode(cfile->dentry);
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	tcon = tlink_tcon(cfile->tlink);
 	server = tcon->ses->server;
 
@@ -670,7 +672,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		unsigned int oflags = cfile->f_flags &
 						~(O_CREAT | O_EXCL | O_TRUNC);
 
-		rc = cifs_posix_open(full_path, NULL, inode->i_sb,
+		rc = cifs_posix_open(full_path, NULL, inode_sb(inode),
 				     cifs_sb->mnt_file_mode /* ignored */,
 				     oflags, &oplock, &cfile->fid.netfid, xid);
 		if (rc == 0) {
@@ -734,10 +736,10 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 
 		if (tcon->unix_ext)
 			rc = cifs_get_inode_info_unix(&inode, full_path,
-						      inode->i_sb, xid);
+						      inode_sb(inode), xid);
 		else
 			rc = cifs_get_inode_info(&inode, full_path, NULL,
-						 inode->i_sb, xid, NULL);
+						 inode_sb(inode), xid, NULL);
 	}
 	/*
 	 * Else we are writing out data to server already and could deadlock if
@@ -1790,7 +1792,7 @@ struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *cifs_inode,
 					bool fsuid_only)
 {
 	struct cifsFileInfo *open_file = NULL;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(cifs_inode->vfs_inode.i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(&cifs_inode->vfs_inode));
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
 	/* only filter by fsuid on multiuser mounts */
@@ -1841,7 +1843,7 @@ struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *cifs_inode,
 		return NULL;
 	}
 
-	cifs_sb = CIFS_SB(cifs_inode->vfs_inode.i_sb);
+	cifs_sb = CIFS_SB(inode_sb(&cifs_inode->vfs_inode));
 	tcon = cifs_sb_master_tcon(cifs_sb);
 
 	/* only filter by fsuid on multiuser mounts */
@@ -2093,7 +2095,7 @@ wdata_send_pages(struct cifs_writedata *wdata, unsigned int nr_pages,
 static int cifs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	struct cifs_sb_info *cifs_sb = CIFS_SB(mapping->host->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(mapping->host));
 	struct TCP_Server_Info *server;
 	bool done = false, scanned = false, range_whole = false;
 	pgoff_t end, index;
@@ -2321,7 +2323,7 @@ int cifs_strict_fsync(struct file *file, loff_t start, loff_t end,
 	struct TCP_Server_Info *server;
 	struct cifsFileInfo *smbfile = file->private_data;
 	struct inode *inode = file_inode(file);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 
 	rc = file_write_and_wait_range(file, start, end);
 	if (rc)
@@ -2837,7 +2839,7 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifsFileInfo *cfile = (struct cifsFileInfo *)
 						iocb->ki_filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
@@ -3333,7 +3335,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifsFileInfo *cfile = (struct cifsFileInfo *)
 						iocb->ki_filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
@@ -3900,7 +3902,7 @@ static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
 {
 	struct cifsFileInfo *open_file;
 	struct cifs_tcon *tcon =
-		cifs_sb_master_tcon(CIFS_SB(cifs_inode->vfs_inode.i_sb));
+		cifs_sb_master_tcon(CIFS_SB(inode_sb(&cifs_inode->vfs_inode)));
 
 	spin_lock(&tcon->open_file_lock);
 	list_for_each_entry(open_file, &cifs_inode->openFileList, flist) {
@@ -3928,7 +3930,7 @@ bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file)
 		/* This inode is open for write at least once */
 		struct cifs_sb_info *cifs_sb;
 
-		cifs_sb = CIFS_SB(cifsInode->vfs_inode.i_sb);
+		cifs_sb = CIFS_SB(inode_sb(&cifsInode->vfs_inode));
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
 			/* since no page cache to corrupt on directio
 			we can change size safely */
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 8d4b7bc8ae91..bb24a08d7edd 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -61,7 +61,7 @@ void cifs_fscache_release_super_cookie(struct cifs_tcon *tcon)
 static void cifs_fscache_enable_inode_cookie(struct inode *inode)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
 	if (cifsi->fscache)
@@ -109,7 +109,7 @@ void cifs_fscache_set_inode_cookie(struct inode *inode, struct file *filp)
 void cifs_fscache_reset_inode_cookie(struct inode *inode)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct fscache_cookie *old = cifsi->fscache;
 
 	if (cifsi->fscache) {
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 8f9a8cc7cc62..b29d09642214 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -39,7 +39,7 @@
 
 static void cifs_set_ops(struct inode *inode)
 {
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
@@ -157,7 +157,7 @@ void
 cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 
 	cifs_revalidate_cache(inode, fattr);
 
@@ -340,7 +340,7 @@ cifs_get_file_info_unix(struct file *filp)
 	FILE_UNIX_BASIC_INFO find_data;
 	struct cifs_fattr fattr;
 	struct inode *inode = file_inode(filp);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifsFileInfo *cfile = filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 
@@ -349,7 +349,7 @@ cifs_get_file_info_unix(struct file *filp)
 	if (!rc) {
 		cifs_unix_basic_to_fattr(&fattr, &find_data, cifs_sb);
 	} else if (rc == -EREMOTE) {
-		cifs_create_dfs_fattr(&fattr, inode->i_sb);
+		cifs_create_dfs_fattr(&fattr, inode_sb(inode));
 		rc = 0;
 	}
 
@@ -675,11 +675,12 @@ cifs_get_file_info(struct file *filp)
 	rc = server->ops->query_file_info(xid, tcon, &cfile->fid, &find_data);
 	switch (rc) {
 	case 0:
-		cifs_all_info_to_fattr(&fattr, &find_data, inode->i_sb, false,
+		cifs_all_info_to_fattr(&fattr, &find_data, inode_sb(inode),
+				       false,
 				       false);
 		break;
 	case -EREMOTE:
-		cifs_create_dfs_fattr(&fattr, inode->i_sb);
+		cifs_create_dfs_fattr(&fattr, inode_sb(inode));
 		rc = 0;
 		break;
 	case -EOPNOTSUPP:
@@ -1078,7 +1079,7 @@ cifs_set_file_info(struct inode *inode, struct iattr *attrs, unsigned int xid,
 		   char *full_path, __u32 dosattr)
 {
 	bool set_time = false;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct TCP_Server_Info *server;
 	FILE_BASIC_INFO	info_buf;
 
@@ -1137,7 +1138,7 @@ cifs_rename_pending_delete(const char *full_path, struct dentry *dentry,
 	struct cifs_open_parms oparms;
 	struct inode *inode = d_inode(dentry);
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	__u32 dosattr, origattr;
@@ -1277,7 +1278,7 @@ int cifs_unlink(struct inode *dir, struct dentry *dentry)
 	char *full_path = NULL;
 	struct inode *inode = d_inode(dentry);
 	struct cifsInodeInfo *cifs_inode;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
@@ -1389,10 +1390,12 @@ cifs_mkdir_qinfo(struct inode *parent, struct dentry *dentry, umode_t mode,
 	struct inode *inode = NULL;
 
 	if (tcon->unix_ext)
-		rc = cifs_get_inode_info_unix(&inode, full_path, parent->i_sb,
+		rc = cifs_get_inode_info_unix(&inode, full_path,
+					      inode_sb(parent),
 					      xid);
 	else
-		rc = cifs_get_inode_info(&inode, full_path, NULL, parent->i_sb,
+		rc = cifs_get_inode_info(&inode, full_path, NULL,
+					 inode_sb(parent),
 					 xid, NULL);
 
 	if (rc)
@@ -1490,8 +1493,8 @@ cifs_posix_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode,
 	 */
 
 	cifs_unix_basic_to_fattr(&fattr, info, cifs_sb);
-	cifs_fill_uniqueid(inode->i_sb, &fattr);
-	newinode = cifs_iget(inode->i_sb, &fattr);
+	cifs_fill_uniqueid(inode_sb(inode), &fattr);
+	newinode = cifs_iget(inode_sb(inode), &fattr);
 	if (!newinode)
 		goto posix_mkdir_get_info;
 
@@ -1528,7 +1531,7 @@ int cifs_mkdir(struct inode *inode, struct dentry *direntry, umode_t mode)
 	cifs_dbg(FYI, "In cifs_mkdir, mode = 0x%hx inode = 0x%p\n",
 		 mode, inode);
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -1600,7 +1603,7 @@ int cifs_rmdir(struct inode *inode, struct dentry *direntry)
 		goto rmdir_exit;
 	}
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink)) {
 		rc = PTR_ERR(tlink);
@@ -1722,7 +1725,7 @@ cifs_rename2(struct inode *source_dir, struct dentry *source_dentry,
 	if (flags & ~RENAME_NOREPLACE)
 		return -EINVAL;
 
-	cifs_sb = CIFS_SB(source_dir->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(source_dir));
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
@@ -1825,7 +1828,7 @@ static bool
 cifs_inode_needs_reval(struct inode *inode)
 {
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 
 	if (CIFS_CACHE_READ(cifs_i))
 		return false;
@@ -2088,7 +2091,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 	int rc;
 	struct cifsFileInfo *open_file;
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = NULL;
 	struct cifs_tcon *tcon = NULL;
 	struct TCP_Server_Info *server;
@@ -2160,7 +2163,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	char *full_path = NULL;
 	struct inode *inode = d_inode(direntry);
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	struct cifs_unix_set_info_args *args = NULL;
@@ -2299,7 +2302,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	kuid_t uid = INVALID_UID;
 	kgid_t gid = INVALID_GID;
 	struct inode *inode = d_inode(direntry);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct cifsInodeInfo *cifsInode = CIFS_I(inode);
 	char *full_path = NULL;
 	int rc = -EACCES;
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index 54f32f9143a9..abb71d967084 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -131,7 +131,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 
 	xid = get_xid();
 
-	cifs_sb = CIFS_SB(inode->i_sb);
+	cifs_sb = CIFS_SB(inode_sb(inode));
 	cifs_dbg(FYI, "cifs ioctl 0x%x\n", command);
 	switch (command) {
 		case FS_IOC_GETFLAGS:
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 60b5a11ee11b..bd4d4ddc40a1 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -535,7 +535,7 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 	unsigned int xid;
 	char *from_name = NULL;
 	char *to_name = NULL;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -625,7 +625,7 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 	unsigned int xid;
 	char *full_path = NULL;
 	char *target_path = NULL;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = NULL;
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
@@ -681,7 +681,7 @@ cifs_symlink(struct inode *inode, struct dentry *direntry, const char *symname)
 {
 	int rc = -EOPNOTSUPP;
 	unsigned int xid;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink;
 	struct cifs_tcon *pTcon;
 	char *full_path = NULL;
@@ -719,10 +719,10 @@ cifs_symlink(struct inode *inode, struct dentry *direntry, const char *symname)
 	if (rc == 0) {
 		if (pTcon->unix_ext)
 			rc = cifs_get_inode_info_unix(&newinode, full_path,
-						      inode->i_sb, xid);
+						      inode_sb(inode), xid);
 		else
 			rc = cifs_get_inode_info(&newinode, full_path, NULL,
-						 inode->i_sb, xid, NULL);
+						 inode_sb(inode), xid, NULL);
 
 		if (rc != 0) {
 			cifs_dbg(FYI, "Create symlink ok, getinodeinfo fail rc = %d\n",
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index a27fc8791551..19e3a9f6f89c 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -689,7 +689,7 @@ static int cifs_filldir(char *find_entry, struct file *file,
 		char *scratch_buf, unsigned int max_len)
 {
 	struct cifsFileInfo *file_info = file->private_data;
-	struct super_block *sb = file_inode(file)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(file));
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_dirent de = { NULL, };
 	struct cifs_fattr fattr;
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 3d495e440c87..a0385106b711 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -774,7 +774,7 @@ smb_set_file_info(struct inode *inode, const char *full_path,
 	struct cifs_open_parms oparms;
 	struct cifsFileInfo *open_file;
 	struct cifsInodeInfo *cinode = CIFS_I(inode);
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = NULL;
 	struct cifs_tcon *tcon;
 
@@ -1013,7 +1013,7 @@ cifs_is_read_op(__u32 oplock)
 static unsigned int
 cifs_wp_retry_size(struct inode *inode)
 {
-	return CIFS_SB(inode->i_sb)->wsize;
+	return CIFS_SB(inode_sb(inode))->wsize;
 }
 
 static bool
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 1238cd3552f9..74ac53fc470b 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -262,7 +262,7 @@ int
 smb2_set_file_info(struct inode *inode, const char *full_path,
 		   FILE_BASIC_INFO *buf, const unsigned int xid)
 {
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink;
 	int rc;
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index eb68e2fcc500..932e8661c2a6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1608,7 +1608,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	unsigned int xid;
 	int rc, access_flags = 0;
 	struct cifs_tcon *tcon;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode_sb(inode));
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
@@ -2039,7 +2039,7 @@ smb3_parse_lease_buf(void *buf, unsigned int *epoch)
 static unsigned int
 smb2_wp_retry_size(struct inode *inode)
 {
-	return min_t(unsigned int, CIFS_SB(inode->i_sb)->wsize,
+	return min_t(unsigned int, CIFS_SB(inode_sb(inode))->wsize,
 		     SMB2_MAX_BUFFER_SIZE);
 }
 
-- 
2.15.1
