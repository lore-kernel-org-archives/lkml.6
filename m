Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbeEHSJD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:09:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:54289 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932946AbeEHSGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:30 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 70/76] fs/udf: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:30 -0700
Message-Id: <20180508180436.716-71-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/udf/dir.c       |   2 +-
 fs/udf/directory.c |  30 ++++----
 fs/udf/file.c      |   6 +-
 fs/udf/ialloc.c    |  24 +++---
 fs/udf/inode.c     | 209 +++++++++++++++++++++++++++--------------------------
 fs/udf/misc.c      |   4 +-
 fs/udf/namei.c     |  76 ++++++++++---------
 fs/udf/partition.c |   2 +-
 fs/udf/super.c     |   2 +-
 fs/udf/symlink.c   |   7 +-
 fs/udf/truncate.c  |  26 +++----
 11 files changed, 199 insertions(+), 189 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index c19dba45aa20..ef5b632da782 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -57,7 +57,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 	sector_t offset;
 	int i, num, ret = 0;
 	struct extent_position epos = { NULL, 0, {0, 0} };
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	if (ctx->pos == 0) {
 		if (!dir_emit_dot(file, ctx))
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 0a98a2369738..d5d490eaba6c 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -38,7 +38,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 				       (iinfo->i_efe ?
 					sizeof(struct extendedFileEntry) :
 					sizeof(struct fileEntry)),
-				       dir->i_sb->s_blocksize,
+				       inode_sb(dir)->s_blocksize,
 				       &(fibh->eoffset));
 		if (!fi)
 			return NULL;
@@ -51,15 +51,15 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 		return fi;
 	}
 
