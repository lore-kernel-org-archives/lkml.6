Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756465AbeEHSkl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbeEHSE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:04:57 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 05/76] include: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:25 -0700
Message-Id: <20180508180436.716-6-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 include/linux/backing-dev.h      |   4 +-
 include/linux/cleancache.h       |   2 +-
 include/linux/fs.h               |  29 +++++-----
 include/linux/fscrypt_supp.h     |   4 +-
 include/linux/hugetlb.h          |   2 +-
 include/linux/nfs_fs.h           |   2 +-
 include/trace/events/btrfs.h     |  10 ++--
 include/trace/events/ext4.h      | 118 +++++++++++++++++++--------------------
 include/trace/events/f2fs.h      |  52 ++++++++---------
 include/trace/events/filelock.h  |   8 +--
 include/trace/events/filemap.h   |  12 ++--
 include/trace/events/fs_dax.h    |  14 ++---
 include/trace/events/jbd2.h      |   2 +-
 include/trace/events/writeback.h |   2 +-
 include/uapi/linux/iso_fs.h      |   4 +-
 15 files changed, 134 insertions(+), 131 deletions(-)

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 3e4ce54d84ab..0fb241c9324a 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -157,7 +157,7 @@ static inline struct backing_dev_info *inode_to_bdi(struct inode *inode)
 	if (!inode)
 		return &noop_backing_dev_info;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 #ifdef CONFIG_BLOCK
 	if (sb_is_blkdev_sb(sb))
 		return I_BDEV(inode)->bd_bdi;
@@ -251,7 +251,7 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 		bdi_cap_account_dirty(bdi) &&
 		(bdi->capabilities & BDI_CAP_CGROUP_WRITEBACK) &&
-		(inode->i_sb->s_iflags & SB_I_CGROUPWB);
+		(inode_sb(inode)->s_iflags & SB_I_CGROUPWB);
 }
 
 /**
diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
index 5f5730c1d324..74f89782f70e 100644
--- a/include/linux/cleancache.h
+++ b/include/linux/cleancache.h
@@ -51,7 +51,7 @@ extern void __cleancache_invalidate_fs(struct super_block *);
 #define cleancache_enabled (1)
 static inline bool cleancache_fs_enabled_mapping(struct address_space *mapping)
 {
-	return mapping->host->i_sb->cleancache_poolid >= 0;
+	return inode_sb(mapping->host)->cleancache_poolid >= 0;
 }
 static inline bool cleancache_fs_enabled(struct page *page)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4561cb9156d4..5d4bb19b2a43 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1475,22 +1475,22 @@ struct super_block {
  */
 static inline uid_t i_uid_read(const struct inode *inode)
 {
-	return from_kuid(inode->i_sb->s_user_ns, inode->i_uid);
+	return from_kuid(inode_sb(inode)->s_user_ns, inode->i_uid);
 }
 
 static inline gid_t i_gid_read(const struct inode *inode)
 {
-	return from_kgid(inode->i_sb->s_user_ns, inode->i_gid);
+	return from_kgid(inode_sb(inode)->s_user_ns, inode->i_gid);
 }
 
 static inline void i_uid_write(struct inode *inode, uid_t uid)
 {
-	inode->i_uid = make_kuid(inode->i_sb->s_user_ns, uid);
+	inode->i_uid = make_kuid(inode_sb(inode)->s_user_ns, uid);
 }
 
 static inline void i_gid_write(struct inode *inode, gid_t gid)
 {
-	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
+	inode->i_gid = make_kgid(inode_sb(inode)->s_user_ns, gid);
 }
 
 extern struct timespec current_time(struct inode *inode);
@@ -1899,10 +1899,10 @@ struct super_operations {
  * i_flags updated.  Hence, i_flags no longer inherit the superblock mount
  * flags, so these have to be checked separately. -- rmk@arm.uk.linux.org
  */
-#define __IS_FLG(inode, flg)	((inode)->i_sb->s_flags & (flg))
+#define __IS_FLG(inode, flg)	(inode_sb((inode))->s_flags & (flg))
 
 static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags & SB_RDONLY; }
