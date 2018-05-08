Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756242AbeEHSgH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:36:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:53949 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755614AbeEHSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:16 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 19/76] fs/ceph: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:39 -0700
Message-Id: <20180508180436.716-20-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ceph/addr.c       |  2 +-
 fs/ceph/caps.c       | 16 ++++++++--------
 fs/ceph/dir.c        | 24 ++++++++++++------------
 fs/ceph/file.c       | 16 ++++++++--------
 fs/ceph/inode.c      | 16 ++++++++--------
 fs/ceph/ioctl.c      |  6 +++---
 fs/ceph/locks.c      |  2 +-
 fs/ceph/mds_client.c |  2 +-
 fs/ceph/snap.c       |  2 +-
 fs/ceph/super.h      |  2 +-
 fs/ceph/xattr.c      |  8 ++++----
 11 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b4336b42ce3b..8741e928fca0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -776,7 +776,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	osd_data = osd_req_op_extent_osd_data(req, 0);
 	if (osd_data->pages_from_pool)
 		mempool_free(osd_data->pages,
-			     ceph_sb_to_client(inode->i_sb)->wb_pagevec_pool);
+			     ceph_sb_to_client(inode_sb(inode))->wb_pagevec_pool);
 	else
 		kfree(osd_data->pages);
 	ceph_osdc_put_request(req);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 0e5bd3e3344e..d92e6e9ff6e2 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -977,7 +977,7 @@ static void drop_inode_snap_realm(struct ceph_inode_info *ci)
 	ci->i_snap_realm_counter++;
 	ci->i_snap_realm = NULL;
 	spin_unlock(&realm->inodes_with_caps_lock);
-	ceph_put_snap_realm(ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc,
+	ceph_put_snap_realm(ceph_sb_to_client(inode_sb(&ci->vfs_inode))->mdsc,
 			    realm);
 }
 
@@ -992,7 +992,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+		ceph_sb_to_client(inode_sb(&ci->vfs_inode))->mdsc;
 	int removed = 0;
 
 	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
@@ -1551,7 +1551,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			   struct ceph_cap_flush **pcf)
 {
 	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+		ceph_sb_to_client(inode_sb(&ci->vfs_inode))->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
@@ -1660,7 +1660,7 @@ static int __mark_caps_flushing(struct inode *inode,
 				struct ceph_mds_session *session, bool wake,
 				u64 *flush_tid, u64 *oldest_flush_tid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *cf = NULL;
 	int flushing;
@@ -2029,7 +2029,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
  */
 static int try_flush_caps(struct inode *inode, u64 *ptid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_session *session = NULL;
 	int flushing = 0;
@@ -2217,7 +2217,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 				       caps_are_flushed(inode, flush_tid));
 	} else {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(inode->i_sb)->mdsc;
+			ceph_sb_to_client(inode_sb(inode))->mdsc;
 
 		spin_lock(&ci->i_ceph_lock);
 		if (__ceph_caps_dirty(ci))
@@ -3228,7 +3228,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_cap_flush *cf, *tmp_cf;
 	LIST_HEAD(to_remove);
 	unsigned seq = le32_to_cpu(m->seq);
@@ -3331,7 +3331,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 				     struct ceph_mds_session *session)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	u64 follows = le64_to_cpu(m->snap_follows);
 	struct ceph_cap_snap *capsnap;
 	bool flushed = false;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f1d9c6cc0491..f41c584cdae7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -317,7 +317,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	if (ctx->pos == 0) {
 		dout("readdir off 0 -> '.'\n");
 		if (!dir_emit(ctx, ".", 1, 
-			    ceph_translate_ino(inode->i_sb, inode->i_ino),
+			    ceph_translate_ino(inode_sb(inode), inode->i_ino),
 			    inode->i_mode >> 12))
 			return 0;
 		ctx->pos = 1;
@@ -326,7 +326,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ino_t ino = parent_ino(file->f_path.dentry);
 		dout("readdir off 1 -> '..'\n");
 		if (!dir_emit(ctx, "..", 2,
-			    ceph_translate_ino(inode->i_sb, ino),
+			    ceph_translate_ino(inode_sb(inode), ino),
 			    inode->i_mode >> 12))
 			return 0;
 		ctx->pos = 2;
@@ -513,7 +513,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		ino = ceph_vino_to_ino(vino);
 
 		if (!dir_emit(ctx, rde->name, rde->name_len,
-			      ceph_translate_ino(inode->i_sb, ino), ftype)) {
+			      ceph_translate_ino(inode_sb(inode), ino), ftype)) {
 			dout("filldir stopping us...\n");
 			return 0;
 		}
@@ -727,7 +727,7 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int op;
@@ -816,7 +816,7 @@ int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
 static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 		      umode_t mode, dev_t rdev)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_acls_info acls = {};
