Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45097C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CEF2151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CEF2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbeHGVLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:11:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbeHGVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:11:43 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87D36D07;
        Tue,  7 Aug 2018 18:55:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Benjamin Gilbert <bgilbert@redhat.com>
Subject: [PATCH 4.4 08/12] ext4: fix false negatives *and* false positives in ext4_check_descriptors()
Date:   Tue,  7 Aug 2018 20:52:12 +0200
Message-Id: <20180807172343.710035023@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172343.326201671@linuxfoundation.org>
References: <20180807172343.326201671@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 44de022c4382541cebdd6de4465d1f4f465ff1dd upstream.

Ext4_check_descriptors() was getting called before s_gdb_count was
initialized.  So for file systems w/o the meta_bg feature, allocation
bitmaps could overlap the block group descriptors and ext4 wouldn't
notice.

For file systems with the meta_bg feature enabled, there was a
fencepost error which would cause the ext4_check_descriptors() to
incorrectly believe that the block allocation bitmap overlaps with the
block group descriptor blocks, and it would reject the mount.

Fix both of these problems.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Gilbert <bgilbert@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2102,7 +2102,7 @@ static int ext4_check_descriptors(struct
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	ext4_fsblk_t last_block;
-	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0) + 1;
+	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0);
 	ext4_fsblk_t block_bitmap;
 	ext4_fsblk_t inode_bitmap;
 	ext4_fsblk_t inode_table;
@@ -3777,13 +3777,13 @@ static int ext4_fill_super(struct super_
 			goto failed_mount2;
 		}
 	}
+	sbi->s_gdb_count = db_count;
 	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
 		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
 		ret = -EFSCORRUPTED;
 		goto failed_mount2;
 	}
 
-	sbi->s_gdb_count = db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
 


