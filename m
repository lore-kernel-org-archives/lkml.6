Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755783AbeEHSGG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54115 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755755AbeEHSGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:01 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 50/76] fs/nfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:10 -0700
Message-Id: <20180508180436.716-51-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/nfs/blocklayout/rpc_pipefs.c        |  2 +-
 fs/nfs/callback_proc.c                 |  4 ++--
 fs/nfs/dir.c                           | 22 +++++++++---------
 fs/nfs/export.c                        |  2 +-
 fs/nfs/file.c                          |  4 ++--
 fs/nfs/filelayout/filelayout.c         |  4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ++---
 fs/nfs/fscache.c                       |  2 +-
 fs/nfs/inode.c                         | 20 ++++++++--------
 fs/nfs/internal.h                      |  4 ++--
 fs/nfs/nfs42proc.c                     |  2 +-
 fs/nfs/nfs4proc.c                      |  4 ++--
 fs/nfs/nfs4trace.h                     | 36 ++++++++++++++---------------
 fs/nfs/nfstrace.h                      | 42 +++++++++++++++++-----------------
 fs/nfs/pagelist.c                      |  2 +-
 fs/nfs/pnfs.c                          |  2 +-
 fs/nfs/read.c                          |  4 ++--
 fs/nfs/unlink.c                        |  6 ++---
 18 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/fs/nfs/blocklayout/rpc_pipefs.c b/fs/nfs/blocklayout/rpc_pipefs.c
index 9fb067a6f7e0..68a6176a4287 100644
--- a/fs/nfs/blocklayout/rpc_pipefs.c
+++ b/fs/nfs/blocklayout/rpc_pipefs.c
@@ -112,7 +112,7 @@ bl_resolve_deviceid(struct nfs_server *server, struct pnfs_block_volume *b,
 static ssize_t bl_pipe_downcall(struct file *filp, const char __user *src,
 			 size_t mlen)
 {
-	struct nfs_net *nn = net_generic(file_inode(filp)->i_sb->s_fs_info,
+	struct nfs_net *nn = net_generic(inode_sb(file_inode(filp))->s_fs_info,
 					 nfs_net_id);
 
 	if (mlen != sizeof (struct bl_dev_msg))
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index a50d7813e3ea..73c5a7baf8a4 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -133,7 +133,7 @@ static struct inode *nfs_layout_find_inode_by_stateid(struct nfs_client *clp,
 			inode = igrab(lo->plh_inode);
 			if (!inode)
 				continue;
-			if (!nfs_sb_active(inode->i_sb)) {
+			if (!nfs_sb_active(inode_sb(inode))) {
 				rcu_read_unlock();
 				spin_unlock(&clp->cl_lock);
 				iput(inode);
@@ -173,7 +173,7 @@ static struct inode *nfs_layout_find_inode_by_fh(struct nfs_client *clp,
 			inode = igrab(lo->plh_inode);
 			if (!inode)
 				continue;
-			if (!nfs_sb_active(inode->i_sb)) {
+			if (!nfs_sb_active(inode_sb(inode))) {
 				rcu_read_unlock();
 				spin_unlock(&clp->cl_lock);
 				iput(inode);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2f3f86726f5b..3d150fa56e4f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1449,7 +1449,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	BUG_ON(d_inode(dentry));
 
 	dfprintk(VFS, "NFS: atomic_open(%s/%lu), %pd\n",
-			dir->i_sb->s_id, dir->i_ino, dentry);
+			inode_sb(dir)->s_id, dir->i_ino, dentry);
 
 	err = nfs_check_flags(open_flags);
 	if (err)
@@ -1671,7 +1671,7 @@ int nfs_create(struct inode *dir, struct dentry *dentry,
 	int error;
 
 	dfprintk(VFS, "NFS: create(%s/%lu), %pd\n",
-			dir->i_sb->s_id, dir->i_ino, dentry);
+			inode_sb(dir)->s_id, dir->i_ino, dentry);
 
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
@@ -1698,7 +1698,7 @@ nfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
 	int status;
 
 	dfprintk(VFS, "NFS: mknod(%s/%lu), %pd\n",
-			dir->i_sb->s_id, dir->i_ino, dentry);
+			inode_sb(dir)->s_id, dir->i_ino, dentry);
 
 	attr.ia_mode = mode;
 	attr.ia_valid = ATTR_MODE;
@@ -1724,7 +1724,7 @@ int nfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	int error;
 
 	dfprintk(VFS, "NFS: mkdir(%s/%lu), %pd\n",
-			dir->i_sb->s_id, dir->i_ino, dentry);
+			inode_sb(dir)->s_id, dir->i_ino, dentry);
 
 	attr.ia_valid = ATTR_MODE;
 	attr.ia_mode = mode | S_IFDIR;
@@ -1752,7 +1752,7 @@ int nfs_rmdir(struct inode *dir, struct dentry *dentry)
 	int error;
 
 	dfprintk(VFS, "NFS: rmdir(%s/%lu), %pd\n",
-			dir->i_sb->s_id, dir->i_ino, dentry);
+			inode_sb(dir)->s_id, dir->i_ino, dentry);
 
 	trace_nfs_rmdir_enter(dir, dentry);
 	if (d_really_is_positive(dentry)) {
@@ -1821,8 +1821,8 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 	int error;
 	int need_rehash = 0;
 
-	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
-		dir->i_ino, dentry);
+	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", inode_sb(dir)->s_id,
+		 dir->i_ino, dentry);
 
 	trace_nfs_unlink_enter(dir, dentry);
 	spin_lock(&dentry->d_lock);
@@ -1872,8 +1872,8 @@ int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 	unsigned int pathlen = strlen(symname);
 	int error;
 
-	dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s)\n", dir->i_sb->s_id,
-		dir->i_ino, dentry, symname);
+	dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s)\n", inode_sb(dir)->s_id,
+		 dir->i_ino, dentry, symname);
 
 	if (pathlen > PAGE_SIZE)
 		return -ENAMETOOLONG;
