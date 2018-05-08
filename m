Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeEHSGj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:54347 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbeEHSGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:34 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 72/76] fs/xfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:32 -0700
Message-Id: <20180508180436.716-73-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/xfs/xfs_acl.c    |  2 +-
 fs/xfs/xfs_aops.c   |  4 ++--
 fs/xfs/xfs_export.c |  4 ++--
 fs/xfs/xfs_file.c   | 10 ++++-----
 fs/xfs/xfs_ioctl.c  |  8 +++----
 fs/xfs/xfs_iops.c   |  6 ++---
 fs/xfs/xfs_pnfs.c   |  2 +-
 fs/xfs/xfs_trace.h  | 64 ++++++++++++++++++++++++++---------------------------
 8 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 3354140de07e..42b00b01ea1a 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -255,7 +255,7 @@ xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		goto set_acl;
 
 	error = -E2BIG;
-	if (acl->a_count > XFS_ACL_MAX_ENTRIES(XFS_M(inode->i_sb)))
+	if (acl->a_count > XFS_ACL_MAX_ENTRIES(XFS_M(inode_sb(inode))))
 		return error;
 
 	if (type == ACL_TYPE_ACCESS) {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 9c6a830da0ee..951ca9c4ed9e 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -219,7 +219,7 @@ xfs_setfilesize_trans_alloc(
 	 * We may pass freeze protection with a transaction.  So tell lockdep
 	 * we released it.
 	 */
-	__sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);
+	__sb_writers_release(inode_sb(ioend->io_inode), SB_FREEZE_FS);
 	/*
 	 * We hand off the transaction to the completion thread now, so
 	 * clear the flag here.
@@ -288,7 +288,7 @@ xfs_setfilesize_ioend(
 	 * Similarly for freeze protection.
 	 */
 	current_set_flags_nested(&tp->t_pflags, PF_MEMALLOC_NOFS);
-	__sb_writers_acquired(VFS_I(ip)->i_sb, SB_FREEZE_FS);
+	__sb_writers_acquired(inode_sb(VFS_I(ip)), SB_FREEZE_FS);
 
 	/* we abort the update if there was an IO error */
 	if (error) {
diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index fe1bfee35898..a78f6eb9987b 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -78,8 +78,8 @@ xfs_fs_encode_fh(
 	 * large enough filesystem may contain them, thus the slightly
 	 * confusing looking conditional below.
 	 */
-	if (!(XFS_M(inode->i_sb)->m_flags & XFS_MOUNT_SMALL_INUMS) ||
-	    (XFS_M(inode->i_sb)->m_flags & XFS_MOUNT_32BITINODES))
+	if (!(XFS_M(inode_sb(inode))->m_flags & XFS_MOUNT_SMALL_INUMS) ||
+	    (XFS_M(inode_sb(inode))->m_flags & XFS_MOUNT_32BITINODES))
 		fileid_type |= XFS_FILEID_TYPE_64FLAG;
 
 	/*
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 9ea08326f876..7b805a8a031e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -821,7 +821,7 @@ xfs_file_fallocate(
 		}
 
 		/* check the new inode size does not wrap through zero */
-		if (new_size > inode->i_sb->s_maxbytes) {
+		if (new_size > inode_sb(inode)->s_maxbytes) {
 			error = -EFBIG;
 			goto out_unlock;
 		}
@@ -926,7 +926,7 @@ xfs_file_open(
 {
 	if (!(file->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_LFS)
 		return -EFBIG;
-	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
+	if (XFS_FORCED_SHUTDOWN(XFS_M(inode_sb(inode))))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT;
 	return 0;
@@ -1014,7 +1014,7 @@ xfs_file_llseek(
 
 	if (offset < 0)
 		return offset;
-	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+	return vfs_setpos(file, offset, inode_sb(inode)->s_maxbytes);
 }
 
 /*
@@ -1040,7 +1040,7 @@ __xfs_filemap_fault(
 	trace_xfs_filemap_fault(ip, pe_size, write_fault);
 
 	if (write_fault) {
-		sb_start_pagefault(inode->i_sb);
+		sb_start_pagefault(inode_sb(inode));
 		file_update_time(vmf->vma->vm_file);
 	}
 
@@ -1060,7 +1060,7 @@ __xfs_filemap_fault(
 	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 
 	if (write_fault)
-		sb_end_pagefault(inode->i_sb);
+		sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 89fb1eb80aae..8e492a123815 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -98,7 +98,7 @@ xfs_find_handle(
 	 * and only for regular files, directories or symbolic links.
 	 */
 	error = -EINVAL;
-	if (inode->i_sb->s_magic != XFS_SB_MAGIC)
+	if (inode_sb(inode)->s_magic != XFS_SB_MAGIC)
 		goto out_put;
 
 	error = -EBADF;
@@ -688,9 +688,9 @@ xfs_ioc_space(
 	}
 
 	if (bf->l_start < 0 ||
-	    bf->l_start > inode->i_sb->s_maxbytes ||
+	    bf->l_start > inode_sb(inode)->s_maxbytes ||
 	    bf->l_start + bf->l_len < 0 ||
-	    bf->l_start + bf->l_len >= inode->i_sb->s_maxbytes) {
+	    bf->l_start + bf->l_len >= inode_sb(inode)->s_maxbytes) {
 		error = -EINVAL;
 		goto out_unlock;
 	}
@@ -1090,7 +1090,7 @@ xfs_ioctl_setattr_dax_invalidate(
 	int			*join_flags)
 {
 	struct inode		*inode = VFS_I(ip);
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	int			error;
 
 	*join_flags = 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 56475fcd76f2..7aed2ad33d07 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -360,7 +360,7 @@ xfs_vn_unlink(
 	 * but still hashed. This is incompatible with case-insensitive
 	 * mode, so invalidate (unhash) the dentry in CI-mode.
 	 */
-	if (xfs_sb_version_hasasciici(&XFS_M(dir->i_sb)->m_sb))
+	if (xfs_sb_version_hasasciici(&XFS_M(inode_sb(dir))->m_sb))
 		d_invalidate(dentry);
 	return 0;
 }
@@ -503,7 +503,7 @@ xfs_vn_getattr(
 		return -EIO;
 
 	stat->size = XFS_ISIZE(ip);
-	stat->dev = inode->i_sb->s_dev;
+	stat->dev = inode_sb(inode)->s_dev;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
 	stat->uid = inode->i_uid;
@@ -1275,7 +1275,7 @@ xfs_setup_iops(
 		inode->i_mapping->a_ops = &xfs_address_space_operations;
 		break;
 	case S_IFDIR:
-		if (xfs_sb_version_hasasciici(&XFS_M(inode->i_sb)->m_sb))
+		if (xfs_sb_version_hasasciici(&XFS_M(inode_sb(inode))->m_sb))
 			inode->i_op = &xfs_dir_ci_inode_operations;
 		else
 			inode->i_op = &xfs_dir_inode_operations;
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index aa6c5c193f45..c3e90d20bfcf 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -129,7 +129,7 @@ xfs_fs_map_blocks(
 	limit = mp->m_super->s_maxbytes;
 	if (!write)
 		limit = max(limit, round_up(i_size_read(inode),
-				     inode->i_sb->s_blocksize));
+				     inode_sb(inode)->s_blocksize));
 	if (offset > limit)
 		goto out_unlock;
 	if (offset > limit - length)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 945de08af7ba..633c7cbc097a 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -60,7 +60,7 @@ DECLARE_EVENT_CLASS(xfs_attr_list_class,
 		__field(int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ctx->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ctx->dp))->s_dev;
 		__entry->ino = ctx->dp->i_ino;
 		__entry->hashval = ctx->cursor->hashval;
 		__entry->blkno = ctx->cursor->blkno;
@@ -186,7 +186,7 @@ TRACE_EVENT(xfs_attr_list_node_descend,
 		__field(u32, bt_before)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ctx->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ctx->dp))->s_dev;
 		__entry->ino = ctx->dp->i_ino;
 		__entry->hashval = ctx->cursor->hashval;
 		__entry->blkno = ctx->cursor->blkno;
@@ -240,7 +240,7 @@ DECLARE_EVENT_CLASS(xfs_bmap_class,
 
 		ifp = xfs_iext_state_to_fork(ip, state);
 		xfs_iext_get_extent(ifp, cur, &r);
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->leaf = cur->leaf;
 		__entry->pos = cur->pos;
@@ -515,7 +515,7 @@ DECLARE_EVENT_CLASS(xfs_filestream_class,
 		__field(int, streams)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->agno = agno;
 		__entry->streams = xfs_filestream_peek_ag(ip->i_mount, agno);
@@ -547,7 +547,7 @@ TRACE_EVENT(xfs_filestream_pick,
 		__field(int, nscan)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->agno = agno;
 		__entry->streams = xfs_filestream_peek_ag(ip->i_mount, agno);
@@ -574,7 +574,7 @@ DECLARE_EVENT_CLASS(xfs_lock_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lock_flags = lock_flags;
 		__entry->caller_ip = caller_ip;
@@ -604,7 +604,7 @@ DECLARE_EVENT_CLASS(xfs_inode_class,
 		__field(xfs_ino_t, ino)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 	),
 	TP_printk("dev %d:%d ino 0x%llx",
@@ -665,7 +665,7 @@ TRACE_EVENT(xfs_filemap_fault,
 		__field(bool, write_fault)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->pe_size = pe_size;
 		__entry->write_fault = write_fault;
@@ -691,7 +691,7 @@ DECLARE_EVENT_CLASS(xfs_iref_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->count = atomic_read(&VFS_I(ip)->i_count);
 		__entry->pincount = atomic_read(&ip->i_pincount);
@@ -717,7 +717,7 @@ TRACE_EVENT(xfs_iomap_prealloc_size,
 		__field(unsigned int, writeio_blocks)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->blocks = blocks;
 		__entry->shift = shift;
@@ -795,7 +795,7 @@ DECLARE_EVENT_CLASS(xfs_namespace_class,
 		__dynamic_array(char, name, name->len)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(dp))->s_dev;
 		__entry->dp_ino = dp->i_ino;
 		__entry->namelen = name->len;
 		memcpy(__get_str(name), name->name, name->len);
@@ -831,7 +831,7 @@ TRACE_EVENT(xfs_rename,
 		__dynamic_array(char, target_name, target_name->len)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(src_dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(src_dp))->s_dev;
 		__entry->src_dp_ino = src_dp->i_ino;
 		__entry->target_dp_ino = target_dp->i_ino;
 		__entry->src_namelen = src_name->len;
@@ -1132,7 +1132,7 @@ DECLARE_EVENT_CLASS(xfs_file_class,
 		__field(size_t, count)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->offset = offset;
@@ -1176,7 +1176,7 @@ DECLARE_EVENT_CLASS(xfs_page_class,
 
 		if (page_has_buffers(page))
 			xfs_count_page_state(page, &delalloc, &unwritten);
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = XFS_I(inode)->i_ino;
 		__entry->pgoff = page_offset(page);
 		__entry->size = i_size_read(inode);
@@ -1215,7 +1215,7 @@ DECLARE_EVENT_CLASS(xfs_readpage_class,
 		__field(int, nr_pages)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->nr_pages = nr_pages;
 	),
@@ -1248,7 +1248,7 @@ DECLARE_EVENT_CLASS(xfs_imap_class,
 		__field(xfs_filblks_t, blockcount)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->offset = offset;
@@ -1296,7 +1296,7 @@ DECLARE_EVENT_CLASS(xfs_simple_io_class,
 		__field(size_t, count)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->isize = VFS_I(ip)->i_size;
 		__entry->disize = ip->i_d.di_size;
@@ -1336,7 +1336,7 @@ DECLARE_EVENT_CLASS(xfs_itrunc_class,
 		__field(xfs_fsize_t, new_size)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->new_size = new_size;
@@ -1366,7 +1366,7 @@ TRACE_EVENT(xfs_pagecache_inval,
 		__field(xfs_off_t, finish)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->start = start;
@@ -1394,7 +1394,7 @@ TRACE_EVENT(xfs_bunmap,
 		__field(int, flags)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->size = ip->i_d.di_size;
 		__entry->bno = bno;
@@ -1682,7 +1682,7 @@ DECLARE_EVENT_CLASS(xfs_da_class,
 		__field(int, op_flags)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(args->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
 		__entry->ino = args->dp->i_ino;
 		if (args->namelen)
 			memcpy(__get_str(name), args->name, args->namelen);
@@ -1746,7 +1746,7 @@ DECLARE_EVENT_CLASS(xfs_attr_class,
 		__field(int, op_flags)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(args->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
 		__entry->ino = args->dp->i_ino;
 		if (args->namelen)
 			memcpy(__get_str(name), args->name, args->namelen);
@@ -1849,7 +1849,7 @@ DECLARE_EVENT_CLASS(xfs_dir2_space_class,
 		__field(int, idx)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(args->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
 		__entry->ino = args->dp->i_ino;
 		__entry->op_flags = args->op_flags;
 		__entry->idx = idx;
@@ -1882,7 +1882,7 @@ TRACE_EVENT(xfs_dir2_leafn_moveents,
 		__field(int, count)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(args->dp)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(args->dp))->s_dev;
 		__entry->ino = args->dp->i_ino;
 		__entry->op_flags = args->op_flags;
 		__entry->src_idx = src_idx;
@@ -1922,7 +1922,7 @@ DECLARE_EVENT_CLASS(xfs_swap_extent_class,
 		__field(int, fork_off)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->which = which;
 		__entry->ino = ip->i_ino;
 		__entry->format = ip->i_d.di_format;
@@ -2972,7 +2972,7 @@ DECLARE_EVENT_CLASS(xfs_inode_error_class,
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->error = error;
 		__entry->caller_ip = caller_ip;
@@ -3010,7 +3010,7 @@ DECLARE_EVENT_CLASS(xfs_double_io_class,
 		__field(loff_t, dest_offset)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(src)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(src))->s_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_isize = VFS_I(src)->i_size;
 		__entry->src_disize = src->i_d.di_size;
@@ -3055,7 +3055,7 @@ DECLARE_EVENT_CLASS(xfs_inode_irec_class,
 		__field(int, state)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = irec->br_startoff;
 		__entry->len = irec->br_blockcount;
@@ -3096,7 +3096,7 @@ TRACE_EVENT(xfs_reflink_remap_blocks_loop,
 		__field(xfs_fileoff_t, dest_lblk)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(src)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(src))->s_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_lblk = soffset;
 		__entry->len = len;
@@ -3124,7 +3124,7 @@ TRACE_EVENT(xfs_reflink_punch_range,
 		__field(xfs_extlen_t, len)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = lblk;
 		__entry->len = len;
@@ -3147,7 +3147,7 @@ TRACE_EVENT(xfs_reflink_remap,
 		__field(xfs_fsblock_t, new_pblk)
 	),
 	TP_fast_assign(
-		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->dev = inode_sb(VFS_I(ip))->s_dev;
 		__entry->ino = ip->i_ino;
 		__entry->lblk = lblk;
 		__entry->len = len;
@@ -3183,7 +3183,7 @@ TRACE_EVENT(xfs_ioctl_clone,
 		__field(loff_t, dest_isize)
 	),
 	TP_fast_assign(
-		__entry->dev = src->i_sb->s_dev;
+		__entry->dev = inode_sb(src)->s_dev;
 		__entry->src_ino = src->i_ino;
 		__entry->src_isize = i_size_read(src);
 		__entry->dest_ino = dest->i_ino;
-- 
2.15.1
