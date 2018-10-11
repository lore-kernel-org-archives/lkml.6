Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D608C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046A121476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXRyW2ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046A121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeJKXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeJKXJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A5720652;
        Thu, 11 Oct 2018 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272482;
        bh=sC8nGGtx44WePJo+NblbHm3uqDOQEIMrtBRQsiroaag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXRyW2yeHSl7ObxivRiA72t8UL+pr8QjRacMu33q5g4lXCvW40vxmBs8UuYKNcviP
         SgyUObiMphEcjF7ec9oBDMpUcdy9xZODSSJxBjG13vZ4UEn5cuCqTKD0FBPT7LMkm6
         spY/pT29JoCEuI4bnQhrVGsnQp8vgbM21wJTMbuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 111/120] ext4: fix false negatives *and* false positives in ext4_check_descriptors()
Date:   Thu, 11 Oct 2018 17:34:52 +0200
Message-Id: <20181011152554.384536691@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2064,7 +2064,7 @@ static int ext4_check_descriptors(struct
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t first_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	ext4_fsblk_t last_block;
-	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0) + 1;
+	ext4_fsblk_t last_bg_block = sb_block + ext4_bg_num_gdb(sb, 0);
 	ext4_fsblk_t block_bitmap;
 	ext4_fsblk_t inode_bitmap;
 	ext4_fsblk_t inode_table;
@@ -4018,12 +4018,12 @@ static int ext4_fill_super(struct super_
 			goto failed_mount2;
 		}
 	}
+	sbi->s_gdb_count = db_count;
 	if (!ext4_check_descriptors(sb, logical_sb_block, &first_not_zeroed)) {
 		ext4_msg(sb, KERN_ERR, "group descriptors corrupted!");
 		goto failed_mount2;
 	}
 
-	sbi->s_gdb_count = db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	spin_lock_init(&sbi->s_next_gen_lock);
 


