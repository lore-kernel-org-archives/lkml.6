Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeEHSjE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:39:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:53884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755474AbeEHSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:05 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 11/76] fs/9p: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:31 -0700
Message-Id: <20180508180436.716-12-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/9p/acl.c            |  3 ++-
 fs/9p/v9fs.h           |  2 +-
 fs/9p/vfs_inode.c      |  8 ++++----
 fs/9p/vfs_inode_dotl.c | 14 +++++++-------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 082d227fa56b..ccd91eb83725 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -266,7 +266,8 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 		else if (acl) {
-			retval = posix_acl_valid(inode->i_sb->s_user_ns, acl);
+			retval = posix_acl_valid(inode_sb(inode)->s_user_ns,
+						 acl);
 			if (retval)
 				goto err_out;
 		}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 982e017acadb..9e27ef7ebeaa 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -171,7 +171,7 @@ extern struct inode *v9fs_inode_from_fid_dotl(struct v9fs_session_info *v9ses,
 
 static inline struct v9fs_session_info *v9fs_inode2v9ses(struct inode *inode)
 {
-	return (inode->i_sb->s_fs_info);
+	return (inode_sb(inode)->s_fs_info);
 }
 
 static inline struct v9fs_session_info *v9fs_dentry2v9ses(struct dentry *dentry)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index bdabb2765d1b..fb6220552fc6 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -690,7 +690,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 		/*
 		 * instantiate inode and assign the unopened fid to the dentry
 		 */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS,
@@ -820,9 +820,9 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	 * inode. But with cache disabled, lookup should do this.
 	 */
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
-		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_inode_from_fid(v9ses, fid, inode_sb(dir));
 	else
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 	if (IS_ERR(inode)) {
 		p9_client_clunk(fid);
 		return ERR_CAST(inode);
@@ -1425,7 +1425,7 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * because we may have cached data
 	 */
 	i_size = inode->i_size;
-	v9fs_stat2inode(st, inode, inode->i_sb);
+	v9fs_stat2inode(st, inode, inode_sb(inode));
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		inode->i_size = i_size;
 	spin_unlock(&inode->i_lock);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 7f6ae21a27b3..ed462264239c 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -318,7 +318,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 		fid = NULL;
 		goto error;
 	}
-	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n", err);
@@ -435,7 +435,7 @@ static int v9fs_vfs_mkdir_dotl(struct inode *dir,
 
 	/* instantiate inode and assign the unopened fid to the dentry */
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -453,7 +453,7 @@ static int v9fs_vfs_mkdir_dotl(struct inode *dir,
 		 * inode with stat. We need to get an inode
 		 * so that we can set the acl with dentry
 		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, 0);
+		inode = v9fs_get_inode(inode_sb(dir), mode, 0);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			goto error;
@@ -723,7 +723,7 @@ v9fs_vfs_symlink_dotl(struct inode *dir, struct dentry *dentry,
 		}
 
 		/* instantiate inode and assign the unopened fid to dentry */
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -736,7 +736,7 @@ v9fs_vfs_symlink_dotl(struct inode *dir, struct dentry *dentry,
 		err = 0;
 	} else {
 		/* Not in cached mode. No need to populate inode with stat */
-		inode = v9fs_get_inode(dir->i_sb, S_IFLNK, 0);
+		inode = v9fs_get_inode(inode_sb(dir), S_IFLNK, 0);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			goto error;
@@ -864,7 +864,7 @@ v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
 
 	/* instantiate inode and assign the unopened fid to the dentry */
 	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
-		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+		inode = v9fs_get_new_inode_from_fid(v9ses, fid, inode_sb(dir));
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
@@ -881,7 +881,7 @@ v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
 		 * Not in cached mode. No need to populate inode with stat.
 		 * socket syscall returns a fd, so we need instantiate
 		 */
-		inode = v9fs_get_inode(dir->i_sb, mode, rdev);
+		inode = v9fs_get_inode(inode_sb(dir), mode, rdev);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
 			goto error;
-- 
2.15.1