-#define IS_RDONLY(inode)	sb_rdonly((inode)->i_sb)
+#define IS_RDONLY(inode)	sb_rdonly(inode_sb((inode)))
 #define IS_SYNC(inode)		(__IS_FLG(inode, SB_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, SB_SYNCHRONOUS|SB_DIRSYNC) || \
@@ -2725,21 +2725,22 @@ static inline void file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+	__sb_start_write(inode_sb(file_inode(file)), SB_FREEZE_WRITE, true);
 }
 
 static inline bool file_start_write_trylock(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return true;
-	return __sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, false);
+	return __sb_start_write(inode_sb(file_inode(file)), SB_FREEZE_WRITE,
+				false);
 }
 
 static inline void file_end_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return;
-	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode_sb(file_inode(file)), SB_FREEZE_WRITE);
 }
 
 static inline int do_clone_file_range(struct file *file_in, loff_t pos_in,
@@ -3018,8 +3019,10 @@ static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
 					 struct iov_iter *iter,
 					 get_block_t get_block)
 {
-	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
-			get_block, NULL, NULL, DIO_LOCKING | DIO_SKIP_HOLES);
+	return __blockdev_direct_IO(iocb, inode, inode_sb(inode)->s_bdev,
+				    iter,
+				    get_block, NULL, NULL,
+				    DIO_LOCKING | DIO_SKIP_HOLES);
 }
 #endif
 
@@ -3370,13 +3373,13 @@ static inline int check_sticky(struct inode *dir, struct inode *inode)
 
 static inline void inode_has_no_xattr(struct inode *inode)
 {
-	if (!is_sxid(inode->i_mode) && (inode->i_sb->s_flags & SB_NOSEC))
+	if (!is_sxid(inode->i_mode) && (inode_sb(inode)->s_flags & SB_NOSEC))
 		inode->i_flags |= S_NOSEC;
 }
 
 static inline bool is_root_inode(struct inode *inode)
 {
-	return inode == inode->i_sb->s_root->d_inode;
+	return inode == inode_sb(inode)->s_root->d_inode;
 }
 
 static inline bool dir_emit(struct dir_context *ctx,
diff --git a/include/linux/fscrypt_supp.h b/include/linux/fscrypt_supp.h
index 477a7a6504d2..01e75d7e5ec8 100644
--- a/include/linux/fscrypt_supp.h
+++ b/include/linux/fscrypt_supp.h
@@ -54,8 +54,8 @@ static inline bool fscrypt_has_encryption_key(const struct inode *inode)
 
 static inline bool fscrypt_dummy_context_enabled(struct inode *inode)
 {
-	return inode->i_sb->s_cop->dummy_context &&
-		inode->i_sb->s_cop->dummy_context(inode);
+	return inode_sb(inode)->s_cop->dummy_context &&
+			inode_sb(inode)->s_cop->dummy_context(inode);
 }
 
 /* crypto.c */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 36fa6a2a82e3..91036dfbfe78 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -382,7 +382,7 @@ extern unsigned int default_hstate_idx;
 
 static inline struct hstate *hstate_inode(struct inode *i)
 {
-	return HUGETLBFS_SB(i->i_sb)->hstate;
+	return HUGETLBFS_SB(inode_sb(i))->hstate;
 }
 
 static inline struct hstate *hstate_file(struct file *f)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 38187c68063d..0d3dddba4d5d 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -238,7 +238,7 @@ static inline struct nfs_fh *NFS_FH(const struct inode *inode)
 
 static inline struct nfs_server *NFS_SERVER(const struct inode *inode)
 {
-	return NFS_SB(inode->i_sb);
+	return NFS_SB(inode_sb(inode));
 }
 
 static inline struct rpc_clnt *NFS_CLIENT(const struct inode *inode)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index c3ac5ec86519..d8d8823c635a 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(btrfs__inode,
 		__field(	u64,  root_objectid		)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+	TP_fast_assign_btrfs(btrfs_sb(inode_sb(inode)),
 		__entry->ino	= inode->i_ino;
 		__entry->blocks	= inode->i_blocks;
 		__entry->disk_i_size  = BTRFS_I(inode)->disk_i_size;
@@ -415,7 +415,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
 		__field(	u64,  truncated_len	)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+	TP_fast_assign_btrfs(btrfs_sb(inode_sb(inode)),
 		__entry->ino 		= inode->i_ino;
 		__entry->file_offset	= ordered->file_offset;
 		__entry->start		= ordered->start;
@@ -500,7 +500,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 		__field(	u64,    root_objectid		)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+	TP_fast_assign_btrfs(btrfs_sb(inode_sb(inode)),
 		__entry->ino		= inode->i_ino;
 		__entry->index		= page->index;
 		__entry->nr_to_write	= wbc->nr_to_write;
@@ -551,7 +551,7 @@ TRACE_EVENT(btrfs_writepage_end_io_hook,
 		__field(	u64,    root_objectid	)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(page->mapping->host->i_sb),
+	TP_fast_assign_btrfs(btrfs_sb(inode_sb(page->mapping->host)),
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->index	= page->index;
 		__entry->start	= start;
@@ -1442,7 +1442,7 @@ DECLARE_EVENT_CLASS(btrfs__qgroup_rsv_data,
 		__field(	int,		op		)
 	),
 
-	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+	TP_fast_assign_btrfs(btrfs_sb(inode_sb(inode)),
 		__entry->rootid		= BTRFS_I(inode)->root->objectid;
 		__entry->ino		= inode->i_ino;
 		__entry->start		= start;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 4d0e3af4e561..89943e59ae36 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -91,7 +91,7 @@ TRACE_EVENT(ext4_other_inode_update_time,
 
 	TP_fast_assign(
 		__entry->orig_ino = orig_ino;
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->uid	= i_uid_read(inode);
 		__entry->gid	= i_gid_read(inode);
@@ -120,7 +120,7 @@ TRACE_EVENT(ext4_free_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->uid	= i_uid_read(inode);
 		__entry->gid	= i_gid_read(inode);
@@ -146,7 +146,7 @@ TRACE_EVENT(ext4_request_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= dir->i_sb->s_dev;
+		__entry->dev	= inode_sb(dir)->s_dev;
 		__entry->dir	= dir->i_ino;
 		__entry->mode	= mode;
 	),
@@ -169,7 +169,7 @@ TRACE_EVENT(ext4_allocate_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->dir	= dir->i_ino;
 		__entry->mode	= mode;
@@ -193,7 +193,7 @@ TRACE_EVENT(ext4_evict_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nlink	= inode->i_nlink;
 	),
@@ -215,7 +215,7 @@ TRACE_EVENT(ext4_drop_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->drop	= drop;
 	),
@@ -237,7 +237,7 @@ TRACE_EVENT(ext4_mark_inode_dirty,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->ip	= IP;
 	),
@@ -259,7 +259,7 @@ TRACE_EVENT(ext4_begin_ordered_truncate,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->new_size	= new_size;
 	),
@@ -286,7 +286,7 @@ DECLARE_EVENT_CLASS(ext4__write_begin,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -330,7 +330,7 @@ DECLARE_EVENT_CLASS(ext4__write_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -386,7 +386,7 @@ TRACE_EVENT(ext4_writepages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
@@ -424,7 +424,7 @@ TRACE_EVENT(ext4_da_write_pages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->first_page	= first_page;
 		__entry->nr_to_write	= wbc->nr_to_write;
@@ -452,7 +452,7 @@ TRACE_EVENT(ext4_da_write_pages_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->lblk		= map->m_lblk;
 		__entry->len		= map->m_len;
@@ -482,7 +482,7 @@ TRACE_EVENT(ext4_writepages_result,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->ret		= ret;
 		__entry->pages_written	= pages_written;
@@ -513,7 +513,7 @@ DECLARE_EVENT_CLASS(ext4__page_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->index	= page->index;
 	),
@@ -559,7 +559,7 @@ DECLARE_EVENT_CLASS(ext4_invalidatepage_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->index	= page->index;
 		__entry->offset	= offset;
@@ -669,7 +669,7 @@ TRACE_EVENT(ext4_mb_release_inode_pa,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= pa->pa_inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(pa->pa_inode)->s_dev;
 		__entry->ino		= pa->pa_inode->i_ino;
 		__entry->block		= block;
 		__entry->count		= count;
@@ -716,7 +716,7 @@ TRACE_EVENT(ext4_discard_preallocations,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 	),
 
@@ -765,7 +765,7 @@ TRACE_EVENT(ext4_request_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= ar->inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(ar->inode)->s_dev;
 		__entry->ino	= ar->inode->i_ino;
 		__entry->len	= ar->len;
 		__entry->logical = ar->logical;
@@ -806,7 +806,7 @@ TRACE_EVENT(ext4_allocate_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= ar->inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(ar->inode)->s_dev;
 		__entry->ino	= ar->inode->i_ino;
 		__entry->block	= block;
 		__entry->len	= ar->len;
@@ -844,7 +844,7 @@ TRACE_EVENT(ext4_free_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->block		= block;
 		__entry->count		= count;
@@ -898,7 +898,7 @@ TRACE_EVENT(ext4_sync_file_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->ret		= ret;
 	),
@@ -942,7 +942,7 @@ TRACE_EVENT(ext4_alloc_da_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 	),
@@ -982,7 +982,7 @@ TRACE_EVENT(ext4_mballoc_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= ac->ac_inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(ac->ac_inode)->s_dev;
 		__entry->ino		= ac->ac_inode->i_ino;
 		__entry->orig_logical	= ac->ac_o_ex.fe_logical;
 		__entry->orig_start	= ac->ac_o_ex.fe_start;
@@ -1039,7 +1039,7 @@ TRACE_EVENT(ext4_mballoc_prealloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= ac->ac_inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(ac->ac_inode)->s_dev;
 		__entry->ino		= ac->ac_inode->i_ino;
 		__entry->orig_logical	= ac->ac_o_ex.fe_logical;
 		__entry->orig_start	= ac->ac_o_ex.fe_start;
@@ -1128,7 +1128,7 @@ TRACE_EVENT(ext4_forget,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->block	= block;
 		__entry->is_metadata = is_metadata;
@@ -1157,7 +1157,7 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->used_blocks = used_blocks;
@@ -1190,7 +1190,7 @@ TRACE_EVENT(ext4_da_reserve_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
@@ -1220,7 +1220,7 @@ TRACE_EVENT(ext4_da_release_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
 		__entry->freed_blocks = freed_blocks;
@@ -1299,7 +1299,7 @@ TRACE_EVENT(ext4_direct_IO_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -1328,7 +1328,7 @@ TRACE_EVENT(ext4_direct_IO_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -1357,7 +1357,7 @@ DECLARE_EVENT_CLASS(ext4__fallocate_mode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
@@ -1407,7 +1407,7 @@ TRACE_EVENT(ext4_fallocate_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->blocks	= max_blocks;
@@ -1481,7 +1481,7 @@ DECLARE_EVENT_CLASS(ext4__truncate,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode->i_sb->s_dev;
+		__entry->dev    = inode_sb(inode)->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->blocks	= inode->i_blocks;
 	),
@@ -1523,7 +1523,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_len		= map->m_len;
@@ -1564,7 +1564,7 @@ TRACE_EVENT(ext4_ext_convert_to_initialized_fastpath,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_len		= map->m_len;
@@ -1601,7 +1601,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode->i_sb->s_dev;
+		__entry->dev    = inode_sb(inode)->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -1646,7 +1646,7 @@ DECLARE_EVENT_CLASS(ext4__map_blocks_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode->i_sb->s_dev;
+		__entry->dev    = inode_sb(inode)->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->flags	= flags;
 		__entry->pblk	= map->m_pblk;
@@ -1691,7 +1691,7 @@ TRACE_EVENT(ext4_ext_load_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev    = inode->i_sb->s_dev;
+		__entry->dev    = inode_sb(inode)->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->pblk	= pblk;
 		__entry->lblk	= lblk;
@@ -1714,7 +1714,7 @@ TRACE_EVENT(ext4_load_inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 	),
 
@@ -1837,7 +1837,7 @@ TRACE_EVENT(ext4_ext_handle_unwritten_extents,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->flags		= flags;
 		__entry->lblk		= map->m_lblk;
@@ -1901,7 +1901,7 @@ TRACE_EVENT(ext4_ext_put_in_cache,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -1929,7 +1929,7 @@ TRACE_EVENT(ext4_ext_in_cache,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->ret	= ret;
@@ -1960,7 +1960,7 @@ TRACE_EVENT(ext4_find_delalloc_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->from		= from;
 		__entry->to		= to;
@@ -1991,7 +1991,7 @@ TRACE_EVENT(ext4_get_reserved_cluster_alloc,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -2019,7 +2019,7 @@ TRACE_EVENT(ext4_ext_show_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pblk	= pblk;
 		__entry->lblk	= lblk;
@@ -2053,7 +2053,7 @@ TRACE_EVENT(ext4_remove_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->from		= from;
 		__entry->to		= to;
@@ -2093,7 +2093,7 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->partial	= partial_cluster;
 		__entry->start		= start;
@@ -2125,7 +2125,7 @@ TRACE_EVENT(ext4_ext_rm_idx,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pblk	= pblk;
 	),
@@ -2151,7 +2151,7 @@ TRACE_EVENT(ext4_ext_remove_space,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->start	= start;
 		__entry->end	= end;
@@ -2183,7 +2183,7 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->start		= start;
 		__entry->end		= end;
@@ -2218,7 +2218,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2258,7 +2258,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
@@ -2282,7 +2282,7 @@ TRACE_EVENT(ext4_es_find_delayed_extent_range_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 	),
@@ -2307,7 +2307,7 @@ TRACE_EVENT(ext4_es_find_delayed_extent_range_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2334,7 +2334,7 @@ TRACE_EVENT(ext4_es_lookup_extent_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 	),
@@ -2361,7 +2361,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= es->es_lblk;
 		__entry->len	= es->es_len;
@@ -2447,7 +2447,7 @@ TRACE_EVENT(ext4_collapse_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
@@ -2472,7 +2472,7 @@ TRACE_EVENT(ext4_insert_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->offset	= offset;
 		__entry->len	= len;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 06c87f9f720c..8e958dd92412 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pino	= F2FS_I(inode)->i_pino;
 		__entry->mode	= inode->i_mode;
@@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(f2fs__inode_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->ret	= ret;
 	),
@@ -237,7 +237,7 @@ TRACE_EVENT(f2fs_sync_file_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->cp_reason	= cp_reason;
 		__entry->datasync	= datasync;
@@ -319,7 +319,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= dir->i_sb->s_dev;
+		__entry->dev	= inode_sb(dir)->s_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->size	= dir->i_size;
 		__entry->blocks	= dir->i_blocks;
@@ -370,7 +370,7 @@ TRACE_EVENT(f2fs_truncate_data_blocks_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nid	= nid;
 		__entry->ofs	= ofs;
@@ -399,7 +399,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->size	= inode->i_size;
 		__entry->blocks	= inode->i_blocks;
@@ -456,7 +456,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_node,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->nid		= nid;
 		__entry->blk_addr	= blk_addr;
@@ -504,7 +504,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->nid[0]	= nid[0];
 		__entry->nid[1]	= nid[1];
@@ -538,7 +538,7 @@ TRACE_EVENT(f2fs_map_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
@@ -756,7 +756,7 @@ TRACE_EVENT(f2fs_lookup_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= dir->i_sb->s_dev;
+		__entry->dev	= inode_sb(dir)->s_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->name	= dentry->d_name.name;
 		__entry->flags	= flags;
@@ -784,7 +784,7 @@ TRACE_EVENT(f2fs_lookup_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= dir->i_sb->s_dev;
+		__entry->dev	= inode_sb(dir)->s_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->name	= dentry->d_name.name;
 		__entry->cino	= ino;
@@ -813,7 +813,7 @@ TRACE_EVENT(f2fs_readdir,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= dir->i_sb->s_dev;
+		__entry->dev	= inode_sb(dir)->s_dev;
 		__entry->ino	= dir->i_ino;
 		__entry->start	= start_pos;
 		__entry->end	= end_pos;
@@ -846,7 +846,7 @@ TRACE_EVENT(f2fs_fallocate,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->mode	= mode;
 		__entry->offset	= offset;
@@ -882,7 +882,7 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -913,7 +913,7 @@ TRACE_EVENT(f2fs_direct_IO_exit,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= offset;
 		__entry->len	= len;
@@ -945,7 +945,7 @@ TRACE_EVENT(f2fs_reserve_new_blocks,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->nid	= nid;
 		__entry->ofs_in_node = ofs_in_node;
 		__entry->count = count;
@@ -977,7 +977,7 @@ DECLARE_EVENT_CLASS(f2fs__submit_page_bio,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= page->mapping->host->i_sb->s_dev;
+		__entry->dev		= inode_sb(page->mapping->host)->s_dev;
 		__entry->ino		= page->mapping->host->i_ino;
 		__entry->index		= page->index;
 		__entry->old_blkaddr	= fio->old_blkaddr;
@@ -1104,7 +1104,7 @@ TRACE_EVENT(f2fs_write_begin,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -1134,7 +1134,7 @@ TRACE_EVENT(f2fs_write_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->pos	= pos;
 		__entry->len	= len;
@@ -1165,7 +1165,7 @@ DECLARE_EVENT_CLASS(f2fs__page,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= page->mapping->host->i_sb->s_dev;
+		__entry->dev	= inode_sb(page->mapping->host)->s_dev;
 		__entry->ino	= page->mapping->host->i_ino;
 		__entry->type	= type;
 		__entry->dir	= S_ISDIR(page->mapping->host->i_mode);
@@ -1259,7 +1259,7 @@ TRACE_EVENT(f2fs_writepages,
 	),
 
 	TP_fast_assign(
-		__entry->dev		= inode->i_sb->s_dev;
+		__entry->dev		= inode_sb(inode)->s_dev;
 		__entry->ino		= inode->i_ino;
 		__entry->type		= type;
 		__entry->dir		= S_ISDIR(inode->i_mode);
@@ -1311,7 +1311,7 @@ TRACE_EVENT(f2fs_readpages,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->start	= page->index;
 		__entry->nrpage	= nrpage;
@@ -1454,7 +1454,7 @@ TRACE_EVENT(f2fs_lookup_extent_tree_start,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 	),
@@ -1483,7 +1483,7 @@ TRACE_EVENT_CONDITION(f2fs_lookup_extent_tree_end,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->fofs = ei->fofs;
@@ -1516,7 +1516,7 @@ TRACE_EVENT(f2fs_update_extent_tree_range,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgofs = pgofs;
 		__entry->blk = blkaddr;
@@ -1569,7 +1569,7 @@ TRACE_EVENT(f2fs_destroy_extent_tree,
 	),
 
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->node_cnt = node_cnt;
 	),
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index d1faf3597b9d..522d2740a56f 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -48,7 +48,7 @@ TRACE_EVENT(locks_get_lock_context,
 	),
 
 	TP_fast_assign(
-		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->s_dev = inode_sb(inode)->s_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->type = type;
 		__entry->ctx = ctx;
@@ -80,7 +80,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
 
 	TP_fast_assign(
 		__entry->fl = fl ? fl : NULL;
-		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->s_dev = inode_sb(inode)->s_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->fl_next = fl ? fl->fl_next : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
@@ -132,7 +132,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
 
 	TP_fast_assign(
 		__entry->fl = fl ? fl : NULL;
-		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->s_dev = inode_sb(inode)->s_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->fl_next = fl ? fl->fl_next : NULL;
 		__entry->fl_owner = fl ? fl->fl_owner : NULL;
@@ -182,7 +182,7 @@ TRACE_EVENT(generic_add_lease,
 	),
 
 	TP_fast_assign(
-		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->s_dev = inode_sb(inode)->s_dev;
 		__entry->i_ino = inode->i_ino;
 		__entry->wcount = atomic_read(&inode->i_writecount);
 		__entry->dcount = d_count(fl->fl_file->f_path.dentry);
diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
index ee05db7ee8d2..0517759b4b8f 100644
--- a/include/trace/events/filemap.h
+++ b/include/trace/events/filemap.h
@@ -30,8 +30,8 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
 		__entry->pfn = page_to_pfn(page);
 		__entry->i_ino = page->mapping->host->i_ino;
 		__entry->index = page->index;
-		if (page->mapping->host->i_sb)
-			__entry->s_dev = page->mapping->host->i_sb->s_dev;
+		if (inode_sb(page->mapping->host))
+			__entry->s_dev = inode_sb(page->mapping->host)->s_dev;
 		else
 			__entry->s_dev = page->mapping->host->i_rdev;
 	),
@@ -68,8 +68,8 @@ TRACE_EVENT(filemap_set_wb_err,
 		TP_fast_assign(
 			__entry->i_ino = mapping->host->i_ino;
 			__entry->errseq = eseq;
-			if (mapping->host->i_sb)
-				__entry->s_dev = mapping->host->i_sb->s_dev;
+			if (inode_sb(mapping->host))
+				__entry->s_dev = inode_sb(mapping->host)->s_dev;
 			else
 				__entry->s_dev = mapping->host->i_rdev;
 		),
@@ -95,9 +95,9 @@ TRACE_EVENT(file_check_and_advance_wb_err,
 		TP_fast_assign(
 			__entry->file = file;
 			__entry->i_ino = file->f_mapping->host->i_ino;
-			if (file->f_mapping->host->i_sb)
+			if (inode_sb(file->f_mapping->host))
 				__entry->s_dev =
-					file->f_mapping->host->i_sb->s_dev;
+					inode_sb(file->f_mapping->host)->s_dev;
 			else
 				__entry->s_dev =
 					file->f_mapping->host->i_rdev;
diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
index 97b09fcf7e52..d3173cae131d 100644
--- a/include/trace/events/fs_dax.h
+++ b/include/trace/events/fs_dax.h
@@ -24,7 +24,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
 		__field(int, result)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_start = vmf->vma->vm_start;
 		__entry->vm_end = vmf->vma->vm_end;
@@ -74,7 +74,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -117,7 +117,7 @@ DECLARE_EVENT_CLASS(dax_pmd_insert_mapping_class,
 		__field(int, write)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -163,7 +163,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
 		__field(int, result)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -206,7 +206,7 @@ TRACE_EVENT(dax_insert_mapping,
 		__field(int, write)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->vm_flags = vmf->vma->vm_flags;
 		__entry->address = vmf->address;
@@ -234,7 +234,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->start_index = start_index;
 		__entry->end_index = end_index;
@@ -266,7 +266,7 @@ TRACE_EVENT(dax_writeback_one,
 		__field(dev_t, dev)
 	),
 	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
+		__entry->dev = inode_sb(inode)->s_dev;
 		__entry->ino = inode->i_ino;
 		__entry->pgoff = pgoff;
 		__entry->pglen = pglen;
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..95e0cb226d30 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -124,7 +124,7 @@ TRACE_EVENT(jbd2_submit_inode_data,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 	),
 
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 32db72c7c055..d5ae5ea65bc4 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -710,7 +710,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
+		__entry->dev	= inode_sb(inode)->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->state	= inode->i_state;
 		__entry->mode	= inode->i_mode;
diff --git a/include/uapi/linux/iso_fs.h b/include/uapi/linux/iso_fs.h
index a2555176f6d1..36aee6068b4a 100644
--- a/include/uapi/linux/iso_fs.h
+++ b/include/uapi/linux/iso_fs.h
@@ -160,7 +160,7 @@ struct iso_directory_record {
 #define ISOFS_BLOCK_BITS 11
 #define ISOFS_BLOCK_SIZE 2048
 
-#define ISOFS_BUFFER_SIZE(INODE) ((INODE)->i_sb->s_blocksize)
-#define ISOFS_BUFFER_BITS(INODE) ((INODE)->i_sb->s_blocksize_bits)
+#define ISOFS_BUFFER_SIZE(INODE) (inode_sb((INODE))->s_blocksize)
+#define ISOFS_BUFFER_BITS(INODE) (inode_sb((INODE))->s_blocksize_bits)
 
 #endif /* _ISOFS_FS_H */
-- 
2.15.1
