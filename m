Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeE3Lsj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:48:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60636 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751622AbeE3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wen Xu" <wen.xu@gatech.edu>,
        "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.336797334@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 008/153] ext4: add validity checks for bitmap block
 numbers
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 7dac4a1726a9c64a517d595c40e95e2d0d135f6f upstream.

An privileged attacker can cause a crash by mounting a crafted ext4
image which triggers a out-of-bounds read in the function
ext4_valid_block_bitmap() in fs/ext4/balloc.c.

This issue has been assigned CVE-2018-1093.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199181
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1560782
Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.2:
 - In ext4_valid_block_bitmap(), goto err_out on error
 - In ext4_read_{block,inode}_bitmap(), return NULL on error
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -298,20 +298,25 @@ static int ext4_valid_block_bitmap(struc
 	/* check whether block bitmap block number is set */
 	bitmap_blk = ext4_block_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode table block number is set */
 	bitmap_blk = ext4_inode_table(sb, desc);
 	offset = bitmap_blk - group_first_block;
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= sb->s_blocksize)
+		goto err_out;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
 			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
 			EXT4_B2C(sbi, offset));
@@ -339,6 +344,7 @@ struct buffer_head *
 ext4_read_block_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 
@@ -346,6 +352,12 @@ ext4_read_block_bitmap(struct super_bloc
 	if (!desc)
 		return NULL;
 	bitmap_blk = ext4_block_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid block bitmap block %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return NULL;
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read block bitmap - "
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -102,6 +102,7 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct buffer_head *bh = NULL;
 	ext4_fsblk_t bitmap_blk;
 
@@ -110,6 +111,12 @@ ext4_read_inode_bitmap(struct super_bloc
 		return NULL;
 
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
+	if ((bitmap_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >= ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid inode bitmap blk %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return NULL;
+	}
 	bh = sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read inode bitmap - "
