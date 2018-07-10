Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC9FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3135D2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3135D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGJSc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbeGJSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 917ABCED;
        Tue, 10 Jul 2018 18:32:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 18/53] ext4: make sure bitmaps and the inode table dont overlap with bg descriptors
Date:   Tue, 10 Jul 2018 20:24:54 +0200
Message-Id: <20180710182459.936814484@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 77260807d1170a8cf35dbb06e07461a655f67eee upstream.

It's really bad when the allocation bitmaps and the inode table
overlap with the block group descriptors, since it causes random
corruption of the bg descriptors.  So we really want to head those off
at the pass.

https://bugzilla.kernel.org/show_bug.cgi?id=199865

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2301,6 +2301,7 @@ static int ext4_check_descriptors(struct
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	ext4_fsblk_t last_block;
+	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0) + 1;
 	ext4_fsblk_t block_bitmap;
 	ext4_fsblk_t inode_bitmap;
 	ext4_fsblk_t inode_table;
@@ -2333,6 +2334,14 @@ static int ext4_check_descriptors(struct
 			if (!sb_rdonly(sb))
 				return 0;
 		}
+		if (block_bitmap >= sb_block + 1 &&
+		    block_bitmap <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Block bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!sb_rdonly(sb))
+				return 0;
+		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 			       "Block bitmap for group %u not in group "
@@ -2347,6 +2356,14 @@ static int ext4_check_descriptors(struct
 			if (!sb_rdonly(sb))
 				return 0;
 		}
+		if (inode_bitmap >= sb_block + 1 &&
+		    inode_bitmap <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode bitmap for group %u overlaps "
+				 "block group descriptors", i);
+			if (!sb_rdonly(sb))
+				return 0;
+		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 			       "Inode bitmap for group %u not in group "
@@ -2361,6 +2378,14 @@ static int ext4_check_descriptors(struct
 			if (!sb_rdonly(sb))
 				return 0;
 		}
+		if (inode_table >= sb_block + 1 &&
+		    inode_table <= last_bg_block) {
+			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
+				 "Inode table for group %u overlaps "
+				 "block group descriptors", i);
+			if (!sb_rdonly(sb))
+				return 0;
+		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "


