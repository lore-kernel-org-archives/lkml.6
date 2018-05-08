Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933201AbeEHSGs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54363 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933046AbeEHSGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:39 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 75/76] fs: Use fs view device from struct super_block
Date: Tue,  8 May 2018 11:04:35 -0700
Message-Id: <20180508180436.716-76-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some places which access s_dev directly from struct super_block.

Convert those to get v_dev from the default super block view.

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 drivers/mtd/mtdsuper.c                          |  2 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c |  6 +-
 fs/autofs4/autofs_i.h                           |  2 +-
 fs/autofs4/dev-ioctl.c                          | 10 +--
 fs/ceph/super.c                                 |  2 +-
 fs/cramfs/inode.c                               |  4 +-
 fs/exofs/super.c                                |  2 +-
 fs/fuse/inode.c                                 |  2 +-
 fs/gfs2/ops_fstype.c                            |  2 +-
 fs/gfs2/quota.c                                 |  5 +-
 fs/gfs2/sys.c                                   |  3 +-
 fs/gfs2/trace_gfs2.h                            | 30 ++++-----
 fs/nfs/nfs4trace.h                              |  2 +-
 fs/nfs/super.c                                  |  6 +-
 fs/nfsd/nfs3xdr.c                               |  2 +-
 fs/nfsd/nfsfh.c                                 |  6 +-
 fs/nilfs2/super.c                               |  2 +-
 fs/ocfs2/journal.c                              | 13 ++--
 fs/ocfs2/ocfs2_trace.h                          |  4 +-
 fs/ocfs2/super.c                                |  4 +-
 fs/overlayfs/inode.c                            |  4 +-
 fs/overlayfs/readdir.c                          |  4 +-
 fs/proc_namespace.c                             |  2 +-
 fs/quota/dquot.c                                |  2 +-
 fs/reiserfs/journal.c                           |  6 +-
 fs/romfs/super.c                                |  6 +-
 fs/super.c                                      |  8 +--
 fs/xfs/scrub/trace.h                            | 26 ++++----
 fs/xfs/xfs_trace.h                              | 84 ++++++++++++-------------
 fs/xfs/xfs_trans_dquot.c                        |  2 +-
 include/trace/events/ext4.h                     | 36 +++++------
 include/trace/events/f2fs.h                     | 18 +++---
 include/trace/events/writeback.h                |  2 +-
 init/do_mounts.c                                |  2 +-
 kernel/audit_watch.c                            |  2 +-
 net/unix/diag.c                                 |  2 +-
 security/tomoyo/realpath.c                      |  4 +-
 37 files changed, 162 insertions(+), 157 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index d58a61c09304..f5346de9b29d 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -51,7 +51,7 @@ static int get_sb_mtd_set(struct super_block *sb, void *_mtd)
 	struct mtd_info *mtd = _mtd;
 
 	sb->s_mtd = mtd;
-	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
+	sb->s_view.v_dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
 	sb->s_bdi = bdi_get(mtd_bdi);
 
 	return 0;
diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 6f6df27635d4..ffa6e7d92080 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -524,7 +524,7 @@ static int client_common_fill_super(struct super_block *sb, char *md, char *dt)
 		goto out_lock_cn_cb;
 	}
 
-	sbi->ll_sdev_orig = sb->s_dev;
+	sbi->ll_sdev_orig = sb->s_view.v_dev;
 
 	/* We set sb->s_dev equal on all lustre clients in order to support
 	 * NFS export clustering.  NFSD requires that the FSID be the same
@@ -535,7 +535,7 @@ static int client_common_fill_super(struct super_block *sb, char *md, char *dt)
 	 */
 	uuid = obd_get_uuid(sbi->ll_md_exp);
 	if (uuid) {
-		sb->s_dev = get_uuid2int(uuid->uuid, strlen(uuid->uuid));
+		sb->s_view.v_dev = get_uuid2int(uuid->uuid, strlen(uuid->uuid));
 		get_uuid2fsid(uuid->uuid, strlen(uuid->uuid), &sbi->ll_fsid);
 	}
 
@@ -670,7 +670,7 @@ void ll_kill_super(struct super_block *sb)
 	 * in put_super not affected real removing devices
 	 */
 	if (sbi) {
-		sb->s_dev = sbi->ll_sdev_orig;
+		sb->s_view.v_dev = sbi->ll_sdev_orig;
 		sbi->ll_umounting = 1;
 
 		/* wait running statahead threads to quit */
diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4737615f0eaa..31fcf15108eb 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -225,7 +225,7 @@ void autofs4_catatonic_mode(struct autofs_sb_info *);
 
 static inline u32 autofs4_get_dev(struct autofs_sb_info *sbi)
 {
-	return new_encode_dev(sbi->sb->s_dev);
+	return new_encode_dev(sbi->sb->s_view.v_dev);
 }
 
 static inline u64 autofs4_get_ino(struct autofs_sb_info *sbi)
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 6b28b01e5022..6d1f1bc5db06 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -231,7 +231,7 @@ static int find_autofs_mount(const char *pathname,
 
 static int test_by_dev(const struct path *path, void *p)
 {
-	return path->dentry->d_sb->s_dev == *(dev_t *)p;
+	return path->dentry->d_sb->s_view.v_dev == *(dev_t *)p;
 }
 
 static int test_by_type(const struct path *path, void *p)
@@ -243,7 +243,7 @@ static int test_by_type(const struct path *path, void *p)
 
 /*
  * Open a file descriptor on the autofs mount point corresponding
- * to the given path and device number (aka. new_encode_dev(sb->s_dev)).
+ * to the given path and device number (aka. new_encode_dev(sb->s_view.v_dev)).
  */
 static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 {
@@ -451,7 +451,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 		goto out;
 	}
 
-	devid = sbi->sb->s_dev;
+	devid = sbi->sb->s_view.v_dev;
 
 	param->requester.uid = param->requester.gid = -1;
 
@@ -554,14 +554,14 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 						test_by_type, &type);
 		if (err)
 			goto out;
-		devid = new_encode_dev(path.dentry->d_sb->s_dev);
+		devid = new_encode_dev(path.dentry->d_sb->s_view.v_dev);
 		err = 0;
 		if (path.mnt->mnt_root == path.dentry) {
 			err = 1;
 			magic = path.dentry->d_sb->s_magic;
 		}
 	} else {
-		dev_t dev = sbi->sb->s_dev;
+		dev_t dev = sbi->sb->s_view.v_dev;
 
 		err = find_autofs_mount(name, &path, test_by_dev, &dev);
 		if (err)
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index fb2bc9c15a23..2f6c4c16a5ad 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1055,7 +1055,7 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 static void ceph_kill_sb(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
-	dev_t dev = s->s_dev;
+	dev_t dev = s->s_view.v_dev;
 
 	dout("kill_sb %p\n", s);
 
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index eb633de7ccbe..239ec223433f 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -674,8 +674,8 @@ static int cramfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	if (sb->s_bdev)
 		id = huge_encode_dev(sb->s_bdev->bd_dev);
-	else if (sb->s_dev)
-		id = huge_encode_dev(sb->s_dev);
+	else if (sb->s_view.v_dev)
+		id = huge_encode_dev(sb->s_view.v_dev);
 
 	buf->f_type = CRAMFS_MAGIC;
 	buf->f_bsize = PAGE_SIZE;
diff --git a/fs/exofs/super.c b/fs/exofs/super.c
index 179cd5c2f52a..6149c1bc02ff 100644
--- a/fs/exofs/super.c
+++ b/fs/exofs/super.c
@@ -760,7 +760,7 @@ static int exofs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_max_links = EXOFS_LINK_MAX;
 	atomic_set(&sbi->s_curr_pending, 0);
 	sb->s_bdev = NULL;
-	sb->s_dev = 0;
+	sb->s_view.v_dev = 0;
 
 	comp.obj.partition = sbi->one_comp.obj.partition;
 	comp.obj.id = EXOFS_SUPER_ID;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d6d2fbe6c3ec..3b4d753b8c70 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1103,7 +1103,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (!fud)
 		goto err_put_conn;
 
-	fc->dev = sb->s_dev;
+	fc->dev = sb->s_view.v_dev;
 	fc->sb = sb;
 	err = fuse_bdi_init(fc, sb);
 	if (err)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e6a0a8a89ea7..25a93cacaa1d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1222,7 +1222,7 @@ static int fill_super(struct super_block *sb, struct gfs2_args *args, int silent
 static int set_gfs2_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
+	s->s_view.v_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
 	return 0;
 }
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 7a98abd340ee..21499dd4ad5c 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1227,7 +1227,7 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 						      &qd->qd_flags)) {
 					print_message(qd, "exceeded");
 					quota_send_warning(qd->qd_id,
-							   sdp->sd_vfs->s_dev,
+							   sdp->sd_vfs->s_view.v_dev,
 							   QUOTA_NL_BHARDWARN);
 				}
 				error = -EDQUOT;