@@ -870,7 +870,7 @@ static int ceph_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *dest)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int err;
@@ -908,7 +908,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 
 static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_acls_info acls = {};
@@ -967,7 +967,7 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 		     struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int err;
@@ -1007,7 +1007,7 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
  */
 static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
 	struct ceph_mds_request *req;
@@ -1049,7 +1049,7 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 		       struct inode *new_dir, struct dentry *new_dentry,
 		       unsigned int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(old_dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(old_dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int op = CEPH_MDS_OP_RENAME;
@@ -1232,7 +1232,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	if (!valid) {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(dir->i_sb)->mdsc;
+			ceph_sb_to_client(inode_sb(dir))->mdsc;
 		struct ceph_mds_request *req;
 		int op, err;
 		u32 mask;
@@ -1358,7 +1358,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 	int left;
 	const int bufsize = 1024;
 
-	if (!ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb), DIRSTAT))
+	if (!ceph_test_mount_opt(ceph_sb_to_client(inode_sb(inode)), DIRSTAT))
 		return -EISDIR;
 
 	if (!cf->dir_info) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b67eec3532a1..7d0984676292 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -218,7 +218,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
  */
 int ceph_renew_caps(struct inode *inode)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	int err, flags, wanted;
@@ -248,7 +248,7 @@ int ceph_renew_caps(struct inode *inode)
 		flags |= O_LAZY;
 #endif
 
-	req = prepare_open_request(inode->i_sb, flags, 0);
+	req = prepare_open_request(inode_sb(inode), flags, 0);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out;
@@ -275,7 +275,7 @@ int ceph_renew_caps(struct inode *inode)
 int ceph_open(struct inode *inode, struct file *file)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(inode));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *cf = file->private_data;
@@ -343,7 +343,7 @@ int ceph_open(struct inode *inode, struct file *file)
 	spin_unlock(&ci->i_ceph_lock);
 
 	dout("open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
-	req = prepare_open_request(inode->i_sb, flags, 0);
+	req = prepare_open_request(inode_sb(inode), flags, 0);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out;
@@ -370,7 +370,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode,
 		     int *opened)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(dir));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -392,7 +392,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	}
 
 	/* do the open */
-	req = prepare_open_request(dir->i_sb, flags, mode);
+	req = prepare_open_request(inode_sb(dir), flags, mode);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out_acl;
@@ -1307,7 +1307,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
-		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+		&ceph_sb_to_client(inode_sb(inode))->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
 	int err, want, got;
@@ -1505,7 +1505,7 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 		break;
 	}
 
-	ret = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+	ret = vfs_setpos(file, offset, inode_sb(inode)->s_maxbytes);
 
 out:
 	inode_unlock(inode);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index c6ec5aa46100..95ef61d0954a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -75,7 +75,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 		.ino = ceph_ino(parent),
 		.snap = CEPH_SNAPDIR,
 	};