-	if (fibh->eoffset == dir->i_sb->s_blocksize) {
+	if (fibh->eoffset == inode_sb(dir)->s_blocksize) {
 		uint32_t lextoffset = epos->offset;
-		unsigned char blocksize_bits = dir->i_sb->s_blocksize_bits;
+		unsigned char blocksize_bits = inode_sb(dir)->s_blocksize_bits;
 
 		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
 		    (EXT_RECORDED_ALLOCATED >> 30))
 			return NULL;
 
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
+		block = udf_get_lb_pblock(inode_sb(dir), eloc, *offset);
 
 		(*offset)++;
 
@@ -69,7 +69,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 			epos->offset = lextoffset;
 
 		brelse(fibh->sbh);
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
+		fibh->sbh = fibh->ebh = udf_tread(inode_sb(dir), block);
 		if (!fibh->sbh)
 			return NULL;
 		fibh->soffset = fibh->eoffset = 0;
@@ -79,9 +79,9 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 			if (i + *offset > (*elen >> blocksize_bits))
 				i = (*elen >> blocksize_bits)-*offset;
 			for (num = 0; i > 0; i--) {
-				block = udf_get_lb_pblock(dir->i_sb, eloc,
+				block = udf_get_lb_pblock(inode_sb(dir), eloc,
 							  *offset + i);
-				tmp = udf_tgetblk(dir->i_sb, block);
+				tmp = udf_tgetblk(inode_sb(dir), block);
 				if (tmp && !buffer_uptodate(tmp) &&
 						!buffer_locked(tmp))
 					bha[num++] = tmp;
@@ -99,7 +99,7 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 		fibh->sbh = fibh->ebh;
 	}
 
-	fi = udf_get_fileident(fibh->sbh->b_data, dir->i_sb->s_blocksize,
+	fi = udf_get_fileident(fibh->sbh->b_data, inode_sb(dir)->s_blocksize,
 			       &(fibh->eoffset));
 
 	if (!fi)
@@ -107,29 +107,29 @@ struct fileIdentDesc *udf_fileident_read(struct inode *dir, loff_t *nf_pos,
 
 	*nf_pos += fibh->eoffset - fibh->soffset;
 
-	if (fibh->eoffset <= dir->i_sb->s_blocksize) {
+	if (fibh->eoffset <= inode_sb(dir)->s_blocksize) {
 		memcpy((uint8_t *)cfi, (uint8_t *)fi,
 		       sizeof(struct fileIdentDesc));
-	} else if (fibh->eoffset > dir->i_sb->s_blocksize) {
+	} else if (fibh->eoffset > inode_sb(dir)->s_blocksize) {
 		uint32_t lextoffset = epos->offset;
 
 		if (udf_next_aext(dir, epos, eloc, elen, 1) !=
 		    (EXT_RECORDED_ALLOCATED >> 30))
 			return NULL;
 
-		block = udf_get_lb_pblock(dir->i_sb, eloc, *offset);
+		block = udf_get_lb_pblock(inode_sb(dir), eloc, *offset);
 
 		(*offset)++;
 
-		if ((*offset << dir->i_sb->s_blocksize_bits) >= *elen)
+		if ((*offset << inode_sb(dir)->s_blocksize_bits) >= *elen)
 			*offset = 0;
 		else
 			epos->offset = lextoffset;
 
-		fibh->soffset -= dir->i_sb->s_blocksize;
-		fibh->eoffset -= dir->i_sb->s_blocksize;
+		fibh->soffset -= inode_sb(dir)->s_blocksize;
+		fibh->eoffset -= inode_sb(dir)->s_blocksize;
 
-		fibh->ebh = udf_tread(dir->i_sb, block);
+		fibh->ebh = udf_tread(inode_sb(dir), block);
 		if (!fibh->ebh)
 			return NULL;
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 356c2bf148a5..d28bb49a2d87 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -151,7 +151,7 @@ static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		loff_t end = iocb->ki_pos + iov_iter_count(from);
 
-		if (inode->i_sb->s_blocksize <
+		if (inode_sb(inode)->s_blocksize <
 				(udf_file_entry_alloc_offset(inode) + end)) {
 			err = udf_expand_file_adinicb(inode);
 			if (err) {
@@ -198,7 +198,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case UDF_GETVOLIDENT:
 		if (copy_to_user((char __user *)arg,
-				 UDF_SB(inode->i_sb)->s_volume_ident, 32))
+				 UDF_SB(inode_sb(inode))->s_volume_ident, 32))
 			return -EFAULT;
 		return 0;
 	case UDF_RELOCATE_BLOCKS:
@@ -206,7 +206,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EPERM;
 		if (get_user(old_block, (long __user *)arg))
 			return -EFAULT;
-		result = udf_relocate_blocks(inode->i_sb,
+		result = udf_relocate_blocks(inode_sb(inode),
 						old_block, &new_block);
 		if (result == 0)
 			result = put_user(new_block, (long __user *)arg);
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index b6e420c1bfeb..eb37faceb405 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -28,7 +28,7 @@
 
 void udf_free_inode(struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDescImpUse *lvidiu = udf_sb_lvidiu(sb);
 
@@ -47,7 +47,7 @@ void udf_free_inode(struct inode *inode)
 
 struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct inode *inode;
 	udf_pblk_t block;
@@ -63,18 +63,18 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		return ERR_PTR(-ENOMEM);
 
 	iinfo = UDF_I(inode);
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_EXTENDED_FE)) {
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_EXTENDED_FE)) {
 		iinfo->i_efe = 1;
 		if (UDF_VERS_USE_EXTENDED_FE > sbi->s_udfrev)
 			sbi->s_udfrev = UDF_VERS_USE_EXTENDED_FE;
-		iinfo->i_ext.i_data = kzalloc(inode->i_sb->s_blocksize -
-					    sizeof(struct extendedFileEntry),
-					    GFP_KERNEL);
+		iinfo->i_ext.i_data = kzalloc(inode_sb(inode)->s_blocksize -
+					      sizeof(struct extendedFileEntry),
+					      GFP_KERNEL);
 	} else {
 		iinfo->i_efe = 0;
-		iinfo->i_ext.i_data = kzalloc(inode->i_sb->s_blocksize -
-					    sizeof(struct fileEntry),
-					    GFP_KERNEL);
+		iinfo->i_ext.i_data = kzalloc(inode_sb(inode)->s_blocksize -
+					      sizeof(struct fileEntry),
+					      GFP_KERNEL);
 	}
 	if (!iinfo->i_ext.i_data) {
 		iput(inode);
@@ -82,7 +82,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 	}
 
 	err = -ENOSPC;
-	block = udf_new_block(dir->i_sb, NULL,
+	block = udf_new_block(inode_sb(dir), NULL,
 			      dinfo->i_location.partitionReferenceNum,
 			      start, &err);
 	if (err) {
@@ -114,9 +114,9 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 	iinfo->i_lenAlloc = 0;
 	iinfo->i_use = 0;
 	iinfo->i_checkpoint = 1;
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_AD_IN_ICB))
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-	else if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+	else if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_SHORT_AD))
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c23744d5ae5c..397d4ea29232 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -142,7 +142,8 @@ void udf_evict_inode(struct inode *inode)
 	clear_inode(inode);
 	if (iinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB &&
 	    inode->i_size != iinfo->i_lenExtents) {
-		udf_warn(inode->i_sb, "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
+		udf_warn(inode_sb(inode),
+			 "Inode %lu (mode %o) has inode size %llu different from extent length %llu. Filesystem need not be standards compliant.\n",
 			 inode->i_ino, inode->i_mode,
 			 (unsigned long long)inode->i_size,
 			 (unsigned long long)iinfo->i_lenExtents);
@@ -255,7 +256,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 	if (!iinfo->i_lenAlloc) {
-		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_SHORT_AD))
 			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 		else
 			iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
@@ -289,7 +290,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 	memset(iinfo->i_ext.i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
 	iinfo->i_lenAlloc = 0;
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_SHORT_AD))
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
@@ -331,7 +332,7 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	struct fileIdentDesc cfi, *sfi, *dfi;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_USE_SHORT_AD))
 		alloctype = ICBTAG_FLAG_AD_SHORT;
 	else
 		alloctype = ICBTAG_FLAG_AD_LONG;
@@ -343,27 +344,27 @@ struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	}
 
 	/* alloc block, and copy data to it */
-	*block = udf_new_block(inode->i_sb, inode,
+	*block = udf_new_block(inode_sb(inode), inode,
 			       iinfo->i_location.partitionReferenceNum,
 			       iinfo->i_location.logicalBlockNum, err);
 	if (!(*block))
 		return NULL;
-	newblock = udf_get_pblock(inode->i_sb, *block,
+	newblock = udf_get_pblock(inode_sb(inode), *block,
 				  iinfo->i_location.partitionReferenceNum,
 				0);
 	if (!newblock)
 		return NULL;
-	dbh = udf_tgetblk(inode->i_sb, newblock);
+	dbh = udf_tgetblk(inode_sb(inode), newblock);
 	if (!dbh)
 		return NULL;
 	lock_buffer(dbh);
-	memset(dbh->b_data, 0x00, inode->i_sb->s_blocksize);
+	memset(dbh->b_data, 0x00, inode_sb(inode)->s_blocksize);
 	set_buffer_uptodate(dbh);
 	unlock_buffer(dbh);
 	mark_buffer_dirty_inode(dbh, inode);
 
 	sfibh.soffset = sfibh.eoffset =
-			f_pos & (inode->i_sb->s_blocksize - 1);
+			f_pos & (inode_sb(inode)->s_blocksize - 1);
 	sfibh.sbh = sfibh.ebh = NULL;
 	dfibh.soffset = dfibh.eoffset = 0;
 	dfibh.sbh = dfibh.ebh = dbh;
@@ -418,7 +419,7 @@ static int udf_get_block(struct inode *inode, sector_t block,
 	if (!create) {
 		phys = udf_block_map(inode, block);
 		if (phys)
-			map_bh(bh_result, inode->i_sb, phys);
+			map_bh(bh_result, inode_sb(inode), phys);
 		return 0;
 	}
 
@@ -439,7 +440,7 @@ static int udf_get_block(struct inode *inode, sector_t block,
 
 	if (new)
 		set_buffer_new(bh_result);
-	map_bh(bh_result, inode->i_sb, phys);
+	map_bh(bh_result, inode_sb(inode), phys);
 
 abort:
 	up_write(&iinfo->i_data_sem);
@@ -456,10 +457,10 @@ static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
 	dummy.b_blocknr = -1000;
 	*err = udf_get_block(inode, block, &dummy, create);
 	if (!*err && buffer_mapped(&dummy)) {
-		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+		bh = sb_getblk(inode_sb(inode), dummy.b_blocknr);
 		if (buffer_new(&dummy)) {
 			lock_buffer(bh);
-			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
+			memset(bh->b_data, 0x00, inode_sb(inode)->s_blocksize);
 			set_buffer_uptodate(bh);
 			unlock_buffer(bh);
 			mark_buffer_dirty_inode(bh, inode);
@@ -478,7 +479,7 @@ static int udf_do_extend_file(struct inode *inode,
 {
 	sector_t add;
 	int count = 0, fake = !(last_ext->extLength & UDF_EXTENT_LENGTH_MASK);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct kernel_lb_addr prealloc_loc = {};
 	uint32_t prealloc_len = 0;
 	struct udf_inode_info *iinfo;
@@ -603,7 +604,7 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
 	int8_t etype;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	sector_t first_block = newsize >> sb->s_blocksize_bits, offset;
 	int adsize;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -677,7 +678,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	prev_epos.block = iinfo->i_location;
 	prev_epos.bh = NULL;
 	cur_epos = next_epos = prev_epos;
-	b_off = (loff_t)block << inode->i_sb->s_blocksize_bits;
+	b_off = (loff_t)block << inode_sb(inode)->s_blocksize_bits;
 
 	/* find the extent which contains the block we are looking for.
 	   alternate between laarr[0] and laarr[1] for locations of the
@@ -713,14 +714,14 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 
 		if (etype != (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30))
 			pgoal = eloc.logicalBlockNum +
-				((elen + inode->i_sb->s_blocksize - 1) >>
-				 inode->i_sb->s_blocksize_bits);
+				((elen + inode_sb(inode)->s_blocksize - 1) >>
+				 inode_sb(inode)->s_blocksize_bits);
 
 		count++;
 	} while (lbcount + elen <= b_off);
 
 	b_off -= lbcount;
-	offset = b_off >> inode->i_sb->s_blocksize_bits;
+	offset = b_off >> inode_sb(inode)->s_blocksize_bits;
 	/*
 	 * Move prev_epos and cur_epos into indirect extent if we are at
 	 * the pointer to it
@@ -732,13 +733,13 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	   if the extent is not a multiple of the blocksize, round up */
 
 	if (etype == (EXT_RECORDED_ALLOCATED >> 30)) {
-		if (elen & (inode->i_sb->s_blocksize - 1)) {
+		if (elen & (inode_sb(inode)->s_blocksize - 1)) {
 			elen = EXT_RECORDED_ALLOCATED |
-				((elen + inode->i_sb->s_blocksize - 1) &
-				 ~(inode->i_sb->s_blocksize - 1));
+				((elen + inode_sb(inode)->s_blocksize - 1) &
+				 ~(inode_sb(inode)->s_blocksize - 1));
 			udf_write_aext(inode, &cur_epos, &eloc, elen, 1);
 		}
-		newblock = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
+		newblock = udf_get_lb_pblock(inode_sb(inode), &eloc, offset);
 		goto out_free;
 	}
 
@@ -777,7 +778,7 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 			if (count)
 				c = !c;
 			laarr[c].extLength = EXT_NOT_RECORDED_NOT_ALLOCATED |
-				inode->i_sb->s_blocksize;
+				inode_sb(inode)->s_blocksize;
 			memset(&laarr[c].extLocation, 0x00,
 				sizeof(struct kernel_lb_addr));
 			count++;
@@ -823,16 +824,16 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 				goal = iinfo->i_location.logicalBlockNum + 1;
 		}
 
-		newblocknum = udf_new_block(inode->i_sb, inode,
-				iinfo->i_location.partitionReferenceNum,
-				goal, err);
+		newblocknum = udf_new_block(inode_sb(inode), inode,
+					    iinfo->i_location.partitionReferenceNum,
+					    goal, err);
 		if (!newblocknum) {
 			*err = -ENOSPC;
 			newblock = 0;
 			goto out_free;
 		}
 		if (isBeyondEOF)
-			iinfo->i_lenExtents += inode->i_sb->s_blocksize;
+			iinfo->i_lenExtents += inode_sb(inode)->s_blocksize;
 	}
 
 	/* if the extent the requsted block is located in contains multiple
@@ -856,8 +857,8 @@ static sector_t inode_getblk(struct inode *inode, sector_t block,
 	 * the new number of extents is less than the old number */
 	udf_update_extents(inode, laarr, startnum, endnum, &prev_epos);
 
-	newblock = udf_get_pblock(inode->i_sb, newblocknum,
-				iinfo->i_location.partitionReferenceNum, 0);
+	newblock = udf_get_pblock(inode_sb(inode), newblocknum,
+				  iinfo->i_location.partitionReferenceNum, 0);
 	if (!newblock) {
 		*err = -EIO;
 		goto out_free;
@@ -882,8 +883,8 @@ static void udf_split_extents(struct inode *inode, int *c, int offset,
 			       udf_pblk_t newblocknum,
 			       struct kernel_long_ad *laarr, int *endnum)
 {
-	unsigned long blocksize = inode->i_sb->s_blocksize;
-	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
+	unsigned long blocksize = inode_sb(inode)->s_blocksize;
+	unsigned char blocksize_bits = inode_sb(inode)->s_blocksize_bits;
 
 	if ((laarr[*c].extLength >> 30) == (EXT_NOT_RECORDED_ALLOCATED >> 30) ||
 	    (laarr[*c].extLength >> 30) ==
@@ -905,7 +906,7 @@ static void udf_split_extents(struct inode *inode, int *c, int offset,
 
 		if (offset) {
 			if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
-				udf_free_blocks(inode->i_sb, inode,
+				udf_free_blocks(inode_sb(inode), inode,
 						&laarr[curr].extLocation,
 						0, offset);
 				laarr[curr].extLength =
@@ -960,8 +961,8 @@ static void udf_prealloc_extents(struct inode *inode, int c, int lastblock,
 			length = currlength =
 				(((laarr[c + 1].extLength &
 					UDF_EXTENT_LENGTH_MASK) +
-				inode->i_sb->s_blocksize - 1) >>
-				inode->i_sb->s_blocksize_bits);
+				inode_sb(inode)->s_blocksize - 1) >>
+				 inode_sb(inode)->s_blocksize_bits);
 		} else
 			start = c;
 	}
@@ -974,8 +975,8 @@ static void udf_prealloc_extents(struct inode *inode, int c, int lastblock,
 				(EXT_NOT_RECORDED_NOT_ALLOCATED >> 30)) {
 			length += (((laarr[i].extLength &
 						UDF_EXTENT_LENGTH_MASK) +
-				    inode->i_sb->s_blocksize - 1) >>
-				    inode->i_sb->s_blocksize_bits);
+				    inode_sb(inode)->s_blocksize - 1) >>
+				    inode_sb(inode)->s_blocksize_bits);
 		} else
 			break;
 	}
@@ -983,18 +984,18 @@ static void udf_prealloc_extents(struct inode *inode, int c, int lastblock,
 	if (length) {
 		int next = laarr[start].extLocation.logicalBlockNum +
 			(((laarr[start].extLength & UDF_EXTENT_LENGTH_MASK) +
-			  inode->i_sb->s_blocksize - 1) >>
-			  inode->i_sb->s_blocksize_bits);
-		int numalloc = udf_prealloc_blocks(inode->i_sb, inode,
-				laarr[start].extLocation.partitionReferenceNum,
-				next, (UDF_DEFAULT_PREALLOC_BLOCKS > length ?
-				length : UDF_DEFAULT_PREALLOC_BLOCKS) -
-				currlength);
+			  inode_sb(inode)->s_blocksize - 1) >>
+			  inode_sb(inode)->s_blocksize_bits);
+		int numalloc = udf_prealloc_blocks(inode_sb(inode), inode,
+						   laarr[start].extLocation.partitionReferenceNum,
+						   next, (UDF_DEFAULT_PREALLOC_BLOCKS > length ?
+							  length : UDF_DEFAULT_PREALLOC_BLOCKS) -
+						   currlength);
 		if (numalloc) 	{
 			if (start == (c + 1))
 				laarr[start].extLength +=
 					(numalloc <<
-					 inode->i_sb->s_blocksize_bits);
+					 inode_sb(inode)->s_blocksize_bits);
 			else {
 				memmove(&laarr[c + 2], &laarr[c + 1],
 					sizeof(struct long_ad) * (*endnum - (c + 1)));
@@ -1006,20 +1007,20 @@ static void udf_prealloc_extents(struct inode *inode, int c, int lastblock,
 				laarr[c + 1].extLength =
 					EXT_NOT_RECORDED_ALLOCATED |
 					(numalloc <<
-					 inode->i_sb->s_blocksize_bits);
+					 inode_sb(inode)->s_blocksize_bits);
 				start = c + 1;
 			}
 
 			for (i = start + 1; numalloc && i < *endnum; i++) {
 				int elen = ((laarr[i].extLength &
 						UDF_EXTENT_LENGTH_MASK) +
-					    inode->i_sb->s_blocksize - 1) >>
-					    inode->i_sb->s_blocksize_bits;
+					    inode_sb(inode)->s_blocksize - 1) >>
+					    inode_sb(inode)->s_blocksize_bits;
 
 				if (elen > numalloc) {
 					laarr[i].extLength -=
 						(numalloc <<
-						 inode->i_sb->s_blocksize_bits);
+						 inode_sb(inode)->s_blocksize_bits);
 					numalloc = 0;
 				} else {
 					numalloc -= elen;
@@ -1033,7 +1034,7 @@ static void udf_prealloc_extents(struct inode *inode, int c, int lastblock,
 				}
 			}
 			UDF_I(inode)->i_lenExtents +=
-				numalloc << inode->i_sb->s_blocksize_bits;
+				numalloc << inode_sb(inode)->s_blocksize_bits;
 		}
 	}
 }
@@ -1042,8 +1043,8 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			      int *endnum)
 {
 	int i;
-	unsigned long blocksize = inode->i_sb->s_blocksize;
-	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
+	unsigned long blocksize = inode_sb(inode)->s_blocksize;
+	unsigned char blocksize_bits = inode_sb(inode)->s_blocksize_bits;
 
 	for (i = 0; i < (*endnum - 1); i++) {
 		struct kernel_long_ad *li /*l[i]*/ = &laarr[i];
@@ -1090,7 +1091,8 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 				(EXT_NOT_RECORDED_ALLOCATED >> 30)) &&
 			   ((lip1->extLength >> 30) ==
 				(EXT_NOT_RECORDED_NOT_ALLOCATED >> 30))) {
-			udf_free_blocks(inode->i_sb, inode, &li->extLocation, 0,
+			udf_free_blocks(inode_sb(inode), inode,
+					&li->extLocation, 0,
 					((li->extLength &
 					  UDF_EXTENT_LENGTH_MASK) +
 					 blocksize - 1) >> blocksize_bits);
@@ -1123,7 +1125,7 @@ static void udf_merge_extents(struct inode *inode, struct kernel_long_ad *laarr,
 			}
 		} else if ((li->extLength >> 30) ==
 					(EXT_NOT_RECORDED_ALLOCATED >> 30)) {
-			udf_free_blocks(inode->i_sb, inode,
+			udf_free_blocks(inode_sb(inode), inode,
 					&li->extLocation, 0,
 					((li->extLength &
 						UDF_EXTENT_LENGTH_MASK) +
@@ -1269,11 +1271,11 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	struct extendedFileEntry *efe;
 	uint16_t ident;
 	struct udf_inode_info *iinfo = UDF_I(inode);
-	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
+	struct udf_sb_info *sbi = UDF_SB(inode_sb(inode));
 	struct kernel_lb_addr *iloc = &iinfo->i_location;
 	unsigned int link_count;
 	unsigned int indirections = 0;
-	int bs = inode->i_sb->s_blocksize;
+	int bs = inode_sb(inode)->s_blocksize;
 	int ret = -EIO;
 
 reread:
@@ -1302,15 +1304,16 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	 *      i_nlink = 1
 	 *      i_op = NULL;
 	 */
-	bh = udf_read_ptagged(inode->i_sb, iloc, 0, &ident);
+	bh = udf_read_ptagged(inode_sb(inode), iloc, 0, &ident);
 	if (!bh) {
-		udf_err(inode->i_sb, "(ino %lu) failed !bh\n", inode->i_ino);
+		udf_err(inode_sb(inode), "(ino %lu) failed !bh\n",
+			inode->i_ino);
 		return -EIO;
 	}
 
 	if (ident != TAG_IDENT_FE && ident != TAG_IDENT_EFE &&
 	    ident != TAG_IDENT_USE) {
-		udf_err(inode->i_sb, "(ino %lu) failed ident=%u\n",
+		udf_err(inode_sb(inode), "(ino %lu) failed ident=%u\n",
 			inode->i_ino, ident);
 		goto out;
 	}
@@ -1321,7 +1324,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	if (fe->icbTag.strategyType == cpu_to_le16(4096)) {
 		struct buffer_head *ibh;
 
-		ibh = udf_read_ptagged(inode->i_sb, iloc, 1, &ident);
+		ibh = udf_read_ptagged(inode_sb(inode), iloc, 1, &ident);
 		if (ident == TAG_IDENT_IE && ibh) {
 			struct kernel_lb_addr loc;
 			struct indirectEntry *ie;
@@ -1334,7 +1337,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 				memcpy(&iinfo->i_location, &loc,
 				       sizeof(struct kernel_lb_addr));
 				if (++indirections > UDF_MAX_ICB_NESTING) {
-					udf_err(inode->i_sb,
+					udf_err(inode_sb(inode),
 						"too many ICBs in ICB hierarchy"
 						" (max %d supported)\n",
 						UDF_MAX_ICB_NESTING);
@@ -1346,7 +1349,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		}
 		brelse(ibh);
 	} else if (fe->icbTag.strategyType != cpu_to_le16(4)) {
-		udf_err(inode->i_sb, "unsupported strategy type: %u\n",
+		udf_err(inode_sb(inode), "unsupported strategy type: %u\n",
 			le16_to_cpu(fe->icbTag.strategyType));
 		goto out;
 	}
@@ -1402,15 +1405,15 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	read_lock(&sbi->s_cred_lock);
 	i_uid_write(inode, le32_to_cpu(fe->uid));
 	if (!uid_valid(inode->i_uid) ||
-	    UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_IGNORE) ||
-	    UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_SET))
-		inode->i_uid = UDF_SB(inode->i_sb)->s_uid;
+	    UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_UID_IGNORE) ||
+	    UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_UID_SET))
+		inode->i_uid = UDF_SB(inode_sb(inode))->s_uid;
 
 	i_gid_write(inode, le32_to_cpu(fe->gid));
 	if (!gid_valid(inode->i_gid) ||
-	    UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_IGNORE) ||
-	    UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_SET))
-		inode->i_gid = UDF_SB(inode->i_sb)->s_gid;
+	    UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_GID_IGNORE) ||
+	    UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_GID_SET))
+		inode->i_gid = UDF_SB(inode_sb(inode))->s_gid;
 
 	if (fe->icbTag.fileType != ICBTAG_FILE_TYPE_DIRECTORY &&
 			sbi->s_fmode != UDF_INVALID_MODE)
@@ -1438,7 +1441,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 
 	if (iinfo->i_efe == 0) {
 		inode->i_blocks = le64_to_cpu(fe->logicalBlocksRecorded) <<
-			(inode->i_sb->s_blocksize_bits - 9);
+			(inode_sb(inode)->s_blocksize_bits - 9);
 
 		if (!udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime))
 			inode->i_atime = sbi->s_record_time;
@@ -1456,7 +1459,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		iinfo->i_checkpoint = le32_to_cpu(fe->checkpoint);
 	} else {
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
-		    (inode->i_sb->s_blocksize_bits - 9);
+		    (inode_sb(inode)->s_blocksize_bits - 9);
 
 		if (!udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime))
 			inode->i_atime = sbi->s_record_time;
@@ -1547,7 +1550,8 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		udf_debug("METADATA BITMAP FILE-----\n");
 		break;
 	default:
-		udf_err(inode->i_sb, "(ino %lu) failed unknown file type=%u\n",
+		udf_err(inode_sb(inode),
+			"(ino %lu) failed unknown file type=%u\n",
 			inode->i_ino, fe->icbTag.fileType);
 		goto out;
 	}
@@ -1624,19 +1628,19 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	uint16_t icbflags;
 	uint16_t crclen;
 	int err = 0;
-	struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
-	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
+	struct udf_sb_info *sbi = UDF_SB(inode_sb(inode));
+	unsigned char blocksize_bits = inode_sb(inode)->s_blocksize_bits;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 
-	bh = udf_tgetblk(inode->i_sb,
-			udf_get_lb_pblock(inode->i_sb, &iinfo->i_location, 0));
+	bh = udf_tgetblk(inode_sb(inode),
+			 udf_get_lb_pblock(inode_sb(inode), &iinfo->i_location, 0));
 	if (!bh) {
 		udf_debug("getblk failure\n");
 		return -EIO;
 	}
 
 	lock_buffer(bh);
-	memset(bh->b_data, 0, inode->i_sb->s_blocksize);
+	memset(bh->b_data, 0, inode_sb(inode)->s_blocksize);
 	fe = (struct fileEntry *)bh->b_data;
 	efe = (struct extendedFileEntry *)bh->b_data;
 
@@ -1646,20 +1650,20 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 
 		use->lengthAllocDescs = cpu_to_le32(iinfo->i_lenAlloc);
 		memcpy(bh->b_data + sizeof(struct unallocSpaceEntry),
-		       iinfo->i_ext.i_data, inode->i_sb->s_blocksize -
-					sizeof(struct unallocSpaceEntry));
+		       iinfo->i_ext.i_data, inode_sb(inode)->s_blocksize -
+		       sizeof(struct unallocSpaceEntry));
 		use->descTag.tagIdent = cpu_to_le16(TAG_IDENT_USE);
 		crclen = sizeof(struct unallocSpaceEntry);
 
 		goto finish;
 	}
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_UID_FORGET))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_UID_FORGET))
 		fe->uid = cpu_to_le32(-1);
 	else
 		fe->uid = cpu_to_le32(i_uid_read(inode));
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_GID_FORGET))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_GID_FORGET))
 		fe->gid = cpu_to_le32(-1);
 	else
 		fe->gid = cpu_to_le32(i_gid_read(inode));
