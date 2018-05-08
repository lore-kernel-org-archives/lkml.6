Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933323AbeEHSY5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755771AbeEHSGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:05 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 53/76] fs/ntfs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:13 -0700
Message-Id: <20180508180436.716-54-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/ntfs/aops.c    |  16 ++--
 fs/ntfs/bitmap.c  |  11 ++-
 fs/ntfs/dir.c     |  10 ++-
 fs/ntfs/file.c    |  30 ++++---
 fs/ntfs/inode.c   | 231 +++++++++++++++++++++++++++++++++---------------------
 fs/ntfs/inode.h   |   2 +-
 fs/ntfs/logfile.c |  46 ++++++-----
 fs/ntfs/namei.c   |   7 +-
 8 files changed, 214 insertions(+), 139 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 3a2e509c77c5..f8817dfdc2b8 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1400,14 +1400,16 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 			// TODO: Implement and replace this with
 			// return ntfs_write_compressed_block(page);
 			unlock_page(page);
-			ntfs_error(vi->i_sb, "Writing to compressed files is "
+			ntfs_error(inode_sb(vi),
+					"Writing to compressed files is "
 					"not supported yet.  Sorry.");
 			return -EOPNOTSUPP;
 		}
 		// TODO: Implement and remove this check.
 		if (NInoNonResident(ni) && NInoSparse(ni)) {
 			unlock_page(page);
-			ntfs_error(vi->i_sb, "Writing to sparse files is not "
+			ntfs_error(inode_sb(vi),
+					"Writing to sparse files is not "
 					"supported yet.  Sorry.");
 			return -EOPNOTSUPP;
 		}
@@ -1437,7 +1439,7 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	BUG_ON(page_has_buffers(page));
 	BUG_ON(!PageUptodate(page));
 	if (unlikely(page->index > 0)) {
-		ntfs_error(vi->i_sb, "BUG()! page->index (0x%lx) > 0.  "
+		ntfs_error(inode_sb(vi), "BUG()! page->index (0x%lx) > 0.  "
 				"Aborting write.", page->index);
 		BUG_ON(PageWriteback(page));
 		set_page_writeback(page);
@@ -1514,7 +1516,8 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 err_out:
 	if (err == -ENOMEM) {
-		ntfs_warning(vi->i_sb, "Error allocating memory. Redirtying "
+		ntfs_warning(inode_sb(vi),
+				"Error allocating memory. Redirtying "
 				"page so we try again later.");
 		/*
 		 * Put the page back on mapping->dirty_pages, but leave its
@@ -1523,7 +1526,8 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 		redirty_page_for_writepage(wbc, page);
 		err = 0;
 	} else {
-		ntfs_error(vi->i_sb, "Resident attribute write failed with "
+		ntfs_error(inode_sb(vi),
+				"Resident attribute write failed with "
 				"error %i.", err);
 		SetPageError(page);
 		NVolSetErrors(ni->vol);
@@ -1735,7 +1739,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 
 	BUG_ON(!PageUptodate(page));
 	end = ofs + ni->itype.index.block_size;
-	bh_size = VFS_I(ni)->i_sb->s_blocksize;
+	bh_size = inode_sb(VFS_I(ni))->s_blocksize;
 	spin_lock(&mapping->private_lock);
 	if (unlikely(!page_has_buffers(page))) {
 		spin_unlock(&mapping->private_lock);
diff --git a/fs/ntfs/bitmap.c b/fs/ntfs/bitmap.c
index ec130c588d2b..7584c413bdb5 100644
--- a/fs/ntfs/bitmap.c
+++ b/fs/ntfs/bitmap.c
@@ -75,7 +75,8 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 	page = ntfs_map_page(mapping, index);
 	if (IS_ERR(page)) {
 		if (!is_rollback)
-			ntfs_error(vi->i_sb, "Failed to map first page (error "
+			ntfs_error(inode_sb(vi),
+					"Failed to map first page (error "
 					"%li), aborting.", PTR_ERR(page));
 		return PTR_ERR(page);
 	}
@@ -177,15 +178,17 @@ int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
 		pos = 0;
 	if (!pos) {
 		/* Rollback was successful. */
-		ntfs_error(vi->i_sb, "Failed to map subsequent page (error "
+		ntfs_error(inode_sb(vi),
+				"Failed to map subsequent page (error "
 				"%li), aborting.", PTR_ERR(page));
 	} else {
 		/* Rollback failed. */
-		ntfs_error(vi->i_sb, "Failed to map subsequent page (error "
+		ntfs_error(inode_sb(vi),
+				"Failed to map subsequent page (error "
 				"%li) and rollback failed (error %i).  "
 				"Aborting and leaving inconsistent metadata.  "
 				"Unmount and run chkdsk.", PTR_ERR(page), pos);
-		NVolSetErrors(NTFS_SB(vi->i_sb));
+		NVolSetErrors(NTFS_SB(inode_sb(vi)));
 	}
 	return PTR_ERR(page);
 }
diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
index 1a24be9e8405..27505db99278 100644
--- a/fs/ntfs/dir.c
+++ b/fs/ntfs/dir.c
@@ -1101,7 +1101,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *actor)
 	s64 ia_pos, ia_start, prev_ia_pos, bmp_pos;
 	loff_t i_size;
 	struct inode *bmp_vi, *vdir = file_inode(file);
-	struct super_block *sb = vdir->i_sb;
+	struct super_block *sb = inode_sb(vdir);
 	ntfs_inode *ndir = NTFS_I(vdir);
 	ntfs_volume *vol = NTFS_SB(sb);
 	MFT_RECORD *m;
@@ -1517,20 +1517,22 @@ static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
 	na.type = AT_BITMAP;
 	na.name = I30;
 	na.name_len = 4;
-	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, (test_t)ntfs_test_inode, &na);
+	bmp_vi = ilookup5(inode_sb(vi), vi->i_ino, (test_t)ntfs_test_inode,
+			  &na);
 	if (bmp_vi) {
  		write_inode_now(bmp_vi, !datasync);
 		iput(bmp_vi);
 	}
 	ret = __ntfs_write_inode(vi, 1);
 	write_inode_now(vi, !datasync);
-	err = sync_blockdev(vi->i_sb->s_bdev);
+	err = sync_blockdev(inode_sb(vi)->s_bdev);
 	if (unlikely(err && !ret))
 		ret = err;
 	if (likely(!ret))
 		ntfs_debug("Done.");
 	else
-		ntfs_warning(vi->i_sb, "Failed to f%ssync inode 0x%lx.  Error "
+		ntfs_warning(inode_sb(vi),
+				"Failed to f%ssync inode 0x%lx.  Error "
 				"%u.", datasync ? "data" : "", vi->i_ino, -ret);
 	inode_unlock(vi);
 	return ret;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 331910fa8442..8955ab0c2869 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -374,7 +374,7 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 		 * compression kick in.  This is in contrast to encrypted files
 		 * (see above).
 		 */
-		ntfs_error(vi->i_sb, "Writing to compressed files is not "
+		ntfs_error(inode_sb(vi), "Writing to compressed files is not "
 				"implemented yet.  Sorry.");
 		err = -EOPNOTSUPP;
 		goto out;
@@ -439,7 +439,8 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 				iov_iter_truncate(from, ll - pos);
 			} else {
 				if (err != -ENOSPC)
-					ntfs_error(vi->i_sb, "Cannot perform "
+					ntfs_error(inode_sb(vi),
+							"Cannot perform "
 							"write to inode "
 							"0x%lx, attribute "
 							"type 0x%x, because "
@@ -479,7 +480,8 @@ static ssize_t ntfs_prepare_file_for_write(struct kiocb *iocb,
 		inode_dio_wait(vi);
 		err = ntfs_attr_extend_initialized(ni, pos);
 		if (unlikely(err < 0))
-			ntfs_error(vi->i_sb, "Cannot perform write to inode "
+			ntfs_error(inode_sb(vi),
+					"Cannot perform write to inode "
 					"0x%lx, attribute type 0x%x, because "
 					"extending the initialized size "
 					"failed (error %d).", vi->i_ino,
@@ -1412,7 +1414,7 @@ static inline int ntfs_commit_pages_after_non_resident_write(
 
 	vi = pages[0]->mapping->host;
 	ni = NTFS_I(vi);
-	blocksize = vi->i_sb->s_blocksize;
+	blocksize = inode_sb(vi)->s_blocksize;
 	end = pos + bytes;
 	u = 0;
 	do {
@@ -1507,7 +1509,8 @@ static inline int ntfs_commit_pages_after_non_resident_write(
 		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(base_ni);
-	ntfs_error(vi->i_sb, "Failed to update initialized_size/i_size (error "
+	ntfs_error(inode_sb(vi),
+			"Failed to update initialized_size/i_size (error "
 			"code %i).", err);
 	if (err != -ENOMEM)
 		NVolSetErrors(ni->vol);
@@ -1664,10 +1667,12 @@ static int ntfs_commit_pages_after_write(struct page **pages,
 	return 0;
 err_out:
 	if (err == -ENOMEM) {
-		ntfs_warning(vi->i_sb, "Error allocating memory required to "
+		ntfs_warning(inode_sb(vi),
+				"Error allocating memory required to "
 				"commit the write.");
 		if (PageUptodate(page)) {
-			ntfs_warning(vi->i_sb, "Page is uptodate, setting "
+			ntfs_warning(inode_sb(vi),
+					"Page is uptodate, setting "
 					"dirty so the write will be retried "
 					"later on by the VM.");
 			/*
@@ -1677,10 +1682,12 @@ static int ntfs_commit_pages_after_write(struct page **pages,
 			__set_page_dirty_nobuffers(page);
 			err = 0;
 		} else
-			ntfs_error(vi->i_sb, "Page is not uptodate.  Written "
+			ntfs_error(inode_sb(vi),
+					"Page is not uptodate.  Written "
 					"data has been lost.");
 	} else {
-		ntfs_error(vi->i_sb, "Resident attribute commit write failed "
+		ntfs_error(inode_sb(vi),
+				"Resident attribute commit write failed "
 				"with error %i.", err);
 		NVolSetErrors(ni->vol);
 	}
@@ -2003,13 +2010,14 @@ static int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end,
 	 * fs/buffer.c) for dirty blocks then we could optimize the below to be
 	 * sync_mapping_buffers(vi->i_mapping).
 	 */
-	err = sync_blockdev(vi->i_sb->s_bdev);
+	err = sync_blockdev(inode_sb(vi)->s_bdev);
 	if (unlikely(err && !ret))
 		ret = err;
 	if (likely(!ret))
 		ntfs_debug("Done.");
 	else
-		ntfs_warning(vi->i_sb, "Failed to f%ssync inode 0x%lx.  Error "
+		ntfs_warning(inode_sb(vi),
+				"Failed to f%ssync inode 0x%lx.  Error "
 				"%u.", datasync ? "data" : "", vi->i_ino, -ret);
 	inode_unlock(vi);
 	return ret;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 1c1ee489284b..cde6853c99ac 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -239,8 +239,9 @@ struct inode *ntfs_attr_iget(struct inode *base_vi, ATTR_TYPE type,
 	na.name = name;
 	na.name_len = name_len;
 
-	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
-			(set_t)ntfs_init_locked_inode, &na);
+	vi = iget5_locked(inode_sb(base_vi), na.mft_no,
+			  (test_t)ntfs_test_inode,
+			  (set_t)ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
 
@@ -294,8 +295,9 @@ struct inode *ntfs_index_iget(struct inode *base_vi, ntfschar *name,
 	na.name = name;
 	na.name_len = name_len;
 
-	vi = iget5_locked(base_vi->i_sb, na.mft_no, (test_t)ntfs_test_inode,
-			(set_t)ntfs_init_locked_inode, &na);
+	vi = iget5_locked(inode_sb(base_vi), na.mft_no,
+			  (test_t)ntfs_test_inode,
+			  (set_t)ntfs_init_locked_inode, &na);
 	if (unlikely(!vi))
 		return ERR_PTR(-ENOMEM);
 
@@ -548,7 +550,7 @@ static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
  */
 static int ntfs_read_locked_inode(struct inode *vi)
 {
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(vi));
 	ntfs_inode *ni;
 	struct inode *bvi;
 	MFT_RECORD *m;
@@ -584,11 +586,11 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	}
 
 	if (!(m->flags & MFT_RECORD_IN_USE)) {
-		ntfs_error(vi->i_sb, "Inode is not in use!");
+		ntfs_error(inode_sb(vi), "Inode is not in use!");
 		goto unm_err_out;
 	}
 	if (m->base_mft_record) {
-		ntfs_error(vi->i_sb, "Inode is an extent inode!");
+		ntfs_error(inode_sb(vi), "Inode is an extent inode!");
 		goto unm_err_out;
 	}
 
@@ -647,7 +649,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			 * recover mount option is set) by creating a new
 			 * attribute.
 			 */
-			ntfs_error(vi->i_sb, "$STANDARD_INFORMATION attribute "
+			ntfs_error(inode_sb(vi),
+					"$STANDARD_INFORMATION attribute "
 					"is missing.");
 		}
 		goto unm_err_out;
@@ -685,7 +688,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	err = ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx);
 	if (err) {
 		if (unlikely(err != -ENOENT)) {
-			ntfs_error(vi->i_sb, "Failed to lookup attribute list "
+			ntfs_error(inode_sb(vi),
+					"Failed to lookup attribute list "
 					"attribute.");
 			goto unm_err_out;
 		}
@@ -696,19 +700,21 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		NInoSetAttrList(ni);
 		a = ctx->attr;
 		if (a->flags & ATTR_COMPRESSION_MASK) {
-			ntfs_error(vi->i_sb, "Attribute list attribute is "
+			ntfs_error(inode_sb(vi),
+					"Attribute list attribute is "
 					"compressed.");
 			goto unm_err_out;
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED ||
 				a->flags & ATTR_IS_SPARSE) {
 			if (a->non_resident) {
-				ntfs_error(vi->i_sb, "Non-resident attribute "
+				ntfs_error(inode_sb(vi),
+						"Non-resident attribute "
 						"list attribute is encrypted/"
 						"sparse.");
 				goto unm_err_out;
 			}
-			ntfs_warning(vi->i_sb, "Resident attribute list "
+			ntfs_warning(inode_sb(vi), "Resident attribute list "
 					"attribute in inode 0x%lx is marked "
 					"encrypted/sparse which is not true.  "
 					"However, Windows allows this and "
@@ -721,7 +727,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		ni->attr_list_size = (u32)ntfs_attr_size(a);
 		ni->attr_list = ntfs_malloc_nofs(ni->attr_list_size);
 		if (!ni->attr_list) {
-			ntfs_error(vi->i_sb, "Not enough memory to allocate "
+			ntfs_error(inode_sb(vi),
+					"Not enough memory to allocate "
 					"buffer for attribute list.");
 			err = -ENOMEM;
 			goto unm_err_out;
@@ -729,7 +736,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		if (a->non_resident) {
 			NInoSetAttrListNonResident(ni);
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(vi->i_sb, "Attribute list has non "
+				ntfs_error(inode_sb(vi),
+						"Attribute list has non "
 						"zero lowest_vcn.");
 				goto unm_err_out;
 			}
@@ -742,7 +750,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			if (IS_ERR(ni->attr_list_rl.rl)) {
 				err = PTR_ERR(ni->attr_list_rl.rl);
 				ni->attr_list_rl.rl = NULL;
-				ntfs_error(vi->i_sb, "Mapping pairs "
+				ntfs_error(inode_sb(vi), "Mapping pairs "
 						"decompression failed.");
 				goto unm_err_out;
 			}
@@ -751,7 +759,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					ni->attr_list, ni->attr_list_size,
 					sle64_to_cpu(a->data.non_resident.
 					initialized_size)))) {
-				ntfs_error(vi->i_sb, "Failed to load "
+				ntfs_error(inode_sb(vi), "Failed to load "
 						"attribute list attribute.");
 				goto unm_err_out;
 			}
@@ -760,7 +768,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					+ le32_to_cpu(
 					a->data.resident.value_length) >
 					(u8*)ctx->mrec + vol->mft_record_size) {
-				ntfs_error(vi->i_sb, "Corrupt attribute list "
+				ntfs_error(inode_sb(vi),
+						"Corrupt attribute list "
 						"in inode.");
 				goto unm_err_out;
 			}
@@ -791,7 +800,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				// FIXME: File is corrupt! Hot-fix with empty
 				// index root attribute if recovery option is
 				// set.
-				ntfs_error(vi->i_sb, "$INDEX_ROOT attribute "
+				ntfs_error(inode_sb(vi),
+						"$INDEX_ROOT attribute "
 						"is missing.");
 			}
 			goto unm_err_out;
@@ -820,7 +830,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			NInoSetCompressed(ni);
 		if (a->flags & ATTR_IS_ENCRYPTED) {
 			if (a->flags & ATTR_COMPRESSION_MASK) {
-				ntfs_error(vi->i_sb, "Found encrypted and "
+				ntfs_error(inode_sb(vi),
+						"Found encrypted and "
 						"compressed attribute.");
 				goto unm_err_out;
 			}
@@ -832,23 +843,25 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				le16_to_cpu(a->data.resident.value_offset));
 		ir_end = (u8*)ir + le32_to_cpu(a->data.resident.value_length);
 		if (ir_end > (u8*)ctx->mrec + vol->mft_record_size) {
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
+			ntfs_error(inode_sb(vi), "$INDEX_ROOT attribute is "
 					"corrupt.");
 			goto unm_err_out;
 		}
 		index_end = (u8*)&ir->index +
 				le32_to_cpu(ir->index.index_length);
 		if (index_end > ir_end) {
-			ntfs_error(vi->i_sb, "Directory index is corrupt.");
+			ntfs_error(inode_sb(vi),
+				   "Directory index is corrupt.");
 			goto unm_err_out;
 		}
 		if (ir->type != AT_FILE_NAME) {
-			ntfs_error(vi->i_sb, "Indexed attribute is not "
+			ntfs_error(inode_sb(vi), "Indexed attribute is not "
 					"$FILE_NAME.");
 			goto unm_err_out;
 		}
 		if (ir->collation_rule != COLLATION_FILE_NAME) {
-			ntfs_error(vi->i_sb, "Index collation rule is not "
+			ntfs_error(inode_sb(vi),
+					"Index collation rule is not "
 					"COLLATION_FILE_NAME.");
 			goto unm_err_out;
 		}
@@ -856,13 +869,14 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
 		if (ni->itype.index.block_size &
 				(ni->itype.index.block_size - 1)) {
-			ntfs_error(vi->i_sb, "Index block size (%u) is not a "
+			ntfs_error(inode_sb(vi),
+					"Index block size (%u) is not a "
 					"power of two.",
 					ni->itype.index.block_size);
 			goto unm_err_out;
 		}
 		if (ni->itype.index.block_size > PAGE_SIZE) {
-			ntfs_error(vi->i_sb, "Index block size (%u) > "
+			ntfs_error(inode_sb(vi), "Index block size (%u) > "
 					"PAGE_SIZE (%ld) is not "
 					"supported.  Sorry.",
 					ni->itype.index.block_size,
@@ -871,7 +885,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			goto unm_err_out;
 		}
 		if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
-			ntfs_error(vi->i_sb, "Index block size (%u) < "
+			ntfs_error(inode_sb(vi), "Index block size (%u) < "
 					"NTFS_BLOCK_SIZE (%i) is not "
 					"supported.  Sorry.",
 					ni->itype.index.block_size,
@@ -914,18 +928,19 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				CASE_SENSITIVE, 0, NULL, 0, ctx);
 		if (unlikely(err)) {
 			if (err == -ENOENT)
-				ntfs_error(vi->i_sb, "$INDEX_ALLOCATION "
+				ntfs_error(inode_sb(vi), "$INDEX_ALLOCATION "
 						"attribute is not present but "
 						"$INDEX_ROOT indicated it is.");
 			else
-				ntfs_error(vi->i_sb, "Failed to lookup "
+				ntfs_error(inode_sb(vi), "Failed to lookup "
 						"$INDEX_ALLOCATION "
 						"attribute.");
 			goto unm_err_out;
 		}
 		a = ctx->attr;
 		if (!a->non_resident) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
+			ntfs_error(inode_sb(vi),
+					"$INDEX_ALLOCATION attribute "
 					"is resident.");
 			goto unm_err_out;
 		}
@@ -942,22 +957,25 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			goto unm_err_out;
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
+			ntfs_error(inode_sb(vi),
+					"$INDEX_ALLOCATION attribute "
 					"is encrypted.");
 			goto unm_err_out;
 		}
 		if (a->flags & ATTR_IS_SPARSE) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
+			ntfs_error(inode_sb(vi),
+					"$INDEX_ALLOCATION attribute "
 					"is sparse.");
 			goto unm_err_out;
 		}
 		if (a->flags & ATTR_COMPRESSION_MASK) {
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
+			ntfs_error(inode_sb(vi),
+					"$INDEX_ALLOCATION attribute "
 					"is compressed.");
 			goto unm_err_out;
 		}
 		if (a->data.non_resident.lowest_vcn) {
-			ntfs_error(vi->i_sb, "First extent of "
+			ntfs_error(inode_sb(vi), "First extent of "
 					"$INDEX_ALLOCATION attribute has non "
 					"zero lowest_vcn.");
 			goto unm_err_out;
@@ -978,14 +996,16 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		/* Get the index bitmap attribute inode. */
 		bvi = ntfs_attr_iget(vi, AT_BITMAP, I30, 4);
 		if (IS_ERR(bvi)) {
-			ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
+			ntfs_error(inode_sb(vi),
+				   "Failed to get bitmap attribute.");
 			err = PTR_ERR(bvi);
 			goto unm_err_out;
 		}
 		bni = NTFS_I(bvi);
 		if (NInoCompressed(bni) || NInoEncrypted(bni) ||
 				NInoSparse(bni)) {
-			ntfs_error(vi->i_sb, "$BITMAP attribute is compressed "
+			ntfs_error(inode_sb(vi),
+					"$BITMAP attribute is compressed "
 					"and/or encrypted and/or sparse.");
 			goto iput_unm_err_out;
 		}
@@ -993,7 +1013,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		bvi_size = i_size_read(bvi);
 		if ((bvi_size << 3) < (vi->i_size >>
 				ni->itype.index.block_size_bits)) {
-			ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) "
+			ntfs_error(inode_sb(vi),
+					"Index bitmap too small (0x%llx) "
 					"for index allocation (0x%llx).",
 					bvi_size << 3, vi->i_size);
 			goto iput_unm_err_out;
@@ -1020,7 +1041,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0;
 			if (err != -ENOENT) {
-				ntfs_error(vi->i_sb, "Failed to lookup $DATA "
+				ntfs_error(inode_sb(vi),
+						"Failed to lookup $DATA "
 						"attribute.");
 				goto unm_err_out;
 			}
@@ -1043,7 +1065,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				goto no_data_attr_special_case;
 			// FIXME: File is corrupt! Hot-fix with empty data
 			// attribute if recovery option is set.
-			ntfs_error(vi->i_sb, "$DATA attribute is missing.");
+			ntfs_error(inode_sb(vi),
+				   "$DATA attribute is missing.");
 			goto unm_err_out;
 		}
 		a = ctx->attr;
@@ -1052,7 +1075,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			if (a->flags & ATTR_COMPRESSION_MASK) {
 				NInoSetCompressed(ni);
 				if (vol->cluster_size > 4096) {
-					ntfs_error(vi->i_sb, "Found "
+					ntfs_error(inode_sb(vi), "Found "
 							"compressed data but "
 							"compression is "
 							"disabled due to "
@@ -1063,7 +1086,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 				}
 				if ((a->flags & ATTR_COMPRESSION_MASK)
 						!= ATTR_IS_COMPRESSED) {
-					ntfs_error(vi->i_sb, "Found unknown "
+					ntfs_error(inode_sb(vi),
+							"Found unknown "
 							"compression method "
 							"or corrupt file.");
 					goto unm_err_out;
@@ -1074,7 +1098,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 		}
 		if (a->flags & ATTR_IS_ENCRYPTED) {
 			if (NInoCompressed(ni)) {
-				ntfs_error(vi->i_sb, "Found encrypted and "
+				ntfs_error(inode_sb(vi),
+						"Found encrypted and "
 						"compressed data.");
 				goto unm_err_out;
 			}
@@ -1085,7 +1110,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
 			if (NInoCompressed(ni) || NInoSparse(ni)) {
 				if (NInoCompressed(ni) && a->data.non_resident.
 						compression_unit != 4) {
-					ntfs_error(vi->i_sb, "Found "
+					ntfs_error(inode_sb(vi), "Found "
 							"non-standard "
 							"compression unit (%u "
 							"instead of 4).  "
@@ -1120,7 +1145,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 						compressed_size);
 			}
 			if (a->data.non_resident.lowest_vcn) {
-				ntfs_error(vi->i_sb, "First extent of $DATA "
+				ntfs_error(inode_sb(vi),
+						"First extent of $DATA "
 						"attribute has non zero "
 						"lowest_vcn.");
 				goto unm_err_out;
@@ -1138,7 +1164,8 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					le16_to_cpu(
 					a->data.resident.value_offset);
 			if (vi->i_size > ni->allocated_size) {
-				ntfs_error(vi->i_sb, "Resident data attribute "
+				ntfs_error(inode_sb(vi),
+						"Resident data attribute "
 						"is corrupt (size exceeds "
 						"allocation).");
 				goto unm_err_out;
@@ -1218,7 +1245,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
  */
 static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 {
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(vi));
 	ntfs_inode *ni, *base_ni;
 	MFT_RECORD *m;
 	ATTR_RECORD *a;
@@ -1265,7 +1292,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 			NInoSetCompressed(ni);
 			if ((ni->type != AT_DATA) || (ni->type == AT_DATA &&
 					ni->name_len)) {
-				ntfs_error(vi->i_sb, "Found compressed "
+				ntfs_error(inode_sb(vi), "Found compressed "
 						"non-data or named data "
 						"attribute.  Please report "
 						"you saw this message to "
@@ -1274,7 +1301,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 				goto unm_err_out;
 			}
 			if (vol->cluster_size > 4096) {
-				ntfs_error(vi->i_sb, "Found compressed "
+				ntfs_error(inode_sb(vi), "Found compressed "
 						"attribute but compression is "
 						"disabled due to cluster size "
 						"(%i) > 4kiB.",
@@ -1283,7 +1310,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 			}
 			if ((a->flags & ATTR_COMPRESSION_MASK) !=
 					ATTR_IS_COMPRESSED) {
-				ntfs_error(vi->i_sb, "Found unknown "
+				ntfs_error(inode_sb(vi), "Found unknown "
 						"compression method.");
 				goto unm_err_out;
 			}
@@ -1293,7 +1320,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		 * to compress all files.
 		 */
 		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
+			ntfs_error(inode_sb(vi),
+					"Found mst protected attribute "
 					"but the attribute is %s.  Please "
 					"report you saw this message to "
 					"linux-ntfs-dev@lists.sourceforge.net",
@@ -1306,7 +1334,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 	}
 	if (a->flags & ATTR_IS_ENCRYPTED) {
 		if (NInoCompressed(ni)) {
-			ntfs_error(vi->i_sb, "Found encrypted and compressed "
+			ntfs_error(inode_sb(vi),
+					"Found encrypted and compressed "
 					"data.");
 			goto unm_err_out;
 		}
@@ -1315,7 +1344,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		 * encrypt all files.
 		 */
 		if (NInoMstProtected(ni) && ni->type != AT_INDEX_ROOT) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
+			ntfs_error(inode_sb(vi),
+					"Found mst protected attribute "
 					"but the attribute is encrypted.  "
 					"Please report you saw this message "
 					"to linux-ntfs-dev@lists.sourceforge."
@@ -1323,7 +1353,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 			goto unm_err_out;
 		}
 		if (ni->type != AT_DATA) {
-			ntfs_error(vi->i_sb, "Found encrypted non-data "
+			ntfs_error(inode_sb(vi), "Found encrypted non-data "
 					"attribute.");
 			goto unm_err_out;
 		}
@@ -1338,7 +1368,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 			goto unm_err_out;
 		}
 		if (NInoMstProtected(ni)) {
-			ntfs_error(vi->i_sb, "Found mst protected attribute "
+			ntfs_error(inode_sb(vi),
+					"Found mst protected attribute "
 					"but the attribute is resident.  "
 					"Please report you saw this message to "
 					"linux-ntfs-dev@lists.sourceforge.net");
@@ -1349,7 +1380,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		ni->allocated_size = le32_to_cpu(a->length) -
 				le16_to_cpu(a->data.resident.value_offset);
 		if (vi->i_size > ni->allocated_size) {
-			ntfs_error(vi->i_sb, "Resident attribute is corrupt "
+			ntfs_error(inode_sb(vi),
+					"Resident attribute is corrupt "
 					"(size exceeds allocation).");
 			goto unm_err_out;
 		}
@@ -1369,7 +1401,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 		if (NInoCompressed(ni) || NInoSparse(ni)) {
 			if (NInoCompressed(ni) && a->data.non_resident.
 					compression_unit != 4) {
-				ntfs_error(vi->i_sb, "Found non-standard "
+				ntfs_error(inode_sb(vi), "Found non-standard "
 						"compression unit (%u instead "
 						"of 4).  Cannot handle this.",
 						a->data.non_resident.
@@ -1397,7 +1429,8 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 					a->data.non_resident.compressed_size);
 		}
 		if (a->data.non_resident.lowest_vcn) {
-			ntfs_error(vi->i_sb, "First extent of attribute has "
+			ntfs_error(inode_sb(vi),
+					"First extent of attribute has "
 					"non-zero lowest_vcn.");
 			goto unm_err_out;
 		}
@@ -1484,7 +1517,7 @@ static int ntfs_read_locked_attr_inode(struct inode *base_vi, struct inode *vi)
 static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 {
 	loff_t bvi_size;
-	ntfs_volume *vol = NTFS_SB(vi->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(vi));
 	ntfs_inode *ni, *base_ni, *bni;
 	struct inode *bvi;
 	MFT_RECORD *m;
@@ -1524,7 +1557,7 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
 		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is "
+			ntfs_error(inode_sb(vi), "$INDEX_ROOT attribute is "
 					"missing.");
 		goto unm_err_out;
 	}
@@ -1547,23 +1580,25 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	 */
 	if (a->flags & (ATTR_COMPRESSION_MASK | ATTR_IS_ENCRYPTED |
 			ATTR_IS_SPARSE)) {
-		ntfs_error(vi->i_sb, "Found compressed/encrypted/sparse index "
+		ntfs_error(inode_sb(vi),
+				"Found compressed/encrypted/sparse index "
 				"root attribute.");
 		goto unm_err_out;
 	}
 	ir = (INDEX_ROOT*)((u8*)a + le16_to_cpu(a->data.resident.value_offset));
 	ir_end = (u8*)ir + le32_to_cpu(a->data.resident.value_length);
 	if (ir_end > (u8*)ctx->mrec + vol->mft_record_size) {
-		ntfs_error(vi->i_sb, "$INDEX_ROOT attribute is corrupt.");
+		ntfs_error(inode_sb(vi), "$INDEX_ROOT attribute is corrupt.");
 		goto unm_err_out;
 	}
 	index_end = (u8*)&ir->index + le32_to_cpu(ir->index.index_length);
 	if (index_end > ir_end) {
-		ntfs_error(vi->i_sb, "Index is corrupt.");
+		ntfs_error(inode_sb(vi), "Index is corrupt.");
 		goto unm_err_out;
 	}
 	if (ir->type) {
-		ntfs_error(vi->i_sb, "Index type is not 0 (type is 0x%x).",
+		ntfs_error(inode_sb(vi),
+				"Index type is not 0 (type is 0x%x).",
 				le32_to_cpu(ir->type));
 		goto unm_err_out;
 	}
@@ -1572,19 +1607,21 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 			le32_to_cpu(ir->collation_rule));
 	ni->itype.index.block_size = le32_to_cpu(ir->index_block_size);
 	if (!is_power_of_2(ni->itype.index.block_size)) {
-		ntfs_error(vi->i_sb, "Index block size (%u) is not a power of "
+		ntfs_error(inode_sb(vi),
+				"Index block size (%u) is not a power of "
 				"two.", ni->itype.index.block_size);
 		goto unm_err_out;
 	}
 	if (ni->itype.index.block_size > PAGE_SIZE) {
-		ntfs_error(vi->i_sb, "Index block size (%u) > PAGE_SIZE "
+		ntfs_error(inode_sb(vi), "Index block size (%u) > PAGE_SIZE "
 				"(%ld) is not supported.  Sorry.",
 				ni->itype.index.block_size, PAGE_SIZE);
 		err = -EOPNOTSUPP;
 		goto unm_err_out;
 	}
 	if (ni->itype.index.block_size < NTFS_BLOCK_SIZE) {
-		ntfs_error(vi->i_sb, "Index block size (%u) < NTFS_BLOCK_SIZE "
+		ntfs_error(inode_sb(vi),
+				"Index block size (%u) < NTFS_BLOCK_SIZE "
 				"(%i) is not supported.  Sorry.",
 				ni->itype.index.block_size, NTFS_BLOCK_SIZE);
 		err = -EOPNOTSUPP;
@@ -1617,17 +1654,18 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
 		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
+			ntfs_error(inode_sb(vi),
+					"$INDEX_ALLOCATION attribute is "
 					"not present but $INDEX_ROOT "
 					"indicated it is.");
 		else
-			ntfs_error(vi->i_sb, "Failed to lookup "
+			ntfs_error(inode_sb(vi), "Failed to lookup "
 					"$INDEX_ALLOCATION attribute.");
 		goto unm_err_out;
 	}
 	a = ctx->attr;
 	if (!a->non_resident) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
+		ntfs_error(inode_sb(vi), "$INDEX_ALLOCATION attribute is "
 				"resident.");
 		goto unm_err_out;
 	}
@@ -1642,21 +1680,22 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_IS_ENCRYPTED) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
+		ntfs_error(inode_sb(vi), "$INDEX_ALLOCATION attribute is "
 				"encrypted.");
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_IS_SPARSE) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is sparse.");
+		ntfs_error(inode_sb(vi),
+			   "$INDEX_ALLOCATION attribute is sparse.");
 		goto unm_err_out;
 	}
 	if (a->flags & ATTR_COMPRESSION_MASK) {
-		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is "
+		ntfs_error(inode_sb(vi), "$INDEX_ALLOCATION attribute is "
 				"compressed.");
 		goto unm_err_out;
 	}
 	if (a->data.non_resident.lowest_vcn) {
-		ntfs_error(vi->i_sb, "First extent of $INDEX_ALLOCATION "
+		ntfs_error(inode_sb(vi), "First extent of $INDEX_ALLOCATION "
 				"attribute has non zero lowest_vcn.");
 		goto unm_err_out;
 	}
@@ -1675,21 +1714,23 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	/* Get the index bitmap attribute inode. */
 	bvi = ntfs_attr_iget(base_vi, AT_BITMAP, ni->name, ni->name_len);
 	if (IS_ERR(bvi)) {
-		ntfs_error(vi->i_sb, "Failed to get bitmap attribute.");
+		ntfs_error(inode_sb(vi), "Failed to get bitmap attribute.");
 		err = PTR_ERR(bvi);
 		goto unm_err_out;
 	}
 	bni = NTFS_I(bvi);
 	if (NInoCompressed(bni) || NInoEncrypted(bni) ||
 			NInoSparse(bni)) {
-		ntfs_error(vi->i_sb, "$BITMAP attribute is compressed and/or "
+		ntfs_error(inode_sb(vi),
+				"$BITMAP attribute is compressed and/or "
 				"encrypted and/or sparse.");
 		goto iput_unm_err_out;
 	}
 	/* Consistency check bitmap size vs. index allocation size. */
 	bvi_size = i_size_read(bvi);
 	if ((bvi_size << 3) < (vi->i_size >> ni->itype.index.block_size_bits)) {
-		ntfs_error(vi->i_sb, "Index bitmap too small (0x%llx) for "
+		ntfs_error(inode_sb(vi),
+				"Index bitmap too small (0x%llx) for "
 				"index allocation (0x%llx).", bvi_size << 3,
 				vi->i_size);
 		goto iput_unm_err_out;
@@ -1719,7 +1760,8 @@ static int ntfs_read_locked_index_inode(struct inode *base_vi, struct inode *vi)
 	if (m)
 		unmap_mft_record(base_ni);
 err_out:
-	ntfs_error(vi->i_sb, "Failed with error code %i while reading index "
+	ntfs_error(inode_sb(vi),
+			"Failed with error code %i while reading index "
 			"inode (mft_no 0x%lx, name_len %i.", err, vi->i_ino,
 			ni->name_len);
 	make_bad_inode(vi);
@@ -1767,7 +1809,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 {
 	VCN next_vcn, last_vcn, highest_vcn;
 	s64 block;
-	struct super_block *sb = vi->i_sb;
+	struct super_block *sb = inode_sb(vi);
 	ntfs_volume *vol = NTFS_SB(sb);
 	struct buffer_head *bh;
 	ntfs_inode *ni;
@@ -2261,7 +2303,8 @@ void ntfs_evict_big_inode(struct inode *vi)
 		ntfs_commit_inode(vi);
 
 		if (!was_bad && (is_bad_inode(vi) || NInoDirty(ni))) {
-			ntfs_error(vi->i_sb, "Failed to commit dirty inode "
+			ntfs_error(inode_sb(vi),
+					"Failed to commit dirty inode "
 					"0x%lx.  Losing data!", vi->i_ino);
 			// FIXME:  Do something!!!
 		}
@@ -2383,7 +2426,8 @@ int ntfs_truncate(struct inode *vi)
 	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
 		err = PTR_ERR(m);
-		ntfs_error(vi->i_sb, "Failed to map mft record for inode 0x%lx "
+		ntfs_error(inode_sb(vi),
+				"Failed to map mft record for inode 0x%lx "
 				"(error code %d).%s", vi->i_ino, err, te);
 		ctx = NULL;
 		m = NULL;
@@ -2391,7 +2435,8 @@ int ntfs_truncate(struct inode *vi)
 	}
 	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (unlikely(!ctx)) {
-		ntfs_error(vi->i_sb, "Failed to allocate a search context for "
+		ntfs_error(inode_sb(vi),
+				"Failed to allocate a search context for "
 				"inode 0x%lx (not enough memory).%s",
 				vi->i_ino, te);
 		err = -ENOMEM;
@@ -2401,12 +2446,14 @@ int ntfs_truncate(struct inode *vi)
 			CASE_SENSITIVE, 0, NULL, 0, ctx);
 	if (unlikely(err)) {
 		if (err == -ENOENT) {
-			ntfs_error(vi->i_sb, "Open attribute is missing from "
+			ntfs_error(inode_sb(vi),
+					"Open attribute is missing from "
 					"mft record.  Inode 0x%lx is corrupt.  "
 					"Run chkdsk.%s", vi->i_ino, te);
 			err = -EIO;
 		} else
-			ntfs_error(vi->i_sb, "Failed to lookup attribute in "
+			ntfs_error(inode_sb(vi),
+					"Failed to lookup attribute in "
 					"inode 0x%lx (error code %d).%s",
 					vi->i_ino, err, te);
 		goto old_bad_out;
@@ -2480,7 +2527,7 @@ int ntfs_truncate(struct inode *vi)
 		}
 	}
 	if (NInoCompressed(ni) || NInoEncrypted(ni)) {
-		ntfs_warning(vi->i_sb, "Changes in inode size are not "
+		ntfs_warning(inode_sb(vi), "Changes in inode size are not "
 				"supported yet for %s files, ignoring.",
 				NInoCompressed(ni) ? "compressed" :
 				"encrypted");
@@ -2889,7 +2936,8 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 		goto out;
 	/* We do not support NTFS ACLs yet. */
 	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE)) {
-		ntfs_warning(vi->i_sb, "Changes in user/group/mode are not "
+		ntfs_warning(inode_sb(vi),
+				"Changes in user/group/mode are not "
 				"supported yet, ignoring.");
 		err = -EOPNOTSUPP;
 		goto out;
@@ -2902,7 +2950,8 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 			 * compressed or encrypted files yet.
 			 */
 			if (NInoCompressed(ni) || NInoEncrypted(ni)) {
-				ntfs_warning(vi->i_sb, "Changes in inode size "
+				ntfs_warning(inode_sb(vi),
+						"Changes in inode size "
 						"are not supported yet for "
 						"%s files, ignoring.",
 						NInoCompressed(ni) ?
@@ -2924,13 +2973,13 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	if (ia_valid & ATTR_ATIME)
 		vi->i_atime = timespec_trunc(attr->ia_atime,
-				vi->i_sb->s_time_gran);
+				inode_sb(vi)->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
 		vi->i_mtime = timespec_trunc(attr->ia_mtime,
-				vi->i_sb->s_time_gran);
+				inode_sb(vi)->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
 		vi->i_ctime = timespec_trunc(attr->ia_ctime,
-				vi->i_sb->s_time_gran);
+				inode_sb(vi)->s_time_gran);
 	mark_inode_dirty(vi);
 out:
 	return err;
@@ -3088,12 +3137,14 @@ int __ntfs_write_inode(struct inode *vi, int sync)
 	unmap_mft_record(ni);
 err_out:
 	if (err == -ENOMEM) {
-		ntfs_warning(vi->i_sb, "Not enough memory to write inode.  "
+		ntfs_warning(inode_sb(vi),
+				"Not enough memory to write inode.  "
 				"Marking the inode dirty again, so the VFS "
 				"retries later.");
 		mark_inode_dirty(vi);
 	} else {
-		ntfs_error(vi->i_sb, "Failed (error %i):  Run chkdsk.", -err);
+		ntfs_error(inode_sb(vi), "Failed (error %i):  Run chkdsk.",
+			   -err);
 		NVolSetErrors(ni->vol);
 	}
 	return err;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index b3c3469de6cb..d22743c94763 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -288,7 +288,7 @@ static inline void ntfs_init_big_inode(struct inode *vi)
 	ntfs_inode *ni = NTFS_I(vi);
 
 	ntfs_debug("Entering.");
-	__ntfs_init_inode(vi->i_sb, ni);
+	__ntfs_init_inode(inode_sb(vi), ni);
 	ni->mft_no = vi->i_ino;
 }
 
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index 353379ff6057..2cc0cac18ac5 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -68,7 +68,8 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 			logfile_system_page_size &
 			(logfile_system_page_size - 1) ||
 			!is_power_of_2(logfile_log_page_size)) {
-		ntfs_error(vi->i_sb, "$LogFile uses unsupported page size.");
+		ntfs_error(inode_sb(vi),
+			   "$LogFile uses unsupported page size.");
 		return false;
 	}
 	/*
@@ -76,14 +77,14 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	 * size (2nd restart page).
 	 */
 	if (pos && pos != logfile_system_page_size) {
-		ntfs_error(vi->i_sb, "Found restart area in incorrect "
+		ntfs_error(inode_sb(vi), "Found restart area in incorrect "
 				"position in $LogFile.");
 		return false;
 	}
 	/* We only know how to handle version 1.1. */
 	if (sle16_to_cpu(rp->major_ver) != 1 ||
 			sle16_to_cpu(rp->minor_ver) != 1) {
-		ntfs_error(vi->i_sb, "$LogFile version %i.%i is not "
+		ntfs_error(inode_sb(vi), "$LogFile version %i.%i is not "
 				"supported.  (This driver supports version "
 				"1.1 only.)", (int)sle16_to_cpu(rp->major_ver),
 				(int)sle16_to_cpu(rp->minor_ver));
@@ -100,7 +101,7 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	/* Verify the size of the update sequence array. */
 	usa_count = 1 + (logfile_system_page_size >> NTFS_BLOCK_SIZE_BITS);
 	if (usa_count != le16_to_cpu(rp->usa_count)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart page specifies "
 				"inconsistent update sequence array count.");
 		return false;
 	}
@@ -109,7 +110,7 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	usa_end = usa_ofs + usa_count * sizeof(u16);
 	if (usa_ofs < sizeof(RESTART_PAGE_HEADER) ||
 			usa_end > NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart page specifies "
 				"inconsistent update sequence array offset.");
 		return false;
 	}
@@ -124,7 +125,7 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	if (ra_ofs & 7 || (have_usa ? ra_ofs < usa_end :
 			ra_ofs < sizeof(RESTART_PAGE_HEADER)) ||
 			ra_ofs > logfile_system_page_size) {
-		ntfs_error(vi->i_sb, "$LogFile restart page specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart page specifies "
 				"inconsistent restart area offset.");
 		return false;
 	}
@@ -133,7 +134,8 @@ static bool ntfs_check_restart_page_header(struct inode *vi,
 	 * set.
 	 */
 	if (!ntfs_is_chkd_record(rp->magic) && sle64_to_cpu(rp->chkdsk_lsn)) {
-		ntfs_error(vi->i_sb, "$LogFile restart page is not modified "
+		ntfs_error(inode_sb(vi),
+				"$LogFile restart page is not modified "
 				"by chkdsk but a chkdsk LSN is specified.");
 		return false;
 	}
@@ -172,7 +174,7 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 	 */
 	if (ra_ofs + offsetof(RESTART_AREA, file_size) >
 			NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"inconsistent file offset.");
 		return false;
 	}
@@ -186,7 +188,7 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 	ca_ofs = le16_to_cpu(ra->client_array_offset);
 	if (((ca_ofs + 7) & ~7) != ca_ofs ||
 			ra_ofs + ca_ofs > NTFS_BLOCK_SIZE - sizeof(u16)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"inconsistent client array offset.");
 		return false;
 	}
@@ -201,7 +203,8 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 			ra_ofs + le16_to_cpu(ra->restart_area_length) >
 			le32_to_cpu(rp->system_page_size) ||
 			ra_len > le16_to_cpu(ra->restart_area_length)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area is out of bounds "
+		ntfs_error(inode_sb(vi),
+				"$LogFile restart area is out of bounds "
 				"of the system page size specified by the "
 				"restart page header and/or the specified "
 				"restart area length is inconsistent.");
@@ -218,7 +221,7 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 			(ra->client_in_use_list != LOGFILE_NO_CLIENT &&
 			le16_to_cpu(ra->client_in_use_list) >=
 			le16_to_cpu(ra->log_clients))) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"overflowing client free and/or in use lists.");
 		return false;
 	}
@@ -233,21 +236,21 @@ static bool ntfs_check_restart_area(struct inode *vi, RESTART_PAGE_HEADER *rp)
 		fs_bits++;
 	}
 	if (le32_to_cpu(ra->seq_number_bits) != 67 - fs_bits) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"inconsistent sequence number bits.");
 		return false;
 	}
 	/* The log record header length must be a multiple of 8. */
 	if (((le16_to_cpu(ra->log_record_header_length) + 7) & ~7) !=
 			le16_to_cpu(ra->log_record_header_length)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"inconsistent log record header length.");
 		return false;
 	}
 	/* Dito for the log page data offset. */
 	if (((le16_to_cpu(ra->log_page_data_offset) + 7) & ~7) !=
 			le16_to_cpu(ra->log_page_data_offset)) {
-		ntfs_error(vi->i_sb, "$LogFile restart area specifies "
+		ntfs_error(inode_sb(vi), "$LogFile restart area specifies "
 				"inconsistent log page data offset.");
 		return false;
 	}
@@ -316,7 +319,7 @@ static bool ntfs_check_log_client_array(struct inode *vi,
 	ntfs_debug("Done.");
 	return true;
 err_out:
-	ntfs_error(vi->i_sb, "$LogFile log client array is corrupt.");
+	ntfs_error(inode_sb(vi), "$LogFile log client array is corrupt.");
 	return false;
 }
 
@@ -373,7 +376,8 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 	 */
 	trp = ntfs_malloc_nofs(le32_to_cpu(rp->system_page_size));
 	if (!trp) {
-		ntfs_error(vi->i_sb, "Failed to allocate memory for $LogFile "
+		ntfs_error(inode_sb(vi),
+				"Failed to allocate memory for $LogFile "
 				"restart page buffer.");
 		return -ENOMEM;
 	}
@@ -400,7 +404,8 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		do {
 			page = ntfs_map_page(vi->i_mapping, idx);
 			if (IS_ERR(page)) {
-				ntfs_error(vi->i_sb, "Error mapping $LogFile "
+				ntfs_error(inode_sb(vi),
+						"Error mapping $LogFile "
 						"page (index %lu).", idx);
 				err = PTR_ERR(page);
 				if (err != -EIO && err != -ENOMEM)
@@ -430,7 +435,8 @@ static int ntfs_check_and_load_restart_page(struct inode *vi,
 		if (le16_to_cpu(rp->restart_area_offset) +
 				le16_to_cpu(ra->restart_area_length) >
 				NTFS_BLOCK_SIZE - sizeof(u16)) {
-			ntfs_error(vi->i_sb, "Multi sector transfer error "
+			ntfs_error(inode_sb(vi),
+					"Multi sector transfer error "
 					"detected in $LogFile restart page.");
 			err = -EINVAL;
 			goto err_out;
@@ -486,7 +492,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
 {
 	s64 size, pos;
 	LSN rstr1_lsn, rstr2_lsn;
-	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(log_vi));
 	struct address_space *mapping = log_vi->i_mapping;
 	struct page *page = NULL;
 	u8 *kaddr = NULL;
@@ -679,7 +685,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
  */
 bool ntfs_is_logfile_clean(struct inode *log_vi, const RESTART_PAGE_HEADER *rp)
 {
-	ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(log_vi));
 	RESTART_AREA *ra;
 
 	ntfs_debug("Entering.");
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 4690cd75d8d7..b55c2fb0ed56 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -103,7 +103,7 @@
 static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		unsigned int flags)
 {
-	ntfs_volume *vol = NTFS_SB(dir_ino->i_sb);
+	ntfs_volume *vol = NTFS_SB(inode_sb(dir_ino));
 	struct inode *dent_inode;
 	ntfschar *uname;
 	ntfs_name *name = NULL;
@@ -326,7 +326,8 @@ static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		if (err == -ENOENT)
-			ntfs_error(vi->i_sb, "Inode 0x%lx does not have a "
+			ntfs_error(inode_sb(vi),
+					"Inode 0x%lx does not have a "
 					"file name attribute.  Run chkdsk.",
 					vi->i_ino);
 		return ERR_PTR(err);
@@ -345,7 +346,7 @@ static struct dentry *ntfs_get_parent(struct dentry *child_dent)
 	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 
-	return d_obtain_alias(ntfs_iget(vi->i_sb, parent_ino));
+	return d_obtain_alias(ntfs_iget(inode_sb(vi), parent_ino));
 }
 
 static struct inode *ntfs_nfs_get_inode(struct super_block *sb,
-- 
2.15.1
