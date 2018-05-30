Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeE3LHH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:07:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60627 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751507AbeE3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.225630673@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 007/153] ext4: fix block bitmap validation when
 bigalloc, ^flex_bg
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>

commit e674e5cbd0942b42a12106ac0be8330f4301bef4 upstream.

On a bigalloc,^flex_bg filesystem, the ext4_valid_block_bitmap
function fails to convert from blocks to clusters when spot-checking
the validity of the bitmap block that we've just read from disk.  This
causes ext4 to think that the bitmap is garbage, which results in the
block group being taken offline when it's not necessary.  Add in the
necessary EXT4_B2C() calls to perform the conversions.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/balloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -278,6 +278,7 @@ static int ext4_valid_block_bitmap(struc
 					unsigned int block_group,
 					struct buffer_head *bh)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t offset;
 	ext4_grpblk_t next_zero_bit;
 	ext4_fsblk_t bitmap_blk;
@@ -297,14 +298,14 @@ static int ext4_valid_block_bitmap(struc
 	/* check whether block bitmap block number is set */
 	bitmap_blk = ext4_block_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (!ext4_test_bit(offset, bh->b_data))
+	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (!ext4_test_bit(offset, bh->b_data))
+	if (!ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
@@ -312,9 +313,10 @@ static int ext4_valid_block_bitmap(struc
 	bitmap_blk = ext4_inode_table(sb, desc);
 	offset = bitmap_blk - group_first_block;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
-				offset + EXT4_SB(sb)->s_itb_per_group,
-				offset);
-	if (next_zero_bit >= offset + EXT4_SB(sb)->s_itb_per_group)
+			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
+			EXT4_B2C(sbi, offset));
+	if (next_zero_bit >=
+	    EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group))
 		/* good bitmap for inode tables */
 		return 1;
 
