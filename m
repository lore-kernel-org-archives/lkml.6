Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933296AbeEHSY1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:24:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755211AbeEHSGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:07 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 54/76] fs/ocfs2: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:14 -0700
Message-Id: <20180508180436.716-55-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ocfs2/acl.c          |  10 +-
 fs/ocfs2/alloc.c        |  47 +++----
 fs/ocfs2/aops.c         |  85 ++++++------
 fs/ocfs2/dcache.c       |   2 +-
 fs/ocfs2/dir.c          | 127 +++++++++---------
 fs/ocfs2/dlmfs/dlmfs.c  |   2 +-
 fs/ocfs2/dlmglue.c      |  62 ++++-----
 fs/ocfs2/export.c       |   2 +-
 fs/ocfs2/extent_map.c   |  48 +++----
 fs/ocfs2/file.c         |  93 ++++++-------
 fs/ocfs2/inode.c        |  30 ++---
 fs/ocfs2/inode.h        |   2 +-
 fs/ocfs2/ioctl.c        |  22 ++--
 fs/ocfs2/journal.c      |   5 +-
 fs/ocfs2/journal.h      |   4 +-
 fs/ocfs2/localalloc.c   |   2 +-
 fs/ocfs2/locks.c        |   4 +-
 fs/ocfs2/mmap.c         |   4 +-
 fs/ocfs2/move_extents.c |  47 +++----
 fs/ocfs2/namei.c        |  24 ++--
 fs/ocfs2/ocfs2.h        |   2 +-
 fs/ocfs2/quota_global.c |   2 +-
 fs/ocfs2/quota_local.c  |  12 +-
 fs/ocfs2/refcounttree.c | 117 +++++++++--------
 fs/ocfs2/resize.c       |  27 ++--
 fs/ocfs2/slot_map.c     |   2 +-
 fs/ocfs2/suballoc.c     |  71 +++++-----
 fs/ocfs2/suballoc.h     |   2 +-
 fs/ocfs2/symlink.c      |   2 +-
 fs/ocfs2/xattr.c        | 339 ++++++++++++++++++++++++------------------------
 30 files changed, 620 insertions(+), 578 deletions(-)

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 917fadca8a7b..20bd414b4cfd 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -181,7 +181,7 @@ static int ocfs2_acl_set_mode(struct inode *inode, struct buffer_head *di_bh,
 		get_bh(di_bh);
 
 	if (handle == NULL) {
-		handle = ocfs2_start_trans(OCFS2_SB(inode->i_sb),
+		handle = ocfs2_start_trans(OCFS2_SB(inode_sb(inode)),
 					   OCFS2_INODE_UPDATE_CREDITS);
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
@@ -211,7 +211,7 @@ static int ocfs2_acl_set_mode(struct inode *inode, struct buffer_head *di_bh,
 
 out_commit:
 	if (commit_handle)
-		ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
+		ocfs2_commit_trans(OCFS2_SB(inode_sb(inode)), handle);
 out_brelse:
 	brelse(di_bh);
 out:
@@ -303,7 +303,7 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type)
 	int had_lock;
 	struct ocfs2_lock_holder oh;
 
-	osb = OCFS2_SB(inode->i_sb);
+	osb = OCFS2_SB(inode_sb(inode));
 	if (!(osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL))
 		return NULL;
 
@@ -322,7 +322,7 @@ struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type)
 
 int ocfs2_acl_chmod(struct inode *inode, struct buffer_head *bh)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct posix_acl *acl;
 	int ret;
 
@@ -358,7 +358,7 @@ int ocfs2_init_acl(handle_t *handle,
 		   struct ocfs2_alloc_context *meta_ac,
 		   struct ocfs2_alloc_context *data_ac)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct posix_acl *acl = NULL;
 	int ret = 0, ret2;
 	umode_t mode;
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index 9a876bb07cac..10fd4f40d202 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -232,7 +232,7 @@ static int ocfs2_dinode_insert_check(struct ocfs2_extent_tree *et,
 				     struct ocfs2_extent_rec *rec)
 {
 	struct ocfs2_inode_info *oi = cache_info_to_inode(et->et_ci);
-	struct ocfs2_super *osb = OCFS2_SB(oi->vfs_inode.i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(&oi->vfs_inode));
 
 	BUG_ON(oi->ip_dyn_features & OCFS2_INLINE_DATA_FL);
 	mlog_bug_on_msg(!ocfs2_sparse_alloc(osb) &&
@@ -5275,8 +5275,9 @@ int ocfs2_mark_extent_written(struct inode *inode,
 		(unsigned long long)OCFS2_I(inode)->ip_blkno,
 		cpos, len, phys);
 
-	if (!ocfs2_writes_unwritten_extents(OCFS2_SB(inode->i_sb))) {
-		ocfs2_error(inode->i_sb, "Inode %llu has unwritten extents that are being written to, but the feature bit is not set in the super block\n",
+	if (!ocfs2_writes_unwritten_extents(OCFS2_SB(inode_sb(inode)))) {
+		ocfs2_error(inode_sb(inode),
+			    "Inode %llu has unwritten extents that are being written to, but the feature bit is not set in the super block\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno);
 		ret = -EROFS;
 		goto out;
@@ -5687,7 +5688,7 @@ static int ocfs2_reserve_blocks_for_rec_trunc(struct inode *inode,
 {
 	int ret = 0, num_free_extents;
 	unsigned int max_recs_needed = 2 * extents_to_split;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	*ac = NULL;
 
@@ -5729,8 +5730,8 @@ int ocfs2_remove_btree_range(struct inode *inode,
 			     u64 refcount_loc, bool refcount_tree_locked)
 {
 	int ret, credits = 0, extra_blocks = 0;
-	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	u64 phys_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), phys_cpos);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *tl_inode = osb->osb_tl_inode;
 	handle_t *handle;
 	struct ocfs2_alloc_context *meta_ac = NULL;
@@ -5793,7 +5794,7 @@ int ocfs2_remove_btree_range(struct inode *inode,
 	}
 
 	dquot_free_space_nodirty(inode,
-				  ocfs2_clusters_to_bytes(inode->i_sb, len));
+				  ocfs2_clusters_to_bytes(inode_sb(inode), len));
 
 	ret = ocfs2_remove_extent(handle, et, cpos, len, meta_ac, dealloc);
 	if (ret) {
@@ -5984,8 +5985,8 @@ static int ocfs2_replay_truncate_records(struct ocfs2_super *osb,
 		ocfs2_journal_dirty(handle, tl_bh);
 
 		rec = tl->tl_recs[i];
-		start_blk = ocfs2_clusters_to_blocks(data_alloc_inode->i_sb,
-						    le32_to_cpu(rec.t_start));
+		start_blk = ocfs2_clusters_to_blocks(inode_sb(data_alloc_inode),
+						     le32_to_cpu(rec.t_start));
 		num_clusters = le32_to_cpu(rec.t_clusters);
 
 		/* if start_blk is not set, we ignore the record as
@@ -6861,7 +6862,7 @@ static void ocfs2_zero_cluster_pages(struct inode *inode, loff_t start,
 	int i;
 	struct page *page;
 	unsigned int from, to = PAGE_SIZE;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	BUG_ON(!ocfs2_sparse_alloc(OCFS2_SB(sb)));
 
@@ -6929,7 +6930,7 @@ int ocfs2_grab_pages(struct inode *inode, loff_t start, loff_t end,
 static int ocfs2_grab_eof_pages(struct inode *inode, loff_t start, loff_t end,
 				struct page **pages, int *num)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	BUG_ON(start >> OCFS2_SB(sb)->s_clustersize_bits !=
 	       (end - 1) >> OCFS2_SB(sb)->s_clustersize_bits);
@@ -6953,7 +6954,7 @@ int ocfs2_zero_range_for_truncate(struct inode *inode, handle_t *handle,
 	struct page **pages = NULL;
 	u64 phys;
 	unsigned int ext_flags;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	/*
 	 * File systems which don't support sparse files zero on every
@@ -7017,7 +7018,7 @@ int ocfs2_zero_range_for_truncate(struct inode *inode, handle_t *handle,
 static void ocfs2_zero_dinode_id2_with_xattr(struct inode *inode,
 					     struct ocfs2_dinode *di)
 {
-	unsigned int blocksize = 1 << inode->i_sb->s_blocksize_bits;
+	unsigned int blocksize = 1 << inode_sb(inode)->s_blocksize_bits;
 	unsigned int xattrsize = le16_to_cpu(di->i_xattr_inline_size);
 
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_XATTR_FL)
@@ -7036,7 +7037,7 @@ void ocfs2_dinode_new_extent_list(struct inode *inode,
 	di->id2.i_list.l_tree_depth = 0;
 	di->id2.i_list.l_next_free_rec = 0;
 	di->id2.i_list.l_count = cpu_to_le16(
-		ocfs2_extent_recs_per_inode_with_xattr(inode->i_sb, di));
+		ocfs2_extent_recs_per_inode_with_xattr(inode_sb(inode), di));
 }
 
 void ocfs2_set_inode_data_inline(struct inode *inode, struct ocfs2_dinode *di)
@@ -7056,7 +7057,7 @@ void ocfs2_set_inode_data_inline(struct inode *inode, struct ocfs2_dinode *di)
 	ocfs2_zero_dinode_id2_with_xattr(inode, di);
 
 	idata->id_count = cpu_to_le16(
-			ocfs2_max_inline_data_with_xattr(inode->i_sb, di));
+			ocfs2_max_inline_data_with_xattr(inode_sb(inode), di));
 }
 
 int ocfs2_convert_inline_data_to_extents(struct inode *inode,
@@ -7068,7 +7069,7 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	handle_t *handle;
 	u64 uninitialized_var(block);
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_alloc_context *data_ac = NULL;
 	struct page **pages = NULL;
@@ -7132,7 +7133,8 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 		 * Save two copies, one for insert, and one that can
 		 * be changed by ocfs2_map_and_dirty_page() below.
 		 */
-		block = phys = ocfs2_clusters_to_blocks(inode->i_sb, bit_off);
+		block = phys = ocfs2_clusters_to_blocks(inode_sb(inode),
+							bit_off);
 
 		/*
 		 * Non sparse file systems zero on extend, so no need
@@ -7303,7 +7305,7 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
 	 */
 	el = path_leaf_el(path);
 	if (le16_to_cpu(el->l_next_free_rec) == 0) {
-		ocfs2_error(inode->i_sb,
+		ocfs2_error(inode_sb(inode),
 			    "Inode %llu has empty extent block at %llu\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    (unsigned long long)path_leaf_bh(path)->b_blocknr);
@@ -7355,7 +7357,8 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
 		trunc_len = range - new_highest_cpos;
 		coff = new_highest_cpos - le32_to_cpu(rec->e_cpos);
 		blkno = le64_to_cpu(rec->e_blkno) +
-				ocfs2_clusters_to_blocks(inode->i_sb, coff);
+				ocfs2_clusters_to_blocks(inode_sb(inode),
+							 coff);
 	} else {
 		/*
 		 * Truncate completed, leave happily.
@@ -7364,7 +7367,7 @@ int ocfs2_commit_truncate(struct ocfs2_super *osb,
 		goto bail;
 	}
 
-	phys_cpos = ocfs2_blocks_to_clusters(inode->i_sb, blkno);
+	phys_cpos = ocfs2_blocks_to_clusters(inode_sb(inode), blkno);
 
 	if ((flags & OCFS2_EXT_REFCOUNTED) && trunc_len && !ref_tree) {
 		status = ocfs2_lock_refcount_tree(osb, refcount_loc, 1,
@@ -7413,7 +7416,7 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	int ret;
 	unsigned int numbytes;
 	handle_t *handle;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_inline_data *idata = &di->id2.i_data;
 
@@ -7425,7 +7428,7 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	if (!(OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) ||
 	    !(le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) ||
 	    !ocfs2_supports_inline_data(osb)) {
-		ocfs2_error(inode->i_sb,
+		ocfs2_error(inode_sb(inode),
 			    "Inline data flags for inode %llu don't agree! Disk: 0x%x, Memory: 0x%x, Superblock: 0x%x\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    le16_to_cpu(di->i_dyn_features),
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index e8e205bf2e41..12c487fe8ddc 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -61,7 +61,7 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 	struct ocfs2_dinode *fe = NULL;
 	struct buffer_head *bh = NULL;
 	struct buffer_head *buffer_cache_bh = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	void *kaddr;
 
 	trace_ocfs2_symlink_get_block(
@@ -70,7 +70,7 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 
 	BUG_ON(ocfs2_inode_is_fast_symlink(inode));
 
-	if ((iblock << inode->i_sb->s_blocksize_bits) > PATH_MAX + 1) {
+	if ((iblock << inode_sb(inode)->s_blocksize_bits) > PATH_MAX + 1) {
 		mlog(ML_ERROR, "block offset > PATH_MAX: %llu",
 		     (unsigned long long)iblock);
 		goto bail;
@@ -83,7 +83,7 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 	}
 	fe = (struct ocfs2_dinode *) bh->b_data;
 
-	if ((u64)iblock >= ocfs2_clusters_to_blocks(inode->i_sb,
+	if ((u64)iblock >= ocfs2_clusters_to_blocks(inode_sb(inode),
 						    le32_to_cpu(fe->i_clusters))) {
 		err = -ENOMEM;
 		mlog(ML_ERROR, "block offset is outside the allocated size: "
@@ -123,7 +123,7 @@ static int ocfs2_symlink_get_block(struct inode *inode, sector_t iblock,
 		brelse(buffer_cache_bh);
 	}
 
-	map_bh(bh_result, inode->i_sb,
+	map_bh(bh_result, inode_sb(inode),
 	       le64_to_cpu(fe->id2.i_list.l_recs[0].e_blkno) + iblock);
 
 	err = 0;
@@ -154,7 +154,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 	unsigned int ext_flags;
 	u64 max_blocks = bh_result->b_size >> inode->i_blkbits;
 	u64 p_blkno, count, past_eof;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	trace_ocfs2_get_block((unsigned long long)OCFS2_I(inode)->ip_blkno,
 			      (unsigned long long)iblock, bh_result, create);
@@ -200,7 +200,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 
 	/* Treat the unwritten extent as a hole for zeroing purposes. */
 	if (p_blkno && !(ext_flags & OCFS2_EXT_UNWRITTEN))
-		map_bh(bh_result, inode->i_sb, p_blkno);
+		map_bh(bh_result, inode_sb(inode), p_blkno);
 
 	bh_result->b_size = count << inode->i_blkbits;
 
@@ -218,7 +218,7 @@ int ocfs2_get_block(struct inode *inode, sector_t iblock,
 		}
 	}
 
-	past_eof = ocfs2_blocks_for_bytes(inode->i_sb, i_size_read(inode));
+	past_eof = ocfs2_blocks_for_bytes(inode_sb(inode), i_size_read(inode));
 
 	trace_ocfs2_get_block_end((unsigned long long)OCFS2_I(inode)->ip_blkno,
 				  (unsigned long long)past_eof);
@@ -240,7 +240,8 @@ int ocfs2_read_inline_data(struct inode *inode, struct page *page,
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	if (!(le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL)) {
-		ocfs2_error(inode->i_sb, "Inode %llu lost inline data flag\n",
+		ocfs2_error(inode_sb(inode),
+			    "Inode %llu lost inline data flag\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno);
 		return -EROFS;
 	}
@@ -248,8 +249,8 @@ int ocfs2_read_inline_data(struct inode *inode, struct page *page,
 	size = i_size_read(inode);
 
 	if (size > PAGE_SIZE ||
-	    size > ocfs2_max_inline_data_with_xattr(inode->i_sb, di)) {
-		ocfs2_error(inode->i_sb,
+	    size > ocfs2_max_inline_data_with_xattr(inode_sb(inode), di)) {
+		ocfs2_error(inode_sb(inode),
 			    "Inode %llu has with inline data has bad size: %Lu\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    (unsigned long long)size);
@@ -598,7 +599,7 @@ static int ocfs2_should_read_blk(struct inode *inode, struct page *page,
 {
 	u64 offset = page_offset(page) + block_start;
 
-	if (ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)))
+	if (ocfs2_sparse_alloc(OCFS2_SB(inode_sb(inode))))
 		return 1;
 
 	if (i_size_read(inode) > offset)
@@ -651,7 +652,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 			set_buffer_new(bh);
 
 		if (!buffer_mapped(bh)) {
-			map_bh(bh, inode->i_sb, *p_blkno);
+			map_bh(bh, inode_sb(inode), *p_blkno);
 			clean_bdev_bh_alias(bh);
 		}
 
@@ -973,7 +974,7 @@ static int ocfs2_prepare_page_for_write(struct inode *inode, u64 *p_blkno,
 	unsigned int cluster_start, cluster_end;
 	unsigned int user_data_from = 0, user_data_to = 0;
 
-	ocfs2_figure_cluster_boundaries(OCFS2_SB(inode->i_sb), cpos,
+	ocfs2_figure_cluster_boundaries(OCFS2_SB(inode_sb(inode)), cpos,
 					&cluster_start, &cluster_end);
 
 	/* treat the write as new if the a hole/lseek spanned across
@@ -1034,7 +1035,7 @@ static int ocfs2_prepare_page_for_write(struct inode *inode, u64 *p_blkno,
 	 * been zero'd from being read in as a hole.
 	 */
 	if (new && !PageUptodate(page))
-		ocfs2_clear_page_regions(page, OCFS2_SB(inode->i_sb),
+		ocfs2_clear_page_regions(page, OCFS2_SB(inode_sb(inode)),
 					 cpos, user_data_from, user_data_to);
 
 	flush_dcache_page(page);
@@ -1067,8 +1068,9 @@ static int ocfs2_grab_pages_for_write(struct address_space *mapping,
 	 * last page of the write.
 	 */
 	if (new) {
-		wc->w_num_pages = ocfs2_pages_per_cluster(inode->i_sb);
-		start = ocfs2_align_clusters_to_page_index(inode->i_sb, cpos);
+		wc->w_num_pages = ocfs2_pages_per_cluster(inode_sb(inode));
+		start = ocfs2_align_clusters_to_page_index(inode_sb(inode),
+							   cpos);
 		/*
 		 * We need the index *past* the last page we could possibly
 		 * touch.  This is the page past the end of the write or
@@ -1149,7 +1151,7 @@ static int ocfs2_write_cluster(struct address_space *mapping,
 	u64 p_blkno;
 	struct inode *inode = mapping->host;
 	struct ocfs2_extent_tree et;
-	int bpc = ocfs2_clusters_to_blocks(inode->i_sb, 1);
+	int bpc = ocfs2_clusters_to_blocks(inode_sb(inode), 1);
 
 	if (new) {
 		u32 tmp_pos;
@@ -1159,7 +1161,7 @@ static int ocfs2_write_cluster(struct address_space *mapping,
 		 * any additional semaphores or cluster locks.
 		 */
 		tmp_pos = cpos;
-		ret = ocfs2_add_inode_data(OCFS2_SB(inode->i_sb), inode,
+		ret = ocfs2_add_inode_data(OCFS2_SB(inode_sb(inode)), inode,
 					   &tmp_pos, 1, !clear_unwritten,
 					   wc->w_di_bh, wc->w_handle,
 					   data_ac, meta_ac, NULL);
@@ -1205,9 +1207,9 @@ static int ocfs2_write_cluster(struct address_space *mapping,
 
 	BUG_ON(*phys == 0);
 
-	p_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *phys);
+	p_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), *phys);
 	if (!should_zero)
-		p_blkno += (user_pos >> inode->i_sb->s_blocksize_bits) & (u64)(bpc - 1);
+		p_blkno += (user_pos >> inode_sb(inode)->s_blocksize_bits) & (u64)(bpc - 1);
 
 	for(i = 0; i < wc->w_num_pages; i++) {
 		int tmpret;
@@ -1250,7 +1252,7 @@ static int ocfs2_write_cluster_by_desc(struct address_space *mapping,
 	loff_t cluster_off;
 	unsigned int local_len = len;
 	struct ocfs2_write_cluster_desc *desc;
-	struct ocfs2_super *osb = OCFS2_SB(mapping->host->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(mapping->host));
 
 	for (i = 0; i < wc->w_clen; i++) {
 		desc = &wc->w_desc[i];
@@ -1500,7 +1502,7 @@ static int ocfs2_write_begin_inline(struct address_space *mapping,
 				    struct ocfs2_write_ctxt *wc)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct page *page;
 	handle_t *handle;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)wc->w_di_bh->b_data;
@@ -1604,7 +1606,7 @@ static int ocfs2_try_to_write_inline_data(struct address_space *mapping,
 	 */
 	di = (struct ocfs2_dinode *)wc->w_di_bh->b_data;
 	if (mmap_page ||
-	    end > ocfs2_max_inline_data_with_xattr(inode->i_sb, di))
+	    end > ocfs2_max_inline_data_with_xattr(inode_sb(inode), di))
 		return 0;
 
 do_inline_write:
@@ -1640,7 +1642,7 @@ static int ocfs2_expand_nonsparse_inode(struct inode *inode,
 	int ret;
 	loff_t newsize = pos + len;
 
-	BUG_ON(ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)));
+	BUG_ON(ocfs2_sparse_alloc(OCFS2_SB(inode_sb(inode))));
 
 	if (newsize <= i_size_read(inode))
 		return 0;
@@ -1652,7 +1654,8 @@ static int ocfs2_expand_nonsparse_inode(struct inode *inode,
 	/* There is no wc if this is call from direct. */
 	if (wc)
 		wc->w_first_new_cpos =
-			ocfs2_clusters_for_bytes(inode->i_sb, i_size_read(inode));
+			ocfs2_clusters_for_bytes(inode_sb(inode),
+						 i_size_read(inode));
 
 	return ret;
 }
@@ -1662,7 +1665,7 @@ static int ocfs2_zero_tail(struct inode *inode, struct buffer_head *di_bh,
 {
 	int ret = 0;
 
-	BUG_ON(!ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)));
+	BUG_ON(!ocfs2_sparse_alloc(OCFS2_SB(inode_sb(inode))));
 	if (pos > i_size_read(inode))
 		ret = ocfs2_zero_extend(inode, di_bh, pos);
 
@@ -1678,7 +1681,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 	unsigned int clusters_to_alloc, extents_to_split, clusters_need = 0;
 	struct ocfs2_write_ctxt *wc;
 	struct inode *inode = mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di;
 	struct ocfs2_alloc_context *data_ac = NULL;
 	struct ocfs2_alloc_context *meta_ac = NULL;
@@ -1775,7 +1778,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 		if (data_ac)
 			data_ac->ac_resv = &OCFS2_I(inode)->ip_la_data_resv;
 
-		credits = ocfs2_calc_extend_credits(inode->i_sb,
+		credits = ocfs2_calc_extend_credits(inode_sb(inode),
 						    &di->id2.i_list);
 	} else if (type == OCFS2_WRITE_DIRECT)
 		/* direct write needs not to start trans if no extents alloc. */
@@ -1979,7 +1982,7 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
 	int i, ret;
 	unsigned from, to, start = pos & (PAGE_SIZE - 1);
 	struct inode *inode = mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_write_ctxt *wc = fsdata;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)wc->w_di_bh->b_data;
 	handle_t *handle = wc->w_handle;
@@ -2146,14 +2149,14 @@ static void ocfs2_dio_free_write_ctx(struct inode *inode,
 static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 			       struct buffer_head *bh_result, int create)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_write_ctxt *wc;
 	struct ocfs2_write_cluster_desc *desc = NULL;
 	struct ocfs2_dio_write_ctxt *dwc = NULL;
 	struct buffer_head *di_bh = NULL;
 	u64 p_blkno;
-	loff_t pos = iblock << inode->i_sb->s_blocksize_bits;
+	loff_t pos = iblock << inode_sb(inode)->s_blocksize_bits;
 	unsigned len, total_len = bh_result->b_size;
 	int ret = 0, first_get_block = 0;
 
@@ -2188,8 +2191,8 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 		goto out;
 	}
 
-	if (ocfs2_clusters_for_bytes(inode->i_sb, pos + total_len) >
-	    ocfs2_clusters_for_bytes(inode->i_sb, i_size_read(inode)) &&
+	if (ocfs2_clusters_for_bytes(inode_sb(inode), pos + total_len) >
+	    ocfs2_clusters_for_bytes(inode_sb(inode), i_size_read(inode)) &&
 	    !dwc->dw_orphaned) {
 		/*
 		 * when we are going to alloc extents beyond file size, add the
@@ -2213,7 +2216,7 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 	down_write(&oi->ip_alloc_sem);
 
 	if (first_get_block) {
-		if (ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)))
+		if (ocfs2_sparse_alloc(OCFS2_SB(inode_sb(inode))))
 			ret = ocfs2_zero_tail(inode, di_bh, pos);
 		else
 			ret = ocfs2_expand_nonsparse_inode(inode, di_bh, pos,
@@ -2234,11 +2237,11 @@ static int ocfs2_dio_wr_get_block(struct inode *inode, sector_t iblock,
 
 	desc = &wc->w_desc[0];
 
-	p_blkno = ocfs2_clusters_to_blocks(inode->i_sb, desc->c_phys);
+	p_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), desc->c_phys);
 	BUG_ON(p_blkno == 0);
-	p_blkno += iblock & (u64)(ocfs2_clusters_to_blocks(inode->i_sb, 1) - 1);
+	p_blkno += iblock & (u64)(ocfs2_clusters_to_blocks(inode_sb(inode), 1) - 1);
 
-	map_bh(bh_result, inode->i_sb, p_blkno);
+	map_bh(bh_result, inode_sb(inode), p_blkno);
 	bh_result->b_size = len;
 	if (desc->c_needs_zero)
 		set_buffer_new(bh_result);
@@ -2281,7 +2284,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 {
 	struct ocfs2_cached_dealloc_ctxt dealloc;
 	struct ocfs2_extent_tree et;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_unwritten_extent *ue = NULL;
 	struct buffer_head *di_bh = NULL;
@@ -2345,7 +2348,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		goto unlock;
 	}
 
-	credits = ocfs2_calc_extend_credits(inode->i_sb, &di->id2.i_list);
+	credits = ocfs2_calc_extend_credits(inode_sb(inode), &di->id2.i_list);
 
 	handle = ocfs2_start_trans(osb, credits);
 	if (IS_ERR(handle)) {
@@ -2426,7 +2429,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	get_block_t *get_block;
 
 	/*
@@ -2446,7 +2449,7 @@ static ssize_t ocfs2_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	else
 		get_block = ocfs2_dio_wr_get_block;
 
-	return __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
+	return __blockdev_direct_IO(iocb, inode, inode_sb(inode)->s_bdev,
 				    iter, get_block,
 				    ocfs2_dio_end_io, NULL, 0);
 }
diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index 290373024d9d..a39ccd03fc83 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -445,7 +445,7 @@ void ocfs2_dentry_move(struct dentry *dentry, struct dentry *target,
 		       struct inode *old_dir, struct inode *new_dir)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(old_dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(old_dir));
 	struct inode *inode = d_inode(dentry);
 
 	/*
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 977763d4c27d..b4bb93d1259d 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -88,7 +88,7 @@ static int ocfs2_dir_indexed(struct inode *inode);
  */
 static int ocfs2_supports_dir_trailer(struct inode *dir)
 {
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 
 	if (OCFS2_I(dir)->ip_dyn_features & OCFS2_INLINE_DATA_FL)
 		return 0;
@@ -106,7 +106,7 @@ static int ocfs2_supports_dir_trailer(struct inode *dir)
  */
 static int ocfs2_new_dir_wants_trailer(struct inode *dir)
 {
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 
 	return ocfs2_meta_ecc(osb) ||
 		ocfs2_supports_indexed_dirs(osb);
@@ -155,7 +155,7 @@ static void ocfs2_init_dir_trailer(struct inode *inode,
 {
 	struct ocfs2_dir_block_trailer *trailer;
 
-	trailer = ocfs2_trailer_from_bh(bh, inode->i_sb);
+	trailer = ocfs2_trailer_from_bh(bh, inode_sb(inode));
 	strcpy(trailer->db_signature, OCFS2_DIR_TRAILER_SIGNATURE);
 	trailer->db_compat_rec_len =
 			cpu_to_le16(sizeof(struct ocfs2_dir_block_trailer));
@@ -182,7 +182,7 @@ static int ocfs2_dx_dir_link_trailer(struct inode *dir, handle_t *handle,
 		mlog_errno(ret);
 		goto out;
 	}
-	trailer = ocfs2_trailer_from_bh(dirdata_bh, dir->i_sb);
+	trailer = ocfs2_trailer_from_bh(dirdata_bh, inode_sb(dir));
 	dx_root = (struct ocfs2_dx_root_block *)dx_root_bh->b_data;
 
 	trailer->db_free_next = dx_root->dr_free_blk;
@@ -271,7 +271,7 @@ static void str2hashbuf(const char *msg, int len, __u32 *buf, int num)
 static void ocfs2_dx_dir_name_hash(struct inode *dir, const char *name, int len,
 				   struct ocfs2_dx_hinfo *hinfo)
 {
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	const char	*p;
 	__u32		in[8], buf[4];
 
@@ -329,7 +329,7 @@ static int ocfs2_check_dir_entry(struct inode * dir,
 	else if (unlikely(rlen < OCFS2_DIR_REC_LEN(de->name_len)))
 		error_msg = "rec_len is too small for name_len";
 	else if (unlikely(
-		 ((char *) de - bh->b_data) + rlen > dir->i_sb->s_blocksize))
+		 ((char *) de - bh->b_data) + rlen > inode_sb(dir)->s_blocksize))
 		error_msg = "directory entry across blocks";
 
 	if (unlikely(error_msg != NULL))
@@ -479,16 +479,16 @@ static int ocfs2_check_dir_trailer(struct inode *dir, struct buffer_head *bh)
 	int rc = 0;
 	struct ocfs2_dir_block_trailer *trailer;
 
-	trailer = ocfs2_trailer_from_bh(bh, dir->i_sb);
+	trailer = ocfs2_trailer_from_bh(bh, inode_sb(dir));
 	if (!OCFS2_IS_VALID_DIR_TRAILER(trailer)) {
-		rc = ocfs2_error(dir->i_sb,
+		rc = ocfs2_error(inode_sb(dir),
 				 "Invalid dirblock #%llu: signature = %.*s\n",
 				 (unsigned long long)bh->b_blocknr, 7,
 				 trailer->db_signature);
 		goto out;
 	}
 	if (le64_to_cpu(trailer->db_blkno) != bh->b_blocknr) {
-		rc = ocfs2_error(dir->i_sb,
+		rc = ocfs2_error(inode_sb(dir),
 				 "Directory block #%llu has an invalid db_blkno of %llu\n",
 				 (unsigned long long)bh->b_blocknr,
 				 (unsigned long long)le64_to_cpu(trailer->db_blkno));
@@ -496,7 +496,7 @@ static int ocfs2_check_dir_trailer(struct inode *dir, struct buffer_head *bh)
 	}
 	if (le64_to_cpu(trailer->db_parent_dinode) !=
 	    OCFS2_I(dir)->ip_blkno) {
-		rc = ocfs2_error(dir->i_sb,
+		rc = ocfs2_error(inode_sb(dir),
 				 "Directory block #%llu on dinode #%llu has an invalid parent_dinode of %llu\n",
 				 (unsigned long long)bh->b_blocknr,
 				 (unsigned long long)OCFS2_I(dir)->ip_blkno,
@@ -696,7 +696,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
 	int num = 0;
 	int nblocks, i, err;
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 
 	nblocks = i_size_read(dir) >> sb->s_blocksize_bits;
 	start = OCFS2_I(dir)->ip_dir_start_lookup;
@@ -804,7 +804,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 		el = &eb->h_list;
 
 		if (el->l_tree_depth) {
-			ret = ocfs2_error(inode->i_sb,
+			ret = ocfs2_error(inode_sb(inode),
 					  "Inode %lu has non zero tree depth in btree tree block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
@@ -823,7 +823,7 @@ static int ocfs2_dx_dir_lookup_rec(struct inode *inode,
 	}
 
 	if (!found) {
-		ret = ocfs2_error(inode->i_sb,
+		ret = ocfs2_error(inode_sb(inode),
 				  "Inode %lu has bad extent record (%u, %u, 0) in btree\n",
 				  inode->i_ino,
 				  le32_to_cpu(rec->e_cpos),
@@ -881,10 +881,10 @@ static int ocfs2_dx_dir_lookup(struct inode *inode,
 	cend = cpos + clen;
 	if (name_hash >= cend) {
 		/* We want the last cluster */
-		blkno += ocfs2_clusters_to_blocks(inode->i_sb, clen - 1);
+		blkno += ocfs2_clusters_to_blocks(inode_sb(inode), clen - 1);
 		cpos += clen - 1;
 	} else {
-		blkno += ocfs2_clusters_to_blocks(inode->i_sb,
+		blkno += ocfs2_clusters_to_blocks(inode_sb(inode),
 						  name_hash - cpos);
 		cpos = name_hash;
 	}
@@ -894,7 +894,7 @@ static int ocfs2_dx_dir_lookup(struct inode *inode,
 	 * find the exact block from the start of the cluster to
 	 * search, we take the lower bits of the hash.
 	 */
-	blkno += ocfs2_dx_dir_hash_idx(OCFS2_SB(inode->i_sb), hinfo);
+	blkno += ocfs2_dx_dir_hash_idx(OCFS2_SB(inode_sb(inode)), hinfo);
 
 	if (ret_phys_blkno)
 		*ret_phys_blkno = blkno;
@@ -986,7 +986,8 @@ static int ocfs2_dx_dir_search(const char *name, int namelen,
 
 		found = ocfs2_search_dirblock(dir_ent_bh, dir, name, namelen,
 					      0, dir_ent_bh->b_data,
-					      dir->i_sb->s_blocksize, &dir_ent);
+					      inode_sb(dir)->s_blocksize,
+					      &dir_ent);
 		if (found == 1)
 			break;
 
@@ -1297,7 +1298,7 @@ static int ocfs2_delete_entry_dx(handle_t *handle, struct inode *dir,
 	 * for a new one, so add this block to the free list if it
 	 * isn't already there.
 	 */
-	trailer = ocfs2_trailer_from_bh(leaf_bh, dir->i_sb);
+	trailer = ocfs2_trailer_from_bh(leaf_bh, inode_sb(dir));
 	if (trailer->db_free_rec_len == 0)
 		add_to_free_list = 1;
 
@@ -1339,7 +1340,7 @@ static int ocfs2_delete_entry_dx(handle_t *handle, struct inode *dir,
 		goto out;
 	}
 
-	max_rec_len = ocfs2_find_max_rec_len(dir->i_sb, leaf_bh);
+	max_rec_len = ocfs2_find_max_rec_len(inode_sb(dir), leaf_bh);
 	trailer->db_free_rec_len = cpu_to_le16(max_rec_len);
 	if (add_to_free_list) {
 		trailer->db_free_next = dx_root->dr_free_blk;
@@ -1545,7 +1546,7 @@ static void ocfs2_remove_block_from_free_list(struct inode *dir,
 	struct ocfs2_dx_root_block *dx_root;
 	struct buffer_head *bh;
 
-	trailer = ocfs2_trailer_from_bh(lookup->dl_leaf_bh, dir->i_sb);
+	trailer = ocfs2_trailer_from_bh(lookup->dl_leaf_bh, inode_sb(dir));
 
 	if (ocfs2_free_list_at_root(lookup)) {
 		bh = lookup->dl_dx_root_bh;
@@ -1553,7 +1554,7 @@ static void ocfs2_remove_block_from_free_list(struct inode *dir,
 		dx_root->dr_free_blk = trailer->db_free_next;
 	} else {
 		bh = lookup->dl_prev_leaf_bh;
-		prev = ocfs2_trailer_from_bh(bh, dir->i_sb);
+		prev = ocfs2_trailer_from_bh(bh, inode_sb(dir));
 		prev->db_free_next = trailer->db_free_next;
 	}
 
@@ -1575,14 +1576,16 @@ static void ocfs2_recalc_free_list(struct inode *dir, handle_t *handle,
 	struct ocfs2_dir_block_trailer *trailer;
 
 	/* Walk dl_leaf_bh to figure out what the new free rec_len is. */
-	max_rec_len = ocfs2_find_max_rec_len(dir->i_sb, lookup->dl_leaf_bh);
+	max_rec_len = ocfs2_find_max_rec_len(inode_sb(dir),
+					     lookup->dl_leaf_bh);
 	if (max_rec_len) {
 		/*
 		 * There's still room in this block, so no need to remove it
 		 * from the free list. In this case, we just want to update
 		 * the rec len accounting.
 		 */
-		trailer = ocfs2_trailer_from_bh(lookup->dl_leaf_bh, dir->i_sb);
+		trailer = ocfs2_trailer_from_bh(lookup->dl_leaf_bh,
+						inode_sb(dir));
 		trailer->db_free_rec_len = cpu_to_le16(max_rec_len);
 		ocfs2_journal_dirty(handle, lookup->dl_leaf_bh);
 	} else {
@@ -1607,7 +1610,7 @@ int __ocfs2_add_entry(handle_t *handle,
 	unsigned short rec_len;
 	struct ocfs2_dir_entry *de, *de1;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)parent_fe_bh->b_data;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	int retval;
 	unsigned int size = sb->s_blocksize;
 	struct buffer_head *insert_bh = lookup->dl_leaf_bh;
@@ -1675,7 +1678,8 @@ int __ocfs2_add_entry(handle_t *handle,
 				"offset is %lu, trailer offset is %d\n",
 				namelen, name, namelen,
 				(unsigned long long)parent_fe_bh->b_blocknr,
-				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
+				offset,
+				ocfs2_dir_trailer_blk_off(inode_sb(dir)));
 
 		if (ocfs2_dirent_would_fit(de, rec_len)) {
 			dir->i_mtime = dir->i_ctime = current_time(dir);
@@ -1832,7 +1836,7 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
 	int i;
 	struct buffer_head * bh, * tmp;
 	struct ocfs2_dir_entry * de;
-	struct super_block * sb = inode->i_sb;
+	struct super_block * sb = inode_sb(inode);
 	unsigned int ra_sectors = 16;
 	int stored = 0;
 
@@ -2252,7 +2256,7 @@ static int ocfs2_fill_new_dir_el(struct ocfs2_super *osb,
 	struct ocfs2_dir_entry *de;
 
 	if (ocfs2_new_dir_wants_trailer(inode))
-		size = ocfs2_dir_trailer_blk_off(parent->i_sb);
+		size = ocfs2_dir_trailer_blk_off(inode_sb(parent));
 
 	status = ocfs2_do_extend_dir(osb->sb, handle, inode, fe_bh,
 				     data_ac, NULL, &new_bh);
@@ -2288,7 +2292,7 @@ static int ocfs2_fill_new_dir_el(struct ocfs2_super *osb,
 
 	ocfs2_journal_dirty(handle, new_bh);
 
-	i_size_write(inode, inode->i_sb->s_blocksize);
+	i_size_write(inode, inode_sb(inode)->s_blocksize);
 	set_nlink(inode, 2);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
 	status = ocfs2_mark_inode_dirty(handle, inode, fe_bh);
@@ -2324,7 +2328,7 @@ static int ocfs2_dx_dir_attach_index(struct ocfs2_super *osb,
 	struct buffer_head *dx_root_bh = NULL;
 	struct ocfs2_dx_root_block *dx_root;
 	struct ocfs2_dir_block_trailer *trailer =
-		ocfs2_trailer_from_bh(dirdata_bh, dir->i_sb);
+		ocfs2_trailer_from_bh(dirdata_bh, inode_sb(dir));
 
 	ret = ocfs2_claim_metadata(handle, meta_ac, 1, &suballoc_loc,
 				   &dr_suballoc_bit, &num_bits, &dr_blkno);
@@ -2462,7 +2466,7 @@ static int __ocfs2_dx_dir_new_cluster(struct inode *dir,
 	int ret;
 	u32 phys, num;
 	u64 phys_blkno;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 
 	/*
 	 * XXX: For create, this should claim cluster for the index
@@ -2625,7 +2629,7 @@ static int ocfs2_dx_dir_index_block(struct inode *dir,
 	u64 dirent_blk = dirent_bh->b_blocknr;
 
 	de_buf = dirent_bh->b_data;
-	limit = de_buf + dir->i_sb->s_blocksize;
+	limit = de_buf + inode_sb(dir)->s_blocksize;
 
 	while (de_buf < limit) {
 		de = (struct ocfs2_dir_entry *)de_buf;
@@ -2636,7 +2640,7 @@ static int ocfs2_dx_dir_index_block(struct inode *dir,
 
 		ocfs2_dx_dir_name_hash(dir, de->name, namelen, &hinfo);
 
-		i = ocfs2_dx_dir_hash_idx(OCFS2_SB(dir->i_sb), &hinfo);
+		i = ocfs2_dx_dir_hash_idx(OCFS2_SB(inode_sb(dir)), &hinfo);
 		dx_leaf_bh = dx_leaves[i];
 
 		ret = __ocfs2_dx_dir_leaf_insert(dir, handle, &hinfo,
@@ -2672,7 +2676,7 @@ static void ocfs2_dx_dir_index_root_block(struct inode *dir,
 	dx_root = (struct ocfs2_dx_root_block *)dx_root_bh->b_data;
 
 	de_buf = dirent_bh->b_data;
-	limit = de_buf + dir->i_sb->s_blocksize;
+	limit = de_buf + inode_sb(dir)->s_blocksize;
 
 	while (de_buf < limit) {
 		de = (struct ocfs2_dir_entry *)de_buf;
@@ -2723,7 +2727,7 @@ static int ocfs2_new_dx_should_be_inline(struct inode *dir,
 	}
 
 	/* We are careful to leave room for one extra record. */
-	return dirent_count < ocfs2_dx_entries_per_root(dir->i_sb);
+	return dirent_count < ocfs2_dx_entries_per_root(inode_sb(dir));
 }
 
 /*
@@ -2743,7 +2747,7 @@ static int ocfs2_new_dx_should_be_inline(struct inode *dir,
 static unsigned int ocfs2_expand_last_dirent(char *start, unsigned int old_size,
 					     struct inode *dir)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct ocfs2_dir_entry *de;
 	struct ocfs2_dir_entry *prev_de;
 	char *de_buf, *limit;
@@ -2796,12 +2800,12 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 				   struct buffer_head **first_block_bh)
 {
 	u32 alloc, dx_alloc, bit_off, len, num_dx_entries = 0;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	int ret, i, num_dx_leaves = 0, dx_inline = 0,
 		credits = ocfs2_inline_to_extents_credits(sb);
 	u64 dx_insert_blkno, blkno,
 		bytes = blocks_wanted << sb->s_blocksize_bits;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_inode_info *oi = OCFS2_I(dir);
 	struct ocfs2_alloc_context *data_ac = NULL;
 	struct ocfs2_alloc_context *meta_ac = NULL;
@@ -2894,7 +2898,7 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out_commit;
 		}
-		bytes_allocated += ocfs2_clusters_to_bytes(dir->i_sb, 1);
+		bytes_allocated += ocfs2_clusters_to_bytes(inode_sb(dir), 1);
 	}
 
 	/*
@@ -2909,14 +2913,14 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 		mlog_errno(ret);
 		goto out_commit;
 	}
-	bytes_allocated += ocfs2_clusters_to_bytes(dir->i_sb, 1);
+	bytes_allocated += ocfs2_clusters_to_bytes(inode_sb(dir), 1);
 
 	/*
 	 * Operations are carefully ordered so that we set up the new
 	 * data block first. The conversion from inline data to
 	 * extents follows.
 	 */
-	blkno = ocfs2_clusters_to_blocks(dir->i_sb, bit_off);
+	blkno = ocfs2_clusters_to_blocks(inode_sb(dir), bit_off);
 	dirdata_bh = sb_getblk(sb, blkno);
 	if (!dirdata_bh) {
 		ret = -ENOMEM;
@@ -3051,7 +3055,7 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out_commit;
 		}
-		blkno = ocfs2_clusters_to_blocks(dir->i_sb, bit_off);
+		blkno = ocfs2_clusters_to_blocks(inode_sb(dir), bit_off);
 
 		ret = ocfs2_insert_extent(handle, &et, 1,
 					  blkno, len, 0, NULL);
@@ -3059,7 +3063,7 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out_commit;
 		}
-		bytes_allocated += ocfs2_clusters_to_bytes(dir->i_sb, 1);
+		bytes_allocated += ocfs2_clusters_to_bytes(inode_sb(dir), 1);
 	}
 
 	*first_block_bh = dirdata_bh;
@@ -3072,7 +3076,7 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 			 * We need to return the correct block within the
 			 * cluster which should hold our entry.
 			 */
-			off = ocfs2_dx_dir_hash_idx(OCFS2_SB(dir->i_sb),
+			off = ocfs2_dx_dir_hash_idx(OCFS2_SB(inode_sb(dir)),
 						    &lookup->dl_hinfo);
 			get_bh(dx_leaves[off]);
 			lookup->dl_dx_leaf_bh = dx_leaves[off];
@@ -3333,7 +3337,7 @@ static int ocfs2_extend_dir(struct ocfs2_super *osb,
 	ocfs2_update_inode_fsync_trans(handle, dir, 1);
 	ocfs2_journal_dirty(handle, new_bh);
 
-	dir_i_size += dir->i_sb->s_blocksize;
+	dir_i_size += inode_sb(dir)->s_blocksize;
 	i_size_write(dir, dir_i_size);
 	dir->i_blocks = ocfs2_inode_sector_count(dir);
 	status = ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
@@ -3367,12 +3371,12 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 				   unsigned int *blocks_wanted)
 {
 	int ret;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_dir_entry *de, *last_de = NULL;
 	char *de_buf, *limit;
 	unsigned long offset = 0;
-	unsigned int rec_len, new_rec_len, free_space = dir->i_sb->s_blocksize;
+	unsigned int rec_len, new_rec_len, free_space = inode_sb(dir)->s_blocksize;
 
 	/*
 	 * This calculates how many free bytes we'd have in block zero, should
@@ -3381,7 +3385,7 @@ static int ocfs2_find_dir_space_id(struct inode *dir, struct buffer_head *di_bh,
 	if (ocfs2_new_dir_wants_trailer(dir))
 		free_space = ocfs2_dir_trailer_blk_off(sb) - i_size_read(dir);
 	else
-		free_space = dir->i_sb->s_blocksize - i_size_read(dir);
+		free_space = inode_sb(dir)->s_blocksize - i_size_read(dir);
 
 	de_buf = di->id2.i_data.id_data;
 	limit = de_buf + i_size_read(dir);
@@ -3439,9 +3443,9 @@ static int ocfs2_find_dir_space_el(struct inode *dir, const char *name,
 	struct buffer_head *bh = NULL;
 	unsigned short rec_len;
 	struct ocfs2_dir_entry *de;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	int status;
-	int blocksize = dir->i_sb->s_blocksize;
+	int blocksize = inode_sb(dir)->s_blocksize;
 
 	status = ocfs2_read_dir_block(dir, 0, &bh, 0);
 	if (status)
@@ -3676,7 +3680,7 @@ static void ocfs2_dx_dir_transfer_leaf(struct inode *dir, u32 split_hash,
 
 		num_used = le16_to_cpu(orig_list->de_num_used);
 
-		memcpy(tmp_dx_leaf, orig_dx_leaf, dir->i_sb->s_blocksize);
+		memcpy(tmp_dx_leaf, orig_dx_leaf, inode_sb(dir)->s_blocksize);
 		tmp_list->de_num_used = cpu_to_le16(0);
 		memset(&tmp_list->de_entries, 0, sizeof(*dx_entry)*num_used);
 
@@ -3690,7 +3694,7 @@ static void ocfs2_dx_dir_transfer_leaf(struct inode *dir, u32 split_hash,
 				ocfs2_dx_dir_leaf_insert_tail(tmp_dx_leaf,
 							      dx_entry);
 		}
-		memcpy(orig_dx_leaf, tmp_dx_leaf, dir->i_sb->s_blocksize);
+		memcpy(orig_dx_leaf, tmp_dx_leaf, inode_sb(dir)->s_blocksize);
 
 		ocfs2_journal_dirty(handle, orig_dx_leaves[i]);
 		ocfs2_journal_dirty(handle, new_dx_leaves[i]);
@@ -3784,7 +3788,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
 	}
 
 	ret = dquot_alloc_space_nodirty(dir,
-				       ocfs2_clusters_to_bytes(dir->i_sb, 1));
+				       ocfs2_clusters_to_bytes(inode_sb(dir), 1));
 	if (ret)
 		goto out_commit;
 	did_quota = 1;
@@ -3839,7 +3843,8 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
 		goto out_commit;
 	}
 
-	orig_leaves_start = ocfs2_block_to_cluster_start(dir->i_sb, leaf_blkno);
+	orig_leaves_start = ocfs2_block_to_cluster_start(inode_sb(dir),
+							 leaf_blkno);
 	ret = ocfs2_read_dx_leaves(dir, orig_leaves_start, num_dx_leaves,
 				   orig_dx_leaves);
 	if (ret) {
@@ -3880,7 +3885,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
 out_commit:
 	if (ret < 0 && did_quota)
 		dquot_free_space_nodirty(dir,
-				ocfs2_clusters_to_bytes(dir->i_sb, 1));
+				ocfs2_clusters_to_bytes(inode_sb(dir), 1));
 
 	ocfs2_update_inode_fsync_trans(handle, dir, 1);
 	ocfs2_commit_trans(osb, handle);
@@ -4005,7 +4010,7 @@ static int ocfs2_search_dx_free_list(struct inode *dir,
 			goto out;
 		}
 
-		db = ocfs2_trailer_from_bh(leaf_bh, dir->i_sb);
+		db = ocfs2_trailer_from_bh(leaf_bh, inode_sb(dir));
 		if (rec_len <= le16_to_cpu(db->db_free_rec_len)) {
 			lookup->dl_leaf_bh = leaf_bh;
 			lookup->dl_prev_leaf_bh = prev_leaf_bh;
@@ -4035,7 +4040,7 @@ static int ocfs2_expand_inline_dx_root(struct inode *dir,
 	struct ocfs2_extent_tree et;
 	u64 insert_blkno;
 	struct ocfs2_alloc_context *data_ac = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	handle_t *handle = NULL;
 	struct ocfs2_dx_root_block *dx_root;
 	struct ocfs2_dx_entry_list *entry_list;
@@ -4127,7 +4132,7 @@ static int ocfs2_expand_inline_dx_root(struct inode *dir,
 out_commit:
 	if (ret < 0 && did_quota)
 		dquot_free_space_nodirty(dir,
-					  ocfs2_clusters_to_bytes(dir->i_sb, 1));
+					  ocfs2_clusters_to_bytes(inode_sb(dir), 1));
 
 	ocfs2_commit_trans(osb, handle);
 
@@ -4165,7 +4170,7 @@ static int ocfs2_prepare_dx_dir_for_insert(struct inode *dir,
 					   struct ocfs2_dir_lookup_result *lookup)
 {
 	int ret, free_dx_root = 1;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct buffer_head *dx_root_bh = NULL;
 	struct buffer_head *leaf_bh = NULL;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
@@ -4342,7 +4347,7 @@ static int ocfs2_dx_dir_remove_index(struct inode *dir,
 				     struct buffer_head *dx_root_bh)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_dx_root_block *dx_root;
 	struct inode *dx_alloc_inode = NULL;
@@ -4424,7 +4429,7 @@ int ocfs2_dx_dir_truncate(struct inode *dir, struct buffer_head *di_bh)
 	unsigned int uninitialized_var(clen);
 	u32 major_hash = UINT_MAX, p_cpos, uninitialized_var(cpos);
 	u64 uninitialized_var(blkno);
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct buffer_head *dx_root_bh = NULL;
 	struct ocfs2_dx_root_block *dx_root;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
@@ -4457,7 +4462,7 @@ int ocfs2_dx_dir_truncate(struct inode *dir, struct buffer_head *di_bh)
 			goto out;
 		}
 
-		p_cpos = ocfs2_blocks_to_clusters(dir->i_sb, blkno);
+		p_cpos = ocfs2_blocks_to_clusters(inode_sb(dir), blkno);
 
 		ret = ocfs2_remove_btree_range(dir, &et, cpos, p_cpos, clen, 0,
 					       &dealloc, 0, false);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 602c71f32740..a434f7e143cf 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -412,7 +412,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
 				     struct dentry *dentry,
 				     umode_t mode)
 {
-	struct super_block *sb = parent->i_sb;
+	struct super_block *sb = inode_sb(parent);
 	struct inode * inode = new_inode(sb);
 	struct dlmfs_inode_private *ip;
 
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 9479f99c2145..ada39d788169 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -565,14 +565,15 @@ void ocfs2_inode_lock_res_init(struct ocfs2_lock_res *res,
 
 	ocfs2_build_lock_name(type, OCFS2_I(inode)->ip_blkno,
 			      generation, res->l_name);
-	ocfs2_lock_res_init_common(OCFS2_SB(inode->i_sb), res, type, ops, inode);
+	ocfs2_lock_res_init_common(OCFS2_SB(inode_sb(inode)), res, type, ops,
+				   inode);
 }
 
 static struct ocfs2_super *ocfs2_get_inode_osb(struct ocfs2_lock_res *lockres)
 {
 	struct inode *inode = ocfs2_lock_res_inode(lockres);
 
-	return OCFS2_SB(inode->i_sb);
+	return OCFS2_SB(inode_sb(inode));
 }
 
 static struct ocfs2_super *ocfs2_get_qinfo_osb(struct ocfs2_lock_res *lockres)
@@ -586,7 +587,7 @@ static struct ocfs2_super *ocfs2_get_file_osb(struct ocfs2_lock_res *lockres)
 {
 	struct ocfs2_file_private *fp = lockres->l_priv;
 
-	return OCFS2_SB(fp->fp_file->f_mapping->host->i_sb);
+	return OCFS2_SB(inode_sb(fp->fp_file->f_mapping->host));
 }
 
 static __u64 ocfs2_get_dentry_lock_ino(struct ocfs2_lock_res *lockres)
@@ -603,7 +604,7 @@ static struct ocfs2_super *ocfs2_get_dentry_osb(struct ocfs2_lock_res *lockres)
 {
 	struct ocfs2_dentry_lock *dl = lockres->l_priv;
 
-	return OCFS2_SB(dl->dl_inode->i_sb);
+	return OCFS2_SB(inode_sb(dl->dl_inode));
 }
 
 void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
@@ -641,7 +642,7 @@ void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 	memcpy(&lockres->l_name[OCFS2_DENTRY_LOCK_INO_START], &inode_blkno_be,
 	       sizeof(__be64));
 
-	ocfs2_lock_res_init_common(OCFS2_SB(inode->i_sb), lockres,
+	ocfs2_lock_res_init_common(OCFS2_SB(inode_sb(inode)), lockres,
 				   OCFS2_LOCK_TYPE_DENTRY, &ocfs2_dentry_lops,
 				   dl);
 }
@@ -716,7 +717,7 @@ void ocfs2_file_lock_res_init(struct ocfs2_lock_res *lockres,
 	ocfs2_lock_res_init_once(lockres);
 	ocfs2_build_lock_name(OCFS2_LOCK_TYPE_FLOCK, oi->ip_blkno,
 			      inode->i_generation, lockres->l_name);
-	ocfs2_lock_res_init_common(OCFS2_SB(inode->i_sb), lockres,
+	ocfs2_lock_res_init_common(OCFS2_SB(inode_sb(inode)), lockres,
 				   OCFS2_LOCK_TYPE_FLOCK, &ocfs2_flock_lops,
 				   fp);
 	lockres->l_flags |= OCFS2_LOCK_NOCACHE;
@@ -1701,7 +1702,7 @@ static int ocfs2_create_new_lock(struct ocfs2_super *osb,
 int ocfs2_create_new_inode_locks(struct inode *inode)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	BUG_ON(!ocfs2_inode_is_new(inode));
 
@@ -1743,7 +1744,7 @@ int ocfs2_rw_lock(struct inode *inode, int write)
 {
 	int status, level;
 	struct ocfs2_lock_res *lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu take %s RW lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno,
@@ -1756,7 +1757,8 @@ int ocfs2_rw_lock(struct inode *inode, int write)
 
 	level = write ? DLM_LOCK_EX : DLM_LOCK_PR;
 
-	status = ocfs2_cluster_lock(OCFS2_SB(inode->i_sb), lockres, level, 0,
+	status = ocfs2_cluster_lock(OCFS2_SB(inode_sb(inode)), lockres, level,
+				    0,
 				    0);
 	if (status < 0)
 		mlog_errno(status);
@@ -1768,7 +1770,7 @@ int ocfs2_try_rw_lock(struct inode *inode, int write)
 {
 	int status, level;
 	struct ocfs2_lock_res *lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu try to take %s RW lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno,
@@ -1789,14 +1791,15 @@ void ocfs2_rw_unlock(struct inode *inode, int write)
 {
 	int level = write ? DLM_LOCK_EX : DLM_LOCK_PR;
 	struct ocfs2_lock_res *lockres = &OCFS2_I(inode)->ip_rw_lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu drop %s RW lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno,
 	     write ? "EXMODE" : "PRMODE");
 
 	if (!ocfs2_mount_local(osb))
-		ocfs2_cluster_unlock(OCFS2_SB(inode->i_sb), lockres, level);
+		ocfs2_cluster_unlock(OCFS2_SB(inode_sb(inode)), lockres,
+				     level);
 }
 
 /*
@@ -1806,7 +1809,7 @@ int ocfs2_open_lock(struct inode *inode)
 {
 	int status = 0;
 	struct ocfs2_lock_res *lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu take PRMODE open lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno);
@@ -1816,7 +1819,7 @@ int ocfs2_open_lock(struct inode *inode)
 
 	lockres = &OCFS2_I(inode)->ip_open_lockres;
 
-	status = ocfs2_cluster_lock(OCFS2_SB(inode->i_sb), lockres,
+	status = ocfs2_cluster_lock(OCFS2_SB(inode_sb(inode)), lockres,
 				    DLM_LOCK_PR, 0, 0);
 	if (status < 0)
 		mlog_errno(status);
@@ -1829,7 +1832,7 @@ int ocfs2_try_open_lock(struct inode *inode, int write)
 {
 	int status = 0, level;
 	struct ocfs2_lock_res *lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu try to take %s open lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno,
@@ -1854,7 +1857,7 @@ int ocfs2_try_open_lock(struct inode *inode, int write)
 	 * other nodes and the -EAGAIN will indicate to the caller that
 	 * this inode is still in use.
 	 */
-	status = ocfs2_cluster_lock(OCFS2_SB(inode->i_sb), lockres,
+	status = ocfs2_cluster_lock(OCFS2_SB(inode_sb(inode)), lockres,
 				    level, DLM_LKF_NOQUEUE, 0);
 
 out:
@@ -1867,7 +1870,7 @@ int ocfs2_try_open_lock(struct inode *inode, int write)
 void ocfs2_open_unlock(struct inode *inode)
 {
 	struct ocfs2_lock_res *lockres = &OCFS2_I(inode)->ip_open_lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu drop open lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno);
@@ -1876,10 +1879,10 @@ void ocfs2_open_unlock(struct inode *inode)
 		goto out;
 
 	if(lockres->l_ro_holders)
-		ocfs2_cluster_unlock(OCFS2_SB(inode->i_sb), lockres,
+		ocfs2_cluster_unlock(OCFS2_SB(inode_sb(inode)), lockres,
 				     DLM_LOCK_PR);
 	if(lockres->l_ex_holders)
-		ocfs2_cluster_unlock(OCFS2_SB(inode->i_sb), lockres,
+		ocfs2_cluster_unlock(OCFS2_SB(inode_sb(inode)), lockres,
 				     DLM_LOCK_EX);
 
 out:
@@ -1961,7 +1964,7 @@ int ocfs2_file_lock(struct file *file, int ex, int trylock)
 	unsigned long flags;
 	struct ocfs2_file_private *fp = file->private_data;
 	struct ocfs2_lock_res *lockres = &fp->fp_flock;
-	struct ocfs2_super *osb = OCFS2_SB(file->f_mapping->host->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(file->f_mapping->host));
 	struct ocfs2_mask_waiter mw;
 
 	ocfs2_init_mask_waiter(&mw);
@@ -2057,7 +2060,7 @@ void ocfs2_file_unlock(struct file *file)
 	unsigned long flags;
 	struct ocfs2_file_private *fp = file->private_data;
 	struct ocfs2_lock_res *lockres = &fp->fp_flock;
-	struct ocfs2_super *osb = OCFS2_SB(file->f_mapping->host->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(file->f_mapping->host));
 	struct ocfs2_mask_waiter mw;
 
 	ocfs2_init_mask_waiter(&mw);
@@ -2297,7 +2300,7 @@ static int ocfs2_inode_lock_update(struct inode *inode,
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_dinode *fe;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (ocfs2_mount_local(osb))
 		goto bail;
@@ -2405,7 +2408,7 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 	int status, level, acquired;
 	u32 dlm_flags;
 	struct ocfs2_lock_res *lockres = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *local_bh = NULL;
 
 	mlog(0, "inode %llu, take %s META lock\n",
@@ -2595,15 +2598,16 @@ void ocfs2_inode_unlock(struct inode *inode,
 {
 	int level = ex ? DLM_LOCK_EX : DLM_LOCK_PR;
 	struct ocfs2_lock_res *lockres = &OCFS2_I(inode)->ip_inode_lockres;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	mlog(0, "inode %llu drop %s META lock\n",
 	     (unsigned long long)OCFS2_I(inode)->ip_blkno,
 	     ex ? "EXMODE" : "PRMODE");
 
-	if (!ocfs2_is_hard_readonly(OCFS2_SB(inode->i_sb)) &&
+	if (!ocfs2_is_hard_readonly(OCFS2_SB(inode_sb(inode))) &&
 	    !ocfs2_mount_local(osb))
-		ocfs2_cluster_unlock(OCFS2_SB(inode->i_sb), lockres, level);
+		ocfs2_cluster_unlock(OCFS2_SB(inode_sb(inode)), lockres,
+				     level);
 }
 
 /*
@@ -3468,21 +3472,21 @@ int ocfs2_drop_inode_locks(struct inode *inode)
 	/* No need to call ocfs2_mark_lockres_freeing here -
 	 * ocfs2_clear_inode has done it for us. */
 
-	err = ocfs2_drop_lock(OCFS2_SB(inode->i_sb),
+	err = ocfs2_drop_lock(OCFS2_SB(inode_sb(inode)),
 			      &OCFS2_I(inode)->ip_open_lockres);
 	if (err < 0)
 		mlog_errno(err);
 
 	status = err;
 
-	err = ocfs2_drop_lock(OCFS2_SB(inode->i_sb),
+	err = ocfs2_drop_lock(OCFS2_SB(inode_sb(inode)),
 			      &OCFS2_I(inode)->ip_inode_lockres);
 	if (err < 0)
 		mlog_errno(err);
 	if (err < 0 && !status)
 		status = err;
 
-	err = ocfs2_drop_lock(OCFS2_SB(inode->i_sb),
+	err = ocfs2_drop_lock(OCFS2_SB(inode_sb(inode)),
 			      &OCFS2_I(inode)->ip_rw_lockres);
 	if (err < 0)
 		mlog_errno(err);
diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index 9f88188060db..f54d262627ae 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -166,7 +166,7 @@ static struct dentry *ocfs2_get_parent(struct dentry *child)
 		goto bail_unlock;
 	}
 
-	parent = d_obtain_alias(ocfs2_iget(OCFS2_SB(dir->i_sb), blkno, 0, 0));
+	parent = d_obtain_alias(ocfs2_iget(OCFS2_SB(inode_sb(dir)), blkno, 0, 0));
 
 bail_unlock:
 	ocfs2_inode_unlock(dir, 0);
diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 06cb96462bf9..7b9b0bf66d0f 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -234,7 +234,7 @@ void ocfs2_extent_map_insert_rec(struct inode *inode,
 	struct ocfs2_extent_map_item ins;
 
 	ins.ei_cpos = le32_to_cpu(rec->e_cpos);
-	ins.ei_phys = ocfs2_blocks_to_clusters(inode->i_sb,
+	ins.ei_phys = ocfs2_blocks_to_clusters(inode_sb(inode),
 					       le64_to_cpu(rec->e_blkno));
 	ins.ei_clusters = le16_to_cpu(rec->e_leaf_clusters);
 	ins.ei_flags = rec->e_flags;
@@ -305,7 +305,7 @@ static int ocfs2_last_eb_is_empty(struct inode *inode,
 	el = &eb->h_list;
 
 	if (el->l_tree_depth) {
-		ocfs2_error(inode->i_sb,
+		ocfs2_error(inode_sb(inode),
 			    "Inode %lu has non zero tree depth in leaf block %llu\n",
 			    inode->i_ino,
 			    (unsigned long long)eb_bh->b_blocknr);
@@ -441,7 +441,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 		el = &eb->h_list;
 
 		if (el->l_tree_depth) {
-			ocfs2_error(inode->i_sb,
+			ocfs2_error(inode_sb(inode),
 				    "Inode %lu has non zero tree depth in leaf block %llu\n",
 				    inode->i_ino,
 				    (unsigned long long)eb_bh->b_blocknr);
@@ -476,7 +476,7 @@ static int ocfs2_get_clusters_nocache(struct inode *inode,
 	BUG_ON(v_cluster < le32_to_cpu(rec->e_cpos));
 
 	if (!rec->e_blkno) {
-		ocfs2_error(inode->i_sb,
+		ocfs2_error(inode_sb(inode),
 			    "Inode %lu has bad extent record (%u, %u, 0)\n",
 			    inode->i_ino,
 			    le32_to_cpu(rec->e_cpos),
@@ -565,7 +565,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
 		el = &eb->h_list;
 
 		if (el->l_tree_depth) {
-			ocfs2_error(inode->i_sb,
+			ocfs2_error(inode_sb(inode),
 				    "Inode %lu has non zero tree depth in xattr leaf block %llu\n",
 				    inode->i_ino,
 				    (unsigned long long)eb_bh->b_blocknr);
@@ -584,7 +584,7 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
 		BUG_ON(v_cluster < le32_to_cpu(rec->e_cpos));
 
 		if (!rec->e_blkno) {
-			ocfs2_error(inode->i_sb,
+			ocfs2_error(inode_sb(inode),
 				    "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
 				    inode->i_ino,
 				    le32_to_cpu(rec->e_cpos),
@@ -593,8 +593,8 @@ int ocfs2_xattr_get_clusters(struct inode *inode, u32 v_cluster,
 			goto out;
 		}
 		coff = v_cluster - le32_to_cpu(rec->e_cpos);
-		*p_cluster = ocfs2_blocks_to_clusters(inode->i_sb,
-						    le64_to_cpu(rec->e_blkno));
+		*p_cluster = ocfs2_blocks_to_clusters(inode_sb(inode),
+						      le64_to_cpu(rec->e_blkno));
 		*p_cluster = *p_cluster + coff;
 		if (num_clusters)
 			*num_clusters = ocfs2_rec_clusters(el, rec) - coff;
@@ -652,7 +652,8 @@ int ocfs2_get_clusters(struct inode *inode, u32 v_cluster,
 			*num_clusters = hole_len;
 		}
 	} else {
-		ocfs2_relative_extent_offsets(inode->i_sb, v_cluster, &rec,
+		ocfs2_relative_extent_offsets(inode_sb(inode), v_cluster,
+					      &rec,
 					      p_cluster, num_clusters);
 		flags = rec.e_flags;
 
@@ -675,11 +676,11 @@ int ocfs2_extent_map_get_blocks(struct inode *inode, u64 v_blkno, u64 *p_blkno,
 				u64 *ret_count, unsigned int *extent_flags)
 {
 	int ret;
-	int bpc = ocfs2_clusters_to_blocks(inode->i_sb, 1);
+	int bpc = ocfs2_clusters_to_blocks(inode_sb(inode), 1);
 	u32 cpos, num_clusters, p_cluster;
 	u64 boff = 0;
 
-	cpos = ocfs2_blocks_to_clusters(inode->i_sb, v_blkno);
+	cpos = ocfs2_blocks_to_clusters(inode_sb(inode), v_blkno);
 
 	ret = ocfs2_get_clusters(inode, cpos, &p_cluster, &num_clusters,
 				 extent_flags);
@@ -692,14 +693,15 @@ int ocfs2_extent_map_get_blocks(struct inode *inode, u64 v_blkno, u64 *p_blkno,
 	 * p_cluster == 0 indicates a hole.
 	 */
 	if (p_cluster) {
-		boff = ocfs2_clusters_to_blocks(inode->i_sb, p_cluster);
+		boff = ocfs2_clusters_to_blocks(inode_sb(inode), p_cluster);
 		boff += (v_blkno & (u64)(bpc - 1));
 	}
 
 	*p_blkno = boff;
 
 	if (ret_count) {
-		*ret_count = ocfs2_clusters_to_blocks(inode->i_sb, num_clusters);
+		*ret_count = ocfs2_clusters_to_blocks(inode_sb(inode),
+						      num_clusters);
 		*ret_count -= v_blkno & (u64)(bpc - 1);
 	}
 
@@ -726,12 +728,12 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	if (ocfs2_inode_is_fast_symlink(inode))
-		id_count = ocfs2_fast_symlink_chars(inode->i_sb);
+		id_count = ocfs2_fast_symlink_chars(inode_sb(inode));
 	else
 		id_count = le16_to_cpu(di->id2.i_data.id_count);
 
 	if (map_start < id_count) {
-		phys = oi->ip_blkno << inode->i_sb->s_blocksize_bits;
+		phys = oi->ip_blkno << inode_sb(inode)->s_blocksize_bits;
 		if (ocfs2_inode_is_fast_symlink(inode))
 			phys += offsetof(struct ocfs2_dinode, id2.i_symlink);
 		else
@@ -755,7 +757,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int ret, is_last;
 	u32 mapping_end, cpos;
 	unsigned int hole_size;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	u64 len_bytes, phys_bytes, virt_bytes;
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_extent_rec rec;
@@ -782,7 +784,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	cpos = map_start >> osb->s_clustersize_bits;
-	mapping_end = ocfs2_clusters_for_bytes(inode->i_sb,
+	mapping_end = ocfs2_clusters_for_bytes(inode_sb(inode),
 					       map_start + map_len);
 	is_last = 0;
 	while (cpos < mapping_end && !is_last) {
@@ -839,7 +841,7 @@ int ocfs2_overwrite_io(struct inode *inode, struct buffer_head *di_bh,
 {
 	int ret = 0, is_last;
 	u32 mapping_end, cpos;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_extent_rec rec;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
@@ -850,7 +852,7 @@ int ocfs2_overwrite_io(struct inode *inode, struct buffer_head *di_bh,
 	}
 
 	cpos = map_start >> osb->s_clustersize_bits;
-	mapping_end = ocfs2_clusters_for_bytes(inode->i_sb,
+	mapping_end = ocfs2_clusters_for_bytes(inode_sb(inode),
 					       map_start + map_len);
 	is_last = 0;
 	while (cpos < mapping_end && !is_last) {
@@ -882,7 +884,7 @@ int ocfs2_seek_data_hole_offset(struct file *file, loff_t *offset, int whence)
 	struct inode *inode = file->f_mapping->host;
 	int ret;
 	unsigned int is_last = 0, is_data = 0;
-	u16 cs_bits = OCFS2_SB(inode->i_sb)->s_clustersize_bits;
+	u16 cs_bits = OCFS2_SB(inode_sb(inode))->s_clustersize_bits;
 	u32 cpos, cend, clen, hole_size;
 	u64 extoff, extlen;
 	struct buffer_head *di_bh = NULL;
@@ -911,7 +913,7 @@ int ocfs2_seek_data_hole_offset(struct file *file, loff_t *offset, int whence)
 
 	clen = 0;
 	cpos = *offset >> cs_bits;
-	cend = ocfs2_clusters_for_bytes(inode->i_sb, i_size_read(inode));
+	cend = ocfs2_clusters_for_bytes(inode_sb(inode), i_size_read(inode));
 
 	while (cpos < cend && !is_last) {
 		ret = ocfs2_get_clusters_nocache(inode, di_bh, cpos, &hole_size,
@@ -984,7 +986,7 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	     inode, (unsigned long long)v_block, nr, bhs, flags,
 	     validate);
 
-	if (((v_block + nr - 1) << inode->i_sb->s_blocksize_bits) >=
+	if (((v_block + nr - 1) << inode_sb(inode)->s_blocksize_bits) >=
 	    i_size_read(inode)) {
 		BUG_ON(!(flags & OCFS2_BH_READAHEAD));
 		goto out;
@@ -1006,7 +1008,7 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 			     "Inode #%llu contains a hole at offset %llu\n",
 			     (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			     (unsigned long long)(v_block + done) <<
-			     inode->i_sb->s_blocksize_bits);
+			     inode_sb(inode)->s_blocksize_bits);
 			break;
 		}
 
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 5d1784a365a3..b41f89b0f814 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -84,7 +84,7 @@ static int ocfs2_init_file_private(struct inode *inode, struct file *file)
 static void ocfs2_free_file_private(struct inode *inode, struct file *file)
 {
 	struct ocfs2_file_private *fp = file->private_data;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (fp) {
 		ocfs2_simple_drop_lockres(osb, &fp->fp_flock);
@@ -182,7 +182,7 @@ static int ocfs2_sync_file(struct file *file, loff_t start, loff_t end,
 {
 	int err = 0;
 	struct inode *inode = file->f_mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	journal_t *journal = osb->journal->j_journal;
 	int ret;
@@ -208,7 +208,8 @@ static int ocfs2_sync_file(struct file *file, loff_t start, loff_t end,
 		needs_barrier = true;
 	err = jbd2_complete_transaction(journal, commit_tid);
 	if (needs_barrier) {
-		ret = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		ret = blkdev_issue_flush(inode_sb(inode)->s_bdev, GFP_KERNEL,
+					 NULL);
 		if (!err)
 			err = ret;
 	}
@@ -223,13 +224,13 @@ int ocfs2_should_update_atime(struct inode *inode,
 			      struct vfsmount *vfsmnt)
 {
 	struct timespec now;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (ocfs2_is_hard_readonly(osb) || ocfs2_is_soft_readonly(osb))
 		return 0;
 
 	if ((inode->i_flags & S_NOATIME) ||
-	    ((inode->i_sb->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode)))
+	    ((inode_sb(inode)->s_flags & SB_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		return 0;
 
 	/*
@@ -266,7 +267,7 @@ int ocfs2_update_inode_atime(struct inode *inode,
 			     struct buffer_head *bh)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	handle_t *handle;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *) bh->b_data;
 
@@ -296,7 +297,7 @@ int ocfs2_update_inode_atime(struct inode *inode,
 	ocfs2_journal_dirty(handle, bh);
 
 out_commit:
-	ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
+	ocfs2_commit_trans(OCFS2_SB(inode_sb(inode)), handle);
 out:
 	return ret;
 }
@@ -327,7 +328,7 @@ int ocfs2_simple_size_update(struct inode *inode,
 			     u64 new_i_size)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	handle_t *handle = NULL;
 
 	handle = ocfs2_start_trans(osb, OCFS2_INODE_UPDATE_CREDITS);
@@ -353,7 +354,7 @@ static int ocfs2_cow_file_pos(struct inode *inode,
 			      u64 offset)
 {
 	int status;
-	u32 phys, cpos = offset >> OCFS2_SB(inode->i_sb)->s_clustersize_bits;
+	u32 phys, cpos = offset >> OCFS2_SB(inode_sb(inode))->s_clustersize_bits;
 	unsigned int num_clusters = 0;
 	unsigned int ext_flags = 0;
 
@@ -362,7 +363,7 @@ static int ocfs2_cow_file_pos(struct inode *inode,
 	 * no space for ocfs2_zero_range_for_truncate to fill, so no need to
 	 * CoW either.
 	 */
-	if ((offset & (OCFS2_SB(inode->i_sb)->s_clustersize - 1)) == 0)
+	if ((offset & (OCFS2_SB(inode_sb(inode))->s_clustersize - 1)) == 0)
 		return 0;
 
 	status = ocfs2_get_clusters(inode, cpos, &phys,
@@ -422,7 +423,8 @@ static int ocfs2_orphan_for_truncate(struct ocfs2_super *osb,
 	/*
 	 * Do this before setting i_size.
 	 */
-	cluster_bytes = ocfs2_align_bytes_to_clusters(inode->i_sb, new_i_size);
+	cluster_bytes = ocfs2_align_bytes_to_clusters(inode_sb(inode),
+						      new_i_size);
 	status = ocfs2_zero_range_for_truncate(inode, handle, new_i_size,
 					       cluster_bytes);
 	if (status) {
@@ -453,7 +455,7 @@ int ocfs2_truncate_file(struct inode *inode,
 {
 	int status = 0;
 	struct ocfs2_dinode *fe = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	/* We trust di_bh because it comes from ocfs2_inode_lock(), which
 	 * already validated it */
@@ -576,7 +578,7 @@ static int __ocfs2_extend_allocation(struct inode *inode, u32 logical_start,
 	struct ocfs2_alloc_context *data_ac = NULL;
 	struct ocfs2_alloc_context *meta_ac = NULL;
 	enum ocfs2_alloc_restarted why = RESTART_NONE;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_extent_tree et;
 	int did_quota = 0;
 
@@ -722,7 +724,7 @@ static int __ocfs2_extend_allocation(struct inode *inode, u32 logical_start,
 static handle_t *ocfs2_zero_start_ordered_transaction(struct inode *inode,
 						struct buffer_head *di_bh)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	handle_t *handle = NULL;
 	int ret = 0;
 
@@ -849,7 +851,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 	put_page(page);
 out_commit_trans:
 	if (handle)
-		ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
+		ocfs2_commit_trans(OCFS2_SB(inode_sb(inode)), handle);
 out:
 	return ret;
 }
@@ -874,8 +876,8 @@ static int ocfs2_zero_extend_get_range(struct inode *inode,
 	int rc = 0, needs_cow = 0;
 	u32 p_cpos, zero_clusters = 0;
 	u32 zero_cpos =
-		zero_start >> OCFS2_SB(inode->i_sb)->s_clustersize_bits;
-	u32 last_cpos = ocfs2_clusters_for_bytes(inode->i_sb, zero_end);
+		zero_start >> OCFS2_SB(inode_sb(inode))->s_clustersize_bits;
+	u32 last_cpos = ocfs2_clusters_for_bytes(inode_sb(inode), zero_end);
 	unsigned int num_clusters = 0;
 	unsigned int ext_flags = 0;
 
@@ -928,8 +930,8 @@ static int ocfs2_zero_extend_get_range(struct inode *inode,
 		}
 	}
 
-	*range_start = ocfs2_clusters_to_bytes(inode->i_sb, zero_cpos);
-	*range_end = ocfs2_clusters_to_bytes(inode->i_sb,
+	*range_start = ocfs2_clusters_to_bytes(inode_sb(inode), zero_cpos);
+	*range_end = ocfs2_clusters_to_bytes(inode_sb(inode),
 					     zero_cpos + zero_clusters);
 
 out:
@@ -979,7 +981,7 @@ int ocfs2_zero_extend(struct inode *inode, struct buffer_head *di_bh,
 {
 	int ret = 0;
 	u64 zero_start, range_start = 0, range_end = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	zero_start = ocfs2_align_bytes_to_blocks(sb, i_size_read(inode));
 	trace_ocfs2_zero_extend((unsigned long long)OCFS2_I(inode)->ip_blkno,
@@ -1028,7 +1030,8 @@ int ocfs2_extend_no_holes(struct inode *inode, struct buffer_head *di_bh,
 	BUG_ON(!di_bh && ocfs2_is_refcount_inode(inode));
 	BUG_ON(!di_bh && !(oi->ip_flags & OCFS2_INODE_SYSTEM_FILE));
 
-	clusters_to_add = ocfs2_clusters_for_bytes(inode->i_sb, new_i_size);
+	clusters_to_add = ocfs2_clusters_for_bytes(inode_sb(inode),
+						   new_i_size);
 	if (clusters_to_add < oi->ip_clusters)
 		clusters_to_add = 0;
 	else
@@ -1100,7 +1103,7 @@ static int ocfs2_extend_file(struct inode *inode,
 		}
 	}
 
-	if (ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)))
+	if (ocfs2_sparse_alloc(OCFS2_SB(inode_sb(inode))))
 		ret = ocfs2_zero_extend(inode, di_bh, new_i_size);
 	else
 		ret = ocfs2_extend_no_holes(inode, di_bh, new_i_size,
@@ -1127,7 +1130,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	int status = 0, size_change;
 	int inode_locked = 0;
 	struct inode *inode = d_inode(dentry);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ocfs2_super *osb = OCFS2_SB(sb);
 	struct buffer_head *bh = NULL;
 	handle_t *handle = NULL;
@@ -1375,7 +1378,7 @@ static int __ocfs2_write_remove_suid(struct inode *inode,
 {
 	int ret;
 	handle_t *handle;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di;
 
 	trace_ocfs2_write_remove_suid(
@@ -1466,8 +1469,8 @@ static int ocfs2_allocate_unwritten_extents(struct inode *inode,
 	/*
 	 * We consider both start and len to be inclusive.
 	 */
-	cpos = start >> OCFS2_SB(inode->i_sb)->s_clustersize_bits;
-	clusters = ocfs2_clusters_for_bytes(inode->i_sb, start + len);
+	cpos = start >> OCFS2_SB(inode_sb(inode))->s_clustersize_bits;
+	clusters = ocfs2_clusters_for_bytes(inode_sb(inode), start + len);
 	clusters -= cpos;
 
 	while (clusters) {
@@ -1519,11 +1522,12 @@ static int ocfs2_allocate_unwritten_extents(struct inode *inode,
 static void ocfs2_truncate_cluster_pages(struct inode *inode, u64 byte_start,
 					 u64 byte_len)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	loff_t start, end;
 	struct address_space *mapping = inode->i_mapping;
 
-	start = (loff_t)ocfs2_align_bytes_to_clusters(inode->i_sb, byte_start);
+	start = (loff_t)ocfs2_align_bytes_to_clusters(inode_sb(inode),
+						      byte_start);
 	end = byte_start + byte_len;
 	end = end & ~(osb->s_clustersize - 1);
 
@@ -1539,7 +1543,7 @@ static int ocfs2_zero_partial_clusters(struct inode *inode,
 	int ret = 0;
 	u64 tmpend = 0;
 	u64 end = start + len;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	unsigned int csize = osb->s_clustersize;
 	handle_t *handle;
 
@@ -1681,7 +1685,8 @@ static void ocfs2_calc_trunc_pos(struct inode *inode,
 		*trunc_len = *trunc_end - trunc_start;
 		coff = trunc_start - le32_to_cpu(rec->e_cpos);
 		*blkno = le64_to_cpu(rec->e_blkno) +
-				ocfs2_clusters_to_blocks(inode->i_sb, coff);
+				ocfs2_clusters_to_blocks(inode_sb(inode),
+							 coff);
 		*trunc_end = trunc_start;
 	} else {
 		/*
@@ -1705,7 +1710,7 @@ int ocfs2_remove_inode_range(struct inode *inode,
 	int ret = 0, flags = 0, done = 0, i;
 	u32 trunc_start, trunc_len, trunc_end, trunc_cpos, phys_cpos;
 	u32 cluster_in_el;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_cached_dealloc_ctxt dealloc;
 	struct address_space *mapping = inode->i_mapping;
 	struct ocfs2_extent_tree et;
@@ -1800,7 +1805,7 @@ int ocfs2_remove_inode_range(struct inode *inode,
 			if (path->p_tree_depth == 0)
 				break;
 
-			ret = ocfs2_find_cpos_for_left_leaf(inode->i_sb,
+			ret = ocfs2_find_cpos_for_left_leaf(inode_sb(inode),
 							    path,
 							    &cluster_in_el);
 			if (ret) {
@@ -1834,7 +1839,7 @@ int ocfs2_remove_inode_range(struct inode *inode,
 			break;
 
 		flags = rec->e_flags;
-		phys_cpos = ocfs2_blocks_to_clusters(inode->i_sb, blkno);
+		phys_cpos = ocfs2_blocks_to_clusters(inode_sb(inode), blkno);
 
 		ret = ocfs2_remove_btree_range(inode, &et, trunc_cpos,
 					       phys_cpos, trunc_len, flags,
@@ -1870,10 +1875,10 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 	int ret;
 	s64 llen;
 	loff_t size;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *di_bh = NULL;
 	handle_t *handle;
-	unsigned long long max_off = inode->i_sb->s_maxbytes;
+	unsigned long long max_off = inode_sb(inode)->s_maxbytes;
 
 	if (ocfs2_is_hard_readonly(osb) || ocfs2_is_soft_readonly(osb))
 		return -EROFS;
@@ -2005,7 +2010,7 @@ int ocfs2_change_file_space(struct file *file, unsigned int cmd,
 			    struct ocfs2_space_resv *sr)
 {
 	struct inode *inode = file_inode(file);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	int ret;
 
 	if ((cmd == OCFS2_IOC_RESVSP || cmd == OCFS2_IOC_RESVSP64) &&
@@ -2033,7 +2038,7 @@ static long ocfs2_fallocate(struct file *file, int mode, loff_t offset,
 			    loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_space_resv sr;
 	int change_size = 1;
 	int cmd = OCFS2_IOC_RESVSP64;
@@ -2063,9 +2068,9 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
 	int ret = 0;
 	unsigned int extent_flags;
 	u32 cpos, clusters, extent_len, phys_cpos;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb)) ||
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode))) ||
 	    !ocfs2_is_refcount_inode(inode) ||
 	    OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL)
 		return 0;
@@ -2098,7 +2103,7 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
 
 static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
 {
-	int blockmask = inode->i_sb->s_blocksize - 1;
+	int blockmask = inode_sb(inode)->s_blocksize - 1;
 	loff_t final_size = pos + count;
 
 	if ((pos & blockmask) || (final_size & blockmask))
@@ -2113,9 +2118,9 @@ static int ocfs2_prepare_inode_for_refcount(struct inode *inode,
 {
 	int ret;
 	struct buffer_head *di_bh = NULL;
-	u32 cpos = pos >> OCFS2_SB(inode->i_sb)->s_clustersize_bits;
+	u32 cpos = pos >> OCFS2_SB(inode_sb(inode))->s_clustersize_bits;
 	u32 clusters =
-		ocfs2_clusters_for_bytes(inode->i_sb, pos + count) - cpos;
+		ocfs2_clusters_for_bytes(inode_sb(inode), pos + count) - cpos;
 
 	ret = ocfs2_inode_lock(inode, &di_bh, 1);
 	if (ret) {
@@ -2248,7 +2253,7 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 	size_t count = iov_iter_count(from);
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	int full_coherency = !(osb->s_mount_opt &
 			       OCFS2_MOUNT_COHERENCY_BUFFERED);
 	void *saved_ki_complete = NULL;
@@ -2518,7 +2523,7 @@ static loff_t ocfs2_file_llseek(struct file *file, loff_t offset, int whence)
 		goto out;
 	}
 
-	offset = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+	offset = vfs_setpos(file, offset, inode_sb(inode)->s_maxbytes);
 
 out:
 	inode_unlock(inode);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index d51b80edd972..ebceb88328ee 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -280,7 +280,7 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
 	struct ocfs2_super *osb;
 	int use_plocks = 1;
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	osb = OCFS2_SB(sb);
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
@@ -383,8 +383,8 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
 	}
 
 	if (create_ino) {
-		inode->i_ino = ino_from_blkno(inode->i_sb,
-			       le64_to_cpu(fe->i_blkno));
+		inode->i_ino = ino_from_blkno(inode_sb(inode),
+				              le64_to_cpu(fe->i_blkno));
 
 		/*
 		 * If we ever want to create system files from kernel,
@@ -425,7 +425,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 	u32 generation = 0;
 
 	status = -EINVAL;
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	osb = OCFS2_SB(sb);
 
 	/*
@@ -658,7 +658,7 @@ static int ocfs2_remove_inode(struct inode *inode,
 	struct inode *inode_alloc_inode = NULL;
 	struct buffer_head *inode_alloc_bh = NULL;
 	handle_t *handle;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *) di_bh->b_data;
 
 	inode_alloc_inode =
@@ -680,7 +680,7 @@ static int ocfs2_remove_inode(struct inode *inode,
 	}
 
 	handle = ocfs2_start_trans(osb, OCFS2_DELETE_INODE_CREDITS +
-				   ocfs2_quota_trans_credits(inode->i_sb));
+				   ocfs2_quota_trans_credits(inode_sb(inode)));
 	if (IS_ERR(handle)) {
 		status = PTR_ERR(handle);
 		mlog_errno(status);
@@ -769,7 +769,7 @@ static int ocfs2_wipe_inode(struct inode *inode,
 	int status, orphaned_slot = -1;
 	struct inode *orphan_dir_inode = NULL;
 	struct buffer_head *orphan_dir_bh = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *) di_bh->b_data;
 
 	if (!(OCFS2_I(inode)->ip_flags & OCFS2_INODE_SKIP_ORPHAN_DIR)) {
@@ -858,7 +858,7 @@ static int ocfs2_inode_is_valid_to_delete(struct inode *inode)
 {
 	int ret = 0;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	trace_ocfs2_inode_is_valid_to_delete(current, osb->dc_task,
 					     (unsigned long long)oi->ip_blkno,
@@ -1045,7 +1045,7 @@ static void ocfs2_delete_inode(struct inode *inode)
 	 * shared mode so that all nodes can still concurrently
 	 * process deletes.
 	 */
-	status = ocfs2_nfs_sync_lock(OCFS2_SB(inode->i_sb), 0);
+	status = ocfs2_nfs_sync_lock(OCFS2_SB(inode_sb(inode)), 0);
 	if (status < 0) {
 		mlog(ML_ERROR, "getting nfs sync lock(PR) failed %d\n", status);
 		ocfs2_cleanup_delete_inode(inode, 0);
@@ -1117,7 +1117,7 @@ static void ocfs2_delete_inode(struct inode *inode)
 	brelse(di_bh);
 
 bail_unlock_nfs_sync:
-	ocfs2_nfs_sync_unlock(OCFS2_SB(inode->i_sb), 0);
+	ocfs2_nfs_sync_unlock(OCFS2_SB(inode_sb(inode)), 0);
 
 bail_unblock:
 	ocfs2_unblock_signals(&oldset);
@@ -1129,13 +1129,13 @@ static void ocfs2_clear_inode(struct inode *inode)
 {
 	int status;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	clear_inode(inode);
 	trace_ocfs2_clear_inode((unsigned long long)oi->ip_blkno,
 				inode->i_nlink);
 
-	mlog_bug_on_msg(OCFS2_SB(inode->i_sb) == NULL,
+	mlog_bug_on_msg(OCFS2_SB(inode_sb(inode)) == NULL,
 			"Inode=%lu\n", inode->i_ino);
 
 	dquot_drop(inode);
@@ -1150,7 +1150,7 @@ static void ocfs2_clear_inode(struct inode *inode)
 	ocfs2_mark_lockres_freeing(osb, &oi->ip_inode_lockres);
 	ocfs2_mark_lockres_freeing(osb, &oi->ip_open_lockres);
 
-	ocfs2_resv_discard(&OCFS2_SB(inode->i_sb)->osb_la_resmap,
+	ocfs2_resv_discard(&OCFS2_SB(inode_sb(inode))->osb_la_resmap,
 			   &oi->ip_la_data_resv);
 	ocfs2_resv_init_once(&oi->ip_la_data_resv);
 
@@ -1223,7 +1223,7 @@ static void ocfs2_clear_inode(struct inode *inode)
 	 * the journal is flushed before journal shutdown. Thus it is safe to
 	 * have inodes get cleaned up after journal shutdown.
 	 */
-	jbd2_journal_release_jbd_inode(OCFS2_SB(inode->i_sb)->journal->j_journal,
+	jbd2_journal_release_jbd_inode(OCFS2_SB(inode_sb(inode))->journal->j_journal,
 				       &oi->ip_jinode);
 }
 
@@ -1636,7 +1636,7 @@ static struct super_block *ocfs2_inode_cache_get_super(struct ocfs2_caching_info
 {
 	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
 
-	return oi->vfs_inode.i_sb;
+	return inode_sb(&oi->vfs_inode);
 }
 
 static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
index 9b955f732bca..740204816ff7 100644
--- a/fs/ocfs2/inode.h
+++ b/fs/ocfs2/inode.h
@@ -158,7 +158,7 @@ void ocfs2_get_inode_flags(struct ocfs2_inode_info *oi);
 
 static inline blkcnt_t ocfs2_inode_sector_count(struct inode *inode)
 {
-	int c_to_s_bits = OCFS2_SB(inode->i_sb)->s_clustersize_bits - 9;
+	int c_to_s_bits = OCFS2_SB(inode_sb(inode))->s_clustersize_bits - 9;
 
 	return (blkcnt_t)OCFS2_I(inode)->ip_clusters << c_to_s_bits;
 }
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index ab30c005cc4b..9be6d9d1390d 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -81,7 +81,7 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 				unsigned mask)
 {
 	struct ocfs2_inode_info *ocfs2_inode = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	handle_t *handle = NULL;
 	struct buffer_head *bh = NULL;
 	unsigned oldflags;
@@ -151,7 +151,7 @@ static int ocfs2_info_handle_blocksize(struct inode *inode,
 	if (o2info_from_user(oib, req))
 		return -EFAULT;
 
-	oib.ib_blocksize = inode->i_sb->s_blocksize;
+	oib.ib_blocksize = inode_sb(inode)->s_blocksize;
 
 	o2info_set_request_filled(&oib.ib_req);
 
@@ -165,7 +165,7 @@ static int ocfs2_info_handle_clustersize(struct inode *inode,
 					 struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_clustersize oic;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oic, req))
 		return -EFAULT;
@@ -184,7 +184,7 @@ static int ocfs2_info_handle_maxslots(struct inode *inode,
 				      struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_maxslots oim;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oim, req))
 		return -EFAULT;
@@ -203,7 +203,7 @@ static int ocfs2_info_handle_label(struct inode *inode,
 				   struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_label oil;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oil, req))
 		return -EFAULT;
@@ -222,7 +222,7 @@ static int ocfs2_info_handle_uuid(struct inode *inode,
 				  struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_uuid oiu;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oiu, req))
 		return -EFAULT;
@@ -241,7 +241,7 @@ static int ocfs2_info_handle_fs_features(struct inode *inode,
 					 struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_fs_features oif;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oif, req))
 		return -EFAULT;
@@ -262,7 +262,7 @@ static int ocfs2_info_handle_journal_size(struct inode *inode,
 					  struct ocfs2_info_request __user *req)
 {
 	struct ocfs2_info_journal_size oij;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (o2info_from_user(oij, req))
 		return -EFAULT;
@@ -333,7 +333,7 @@ static int ocfs2_info_handle_freeinode(struct inode *inode,
 	char namebuf[40];
 	int status, type = INODE_ALLOC_SYSTEM_INODE;
 	struct ocfs2_info_freeinode *oifi = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *inode_alloc = NULL;
 
 	oifi = kzalloc(sizeof(struct ocfs2_info_freeinode), GFP_KERNEL);
@@ -621,7 +621,7 @@ static int ocfs2_info_handle_freefrag(struct inode *inode,
 	int status, type = GLOBAL_BITMAP_SYSTEM_INODE;
 
 	struct ocfs2_info_freefrag *oiff;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *gb_inode = NULL;
 
 	oiff = kzalloc(sizeof(struct ocfs2_info_freefrag), GFP_KERNEL);
@@ -924,7 +924,7 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ocfs2_info_handle(inode, &info, 0);
 	case FITRIM:
 	{
-		struct super_block *sb = inode->i_sb;
+		struct super_block *sb = inode_sb(inode);
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 		struct fstrim_range range;
 		int ret = 0;
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index e5dcea6cee5f..e0047816c7b7 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1161,9 +1161,10 @@ static int ocfs2_force_read_journal(struct inode *inode)
 	int i;
 	u64 v_blkno, p_blkno, p_blocks, num_blocks;
 	struct buffer_head *bh = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
-	num_blocks = ocfs2_blocks_for_bytes(inode->i_sb, i_size_read(inode));
+	num_blocks = ocfs2_blocks_for_bytes(inode_sb(inode),
+					    i_size_read(inode));
 	v_blkno = 0;
 	while (v_blkno < num_blocks) {
 		status = ocfs2_extent_map_get_blocks(inode, v_blkno,
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index 497a4171ef61..504560ccfa94 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -205,7 +205,7 @@ static inline void ocfs2_start_checkpoint(struct ocfs2_super *osb)
 
 static inline void ocfs2_checkpoint_inode(struct inode *inode)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (ocfs2_mount_local(osb))
 		return;
@@ -626,7 +626,7 @@ static inline int ocfs2_begin_ordered_truncate(struct inode *inode,
 					       loff_t new_size)
 {
 	return jbd2_journal_begin_ordered_truncate(
-				OCFS2_SB(inode->i_sb)->journal->j_journal,
+				OCFS2_SB(inode_sb(inode))->journal->j_journal,
 				&OCFS2_I(inode)->ip_jinode,
 				new_size);
 }
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index fe0d1f9571bb..579b6a5848aa 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -330,7 +330,7 @@ int ocfs2_load_local_alloc(struct ocfs2_super *osb)
 	}
 
 	if ((la->la_size == 0) ||
-	    (le16_to_cpu(la->la_size) > ocfs2_local_alloc_size(inode->i_sb))) {
+	    (le16_to_cpu(la->la_size) > ocfs2_local_alloc_size(inode_sb(inode)))) {
 		mlog(ML_ERROR, "Local alloc size is invalid (la_size = %u)\n",
 		     le16_to_cpu(la->la_size));
 		status = -EINVAL;
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index d56f0079b858..91888b521133 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -113,7 +113,7 @@ static int ocfs2_do_funlock(struct file *file, int cmd, struct file_lock *fl)
 int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
@@ -133,7 +133,7 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 int ocfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index fb9a20e3d608..83aa18171e29 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -136,7 +136,7 @@ static int ocfs2_page_mkwrite(struct vm_fault *vmf)
 	sigset_t oldset;
 	int ret;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 	ocfs2_block_signals(&oldset);
 
 	/*
@@ -170,7 +170,7 @@ static int ocfs2_page_mkwrite(struct vm_fault *vmf)
 
 out:
 	ocfs2_unblock_signals(&oldset);
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 7eb3b0a6347e..c652bd0a0d8a 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -62,12 +62,12 @@ static int __ocfs2_move_extent(handle_t *handle,
 {
 	int ret = 0, index;
 	struct inode *inode = context->inode;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_extent_rec *rec, replace_rec;
 	struct ocfs2_path *path = NULL;
 	struct ocfs2_extent_list *el;
 	u64 ino = ocfs2_metadata_cache_owner(context->et.et_ci);
-	u64 old_blkno = ocfs2_clusters_to_blocks(inode->i_sb, p_cpos);
+	u64 old_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), p_cpos);
 
 	ret = ocfs2_duplicate_clusters_by_page(handle, inode, cpos,
 					       p_cpos, new_p_cpos, len);
@@ -79,7 +79,7 @@ static int __ocfs2_move_extent(handle_t *handle,
 	memset(&replace_rec, 0, sizeof(replace_rec));
 	replace_rec.e_cpos = cpu_to_le32(cpos);
 	replace_rec.e_leaf_clusters = cpu_to_le16(len);
-	replace_rec.e_blkno = cpu_to_le64(ocfs2_clusters_to_blocks(inode->i_sb,
+	replace_rec.e_blkno = cpu_to_le64(ocfs2_clusters_to_blocks(inode_sb(inode),
 								   new_p_cpos));
 
 	path = ocfs2_new_path_from_et(&context->et);
@@ -99,7 +99,7 @@ static int __ocfs2_move_extent(handle_t *handle,
 
 	index = ocfs2_search_extent_list(el, cpos);
 	if (index == -1) {
-		ret = ocfs2_error(inode->i_sb,
+		ret = ocfs2_error(inode_sb(inode),
 				  "Inode %llu has an extent at cpos %u which can no longer be found\n",
 				  (unsigned long long)ino, cpos);
 		goto out;
@@ -173,7 +173,7 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
 {
 	int ret, num_free_extents;
 	unsigned int max_recs_needed = 2 * extents_to_split + clusters_to_move;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	num_free_extents = ocfs2_num_free_extents(et);
 	if (num_free_extents < 0) {
@@ -228,11 +228,11 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 	int ret, credits = 0, extra_blocks = 0, partial = context->partial;
 	handle_t *handle;
 	struct inode *inode = context->inode;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *tl_inode = osb->osb_tl_inode;
 	struct ocfs2_refcount_tree *ref_tree = NULL;
 	u32 new_phys_cpos, new_len;
-	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+	u64 phys_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), phys_cpos);
 
 	if ((ext_flags & OCFS2_EXT_REFCOUNTED) && *len) {
 		BUG_ON(!ocfs2_is_refcount_inode(inode));
@@ -327,7 +327,8 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 	 * Here we should write the new page out first if we are
 	 * in write-back mode.
 	 */
-	ret = ocfs2_cow_sync_writeback(inode->i_sb, context->inode, cpos, *len);
+	ret = ocfs2_cow_sync_writeback(inode_sb(inode), context->inode, cpos,
+				       *len);
 	if (ret)
 		mlog_errno(ret);
 
@@ -367,7 +368,7 @@ static int ocfs2_find_victim_alloc_group(struct inode *inode,
 	u64 blkno;
 	char namebuf[40];
 
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *ac_bh = NULL, *gd_bh = NULL;
 	struct ocfs2_chain_list *cl;
 	struct ocfs2_chain_rec *rec;
@@ -394,7 +395,7 @@ static int ocfs2_find_victim_alloc_group(struct inode *inode,
 
 	if (type == GLOBAL_BITMAP_SYSTEM_INODE)
 		bits_per_unit = osb->s_clustersize_bits -
-					inode->i_sb->s_blocksize_bits;
+					inode_sb(inode)->s_blocksize_bits;
 	/*
 	 * 'vict_blkno' was out of the valid range.
 	 */
@@ -468,14 +469,14 @@ static int ocfs2_validate_and_adjust_move_goal(struct inode *inode,
 
 	struct buffer_head *gd_bh = NULL;
 	struct ocfs2_group_desc *bg;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	int c_to_b = 1 << (osb->s_clustersize_bits -
-					inode->i_sb->s_blocksize_bits);
+					inode_sb(inode)->s_blocksize_bits);
 
 	/*
 	 * make goal become cluster aligned.
 	 */
-	range->me_goal = ocfs2_block_to_cluster_start(inode->i_sb,
+	range->me_goal = ocfs2_block_to_cluster_start(inode_sb(inode),
 						      range->me_goal);
 	/*
 	 * validate goal sits within global_bitmap, and return the victim
@@ -524,7 +525,7 @@ static void ocfs2_probe_alloc_group(struct inode *inode, struct buffer_head *bh,
 {
 	int i, used, last_free_bits = 0, base_bit = *goal_bit;
 	struct ocfs2_group_desc *gd = (struct ocfs2_group_desc *)bh->b_data;
-	u32 base_cpos = ocfs2_blocks_to_clusters(inode->i_sb,
+	u32 base_cpos = ocfs2_blocks_to_clusters(inode_sb(inode),
 						 le64_to_cpu(gd->bg_blkno));
 
 	for (i = base_bit; i < le16_to_cpu(gd->bg_bits); i++) {
@@ -564,18 +565,18 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 	int ret, credits = 0, extra_blocks = 0, goal_bit = 0;
 	handle_t *handle;
 	struct inode *inode = context->inode;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *tl_inode = osb->osb_tl_inode;
 	struct inode *gb_inode = NULL;
 	struct buffer_head *gb_bh = NULL;
 	struct buffer_head *gd_bh = NULL;
 	struct ocfs2_group_desc *gd;
 	struct ocfs2_refcount_tree *ref_tree = NULL;
-	u32 move_max_hop = ocfs2_blocks_to_clusters(inode->i_sb,
+	u32 move_max_hop = ocfs2_blocks_to_clusters(inode_sb(inode),
 						    context->range->me_threshold);
 	u64 phys_blkno, new_phys_blkno;
 
-	phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+	phys_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), phys_cpos);
 
 	if ((ext_flags & OCFS2_EXT_REFCOUNTED) && len) {
 		BUG_ON(!ocfs2_is_refcount_inode(inode));
@@ -643,7 +644,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 		goto out_unlock_tl_inode;
 	}
 
-	new_phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, *new_phys_cpos);
+	new_phys_blkno = ocfs2_clusters_to_blocks(inode_sb(inode),
+						  *new_phys_cpos);
 	ret = ocfs2_find_victim_alloc_group(inode, new_phys_blkno,
 					    GLOBAL_BITMAP_SYSTEM_INODE,
 					    OCFS2_INVALID_SLOT,
@@ -693,7 +695,8 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
 	 * Here we should write the new page out first if we are
 	 * in write-back mode.
 	 */
-	ret = ocfs2_cow_sync_writeback(inode->i_sb, context->inode, cpos, len);
+	ret = ocfs2_cow_sync_writeback(inode_sb(inode), context->inode, cpos,
+				       len);
 	if (ret)
 		mlog_errno(ret);
 
@@ -762,7 +765,7 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 	struct inode *inode = context->inode;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_move_extents *range = context->range;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if ((i_size_read(inode) == 0) || (range->me_len == 0))
 		return 0;
@@ -801,7 +804,7 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 		if (defrag_thresh <= 1)
 			goto done;
 	} else
-		new_phys_cpos = ocfs2_blocks_to_clusters(inode->i_sb,
+		new_phys_cpos = ocfs2_blocks_to_clusters(inode_sb(inode),
 							 range->me_goal);
 
 	mlog(0, "Inode: %llu, start: %llu, len: %llu, cstart: %u, clen: %u, "
@@ -894,7 +897,7 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 	struct inode *inode = context->inode;
 	struct ocfs2_dinode *di;
 	struct buffer_head *di_bh = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (ocfs2_is_hard_readonly(osb) || ocfs2_is_soft_readonly(osb))
 		return -EROFS;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c801eddc4bf3..5e8eaf059b93 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -139,7 +139,7 @@ static struct dentry *ocfs2_lookup(struct inode *dir, struct dentry *dentry,
 	if (status < 0)
 		goto bail_add;
 
-	inode = ocfs2_iget(OCFS2_SB(dir->i_sb), blkno, 0, 0);
+	inode = ocfs2_iget(OCFS2_SB(inode_sb(dir)), blkno, 0, 0);
 	if (IS_ERR(inode)) {
 		ret = ERR_PTR(-EACCES);
 		goto bail_unlock;
@@ -201,7 +201,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	struct inode *inode;
 	int status;
 
-	inode = new_inode(dir->i_sb);
+	inode = new_inode(inode_sb(dir));
 	if (!inode) {
 		mlog(ML_ERROR, "new_inode failed!\n");
 		return ERR_PTR(-ENOMEM);
@@ -273,7 +273,7 @@ static int ocfs2_mknod(struct inode *dir,
 	}
 
 	/* get our super block */
-	osb = OCFS2_SB(dir->i_sb);
+	osb = OCFS2_SB(inode_sb(dir));
 
 	status = ocfs2_inode_lock(dir, &parent_fe_bh, 1);
 	if (status < 0) {
@@ -512,7 +512,7 @@ static int __ocfs2_mknod_locked(struct inode *dir,
 				u64 fe_blkno, u64 suballoc_loc, u16 suballoc_bit)
 {
 	int status = 0;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_dinode *fe = NULL;
 	struct ocfs2_extent_list *fel;
 	u16 feat;
@@ -696,7 +696,7 @@ static int ocfs2_link(struct dentry *old_dentry,
 	struct buffer_head *old_dir_bh = NULL;
 	struct buffer_head *parent_fe_bh = NULL;
 	struct ocfs2_dinode *fe = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_dir_lookup_result lookup = { NULL, };
 	sigset_t oldset;
 	u64 old_de_ino;
@@ -885,7 +885,7 @@ static int ocfs2_unlink(struct inode *dir,
 	bool is_unlinkable = false;
 	struct inode *inode = d_inode(dentry);
 	struct inode *orphan_dir = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	u64 blkno;
 	struct ocfs2_dinode *fe = NULL;
 	struct buffer_head *fe_bh = NULL;
@@ -1253,7 +1253,7 @@ static int ocfs2_rename(struct inode *old_dir,
 		goto bail;
 	}
 
-	osb = OCFS2_SB(old_dir->i_sb);
+	osb = OCFS2_SB(inode_sb(old_dir));
 
 	if (new_inode) {
 		if (!igrab(new_inode))
@@ -1829,7 +1829,7 @@ static int ocfs2_symlink(struct inode *dir,
 		goto bail;
 	}
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	osb = OCFS2_SB(sb);
 
 	l = strlen(symname) + 1;
@@ -2134,7 +2134,7 @@ static int __ocfs2_prepare_orphan_dir(struct inode *orphan_dir_inode,
 				      bool dio)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(orphan_dir_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(orphan_dir_inode));
 	int namelen = dio ?
 			(OCFS2_DIO_ORPHAN_PREFIX_LEN + OCFS2_ORPHAN_NAMELEN) :
 			OCFS2_ORPHAN_NAMELEN;
@@ -2434,7 +2434,7 @@ static int ocfs2_prep_new_orphaned_file(struct inode *dir,
 {
 	int ret;
 	u64 di_blkno;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct inode *orphan_dir = NULL;
 	struct buffer_head *orphan_dir_bh = NULL;
 	struct ocfs2_alloc_context *inode_ac = NULL;
@@ -2500,7 +2500,7 @@ int ocfs2_create_inode_in_orphan(struct inode *dir,
 	int status, did_quota_inode = 0;
 	struct inode *inode = NULL;
 	struct inode *orphan_dir = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_dinode *di = NULL;
 	handle_t *handle = NULL;
 	char orphan_name[OCFS2_ORPHAN_NAMELEN + 1];
@@ -2773,7 +2773,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
 	int status = 0;
 	struct buffer_head *parent_di_bh = NULL;
 	handle_t *handle = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	struct ocfs2_dinode *dir_di, *di;
 	struct inode *orphan_dir_inode = NULL;
 	struct buffer_head *orphan_dir_bh = NULL;
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 6867eef2e06b..ec6501f88b75 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -485,7 +485,7 @@ static inline int ocfs2_should_order_data(struct inode *inode)
 {
 	if (!S_ISREG(inode->i_mode))
 		return 0;
-	if (OCFS2_SB(inode->i_sb)->s_mount_opt & OCFS2_MOUNT_DATA_WRITEBACK)
+	if (OCFS2_SB(inode_sb(inode))->s_mount_opt & OCFS2_MOUNT_DATA_WRITEBACK)
 		return 0;
 	return 1;
 }
diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 7a922190a8c7..aa80eb17f73a 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -638,7 +638,7 @@ static void qsync_work_fn(struct work_struct *work)
 	struct ocfs2_mem_dqinfo *oinfo = container_of(work,
 						      struct ocfs2_mem_dqinfo,
 						      dqi_sync_work.work);
-	struct super_block *sb = oinfo->dqi_gqinode->i_sb;
+	struct super_block *sb = inode_sb(oinfo->dqi_gqinode);
 
 	/*
 	 * We have to be careful here not to deadlock on s_umount as umount
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 16c42ed0dca8..25e59756fec1 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -94,7 +94,7 @@ static int ol_dqblk_chunk_off(struct super_block *sb, int c, loff_t off)
 static int ocfs2_modify_bh(struct inode *inode, struct buffer_head *bh,
 		void (*modify)(struct buffer_head *, void *), void *private)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	handle_t *handle;
 	int status;
 
@@ -137,8 +137,8 @@ static int ocfs2_read_quota_block(struct inode *inode, u64 v_block,
 	int rc = 0;
 	struct buffer_head *tmp = *bh;
 
-	if (i_size_read(inode) >> inode->i_sb->s_blocksize_bits <= v_block) {
-		ocfs2_error(inode->i_sb,
+	if (i_size_read(inode) >> inode_sb(inode)->s_blocksize_bits <= v_block) {
+		ocfs2_error(inode_sb(inode),
 			    "Quota file %llu is probably corrupted! Requested to read block %Lu but file has size only %Lu\n",
 			    (unsigned long long)OCFS2_I(inode)->ip_blkno,
 			    (unsigned long long)v_block,
@@ -264,7 +264,7 @@ static int ocfs2_load_local_quota_bitmaps(struct inode *inode,
 		newchunk->qc_num = i;
 		newchunk->qc_headerbh = NULL;
 		status = ocfs2_read_quota_block(inode,
-				ol_quota_chunk_block(inode->i_sb, i),
+				ol_quota_chunk_block(inode_sb(inode), i),
 				&newchunk->qc_headerbh);
 		if (status) {
 			mlog_errno(status);
@@ -341,7 +341,7 @@ static int ocfs2_recovery_load_quota(struct inode *lqinode,
 				     int type,
 				     struct list_head *head)
 {
-	struct super_block *sb = lqinode->i_sb;
+	struct super_block *sb = inode_sb(lqinode);
 	struct buffer_head *hbh;
 	struct ocfs2_local_disk_chunk *dchunk;
 	int i, chunks = le32_to_cpu(ldinfo->dqi_chunks);
@@ -460,7 +460,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 					  int type,
 					  struct ocfs2_quota_recovery *rec)
 {
-	struct super_block *sb = lqinode->i_sb;
+	struct super_block *sb = inode_sb(lqinode);
 	struct ocfs2_mem_dqinfo *oinfo = sb_dqinfo(sb, type)->dqi_priv;
 	struct ocfs2_local_disk_chunk *dchunk;
 	struct ocfs2_local_disk_dqblk *dqblk;
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index ab156e35ec00..0a7f5db63ce3 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -562,7 +562,7 @@ static int ocfs2_create_refcount_tree(struct inode *inode,
 	struct ocfs2_alloc_context *meta_ac = NULL;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *new_bh = NULL;
 	struct ocfs2_refcount_block *rb;
 	struct ocfs2_refcount_tree *new_tree = NULL, *tree = NULL;
@@ -610,7 +610,7 @@ static int ocfs2_create_refcount_tree(struct inode *inode,
 		goto out_commit;
 	}
 
-	new_bh = sb_getblk(inode->i_sb, first_blkno);
+	new_bh = sb_getblk(inode_sb(inode), first_blkno);
 	if (!new_bh) {
 		ret = -ENOMEM;
 		mlog_errno(ret);
@@ -627,7 +627,7 @@ static int ocfs2_create_refcount_tree(struct inode *inode,
 
 	/* Initialize ocfs2_refcount_block. */
 	rb = (struct ocfs2_refcount_block *)new_bh->b_data;
-	memset(rb, 0, inode->i_sb->s_blocksize);
+	memset(rb, 0, inode_sb(inode)->s_blocksize);
 	strcpy((void *)rb, OCFS2_REFCOUNT_BLOCK_SIGNATURE);
 	rb->rf_suballoc_slot = cpu_to_le16(meta_ac->ac_alloc_slot);
 	rb->rf_suballoc_loc = cpu_to_le64(suballoc_loc);
@@ -703,7 +703,7 @@ static int ocfs2_set_refcount_tree(struct inode *inode,
 	handle_t *handle = NULL;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_refcount_block *rb;
 	struct ocfs2_refcount_tree *ref_tree;
@@ -765,7 +765,7 @@ int ocfs2_remove_refcount_tree(struct inode *inode, struct buffer_head *di_bh)
 	handle_t *handle = NULL;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_refcount_block *rb;
 	struct inode *alloc_inode = NULL;
 	struct buffer_head *alloc_bh = NULL;
@@ -2310,7 +2310,8 @@ int ocfs2_decrease_refcount(struct inode *inode,
 		goto out;
 	}
 
-	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode->i_sb), ref_blkno, &tree);
+	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode_sb(inode)), ref_blkno,
+				      &tree);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
@@ -2353,8 +2354,9 @@ static int ocfs2_mark_extent_refcounted(struct inode *inode,
 	trace_ocfs2_mark_extent_refcounted(OCFS2_I(inode)->ip_blkno,
 					   cpos, len, phys);
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode)))) {
+		ret = ocfs2_error(inode_sb(inode),
+				  "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
 				  inode->i_ino);
 		goto out;
 	}
@@ -2534,17 +2536,18 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
 	int ret;
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_refcount_tree *tree;
-	u64 start_cpos = ocfs2_blocks_to_clusters(inode->i_sb, phys_blkno);
+	u64 start_cpos = ocfs2_blocks_to_clusters(inode_sb(inode), phys_blkno);
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode)))) {
+		ret = ocfs2_error(inode_sb(inode),
+				  "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
 				  inode->i_ino);
 		goto out;
 	}
 
 	BUG_ON(!ocfs2_is_refcount_inode(inode));
 
-	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode->i_sb),
+	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode_sb(inode)),
 				      refcount_loc, &tree);
 	if (ret) {
 		mlog_errno(ret);
@@ -2558,7 +2561,7 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
 		goto out;
 	}
 
-	ret = ocfs2_calc_refcount_meta_credits(inode->i_sb,
+	ret = ocfs2_calc_refcount_meta_credits(inode_sb(inode),
 					       &tree->rf_ci,
 					       ref_root_bh,
 					       start_cpos, clusters,
@@ -2646,7 +2649,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 	struct ocfs2_extent_block *eb = NULL;
 	struct ocfs2_extent_rec *rec;
 	unsigned int want_clusters, rec_end = 0;
-	int contig_clusters = ocfs2_cow_contig_clusters(inode->i_sb);
+	int contig_clusters = ocfs2_cow_contig_clusters(inode_sb(inode));
 	int leaf_clusters;
 
 	BUG_ON(cpos + write_len > max_cpos);
@@ -2662,7 +2665,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 		el = &eb->h_list;
 
 		if (el->l_tree_depth) {
-			ret = ocfs2_error(inode->i_sb,
+			ret = ocfs2_error(inode_sb(inode),
 					  "Inode %lu has non zero tree depth in leaf block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
@@ -2741,7 +2744,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 			 * want_clusters to the edge of contig_clusters
 			 * to get better I/O.
 			 */
-			want_clusters = ocfs2_cow_align_length(inode->i_sb,
+			want_clusters = ocfs2_cow_align_length(inode_sb(inode),
 							       want_clusters);
 
 			if (leaf_clusters < want_clusters)
@@ -2774,7 +2777,7 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 			 * contig_clusters of the front), we'll CoW the
 			 * entire extent.
 			 */
-			*cow_start = ocfs2_cow_align_start(inode->i_sb,
+			*cow_start = ocfs2_cow_align_start(inode_sb(inode),
 							   *cow_start, cpos);
 			*cow_len = rec_end - *cow_start;
 		} else {
@@ -2786,11 +2789,11 @@ static int ocfs2_refcount_cal_cow_clusters(struct inode *inode,
 			 * extent and goes for n*contig_clusters,
 			 * covering the entire write.
 			 */
-			*cow_start = ocfs2_cow_align_start(inode->i_sb,
+			*cow_start = ocfs2_cow_align_start(inode_sb(inode),
 							   *cow_start, cpos);
 
 			want_clusters = (cpos + write_len) - *cow_start;
-			want_clusters = ocfs2_cow_align_length(inode->i_sb,
+			want_clusters = ocfs2_cow_align_length(inode_sb(inode),
 							       want_clusters);
 			if (*cow_start + want_clusters <= rec_end)
 				*cow_len = want_clusters;
@@ -2914,7 +2917,7 @@ int ocfs2_duplicate_clusters_by_page(handle_t *handle,
 				     u32 new_cluster, u32 new_len)
 {
 	int ret = 0, partial;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	u64 new_block = ocfs2_clusters_to_blocks(sb, new_cluster);
 	struct page *page;
 	pgoff_t page_index;
@@ -3001,7 +3004,7 @@ int ocfs2_duplicate_clusters_by_jbd(handle_t *handle,
 				    u32 new_cluster, u32 new_len)
 {
 	int ret = 0;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ocfs2_caching_info *ci = INODE_CACHE(inode);
 	int i, blocks = ocfs2_clusters_to_blocks(sb, new_len);
 	u64 old_block = ocfs2_clusters_to_blocks(sb, old_cluster);
@@ -3357,10 +3360,11 @@ static int ocfs2_replace_cow(struct ocfs2_cow_context *context)
 	u32 cow_start = context->cow_start, cow_len = context->cow_len;
 	u32 p_cluster, num_clusters;
 	unsigned int ext_flags;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb))) {
-		return ocfs2_error(inode->i_sb, "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode)))) {
+		return ocfs2_error(inode_sb(inode),
+				   "Inode %lu want to use refcount tree, but the feature bit is not set in the super block\n",
 				   inode->i_ino);
 	}
 
@@ -3379,7 +3383,7 @@ static int ocfs2_replace_cow(struct ocfs2_cow_context *context)
 		if (cow_len < num_clusters)
 			num_clusters = cow_len;
 
-		ret = ocfs2_make_clusters_writable(inode->i_sb, context,
+		ret = ocfs2_make_clusters_writable(inode_sb(inode), context,
 						   cow_start, p_cluster,
 						   num_clusters, ext_flags);
 		if (ret) {
@@ -3410,7 +3414,7 @@ static int ocfs2_refcount_cow_hunk(struct inode *inode,
 {
 	int ret;
 	u32 cow_start = 0, cow_len = 0;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_refcount_tree *ref_tree;
@@ -3604,7 +3608,7 @@ int ocfs2_refcounted_xattr_delete_need(struct inode *inode,
 		struct ocfs2_extent_tree et;
 
 		ocfs2_init_refcount_extent_tree(&et, ref_ci, ref_root_bh);
-		*credits += ocfs2_calc_extend_credits(inode->i_sb,
+		*credits += ocfs2_calc_extend_credits(inode_sb(inode),
 						      et.et_root_el);
 	}
 
@@ -3658,7 +3662,7 @@ int ocfs2_refcount_cow_xattr(struct inode *inode,
 	context->cow_duplicate_clusters = ocfs2_duplicate_clusters_by_jbd;
 	/* We need the extra credits for duplicate_clusters by jbd. */
 	context->extra_credits =
-		ocfs2_clusters_to_blocks(inode->i_sb, 1) * cow_len;
+		ocfs2_clusters_to_blocks(inode_sb(inode), 1) * cow_len;
 	context->get_clusters = ocfs2_xattr_value_get_clusters;
 	context->post_refcount = post;
 
@@ -3689,13 +3693,13 @@ int ocfs2_add_refcount_flag(struct inode *inode,
 	int ret;
 	handle_t *handle;
 	int credits = 1, ref_blocks = 0;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_alloc_context *meta_ac = NULL;
 
 	/* We need to be able to handle at least an extent tree split. */
 	ref_blocks = ocfs2_extend_meta_needed(data_et->et_root_el);
 
-	ret = ocfs2_calc_refcount_meta_credits(inode->i_sb,
+	ret = ocfs2_calc_refcount_meta_credits(inode_sb(inode),
 					       ref_ci, ref_root_bh,
 					       p_cluster, num_clusters,
 					       &ref_blocks, &credits);
@@ -3707,7 +3711,7 @@ int ocfs2_add_refcount_flag(struct inode *inode,
 	trace_ocfs2_add_refcount_flag(ref_blocks, credits);
 
 	if (ref_blocks) {
-		ret = ocfs2_reserve_new_metadata_blocks(OCFS2_SB(inode->i_sb),
+		ret = ocfs2_reserve_new_metadata_blocks(OCFS2_SB(inode_sb(inode)),
 							ref_blocks, &meta_ac);
 		if (ret) {
 			mlog_errno(ret);
@@ -3762,7 +3766,7 @@ static int ocfs2_change_ctime(struct inode *inode,
 	handle_t *handle;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 
-	handle = ocfs2_start_trans(OCFS2_SB(inode->i_sb),
+	handle = ocfs2_start_trans(OCFS2_SB(inode_sb(inode)),
 				   OCFS2_INODE_UPDATE_CREDITS);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -3784,7 +3788,7 @@ static int ocfs2_change_ctime(struct inode *inode,
 	ocfs2_journal_dirty(handle, di_bh);
 
 out_commit:
-	ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
+	ocfs2_commit_trans(OCFS2_SB(inode_sb(inode)), handle);
 out:
 	return ret;
 }
@@ -3796,7 +3800,7 @@ static int ocfs2_attach_refcount_tree(struct inode *inode,
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_refcount_tree *ref_tree;
 	unsigned int ext_flags;
 	loff_t size;
@@ -3829,7 +3833,7 @@ static int ocfs2_attach_refcount_tree(struct inode *inode,
 	ocfs2_init_dinode_extent_tree(&di_et, INODE_CACHE(inode), di_bh);
 
 	size = i_size_read(inode);
-	clusters = ocfs2_clusters_for_bytes(inode->i_sb, size);
+	clusters = ocfs2_clusters_for_bytes(inode_sb(inode), size);
 
 	cpos = 0;
 	while (cpos < clusters) {
@@ -3902,10 +3906,10 @@ static int ocfs2_add_refcounted_extent(struct inode *inode,
 	int ret;
 	handle_t *handle;
 	int credits = 0;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_alloc_context *meta_ac = NULL;
 
-	ret = ocfs2_lock_refcount_allocators(inode->i_sb,
+	ret = ocfs2_lock_refcount_allocators(inode_sb(inode),
 					     p_cluster, num_clusters,
 					     et, ref_ci,
 					     ref_root_bh, &meta_ac,
@@ -3923,7 +3927,7 @@ static int ocfs2_add_refcounted_extent(struct inode *inode,
 	}
 
 	ret = ocfs2_insert_extent(handle, et, cpos,
-			ocfs2_clusters_to_blocks(inode->i_sb, p_cluster),
+			ocfs2_clusters_to_blocks(inode_sb(inode), p_cluster),
 			num_clusters, ext_flags, meta_ac);
 	if (ret) {
 		mlog_errno(ret);
@@ -3958,7 +3962,7 @@ static int ocfs2_duplicate_inline_data(struct inode *s_inode,
 {
 	int ret;
 	handle_t *handle;
-	struct ocfs2_super *osb = OCFS2_SB(s_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(s_inode));
 	struct ocfs2_dinode *s_di = (struct ocfs2_dinode *)s_bh->b_data;
 	struct ocfs2_dinode *t_di = (struct ocfs2_dinode *)t_bh->b_data;
 
@@ -4010,7 +4014,7 @@ static int ocfs2_duplicate_extent_list(struct inode *s_inode,
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(t_inode), t_bh);
 
 	size = i_size_read(s_inode);
-	clusters = ocfs2_clusters_for_bytes(s_inode->i_sb, size);
+	clusters = ocfs2_clusters_for_bytes(inode_sb(s_inode), size);
 
 	cpos = 0;
 	while (cpos < clusters) {
@@ -4058,7 +4062,7 @@ static int ocfs2_complete_reflink(struct inode *s_inode,
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)t_bh->b_data;
 	loff_t size = i_size_read(s_inode);
 
-	handle = ocfs2_start_trans(OCFS2_SB(t_inode->i_sb),
+	handle = ocfs2_start_trans(OCFS2_SB(inode_sb(t_inode)),
 				   OCFS2_INODE_UPDATE_CREDITS);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -4113,7 +4117,7 @@ static int ocfs2_complete_reflink(struct inode *s_inode,
 	ocfs2_journal_dirty(handle, t_bh);
 
 out_commit:
-	ocfs2_commit_trans(OCFS2_SB(t_inode->i_sb), handle);
+	ocfs2_commit_trans(OCFS2_SB(inode_sb(t_inode)), handle);
 	return ret;
 }
 
@@ -4126,7 +4130,7 @@ static int ocfs2_create_reflink_node(struct inode *s_inode,
 	int ret;
 	struct buffer_head *ref_root_bh = NULL;
 	struct ocfs2_cached_dealloc_ctxt dealloc;
-	struct ocfs2_super *osb = OCFS2_SB(s_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(s_inode));
 	struct ocfs2_refcount_block *rb;
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)s_bh->b_data;
 	struct ocfs2_refcount_tree *ref_tree;
@@ -4255,7 +4259,7 @@ static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
 	struct buffer_head *old_bh = NULL;
 	struct inode *new_orphan_inode = NULL;
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode))))
 		return -EOPNOTSUPP;
 
 
@@ -4360,7 +4364,7 @@ static int ocfs2_vfs_reflink(struct dentry *old_dentry, struct inode *dir,
 	if (error)
 		return error;
 
-	if (dir->i_sb != inode->i_sb)
+	if (inode_sb(dir) != inode_sb(inode))
 		return -EXDEV;
 
 	/*
@@ -4416,7 +4420,7 @@ int ocfs2_reflink_ioctl(struct inode *inode,
 	struct path old_path, new_path;
 	int error;
 
-	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_refcount_tree(OCFS2_SB(inode_sb(inode))))
 		return -EOPNOTSUPP;
 
 	error = user_path_at(AT_FDCWD, oldname, 0, &old_path);
@@ -4462,7 +4466,7 @@ static int ocfs2_reflink_update_dest(struct inode *dest,
 	if (newlen <= i_size_read(dest))
 		return 0;
 
-	handle = ocfs2_start_trans(OCFS2_SB(dest->i_sb),
+	handle = ocfs2_start_trans(OCFS2_SB(inode_sb(dest)),
 				   OCFS2_INODE_UPDATE_CREDITS);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -4484,7 +4488,7 @@ static int ocfs2_reflink_update_dest(struct inode *dest,
 	}
 
 out_commit:
-	ocfs2_commit_trans(OCFS2_SB(dest->i_sb), handle);
+	ocfs2_commit_trans(OCFS2_SB(inode_sb(dest)), handle);
 	return ret;
 }
 
@@ -4509,14 +4513,14 @@ static int ocfs2_reflink_remap_extent(struct inode *s_inode,
 	unsigned int ext_flags;
 	int ret = 0;
 
-	osb = OCFS2_SB(s_inode->i_sb);
+	osb = OCFS2_SB(inode_sb(s_inode));
 	dis = (struct ocfs2_dinode *)s_bh->b_data;
 	ocfs2_init_dinode_extent_tree(&s_et, INODE_CACHE(s_inode), s_bh);
 	ocfs2_init_dinode_extent_tree(&t_et, INODE_CACHE(t_inode), t_bh);
 
-	spos = ocfs2_bytes_to_clusters(s_inode->i_sb, pos_in);
-	tpos = ocfs2_bytes_to_clusters(t_inode->i_sb, pos_out);
-	slast = ocfs2_clusters_for_bytes(s_inode->i_sb, pos_in + len);
+	spos = ocfs2_bytes_to_clusters(inode_sb(s_inode), pos_in);
+	tpos = ocfs2_bytes_to_clusters(inode_sb(t_inode), pos_out);
+	slast = ocfs2_clusters_for_bytes(inode_sb(s_inode), pos_in + len);
 
 	while (spos < slast) {
 		if (fatal_signal_pending(current)) {
@@ -4535,8 +4539,9 @@ static int ocfs2_reflink_remap_extent(struct inode *s_inode,
 		num_clusters = min_t(u32, num_clusters, slast - spos);
 
 		/* Punch out the dest range. */
-		pstart = ocfs2_clusters_to_bytes(t_inode->i_sb, tpos);
-		plen = ocfs2_clusters_to_bytes(t_inode->i_sb, num_clusters);
+		pstart = ocfs2_clusters_to_bytes(inode_sb(t_inode), tpos);
+		plen = ocfs2_clusters_to_bytes(inode_sb(t_inode),
+					       num_clusters);
 		ret = ocfs2_remove_inode_range(t_inode, t_bh, pstart, plen);
 		if (ret) {
 			mlog_errno(ret);
@@ -4612,7 +4617,7 @@ static int ocfs2_reflink_remap_blocks(struct inode *s_inode,
 	struct ocfs2_dinode *dit;
 	int ret;
 
-	osb = OCFS2_SB(s_inode->i_sb);
+	osb = OCFS2_SB(inode_sb(s_inode));
 	dis = (struct ocfs2_dinode *)s_bh->b_data;
 	dit = (struct ocfs2_dinode *)t_bh->b_data;
 	ocfs2_init_dealloc_ctxt(&dealloc);
@@ -4811,7 +4816,7 @@ int ocfs2_reflink_remap_range(struct file *file_in,
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
-	struct ocfs2_super *osb = OCFS2_SB(inode_in->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode_in));
 	struct buffer_head *in_bh = NULL, *out_bh = NULL;
 	bool same_inode = (inode_in == inode_out);
 	ssize_t ret;
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index 18451e0fab81..ae75edf88a65 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -63,8 +63,8 @@ static u16 ocfs2_calc_new_backup_super(struct inode *inode,
 	u64 blkno, gd_blkno, lgd_blkno = le64_to_cpu(gd->bg_blkno);
 
 	for (i = 0; i < OCFS2_MAX_BACKUP_SUPERBLOCKS; i++) {
-		blkno = ocfs2_backup_super_blkno(inode->i_sb, i);
-		cluster = ocfs2_blocks_to_clusters(inode->i_sb, blkno);
+		blkno = ocfs2_backup_super_blkno(inode_sb(inode), i);
+		cluster = ocfs2_blocks_to_clusters(inode_sb(inode), blkno);
 
 		gd_blkno = ocfs2_which_cluster_group(inode, cluster);
 		if (gd_blkno < lgd_blkno)
@@ -73,7 +73,8 @@ static u16 ocfs2_calc_new_backup_super(struct inode *inode,
 			break;
 
 		/* check if already done backup super */
-		lgd_cluster = ocfs2_blocks_to_clusters(inode->i_sb, lgd_blkno);
+		lgd_cluster = ocfs2_blocks_to_clusters(inode_sb(inode),
+						       lgd_blkno);
 		lgd_cluster += old_bg_clusters;
 		if (lgd_cluster >= cluster)
 			continue;
@@ -98,7 +99,7 @@ static int ocfs2_update_last_group_and_inode(handle_t *handle,
 					     int new_clusters)
 {
 	int ret = 0;
-	struct ocfs2_super *osb = OCFS2_SB(bm_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(bm_inode));
 	struct ocfs2_dinode *fe = (struct ocfs2_dinode *) bm_bh->b_data;
 	struct ocfs2_chain_list *cl = &fe->id2.i_chain;
 	struct ocfs2_chain_rec *cr;
@@ -190,12 +191,12 @@ static int update_backups(struct inode * inode, u32 clusters, char *data)
 	u64 blkno;
 	struct buffer_head *backup = NULL;
 	struct ocfs2_dinode *backup_di = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	/* calculate the real backups we need to update. */
 	for (i = 0; i < OCFS2_MAX_BACKUP_SUPERBLOCKS; i++) {
-		blkno = ocfs2_backup_super_blkno(inode->i_sb, i);
-		cluster = ocfs2_blocks_to_clusters(inode->i_sb, blkno);
+		blkno = ocfs2_backup_super_blkno(inode_sb(inode), i);
+		cluster = ocfs2_blocks_to_clusters(inode_sb(inode), blkno);
 		if (cluster >= clusters)
 			break;
 
@@ -205,7 +206,7 @@ static int update_backups(struct inode * inode, u32 clusters, char *data)
 			break;
 		}
 
-		memcpy(backup->b_data, data, inode->i_sb->s_blocksize);
+		memcpy(backup->b_data, data, inode_sb(inode)->s_blocksize);
 
 		backup_di = (struct ocfs2_dinode *)backup->b_data;
 		backup_di->i_blkno = cpu_to_le64(blkno);
@@ -229,7 +230,7 @@ static void ocfs2_update_super_and_backups(struct inode *inode,
 	u32 clusters = 0;
 	struct buffer_head *super_bh = NULL;
 	struct ocfs2_dinode *super_di = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	/*
 	 * update the superblock last.
@@ -279,7 +280,7 @@ int ocfs2_group_extend(struct inode * inode, int new_clusters)
 	struct inode *main_bm_inode = NULL;
 	struct ocfs2_dinode *fe = NULL;
 	struct ocfs2_group_desc *group = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	u16 cl_bpc;
 	u32 first_new_cluster;
 	u64 lgd_blkno;
@@ -392,7 +393,7 @@ static int ocfs2_check_new_group(struct inode *inode,
 		(struct ocfs2_group_desc *)group_bh->b_data;
 	u16 cl_bpc = le16_to_cpu(di->id2.i_chain.cl_bpc);
 
-	ret = ocfs2_check_group_descriptor(inode->i_sb, di, group_bh);
+	ret = ocfs2_check_group_descriptor(inode_sb(inode), di, group_bh);
 	if (ret)
 		goto out;
 
@@ -428,7 +429,7 @@ static int ocfs2_verify_group_and_input(struct inode *inode,
 	u16 cl_count = le16_to_cpu(di->id2.i_chain.cl_count);
 	u16 cl_cpg = le16_to_cpu(di->id2.i_chain.cl_cpg);
 	u16 next_free = le16_to_cpu(di->id2.i_chain.cl_next_free_rec);
-	u32 cluster = ocfs2_blocks_to_clusters(inode->i_sb, input->group);
+	u32 cluster = ocfs2_blocks_to_clusters(inode_sb(inode), input->group);
 	u32 total_clusters = le32_to_cpu(di->i_clusters);
 	int ret = -EINVAL;
 
@@ -466,7 +467,7 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 	struct buffer_head *main_bm_bh = NULL;
 	struct inode *main_bm_inode = NULL;
 	struct ocfs2_dinode *fe = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct buffer_head *group_bh = NULL;
 	struct ocfs2_group_desc *group = NULL;
 	struct ocfs2_chain_list *cl;
diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index d7407994f308..3c0018119153 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -363,7 +363,7 @@ static int ocfs2_map_slot_buffers(struct ocfs2_super *osb,
 	if (status)
 		goto bail;
 
-	blocks = ocfs2_blocks_for_bytes(si->si_inode->i_sb, bytes);
+	blocks = ocfs2_blocks_for_bytes(inode_sb(si->si_inode), bytes);
 	BUG_ON(blocks > UINT_MAX);
 	si->si_blocks = blocks;
 	if (!si->si_blocks)
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index d8f5f6ce99dc..01ec1d59b2d6 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -319,7 +319,7 @@ int ocfs2_read_group_descriptor(struct inode *inode, struct ocfs2_dinode *di,
 	if (rc)
 		goto out;
 
-	rc = ocfs2_validate_gd_parent(inode->i_sb, di, tmp, 0);
+	rc = ocfs2_validate_gd_parent(inode_sb(inode), di, tmp, 0);
 	if (rc) {
 		brelse(tmp);
 		goto out;
@@ -364,12 +364,12 @@ static int ocfs2_block_group_fill(handle_t *handle,
 				  struct ocfs2_chain_list *cl)
 {
 	int status = 0;
-	struct ocfs2_super *osb = OCFS2_SB(alloc_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(alloc_inode));
 	struct ocfs2_group_desc *bg = (struct ocfs2_group_desc *) bg_bh->b_data;
-	struct super_block * sb = alloc_inode->i_sb;
+	struct super_block * sb = inode_sb(alloc_inode);
 
 	if (((unsigned long long) bg_bh->b_blocknr) != group_blkno) {
-		status = ocfs2_error(alloc_inode->i_sb,
+		status = ocfs2_error(inode_sb(alloc_inode),
 				     "group block (%llu) != b_blocknr (%llu)\n",
 				     (unsigned long long)group_blkno,
 				     (unsigned long long) bg_bh->b_blocknr);
@@ -504,7 +504,7 @@ static int ocfs2_block_group_grow_discontig(handle_t *handle,
 					    unsigned int min_bits)
 {
 	int status;
-	struct ocfs2_super *osb = OCFS2_SB(alloc_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(alloc_inode));
 	struct ocfs2_group_desc *bg =
 		(struct ocfs2_group_desc *)bg_bh->b_data;
 	unsigned int needed = le16_to_cpu(cl->cl_cpg) -
@@ -600,7 +600,7 @@ ocfs2_block_group_alloc_discontig(handle_t *handle,
 	unsigned int min_bits = le16_to_cpu(cl->cl_cpg) >> 1;
 	struct buffer_head *bg_bh = NULL;
 	unsigned int alloc_rec = ocfs2_find_smallest_chain(cl);
-	struct ocfs2_super *osb = OCFS2_SB(alloc_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(alloc_inode));
 
 	if (!ocfs2_supports_discontig_bg(osb)) {
 		status = -ENOSPC;
@@ -750,8 +750,8 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 
 	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
 	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
-	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
-					     le32_to_cpu(fe->i_clusters)));
+	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(inode_sb(alloc_inode),
+							 le32_to_cpu(fe->i_clusters)));
 	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
 	i_size_write(alloc_inode, le64_to_cpu(fe->i_size));
 	alloc_inode->i_blocks = ocfs2_inode_sector_count(alloc_inode);
@@ -818,7 +818,7 @@ static int ocfs2_reserve_suballoc_bits(struct ocfs2_super *osb,
 	BUG_ON(!OCFS2_IS_VALID_DINODE(fe));
 
 	if (!(fe->i_flags & cpu_to_le32(OCFS2_CHAIN_FL))) {
-		status = ocfs2_error(alloc_inode->i_sb,
+		status = ocfs2_error(inode_sb(alloc_inode),
 				     "Invalid chain allocator %llu\n",
 				     (unsigned long long)le64_to_cpu(fe->i_blkno));
 		goto bail;
@@ -1379,7 +1379,8 @@ int ocfs2_block_group_set_bits(handle_t *handle,
 
 	le16_add_cpu(&bg->bg_free_bits_count, -num_bits);
 	if (le16_to_cpu(bg->bg_free_bits_count) > le16_to_cpu(bg->bg_bits)) {
-		return ocfs2_error(alloc_inode->i_sb, "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
+		return ocfs2_error(inode_sb(alloc_inode),
+				   "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
 				   (unsigned long long)le64_to_cpu(bg->bg_blkno),
 				   le16_to_cpu(bg->bg_bits),
 				   le16_to_cpu(bg->bg_free_bits_count),
@@ -1496,7 +1497,7 @@ static int ocfs2_cluster_group_search(struct inode *inode,
 	int ret;
 	u64 blkoff;
 	struct ocfs2_group_desc *gd = (struct ocfs2_group_desc *) group_bh->b_data;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	unsigned int max_bits, gd_cluster_off;
 
 	BUG_ON(!ocfs2_is_cluster_bitmap(inode));
@@ -1510,7 +1511,7 @@ static int ocfs2_cluster_group_search(struct inode *inode,
 		 * update the dinode cluster count, then we don't want
 		 * to trust any clusters past it, regardless of what
 		 * the group descriptor says. */
-		gd_cluster_off = ocfs2_blocks_to_clusters(inode->i_sb,
+		gd_cluster_off = ocfs2_blocks_to_clusters(inode_sb(inode),
 							  le64_to_cpu(gd->bg_blkno));
 		if ((gd_cluster_off + max_bits) >
 		    OCFS2_I(inode)->ip_clusters) {
@@ -1521,14 +1522,14 @@ static int ocfs2_cluster_group_search(struct inode *inode,
 				OCFS2_I(inode)->ip_clusters, max_bits);
 		}
 
-		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode->i_sb),
+		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode_sb(inode)),
 							group_bh, bits_wanted,
 							max_bits, res);
 		if (ret)
 			return ret;
 
 		if (max_block) {
-			blkoff = ocfs2_clusters_to_blocks(inode->i_sb,
+			blkoff = ocfs2_clusters_to_blocks(inode_sb(inode),
 							  gd_cluster_off +
 							  res->sr_bit_offset +
 							  res->sr_bits);
@@ -1571,7 +1572,7 @@ static int ocfs2_block_group_search(struct inode *inode,
 	BUG_ON(ocfs2_is_cluster_bitmap(inode));
 
 	if (bg->bg_free_bits_count) {
-		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode->i_sb),
+		ret = ocfs2_block_group_find_clear_bits(OCFS2_SB(inode_sb(inode)),
 							group_bh, bits_wanted,
 							le16_to_cpu(bg->bg_bits),
 							res);
@@ -1667,7 +1668,7 @@ static void ocfs2_bg_discontig_fix_result(struct ocfs2_alloc_context *ac,
 
 	res->sr_blkno = res->sr_bg_blkno + res->sr_bit_offset;
 	res->sr_bg_blkno = 0;  /* Clear it for contig block groups */
-	if (!ocfs2_supports_discontig_bg(OCFS2_SB(ac->ac_inode->i_sb)) ||
+	if (!ocfs2_supports_discontig_bg(OCFS2_SB(inode_sb(ac->ac_inode))) ||
 	    !bg->bg_list.l_next_free_rec)
 		return;
 
@@ -1913,7 +1914,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 
 	if (le32_to_cpu(fe->id1.bitmap1.i_used) >=
 	    le32_to_cpu(fe->id1.bitmap1.i_total)) {
-		status = ocfs2_error(ac->ac_inode->i_sb,
+		status = ocfs2_error(inode_sb(ac->ac_inode),
 				     "Chain allocator dinode %llu has %u used bits but only %u total\n",
 				     (unsigned long long)le64_to_cpu(fe->i_blkno),
 				     le32_to_cpu(fe->id1.bitmap1.i_used),
@@ -2023,7 +2024,7 @@ int ocfs2_claim_metadata(handle_t *handle,
 		mlog_errno(status);
 		goto bail;
 	}
-	atomic_inc(&OCFS2_SB(ac->ac_inode->i_sb)->alloc_stats.bg_allocs);
+	atomic_inc(&OCFS2_SB(inode_sb(ac->ac_inode))->alloc_stats.bg_allocs);
 
 	*suballoc_loc = res.sr_bg_blkno;
 	*suballoc_bit_start = res.sr_bit_offset;
@@ -2099,7 +2100,8 @@ int ocfs2_find_new_inode_loc(struct inode *dir,
 	 * The handle started here is for chain relink. Alternatively,
 	 * we could just disable relink for these calls.
 	 */
-	handle = ocfs2_start_trans(OCFS2_SB(dir->i_sb), OCFS2_SUBALLOC_ALLOC);
+	handle = ocfs2_start_trans(OCFS2_SB(inode_sb(dir)),
+				   OCFS2_SUBALLOC_ALLOC);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		handle = NULL;
@@ -2125,7 +2127,7 @@ int ocfs2_find_new_inode_loc(struct inode *dir,
 	ocfs2_update_inode_fsync_trans(handle, dir, 0);
 out:
 	if (handle)
-		ocfs2_commit_trans(OCFS2_SB(dir->i_sb), handle);
+		ocfs2_commit_trans(OCFS2_SB(inode_sb(dir)), handle);
 
 	if (ret)
 		kfree(res);
@@ -2189,7 +2191,7 @@ int ocfs2_claim_new_inode_at_loc(handle_t *handle,
 	trace_ocfs2_claim_new_inode_at_loc((unsigned long long)di_blkno,
 					   res->sr_bits);
 
-	atomic_inc(&OCFS2_SB(ac->ac_inode->i_sb)->alloc_stats.bg_allocs);
+	atomic_inc(&OCFS2_SB(inode_sb(ac->ac_inode))->alloc_stats.bg_allocs);
 
 	BUG_ON(res->sr_bits != 1);
 
@@ -2231,7 +2233,7 @@ int ocfs2_claim_new_inode(handle_t *handle,
 		mlog_errno(status);
 		goto bail;
 	}
-	atomic_inc(&OCFS2_SB(ac->ac_inode->i_sb)->alloc_stats.bg_allocs);
+	atomic_inc(&OCFS2_SB(inode_sb(ac->ac_inode))->alloc_stats.bg_allocs);
 
 	BUG_ON(res.sr_bits != 1);
 
@@ -2253,13 +2255,13 @@ static inline u32 ocfs2_desc_bitmap_to_cluster_off(struct inode *inode,
 						   u64 bg_blkno,
 						   u16 bg_bit_off)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	u32 cluster = 0;
 
 	BUG_ON(!ocfs2_is_cluster_bitmap(inode));
 
 	if (bg_blkno != osb->first_cluster_group_blkno)
-		cluster = ocfs2_blocks_to_clusters(inode->i_sb, bg_blkno);
+		cluster = ocfs2_blocks_to_clusters(inode_sb(inode), bg_blkno);
 	cluster += (u32) bg_bit_off;
 	return cluster;
 }
@@ -2268,7 +2270,7 @@ static inline u32 ocfs2_desc_bitmap_to_cluster_off(struct inode *inode,
  * and return that block offset. */
 u64 ocfs2_which_cluster_group(struct inode *inode, u32 cluster)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	u32 group_no;
 
 	BUG_ON(!ocfs2_is_cluster_bitmap(inode));
@@ -2276,7 +2278,7 @@ u64 ocfs2_which_cluster_group(struct inode *inode, u32 cluster)
 	group_no = cluster / osb->bitmap_cpg;
 	if (!group_no)
 		return osb->first_cluster_group_blkno;
-	return ocfs2_clusters_to_blocks(inode->i_sb,
+	return ocfs2_clusters_to_blocks(inode_sb(inode),
 					group_no * osb->bitmap_cpg);
 }
 
@@ -2287,7 +2289,7 @@ static inline void ocfs2_block_to_cluster_group(struct inode *inode,
 						u64 *bg_blkno,
 						u16 *bg_bit_off)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	u32 data_cluster = ocfs2_blocks_to_clusters(osb->sb, data_blkno);
 
 	BUG_ON(!ocfs2_is_cluster_bitmap(inode));
@@ -2318,7 +2320,7 @@ int __ocfs2_claim_clusters(handle_t *handle,
 	int status;
 	unsigned int bits_wanted = max_clusters;
 	struct ocfs2_suballoc_result res = { .sr_blkno = 0, };
-	struct ocfs2_super *osb = OCFS2_SB(ac->ac_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(ac->ac_inode));
 
 	BUG_ON(ac->ac_bits_given >= ac->ac_bits_wanted);
 
@@ -2440,7 +2442,8 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
 	if (le16_to_cpu(bg->bg_free_bits_count) > le16_to_cpu(bg->bg_bits)) {
 		if (undo_fn)
 			jbd_unlock_bh_state(group_bh);
-		return ocfs2_error(alloc_inode->i_sb, "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
+		return ocfs2_error(inode_sb(alloc_inode),
+				   "Group descriptor # %llu has bit count %u but claims %u are freed. num_bits %d\n",
 				   (unsigned long long)le64_to_cpu(bg->bg_blkno),
 				   le16_to_cpu(bg->bg_bits),
 				   le16_to_cpu(bg->bg_free_bits_count),
@@ -2571,9 +2574,9 @@ static int _ocfs2_free_clusters(handle_t *handle,
 	 * about looping on them.
 	 * This is expensive. We can safely remove once this stuff has
 	 * gotten tested really well. */
-	BUG_ON(start_blk != ocfs2_clusters_to_blocks(bitmap_inode->i_sb,
-				ocfs2_blocks_to_clusters(bitmap_inode->i_sb,
-							 start_blk)));
+	BUG_ON(start_blk != ocfs2_clusters_to_blocks(inode_sb(bitmap_inode),
+						     ocfs2_blocks_to_clusters(inode_sb(bitmap_inode),
+									      start_blk)));
 
 
 	ocfs2_block_to_cluster_group(bitmap_inode, start_blk, &bg_blkno,
@@ -2591,7 +2594,7 @@ static int _ocfs2_free_clusters(handle_t *handle,
 		goto out;
 	}
 
-	ocfs2_local_alloc_seen_free_bits(OCFS2_SB(bitmap_inode->i_sb),
+	ocfs2_local_alloc_seen_free_bits(OCFS2_SB(inode_sb(bitmap_inode)),
 					 num_clusters);
 
 out:
@@ -2691,7 +2694,7 @@ int ocfs2_lock_allocators(struct inode *inode,
 {
 	int ret = 0, num_free_extents;
 	unsigned int max_recs_needed = clusters_to_add + 2 * extents_to_split;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	*meta_ac = NULL;
 	if (data_ac)
diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
index 2d2501767c0c..95ad9e247205 100644
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -178,7 +178,7 @@ static inline u32 ocfs2_cluster_from_desc(struct ocfs2_super *osb,
 
 static inline int ocfs2_is_cluster_bitmap(struct inode *inode)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	return osb->bitmap_blkno == OCFS2_I(inode)->ip_blkno;
 }
 
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 94cfacc9bad7..a3386fcdf699 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -72,7 +72,7 @@ static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
 	fe = (struct ocfs2_dinode *) bh->b_data;
 	link = (char *) fe->id2.i_symlink;
 	/* will be less than a page size */
-	len = strnlen(link, ocfs2_fast_symlink_chars(inode->i_sb));
+	len = strnlen(link, ocfs2_fast_symlink_chars(inode_sb(inode)));
 	kaddr = kmap_atomic(page);
 	memcpy(kaddr, link, len + 1);
 	kunmap_atomic(kaddr);
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index c261c1dfd374..a81dc212b215 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -88,7 +88,7 @@ struct ocfs2_xattr_set_ctxt {
 #define OCFS2_XATTR_FREE_IN_IBODY	(OCFS2_MIN_XATTR_INLINE_SIZE \
 					 - sizeof(struct ocfs2_xattr_header) \
 					 - OCFS2_XATTR_HEADER_GAP)
-#define OCFS2_XATTR_FREE_IN_BLOCK(ptr)	((ptr)->i_sb->s_blocksize \
+#define OCFS2_XATTR_FREE_IN_BLOCK(ptr)	(inode_sb((ptr))->s_blocksize \
 					 - sizeof(struct ocfs2_xattr_block) \
 					 - sizeof(struct ocfs2_xattr_header) \
 					 - OCFS2_XATTR_HEADER_GAP)
@@ -330,7 +330,7 @@ static inline u16 ocfs2_blocks_per_xattr_bucket(struct super_block *sb)
 static struct ocfs2_xattr_bucket *ocfs2_xattr_bucket_new(struct inode *inode)
 {
 	struct ocfs2_xattr_bucket *bucket;
-	int blks = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	int blks = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 
 	BUG_ON(blks > OCFS2_XATTR_MAX_BLOCKS_PER_BUCKET);
 
@@ -374,7 +374,7 @@ static int ocfs2_init_xattr_bucket(struct ocfs2_xattr_bucket *bucket,
 	int i, rc = 0;
 
 	for (i = 0; i < bucket->bu_blocks; i++) {
-		bucket->bu_bhs[i] = sb_getblk(bucket->bu_inode->i_sb,
+		bucket->bu_bhs[i] = sb_getblk(inode_sb(bucket->bu_inode),
 					      xb_blkno + i);
 		if (!bucket->bu_bhs[i]) {
 			rc = -ENOMEM;
@@ -410,12 +410,12 @@ static int ocfs2_read_xattr_bucket(struct ocfs2_xattr_bucket *bucket,
 			       bucket->bu_blocks, bucket->bu_bhs, 0,
 			       NULL);
 	if (!rc) {
-		spin_lock(&OCFS2_SB(bucket->bu_inode->i_sb)->osb_xattr_lock);
-		rc = ocfs2_validate_meta_ecc_bhs(bucket->bu_inode->i_sb,
+		spin_lock(&OCFS2_SB(inode_sb(bucket->bu_inode))->osb_xattr_lock);
+		rc = ocfs2_validate_meta_ecc_bhs(inode_sb(bucket->bu_inode),
 						 bucket->bu_bhs,
 						 bucket->bu_blocks,
 						 &bucket_xh(bucket)->xh_check);
-		spin_unlock(&OCFS2_SB(bucket->bu_inode->i_sb)->osb_xattr_lock);
+		spin_unlock(&OCFS2_SB(inode_sb(bucket->bu_inode))->osb_xattr_lock);
 		if (rc)
 			mlog_errno(rc);
 	}
@@ -449,11 +449,11 @@ static void ocfs2_xattr_bucket_journal_dirty(handle_t *handle,
 {
 	int i;
 
-	spin_lock(&OCFS2_SB(bucket->bu_inode->i_sb)->osb_xattr_lock);
-	ocfs2_compute_meta_ecc_bhs(bucket->bu_inode->i_sb,
+	spin_lock(&OCFS2_SB(inode_sb(bucket->bu_inode))->osb_xattr_lock);
+	ocfs2_compute_meta_ecc_bhs(inode_sb(bucket->bu_inode),
 				   bucket->bu_bhs, bucket->bu_blocks,
 				   &bucket_xh(bucket)->xh_check);
-	spin_unlock(&OCFS2_SB(bucket->bu_inode->i_sb)->osb_xattr_lock);
+	spin_unlock(&OCFS2_SB(inode_sb(bucket->bu_inode))->osb_xattr_lock);
 
 	for (i = 0; i < bucket->bu_blocks; i++)
 		ocfs2_journal_dirty(handle, bucket->bu_bhs[i]);
@@ -463,7 +463,7 @@ static void ocfs2_xattr_bucket_copy_data(struct ocfs2_xattr_bucket *dest,
 					 struct ocfs2_xattr_bucket *src)
 {
 	int i;
-	int blocksize = src->bu_inode->i_sb->s_blocksize;
+	int blocksize = inode_sb(src->bu_inode)->s_blocksize;
 
 	BUG_ON(dest->bu_blocks != src->bu_blocks);
 	BUG_ON(dest->bu_inode != src->bu_inode);
@@ -552,7 +552,7 @@ static u32 ocfs2_xattr_name_hash(struct inode *inode,
 				 int name_len)
 {
 	/* Get hash value of uuid from super block */
-	u32 hash = OCFS2_SB(inode->i_sb)->uuid_hash;
+	u32 hash = OCFS2_SB(inode_sb(inode))->uuid_hash;
 	int i;
 
 	/* hash extended attribute name */
@@ -590,7 +590,7 @@ int ocfs2_calc_security_init(struct inode *dir,
 			     struct ocfs2_alloc_context **xattr_ac)
 {
 	int ret = 0;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	int s_size = ocfs2_xattr_entry_real_size(strlen(si->name),
 						 si->value_len);
 
@@ -599,7 +599,7 @@ int ocfs2_calc_security_init(struct inode *dir,
 	 * 256(name) + 80(value) + 16(entry) = 352 bytes,
 	 * So reserve one metadata block for it is ok.
 	 */
-	if (dir->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE ||
+	if (inode_sb(dir)->s_blocksize == OCFS2_MIN_BLOCKSIZE ||
 	    s_size > OCFS2_XATTR_FREE_IN_IBODY) {
 		ret = ocfs2_reserve_new_metadata_blocks(osb, 1, xattr_ac);
 		if (ret) {
@@ -611,10 +611,10 @@ int ocfs2_calc_security_init(struct inode *dir,
 
 	/* reserve clusters for xattr value which will be set in B tree*/
 	if (si->value_len > OCFS2_XATTR_INLINE_SIZE) {
-		int new_clusters = ocfs2_clusters_for_bytes(dir->i_sb,
+		int new_clusters = ocfs2_clusters_for_bytes(inode_sb(dir),
 							    si->value_len);
 
-		*xattr_credits += ocfs2_clusters_to_blocks(dir->i_sb,
+		*xattr_credits += ocfs2_clusters_to_blocks(inode_sb(dir),
 							   new_clusters);
 		*want_clusters += new_clusters;
 	}
@@ -630,7 +630,7 @@ int ocfs2_calc_xattr_init(struct inode *dir,
 			  int *want_meta)
 {
 	int ret = 0;
-	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(dir));
 	int s_size = 0, a_size = 0, acl_len = 0, new_clusters;
 
 	if (si->enable)
@@ -669,17 +669,17 @@ int ocfs2_calc_xattr_init(struct inode *dir,
 	 * we choose to reserve the entire inline area for
 	 * directory contents and force an external xattr block.
 	 */
-	if (dir->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE ||
+	if (inode_sb(dir)->s_blocksize == OCFS2_MIN_BLOCKSIZE ||
 	    (S_ISDIR(mode) && ocfs2_supports_inline_data(osb)) ||
 	    (s_size + a_size) > OCFS2_XATTR_FREE_IN_IBODY) {
 		*want_meta = *want_meta + 1;
 		*xattr_credits += OCFS2_XATTR_BLOCK_CREATE_CREDITS;
 	}
 
-	if (dir->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE &&
+	if (inode_sb(dir)->s_blocksize == OCFS2_MIN_BLOCKSIZE &&
 	    (s_size + a_size) > OCFS2_XATTR_FREE_IN_BLOCK(dir)) {
 		*want_clusters += 1;
-		*xattr_credits += ocfs2_blocks_per_xattr_bucket(dir->i_sb);
+		*xattr_credits += ocfs2_blocks_per_xattr_bucket(inode_sb(dir));
 	}
 
 	/*
@@ -687,9 +687,9 @@ int ocfs2_calc_xattr_init(struct inode *dir,
 	 * and have to be set outside
 	 */
 	if (si->enable && si->value_len > OCFS2_XATTR_INLINE_SIZE) {
-		new_clusters = ocfs2_clusters_for_bytes(dir->i_sb,
+		new_clusters = ocfs2_clusters_for_bytes(inode_sb(dir),
 							si->value_len);
-		*xattr_credits += ocfs2_clusters_to_blocks(dir->i_sb,
+		*xattr_credits += ocfs2_clusters_to_blocks(inode_sb(dir),
 							   new_clusters);
 		*want_clusters += new_clusters;
 	}
@@ -697,8 +697,9 @@ int ocfs2_calc_xattr_init(struct inode *dir,
 	    acl_len > OCFS2_XATTR_INLINE_SIZE) {
 		/* for directory, it has DEFAULT and ACCESS two types of acls */
 		new_clusters = (S_ISDIR(mode) ? 2 : 1) *
-				ocfs2_clusters_for_bytes(dir->i_sb, acl_len);
-		*xattr_credits += ocfs2_clusters_to_blocks(dir->i_sb,
+				ocfs2_clusters_for_bytes(inode_sb(dir),
+							 acl_len);
+		*xattr_credits += ocfs2_clusters_to_blocks(inode_sb(dir),
 							   new_clusters);
 		*want_clusters += new_clusters;
 	}
@@ -756,7 +757,7 @@ static int ocfs2_xattr_extend_allocation(struct inode *inode,
 			 */
 			BUG_ON(why == RESTART_META);
 
-			credits = ocfs2_calc_extend_credits(inode->i_sb,
+			credits = ocfs2_calc_extend_credits(inode_sb(inode),
 							    &vb->vb_xv->xr_list);
 			status = ocfs2_extend_trans(handle, credits);
 			if (status < 0) {
@@ -777,7 +778,7 @@ static int __ocfs2_remove_xattr_range(struct inode *inode,
 				      struct ocfs2_xattr_set_ctxt *ctxt)
 {
 	int ret;
-	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+	u64 phys_blkno = ocfs2_clusters_to_blocks(inode_sb(inode), phys_cpos);
 	handle_t *handle = ctxt->handle;
 	struct ocfs2_extent_tree et;
 
@@ -802,7 +803,7 @@ static int __ocfs2_remove_xattr_range(struct inode *inode,
 
 	if (ext_flags & OCFS2_EXT_REFCOUNTED)
 		ret = ocfs2_decrease_refcount(inode, handle,
-					ocfs2_blocks_to_clusters(inode->i_sb,
+					ocfs2_blocks_to_clusters(inode_sb(inode),
 								 phys_blkno),
 					len, ctxt->meta_ac, &ctxt->dealloc, 1);
 	else
@@ -851,7 +852,7 @@ static int ocfs2_xattr_shrink_size(struct inode *inode,
 			goto out;
 		}
 
-		block = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+		block = ocfs2_clusters_to_blocks(inode_sb(inode), phys_cpos);
 		ocfs2_remove_xattr_clusters_from_cache(INODE_CACHE(inode),
 						       block, alloc_size);
 		cpos += alloc_size;
@@ -868,7 +869,7 @@ static int ocfs2_xattr_value_truncate(struct inode *inode,
 				      struct ocfs2_xattr_set_ctxt *ctxt)
 {
 	int ret;
-	u32 new_clusters = ocfs2_clusters_for_bytes(inode->i_sb, len);
+	u32 new_clusters = ocfs2_clusters_for_bytes(inode_sb(inode), len);
 	u32 old_clusters = le32_to_cpu(vb->vb_xv->xr_clusters);
 
 	if (new_clusters == old_clusters)
@@ -949,7 +950,7 @@ static int ocfs2_xattr_list_entries(struct inode *inode,
 		name = (const char *)header +
 			le16_to_cpu(entry->xe_name_offset);
 
-		ret = ocfs2_xattr_list_entry(inode->i_sb,
+		ret = ocfs2_xattr_list_entry(inode_sb(inode),
 					     buffer, buffer_size,
 					     &result, type, name,
 					     entry->xe_name_len);
@@ -967,8 +968,8 @@ int ocfs2_has_inline_xattr_value_outside(struct inode *inode,
 	int i;
 
 	xh = (struct ocfs2_xattr_header *)
-		 ((void *)di + inode->i_sb->s_blocksize -
-		 le16_to_cpu(di->i_xattr_inline_size));
+		 ((void *)di + inode_sb(inode)->s_blocksize -
+		  le16_to_cpu(di->i_xattr_inline_size));
 
 	for (i = 0; i < le16_to_cpu(xh->xh_count); i++)
 		if (!ocfs2_xattr_is_local(&xh->xh_entries[i]))
@@ -990,8 +991,8 @@ static int ocfs2_xattr_ibody_list(struct inode *inode,
 		return ret;
 
 	header = (struct ocfs2_xattr_header *)
-		 ((void *)di + inode->i_sb->s_blocksize -
-		 le16_to_cpu(di->i_xattr_inline_size));
+		 ((void *)di + inode_sb(inode)->s_blocksize -
+		  le16_to_cpu(di->i_xattr_inline_size));
 
 	ret = ocfs2_xattr_list_entries(inode, header, buffer, buffer_size);
 
@@ -1120,8 +1121,8 @@ static int ocfs2_xattr_get_value_outside(struct inode *inode,
 
 	el = &xv->xr_list;
 	clusters = le32_to_cpu(xv->xr_clusters);
-	bpc = ocfs2_clusters_to_blocks(inode->i_sb, 1);
-	blocksize = inode->i_sb->s_blocksize;
+	bpc = ocfs2_clusters_to_blocks(inode_sb(inode), 1);
+	blocksize = inode_sb(inode)->s_blocksize;
 
 	cpos = 0;
 	while (cpos < clusters) {
@@ -1132,7 +1133,7 @@ static int ocfs2_xattr_get_value_outside(struct inode *inode,
 			goto out;
 		}
 
-		blkno = ocfs2_clusters_to_blocks(inode->i_sb, p_cluster);
+		blkno = ocfs2_clusters_to_blocks(inode_sb(inode), p_cluster);
 		/* Copy ocfs2_xattr_value */
 		for (i = 0; i < num_clusters * bpc; i++, blkno++) {
 			ret = ocfs2_read_block(INODE_CACHE(inode), blkno,
@@ -1174,7 +1175,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
 	if (!(oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL))
 		return -ENODATA;
 
-	xs->end = (void *)di + inode->i_sb->s_blocksize;
+	xs->end = (void *)di + inode_sb(inode)->s_blocksize;
 	xs->header = (struct ocfs2_xattr_header *)
 			(xs->end - le16_to_cpu(di->i_xattr_inline_size));
 	xs->base = (void *)xs->header;
@@ -1251,7 +1252,7 @@ static int ocfs2_xattr_block_get(struct inode *inode,
 		i = xs->here - xs->header->xh_entries;
 
 		if (le16_to_cpu(xb->xb_flags) & OCFS2_XATTR_INDEXED) {
-			ret = ocfs2_xattr_bucket_get_name_value(inode->i_sb,
+			ret = ocfs2_xattr_bucket_get_name_value(inode_sb(inode),
 								bucket_xh(xs->bucket),
 								i,
 								&block_off,
@@ -1302,7 +1303,7 @@ int ocfs2_xattr_get_nolock(struct inode *inode,
 		.not_found = -ENODATA,
 	};
 
-	if (!ocfs2_supports_xattr(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_supports_xattr(OCFS2_SB(inode_sb(inode))))
 		return -EOPNOTSUPP;
 
 	if (!(oi->ip_dyn_features & OCFS2_HAS_XATTR_FL))
@@ -1359,10 +1360,10 @@ static int __ocfs2_xattr_set_value_outside(struct inode *inode,
 					   int value_len)
 {
 	int ret = 0, i, cp_len;
-	u16 blocksize = inode->i_sb->s_blocksize;
+	u16 blocksize = inode_sb(inode)->s_blocksize;
 	u32 p_cluster, num_clusters;
-	u32 cpos = 0, bpc = ocfs2_clusters_to_blocks(inode->i_sb, 1);
-	u32 clusters = ocfs2_clusters_for_bytes(inode->i_sb, value_len);
+	u32 cpos = 0, bpc = ocfs2_clusters_to_blocks(inode_sb(inode), 1);
+	u32 clusters = ocfs2_clusters_for_bytes(inode_sb(inode), value_len);
 	u64 blkno;
 	struct buffer_head *bh = NULL;
 	unsigned int ext_flags;
@@ -1381,7 +1382,7 @@ static int __ocfs2_xattr_set_value_outside(struct inode *inode,
 
 		BUG_ON(ext_flags & OCFS2_EXT_REFCOUNTED);
 
-		blkno = ocfs2_clusters_to_blocks(inode->i_sb, p_cluster);
+		blkno = ocfs2_clusters_to_blocks(inode_sb(inode), p_cluster);
 
 		for (i = 0; i < num_clusters * bpc; i++, blkno++) {
 			ret = ocfs2_read_block(INODE_CACHE(inode), blkno,
@@ -1732,8 +1733,8 @@ static void *ocfs2_xa_bucket_offset_pointer(struct ocfs2_xa_loc *loc,
 	int block, block_offset;
 
 	/* The header is at the front of the bucket */
-	block = offset >> loc->xl_inode->i_sb->s_blocksize_bits;
-	block_offset = offset % loc->xl_inode->i_sb->s_blocksize;
+	block = offset >> inode_sb(loc->xl_inode)->s_blocksize_bits;
+	block_offset = offset % inode_sb(loc->xl_inode)->s_blocksize;
 
 	return bucket_block(bucket, block) + block_offset;
 }
@@ -1773,7 +1774,7 @@ static int ocfs2_xa_bucket_check_space(struct ocfs2_xa_loc *loc,
 	int free_start = ocfs2_xa_get_free_start(loc);
 	int needed_space = ocfs2_xi_entry_usage(xi);
 	int size = namevalue_size_xi(xi);
-	struct super_block *sb = loc->xl_inode->i_sb;
+	struct super_block *sb = inode_sb(loc->xl_inode);
 
 	/*
 	 * Bucket storage does not reclaim name+value pairs it cannot
@@ -1855,7 +1856,7 @@ static void ocfs2_xa_bucket_add_namevalue(struct ocfs2_xa_loc *loc, int size)
 {
 	int free_start = ocfs2_xa_get_free_start(loc);
 	struct ocfs2_xattr_header *xh = loc->xl_header;
-	struct super_block *sb = loc->xl_inode->i_sb;
+	struct super_block *sb = inode_sb(loc->xl_inode);
 	int nameval_offset;
 
 	free_start = ocfs2_bucket_align_free_start(sb, free_start, size);
@@ -1870,7 +1871,7 @@ static void ocfs2_xa_bucket_fill_value_buf(struct ocfs2_xa_loc *loc,
 					   struct ocfs2_xattr_value_buf *vb)
 {
 	struct ocfs2_xattr_bucket *bucket = loc->xl_storage;
-	struct super_block *sb = loc->xl_inode->i_sb;
+	struct super_block *sb = inode_sb(loc->xl_inode);
 	int nameval_offset = le16_to_cpu(loc->xl_entry->xe_name_offset);
 	int size = namevalue_size_xe(loc->xl_entry);
 	int block_offset = nameval_offset >> sb->s_blocksize_bits;
@@ -2358,7 +2359,7 @@ static int ocfs2_lock_xattr_remove_allocators(struct inode *inode,
 		goto out;
 	}
 
-	ret = ocfs2_reserve_new_metadata_blocks(OCFS2_SB(inode->i_sb),
+	ret = ocfs2_reserve_new_metadata_blocks(OCFS2_SB(inode_sb(inode)),
 						meta_add, meta_ac);
 	if (ret)
 		mlog_errno(ret);
@@ -2374,7 +2375,7 @@ static int ocfs2_remove_value_outside(struct inode*inode,
 				      struct buffer_head *ref_root_bh)
 {
 	int ret = 0, i, ref_credits;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_xattr_set_ctxt ctxt = { NULL, NULL, };
 	void *val;
 
@@ -2441,8 +2442,8 @@ static int ocfs2_xattr_ibody_remove(struct inode *inode,
 	};
 
 	header = (struct ocfs2_xattr_header *)
-		 ((void *)di + inode->i_sb->s_blocksize -
-		 le16_to_cpu(di->i_xattr_inline_size));
+		 ((void *)di + inode_sb(inode)->s_blocksize -
+		  le16_to_cpu(di->i_xattr_inline_size));
 
 	ret = ocfs2_remove_value_outside(inode, &vb, header,
 					 ref_ci, ref_root_bh);
@@ -2494,7 +2495,7 @@ static int ocfs2_xattr_free_block(struct inode *inode,
 	struct buffer_head *xb_alloc_bh = NULL;
 	struct buffer_head *blk_bh = NULL;
 	struct ocfs2_xattr_block *xb;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	handle_t *handle;
 	int ret = 0;
 	u64 blk, bg_blkno;
@@ -2575,14 +2576,14 @@ int ocfs2_xattr_remove(struct inode *inode, struct buffer_head *di_bh)
 	handle_t *handle;
 	int ret;
 
-	if (!ocfs2_supports_xattr(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_supports_xattr(OCFS2_SB(inode_sb(inode))))
 		return 0;
 
 	if (!(oi->ip_dyn_features & OCFS2_HAS_XATTR_FL))
 		return 0;
 
 	if (ocfs2_is_refcount_inode(inode)) {
-		ret = ocfs2_lock_refcount_tree(OCFS2_SB(inode->i_sb),
+		ret = ocfs2_lock_refcount_tree(OCFS2_SB(inode_sb(inode)),
 					       le64_to_cpu(di->i_refcount_loc),
 					       1, &ref_tree, &ref_root_bh);
 		if (ret) {
@@ -2612,7 +2613,7 @@ int ocfs2_xattr_remove(struct inode *inode, struct buffer_head *di_bh)
 		}
 	}
 
-	handle = ocfs2_start_trans((OCFS2_SB(inode->i_sb)),
+	handle = ocfs2_start_trans((OCFS2_SB(inode_sb(inode))),
 				   OCFS2_INODE_UPDATE_CREDITS);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
@@ -2636,10 +2637,11 @@ int ocfs2_xattr_remove(struct inode *inode, struct buffer_head *di_bh)
 
 	ocfs2_journal_dirty(handle, di_bh);
 out_commit:
-	ocfs2_commit_trans(OCFS2_SB(inode->i_sb), handle);
+	ocfs2_commit_trans(OCFS2_SB(inode_sb(inode)), handle);
 out:
 	if (ref_tree)
-		ocfs2_unlock_refcount_tree(OCFS2_SB(inode->i_sb), ref_tree, 1);
+		ocfs2_unlock_refcount_tree(OCFS2_SB(inode_sb(inode)),
+					   ref_tree, 1);
 	brelse(ref_root_bh);
 	return ret;
 }
@@ -2648,7 +2650,7 @@ static int ocfs2_xattr_has_space_inline(struct inode *inode,
 					struct ocfs2_dinode *di)
 {
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
-	unsigned int xattrsize = OCFS2_SB(inode->i_sb)->s_xattr_inline_size;
+	unsigned int xattrsize = OCFS2_SB(inode_sb(inode))->s_xattr_inline_size;
 	int free;
 
 	if (xattrsize < OCFS2_MIN_XATTR_INLINE_SIZE)
@@ -2658,7 +2660,7 @@ static int ocfs2_xattr_has_space_inline(struct inode *inode,
 		struct ocfs2_inline_data *idata = &di->id2.i_data;
 		free = le16_to_cpu(idata->id_count) - le64_to_cpu(di->i_size);
 	} else if (ocfs2_inode_is_fast_symlink(inode)) {
-		free = ocfs2_fast_symlink_chars(inode->i_sb) -
+		free = ocfs2_fast_symlink_chars(inode_sb(inode)) -
 			le64_to_cpu(di->i_size);
 	} else {
 		struct ocfs2_extent_list *el = &di->id2.i_list;
@@ -2688,7 +2690,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 	int ret;
 	int has_space = 0;
 
-	if (inode->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE)
+	if (inode_sb(inode)->s_blocksize == OCFS2_MIN_BLOCKSIZE)
 		return 0;
 
 	if (!(oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)) {
@@ -2700,13 +2702,13 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 	}
 
 	xs->xattr_bh = xs->inode_bh;
-	xs->end = (void *)di + inode->i_sb->s_blocksize;
+	xs->end = (void *)di + inode_sb(inode)->s_blocksize;
 	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)
 		xs->header = (struct ocfs2_xattr_header *)
 			(xs->end - le16_to_cpu(di->i_xattr_inline_size));
 	else
 		xs->header = (struct ocfs2_xattr_header *)
-			(xs->end - OCFS2_SB(inode->i_sb)->s_xattr_inline_size);
+			(xs->end - OCFS2_SB(inode_sb(inode))->s_xattr_inline_size);
 	xs->base = (void *)xs->header;
 	xs->here = xs->header->xh_entries;
 
@@ -2728,7 +2730,7 @@ static int ocfs2_xattr_ibody_init(struct inode *inode,
 	int ret;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	unsigned int xattrsize = osb->s_xattr_inline_size;
 
 	if (!ocfs2_xattr_has_space_inline(inode, di)) {
@@ -2783,7 +2785,7 @@ static int ocfs2_xattr_ibody_set(struct inode *inode,
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_xa_loc loc;
 
-	if (inode->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE)
+	if (inode_sb(inode)->s_blocksize == OCFS2_MIN_BLOCKSIZE)
 		return -ENOSPC;
 
 	down_write(&oi->ip_alloc_sem);
@@ -2894,7 +2896,7 @@ static int ocfs2_create_xattr_block(struct inode *inode,
 		goto end;
 	}
 
-	new_bh = sb_getblk(inode->i_sb, first_blkno);
+	new_bh = sb_getblk(inode_sb(inode), first_blkno);
 	if (!new_bh) {
 		ret = -ENOMEM;
 		mlog_errno(ret);
@@ -2913,13 +2915,13 @@ static int ocfs2_create_xattr_block(struct inode *inode,
 
 	/* Initialize ocfs2_xattr_block */
 	xblk = (struct ocfs2_xattr_block *)new_bh->b_data;
-	memset(xblk, 0, inode->i_sb->s_blocksize);
+	memset(xblk, 0, inode_sb(inode)->s_blocksize);
 	strcpy((void *)xblk, OCFS2_XATTR_BLOCK_SIGNATURE);
 	xblk->xb_suballoc_slot = cpu_to_le16(ctxt->meta_ac->ac_alloc_slot);
 	xblk->xb_suballoc_loc = cpu_to_le64(suballoc_loc);
 	xblk->xb_suballoc_bit = cpu_to_le16(suballoc_bit_start);
 	xblk->xb_fs_generation =
-		cpu_to_le32(OCFS2_SB(inode->i_sb)->fs_generation);
+		cpu_to_le32(OCFS2_SB(inode_sb(inode))->fs_generation);
 	xblk->xb_blkno = cpu_to_le64(first_blkno);
 	if (indexed) {
 		struct ocfs2_xattr_tree_root *xr = &xblk->xb_attrs.xb_root;
@@ -2927,7 +2929,7 @@ static int ocfs2_create_xattr_block(struct inode *inode,
 		xr->xt_last_eb_blk = 0;
 		xr->xt_list.l_tree_depth = 0;
 		xr->xt_list.l_count = cpu_to_le16(
-					ocfs2_xattr_recs_per_xb(inode->i_sb));
+					ocfs2_xattr_recs_per_xb(inode_sb(inode)));
 		xr->xt_list.l_next_free_rec = cpu_to_le16(1);
 		xblk->xb_flags = cpu_to_le16(OCFS2_XATTR_INDEXED);
 	}
@@ -2979,7 +2981,7 @@ static int ocfs2_xattr_block_set(struct inode *inode,
 		xblk = (struct ocfs2_xattr_block *)xs->xattr_bh->b_data;
 		xs->header = &xblk->xb_attrs.xb_header;
 		xs->base = (void *)xs->header;
-		xs->end = (void *)xblk + inode->i_sb->s_blocksize;
+		xs->end = (void *)xblk + inode_sb(inode)->s_blocksize;
 		xs->here = xs->header->xh_entries;
 	} else
 		xblk = (struct ocfs2_xattr_block *)xs->xattr_bh->b_data;
@@ -3057,7 +3059,7 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 	struct ocfs2_xattr_value_root *xv = NULL;
 	char *base = NULL;
 	int name_offset, name_len = 0;
-	u32 new_clusters = ocfs2_clusters_for_bytes(inode->i_sb,
+	u32 new_clusters = ocfs2_clusters_for_bytes(inode_sb(inode),
 						    xi->xi_value_len);
 	u64 value_size;
 
@@ -3068,15 +3070,15 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 	 */
 	if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE)
 		credits += new_clusters *
-			   ocfs2_clusters_to_blocks(inode->i_sb, 1);
+			   ocfs2_clusters_to_blocks(inode_sb(inode), 1);
 
 	if (xis->not_found && xbs->not_found) {
-		credits += ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+		credits += ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 
 		if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE) {
 			clusters_add += new_clusters;
-			credits += ocfs2_calc_extend_credits(inode->i_sb,
-							&def_xv.xv.xr_list);
+			credits += ocfs2_calc_extend_credits(inode_sb(inode),
+							     &def_xv.xv.xr_list);
 		}
 
 		goto meta_guess;
@@ -3098,12 +3100,12 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		old_in_xb = 1;
 
 		if (le16_to_cpu(xb->xb_flags) & OCFS2_XATTR_INDEXED) {
-			ret = ocfs2_xattr_bucket_get_name_value(inode->i_sb,
-							bucket_xh(xbs->bucket),
-							i, &block_off,
-							&name_offset);
+			ret = ocfs2_xattr_bucket_get_name_value(inode_sb(inode),
+								bucket_xh(xbs->bucket),
+								i, &block_off,
+								&name_offset);
 			base = bucket_block(xbs->bucket, block_off);
-			credits += ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+			credits += ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 		} else {
 			base = xbs->base;
 			credits += OCFS2_XATTR_BLOCK_UPDATE_CREDITS;
@@ -3119,7 +3121,7 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 	 */
 	if (!xi->xi_value) {
 		if (!ocfs2_xattr_is_local(xe))
-			credits += ocfs2_remove_extent_credits(inode->i_sb);
+			credits += ocfs2_remove_extent_credits(inode_sb(inode));
 
 		goto out;
 	}
@@ -3136,12 +3138,11 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		 */
 		if (ocfs2_xattr_can_be_in_inode(inode, xi, xis)) {
 			clusters_add += new_clusters;
-			credits += ocfs2_remove_extent_credits(inode->i_sb) +
+			credits += ocfs2_remove_extent_credits(inode_sb(inode)) +
 				    OCFS2_INODE_UPDATE_CREDITS;
 			if (!ocfs2_xattr_is_local(xe))
-				credits += ocfs2_calc_extend_credits(
-							inode->i_sb,
-							&def_xv.xv.xr_list);
+				credits += ocfs2_calc_extend_credits(inode_sb(inode),
+								     &def_xv.xv.xr_list);
 			goto out;
 		}
 	}
@@ -3151,8 +3152,8 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		u32 old_clusters = 0;
 
 		if (!ocfs2_xattr_is_local(xe)) {
-			old_clusters =	ocfs2_clusters_for_bytes(inode->i_sb,
-								 value_size);
+			old_clusters =	ocfs2_clusters_for_bytes(inode_sb(inode),
+								       value_size);
 			xv = (struct ocfs2_xattr_value_root *)
 			     (base + name_offset + name_len);
 			value_size = OCFS2_XATTR_ROOT_SIZE;
@@ -3160,12 +3161,12 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 			xv = &def_xv.xv;
 
 		if (old_clusters >= new_clusters) {
-			credits += ocfs2_remove_extent_credits(inode->i_sb);
+			credits += ocfs2_remove_extent_credits(inode_sb(inode));
 			goto out;
 		} else {
 			meta_add += ocfs2_extend_meta_needed(&xv->xr_list);
 			clusters_add += new_clusters - old_clusters;
-			credits += ocfs2_calc_extend_credits(inode->i_sb,
+			credits += ocfs2_calc_extend_credits(inode_sb(inode),
 							     &xv->xr_list);
 			if (value_size >= OCFS2_XATTR_ROOT_SIZE)
 				goto out;
@@ -3211,7 +3212,7 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 			struct ocfs2_extent_list *el =
 				 &xb->xb_attrs.xb_root.xt_list;
 			meta_add += ocfs2_extend_meta_needed(el);
-			credits += ocfs2_calc_extend_credits(inode->i_sb,
+			credits += ocfs2_calc_extend_credits(inode_sb(inode),
 							     el);
 		} else
 			credits += OCFS2_SUBALLOC_ALLOC + 1;
@@ -3224,10 +3225,10 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		 * also.
 		 */
 		clusters_add += 1;
-		credits += ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+		credits += ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 		if (OCFS2_XATTR_BUCKET_SIZE ==
-			OCFS2_SB(inode->i_sb)->s_clustersize) {
-			credits += ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+			OCFS2_SB(inode_sb(inode))->s_clustersize) {
+			credits += ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 			clusters_add += 1;
 		}
 	} else {
@@ -3235,7 +3236,7 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE) {
 			struct ocfs2_extent_list *el = &def_xv.xv.xr_list;
 			meta_add += ocfs2_extend_meta_needed(el);
-			credits += ocfs2_calc_extend_credits(inode->i_sb,
+			credits += ocfs2_calc_extend_credits(inode_sb(inode),
 							     el);
 		} else {
 			meta_add += 1;
@@ -3262,7 +3263,7 @@ static int ocfs2_init_xattr_set_ctxt(struct inode *inode,
 				     int *credits)
 {
 	int clusters_add, meta_add, ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	memset(ctxt, 0, sizeof(struct ocfs2_xattr_set_ctxt));
 
@@ -3485,7 +3486,7 @@ int ocfs2_xattr_set_handle(handle_t *handle,
 		.data_ac = data_ac,
 	};
 
-	if (!ocfs2_supports_xattr(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_supports_xattr(OCFS2_SB(inode_sb(inode))))
 		return -EOPNOTSUPP;
 
 	/*
@@ -3493,7 +3494,7 @@ int ocfs2_xattr_set_handle(handle_t *handle,
 	 * block size is too small. And we have already reserved
 	 * the credits for bucket in mknod.
 	 */
-	if (inode->i_sb->s_blocksize == OCFS2_MIN_BLOCKSIZE) {
+	if (inode_sb(inode)->s_blocksize == OCFS2_MIN_BLOCKSIZE) {
 		xbs.bucket = ocfs2_xattr_bucket_new(inode);
 		if (!xbs.bucket) {
 			mlog_errno(-ENOMEM);
@@ -3542,7 +3543,7 @@ int ocfs2_xattr_set(struct inode *inode,
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_dinode *di;
 	int ret, credits, had_lock, ref_meta = 0, ref_credits = 0;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *tl_inode = osb->osb_tl_inode;
 	struct ocfs2_xattr_set_ctxt ctxt = { NULL, NULL, NULL, };
 	struct ocfs2_refcount_tree *ref_tree = NULL;
@@ -3564,7 +3565,7 @@ int ocfs2_xattr_set(struct inode *inode,
 		.not_found = -ENODATA,
 	};
 
-	if (!ocfs2_supports_xattr(OCFS2_SB(inode->i_sb)))
+	if (!ocfs2_supports_xattr(OCFS2_SB(inode_sb(inode))))
 		return -EOPNOTSUPP;
 
 	/*
@@ -3715,7 +3716,7 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
 		el = &eb->h_list;
 
 		if (el->l_tree_depth) {
-			ret = ocfs2_error(inode->i_sb,
+			ret = ocfs2_error(inode_sb(inode),
 					  "Inode %lu has non zero tree depth in xattr tree block %llu\n",
 					  inode->i_ino,
 					  (unsigned long long)eb_bh->b_blocknr);
@@ -3733,7 +3734,8 @@ static int ocfs2_xattr_get_rec(struct inode *inode,
 	}
 
 	if (!e_blkno) {
-		ret = ocfs2_error(inode->i_sb, "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
+		ret = ocfs2_error(inode_sb(inode),
+				  "Inode %lu has bad extent record (%u, %u, 0) in xattr\n",
 				  inode->i_ino,
 				  le32_to_cpu(rec->e_cpos),
 				  ocfs2_rec_clusters(el, rec));
@@ -3785,7 +3787,7 @@ static int ocfs2_find_xe_in_bucket(struct inode *inode,
 		if (cmp)
 			continue;
 
-		ret = ocfs2_xattr_bucket_get_name_value(inode->i_sb,
+		ret = ocfs2_xattr_bucket_get_name_value(inode_sb(inode),
 							xh,
 							i,
 							&block_off,
@@ -3830,7 +3832,7 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 	struct ocfs2_xattr_header *xh = NULL;
 	struct ocfs2_xattr_entry *xe = NULL;
 	u16 index = 0;
-	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	int low_bucket = 0, bucket, high_bucket;
 	struct ocfs2_xattr_bucket *search;
 	u32 last_hash;
@@ -3915,7 +3917,7 @@ static int ocfs2_xattr_bucket_find(struct inode *inode,
 
 	xs->header = bucket_xh(xs->bucket);
 	xs->base = bucket_block(xs->bucket, 0);
-	xs->end = xs->base + inode->i_sb->s_blocksize;
+	xs->end = xs->base + inode_sb(inode)->s_blocksize;
 
 	if (found) {
 		xs->here = &xs->header->xh_entries[index];
@@ -3982,7 +3984,7 @@ static int ocfs2_iterate_xattr_buckets(struct inode *inode,
 				       void *para)
 {
 	int i, ret = 0;
-	u32 bpc = ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode->i_sb));
+	u32 bpc = ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode_sb(inode)));
 	u32 num_buckets = clusters * bpc;
 	struct ocfs2_xattr_bucket *bucket;
 
@@ -4066,7 +4068,7 @@ static int ocfs2_list_xattr_bucket(struct inode *inode,
 		struct ocfs2_xattr_entry *entry = &bucket_xh(bucket)->xh_entries[i];
 		type = ocfs2_xattr_get_type(entry);
 
-		ret = ocfs2_xattr_bucket_get_name_value(inode->i_sb,
+		ret = ocfs2_xattr_bucket_get_name_value(inode_sb(inode),
 							bucket_xh(bucket),
 							i,
 							&block_off,
@@ -4076,7 +4078,7 @@ static int ocfs2_list_xattr_bucket(struct inode *inode,
 
 		name = (const char *)bucket_block(bucket, block_off) +
 			new_offset;
-		ret = ocfs2_xattr_list_entry(inode->i_sb,
+		ret = ocfs2_xattr_list_entry(inode_sb(inode),
 					     xl->buffer,
 					     xl->buffer_size,
 					     &xl->result,
@@ -4196,8 +4198,8 @@ static void ocfs2_cp_xattr_block_to_bucket(struct inode *inode,
 					   struct buffer_head *xb_bh,
 					   struct ocfs2_xattr_bucket *bucket)
 {
-	int i, blocksize = inode->i_sb->s_blocksize;
-	int blks = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	int i, blocksize = inode_sb(inode)->s_blocksize;
+	int blks = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	u16 offset, size, off_change;
 	struct ocfs2_xattr_entry *xe;
 	struct ocfs2_xattr_block *xb =
@@ -4271,7 +4273,7 @@ static void ocfs2_xattr_update_xattr_search(struct inode *inode,
 
 	xs->header = bucket_xh(xs->bucket);
 	xs->base = bucket_block(xs->bucket, 0);
-	xs->end = xs->base + inode->i_sb->s_blocksize;
+	xs->end = xs->base + inode_sb(inode)->s_blocksize;
 
 	if (xs->not_found)
 		return;
@@ -4327,7 +4329,7 @@ static int ocfs2_xattr_create_index_block(struct inode *inode,
 	 * we will only touch the 1st block and the last block
 	 * in the whole bucket(one for entry and one for data).
 	 */
-	blkno = ocfs2_clusters_to_blocks(inode->i_sb, bit_off);
+	blkno = ocfs2_clusters_to_blocks(inode_sb(inode), bit_off);
 
 	trace_ocfs2_xattr_create_index_block((unsigned long long)blkno);
 
@@ -4350,14 +4352,14 @@ static int ocfs2_xattr_create_index_block(struct inode *inode,
 	ocfs2_xattr_update_xattr_search(inode, xs, xb_bh);
 
 	/* Change from ocfs2_xattr_header to ocfs2_xattr_tree_root */
-	memset(&xb->xb_attrs, 0, inode->i_sb->s_blocksize -
+	memset(&xb->xb_attrs, 0, inode_sb(inode)->s_blocksize -
 	       offsetof(struct ocfs2_xattr_block, xb_attrs));
 
 	xr = &xb->xb_attrs.xb_root;
 	xr->xt_clusters = cpu_to_le32(1);
 	xr->xt_last_eb_blk = 0;
 	xr->xt_list.l_tree_depth = 0;
-	xr->xt_list.l_count = cpu_to_le16(ocfs2_xattr_recs_per_xb(inode->i_sb));
+	xr->xt_list.l_count = cpu_to_le16(ocfs2_xattr_recs_per_xb(inode_sb(inode)));
 	xr->xt_list.l_next_free_rec = cpu_to_le16(1);
 
 	xr->xt_list.l_recs[0].e_cpos = 0;
@@ -4403,7 +4405,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
 	char *entries, *buf, *bucket_buf = NULL;
 	u64 blkno = bucket_blkno(bucket);
 	u16 xh_free_start;
-	size_t blocksize = inode->i_sb->s_blocksize;
+	size_t blocksize = inode_sb(inode)->s_blocksize;
 	struct ocfs2_xattr_entry *xe;
 
 	/*
@@ -4524,7 +4526,7 @@ static int ocfs2_mv_xattr_bucket_cross_cluster(struct inode *inode,
 					       u32 *first_hash)
 {
 	int ret;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int blks_per_bucket = ocfs2_blocks_per_xattr_bucket(sb);
 	int num_buckets = ocfs2_xattr_buckets_per_cluster(OCFS2_SB(sb));
 	int to_move = num_buckets / 2;
@@ -4645,7 +4647,7 @@ static int ocfs2_divide_xattr_bucket(struct inode *inode,
 	struct ocfs2_xattr_bucket *s_bucket = NULL, *t_bucket = NULL;
 	struct ocfs2_xattr_header *xh;
 	struct ocfs2_xattr_entry *xe;
-	int blocksize = inode->i_sb->s_blocksize;
+	int blocksize = inode_sb(inode)->s_blocksize;
 
 	trace_ocfs2_divide_xattr_bucket_begin((unsigned long long)blk,
 					      (unsigned long long)new_blk);
@@ -4890,8 +4892,8 @@ static int ocfs2_mv_xattr_buckets(struct inode *inode, handle_t *handle,
 				  u32 *first_hash)
 {
 	int i, ret, credits;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-	int blks_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
+	int blks_per_bucket = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	int num_buckets = ocfs2_xattr_buckets_per_cluster(osb);
 	struct ocfs2_xattr_bucket *old_first, *new_first;
 
@@ -4993,10 +4995,10 @@ static int ocfs2_divide_xattr_cluster(struct inode *inode,
 				      u64 new_blk,
 				      u32 *first_hash)
 {
-	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	int ret, credits = 2 * blk_per_bucket;
 
-	BUG_ON(OCFS2_XATTR_BUCKET_SIZE < OCFS2_SB(inode->i_sb)->s_clustersize);
+	BUG_ON(OCFS2_XATTR_BUCKET_SIZE < OCFS2_SB(inode_sb(inode))->s_clustersize);
 
 	ret = ocfs2_extend_trans(handle, credits);
 	if (ret) {
@@ -5050,7 +5052,7 @@ static int ocfs2_adjust_xattr_cross_cluster(struct inode *inode,
 			(unsigned long long)bucket_blkno(first),
 			(unsigned long long)new_blk, prev_clusters);
 
-	if (ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode->i_sb)) > 1) {
+	if (ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode_sb(inode))) > 1) {
 		ret = ocfs2_mv_xattr_bucket_cross_cluster(inode,
 							  handle,
 							  first, target,
@@ -5063,7 +5065,7 @@ static int ocfs2_adjust_xattr_cross_cluster(struct inode *inode,
 		/* The start of the last cluster in the first extent */
 		u64 last_blk = bucket_blkno(first) +
 			((prev_clusters - 1) *
-			 ocfs2_clusters_to_blocks(inode->i_sb, 1));
+			 ocfs2_clusters_to_blocks(inode_sb(inode), 1));
 
 		if (prev_clusters > 1 && bucket_blkno(target) != last_blk) {
 			ret = ocfs2_mv_xattr_buckets(inode, handle,
@@ -5113,12 +5115,12 @@ static int ocfs2_add_new_xattr_cluster(struct inode *inode,
 				       struct ocfs2_xattr_set_ctxt *ctxt)
 {
 	int ret;
-	u16 bpc = ocfs2_clusters_to_blocks(inode->i_sb, 1);
+	u16 bpc = ocfs2_clusters_to_blocks(inode_sb(inode), 1);
 	u32 prev_clusters = *num_clusters;
 	u32 clusters_to_add = 1, bit_off, num_bits, v_start = 0;
 	u64 block;
 	handle_t *handle = ctxt->handle;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_extent_tree et;
 
 	trace_ocfs2_add_new_xattr_cluster_begin(
@@ -5208,8 +5210,8 @@ static int ocfs2_extend_xattr_bucket(struct inode *inode,
 				     u32 num_clusters)
 {
 	int ret, credits;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
-	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
+	u16 blk_per_bucket = ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	u64 end_blk;
 	u16 new_bucket = le16_to_cpu(bucket_xh(first)->xh_num_buckets);
 
@@ -5288,7 +5290,7 @@ static int ocfs2_add_new_xattr_bucket(struct inode *inode,
 	struct ocfs2_extent_list *el = &xb_root->xt_list;
 	u32 name_hash =
 		le32_to_cpu(bucket_xh(target)->xh_entries[0].xe_name_hash);
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	int ret, num_buckets, extend = 1;
 	u64 p_blkno;
 	u32 e_cpos, num_clusters;
@@ -5372,7 +5374,7 @@ static int ocfs2_xattr_bucket_value_truncate(struct inode *inode,
 	u64 value_blk;
 	struct ocfs2_xattr_entry *xe;
 	struct ocfs2_xattr_header *xh = bucket_xh(bucket);
-	size_t blocksize = inode->i_sb->s_blocksize;
+	size_t blocksize = inode_sb(inode)->s_blocksize;
 	struct ocfs2_xattr_value_buf vb = {
 		.vb_access = ocfs2_journal_access,
 	};
@@ -5433,7 +5435,7 @@ static int ocfs2_rm_xattr_cluster(struct inode *inode,
 				  void *para)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct inode *tl_inode = osb->osb_tl_inode;
 	handle_t *handle;
 	struct ocfs2_xattr_block *xb =
@@ -5669,10 +5671,10 @@ static int ocfs2_delete_xattr_in_bucket(struct inode *inode,
 	struct ocfs2_xattr_header *xh = bucket_xh(bucket);
 	u16 i;
 	struct ocfs2_xattr_entry *xe;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_xattr_set_ctxt ctxt = {NULL, NULL,};
 	int credits = ocfs2_remove_extent_credits(osb->sb) +
-		ocfs2_blocks_per_xattr_bucket(inode->i_sb);
+		ocfs2_blocks_per_xattr_bucket(inode_sb(inode));
 	struct ocfs2_xattr_value_root *xv;
 	struct ocfs2_rm_xattr_bucket_para *args =
 			(struct ocfs2_rm_xattr_bucket_para *)para;
@@ -5684,7 +5686,7 @@ static int ocfs2_delete_xattr_in_bucket(struct inode *inode,
 		if (ocfs2_xattr_is_local(xe))
 			continue;
 
-		ret = ocfs2_get_xattr_tree_value_root(inode->i_sb, bucket,
+		ret = ocfs2_get_xattr_tree_value_root(inode_sb(inode), bucket,
 						      i, &xv, NULL);
 		if (ret) {
 			mlog_errno(ret);
@@ -5785,7 +5787,7 @@ static int ocfs2_prepare_refcount_xattr(struct inode *inode,
 	int name_offset, name_len;
 	struct ocfs2_xattr_value_buf vb;
 	struct ocfs2_xattr_bucket *bucket = NULL;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_post_refcount refcount;
 	struct ocfs2_post_refcount *p = NULL;
 	struct buffer_head *ref_root_bh = NULL;
@@ -5806,10 +5808,10 @@ static int ocfs2_prepare_refcount_xattr(struct inode *inode,
 		i = xbs->here - xbs->header->xh_entries;
 
 		if (le16_to_cpu(xb->xb_flags) & OCFS2_XATTR_INDEXED) {
-			ret = ocfs2_xattr_bucket_get_name_value(inode->i_sb,
-							bucket_xh(xbs->bucket),
-							i, &block_off,
-							&name_offset);
+			ret = ocfs2_xattr_bucket_get_name_value(inode_sb(inode),
+								bucket_xh(xbs->bucket),
+								i, &block_off,
+								&name_offset);
 			if (ret) {
 				mlog_errno(ret);
 				goto out;
@@ -5991,8 +5993,8 @@ static int ocfs2_xattr_inline_attach_refcount(struct inode *inode,
 {
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)fe_bh->b_data;
 	struct ocfs2_xattr_header *header = (struct ocfs2_xattr_header *)
-				(fe_bh->b_data + inode->i_sb->s_blocksize -
-				le16_to_cpu(di->i_xattr_inline_size));
+				(fe_bh->b_data + inode_sb(inode)->s_blocksize -
+				 le16_to_cpu(di->i_xattr_inline_size));
 	struct ocfs2_xattr_value_buf vb = {
 		.vb_bh = fe_bh,
 		.vb_access = ocfs2_journal_access_di,
@@ -6066,7 +6068,7 @@ static int ocfs2_xattr_bucket_value_refcount(struct inode *inode,
 	struct ocfs2_post_refcount *p = NULL;
 
 	/* We only need post_refcount if we support metaecc. */
-	if (ocfs2_meta_ecc(OCFS2_SB(inode->i_sb)))
+	if (ocfs2_meta_ecc(OCFS2_SB(inode_sb(inode))))
 		p = &refcount;
 
 	trace_ocfs2_xattr_bucket_value_refcount(
@@ -6078,7 +6080,8 @@ static int ocfs2_xattr_bucket_value_refcount(struct inode *inode,
 		if (ocfs2_xattr_is_local(xe))
 			continue;
 
-		ret = ocfs2_get_xattr_tree_value_root(inode->i_sb, bucket, i,
+		ret = ocfs2_get_xattr_tree_value_root(inode_sb(inode), bucket,
+						      i,
 						      &vb.vb_xv, &vb.vb_bh);
 		if (ret) {
 			mlog_errno(ret);
@@ -6358,7 +6361,7 @@ static int ocfs2_reflink_xattr_header(handle_t *handle,
 				      void *para)
 {
 	int ret = 0, i, j;
-	struct super_block *sb = args->old_inode->i_sb;
+	struct super_block *sb = inode_sb(args->old_inode);
 	struct buffer_head *value_bh;
 	struct ocfs2_xattr_entry *xe, *last;
 	struct ocfs2_xattr_value_root *xv, *new_xv;
@@ -6444,9 +6447,8 @@ static int ocfs2_reflink_xattr_header(handle_t *handle,
 			if (xv->xr_list.l_tree_depth) {
 				ret = ocfs2_insert_extent(handle,
 						&data_et, cpos,
-						ocfs2_clusters_to_blocks(
-							args->old_inode->i_sb,
-							p_cluster),
+						ocfs2_clusters_to_blocks(inode_sb(args->old_inode),
+									 p_cluster),
 						num_clusters, ext_flags,
 						meta_ac);
 				if (ret) {
@@ -6476,7 +6478,7 @@ static int ocfs2_reflink_xattr_inline(struct ocfs2_xattr_reflink *args)
 {
 	int ret = 0, credits = 0;
 	handle_t *handle;
-	struct ocfs2_super *osb = OCFS2_SB(args->old_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(args->old_inode));
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)args->old_bh->b_data;
 	int inline_size = le16_to_cpu(di->i_xattr_inline_size);
 	int header_off = osb->sb->s_blocksize - inline_size;
@@ -6560,7 +6562,7 @@ static int ocfs2_create_empty_xattr_block(struct inode *inode,
 					  int indexed)
 {
 	int ret;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_xattr_set_ctxt ctxt;
 
 	memset(&ctxt, 0, sizeof(ctxt));
@@ -6598,7 +6600,7 @@ static int ocfs2_reflink_xattr_block(struct ocfs2_xattr_reflink *args,
 	handle_t *handle;
 	struct ocfs2_inode_info *new_oi = OCFS2_I(args->new_inode);
 	struct ocfs2_dinode *new_di;
-	struct ocfs2_super *osb = OCFS2_SB(args->new_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(args->new_inode));
 	int header_off = offsetof(struct ocfs2_xattr_block, xb_attrs.xb_header);
 	struct ocfs2_xattr_block *xb =
 			(struct ocfs2_xattr_block *)blk_bh->b_data;
@@ -6743,11 +6745,13 @@ static int ocfs2_calc_value_tree_metas(struct inode *inode,
 
 	/* Add the credits for this bucket first. */
 	metas->credits += bucket->bu_blocks;
-	return ocfs2_value_metas_in_xattr_header(inode->i_sb, bucket->bu_bhs[0],
-					xh, &metas->num_metas,
-					&metas->credits, &metas->num_recs,
-					ocfs2_value_tree_metas_in_bucket,
-					bucket);
+	return ocfs2_value_metas_in_xattr_header(inode_sb(inode),
+						 bucket->bu_bhs[0],
+						 xh, &metas->num_metas,
+						 &metas->credits,
+						 &metas->num_recs,
+						 ocfs2_value_tree_metas_in_bucket,
+						 bucket);
 }
 
 /*
@@ -6764,7 +6768,7 @@ static int ocfs2_lock_reflink_xattr_rec_allocators(
 {
 	int ret, num_free_extents;
 	struct ocfs2_value_tree_metas metas;
-	struct ocfs2_super *osb = OCFS2_SB(args->reflink->old_inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(args->reflink->old_inode));
 	struct ocfs2_refcount_block *rb;
 
 	memset(&metas, 0, sizeof(metas));
@@ -6849,7 +6853,7 @@ static int ocfs2_reflink_xattr_bucket(handle_t *handle,
 				struct ocfs2_reflink_xattr_tree_args *args)
 {
 	int i, j, ret = 0;
-	struct super_block *sb = args->reflink->old_inode->i_sb;
+	struct super_block *sb = inode_sb(args->reflink->old_inode);
 	int bpb = args->old_bucket->bu_blocks;
 	struct ocfs2_xattr_value_buf vb = {
 		.vb_access = ocfs2_journal_access,
@@ -6945,7 +6949,7 @@ static int ocfs2_reflink_xattr_buckets(handle_t *handle,
 	u64 new_blkno;
 	unsigned int num_buckets, reflink_buckets;
 	unsigned int bpc =
-		ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode->i_sb));
+		ocfs2_xattr_buckets_per_cluster(OCFS2_SB(inode_sb(inode)));
 
 	ret = ocfs2_read_xattr_bucket(args->old_bucket, blkno);
 	if (ret) {
@@ -6963,7 +6967,8 @@ static int ocfs2_reflink_xattr_buckets(handle_t *handle,
 			goto out;
 		}
 
-		new_blkno = ocfs2_clusters_to_blocks(inode->i_sb, p_cluster);
+		new_blkno = ocfs2_clusters_to_blocks(inode_sb(inode),
+						     p_cluster);
 		reflink_buckets = min(num_buckets, bpc * num_clusters);
 
 		ret = ocfs2_reflink_xattr_bucket(handle, blkno,
@@ -6993,7 +6998,8 @@ static int ocfs2_reflink_xattr_buckets(handle_t *handle,
 						  num_clusters, reflink_cpos);
 
 		len -= num_clusters;
-		blkno += ocfs2_clusters_to_blocks(inode->i_sb, num_clusters);
+		blkno += ocfs2_clusters_to_blocks(inode_sb(inode),
+						  num_clusters);
 		num_buckets -= reflink_buckets;
 	}
 out:
@@ -7014,7 +7020,7 @@ static int ocfs2_reflink_xattr_rec(struct inode *inode,
 	handle_t *handle;
 	struct ocfs2_reflink_xattr_tree_args *args =
 			(struct ocfs2_reflink_xattr_tree_args *)para;
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 	struct ocfs2_alloc_context *meta_ac = NULL;
 	struct ocfs2_alloc_context *data_ac = NULL;
 	struct ocfs2_extent_tree et;
@@ -7153,7 +7159,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
 	struct ocfs2_refcount_tree *ref_tree;
 	struct buffer_head *ref_root_bh = NULL;
 
-	ret = ocfs2_lock_refcount_tree(OCFS2_SB(old_inode->i_sb),
+	ret = ocfs2_lock_refcount_tree(OCFS2_SB(inode_sb(old_inode)),
 				       le64_to_cpu(di->i_refcount_loc),
 				       1, &ref_tree, &ref_root_bh);
 	if (ret) {
@@ -7200,13 +7206,14 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
 	brelse(blk_bh);
 
 out_unlock:
-	ocfs2_unlock_refcount_tree(OCFS2_SB(old_inode->i_sb),
+	ocfs2_unlock_refcount_tree(OCFS2_SB(inode_sb(old_inode)),
 				   ref_tree, 1);
 	brelse(ref_root_bh);
 
 	if (ocfs2_dealloc_has_cluster(&dealloc)) {
-		ocfs2_schedule_truncate_log_flush(OCFS2_SB(old_inode->i_sb), 1);
-		ocfs2_run_deallocs(OCFS2_SB(old_inode->i_sb), &dealloc);
+		ocfs2_schedule_truncate_log_flush(OCFS2_SB(inode_sb(old_inode)),
+						  1);
+		ocfs2_run_deallocs(OCFS2_SB(inode_sb(old_inode)), &dealloc);
 	}
 
 out:
@@ -7290,7 +7297,7 @@ int ocfs2_init_security_get(struct inode *inode,
 			    struct ocfs2_security_xattr_info *si)
 {
 	/* check whether ocfs2 support feature xattr */
-	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
+	if (!ocfs2_supports_xattr(OCFS2_SB(inode_sb(dir))))
 		return -EOPNOTSUPP;
 	if (si)
 		return security_old_inode_init_security(inode, dir, qstr,
@@ -7353,7 +7360,7 @@ static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
 				struct dentry *unused, struct inode *inode,
 				const char *name, void *buffer, size_t size)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (osb->s_mount_opt & OCFS2_MOUNT_NOUSERXATTR)
 		return -EOPNOTSUPP;
@@ -7366,7 +7373,7 @@ static int ocfs2_xattr_user_set(const struct xattr_handler *handler,
 				const char *name, const void *value,
 				size_t size, int flags)
 {
-	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
+	struct ocfs2_super *osb = OCFS2_SB(inode_sb(inode));
 
 	if (osb->s_mount_opt & OCFS2_MOUNT_NOUSERXATTR)
 		return -EOPNOTSUPP;
-- 
2.15.1
