Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756259AbeEHSgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:36:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53941 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755315AbeEHSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:15 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 18/76] fs/btrfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:38 -0700
Message-Id: <20180508180436.716-19-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/btrfs/compression.c      |   4 +-
 fs/btrfs/ctree.h            |   2 +-
 fs/btrfs/delayed-inode.c    |   4 +-
 fs/btrfs/disk-io.c          |   8 +--
 fs/btrfs/export.c           |   4 +-
 fs/btrfs/extent-tree.c      |  14 ++---
 fs/btrfs/extent_io.c        |  24 ++++----
 fs/btrfs/file-item.c        |  10 ++--
 fs/btrfs/file.c             |  30 +++++-----
 fs/btrfs/free-space-cache.c |   6 +-
 fs/btrfs/inode.c            | 133 ++++++++++++++++++++++----------------------
 fs/btrfs/ioctl.c            |  72 ++++++++++++------------
 fs/btrfs/ordered-data.c     |  12 ++--
 fs/btrfs/relocation.c       |   6 +-
 fs/btrfs/tree-log.c         |   8 +--
 15 files changed, 169 insertions(+), 168 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 07d049c0c20f..63ac953b18c3 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -312,7 +312,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				 unsigned long nr_pages,
 				 unsigned int write_flags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct bio *bio = NULL;
 	struct compressed_bio *cb;
 	unsigned long bytes_left;
