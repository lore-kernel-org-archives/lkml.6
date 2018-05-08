Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755466AbeEHSFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:53819 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751723AbeEHSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:54 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 03/76] drivers: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:23 -0700
Message-Id: <20180508180436.716-4-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 drivers/block/loop.c                               |  6 ++---
 drivers/infiniband/hw/qib/qib_fs.c                 |  2 +-
 drivers/md/md-bitmap.c                             |  2 +-
 drivers/staging/lustre/lustre/llite/dir.c          | 18 +++++++-------
 drivers/staging/lustre/lustre/llite/file.c         | 28 +++++++++++-----------
 .../staging/lustre/lustre/llite/llite_internal.h   |  6 ++---
 drivers/staging/lustre/lustre/llite/llite_lib.c    | 20 +++++++++-------
 drivers/staging/lustre/lustre/llite/llite_nfs.c    | 10 ++++----
 drivers/staging/lustre/lustre/llite/namei.c        |  8 +++----
 drivers/staging/lustre/lustre/llite/statahead.c    |  8 +++----
 drivers/staging/lustre/lustre/llite/symlink.c      |  4 ++--
 drivers/staging/lustre/lustre/llite/vvp_io.c       |  4 ++--
 drivers/staging/lustre/lustre/llite/xattr.c        |  2 +-
 drivers/staging/ncpfs/dir.c                        | 17 ++++++-------
 drivers/staging/ncpfs/file.c                       |  4 ++--
 drivers/staging/ncpfs/ioctl.c                      |  6 ++---
 drivers/staging/ncpfs/ncp_fs.h                     |  2 +-
 17 files changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ee62d2d517bf..1b2452b7ae09 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -173,8 +173,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	unsigned dio_align = 0;
 	bool use_dio;
 
-	if (inode->i_sb->s_bdev) {
-		sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
+	if (inode_sb(inode)->s_bdev) {
+		sb_bsize = bdev_logical_block_size(inode_sb(inode)->s_bdev);
 		dio_align = sb_bsize - 1;
 	}
 
@@ -821,7 +821,7 @@ static void loop_config_discard(struct loop_device *lo)
 		return;
 	}
 
