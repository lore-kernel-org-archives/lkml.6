Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeEHSGb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:06:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932872AbeEHSGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:23 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 65/76] fs/reiserfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:25 -0700
Message-Id: <20180508180436.716-66-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/reiserfs/bitmap.c          |  12 +-
 fs/reiserfs/dir.c             |  27 ++--
 fs/reiserfs/file.c            |  22 +--
 fs/reiserfs/inode.c           | 321 +++++++++++++++++++++---------------------
 fs/reiserfs/ioctl.c           |  18 +--
 fs/reiserfs/journal.c         |  10 +-
 fs/reiserfs/namei.c           | 190 +++++++++++++------------
 fs/reiserfs/reiserfs.h        |   8 +-
 fs/reiserfs/stree.c           |  69 ++++-----
 fs/reiserfs/super.c           |  31 ++--
 fs/reiserfs/tail_conversion.c |   6 +-
 fs/reiserfs/xattr.c           |  36 ++---
 fs/reiserfs/xattr.h           |  13 +-
 fs/reiserfs/xattr_acl.c       |  14 +-
 fs/reiserfs/xattr_security.c  |   2 +-
 fs/reiserfs/xattr_user.c      |   4 +-
 16 files changed, 397 insertions(+), 386 deletions(-)

diff --git a/fs/reiserfs/bitmap.c b/fs/reiserfs/bitmap.c
index edc8ef78b63f..9d73c0df3bf3 100644
--- a/fs/reiserfs/bitmap.c
+++ b/fs/reiserfs/bitmap.c
@@ -325,13 +325,13 @@ static inline int block_group_used(struct super_block *s, u32 id)
 __le32 reiserfs_choose_packing(struct inode * dir)
 {
 	__le32 packing;
-	if (TEST_OPTION(packing_groups, dir->i_sb)) {
+	if (TEST_OPTION(packing_groups, inode_sb(dir))) {
 		u32 parent_dir = le32_to_cpu(INODE_PKEY(dir)->k_dir_id);
 		/*
 		 * some versions of reiserfsck expect packing locality 1 to be
 		 * special
 		 */
-		if (parent_dir == 1 || block_group_used(dir->i_sb, parent_dir))
+		if (parent_dir == 1 || block_group_used(inode_sb(dir), parent_dir))
 			packing = INODE_PKEY(dir)->k_objectid;
 		else
 			packing = INODE_PKEY(dir)->k_dir_id;
@@ -837,11 +837,11 @@ static void oid_groups(reiserfs_blocknr_hint_t * hint)
 		 * the start of the disk
 		 */
 		if (dirid <= 2)
-			hash = (hint->inode->i_sb->s_blocksize << 3);
+			hash = (inode_sb(hint->inode)->s_blocksize << 3);
 		else {
 			oid = le32_to_cpu(INODE_PKEY(hint->inode)->k_objectid);
-			bm = bmap_hash_id(hint->inode->i_sb, oid);
-			hash = bm * (hint->inode->i_sb->s_blocksize << 3);
+			bm = bmap_hash_id(inode_sb(hint->inode), oid);
+			hash = bm * (inode_sb(hint->inode)->s_blocksize << 3);
 		}
 		hint->search_start = hash;
 	}
@@ -1139,7 +1139,7 @@ static int determine_prealloc_size(reiserfs_blocknr_hint_t * hint)
 		if (S_ISREG(hint->inode->i_mode) && !IS_PRIVATE(hint->inode)
 		    && hint->inode->i_size >=
 		    REISERFS_SB(hint->th->t_super)->s_alloc_options.
-		    preallocmin * hint->inode->i_sb->s_blocksize)
+		    preallocmin * inode_sb(hint->inode)->s_blocksize)
 			hint->prealloc_size =
 			    REISERFS_SB(hint->th->t_super)->s_alloc_options.
 			    preallocsize - 1;
diff --git a/fs/reiserfs/dir.c b/fs/reiserfs/dir.c
index 5b50689d8539..d9aff9f826cc 100644
--- a/fs/reiserfs/dir.c
+++ b/fs/reiserfs/dir.c
@@ -39,9 +39,9 @@ static int reiserfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 		return err;
 
 	inode_lock(inode);
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	err = reiserfs_commit_for_inode(inode);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	inode_unlock(inode);
 	if (err < 0)
 		return err;
@@ -52,7 +52,7 @@ static int reiserfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 
 static inline bool is_privroot_deh(struct inode *dir, struct reiserfs_de_head *deh)
 {
-	struct dentry *privroot = REISERFS_SB(dir->i_sb)->priv_root;
+	struct dentry *privroot = REISERFS_SB(inode_sb(dir))->priv_root;
 	return (d_really_is_positive(privroot) &&
 	        deh->deh_objectid == INODE_PKEY(d_inode(privroot))->k_objectid);
 }
@@ -76,9 +76,9 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 	int ret = 0;
 	int depth;
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 
-	reiserfs_check_lock_depth(inode->i_sb, "readdir");
+	reiserfs_check_lock_depth(inode_sb(inode), "readdir");
 
 	/*
 	 * form key for search the next directory entry using
@@ -95,7 +95,8 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 		 * specified key
 		 */
 		search_res =
-		    search_by_entry_key(inode->i_sb, &pos_key, &path_to_entry,
+		    search_by_entry_key(inode_sb(inode), &pos_key,
+					&path_to_entry,
 					&de);
 		if (search_res == IO_ERROR) {
 			/*
@@ -165,7 +166,7 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 
 				/* too big to send back to VFS */
 				if (d_reclen >
-				    REISERFS_MAX_NAME(inode->i_sb->
+				    REISERFS_MAX_NAME(inode_sb(inode)->
 						      s_blocksize)) {
 					continue;
 				}
@@ -205,17 +206,19 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 				 * Since filldir might sleep, we can release
 				 * the write lock here for other waiters
 				 */
-				depth = reiserfs_write_unlock_nested(inode->i_sb);
+				depth = reiserfs_write_unlock_nested(inode_sb(inode));
 				if (!dir_emit
 				    (ctx, local_buf, d_reclen, d_ino,
 				     DT_UNKNOWN)) {
-					reiserfs_write_lock_nested(inode->i_sb, depth);
+					reiserfs_write_lock_nested(inode_sb(inode),
+								   depth);
 					if (local_buf != small_buf) {
 						kfree(local_buf);
 					}
 					goto end;
 				}
-				reiserfs_write_lock_nested(inode->i_sb, depth);
+				reiserfs_write_lock_nested(inode_sb(inode),
+							   depth);
 				if (local_buf != small_buf) {
 					kfree(local_buf);
 				}
@@ -239,7 +242,7 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 		 * item we went through is last item of node. Using right
 		 * delimiting key check is it directory end
 		 */
-		rkey = get_rkey(&path_to_entry, inode->i_sb);
+		rkey = get_rkey(&path_to_entry, inode_sb(inode));
 		if (!comp_le_keys(rkey, &MIN_KEY)) {
 			/*
 			 * set pos_key to key, that is the smallest and greater
@@ -265,7 +268,7 @@ int reiserfs_readdir_inode(struct inode *inode, struct dir_context *ctx)
 	pathrelse(&path_to_entry);
 	reiserfs_check_path(&path_to_entry);
 out:
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	return ret;
 }
 
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 843aadcc123c..8b41044bbd12 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -56,14 +56,14 @@ static int reiserfs_file_release(struct inode *inode, struct file *filp)
 		return 0;
 	}
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	/*
 	 * freeing preallocation only involves relogging blocks that
 	 * are already in the current transaction.  preallocation gets
 	 * freed at the end of each transaction, so it is impossible for
 	 * us to log any additional blocks (including quota blocks)
 	 */
-	err = journal_begin(&th, inode->i_sb, 1);
+	err = journal_begin(&th, inode_sb(inode), 1);
 	if (err) {
 		/*
 		 * uh oh, we can't allow the inode to go away while there
@@ -71,7 +71,7 @@ static int reiserfs_file_release(struct inode *inode, struct file *filp)
 		 * aborted transaction
 		 */
 		jbegin_failure = err;
-		err = journal_join_abort(&th, inode->i_sb);
+		err = journal_join_abort(&th, inode_sb(inode));
 
 		if (err) {
 			/*
@@ -84,7 +84,7 @@ static int reiserfs_file_release(struct inode *inode, struct file *filp)
 			 * and let the admin know what is going on.
 			 */
 			igrab(inode);
-			reiserfs_warning(inode->i_sb, "clm-9001",
+			reiserfs_warning(inode_sb(inode), "clm-9001",
 					 "pinning inode %lu because the "
 					 "preallocation can't be freed",
 					 inode->i_ino);
@@ -115,7 +115,7 @@ static int reiserfs_file_release(struct inode *inode, struct file *filp)
 		err = reiserfs_truncate_file(inode, 0);
 	}
 out:
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	mutex_unlock(&REISERFS_I(inode)->tailpack);
 	return err;
 }
@@ -161,11 +161,11 @@ static int reiserfs_sync_file(struct file *filp, loff_t start, loff_t end,
 	inode_lock(inode);
 	BUG_ON(!S_ISREG(inode->i_mode));
 	err = sync_mapping_buffers(inode->i_mapping);
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	barrier_done = reiserfs_commit_for_inode(inode);
-	reiserfs_write_unlock(inode->i_sb);
-	if (barrier_done != 1 && reiserfs_barrier_flush(inode->i_sb))
-		blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+	reiserfs_write_unlock(inode_sb(inode));
+	if (barrier_done != 1 && reiserfs_barrier_flush(inode_sb(inode)))
+		blkdev_issue_flush(inode_sb(inode)->s_bdev, GFP_KERNEL, NULL);
 	inode_unlock(inode);
 	if (barrier_done < 0)
 		return barrier_done;
@@ -183,7 +183,7 @@ int reiserfs_commit_page(struct inode *inode, struct page *page,
 	unsigned long i_size_index = inode->i_size >> PAGE_SHIFT;
 	int new;
 	int logit = reiserfs_file_data_log(inode);
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	int bh_per_page = PAGE_SIZE / s->s_blocksize;
 	struct reiserfs_transaction_handle th;
 	int ret = 0;
@@ -219,7 +219,7 @@ int reiserfs_commit_page(struct inode *inode, struct page *page,
 				 * do data=ordered on any page past the end
 				 * of file and any buffer marked BH_New.
 				 */
-				if (reiserfs_data_ordered(inode->i_sb) &&
+				if (reiserfs_data_ordered(inode_sb(inode)) &&
 				    (new || page->index >= i_size_index)) {
 					reiserfs_add_ordered_list(inode, bh);
 				}
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index b13fc024d2ee..a3c814ddb774 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -32,7 +32,7 @@ void reiserfs_evict_inode(struct inode *inode)
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 2 +
-	    2 * REISERFS_QUOTA_INIT_BLOCKS(inode->i_sb);
+	    2 * REISERFS_QUOTA_INIT_BLOCKS(inode_sb(inode));
 	struct reiserfs_transaction_handle th;
 	int err;
 
@@ -52,9 +52,9 @@ void reiserfs_evict_inode(struct inode *inode)
 
 		reiserfs_delete_xattrs(inode);
 
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 
-		if (journal_begin(&th, inode->i_sb, jbegin_count))
+		if (journal_begin(&th, inode_sb(inode), jbegin_count))
 			goto out;
 		reiserfs_update_inode_transaction(inode);
 
@@ -68,9 +68,9 @@ void reiserfs_evict_inode(struct inode *inode)
 		 * go into the same transaction as stat data deletion
 		 */
 		if (!err) {
-			int depth = reiserfs_write_unlock_nested(inode->i_sb);
+			int depth = reiserfs_write_unlock_nested(inode_sb(inode));
 			dquot_free_inode(inode);
-			reiserfs_write_lock_nested(inode->i_sb, depth);
+			reiserfs_write_lock_nested(inode_sb(inode), depth);
 		}
 
 		if (journal_end(&th))
@@ -90,7 +90,7 @@ void reiserfs_evict_inode(struct inode *inode)
 		 */
 		remove_save_link(inode, 0 /* not truncate */);
 out:
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 	} else {
 		/* no object items are in the tree */
 		;
@@ -231,7 +231,7 @@ static inline int indirect_item_found(int retval, struct item_head *ih)
 static inline void set_block_dev_mapped(struct buffer_head *bh,
 					b_blocknr_t block, struct inode *inode)
 {
-	map_bh(bh, inode->i_sb, block);
+	map_bh(bh, inode_sb(inode), block);
 }
 
 /*
@@ -243,7 +243,7 @@ static int file_capable(struct inode *inode, sector_t block)
 	/* it is new file. */
 	if (get_inode_item_key_version(inode) != KEY_FORMAT_3_5 ||
 	    /* old file, but 'block' is inside of 2gb */
-	    block < (1 << (31 - inode->i_sb->s_blocksize_bits)))
+	    block < (1 << (31 - inode_sb(inode)->s_blocksize_bits)))
 		return 1;
 
 	return 0;
@@ -299,10 +299,11 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 
 	/* prepare the key to look for the 'block'-th block of file */
 	make_cpu_key(&key, inode,
-		     (loff_t) block * inode->i_sb->s_blocksize + 1, TYPE_ANY,
+		     (loff_t) block * inode_sb(inode)->s_blocksize + 1,
+		     TYPE_ANY,
 		     3);
 
-	result = search_for_position_by_key(inode->i_sb, &key, &path);
+	result = search_for_position_by_key(inode_sb(inode), &key, &path);
 	if (result != POSITION_FOUND) {
 		pathrelse(&path);
 		if (p)
@@ -334,7 +335,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		blocknr = get_block_num(ind_item, path.pos_in_item);
 		ret = 0;
 		if (blocknr) {
-			map_bh(bh_result, inode->i_sb, blocknr);
+			map_bh(bh_result, inode_sb(inode), blocknr);
 			if (path.pos_in_item ==
 			    ((ih_item_len(ih) / UNFM_P_SIZE) - 1)) {
 				set_buffer_boundary(bh_result);
@@ -400,7 +401,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 		p = (char *)kmap(bh_result->b_page);
 
 	p += offset;
-	memset(p, 0, inode->i_sb->s_blocksize);
+	memset(p, 0, inode_sb(inode)->s_blocksize);
 	do {
 		if (!is_direct_le_ih(ih)) {
 			BUG();
@@ -439,7 +440,8 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 
 		/* update key to look for the next piece */
 		set_cpu_key_k_offset(&key, cpu_key_k_offset(&key) + chars);
-		result = search_for_position_by_key(inode->i_sb, &key, &path);
+		result = search_for_position_by_key(inode_sb(inode), &key,
+						    &path);
 		if (result != POSITION_FOUND)
 			/* i/o error most likely */
 			break;
@@ -460,7 +462,7 @@ static int _get_block_create_0(struct inode *inode, sector_t block,
 	 * this buffer has valid data, but isn't valid for io.  mapping it to
 	 * block #0 tells the rest of reiserfs it just has a tail in it
 	 */
-	map_bh(bh_result, inode->i_sb, 0);
+	map_bh(bh_result, inode_sb(inode), 0);
 	set_buffer_uptodate(bh_result);
 	return 0;
 }
@@ -475,10 +477,10 @@ static int reiserfs_bmap(struct inode *inode, sector_t block,
 	if (!file_capable(inode, block))
 		return -EFBIG;
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	/* do not read the direct item */
 	_get_block_create_0(inode, block, bh_result, 0);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	return 0;
 }
 
@@ -549,12 +551,12 @@ static int reiserfs_get_blocks_direct_io(struct inode *inode,
 	if (REISERFS_I(inode)->i_flags & i_pack_on_close_mask) {
 		int err;
 
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 
 		err = reiserfs_commit_for_inode(inode);
 		REISERFS_I(inode)->i_flags &= ~i_pack_on_close_mask;
 
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 
 		if (err < 0)
 			ret = err;
@@ -679,17 +681,17 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 + 1 +
-	    2 * REISERFS_QUOTA_TRANS_BLOCKS(inode->i_sb);
+	    2 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(inode));
 	int version;
 	int dangle = 1;
 	loff_t new_offset =
-	    (((loff_t) block) << inode->i_sb->s_blocksize_bits) + 1;
+	    (((loff_t) block) << inode_sb(inode)->s_blocksize_bits) + 1;
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	version = get_inode_item_key_version(inode);
 
 	if (!file_capable(inode, block)) {
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		return -EFBIG;
 	}
 
@@ -702,7 +704,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 		/* find number of block-th logical block of the file */
 		ret = _get_block_create_0(inode, block, bh_result,
 					  create | GET_BLOCK_READ_DIRECT);
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		return ret;
 	}
 
@@ -711,7 +713,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	 * any new transactions we start in this func
 	 */
 	if ((create & GET_BLOCK_NO_DANGLE) ||
-	    reiserfs_transaction_running(inode->i_sb))
+	    reiserfs_transaction_running(inode_sb(inode)))
 		dangle = 0;
 
 	/*
@@ -719,17 +721,18 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	 * tails are enabled  we should mark it as possibly needing
 	 * tail packing on close
 	 */
-	if ((have_large_tails(inode->i_sb)
+	if ((have_large_tails(inode_sb(inode))
 	     && inode->i_size < i_block_size(inode) * 4)
-	    || (have_small_tails(inode->i_sb)
+	    || (have_small_tails(inode_sb(inode))
 		&& inode->i_size < i_block_size(inode)))
 		REISERFS_I(inode)->i_flags |= i_pack_on_close_mask;
 
 	/* set the key of the first byte in the 'block'-th block of file */
 	make_cpu_key(&key, inode, new_offset, TYPE_ANY, 3 /*key length */ );
-	if ((new_offset + inode->i_sb->s_blocksize - 1) > inode->i_size) {
+	if ((new_offset + inode_sb(inode)->s_blocksize - 1) > inode->i_size) {
 start_trans:
-		th = reiserfs_persistent_transaction(inode->i_sb, jbegin_count);
+		th = reiserfs_persistent_transaction(inode_sb(inode),
+						     jbegin_count);
 		if (!th) {
 			retval = -ENOMEM;
 			goto failure;
@@ -738,7 +741,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	}
 research:
 
-	retval = search_for_position_by_key(inode->i_sb, &key, &path);
+	retval = search_for_position_by_key(inode_sb(inode), &key, &path);
 	if (retval == IO_ERROR) {
 		retval = -EIO;
 		goto failure;
@@ -749,7 +752,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 	item = tp_item_body(&path);
 	pos_in_item = path.pos_in_item;
 
-	fs_gen = get_generation(inode->i_sb);
+	fs_gen = get_generation(inode_sb(inode));
 	copy_item_head(&tmp_ih, ih);
 
 	if (allocation_needed
@@ -770,7 +773,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 		 * research if we succeed on the second try
 		 */
 		if (repeat == NO_DISK_SPACE || repeat == QUOTA_EXCEEDED) {
-			SB_JOURNAL(inode->i_sb)->j_next_async_flush = 1;
+			SB_JOURNAL(inode_sb(inode))->j_next_async_flush = 1;
 			retval = restart_transaction(th, inode, &path);
 			if (retval)
 				goto failure;
@@ -788,7 +791,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 			goto failure;
 		}
 
-		if (fs_changed(fs_gen, inode->i_sb)
+		if (fs_changed(fs_gen, inode_sb(inode))
 		    && item_moved(&tmp_ih, &path)) {
 			goto research;
 		}
@@ -804,16 +807,16 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 		unfm_ptr = get_block_num(item, pos_in_item);
 		if (unfm_ptr == 0) {
 			/* use allocated block to plug the hole */
-			reiserfs_prepare_for_journal(inode->i_sb, bh, 1);
-			if (fs_changed(fs_gen, inode->i_sb)
+			reiserfs_prepare_for_journal(inode_sb(inode), bh, 1);
+			if (fs_changed(fs_gen, inode_sb(inode))
 			    && item_moved(&tmp_ih, &path)) {
-				reiserfs_restore_prepared_buffer(inode->i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(inode),
 								 bh);
 				goto research;
 			}
 			set_buffer_new(bh_result);
 			if (buffer_dirty(bh_result)
-			    && reiserfs_data_ordered(inode->i_sb))
+			    && reiserfs_data_ordered(inode_sb(inode)))
 				reiserfs_add_ordered_list(inode, bh_result);
 			put_block_num(item, pos_in_item, allocated_block_nr);
 			unfm_ptr = allocated_block_nr;
@@ -826,7 +829,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 		if (!dangle && th)
 			retval = reiserfs_end_persistent_transaction(th);
 
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 
 		/*
 		 * the item was found, so new blocks were not added to the file
@@ -890,7 +893,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 
 			tail_offset =
 			    ((le_ih_k_offset(ih) -
-			      1) & ~(inode->i_sb->s_blocksize - 1)) + 1;
+			      1) & ~(inode_sb(inode)->s_blocksize - 1)) + 1;
 
 			/*
 			 * direct item we just found fits into block we have
@@ -930,19 +933,20 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 							  tail_offset);
 				if (retval) {
 					if (retval != -ENOSPC)
-						reiserfs_error(inode->i_sb,
-							"clm-6004",
-							"convert tail failed "
-							"inode %lu, error %d",
-							inode->i_ino,
-							retval);
+						reiserfs_error(inode_sb(inode),
+							       "clm-6004",
+							       "convert tail failed "
+							       "inode %lu, error %d",
+							       inode->i_ino,
+							       retval);
 					if (allocated_block_nr) {
 						/*
 						 * the bitmap, the super,
 						 * and the stat data == 3
 						 */
 						if (!th)
-							th = reiserfs_persistent_transaction(inode->i_sb, 3);
+							th = reiserfs_persistent_transaction(inode_sb(inode),
+											     3);
 						if (th)
 							reiserfs_free_block(th,
 									    inode,
@@ -1015,7 +1019,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 			unp_t unf_single = 0;
 			unp_t *un;
 			__u64 max_to_insert =
-			    MAX_ITEM_LEN(inode->i_sb->s_blocksize) /
+			    MAX_ITEM_LEN(inode_sb(inode)->s_blocksize) /
 			    UNFM_P_SIZE;
 			__u64 blocks_needed;
 
@@ -1030,7 +1034,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 				     le_key_k_offset(version,
 						     &ih->ih_key) +
 				     op_bytes_number(ih,
-						     inode->i_sb->s_blocksize),
+						     inode_sb(inode)->s_blocksize),
 				     TYPE_INDIRECT, 3);
 
 			RFALSE(cpu_key_k_offset(&tmp_key) > cpu_key_k_offset(&key),
@@ -1038,7 +1042,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 			blocks_needed =
 			    1 +
 			    ((cpu_key_k_offset(&key) -
-			      cpu_key_k_offset(&tmp_key)) >> inode->i_sb->
+			      cpu_key_k_offset(&tmp_key)) >> inode_sb(inode)->
 			     s_blocksize_bits);
 
 			if (blocks_needed == 1) {
@@ -1094,7 +1098,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 				 * holes.
 				 */
 				inode->i_size +=
-				    inode->i_sb->s_blocksize * blocks_needed;
+				    inode_sb(inode)->s_blocksize * blocks_needed;
 			}
 		}
 
@@ -1119,15 +1123,16 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 		 * long time.  reschedule if needed and also release the write
 		 * lock for others.
 		 */
-		reiserfs_cond_resched(inode->i_sb);
+		reiserfs_cond_resched(inode_sb(inode));
 
-		retval = search_for_position_by_key(inode->i_sb, &key, &path);
+		retval = search_for_position_by_key(inode_sb(inode), &key,
+						    &path);
 		if (retval == IO_ERROR) {
 			retval = -EIO;
 			goto failure;
 		}
 		if (retval == POSITION_FOUND) {
-			reiserfs_warning(inode->i_sb, "vs-825",
+			reiserfs_warning(inode_sb(inode), "vs-825",
 					 "%K should not be found", &key);
 			retval = -EEXIST;
 			if (allocated_block_nr)
@@ -1154,7 +1159,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
 			retval = err;
 	}
 
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	reiserfs_check_path(&path);
 	return retval;
 }
@@ -1174,7 +1179,7 @@ reiserfs_readpages(struct file *file, struct address_space *mapping,
 static int real_space_diff(struct inode *inode, int sd_size)
 {
 	int bytes;
-	loff_t blocksize = inode->i_sb->s_blocksize;
+	loff_t blocksize = inode_sb(inode)->s_blocksize;
 
 	if (S_ISLNK(inode->i_mode) || S_ISDIR(inode->i_mode))
 		return sd_size;
@@ -1190,7 +1195,7 @@ static int real_space_diff(struct inode *inode, int sd_size)
 	 */
 	bytes =
 	    ((inode->i_size +
-	      (blocksize - 1)) >> inode->i_sb->s_blocksize_bits) * UNFM_P_SIZE +
+	      (blocksize - 1)) >> inode_sb(inode)->s_blocksize_bits) * UNFM_P_SIZE +
 	    sd_size;
 	return bytes;
 }
@@ -1276,7 +1281,7 @@ static void init_inode(struct inode *inode, struct treepath *path)
 		inode->i_blocks = sd_v1_blocks(sd);
 		inode->i_generation = le32_to_cpu(INODE_PKEY(inode)->k_dir_id);
 		blocks = (inode->i_size + 511) >> 9;
-		blocks = _ROUND_UP(blocks, inode->i_sb->s_blocksize >> 9);
+		blocks = _ROUND_UP(blocks, inode_sb(inode)->s_blocksize >> 9);
 
 		/*
 		 * there was a bug in <=3.5.23 when i_blocks could take
@@ -1430,7 +1435,8 @@ static void update_stat_data(struct treepath *path, struct inode *inode,
 	ih = tp_item_head(path);
 
 	if (!is_statdata_le_ih(ih))
-		reiserfs_panic(inode->i_sb, "vs-13065", "key %k, found item %h",
+		reiserfs_panic(inode_sb(inode), "vs-13065",
+			       "key %k, found item %h",
 			       INODE_PKEY(inode), ih);
 
 	/* path points to old stat data */
@@ -1461,9 +1467,9 @@ void reiserfs_update_sd_size(struct reiserfs_transaction_handle *th,
 	for (;;) {
 		int pos;
 		/* look for the object's stat data */
-		retval = search_item(inode->i_sb, &key, &path);
+		retval = search_item(inode_sb(inode), &key, &path);
 		if (retval == IO_ERROR) {
-			reiserfs_error(inode->i_sb, "vs-13050",
+			reiserfs_error(inode_sb(inode), "vs-13050",
 				       "i/o failure occurred trying to "
 				       "update %K stat data", &key);
 			return;
@@ -1472,10 +1478,10 @@ void reiserfs_update_sd_size(struct reiserfs_transaction_handle *th,
 			pos = PATH_LAST_POSITION(&path);
 			pathrelse(&path);
 			if (inode->i_nlink == 0) {
-				/*reiserfs_warning (inode->i_sb, "vs-13050: reiserfs_update_sd: i_nlink == 0, stat data not found"); */
+				/*reiserfs_warning (inode_sb(inode), "vs-13050: reiserfs_update_sd: i_nlink == 0, stat data not found"); */
 				return;
 			}
-			reiserfs_warning(inode->i_sb, "vs-13060",
+			reiserfs_warning(inode_sb(inode), "vs-13060",
 					 "stat data of object %k (nlink == %d) "
 					 "not found (pos %d)",
 					 INODE_PKEY(inode), inode->i_nlink,
@@ -1492,13 +1498,13 @@ void reiserfs_update_sd_size(struct reiserfs_transaction_handle *th,
 		bh = get_last_bh(&path);
 		ih = tp_item_head(&path);
 		copy_item_head(&tmp_ih, ih);
-		fs_gen = get_generation(inode->i_sb);
-		reiserfs_prepare_for_journal(inode->i_sb, bh, 1);
+		fs_gen = get_generation(inode_sb(inode));
+		reiserfs_prepare_for_journal(inode_sb(inode), bh, 1);
 
 		/* Stat_data item has been moved after scheduling. */
-		if (fs_changed(fs_gen, inode->i_sb)
+		if (fs_changed(fs_gen, inode_sb(inode))
 		    && item_moved(&tmp_ih, &path)) {
-			reiserfs_restore_prepared_buffer(inode->i_sb, bh);
+			reiserfs_restore_prepared_buffer(inode_sb(inode), bh);
 			continue;
 		}
 		break;
@@ -1559,9 +1565,9 @@ void reiserfs_read_locked_inode(struct inode *inode,
 	key.on_disk_key.k_type = 0;
 
 	/* look for the object's stat data */
-	retval = search_item(inode->i_sb, &key, &path_to_sd);
+	retval = search_item(inode_sb(inode), &key, &path_to_sd);
 	if (retval == IO_ERROR) {
-		reiserfs_error(inode->i_sb, "vs-13070",
+		reiserfs_error(inode_sb(inode), "vs-13070",
 			       "i/o failure occurred trying to find "
 			       "stat data of %K", &key);
 		reiserfs_make_bad_inode(inode);
@@ -1598,8 +1604,8 @@ void reiserfs_read_locked_inode(struct inode *inode,
 	 * during mount (fs/reiserfs/super.c:finish_unfinished()).
 	 */
 	if ((inode->i_nlink == 0) &&
-	    !REISERFS_SB(inode->i_sb)->s_is_unlinked_ok) {
-		reiserfs_warning(inode->i_sb, "vs-13075",
+	    !REISERFS_SB(inode_sb(inode))->s_is_unlinked_ok) {
+		reiserfs_warning(inode_sb(inode), "vs-13075",
 				 "dead inode read from disk %K. "
 				 "This is likely to be race with knfsd. Ignore",
 				 &key);
@@ -1776,7 +1782,7 @@ int reiserfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct reiserfs_transaction_handle th;
 	int jbegin_count = 1;
 
-	if (sb_rdonly(inode->i_sb))
+	if (sb_rdonly(inode_sb(inode)))
 		return -EROFS;
 	/*
 	 * memory pressure can sometimes initiate write_inode calls with
@@ -1786,12 +1792,12 @@ int reiserfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * ignored because the altered inode has already been logged.
 	 */
 	if (wbc->sync_mode == WB_SYNC_ALL && !(current->flags & PF_MEMALLOC)) {
-		reiserfs_write_lock(inode->i_sb);
-		if (!journal_begin(&th, inode->i_sb, jbegin_count)) {
+		reiserfs_write_lock(inode_sb(inode));
+		if (!journal_begin(&th, inode_sb(inode), jbegin_count)) {
 			reiserfs_update_sd(&th, inode);
 			journal_end_sync(&th);
 		}
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 	}
 	return 0;
 }
@@ -1930,7 +1936,7 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 		       struct inode *inode,
 		       struct reiserfs_security_handle *security)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct reiserfs_iget_args args;
 	INITIALIZE_PATH(path_to_key);
 	struct cpu_key key;
@@ -1969,10 +1975,10 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	memcpy(INODE_PKEY(inode), &ih.ih_key, KEY_SIZE);
 	args.dirid = le32_to_cpu(ih.ih_key.k_dir_id);
 
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
 	err = insert_inode_locked4(inode, args.objectid,
 			     reiserfs_find_actor, &args);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 	if (err) {
 		err = -EINVAL;
 		goto out_bad_inode;
@@ -2096,27 +2102,27 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 		goto out_inserted_sd;
 	}
 
-	if (reiserfs_posixacl(inode->i_sb)) {
-		reiserfs_write_unlock(inode->i_sb);
+	if (reiserfs_posixacl(inode_sb(inode))) {
+		reiserfs_write_unlock(inode_sb(inode));
 		retval = reiserfs_inherit_default_acl(th, dir, dentry, inode);
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		if (retval) {
 			err = retval;
 			reiserfs_check_path(&path_to_key);
 			journal_end(th);
 			goto out_inserted_sd;
 		}
-	} else if (inode->i_sb->s_flags & SB_POSIXACL) {
-		reiserfs_warning(inode->i_sb, "jdm-13090",
+	} else if (inode_sb(inode)->s_flags & SB_POSIXACL) {
+		reiserfs_warning(inode_sb(inode), "jdm-13090",
 				 "ACLs aren't enabled in the fs, "
 				 "but vfs thinks they are!");
 	} else if (IS_PRIVATE(dir))
 		inode->i_flags |= S_PRIVATE;
 
 	if (security->name) {
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		retval = reiserfs_security_write(th, inode, security);
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		if (retval) {
 			err = retval;
 			reiserfs_check_path(&path_to_key);
@@ -2137,9 +2143,9 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	INODE_PKEY(inode)->k_objectid = 0;
 
 	/* Quota change must be inside a transaction for journaling */
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
 	dquot_free_inode(inode);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 
 out_end_trans:
 	journal_end(th);
@@ -2147,9 +2153,9 @@ int reiserfs_new_inode(struct reiserfs_transaction_handle *th,
 	 * Drop can be outside and it needs more credits so it's better
 	 * to have it outside
 	 */
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
 	dquot_drop(inode);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 	inode->i_flags |= S_NOQUOTA;
 	make_bad_inode(inode);
 
@@ -2186,7 +2192,7 @@ static int grab_tail_page(struct inode *inode,
 	unsigned long index = (inode->i_size - 1) >> PAGE_SHIFT;
 	unsigned long pos = 0;
 	unsigned long start = 0;
-	unsigned long blocksize = inode->i_sb->s_blocksize;
+	unsigned long blocksize = inode_sb(inode)->s_blocksize;
 	unsigned long offset = (inode->i_size) & (PAGE_SIZE - 1);
 	struct buffer_head *bh;
 	struct buffer_head *head;
@@ -2232,7 +2238,7 @@ static int grab_tail_page(struct inode *inode,
 		 * date, I've screwed up the code to find the buffer, or the
 		 * code to call prepare_write
 		 */
-		reiserfs_error(inode->i_sb, "clm-6000",
+		reiserfs_error(inode_sb(inode), "clm-6000",
 			       "error reading block %lu", bh->b_blocknr);
 		error = -EIO;
 		goto unlock;
@@ -2260,14 +2266,14 @@ int reiserfs_truncate_file(struct inode *inode, int update_timestamps)
 	struct reiserfs_transaction_handle th;
 	/* we want the offset for the first byte after the end of the file */
 	unsigned long offset = inode->i_size & (PAGE_SIZE - 1);
-	unsigned blocksize = inode->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(inode)->s_blocksize;
 	unsigned length;
 	struct page *page = NULL;
 	int error;
 	struct buffer_head *bh = NULL;
 	int err2;
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 
 	if (inode->i_size > 0) {
 		error = grab_tail_page(inode, &page, &bh);
@@ -2278,7 +2284,7 @@ int reiserfs_truncate_file(struct inode *inode, int update_timestamps)
 			 * block to read in, which is ok.
 			 */
 			if (error != -ENOENT)
-				reiserfs_error(inode->i_sb, "clm-6001",
+				reiserfs_error(inode_sb(inode), "clm-6001",
 					       "grab_tail_page failed %d",
 					       error);
 			page = NULL;
@@ -2298,7 +2304,7 @@ int reiserfs_truncate_file(struct inode *inode, int update_timestamps)
 	 * one for "save" link adding and another for the first
 	 * cut_from_item. 1 is for update_sd
 	 */
-	error = journal_begin(&th, inode->i_sb,
+	error = journal_begin(&th, inode_sb(inode),
 			      JOURNAL_PER_BALANCE_CNT * 2 + 1);
 	if (error)
 		goto out;
@@ -2342,7 +2348,7 @@ int reiserfs_truncate_file(struct inode *inode, int update_timestamps)
 		put_page(page);
 	}
 
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 
 	return 0;
 out:
@@ -2351,7 +2357,7 @@ int reiserfs_truncate_file(struct inode *inode, int update_timestamps)
 		put_page(page);
 	}
 
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 
 	return error;
 }
@@ -2370,7 +2376,7 @@ static int map_block_for_writepage(struct inode *inode,
 	INITIALIZE_PATH(path);
 	int pos_in_item;
 	int jbegin_count = JOURNAL_PER_BALANCE_CNT;
-	loff_t byte_offset = ((loff_t)block << inode->i_sb->s_blocksize_bits)+1;
+	loff_t byte_offset = ((loff_t)block << inode_sb(inode)->s_blocksize_bits)+1;
 	int retval;
 	int use_get_block = 0;
 	int bytes_copied = 0;
@@ -2389,11 +2395,11 @@ static int map_block_for_writepage(struct inode *inode,
 
 	kmap(bh_result->b_page);
 start_over:
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	make_cpu_key(&key, inode, byte_offset, TYPE_ANY, 3);
 
 research:
-	retval = search_for_position_by_key(inode->i_sb, &key, &path);
+	retval = search_for_position_by_key(inode_sb(inode), &key, &path);
 	if (retval != POSITION_FOUND) {
 		use_get_block = 1;
 		goto out;
@@ -2407,7 +2413,7 @@ static int map_block_for_writepage(struct inode *inode,
 	/* we've found an unformatted node */
 	if (indirect_item_found(retval, ih)) {
 		if (bytes_copied > 0) {
-			reiserfs_warning(inode->i_sb, "clm-6002",
+			reiserfs_warning(inode_sb(inode), "clm-6002",
 					 "bytes_copied %d", bytes_copied);
 		}
 		if (!get_block_num(item, pos_in_item)) {
@@ -2423,29 +2429,30 @@ static int map_block_for_writepage(struct inode *inode,
 		p += (byte_offset - 1) & (PAGE_SIZE - 1);
 		copy_size = ih_item_len(ih) - pos_in_item;
 
-		fs_gen = get_generation(inode->i_sb);
+		fs_gen = get_generation(inode_sb(inode));
 		copy_item_head(&tmp_ih, ih);
 
 		if (!trans_running) {
 			/* vs-3050 is gone, no need to drop the path */
-			retval = journal_begin(&th, inode->i_sb, jbegin_count);
+			retval = journal_begin(&th, inode_sb(inode),
+					       jbegin_count);
 			if (retval)
 				goto out;
 			reiserfs_update_inode_transaction(inode);
 			trans_running = 1;
-			if (fs_changed(fs_gen, inode->i_sb)
+			if (fs_changed(fs_gen, inode_sb(inode))
 			    && item_moved(&tmp_ih, &path)) {
-				reiserfs_restore_prepared_buffer(inode->i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(inode),
 								 bh);
 				goto research;
 			}
 		}
 
-		reiserfs_prepare_for_journal(inode->i_sb, bh, 1);
+		reiserfs_prepare_for_journal(inode_sb(inode), bh, 1);
 
-		if (fs_changed(fs_gen, inode->i_sb)
+		if (fs_changed(fs_gen, inode_sb(inode))
 		    && item_moved(&tmp_ih, &path)) {
-			reiserfs_restore_prepared_buffer(inode->i_sb, bh);
+			reiserfs_restore_prepared_buffer(inode_sb(inode), bh);
 			goto research;
 		}
 
@@ -2465,7 +2472,7 @@ static int map_block_for_writepage(struct inode *inode,
 			goto research;
 		}
 	} else {
-		reiserfs_warning(inode->i_sb, "clm-6003",
+		reiserfs_warning(inode_sb(inode), "clm-6003",
 				 "bad item inode %lu", inode->i_ino);
 		retval = -EIO;
 		goto out;
@@ -2480,7 +2487,7 @@ static int map_block_for_writepage(struct inode *inode,
 			retval = err;
 		trans_running = 0;
 	}
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 
 	/* this is where we fill in holes in the file. */
 	if (use_get_block) {
@@ -2528,7 +2535,7 @@ static int reiserfs_write_full_page(struct page *page,
 	int nr = 0;
 	int checked = PageChecked(page);
 	struct reiserfs_transaction_handle th;
-	struct super_block *s = inode->i_sb;
+	struct super_block *s = inode_sb(inode);
 	int bh_per_page = PAGE_SIZE / s->s_blocksize;
 	th.t_trans_id = 0;
 
@@ -2739,7 +2746,7 @@ static int reiserfs_readpage(struct file *f, struct page *page)
 static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
-	reiserfs_wait_on_write_block(inode->i_sb);
+	reiserfs_wait_on_write_block(inode_sb(inode));
 	return reiserfs_write_full_page(page, wbc);
 }
 
@@ -2763,7 +2770,7 @@ static int reiserfs_write_begin(struct file *file,
  	inode = mapping->host;
 	*fsdata = NULL;
  	if (flags & AOP_FLAG_CONT_EXPAND &&
- 	    (pos & (inode->i_sb->s_blocksize - 1)) == 0) {
+ 	    (pos & (inode_sb(inode)->s_blocksize - 1)) == 0) {
  		pos ++;
 		*fsdata = (void *)(unsigned long)flags;
 	}
@@ -2774,9 +2781,9 @@ static int reiserfs_write_begin(struct file *file,
 		return -ENOMEM;
 	*pagep = page;
 
-	reiserfs_wait_on_write_block(inode->i_sb);
+	reiserfs_wait_on_write_block(inode_sb(inode));
 	fix_tail_page_for_writing(page);
-	if (reiserfs_transaction_running(inode->i_sb)) {
+	if (reiserfs_transaction_running(inode_sb(inode))) {
 		struct reiserfs_transaction_handle *th;
 		th = (struct reiserfs_transaction_handle *)current->
 		    journal_info;
@@ -2786,7 +2793,7 @@ static int reiserfs_write_begin(struct file *file,
 		th->t_refcount++;
 	}
 	ret = __block_write_begin(page, pos, len, reiserfs_get_block);
-	if (ret && reiserfs_transaction_running(inode->i_sb)) {
+	if (ret && reiserfs_transaction_running(inode_sb(inode))) {
 		struct reiserfs_transaction_handle *th = current->journal_info;
 		/*
 		 * this gets a little ugly.  If reiserfs_get_block returned an
@@ -2806,9 +2813,9 @@ static int reiserfs_write_begin(struct file *file,
 				th->t_refcount--;
 			else {
 				int err;
-				reiserfs_write_lock(inode->i_sb);
+				reiserfs_write_lock(inode_sb(inode));
 				err = reiserfs_end_persistent_transaction(th);
-				reiserfs_write_unlock(inode->i_sb);
+				reiserfs_write_unlock(inode_sb(inode));
 				if (err)
 					ret = err;
 			}
@@ -2830,12 +2837,12 @@ int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len)
 	int old_ref = 0;
 	int depth;
 
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
-	reiserfs_wait_on_write_block(inode->i_sb);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
+	reiserfs_wait_on_write_block(inode_sb(inode));
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 
 	fix_tail_page_for_writing(page);
-	if (reiserfs_transaction_running(inode->i_sb)) {
+	if (reiserfs_transaction_running(inode_sb(inode))) {
 		struct reiserfs_transaction_handle *th;
 		th = (struct reiserfs_transaction_handle *)current->
 		    journal_info;
@@ -2846,7 +2853,7 @@ int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len)
 	}
 
 	ret = __block_write_begin(page, from, len, reiserfs_get_block);
-	if (ret && reiserfs_transaction_running(inode->i_sb)) {
+	if (ret && reiserfs_transaction_running(inode_sb(inode))) {
 		struct reiserfs_transaction_handle *th = current->journal_info;
 		/*
 		 * this gets a little ugly.  If reiserfs_get_block returned an
@@ -2866,9 +2873,9 @@ int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len)
 				th->t_refcount--;
 			else {
 				int err;
-				reiserfs_write_lock(inode->i_sb);
+				reiserfs_write_lock(inode_sb(inode));
 				err = reiserfs_end_persistent_transaction(th);
-				reiserfs_write_unlock(inode->i_sb);
+				reiserfs_write_unlock(inode_sb(inode));
 				if (err)
 					ret = err;
 			}
@@ -2897,8 +2904,8 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	if ((unsigned long)fsdata & AOP_FLAG_CONT_EXPAND)
 		pos ++;
 
-	reiserfs_wait_on_write_block(inode->i_sb);
-	if (reiserfs_transaction_running(inode->i_sb))
+	reiserfs_wait_on_write_block(inode_sb(inode));
+	if (reiserfs_transaction_running(inode_sb(inode)))
 		th = current->journal_info;
 	else
 		th = NULL;
@@ -2921,20 +2928,20 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	 */
 	if (pos + copied > inode->i_size) {
 		struct reiserfs_transaction_handle myth;
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		locked = true;
 		/*
 		 * If the file have grown beyond the border where it
 		 * can have a tail, unmark it as needing a tail
 		 * packing
 		 */
-		if ((have_large_tails(inode->i_sb)
+		if ((have_large_tails(inode_sb(inode))
 		     && inode->i_size > i_block_size(inode) * 4)
-		    || (have_small_tails(inode->i_sb)
+		    || (have_small_tails(inode_sb(inode))
 			&& inode->i_size > i_block_size(inode)))
 			REISERFS_I(inode)->i_flags &= ~i_pack_on_close_mask;
 
-		ret = journal_begin(&myth, inode->i_sb, 1);
+		ret = journal_begin(&myth, inode_sb(inode), 1);
 		if (ret)
 			goto journal_error;
 
@@ -2954,7 +2961,7 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	}
 	if (th) {
 		if (!locked) {
-			reiserfs_write_lock(inode->i_sb);
+			reiserfs_write_lock(inode_sb(inode));
 			locked = true;
 		}
 		if (!update_sd)
@@ -2966,7 +2973,7 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 
 out:
 	if (locked)
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 	unlock_page(page);
 	put_page(page);
 
@@ -2976,7 +2983,7 @@ static int reiserfs_write_end(struct file *file, struct address_space *mapping,
 	return ret == 0 ? copied : ret;
 
 journal_error:
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	locked = false;
 	if (th) {
 		if (!update_sd)
@@ -2996,11 +3003,11 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 	struct reiserfs_transaction_handle *th = NULL;
 	int depth;
 
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
-	reiserfs_wait_on_write_block(inode->i_sb);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
+	reiserfs_wait_on_write_block(inode_sb(inode));
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 
-	if (reiserfs_transaction_running(inode->i_sb)) {
+	if (reiserfs_transaction_running(inode_sb(inode))) {
 		th = current->journal_info;
 	}
 	reiserfs_commit_page(inode, page, from, to);
@@ -3017,13 +3024,13 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 		 * can have a tail, unmark it as needing a tail
 		 * packing
 		 */
-		if ((have_large_tails(inode->i_sb)
+		if ((have_large_tails(inode_sb(inode))
 		     && inode->i_size > i_block_size(inode) * 4)
-		    || (have_small_tails(inode->i_sb)
+		    || (have_small_tails(inode_sb(inode))
 			&& inode->i_size > i_block_size(inode)))
 			REISERFS_I(inode)->i_flags &= ~i_pack_on_close_mask;
 
-		ret = journal_begin(&myth, inode->i_sb, 1);
+		ret = journal_begin(&myth, inode_sb(inode), 1);
 		if (ret)
 			goto journal_error;
 
@@ -3064,7 +3071,7 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 
 void sd_attrs_to_i_attrs(__u16 sd_attrs, struct inode *inode)
 {
-	if (reiserfs_attrs(inode->i_sb)) {
+	if (reiserfs_attrs(inode_sb(inode))) {
 		if (sd_attrs & REISERFS_SYNC_FL)
 			inode->i_flags |= S_SYNC;
 		else
@@ -3095,7 +3102,7 @@ void sd_attrs_to_i_attrs(__u16 sd_attrs, struct inode *inode)
 static int invalidatepage_can_drop(struct inode *inode, struct buffer_head *bh)
 {
 	int ret = 1;
-	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
+	struct reiserfs_journal *j = SB_JOURNAL(inode_sb(inode));
 
 	lock_buffer(bh);
 	spin_lock(&j->j_dirty_buffers_lock);
@@ -3133,7 +3140,7 @@ static int invalidatepage_can_drop(struct inode *inode, struct buffer_head *bh)
 		 * transaction, we need to leave it around
 		 */
 		if (jh && (jl = jh->jl)
-		    && jl != SB_JOURNAL(inode->i_sb)->j_current_jl)
+		    && jl != SB_JOURNAL(inode_sb(inode))->j_current_jl)
 			ret = 0;
 	}
 free_jh:
@@ -3221,7 +3228,7 @@ static int reiserfs_set_page_dirty(struct page *page)
 static int reiserfs_releasepage(struct page *page, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = page->mapping->host;
-	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
+	struct reiserfs_journal *j = SB_JOURNAL(inode_sb(inode));
 	struct buffer_head *head;
 	struct buffer_head *bh;
 	int ret = 1;
@@ -3296,7 +3303,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 		if (error)
 			return error;
 	}
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	if (attr->ia_valid & ATTR_SIZE) {
 		/*
 		 * version 2 items will be caught by the s_maxbytes check
@@ -3304,7 +3311,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 		 */
 		if (get_inode_item_key_version(inode) == KEY_FORMAT_3_5 &&
 		    attr->ia_size > MAX_NON_LFS) {
-			reiserfs_write_unlock(inode->i_sb);
+			reiserfs_write_unlock(inode_sb(inode));
 			error = -EFBIG;
 			goto out;
 		}
@@ -3318,7 +3325,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 				int err;
 				struct reiserfs_transaction_handle th;
 				/* we're changing at most 2 bitmaps, inode + super */
-				err = journal_begin(&th, inode->i_sb, 4);
+				err = journal_begin(&th, inode_sb(inode), 4);
 				if (!err) {
 					reiserfs_discard_prealloc(&th, inode);
 					err = journal_end(&th);
@@ -3327,7 +3334,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 					error = err;
 			}
 			if (error) {
-				reiserfs_write_unlock(inode->i_sb);
+				reiserfs_write_unlock(inode_sb(inode));
 				goto out;
 			}
 			/*
@@ -3337,7 +3344,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 			attr->ia_valid |= (ATTR_MTIME | ATTR_CTIME);
 		}
 	}
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 
 	if ((((attr->ia_valid & ATTR_UID) && (from_kuid(&init_user_ns, attr->ia_uid) & ~0xffff)) ||
 	     ((attr->ia_valid & ATTR_GID) && (from_kgid(&init_user_ns, attr->ia_gid) & ~0xffff))) &&
@@ -3352,8 +3359,8 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 		struct reiserfs_transaction_handle th;
 		int jbegin_count =
 		    2 *
-		    (REISERFS_QUOTA_INIT_BLOCKS(inode->i_sb) +
-		     REISERFS_QUOTA_DEL_BLOCKS(inode->i_sb)) +
+		    (REISERFS_QUOTA_INIT_BLOCKS(inode_sb(inode)) +
+		     REISERFS_QUOTA_DEL_BLOCKS(inode_sb(inode))) +
 		    2;
 
 		error = reiserfs_chown_xattrs(inode, attr);
@@ -3365,16 +3372,16 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 		 * (user+group)*(old+new) structure - we count quota
 		 * info and , inode write (sb, inode)
 		 */
-		reiserfs_write_lock(inode->i_sb);
-		error = journal_begin(&th, inode->i_sb, jbegin_count);
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
+		error = journal_begin(&th, inode_sb(inode), jbegin_count);
+		reiserfs_write_unlock(inode_sb(inode));
 		if (error)
 			goto out;
 		error = dquot_transfer(inode, attr);
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		if (error) {
 			journal_end(&th);
-			reiserfs_write_unlock(inode->i_sb);
+			reiserfs_write_unlock(inode_sb(inode));
 			goto out;
 		}
 
@@ -3388,7 +3395,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 			inode->i_gid = attr->ia_gid;
 		mark_inode_dirty(inode);
 		error = journal_end(&th);
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		if (error)
 			goto out;
 	}
@@ -3413,7 +3420,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 		mark_inode_dirty(inode);
 	}
 
-	if (!error && reiserfs_posixacl(inode->i_sb)) {
+	if (!error && reiserfs_posixacl(inode_sb(inode))) {
 		if (attr->ia_valid & ATTR_MODE)
 			error = reiserfs_acl_chmod(inode);
 	}
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index acbbaf7a0bb2..122dfdfe69c9 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -26,7 +26,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int flags;
 	int err = 0;
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 
 	switch (cmd) {
 	case REISERFS_IOC_UNPACK:
@@ -41,7 +41,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * Card (card@masi.ibp.fr)
 		 */
 	case REISERFS_IOC_GETFLAGS:
-		if (!reiserfs_attrs(inode->i_sb)) {
+		if (!reiserfs_attrs(inode_sb(inode))) {
 			err = -ENOTTY;
 			break;
 		}
@@ -50,7 +50,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = put_user(flags, (int __user *)arg);
 		break;
 	case REISERFS_IOC_SETFLAGS:{
-			if (!reiserfs_attrs(inode->i_sb)) {
+			if (!reiserfs_attrs(inode_sb(inode))) {
 				err = -ENOTTY;
 				break;
 			}
@@ -123,7 +123,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = -ENOTTY;
 	}
 
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 
 	return err;
 }
@@ -174,7 +174,7 @@ int reiserfs_unpack(struct inode *inode, struct file *filp)
 	struct page *page;
 	struct address_space *mapping;
 	unsigned long write_from;
-	unsigned long blocksize = inode->i_sb->s_blocksize;
+	unsigned long blocksize = inode_sb(inode)->s_blocksize;
 
 	if (inode->i_size == 0) {
 		REISERFS_I(inode)->i_flags |= i_nopack_mask;
@@ -187,12 +187,12 @@ int reiserfs_unpack(struct inode *inode, struct file *filp)
 
 	/* we need to make sure nobody is changing the file size beneath us */
 {
-	int depth = reiserfs_write_unlock_nested(inode->i_sb);
+	int depth = reiserfs_write_unlock_nested(inode_sb(inode));
 	inode_lock(inode);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 }
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 
 	write_from = inode->i_size & (blocksize - 1);
 	/* if we are on a block boundary, we are already unpacked.  */
@@ -228,6 +228,6 @@ int reiserfs_unpack(struct inode *inode, struct file *filp)
 
 out:
 	inode_unlock(inode);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	return retval;
 }
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 70057359fbaf..aefcb77de3fd 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -782,11 +782,11 @@ static inline int __add_jh(struct reiserfs_journal *j, struct buffer_head *bh,
 
 int reiserfs_add_tail_list(struct inode *inode, struct buffer_head *bh)
 {
-	return __add_jh(SB_JOURNAL(inode->i_sb), bh, 1);
+	return __add_jh(SB_JOURNAL(inode_sb(inode)), bh, 1);
 }
 int reiserfs_add_ordered_list(struct inode *inode, struct buffer_head *bh)
 {
-	return __add_jh(SB_JOURNAL(inode->i_sb), bh, 0);
+	return __add_jh(SB_JOURNAL(inode_sb(inode)), bh, 0);
 }
 
 #define JH_ENTRY(l) list_entry((l), struct reiserfs_jh, list)
@@ -3825,7 +3825,7 @@ int journal_mark_freed(struct reiserfs_transaction_handle *th,
 
 void reiserfs_update_inode_transaction(struct inode *inode)
 {
-	struct reiserfs_journal *journal = SB_JOURNAL(inode->i_sb);
+	struct reiserfs_journal *journal = SB_JOURNAL(inode_sb(inode));
 	REISERFS_I(inode)->i_jl = journal->j_current_jl;
 	REISERFS_I(inode)->i_trans_id = journal->j_trans_id;
 }
@@ -3838,7 +3838,7 @@ static int __commit_trans_jl(struct inode *inode, unsigned long id,
 			     struct reiserfs_journal_list *jl)
 {
 	struct reiserfs_transaction_handle th;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct reiserfs_journal *journal = SB_JOURNAL(sb);
 	int ret = 0;
 
@@ -3881,7 +3881,7 @@ static int __commit_trans_jl(struct inode *inode, unsigned long id,
 		 * if we've got a larger transaction id than the oldest list
 		 */
 flush_commit_only:
-		if (journal_list_still_alive(inode->i_sb, id)) {
+		if (journal_list_still_alive(inode_sb(inode), id)) {
 			/*
 			 * we only set ret to 1 when we know for sure
 			 * the barrier hasn't been started yet on the commit
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index bd39a998843d..70c1da7d9ef1 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -308,20 +308,20 @@ static int reiserfs_find_entry(struct inode *dir, const char *name, int namelen,
 	struct cpu_key key_to_search;
 	int retval;
 
-	if (namelen > REISERFS_MAX_NAME(dir->i_sb->s_blocksize))
+	if (namelen > REISERFS_MAX_NAME(inode_sb(dir)->s_blocksize))
 		return NAME_NOT_FOUND;
 
 	/* we will search for this key in the tree */
 	make_cpu_key(&key_to_search, dir,
-		     get_third_component(dir->i_sb, name, namelen),
+		     get_third_component(inode_sb(dir), name, namelen),
 		     TYPE_DIRENTRY, 3);
 
 	while (1) {
 		retval =
-		    search_by_entry_key(dir->i_sb, &key_to_search,
+		    search_by_entry_key(inode_sb(dir), &key_to_search,
 					path_to_entry, de);
 		if (retval == IO_ERROR) {
-			reiserfs_error(dir->i_sb, "zam-7001", "io error");
+			reiserfs_error(inode_sb(dir), "zam-7001", "io error");
 			return IO_ERROR;
 		}
 
@@ -357,10 +357,10 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct reiserfs_dir_entry de;
 	INITIALIZE_PATH(path_to_entry);
 
-	if (REISERFS_MAX_NAME(dir->i_sb->s_blocksize) < dentry->d_name.len)
+	if (REISERFS_MAX_NAME(inode_sb(dir)->s_blocksize) < dentry->d_name.len)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 
 	de.de_gen_number_bit_string = NULL;
 	retval =
@@ -368,10 +368,10 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 				&path_to_entry, &de);
 	pathrelse(&path_to_entry);
 	if (retval == NAME_FOUND) {
-		inode = reiserfs_iget(dir->i_sb,
+		inode = reiserfs_iget(inode_sb(dir),
 				      (struct cpu_key *)&de.de_dir_id);
 		if (!inode || IS_ERR(inode)) {
-			reiserfs_write_unlock(dir->i_sb);
+			reiserfs_write_unlock(inode_sb(dir));
 			return ERR_PTR(-EACCES);
 		}
 
@@ -382,7 +382,7 @@ static struct dentry *reiserfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (IS_PRIVATE(dir))
 			inode->i_flags |= S_PRIVATE;
 	}
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	if (retval == IO_ERROR) {
 		return ERR_PTR(-EIO);
 	}
@@ -407,15 +407,15 @@ struct dentry *reiserfs_get_parent(struct dentry *child)
 	}
 	de.de_gen_number_bit_string = NULL;
 
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 	retval = reiserfs_find_entry(dir, "..", 2, &path_to_entry, &de);
 	pathrelse(&path_to_entry);
 	if (retval != NAME_FOUND) {
-		reiserfs_write_unlock(dir->i_sb);
+		reiserfs_write_unlock(inode_sb(dir));
 		return ERR_PTR(-ENOENT);
 	}
-	inode = reiserfs_iget(dir->i_sb, (struct cpu_key *)&de.de_dir_id);
-	reiserfs_write_unlock(dir->i_sb);
+	inode = reiserfs_iget(inode_sb(dir), (struct cpu_key *)&de.de_dir_id);
+	reiserfs_write_unlock(inode_sb(dir));
 
 	return d_obtain_alias(inode);
 }
@@ -453,12 +453,12 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 	if (!namelen)
 		return -EINVAL;
 
-	if (namelen > REISERFS_MAX_NAME(dir->i_sb->s_blocksize))
+	if (namelen > REISERFS_MAX_NAME(inode_sb(dir)->s_blocksize))
 		return -ENAMETOOLONG;
 
 	/* each entry has unique key. compose it */
 	make_cpu_key(&entry_key, dir,
-		     get_third_component(dir->i_sb, name, namelen),
+		     get_third_component(inode_sb(dir), name, namelen),
 		     TYPE_DIRENTRY, 3);
 
 	/* get memory for composing the entry */
@@ -515,7 +515,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 		}
 
 		if (retval != NAME_FOUND) {
-			reiserfs_error(dir->i_sb, "zam-7002",
+			reiserfs_error(inode_sb(dir), "zam-7002",
 				       "reiserfs_find_entry() returned "
 				       "unexpected value (%d)", retval);
 		}
@@ -528,7 +528,7 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 				MAX_GENERATION_NUMBER + 1);
 	if (gen_number > MAX_GENERATION_NUMBER) {
 		/* there is no free generation number */
-		reiserfs_warning(dir->i_sb, "reiserfs-7010",
+		reiserfs_warning(inode_sb(dir), "reiserfs-7010",
 				 "Congratulations! we have got hash function "
 				 "screwed up");
 		if (buffer != small_buf)
@@ -545,9 +545,9 @@ static int reiserfs_add_entry(struct reiserfs_transaction_handle *th,
 
 	/* we need to re-search for the insertion point */
 	if (gen_number != 0) {
-		if (search_by_entry_key(dir->i_sb, &entry_key, &path, &de) !=
+		if (search_by_entry_key(inode_sb(dir), &entry_key, &path, &de) !=
 		    NAME_NOT_FOUND) {
-			reiserfs_warning(dir->i_sb, "vs-7032",
+			reiserfs_warning(inode_sb(dir), "vs-7032",
 					 "entry with this key (%K) already "
 					 "exists", &entry_key);
 
@@ -627,8 +627,8 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mod
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 2 +
-	    2 * (REISERFS_QUOTA_INIT_BLOCKS(dir->i_sb) +
-		 REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb));
+	    2 * (REISERFS_QUOTA_INIT_BLOCKS(inode_sb(dir)) +
+		 REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir)));
 	struct reiserfs_transaction_handle th;
 	struct reiserfs_security_handle security;
 
@@ -636,7 +636,7 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mod
 	if (retval)
 		return retval;
 
-	if (!(inode = new_inode(dir->i_sb))) {
+	if (!(inode = new_inode(inode_sb(dir)))) {
 		return -ENOMEM;
 	}
 	retval = new_inode_init(inode, dir, mode);
@@ -652,9 +652,9 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mod
 		return retval;
 	}
 	jbegin_count += retval;
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval) {
 		drop_new_inode(inode);
 		goto out_failed;
@@ -692,7 +692,7 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mod
 	retval = journal_end(&th);
 
 out_failed:
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 }
 
@@ -709,14 +709,14 @@ static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 +
-	    2 * (REISERFS_QUOTA_INIT_BLOCKS(dir->i_sb) +
-		 REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb));
+	    2 * (REISERFS_QUOTA_INIT_BLOCKS(inode_sb(dir)) +
+		 REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir)));
 
 	retval = dquot_initialize(dir);
 	if (retval)
 		return retval;
 
-	if (!(inode = new_inode(dir->i_sb))) {
+	if (!(inode = new_inode(inode_sb(dir)))) {
 		return -ENOMEM;
 	}
 	retval = new_inode_init(inode, dir, mode);
@@ -732,9 +732,9 @@ static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode
 		return retval;
 	}
 	jbegin_count += retval;
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval) {
 		drop_new_inode(inode);
 		goto out_failed;
@@ -776,7 +776,7 @@ static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode
 	retval = journal_end(&th);
 
 out_failed:
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 }
 
@@ -792,8 +792,8 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 +
-	    2 * (REISERFS_QUOTA_INIT_BLOCKS(dir->i_sb) +
-		 REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb));
+	    2 * (REISERFS_QUOTA_INIT_BLOCKS(inode_sb(dir)) +
+		 REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir)));
 
 	retval = dquot_initialize(dir);
 	if (retval)
@@ -807,7 +807,7 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	REISERFS_I(dir)->new_packing_locality = 1;
 #endif
 	mode = S_IFDIR | mode;
-	if (!(inode = new_inode(dir->i_sb))) {
+	if (!(inode = new_inode(inode_sb(dir)))) {
 		return -ENOMEM;
 	}
 	retval = new_inode_init(inode, dir, mode);
@@ -823,9 +823,9 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 		return retval;
 	}
 	jbegin_count += retval;
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval) {
 		drop_new_inode(inode);
 		goto out_failed;
@@ -838,7 +838,7 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	INC_DIR_INODE_NLINK(dir)
 
 	    retval = reiserfs_new_inode(&th, dir, mode, NULL /*symlink */ ,
-					old_format_only(dir->i_sb) ?
+					old_format_only(inode_sb(dir)) ?
 					EMPTY_DIR_SIZE_V1 : EMPTY_DIR_SIZE,
 					dentry, inode, &security);
 	if (retval) {
@@ -875,7 +875,7 @@ static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	d_instantiate(dentry, inode);
 	retval = journal_end(&th);
 out_failed:
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 }
 
@@ -911,14 +911,14 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 */
 	jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 2 + 2 +
-	    4 * REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb);
+	    4 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir));
 
 	retval = dquot_initialize(dir);
 	if (retval)
 		return retval;
 
-	reiserfs_write_lock(dir->i_sb);
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	reiserfs_write_lock(inode_sb(dir));
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval)
 		goto out_rmdir;
 
@@ -958,7 +958,7 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 		goto end_rmdir;
 
 	if (inode->i_nlink != 2 && inode->i_nlink != 1)
-		reiserfs_error(inode->i_sb, "reiserfs-7040",
+		reiserfs_error(inode_sb(inode), "reiserfs-7040",
 			       "empty directory has nlink != 2 (%d)",
 			       inode->i_nlink);
 
@@ -976,7 +976,7 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 	retval = journal_end(&th);
 	reiserfs_check_path(&path);
 out_rmdir:
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 
 end_rmdir:
@@ -987,7 +987,7 @@ static int reiserfs_rmdir(struct inode *dir, struct dentry *dentry)
 	 */
 	pathrelse(&path);
 	err = journal_end(&th);
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return err ? err : retval;
 }
 
@@ -1016,10 +1016,10 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	 */
 	jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 2 + 2 +
-	    4 * REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb);
+	    4 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir));
 
-	reiserfs_write_lock(dir->i_sb);
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	reiserfs_write_lock(inode_sb(dir));
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval)
 		goto out_unlink;
 
@@ -1046,7 +1046,7 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (!inode->i_nlink) {
-		reiserfs_warning(inode->i_sb, "reiserfs-7042",
+		reiserfs_warning(inode_sb(inode), "reiserfs-7042",
 				 "deleting nonexistent file (%lu), %d",
 				 inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
@@ -1080,7 +1080,7 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 
 	retval = journal_end(&th);
 	reiserfs_check_path(&path);
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 
 end_unlink:
@@ -1090,7 +1090,7 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err)
 		retval = err;
 out_unlink:
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 }
 
@@ -1110,14 +1110,14 @@ static int reiserfs_symlink(struct inode *parent_dir,
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 +
-	    2 * (REISERFS_QUOTA_INIT_BLOCKS(parent_dir->i_sb) +
-		 REISERFS_QUOTA_TRANS_BLOCKS(parent_dir->i_sb));
+	    2 * (REISERFS_QUOTA_INIT_BLOCKS(inode_sb(parent_dir)) +
+		 REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(parent_dir)));
 
 	retval = dquot_initialize(parent_dir);
 	if (retval)
 		return retval;
 
-	if (!(inode = new_inode(parent_dir->i_sb))) {
+	if (!(inode = new_inode(inode_sb(parent_dir)))) {
 		return -ENOMEM;
 	}
 	retval = new_inode_init(inode, parent_dir, mode);
@@ -1134,9 +1134,9 @@ static int reiserfs_symlink(struct inode *parent_dir,
 	}
 	jbegin_count += retval;
 
-	reiserfs_write_lock(parent_dir->i_sb);
+	reiserfs_write_lock(inode_sb(parent_dir));
 	item_len = ROUND_UP(strlen(symname));
-	if (item_len > MAX_DIRECT_ITEM_LEN(parent_dir->i_sb->s_blocksize)) {
+	if (item_len > MAX_DIRECT_ITEM_LEN(inode_sb(parent_dir)->s_blocksize)) {
 		retval = -ENAMETOOLONG;
 		drop_new_inode(inode);
 		goto out_failed;
@@ -1151,7 +1151,7 @@ static int reiserfs_symlink(struct inode *parent_dir,
 	memcpy(name, symname, strlen(symname));
 	padd_item(name, item_len, strlen(symname));
 
-	retval = journal_begin(&th, parent_dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(parent_dir), jbegin_count);
 	if (retval) {
 		drop_new_inode(inode);
 		kfree(name);
@@ -1191,7 +1191,7 @@ static int reiserfs_symlink(struct inode *parent_dir,
 	d_instantiate(dentry, inode);
 	retval = journal_end(&th);
 out_failed:
-	reiserfs_write_unlock(parent_dir->i_sb);
+	reiserfs_write_unlock(inode_sb(parent_dir));
 	return retval;
 }
 
@@ -1207,26 +1207,26 @@ static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
 	 */
 	int jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 +
-	    2 * REISERFS_QUOTA_TRANS_BLOCKS(dir->i_sb);
+	    2 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(dir));
 
 	retval = dquot_initialize(dir);
 	if (retval)
 		return retval;
 
-	reiserfs_write_lock(dir->i_sb);
+	reiserfs_write_lock(inode_sb(dir));
 	if (inode->i_nlink >= REISERFS_LINK_MAX) {
 		/* FIXME: sd_nlink is 32 bit for new files */
-		reiserfs_write_unlock(dir->i_sb);
+		reiserfs_write_unlock(inode_sb(dir));
 		return -EMLINK;
 	}
 
 	/* inc before scheduling so reiserfs_unlink knows we are here */
 	inc_nlink(inode);
 
-	retval = journal_begin(&th, dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(dir), jbegin_count);
 	if (retval) {
 		drop_nlink(inode);
-		reiserfs_write_unlock(dir->i_sb);
+		reiserfs_write_unlock(inode_sb(dir));
 		return retval;
 	}
 
@@ -1242,7 +1242,7 @@ static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
 		int err;
 		drop_nlink(inode);
 		err = journal_end(&th);
-		reiserfs_write_unlock(dir->i_sb);
+		reiserfs_write_unlock(inode_sb(dir));
 		return err ? err : retval;
 	}
 
@@ -1252,7 +1252,7 @@ static int reiserfs_link(struct dentry *old_dentry, struct inode *dir,
 	ihold(inode);
 	d_instantiate(dentry, inode);
 	retval = journal_end(&th);
-	reiserfs_write_unlock(dir->i_sb);
+	reiserfs_write_unlock(inode_sb(dir));
 	return retval;
 }
 
@@ -1279,7 +1279,7 @@ static int entry_points_to_object(const char *name, int len,
 
 	if (inode) {
 		if (!de_visible(de->de_deh + de->de_entry_num))
-			reiserfs_panic(inode->i_sb, "vs-7042",
+			reiserfs_panic(inode_sb(inode), "vs-7042",
 				       "entry must be visible");
 		return (de->de_objectid == inode->i_ino) ? 1 : 0;
 	}
@@ -1337,7 +1337,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 */
 	jbegin_count =
 	    JOURNAL_PER_BALANCE_CNT * 3 + 5 +
-	    4 * REISERFS_QUOTA_TRANS_BLOCKS(old_dir->i_sb);
+	    4 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(old_dir));
 
 	retval = dquot_initialize(old_dir);
 	if (retval)
@@ -1354,19 +1354,19 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 * are going to rename
 	 */
 	old_de.de_gen_number_bit_string = NULL;
-	reiserfs_write_lock(old_dir->i_sb);
+	reiserfs_write_lock(inode_sb(old_dir));
 	retval =
 	    reiserfs_find_entry(old_dir, old_dentry->d_name.name,
 				old_dentry->d_name.len, &old_entry_path,
 				&old_de);
 	pathrelse(&old_entry_path);
 	if (retval == IO_ERROR) {
-		reiserfs_write_unlock(old_dir->i_sb);
+		reiserfs_write_unlock(inode_sb(old_dir));
 		return -EIO;
 	}
 
 	if (retval != NAME_FOUND || old_de.de_objectid != old_inode->i_ino) {
-		reiserfs_write_unlock(old_dir->i_sb);
+		reiserfs_write_unlock(inode_sb(old_dir));
 		return -ENOENT;
 	}
 
@@ -1379,7 +1379,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		 */
 		if (new_dentry_inode) {
 			if (!reiserfs_empty_dir(new_dentry_inode)) {
-				reiserfs_write_unlock(old_dir->i_sb);
+				reiserfs_write_unlock(inode_sb(old_dir));
 				return -ENOTEMPTY;
 			}
 		}
@@ -1394,20 +1394,20 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 					&dot_dot_de);
 		pathrelse(&dot_dot_entry_path);
 		if (retval != NAME_FOUND) {
-			reiserfs_write_unlock(old_dir->i_sb);
+			reiserfs_write_unlock(inode_sb(old_dir));
 			return -EIO;
 		}
 
 		/* inode number of .. must equal old_dir->i_ino */
 		if (dot_dot_de.de_objectid != old_dir->i_ino) {
-			reiserfs_write_unlock(old_dir->i_sb);
+			reiserfs_write_unlock(inode_sb(old_dir));
 			return -EIO;
 		}
 	}
 
-	retval = journal_begin(&th, old_dir->i_sb, jbegin_count);
+	retval = journal_begin(&th, inode_sb(old_dir), jbegin_count);
 	if (retval) {
-		reiserfs_write_unlock(old_dir->i_sb);
+		reiserfs_write_unlock(inode_sb(old_dir));
 		return retval;
 	}
 
@@ -1417,12 +1417,12 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			       new_dentry->d_name.len, old_inode, 0);
 	if (retval == -EEXIST) {
 		if (!new_dentry_inode) {
-			reiserfs_panic(old_dir->i_sb, "vs-7050",
+			reiserfs_panic(inode_sb(old_dir), "vs-7050",
 				       "new entry is found, new inode == 0");
 		}
 	} else if (retval) {
 		int err = journal_end(&th);
-		reiserfs_write_unlock(old_dir->i_sb);
+		reiserfs_write_unlock(inode_sb(old_dir));
 		return err ? err : retval;
 	}
 
@@ -1444,18 +1444,19 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		 * (found by reiserfs_find_entry)
 		 */
 		if ((retval =
-		     search_by_entry_key(new_dir->i_sb, &old_de.de_entry_key,
+		     search_by_entry_key(inode_sb(new_dir), &old_de.de_entry_key,
 					 &old_entry_path,
 					 &old_de)) != NAME_FOUND) {
 			pathrelse(&old_entry_path);
 			journal_end(&th);
-			reiserfs_write_unlock(old_dir->i_sb);
+			reiserfs_write_unlock(inode_sb(old_dir));
 			return -EIO;
 		}
 
 		copy_item_head(&old_entry_ih, tp_item_head(&old_entry_path));
 
-		reiserfs_prepare_for_journal(old_inode->i_sb, old_de.de_bh, 1);
+		reiserfs_prepare_for_journal(inode_sb(old_inode),
+					     old_de.de_bh, 1);
 
 		/* look for new name by reiserfs_find_entry */
 		new_de.de_gen_number_bit_string = NULL;
@@ -1473,17 +1474,18 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			pathrelse(&new_entry_path);
 			pathrelse(&old_entry_path);
 			journal_end(&th);
-			reiserfs_write_unlock(old_dir->i_sb);
+			reiserfs_write_unlock(inode_sb(old_dir));
 			return -EIO;
 		}
 
 		copy_item_head(&new_entry_ih, tp_item_head(&new_entry_path));
 
-		reiserfs_prepare_for_journal(old_inode->i_sb, new_de.de_bh, 1);
+		reiserfs_prepare_for_journal(inode_sb(old_inode),
+					     new_de.de_bh, 1);
 
 		if (S_ISDIR(old_inode->i_mode)) {
 			if ((retval =
-			     search_by_entry_key(new_dir->i_sb,
+			     search_by_entry_key(inode_sb(new_dir),
 						 &dot_dot_de.de_entry_key,
 						 &dot_dot_entry_path,
 						 &dot_dot_de)) != NAME_FOUND) {
@@ -1491,13 +1493,13 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 				pathrelse(&new_entry_path);
 				pathrelse(&old_entry_path);
 				journal_end(&th);
-				reiserfs_write_unlock(old_dir->i_sb);
+				reiserfs_write_unlock(inode_sb(old_dir));
 				return -EIO;
 			}
 			copy_item_head(&dot_dot_ih,
 				       tp_item_head(&dot_dot_entry_path));
 			/* node containing ".." gets into transaction */
-			reiserfs_prepare_for_journal(old_inode->i_sb,
+			reiserfs_prepare_for_journal(inode_sb(old_inode),
 						     dot_dot_de.de_bh, 1);
 		}
 		/*
@@ -1525,13 +1527,12 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		    !entry_points_to_object(old_dentry->d_name.name,
 					    old_dentry->d_name.len,
 					    &old_de, old_inode)) {
-			reiserfs_restore_prepared_buffer(old_inode->i_sb,
+			reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 							 new_de.de_bh);
-			reiserfs_restore_prepared_buffer(old_inode->i_sb,
+			reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 							 old_de.de_bh);
 			if (S_ISDIR(old_inode_mode))
-				reiserfs_restore_prepared_buffer(old_inode->
-								 i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 								 dot_dot_de.
 								 de_bh);
 			continue;
@@ -1540,14 +1541,11 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			if (item_moved(&dot_dot_ih, &dot_dot_entry_path) ||
 			    !entry_points_to_object("..", 2, &dot_dot_de,
 						    old_dir)) {
-				reiserfs_restore_prepared_buffer(old_inode->
-								 i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 								 old_de.de_bh);
-				reiserfs_restore_prepared_buffer(old_inode->
-								 i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 								 new_de.de_bh);
-				reiserfs_restore_prepared_buffer(old_inode->
-								 i_sb,
+				reiserfs_restore_prepared_buffer(inode_sb(old_inode),
 								 dot_dot_de.
 								 de_bh);
 				continue;
@@ -1621,7 +1619,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (reiserfs_cut_from_item
 	    (&th, &old_entry_path, &old_de.de_entry_key, old_dir, NULL,
 	     0) < 0)
-		reiserfs_error(old_dir->i_sb, "vs-7060",
+		reiserfs_error(inode_sb(old_dir), "vs-7060",
 			       "couldn't not cut old name. Fsck later?");
 
 	old_dir->i_size -= DEH_SIZE + old_de.de_entrylen;
@@ -1638,7 +1636,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	}
 
 	retval = journal_end(&th);
-	reiserfs_write_unlock(old_dir->i_sb);
+	reiserfs_write_unlock(inode_sb(old_dir));
 	return retval;
 }
 
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 48835a659948..2523d838588c 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -2886,7 +2886,7 @@ int journal_mark_dirty(struct reiserfs_transaction_handle *,
 
 static inline int reiserfs_file_data_log(struct inode *inode)
 {
-	if (reiserfs_data_log(inode->i_sb) ||
+	if (reiserfs_data_log(inode_sb(inode)) ||
 	    (REISERFS_I(inode)->i_flags & i_data_log))
 		return 1;
 	return 0;
@@ -3042,12 +3042,12 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 			 struct inode *inode, struct page *,
 			 int update_timestamps);
 
-#define i_block_size(inode) ((inode)->i_sb->s_blocksize)
+#define i_block_size(inode) (inode_sb((inode))->s_blocksize)
 #define file_size(inode) ((inode)->i_size)
 #define tail_size(inode) (file_size (inode) & (i_block_size (inode) - 1))
 
-#define tail_has_to_be_packed(inode) (have_large_tails ((inode)->i_sb)?\
-!STORE_TAIL_IN_UNFM_S1(file_size (inode), tail_size(inode), inode->i_sb->s_blocksize):have_small_tails ((inode)->i_sb)?!STORE_TAIL_IN_UNFM_S2(file_size (inode), tail_size(inode), inode->i_sb->s_blocksize):0 )
+#define tail_has_to_be_packed(inode) (have_large_tails (inode_sb((inode)))?\
+!STORE_TAIL_IN_UNFM_S1(file_size (inode), tail_size(inode), inode_sb(inode)->s_blocksize):have_small_tails (inode_sb((inode)))?!STORE_TAIL_IN_UNFM_S2(file_size (inode), tail_size(inode), inode_sb(inode)->s_blocksize):0 )
 
 void padd_item(char *item, int total_length, int length);
 
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 0037aea97d39..a69a974ef362 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1029,7 +1029,7 @@ static char prepare_for_delete_or_cut(struct reiserfs_transaction_handle *th,
 				      unsigned long long new_file_length
     )
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct item_head *p_le_ih = tp_item_head(path);
 	struct buffer_head *bh = PATH_PLAST_BUFFER(path);
 
@@ -1235,7 +1235,7 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
 			 struct treepath *path, const struct cpu_key *item_key,
 			 struct inode *inode, struct buffer_head *un_bh)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct tree_balance s_del_balance;
 	struct item_head s_ih;
 	struct item_head *q_ih;
@@ -1358,9 +1358,9 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
 		       "reiserquota delete_item(): freeing %u, id=%u type=%c",
 		       quota_cut_bytes, inode->i_uid, head2type(&s_ih));
 #endif
-	depth = reiserfs_write_unlock_nested(inode->i_sb);
+	depth = reiserfs_write_unlock_nested(inode_sb(inode));
 	dquot_free_space_nodirty(inode, quota_cut_bytes);
-	reiserfs_write_lock_nested(inode->i_sb, depth);
+	reiserfs_write_lock_nested(inode_sb(inode), depth);
 
 	/* Return deleted body length */
 	return ret_value;
@@ -1544,7 +1544,7 @@ static int maybe_indirect_to_direct(struct reiserfs_transaction_handle *th,
 				    const struct cpu_key *item_key,
 				    loff_t new_file_size, char *mode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int block_size = sb->s_blocksize;
 	int cut_bytes;
 	BUG_ON(!th->t_trans_id);
@@ -1589,12 +1589,12 @@ static void indirect_to_direct_roll_back(struct reiserfs_transaction_handle *th,
 	tail_key.key_length = 4;
 
 	tail_len =
-	    (cpu_key_k_offset(&tail_key) & (inode->i_sb->s_blocksize - 1)) - 1;
+	    (cpu_key_k_offset(&tail_key) & (inode_sb(inode)->s_blocksize - 1)) - 1;
 	while (tail_len) {
 		/* look for the last byte of the tail */
-		if (search_for_position_by_key(inode->i_sb, &tail_key, path) ==
+		if (search_for_position_by_key(inode_sb(inode), &tail_key, path) ==
 		    POSITION_NOT_FOUND)
-			reiserfs_panic(inode->i_sb, "vs-5615",
+			reiserfs_panic(inode_sb(inode), "vs-5615",
 				       "found invalid item");
 		RFALSE(path->pos_in_item !=
 		       ih_item_len(tp_item_head(path)) - 1,
@@ -1612,7 +1612,8 @@ static void indirect_to_direct_roll_back(struct reiserfs_transaction_handle *th,
 		set_cpu_key_k_offset(&tail_key,
 				     cpu_key_k_offset(&tail_key) - removed);
 	}
-	reiserfs_warning(inode->i_sb, "reiserfs-5091", "indirect_to_direct "
+	reiserfs_warning(inode_sb(inode), "reiserfs-5091",
+			 "indirect_to_direct "
 			 "conversion has been rolled back due to "
 			 "lack of disk space");
 	mark_inode_dirty(inode);
@@ -1625,7 +1626,7 @@ int reiserfs_cut_from_item(struct reiserfs_transaction_handle *th,
 			   struct inode *inode,
 			   struct page *page, loff_t new_file_size)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	/*
 	 * Every function which is going to call do_balance must first
 	 * create a tree_balance structure.  Then it must fill up this
@@ -1646,7 +1647,7 @@ int reiserfs_cut_from_item(struct reiserfs_transaction_handle *th,
 
 	BUG_ON(!th->t_trans_id);
 
-	init_tb_struct(th, &s_cut_balance, inode->i_sb, path,
+	init_tb_struct(th, &s_cut_balance, inode_sb(inode), path,
 		       cut_size);
 
 	/*
@@ -1830,7 +1831,7 @@ int reiserfs_cut_from_item(struct reiserfs_transaction_handle *th,
 		REISERFS_I(inode)->i_flags &= ~i_pack_on_close_mask;
 	}
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug(inode->i_sb, REISERFS_DEBUG_CODE,
+	reiserfs_debug(inode_sb(inode), REISERFS_DEBUG_CODE,
 		       "reiserquota cut_from_item(): freeing %u id=%u type=%c",
 		       quota_cut_bytes, inode->i_uid, '?');
 #endif
@@ -1845,7 +1846,7 @@ static void truncate_directory(struct reiserfs_transaction_handle *th,
 {
 	BUG_ON(!th->t_trans_id);
 	if (inode->i_nlink)
-		reiserfs_error(inode->i_sb, "vs-5655", "link count != 0");
+		reiserfs_error(inode_sb(inode), "vs-5655", "link count != 0");
 
 	set_le_key_k_offset(KEY_FORMAT_3_5, INODE_PKEY(inode), DOT_OFFSET);
 	set_le_key_k_type(KEY_FORMAT_3_5, INODE_PKEY(inode), TYPE_DIRENTRY);
@@ -1900,17 +1901,17 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 		     TYPE_DIRECT, 3);
 
 	retval =
-	    search_for_position_by_key(inode->i_sb, &s_item_key,
+	    search_for_position_by_key(inode_sb(inode), &s_item_key,
 				       &s_search_path);
 	if (retval == IO_ERROR) {
-		reiserfs_error(inode->i_sb, "vs-5657",
+		reiserfs_error(inode_sb(inode), "vs-5657",
 			       "i/o failure occurred trying to truncate %K",
 			       &s_item_key);
 		err = -EIO;
 		goto out;
 	}
 	if (retval == POSITION_FOUND || retval == FILE_NOT_FOUND) {
-		reiserfs_error(inode->i_sb, "PAP-5660",
+		reiserfs_error(inode_sb(inode), "PAP-5660",
 			       "wrong result %d of search for %K", retval,
 			       &s_item_key);
 
@@ -1927,7 +1928,7 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 	else {
 		loff_t offset = le_ih_k_offset(p_le_ih);
 		int bytes =
-		    op_bytes_number(p_le_ih, inode->i_sb->s_blocksize);
+		    op_bytes_number(p_le_ih, inode_sb(inode)->s_blocksize);
 
 		/*
 		 * this may mismatch with real file size: if last direct item
@@ -1956,7 +1957,7 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 		    reiserfs_cut_from_item(th, &s_search_path, &s_item_key,
 					   inode, page, new_file_size);
 		if (deleted < 0) {
-			reiserfs_warning(inode->i_sb, "vs-5665",
+			reiserfs_warning(inode_sb(inode), "vs-5665",
 					 "reiserfs_cut_from_item failed");
 			reiserfs_check_path(&s_search_path);
 			return 0;
@@ -1996,14 +1997,14 @@ int reiserfs_do_truncate(struct reiserfs_transaction_handle *th,
 			err = journal_end(th);
 			if (err)
 				goto out;
-			err = journal_begin(th, inode->i_sb,
+			err = journal_begin(th, inode_sb(inode),
 					    JOURNAL_FOR_FREE_BLOCK_AND_UPDATE_SD + JOURNAL_PER_BALANCE_CNT * 4) ;
 			if (err)
 				goto out;
 			reiserfs_update_inode_transaction(inode);
 		}
 	} while (file_size > ROUND_UP(new_file_size) &&
-		 search_for_position_by_key(inode->i_sb, &s_item_key,
+		 search_for_position_by_key(inode_sb(inode), &s_item_key,
 					    &s_search_path) == POSITION_FOUND);
 
 	RFALSE(file_size > ROUND_UP(new_file_size),
@@ -2074,7 +2075,7 @@ int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
 			     /* Size of pasted bytes. */
 			     int pasted_size)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct tree_balance s_paste_balance;
 	int retval;
 	int fs_gen;
@@ -2082,10 +2083,10 @@ int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
 
 	BUG_ON(!th->t_trans_id);
 
-	fs_gen = get_generation(inode->i_sb);
+	fs_gen = get_generation(inode_sb(inode));
 
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug(inode->i_sb, REISERFS_DEBUG_CODE,
+	reiserfs_debug(inode_sb(inode), REISERFS_DEBUG_CODE,
 		       "reiserquota paste_into_item(): allocating %u id=%u type=%c",
 		       pasted_size, inode->i_uid,
 		       key2type(&key->on_disk_key));
@@ -2105,7 +2106,7 @@ int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
 #endif
 
 	/* DQUOT_* can schedule, must check before the fix_nodes */
-	if (fs_changed(fs_gen, inode->i_sb)) {
+	if (fs_changed(fs_gen, inode_sb(inode))) {
 		goto search_again;
 	}
 
@@ -2123,7 +2124,7 @@ int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
 			goto error_out;
 		}
 		if (retval == POSITION_FOUND) {
-			reiserfs_warning(inode->i_sb, "PAP-5710",
+			reiserfs_warning(inode_sb(inode), "PAP-5710",
 					 "entry or pasted byte (%K) exists",
 					 key);
 			retval = -EEXIST;
@@ -2147,7 +2148,7 @@ int reiserfs_paste_into_item(struct reiserfs_transaction_handle *th,
 	/* this also releases the path */
 	unfix_nodes(&s_paste_balance);
 #ifdef REISERQUOTA_DEBUG
-	reiserfs_debug(inode->i_sb, REISERFS_DEBUG_CODE,
+	reiserfs_debug(inode_sb(inode), REISERFS_DEBUG_CODE,
 		       "reiserquota paste_into_item(): freeing %u id=%u type=%c",
 		       pasted_size, inode->i_uid,
 		       key2type(&key->on_disk_key));
@@ -2179,7 +2180,7 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
 
 	if (inode) {		/* Do we count quotas for item? */
 		int depth;
-		fs_gen = get_generation(inode->i_sb);
+		fs_gen = get_generation(inode_sb(inode));
 		quota_bytes = ih_item_len(ih);
 
 		/*
@@ -2188,9 +2189,9 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
 		 * so there's no guessing needed
 		 */
 		if (!S_ISLNK(inode->i_mode) && is_direct_le_ih(ih))
-			quota_bytes = inode->i_sb->s_blocksize + UNFM_P_SIZE;
+			quota_bytes = inode_sb(inode)->s_blocksize + UNFM_P_SIZE;
 #ifdef REISERQUOTA_DEBUG
-		reiserfs_debug(inode->i_sb, REISERFS_DEBUG_CODE,
+		reiserfs_debug(inode_sb(inode), REISERFS_DEBUG_CODE,
 			       "reiserquota insert_item(): allocating %u id=%u type=%c",
 			       quota_bytes, inode->i_uid, head2type(ih));
 #endif
@@ -2198,9 +2199,9 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
 		 * We can't dirty inode here. It would be immediately
 		 * written but appropriate stat item isn't inserted yet...
 		 */
-		depth = reiserfs_write_unlock_nested(inode->i_sb);
+		depth = reiserfs_write_unlock_nested(inode_sb(inode));
 		retval = dquot_alloc_space_nodirty(inode, quota_bytes);
-		reiserfs_write_lock_nested(inode->i_sb, depth);
+		reiserfs_write_lock_nested(inode_sb(inode), depth);
 		if (retval) {
 			pathrelse(path);
 			return retval;
@@ -2215,7 +2216,7 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
 	 * DQUOT_* can schedule, must check to be sure calling
 	 * fix_nodes is safe
 	 */
-	if (inode && fs_changed(fs_gen, inode->i_sb)) {
+	if (inode && fs_changed(fs_gen, inode_sb(inode))) {
 		goto search_again;
 	}
 
@@ -2255,9 +2256,9 @@ int reiserfs_insert_item(struct reiserfs_transaction_handle *th,
 		       quota_bytes, inode->i_uid, head2type(ih));
 #endif
 	if (inode) {
-		int depth = reiserfs_write_unlock_nested(inode->i_sb);
+		int depth = reiserfs_write_unlock_nested(inode_sb(inode));
 		dquot_free_space_nodirty(inode, quota_bytes);
-		reiserfs_write_lock_nested(inode->i_sb, depth);
+		reiserfs_write_lock_nested(inode_sb(inode), depth);
 	}
 	return retval;
 }
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1fc934d24459..031010fe79f9 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -340,9 +340,9 @@ static int finish_unfinished(struct super_block *s)
 			retval = remove_save_link_only(s, &save_link_key, 0);
 			continue;
 		}
-		depth = reiserfs_write_unlock_nested(inode->i_sb);
+		depth = reiserfs_write_unlock_nested(inode_sb(inode));
 		dquot_initialize(inode);
-		reiserfs_write_lock_nested(inode->i_sb, depth);
+		reiserfs_write_lock_nested(inode_sb(inode), depth);
 
 		if (truncate && S_ISDIR(inode->i_mode)) {
 			/*
@@ -453,17 +453,18 @@ void add_save_link(struct reiserfs_transaction_handle *th,
 	key.on_disk_key.k_objectid = inode->i_ino;
 	if (!truncate) {
 		/* unlink, rmdir, rename */
-		set_cpu_key_k_offset(&key, 1 + inode->i_sb->s_blocksize);
+		set_cpu_key_k_offset(&key, 1 + inode_sb(inode)->s_blocksize);
 		set_cpu_key_k_type(&key, TYPE_DIRECT);
 
 		/* item head of "safe" link */
 		make_le_item_head(&ih, &key, key.version,
-				  1 + inode->i_sb->s_blocksize, TYPE_DIRECT,
+				  1 + inode_sb(inode)->s_blocksize,
+				  TYPE_DIRECT,
 				  4 /*length */ , 0xffff /*free space */ );
 	} else {
 		/* truncate */
 		if (S_ISDIR(inode->i_mode))
-			reiserfs_warning(inode->i_sb, "green-2102",
+			reiserfs_warning(inode_sb(inode), "green-2102",
 					 "Adding a truncate savelink for "
 					 "a directory %k! Please report",
 					 INODE_PKEY(inode));
@@ -477,10 +478,10 @@ void add_save_link(struct reiserfs_transaction_handle *th,
 	key.key_length = 3;
 
 	/* look for its place in the tree */
-	retval = search_item(inode->i_sb, &key, &path);
+	retval = search_item(inode_sb(inode), &key, &path);
 	if (retval != ITEM_NOT_FOUND) {
 		if (retval != -ENOSPC)
-			reiserfs_error(inode->i_sb, "vs-2100",
+			reiserfs_error(inode_sb(inode), "vs-2100",
 				       "search_by_key (%K) returned %d", &key,
 				       retval);
 		pathrelse(&path);
@@ -495,7 +496,7 @@ void add_save_link(struct reiserfs_transaction_handle *th,
 	    reiserfs_insert_item(th, &path, &key, &ih, NULL, (char *)&link);
 	if (retval) {
 		if (retval != -ENOSPC)
-			reiserfs_error(inode->i_sb, "vs-2120",
+			reiserfs_error(inode_sb(inode), "vs-2120",
 				       "insert_item returned %d", retval);
 	} else {
 		if (truncate)
@@ -514,7 +515,7 @@ int remove_save_link(struct inode *inode, int truncate)
 	int err;
 
 	/* we are going to do one balancing only */
-	err = journal_begin(&th, inode->i_sb, JOURNAL_PER_BALANCE_CNT);
+	err = journal_begin(&th, inode_sb(inode), JOURNAL_PER_BALANCE_CNT);
 	if (err)
 		return err;
 
@@ -524,7 +525,7 @@ int remove_save_link(struct inode *inode, int truncate)
 	if (!truncate) {
 		/* unlink, rmdir, rename */
 		set_le_key_k_offset(KEY_FORMAT_3_5, &key,
-				    1 + inode->i_sb->s_blocksize);
+				    1 + inode_sb(inode)->s_blocksize);
 		set_le_key_k_type(KEY_FORMAT_3_5, &key, TYPE_DIRECT);
 	} else {
 		/* truncate */
@@ -700,19 +701,19 @@ static void reiserfs_dirty_inode(struct inode *inode, int flags)
 
 	int err = 0;
 
-	if (sb_rdonly(inode->i_sb)) {
-		reiserfs_warning(inode->i_sb, "clm-6006",
+	if (sb_rdonly(inode_sb(inode))) {
+		reiserfs_warning(inode_sb(inode), "clm-6006",
 				 "writing inode %lu on readonly FS",
 				 inode->i_ino);
 		return;
 	}
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 
 	/*
 	 * this is really only used for atime updates, so they don't have
 	 * to be included in O_SYNC or fsync
 	 */
-	err = journal_begin(&th, inode->i_sb, 1);
+	err = journal_begin(&th, inode_sb(inode), 1);
 	if (err)
 		goto out;
 
@@ -720,7 +721,7 @@ static void reiserfs_dirty_inode(struct inode *inode, int flags)
 	journal_end(&th);
 
 out:
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 }
 
 static int reiserfs_show_options(struct seq_file *seq, struct dentry *root)
diff --git a/fs/reiserfs/tail_conversion.c b/fs/reiserfs/tail_conversion.c
index b0ae088dffc7..a6635188890a 100644
--- a/fs/reiserfs/tail_conversion.c
+++ b/fs/reiserfs/tail_conversion.c
@@ -26,7 +26,7 @@ int direct2indirect(struct reiserfs_transaction_handle *th, struct inode *inode,
 		    struct treepath *path, struct buffer_head *unbh,
 		    loff_t tail_offset)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *up_to_date_bh;
 	struct item_head *p_le_ih = tp_item_head(path);
 	unsigned long total_tail = 0;
@@ -178,7 +178,7 @@ void reiserfs_unmap_buffer(struct buffer_head *bh)
 	 */
 	if ((!list_empty(&bh->b_assoc_buffers) || bh->b_private) && bh->b_page) {
 		struct inode *inode = bh->b_page->mapping->host;
-		struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
+		struct reiserfs_journal *j = SB_JOURNAL(inode_sb(inode));
 		spin_lock(&j->j_dirty_buffers_lock);
 		list_del_init(&bh->b_assoc_buffers);
 		reiserfs_free_jh(bh);
@@ -208,7 +208,7 @@ int indirect2direct(struct reiserfs_transaction_handle *th,
 		    loff_t n_new_file_size,	/* New file size. */
 		    char *mode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct item_head s_ih;
 	unsigned long block_size = sb->s_blocksize;
 	char *tail;
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 5dbf5324bdda..e73afd1703ef 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -149,7 +149,7 @@ static struct dentry *open_xa_dir(const struct inode *inode, int flags)
 	struct dentry *xaroot, *xadir;
 	char namebuf[17];
 
-	xaroot = open_xa_root(inode->i_sb, flags);
+	xaroot = open_xa_root(inode_sb(inode), flags);
 	if (IS_ERR(xaroot))
 		return xaroot;
 
@@ -290,21 +290,21 @@ static int reiserfs_for_each_xattr(struct inode *inode,
 		 * outer transaction.
 		 */
 		int blocks = JOURNAL_PER_BALANCE_CNT * 2 + 2 +
-			     4 * REISERFS_QUOTA_TRANS_BLOCKS(inode->i_sb);
+			     4 * REISERFS_QUOTA_TRANS_BLOCKS(inode_sb(inode));
 		struct reiserfs_transaction_handle th;
 
-		reiserfs_write_lock(inode->i_sb);
-		err = journal_begin(&th, inode->i_sb, blocks);
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
+		err = journal_begin(&th, inode_sb(inode), blocks);
+		reiserfs_write_unlock(inode_sb(inode));
 		if (!err) {
 			int jerror;
 
 			inode_lock_nested(d_inode(dir->d_parent),
 					  I_MUTEX_XATTR);
 			err = action(dir, data);
-			reiserfs_write_lock(inode->i_sb);
+			reiserfs_write_lock(inode_sb(inode));
 			jerror = journal_end(&th);
-			reiserfs_write_unlock(inode->i_sb);
+			reiserfs_write_unlock(inode_sb(inode));
 			inode_unlock(d_inode(dir->d_parent));
 			err = jerror ?: err;
 		}
@@ -353,7 +353,7 @@ int reiserfs_delete_xattrs(struct inode *inode)
 	int err = reiserfs_for_each_xattr(inode, delete_one_xattr, NULL);
 
 	if (err)
-		reiserfs_warning(inode->i_sb, "jdm-20004",
+		reiserfs_warning(inode_sb(inode), "jdm-20004",
 				 "Couldn't delete all xattrs (%d)\n", err);
 	return err;
 }
@@ -364,7 +364,7 @@ int reiserfs_chown_xattrs(struct inode *inode, struct iattr *attrs)
 	int err = reiserfs_for_each_xattr(inode, chown_one_xattr, attrs);
 
 	if (err)
-		reiserfs_warning(inode->i_sb, "jdm-20007",
+		reiserfs_warning(inode_sb(inode), "jdm-20007",
 				 "Couldn't chown all xattrs (%d)\n", err);
 	return err;
 }
@@ -554,7 +554,7 @@ reiserfs_xattr_set_handle(struct reiserfs_transaction_handle *th,
 			rxh->h_hash = cpu_to_le32(xahash);
 		}
 
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		err = __reiserfs_write_begin(page, page_offset, chunk + skip);
 		if (!err) {
 			if (buffer)
@@ -563,7 +563,7 @@ reiserfs_xattr_set_handle(struct reiserfs_transaction_handle *th,
 						    page_offset + chunk +
 						    skip);
 		}
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		unlock_page(page);
 		reiserfs_put_page(page);
 		buffer_pos += chunk;
@@ -606,9 +606,9 @@ int reiserfs_xattr_set(struct inode *inode, const char *name,
 	if (!(flags & XATTR_REPLACE))
 		jbegin_count += reiserfs_xattr_jcreate_nblocks(inode);
 
-	reiserfs_write_lock(inode->i_sb);
-	error = journal_begin(&th, inode->i_sb, jbegin_count);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
+	error = journal_begin(&th, inode_sb(inode), jbegin_count);
+	reiserfs_write_unlock(inode_sb(inode));
 	if (error) {
 		return error;
 	}
@@ -616,9 +616,9 @@ int reiserfs_xattr_set(struct inode *inode, const char *name,
 	error = reiserfs_xattr_set_handle(&th, inode, name,
 					  buffer, buffer_size, flags);
 
-	reiserfs_write_lock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
 	error2 = journal_end(&th);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_unlock(inode_sb(inode));
 	if (error == 0)
 		error = error2;
 
@@ -698,7 +698,7 @@ reiserfs_xattr_get(struct inode *inode, const char *name, void *buffer,
 			if (rxh->h_magic != cpu_to_le32(REISERFS_XATTR_MAGIC)) {
 				unlock_page(page);
 				reiserfs_put_page(page);
-				reiserfs_warning(inode->i_sb, "jdm-20001",
+				reiserfs_warning(inode_sb(inode), "jdm-20001",
 						 "Invalid magic for xattr (%s) "
 						 "associated with %k", name,
 						 INODE_PKEY(inode));
@@ -718,7 +718,7 @@ reiserfs_xattr_get(struct inode *inode, const char *name, void *buffer,
 
 	if (xattr_hash(buffer, isize - sizeof(struct reiserfs_xattr_header)) !=
 	    hash) {
-		reiserfs_warning(inode->i_sb, "jdm-20002",
+		reiserfs_warning(inode_sb(inode), "jdm-20002",
 				 "Invalid hash for xattr (%s) associated "
 				 "with %k", name, INODE_PKEY(inode));
 		err = -EIO;
diff --git a/fs/reiserfs/xattr.h b/fs/reiserfs/xattr.h
index c764352447ba..7b7c55d603a6 100644
--- a/fs/reiserfs/xattr.h
+++ b/fs/reiserfs/xattr.h
@@ -51,8 +51,9 @@ static inline loff_t reiserfs_xattr_nblocks(struct inode *inode, loff_t size)
 {
 	loff_t ret = 0;
 	if (reiserfs_file_data_log(inode)) {
-		ret = _ROUND_UP(xattr_size(size), inode->i_sb->s_blocksize);
-		ret >>= inode->i_sb->s_blocksize_bits;
+		ret = _ROUND_UP(xattr_size(size),
+				inode_sb(inode)->s_blocksize);
+		ret >>= inode_sb(inode)->s_blocksize_bits;
 	}
 	return ret;
 }
@@ -71,12 +72,12 @@ static inline loff_t reiserfs_xattr_nblocks(struct inode *inode, loff_t size)
  */
 static inline size_t reiserfs_xattr_jcreate_nblocks(struct inode *inode)
 {
-	size_t nblocks = JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
+	size_t nblocks = JOURNAL_BLOCKS_PER_OBJECT(inode_sb(inode));
 
 	if ((REISERFS_I(inode)->i_flags & i_has_xattr_dir) == 0) {
-		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
-		if (d_really_is_negative(REISERFS_SB(inode->i_sb)->xattr_root))
-			nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
+		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode_sb(inode));
+		if (d_really_is_negative(REISERFS_SB(inode_sb(inode))->xattr_root))
+			nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode_sb(inode));
 	}
 
 	return nblocks;
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index aa9380bac196..3bebe8b2064b 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -35,9 +35,9 @@ reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	jcreate_blocks = reiserfs_xattr_jcreate_nblocks(inode) +
 			 reiserfs_xattr_nblocks(inode, size) * 2;
 
-	reiserfs_write_lock(inode->i_sb);
-	error = journal_begin(&th, inode->i_sb, jcreate_blocks);
-	reiserfs_write_unlock(inode->i_sb);
+	reiserfs_write_lock(inode_sb(inode));
+	error = journal_begin(&th, inode_sb(inode), jcreate_blocks);
+	reiserfs_write_unlock(inode_sb(inode));
 	if (error == 0) {
 		if (type == ACL_TYPE_ACCESS && acl) {
 			error = posix_acl_update_mode(inode, &mode, &acl);
@@ -49,9 +49,9 @@ reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		if (!error && update_mode)
 			inode->i_mode = mode;
 unlock:
-		reiserfs_write_lock(inode->i_sb);
+		reiserfs_write_lock(inode_sb(inode));
 		error2 = journal_end(&th);
-		reiserfs_write_unlock(inode->i_sb);
+		reiserfs_write_unlock(inode_sb(inode));
 		if (error2)
 			error = error2;
 	}
@@ -378,7 +378,7 @@ int reiserfs_cache_default_acl(struct inode *inode)
 		 * we need to create the tree to the xattrs, and then we
 		 * just want two files. */
 		nblocks = reiserfs_xattr_jcreate_nblocks(inode);
-		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode->i_sb);
+		nblocks += JOURNAL_BLOCKS_PER_OBJECT(inode_sb(inode));
 
 		REISERFS_I(inode)->i_flags |= i_has_xattr_dir;
 
@@ -398,7 +398,7 @@ int reiserfs_acl_chmod(struct inode *inode)
 	if (IS_PRIVATE(inode))
 		return 0;
 	if (get_inode_sd_version(inode) == STAT_DATA_V1 ||
-	    !reiserfs_posixacl(inode->i_sb))
+	    !reiserfs_posixacl(inode_sb(inode)))
 		return 0;
 
 	return posix_acl_chmod(inode, inode->i_mode);
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 20be9a0e5870..c0a096637536 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -66,7 +66,7 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
 		return error;
 	}
 
-	if (sec->length && reiserfs_xattrs_initialized(inode->i_sb)) {
+	if (sec->length && reiserfs_xattrs_initialized(inode_sb(inode))) {
 		blocks = reiserfs_xattr_jcreate_nblocks(inode) +
 			 reiserfs_xattr_nblocks(inode, sec->length);
 		/* We don't want to count the directories twice if we have
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index a573ca45bacc..baf8f21dd844 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -11,7 +11,7 @@ static int
 user_get(const struct xattr_handler *handler, struct dentry *unused,
 	 struct inode *inode, const char *name, void *buffer, size_t size)
 {
-	if (!reiserfs_xattrs_user(inode->i_sb))
+	if (!reiserfs_xattrs_user(inode_sb(inode)))
 		return -EOPNOTSUPP;
 	return reiserfs_xattr_get(inode, xattr_full_name(handler, name),
 				  buffer, size);
@@ -22,7 +22,7 @@ user_set(const struct xattr_handler *handler, struct dentry *unused,
 	 struct inode *inode, const char *name, const void *buffer,
 	 size_t size, int flags)
 {
-	if (!reiserfs_xattrs_user(inode->i_sb))
+	if (!reiserfs_xattrs_user(inode_sb(inode)))
 		return -EOPNOTSUPP;
 	return reiserfs_xattr_set(inode,
 				  xattr_full_name(handler, name),
-- 
2.15.1