@@ -1716,7 +1720,7 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	if (iinfo->i_efe == 0) {
 		memcpy(bh->b_data + sizeof(struct fileEntry),
 		       iinfo->i_ext.i_data,
-		       inode->i_sb->s_blocksize - sizeof(struct fileEntry));
+		       inode_sb(inode)->s_blocksize - sizeof(struct fileEntry));
 		fe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
 		udf_time_to_disk_stamp(&fe->accessTime, inode->i_atime);
@@ -1735,8 +1739,8 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	} else {
 		memcpy(bh->b_data + sizeof(struct extendedFileEntry),
 		       iinfo->i_ext.i_data,
-		       inode->i_sb->s_blocksize -
-					sizeof(struct extendedFileEntry));
+		       inode_sb(inode)->s_blocksize -
+		       sizeof(struct extendedFileEntry));
 		efe->objectSize = cpu_to_le64(inode->i_size);
 		efe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
@@ -1818,7 +1822,8 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 	if (do_sync) {
 		sync_dirty_buffer(bh);
 		if (buffer_write_io_error(bh)) {
-			udf_warn(inode->i_sb, "IO error syncing udf inode [%08lx]\n",
+			udf_warn(inode_sb(inode),
+				 "IO error syncing udf inode [%08lx]\n",
 				 inode->i_ino);
 			err = -EIO;
 		}
@@ -1855,7 +1860,7 @@ struct inode *__udf_iget(struct super_block *sb, struct kernel_lb_addr *ino,
 int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
 			    struct extent_position *epos)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct buffer_head *bh;
 	struct allocExtDesc *aed;
 	struct extent_position nepos;
@@ -1951,7 +1956,7 @@ int __udf_add_aext(struct inode *inode, struct extent_position *epos,
 		aed = (struct allocExtDesc *)epos->bh->b_data;
 		WARN_ON(le32_to_cpu(aed->lengthAllocDescs) !=
 			epos->offset - sizeof(struct allocExtDesc));
-		WARN_ON(epos->offset + adsize > inode->i_sb->s_blocksize);
+		WARN_ON(epos->offset + adsize > inode_sb(inode)->s_blocksize);
 	}
 
 	udf_write_aext(inode, epos, eloc, elen, inc);
@@ -1962,8 +1967,8 @@ int __udf_add_aext(struct inode *inode, struct extent_position *epos,
 	} else {
 		aed = (struct allocExtDesc *)epos->bh->b_data;
 		le32_add_cpu(&aed->lengthAllocDescs, adsize);
-		if (!UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT) ||
-				UDF_SB(inode->i_sb)->s_udfrev >= 0x0201)
+		if (!UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT) ||
+				UDF_SB(inode_sb(inode))->s_udfrev >= 0x0201)
 			udf_update_tag(epos->bh->b_data,
 					epos->offset + (inc ? 0 : adsize));
 		else
@@ -1983,7 +1988,7 @@ int udf_add_aext(struct inode *inode, struct extent_position *epos,
 		 struct kernel_lb_addr *eloc, uint32_t elen, int inc)
 {
 	int adsize;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (UDF_I(inode)->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 		adsize = sizeof(struct short_ad);
@@ -2045,8 +2050,8 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
 	}
 
 	if (epos->bh) {
-		if (!UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT) ||
-		    UDF_SB(inode->i_sb)->s_udfrev >= 0x0201) {
+		if (!UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT) ||
+		    UDF_SB(inode_sb(inode))->s_udfrev >= 0x0201) {
 			struct allocExtDesc *aed =
 				(struct allocExtDesc *)epos->bh->b_data;
 			udf_update_tag(epos->bh->b_data,
@@ -2079,7 +2084,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		udf_pblk_t block;
 
 		if (++indirections > UDF_MAX_INDIR_EXTS) {
-			udf_err(inode->i_sb,
+			udf_err(inode_sb(inode),
 				"too many indirect extents in inode %lu\n",
 				inode->i_ino);
 			return -1;
@@ -2088,8 +2093,8 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
 		epos->block = *eloc;
 		epos->offset = sizeof(struct allocExtDesc);
 		brelse(epos->bh);
-		block = udf_get_lb_pblock(inode->i_sb, &epos->block, 0);
-		epos->bh = udf_tread(inode->i_sb, block);
+		block = udf_get_lb_pblock(inode_sb(inode), &epos->block, 0);
+		epos->bh = udf_tread(inode_sb(inode), block);
 		if (!epos->bh) {
 			udf_debug("reading block %u failed!\n", block);
 			return -1;
@@ -2214,7 +2219,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
 	elen = 0;
 
 	if (epos.bh != oepos.bh) {
-		udf_free_blocks(inode->i_sb, inode, &epos.block, 0, 1);
+		udf_free_blocks(inode_sb(inode), inode, &epos.block, 0, 1);
 		udf_write_aext(inode, &oepos, &eloc, elen, 1);
 		udf_write_aext(inode, &oepos, &eloc, elen, 1);
 		if (!oepos.bh) {
@@ -2223,8 +2228,8 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
 		} else {
 			aed = (struct allocExtDesc *)oepos.bh->b_data;
 			le32_add_cpu(&aed->lengthAllocDescs, -(2 * adsize));
-			if (!UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT) ||
-			    UDF_SB(inode->i_sb)->s_udfrev >= 0x0201)
+			if (!UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT) ||
+			    UDF_SB(inode_sb(inode))->s_udfrev >= 0x0201)
 				udf_update_tag(oepos.bh->b_data,
 						oepos.offset - (2 * adsize));
 			else
@@ -2240,8 +2245,8 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos,
 		} else {
 			aed = (struct allocExtDesc *)oepos.bh->b_data;
 			le32_add_cpu(&aed->lengthAllocDescs, -adsize);
-			if (!UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT) ||
-			    UDF_SB(inode->i_sb)->s_udfrev >= 0x0201)
+			if (!UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT) ||
+			    UDF_SB(inode_sb(inode))->s_udfrev >= 0x0201)
 				udf_update_tag(oepos.bh->b_data,
 						epos.offset - adsize);
 			else
@@ -2261,7 +2266,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
 		  struct extent_position *pos, struct kernel_lb_addr *eloc,
 		  uint32_t *elen, sector_t *offset)
 {
-	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
+	unsigned char blocksize_bits = inode_sb(inode)->s_blocksize_bits;
 	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
 	int8_t etype;
 	struct udf_inode_info *iinfo;
@@ -2301,14 +2306,14 @@ udf_pblk_t udf_block_map(struct inode *inode, sector_t block)
 
 	if (inode_bmap(inode, block, &epos, &eloc, &elen, &offset) ==
 						(EXT_RECORDED_ALLOCATED >> 30))
-		ret = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
+		ret = udf_get_lb_pblock(inode_sb(inode), &eloc, offset);
 	else
 		ret = 0;
 
 	up_read(&UDF_I(inode)->i_data_sem);
 	brelse(epos.bh);
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_VARCONV))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_VARCONV))
 		return udf_fixed_to_variable(ret);
 	else
 		return ret;
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 401e64cde1be..9aaae9329f27 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -60,7 +60,7 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 		size += sizeof(struct extendedAttrHeaderDesc);
 	}
 