-	struct inode *inode = ceph_get_inode(parent->i_sb, vino);
+	struct inode *inode = ceph_get_inode(inode_sb(parent), vino);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	BUG_ON(!S_ISDIR(parent->i_mode));
@@ -542,7 +542,7 @@ void ceph_destroy_inode(struct inode *inode)
 	 */
 	if (ci->i_snap_realm) {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+			ceph_sb_to_client(inode_sb(&ci->vfs_inode))->mdsc;
 		struct ceph_snap_realm *realm = ci->i_snap_realm;
 
 		dout(" dropping residual ref to snap realm %p\n", realm);
@@ -1832,7 +1832,7 @@ void ceph_queue_vmtruncate(struct inode *inode)
 
 	ihold(inode);
 
-	if (queue_work(ceph_sb_to_client(inode->i_sb)->trunc_wq,
+	if (queue_work(ceph_sb_to_client(inode_sb(inode))->trunc_wq,
 		       &ci->i_vmtruncate_work)) {
 		dout("ceph_queue_vmtruncate %p\n", inode);
 	} else {
@@ -1882,7 +1882,7 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 		truncate_pagecache(inode, to);
 
 		filemap_write_and_wait_range(&inode->i_data, 0,
-					     inode->i_sb->s_maxbytes);
+					     inode_sb(inode)->s_maxbytes);
 		goto retry;
 	}
 
@@ -1929,7 +1929,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	const unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_cap_flush *prealloc_cf;
 	int issued;
 	int release = 0, dirtied = 0;
@@ -2167,7 +2167,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		      int mask, bool force)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(inode));
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int err;
@@ -2240,13 +2240,13 @@ int ceph_getattr(const struct path *path, struct kstat *stat,
 	err = ceph_do_getattr(inode, CEPH_STAT_CAP_INODE_ALL, false);
 	if (!err) {
 		generic_fillattr(inode, stat);
-		stat->ino = ceph_translate_ino(inode->i_sb, inode->i_ino);
+		stat->ino = ceph_translate_ino(inode_sb(inode), inode->i_ino);
 		if (ceph_snap(inode) != CEPH_NOSNAP)
 			stat->dev = ceph_snap(inode);
 		else
 			stat->dev = 0;
 		if (S_ISDIR(inode->i_mode)) {
-			if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
+			if (ceph_test_mount_opt(ceph_sb_to_client(inode_sb(inode)),
 						RBYTES))
 				stat->size = ci->i_rbytes;
 			else
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 851aa69ec8f0..ed3401b8bf0a 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -64,7 +64,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
@@ -139,7 +139,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	int err;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -182,7 +182,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
-		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+		&ceph_sb_to_client(inode_sb(inode))->client->osdc;
 	struct ceph_object_locator oloc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
 	u64 len = 1, olen;
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 9e66f69ee8a5..0690fec1b678 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -59,7 +59,7 @@ static const struct file_lock_operations ceph_fl_lock_ops = {
 static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 			     int cmd, u8 wait, struct file_lock *fl)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_mds_request *req;
 	int err;
 	u64 length = 0;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2e8f90f96540..b46d25e5586f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -760,7 +760,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 		parent = req->r_dentry->d_parent;
 		dir = req->r_parent ? : d_inode_rcu(parent);
 
-		if (!dir || dir->i_sb != mdsc->fsc->sb) {
+		if (!dir || inode_sb(dir) != mdsc->fsc->sb) {
 			/*  not this fs or parent went negative */
 			inode = d_inode(req->r_dentry);
 			if (inode)
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 07cf95e6413d..b370cf0f7218 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -590,7 +590,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *ci,
 			    struct ceph_cap_snap *capsnap)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 
 	BUG_ON(capsnap->writing);
 	capsnap->size = inode->i_size;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1c2086e0fec2..49c013180595 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -386,7 +386,7 @@ static inline struct ceph_inode_info *ceph_inode(struct inode *inode)
 
 static inline struct ceph_fs_client *ceph_inode_to_client(struct inode *inode)
 {
-	return (struct ceph_fs_client *)inode->i_sb->s_fs_info;
+	return (struct ceph_fs_client *) inode_sb(inode)->s_fs_info;
 }
 
 static inline struct ceph_fs_client *ceph_sb_to_client(struct super_block *sb)
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e1c4e0b12b4c..a6d4f85d0583 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -67,7 +67,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 static size_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				   size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(&ci->vfs_inode));
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
@@ -146,7 +146,7 @@ static size_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 					char *val, size_t size)
 {
 	int ret;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(&ci->vfs_inode));
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
@@ -885,7 +885,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode_sb(inode));
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -953,7 +953,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 {
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode_sb(inode))->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	int issued;
 	int err;
-- 
2.15.1
