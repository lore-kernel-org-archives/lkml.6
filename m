Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeEHS0E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:26:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755507AbeEHSF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:59 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 49/76] fs/nfsd: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:09 -0700
Message-Id: <20180508180436.716-50-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/nfsd/blocklayout.c | 4 ++--
 fs/nfsd/export.c      | 8 ++++----
 fs/nfsd/nfs4recover.c | 2 +-
 fs/nfsd/nfsctl.c      | 4 ++--
 fs/nfsd/nfssvc.c      | 5 +++--
 fs/nfsd/vfs.c         | 8 ++++----
 6 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 70b8bf781fce..66fe95fc7966 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -24,7 +24,7 @@ nfsd4_block_proc_layoutget(struct inode *inode, const struct svc_fh *fhp,
 		struct nfsd4_layoutget *args)
 {
 	struct nfsd4_layout_seg *seg = &args->lg_seg;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u32 block_size = i_blocksize(inode);
 	struct pnfs_block_extent *bex;
 	struct iomap iomap;
@@ -134,7 +134,7 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		iattr.ia_size = new_size;
 	}
 
-	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
+	error = inode_sb(inode)->s_export_op->commit_blocks(inode, iomaps,
 			nr_iomaps, &iattr);
 	kfree(iomaps);
 	return nfserrno(error);
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8ceb25a10ea0..bd554e880415 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -366,15 +366,15 @@ static int check_export(struct inode *inode, int *flags, unsigned char *uuid)
 	 * 2:  We must be able to find an inode from a filehandle.
 	 *       This means that s_export_op must be set.
 	 */
-	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
+	if (!(inode_sb(inode)->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(*flags & NFSEXP_FSID) &&
 	    uuid == NULL) {
 		dprintk("exp_export: export of non-dev fs without fsid\n");
 		return -EINVAL;
 	}
 
-	if (!inode->i_sb->s_export_op ||
-	    !inode->i_sb->s_export_op->fh_to_dentry) {
+	if (!inode_sb(inode)->s_export_op ||
+	    !inode_sb(inode)->s_export_op->fh_to_dentry) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
@@ -895,7 +895,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 
 	dprintk("nfsd: exp_rootfh(%s [%p] %s:%s/%ld)\n",
 		 name, path.dentry, clp->name,
-		 inode->i_sb->s_id, inode->i_ino);
+		 inode_sb(inode)->s_id, inode->i_ino);
 	exp = exp_parent(cd, clp, &path);
 	if (IS_ERR(exp)) {
 		err = PTR_ERR(exp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 66eaeb1e8c2c..11d6aeb74bc1 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -716,7 +716,7 @@ cld_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 	struct cld_upcall *tmp, *cup;
 	struct cld_msg __user *cmsg = (struct cld_msg __user *)src;
 	uint32_t xid;
-	struct nfsd_net *nn = net_generic(file_inode(filp)->i_sb->s_fs_info,
+	struct nfsd_net *nn = net_generic(inode_sb(file_inode(filp))->s_fs_info,
 						nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d107b4426f7e..4b7473141f2d 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -162,7 +162,7 @@ static const struct file_operations exports_proc_operations = {
 
 static int exports_nfsd_open(struct inode *inode, struct file *file)
 {
-	return exports_net_open(inode->i_sb->s_fs_info, file);
+	return exports_net_open(inode_sb(inode)->s_fs_info, file);
 }
 
 static const struct file_operations exports_nfsd_operations = {
@@ -231,7 +231,7 @@ static const struct file_operations reply_cache_stats_operations = {
 
 static inline struct net *netns(struct file *file)
 {
-	return file_inode(file)->i_sb->s_fs_info;
+	return inode_sb(file_inode(file))->s_fs_info;
 }
 
 /**
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 89cb484f1cfb..742755f6356a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -866,7 +866,8 @@ nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 {
 	int ret;
-	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
+	struct nfsd_net *nn = net_generic(inode_sb(inode)->s_fs_info,
+					  nfsd_net_id);
 
 	mutex_lock(&nfsd_mutex);
 	if (nn->nfsd_serv == NULL) {
@@ -883,7 +884,7 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
 int nfsd_pool_stats_release(struct inode *inode, struct file *file)
 {
 	int ret = seq_release(inode, file);
-	struct net *net = inode->i_sb->s_fs_info;
+	struct net *net = inode_sb(inode)->s_fs_info;
 
 	mutex_lock(&nfsd_mutex);
 	/* this function really, really should have been called svc_put() */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index a3c9bfa77def..393159739b95 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -310,7 +310,7 @@ static int
 commit_metadata(struct svc_fh *fhp)
 {
 	struct inode *inode = d_inode(fhp->fh_dentry);
-	const struct export_operations *export_ops = inode->i_sb->s_export_op;
+	const struct export_operations *export_ops = inode_sb(inode)->s_export_op;
 
 	if (!EX_ISSYNC(fhp->fh_export))
 		return 0;
@@ -786,7 +786,7 @@ struct raparms *
 nfsd_init_raparms(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	dev_t dev = inode->i_sb->s_dev;
+	dev_t dev = inode_sb(inode)->s_dev;
 	ino_t ino = inode->i_ino;
 	struct raparms	*ra, **rap, **frap = NULL;
 	int depth = 0;
@@ -943,7 +943,7 @@ static int wait_for_concurrent_writes(struct file *file)
 	int err = 0;
 
 	if (atomic_read(&inode->i_writecount) > 1
-	    || (last_ino == inode->i_ino && last_dev == inode->i_sb->s_dev)) {
+	    || (last_ino == inode->i_ino && last_dev == inode_sb(inode)->s_dev)) {
 		dprintk("nfsd: write defer %d\n", task_pid_nr(current));
 		msleep(10);
 		dprintk("nfsd: write resume %d\n", task_pid_nr(current));
@@ -954,7 +954,7 @@ static int wait_for_concurrent_writes(struct file *file)
 		err = vfs_fsync(file, 0);
 	}
 	last_ino = inode->i_ino;
-	last_dev = inode->i_sb->s_dev;
+	last_dev = inode_sb(inode)->s_dev;
 	return err;
 }
 
-- 
2.15.1