-	offset = inode->i_sb->s_blocksize - udf_file_entry_alloc_offset(inode) -
+	offset = inode_sb(inode)->s_blocksize - udf_file_entry_alloc_offset(inode) -
 		iinfo->i_lenAlloc;
 
 	/* TODO - Check for FreeEASpace */
@@ -80,7 +80,7 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 					iinfo->i_location.logicalBlockNum)
 				return NULL;
 		} else {
-			struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
+			struct udf_sb_info *sbi = UDF_SB(inode_sb(inode));
 
 			size -= sizeof(struct extendedAttrHeaderDesc);
 			iinfo->i_lenEAttr +=
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 0458dd47e105..a6bd6fa95d7d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -178,7 +178,7 @@ static struct fileIdentDesc *udf_find_entry(struct inode *dir,
 	struct udf_inode_info *dinfo = UDF_I(dir);
 	int isdotdot = child->len == 2 &&
 		child->name[0] == '.' && child->name[1] == '.';
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	size = udf_ext0_offset(dir) + dir->i_size;
 	f_pos = udf_ext0_offset(dir);
@@ -313,7 +313,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 				simple_strtoul(dentry->d_name.name + 3,
 						NULL, 0),
 		};
-		inode = udf_iget(dir->i_sb, lb);
+		inode = udf_iget(inode_sb(dir), lb);
 		if (IS_ERR(inode))
 			return inode;
 	} else