@@ -1895,7 +1895,7 @@ int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
 	trace_nfs_symlink_exit(dir, dentry, error);
 	if (error != 0) {
 		dfprintk(VFS, "NFS: symlink(%s/%lu, %pd, %s) error %d\n",
-			dir->i_sb->s_id, dir->i_ino,
+			inode_sb(dir)->s_id, dir->i_ino,
 			dentry, symname, error);
 		d_drop(dentry);
 		__free_page(page);
@@ -2540,7 +2540,7 @@ int nfs_permission(struct inode *inode, int mask)
 		res = nfs_execute_ok(inode, mask);
 
 	dfprintk(VFS, "NFS: permission(%s/%lu), mask=0x%x, res=%d\n",
-		inode->i_sb->s_id, inode->i_ino, mask, res);
+		inode_sb(inode)->s_id, inode->i_ino, mask, res);
 	return res;
 out_notsup:
 	if (mask & MAY_NOT_BLOCK)
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index ab5de3246c5c..de16a94dab82 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -127,7 +127,7 @@ nfs_get_parent(struct dentry *dentry)
 {
 	int ret;
 	struct inode *inode = d_inode(dentry), *pinode;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct nfs_server *server = NFS_SB(sb);
 	struct nfs_fattr *fattr = NULL;
 	struct nfs4_label *label = NULL;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 81cca49a8375..5997bd7ea978 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -545,7 +545,7 @@ static int nfs_vm_page_mkwrite(struct vm_fault *vmf)
 		filp, filp->f_mapping->host->i_ino,
 		(long long)page_offset(page));
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 
 	/* make sure the cache has finished storing the page */
 	nfs_fscache_wait_on_page_write(NFS_I(inode), page);