-	q->limits.discard_granularity = inode->i_sb->s_blocksize;
+	q->limits.discard_granularity = inode_sb(inode)->s_blocksize;
 	q->limits.discard_alignment = 0;
 
 	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 1d940a2885c9..8eab4149c7d1 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -52,7 +52,7 @@ static int qibfs_mknod(struct inode *dir, struct dentry *dentry,
 		       void *data)
 {
 	int error;
-	struct inode *inode = new_inode(dir->i_sb);
+	struct inode *inode = new_inode(inode_sb(dir));
 
 	if (!inode) {
 		error = -EPERM;
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 239c7bb3929b..2355a7c18ecb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -385,7 +385,7 @@ static int read_page(struct file *file, unsigned long index,
 				ret = -EINVAL;
 				goto out;
 			}
-			bh->b_bdev = inode->i_sb->s_bdev;
+			bh->b_bdev = inode_sb(inode)->s_bdev;
 			if (count < (1<<inode->i_blkbits))
 				count = 0;
 			else
diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
index 99b0b77c75f5..809e493b61da 100644
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -448,7 +448,7 @@ static int ll_dir_setdirstripe(struct inode *parent, struct lmv_user_md *lump,
 			cfs_curproc_cap_pack(), 0, &request);
 	ll_finish_md_op_data(op_data);
 
-	err = ll_prep_inode(&inode, request, parent->i_sb, NULL);
+	err = ll_prep_inode(&inode, request, inode_sb(parent), NULL);
 	if (err)
 		goto err_exit;
 
@@ -470,7 +470,7 @@ int ll_dir_setstripe(struct inode *inode, struct lov_user_md *lump,
 	struct md_op_data *op_data;
 	struct ptlrpc_request *req = NULL;
 	int rc = 0;
-	struct lustre_sb_info *lsi = s2lsi(inode->i_sb);
+	struct lustre_sb_info *lsi = s2lsi(inode_sb(inode));
 	struct obd_device *mgc = lsi->lsi_mgc;
 	int lum_size;
 
@@ -544,7 +544,7 @@ int ll_dir_setstripe(struct inode *inode, struct lov_user_md *lump,
 
 		buf = param;
 		/* Get fsname and assume devname to be -MDT0000. */
-		ll_get_fsname(inode->i_sb, buf, MTI_NAME_MAXLEN);
+		ll_get_fsname(inode_sb(inode), buf, MTI_NAME_MAXLEN);
 		strcat(buf, "-MDT0000.lov");
 		buf += strlen(buf);
 
@@ -1093,7 +1093,8 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		rc = ll_get_fid_by_name(inode, filename, namelen, NULL, NULL);
 		if (rc < 0) {
 			CERROR("%s: lookup %.*s failed: rc = %d\n",
-			       ll_get_fsname(inode->i_sb, NULL, 0), namelen,
+			       ll_get_fsname(inode_sb(inode), NULL, 0),
+			       namelen,
 			       filename, rc);
 			goto out_free;
 		}
@@ -1363,7 +1364,7 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			struct lov_user_mds_data __user *lmdp;
 			lstat_t st = { 0 };
 
-			st.st_dev     = inode->i_sb->s_dev;
+			st.st_dev     = inode_sb(inode)->s_dev;
 			st.st_mode    = body->mbo_mode;
 			st.st_nlink   = body->mbo_nlink;
 			st.st_uid     = body->mbo_uid;
@@ -1514,7 +1515,8 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 			for (i = 0; i < hur->hur_request.hr_itemcount; i++) {
 				fid = &hur->hur_user_item[i].hui_fid;
-				f = search_inode_for_lustre(inode->i_sb, fid);
+				f = search_inode_for_lustre(inode_sb(inode),
+							    fid);
 				if (IS_ERR(f)) {
 					rc = PTR_ERR(f);
 					break;
@@ -1571,7 +1573,7 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(copy))
 			return PTR_ERR(copy);
 
-		rc = ll_ioc_copy_start(inode->i_sb, copy);
+		rc = ll_ioc_copy_start(inode_sb(inode), copy);
 		if (copy_to_user((char __user *)arg, copy, sizeof(*copy)))
 			rc = -EFAULT;
 
@@ -1586,7 +1588,7 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(copy))
 			return PTR_ERR(copy);
 
-		rc = ll_ioc_copy_end(inode->i_sb, copy);
+		rc = ll_ioc_copy_end(inode_sb(inode), copy);
 		if (copy_to_user((char __user *)arg, copy, sizeof(*copy)))
 			rc = -EFAULT;
 
diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
index 938b859b6650..64df47bd1118 100644
--- a/drivers/staging/lustre/lustre/llite/file.c
+++ b/drivers/staging/lustre/lustre/llite/file.c
@@ -130,7 +130,7 @@ static int ll_close_inode_openhandle(struct inode *inode,
 
 	if (!class_exp2obd(md_exp)) {
 		CERROR("%s: invalid MDC connection handle closing " DFID "\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(&lli->lli_fid));
 		rc = 0;
 		goto out;
@@ -837,7 +837,7 @@ ll_lease_open(struct inode *inode, struct file *file, fmode_t fmode,
 	rc2 = ll_close_inode_openhandle(inode, och, 0, NULL);
 	if (rc2 < 0)
 		CERROR("%s: error closing file " DFID ": %d\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(&ll_i2info(inode)->lli_fid), rc2);
 	och = NULL; /* och has been freed in ll_close_inode_openhandle() */
 out_release_it:
@@ -866,7 +866,7 @@ static int ll_check_swap_layouts_validity(struct inode *inode1,
 	    inode_permission(inode2, MAY_WRITE))
 		return -EPERM;
 
-	if (inode1->i_sb != inode2->i_sb)
+	if (inode_sb(inode1) != inode_sb(inode2))
 		return -EXDEV;
 
 	return 0;
@@ -880,7 +880,7 @@ static int ll_swap_layouts_close(struct obd_client_handle *och,
 	int rc;
 
 	CDEBUG(D_INODE, "%s: biased close of file " DFID "\n",
-	       ll_get_fsname(inode->i_sb, NULL, 0), PFID(fid1));
+	       ll_get_fsname(inode_sb(inode), NULL, 0), PFID(fid1));
 
 	rc = ll_check_swap_layouts_validity(inode, inode2);
 	if (rc < 0)
@@ -1016,7 +1016,7 @@ static bool file_is_noatime(const struct file *file)
 	if ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return true;
 
-	if ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
+	if ((inode_sb(inode)->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return true;
 
 	return false;
@@ -1669,7 +1669,7 @@ int ll_hsm_release(struct inode *inode)
 	u16 refcheck;
 
 	CDEBUG(D_INODE, "%s: Releasing file " DFID ".\n",
-	       ll_get_fsname(inode->i_sb, NULL, 0),
+	       ll_get_fsname(inode_sb(inode), NULL, 0),
 	       PFID(&ll_i2info(inode)->lli_fid));
 
 	och = ll_lease_open(inode, NULL, FMODE_WRITE, MDS_OPEN_RELEASE);
@@ -2566,7 +2566,7 @@ int ll_get_fid_by_name(struct inode *parent, const char *name,
 		*fid = body->mbo_fid1;
 
 	if (inode)
-		rc = ll_prep_inode(inode, req, parent->i_sb, NULL);
+		rc = ll_prep_inode(inode, req, inode_sb(parent), NULL);
 out_req:
 	ptlrpc_req_finished(req);
 	return rc;
@@ -2621,7 +2621,7 @@ int ll_migrate(struct inode *parent, struct file *file, int mdtidx,
 	op_data->op_fid3 = *ll_inode2fid(child_inode);
 	if (!fid_is_sane(&op_data->op_fid3)) {
 		CERROR("%s: migrate %s, but fid " DFID " is insane\n",
-		       ll_get_fsname(parent->i_sb, NULL, 0), name,
+		       ll_get_fsname(inode_sb(parent), NULL, 0), name,
 		       PFID(&op_data->op_fid3));
 		rc = -EINVAL;
 		goto out_unlock;
@@ -2796,7 +2796,7 @@ static int ll_inode_revalidate_fini(struct inode *inode, int rc)
 	} else if (rc != 0) {
 		CDEBUG_LIMIT((rc == -EACCES || rc == -EIDRM) ? D_INFO : D_ERROR,
 			     "%s: revalidate FID " DFID " error: rc = %d\n",
-			     ll_get_fsname(inode->i_sb, NULL, 0),
+			     ll_get_fsname(inode_sb(inode), NULL, 0),
 			     PFID(ll_inode2fid(inode)), rc);
 	}
 
@@ -2967,7 +2967,7 @@ int ll_getattr(const struct path *path, struct kstat *stat,
 
 	OBD_FAIL_TIMEOUT(OBD_FAIL_GETATTR_DELAY, 30);
 
-	stat->dev = inode->i_sb->s_dev;
+	stat->dev = inode_sb(inode)->s_dev;
 	if (ll_need_32bit_api(sbi))
 		stat->ino = cl_fid_build_ino(&lli->lli_fid, 1);
 	else
@@ -3061,7 +3061,7 @@ int ll_inode_permission(struct inode *inode, int mask)
 	*/
 
 	if (is_root_inode(inode)) {
-		rc = __ll_inode_revalidate(inode->i_sb->s_root,
+		rc = __ll_inode_revalidate(inode_sb(inode)->s_root,
 					   MDS_INODELOCK_LOOKUP);
 		if (rc)
 			return rc;
@@ -3448,7 +3448,7 @@ static int ll_layout_lock_set(struct lustre_handle *lockh, enum ldlm_mode mode,
 	/* wait for IO to complete if it's still being used. */
 	if (wait_layout) {
 		CDEBUG(D_INODE, "%s: " DFID "(%p) wait for layout reconf\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(&lli->lli_fid), inode);
 
 		memset(&conf, 0, sizeof(conf));
@@ -3460,7 +3460,7 @@ static int ll_layout_lock_set(struct lustre_handle *lockh, enum ldlm_mode mode,
 
 		CDEBUG(D_INODE,
 		       "%s: file=" DFID " waiting layout return: %d.\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(&lli->lli_fid), rc);
 	}
 	return rc;
@@ -3506,7 +3506,7 @@ static int ll_layout_refresh_locked(struct inode *inode)
 	lockh.cookie = 0ULL;
 
 	LDLM_DEBUG_NOLOCK("%s: requeue layout lock for file " DFID "(%p)",
-			  ll_get_fsname(inode->i_sb, NULL, 0),
+			  ll_get_fsname(inode_sb(inode), NULL, 0),
 			  PFID(&lli->lli_fid), inode);
 
 	rc = md_enqueue(sbi->ll_md_exp, &einfo, NULL, &it, op_data, &lockh, 0);
diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
index f68c2e88f12b..296a546ac72d 100644
--- a/drivers/staging/lustre/lustre/llite/llite_internal.h
+++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
@@ -964,17 +964,17 @@ static inline struct client_obd *sbi2mdc(struct ll_sb_info *sbi)
 /* FIXME: replace the name of this with LL_SB to conform to kernel stuff */
 static inline struct ll_sb_info *ll_i2sbi(struct inode *inode)
 {
-	return ll_s2sbi(inode->i_sb);
+	return ll_s2sbi(inode_sb(inode));
 }
 
 static inline struct obd_export *ll_i2dtexp(struct inode *inode)
 {
-	return ll_s2dtexp(inode->i_sb);
+	return ll_s2dtexp(inode_sb(inode));
 }
 
 static inline struct obd_export *ll_i2mdexp(struct inode *inode)
 {
-	return ll_s2mdexp(inode->i_sb);
+	return ll_s2mdexp(inode_sb(inode));
 }
 
 static inline struct lu_fid *ll_inode2fid(struct inode *inode)
diff --git a/drivers/staging/lustre/lustre/llite/llite_lib.c b/drivers/staging/lustre/lustre/llite/llite_lib.c
index 6735a6f006d2..6f6df27635d4 100644
--- a/drivers/staging/lustre/lustre/llite/llite_lib.c
+++ b/drivers/staging/lustre/lustre/llite/llite_lib.c
@@ -1146,7 +1146,7 @@ static int ll_init_lsm_md(struct inode *inode, struct lustre_md *md)
 			lsm->lsm_md_oinfo[i].lmo_root = inode;
 		else
 			lsm->lsm_md_oinfo[i].lmo_root =
-				ll_iget_anon_dir(inode->i_sb, fid, md);
+				ll_iget_anon_dir(inode_sb(inode), fid, md);
 		if (IS_ERR(lsm->lsm_md_oinfo[i].lmo_root)) {
 			int rc = PTR_ERR(lsm->lsm_md_oinfo[i].lmo_root);
 
@@ -1257,7 +1257,8 @@ static int ll_update_lsm_md(struct inode *inode, struct lustre_md *md)
 		int idx;
 
 		CERROR("%s: inode " DFID "(%p)'s lmv layout mismatch (%p)/(%p) magic:0x%x/0x%x stripe count: %d/%d master_mdt: %d/%d hash_type:0x%x/0x%x layout: 0x%x/0x%x pool:%s/%s\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0), PFID(&lli->lli_fid),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
+		       PFID(&lli->lli_fid),
 		       inode, lsm, old_lsm,
 		       lsm->lsm_md_magic, old_lsm->lsm_md_magic,
 		       lsm->lsm_md_stripe_count,
@@ -1272,13 +1273,13 @@ static int ll_update_lsm_md(struct inode *inode, struct lustre_md *md)
 
 		for (idx = 0; idx < old_lsm->lsm_md_stripe_count; idx++) {
 			CERROR("%s: sub FIDs in old lsm idx %d, old: " DFID "\n",
-			       ll_get_fsname(inode->i_sb, NULL, 0), idx,
+			       ll_get_fsname(inode_sb(inode), NULL, 0), idx,
 			       PFID(&old_lsm->lsm_md_oinfo[idx].lmo_fid));
 		}
 
 		for (idx = 0; idx < lsm->lsm_md_stripe_count; idx++) {
 			CERROR("%s: sub FIDs in new lsm idx %d, new: " DFID "\n",
-			       ll_get_fsname(inode->i_sb, NULL, 0), idx,
+			       ll_get_fsname(inode_sb(inode), NULL, 0), idx,
 			       PFID(&lsm->lsm_md_oinfo[idx].lmo_fid));
 		}
 
@@ -1428,7 +1429,8 @@ int ll_setattr_raw(struct dentry *dentry, struct iattr *attr, bool hsm_import)
 	int rc = 0;
 
 	CDEBUG(D_VFSTRACE, "%s: setattr inode " DFID "(%p) from %llu to %llu, valid %x, hsm_import %d\n",
-	       ll_get_fsname(inode->i_sb, NULL, 0), PFID(&lli->lli_fid), inode,
+	       ll_get_fsname(inode_sb(inode), NULL, 0), PFID(&lli->lli_fid),
+	       inode,
 	       i_size_read(inode), attr->ia_size, attr->ia_valid, hsm_import);
 
 	if (attr->ia_valid & ATTR_SIZE) {
@@ -1776,7 +1778,7 @@ int ll_update_inode(struct inode *inode, struct lustre_md *md)
 		inode->i_blkbits = min(PTLRPC_MAX_BRW_BITS + 1,
 				       LL_MAX_BLKSIZE_BITS);
 	else
-		inode->i_blkbits = inode->i_sb->s_blocksize_bits;
+		inode->i_blkbits = inode_sb(inode)->s_blocksize_bits;
 	if (body->mbo_valid & OBD_MD_FLUID)
 		inode->i_uid = make_kuid(&init_user_ns, body->mbo_uid);
 	if (body->mbo_valid & OBD_MD_FLGID)
@@ -2182,7 +2184,7 @@ int ll_prep_inode(struct inode **inode, struct ptlrpc_request *req,
 	md_free_lustre_md(sbi->ll_md_exp, &md);
 cleanup:
 	if (rc != 0 && it && it->it_op & IT_OPEN)
-		ll_open_cleanup(sb ? sb : (*inode)->i_sb, req);
+		ll_open_cleanup(sb ? sb : inode_sb((*inode)), req);
 
 	return rc;
 }
@@ -2452,8 +2454,8 @@ void ll_dirty_page_discard_warn(struct page *page, int ioret)
 
 	CDEBUG(D_WARNING,
 	       "%s: dirty page discard: %s/fid: " DFID "/%s may get corrupted (rc %d)\n",
-	       ll_get_fsname(page->mapping->host->i_sb, NULL, 0),
-	       s2lsi(page->mapping->host->i_sb)->lsi_lmd->lmd_dev,
+	       ll_get_fsname(inode_sb(page->mapping->host), NULL, 0),
+	       s2lsi(inode_sb(page->mapping->host))->lsi_lmd->lmd_dev,
 	       PFID(&obj->vob_header.coh_lu.loh_fid),
 	       (path && !IS_ERR(path)) ? path : "", ioret);
 
diff --git a/drivers/staging/lustre/lustre/llite/llite_nfs.c b/drivers/staging/lustre/lustre/llite/llite_nfs.c
index a6a1d80c711a..699a5d1f3941 100644
--- a/drivers/staging/lustre/lustre/llite/llite_nfs.c
+++ b/drivers/staging/lustre/lustre/llite/llite_nfs.c
@@ -198,7 +198,7 @@ static int ll_encode_fh(struct inode *inode, __u32 *fh, int *plen,
 	struct lustre_nfs_fid *nfs_fid = (void *)fh;
 
 	CDEBUG(D_INFO, "%s: encoding for (" DFID ") maxlen=%d minlen=%d\n",
-	       ll_get_fsname(inode->i_sb, NULL, 0),
+	       ll_get_fsname(inode_sb(inode), NULL, 0),
 	       PFID(ll_inode2fid(inode)), *plen, fileid_len);
 
 	if (*plen < fileid_len) {
@@ -312,10 +312,10 @@ int ll_dir_get_parent_fid(struct inode *dir, struct lu_fid *parent_fid)
 
 	LASSERT(dir && S_ISDIR(dir->i_mode));
 
-	sbi = ll_s2sbi(dir->i_sb);
+	sbi = ll_s2sbi(inode_sb(dir));
 
 	CDEBUG(D_INFO, "%s: getting parent for (" DFID ")\n",
-	       ll_get_fsname(dir->i_sb, NULL, 0),
+	       ll_get_fsname(inode_sb(dir), NULL, 0),
 	       PFID(ll_inode2fid(dir)));
 
 	rc = ll_get_default_mdsize(sbi, &lmmsize);
@@ -332,7 +332,7 @@ int ll_dir_get_parent_fid(struct inode *dir, struct lu_fid *parent_fid)
 	ll_finish_md_op_data(op_data);
 	if (rc) {
 		CERROR("%s: failure inode " DFID " get parent: rc = %d\n",
-		       ll_get_fsname(dir->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(dir), NULL, 0),
 		       PFID(ll_inode2fid(dir)), rc);
 		return rc;
 	}
@@ -361,7 +361,7 @@ static struct dentry *ll_get_parent(struct dentry *dchild)
 	if (rc)
 		return ERR_PTR(rc);
 
-	dentry = ll_iget_for_nfs(dchild->d_inode->i_sb, &parent_fid, NULL);
+	dentry = ll_iget_for_nfs(inode_sb(dchild->d_inode), &parent_fid, NULL);
 
 	return dentry;
 }
diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
index a2687f46a16d..35296a363db5 100644
--- a/drivers/staging/lustre/lustre/llite/namei.c
+++ b/drivers/staging/lustre/lustre/llite/namei.c
@@ -326,7 +326,7 @@ int ll_md_blocking_ast(struct ldlm_lock *lock, struct ldlm_lock_desc *desc,
 				 * ->ilookup5()), because master inode state is
 				 *  NEW.
 				 */
-				master_inode = ilookup5_nowait(inode->i_sb,
+				master_inode = ilookup5_nowait(inode_sb(inode),
 							       hash,
 							       ll_test_inode_by_fid,
 							       (void *)&lli->lli_pfid);
@@ -340,7 +340,7 @@ int ll_md_blocking_ast(struct ldlm_lock *lock, struct ldlm_lock_desc *desc,
 		}
 
 		if ((bits & (MDS_INODELOCK_LOOKUP | MDS_INODELOCK_PERM)) &&
-		    inode->i_sb->s_root &&
+		    inode_sb(inode)->s_root &&
 		    !is_root_inode(inode))
 			ll_invalidate_aliases(inode);
 
@@ -782,7 +782,7 @@ static struct inode *ll_create_node(struct inode *dir, struct lookup_intent *it)
 	LASSERT(it_disposition(it, DISP_ENQ_CREATE_REF));
 	request = it->it_request;
 	it_clear_disposition(it, DISP_ENQ_CREATE_REF);
-	rc = ll_prep_inode(&inode, request, dir->i_sb, it);
+	rc = ll_prep_inode(&inode, request, inode_sb(dir), it);
 	if (rc) {
 		inode = ERR_PTR(rc);
 		goto out;
@@ -925,7 +925,7 @@ static int ll_new_node(struct inode *dir, struct dentry *dentry,
 
 	ll_update_times(request, dir);
 
-	err = ll_prep_inode(&inode, request, dir->i_sb, NULL);
+	err = ll_prep_inode(&inode, request, inode_sb(dir), NULL);
 	if (err)
 		goto err_exit;
 
diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/staging/lustre/lustre/llite/statahead.c
index 90c7324575e4..8245da36cfab 100644
--- a/drivers/staging/lustre/lustre/llite/statahead.c
+++ b/drivers/staging/lustre/lustre/llite/statahead.c
@@ -586,12 +586,12 @@ static void sa_instantiate(struct ll_statahead_info *sai,
 		goto out;
 	}
 
-	rc = ll_prep_inode(&child, req, dir->i_sb, it);
+	rc = ll_prep_inode(&child, req, inode_sb(dir), it);
 	if (rc)
 		goto out;
 
 	CDEBUG(D_READA, "%s: setting %.*s" DFID " l_data to inode %p\n",
-	       ll_get_fsname(child->i_sb, NULL, 0),
+	       ll_get_fsname(inode_sb(child), NULL, 0),
 	       entry->se_qstr.len, entry->se_qstr.name,
 	       PFID(ll_inode2fid(child)), child);
 	ll_set_lock_data(ll_i2sbi(dir)->ll_md_exp, child, it, NULL);
@@ -1277,7 +1277,7 @@ static int is_first_dirent(struct inode *dir, struct dentry *dentry)
 
 			rc = PTR_ERR(page);
 			CERROR("%s: error reading dir " DFID " at %llu: opendir_pid = %u : rc = %d\n",
-			       ll_get_fsname(dir->i_sb, NULL, 0),
+			       ll_get_fsname(inode_sb(dir), NULL, 0),
 			       PFID(ll_inode2fid(dir)), pos,
 			       lli->lli_opendir_pid, rc);
 			break;
@@ -1474,7 +1474,7 @@ static int revalidate_statahead_dentry(struct inode *dir,
 				/* revalidate, but inode is recreated */
 				CDEBUG(D_READA,
 				       "%s: stale dentry %pd inode " DFID ", statahead inode " DFID "\n",
-				       ll_get_fsname((*dentryp)->d_inode->i_sb,
+				       ll_get_fsname(inode_sb((*dentryp)->d_inode),
 						     NULL, 0),
 				       *dentryp,
 				       PFID(ll_inode2fid((*dentryp)->d_inode)),
diff --git a/drivers/staging/lustre/lustre/llite/symlink.c b/drivers/staging/lustre/lustre/llite/symlink.c
index 0690fdbf49f5..caebe4f16dab 100644
--- a/drivers/staging/lustre/lustre/llite/symlink.c
+++ b/drivers/staging/lustre/lustre/llite/symlink.c
@@ -74,7 +74,7 @@ static int ll_readlink_internal(struct inode *inode,
 	if (rc) {
 		if (rc != -ENOENT)
 			CERROR("%s: inode " DFID ": rc = %d\n",
-			       ll_get_fsname(inode->i_sb, NULL, 0),
+			       ll_get_fsname(inode_sb(inode), NULL, 0),
 			       PFID(ll_inode2fid(inode)), rc);
 		goto failed;
 	}
@@ -89,7 +89,7 @@ static int ll_readlink_internal(struct inode *inode,
 	LASSERT(symlen != 0);
 	if (body->mbo_eadatasize != symlen) {
 		CERROR("%s: inode " DFID ": symlink length %d not expected %d\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(ll_inode2fid(inode)), body->mbo_eadatasize - 1,
 		       symlen - 1);
 		rc = -EPROTO;
diff --git a/drivers/staging/lustre/lustre/llite/vvp_io.c b/drivers/staging/lustre/lustre/llite/vvp_io.c
index e7a4778e02e4..3262a297e310 100644
--- a/drivers/staging/lustre/lustre/llite/vvp_io.c
+++ b/drivers/staging/lustre/lustre/llite/vvp_io.c
@@ -951,7 +951,7 @@ static int vvp_io_write_start(const struct lu_env *env,
 	if (pos + cnt > ll_file_maxbytes(inode)) {
 		CDEBUG(D_INODE,
 		       "%s: file " DFID " offset %llu > maxbytes %llu\n",
-		       ll_get_fsname(inode->i_sb, NULL, 0),
+		       ll_get_fsname(inode_sb(inode), NULL, 0),
 		       PFID(ll_inode2fid(inode)), pos + cnt,
 		       ll_file_maxbytes(inode));
 		return -EFBIG;
@@ -1366,7 +1366,7 @@ int vvp_io_init(const struct lu_env *env, struct cl_object *obj,
 			result = 0;
 		if (result < 0)
 			CERROR("%s: refresh file layout " DFID " error %d.\n",
-			       ll_get_fsname(inode->i_sb, NULL, 0),
+			       ll_get_fsname(inode_sb(inode), NULL, 0),
 			       PFID(lu_object_fid(&obj->co_lu)), result);
 	}
 
diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 532384c91447..2e4becc5b3c6 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -352,7 +352,7 @@ ll_xattr_list(struct inode *inode, const char *name, int type, void *buffer,
 	if (rc == -EOPNOTSUPP && type == XATTR_USER_T) {
 		LCONSOLE_INFO(
 			"%s: disabling user_xattr feature because it is not supported on the server: rc = %d\n",
-			ll_get_fsname(inode->i_sb, NULL, 0), rc);
+			ll_get_fsname(inode_sb(inode), NULL, 0), rc);
 		sbi->ll_flags &= ~LL_SBI_USER_XATTR;
 	}
 out:
diff --git a/drivers/staging/ncpfs/dir.c b/drivers/staging/ncpfs/dir.c
index 0c57c5c5d40a..10be63953509 100644
--- a/drivers/staging/ncpfs/dir.c
+++ b/drivers/staging/ncpfs/dir.c
@@ -160,7 +160,8 @@ ncp_compare_dentry(const struct dentry *dentry,
 	if (ncp_case_sensitive(pinode))
 		return strncmp(str, name->name, len);
 
-	return ncp_strnicmp(NCP_IO_TABLE(pinode->i_sb), str, name->name, len);
+	return ncp_strnicmp(NCP_IO_TABLE(inode_sb(pinode)), str, name->name,
+			    len);
 }
 
 /*
@@ -616,8 +617,8 @@ ncp_fill_cache(struct file *file, struct dir_context *ctx,
 		struct inode *inode;
 
 		entry->opened = 0;
-		entry->ino = iunique(dir->i_sb, 2);
-		inode = ncp_iget(dir->i_sb, entry);
+		entry->ino = iunique(inode_sb(dir), 2);
+		inode = ncp_iget(inode_sb(dir), entry);
 		if (inode) {
 			d_instantiate(newdent, inode);
 			if (!hashed)
@@ -664,7 +665,7 @@ ncp_fill_cache(struct file *file, struct dir_context *ctx,
 		ctl.valid = 0;
 	if (!ctl.filled && (ctl.fpos == ctx->pos)) {
 		if (!ino)
-			ino = iunique(dir->i_sb, 2);
+			ino = iunique(inode_sb(dir), 2);
 		ctl.filled = !dir_emit(ctx, qname.name, qname.len,
 				     ino, DT_UNKNOWN);
 		if (!ctl.filled)
@@ -857,10 +858,10 @@ static struct dentry *ncp_lookup(struct inode *dir, struct dentry *dentry, unsig
 	 * Create an inode for the entry.
 	 */
 	finfo.opened = 0;
-	finfo.ino = iunique(dir->i_sb, 2);
+	finfo.ino = iunique(inode_sb(dir), 2);
 	finfo.volume = finfo.i.volNumber;
 	error = -EACCES;
-	inode = ncp_iget(dir->i_sb, &finfo);
+	inode = ncp_iget(inode_sb(dir), &finfo);
 
 	if (inode) {
 		ncp_new_dentry(dentry);
@@ -883,8 +884,8 @@ static int ncp_instantiate(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int error = -EINVAL;
 
-	finfo->ino = iunique(dir->i_sb, 2);
-	inode = ncp_iget(dir->i_sb, finfo);
+	finfo->ino = iunique(inode_sb(dir), 2);
+	inode = ncp_iget(inode_sb(dir), finfo);
 	if (!inode)
 		goto out_close;
 	d_instantiate(dentry,inode);
diff --git a/drivers/staging/ncpfs/file.c b/drivers/staging/ncpfs/file.c
index 8f8cc0334ddd..ecb525a92656 100644
--- a/drivers/staging/ncpfs/file.c
+++ b/drivers/staging/ncpfs/file.c
@@ -114,9 +114,9 @@ ncp_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (!iov_iter_count(to))
 		return 0;
-	if (pos > inode->i_sb->s_maxbytes)
+	if (pos > inode_sb(inode)->s_maxbytes)
 		return 0;
-	iov_iter_truncate(to, inode->i_sb->s_maxbytes - pos);
+	iov_iter_truncate(to, inode_sb(inode)->s_maxbytes - pos);
 
 	error = ncp_make_open(inode, O_RDONLY);
 	if (error) {
diff --git a/drivers/staging/ncpfs/ioctl.c b/drivers/staging/ncpfs/ioctl.c
index d378b98cd7b6..6be6eae9e0db 100644
--- a/drivers/staging/ncpfs/ioctl.c
+++ b/drivers/staging/ncpfs/ioctl.c
@@ -325,7 +325,7 @@ static long __ncp_ioctl(struct inode *inode, unsigned int cmd, unsigned long arg
 		if (server->root_setuped)
 			result = -EBUSY;
 		else {
-			result = ncp_conn_logged_in(inode->i_sb);
+			result = ncp_conn_logged_in(inode_sb(inode));
 			if (result == 0)
 				server->root_setuped = 1;
 		}
@@ -375,7 +375,7 @@ static long __ncp_ioctl(struct inode *inode, unsigned int cmd, unsigned long arg
 			result = -EACCES;
 			mutex_lock(&server->root_setup_lock);
 			if (server->m.mounted_vol[0]) {
-				struct dentry* dentry = inode->i_sb->s_root;
+				struct dentry* dentry = inode_sb(inode)->s_root;
 
 				if (dentry) {
 					struct inode* s_inode = d_inode(dentry);
@@ -431,7 +431,7 @@ static long __ncp_ioctl(struct inode *inode, unsigned int cmd, unsigned long arg
 					result = 0;
 
 				if (result == 0) {
-					dentry = inode->i_sb->s_root;
+					dentry = inode_sb(inode)->s_root;
 					if (dentry) {
 						struct inode* s_inode = d_inode(dentry);
 
diff --git a/drivers/staging/ncpfs/ncp_fs.h b/drivers/staging/ncpfs/ncp_fs.h
index bdd262b6c198..534d2cad978c 100644
--- a/drivers/staging/ncpfs/ncp_fs.h
+++ b/drivers/staging/ncpfs/ncp_fs.h
@@ -46,7 +46,7 @@ static inline struct ncp_server *NCP_SBP(const struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-#define NCP_SERVER(inode)	NCP_SBP((inode)->i_sb)
+#define NCP_SERVER(inode)	NCP_SBP(inode_sb((inode)))
 static inline struct ncp_inode_info *NCP_FINFO(const struct inode *inode)
 {
 	return container_of(inode, struct ncp_inode_info, vfs_inode);
-- 
2.15.1