@@ -331,7 +331,7 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
 		brelse(fibh.sbh);
 
 		loc = lelb_to_cpu(cfi.icb.extLocation);
-		inode = udf_iget(dir->i_sb, &loc);
+		inode = udf_iget(inode_sb(dir), &loc);
 		if (IS_ERR(inode))
 			return ERR_CAST(inode);
 	}
@@ -344,7 +344,7 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 					   struct udf_fileident_bh *fibh,
 					   struct fileIdentDesc *cfi, int *err)
 {
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 	struct fileIdentDesc *fi = NULL;
 	unsigned char *name = NULL;
 	int namelen;
@@ -387,18 +387,18 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 
 	f_pos = udf_ext0_offset(dir);
 
-	fibh->soffset = fibh->eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
+	fibh->soffset = fibh->eoffset = f_pos & (inode_sb(dir)->s_blocksize - 1);
 	dinfo = UDF_I(dir);
 	if (dinfo->i_alloc_type != ICBTAG_FLAG_AD_IN_ICB) {
-		if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits, &epos,
-		    &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
-			block = udf_get_lb_pblock(dir->i_sb,
-					&dinfo->i_location, 0);
+		if (inode_bmap(dir, f_pos >> inode_sb(dir)->s_blocksize_bits, &epos,
+			       &eloc, &elen, &offset) != (EXT_RECORDED_ALLOCATED >> 30)) {
+			block = udf_get_lb_pblock(inode_sb(dir),
+						  &dinfo->i_location, 0);
 			fibh->soffset = fibh->eoffset = sb->s_blocksize;
 			goto add;
 		}
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
+		block = udf_get_lb_pblock(inode_sb(dir), &eloc, offset);
+		if ((++offset << inode_sb(dir)->s_blocksize_bits) < elen) {
 			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 				epos.offset -= sizeof(struct short_ad);
 			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
@@ -406,7 +406,7 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 		} else
 			offset = 0;
 
-		fibh->sbh = fibh->ebh = udf_tread(dir->i_sb, block);
+		fibh->sbh = fibh->ebh = udf_tread(inode_sb(dir), block);
 		if (!fibh->sbh) {
 			*err = -EIO;
 			goto out_err;
@@ -488,7 +488,7 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 		} else {
 			block = eloc.logicalBlockNum +
 					((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
+						inode_sb(dir)->s_blocksize_bits);
 			fi = (struct fileIdentDesc *)
 				(fibh->sbh->b_data + fibh->soffset);
 		}
@@ -511,9 +511,10 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 		}
 
 		block = eloc.logicalBlockNum + ((elen - 1) >>
-						dir->i_sb->s_blocksize_bits);
+						inode_sb(dir)->s_blocksize_bits);
 		fibh->ebh = udf_bread(dir,
-				f_pos >> dir->i_sb->s_blocksize_bits, 1, err);
+				f_pos >> inode_sb(dir)->s_blocksize_bits, 1,
+				err);
 		if (!fibh->ebh)
 			goto out_err;
 		/* Extents could have been merged, invalidate our position */