@@ -573,7 +573,7 @@ static int nfs_vm_page_mkwrite(struct vm_fault *vmf)
 out_unlock:
 	unlock_page(page);
 out:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d175724ff566..5c4945503b67 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -93,7 +93,7 @@ static void filelayout_reset_write(struct nfs_pgio_header *hdr)
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			inode_sb(hdr->inode)->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -110,7 +110,7 @@ static void filelayout_reset_read(struct nfs_pgio_header *hdr)
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			inode_sb(hdr->inode)->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index c75ad982bcfc..89383069dd95 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1001,7 +1001,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 		dprintk("%s Reset task %5u for i/o through pNFS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			inode_sb(hdr->inode)->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -1014,7 +1014,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			inode_sb(hdr->inode)->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
@@ -1033,7 +1033,7 @@ static void ff_layout_reset_read(struct nfs_pgio_header *hdr)
 		dprintk("%s Reset task %5u for i/o through MDS "
 			"(req %s/%llu, %u bytes @ offset %llu)\n", __func__,
 			hdr->task.tk_pid,
-			hdr->inode->i_sb->s_id,
+			inode_sb(hdr->inode)->s_id,
 			(unsigned long long)NFS_FILEID(hdr->inode),
 			hdr->args.count,
 			(unsigned long long)hdr->args.offset);
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index d63bea8bbfbb..25dce99edd64 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -185,7 +185,7 @@ void nfs_fscache_init_inode(struct inode *inode)
 	nfsi->fscache = NULL;
 	if (!S_ISREG(inode->i_mode))
 		return;
-	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode->i_sb)->fscache,
+	nfsi->fscache = fscache_acquire_cookie(NFS_SB(inode_sb(inode))->fscache,
 					       &nfs_fscache_inode_object_def,
 					       nfsi, false);
 }
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7d893543cf3b..52d3bc16099a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -556,7 +556,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 		}
 	}
 	dprintk("NFS: nfs_fhget(%s/%Lu fh_crc=0x%08x ct=%d)\n",
-		inode->i_sb->s_id,
+		inode_sb(inode)->s_id,
 		(unsigned long long)NFS_FILEID(inode),
 		nfs_display_fhandle_hash(fh),
 		atomic_read(&inode->i_count));
@@ -1074,7 +1074,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%s/%Lu)\n",
-		inode->i_sb->s_id, (unsigned long long)NFS_FILEID(inode));
+		inode_sb(inode)->s_id, (unsigned long long)NFS_FILEID(inode));
 
 	trace_nfs_revalidate_inode_enter(inode);
 
@@ -1106,7 +1106,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	status = NFS_PROTO(inode)->getattr(server, NFS_FH(inode), fattr, label);
 	if (status != 0) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) getattr failed, error=%d\n",
-			 inode->i_sb->s_id,
+			 inode_sb(inode)->s_id,
 			 (unsigned long long)NFS_FILEID(inode), status);
 		if (status == -ESTALE) {
 			nfs_zap_caches(inode);
@@ -1119,7 +1119,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	status = nfs_refresh_inode(inode, fattr);
 	if (status) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Lu) refresh failed, error=%d\n",
-			 inode->i_sb->s_id,
+			 inode_sb(inode)->s_id,
 			 (unsigned long long)NFS_FILEID(inode), status);
 		goto err_out;
 	}
@@ -1130,7 +1130,7 @@ __nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 	nfs_setsecurity(inode, fattr, label);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) revalidation complete\n",
-		inode->i_sb->s_id,
+		inode_sb(inode)->s_id,
 		(unsigned long long)NFS_FILEID(inode));
 
 err_out:
@@ -1187,7 +1187,7 @@ static int nfs_invalidate_mapping(struct inode *inode, struct address_space *map
 	nfs_fscache_wait_on_invalidate(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Lu) data cache invalidated\n",
-			inode->i_sb->s_id,
+			inode_sb(inode)->s_id,
 			(unsigned long long)NFS_FILEID(inode));
 	return 0;
 }
@@ -1750,7 +1750,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	bool cache_revalidated = true;
 
 	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%x)\n",
-			__func__, inode->i_sb->s_id, inode->i_ino,
+			__func__, inode_sb(inode)->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
 			atomic_read(&inode->i_count), fattr->valid);
 
@@ -1758,7 +1758,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		printk(KERN_ERR "NFS: server %s error: fileid changed\n"
 			"fsid %s: expected fileid 0x%Lx, got 0x%Lx\n",
 			NFS_SERVER(inode)->nfs_client->cl_hostname,
-			inode->i_sb->s_id, (long long)nfsi->fileid,
+			inode_sb(inode)->s_id, (long long)nfsi->fileid,
 			(long long)fattr->fileid);
 		goto out_err;
 	}