@@ -1238,7 +1238,8 @@ int gfs2_quota_check(struct gfs2_inode *ip, kuid_t uid, kgid_t gid,
 					 gfs2_tune_get(sdp, gt_quota_warn_period)
 					 * HZ)) {
 			quota_send_warning(qd->qd_id,
-					   sdp->sd_vfs->s_dev, QUOTA_NL_BSOFTWARN);
+					   sdp->sd_vfs->s_view.v_dev,
+					   QUOTA_NL_BSOFTWARN);
 			error = print_message(qd, "warning");
 			qd->qd_last_warn = jiffies;
 		}
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c191fa58a1df..d5036ad407b6 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -63,7 +63,8 @@ static struct kset *gfs2_kset;
 static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%u:%u\n",
-			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
+			MAJOR(sdp->sd_vfs->s_view.v_dev),
+			MINOR(sdp->sd_vfs->s_view.v_dev));
 }
 
 static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index b9318b49ff8f..b25112935281 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -106,7 +106,7 @@ TRACE_EVENT(gfs2_glock_state_change,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->glnum		= gl->gl_name.ln_number;
 		__entry->gltype		= gl->gl_name.ln_type;
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
@@ -142,7 +142,7 @@ TRACE_EVENT(gfs2_glock_put,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->gltype		= gl->gl_name.ln_type;
 		__entry->glnum		= gl->gl_name.ln_number;
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
@@ -176,7 +176,7 @@ TRACE_EVENT(gfs2_demote_rq,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->gltype		= gl->gl_name.ln_type;
 		__entry->glnum		= gl->gl_name.ln_number;
 		__entry->cur_state	= glock_trace_state(gl->gl_state);
@@ -211,7 +211,7 @@ TRACE_EVENT(gfs2_promote,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->glnum	= gh->gh_gl->gl_name.ln_number;
 		__entry->gltype	= gh->gh_gl->gl_name.ln_type;
 		__entry->first	= first;
@@ -241,7 +241,7 @@ TRACE_EVENT(gfs2_glock_queue,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev	= gh->gh_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->glnum	= gh->gh_gl->gl_name.ln_number;
 		__entry->gltype	= gh->gh_gl->gl_name.ln_type;
 		__entry->queue	= queue;
@@ -280,7 +280,7 @@ TRACE_EVENT(gfs2_glock_lock_time,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->glnum          = gl->gl_name.ln_number;
 		__entry->gltype         = gl->gl_name.ln_type;
 		__entry->status		= gl->gl_lksb.sb_status;
@@ -335,7 +335,7 @@ TRACE_EVENT(gfs2_pin,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= bd->bd_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= bd->bd_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->pin		= pin;
 		__entry->len		= bd->bd_bh->b_size;
 		__entry->block		= bd->bd_bh->b_blocknr;
@@ -365,7 +365,7 @@ TRACE_EVENT(gfs2_log_flush,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = sdp->sd_vfs->s_dev;
+		__entry->dev            = sdp->sd_vfs->s_view.v_dev;
 		__entry->start		= start;
 		__entry->log_seq	= sdp->sd_log_sequence;
 		__entry->flags		= flags;
@@ -391,7 +391,7 @@ TRACE_EVENT(gfs2_log_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sdp->sd_vfs->s_dev;
+		__entry->dev		= sdp->sd_vfs->s_view.v_dev;
 		__entry->blocks		= blocks;
 	),
 
@@ -414,7 +414,7 @@ TRACE_EVENT(gfs2_ail_flush,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sdp->sd_vfs->s_dev;
+		__entry->dev		= sdp->sd_vfs->s_view.v_dev;
 		__entry->start		= start;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->nr_to_write	= wbc->nr_to_write;
@@ -454,7 +454,7 @@ TRACE_EVENT(gfs2_bmap,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->lblock		= lblock;
 		__entry->pblock		= buffer_mapped(bh) ?  bh->b_blocknr : 0;
 		__entry->inum		= ip->i_no_addr;
@@ -490,7 +490,7 @@ TRACE_EVENT(gfs2_iomap_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->pos		= pos;
 		__entry->length		= length;
@@ -521,7 +521,7 @@ TRACE_EVENT(gfs2_iomap_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev            = ip->i_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->inum		= ip->i_no_addr;
 		__entry->offset		= iomap->offset;
 		__entry->length		= iomap->length;
@@ -558,7 +558,7 @@ TRACE_EVENT(gfs2_block_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= rgd->rd_gl->gl_name.ln_sbd->sd_vfs->s_dev;
+		__entry->dev		= rgd->rd_gl->gl_name.ln_sbd->sd_vfs->s_view.v_dev;
 		__entry->start		= block;
 		__entry->inum		= ip->i_no_addr;
 		__entry->len		= len;
@@ -597,7 +597,7 @@ TRACE_EVENT(gfs2_rs,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= rs->rs_rbm.rgd->rd_sbd->sd_vfs->s_dev;
+		__entry->dev		= rs->rs_rbm.rgd->rd_sbd->sd_vfs->s_view.v_dev;
 		__entry->rd_addr	= rs->rs_rbm.rgd->rd_addr;
 		__entry->rd_free_clone	= rs->rs_rbm.rgd->rd_free_clone;
 		__entry->rd_reserved	= rs->rs_rbm.rgd->rd_reserved;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 07f81f981792..4cdb6e356742 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -410,7 +410,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
 			__entry->error = error;
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
-			__entry->dev = ctx->dentry->d_sb->s_dev;
+			__entry->dev = ctx->dentry->d_sb->s_view.v_dev;
 			if (!IS_ERR_OR_NULL(state)) {
 				inode = state->inode;
 				__entry->stateid_seq =
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 5e470e233c83..5dc8226409f1 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2321,7 +2321,7 @@ static void nfs_initialise_sb(struct super_block *sb)
 
 	/* We probably want something more informative here */
 	snprintf(sb->s_id, sizeof(sb->s_id),
-		 "%u:%u", MAJOR(sb->s_dev), MINOR(sb->s_dev));
+		 "%u:%u", MAJOR(sb->s_view.v_dev), MINOR(sb->s_view.v_dev));
 
 	if (sb->s_blocksize == 0)
 		sb->s_blocksize = nfs_block_bits(server->wsize,
@@ -2433,7 +2433,7 @@ static int nfs_set_super(struct super_block *s, void *data)
 	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
 	ret = set_anon_super(s, server);
 	if (ret == 0)
-		server->s_dev = s->s_dev;
+		server->s_dev = s->s_view.v_dev;
 	return ret;
 }
 
@@ -2708,7 +2708,7 @@ EXPORT_SYMBOL_GPL(nfs_fs_mount);
 void nfs_kill_super(struct super_block *s)
 {
 	struct nfs_server *server = NFS_SB(s);
-	dev_t dev = s->s_dev;
+	dev_t dev = s->s_view.v_dev;
 
 	generic_shutdown_super(s);
 
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 1a70581e1cb2..d432f7020d39 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -147,7 +147,7 @@ static __be32 *encode_fsid(__be32 *p, struct svc_fh *fhp)
 	default:
 	case FSIDSOURCE_DEV:
 		p = xdr_encode_hyper(p, (u64)huge_encode_dev
-				     (fhp->fh_dentry->d_sb->s_dev));
+				     (fhp->fh_dentry->d_sb->s_view.v_dev));
 		break;
 	case FSIDSOURCE_FSID:
 		p = xdr_encode_hyper(p, (u64) fhp->fh_export->ex_fsid);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8aa011820c4a..2f819ae8f47e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -440,7 +440,7 @@ static bool fsid_type_ok_for_exp(u8 fsid_type, struct svc_export *exp)
 {
 	switch (fsid_type) {
 	case FSID_DEV:
-		if (!old_valid_dev(exp_sb(exp)->s_dev))
+		if (!old_valid_dev(exp_sb(exp)->s_view.v_dev))
 			return 0;
 		/* FALL THROUGH */
 	case FSID_MAJOR_MINOR:
@@ -505,7 +505,7 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
 			else
 				fsid_type = FSID_UUID4_INUM;
 		}
-	} else if (!old_valid_dev(exp_sb(exp)->s_dev))
+	} else if (!old_valid_dev(exp_sb(exp)->s_view.v_dev))
 		/* for newer device numbers, we must use a newer fsid format */
 		fsid_type = FSID_ENCODE_DEV;
 	else
@@ -528,7 +528,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	 */
 
 	struct inode * inode = d_inode(dentry);
-	dev_t ex_dev = exp_sb(exp)->s_dev;
+	dev_t ex_dev = exp_sb(exp)->s_view.v_dev;
 
 	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 6ffeca84d7c3..0239b1b495db 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1267,7 +1267,7 @@ static int nilfs_identify(char *data, struct nilfs_super_data *sd)
 static int nilfs_set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
+	s->s_view.v_dev = s->s_bdev->bd_dev;
 	return 0;
 }
 
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index e0047816c7b7..520c3cdee1e1 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1435,7 +1435,8 @@ static int __ocfs2_recovery_thread(void *arg)
 			mlog(ML_ERROR,
 			     "Error %d recovering node %d on device (%u,%u)!\n",
 			     status, node_num,
-			     MAJOR(osb->sb->s_dev), MINOR(osb->sb->s_dev));
+			     MAJOR(osb->sb->s_view.v_dev),
+			     MINOR(osb->sb->s_view.v_dev));
 			mlog(ML_ERROR, "Volume requires unmount.\n");
 		}
 
@@ -1624,8 +1625,9 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	ocfs2_replay_map_set_state(osb, REPLAY_NEEDED);
 
 	printk(KERN_NOTICE "ocfs2: Begin replay journal (node %d, slot %d) on "\
-	       "device (%u,%u)\n", node_num, slot_num, MAJOR(osb->sb->s_dev),
-	       MINOR(osb->sb->s_dev));
+	       "device (%u,%u)\n", node_num, slot_num,
+	       MAJOR(osb->sb->s_view.v_dev),
+	       MINOR(osb->sb->s_view.v_dev));
 
 	OCFS2_I(inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
 
@@ -1681,8 +1683,9 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 	jbd2_journal_destroy(journal);
 
 	printk(KERN_NOTICE "ocfs2: End replay journal (node %d, slot %d) on "\
-	       "device (%u,%u)\n", node_num, slot_num, MAJOR(osb->sb->s_dev),
-	       MINOR(osb->sb->s_dev));
+	       "device (%u,%u)\n", node_num, slot_num,
+	       MAJOR(osb->sb->s_view.v_dev),
+	       MINOR(osb->sb->s_view.v_dev));
 done:
 	/* drop the lock on this nodes journal */
 	if (got_lock)
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index e2a11aaece10..cb9b7bd9e0c4 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -700,8 +700,8 @@ TRACE_EVENT(ocfs2_trim_extent,
 		__field(__u64,	count)
 	),
 	TP_fast_assign(
-		__entry->dev_major = MAJOR(sb->s_dev);
-		__entry->dev_minor = MINOR(sb->s_dev);
+		__entry->dev_major = MAJOR(sb->s_view.v_dev);
+		__entry->dev_minor = MINOR(sb->s_view.v_dev);
 		__entry->blk = blk;
 		__entry->count = count;
 	),
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index ffa4952d432b..7d9d34c360e4 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1973,7 +1973,7 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 
 	ocfs2_delete_osb(osb);
 	kfree(osb);
-	sb->s_dev = 0;
+	sb->s_view.v_dev = 0;
 	sb->s_fs_info = NULL;
 }
 
@@ -2102,7 +2102,7 @@ static int ocfs2_initialize_super(struct super_block *sb,
 	ocfs2_init_node_maps(osb);
 
 	snprintf(osb->dev_str, sizeof(osb->dev_str), "%u,%u",
-		 MAJOR(osb->sb->s_dev), MINOR(osb->sb->s_dev));
+		 MAJOR(osb->sb->s_view.v_dev), MINOR(osb->sb->s_view.v_dev));
 
 	osb->max_slots = le16_to_cpu(di->id2.i_super.s_max_slots);
 	if (osb->max_slots > OCFS2_MAX_SLOTS || osb->max_slots == 0) {
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index ebf2a857d547..6169f36337bf 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -132,7 +132,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 			 * number are unique, so we use the overlay st_dev,
 			 * which is friendly to du -x.
 			 */
-			stat->dev = dentry->d_sb->s_dev;
+			stat->dev = dentry->d_sb->s_view.v_dev;
 		} else if (!OVL_TYPE_UPPER(type)) {
 			/*
 			 * For non-samefs setup, to make sure that st_dev/st_ino
@@ -151,7 +151,7 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 		 * overlay st_dev} is not unique, so use the non persistent
 		 * overlay st_ino for directories.
 		 */
-		stat->dev = dentry->d_sb->s_dev;
+		stat->dev = dentry->d_sb->s_view.v_dev;
 		stat->ino = dentry->d_inode->i_ino;
 	}
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index c11f5c0906c3..3b2ce71de48d 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -489,7 +489,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 		if (err)
 			goto fail;
 
-		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
+		WARN_ON_ONCE(dir->d_sb->s_view.v_dev != stat.dev);
 		ino = stat.ino;
 	}
 
@@ -660,7 +660,7 @@ static int ovl_iterate_real(struct file *file, struct dir_context *ctx)
 		if (err)
 			return err;
 
-		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
+		WARN_ON_ONCE(dir->d_sb->s_view.v_dev != stat.dev);
 		rdt.parent_ino = stat.ino;
 	}
 
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e16fb8f2049e..842d6f4fe014 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -137,7 +137,7 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 	int err;
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
-		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
+		   MAJOR(sb->s_view.v_dev), MINOR(sb->s_view.v_dev));
 	if (sb->s_op->show_path) {
 		err = sb->s_op->show_path(m, mnt->mnt_root);
 		if (err)
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index ba6d549323cb..124f8dff5214 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1242,7 +1242,7 @@ static void flush_warnings(struct dquot_warn *warn)
 		print_warning(&warn[i]);
 #endif
 		quota_send_warning(warn[i].w_dq_id,
-				   warn[i].w_sb->s_dev, warn[i].w_type);
+				   warn[i].w_sb->s_view.v_dev, warn[i].w_type);
 	}
 }
 
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index aefcb77de3fd..7c20afe62014 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2613,14 +2613,14 @@ static int journal_init_dev(struct super_block *super,
 
 	journal->j_dev_bd = NULL;
 	jdev = SB_ONDISK_JOURNAL_DEVICE(super) ?
-	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_dev;
+	    new_decode_dev(SB_ONDISK_JOURNAL_DEVICE(super)) : super->s_view.v_dev;
 
 	if (bdev_read_only(super->s_bdev))
 		blkdev_mode = FMODE_READ;
 
 	/* there is no "jdev" option and journal is on separate device */
 	if ((!jdev_name || !jdev_name[0])) {
-		if (jdev == super->s_dev)
+		if (jdev == super->s_view.v_dev)
 			blkdev_mode &= ~FMODE_EXCL;
 		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode,
 						      journal);
@@ -2632,7 +2632,7 @@ static int journal_init_dev(struct super_block *super,
 					 "cannot init journal device '%s': %i",
 					 __bdevname(jdev, b), result);
 			return result;
-		} else if (jdev != super->s_dev)
+		} else if (jdev != super->s_view.v_dev)
 			set_blocksize(journal->j_dev_bd, super->s_blocksize);
 
 		return 0;
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index eb0b7d3775bb..f9d9d99a32e9 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -433,8 +433,8 @@ static int romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 */
 	if (sb->s_bdev)
 		id = huge_encode_dev(sb->s_bdev->bd_dev);
-	else if (sb->s_dev)
-		id = huge_encode_dev(sb->s_dev);
+	else if (sb->s_view.v_dev)
+		id = huge_encode_dev(sb->s_view.v_dev);
 
 	buf->f_type = ROMFS_MAGIC;
 	buf->f_namelen = ROMFS_MAXFN;
@@ -510,7 +510,7 @@ static int romfs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_ROMFS_ON_MTD
 	/* Use same dev ID from the underlying mtdblock device */
 	if (sb->s_mtd)
-		sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, sb->s_mtd->index);
+		sb->s_view.v_dev = MKDEV(MTD_BLOCK_MAJOR, sb->s_mtd->index);
 #endif
 	/* read the image superblock and check it */
 	rsb = kmalloc(512, GFP_KERNEL);
diff --git a/fs/super.c b/fs/super.c
index 5258a57d410a..dfb5b1c8ef20 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -781,7 +781,7 @@ struct super_block *user_get_super(dev_t dev)
 	list_for_each_entry(sb, &super_blocks, s_list) {
 		if (hlist_unhashed(&sb->s_instances))
 			continue;
-		if (sb->s_dev ==  dev) {
+		if (sb->s_view.v_dev ==  dev) {
 			sb->s_count++;
 			spin_unlock(&sb_lock);
 			down_read(&sb->s_umount);
@@ -981,14 +981,14 @@ EXPORT_SYMBOL(free_anon_bdev);
 
 int set_anon_super(struct super_block *s, void *data)
 {
-	return get_anon_bdev(&s->s_dev);
+	return get_anon_bdev(&s->s_view.v_dev);
 }
 
 EXPORT_SYMBOL(set_anon_super);
 
 void kill_anon_super(struct super_block *sb)
 {
-	dev_t dev = sb->s_dev;
+	dev_t dev = sb->s_view.v_dev;
 	generic_shutdown_super(sb);
 	free_anon_bdev(dev);
 }
@@ -1052,7 +1052,7 @@ EXPORT_SYMBOL(mount_ns);
 static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
-	s->s_dev = s->s_bdev->bd_dev;
+	s->s_view.v_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
 
 	return 0;
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 4dc896852bf0..57e6610e29d6 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -41,7 +41,7 @@ DECLARE_EVENT_CLASS(xfs_scrub_class,
 		__field(int, error)
 	),
 	TP_fast_assign(
-		__entry->dev = ip->i_mount->m_super->s_dev;
+		__entry->dev = ip->i_mount->m_super->s_view.v_dev;
 		__entry->ino = ip->i_ino;
 		__entry->type = sm->sm_type;
 		__entry->agno = sm->sm_agno;
@@ -83,7 +83,7 @@ TRACE_EVENT(xfs_scrub_op_error,
 		__field(void *, ret_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->agno = agno;
 		__entry->bno = bno;
@@ -113,7 +113,7 @@ TRACE_EVENT(xfs_scrub_file_op_error,
 		__field(void *, ret_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = sc->ip->i_mount->m_super->s_dev;
+		__entry->dev = sc->ip->i_mount->m_super->s_view.v_dev;
 		__entry->ino = sc->ip->i_ino;
 		__entry->whichfork = whichfork;
 		__entry->type = sc->sm->sm_type;
@@ -150,7 +150,7 @@ DECLARE_EVENT_CLASS(xfs_scrub_block_error_class,
 		agno = XFS_FSB_TO_AGNO(sc->mp, fsbno);
 		bno = XFS_FSB_TO_AGBNO(sc->mp, fsbno);
 
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->agno = agno;
 		__entry->bno = bno;
@@ -200,7 +200,7 @@ DECLARE_EVENT_CLASS(xfs_scrub_ino_error_class,
 					XFS_INO_TO_AGINO(sc->mp, ino));
 		}
 
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->ino = ino;
 		__entry->type = sc->sm->sm_type;
 		__entry->agno = agno;
@@ -239,7 +239,7 @@ DECLARE_EVENT_CLASS(xfs_scrub_fblock_error_class,
 		__field(void *, ret_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = sc->ip->i_mount->m_super->s_dev;
+		__entry->dev = sc->ip->i_mount->m_super->s_view.v_dev;
 		__entry->ino = sc->ip->i_ino;
 		__entry->whichfork = whichfork;
 		__entry->type = sc->sm->sm_type;
@@ -273,7 +273,7 @@ TRACE_EVENT(xfs_scrub_incomplete,
 		__field(void *, ret_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->ret_ip = ret_ip;
 	),
@@ -301,7 +301,7 @@ TRACE_EVENT(xfs_scrub_btree_op_error,
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xfs_scrub_btree_cur_fsbno(cur, level);
 
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->btnum = cur->bc_btnum;
 		__entry->level = level;
@@ -342,7 +342,7 @@ TRACE_EVENT(xfs_scrub_ifork_btree_op_error,
 	),
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xfs_scrub_btree_cur_fsbno(cur, level);
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->ino = sc->ip->i_ino;
 		__entry->whichfork = cur->bc_private.b.whichfork;
 		__entry->type = sc->sm->sm_type;
@@ -384,7 +384,7 @@ TRACE_EVENT(xfs_scrub_btree_error,
 	),
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xfs_scrub_btree_cur_fsbno(cur, level);
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->btnum = cur->bc_btnum;
 		__entry->level = level;
@@ -422,7 +422,7 @@ TRACE_EVENT(xfs_scrub_ifork_btree_error,
 	),
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xfs_scrub_btree_cur_fsbno(cur, level);
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->ino = sc->ip->i_ino;
 		__entry->whichfork = cur->bc_private.b.whichfork;
 		__entry->type = sc->sm->sm_type;
@@ -463,7 +463,7 @@ DECLARE_EVENT_CLASS(xfs_scrub_sbtree_class,
 	TP_fast_assign(
 		xfs_fsblock_t fsbno = xfs_scrub_btree_cur_fsbno(cur, level);
 
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->btnum = cur->bc_btnum;
 		__entry->agno = XFS_FSB_TO_AGNO(cur->bc_mp, fsbno);
@@ -501,7 +501,7 @@ TRACE_EVENT(xfs_scrub_xref_error,
 		__field(void *, ret_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = sc->mp->m_super->s_dev;
+		__entry->dev = sc->mp->m_super->s_view.v_dev;
 		__entry->type = sc->sm->sm_type;
 		__entry->error = error;
 		__entry->ret_ip = ret_ip;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 16065fe0bd4d..2d650a11890b 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -114,7 +114,7 @@ DECLARE_EVENT_CLASS(xfs_perag_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->refcount = refcount;
 		__entry->caller_ip = caller_ip;
@@ -149,7 +149,7 @@ DECLARE_EVENT_CLASS(xfs_ag_class,
 		__field(xfs_agnumber_t, agno)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 	),
 	TP_printk("dev %d:%d agno %u",
@@ -742,7 +742,7 @@ TRACE_EVENT(xfs_irec_merge_pre,
 		__field(uint16_t, nholemask)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agino = agino;
 		__entry->holemask = holemask;
@@ -766,7 +766,7 @@ TRACE_EVENT(xfs_irec_merge_post,
 		__field(uint16_t, holemask)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agino = agino;
 		__entry->holemask = holemask;
@@ -868,7 +868,7 @@ DECLARE_EVENT_CLASS(xfs_dquot_class,
 		__field(unsigned long long, ino_softlimit)
 	), \
 	TP_fast_assign(
-		__entry->dev = dqp->q_mount->m_super->s_dev;
+		__entry->dev = dqp->q_mount->m_super->s_view.v_dev;
 		__entry->id = be32_to_cpu(dqp->q_core.d_id);
 		__entry->flags = dqp->dq_flags;
 		__entry->nrefs = dqp->q_nrefs;
@@ -947,7 +947,7 @@ DECLARE_EVENT_CLASS(xfs_loggrant_class,
 		__field(xfs_lsn_t, tail_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->ocnt = tic->t_ocnt;
 		__entry->cnt = tic->t_cnt;
 		__entry->curr_res = tic->t_curr_res;
@@ -1022,7 +1022,7 @@ DECLARE_EVENT_CLASS(xfs_log_item_class,
 		__field(xfs_lsn_t, lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_mountp->m_super->s_view.v_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
@@ -1045,7 +1045,7 @@ TRACE_EVENT(xfs_log_force,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->lsn = lsn;
 		__entry->caller_ip = caller_ip;
 	),
@@ -1075,7 +1075,7 @@ DECLARE_EVENT_CLASS(xfs_ail_class,
 		__field(xfs_lsn_t, new_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = lip->li_mountp->m_super->s_dev;
+		__entry->dev = lip->li_mountp->m_super->s_view.v_dev;
 		__entry->lip = lip;
 		__entry->type = lip->li_type;
 		__entry->flags = lip->li_flags;
@@ -1109,7 +1109,7 @@ TRACE_EVENT(xfs_log_assign_tail_lsn,
 		__field(xfs_lsn_t, last_sync_lsn)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->new_lsn = new_lsn;
 		__entry->old_lsn = atomic64_read(&log->l_tail_lsn);
 		__entry->last_sync_lsn = atomic64_read(&log->l_last_sync_lsn);
@@ -1425,7 +1425,7 @@ DECLARE_EVENT_CLASS(xfs_extent_busy_class,
 		__field(xfs_extlen_t, len)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -1461,7 +1461,7 @@ TRACE_EVENT(xfs_extent_busy_trim,
 		__field(xfs_extlen_t, tlen)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -1498,7 +1498,7 @@ TRACE_EVENT(xfs_agf,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = be32_to_cpu(agf->agf_seqno),
 		__entry->flags = flags;
 		__entry->length = be32_to_cpu(agf->agf_length),
@@ -1549,7 +1549,7 @@ TRACE_EVENT(xfs_free_extent,
 		__field(int, haveright)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -1594,7 +1594,7 @@ DECLARE_EVENT_CLASS(xfs_alloc_class,
 		__field(xfs_fsblock_t, firstblock)
 	),
 	TP_fast_assign(
-		__entry->dev = args->mp->m_super->s_dev;
+		__entry->dev = args->mp->m_super->s_view.v_dev;
 		__entry->agno = args->agno;
 		__entry->agbno = args->agbno;
 		__entry->minlen = args->minlen;
@@ -1958,7 +1958,7 @@ TRACE_EVENT(xfs_log_recover,
 		__field(xfs_daddr_t, tailblk)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->headblk = headblk;
 		__entry->tailblk = tailblk;
 	),
@@ -1978,7 +1978,7 @@ TRACE_EVENT(xfs_log_recover_record,
 		__field(int, pass)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->lsn = be64_to_cpu(rhead->h_lsn);
 		__entry->len = be32_to_cpu(rhead->h_len);
 		__entry->num_logops = be32_to_cpu(rhead->h_num_logops);
@@ -2005,7 +2005,7 @@ DECLARE_EVENT_CLASS(xfs_log_recover_item_class,
 		__field(int, total)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->item = (unsigned long)item;
 		__entry->tid = trans->r_log_tid;
 		__entry->lsn = trans->r_lsn;
@@ -2050,7 +2050,7 @@ DECLARE_EVENT_CLASS(xfs_log_recover_buf_item_class,
 		__field(unsigned int, map_size)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->blkno = buf_f->blf_blkno;
 		__entry->len = buf_f->blf_len;
 		__entry->flags = buf_f->blf_flags;
@@ -2097,7 +2097,7 @@ DECLARE_EVENT_CLASS(xfs_log_recover_ino_item_class,
 		__field(int, boffset)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->ino = in_f->ilf_ino;
 		__entry->size = in_f->ilf_size;
 		__entry->fields = in_f->ilf_fields;
@@ -2141,7 +2141,7 @@ DECLARE_EVENT_CLASS(xfs_log_recover_icreate_item_class,
 		__field(unsigned int, gen)
 	),
 	TP_fast_assign(
-		__entry->dev = log->l_mp->m_super->s_dev;
+		__entry->dev = log->l_mp->m_super->s_view.v_dev;
 		__entry->agno = be32_to_cpu(in_f->icl_ag);
 		__entry->agbno = be32_to_cpu(in_f->icl_agbno);
 		__entry->count = be32_to_cpu(in_f->icl_count);
@@ -2173,7 +2173,7 @@ DECLARE_EVENT_CLASS(xfs_discard_class,
 		__field(xfs_extlen_t, len)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -2208,7 +2208,7 @@ DECLARE_EVENT_CLASS(xfs_btree_cur_class,
 		__field(xfs_daddr_t, daddr)
 	),
 	TP_fast_assign(
-		__entry->dev = cur->bc_mp->m_super->s_dev;
+		__entry->dev = cur->bc_mp->m_super->s_view.v_dev;
 		__entry->btnum = cur->bc_btnum;
 		__entry->level = level;
 		__entry->nlevels = cur->bc_nlevels;
@@ -2245,7 +2245,7 @@ DECLARE_EVENT_CLASS(xfs_defer_class,
 		__field(char, low)
 	),
 	TP_fast_assign(
-		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->dev = mp ? mp->m_super->s_view.v_dev : 0;
 		__entry->dop = dop;
 		__entry->committed = dop->dop_committed;
 		__entry->low = dop->dop_low;
@@ -2272,7 +2272,7 @@ DECLARE_EVENT_CLASS(xfs_defer_error_class,
 		__field(int, error)
 	),
 	TP_fast_assign(
-		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->dev = mp ? mp->m_super->s_view.v_dev : 0;
 		__entry->dop = dop;
 		__entry->committed = dop->dop_committed;
 		__entry->low = dop->dop_low;
@@ -2301,7 +2301,7 @@ DECLARE_EVENT_CLASS(xfs_defer_pending_class,
 		__field(int, nr)
 	),
 	TP_fast_assign(
-		__entry->dev = mp ? mp->m_super->s_dev : 0;
+		__entry->dev = mp ? mp->m_super->s_view.v_dev : 0;
 		__entry->type = dfp->dfp_type->type;
 		__entry->intent = dfp->dfp_intent;
 		__entry->committed = dfp->dfp_done != NULL;
@@ -2331,7 +2331,7 @@ DECLARE_EVENT_CLASS(xfs_phys_extent_deferred_class,
 		__field(xfs_extlen_t, len)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->type = type;
 		__entry->agbno = agbno;
@@ -2374,7 +2374,7 @@ DECLARE_EVENT_CLASS(xfs_map_extent_deferred_class,
 		__field(int, op)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->ino = ino;
 		__entry->agbno = agbno;
@@ -2443,7 +2443,7 @@ DECLARE_EVENT_CLASS(xfs_rmap_class,
 		__field(unsigned long, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -2481,7 +2481,7 @@ DECLARE_EVENT_CLASS(xfs_ag_error_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->error = error;
 		__entry->caller_ip = caller_ip;
@@ -2525,7 +2525,7 @@ DECLARE_EVENT_CLASS(xfs_rmapbt_class,
 		__field(unsigned int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->len = len;
@@ -2593,7 +2593,7 @@ DECLARE_EVENT_CLASS(xfs_ag_resv_class,
 	TP_fast_assign(
 		struct xfs_ag_resv	*r = xfs_perag_resv(pag, resv);
 
-		__entry->dev = pag->pag_mount->m_super->s_dev;
+		__entry->dev = pag->pag_mount->m_super->s_view.v_dev;
 		__entry->agno = pag->pag_agno;
 		__entry->resv = resv;
 		__entry->freeblks = pag->pagf_freeblks;
@@ -2651,7 +2651,7 @@ DECLARE_EVENT_CLASS(xfs_ag_btree_lookup_class,
 		__field(xfs_lookup_t, dir)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->agbno = agbno;
 		__entry->dir = dir;
@@ -2683,7 +2683,7 @@ DECLARE_EVENT_CLASS(xfs_refcount_extent_class,
 		__field(xfs_nlink_t, refcount)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->startblock = irec->rc_startblock;
 		__entry->blockcount = irec->rc_blockcount;
@@ -2717,7 +2717,7 @@ DECLARE_EVENT_CLASS(xfs_refcount_extent_at_class,
 		__field(xfs_agblock_t, agbno)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->startblock = irec->rc_startblock;
 		__entry->blockcount = irec->rc_blockcount;
@@ -2755,7 +2755,7 @@ DECLARE_EVENT_CLASS(xfs_refcount_double_extent_class,
 		__field(xfs_nlink_t, i2_refcount)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->i1_startblock = i1->rc_startblock;
 		__entry->i1_blockcount = i1->rc_blockcount;
@@ -2800,7 +2800,7 @@ DECLARE_EVENT_CLASS(xfs_refcount_double_extent_at_class,
 		__field(xfs_agblock_t, agbno)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->i1_startblock = i1->rc_startblock;
 		__entry->i1_blockcount = i1->rc_blockcount;
@@ -2850,7 +2850,7 @@ DECLARE_EVENT_CLASS(xfs_refcount_triple_extent_class,
 		__field(xfs_nlink_t, i3_refcount)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->i1_startblock = i1->rc_startblock;
 		__entry->i1_blockcount = i1->rc_blockcount;
@@ -2943,7 +2943,7 @@ TRACE_EVENT(xfs_refcount_finish_one_leftover,
 		__field(xfs_extlen_t, new_len)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->agno = agno;
 		__entry->type = type;
 		__entry->agbno = agbno;
@@ -3247,7 +3247,7 @@ DECLARE_EVENT_CLASS(xfs_fsmap_class,
 		__field(unsigned int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->keydev = new_decode_dev(keydev);
 		__entry->agno = agno;
 		__entry->bno = rmap->rm_startblock;
@@ -3288,7 +3288,7 @@ DECLARE_EVENT_CLASS(xfs_getfsmap_class,
 		__field(uint64_t, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->keydev = new_decode_dev(fsmap->fmr_device);
 		__entry->block = fsmap->fmr_physical;
 		__entry->len = fsmap->fmr_length;
@@ -3325,7 +3325,7 @@ TRACE_EVENT(xfs_trans_resv_calc,
 		__field(int, logflags)
 	),
 	TP_fast_assign(
-		__entry->dev = mp->m_super->s_dev;
+		__entry->dev = mp->m_super->s_view.v_dev;
 		__entry->type = type;
 		__entry->logres = res->tr_logres;
 		__entry->logcount = res->tr_logcount;
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index c3d547211d16..be0850fdbe50 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -583,7 +583,7 @@ xfs_quota_warn(
 
 	quota_send_warning(make_kqid(&init_user_ns, qtype,
 				     be32_to_cpu(dqp->q_core.d_id)),
-			   mp->m_super->s_dev, type);
+			   mp->m_super->s_view.v_dev, type);
 }
 
 /*
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 500ae412f483..003844d10b86 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -599,7 +599,7 @@ TRACE_EVENT(ext4_discard_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->blk	= blk;
 		__entry->count	= count;
 	),
@@ -625,7 +625,7 @@ DECLARE_EVENT_CLASS(ext4__mb_new_pa,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= ac->ac_sb->s_dev;
+		__entry->dev		= ac->ac_sb->s_view.v_dev;
 		__entry->ino		= ac->ac_inode->i_ino;
 		__entry->pa_pstart	= pa->pa_pstart;
 		__entry->pa_lstart	= pa->pa_lstart;
@@ -694,7 +694,7 @@ TRACE_EVENT(ext4_mb_release_group_pa,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->pa_pstart	= pa->pa_pstart;
 		__entry->pa_len		= pa->pa_len;
 	),
@@ -737,7 +737,7 @@ TRACE_EVENT(ext4_mb_discard_preallocations,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->needed	= needed;
 	),
 
@@ -874,7 +874,7 @@ TRACE_EVENT(ext4_sync_file_enter,
 	TP_fast_assign(
 		struct dentry *dentry = file->f_path.dentry;
 
-		__entry->dev		= dentry->d_sb->s_dev;
+		__entry->dev		= dentry->d_sb->s_view.v_dev;
 		__entry->ino		= d_inode(dentry)->i_ino;
 		__entry->datasync	= datasync;
 		__entry->parent		= d_inode(dentry->d_parent)->i_ino;
@@ -921,7 +921,7 @@ TRACE_EVENT(ext4_sync_fs,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->wait	= wait;
 	),
 
@@ -1078,7 +1078,7 @@ DECLARE_EVENT_CLASS(ext4__mballoc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->result_start	= start;
 		__entry->result_group	= group;
@@ -1248,7 +1248,7 @@ DECLARE_EVENT_CLASS(ext4__bitmap_load,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->group	= group;
 	),
 
@@ -1434,7 +1434,7 @@ TRACE_EVENT(ext4_unlink_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= dentry->d_sb->s_dev;
+		__entry->dev		= dentry->d_sb->s_view.v_dev;
 		__entry->ino		= d_inode(dentry)->i_ino;
 		__entry->parent		= parent->i_ino;
 		__entry->size		= d_inode(dentry)->i_size;
@@ -1458,7 +1458,7 @@ TRACE_EVENT(ext4_unlink_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= dentry->d_sb->s_dev;
+		__entry->dev		= dentry->d_sb->s_view.v_dev;
 		__entry->ino		= d_inode(dentry)->i_ino;
 		__entry->ret		= ret;
 	),
@@ -1737,7 +1737,7 @@ TRACE_EVENT(ext4_journal_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev		 = sb->s_dev;
+		__entry->dev		 = sb->s_view.v_dev;
 		__entry->ip		 = IP;
 		__entry->blocks		 = blocks;
 		__entry->rsv_blocks	 = rsv_blocks;
@@ -1760,7 +1760,7 @@ TRACE_EVENT(ext4_journal_start_reserved,
 	),
 
 	TP_fast_assign(
-		__entry->dev		 = sb->s_dev;
+		__entry->dev		 = sb->s_view.v_dev;
 		__entry->ip		 = IP;
 		__entry->blocks		 = blocks;
 	),
@@ -1787,8 +1787,8 @@ DECLARE_EVENT_CLASS(ext4__trim,
 	),
 
 	TP_fast_assign(
-		__entry->dev_major	= MAJOR(sb->s_dev);
-		__entry->dev_minor	= MINOR(sb->s_dev);
+		__entry->dev_major	= MAJOR(sb->s_view.v_dev);
+		__entry->dev_minor	= MINOR(sb->s_view.v_dev);
 		__entry->group		= group;
 		__entry->start		= start;
 		__entry->len		= len;
@@ -1872,7 +1872,7 @@ TRACE_EVENT(ext4_get_implied_cluster_alloc_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->flags	= map->m_flags;
 		__entry->lblk	= map->m_lblk;
 		__entry->pblk	= map->m_pblk;
@@ -2390,7 +2390,7 @@ DECLARE_EVENT_CLASS(ext4__es_shrink_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->nr_to_scan	= nr_to_scan;
 		__entry->cache_cnt	= cache_cnt;
 	),
@@ -2424,7 +2424,7 @@ TRACE_EVENT(ext4_es_shrink_scan_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->nr_shrunk	= nr_shrunk;
 		__entry->cache_cnt	= cache_cnt;
 	),
@@ -2499,7 +2499,7 @@ TRACE_EVENT(ext4_es_shrink,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->nr_shrunk	= nr_shrunk;
 		__entry->scan_time	= div_u64(scan_time, 1000);
 		__entry->nr_skipped	= nr_skipped;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index effb2704f3ae..9d67ed3d4dc8 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -265,7 +265,7 @@ TRACE_EVENT(f2fs_sync_fs,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->dirty	= is_sbi_flag_set(F2FS_SB(sb), SBI_IS_DIRTY);
 		__entry->wait	= wait;
 	),
@@ -570,7 +570,7 @@ TRACE_EVENT(f2fs_background_gc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->wait_ms	= wait_ms;
 		__entry->prefree	= prefree;
 		__entry->free		= free;
@@ -608,7 +608,7 @@ TRACE_EVENT(f2fs_gc_begin,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->sync		= sync;
 		__entry->background	= background;
 		__entry->dirty_nodes	= dirty_nodes;
@@ -661,7 +661,7 @@ TRACE_EVENT(f2fs_gc_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->ret		= ret;
 		__entry->seg_freed	= seg_freed;
 		__entry->sec_freed	= sec_freed;
@@ -713,7 +713,7 @@ TRACE_EVENT(f2fs_get_victim,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->type		= type;
 		__entry->gc_type	= gc_type;
 		__entry->alloc_mode	= p->alloc_mode;
@@ -1034,7 +1034,7 @@ DECLARE_EVENT_CLASS(f2fs__bio,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->target		= bio_dev(bio);
 		__entry->op		= bio_op(bio);
 		__entry->op_flags	= bio->bi_opf;
@@ -1336,7 +1336,7 @@ TRACE_EVENT(f2fs_write_checkpoint,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= sb->s_dev;
+		__entry->dev		= sb->s_view.v_dev;
 		__entry->reason		= reason;
 		__entry->msg		= msg;
 	),
@@ -1545,7 +1545,7 @@ TRACE_EVENT(f2fs_shrink_extent_tree,
 	),
 
 	TP_fast_assign(
-		__entry->dev = sbi->sb->s_dev;
+		__entry->dev = sbi->sb->s_view.v_dev;
 		__entry->node_cnt = node_cnt;
 		__entry->tree_cnt = tree_cnt;
 	),
@@ -1592,7 +1592,7 @@ DECLARE_EVENT_CLASS(f2fs_sync_dirty_inodes,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= sb->s_dev;
+		__entry->dev	= sb->s_view.v_dev;
 		__entry->type	= type;
 		__entry->count	= count;
 	),
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 7a5bfa93f938..242d1cc3b58f 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -223,7 +223,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		strncpy(__entry->name,
 			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
 		__entry->nr_pages = work->nr_pages;
-		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
+		__entry->sb_dev = work->sb ? work->sb->s_view.v_dev : 0;
 		__entry->sync_mode = work->sync_mode;
 		__entry->for_kupdate = work->for_kupdate;
 		__entry->range_cyclic = work->range_cyclic;
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7cf4f6dafd5f..724f3b071d62 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -369,7 +369,7 @@ static int __init do_mount_root(char *name, char *fs, int flags, void *data)
 
 	sys_chdir("/root");
 	s = current->fs->pwd.dentry->d_sb;
-	ROOT_DEV = s->s_dev;
+	ROOT_DEV = s->s_view.v_dev;
 	printk(KERN_INFO
 	       "VFS: Mounted root (%s filesystem)%s on device %u:%u.\n",
 	       s->s_type->name,
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index b9f571cc6a7f..72b82db95ecf 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -368,7 +368,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	inode_unlock(d_backing_inode(parent->dentry));
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
-		watch->dev = d->d_sb->s_dev;
+		watch->dev = d->d_sb->s_view.v_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
 	dput(d);
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 384c84e83462..26b4486c41da 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -26,7 +26,7 @@ static int sk_diag_dump_vfs(struct sock *sk, struct sk_buff *nlskb)
 	if (dentry) {
 		struct unix_diag_vfs uv = {
 			.udiag_vfs_ino = d_backing_inode(dentry)->i_ino,
-			.udiag_vfs_dev = dentry->d_sb->s_dev,
+			.udiag_vfs_dev = dentry->d_sb->s_view.v_dev,
 		};
 
 		return nla_put(nlskb, UNIX_DIAG_VFS, sizeof(uv), &uv);
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index 6ff8c21e4fff..dc7eff734fa9 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -166,7 +166,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 		goto prepend_filesystem_name;
 	}
 	/* Use filesystem name for unnamed devices. */
-	if (!MAJOR(sb->s_dev))
+	if (!MAJOR(sb->s_view.v_dev))
 		goto prepend_filesystem_name;
 	{
 		struct inode *inode = d_backing_inode(sb->s_root);
@@ -181,7 +181,7 @@ static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
 	{
 		char name[64];
 		int name_len;
-		const dev_t dev = sb->s_dev;
+		const dev_t dev = sb->s_view.v_dev;
 		name[sizeof(name) - 1] = '\0';
 		snprintf(name, sizeof(name) - 1, "dev(%u,%u):", MAJOR(dev),
 			 MINOR(dev));
-- 
2.15.1
