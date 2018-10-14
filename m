Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B613C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B86720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B86720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeJNXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:48:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35569 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbeJNXLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:39 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0004cj-LE; Sun, 14 Oct 2018 16:30:18 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLN-00009Z-G1; Sun, 14 Oct 2018 16:30:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.737280247@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 015/366] ext4: don't update checksum of new
 initialized bitmaps
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 044e6e3d74a3d7103a0c8a9305dfd94d64000660 upstream.

When reading the inode or block allocation bitmap, if the bitmap needs
to be initialized, do not update the checksum in the block group
descriptor.  That's because we're not set up to journal those changes.
Instead, just set the verified bit on the bitmap block, so that it's
not necessary to validate the checksum.

When a block or inode allocation actually happens, at that point the
checksum will be calculated, and update of the bg descriptor block
will be properly journalled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/balloc.c |  3 +--
 fs/ext4/ialloc.c | 47 +++--------------------------------------------
 2 files changed, 4 insertions(+), 46 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -239,8 +239,6 @@ static int ext4_init_block_bitmap(struct
 	 */
 	ext4_mark_bitmap_end(num_clusters_in_group(sb, block_group),
 			     sb->s_blocksize * 8, bh->b_data);
-	ext4_block_bitmap_csum_set(sb, block_group, gdp, bh);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
 	return 0;
 }
 
@@ -464,6 +462,7 @@ ext4_read_block_bitmap_nowait(struct sup
 		err = ext4_init_block_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
+		set_buffer_verified(bh);
 		ext4_unlock_group(sb, block_group);
 		unlock_buffer(bh);
 		if (err)
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -64,45 +64,6 @@ void ext4_mark_bitmap_end(int start_bit,
 		memset(bitmap + (i >> 3), 0xff, (end_bit - i) >> 3);
 }
 
-/* Initializes an uninitialized inode bitmap */
-static unsigned ext4_init_inode_bitmap(struct super_block *sb,
-				       struct buffer_head *bh,
-				       ext4_group_t block_group,
-				       struct ext4_group_desc *gdp)
-{
-	struct ext4_group_info *grp;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	J_ASSERT_BH(bh, buffer_locked(bh));
-
-	/* If checksum is bad mark all blocks and inodes use to prevent
-	 * allocation, essentially implementing a per-group read-only flag. */
-	if (!ext4_group_desc_csum_verify(sb, block_group, gdp)) {
-		ext4_error(sb, "Checksum bad for group %u", block_group);
-		grp = ext4_get_group_info(sb, block_group);
-		if (!EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
-			percpu_counter_sub(&sbi->s_freeclusters_counter,
-					   grp->bb_free);
-		set_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, &grp->bb_state);
-		if (!EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
-			int count;
-			count = ext4_free_inodes_count(sb, gdp);
-			percpu_counter_sub(&sbi->s_freeinodes_counter,
-					   count);
-		}
-		set_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &grp->bb_state);
-		return 0;
-	}
-
-	memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
-	ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb), sb->s_blocksize * 8,
-			bh->b_data);
-	ext4_inode_bitmap_csum_set(sb, block_group, gdp, bh,
-				   EXT4_INODES_PER_GROUP(sb) / 8);
-	ext4_group_desc_csum_set(sb, block_group, gdp);
-
-	return EXT4_INODES_PER_GROUP(sb);
-}
-
 void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate)
 {
 	if (uptodate) {
@@ -166,7 +127,9 @@ ext4_read_inode_bitmap(struct super_bloc
 			put_bh(bh);
 			return NULL;
 		}
-		ext4_init_inode_bitmap(sb, bh, block_group, desc);
+		memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
+		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
+				     sb->s_blocksize * 8, bh->b_data);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
 		set_buffer_verified(bh);

