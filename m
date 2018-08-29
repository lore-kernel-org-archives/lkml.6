Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFC7C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6320847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD6320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeH2OMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:12:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41687 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2OMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:12:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fuxWG-0005Cz-Go; Wed, 29 Aug 2018 10:16:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jan Kara <jack@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udf: remove unused variables group_start and nr_groups
Date:   Wed, 29 Aug 2018 11:16:12 +0100
Message-Id: <20180829101612.31824-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables group_start and nr_groups are being assigned but are never used
hence they are redundant and can be removed.

Cleans up clang warning:
variable 'group_start' set but not used [-Wunused-but-set-variable]
variable 'nr_groups' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/udf/balloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index fcda0fc97b90..501bc5ffb4ce 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -175,8 +175,8 @@ static int udf_bitmap_prealloc_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	int alloc_count = 0;
-	int bit, block, block_group, group_start;
-	int nr_groups, bitmap_nr;
+	int bit, block, block_group;
+	int bitmap_nr;
 	struct buffer_head *bh;
 	__u32 part_len;
 
@@ -189,10 +189,8 @@ static int udf_bitmap_prealloc_blocks(struct super_block *sb,
 		block_count = part_len - first_block;
 
 	do {
-		nr_groups = udf_compute_nr_groups(sb, partition);
 		block = first_block + (sizeof(struct spaceBitmapDesc) << 3);
 		block_group = block >> (sb->s_blocksize_bits + 3);
-		group_start = block_group ? 0 : sizeof(struct spaceBitmapDesc);
 
 		bitmap_nr = load_block_bitmap(sb, bitmap, block_group);
 		if (bitmap_nr < 0)
-- 
2.17.1

