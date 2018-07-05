Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1F1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED37C2242B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED37C2242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753966AbeGELiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:38:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753656AbeGELiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:38:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 92A08C2ED8E7F;
        Thu,  5 Jul 2018 19:37:45 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.382.0; Thu, 5 Jul 2018 19:37:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to detect looped node chain correctly
Date:   Thu, 5 Jul 2018 19:37:00 +0800
Message-ID: <20180705113701.3466-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below dmesg was printed when testing generic/388 of fstest:

F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22
F2FS-fs (zram1): Mounted with checkpoint version = 22300d0e
F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22

The reason is that we initialize free_blocks with free blocks of
filesystem, so if filesystem is full, free_blocks can be zero,
below condition will be true, so that, it will fail recovery.

if (++loop_cnt >= free_blocks ||
	blkaddr == next_blkaddr_of_node(page))

To fix this issue, initialize free_blocks with correct value which
includes over-privision blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 3051a5e5dfc7..0d927ae26c48 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -241,8 +241,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 	struct page *page = NULL;
 	block_t blkaddr;
 	unsigned int loop_cnt = 0;
-	unsigned int free_blocks = sbi->user_block_count -
-					valid_user_blocks(sbi);
+	unsigned int free_blocks = MAIN_SEGS(sbi) * sbi->blocks_per_seg -
+						valid_user_blocks(sbi);
 	int err = 0;
 
 	/* get node pages in the current segment */
-- 
2.18.0.rc1