@@ -547,7 +547,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 				 int mirror_num, unsigned long bio_flags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_io_tree *tree;
 	struct extent_map_tree *em_tree;
 	struct compressed_bio *cb;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index da308774b8a4..a3cca35642e2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1271,7 +1271,7 @@ struct btrfs_file_private {
 
 static inline u32 btrfs_inode_sectorsize(const struct inode *inode)
 {
-	return btrfs_sb(inode->i_sb)->sectorsize;
+	return btrfs_sb(inode_sb(inode))->sectorsize;
 }
 
 static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 0530f6f2e4ba..adc07604156e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1214,7 +1214,7 @@ int btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 
 int btrfs_commit_inode_delayed_inode(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_delayed_node *delayed_node = btrfs_get_delayed_node(inode);
 	struct btrfs_path *path;
@@ -1829,7 +1829,7 @@ int btrfs_delayed_update_inode(struct btrfs_trans_handle *trans,
 
 int btrfs_delayed_delete_inode_ref(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_delayed_node *delayed_node;
 
 	/*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21f34ad0d411..334234da997c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -226,7 +226,7 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 		struct page *page, size_t pg_offset, u64 start, u64 len,
 		int create)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct extent_map *em;
 	int ret;
@@ -829,7 +829,7 @@ static blk_status_t __btree_submit_bio_done(void *private_data, struct bio *bio,
 	 * when we're called for a write, we're already in the async
 	 * submission context.  Just jump into btrfs_map_bio
 	 */
-	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), bio, mirror_num, 1);
+	ret = btrfs_map_bio(btrfs_sb(inode_sb(inode)), bio, mirror_num, 1);
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
@@ -853,7 +853,7 @@ static blk_status_t btree_submit_bio_hook(void *private_data, struct bio *bio,
 					  u64 bio_offset)
 {
 	struct inode *inode = private_data;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int async = check_async_write(BTRFS_I(inode));
 	blk_status_t ret;
 
@@ -4438,7 +4438,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 static struct btrfs_fs_info *btree_fs_info(void *private_data)
 {
 	struct inode *inode = private_data;
-	return btrfs_sb(inode->i_sb);
+	return btrfs_sb(inode_sb(inode));
 }
 
 static const struct extent_io_ops btree_extent_io_ops = {
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index ddaccad469f8..2ea5b2368999 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -154,7 +154,7 @@ static struct dentry *btrfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 static struct dentry *btrfs_get_parent(struct dentry *child)
 {
 	struct inode *dir = d_inode(child);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
@@ -224,7 +224,7 @@ static int btrfs_get_name(struct dentry *parent, char *name,
 {
 	struct inode *inode = d_inode(child);
 	struct inode *dir = d_inode(parent);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_path *path;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_inode_ref *iref;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c1618ab9fecf..1d86511aec42 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4382,7 +4382,7 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 int btrfs_check_data_free_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int ret;
 
 	/* align the range */
@@ -4414,7 +4414,7 @@ int btrfs_check_data_free_space(struct inode *inode,
 void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 					    u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_space_info *data_sinfo;
 
 	/* Make sure the range is aligned to sectorsize */
@@ -5934,7 +5934,7 @@ void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
 int btrfs_orphan_reserve_metadata(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	/*
 	 * We always use trans->block_rsv here as we will have reserved space
@@ -5959,7 +5959,7 @@ int btrfs_orphan_reserve_metadata(struct btrfs_trans_handle *trans,
 
 void btrfs_orphan_release_metadata(struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, 1);
 
@@ -6051,7 +6051,7 @@ static void btrfs_calculate_inode_block_rsv_size(struct btrfs_fs_info *fs_info,
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	unsigned nr_extents;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_ALL;
@@ -6133,7 +6133,7 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes)
  */
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 
 	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
 	spin_lock(&inode->lock);
@@ -6160,7 +6160,7 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes)
  */
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	unsigned num_extents;
 
 	spin_lock(&inode->lock);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfeb74a0be77..8db8041cf041 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2174,7 +2174,7 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 		struct io_failure_record **failrec_ret)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct io_failure_record *failrec;
 	struct extent_map *em;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
@@ -2261,7 +2261,7 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
 			   struct io_failure_record *failrec, int failed_mirror)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int num_copies;
 
 	num_copies = btrfs_num_copies(fs_info, failrec->logical, failrec->len);
@@ -2327,7 +2327,7 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct page *page, int pg_offset, int icsum,
 				    bio_end_io_t *endio_func, void *data)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct bio *bio;
 	struct btrfs_io_bio *btrfs_failed_bio;
 	struct btrfs_io_bio *btrfs_bio;
@@ -2392,16 +2392,16 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	if (failed_bio_pages > 1)
 		read_mode |= REQ_FAILFAST_DEV;
 
-	phy_offset >>= inode->i_sb->s_blocksize_bits;
+	phy_offset >>= inode_sb(inode)->s_blocksize_bits;
 	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
 				      start - page_offset(page),
 				      (int)phy_offset, failed_bio->bi_end_io,
 				      NULL);
 	bio_set_op_attrs(bio, REQ_OP_READ, read_mode);
 
-	btrfs_debug(btrfs_sb(inode->i_sb),
-		"Repair Read Error: submitting new read[%#x] to this_mirror=%d, in_validation=%d",
-		read_mode, failrec->this_mirror, failrec->in_validation);
+	btrfs_debug(btrfs_sb(inode_sb(inode)),
+		    "Repair Read Error: submitting new read[%#x] to this_mirror=%d, in_validation=%d",
+		    read_mode, failrec->this_mirror, failrec->in_validation);
 
 	status = tree->ops->submit_bio_hook(tree->private_data, bio, failrec->this_mirror,
 					 failrec->bio_flags, 0);
@@ -2457,7 +2457,7 @@ static void end_bio_extent_writepage(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 		/* We always issue full-page reads, but if some block
 		 * in a page fails to read, blk_update_request() will
@@ -2528,7 +2528,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
 		struct inode *inode = page->mapping->host;
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 		btrfs_debug(fs_info,
 			"end_bio_extent_readpage: bi_sector=%llu, err=%d, mirror=%u",
@@ -2900,7 +2900,7 @@ static int __do_readpage(struct extent_io_tree *tree,
 	size_t pg_offset = 0;
 	size_t iosize;
 	size_t disk_io_size;
-	size_t blocksize = inode->i_sb->s_blocksize;
+	size_t blocksize = inode_sb(inode)->s_blocksize;
 	unsigned long this_bio_flag = 0;
 
 	set_page_extent_mapped(page);
@@ -3358,7 +3358,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 		goto done;
 	}
 
-	blocksize = inode->i_sb->s_blocksize;
+	blocksize = inode_sb(inode)->s_blocksize;
 
 	while (cur <= end) {
 		u64 em_end;
@@ -4176,7 +4176,7 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 	struct extent_state *cached_state = NULL;
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	size_t blocksize = page->mapping->host->i_sb->s_blocksize;
+	size_t blocksize = inode_sb(page->mapping->host)->s_blocksize;
 
 	start += ALIGN(offset, blocksize);
 	if (start > end)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index fdcb41002623..75f025a2bf4d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -163,7 +163,7 @@ static void btrfs_io_bio_endio_readpage(struct btrfs_io_bio *bio, int err)
 static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 				   u64 logical_offset, u32 *dst, int dio)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	struct btrfs_io_bio *btrfs_bio = btrfs_io_bio(bio);
@@ -185,7 +185,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 	if (!path)
 		return BLK_STS_RESOURCE;
 
-	nblocks = bio->bi_iter.bi_size >> inode->i_sb->s_blocksize_bits;
+	nblocks = bio->bi_iter.bi_size >> inode_sb(inode)->s_blocksize_bits;
 	if (!dst) {
 		if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 			btrfs_bio->csum_allocated = kmalloc_array(nblocks,
@@ -280,7 +280,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 		diff = diff / fs_info->sectorsize;
 		diff = diff * csum_size;
 		count = min_t(int, nblocks, (item_last_offset - disk_bytenr) >>
-					    inode->i_sb->s_blocksize_bits);
+					    inode_sb(inode)->s_blocksize_bits);
 		read_extent_buffer(path->nodes[0], csum,
 				   ((unsigned long)item) + diff,
 				   csum_size * count);
@@ -435,7 +435,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 		       u64 file_start, int contig)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
 	char *data;
@@ -935,7 +935,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const bool new_inline,
 				     struct extent_map *em)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf = path->nodes[0];
 	const int slot = path->slots[0];
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 41ab9073d1d4..4a7348aed20e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -96,7 +96,7 @@ static int __compare_inode_defrag(struct inode_defrag *defrag1,
 static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 				    struct inode_defrag *defrag)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct inode_defrag *entry;
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
@@ -148,7 +148,7 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
 int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct inode_defrag *defrag;
 	u64 transid;
@@ -198,7 +198,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
 				       struct inode_defrag *defrag)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	int ret;
 
 	if (!__need_auto_defrag(fs_info))
@@ -531,7 +531,7 @@ int btrfs_dirty_pages(struct inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int err = 0;
 	int i;
 	u64 num_bytes;
@@ -1146,7 +1146,7 @@ static int extent_mergeable(struct extent_buffer *leaf, int slot,
 int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 			      struct btrfs_inode *inode, u64 start, u64 end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_path *path;
@@ -1483,7 +1483,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 				u64 *lockstart, u64 *lockend,
 				struct extent_state **cached_state)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	u64 start_pos;
 	u64 last_pos;
 	int i;
@@ -1539,7 +1539,7 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
 static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 				    size_t *write_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct btrfs_ordered_extent *ordered;
 	u64 lockstart, lockend;
@@ -1587,7 +1587,7 @@ static noinline ssize_t __btrfs_buffered_write(struct file *file,
 					       loff_t pos)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct page **pages = NULL;
 	struct extent_state *cached_state = NULL;
@@ -1875,7 +1875,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 start_pos;
 	u64 end_pos;
@@ -2051,7 +2051,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_log_ctx ctx;
@@ -2330,7 +2330,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		struct btrfs_inode *inode,
 		struct btrfs_path *path, u64 offset, u64 end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
@@ -2438,7 +2438,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
  */
 static int find_first_non_hole(struct inode *inode, u64 *start, u64 *len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_map *em;
 	int ret = 0;
 
@@ -2501,7 +2501,7 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 
 static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
@@ -3259,7 +3259,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 
 static int find_desired_extent(struct inode *inode, loff_t *offset, int whence)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_map *em = NULL;
 	struct extent_state *cached_state = NULL;
 	u64 lockstart;
@@ -3348,7 +3348,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 		}
 	}
 
-	offset = vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+	offset = vfs_setpos(file, offset, inode_sb(inode)->s_maxbytes);
 out:
 	inode_unlock(inode);
 	return offset;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index a9f22ac50d6a..a2fd0ea7caa0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -327,7 +327,7 @@ static int io_ctl_init(struct btrfs_io_ctl *io_ctl, struct inode *inode,
 		return -ENOMEM;
 
 	io_ctl->num_pages = num_pages;
-	io_ctl->fs_info = btrfs_sb(inode->i_sb);
+	io_ctl->fs_info = btrfs_sb(inode_sb(inode));
 	io_ctl->check_crcs = check_crcs;
 	io_ctl->inode = inode;
 
@@ -670,7 +670,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				   struct btrfs_free_space_ctl *ctl,
 				   struct btrfs_path *path, u64 offset)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_free_space_header *header;
 	struct extent_buffer *leaf;
 	struct btrfs_io_ctl io_ctl;
@@ -1143,7 +1143,7 @@ static int __btrfs_wait_cache_io(struct btrfs_root *root,
 	if (!inode)
 		return 0;
 
-	fs_info = btrfs_sb(inode->i_sb);
+	fs_info = btrfs_sb(inode_sb(inode));
 
 	/* Flush the dirty pages in the cache file. */
 	ret = flush_dirty_cache(inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f53470112670..1d4a28a4763a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -407,7 +407,7 @@ static noinline int add_async_extent(struct async_cow *cow,
 
 static inline int inode_need_compress(struct inode *inode, u64 start, u64 end)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
@@ -457,7 +457,7 @@ static noinline void compress_file_range(struct inode *inode,
 					struct async_cow *async_cow,
 					int *num_added)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 blocksize = fs_info->sectorsize;
 	u64 actual_end;
@@ -725,7 +725,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 static noinline void submit_compressed_extents(struct inode *inode,
 					      struct async_cow *async_cow)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct async_extent *async_extent;
 	u64 alloc_hint = 0;
 	struct btrfs_key ins;
@@ -956,7 +956,7 @@ static noinline int cow_file_range(struct inode *inode,
 				   int *page_started, unsigned long *nr_written,
 				   int unlock, struct btrfs_dedupe_hash *hash)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u64 alloc_hint = 0;
 	u64 num_bytes;
@@ -1201,7 +1201,7 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
 				unsigned long *nr_written,
 				unsigned int write_flags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct async_cow *async_cow;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	unsigned long nr_pages;
@@ -1277,7 +1277,7 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			      u64 start, u64 end, int *page_started, int force,
 			      unsigned long *nr_written)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_buffer *leaf;
 	struct btrfs_path *path;
@@ -1714,7 +1714,7 @@ static void btrfs_merge_extent_hook(void *private_data,
 static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
 				      struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 	spin_lock(&root->delalloc_lock);
 	if (list_empty(&BTRFS_I(inode)->delalloc_inodes)) {
@@ -1737,7 +1737,7 @@ static void btrfs_add_delalloc_inodes(struct btrfs_root *root,
 static void btrfs_del_delalloc_inode(struct btrfs_root *root,
 				     struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 
 	spin_lock(&root->delalloc_lock);
 	if (!list_empty(&inode->delalloc_inodes)) {
@@ -1765,7 +1765,7 @@ static void btrfs_set_bit_hook(void *private_data,
 {
 	struct inode *inode = private_data;
 
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 	if ((*bits & EXTENT_DEFRAG) && !(*bits & EXTENT_DELALLOC))
 		WARN_ON(1);
@@ -1817,7 +1817,7 @@ static void btrfs_clear_bit_hook(void *private_data,
 				 unsigned *bits)
 {
 	struct btrfs_inode *inode = BTRFS_I((struct inode *)private_data);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	u64 len = state->end + 1 - state->start;
 	u32 num_extents = count_max_extents(len);
 
@@ -1893,7 +1893,7 @@ int btrfs_merge_bio_hook(struct page *page, unsigned long offset,
 			 unsigned long bio_flags)
 {
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	u64 logical = (u64)bio->bi_iter.bi_sector << 9;
 	u64 length = 0;
 	u64 map_length;
@@ -1946,7 +1946,7 @@ static blk_status_t __btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  u64 bio_offset)
 {
 	struct inode *inode = private_data;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	blk_status_t ret;
 
 	ret = btrfs_map_bio(fs_info, bio, mirror_num, 1);
@@ -1980,7 +1980,7 @@ static blk_status_t btrfs_submit_bio_hook(void *private_data, struct bio *bio,
 				 u64 bio_offset)
 {
 	struct inode *inode = private_data;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
 	blk_status_t ret = 0;
@@ -2159,7 +2159,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 static int btrfs_writepage_start_hook(struct page *page, u64 start, u64 end)
 {
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_writepage_fixup *fixup;
 
 	/* this page is properly in the ordered list */
@@ -2374,7 +2374,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 	struct sa_defrag_extent_backref *backref;
 	struct extent_buffer *leaf;
 	struct inode *inode = new->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int slot;
 	int ret;
 	u64 extent_offset;
@@ -2485,7 +2485,7 @@ static noinline int record_one_backref(u64 inum, u64 offset, u64 root_id,
 static noinline bool record_extent_backrefs(struct btrfs_path *path,
 				   struct new_sa_defrag_extent *new)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(new->inode));
 	struct old_sa_defrag_extent *old, *tmp;
 	int ret;
 
@@ -2548,7 +2548,7 @@ static noinline int relink_extent_backref(struct btrfs_path *path,
 	struct extent_buffer *leaf;
 	struct old_sa_defrag_extent *old = backref->old;
 	struct new_sa_defrag_extent *new = old->new;
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(new->inode));
 	struct inode *inode;
 	struct extent_state *cached = NULL;
 	int ret = 0;
@@ -2749,7 +2749,7 @@ static void free_sa_defrag_extent(struct new_sa_defrag_extent *new)
 
 static void relink_file_extents(struct new_sa_defrag_extent *new)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(new->inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(new->inode));
 	struct btrfs_path *path;
 	struct sa_defrag_extent_backref *backref;
 	struct sa_defrag_extent_backref *prev = NULL;
@@ -2804,7 +2804,7 @@ static struct new_sa_defrag_extent *
 record_old_file_extents(struct inode *inode,
 			struct btrfs_ordered_extent *ordered)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -2936,7 +2936,7 @@ static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
 static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 {
 	struct inode *inode = ordered_extent->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans = NULL;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -3161,7 +3161,7 @@ static void btrfs_writepage_end_io_hook(struct page *page, u64 start, u64 end,
 				struct extent_state *state, int uptodate)
 {
 	struct inode *inode = page->mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_extent *ordered_extent = NULL;
 	struct btrfs_workqueue *wq;
 	btrfs_work_func_t func;
@@ -3242,14 +3242,14 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 		return 0;
 	}
 
-	phy_offset >>= inode->i_sb->s_blocksize_bits;
+	phy_offset >>= inode_sb(inode)->s_blocksize_bits;
 	return __readpage_endio_check(inode, io_bio, phy_offset, page, offset,
 				      start, (size_t)(end - start + 1));
 }
 
 void btrfs_add_delayed_iput(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_inode *binode = BTRFS_I(inode);
 
 	if (atomic_add_unless(&inode->i_count, -1, 1))
@@ -3346,7 +3346,7 @@ void btrfs_orphan_commit_root(struct btrfs_trans_handle *trans,
 int btrfs_orphan_add(struct btrfs_trans_handle *trans,
 		struct btrfs_inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 	struct btrfs_block_rsv *block_rsv = NULL;
 	int reserve = 0;
@@ -3758,7 +3758,7 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
  */
 static int btrfs_read_locked_inode(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
@@ -4774,7 +4774,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			int front)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
@@ -4886,7 +4886,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
 			     u64 offset, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_trans_handle *trans;
 	int ret;
 
@@ -4935,7 +4935,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct inode *inode,
  */
 int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map *em = NULL;
@@ -5288,7 +5288,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 void btrfs_evict_inode(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_block_rsv *rsv, *global_rsv;
@@ -5612,7 +5612,7 @@ static void inode_tree_add(struct inode *inode)
 
 static void inode_tree_del(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int empty = 0;
 
@@ -5792,7 +5792,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
@@ -5811,7 +5811,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		return ERR_PTR(-ENOENT);
 
 	if (location.type == BTRFS_INODE_ITEM_KEY) {
-		inode = btrfs_iget(dir->i_sb, &location, root, NULL);
+		inode = btrfs_iget(inode_sb(dir), &location, root, NULL);
 		return inode;
 	}
 
@@ -5822,15 +5822,16 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 		if (ret != -ENOENT)
 			inode = ERR_PTR(ret);
 		else
-			inode = new_simple_dir(dir->i_sb, &location, sub_root);
+			inode = new_simple_dir(inode_sb(dir), &location,
+					       sub_root);
 	} else {
-		inode = btrfs_iget(dir->i_sb, &location, sub_root, NULL);
+		inode = btrfs_iget(inode_sb(dir), &location, sub_root, NULL);
 	}
 	srcu_read_unlock(&fs_info->subvol_srcu, index);
 
 	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
-		if (!sb_rdonly(inode->i_sb))
+		if (!sb_rdonly(inode_sb(inode)))
 			ret = btrfs_orphan_cleanup(sub_root);
 		up_read(&fs_info->cleanup_work_sem);
 		if (ret) {
@@ -6106,7 +6107,7 @@ int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
  */
 static int btrfs_dirty_inode(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	int ret;
@@ -6464,7 +6465,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const char *name, int name_len, int add_backref, u64 index)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	int ret = 0;
 	struct btrfs_key key;
 	struct btrfs_root *root = parent_inode->root;
@@ -6545,7 +6546,7 @@ static int btrfs_add_nondir(struct btrfs_trans_handle *trans,
 static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 			umode_t mode, dev_t rdev)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
@@ -6617,7 +6618,7 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 static int btrfs_create(struct inode *dir, struct dentry *dentry,
 			umode_t mode, bool excl)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
@@ -6695,7 +6696,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = d_inode(old_dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	u64 index;
 	int err;
 	int drop_inode = 0;
@@ -6767,7 +6768,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 
 static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
@@ -6898,7 +6899,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	    size_t pg_offset, u64 start, u64 len,
 		int create)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	int ret;
 	int err = 0;
 	u64 extent_start = 0;
@@ -7279,7 +7280,7 @@ static struct extent_map *btrfs_create_dio_extent(struct inode *inode,
 static struct extent_map *btrfs_new_extent_direct(struct inode *inode,
 						  u64 start, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_map *em;
 	struct btrfs_key ins;
@@ -7311,7 +7312,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_path *path;
 	int ret;
 	struct extent_buffer *leaf;
@@ -7656,7 +7657,7 @@ static struct extent_map *create_io_em(struct inode *inode, u64 start, u64 len,
 static int btrfs_get_blocks_direct(struct inode *inode, sector_t iblock,
 				   struct buffer_head *bh_result, int create)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = NULL;
@@ -7850,7 +7851,7 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 						 struct bio *bio,
 						 int mirror_num)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	blk_status_t ret;
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
@@ -7869,7 +7870,7 @@ static int btrfs_check_dio_repairable(struct inode *inode,
 				      struct io_failure_record *failrec,
 				      int failed_mirror)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	int num_copies;
 
 	num_copies = btrfs_num_copies(fs_info, failrec->logical, failrec->len);
@@ -7936,7 +7937,7 @@ static blk_status_t dio_read_error(struct inode *inode, struct bio *failed_bio,
 		read_mode |= REQ_FAILFAST_DEV;
 
 	isector = start - btrfs_io_bio(failed_bio)->logical;
-	isector >>= inode->i_sb->s_blocksize_bits;
+	isector >>= inode_sb(inode)->s_blocksize_bits;
 	bio = btrfs_create_repair_bio(inode, failed_bio, failrec, page,
 				pgoff, isector, repair_endio, repair_arg);
 	bio_set_op_attrs(bio, REQ_OP_READ, read_mode);
@@ -8209,7 +8210,7 @@ static void __endio_write_update_ordered(struct inode *inode,
 					 const u64 offset, const u64 bytes,
 					 const bool uptodate)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_extent *ordered = NULL;
 	struct btrfs_workqueue *wq;
 	btrfs_work_func_t func;
@@ -8346,7 +8347,7 @@ static inline blk_status_t btrfs_lookup_and_bind_dio_csum(struct inode *inode,
 		return 0;
 
 	file_offset -= dip->logical_offset;
-	file_offset >>= inode->i_sb->s_blocksize_bits;
+	file_offset >>= inode_sb(inode)->s_blocksize_bits;
 	io_bio->csum = (u8 *)(((u32 *)orig_io_bio->csum) + file_offset);
 
 	return 0;
@@ -8356,7 +8357,7 @@ static inline blk_status_t
 __btrfs_submit_dio_bio(struct bio *bio, struct inode *inode, u64 file_offset,
 		       int async_submit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_dio_private *dip = bio->bi_private;
 	bool write = bio_op(bio) == REQ_OP_WRITE;
 	blk_status_t ret;
@@ -8403,7 +8404,7 @@ __btrfs_submit_dio_bio(struct bio *bio, struct inode *inode, u64 file_offset,
 static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip)
 {
 	struct inode *inode = dip->inode;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct bio *bio;
 	struct bio *orig_bio = dip->orig_bio;
 	u64 start_sector = orig_bio->bi_iter.bi_sector;
@@ -8639,7 +8640,7 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_mapping->host;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_dio_data dio_data = { 0 };
 	struct extent_changeset *data_reserved = NULL;
 	loff_t offset = iocb->ki_pos;
@@ -8963,7 +8964,7 @@ int btrfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
@@ -8980,7 +8981,7 @@ int btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	reserved_space = PAGE_SIZE;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 	page_start = page_offset(page);
 	page_end = page_start + PAGE_SIZE - 1;
 	end = page_end;
@@ -9096,7 +9097,7 @@ int btrfs_page_mkwrite(struct vm_fault *vmf)
 out_unlock:
 	if (!ret) {
 		btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-		sb_end_pagefault(inode->i_sb);
+		sb_end_pagefault(inode_sb(inode));
 		extent_changeset_free(data_reserved);
 		return VM_FAULT_LOCKED;
 	}
@@ -9106,14 +9107,14 @@ int btrfs_page_mkwrite(struct vm_fault *vmf)
 	btrfs_delalloc_release_space(inode, data_reserved, page_start,
 				     reserved_space);
 out_noreserve:
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	extent_changeset_free(data_reserved);
 	return ret;
 }
 
 static int btrfs_truncate(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_block_rsv *rsv;
 	int ret = 0;
@@ -9385,7 +9386,7 @@ static void btrfs_i_callback(struct rcu_head *head)
 
 void btrfs_destroy_inode(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 
@@ -9506,7 +9507,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 {
 	u64 delalloc_bytes;
 	struct inode *inode = d_inode(path->dentry);
-	u32 blocksize = inode->i_sb->s_blocksize;
+	u32 blocksize = inode_sb(inode)->s_blocksize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
 
 	stat->result_mask |= STATX_BTIME;
@@ -9542,7 +9543,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 			      struct inode *new_dir,
 			      struct dentry *new_dentry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(old_dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
@@ -9817,7 +9818,7 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(old_dir));
 	struct btrfs_trans_handle *trans;
 	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
@@ -10226,7 +10227,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int delay_iput,
 static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
 			 const char *symname)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_path *path;
@@ -10357,7 +10358,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 				       loff_t actual_len, u64 *alloc_hint,
 				       struct btrfs_trans_handle *trans)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -10523,7 +10524,7 @@ static int btrfs_permission(struct inode *inode, int mask)
 
 static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct inode *inode = NULL;
@@ -10601,7 +10602,7 @@ static int btrfs_readpage_io_failed_hook(struct page *page, int failed_mirror)
 static struct btrfs_fs_info *iotree_fs_info(void *private_data)
 {
 	struct inode *inode = private_data;
-	return btrfs_sb(inode->i_sb);
+	return btrfs_sb(inode_sb(inode));
 }
 
 static void btrfs_check_extent_io_range(void *private_data, const char *caller,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 111ee282b777..a8bc097b23a3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -198,7 +198,7 @@ static int check_flags(unsigned int flags)
 static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_inode *ip = BTRFS_I(inode);
 	struct btrfs_root *root = ip->root;
 	struct btrfs_trans_handle *trans;
@@ -358,7 +358,7 @@ static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
 static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_device *device;
 	struct request_queue *q;
 	struct fstrim_range range;
@@ -421,7 +421,7 @@ static noinline int create_subvol(struct inode *dir,
 				  u64 *async_transid,
 				  struct btrfs_qgroup_inherit *inherit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
 	struct btrfs_root_item *root_item;
@@ -626,7 +626,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 			   u64 *async_transid, bool readonly,
 			   struct btrfs_qgroup_inherit *inherit)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct inode *inode;
 	struct btrfs_pending_snapshot *pending_snapshot;
 	struct btrfs_trans_handle *trans;
@@ -806,7 +806,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 				   struct btrfs_qgroup_inherit *inherit)
 {
 	struct inode *dir = d_inode(parent->dentry);
-	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dir));
 	struct dentry *dentry;
 	int error;
 
@@ -1171,7 +1171,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 	if (!i_done || ret)
 		goto out;
 
-	if (!(inode->i_sb->s_flags & SB_ACTIVE))
+	if (!(inode_sb(inode)->s_flags & SB_ACTIVE))
 		goto out;
 
 	/*
@@ -1236,7 +1236,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct file_ra_state *ra = NULL;
 	unsigned long last_index;
@@ -1331,7 +1331,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		 * make sure we stop running if someone unmounts
 		 * the FS
 		 */
-		if (!(inode->i_sb->s_flags & SB_ACTIVE))
+		if (!(inode_sb(inode)->s_flags & SB_ACTIVE))
 			break;
 
 		if (btrfs_defrag_cancelled(fs_info)) {
@@ -1442,7 +1442,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 					void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	u64 new_size;
 	u64 old_size;
 	u64 devid = 1;
@@ -1621,7 +1621,7 @@ static noinline int btrfs_ioctl_snap_create_transid(struct file *file,
 		}
 
 		src_inode = file_inode(src.file);
-		if (src_inode->i_sb != file_inode(file)->i_sb) {
+		if (inode_sb(src_inode) != inode_sb(file_inode(file))) {
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
 			ret = -EXDEV;
@@ -1730,7 +1730,7 @@ static noinline int btrfs_ioctl_subvol_getflags(struct file *file,
 						void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret = 0;
 	u64 flags = 0;
@@ -1753,7 +1753,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 					      void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	u64 root_flags;
@@ -2050,7 +2050,7 @@ static noinline int search_ioctl(struct inode *inode,
 				 size_t *buf_size,
 				 char __user *ubuf)
 {
-	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root;
 	struct btrfs_key key;
 	struct btrfs_path *path;
@@ -2647,7 +2647,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	int ret;
 
@@ -2699,7 +2699,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ioctl_vol_args *vol_args;
 	int ret;
 
@@ -3354,7 +3354,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 				    const u64 size,
 				    char *inline_data)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(dst->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(dst));
 	struct btrfs_root *root = BTRFS_I(dst)->root;
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
 				      fs_info->sectorsize);
@@ -3478,7 +3478,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		       const u64 off, const u64 olen, const u64 olen_aligned,
 		       const u64 destoff, int no_time_update)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path = NULL;
 	struct extent_buffer *leaf;
@@ -3812,7 +3812,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 {
 	struct inode *inode = file_inode(file);
 	struct inode *src = file_inode(file_src);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret;
 	u64 len = olen;
@@ -3834,7 +3834,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 		return -EROFS;
 
 	if (file_src->f_path.mnt != file->f_path.mnt ||
-	    src->i_sb != inode->i_sb)
+	    inode_sb(src) != inode_sb(inode))
 		return -EXDEV;
 
 	/* don't make the dst file partly checksummed */
@@ -3945,7 +3945,7 @@ int btrfs_clone_file_range(struct file *src_file, loff_t off,
 static long btrfs_ioctl_trans_start(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_file_private *private;
@@ -4006,7 +4006,7 @@ static long btrfs_ioctl_trans_start(struct file *file)
 static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root *new_root;
 	struct btrfs_dir_item *di;
@@ -4313,7 +4313,7 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 
 static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(file_inode(file)->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(file_inode(file)));
 	struct btrfs_ioctl_scrub_args *sa;
 	int ret;
 
@@ -4816,7 +4816,7 @@ static long btrfs_ioctl_balance_progress(struct btrfs_fs_info *fs_info,
 static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ioctl_quota_ctl_args *sa;
 	struct btrfs_trans_handle *trans = NULL;
 	int ret;
@@ -4868,7 +4868,7 @@ static long btrfs_ioctl_quota_ctl(struct file *file, void __user *arg)
 static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_qgroup_assign_args *sa;
 	struct btrfs_trans_handle *trans;
@@ -4921,7 +4921,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
 static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_qgroup_create_args *sa;
 	struct btrfs_trans_handle *trans;
@@ -4972,7 +4972,7 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ioctl_qgroup_limit_args *sa;
 	struct btrfs_trans_handle *trans;
@@ -5021,7 +5021,7 @@ static long btrfs_ioctl_qgroup_limit(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ioctl_quota_rescan_args *qsa;
 	int ret;
 
@@ -5055,7 +5055,7 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ioctl_quota_rescan_args *qsa;
 	int ret = 0;
 
@@ -5081,7 +5081,7 @@ static long btrfs_ioctl_quota_rescan_status(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan_wait(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -5093,7 +5093,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_root_item *root_item = &root->root_item;
 	struct btrfs_trans_handle *trans;
@@ -5251,7 +5251,7 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 static int btrfs_ioctl_get_fslabel(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	size_t len;
 	int ret;
 	char label[BTRFS_LABEL_SIZE];
@@ -5276,7 +5276,7 @@ static int btrfs_ioctl_get_fslabel(struct file *file, void __user *arg)
 static int btrfs_ioctl_set_fslabel(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_trans_handle *trans;
@@ -5338,7 +5338,7 @@ int btrfs_ioctl_get_supported_features(void __user *arg)
 static int btrfs_ioctl_get_features(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_ioctl_feature_flags features;
 
@@ -5420,7 +5420,7 @@ check_feature_bits(fs_info, FEAT_##mask_base, change_mask, flags,	\
 static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_super_block *super_block = fs_info->super_copy;
 	struct btrfs_ioctl_feature_flags flags[2];
@@ -5527,7 +5527,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	void __user *argp = (void __user *)arg;
 
@@ -5598,7 +5598,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 		ret = btrfs_start_delalloc_roots(fs_info, 0, -1);
 		if (ret)
 			return ret;
-		ret = btrfs_sync_fs(inode->i_sb, 1);
+		ret = btrfs_sync_fs(inode_sb(inode), 1);
 		/*
 		 * The transaction thread may want to do more work,
 		 * namely it pokes the cleaner kthread that will start
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 5b311aeddcc8..cfe166246ac1 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -66,7 +66,7 @@ static struct rb_node *tree_insert(struct rb_root *root, u64 file_offset,
 static void ordered_data_tree_panic(struct inode *inode, int errno,
 					       u64 offset)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	btrfs_panic(fs_info, errno,
 		    "Inconsistency in ordered tree at offset %llu", offset);
 }
@@ -186,7 +186,7 @@ static int __btrfs_add_ordered_extent(struct inode *inode, u64 file_offset,
 				      u64 start, u64 len, u64 disk_len,
 				      int type, int dio, int compress_type)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
@@ -312,7 +312,7 @@ int btrfs_dec_test_first_ordered_pending(struct inode *inode,
 				   struct btrfs_ordered_extent **cached,
 				   u64 *file_offset, u64 io_size, int uptodate)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
@@ -598,7 +598,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 void btrfs_remove_ordered_extent(struct inode *inode,
 				 struct btrfs_ordered_extent *entry)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_inode_tree *tree;
 	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
 	struct btrfs_root *root = btrfs_inode->root;
@@ -1123,9 +1123,9 @@ int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 		if (disk_bytenr >= ordered_sum->bytenr &&
 		    disk_bytenr < ordered_sum->bytenr + ordered_sum->len) {
 			i = (disk_bytenr - ordered_sum->bytenr) >>
-			    inode->i_sb->s_blocksize_bits;
+			    inode_sb(inode)->s_blocksize_bits;
 			num_sectors = ordered_sum->len >>
-				      inode->i_sb->s_blocksize_bits;
+				      inode_sb(inode)->s_blocksize_bits;
 			num_sectors = min_t(int, len - index, num_sectors - i);
 			memcpy(sum + index, ordered_sum->sums + i,
 			       num_sectors);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cd2298d185dd..40e3ae49a746 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3145,7 +3145,7 @@ static noinline_for_stack
 int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 			 u64 block_start)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_map *em;
 	int ret = 0;
@@ -3179,7 +3179,7 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 static int relocate_file_extent_cluster(struct inode *inode,
 					struct file_extent_cluster *cluster)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	u64 page_start;
 	u64 page_end;
 	u64 offset = BTRFS_I(inode)->index_cnt;
@@ -4643,7 +4643,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
  */
 int btrfs_reloc_clone_csums(struct inode *inode, u64 file_pos, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(inode));
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered;
 	int ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 434457794c27..a07ca88b6cc6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3738,7 +3738,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 			       int start_slot, int nr, int inode_only,
 			       u64 logged_isize)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	unsigned long src_offset;
 	unsigned long dst_offset;
 	struct btrfs_root *log = inode->root->log_root;
@@ -5417,7 +5417,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 				 struct btrfs_inode *inode,
 				 struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	int ret;
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -5533,7 +5533,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 	bool log_dentries = false;
 	struct btrfs_inode *orig_inode = inode;
 
-	sb = inode->vfs_inode.i_sb;
+	sb = inode_sb(&inode->vfs_inode);
 
 	if (btrfs_test_opt(fs_info, NOTREELOG)) {
 		ret = 1;
@@ -5952,7 +5952,7 @@ int btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			struct btrfs_inode *inode, struct btrfs_inode *old_dir,
 			struct dentry *parent)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->vfs_inode.i_sb);
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode_sb(&inode->vfs_inode));
 	struct btrfs_root *root = inode->root;
 
 	/*
-- 
2.15.1
