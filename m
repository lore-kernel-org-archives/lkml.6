Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeE3Lsw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:48:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60634 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751354AbeE3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Lukas Czerner" <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, "Ilya Dryomov" <idryomov@gmail.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.620272687@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 009/153] ext4: fix bitmap position validation
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Czerner <lczerner@redhat.com>

commit 22be37acce25d66ecf6403fc8f44df9c5ded2372 upstream.

Currently in ext4_valid_block_bitmap() we expect the bitmap to be
positioned anywhere between 0 and s_blocksize clusters, but that's
wrong because the bitmap can be placed anywhere in the block group. This
causes false positives when validating bitmaps on perfectly valid file
system layouts. Fix it by checking whether the bitmap is within the group
boundary.

The problem can be reproduced using the following

mkfs -t ext3 -E stride=256 /dev/vdb1
mount /dev/vdb1 /mnt/test
cd /mnt/test
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.16.3.tar.xz
tar xf linux-4.16.3.tar.xz

This will result in the warnings in the logs

EXT4-fs error (device vdb1): ext4_validate_block_bitmap:399: comm tar: bg 84: block 2774529: invalid block bitmap

[ Changed slightly for clarity and to not drop a overflow test -- TYT ]

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Ilya Dryomov <idryomov@gmail.com>
Fixes: 7dac4a1726a9 ("ext4: add validity checks for bitmap block numbers")
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/balloc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -281,6 +281,7 @@ static int ext4_valid_block_bitmap(struc
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_grpblk_t offset;
 	ext4_grpblk_t next_zero_bit;
+	ext4_grpblk_t max_bit = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_fsblk_t bitmap_blk;
 	ext4_fsblk_t group_first_block;
 
@@ -298,7 +299,7 @@ static int ext4_valid_block_bitmap(struc
 	/* check whether block bitmap block number is set */
 	bitmap_blk = ext4_block_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
@@ -306,7 +307,7 @@ static int ext4_valid_block_bitmap(struc
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = ext4_inode_bitmap(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
 	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
@@ -314,8 +315,8 @@ static int ext4_valid_block_bitmap(struc
 	/* check whether the inode table block number is set */
 	bitmap_blk = ext4_inode_table(sb, desc);
 	offset = bitmap_blk - group_first_block;
-	if (offset < 0 || EXT4_B2C(sbi, offset) >= sb->s_blocksize ||
-	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= sb->s_blocksize)
+	if (offset < 0 || EXT4_B2C(sbi, offset) >= max_bit ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >= max_bit)
 		goto err_out;
 	next_zero_bit = ext4_find_next_zero_bit(bh->b_data,
 			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
