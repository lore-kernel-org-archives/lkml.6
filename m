Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CCECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BEA2159E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BEA2159E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392342AbeIVGNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44234 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392004AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008Bd-6Y; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000s2-2n; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.443081298@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 29/63] ext4: make sure bitmaps and the inode table
 don't overlap with bg descriptors
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 77260807d1170a8cf35dbb06e07461a655f67eee upstream.

It's really bad when the allocation bitmaps and the inode table
overlap with the block group descriptors, since it causes random
corruption of the bg descriptors.  So we really want to head those off
at the pass.

https://bugzilla.kernel.org/show_bug.cgi?id=199865

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: Open-code sb_rdonly()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2086,6 +2086,7 @@ static int ext4_check_descriptors(struct
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	ext4_fsblk_t last_block;
+	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0) + 1;
 	ext4_fsblk_t block_bitmap;
 	ext4_fsblk_t inode_bitmap;
 	ext4_fsblk_t inode_table;
@@ -2118,6 +2119,14 @@ static int ext4_check_descriptors(struct
 			if (!(sb->s_flags & MS_RDONLY))
 				return 0;
 		}
+		if (block_bitmap >= sb_block + 1 &&
+		    block_bitmap <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Block bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 			       "Block bitmap for group %u not in group "
@@ -2132,6 +2141,14 @@ static int ext4_check_descriptors(struct
 			if (!(sb->s_flags & MS_RDONLY))
 				return 0;
 		}
+		if (inode_bitmap >= sb_block + 1 &&
+		    inode_bitmap <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 			       "Inode bitmap for group %u not in group "
@@ -2146,6 +2163,14 @@ static int ext4_check_descriptors(struct
 			if (!(sb->s_flags & MS_RDONLY))
 				return 0;
 		}
+		if (inode_table >= sb_block + 1 &&
+		    inode_table <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode table for group %u overlaps "
+				 "block group descriptors", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
+		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "

