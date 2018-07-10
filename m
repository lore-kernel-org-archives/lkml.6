Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61FEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7146720C0C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7146720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeGJSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:30:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733298AbeGJSaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:22 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 55E58EC2;
        Tue, 10 Jul 2018 18:30:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.9 28/52] ext4: always check block group bounds in ext4_init_block_bitmap()
Date:   Tue, 10 Jul 2018 20:24:56 +0200
Message-Id: <20180710182452.049039704@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
References: <20180710182449.285532226@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 819b23f1c501b17b9694325471789e6b5cc2d0d2 upstream.

Regardless of whether the flex_bg feature is set, we should always
check to make sure the bits we are setting in the block bitmap are
within the block group bounds.

https://bugzilla.kernel.org/show_bug.cgi?id=199865

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/balloc.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -183,7 +183,6 @@ static int ext4_init_block_bitmap(struct
 	unsigned int bit, bit_max;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
-	int flex_bg = 0;
 	struct ext4_group_info *grp;
 
 	J_ASSERT_BH(bh, buffer_locked(bh));
@@ -216,22 +215,19 @@ static int ext4_init_block_bitmap(struct
 
 	start = ext4_group_first_block_no(sb, block_group);
 
-	if (ext4_has_feature_flex_bg(sb))
-		flex_bg = 1;
-
 	/* Set bits for block and inode bitmaps, and inode table */
 	tmp = ext4_block_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 
 	tmp = ext4_inode_bitmap(sb, gdp);
-	if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+	if (ext4_block_in_group(sb, tmp, block_group))
 		ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 
 	tmp = ext4_inode_table(sb, gdp);
 	for (; tmp < ext4_inode_table(sb, gdp) +
 		     sbi->s_itb_per_group; tmp++) {
-		if (!flex_bg || ext4_block_in_group(sb, tmp, block_group))
+		if (ext4_block_in_group(sb, tmp, block_group))
 			ext4_set_bit(EXT4_B2C(sbi, tmp - start), bh->b_data);
 	}
 