@@ -528,7 +529,7 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 				(EXT_RECORDED_ALLOCATED >> 30))
 				;
 			block = eloc.logicalBlockNum + ((elen - 1) >>
-					dir->i_sb->s_blocksize_bits);
+					inode_sb(dir)->s_blocksize_bits);
 			brelse(fibh->sbh);
 			fibh->sbh = fibh->ebh;
 			fi = (struct fileIdentDesc *)(fibh->sbh->b_data);
@@ -591,7 +592,7 @@ static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
 {
 	cfi->fileCharacteristics |= FID_FILE_CHAR_DELETED;
 
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT))
+	if (UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT))
 		memset(&(cfi->icb), 0x00, sizeof(struct long_ad));
 
 	return udf_write_fi(inode, cfi, fi, fibh, NULL, NULL);
@@ -612,7 +613,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 		iput(inode);
 		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	cfi.icb.extLength = cpu_to_le32(inode_sb(inode)->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
 	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
@@ -706,7 +707,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		goto out;
 	}
 	set_nlink(inode, 2);
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	cfi.icb.extLength = cpu_to_le32(inode_sb(inode)->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(dinfo->i_location);
 	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
 		cpu_to_le32(dinfo->i_unique & 0x00000000FFFFFFFFUL);
@@ -724,7 +725,7 @@ static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		iput(inode);
 		goto out;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	cfi.icb.extLength = cpu_to_le32(inode_sb(inode)->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(iinfo->i_location);
 	*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
@@ -758,15 +759,15 @@ static int empty_dir(struct inode *dir)
 	struct udf_inode_info *dinfo = UDF_I(dir);
 
 	f_pos = udf_ext0_offset(dir);
-	fibh.soffset = fibh.eoffset = f_pos & (dir->i_sb->s_blocksize - 1);
+	fibh.soffset = fibh.eoffset = f_pos & (inode_sb(dir)->s_blocksize - 1);
 
 	if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
 		fibh.sbh = fibh.ebh = NULL;
-	else if (inode_bmap(dir, f_pos >> dir->i_sb->s_blocksize_bits,
+	else if (inode_bmap(dir, f_pos >> inode_sb(dir)->s_blocksize_bits,
 			      &epos, &eloc, &elen, &offset) ==
 					(EXT_RECORDED_ALLOCATED >> 30)) {
-		block = udf_get_lb_pblock(dir->i_sb, &eloc, offset);
-		if ((++offset << dir->i_sb->s_blocksize_bits) < elen) {
+		block = udf_get_lb_pblock(inode_sb(dir), &eloc, offset);
+		if ((++offset << inode_sb(dir)->s_blocksize_bits) < elen) {
 			if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
 				epos.offset -= sizeof(struct short_ad);
 			else if (dinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
@@ -774,7 +775,7 @@ static int empty_dir(struct inode *dir)
 		} else
 			offset = 0;
 
-		fibh.sbh = fibh.ebh = udf_tread(dir->i_sb, block);
+		fibh.sbh = fibh.ebh = udf_tread(inode_sb(dir), block);
 		if (!fibh.sbh) {
 			brelse(epos.bh);
 			return 0;
@@ -831,7 +832,7 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 
 	retval = -EIO;
 	tloc = lelb_to_cpu(cfi.icb.extLocation);
-	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
+	if (udf_get_lb_pblock(inode_sb(dir), &tloc, 0) != inode->i_ino)
 		goto end_rmdir;
 	retval = -ENOTEMPTY;
 	if (!empty_dir(inode))
@@ -840,7 +841,8 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	if (retval)
 		goto end_rmdir;
 	if (inode->i_nlink != 2)
-		udf_warn(inode->i_sb, "empty directory has nlink != 2 (%u)\n",
+		udf_warn(inode_sb(inode),
+			 "empty directory has nlink != 2 (%u)\n",
 			 inode->i_nlink);
 	clear_nlink(inode);
 	inode->i_size = 0;
@@ -878,7 +880,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 
 	retval = -EIO;
 	tloc = lelb_to_cpu(cfi.icb.extLocation);
-	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
+	if (udf_get_lb_pblock(inode_sb(dir), &tloc, 0) != inode->i_ino)
 		goto end_unlink;
 
 	if (!inode->i_nlink) {
@@ -918,7 +920,7 @@ static int udf_symlink(struct inode *dir, struct dentry *dentry,
 	unsigned char *name = NULL;
 	int namelen;
 	struct udf_inode_info *iinfo;
-	struct super_block *sb = dir->i_sb;
+	struct super_block *sb = inode_sb(dir);
 
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
@@ -1066,11 +1068,11 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 	if (!fi) {
 		return err;
 	}
-	cfi.icb.extLength = cpu_to_le32(inode->i_sb->s_blocksize);
+	cfi.icb.extLength = cpu_to_le32(inode_sb(inode)->s_blocksize);
 	cfi.icb.extLocation = cpu_to_lelb(UDF_I(inode)->i_location);
-	if (UDF_SB(inode->i_sb)->s_lvid_bh) {
+	if (UDF_SB(inode_sb(inode))->s_lvid_bh) {
 		*(__le32 *)((struct allocDescImpUse *)cfi.icb.impUse)->impUse =
-			cpu_to_le32(lvid_get_unique_id(inode->i_sb));
+			cpu_to_le32(lvid_get_unique_id(inode_sb(inode)));
 	}
 	udf_write_fi(dir, &cfi, fi, &fibh, NULL, NULL);
 	if (UDF_I(dir)->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB)
@@ -1121,7 +1123,7 @@ static int udf_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	brelse(ofibh.sbh);
 	tloc = lelb_to_cpu(ocfi.icb.extLocation);
-	if (!ofi || udf_get_lb_pblock(old_dir->i_sb, &tloc, 0)
+	if (!ofi || udf_get_lb_pblock(inode_sb(old_dir), &tloc, 0)
 	    != old_inode->i_ino)
 		goto end_rename;
 
@@ -1151,18 +1153,20 @@ static int udf_rename(struct inode *old_dir, struct dentry *old_dentry,
 					  (old_iinfo->i_efe ?
 					   sizeof(struct extendedFileEntry) :
 					   sizeof(struct fileEntry)),
-					old_inode->i_sb->s_blocksize, &offset);
+					inode_sb(old_inode)->s_blocksize,
+					&offset);
 		} else {
 			dir_bh = udf_bread(old_inode, 0, 0, &retval);
 			if (!dir_bh)
 				goto end_rename;
 			dir_fi = udf_get_fileident(dir_bh->b_data,
-					old_inode->i_sb->s_blocksize, &offset);
+					inode_sb(old_inode)->s_blocksize,
+					&offset);
 		}
 		if (!dir_fi)
 			goto end_rename;
 		tloc = lelb_to_cpu(dir_fi->icb.extLocation);
-		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
+		if (udf_get_lb_pblock(inode_sb(old_inode), &tloc, 0) !=
 				old_dir->i_ino)
 			goto end_rename;
 	}
diff --git a/fs/udf/partition.c b/fs/udf/partition.c
index 090baff83990..ed7e8a9503da 100644
--- a/fs/udf/partition.c
+++ b/fs/udf/partition.c
@@ -280,7 +280,7 @@ int udf_relocate_blocks(struct super_block *sb, long old_block, long *new_block)
 static uint32_t udf_try_read_meta(struct inode *inode, uint32_t block,
 					uint16_t partition, uint32_t offset)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct udf_part_map *map;
 	struct kernel_lb_addr eloc;
 	uint32_t elen;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index f73239a9a97d..41f42951126a 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2451,7 +2451,7 @@ static unsigned int udf_count_free_table(struct super_block *sb,
 	epos.bh = NULL;
 
 	while ((etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1)
-		accum += (elen >> table->i_sb->s_blocksize_bits);
+		accum += (elen >> inode_sb(table)->s_blocksize_bits);
 
 	brelse(epos.bh);
 	mutex_unlock(&UDF_SB(sb)->s_alloc_mutex);
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 6023c97c6da2..22b521053b5d 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -112,7 +112,7 @@ static int udf_symlink_filler(struct file *file, struct page *page)
 	uint32_t pos;
 
 	/* We don't support symlinks longer than one block */
-	if (inode->i_size > inode->i_sb->s_blocksize) {
+	if (inode->i_size > inode_sb(inode)->s_blocksize) {
 		err = -ENAMETOOLONG;
 		goto out_unmap;
 	}
@@ -124,7 +124,7 @@ static int udf_symlink_filler(struct file *file, struct page *page)
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		symlink = iinfo->i_ext.i_data + iinfo->i_lenEAttr;
 	} else {
-		bh = sb_bread(inode->i_sb, pos);
+		bh = sb_bread(inode_sb(inode), pos);
 
 		if (!bh) {
 			err = -EIO;
@@ -134,7 +134,8 @@ static int udf_symlink_filler(struct file *file, struct page *page)
 		symlink = bh->b_data;
 	}
 
-	err = udf_pc_to_char(inode->i_sb, symlink, inode->i_size, p, PAGE_SIZE);
+	err = udf_pc_to_char(inode_sb(inode), symlink, inode->i_size, p,
+			     PAGE_SIZE);
 	brelse(bh);
 	if (err)
 		goto out_unlock_inode;
diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index b647f0bd150c..cbb31c433908 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -31,14 +31,14 @@ static void extent_trunc(struct inode *inode, struct extent_position *epos,
 			 uint32_t nelen)
 {
 	struct kernel_lb_addr neloc = {};
-	int last_block = (elen + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
-	int first_block = (nelen + inode->i_sb->s_blocksize - 1) >>
-		inode->i_sb->s_blocksize_bits;
+	int last_block = (elen + inode_sb(inode)->s_blocksize - 1) >>
+		inode_sb(inode)->s_blocksize_bits;
+	int first_block = (nelen + inode_sb(inode)->s_blocksize - 1) >>
+		inode_sb(inode)->s_blocksize_bits;
 
 	if (nelen) {
 		if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
-			udf_free_blocks(inode->i_sb, inode, eloc, 0,
+			udf_free_blocks(inode_sb(inode), inode, eloc, 0,
 					last_block);
 			etype = (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30);
 		} else
@@ -53,7 +53,7 @@ static void extent_trunc(struct inode *inode, struct extent_position *epos,
 				mark_inode_dirty(inode);
 
 			if (etype != (EXT_NOT_RECORDED_NOT_ALLOCATED >> 30))
-				udf_free_blocks(inode->i_sb, inode, eloc,
+				udf_free_blocks(inode_sb(inode), inode, eloc,
 						first_block,
 						last_block - first_block);
 		}
@@ -93,8 +93,8 @@ void udf_truncate_tail_extent(struct inode *inode)
 		etype = netype;
 		lbcount += elen;
 		if (lbcount > inode->i_size) {
-			if (lbcount - inode->i_size >= inode->i_sb->s_blocksize)
-				udf_warn(inode->i_sb,
+			if (lbcount - inode->i_size >= inode_sb(inode)->s_blocksize)
+				udf_warn(inode_sb(inode),
 					 "Too long extent after EOF in inode %u: i_size: %lld lbcount: %lld extent %u+%u\n",
 					 (unsigned)inode->i_ino,
 					 (long long)inode->i_size,
@@ -106,7 +106,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
 			epos.offset += adsize;
 			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
-				udf_err(inode->i_sb,
+				udf_err(inode_sb(inode),
 					"Extent after EOF in inode %u\n",
 					(unsigned)inode->i_ino);
 			break;
@@ -161,8 +161,8 @@ void udf_discard_prealloc(struct inode *inode)
 			aed->lengthAllocDescs =
 				cpu_to_le32(epos.offset -
 					    sizeof(struct allocExtDesc));
-			if (!UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_STRICT) ||
-			    UDF_SB(inode->i_sb)->s_udfrev >= 0x0201)
+			if (!UDF_QUERY_FLAG(inode_sb(inode), UDF_FLAG_STRICT) ||
+			    UDF_SB(inode_sb(inode))->s_udfrev >= 0x0201)
 				udf_update_tag(epos.bh->b_data, epos.offset);
 			else
 				udf_update_tag(epos.bh->b_data,
@@ -180,7 +180,7 @@ static void udf_update_alloc_ext_desc(struct inode *inode,
 				      struct extent_position *epos,
 				      u32 lenalloc)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct udf_sb_info *sbi = UDF_SB(sb);
 
 	struct allocExtDesc *aed = (struct allocExtDesc *) (epos->bh->b_data);
@@ -205,7 +205,7 @@ void udf_truncate_extents(struct inode *inode)
 	struct kernel_lb_addr eloc, neloc = {};
 	uint32_t elen, nelen = 0, indirect_ext_len = 0, lenalloc;
 	int8_t etype;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	sector_t first_block = inode->i_size >> sb->s_blocksize_bits, offset;
 	loff_t byte_offset;
 	int adsize;
-- 
2.15.1
