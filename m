Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0983ECE567
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6BF2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6BF2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbeIVGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44241 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392011AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BY-5F; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000rr-0B; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.123314101@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 27/63] ext4: always check block group bounds in
 ext4_init_block_bitmap()
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

commit 819b23f1c501b17b9694325471789e6b5cc2d0d2 upstream.

Regardless of whether the flex_bg feature is set, we should always
check to make sure the bits we are setting in the block bitmap are
within the block group bounds.

https://bugzilla.kernel.org/show_bug.cgi?id=199865

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/balloc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -184,7 +184,6 @@ static int ext4_init_block_bitmap(struct
 	unsigned int bit, bit_max;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_fsblk_t start, tmp;
-	int flex_bg = 0;
 	struct ext4_group_info *grp;
 
 	J_ASSERT_BH(bh, buffer_locked(bh));
@@ -217,22 +216,19 @@ static int ext4_init_block_bitmap(struct
 
 	start = ext4_group_first_block_no(sb, block_group);
 
-	if (EXT4_HAS_INCOMPAT_FEATURE(sb, EXT4_FEATURE_INCOMPAT_FLEX_BG))
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
 