@@ -1805,7 +1805,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	if (fattr->valid & NFS_ATTR_FATTR_CHANGE) {
 		if (!inode_eq_iversion_raw(inode, fattr->change_attr)) {
 			dprintk("NFS: change_attr change on server for file %s/%ld\n",
-					inode->i_sb->s_id, inode->i_ino);
+					inode_sb(inode)->s_id, inode->i_ino);
 			/* Could it be a race with writeback? */
 			if (!have_writers) {
 				invalid |= NFS_INO_INVALID_ATTR
@@ -1854,7 +1854,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			}
 			dprintk("NFS: isize change on server for file %s/%ld "
 					"(%Ld to %Ld)\n",
-					inode->i_sb->s_id,
+					inode_sb(inode)->s_id,
 					inode->i_ino,
 					(long long)cur_isize,
 					(long long)new_isize);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8357ff69962f..7234e76d9025 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -576,7 +576,7 @@ extern int nfs4_test_session_trunk(struct rpc_clnt *,
 static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 {
 	inode = igrab(inode);
-	if (inode != NULL && !nfs_sb_active(inode->i_sb)) {
+	if (inode != NULL && !nfs_sb_active(inode_sb(inode))) {
 		iput(inode);
 		inode = NULL;
 	}
@@ -586,7 +586,7 @@ static inline struct inode *nfs_igrab_and_active(struct inode *inode)
 static inline void nfs_iput_and_deactive(struct inode *inode)
 {
 	if (inode != NULL) {
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 
 		iput(inode);
 		nfs_sb_deactive(sb);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 9c374441f660..f423ced401e3 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -303,7 +303,7 @@ static loff_t _nfs42_proc_llseek(struct file *filep,
 	if (status)
 		return status;
 
-	return vfs_setpos(filep, res.sr_offset, inode->i_sb->s_maxbytes);
+	return vfs_setpos(filep, res.sr_offset, inode_sb(inode)->s_maxbytes);
 }
 
 loff_t nfs42_proc_llseek(struct file *filep, loff_t offset, int whence)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47f3c273245e..c066bc148f05 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3136,7 +3136,7 @@ static void nfs4_free_closedata(void *data)
 {
 	struct nfs4_closedata *calldata = data;
 	struct nfs4_state_owner *sp = calldata->state->owner;
-	struct super_block *sb = calldata->state->inode->i_sb;
+	struct super_block *sb = inode_sb(calldata->state->inode);
 
 	if (calldata->lr.roc)
 		pnfs_roc_release(&calldata->lr.arg, &calldata->lr.res,
@@ -3393,7 +3393,7 @@ int nfs4_do_close(struct nfs4_state *state, gfp_t gfp_mask, int wait)
 		calldata->arg.lr_args = &calldata->lr.arg;
 		calldata->res.lr_res = &calldata->lr.res;
 	}
-	nfs_sb_active(calldata->inode->i_sb);
+	nfs_sb_active(inode_sb(calldata->inode));
 
 	msg.rpc_argp = &calldata->arg;
 	msg.rpc_resp = &calldata->res;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index a275fba93170..517f3194b055 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -488,7 +488,7 @@ TRACE_EVENT(nfs4_cached_open,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
@@ -533,7 +533,7 @@ TRACE_EVENT(nfs4_close,
 		TP_fast_assign(
 			const struct inode *inode = state->inode;
 
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)state->state;
@@ -600,7 +600,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -672,7 +672,7 @@ TRACE_EVENT(nfs4_set_lock,
 			__entry->type = request->fl_type;
 			__entry->start = request->fl_start;
 			__entry->end = request->fl_end;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -719,7 +719,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->fmode = (__force unsigned int)fmode;
@@ -804,7 +804,7 @@ DECLARE_EVENT_CLASS(nfs4_test_stateid_event,
 			const struct inode *inode = state->inode;
 
 			__entry->error = error;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->stateid_seq =
@@ -855,7 +855,7 @@ DECLARE_EVENT_CLASS(nfs4_lookup_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__assign_str(name, name->name);
@@ -903,7 +903,7 @@ TRACE_EVENT(nfs4_lookupp,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->ino = NFS_FILEID(inode);
 			__entry->error = error;
 		),
@@ -938,7 +938,7 @@ TRACE_EVENT(nfs4_rename,
 		),
 
 		TP_fast_assign(
-			__entry->dev = olddir->i_sb->s_dev;
+			__entry->dev = inode_sb(olddir)->s_dev;
 			__entry->olddir = NFS_FILEID(olddir);
 			__entry->newdir = NFS_FILEID(newdir);
 			__entry->error = error;
@@ -976,7 +976,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error;
@@ -1029,7 +1029,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->error = error;
@@ -1139,7 +1139,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_callback_event,
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (inode != NULL) {
 				__entry->fileid = NFS_FILEID(inode);
-				__entry->dev = inode->i_sb->s_dev;
+				__entry->dev = inode_sb(inode)->s_dev;
 			} else {
 				__entry->fileid = 0;
 				__entry->dev = 0;
@@ -1196,7 +1196,7 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			if (inode != NULL) {
 				__entry->fileid = NFS_FILEID(inode);
-				__entry->dev = inode->i_sb->s_dev;
+				__entry->dev = inode_sb(inode)->s_dev;
 			} else {
 				__entry->fileid = 0;
 				__entry->dev = 0;
@@ -1303,7 +1303,7 @@ DECLARE_EVENT_CLASS(nfs4_read_event,
 			const struct inode *inode = hdr->inode;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
@@ -1363,7 +1363,7 @@ DECLARE_EVENT_CLASS(nfs4_write_event,
 			const struct inode *inode = hdr->inode;
 			const struct nfs4_state *state =
 				hdr->args.context->state;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = hdr->args.offset;
@@ -1420,7 +1420,7 @@ DECLARE_EVENT_CLASS(nfs4_commit_event,
 
 		TP_fast_assign(
 			const struct inode *inode = data->inode;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->offset = data->args.offset;
@@ -1485,7 +1485,7 @@ TRACE_EVENT(nfs4_layoutget,
 		TP_fast_assign(
 			const struct inode *inode = d_inode(ctx->dentry);
 			const struct nfs4_state *state = ctx->state;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->iomode = args->iomode;
@@ -1567,7 +1567,7 @@ TRACE_EVENT(pnfs_update_layout,
 			__field(enum pnfs_update_layout_reason, reason)
 		),
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->fhandle = nfs_fhandle_hash(NFS_FH(inode));
 			__entry->pos = pos;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index bd60f8d1e181..aeacf2b86260 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
@@ -97,7 +97,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
 		TP_fast_assign(
 			const struct nfs_inode *nfsi = NFS_I(inode);
 			__entry->error = error;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->type = nfs_umode_to_dtype(inode->i_mode);
@@ -183,7 +183,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -227,7 +227,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__entry->flags = flags;
@@ -294,7 +294,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
@@ -333,7 +333,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
 
 		TP_fast_assign(
 			__entry->error = error;
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__entry->fmode = (__force unsigned int)ctx->mode;
@@ -370,7 +370,7 @@ TRACE_EVENT(nfs_create_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -406,7 +406,7 @@ TRACE_EVENT(nfs_create_exit,
 
 		TP_fast_assign(
 			__entry->error = error;
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->flags = flags;
 			__assign_str(name, dentry->d_name.name);
@@ -438,7 +438,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__assign_str(name, dentry->d_name.name);
 		),
@@ -476,7 +476,7 @@ DECLARE_EVENT_CLASS(nfs_directory_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			__assign_str(name, dentry->d_name.name);
@@ -530,7 +530,7 @@ TRACE_EVENT(nfs_link_enter,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->dir = NFS_FILEID(dir);
 			__assign_str(name, dentry->d_name.name);
@@ -565,7 +565,7 @@ TRACE_EVENT(nfs_link_exit,
 		),
 
 		TP_fast_assign(
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = NFS_FILEID(inode);
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
@@ -602,7 +602,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = old_dir->i_sb->s_dev;
+			__entry->dev = inode_sb(old_dir)->s_dev;
 			__entry->old_dir = NFS_FILEID(old_dir);
 			__entry->new_dir = NFS_FILEID(new_dir);
 			__assign_str(old_name, old_dentry->d_name.name);
@@ -650,7 +650,7 @@ DECLARE_EVENT_CLASS(nfs_rename_event_done,
 		),
 
 		TP_fast_assign(
-			__entry->dev = old_dir->i_sb->s_dev;
+			__entry->dev = inode_sb(old_dir)->s_dev;
 			__entry->old_dir = NFS_FILEID(old_dir);
 			__entry->new_dir = NFS_FILEID(new_dir);
 			__entry->error = error;
@@ -705,7 +705,7 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 		TP_fast_assign(
 			struct inode *dir = d_inode(data->dentry->d_parent);
 			size_t len = data->args.name.len;
-			__entry->dev = dir->i_sb->s_dev;
+			__entry->dev = inode_sb(dir)->s_dev;
 			__entry->dir = NFS_FILEID(dir);
 			__entry->error = error;
 			memcpy(__get_str(name),
@@ -743,7 +743,7 @@ TRACE_EVENT(nfs_initiate_read,
 
 			__entry->offset = offset;
 			__entry->count = count;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -781,7 +781,7 @@ TRACE_EVENT(nfs_readpage_done,
 			__entry->status = status;
 			__entry->offset = offset;
 			__entry->eof = eof;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -831,7 +831,7 @@ TRACE_EVENT(nfs_initiate_write,
 			__entry->offset = offset;
 			__entry->count = count;
 			__entry->stable = stable;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -875,7 +875,7 @@ TRACE_EVENT(nfs_writeback_done,
 			__entry->stable = writeverf->committed;
 			memcpy(&__entry->verifier, &writeverf->verifier,
 			       sizeof(__entry->verifier));
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -914,7 +914,7 @@ TRACE_EVENT(nfs_initiate_commit,
 
 			__entry->offset = data->args.offset;
 			__entry->count = data->args.count;
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
@@ -953,7 +953,7 @@ TRACE_EVENT(nfs_commit_done,
 			__entry->offset = data->args.offset;
 			memcpy(&__entry->verifier, &data->verf.verifier,
 			       sizeof(__entry->verifier));
-			__entry->dev = inode->i_sb->s_dev;
+			__entry->dev = inode_sb(inode)->s_dev;
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 		),
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 18a7626ac638..39dedd4ee92b 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -611,7 +611,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 
 	dprintk("NFS: initiated pgio call "
 		"(req %s/%llu, %u bytes @ offset %llu)\n",
-		hdr->inode->i_sb->s_id,
+		inode_sb(hdr->inode)->s_id,
 		(unsigned long long)NFS_FILEID(hdr->inode),
 		hdr->args.count,
 		(unsigned long long)hdr->args.offset);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index ee723aa153a3..b0226fe6b7b9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1886,7 +1886,7 @@ pnfs_update_layout(struct inode *ino,
 out:
 	dprintk("%s: inode %s/%llu pNFS layout segment %s for "
 			"(%s, offset: %llu, length: %llu)\n",
-			__func__, ino->i_sb->s_id,
+			__func__, inode_sb(ino)->s_id,
 			(unsigned long long)NFS_FILEID(ino),
 			IS_ERR_OR_NULL(lseg) ? "not found" : "found",
 			iomode==IOMODE_RW ?  "read/write" : "read-only",
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 48d7277c60a9..d559e54d71c4 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -94,7 +94,7 @@ static void nfs_readpage_release(struct nfs_page *req)
 {
 	struct inode *inode = d_inode(req->wb_context->dentry);
 
-	dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb->s_id,
+	dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode_sb(inode)->s_id,
 		(unsigned long long)NFS_FILEID(inode), req->wb_bytes,
 		(long long)req_offset(req));
 
@@ -398,7 +398,7 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	int ret = -ESTALE;
 
 	dprintk("NFS: nfs_readpages (%s/%Lu %d)\n",
-			inode->i_sb->s_id,
+			inode_sb(inode)->s_id,
 			(unsigned long long)NFS_FILEID(inode),
 			nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 630b4a3c1a93..b565fa768255 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -101,7 +101,7 @@ static void nfs_do_call_unlink(struct nfs_unlinkdata *data)
 	};
 	struct rpc_task *task;
 	struct inode *dir = d_inode(data->dentry->d_parent);
-	nfs_sb_active(dir->i_sb);
+	nfs_sb_active(inode_sb(dir));
 	data->args.fh = NFS_FH(dir);
 	nfs_fattr_init(data->res.dir_attr);
 
@@ -284,7 +284,7 @@ static void nfs_async_rename_done(struct rpc_task *task, void *calldata)
 static void nfs_async_rename_release(void *calldata)
 {
 	struct nfs_renamedata	*data = calldata;
-	struct super_block *sb = data->old_dir->i_sb;
+	struct super_block *sb = inode_sb(data->old_dir);
 
 	if (d_really_is_positive(data->old_dentry))
 		nfs_mark_for_revalidate(d_inode(data->old_dentry));
@@ -384,7 +384,7 @@ nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 	data->res.old_fattr = &data->old_fattr;
 	data->res.new_fattr = &data->new_fattr;
 
-	nfs_sb_active(old_dir->i_sb);
+	nfs_sb_active(inode_sb(old_dir));
 
 	NFS_PROTO(data->old_dir)->rename_setup(&msg, old_dir);
 
-- 
2.15.1
