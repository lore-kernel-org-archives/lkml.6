Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755734AbeEHSFz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:05:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:54115 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755673AbeEHSFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:50 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 42/76] fs/isofs: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:02 -0700
Message-Id: <20180508180436.716-43-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/isofs/dir.c    |  2 +-
 fs/isofs/export.c |  6 +++---
 fs/isofs/inode.c  | 22 ++++++++++++----------
 fs/isofs/joliet.c |  4 ++--
 fs/isofs/namei.c  |  4 ++--
 fs/isofs/rock.c   | 29 +++++++++++++++--------------
 6 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 947ce22f5b3c..1d3f1d10bea3 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -93,7 +93,7 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 	int first_de = 1;
 	char *p = NULL;		/* Quiet GCC */
 	struct iso_directory_record *de;
-	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
+	struct isofs_sb_info *sbi = ISOFS_SB(inode_sb(inode));
 
 	offset = ctx->pos & (bufsize - 1);
 	block = ctx->pos >> bufbits;
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 85a9093769a9..2bb64a3c1130 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -75,7 +75,7 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 	parent_block = e_child_inode->i_iget5_block;
 
 	/* Get the block in question. */
-	bh = sb_bread(child_inode->i_sb, parent_block);
+	bh = sb_bread(inode_sb(child_inode), parent_block);
 	if (bh == NULL) {
 		rv = ERR_PTR(-EACCES);
 		goto out;
@@ -99,8 +99,8 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 	/* Normalize */
 	isofs_normalize_block_and_offset(de, &parent_block, &parent_offset);
 
-	rv = d_obtain_alias(isofs_iget(child_inode->i_sb, parent_block,
-				     parent_offset));
+	rv = d_obtain_alias(isofs_iget(inode_sb(child_inode), parent_block,
+				       parent_offset));
  out:
 	if (bh)
 		brelse(bh);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index bc258a4402f6..295830250d4b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1090,7 +1090,7 @@ int isofs_get_blocks(struct inode *inode, sector_t iblock,
 			struct inode *ninode;
 
 			offset += sect_size;
-			ninode = isofs_iget(inode->i_sb, nextblk, nextoff);
+			ninode = isofs_iget(inode_sb(inode), nextblk, nextoff);
 			if (IS_ERR(ninode)) {
 				error = PTR_ERR(ninode);
 				goto abort;
@@ -1113,9 +1113,11 @@ int isofs_get_blocks(struct inode *inode, sector_t iblock,
 		}
 
 		if (*bh) {
-			map_bh(*bh, inode->i_sb, firstext + b_off - offset);
+			map_bh(*bh, inode_sb(inode),
+			       firstext + b_off - offset);
 		} else {
-			*bh = sb_getblk(inode->i_sb, firstext+b_off-offset);
+			*bh = sb_getblk(inode_sb(inode),
+					firstext+b_off-offset);
 			if (!*bh)
 				goto abort;
 		}
@@ -1165,7 +1167,7 @@ struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 	sector_t blknr = isofs_bmap(inode, block);
 	if (!blknr)
 		return NULL;
-	return sb_bread(inode->i_sb, blknr);
+	return sb_bread(inode_sb(inode), blknr);
 }
 
 static int isofs_readpage(struct file *file, struct page *page)
@@ -1193,7 +1195,7 @@ static const struct address_space_operations isofs_aops = {
 static int isofs_read_level3_size(struct inode *inode)
 {
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
-	int high_sierra = ISOFS_SB(inode->i_sb)->s_high_sierra;
+	int high_sierra = ISOFS_SB(inode_sb(inode))->s_high_sierra;
 	struct buffer_head *bh = NULL;
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
@@ -1217,7 +1219,7 @@ static int isofs_read_level3_size(struct inode *inode)
 		unsigned int de_len;
 
 		if (!bh) {
-			bh = sb_bread(inode->i_sb, block);
+			bh = sb_bread(inode_sb(inode), block);
 			if (!bh)
 				goto out_noread;
 		}
@@ -1250,7 +1252,7 @@ static int isofs_read_level3_size(struct inode *inode)
 			brelse(bh);
 			bh = NULL;
 			if (offset) {
-				bh = sb_bread(inode->i_sb, block);
+				bh = sb_bread(inode_sb(inode), block);
 				if (!bh)
 					goto out_noread;
 				memcpy((void *)tmpde+slop, bh->b_data, offset);
@@ -1295,7 +1297,7 @@ static int isofs_read_level3_size(struct inode *inode)
 
 static int isofs_read_inode(struct inode *inode, int relocated)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct isofs_sb_info *sbi = ISOFS_SB(sb);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	unsigned long block;
@@ -1309,7 +1311,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 	int ret = -EIO;
 
 	block = ei->i_iget5_block;
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode_sb(inode), block);
 	if (!bh)
 		goto out_badread;
 
@@ -1328,7 +1330,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		}
 		memcpy(tmpde, bh->b_data + offset, frag1);
 		brelse(bh);
-		bh = sb_bread(inode->i_sb, ++block);
+		bh = sb_bread(inode_sb(inode), ++block);
 		if (!bh)
 			goto out_badread;
 		memcpy((char *)tmpde+frag1, bh->b_data, de_len - frag1);
diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
index be8b6a9d0b92..47b0ac950a14 100644
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -45,8 +45,8 @@ get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, st
 	struct nls_table *nls;
 	unsigned char len = 0;
 
-	utf8 = ISOFS_SB(inode->i_sb)->s_utf8;
-	nls = ISOFS_SB(inode->i_sb)->s_nls_iocharset;
+	utf8 = ISOFS_SB(inode_sb(inode))->s_utf8;
+	nls = ISOFS_SB(inode_sb(inode))->s_nls_iocharset;
 
 	if (utf8) {
 		len = utf16s_to_utf8s((const wchar_t *) de->name,
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index cac468f04820..ae74cba9b3e8 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -41,7 +41,7 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 	unsigned char bufbits = ISOFS_BUFFER_BITS(dir);
 	unsigned long block, f_pos, offset, block_saved, offset_saved;
 	struct buffer_head *bh = NULL;
-	struct isofs_sb_info *sbi = ISOFS_SB(dir->i_sb);
+	struct isofs_sb_info *sbi = ISOFS_SB(inode_sb(dir));
 
 	if (!ISOFS_I(dir)->i_first_extent)
 		return 0;
@@ -167,7 +167,7 @@ struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned i
 				1024 + page_address(page));
 	__free_page(page);
 
-	inode = found ? isofs_iget(dir->i_sb, block, offset) : NULL;
+	inode = found ? isofs_iget(inode_sb(dir), block, offset) : NULL;
 
 	return d_splice_alias(inode, dentry);
 }
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 94ef92fe806c..3f398cd95143 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -46,7 +46,7 @@ static int check_sp(struct rock_ridge *rr, struct inode *inode)
 		return -1;
 	if (rr->u.SP.magic[1] != 0xef)
 		return -1;
-	ISOFS_SB(inode->i_sb)->s_rock_offset = rr->u.SP.skip;
+	ISOFS_SB(inode_sb(inode))->s_rock_offset = rr->u.SP.skip;
 	return 0;
 }
 
@@ -61,9 +61,9 @@ static void setup_rock_ridge(struct iso_directory_record *de,
 	if (rs->len < 0)
 		rs->len = 0;
 
-	if (ISOFS_SB(inode->i_sb)->s_rock_offset != -1) {
-		rs->len -= ISOFS_SB(inode->i_sb)->s_rock_offset;
-		rs->chr += ISOFS_SB(inode->i_sb)->s_rock_offset;
+	if (ISOFS_SB(inode_sb(inode))->s_rock_offset != -1) {
+		rs->len -= ISOFS_SB(inode_sb(inode))->s_rock_offset;
+		rs->chr += ISOFS_SB(inode_sb(inode))->s_rock_offset;
 		if (rs->len < 0)
 			rs->len = 0;
 	}
@@ -112,7 +112,7 @@ static int rock_continue(struct rock_state *rs)
 		ret = -EIO;
 		if (++rs->cont_loops >= RR_MAX_CE_ENTRIES)
 			goto out;
-		bh = sb_bread(rs->inode->i_sb, rs->cont_extent);
+		bh = sb_bread(inode_sb(rs->inode), rs->cont_extent);
 		if (bh) {
 			memcpy(rs->buffer, bh->b_data + rs->cont_offset,
 					rs->cont_size);
@@ -207,7 +207,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
 	char *p;
 	int len;
 
-	if (!ISOFS_SB(inode->i_sb)->s_rock)
+	if (!ISOFS_SB(inode_sb(inode))->s_rock)
 		return 0;
 	*retname = 0;
 
@@ -318,7 +318,7 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 	struct rock_state rs;
 	int ret = 0;
 
-	if (!ISOFS_SB(inode->i_sb)->s_rock)
+	if (!ISOFS_SB(inode_sb(inode))->s_rock)
 		return 0;
 
 	init_rock_state(&rs, inode);
@@ -373,7 +373,7 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			/* Invalid length of ER tag id? */
 			if (rr->u.ER.len_id + offsetof(struct rock_ridge, u.ER.data) > rr->len)
 				goto out;
-			ISOFS_SB(inode->i_sb)->s_rock = 1;
+			ISOFS_SB(inode_sb(inode))->s_rock = 1;
 			printk(KERN_DEBUG "ISO 9660 Extensions: ");
 			{
 				int p;
@@ -521,7 +521,8 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				goto eio;
 			}
 			ISOFS_I(inode)->i_first_extent = reloc_block;
-			reloc = isofs_iget_reloc(inode->i_sb, reloc_block, 0);
+			reloc = isofs_iget_reloc(inode_sb(inode), reloc_block,
+						 0);
 			if (IS_ERR(reloc)) {
 				ret = PTR_ERR(reloc);
 				goto out;
@@ -542,7 +543,7 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 		case SIG('Z', 'F'): {
 			int algo;
 
-			if (ISOFS_SB(inode->i_sb)->s_nocompress)
+			if (ISOFS_SB(inode_sb(inode))->s_nocompress)
 				break;
 			algo = isonum_721(rr->u.ZF.algorithm);
 			if (algo == SIG('p', 'z')) {
@@ -678,8 +679,8 @@ int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode,
 	 * if rockridge flag was reset and we didn't look for attributes
 	 * behind eventual XA attributes, have a look there
 	 */
-	if ((ISOFS_SB(inode->i_sb)->s_rock_offset == -1)
-	    && (ISOFS_SB(inode->i_sb)->s_rock == 2)) {
+	if ((ISOFS_SB(inode_sb(inode))->s_rock_offset == -1)
+	    && (ISOFS_SB(inode_sb(inode))->s_rock == 2)) {
 		result = parse_rock_ridge_inode_internal(de, inode,
 							 flags | RR_REGARD_XA);
 	}
@@ -694,7 +695,7 @@ static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct iso_inode_info *ei = ISOFS_I(inode);
-	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
+	struct isofs_sb_info *sbi = ISOFS_SB(inode_sb(inode));
 	char *link = page_address(page);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	struct buffer_head *bh;
@@ -712,7 +713,7 @@ static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 
 	init_rock_state(&rs, inode);
 	block = ei->i_iget5_block;
-	bh = sb_bread(inode->i_sb, block);
+	bh = sb_bread(inode_sb(inode), block);
 	if (!bh)
 		goto out_noread;
 
-- 
2.15.1
