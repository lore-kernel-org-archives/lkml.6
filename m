Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756116AbeEHSdE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:33:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54009 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932466AbeEHSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:34 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 31/76] fs/ext4: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:51 -0700
Message-Id: <20180508180436.716-32-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ext4/acl.c            |   2 +-
 fs/ext4/balloc.c         |  14 +--
 fs/ext4/block_validity.c |   4 +-
 fs/ext4/dir.c            |  12 +-
 fs/ext4/ext4.h           |   8 +-
 fs/ext4/ext4_jbd2.c      |  10 +-
 fs/ext4/ext4_jbd2.h      |  14 +--
 fs/ext4/extents.c        | 107 ++++++++---------
 fs/ext4/extents_status.c |  23 ++--
 fs/ext4/file.c           |  22 ++--
 fs/ext4/fsync.c          |  15 +--
 fs/ext4/ialloc.c         |   7 +-
 fs/ext4/indirect.c       |  53 ++++-----
 fs/ext4/inline.c         |  53 ++++-----
 fs/ext4/inode.c          | 295 ++++++++++++++++++++++++-----------------------
 fs/ext4/ioctl.c          |  24 ++--
 fs/ext4/mballoc.c        |  13 ++-
 fs/ext4/migrate.c        |  44 +++----
 fs/ext4/move_extent.c    |  10 +-
 fs/ext4/namei.c          | 224 +++++++++++++++++------------------
 fs/ext4/page-io.c        |   9 +-
 fs/ext4/readpage.c       |   2 +-
 fs/ext4/resize.c         |   4 +-
 fs/ext4/super.c          |  52 +++++----
 fs/ext4/symlink.c        |   2 +-
 fs/ext4/sysfs.c          |   4 +-
 fs/ext4/truncate.h       |   4 +-
 fs/ext4/xattr.c          | 120 ++++++++++---------
 fs/ext4/xattr_user.c     |   4 +-
 29 files changed, 591 insertions(+), 564 deletions(-)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index fb50f9aa6ead..651d49de6039 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -259,7 +259,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	}
 out_stop:
 	ext4_journal_stop(handle);
-	if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (error == -ENOSPC && ext4_should_retry_alloc(inode_sb(inode), &retries))
 		goto retry;
 	return error;
 }
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f9b3e0a83526..7ea1ed70bdfe 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -654,7 +654,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 	 */
 	if (!(*errp) && (flags & EXT4_MB_DELALLOC_RESERVED)) {
 		dquot_alloc_block_nofail(inode,
-				EXT4_C2B(EXT4_SB(inode->i_sb), ar.len));
+				EXT4_C2B(EXT4_SB(inode_sb(inode)), ar.len));
 	}
 	return ret;
 }
@@ -855,7 +855,7 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *inode)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	ext4_group_t block_group;
 	ext4_grpblk_t colour;
-	int flex_size = ext4_flex_bg_size(EXT4_SB(inode->i_sb));
+	int flex_size = ext4_flex_bg_size(EXT4_SB(inode_sb(inode)));
 	ext4_fsblk_t bg_start;
 	ext4_fsblk_t last_block;
 
@@ -873,19 +873,19 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *inode)
 		if (S_ISREG(inode->i_mode))
 			block_group++;
 	}
-	bg_start = ext4_group_first_block_no(inode->i_sb, block_group);
-	last_block = ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es) - 1;
+	bg_start = ext4_group_first_block_no(inode_sb(inode), block_group);
+	last_block = ext4_blocks_count(EXT4_SB(inode_sb(inode))->s_es) - 1;
 
 	/*
 	 * If we are doing delayed allocation, we don't need take
 	 * colour into account.
 	 */
-	if (test_opt(inode->i_sb, DELALLOC))
+	if (test_opt(inode_sb(inode), DELALLOC))
 		return bg_start;
 
-	if (bg_start + EXT4_BLOCKS_PER_GROUP(inode->i_sb) <= last_block)
+	if (bg_start + EXT4_BLOCKS_PER_GROUP(inode_sb(inode)) <= last_block)
 		colour = (current->pid % 16) *
-			(EXT4_BLOCKS_PER_GROUP(inode->i_sb) / 16);
+			(EXT4_BLOCKS_PER_GROUP(inode_sb(inode)) / 16);
 	else
 		colour = (current->pid % 16) * ((last_block - bg_start) / 16);
 	return bg_start + colour;
diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 913061c0de1b..4ff7e6e93b18 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -223,14 +223,14 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 int ext4_check_blockref(const char *function, unsigned int line,
 			struct inode *inode, __le32 *p, unsigned int max)
 {
-	struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
+	struct ext4_super_block *es = EXT4_SB(inode_sb(inode))->s_es;
 	__le32 *bref = p;
 	unsigned int blk;
 
 	while (bref < p+max) {
 		blk = le32_to_cpu(*bref++);
 		if (blk &&
-		    unlikely(!ext4_data_block_valid(EXT4_SB(inode->i_sb),
+		    unlikely(!ext4_data_block_valid(EXT4_SB(inode_sb(inode)),
 						    blk, 1))) {
 			es->s_last_error_block = cpu_to_le64(blk);
 			ext4_error_inode(inode, function, line, blk,
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index da87cf757f7d..78097b522abd 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -40,9 +40,9 @@ static int ext4_dx_readdir(struct file *, struct dir_context *);
  */
 static int is_dx_dir(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
-	if (ext4_has_feature_dir_index(inode->i_sb) &&
+	if (ext4_has_feature_dir_index(inode_sb(inode)) &&
 	    ((ext4_test_inode_flag(inode, EXT4_INODE_INDEX)) ||
 	     ((inode->i_size >> sb->s_blocksize_bits) == 1) ||
 	     ext4_has_inline_data(inode)))
@@ -67,7 +67,7 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 {
 	const char *error_msg = NULL;
 	const int rlen = ext4_rec_len_from_disk(de->rec_len,
-						dir->i_sb->s_blocksize);
+						inode_sb(dir)->s_blocksize);
 
 	if (unlikely(rlen < EXT4_DIR_REC_LEN(1)))
 		error_msg = "rec_len is smaller than minimal";
@@ -78,7 +78,7 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	else if (unlikely(((char *) de - buf) + rlen > size))
 		error_msg = "directory entry across range";
 	else if (unlikely(le32_to_cpu(de->inode) >
-			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
+			le32_to_cpu(EXT4_SB(inode_sb(dir))->s_es->s_inodes_count)))
 		error_msg = "inode out of bounds";
 	else
 		return 0;
@@ -108,7 +108,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 	struct ext4_dir_entry_2 *de;
 	int err;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh = NULL;
 	int dir_has_error = 0;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
@@ -502,7 +502,7 @@ static int call_filldir(struct file *file, struct dir_context *ctx,
 {
 	struct dir_private_info *info = file->private_data;
 	struct inode *inode = file_inode(file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (!fname) {
 		ext4_msg(sb, KERN_ERR, "%s:%d: inode #%lu: comm %s: "
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3241475a1733..8a3784d7b51f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1978,10 +1978,10 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
  * (c) Daniel Phillips, 2001
  */
 
-#define is_dx(dir) (ext4_has_feature_dir_index((dir)->i_sb) && \
+#define is_dx(dir) (ext4_has_feature_dir_index(inode_sb((dir))) && \
 		    ext4_test_inode_flag((dir), EXT4_INODE_INDEX))
 #define EXT4_DIR_LINK_MAX(dir) unlikely((dir)->i_nlink >= EXT4_LINK_MAX && \
-		    !(ext4_has_feature_dir_nlink((dir)->i_sb) && is_dx(dir)))
+		    !(ext4_has_feature_dir_nlink(inode_sb((dir))) && is_dx(dir)))
 #define EXT4_DIR_LINK_EMPTY(dir) ((dir)->i_nlink == 2 || (dir)->i_nlink == 1)
 
 /* Legal values for the dx_root hash_version field: */
@@ -2341,7 +2341,7 @@ void ext4_insert_dentry(struct inode *inode,
 			struct ext4_filename *fname);
 static inline void ext4_update_dx_flag(struct inode *inode)
 {
-	if (!ext4_has_feature_dir_index(inode->i_sb))
+	if (!ext4_has_feature_dir_index(inode_sb(inode)))
 		ext4_clear_inode_flag(inode, EXT4_INODE_INDEX);
 }
 static const unsigned char ext4_filetype_table[] = {
@@ -2924,7 +2924,7 @@ static inline void ext4_unlock_group(struct super_block *sb,
 #define ext4_check_indirect_blockref(inode, bh)				\
 	ext4_check_blockref(__func__, __LINE__, inode,			\
 			    (__le32 *)(bh)->b_data,			\
-			    EXT4_ADDR_PER_BLOCK((inode)->i_sb))
+			    EXT4_ADDR_PER_BLOCK(inode_sb((inode))))
 
 #define ext4_ind_check_inode(inode)					\
 	ext4_check_blockref(__func__, __LINE__, inode,			\
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 2d593201cf7a..151323c6844b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -207,7 +207,7 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	jbd_debug(4, "forgetting bh %p: is_metadata = %d, mode %o, "
 		  "data mode %x\n",
 		  bh, is_metadata, inode->i_mode,
-		  test_opt(inode->i_sb, DATA_FLAGS));
+		  test_opt(inode_sb(inode), DATA_FLAGS));
 
 	/* In the no journal case, we can just do a bforget and return */
 	if (!ext4_handle_valid(handle)) {
@@ -220,7 +220,7 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	 * support it.  Otherwise, only skip the revoke on un-journaled
 	 * data blocks. */
 
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	if (test_opt(inode_sb(inode), DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (!is_metadata && !ext4_should_journal_data(inode))) {
 		if (bh) {
 			BUFFER_TRACE(bh, "call jbd2_journal_forget");
@@ -241,8 +241,8 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	if (err) {
 		ext4_journal_abort_handle(where, line, __func__,
 					  bh, handle, err);
-		__ext4_abort(inode->i_sb, where, line,
-			   "error %d when attempting revoke", err);
+		__ext4_abort(inode_sb(inode), where, line,
+			     "error %d when attempting revoke", err);
 	}
 	BUFFER_TRACE(bh, "exit");
 	return err;
@@ -308,7 +308,7 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 			if (buffer_req(bh) && !buffer_uptodate(bh)) {
 				struct ext4_super_block *es;
 
-				es = EXT4_SB(inode->i_sb)->s_es;
+				es = EXT4_SB(inode_sb(inode))->s_es;
 				es->s_last_error_block =
 					cpu_to_le64(bh->b_blocknr);
 				ext4_error_inode(inode, where, line,
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 15b6dd733780..029cfddd9035 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -16,7 +16,7 @@
 #include <linux/jbd2.h>
 #include "ext4.h"
 
-#define EXT4_JOURNAL(inode)	(EXT4_SB((inode)->i_sb)->s_journal)
+#define EXT4_JOURNAL(inode)	(EXT4_SB(inode_sb((inode)))->s_journal)
 
 /* Define the number of blocks we need to account to a transaction to
  * modify one block of data.
@@ -308,7 +308,7 @@ static inline handle_t *__ext4_journal_start(struct inode *inode,
 					     unsigned int line, int type,
 					     int blocks, int rsv_blocks)
 {
-	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
+	return __ext4_journal_start_sb(inode_sb(inode), line, type, blocks,
 				       rsv_blocks);
 }
 
@@ -407,17 +407,17 @@ static inline int ext4_inode_journal_mode(struct inode *inode)
 		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
 	/* We do not support data journalling with delayed allocation */
 	if (!S_ISREG(inode->i_mode) ||
-	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    test_opt(inode_sb(inode), DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC))) {
+	    !test_opt(inode_sb(inode), DELALLOC))) {
 		/* We do not support data journalling for encrypted data */
 		if (S_ISREG(inode->i_mode) && ext4_encrypted_inode(inode))
 			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
 		return EXT4_INODE_JOURNAL_DATA_MODE;	/* journal data */
 	}
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
+	if (test_opt(inode_sb(inode), DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
 		return EXT4_INODE_ORDERED_DATA_MODE;	/* ordered */
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
+	if (test_opt(inode_sb(inode), DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
 		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
 	BUG();
 }
@@ -448,7 +448,7 @@ static inline int ext4_should_writeback_data(struct inode *inode)
  */
 static inline int ext4_should_dioread_nolock(struct inode *inode)
 {
-	if (!test_opt(inode->i_sb, DIOREAD_NOLOCK))
+	if (!test_opt(inode_sb(inode), DIOREAD_NOLOCK))
 		return 0;
 	if (!S_ISREG(inode->i_mode))
 		return 0;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 054416e9d827..5001725876ef 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -49,7 +49,7 @@ static __le32 ext4_extent_block_csum(struct inode *inode,
 				     struct ext4_extent_header *eh)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	__u32 csum;
 
 	csum = ext4_chksum(sbi, ei->i_csum_seed, (__u8 *)eh,
@@ -62,7 +62,7 @@ static int ext4_extent_block_csum_verify(struct inode *inode,
 {
 	struct ext4_extent_tail *et;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return 1;
 
 	et = find_ext4_extent_tail(eh);
@@ -76,7 +76,7 @@ static void ext4_extent_block_csum_set(struct inode *inode,
 {
 	struct ext4_extent_tail *et;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return;
 
 	et = find_ext4_extent_tail(eh);
@@ -233,7 +233,7 @@ static inline int ext4_ext_space_block(struct inode *inode, int check)
 {
 	int size;
 
-	size = (inode->i_sb->s_blocksize - sizeof(struct ext4_extent_header))
+	size = (inode_sb(inode)->s_blocksize - sizeof(struct ext4_extent_header))
 			/ sizeof(struct ext4_extent);
 #ifdef AGGRESSIVE_TEST
 	if (!check && size > 6)
@@ -246,7 +246,7 @@ static inline int ext4_ext_space_block_idx(struct inode *inode, int check)
 {
 	int size;
 
-	size = (inode->i_sb->s_blocksize - sizeof(struct ext4_extent_header))
+	size = (inode_sb(inode)->s_blocksize - sizeof(struct ext4_extent_header))
 			/ sizeof(struct ext4_extent_idx);
 #ifdef AGGRESSIVE_TEST
 	if (!check && size > 5)
@@ -307,7 +307,7 @@ int ext4_ext_calc_metadata_amount(struct inode *inode, ext4_lblk_t lblock)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int idxs;
 
-	idxs = ((inode->i_sb->s_blocksize - sizeof(struct ext4_extent_header))
+	idxs = ((inode_sb(inode)->s_blocksize - sizeof(struct ext4_extent_header))
 		/ sizeof(struct ext4_extent_idx));
 
 	/*
@@ -377,7 +377,7 @@ static int ext4_valid_extent(struct inode *inode, struct ext4_extent *ext)
 	 */
 	if (lblock + len <= lblock)
 		return 0;
-	return ext4_data_block_valid(EXT4_SB(inode->i_sb), block, len);
+	return ext4_data_block_valid(EXT4_SB(inode_sb(inode)), block, len);
 }
 
 static int ext4_valid_extent_idx(struct inode *inode,
@@ -385,7 +385,7 @@ static int ext4_valid_extent_idx(struct inode *inode,
 {
 	ext4_fsblk_t block = ext4_idx_pblock(ext_idx);
 
-	return ext4_data_block_valid(EXT4_SB(inode->i_sb), block, 1);
+	return ext4_data_block_valid(EXT4_SB(inode_sb(inode)), block, 1);
 }
 
 static int ext4_valid_extent_entries(struct inode *inode,
@@ -401,7 +401,7 @@ static int ext4_valid_extent_entries(struct inode *inode,
 	if (depth == 0) {
 		/* leaf entries */
 		struct ext4_extent *ext = EXT_FIRST_EXTENT(eh);
-		struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
+		struct ext4_super_block *es = EXT4_SB(inode_sb(inode))->s_es;
 		ext4_fsblk_t pblock = 0;
 		ext4_lblk_t lblock = 0;
 		ext4_lblk_t prev = 0;
@@ -506,7 +506,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	struct buffer_head		*bh;
 	int				err;
 
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode_sb(inode), pblk, __GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
@@ -1000,7 +1000,7 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 	}
 
 	err = ext4_ext_dirty(handle, inode, curp);
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 
 	return err;
 }
@@ -1084,7 +1084,8 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		err = -EFSCORRUPTED;
 		goto cleanup;
 	}
-	bh = sb_getblk_gfp(inode->i_sb, newblock, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode_sb(inode), newblock,
+			   __GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh)) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -1157,7 +1158,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	while (k--) {
 		oldblock = newblock;
 		newblock = ablocks[--a];
-		bh = sb_getblk(inode->i_sb, newblock);
+		bh = sb_getblk(inode_sb(inode), newblock);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			goto cleanup;
@@ -1262,7 +1263,7 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 	struct ext4_extent_header *neh;
 	struct buffer_head *bh;
 	ext4_fsblk_t newblock, goal = 0;
-	struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
+	struct ext4_super_block *es = EXT4_SB(inode_sb(inode))->s_es;
 	int err = 0;
 
 	/* Try to prepend new index to old one */
@@ -1278,7 +1279,8 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 	if (newblock == 0)
 		return err;
 
-	bh = sb_getblk_gfp(inode->i_sb, newblock, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode_sb(inode), newblock,
+			   __GFP_MOVABLE | GFP_NOFS);
 	if (unlikely(!bh))
 		return -ENOMEM;
 	lock_buffer(bh);
@@ -2154,7 +2156,7 @@ static int ext4_fill_fiemap_extents(struct inode *inode,
 	ext4_lblk_t last = block + num;
 	int exists, depth = 0, err = 0;
 	unsigned int flags = 0;
-	unsigned char blksize_bits = inode->i_sb->s_blocksize_bits;
+	unsigned char blksize_bits = inode_sb(inode)->s_blocksize_bits;
 
 	while (block < last && block != EXT_MAX_BLOCKS) {
 		num = last - block;
@@ -2438,7 +2440,7 @@ int ext4_ext_calc_credits_for_single_extent(struct inode *inode, int nrblocks,
 			 *  accounted.
 			 */
 			/* 1 bitmap, 1 block group descriptor */
-			ret = 2 + EXT4_META_TRANS_BLOCKS(inode->i_sb);
+			ret = 2 + EXT4_META_TRANS_BLOCKS(inode_sb(inode));
 			return ret;
 		}
 	}
@@ -2489,7 +2491,7 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 			      long long *partial_cluster,
 			      ext4_lblk_t from, ext4_lblk_t to)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	unsigned short ee_len = ext4_ext_get_actual_len(ex);
 	ext4_fsblk_t pblk;
 	int flags = get_default_free_blocks_flags(inode);
@@ -2520,7 +2522,7 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 
 #ifdef EXTENTS_STATS
 	{
-		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 		spin_lock(&sbi->s_ext_stats_lock);
 		sbi->s_ext_blocks += ee_len;
 		sbi->s_ext_extents++;
@@ -2605,7 +2607,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		 long long *partial_cluster,
 		 ext4_lblk_t start, ext4_lblk_t end)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	int err = 0, correct_index = 0;
 	int depth = ext_depth(inode), credits;
 	struct ext4_extent_header *eh;
@@ -2693,12 +2695,12 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		 * groups plus ex_ee_len/blocks_per_block_group for
 		 * the worst case
 		 */
-		credits = 7 + 2*(ex_ee_len/EXT4_BLOCKS_PER_GROUP(inode->i_sb));
+		credits = 7 + 2*(ex_ee_len/EXT4_BLOCKS_PER_GROUP(inode_sb(inode)));
 		if (ex == EXT_FIRST_EXTENT(eh)) {
 			correct_index = 1;
 			credits += (ext_depth(inode)) + 1;
 		}
-		credits += EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb);
+		credits += EXT4_MAXQUOTAS_TRANS_BLOCKS(inode_sb(inode));
 
 		err = ext4_ext_truncate_extend_restart(handle, inode, credits);
 		if (err)
@@ -2810,7 +2812,7 @@ ext4_ext_more_to_rm(struct ext4_ext_path *path)
 int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			  ext4_lblk_t end)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
 	long long partial_cluster = 0;
@@ -3414,9 +3416,9 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 		"block %llu, max_blocks %u\n", inode->i_ino,
 		(unsigned long long)map->m_lblk, map_len);
 
-	sbi = EXT4_SB(inode->i_sb);
-	eof_block = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
+	sbi = EXT4_SB(inode_sb(inode));
+	eof_block = (inode->i_size + inode_sb(inode)->s_blocksize - 1) >>
+		inode_sb(inode)->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map_len)
 		eof_block = map->m_lblk + map_len;
 
@@ -3561,7 +3563,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
 		max_zeroout = sbi->s_extent_max_zeroout_kb >>
-			(inode->i_sb->s_blocksize_bits - 10);
+			(inode_sb(inode)->s_blocksize_bits - 10);
 
 	if (ext4_encrypted_inode(inode))
 		max_zeroout = 0;
@@ -3671,8 +3673,8 @@ static int ext4_split_convert_extents(handle_t *handle,
 		  __func__, inode->i_ino,
 		  (unsigned long long)map->m_lblk, map->m_len);
 
-	eof_block = (inode->i_size + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
+	eof_block = (inode->i_size + inode_sb(inode)->s_blocksize - 1) >>
+		inode_sb(inode)->s_blocksize_bits;
 	if (eof_block < map->m_lblk + map->m_len)
 		eof_block = map->m_lblk + map->m_len;
 	/*
@@ -3838,7 +3840,7 @@ int ext4_find_delalloc_range(struct inode *inode,
 
 int ext4_find_delalloc_cluster(struct inode *inode, ext4_lblk_t lblk)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	ext4_lblk_t lblk_start, lblk_end;
 	lblk_start = EXT4_LBLK_CMASK(sbi, lblk);
 	lblk_end = lblk_start + sbi->s_cluster_ratio - 1;
@@ -3885,7 +3887,7 @@ static unsigned int
 get_reserved_cluster_alloc(struct inode *inode, ext4_lblk_t lblk_start,
 			   unsigned int num_blks)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	ext4_lblk_t alloc_cluster_start, alloc_cluster_end;
 	ext4_lblk_t lblk_from, lblk_to, c_offset;
 	unsigned int allocated_clusters = 0;
@@ -4096,7 +4098,8 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	 * new.
 	 */
 	if (allocated > map->m_len) {
-		clean_bdev_aliases(inode->i_sb->s_bdev, newblock + map->m_len,
+		clean_bdev_aliases(inode_sb(inode)->s_bdev,
+				   newblock + map->m_len,
 				   allocated - map->m_len);
 		allocated = map->m_len;
 	}
@@ -4263,7 +4266,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = NULL;
 	struct ext4_extent newex, *ex, *ex2;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	ext4_fsblk_t newblock = 0;
 	int free_on_err = 0, err = 0, depth, ret;
 	unsigned int allocated = 0, offset = 0;
@@ -4382,7 +4385,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * by ext4_find_extent() implies a cluster we can use.
 	 */
 	if (cluster_offset && ex &&
-	    get_implied_cluster_alloc(inode->i_sb, map, ex, path)) {
+	    get_implied_cluster_alloc(inode_sb(inode), map, ex, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		map_from_cluster = true;
@@ -4403,7 +4406,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	/* Check if the extent after searching to the right implies a
 	 * cluster we can use. */
 	if ((sbi->s_cluster_ratio > 1) && ex2 &&
-	    get_implied_cluster_alloc(inode->i_sb, map, ex2, path)) {
+	    get_implied_cluster_alloc(inode_sb(inode), map, ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
 		map_from_cluster = true;
@@ -4607,7 +4610,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 
 int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	ext4_lblk_t last_block;
 	int err = 0;
 
@@ -4716,7 +4719,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 			break;
 	}
 	if (ret == -ENOSPC &&
-			ext4_should_retry_alloc(inode->i_sb, &retries)) {
+			ext4_should_retry_alloc(inode_sb(inode), &retries)) {
 		ret = 0;
 		goto retry;
 	}
@@ -4746,7 +4749,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	/* Call ext4_force_commit to flush all data in case of data=journal. */
 	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
+		ret = ext4_force_commit(inode_sb(inode));
 		if (ret)
 			return ret;
 	}
@@ -4849,7 +4852,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	handle = ext4_journal_start(inode, EXT4_HT_MISC, credits);
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
-		ext4_std_error(inode->i_sb, ret);
+		ext4_std_error(inode_sb(inode), ret);
 		goto out_dio;
 	}
 
@@ -4972,8 +4975,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out;
 
-	if (file->f_flags & O_SYNC && EXT4_SB(inode->i_sb)->s_journal) {
-		ret = jbd2_complete_transaction(EXT4_SB(inode->i_sb)->s_journal,
+	if (file->f_flags & O_SYNC && EXT4_SB(inode_sb(inode))->s_journal) {
+		ret = jbd2_complete_transaction(EXT4_SB(inode_sb(inode))->s_journal,
 						EXT4_I(inode)->i_sync_tid);
 	}
 out:
@@ -5035,7 +5038,7 @@ int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
 		ret = ext4_map_blocks(handle, inode, &map,
 				      EXT4_GET_BLOCKS_IO_CONVERT_EXT);
 		if (ret <= 0)
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "inode #%lu: block %u: len %u: "
 				     "ext4_ext_map_blocks returned %d",
 				     inode->i_ino, map.m_lblk,
@@ -5106,7 +5109,7 @@ static int ext4_xattr_fiemap(struct inode *inode,
 	__u64 physical = 0;
 	__u64 length;
 	__u32 flags = FIEMAP_EXTENT_LAST;
-	int blockbits = inode->i_sb->s_blocksize_bits;
+	int blockbits = inode_sb(inode)->s_blocksize_bits;
 	int error = 0;
 
 	/* in-inode? */
@@ -5121,12 +5124,12 @@ static int ext4_xattr_fiemap(struct inode *inode,
 		offset = EXT4_GOOD_OLD_INODE_SIZE +
 				EXT4_I(inode)->i_extra_isize;
 		physical += offset;
-		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
+		length = EXT4_SB(inode_sb(inode))->s_inode_size - offset;
 		flags |= FIEMAP_EXTENT_DATA_INLINE;
 		brelse(iloc.bh);
 	} else { /* external block */
 		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
-		length = inode->i_sb->s_blocksize;
+		length = inode_sb(inode)->s_blocksize;
 	}
 
 	if (physical)
@@ -5171,8 +5174,8 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		ext4_lblk_t len_blks;
 		__u64 last_blk;
 
-		start_blk = start >> inode->i_sb->s_blocksize_bits;
-		last_blk = (start + len - 1) >> inode->i_sb->s_blocksize_bits;
+		start_blk = start >> inode_sb(inode)->s_blocksize_bits;
+		last_blk = (start + len - 1) >> inode_sb(inode)->s_blocksize_bits;
 		if (last_blk >= EXT_MAX_BLOCKS)
 			last_blk = EXT_MAX_BLOCKS-1;
 		len_blks = ((ext4_lblk_t) last_blk) - start_blk + 1;
@@ -5433,7 +5436,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
  */
 int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	ext4_lblk_t punch_start, punch_stop;
 	handle_t *handle;
 	unsigned int credits;
@@ -5463,7 +5466,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Call ext4_force_commit to flush all data in case of data=journal. */
 	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
+		ret = ext4_force_commit(inode_sb(inode));
 		if (ret)
 			return ret;
 	}
@@ -5578,7 +5581,7 @@ int ext4_collapse_range(struct inode *inode, loff_t offset, loff_t len)
  */
 int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	handle_t *handle;
 	struct ext4_ext_path *path;
 	struct ext4_extent *extent;
@@ -5610,7 +5613,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* Call ext4_force_commit to flush all data in case of data=journal */
 	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
+		ret = ext4_force_commit(inode_sb(inode));
 		if (ret)
 			return ret;
 	}
@@ -5623,7 +5626,7 @@ int ext4_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	}
 
 	/* Check for wrap through zero */
-	if (inode->i_size + len > inode->i_sb->s_maxbytes) {
+	if (inode->i_size + len > inode_sb(inode)->s_maxbytes) {
 		ret = -EFBIG;
 		goto out_mutex;
 	}
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 763ef185dd17..56c59000c9cc 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -299,7 +299,7 @@ void ext4_es_find_delayed_extent_range(struct inode *inode,
 static void ext4_es_list_add(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 
 	if (!list_empty(&ei->i_es_list))
 		return;
@@ -315,7 +315,7 @@ static void ext4_es_list_add(struct inode *inode)
 static void ext4_es_list_del(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 
 	spin_lock(&sbi->s_es_lock);
 	if (!list_empty(&ei->i_es_list)) {
@@ -344,12 +344,12 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 	if (!ext4_es_is_delayed(es)) {
 		if (!EXT4_I(inode)->i_es_shk_nr++)
 			ext4_es_list_add(inode);
-		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
+		percpu_counter_inc(&EXT4_SB(inode_sb(inode))->
 					s_es_stats.es_stats_shk_cnt);
 	}
 
 	EXT4_I(inode)->i_es_all_nr++;
-	percpu_counter_inc(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
+	percpu_counter_inc(&EXT4_SB(inode_sb(inode))->s_es_stats.es_stats_all_cnt);
 
 	return es;
 }
@@ -357,14 +357,14 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 {
 	EXT4_I(inode)->i_es_all_nr--;
-	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
+	percpu_counter_dec(&EXT4_SB(inode_sb(inode))->s_es_stats.es_stats_all_cnt);
 
 	/* Decrease the shrink counter when this es is not delayed */
 	if (!ext4_es_is_delayed(es)) {
 		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
 		if (!--EXT4_I(inode)->i_es_shk_nr)
 			ext4_es_list_del(inode);
-		percpu_counter_dec(&EXT4_SB(inode->i_sb)->
+		percpu_counter_dec(&EXT4_SB(inode_sb(inode))->
 					s_es_stats.es_stats_shk_cnt);
 	}
 
@@ -706,7 +706,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	if ((status & EXTENT_STATUS_DELAYED) &&
 	    (status & EXTENT_STATUS_WRITTEN)) {
-		ext4_warning(inode->i_sb, "Inserting extent [%u/%u] as "
+		ext4_warning(inode_sb(inode), "Inserting extent [%u/%u] as "
 				" delayed and written which can potentially "
 				" cause data loss.", lblk, len);
 		WARN_ON(1);
@@ -725,7 +725,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto error;
 retry:
 	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
+	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode_sb(inode)),
 					  128, EXT4_I(inode)))
 		goto retry;
 	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
@@ -818,7 +818,7 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 
 out:
-	stats = &EXT4_SB(inode->i_sb)->s_es_stats;
+	stats = &EXT4_SB(inode_sb(inode))->s_es_stats;
 	if (found) {
 		BUG_ON(!es1);
 		es->es_lblk = es1->es_lblk;
@@ -885,7 +885,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
 				if ((err == -ENOMEM) &&
-				    __es_shrink(EXT4_SB(inode->i_sb),
+				    __es_shrink(EXT4_SB(inode_sb(inode)),
 							128, EXT4_I(inode)))
 					goto retry;
 				goto out;
@@ -1244,7 +1244,8 @@ static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan)
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_EXT_PRECACHED) &&
 	    __ratelimit(&_rs))
-		ext4_warning(inode->i_sb, "forced shrink of precached extents");
+		ext4_warning(inode_sb(inode),
+			     "forced shrink of precached extents");
 
 	if (!es_do_reclaim_extents(ei, EXT_MAX_BLOCKS, nr_to_scan, &nr_shrunk) &&
 	    start != 0)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index fb6f023622fe..d6547085f4d2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -64,7 +64,7 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(file_inode(iocb->ki_filp))))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
@@ -122,7 +122,7 @@ static void ext4_unwritten_wait(struct inode *inode)
 static int
 ext4_unaligned_aio(struct inode *inode, struct iov_iter *from, loff_t pos)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int blockmask = sb->s_blocksize - 1;
 
 	if (pos >= i_size_read(inode))
@@ -170,7 +170,7 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	 * is smaller than s_maxbytes, which is for extent-mapped files.
 	 */
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 
 		if (iocb->ki_pos >= sbi->s_bitmap_maxbytes)
 			return -EFBIG;
@@ -219,7 +219,7 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	int overwrite = 0;
 	ssize_t ret;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 #ifdef CONFIG_FS_DAX
@@ -284,7 +284,7 @@ static int ext4_dax_huge_fault(struct vm_fault *vmf,
 	int retries = 0;
 	handle_t *handle = NULL;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	/*
 	 * We have to distinguish real writes from writes which will result in a
@@ -360,7 +360,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_mapping->host;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	/*
@@ -382,14 +382,14 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 static int ext4_file_open(struct inode * inode, struct file * filp)
 {
-	struct super_block *sb = inode->i_sb;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct super_block *sb = inode_sb(inode);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct vfsmount *mnt = filp->f_path.mnt;
 	struct path path;
 	char buf[64], *cp;
 	int ret;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	if (unlikely(!(sbi->s_mount_flags & EXT4_MF_MNTDIR_SAMPLED) &&
@@ -454,9 +454,9 @@ loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 	loff_t maxbytes;
 
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+		maxbytes = EXT4_SB(inode_sb(inode))->s_bitmap_maxbytes;
 	else
-		maxbytes = inode->i_sb->s_maxbytes;
+		maxbytes = inode_sb(inode)->s_maxbytes;
 
 	switch (whence) {
 	default:
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 26a7fe5c4fd3..ad5a1fff59ec 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -96,22 +96,22 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	journal_t *journal = EXT4_SB(inode_sb(inode))->s_journal;
 	int ret = 0, err;
 	tid_t commit_tid;
 	bool needs_barrier = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	J_ASSERT(ext4_journal_current_handle() == NULL);
 
 	trace_ext4_sync_file_enter(file, datasync);
 
-	if (sb_rdonly(inode->i_sb)) {
+	if (sb_rdonly(inode_sb(inode))) {
 		/* Make sure that we read updated s_mount_flags value */
 		smp_rmb();
-		if (EXT4_SB(inode->i_sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+		if (EXT4_SB(inode_sb(inode))->s_mount_flags & EXT4_MF_FS_ABORTED)
 			ret = -EROFS;
 		goto out;
 	}
@@ -120,7 +120,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		ret = __generic_file_fsync(file, start, end, datasync);
 		if (!ret)
 			ret = ext4_sync_parent(inode);
-		if (test_opt(inode->i_sb, BARRIER))
+		if (test_opt(inode_sb(inode), BARRIER))
 			goto issue_flush;
 		goto out;
 	}
@@ -143,7 +143,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
 	if (ext4_should_journal_data(inode)) {
-		ret = ext4_force_commit(inode->i_sb);
+		ret = ext4_force_commit(inode_sb(inode));
 		goto out;
 	}
 
@@ -154,7 +154,8 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	ret = jbd2_complete_transaction(journal, commit_tid);
 	if (needs_barrier) {
 	issue_flush:
-		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
+		err = blkdev_issue_flush(inode_sb(inode)->s_bdev, GFP_KERNEL,
+					 NULL);
 		if (!ret)
 			ret = err;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7830d28df331..95b8d6077faf 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -255,7 +255,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
  */
 void ext4_free_inode(handle_t *handle, struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int is_directory;
 	unsigned long ino;
 	struct buffer_head *bitmap_bh = NULL;
@@ -795,7 +795,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	if (!dir || !dir->i_nlink)
 		return ERR_PTR(-EPERM);
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	sbi = EXT4_SB(sb);
 
 	if (unlikely(ext4_forced_shutdown(sbi)))
@@ -953,7 +953,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 
 		if (!handle) {
 			BUG_ON(nblocks <= 0);
-			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
+			handle = __ext4_journal_start_sb(inode_sb(dir),
+							 line_no,
 							 handle_type, nblocks,
 							 0);
 			if (IS_ERR(handle)) {
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index c32802c956d5..8725e486df18 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -58,7 +58,7 @@ static inline void add_chain(Indirect *p, struct buffer_head *bh, __le32 *v)
  *
  *	Note: function doesn't find node addresses, so no IO is needed. All
  *	we need to know is the capacity of indirect blocks (taken from the
- *	inode->i_sb).
+ *	inode_sb(inode)).
  */
 
 /*
@@ -75,8 +75,8 @@ static int ext4_block_to_path(struct inode *inode,
 			      ext4_lblk_t i_block,
 			      ext4_lblk_t offsets[4], int *boundary)
 {
-	int ptrs = EXT4_ADDR_PER_BLOCK(inode->i_sb);
-	int ptrs_bits = EXT4_ADDR_PER_BLOCK_BITS(inode->i_sb);
+	int ptrs = EXT4_ADDR_PER_BLOCK(inode_sb(inode));
+	int ptrs_bits = EXT4_ADDR_PER_BLOCK_BITS(inode_sb(inode));
 	const long direct_blocks = EXT4_NDIR_BLOCKS,
 		indirect_blocks = ptrs,
 		double_blocks = (1 << (ptrs_bits * 2));
@@ -102,7 +102,7 @@ static int ext4_block_to_path(struct inode *inode,
 		offsets[n++] = i_block & (ptrs - 1);
 		final = ptrs;
 	} else {
-		ext4_warning(inode->i_sb, "block %lu > max in inode %lu",
+		ext4_warning(inode_sb(inode), "block %lu > max in inode %lu",
 			     i_block + direct_blocks +
 			     indirect_blocks + double_blocks, inode->i_ino);
 	}
@@ -145,7 +145,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 				 ext4_lblk_t  *offsets,
 				 Indirect chain[4], int *err)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	Indirect *p = chain;
 	struct buffer_head *bh;
 	int ret = -EIO;
@@ -346,7 +346,8 @@ static int ext4_alloc_branch(handle_t *handle,
 		if (i == 0)
 			continue;
 
-		bh = branch[i].bh = sb_getblk(ar->inode->i_sb, new_blocks[i-1]);
+		bh = branch[i].bh = sb_getblk(inode_sb(ar->inode),
+					      new_blocks[i-1]);
 		if (unlikely(!bh)) {
 			err = -ENOMEM;
 			goto failed;
@@ -558,7 +559,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 
 	/* Next simple case - plain lookup failed */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		unsigned epb = inode->i_sb->s_blocksize / sizeof(u32);
+		unsigned epb = inode_sb(inode)->s_blocksize / sizeof(u32);
 		int i;
 
 		/* Count number blocks in a subtree under 'partial' */
@@ -578,7 +579,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	/*
 	 * Okay, we need to do block allocation.
 	*/
-	if (ext4_has_feature_bigalloc(inode->i_sb)) {
+	if (ext4_has_feature_bigalloc(inode_sb(inode))) {
 		EXT4_ERROR_INODE(inode, "Can't allocate blocks for "
 				 "non-extent mapped inodes with bigalloc");
 		return -EFSCORRUPTED;
@@ -656,7 +657,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 int ext4_ind_calc_metadata_amount(struct inode *inode, sector_t lblock)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	sector_t dind_mask = ~((sector_t)EXT4_ADDR_PER_BLOCK(inode->i_sb) - 1);
+	sector_t dind_mask = ~((sector_t)EXT4_ADDR_PER_BLOCK(inode_sb(inode)) - 1);
 	int blk_bits;
 
 	if (lblock < EXT4_NDIR_BLOCKS)
@@ -672,7 +673,7 @@ int ext4_ind_calc_metadata_amount(struct inode *inode, sector_t lblock)
 	ei->i_da_metadata_calc_last_lblock = lblock & dind_mask;
 	ei->i_da_metadata_calc_len = 1;
 	blk_bits = order_base_2(lblock);
-	return (blk_bits / EXT4_ADDR_PER_BLOCK_BITS(inode->i_sb)) + 1;
+	return (blk_bits / EXT4_ADDR_PER_BLOCK_BITS(inode_sb(inode))) + 1;
 }
 
 /*
@@ -683,10 +684,10 @@ int ext4_ind_trans_blocks(struct inode *inode, int nrblocks)
 {
 	/*
 	 * With N contiguous data blocks, we need at most
-	 * N/EXT4_ADDR_PER_BLOCK(inode->i_sb) + 1 indirect blocks,
+	 * N/EXT4_ADDR_PER_BLOCK(inode_sb(inode)) + 1 indirect blocks,
 	 * 2 dindirect blocks, and 1 tindirect block
 	 */
-	return DIV_ROUND_UP(nrblocks, EXT4_ADDR_PER_BLOCK(inode->i_sb)) + 4;
+	return DIV_ROUND_UP(nrblocks, EXT4_ADDR_PER_BLOCK(inode_sb(inode))) + 4;
 }
 
 /*
@@ -836,7 +837,7 @@ static int ext4_clear_blocks(handle_t *handle, struct inode *inode,
 	else if (ext4_should_journal_data(inode))
 		flags |= EXT4_FREE_BLOCKS_FORGET;
 
-	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), block_to_free,
+	if (!ext4_data_block_valid(EXT4_SB(inode_sb(inode)), block_to_free,
 				   count)) {
 		EXT4_ERROR_INODE(inode, "attempt to clear invalid "
 				 "blocks %llu len %lu",
@@ -872,7 +873,7 @@ static int ext4_clear_blocks(handle_t *handle, struct inode *inode,
 	ext4_free_blocks(handle, inode, NULL, block_to_free, count, flags);
 	return 0;
 out_err:
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 	return err;
 }
 
@@ -992,14 +993,14 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 
 	if (depth--) {
 		struct buffer_head *bh;
-		int addr_per_block = EXT4_ADDR_PER_BLOCK(inode->i_sb);
+		int addr_per_block = EXT4_ADDR_PER_BLOCK(inode_sb(inode));
 		p = last;
 		while (--p >= first) {
 			nr = le32_to_cpu(*p);
 			if (!nr)
 				continue;		/* A hole */
 
-			if (!ext4_data_block_valid(EXT4_SB(inode->i_sb),
+			if (!ext4_data_block_valid(EXT4_SB(inode_sb(inode)),
 						   nr, 1)) {
 				EXT4_ERROR_INODE(inode,
 						 "invalid indirect mapped "
@@ -1009,7 +1010,7 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			}
 
 			/* Go read the buffer for the next level down */
-			bh = sb_bread(inode->i_sb, nr);
+			bh = sb_bread(inode_sb(inode), nr);
 
 			/*
 			 * A read failure? Report error and clear slot
@@ -1096,19 +1097,19 @@ void ext4_ind_truncate(handle_t *handle, struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	__le32 *i_data = ei->i_data;
-	int addr_per_block = EXT4_ADDR_PER_BLOCK(inode->i_sb);
+	int addr_per_block = EXT4_ADDR_PER_BLOCK(inode_sb(inode));
 	ext4_lblk_t offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
 	__le32 nr = 0;
 	int n = 0;
 	ext4_lblk_t last_block, max_block;
-	unsigned blocksize = inode->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(inode)->s_blocksize;
 
 	last_block = (inode->i_size + blocksize-1)
-					>> EXT4_BLOCK_SIZE_BITS(inode->i_sb);
-	max_block = (EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1)
-					>> EXT4_BLOCK_SIZE_BITS(inode->i_sb);
+					>> EXT4_BLOCK_SIZE_BITS(inode_sb(inode));
+	max_block = (EXT4_SB(inode_sb(inode))->s_bitmap_maxbytes + blocksize-1)
+					>> EXT4_BLOCK_SIZE_BITS(inode_sb(inode));
 
 	if (last_block != max_block) {
 		n = ext4_block_to_path(inode, last_block, offsets, NULL);
@@ -1209,17 +1210,17 @@ int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	__le32 *i_data = ei->i_data;
-	int addr_per_block = EXT4_ADDR_PER_BLOCK(inode->i_sb);
+	int addr_per_block = EXT4_ADDR_PER_BLOCK(inode_sb(inode));
 	ext4_lblk_t offsets[4], offsets2[4];
 	Indirect chain[4], chain2[4];
 	Indirect *partial, *partial2;
 	ext4_lblk_t max_block;
 	__le32 nr = 0, nr2 = 0;
 	int n = 0, n2 = 0;
-	unsigned blocksize = inode->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(inode)->s_blocksize;
 
-	max_block = (EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1)
-					>> EXT4_BLOCK_SIZE_BITS(inode->i_sb);
+	max_block = (EXT4_SB(inode_sb(inode))->s_bitmap_maxbytes + blocksize-1)
+					>> EXT4_BLOCK_SIZE_BITS(inode_sb(inode));
 	if (end >= max_block)
 		end = max_block;
 	if ((start >= end) || (start > max_block))
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 70cf4c7b268a..efd245dccae1 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -34,7 +34,7 @@ static int get_max_inline_xattr_value_size(struct inode *inode,
 	struct ext4_inode *raw_inode;
 	int free, min_offs;
 
-	min_offs = EXT4_SB(inode->i_sb)->s_inode_size -
+	min_offs = EXT4_SB(inode_sb(inode))->s_inode_size -
 			EXT4_GOOD_OLD_INODE_SIZE -
 			EXT4_I(inode)->i_extra_isize -
 			sizeof(struct ext4_xattr_ibody_header);
@@ -209,7 +209,7 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 	struct ext4_inode *raw_inode;
 	int cp_len = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
@@ -432,7 +432,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	memset((void *)ext4_raw_inode(&is.iloc)->i_block,
 		0, EXT4_MIN_INLINE_DATA_SIZE);
 
-	if (ext4_has_feature_extents(inode->i_sb)) {
+	if (ext4_has_feature_extents(inode_sb(inode))) {
 		if (S_ISDIR(inode->i_mode) ||
 		    S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) {
 			ext4_set_inode_flag(inode, EXT4_INODE_EXTENTS);
@@ -466,7 +466,8 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 	BUG_ON(page->index);
 
 	if (!EXT4_I(inode)->i_inline_off) {
-		ext4_warning(inode->i_sb, "inode %lu doesn't have inline data.",
+		ext4_warning(inode_sb(inode),
+			     "inode %lu doesn't have inline data.",
 			     inode->i_ino);
 		goto out;
 	}
@@ -611,7 +612,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 			ext4_orphan_del(NULL, inode);
 	}
 
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode_sb(inode), &retries))
 		goto retry;
 
 	if (page)
@@ -728,7 +729,7 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret) {
-		ext4_std_error(inode->i_sb, ret);
+		ext4_std_error(inode_sb(inode), ret);
 		copied = 0;
 		goto out;
 	}
@@ -760,7 +761,7 @@ ext4_journalled_write_inline_data(struct inode *inode,
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret) {
-		ext4_std_error(inode->i_sb, ret);
+		ext4_std_error(inode_sb(inode), ret);
 		return NULL;
 	}
 
@@ -886,7 +887,7 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 							    fsdata);
 		ext4_journal_stop(handle);
 		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		    ext4_should_retry_alloc(inode_sb(inode), &retries))
 			goto retry_journal;
 		goto out;
 	}
@@ -1128,27 +1129,27 @@ static int ext4_finish_convert_inline_dir(handle_t *handle,
 	 */
 	de = (struct ext4_dir_entry_2 *)target;
 	de = ext4_init_dot_dotdot(inode, de,
-		inode->i_sb->s_blocksize, csum_size,
+		inode_sb(inode)->s_blocksize, csum_size,
 		le32_to_cpu(((struct ext4_dir_entry_2 *)buf)->inode), 1);
 	header_size = (void *)de - target;
 
 	memcpy((void *)de, buf + EXT4_INLINE_DOTDOT_SIZE,
 		inline_size - EXT4_INLINE_DOTDOT_SIZE);
 
-	if (ext4_has_metadata_csum(inode->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(inode)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
-	inode->i_size = inode->i_sb->s_blocksize;
-	i_size_write(inode, inode->i_sb->s_blocksize);
-	EXT4_I(inode)->i_disksize = inode->i_sb->s_blocksize;
+	inode->i_size = inode_sb(inode)->s_blocksize;
+	i_size_write(inode, inode_sb(inode)->s_blocksize);
+	EXT4_I(inode)->i_disksize = inode_sb(inode)->s_blocksize;
 	ext4_update_final_de(dir_block->b_data,
 			inline_size - EXT4_INLINE_DOTDOT_SIZE + header_size,
-			inode->i_sb->s_blocksize - csum_size);
+			inode_sb(inode)->s_blocksize - csum_size);
 
 	if (csum_size) {
 		t = EXT4_DIRENT_TAIL(dir_block->b_data,
-				     inode->i_sb->s_blocksize);
-		initialize_dirent_tail(t, inode->i_sb->s_blocksize);
+				     inode_sb(inode)->s_blocksize);
+		initialize_dirent_tail(t, inode_sb(inode)->s_blocksize);
 	}
 	set_buffer_uptodate(dir_block);
 	err = ext4_handle_dirty_dirent_node(handle, inode, dir_block);
@@ -1206,7 +1207,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 		goto out_restore;
 	}
 
-	data_bh = sb_getblk(inode->i_sb, map.m_pblk);
+	data_bh = sb_getblk(inode_sb(inode), map.m_pblk);
 	if (!data_bh) {
 		error = -ENOMEM;
 		goto out_restore;
@@ -1219,7 +1220,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 		error = -EIO;
 		goto out_restore;
 	}
-	memset(data_bh->b_data, 0, inode->i_sb->s_blocksize);
+	memset(data_bh->b_data, 0, inode_sb(inode)->s_blocksize);
 
 	if (!S_ISDIR(inode->i_mode)) {
 		memcpy(data_bh->b_data, buf, inline_size);
@@ -1370,7 +1371,7 @@ int htree_inlinedir_to_tree(struct file *dir_file,
 			fake.rec_len = ext4_rec_len_to_disk(
 						EXT4_DIR_REC_LEN(fake.name_len),
 						inline_size);
-			ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
+			ext4_set_de_type(inode_sb(inode), &fake, S_IFDIR);
 			de = &fake;
 			pos = EXT4_INLINE_DOTDOT_OFFSET;
 		} else if (pos == EXT4_INLINE_DOTDOT_OFFSET) {
@@ -1380,7 +1381,7 @@ int htree_inlinedir_to_tree(struct file *dir_file,
 			fake.rec_len = ext4_rec_len_to_disk(
 						EXT4_DIR_REC_LEN(fake.name_len),
 						inline_size);
-			ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
+			ext4_set_de_type(inode_sb(inode), &fake, S_IFDIR);
 			de = &fake;
 			pos = EXT4_INLINE_DOTDOT_SIZE;
 		} else {
@@ -1465,7 +1466,7 @@ int ext4_read_inline_dir(struct file *file,
 		goto out;
 
 	ret = 0;
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	parent_ino = le32_to_cpu(((struct ext4_dir_entry_2 *)dir_buf)->inode);
 	offset = ctx->pos;
 
@@ -1706,7 +1707,7 @@ int ext4_delete_inline_entry(handle_t *handle,
 		err = ext4_mark_inode_dirty(handle, dir);
 	brelse(iloc.bh);
 	if (err != -ENOENT)
-		ext4_std_error(dir->i_sb, err);
+		ext4_std_error(inode_sb(dir), err);
 	return err;
 }
 
@@ -1763,7 +1764,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 
 	de = (struct ext4_dir_entry_2 *)ext4_raw_inode(&iloc)->i_block;
 	if (!le32_to_cpu(de->inode)) {
-		ext4_warning(dir->i_sb,
+		ext4_warning(inode_sb(dir),
 			     "bad inline directory (dir #%lu) - no `..'",
 			     dir->i_ino);
 		ret = true;
@@ -1777,7 +1778,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 		if (ext4_check_dir_entry(dir, NULL, de,
 					 iloc.bh, inline_pos,
 					 inline_size, offset)) {
-			ext4_warning(dir->i_sb,
+			ext4_warning(inode_sb(dir),
 				     "bad inline directory (dir #%lu) - "
 				     "inode %u, rec_len %u, name_len %d"
 				     "inline size %d",
@@ -1825,7 +1826,7 @@ int ext4_inline_data_iomap(struct inode *inode, struct iomap *iomap)
 	if (error)
 		goto out;
 
-	addr = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
+	addr = (__u64)iloc.bh->b_blocknr << inode_sb(inode)->s_blocksize_bits;
 	addr += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
 	addr += offsetof(struct ext4_inode, i_block);
 
@@ -1871,7 +1872,7 @@ int ext4_inline_data_fiemap(struct inode *inode,
 	if (error)
 		goto out;
 
-	physical = (__u64)iloc.bh->b_blocknr << inode->i_sb->s_blocksize_bits;
+	physical = (__u64)iloc.bh->b_blocknr << inode_sb(inode)->s_blocksize_bits;
 	physical += (char *)ext4_raw_inode(&iloc) - iloc.bh->b_data;
 	physical += offsetof(struct ext4_inode, i_block);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c94780075b04..89e91fec7cc9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -53,7 +53,7 @@
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	__u32 csum;
 	__u16 dummy_csum = 0;
 	int offset = offsetof(struct ext4_inode, i_checksum_lo);
@@ -65,7 +65,7 @@ static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 	csum = ext4_chksum(sbi, csum, (__u8 *)raw + offset,
 			   EXT4_GOOD_OLD_INODE_SIZE - offset);
 
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE) {
 		offset = offsetof(struct ext4_inode, i_checksum_hi);
 		csum = ext4_chksum(sbi, csum, (__u8 *)raw +
 				   EXT4_GOOD_OLD_INODE_SIZE,
@@ -76,7 +76,7 @@ static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			offset += csum_size;
 		}
 		csum = ext4_chksum(sbi, csum, (__u8 *)raw + offset,
-				   EXT4_INODE_SIZE(inode->i_sb) - offset);
+				   EXT4_INODE_SIZE(inode_sb(inode)) - offset);
 	}
 
 	return csum;
@@ -87,14 +87,14 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 {
 	__u32 provided, calculated;
 
-	if (EXT4_SB(inode->i_sb)->s_es->s_creator_os !=
+	if (EXT4_SB(inode_sb(inode))->s_es->s_creator_os !=
 	    cpu_to_le32(EXT4_OS_LINUX) ||
-	    !ext4_has_metadata_csum(inode->i_sb))
+	    !ext4_has_metadata_csum(inode_sb(inode)))
 		return 1;
 
 	provided = le16_to_cpu(raw->i_checksum_lo);
 	calculated = ext4_inode_csum(inode, raw, ei);
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE &&
 	    EXT4_FITS_IN_INODE(raw, ei, i_checksum_hi))
 		provided |= ((__u32)le16_to_cpu(raw->i_checksum_hi)) << 16;
 	else
@@ -108,14 +108,14 @@ static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
 {
 	__u32 csum;
 
-	if (EXT4_SB(inode->i_sb)->s_es->s_creator_os !=
+	if (EXT4_SB(inode_sb(inode))->s_es->s_creator_os !=
 	    cpu_to_le32(EXT4_OS_LINUX) ||
-	    !ext4_has_metadata_csum(inode->i_sb))
+	    !ext4_has_metadata_csum(inode_sb(inode)))
 		return;
 
 	csum = ext4_inode_csum(inode, raw, ei);
 	raw->i_checksum_lo = cpu_to_le16(csum & 0xFFFF);
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE &&
 	    EXT4_FITS_IN_INODE(raw, ei, i_checksum_hi))
 		raw->i_checksum_hi = cpu_to_le16(csum >> 16);
 }
@@ -152,7 +152,7 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
 {
 	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
-				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
+				EXT4_CLUSTER_SIZE(inode_sb(inode)) >> 9 : 0;
 
 		if (ext4_has_inline_data(inode))
 			return 0;
@@ -224,7 +224,7 @@ void ext4_evict_inode(struct inode *inode)
 		    ext4_should_journal_data(inode) &&
 		    (S_ISLNK(inode->i_mode) || S_ISREG(inode->i_mode)) &&
 		    inode->i_data.nrpages) {
-			journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+			journal_t *journal = EXT4_SB(inode_sb(inode))->s_journal;
 			tid_t commit_tid = EXT4_I(inode)->i_datasync_tid;
 
 			jbd2_complete_transaction(journal, commit_tid);
@@ -247,22 +247,22 @@ void ext4_evict_inode(struct inode *inode)
 	 * Protect us against freezing - iput() caller didn't have to have any
 	 * protection against it
 	 */
-	sb_start_intwrite(inode->i_sb);
+	sb_start_intwrite(inode_sb(inode));
 
 	if (!IS_NOQUOTA(inode))
-		extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb);
+		extra_credits += EXT4_MAXQUOTAS_DEL_BLOCKS(inode_sb(inode));
 
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE,
 				 ext4_blocks_for_truncate(inode)+extra_credits);
 	if (IS_ERR(handle)) {
-		ext4_std_error(inode->i_sb, PTR_ERR(handle));
+		ext4_std_error(inode_sb(inode), PTR_ERR(handle));
 		/*
 		 * If we're going to skip the normal cleanup, we still need to
 		 * make sure that the in-core orphan linked list is properly
 		 * cleaned up.
 		 */
 		ext4_orphan_del(NULL, inode);
-		sb_end_intwrite(inode->i_sb);
+		sb_end_intwrite(inode_sb(inode));
 		goto no_delete;
 	}
 
@@ -281,14 +281,14 @@ void ext4_evict_inode(struct inode *inode)
 	inode->i_size = 0;
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err) {
-		ext4_warning(inode->i_sb,
+		ext4_warning(inode_sb(inode),
 			     "couldn't mark inode dirty (err %d)", err);
 		goto stop_handle;
 	}
 	if (inode->i_blocks) {
 		err = ext4_truncate(inode);
 		if (err) {
-			ext4_error(inode->i_sb,
+			ext4_error(inode_sb(inode),
 				   "couldn't truncate inode %lu (err %d)",
 				   inode->i_ino, err);
 			goto stop_handle;
@@ -299,11 +299,11 @@ void ext4_evict_inode(struct inode *inode)
 	err = ext4_xattr_delete_inode(handle, inode, &ea_inode_array,
 				      extra_credits);
 	if (err) {
-		ext4_warning(inode->i_sb, "xattr delete (err %d)", err);
+		ext4_warning(inode_sb(inode), "xattr delete (err %d)", err);
 stop_handle:
 		ext4_journal_stop(handle);
 		ext4_orphan_del(NULL, inode);
-		sb_end_intwrite(inode->i_sb);
+		sb_end_intwrite(inode_sb(inode));
 		ext4_xattr_inode_array_free(ea_inode_array);
 		goto no_delete;
 	}
@@ -332,7 +332,7 @@ void ext4_evict_inode(struct inode *inode)
 	else
 		ext4_free_inode(handle, inode);
 	ext4_journal_stop(handle);
-	sb_end_intwrite(inode->i_sb);
+	sb_end_intwrite(inode_sb(inode));
 	ext4_xattr_inode_array_free(ea_inode_array);
 	return;
 no_delete:
@@ -353,16 +353,16 @@ qsize_t *ext4_get_reserved_space(struct inode *inode)
 void ext4_da_update_reserve_space(struct inode *inode,
 					int used, int quota_claim)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
 	spin_lock(&ei->i_block_reservation_lock);
 	trace_ext4_da_update_reserve_space(inode, used, quota_claim);
 	if (unlikely(used > ei->i_reserved_data_blocks)) {
-		ext4_warning(inode->i_sb, "%s: ino %lu, used %d "
-			 "with only %d reserved data blocks",
-			 __func__, inode->i_ino, used,
-			 ei->i_reserved_data_blocks);
+		ext4_warning(inode_sb(inode), "%s: ino %lu, used %d "
+		             "with only %d reserved data blocks",
+		             __func__, inode->i_ino, used,
+		             ei->i_reserved_data_blocks);
 		WARN_ON(1);
 		used = ei->i_reserved_data_blocks;
 	}
@@ -399,7 +399,7 @@ static int __check_block_validity(struct inode *inode, const char *func,
 				unsigned int line,
 				struct ext4_map_blocks *map)
 {
-	if (!ext4_data_block_valid(EXT4_SB(inode->i_sb), map->m_pblk,
+	if (!ext4_data_block_valid(EXT4_SB(inode_sb(inode)), map->m_pblk,
 				   map->m_len)) {
 		ext4_error_inode(inode, func, line, map->m_pblk,
 				 "lblock %lu mapped to illegal pblock "
@@ -418,7 +418,7 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	if (ext4_encrypted_inode(inode))
 		return fscrypt_zeroout_range(inode, lblk, pblk, len);
 
-	ret = sb_issue_zeroout(inode->i_sb, pblk, len, GFP_NOFS);
+	ret = sb_issue_zeroout(inode_sb(inode), pblk, len, GFP_NOFS);
 	if (ret > 0)
 		ret = 0;
 
@@ -566,7 +566,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "ES len assertion failed for inode "
 				     "%lu: retval %d != map->m_len %d",
 				     inode->i_ino, retval, map->m_len);
@@ -661,7 +661,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "ES len assertion failed for inode "
 				     "%lu: retval %d != map->m_len %d",
 				     inode->i_ino, retval, map->m_len);
@@ -678,7 +678,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		if (flags & EXT4_GET_BLOCKS_ZERO &&
 		    map->m_flags & EXT4_MAP_MAPPED &&
 		    map->m_flags & EXT4_MAP_NEW) {
-			clean_bdev_aliases(inode->i_sb->s_bdev, map->m_pblk,
+			clean_bdev_aliases(inode_sb(inode)->s_bdev,
+					   map->m_pblk,
 					   map->m_len);
 			ret = ext4_issue_zeroout(inode, map->m_lblk,
 						 map->m_pblk, map->m_len);
@@ -783,13 +784,13 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
 			      flags);
 	if (ret > 0) {
-		map_bh(bh, inode->i_sb, map.m_pblk);
+		map_bh(bh, inode_sb(inode), map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
-		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
+		bh->b_size = inode_sb(inode)->s_blocksize * map.m_len;
 		ret = 0;
 	} else if (ret == 0) {
 		/* hole case, need to fill in bh->b_size */
-		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
+		bh->b_size = inode_sb(inode)->s_blocksize * map.m_len;
 	}
 	return ret;
 }
@@ -844,7 +845,7 @@ static int ext4_get_block_trans(struct inode *inode, sector_t iblock,
 	ret = _ext4_get_block(inode, iblock, bh_result, flags);
 	ext4_journal_stop(handle);
 
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode_sb(inode), &retries))
 		goto retry;
 	return ret;
 }
@@ -970,7 +971,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	bh = sb_getblk(inode->i_sb, map.m_pblk);
+	bh = sb_getblk(inode_sb(inode), map.m_pblk);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
@@ -992,7 +993,7 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 			goto errout;
 		}
 		if (!buffer_uptodate(bh)) {
-			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+			memset(bh->b_data, 0, inode_sb(inode)->s_blocksize);
 			set_buffer_uptodate(bh);
 		}
 		unlock_buffer(bh);
@@ -1160,7 +1161,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	unsigned block_start, block_end;
 	sector_t block;
 	int err = 0;
-	unsigned blocksize = inode->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(inode)->s_blocksize;
 	unsigned bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh = wait;
 	bool decrypt = false;
@@ -1250,7 +1251,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index;
 	unsigned from, to;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	trace_ext4_write_begin(inode, pos, len, flags);
@@ -1350,7 +1351,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		}
 
 		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		    ext4_should_retry_alloc(inode_sb(inode), &retries))
 			goto retry_journal;
 		put_page(page);
 		return ret;
@@ -1567,7 +1568,7 @@ static int ext4_journalled_write_end(struct file *file,
  */
 static int ext4_da_reserve_space(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int ret;
 
@@ -1595,7 +1596,7 @@ static int ext4_da_reserve_space(struct inode *inode)
 
 static void ext4_da_release_space(struct inode *inode, int to_free)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
 	if (!to_free)
@@ -1611,10 +1612,10 @@ static void ext4_da_release_space(struct inode *inode, int to_free)
 		 * function is called from invalidate page, it's
 		 * harmless to return without any action.
 		 */
-		ext4_warning(inode->i_sb, "ext4_da_release_space: "
-			 "ino %lu, to_free %d with only %d reserved "
-			 "data blocks", inode->i_ino, to_free,
-			 ei->i_reserved_data_blocks);
+		ext4_warning(inode_sb(inode), "ext4_da_release_space: "
+			     "ino %lu, to_free %d with only %d reserved "
+			     "data blocks", inode->i_ino, to_free,
+			     ei->i_reserved_data_blocks);
 		WARN_ON(1);
 		to_free = ei->i_reserved_data_blocks;
 	}
@@ -1636,7 +1637,7 @@ static void ext4_da_page_release_reservation(struct page *page,
 	struct buffer_head *head, *bh;
 	unsigned int curr_off = 0;
 	struct inode *inode = page->mapping->host;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	unsigned int stop = offset + length;
 	int num_clusters;
 	ext4_fsblk_t lblk;
@@ -1753,12 +1754,12 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 
 static void ext4_print_free_blocks(struct inode *inode)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	struct super_block *sb = inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 
 	ext4_msg(sb, KERN_CRIT, "Total free blocks count %lld",
-	       EXT4_C2B(EXT4_SB(inode->i_sb),
+	       EXT4_C2B(EXT4_SB(inode_sb(inode)),
 			ext4_count_free_clusters(sb)));
 	ext4_msg(sb, KERN_CRIT, "Free/Dirty block details");
 	ext4_msg(sb, KERN_CRIT, "free_blocks=%lld",
@@ -1797,7 +1798,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	memcpy(&orig_map, map, sizeof(*map));
 #endif
 
-	if (invalid_block < ext4_blocks_count(EXT4_SB(inode->i_sb)->s_es))
+	if (invalid_block < ext4_blocks_count(EXT4_SB(inode_sb(inode))->s_es))
 		invalid_block = ~0;
 
 	map->m_flags = 0;
@@ -1818,7 +1819,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		 * So we need to check it.
 		 */
 		if (ext4_es_is_delayed(&es) && !ext4_es_is_unwritten(&es)) {
-			map_bh(bh, inode->i_sb, invalid_block);
+			map_bh(bh, inode_sb(inode), invalid_block);
 			set_buffer_new(bh);
 			set_buffer_delay(bh);
 			return 0;
@@ -1866,7 +1867,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		 * then we don't need to reserve it again. However we still need
 		 * to reserve metadata for every block we're going to write.
 		 */
-		if (EXT4_SB(inode->i_sb)->s_cluster_ratio == 1 ||
+		if (EXT4_SB(inode_sb(inode))->s_cluster_ratio == 1 ||
 		    !ext4_find_delalloc_cluster(inode, map->m_lblk)) {
 			ret = ext4_da_reserve_space(inode);
 			if (ret) {
@@ -1883,7 +1884,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 			goto out_unlock;
 		}
 
-		map_bh(bh, inode->i_sb, invalid_block);
+		map_bh(bh, inode_sb(inode), invalid_block);
 		set_buffer_new(bh);
 		set_buffer_delay(bh);
 	} else if (retval > 0) {
@@ -1891,7 +1892,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		unsigned int status;
 
 		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "ES len assertion failed for inode "
 				     "%lu: retval %d != map->m_len %d",
 				     inode->i_ino, retval, map->m_len);
@@ -1931,7 +1932,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	int ret = 0;
 
 	BUG_ON(create == 0);
-	BUG_ON(bh->b_size != inode->i_sb->s_blocksize);
+	BUG_ON(bh->b_size != inode_sb(inode)->s_blocksize);
 
 	map.m_lblk = iblock;
 	map.m_len = 1;
@@ -1945,7 +1946,7 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	if (ret <= 0)
 		return ret;
 
-	map_bh(bh, inode->i_sb, map.m_pblk);
+	map_bh(bh, inode_sb(inode), map.m_pblk);
 	ext4_update_bh_state(bh, map.m_flags);
 
 	if (buffer_unwritten(bh)) {
@@ -2110,7 +2111,7 @@ static int ext4_writepage(struct page *page,
 	struct ext4_io_submit io_submit;
 	bool keep_towrite = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode))))) {
 		ext4_invalidatepage(page, 0, PAGE_SIZE);
 		unlock_page(page);
 		return -EIO;
@@ -2145,7 +2146,7 @@ static int ext4_writepage(struct page *page,
 				   ext4_bh_delay_or_unwritten)) {
 		redirty_page_for_writepage(wbc, page);
 		if ((current->flags & PF_MEMALLOC) ||
-		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
+		    (inode_sb(inode)->s_blocksize == PAGE_SIZE)) {
 			/*
 			 * For memory cleaning there's no point in writing only
 			 * some buffers. So just bail out. Warn if we came here
@@ -2463,7 +2464,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 
 	BUG_ON(map->m_len == 0);
 	if (map->m_flags & EXT4_MAP_NEW) {
-		clean_bdev_aliases(inode->i_sb->s_bdev, map->m_pblk,
+		clean_bdev_aliases(inode_sb(inode)->s_bdev, map->m_pblk,
 				   map->m_len);
 	}
 	return 0;
@@ -2504,7 +2505,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	do {
 		err = mpage_map_one_extent(handle, mpd);
 		if (err < 0) {
-			struct super_block *sb = inode->i_sb;
+			struct super_block *sb = inode_sb(inode);
 
 			if (ext4_forced_shutdown(EXT4_SB(sb)) ||
 			    EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
@@ -2565,7 +2566,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		up_write(&EXT4_I(inode)->i_data_sem);
 		err2 = ext4_mark_inode_dirty(handle, inode);
 		if (err2)
-			ext4_error(inode->i_sb,
+			ext4_error(inode_sb(inode),
 				   "Failed to mark inode %lu dirty",
 				   inode->i_ino);
 		if (!err)
@@ -2714,19 +2715,20 @@ static int ext4_writepages(struct address_space *mapping,
 	struct mpage_da_data mpd;
 	struct inode *inode = mapping->host;
 	int needed_blocks, rsv_blocks = 0, ret = 0;
-	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(mapping->host));
 	bool done;
 	struct blk_plug plug;
 	bool give_up_on_write = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	percpu_down_read(&sbi->s_journal_flag_rwsem);
 	trace_ext4_writepages(inode, wbc);
 
 	if (dax_mapping(mapping)) {
-		ret = dax_writeback_mapping_range(mapping, inode->i_sb->s_bdev,
+		ret = dax_writeback_mapping_range(mapping,
+						  inode_sb(inode)->s_bdev,
 						  wbc);
 		goto out_writepages;
 	}
@@ -2758,7 +2760,7 @@ static int ext4_writepages(struct address_space *mapping,
 	 * *never* be called, so if that ever happens, we would want
 	 * the stack trace.
 	 */
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(mapping->host->i_sb)) ||
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(mapping->host))) ||
 		     sbi->s_mount_flags & EXT4_MF_FS_ABORTED)) {
 		ret = -EROFS;
 		goto out_writepages;
@@ -2858,9 +2860,10 @@ static int ext4_writepages(struct address_space *mapping,
 				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
 		if (IS_ERR(handle)) {
 			ret = PTR_ERR(handle);
-			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
-			       "%ld pages, ino %lu; err %d", __func__,
-				wbc->nr_to_write, inode->i_ino, ret);
+			ext4_msg(inode_sb(inode), KERN_CRIT,
+				 "%s: jbd2_start: "
+				 "%ld pages, ino %lu; err %d", __func__,
+				 wbc->nr_to_write, inode->i_ino, ret);
 			/* Release allocated io_end */
 			ext4_put_io_end(mpd.io_submit.io_end);
 			mpd.io_submit.io_end = NULL;
@@ -2992,7 +2995,7 @@ static int ext4_nonda_switch(struct super_block *sb)
 /* We always reserve for an inode update; the superblock could be there too */
 static int ext4_da_write_credits(struct inode *inode, loff_t pos, unsigned len)
 {
-	if (likely(ext4_has_feature_large_file(inode->i_sb)))
+	if (likely(ext4_has_feature_large_file(inode_sb(inode))))
 		return 1;
 
 	if (pos + len <= 0x7fffffffULL)
@@ -3012,12 +3015,12 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	handle_t *handle;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) ||
+	if (ext4_nonda_switch(inode_sb(inode)) ||
 	    S_ISLNK(inode->i_mode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(file, mapping, pos,
@@ -3092,7 +3095,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 			ext4_truncate_failed_write(inode);
 
 		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		    ext4_should_retry_alloc(inode_sb(inode), &retries))
 			goto retry_journal;
 
 		put_page(page);
@@ -3272,7 +3275,7 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 		return 0;
 
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
-			test_opt(inode->i_sb, DELALLOC)) {
+			test_opt(inode_sb(inode), DELALLOC)) {
 		/*
 		 * With delalloc we want to sync the file
 		 * so that we can make sure we allocate
@@ -3396,7 +3399,7 @@ static int ext4_releasepage(struct page *page, gfp_t wait)
 
 static bool ext4_inode_datasync_dirty(struct inode *inode)
 {
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	journal_t *journal = EXT4_SB(inode_sb(inode))->s_journal;
 
 	if (journal)
 		return !jbd2_transaction_committed(journal,
@@ -3410,7 +3413,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
 static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 			    unsigned flags, struct iomap *iomap)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	unsigned int blkbits = inode->i_blkbits;
 	unsigned long first_block = offset >> blkbits;
 	unsigned long last_block = (offset + length - 1) >> blkbits;
@@ -3488,7 +3491,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		if (ret < 0) {
 			ext4_journal_stop(handle);
 			if (ret == -ENOSPC &&
-			    ext4_should_retry_alloc(inode->i_sb, &retries))
+			    ext4_should_retry_alloc(inode_sb(inode), &retries))
 				goto retry;
 			return ret;
 		}
@@ -3522,7 +3525,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->flags = 0;
 	if (ext4_inode_datasync_dirty(inode))
 		iomap->flags |= IOMAP_F_DIRTY;
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->bdev = inode_sb(inode)->s_bdev;
 	iomap->dax_dev = sbi->s_daxdev;
 	iomap->offset = first_block << blkbits;
 	iomap->length = (u64)map.m_len << blkbits;
@@ -3735,7 +3738,7 @@ static ssize_t ext4_direct_IO_write(struct kiocb *iocb, struct iov_iter *iter)
 		get_block_func = ext4_dio_get_block_unwritten_async;
 		dio_flags = DIO_LOCKING;
 	}
-	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev, iter,
+	ret = __blockdev_direct_IO(iocb, inode, inode_sb(inode)->s_bdev, iter,
 				   get_block_func, ext4_end_io_dio, NULL,
 				   dio_flags);
 
@@ -3827,7 +3830,7 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 					   iocb->ki_pos + count - 1);
 	if (ret)
 		goto out_unlock;
-	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
+	ret = __blockdev_direct_IO(iocb, inode, inode_sb(inode)->s_bdev,
 				   iter, ext4_dio_get_block, NULL, NULL, 0);
 out_unlock:
 	inode_unlock_shared(inode);
@@ -3958,7 +3961,7 @@ void ext4_set_aops(struct inode *inode)
 	default:
 		BUG();
 	}
-	if (test_opt(inode->i_sb, DELALLOC))
+	if (test_opt(inode_sb(inode), DELALLOC))
 		inode->i_mapping->a_ops = &ext4_da_aops;
 	else
 		inode->i_mapping->a_ops = &ext4_aops;
@@ -3981,9 +3984,9 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	if (!page)
 		return -ENOMEM;
 
-	blocksize = inode->i_sb->s_blocksize;
+	blocksize = inode_sb(inode)->s_blocksize;
 
-	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
+	iblock = index << (PAGE_SHIFT - inode_sb(inode)->s_blocksize_bits);
 
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
@@ -4066,7 +4069,7 @@ static int ext4_block_zero_page_range(handle_t *handle,
 {
 	struct inode *inode = mapping->host;
 	unsigned offset = from & (PAGE_SIZE-1);
-	unsigned blocksize = inode->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(inode)->s_blocksize;
 	unsigned max = blocksize - (offset & (blocksize - 1));
 
 	/*
@@ -4101,7 +4104,7 @@ static int ext4_block_truncate_page(handle_t *handle,
 	if (ext4_encrypted_inode(inode) && !fscrypt_has_encryption_key(inode))
 		return 0;
 
-	blocksize = inode->i_sb->s_blocksize;
+	blocksize = inode_sb(inode)->s_blocksize;
 	length = blocksize - (offset & (blocksize - 1));
 
 	return ext4_block_zero_page_range(handle, mapping, from, length);
@@ -4110,7 +4113,7 @@ static int ext4_block_truncate_page(handle_t *handle,
 int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t length)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct address_space *mapping = inode->i_mapping;
 	unsigned partial_start, partial_end;
 	ext4_fsblk_t start, end;
@@ -4198,7 +4201,7 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 
 int ext4_punch_hole(struct inode *inode, loff_t offset, loff_t length)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	ext4_lblk_t first_block, stop_block;
 	struct address_space *mapping = inode->i_mapping;
 	loff_t first_block_offset, last_block_offset;
@@ -4335,7 +4338,7 @@ int ext4_inode_attach_jinode(struct inode *inode)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct jbd2_inode *jinode;
 
-	if (ei->jinode || !EXT4_SB(inode->i_sb)->s_journal)
+	if (ei->jinode || !EXT4_SB(inode_sb(inode))->s_journal)
 		return 0;
 
 	jinode = jbd2_alloc_inode(GFP_KERNEL);
@@ -4405,7 +4408,7 @@ int ext4_truncate(struct inode *inode)
 
 	ext4_clear_inode_flag(inode, EXT4_INODE_EOFBLOCKS);
 
-	if (inode->i_size == 0 && !test_opt(inode->i_sb, NO_AUTO_DA_ALLOC))
+	if (inode->i_size == 0 && !test_opt(inode_sb(inode), NO_AUTO_DA_ALLOC))
 		ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
 
 	if (ext4_has_inline_data(inode)) {
@@ -4419,7 +4422,7 @@ int ext4_truncate(struct inode *inode)
 	}
 
 	/* If we zero-out tail of the page, we have to create jinode for jbd2 */
-	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
+	if (inode->i_size & (inode_sb(inode)->s_blocksize - 1)) {
 		if (ext4_inode_attach_jinode(inode) < 0)
 			return 0;
 	}
@@ -4433,7 +4436,7 @@ int ext4_truncate(struct inode *inode)
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
-	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
+	if (inode->i_size & (inode_sb(inode)->s_blocksize - 1))
 		ext4_block_truncate_page(handle, mapping, inode->i_size);
 
 	/*
@@ -4495,7 +4498,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 {
 	struct ext4_group_desc	*gdp;
 	struct buffer_head	*bh;
-	struct super_block	*sb = inode->i_sb;
+	struct super_block	*sb = inode_sb(inode);
 	ext4_fsblk_t		block;
 	int			inodes_per_block, inode_offset;
 
@@ -4636,7 +4639,7 @@ int ext4_get_inode_loc(struct inode *inode, struct ext4_iloc *iloc)
 
 static bool ext4_should_use_dax(struct inode *inode)
 {
-	if (!test_opt(inode->i_sb, DAX))
+	if (!test_opt(inode_sb(inode), DAX))
 		return false;
 	if (!S_ISREG(inode->i_mode))
 		return false;
@@ -4678,7 +4681,7 @@ static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
 {
 	blkcnt_t i_blocks ;
 	struct inode *inode = &(ei->vfs_inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (ext4_has_feature_huge_file(sb)) {
 		/* we are using combined 48 bit field */
@@ -4702,7 +4705,7 @@ static inline void ext4_iget_extra_inode(struct inode *inode,
 	__le32 *magic = (void *)raw_inode +
 			EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize;
 	if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize + sizeof(__le32) <=
-	    EXT4_INODE_SIZE(inode->i_sb) &&
+	    EXT4_INODE_SIZE(inode_sb(inode)) &&
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		ext4_find_inline_data_nolock(inode);
@@ -4712,7 +4715,7 @@ static inline void ext4_iget_extra_inode(struct inode *inode,
 
 int ext4_get_projid(struct inode *inode, kprojid_t *projid)
 {
-	if (!ext4_has_feature_project(inode->i_sb))
+	if (!ext4_has_feature_project(inode_sb(inode)))
 		return -EOPNOTSUPP;
 	*projid = EXT4_I(inode)->i_projid;
 	return 0;
@@ -4746,15 +4749,15 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
 
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
-			EXT4_INODE_SIZE(inode->i_sb) ||
-		    (ei->i_extra_isize & 3)) {
+			EXT4_INODE_SIZE(inode_sb(inode)) ||
+			(ei->i_extra_isize & 3)) {
 			EXT4_ERROR_INODE(inode,
 					 "bad extra_isize %u (inode size %u)",
 					 ei->i_extra_isize,
-					 EXT4_INODE_SIZE(inode->i_sb));
+					 EXT4_INODE_SIZE(inode_sb(inode)));
 			ret = -EFSCORRUPTED;
 			goto bad_inode;
 		}
@@ -4763,7 +4766,7 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 
 	/* Precompute checksum seed for inode metadata */
 	if (ext4_has_metadata_csum(sb)) {
-		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 		__u32 csum;
 		__le32 inum = cpu_to_le32(inode->i_ino);
 		__le32 gen = raw_inode->i_generation;
@@ -4789,7 +4792,7 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	else
 		i_projid = EXT4_DEF_PROJID;
 
-	if (!(test_opt(inode->i_sb, NO_UID32))) {
+	if (!(test_opt(inode_sb(inode), NO_UID32))) {
 		i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
 	}
@@ -4809,7 +4812,7 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	 */
 	if (inode->i_nlink == 0) {
 		if ((inode->i_mode == 0 ||
-		     !(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS)) &&
+		     !(EXT4_SB(inode_sb(inode))->s_mount_state & EXT4_ORPHAN_FS)) &&
 		    ino != EXT4_BOOT_LOADER_INO) {
 			/* this inode is deleted */
 			ret = -ESTALE;
@@ -4874,7 +4877,7 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 		ei->i_datasync_tid = tid;
 	}
 
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE) {
 		if (ei->i_extra_isize == 0) {
 			/* The extra space is currently unused. Use it. */
 			BUILD_BUG_ON(sizeof(struct ext4_inode) & 3);
@@ -4890,10 +4893,10 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
 	EXT4_INODE_GET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_GET_XTIME(i_crtime, ei, raw_inode);
 
-	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
+	if (likely(!test_opt2(inode_sb(inode), HURD_COMPAT))) {
 		u64 ivers = le32_to_cpu(raw_inode->i_disk_version);
 
-		if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+		if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE) {
 			if (EXT4_FITS_IN_INODE(raw_inode, ei, i_version_hi))
 				ivers |=
 		    (__u64)(le32_to_cpu(raw_inode->i_version_hi)) << 32;
@@ -4987,7 +4990,7 @@ static int ext4_inode_blocks_set(handle_t *handle,
 {
 	struct inode *inode = &(ei->vfs_inode);
 	u64 i_blocks = inode->i_blocks;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (i_blocks <= ~0U) {
 		/*
@@ -5098,7 +5101,7 @@ static int ext4_do_update_inode(handle_t *handle,
 	struct ext4_inode *raw_inode = ext4_raw_inode(iloc);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct buffer_head *bh = iloc->bh;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int err = 0, rc, block;
 	int need_datasync = 0, set_large_file = 0;
 	uid_t i_uid;
@@ -5110,13 +5113,13 @@ static int ext4_do_update_inode(handle_t *handle,
 	/* For fields not tracked in the in-memory inode,
 	 * initialise them to zero for new inodes. */
 	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
-		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
+		memset(raw_inode, 0, EXT4_SB(inode_sb(inode))->s_inode_size);
 
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	i_uid = i_uid_read(inode);
 	i_gid = i_gid_read(inode);
 	i_projid = from_kprojid(&init_user_ns, ei->i_projid);
-	if (!(test_opt(inode->i_sb, NO_UID32))) {
+	if (!(test_opt(inode_sb(inode), NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(i_uid));
 		raw_inode->i_gid_low = cpu_to_le16(low_16_bits(i_gid));
 /*
@@ -5152,11 +5155,11 @@ static int ext4_do_update_inode(handle_t *handle,
 	}
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags & 0xFFFFFFFF);
-	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT)))
+	if (likely(!test_opt2(inode_sb(inode), HURD_COMPAT)))
 		raw_inode->i_file_acl_high =
 			cpu_to_le16(ei->i_file_acl >> 32);
 	raw_inode->i_file_acl_lo = cpu_to_le32(ei->i_file_acl);
-	if (ei->i_disksize != ext4_isize(inode->i_sb, raw_inode)) {
+	if (ei->i_disksize != ext4_isize(inode_sb(inode), raw_inode)) {
 		ext4_isize_set(raw_inode, ei->i_disksize);
 		need_datasync = 1;
 	}
@@ -5183,7 +5186,7 @@ static int ext4_do_update_inode(handle_t *handle,
 			raw_inode->i_block[block] = ei->i_data[block];
 	}
 
-	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT))) {
+	if (likely(!test_opt2(inode_sb(inode), HURD_COMPAT))) {
 		u64 ivers = inode_peek_iversion(inode);
 
 		raw_inode->i_disk_version = cpu_to_le32(ivers);
@@ -5196,17 +5199,17 @@ static int ext4_do_update_inode(handle_t *handle,
 		}
 	}
 
-	BUG_ON(!ext4_has_feature_project(inode->i_sb) &&
+	BUG_ON(!ext4_has_feature_project(inode_sb(inode)) &&
 	       i_projid != EXT4_DEF_PROJID);
 
-	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE &&
+	if (EXT4_INODE_SIZE(inode_sb(inode)) > EXT4_GOOD_OLD_INODE_SIZE &&
 	    EXT4_FITS_IN_INODE(raw_inode, ei, i_projid))
 		raw_inode->i_projid = cpu_to_le32(i_projid);
 
 	ext4_inode_csum_set(inode, raw_inode, ei);
 	spin_unlock(&ei->i_raw_lock);
-	if (inode->i_sb->s_flags & SB_LAZYTIME)
-		ext4_update_other_inodes_time(inode->i_sb, inode->i_ino,
+	if (inode_sb(inode)->s_flags & SB_LAZYTIME)
+		ext4_update_other_inodes_time(inode_sb(inode), inode->i_ino,
 					      bh->b_data);
 
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
@@ -5227,7 +5230,7 @@ static int ext4_do_update_inode(handle_t *handle,
 	ext4_update_inode_fsync_trans(handle, inode, need_datasync);
 out_brelse:
 	brelse(bh);
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 	return err;
 }
 
@@ -5272,7 +5275,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
 		return 0;
 
-	if (EXT4_SB(inode->i_sb)->s_journal) {
+	if (EXT4_SB(inode_sb(inode))->s_journal) {
 		if (ext4_journal_current_handle()) {
 			jbd_debug(1, "called recursively, non-PF_MEMALLOC!\n");
 			dump_stack();
@@ -5287,7 +5290,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 		if (wbc->sync_mode != WB_SYNC_ALL || wbc->for_sync)
 			return 0;
 
-		err = ext4_force_commit(inode->i_sb);
+		err = ext4_force_commit(inode_sb(inode));
 	} else {
 		struct ext4_iloc iloc;
 
@@ -5319,7 +5322,7 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
 {
 	struct page *page;
 	unsigned offset;
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	journal_t *journal = EXT4_SB(inode_sb(inode))->s_journal;
 	tid_t commit_tid = 0;
 	int ret;
 
@@ -5383,7 +5386,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	int orphan = 0;
 	const unsigned int ia_valid = attr->ia_valid;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	error = setattr_prepare(dentry, attr);
@@ -5406,8 +5409,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		/* (user+group)*(old+new) structure, inode write (sb,
 		 * inode block, ? - but truncate inode update has it) */
 		handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
-			(EXT4_MAXQUOTAS_INIT_BLOCKS(inode->i_sb) +
-			 EXT4_MAXQUOTAS_DEL_BLOCKS(inode->i_sb)) + 3);
+			(EXT4_MAXQUOTAS_INIT_BLOCKS(inode_sb(inode)) +
+			 EXT4_MAXQUOTAS_DEL_BLOCKS(inode_sb(inode))) + 3);
 		if (IS_ERR(handle)) {
 			error = PTR_ERR(handle);
 			goto err_out;
@@ -5440,7 +5443,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		int shrink = (attr->ia_size <= inode->i_size);
 
 		if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-			struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+			struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 
 			if (attr->ia_size > sbi->s_bitmap_maxbytes)
 				return -EFBIG;
@@ -5542,7 +5545,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		rc = posix_acl_chmod(inode, inode->i_mode);
 
 err_out:
-	ext4_std_error(inode->i_sb, error);
+	ext4_std_error(inode_sb(inode), error);
 	if (!error)
 		error = rc;
 	return error;
@@ -5611,9 +5614,9 @@ int ext4_file_getattr(const struct path *path, struct kstat *stat,
 	 * will return the blocks that include the delayed allocation
 	 * blocks for this file.
 	 */
-	delalloc_blocks = EXT4_C2B(EXT4_SB(inode->i_sb),
+	delalloc_blocks = EXT4_C2B(EXT4_SB(inode_sb(inode)),
 				   EXT4_I(inode)->i_reserved_data_blocks);
-	stat->blocks += delalloc_blocks << (inode->i_sb->s_blocksize_bits - 9);
+	stat->blocks += delalloc_blocks << (inode_sb(inode)->s_blocksize_bits - 9);
 	return 0;
 }
 
@@ -5639,7 +5642,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents)
 {
-	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
+	ext4_group_t groups, ngroups = ext4_get_groups_count(inode_sb(inode));
 	int gdpblocks;
 	int idxblocks;
 	int ret = 0;
@@ -5660,14 +5663,14 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 	gdpblocks = groups;
 	if (groups > ngroups)
 		groups = ngroups;
-	if (groups > EXT4_SB(inode->i_sb)->s_gdb_count)
-		gdpblocks = EXT4_SB(inode->i_sb)->s_gdb_count;
+	if (groups > EXT4_SB(inode_sb(inode))->s_gdb_count)
+		gdpblocks = EXT4_SB(inode_sb(inode))->s_gdb_count;
 
 	/* bitmaps and block group descriptor blocks */
 	ret += groups + gdpblocks;
 
 	/* Blocks for super block, inode, quota and xattr blocks */
-	ret += EXT4_META_TRANS_BLOCKS(inode->i_sb);
+	ret += EXT4_META_TRANS_BLOCKS(inode_sb(inode));
 
 	return ret;
 }
@@ -5718,7 +5721,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 {
 	int err = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	if (IS_I_VERSION(inode))
@@ -5744,7 +5747,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	err = ext4_get_inode_loc(inode, iloc);
@@ -5756,7 +5759,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			iloc->bh = NULL;
 		}
 	}
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 	return err;
 }
 
@@ -5822,7 +5825,7 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 	 */
 	if (ext4_handle_valid(handle) &&
 	    jbd2_journal_extend(handle,
-				EXT4_DATA_TRANS_BLOCKS(inode->i_sb)) != 0)
+				EXT4_DATA_TRANS_BLOCKS(inode_sb(inode))) != 0)
 		return -ENOSPC;
 
 	if (ext4_write_trylock_xattr(inode, &no_expand) == 0)
@@ -5849,7 +5852,7 @@ int ext4_expand_extra_isize(struct inode *inode,
 	}
 
 	handle = ext4_journal_start(inode, EXT4_HT_INODE,
-				    EXT4_DATA_TRANS_BLOCKS(inode->i_sb));
+				    EXT4_DATA_TRANS_BLOCKS(inode_sb(inode)));
 	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
 		brelse(iloc->bh);
@@ -5894,7 +5897,7 @@ int ext4_expand_extra_isize(struct inode *inode,
 int ext4_mark_inode_dirty(handle_t *handle, struct inode *inode)
 {
 	struct ext4_iloc iloc;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	int err;
 
 	might_sleep();
@@ -5970,7 +5973,7 @@ static int ext4_pin_inode(handle_t *handle, struct inode *inode)
 			brelse(iloc.bh);
 		}
 	}
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 	return err;
 }
 #endif
@@ -5980,7 +5983,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	journal_t *journal;
 	handle_t *handle;
 	int err;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 
 	/*
 	 * We have to be very careful here: changing a data block's
@@ -6061,7 +6064,7 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	err = ext4_mark_inode_dirty(handle, inode);
 	ext4_handle_sync(handle);
 	ext4_journal_stop(handle);
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 
 	return err;
 }
@@ -6085,7 +6088,7 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 	get_block_t *get_block;
 	int retries = 0;
 
-	sb_start_pagefault(inode->i_sb);
+	sb_start_pagefault(inode_sb(inode));
 	file_update_time(vma->vm_file);
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
@@ -6095,14 +6098,14 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		goto out_ret;
 
 	/* Delalloc case is easy... */
-	if (test_opt(inode->i_sb, DELALLOC) &&
+	if (test_opt(inode_sb(inode), DELALLOC) &&
 	    !ext4_should_journal_data(inode) &&
-	    !ext4_nonda_switch(inode->i_sb)) {
+	    !ext4_nonda_switch(inode_sb(inode))) {
 		do {
 			ret = block_page_mkwrite(vma, vmf,
 						   ext4_da_get_block_prep);
 		} while (ret == -ENOSPC &&
-		       ext4_should_retry_alloc(inode->i_sb, &retries));
+		       ext4_should_retry_alloc(inode_sb(inode), &retries));
 		goto out_ret;
 	}
 
@@ -6158,13 +6161,13 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 		ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	}
 	ext4_journal_stop(handle);
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (ret == -ENOSPC && ext4_should_retry_alloc(inode_sb(inode), &retries))
 		goto retry_alloc;
 out_ret:
 	ret = block_page_mkwrite_return(ret);
 out:
 	up_read(&EXT4_I(inode)->i_mmap_sem);
-	sb_end_pagefault(inode->i_sb);
+	sb_end_pagefault(inode_sb(inode));
 	return ret;
 }
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7e99ad02f1ba..d8a9930f0ff6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -166,17 +166,17 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
-		ext4_warning(inode->i_sb,
-			"couldn't mark inode #%lu dirty (err %d)",
-			inode->i_ino, err);
+		ext4_warning(inode_sb(inode),
+			     "couldn't mark inode #%lu dirty (err %d)",
+			     inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
 	} else {
 		err = ext4_mark_inode_dirty(handle, inode_bl);
 		if (err < 0) {
-			ext4_warning(inode_bl->i_sb,
-				"couldn't mark inode #%lu dirty (err %d)",
-				inode_bl->i_ino, err);
+			ext4_warning(inode_sb(inode_bl),
+				     "couldn't mark inode #%lu dirty (err %d)",
+				     inode_bl->i_ino, err);
 			/* Revert all changes: */
 			swap_inode_data(inode, inode_bl);
 			ext4_mark_inode_dirty(handle, inode);
@@ -295,7 +295,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 		 * Changes to the journaling mode can cause unsafe changes to
 		 * S_DAX if we are using the DAX mount option.
 		 */
-		if (test_opt(inode->i_sb, DAX)) {
+		if (test_opt(inode_sb(inode), DAX)) {
 			err = -EBUSY;
 			goto flags_out;
 		}
@@ -319,7 +319,7 @@ static int ext4_ioctl_setflags(struct inode *inode,
 static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 {
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int err, rc;
 	handle_t *handle;
@@ -596,7 +596,7 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 static long ext4_ioctl_group_add(struct file *file,
 				 struct ext4_new_group_data *input)
 {
-	struct super_block *sb = file_inode(file)->i_sb;
+	struct super_block *sb = inode_sb(file_inode(file));
 	int err, err2=0;
 
 	err = ext4_resize_begin(sb);
@@ -634,7 +634,7 @@ static long ext4_ioctl_group_add(struct file *file,
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	unsigned int flags;
 
@@ -690,7 +690,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!inode_owner_or_capable(inode))
 			return -EPERM;
 
-		if (ext4_has_metadata_csum(inode->i_sb)) {
+		if (ext4_has_metadata_csum(inode_sb(inode))) {
 			ext4_warning(sb, "Setting inode version is not "
 				     "supported with metadata_csum enabled.");
 			return -ENOTTY;
@@ -995,7 +995,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		memset(&fa, 0, sizeof(struct fsxattr));
 		fa.fsx_xflags = ext4_iflags_to_xflags(ei->i_flags & EXT4_FL_USER_VISIBLE);
 
-		if (ext4_has_feature_project(inode->i_sb)) {
+		if (ext4_has_feature_project(inode_sb(inode))) {
 			fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
 				EXT4_I(inode)->i_projid);
 		}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 769a62708b1c..051379dc75f2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -822,7 +822,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 	mb_debug(1, "init page %lu\n", page->index);
 
 	inode = page->mapping->host;
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	ngroups = ext4_get_groups_count(sb);
 	blocksize = i_blocksize(inode);
 	blocks_per_page = PAGE_SIZE / blocksize;
@@ -4006,7 +4006,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 void ext4_discard_preallocations(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bitmap_bh = NULL;
 	struct ext4_prealloc_space *pa, *tmp;
 	ext4_group_t group = 0;
@@ -4233,7 +4233,7 @@ static noinline_for_stack int
 ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
-	struct super_block *sb = ar->inode->i_sb;
+	struct super_block *sb = inode_sb(ar->inode);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
 	ext4_group_t group;
@@ -4490,7 +4490,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	unsigned int reserv_clstrs = 0;
 
 	might_sleep();
-	sb = ar->inode->i_sb;
+	sb = inode_sb(ar->inode);
 	sbi = EXT4_SB(sb);
 
 	trace_ext4_request_blocks(ar);
@@ -4723,7 +4723,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		      unsigned long count, int flags)
 {
 	struct buffer_head *bitmap_bh = NULL;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_group_desc *gdp;
 	unsigned int overflow;
 	ext4_grpblk_t bit;
@@ -4800,7 +4800,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		for (i = 0; i < count; i++) {
 			cond_resched();
 			if (is_metadata)
-				bh = sb_find_get_block(inode->i_sb, block + i);
+				bh = sb_find_get_block(inode_sb(inode),
+						       block + i);
 			ext4_forget(handle, is_metadata, inode, bh, block + i);
 		}
 	}
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 61a9d1927817..479e3b54d5be 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -114,9 +114,9 @@ static int update_ind_extent_range(handle_t *handle, struct inode *inode,
 	struct buffer_head *bh;
 	__le32 *i_data;
 	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	unsigned long max_entries = inode_sb(inode)->s_blocksize >> 2;
 
-	bh = sb_bread(inode->i_sb, pblock);
+	bh = sb_bread(inode_sb(inode), pblock);
 	if (!bh)
 		return -EIO;
 
@@ -143,9 +143,9 @@ static int update_dind_extent_range(handle_t *handle, struct inode *inode,
 	struct buffer_head *bh;
 	__le32 *i_data;
 	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	unsigned long max_entries = inode_sb(inode)->s_blocksize >> 2;
 
-	bh = sb_bread(inode->i_sb, pblock);
+	bh = sb_bread(inode_sb(inode), pblock);
 	if (!bh)
 		return -EIO;
 
@@ -173,9 +173,9 @@ static int update_tind_extent_range(handle_t *handle, struct inode *inode,
 	struct buffer_head *bh;
 	__le32 *i_data;
 	int i, retval = 0;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	unsigned long max_entries = inode_sb(inode)->s_blocksize >> 2;
 
-	bh = sb_bread(inode->i_sb, pblock);
+	bh = sb_bread(inode_sb(inode), pblock);
 	if (!bh)
 		return -EIO;
 
@@ -208,7 +208,7 @@ static int extend_credit_for_blkdel(handle_t *handle, struct inode *inode)
 	 * So allocate a credit of 3. We may update
 	 * quota (user and group).
 	 */
-	needed = 3 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb);
+	needed = 3 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode_sb(inode));
 
 	if (ext4_journal_extend(handle, needed) != 0)
 		retval = ext4_journal_restart(handle, needed);
@@ -222,9 +222,9 @@ static int free_dind_blocks(handle_t *handle,
 	int i;
 	__le32 *tmp_idata;
 	struct buffer_head *bh;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	unsigned long max_entries = inode_sb(inode)->s_blocksize >> 2;
 
-	bh = sb_bread(inode->i_sb, le32_to_cpu(i_data));
+	bh = sb_bread(inode_sb(inode), le32_to_cpu(i_data));
 	if (!bh)
 		return -EIO;
 
@@ -252,9 +252,9 @@ static int free_tind_blocks(handle_t *handle,
 	int i, retval = 0;
 	__le32 *tmp_idata;
 	struct buffer_head *bh;
-	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
+	unsigned long max_entries = inode_sb(inode)->s_blocksize >> 2;
 
-	bh = sb_bread(inode->i_sb, le32_to_cpu(i_data));
+	bh = sb_bread(inode_sb(inode), le32_to_cpu(i_data));
 	if (!bh)
 		return -EIO;
 
@@ -382,7 +382,7 @@ static int free_ext_idx(handle_t *handle, struct inode *inode,
 	struct ext4_extent_header *eh;
 
 	block = ext4_idx_pblock(ix);
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode_sb(inode), block);
 	if (!bh)
 		return -EIO;
 
@@ -441,7 +441,7 @@ int ext4_ext_migrate(struct inode *inode)
 	 * If the filesystem does not support extents, or the inode
 	 * already is extent-based, error out.
 	 */
-	if (!ext4_has_feature_extents(inode->i_sb) ||
+	if (!ext4_has_feature_extents(inode_sb(inode)) ||
 	    (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
 		return -EINVAL;
 
@@ -457,17 +457,17 @@ int ext4_ext_migrate(struct inode *inode)
 	 * need to worry about credits for modifying the quota inode.
 	 */
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE,
-		4 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb));
+		4 + EXT4_MAXQUOTAS_TRANS_BLOCKS(inode_sb(inode)));
 
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
 		return retval;
 	}
-	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode->i_sb)) *
-		EXT4_INODES_PER_GROUP(inode->i_sb)) + 1;
+	goal = (((inode->i_ino - 1) / EXT4_INODES_PER_GROUP(inode_sb(inode))) *
+		EXT4_INODES_PER_GROUP(inode_sb(inode))) + 1;
 	owner[0] = i_uid_read(inode);
 	owner[1] = i_gid_read(inode);
-	tmp_inode = ext4_new_inode(handle, d_inode(inode->i_sb->s_root),
+	tmp_inode = ext4_new_inode(handle, d_inode(inode_sb(inode)->s_root),
 				   S_IFREG, NULL, goal, owner, 0);
 	if (IS_ERR(tmp_inode)) {
 		retval = PTR_ERR(tmp_inode);
@@ -522,7 +522,7 @@ int ext4_ext_migrate(struct inode *inode)
 	memset(&lb, 0, sizeof(lb));
 
 	/* 32 bit block address 4 bytes */
-	max_entries = inode->i_sb->s_blocksize >> 2;
+	max_entries = inode_sb(inode)->s_blocksize >> 2;
 	for (i = 0; i < EXT4_NDIR_BLOCKS; i++) {
 		if (i_data[i]) {
 			retval = update_extent_range(handle, tmp_inode,
@@ -608,7 +608,7 @@ int ext4_ext_migrate(struct inode *inode)
 int ext4_ind_migrate(struct inode *inode)
 {
 	struct ext4_extent_header	*eh;
-	struct ext4_super_block		*es = EXT4_SB(inode->i_sb)->s_es;
+	struct ext4_super_block		*es = EXT4_SB(inode_sb(inode))->s_es;
 	struct ext4_inode_info		*ei = EXT4_I(inode);
 	struct ext4_extent		*ex;
 	unsigned int			i, len;
@@ -617,11 +617,11 @@ int ext4_ind_migrate(struct inode *inode)
 	handle_t			*handle;
 	int				ret;
 
-	if (!ext4_has_feature_extents(inode->i_sb) ||
+	if (!ext4_has_feature_extents(inode_sb(inode)) ||
 	    (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
 		return -EINVAL;
 
-	if (ext4_has_feature_bigalloc(inode->i_sb))
+	if (ext4_has_feature_bigalloc(inode_sb(inode)))
 		return -EOPNOTSUPP;
 
 	/*
@@ -629,7 +629,7 @@ int ext4_ind_migrate(struct inode *inode)
 	 * blocks to be allocated, otherwise delayed allocation blocks may not
 	 * be reflected and bypass the checks on extent header.
 	 */
-	if (test_opt(inode->i_sb, DELALLOC))
+	if (test_opt(inode_sb(inode), DELALLOC))
 		ext4_alloc_da_blocks(inode);
 
 	handle = ext4_journal_start(inode, EXT4_HT_MIGRATE, 1);
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b96e4bd3b3ec..670ccca993a0 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -255,13 +255,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	struct page *pagep[2] = {NULL, NULL};
 	handle_t *handle;
 	ext4_lblk_t orig_blk_offset, donor_blk_offset;
-	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
+	unsigned long blocksize = inode_sb(orig_inode)->s_blocksize;
 	unsigned int tmp_data_size, data_size, replaced_size;
 	int i, err2, jblocks, retries = 0;
 	int replaced_count = 0;
 	int from = data_offset_in_page << orig_inode->i_blkbits;
 	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
-	struct super_block *sb = orig_inode->i_sb;
+	struct super_block *sb = inode_sb(orig_inode);
 	struct buffer_head *bh = NULL;
 
 	/*
@@ -558,7 +558,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	ext4_lblk_t d_start = donor_blk;
 	int ret;
 
-	if (orig_inode->i_sb != donor_inode->i_sb) {
+	if (inode_sb(orig_inode) != inode_sb(donor_inode)) {
 		ext4_debug("ext4 move extent: The argument files "
 			"should be in same FS [ino:orig %lu, donor %lu]\n",
 			orig_inode->i_ino, donor_inode->i_ino);
@@ -585,14 +585,14 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
 	   journaling enabled */
 	if (ext4_should_journal_data(orig_inode) ||
 	    ext4_should_journal_data(donor_inode)) {
-		ext4_msg(orig_inode->i_sb, KERN_ERR,
+		ext4_msg(inode_sb(orig_inode), KERN_ERR,
 			 "Online defrag not supported with data journaling");
 		return -EOPNOTSUPP;
 	}
 
 	if (ext4_encrypted_inode(orig_inode) ||
 	    ext4_encrypted_inode(donor_inode)) {
-		ext4_msg(orig_inode->i_sb, KERN_ERR,
+		ext4_msg(inode_sb(orig_inode), KERN_ERR,
 			 "Online defrag not supported for encrypted files");
 		return -EOPNOTSUPP;
 	}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b1f21e3a0763..68d59adb8590 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -56,23 +56,23 @@ static struct buffer_head *ext4_append(handle_t *handle,
 	struct buffer_head *bh;
 	int err;
 
-	if (unlikely(EXT4_SB(inode->i_sb)->s_max_dir_size_kb &&
+	if (unlikely(EXT4_SB(inode_sb(inode))->s_max_dir_size_kb &&
 		     ((inode->i_size >> 10) >=
-		      EXT4_SB(inode->i_sb)->s_max_dir_size_kb)))
+		      EXT4_SB(inode_sb(inode))->s_max_dir_size_kb)))
 		return ERR_PTR(-ENOSPC);
 
-	*block = inode->i_size >> inode->i_sb->s_blocksize_bits;
+	*block = inode->i_size >> inode_sb(inode)->s_blocksize_bits;
 
 	bh = ext4_bread(handle, inode, *block, EXT4_GET_BLOCKS_CREATE);
 	if (IS_ERR(bh))
 		return bh;
-	inode->i_size += inode->i_sb->s_blocksize;
+	inode->i_size += inode_sb(inode)->s_blocksize;
 	EXT4_I(inode)->i_disksize = inode->i_size;
 	BUFFER_TRACE(bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, bh);
 	if (err) {
 		brelse(bh);
-		ext4_std_error(inode->i_sb, err);
+		ext4_std_error(inode_sb(inode), err);
 		return ERR_PTR(err);
 	}
 	return bh;
@@ -100,7 +100,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 	bh = ext4_bread(NULL, inode, block, 0);
 	if (IS_ERR(bh)) {
-		__ext4_warning(inode->i_sb, func, line,
+		__ext4_warning(inode_sb(inode), func, line,
 			       "inode #%lu: lblock %lu: comm %s: "
 			       "error %ld reading directory block",
 			       inode->i_ino, (unsigned long)block,
@@ -119,8 +119,8 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		if (block == 0)
 			is_dx_block = 1;
 		else if (ext4_rec_len_from_disk(dirent->rec_len,
-						inode->i_sb->s_blocksize) ==
-			 inode->i_sb->s_blocksize)
+						inode_sb(inode)->s_blocksize) ==
+			 inode_sb(inode)->s_blocksize)
 			is_dx_block = 1;
 	}
 	if (!is_dx_block && type == INDEX) {
@@ -128,7 +128,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		       "directory leaf block found instead of index block");
 		return ERR_PTR(-EFSCORRUPTED);
 	}
-	if (!ext4_has_metadata_csum(inode->i_sb) ||
+	if (!ext4_has_metadata_csum(inode_sb(inode)) ||
 	    buffer_verified(bh))
 		return bh;
 
@@ -298,8 +298,8 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 
 	d = de;
 	top = (struct ext4_dir_entry *)(((void *)de) +
-		(EXT4_BLOCK_SIZE(inode->i_sb) -
-		sizeof(struct ext4_dir_entry_tail)));
+		(EXT4_BLOCK_SIZE(inode_sb(inode)) -
+		 sizeof(struct ext4_dir_entry_tail)));
 	while (d < top && d->rec_len)
 		d = (struct ext4_dir_entry *)(((void *)d) +
 		    le16_to_cpu(d->rec_len));
@@ -309,7 +309,7 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 
 	t = (struct ext4_dir_entry_tail *)d;
 #else
-	t = EXT4_DIRENT_TAIL(de, EXT4_BLOCK_SIZE(inode->i_sb));
+	t = EXT4_DIRENT_TAIL(de, EXT4_BLOCK_SIZE(inode_sb(inode)));
 #endif
 
 	if (t->det_reserved_zero1 ||
@@ -324,7 +324,7 @@ static struct ext4_dir_entry_tail *get_dirent_tail(struct inode *inode,
 static __le32 ext4_dirent_csum(struct inode *inode,
 			       struct ext4_dir_entry *dirent, int size)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	__u32 csum;
 
@@ -346,7 +346,7 @@ int ext4_dirent_csum_verify(struct inode *inode, struct ext4_dir_entry *dirent)
 {
 	struct ext4_dir_entry_tail *t;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return 1;
 
 	t = get_dirent_tail(inode, dirent);
@@ -367,7 +367,7 @@ static void ext4_dirent_csum_set(struct inode *inode,
 {
 	struct ext4_dir_entry_tail *t;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return;
 
 	t = get_dirent_tail(inode, dirent);
@@ -396,12 +396,12 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	struct dx_root_info *root;
 	int count_offset;
 
-	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode->i_sb))
+	if (le16_to_cpu(dirent->rec_len) == EXT4_BLOCK_SIZE(inode_sb(inode)))
 		count_offset = 8;
 	else if (le16_to_cpu(dirent->rec_len) == 12) {
 		dp = (struct ext4_dir_entry *)(((void *)dirent) + 12);
 		if (le16_to_cpu(dp->rec_len) !=
-		    EXT4_BLOCK_SIZE(inode->i_sb) - 12)
+		    EXT4_BLOCK_SIZE(inode_sb(inode)) - 12)
 			return NULL;
 		root = (struct dx_root_info *)(((void *)dp + 12));
 		if (root->reserved_zero ||
@@ -419,7 +419,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 static __le32 ext4_dx_csum(struct inode *inode, struct ext4_dir_entry *dirent,
 			   int count_offset, int count, struct dx_tail *t)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	__u32 csum;
 	int size;
@@ -441,7 +441,7 @@ static int ext4_dx_csum_verify(struct inode *inode,
 	struct dx_tail *t;
 	int count_offset, limit, count;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return 1;
 
 	c = get_dx_countlimit(inode, dirent, &count_offset);
@@ -452,7 +452,7 @@ static int ext4_dx_csum_verify(struct inode *inode,
 	limit = le16_to_cpu(c->limit);
 	count = le16_to_cpu(c->count);
 	if (count_offset + (limit * sizeof(struct dx_entry)) >
-	    EXT4_BLOCK_SIZE(inode->i_sb) - sizeof(struct dx_tail)) {
+	    EXT4_BLOCK_SIZE(inode_sb(inode)) - sizeof(struct dx_tail)) {
 		warn_no_space_for_csum(inode);
 		return 0;
 	}
@@ -470,7 +470,7 @@ static void ext4_dx_csum_set(struct inode *inode, struct ext4_dir_entry *dirent)
 	struct dx_tail *t;
 	int count_offset, limit, count;
 
-	if (!ext4_has_metadata_csum(inode->i_sb))
+	if (!ext4_has_metadata_csum(inode_sb(inode)))
 		return;
 
 	c = get_dx_countlimit(inode, dirent, &count_offset);
@@ -481,7 +481,7 @@ static void ext4_dx_csum_set(struct inode *inode, struct ext4_dir_entry *dirent)
 	limit = le16_to_cpu(c->limit);
 	count = le16_to_cpu(c->count);
 	if (count_offset + (limit * sizeof(struct dx_entry)) >
-	    EXT4_BLOCK_SIZE(inode->i_sb) - sizeof(struct dx_tail)) {
+	    EXT4_BLOCK_SIZE(inode_sb(inode)) - sizeof(struct dx_tail)) {
 		warn_no_space_for_csum(inode);
 		return;
 	}
@@ -555,19 +555,19 @@ static inline void dx_set_limit(struct dx_entry *entries, unsigned value)
 
 static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(1) -
+	unsigned entry_space = inode_sb(dir)->s_blocksize - EXT4_DIR_REC_LEN(1) -
 		EXT4_DIR_REC_LEN(2) - infosize;
 
-	if (ext4_has_metadata_csum(dir->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(dir)))
 		entry_space -= sizeof(struct dx_tail);
 	return entry_space / sizeof(struct dx_entry);
 }
 
 static inline unsigned dx_node_limit(struct inode *dir)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(0);
+	unsigned entry_space = inode_sb(dir)->s_blocksize - EXT4_DIR_REC_LEN(0);
 
-	if (ext4_has_metadata_csum(dir->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(dir)))
 		entry_space -= sizeof(struct dx_tail);
 	return entry_space / sizeof(struct dx_entry);
 }
@@ -689,7 +689,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 			     struct dx_entry *entries, int levels)
 {
-	unsigned blocksize = dir->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(dir)->s_blocksize;
 	unsigned count = dx_get_count(entries), names = 0, space = 0, i;
 	unsigned bcount = 0;
 	struct buffer_head *bh;
@@ -758,8 +758,8 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 		hinfo = &fname->hinfo;
 	hinfo->hash_version = root->info.hash_version;
 	if (hinfo->hash_version <= DX_HASH_TEA)
-		hinfo->hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
-	hinfo->seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+		hinfo->hash_version += EXT4_SB(inode_sb(dir))->s_hash_unsigned;
+	hinfo->seed = EXT4_SB(inode_sb(dir))->s_hash_seed;
 	if (fname && fname_name(fname))
 		ext4fs_dirhash(fname_name(fname), fname_len(fname), hinfo);
 	hash = hinfo->hash;
@@ -771,13 +771,13 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	}
 
 	indirect = root->info.indirect_levels;
-	if (indirect >= ext4_dir_htree_level(dir->i_sb)) {
-		ext4_warning(dir->i_sb,
+	if (indirect >= ext4_dir_htree_level(inode_sb(dir))) {
+		ext4_warning(inode_sb(dir),
 			     "Directory (ino: %lu) htree depth %#06x exceed"
 			     "supported value", dir->i_ino,
-			     ext4_dir_htree_level(dir->i_sb));
-		if (ext4_dir_htree_level(dir->i_sb) < EXT4_HTREE_LEVEL) {
-			ext4_warning(dir->i_sb, "Enable large directory "
+			     ext4_dir_htree_level(inode_sb(dir)));
+		if (ext4_dir_htree_level(inode_sb(dir)) < EXT4_HTREE_LEVEL) {
+			ext4_warning(inode_sb(dir), "Enable large directory "
 						"feature to access it");
 		}
 		goto fail;
@@ -981,7 +981,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
 	top = (struct ext4_dir_entry_2 *) ((char *) de +
-					   dir->i_sb->s_blocksize -
+					   inode_sb(dir)->s_blocksize -
 					   EXT4_DIR_REC_LEN(0));
 #ifdef CONFIG_EXT4_FS_ENCRYPTION
 	/* Check if the directory is encrypted */
@@ -999,11 +999,11 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 		}
 	}
 #endif
-	for (; de < top; de = ext4_next_entry(de, dir->i_sb->s_blocksize)) {
+	for (; de < top; de = ext4_next_entry(de, inode_sb(dir)->s_blocksize)) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
 				bh->b_data, bh->b_size,
-				(block<<EXT4_BLOCK_SIZE_BITS(dir->i_sb))
-					 + ((char *)de - bh->b_data))) {
+				(block<<EXT4_BLOCK_SIZE_BITS(inode_sb(dir)))
+				+ ((char *)de - bh->b_data))) {
 			/* silently ignore the rest of the block */
 			break;
 		}
@@ -1078,11 +1078,11 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 		       start_hash, start_minor_hash));
 	dir = file_inode(dir_file);
 	if (!(ext4_test_inode_flag(dir, EXT4_INODE_INDEX))) {
-		hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+		hinfo.hash_version = EXT4_SB(inode_sb(dir))->s_def_hash_version;
 		if (hinfo.hash_version <= DX_HASH_TEA)
 			hinfo.hash_version +=
-				EXT4_SB(dir->i_sb)->s_hash_unsigned;
-		hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+				EXT4_SB(inode_sb(dir))->s_hash_unsigned;
+		hinfo.seed = EXT4_SB(inode_sb(dir))->s_hash_seed;
 		if (ext4_has_inline_data(dir)) {
 			int has_inline_data = 1;
 			count = htree_inlinedir_to_tree(dir_file, dir, 0,
@@ -1118,7 +1118,7 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 	}
 	if (start_hash < 2 || (start_hash ==2 && start_minor_hash==0)) {
 		de = (struct ext4_dir_entry_2 *) frames[0].bh->b_data;
-		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+		de = ext4_next_entry(de, inode_sb(dir)->s_blocksize);
 		tmp_str.name = de->name;
 		tmp_str.len = de->name_len;
 		err = ext4_htree_store_dirent(dir_file, 2, 0,
@@ -1174,7 +1174,8 @@ static inline int search_dirblock(struct buffer_head *bh,
 				  unsigned int offset,
 				  struct ext4_dir_entry_2 **res_dir)
 {
-	return ext4_search_dir(bh, bh->b_data, dir->i_sb->s_blocksize, dir,
+	return ext4_search_dir(bh, bh->b_data, inode_sb(dir)->s_blocksize,
+			       dir,
 			       fname, offset, res_dir);
 }
 
@@ -1300,7 +1301,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		}
 		/* prevent looping on a bad block */
 		de_len = ext4_rec_len_from_disk(de->rec_len,
-						dir->i_sb->s_blocksize);
+						inode_sb(dir)->s_blocksize);
 		if (de_len <= 0)
 			return -1;
 		offset += de_len;
@@ -1312,7 +1313,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 			       struct ext4_dir_entry *de)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	if (!is_dx(dir))
 		return 0;
@@ -1355,7 +1356,7 @@ static struct buffer_head * ext4_find_entry (struct inode *dir,
 	struct ext4_filename fname;
 
 	*res_dir = NULL;
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	namelen = d_name->len;
 	if (namelen > EXT4_NAME_LEN)
 		return NULL;
@@ -1490,7 +1491,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
 			struct ext4_dir_entry_2 **res_dir)
 {
-	struct super_block * sb = dir->i_sb;
+	struct super_block * sb = inode_sb(dir);
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
 	struct buffer_head *bh;
 	ext4_lblk_t block;
@@ -1560,7 +1561,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 	if (bh) {
 		__u32 ino = le32_to_cpu(de->inode);
 		brelse(bh);
-		if (!ext4_valid_inum(dir->i_sb, ino)) {
+		if (!ext4_valid_inum(inode_sb(dir), ino)) {
 			EXT4_ERROR_INODE(dir, "bad inode number: %u", ino);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
@@ -1569,7 +1570,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 					 dentry);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
-		inode = ext4_iget_normal(dir->i_sb, ino);
+		inode = ext4_iget_normal(inode_sb(dir), ino);
 		if (inode == ERR_PTR(-ESTALE)) {
 			EXT4_ERROR_INODE(dir,
 					 "deleted inode referenced: %u",
@@ -1579,7 +1580,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		if (!IS_ERR(inode) && ext4_encrypted_inode(dir) &&
 		    (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 		    !fscrypt_has_permitted_context(dir, inode)) {
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "Inconsistent encryption contexts: %lu/%lu",
 				     dir->i_ino, inode->i_ino);
 			iput(inode);
@@ -1672,7 +1673,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 			struct buffer_head **bh,struct dx_frame *frame,
 			struct dx_hash_info *hinfo)
 {
-	unsigned blocksize = dir->i_sb->s_blocksize;
+	unsigned blocksize = inode_sb(dir)->s_blocksize;
 	unsigned count, continued;
 	struct buffer_head *bh2;
 	ext4_lblk_t newblock;
@@ -1685,7 +1686,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	int	csum_size = 0;
 	int	err = 0, i;
 
-	if (ext4_has_metadata_csum(dir->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(dir)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	bh2 = ext4_append(handle, dir, &newblock);
@@ -1774,7 +1775,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	brelse(*bh);
 	brelse(bh2);
 	*bh = NULL;
-	ext4_std_error(dir->i_sb, err);
+	ext4_std_error(inode_sb(dir), err);
 	return ERR_PTR(err);
 }
 
@@ -1831,7 +1832,7 @@ void ext4_insert_dentry(struct inode *inode,
 	}
 	de->file_type = EXT4_FT_UNKNOWN;
 	de->inode = cpu_to_le32(inode->i_ino);
-	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
+	ext4_set_de_type(inode_sb(inode), de, inode->i_mode);
 	de->name_len = fname_len(fname);
 	memcpy(de->name, fname_name(fname), fname_len(fname));
 }
@@ -1849,11 +1850,11 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *inode, struct ext4_dir_entry_2 *de,
 			     struct buffer_head *bh)
 {
-	unsigned int	blocksize = dir->i_sb->s_blocksize;
+	unsigned int	blocksize = inode_sb(dir)->s_blocksize;
 	int		csum_size = 0;
 	int		err;
 
-	if (ext4_has_metadata_csum(inode->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(inode)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (!de) {
@@ -1865,7 +1866,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	BUFFER_TRACE(bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, bh);
 	if (err) {
-		ext4_std_error(dir->i_sb, err);
+		ext4_std_error(inode_sb(dir), err);
 		return err;
 	}
 
@@ -1890,7 +1891,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
 	err = ext4_handle_dirty_dirent_node(handle, dir, bh);
 	if (err)
-		ext4_std_error(dir->i_sb, err);
+		ext4_std_error(inode_sb(dir), err);
 	return 0;
 }
 
@@ -1916,15 +1917,15 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	struct fake_dirent *fde;
 	int csum_size = 0;
 
-	if (ext4_has_metadata_csum(inode->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(inode)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
-	blocksize =  dir->i_sb->s_blocksize;
+	blocksize =  inode_sb(dir)->s_blocksize;
 	dxtrace(printk(KERN_DEBUG "Creating index: inode %lu\n", dir->i_ino));
 	BUFFER_TRACE(bh, "get_write_access");
 	retval = ext4_journal_get_write_access(handle, bh);
 	if (retval) {
-		ext4_std_error(dir->i_sb, retval);
+		ext4_std_error(inode_sb(dir), retval);
 		brelse(bh);
 		return retval;
 	}
@@ -1970,7 +1971,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 					   blocksize);
 	memset (&root->info, 0, sizeof(root->info));
 	root->info.info_length = sizeof(root->info);
-	root->info.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	root->info.hash_version = EXT4_SB(inode_sb(dir))->s_def_hash_version;
 	entries = root->entries;
 	dx_set_block(entries, 1);
 	dx_set_count(entries, 1);
@@ -1979,8 +1980,8 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	/* Initialize as for dx_probe */
 	fname->hinfo.hash_version = root->info.hash_version;
 	if (fname->hinfo.hash_version <= DX_HASH_TEA)
-		fname->hinfo.hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
-	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+		fname->hinfo.hash_version += EXT4_SB(inode_sb(dir))->s_hash_unsigned;
+	fname->hinfo.seed = EXT4_SB(inode_sb(dir))->s_hash_seed;
 	ext4fs_dirhash(fname_name(fname), fname_len(fname), &fname->hinfo);
 
 	memset(frames, 0, sizeof(frames));
@@ -2041,10 +2042,10 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	ext4_lblk_t block, blocks;
 	int	csum_size = 0;
 
-	if (ext4_has_metadata_csum(inode->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(inode)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
-	sb = dir->i_sb;
+	sb = inode_sb(dir);
 	blocksize = sb->s_blocksize;
 	if (!dentry->d_name.len)
 		return -EINVAL;
@@ -2126,7 +2127,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
 	struct dx_entry *entries, *at;
 	struct buffer_head *bh;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct ext4_dir_entry_2 *de;
 	int restart;
 	int err;
@@ -2279,7 +2280,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	goto cleanup;
 
 journal_error:
-	ext4_std_error(dir->i_sb, err); /* this is a no-op if err == 0 */
+	ext4_std_error(inode_sb(dir), err); /* this is a no-op if err == 0 */
 cleanup:
 	brelse(bh);
 	dx_release(frames);
@@ -2304,7 +2305,7 @@ int ext4_generic_delete_entry(handle_t *handle,
 			      int csum_size)
 {
 	struct ext4_dir_entry_2 *de, *pde;
-	unsigned int blocksize = dir->i_sb->s_blocksize;
+	unsigned int blocksize = inode_sb(dir)->s_blocksize;
 	int i;
 
 	i = 0;
@@ -2349,7 +2350,7 @@ static int ext4_delete_entry(handle_t *handle,
 			return err;
 	}
 
-	if (ext4_has_metadata_csum(dir->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(dir)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	BUFFER_TRACE(bh, "get_write_access");
@@ -2359,7 +2360,7 @@ static int ext4_delete_entry(handle_t *handle,
 
 	err = ext4_generic_delete_entry(handle, dir, de_del,
 					bh, bh->b_data,
-					dir->i_sb->s_blocksize, csum_size);
+					inode_sb(dir)->s_blocksize, csum_size);
 	if (err)
 		goto out;
 
@@ -2371,7 +2372,7 @@ static int ext4_delete_entry(handle_t *handle,
 	return 0;
 out:
 	if (err != -ENOENT)
-		ext4_std_error(dir->i_sb, err);
+		ext4_std_error(inode_sb(dir), err);
 	return err;
 }
 
@@ -2440,7 +2441,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (err)
 		return err;
 
-	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+	credits = (EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
 	inode = ext4_new_inode_start_handle(dir, mode, &dentry->d_name, 0,
@@ -2457,7 +2458,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	}
 	if (handle)
 		ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode_sb(dir), &retries))
 		goto retry;
 	return err;
 }
@@ -2473,7 +2474,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	if (err)
 		return err;
 
-	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+	credits = (EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
 	inode = ext4_new_inode_start_handle(dir, mode, &dentry->d_name, 0,
@@ -2489,7 +2490,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	}
 	if (handle)
 		ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode_sb(dir), &retries))
 		goto retry;
 	return err;
 }
@@ -2508,8 +2509,8 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	inode = ext4_new_inode_start_handle(dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
-			  4 + EXT4_XATTR_TRANS_BLOCKS);
+			EXT4_MAXQUOTAS_INIT_BLOCKS(inode_sb(dir)) +
+			4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
 	if (!IS_ERR(inode)) {
@@ -2525,7 +2526,7 @@ static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	}
 	if (handle)
 		ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode_sb(dir), &retries))
 		goto retry;
 	return err;
 err_unlock_inode:
@@ -2544,7 +2545,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->rec_len = ext4_rec_len_to_disk(EXT4_DIR_REC_LEN(de->name_len),
 					   blocksize);
 	strcpy(de->name, ".");
-	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
+	ext4_set_de_type(inode_sb(inode), de, S_IFDIR);
 
 	de = ext4_next_entry(de, blocksize);
 	de->inode = cpu_to_le32(parent_ino);
@@ -2557,7 +2558,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 		de->rec_len = ext4_rec_len_to_disk(
 				EXT4_DIR_REC_LEN(de->name_len), blocksize);
 	strcpy(de->name, "..");
-	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
+	ext4_set_de_type(inode_sb(inode), de, S_IFDIR);
 
 	return ext4_next_entry(de, blocksize);
 }
@@ -2569,11 +2570,11 @@ static int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	struct ext4_dir_entry_2 *de;
 	struct ext4_dir_entry_tail *t;
 	ext4_lblk_t block = 0;
-	unsigned int blocksize = dir->i_sb->s_blocksize;
+	unsigned int blocksize = inode_sb(dir)->s_blocksize;
 	int csum_size = 0;
 	int err;
 
-	if (ext4_has_metadata_csum(dir->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(dir)))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
@@ -2619,7 +2620,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (err)
 		return err;
 
-	credits = (EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+	credits = (EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3);
 retry:
 	inode = ext4_new_inode_start_handle(dir, S_IFDIR | mode,
@@ -2659,7 +2660,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 out_stop:
 	if (handle)
 		ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode_sb(dir), &retries))
 		goto retry;
 	return err;
 }
@@ -2683,7 +2684,7 @@ bool ext4_empty_dir(struct inode *inode)
 			return ret;
 	}
 
-	sb = inode->i_sb;
+	sb = inode_sb(inode);
 	if (inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2)) {
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
@@ -2746,7 +2747,7 @@ bool ext4_empty_dir(struct inode *inode)
  */
 int ext4_orphan_add(handle_t *handle, struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_iloc iloc;
 	int err = 0, rc;
@@ -2829,7 +2830,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 {
 	struct list_head *prev;
 	struct ext4_inode_info *ei = EXT4_I(inode);
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	__u32 ino_next;
 	struct ext4_iloc iloc;
 	int err = 0;
@@ -2874,7 +2875,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		}
 		sbi->s_es->s_last_orphan = cpu_to_le32(ino_next);
 		mutex_unlock(&sbi->s_orphan_lock);
-		err = ext4_handle_dirty_super(handle, inode->i_sb);
+		err = ext4_handle_dirty_super(handle, inode_sb(inode));
 	} else {
 		struct ext4_iloc iloc2;
 		struct inode *i_prev =
@@ -2896,7 +2897,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	NEXT_ORPHAN(inode) = 0;
 	err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 out_err:
-	ext4_std_error(inode->i_sb, err);
+	ext4_std_error(inode_sb(inode), err);
 	return err;
 
 out_brelse:
@@ -2912,7 +2913,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(dir)))))
 		return -EIO;
 
 	/* Initialize quotas before so that eventual writes go in
@@ -2942,7 +2943,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		goto end_rmdir;
 
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
+				    EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)));
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
 		handle = NULL;
@@ -2988,7 +2989,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(dir)))))
 		return -EIO;
 
 	trace_ext4_unlink_enter(dir, dentry);
@@ -3015,7 +3016,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		goto end_unlink;
 
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
+				    EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)));
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
 		handle = NULL;
@@ -3059,10 +3060,11 @@ static int ext4_symlink(struct inode *dir,
 	int credits;
 	struct fscrypt_str disk_link;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(dir)))))
 		return -EIO;
 
-	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
+	err = fscrypt_prepare_symlink(dir, symname, len,
+				      inode_sb(dir)->s_blocksize,
 				      &disk_link);
 	if (err)
 		return err;
@@ -3078,7 +3080,7 @@ static int ext4_symlink(struct inode *dir,
 		 * group descriptor, sb, inode block, quota blocks, and
 		 * possibly selinux xattr blocks.
 		 */
-		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(inode_sb(dir)) +
 			  EXT4_XATTR_TRANS_BLOCKS;
 	} else {
 		/*
@@ -3087,7 +3089,7 @@ static int ext4_symlink(struct inode *dir,
 		 * allocate new inode (bitmap, group descriptor, inode block,
 		 * quota blocks, sb is already counted in previous macros).
 		 */
-		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+		credits = EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
 	}
 
@@ -3137,7 +3139,7 @@ static int ext4_symlink(struct inode *dir,
 		 * + EXT4_INDEX_EXTRA_TRANS_BLOCKS), inode is also modified
 		 */
 		handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+				EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 				EXT4_INDEX_EXTRA_TRANS_BLOCKS + 1);
 		if (IS_ERR(handle)) {
 			err = PTR_ERR(handle);
@@ -3205,7 +3207,7 @@ static int ext4_link(struct dentry *old_dentry,
 
 retry:
 	handle = ext4_journal_start(dir, EXT4_HT_DIR,
-		(EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
+		(EXT4_DATA_TRANS_BLOCKS(inode_sb(dir)) +
 		 EXT4_INDEX_EXTRA_TRANS_BLOCKS) + 1);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -3231,7 +3233,7 @@ static int ext4_link(struct dentry *old_dentry,
 		iput(inode);
 	}
 	ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(dir->i_sb, &retries))
+	if (err == -ENOSPC && ext4_should_retry_alloc(inode_sb(dir), &retries))
 		goto retry;
 	return err;
 }
@@ -3258,7 +3260,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		}
 		*parent_de = ext4_next_entry(
 					(struct ext4_dir_entry_2 *)bh->b_data,
-					inode->i_sb->s_blocksize);
+					inode_sb(inode)->s_blocksize);
 		return bh;
 	}
 
@@ -3320,7 +3322,7 @@ static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_mark_inode_dirty(handle, ent->inode);
 	}
 	if (retval) {
-		ext4_std_error(ent->dir->i_sb, retval);
+		ext4_std_error(inode_sb(ent->dir), retval);
 		return retval;
 	}
 	return 0;
@@ -3336,7 +3338,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	if (retval)
 		return retval;
 	ent->de->inode = cpu_to_le32(ino);
-	if (ext4_has_feature_filetype(ent->dir->i_sb))
+	if (ext4_has_feature_filetype(inode_sb(ent->dir)))
 		ent->de->file_type = file_type;
 	inode_inc_iversion(ent->dir);
 	ent->dir->i_ctime = ent->dir->i_mtime =
@@ -3347,7 +3349,7 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_handle_dirty_dirent_node(handle,
 						       ent->dir, ent->bh);
 		if (unlikely(retval)) {
-			ext4_std_error(ent->dir->i_sb, retval);
+			ext4_std_error(inode_sb(ent->dir), retval);
 			return retval;
 		}
 	}
@@ -3428,7 +3430,7 @@ static struct inode *ext4_whiteout_for_rename(struct ext4_renament *ent,
 	 * for inode block, sb block, group summaries,
 	 * and inode bitmap
 	 */
-	credits += (EXT4_MAXQUOTAS_TRANS_BLOCKS(ent->dir->i_sb) +
+	credits += (EXT4_MAXQUOTAS_TRANS_BLOCKS(inode_sb(ent->dir)) +
 		    EXT4_XATTR_TRANS_BLOCKS + 4);
 retry:
 	wh = ext4_new_inode_start_handle(ent->dir, S_IFCHR | WHITEOUT_MODE,
@@ -3440,7 +3442,7 @@ static struct inode *ext4_whiteout_for_rename(struct ext4_renament *ent,
 		if (handle)
 			ext4_journal_stop(handle);
 		if (PTR_ERR(wh) == -ENOSPC &&
-		    ext4_should_retry_alloc(ent->dir->i_sb, &retries))
+		    ext4_should_retry_alloc(inode_sb(ent->dir), &retries))
 			goto retry;
 	} else {
 		*h = handle;
@@ -3525,10 +3527,10 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			new.bh = NULL;
 		}
 	}
-	if (new.inode && !test_opt(new.dir->i_sb, NO_AUTO_DA_ALLOC))
+	if (new.inode && !test_opt(inode_sb(new.dir), NO_AUTO_DA_ALLOC))
 		ext4_alloc_da_blocks(old.inode);
 
-	credits = (2 * EXT4_DATA_TRANS_BLOCKS(old.dir->i_sb) +
+	credits = (2 * EXT4_DATA_TRANS_BLOCKS(inode_sb(old.dir)) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 2);
 	if (!(flags & RENAME_WHITEOUT)) {
 		handle = ext4_journal_start(old.dir, EXT4_HT_DIR, credits);
@@ -3719,7 +3721,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	handle = ext4_journal_start(old.dir, EXT4_HT_DIR,
-		(2 * EXT4_DATA_TRANS_BLOCKS(old.dir->i_sb) +
+		(2 * EXT4_DATA_TRANS_BLOCKS(inode_sb(old.dir)) +
 		 2 * EXT4_INDEX_EXTRA_TRANS_BLOCKS + 2));
 	if (IS_ERR(handle)) {
 		retval = PTR_ERR(handle);
@@ -3805,7 +3807,7 @@ static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(old_dir)))))
 		return -EIO;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index db7590178dfc..fb8493a31e94 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -158,8 +158,8 @@ static int ext4_end_io(ext4_io_end_t *io)
 
 	io->handle = NULL;	/* Following call will use up the handle */
 	ret = ext4_convert_unwritten_extents(handle, inode, offset, size);
-	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
-		ext4_msg(inode->i_sb, KERN_EMERG,
+	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))) {
+		ext4_msg(inode_sb(inode), KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
 			 "(inode %lu, offset %llu, size %zd, error %d)",
@@ -197,7 +197,7 @@ static void dump_completed_IO(struct inode *inode, struct list_head *head)
 static void ext4_add_complete_io(ext4_io_end_t *io_end)
 {
 	struct ext4_inode_info *ei = EXT4_I(io_end->inode);
-	struct ext4_sb_info *sbi = EXT4_SB(io_end->inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(io_end->inode));
 	struct workqueue_struct *wq;
 	unsigned long flags;
 
@@ -314,7 +314,8 @@ static void ext4_end_bio(struct bio *bio)
 	if (bio->bi_status) {
 		struct inode *inode = io_end->inode;
 
-		ext4_warning(inode->i_sb, "I/O error %d writing to inode %lu "
+		ext4_warning(inode_sb(inode),
+			     "I/O error %d writing to inode %lu "
 			     "(offset %llu size %ld starting block %llu)",
 			     bio->bi_status, inode->i_ino,
 			     (unsigned long long) io_end->offset,
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 9ffa6fad18db..7cfb7bd0fe1d 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -112,7 +112,7 @@ int ext4_mpage_readpages(struct address_space *mapping,
 	sector_t last_block_in_file;
 	sector_t blocks[MAX_BUF_PER_PAGE];
 	unsigned page_block;
-	struct block_device *bdev = inode->i_sb->s_bdev;
+	struct block_device *bdev = inode_sb(inode)->s_bdev;
 	int length;
 	unsigned relative_block = 0;
 	struct ext4_map_blocks map;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index b6bec270a8e4..c1cf292c62fc 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -776,7 +776,7 @@ static int verify_reserved_gdb(struct super_block *sb,
 static int add_new_gdb(handle_t *handle, struct inode *inode,
 		       ext4_group_t group)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	unsigned long gdb_num = group / EXT4_DESC_PER_BLOCK(sb);
 	ext4_fsblk_t gdblock = EXT4_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
@@ -957,7 +957,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 static int reserve_backup_gdb(handle_t *handle, struct inode *inode,
 			      ext4_group_t group)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int reserved_gdb =le16_to_cpu(EXT4_SB(sb)->s_es->s_reserved_gdt_blocks);
 	int cluster_bits = EXT4_SB(sb)->s_cluster_bits;
 	struct buffer_head **primary;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 39bf464c35f1..144095b55900 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -467,31 +467,33 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 {
 	va_list args;
 	struct va_format vaf;
-	struct ext4_super_block *es = EXT4_SB(inode->i_sb)->s_es;
+	struct ext4_super_block *es = EXT4_SB(inode_sb(inode))->s_es;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return;
 
 	es->s_last_error_ino = cpu_to_le32(inode->i_ino);
 	es->s_last_error_block = cpu_to_le64(block);
-	if (ext4_error_ratelimit(inode->i_sb)) {
+	if (ext4_error_ratelimit(inode_sb(inode))) {
 		va_start(args, fmt);
 		vaf.fmt = fmt;
 		vaf.va = &args;
 		if (block)
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
 			       "inode #%lu: block %llu: comm %s: %pV\n",
-			       inode->i_sb->s_id, function, line, inode->i_ino,
+			       inode_sb(inode)->s_id, function, line,
+			       inode->i_ino,
 			       block, current->comm, &vaf);
 		else
 			printk(KERN_CRIT "EXT4-fs error (device %s): %s:%d: "
 			       "inode #%lu: comm %s: %pV\n",
-			       inode->i_sb->s_id, function, line, inode->i_ino,
+			       inode_sb(inode)->s_id, function, line,
+			       inode->i_ino,
 			       current->comm, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, function, line);
-	ext4_handle_error(inode->i_sb);
+	save_error_info(inode_sb(inode), function, line);
+	ext4_handle_error(inode_sb(inode));
 }
 
 void __ext4_error_file(struct file *file, const char *function,
@@ -504,12 +506,12 @@ void __ext4_error_file(struct file *file, const char *function,
 	struct inode *inode = file_inode(file);
 	char pathname[80], *path;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return;
 
-	es = EXT4_SB(inode->i_sb)->s_es;
+	es = EXT4_SB(inode_sb(inode))->s_es;
 	es->s_last_error_ino = cpu_to_le32(inode->i_ino);
-	if (ext4_error_ratelimit(inode->i_sb)) {
+	if (ext4_error_ratelimit(inode_sb(inode))) {
 		path = file_path(file, pathname, sizeof(pathname));
 		if (IS_ERR(path))
 			path = "(unknown)";
@@ -520,18 +522,20 @@ void __ext4_error_file(struct file *file, const char *function,
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
 			       "block %llu: comm %s: path %s: %pV\n",
-			       inode->i_sb->s_id, function, line, inode->i_ino,
+			       inode_sb(inode)->s_id, function, line,
+			       inode->i_ino,
 			       block, current->comm, path, &vaf);
 		else
 			printk(KERN_CRIT
 			       "EXT4-fs error (device %s): %s:%d: inode #%lu: "
 			       "comm %s: path %s: %pV\n",
-			       inode->i_sb->s_id, function, line, inode->i_ino,
+			       inode_sb(inode)->s_id, function, line,
+			       inode->i_ino,
 			       current->comm, path, &vaf);
 		va_end(args);
 	}
-	save_error_info(inode->i_sb, function, line);
-	ext4_handle_error(inode->i_sb);
+	save_error_info(inode_sb(inode), function, line);
+	ext4_handle_error(inode_sb(inode));
 }
 
 const char *ext4_decode_error(struct super_block *sb, int errno,
@@ -693,14 +697,14 @@ void __ext4_warning_inode(const struct inode *inode, const char *function,
 	struct va_format vaf;
 	va_list args;
 
-	if (!ext4_warning_ratelimit(inode->i_sb))
+	if (!ext4_warning_ratelimit(inode_sb(inode)))
 		return;
 
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
 	printk(KERN_WARNING "EXT4-fs warning (device %s): %s:%d: "
-	       "inode #%lu: comm %s: %pV\n", inode->i_sb->s_id,
+	       "inode #%lu: comm %s: %pV\n", inode_sb(inode)->s_id,
 	       function, line, inode->i_ino, current->comm, &vaf);
 	va_end(args);
 }
@@ -840,7 +844,7 @@ static void dump_orphan_list(struct super_block *sb, struct ext4_sb_info *sbi)
 		struct inode *inode = orphan_list_entry(l);
 		printk(KERN_ERR "  "
 		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
-		       inode->i_sb->s_id, inode->i_ino, inode,
+		       inode_sb(inode)->s_id, inode->i_ino, inode,
 		       inode->i_mode, inode->i_nlink,
 		       NEXT_ORPHAN(inode));
 	}
@@ -1014,7 +1018,7 @@ static void ext4_i_callback(struct rcu_head *head)
 static void ext4_destroy_inode(struct inode *inode)
 {
 	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
-		ext4_msg(inode->i_sb, KERN_ERR,
+		ext4_msg(inode_sb(inode), KERN_ERR,
 			 "Inode %lu (%p): orphan list check failed!",
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
@@ -1223,7 +1227,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	}
 	res2 = ext4_journal_stop(handle);
 
-	if (res == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (res == -ENOSPC && ext4_should_retry_alloc(inode_sb(inode), &retries))
 		goto retry;
 	if (!res)
 		res = res2;
@@ -1232,13 +1236,13 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 
 static bool ext4_dummy_context(struct inode *inode)
 {
-	return DUMMY_ENCRYPTION_ENABLED(EXT4_SB(inode->i_sb));
+	return DUMMY_ENCRYPTION_ENABLED(EXT4_SB(inode_sb(inode)));
 }
 
 static unsigned ext4_max_namelen(struct inode *inode)
 {
-	return S_ISLNK(inode->i_mode) ? inode->i_sb->s_blocksize :
-		EXT4_NAME_LEN;
+	return S_ISLNK(inode->i_mode) ? inode_sb(inode)->s_blocksize :
+			EXT4_NAME_LEN;
 }
 
 static const struct fscrypt_operations ext4_cryptops = {
@@ -2509,7 +2513,7 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 			truncate_inode_pages(inode->i_mapping, inode->i_size);
 			ret = ext4_truncate(inode);
 			if (ret)
-				ext4_std_error(inode->i_sb, ret);
+				ext4_std_error(inode_sb(inode), ret);
 			inode_unlock(inode);
 			nr_truncates++;
 		} else {
@@ -5674,7 +5678,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 				EXT4_GET_BLOCKS_CREATE |
 				EXT4_GET_BLOCKS_METADATA_NOFAIL);
 	} while (IS_ERR(bh) && (PTR_ERR(bh) == -ENOSPC) &&
-		 ext4_should_retry_alloc(inode->i_sb, &retries));
+		 ext4_should_retry_alloc(inode_sb(inode), &retries));
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
index dd05af983092..bae9b69192e9 100644
--- a/fs/ext4/symlink.c
+++ b/fs/ext4/symlink.c
@@ -43,7 +43,7 @@ static const char *ext4_encrypted_get_link(struct dentry *dentry,
 		if (IS_ERR(cpage))
 			return ERR_CAST(cpage);
 		caddr = page_address(cpage);
-		max_size = inode->i_sb->s_blocksize;
+		max_size = inode_sb(inode)->s_blocksize;
 	}
 
 	paddr = fscrypt_get_symlink(inode, caddr, max_size, done);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 1205261f130c..d36b4f0a3bf7 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -52,7 +52,7 @@ struct ext4_attr {
 static ssize_t session_write_kbytes_show(struct ext4_attr *a,
 					 struct ext4_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->s_buddy_cache->i_sb;
+	struct super_block *sb = inode_sb(sbi->s_buddy_cache);
 
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
@@ -64,7 +64,7 @@ static ssize_t session_write_kbytes_show(struct ext4_attr *a,
 static ssize_t lifetime_write_kbytes_show(struct ext4_attr *a,
 					  struct ext4_sb_info *sbi, char *buf)
 {
-	struct super_block *sb = sbi->s_buddy_cache->i_sb;
+	struct super_block *sb = inode_sb(sbi->s_buddy_cache);
 
 	if (!sb->s_bdev->bd_part)
 		return snprintf(buf, PAGE_SIZE, "0\n");
diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
index 0cb13badf473..aa73c6ec827b 100644
--- a/fs/ext4/truncate.h
+++ b/fs/ext4/truncate.h
@@ -25,7 +25,7 @@ static inline unsigned long ext4_blocks_for_truncate(struct inode *inode)
 {
 	ext4_lblk_t needed;
 
-	needed = inode->i_blocks >> (inode->i_sb->s_blocksize_bits - 9);
+	needed = inode->i_blocks >> (inode_sb(inode)->s_blocksize_bits - 9);
 
 	/* Give ourselves just enough room to cope with inodes in which
 	 * i_blocks is corrupt: we've seen disk corruptions in the past
@@ -41,6 +41,6 @@ static inline unsigned long ext4_blocks_for_truncate(struct inode *inode)
 	if (needed > EXT4_MAX_TRANS_DATA)
 		needed = EXT4_MAX_TRANS_DATA;
 
-	return EXT4_DATA_TRANS_BLOCKS(inode->i_sb) + needed;
+	return EXT4_DATA_TRANS_BLOCKS(inode_sb(inode)) + needed;
 }
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 63656dbafdc4..26211c1db4cc 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -65,7 +65,8 @@
 #ifdef EXT4_XATTR_DEBUG
 # define ea_idebug(inode, fmt, ...)					\
 	printk(KERN_DEBUG "inode %s:%lu: " fmt "\n",			\
-	       inode->i_sb->s_id, inode->i_ino, ##__VA_ARGS__)
+	       inode_sb(inode)->s_id, inode->i_ino,
+	       ##__VA_ARGS__)
 # define ea_bdebug(bh, fmt, ...)					\
 	printk(KERN_DEBUG "block %pg:%lu: " fmt "\n",			\
 	       bh->b_bdev, (unsigned long)bh->b_blocknr, ##__VA_ARGS__)
@@ -109,10 +110,10 @@ const struct xattr_handler *ext4_xattr_handlers[] = {
 };
 
 #define EA_BLOCK_CACHE(inode)	(((struct ext4_sb_info *) \
-				inode->i_sb->s_fs_info)->s_ea_block_cache)
+				inode_sb(inode)->s_fs_info)->s_ea_block_cache)
 
 #define EA_INODE_CACHE(inode)	(((struct ext4_sb_info *) \
-				inode->i_sb->s_fs_info)->s_ea_inode_cache)
+				inode_sb(inode)->s_fs_info)->s_ea_inode_cache)
 
 static int
 ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
@@ -129,7 +130,7 @@ static __le32 ext4_xattr_block_csum(struct inode *inode,
 				    sector_t block_nr,
 				    struct ext4_xattr_header *hdr)
 {
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	__u32 csum;
 	__le64 dsk_block_nr = cpu_to_le64(block_nr);
 	__u32 dummy_csum = 0;
@@ -141,7 +142,7 @@ static __le32 ext4_xattr_block_csum(struct inode *inode,
 	csum = ext4_chksum(sbi, csum, (__u8 *)&dummy_csum, sizeof(dummy_csum));
 	offset += sizeof(dummy_csum);
 	csum = ext4_chksum(sbi, csum, (__u8 *)hdr + offset,
-			   EXT4_BLOCK_SIZE(inode->i_sb) - offset);
+			   EXT4_BLOCK_SIZE(inode_sb(inode)) - offset);
 
 	return cpu_to_le32(csum);
 }
@@ -152,7 +153,7 @@ static int ext4_xattr_block_csum_verify(struct inode *inode,
 	struct ext4_xattr_header *hdr = BHDR(bh);
 	int ret = 1;
 
-	if (ext4_has_metadata_csum(inode->i_sb)) {
+	if (ext4_has_metadata_csum(inode_sb(inode))) {
 		lock_buffer(bh);
 		ret = (hdr->h_checksum == ext4_xattr_block_csum(inode,
 							bh->b_blocknr, hdr));
@@ -164,7 +165,7 @@ static int ext4_xattr_block_csum_verify(struct inode *inode,
 static void ext4_xattr_block_csum_set(struct inode *inode,
 				      struct buffer_head *bh)
 {
-	if (ext4_has_metadata_csum(inode->i_sb))
+	if (ext4_has_metadata_csum(inode_sb(inode)))
 		BHDR(bh)->h_checksum = ext4_xattr_block_csum(inode,
 						bh->b_blocknr, BHDR(bh));
 }
@@ -364,17 +365,17 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 	struct inode *inode;
 	int err;
 
-	inode = ext4_iget(parent->i_sb, ea_ino);
+	inode = ext4_iget(inode_sb(parent), ea_ino);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-		ext4_error(parent->i_sb,
+		ext4_error(inode_sb(parent),
 			   "error while reading EA inode %lu err=%d", ea_ino,
 			   err);
 		return err;
 	}
 
 	if (is_bad_inode(inode)) {
-		ext4_error(parent->i_sb,
+		ext4_error(inode_sb(parent),
 			   "error while reading EA inode %lu is_bad_inode",
 			   ea_ino);
 		err = -EIO;
@@ -382,7 +383,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 	}
 
 	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
-		ext4_error(parent->i_sb,
+		ext4_error(inode_sb(parent),
 			   "EA inode %lu does not have EXT4_EA_INODE_FL flag",
 			    ea_ino);
 		err = -EINVAL;
@@ -422,7 +423,8 @@ ext4_xattr_inode_verify_hashes(struct inode *ea_inode,
 	u32 hash;
 
 	/* Verify stored hash matches calculated hash. */
-	hash = ext4_xattr_inode_hash(EXT4_SB(ea_inode->i_sb), buffer, size);
+	hash = ext4_xattr_inode_hash(EXT4_SB(inode_sb(ea_inode)), buffer,
+				     size);
 	if (hash != ext4_xattr_inode_get_hash(ea_inode))
 		return -EFSCORRUPTED;
 
@@ -506,7 +508,7 @@ ext4_xattr_block_get(struct inode *inode, int name_index, const char *name,
 		goto cleanup;
 	ea_idebug(inode, "reading block %llu",
 		  (unsigned long long)EXT4_I(inode)->i_file_acl);
-	bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 	if (!bh)
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
@@ -563,7 +565,7 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = (void *)raw_inode + EXT4_SB(inode_sb(inode))->s_inode_size;
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -609,7 +611,7 @@ ext4_xattr_get(struct inode *inode, int name_index, const char *name,
 {
 	int error;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode_sb(inode)))))
 		return -EIO;
 
 	if (strlen(name) > 255)
@@ -670,7 +672,7 @@ ext4_xattr_block_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		goto cleanup;
 	ea_idebug(inode, "reading block %llu",
 		  (unsigned long long)EXT4_I(inode)->i_file_acl);
-	bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
 		goto cleanup;
@@ -708,7 +710,7 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = (void *)raw_inode + EXT4_SB(inode_sb(inode))->s_inode_size;
 	error = xattr_check_inode(inode, header, end);
 	if (error)
 		goto cleanup;
@@ -790,7 +792,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+		end = (void *)raw_inode + EXT4_SB(inode_sb(inode))->s_inode_size;
 		ret = xattr_check_inode(inode, header, end);
 		if (ret)
 			goto out;
@@ -802,7 +804,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	}
 
 	if (EXT4_I(inode)->i_file_acl) {
-		bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+		bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 		if (!bh) {
 			ret = -EIO;
 			goto out;
@@ -828,7 +830,7 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 
 static inline size_t round_up_cluster(struct inode *inode, size_t length)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	size_t cluster_size = 1 << (EXT4_SB(sb)->s_cluster_bits +
 				    inode->i_blkbits);
 	size_t mask = ~(cluster_size - 1);
@@ -959,7 +961,8 @@ static int ext4_xattr_ensure_credits(handle_t *handle, struct inode *inode,
 	if (!error)
 		return 0;
 	if (error < 0) {
-		ext4_warning(inode->i_sb, "Extend journal (error %d)", error);
+		ext4_warning(inode_sb(inode), "Extend journal (error %d)",
+			     error);
 		return error;
 	}
 
@@ -968,7 +971,8 @@ static int ext4_xattr_ensure_credits(handle_t *handle, struct inode *inode,
 			ext4_xattr_block_csum_set(inode, bh);
 		error = ext4_handle_dirty_metadata(handle, NULL, bh);
 		if (error) {
-			ext4_warning(inode->i_sb, "Handle metadata (error %d)",
+			ext4_warning(inode_sb(inode),
+				     "Handle metadata (error %d)",
 				     error);
 			return error;
 		}
@@ -976,14 +980,15 @@ static int ext4_xattr_ensure_credits(handle_t *handle, struct inode *inode,
 
 	error = ext4_journal_restart(handle, credits);
 	if (error) {
-		ext4_warning(inode->i_sb, "Restart journal (error %d)", error);
+		ext4_warning(inode_sb(inode), "Restart journal (error %d)",
+			     error);
 		return error;
 	}
 
 	if (bh) {
 		error = ext4_journal_get_write_access(handle, bh);
 		if (error) {
-			ext4_warning(inode->i_sb,
+			ext4_warning(inode_sb(inode),
 				     "Get write access failed (error %d)",
 				     error);
 			return error;
@@ -1115,7 +1120,7 @@ static int ext4_xattr_inode_inc_ref_all(handle_t *handle, struct inode *parent,
 					    le32_to_cpu(entry->e_hash),
 					    &ea_inode);
 		if (err) {
-			ext4_warning(parent->i_sb,
+			ext4_warning(inode_sb(parent),
 				     "cleanup ea_ino %u iget error %d", ea_ino,
 				     err);
 			continue;
@@ -1244,7 +1249,7 @@ ext4_xattr_release_block(handle_t *handle, struct inode *inode,
 		get_bh(bh);
 		unlock_buffer(bh);
 
-		if (ext4_has_feature_ea_inode(inode->i_sb))
+		if (ext4_has_feature_ea_inode(inode_sb(inode)))
 			ext4_xattr_inode_dec_ref_all(handle, inode, bh,
 						     BFIRST(bh),
 						     true /* block_csum */,
@@ -1288,12 +1293,12 @@ ext4_xattr_release_block(handle_t *handle, struct inode *inode,
 			error = ext4_handle_dirty_metadata(handle, inode, bh);
 		if (IS_SYNC(inode))
 			ext4_handle_sync(handle);
-		dquot_free_block(inode, EXT4_C2B(EXT4_SB(inode->i_sb), 1));
+		dquot_free_block(inode, EXT4_C2B(EXT4_SB(inode_sb(inode)), 1));
 		ea_bdebug(bh, "refcount now=%d; releasing",
 			  le32_to_cpu(BHDR(bh)->h_refcount));
 	}
 out:
-	ext4_std_error(inode->i_sb, error);
+	ext4_std_error(inode_sb(inode), error);
 	return;
 }
 
@@ -1324,7 +1329,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 {
 	struct buffer_head *bh = NULL;
 	unsigned long block = 0;
-	int blocksize = ea_inode->i_sb->s_blocksize;
+	int blocksize = inode_sb(ea_inode)->s_blocksize;
 	int max_blocks = (bufsize + blocksize - 1) >> ea_inode->i_blkbits;
 	int csize, wsize = 0;
 	int ret = 0;
@@ -1341,7 +1346,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 		if (ret <= 0) {
 			ext4_mark_inode_dirty(handle, ea_inode);
 			if (ret == -ENOSPC &&
-			    ext4_should_retry_alloc(ea_inode->i_sb, &retries)) {
+			    ext4_should_retry_alloc(inode_sb(ea_inode), &retries)) {
 				ret = 0;
 				goto retry;
 			}
@@ -1401,7 +1406,7 @@ static struct inode *ext4_xattr_inode_create(handle_t *handle,
 	 * Let the next inode be the goal, so we try and allocate the EA inode
 	 * in the same group, or nearby one.
 	 */
-	ea_inode = ext4_new_inode(handle, inode->i_sb->s_root->d_inode,
+	ea_inode = ext4_new_inode(handle, inode_sb(inode)->s_root->d_inode,
 				  S_IFREG | 0600, NULL, inode->i_ino + 1, owner,
 				  EXT4_EA_INODE_FL);
 	if (!IS_ERR(ea_inode)) {
@@ -1457,7 +1462,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	}
 
 	while (ce) {
-		ea_inode = ext4_iget(inode->i_sb, ce->e_value);
+		ea_inode = ext4_iget(inode_sb(inode), ce->e_value);
 		if (!IS_ERR(ea_inode) &&
 		    !is_bad_inode(ea_inode) &&
 		    (EXT4_I(ea_inode)->i_flags & EXT4_EA_INODE_FL) &&
@@ -1491,7 +1496,8 @@ static int ext4_xattr_inode_lookup_create(handle_t *handle, struct inode *inode,
 	u32 hash;
 	int err;
 
-	hash = ext4_xattr_inode_hash(EXT4_SB(inode->i_sb), value, value_len);
+	hash = ext4_xattr_inode_hash(EXT4_SB(inode_sb(inode)), value,
+				     value_len);
 	ea_inode = ext4_xattr_inode_cache_find(inode, value, value_len, hash);
 	if (ea_inode) {
 		err = ext4_xattr_inode_inc_ref(handle, ea_inode);
@@ -1597,7 +1603,7 @@ static int ext4_xattr_set_entry(struct ext4_xattr_info *i,
 		 * attribute block so that a long value does not occupy the
 		 * whole space and prevent futher entries being added.
 		 */
-		if (ext4_has_feature_ea_inode(inode->i_sb) &&
+		if (ext4_has_feature_ea_inode(inode_sb(inode)) &&
 		    new_size && is_block &&
 		    (min_offs + old_size - new_size) <
 					EXT4_XATTR_BLOCK_RESERVE(inode)) {
@@ -1778,7 +1784,7 @@ static int
 ext4_xattr_block_find(struct inode *inode, struct ext4_xattr_info *i,
 		      struct ext4_xattr_block_find *bs)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int error;
 
 	ea_idebug(inode, "name=%d.%s, value=%p, value_len=%ld",
@@ -1821,7 +1827,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		     struct ext4_xattr_info *i,
 		     struct ext4_xattr_block_find *bs)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *new_bh = NULL;
 	struct ext4_xattr_search s_copy = bs->s;
 	struct ext4_xattr_search *s = &s_copy;
@@ -2158,7 +2164,7 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	header = IHDR(inode, raw_inode);
 	is->s.base = is->s.first = IFIRST(header);
 	is->s.here = is->s.first;
-	is->s.end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	is->s.end = (void *)raw_inode + EXT4_SB(inode_sb(inode))->s_inode_size;
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 		error = xattr_check_inode(inode, header, is->s.end);
 		if (error)
@@ -2257,7 +2263,7 @@ static struct buffer_head *ext4_xattr_get_block(struct inode *inode)
 
 	if (!EXT4_I(inode)->i_file_acl)
 		return NULL;
-	bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+	bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 	if (!bh)
 		return ERR_PTR(-EIO);
 	error = ext4_xattr_check_block(inode, bh);
@@ -2317,7 +2323,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 			goto cleanup;
 		}
 
-		credits = __ext4_xattr_set_credits(inode->i_sb, inode, bh,
+		credits = __ext4_xattr_set_credits(inode_sb(inode), inode, bh,
 						   value_len,
 						   flags & XATTR_CREATE);
 		brelse(bh);
@@ -2334,7 +2340,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_NEW)) {
 		struct ext4_inode *raw_inode = ext4_raw_inode(&is.iloc);
-		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
+		memset(raw_inode, 0, EXT4_SB(inode_sb(inode))->s_inode_size);
 		ext4_clear_inode_state(inode, EXT4_STATE_NEW);
 	}
 
@@ -2371,9 +2377,9 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		if (!bs.s.not_found && ext4_xattr_value_same(&bs.s, &i))
 			goto cleanup;
 
-		if (ext4_has_feature_ea_inode(inode->i_sb) &&
+		if (ext4_has_feature_ea_inode(inode_sb(inode)) &&
 		    (EXT4_XATTR_SIZE(i.value_len) >
-			EXT4_XATTR_MIN_LARGE_EA_SIZE(inode->i_sb->s_blocksize)))
+			EXT4_XATTR_MIN_LARGE_EA_SIZE(inode_sb(inode)->s_blocksize)))
 			i.in_inode = 1;
 retry_inode:
 		error = ext4_xattr_ibody_set(handle, inode, &i, &is);
@@ -2396,7 +2402,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 				 * Xattr does not fit in the block, store at
 				 * external inode if possible.
 				 */
-				if (ext4_has_feature_ea_inode(inode->i_sb) &&
+				if (ext4_has_feature_ea_inode(inode_sb(inode)) &&
 				    !i.in_inode) {
 					i.in_inode = 1;
 					goto retry_inode;
@@ -2405,7 +2411,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 		}
 	}
 	if (!error) {
-		ext4_xattr_update_super_block(handle, inode->i_sb);
+		ext4_xattr_update_super_block(handle, inode_sb(inode));
 		inode->i_ctime = current_time(inode);
 		if (!value)
 			no_expand = 0;
@@ -2434,7 +2440,7 @@ int ext4_xattr_set_credits(struct inode *inode, size_t value_len,
 
 	*credits = 0;
 
-	if (!EXT4_SB(inode->i_sb)->s_journal)
+	if (!EXT4_SB(inode_sb(inode))->s_journal)
 		return 0;
 
 	down_read(&EXT4_I(inode)->xattr_sem);
@@ -2443,7 +2449,8 @@ int ext4_xattr_set_credits(struct inode *inode, size_t value_len,
 	if (IS_ERR(bh)) {
 		err = PTR_ERR(bh);
 	} else {
-		*credits = __ext4_xattr_set_credits(inode->i_sb, inode, bh,
+		*credits = __ext4_xattr_set_credits(inode_sb(inode), inode,
+						    bh,
 						    value_len, is_create);
 		brelse(bh);
 		err = 0;
@@ -2466,7 +2473,7 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 	       const void *value, size_t value_len, int flags)
 {
 	handle_t *handle;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int error, retries = 0;
 	int credits;
 
@@ -2677,7 +2684,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 {
 	struct ext4_xattr_ibody_header *header;
 	struct buffer_head *bh;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct ext4_sb_info *sbi = EXT4_SB(inode_sb(inode));
 	static unsigned int mnt_count;
 	size_t min_offs;
 	size_t ifree, bfree;
@@ -2700,7 +2707,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 */
 
 	base = IFIRST(header);
-	end = (void *)raw_inode + EXT4_SB(inode->i_sb)->s_inode_size;
+	end = (void *)raw_inode + EXT4_SB(inode_sb(inode))->s_inode_size;
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header);
 
@@ -2717,7 +2724,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	 * EA block can hold new_extra_isize bytes.
 	 */
 	if (EXT4_I(inode)->i_file_acl) {
-		bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+		bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 		error = -EIO;
 		if (!bh)
 			goto cleanup;
@@ -2744,7 +2751,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 			goto cleanup;
 		}
 	} else {
-		bfree = inode->i_sb->s_blocksize;
+		bfree = inode_sb(inode)->s_blocksize;
 	}
 
 	error = ext4_xattr_make_inode_space(handle, inode, raw_inode,
@@ -2769,7 +2776,8 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 
 cleanup:
 	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
-		ext4_warning(inode->i_sb, "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
+		ext4_warning(inode_sb(inode),
+			     "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
 			     inode->i_ino);
 		mnt_count = le16_to_cpu(sbi->s_es->s_mnt_count);
 	}
@@ -2849,7 +2857,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 		goto cleanup;
 	}
 
-	if (ext4_has_feature_ea_inode(inode->i_sb) &&
+	if (ext4_has_feature_ea_inode(inode_sb(inode)) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
 
 		error = ext4_get_inode_loc(inode, &iloc);
@@ -2876,7 +2884,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 	}
 
 	if (EXT4_I(inode)->i_file_acl) {
-		bh = sb_bread(inode->i_sb, EXT4_I(inode)->i_file_acl);
+		bh = sb_bread(inode_sb(inode), EXT4_I(inode)->i_file_acl);
 		if (!bh) {
 			EXT4_ERROR_INODE(inode, "block %llu read error",
 					 EXT4_I(inode)->i_file_acl);
@@ -2890,7 +2898,7 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 			goto cleanup;
 		}
 
-		if (ext4_has_feature_ea_inode(inode->i_sb)) {
+		if (ext4_has_feature_ea_inode(inode_sb(inode))) {
 			for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
 			     entry = EXT4_XATTR_NEXT(entry)) {
 				if (!entry->e_value_inum)
@@ -3036,7 +3044,7 @@ ext4_xattr_block_cache_find(struct inode *inode,
 	while (ce) {
 		struct buffer_head *bh;
 
-		bh = sb_bread(inode->i_sb, ce->e_value);
+		bh = sb_bread(inode_sb(inode), ce->e_value);
 		if (!bh) {
 			EXT4_ERROR_INODE(inode, "block %lu read error",
 					 (unsigned long)ce->e_value);
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index d4546184b34b..d2d0b8d2c871 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -23,7 +23,7 @@ ext4_xattr_user_get(const struct xattr_handler *handler,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, void *buffer, size_t size)
 {
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!test_opt(inode_sb(inode), XATTR_USER))
 		return -EOPNOTSUPP;
 	return ext4_xattr_get(inode, EXT4_XATTR_INDEX_USER,
 			      name, buffer, size);
@@ -35,7 +35,7 @@ ext4_xattr_user_set(const struct xattr_handler *handler,
 		    const char *name, const void *value,
 		    size_t size, int flags)
 {
-	if (!test_opt(inode->i_sb, XATTR_USER))
+	if (!test_opt(inode_sb(inode), XATTR_USER))
 		return -EOPNOTSUPP;
 	return ext4_xattr_set(inode, EXT4_XATTR_INDEX_USER,
 			      name, value, size, flags);
-- 
2.15.1
