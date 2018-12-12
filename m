Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F33FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBE02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeLLKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:13:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40376 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbeLLKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:13:12 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76687ED22AA6B;
        Wed, 12 Dec 2018 18:13:09 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 12 Dec 2018 18:13:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: clean up checkpoint flow
Date:   Wed, 12 Dec 2018 18:12:32 +0800
Message-ID: <20181212101232.54289-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20181212101232.54289-1-yuchao0@huawei.com>
References: <20181212101232.54289-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up checkpoint flow a bit:
- remove unneeded circulation of flushing meta pages.
- don't flush nat_bits pages in prior to other checkpoint pages.
- add bug_on to check remained meta pages after flushing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0a6b5dc0d717..623536b8e0c0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1328,11 +1328,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	int err;
 
 	/* Flush all the NAT/SIT pages */
-	while (get_pages(sbi, F2FS_DIRTY_META)) {
-		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
-		if (unlikely(f2fs_cp_error(sbi)))
-			break;
-	}
+	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
+					!f2fs_cp_error(sbi));
 
 	/*
 	 * modify checkpoint
@@ -1405,14 +1403,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		for (i = 0; i < nm_i->nat_bits_blocks; i++)
 			f2fs_update_meta_page(sbi, nm_i->nat_bits +
 					(i << F2FS_BLKSIZE_BITS), blk + i);
-
-		/* Flush all the NAT BITS pages */
-		while (get_pages(sbi, F2FS_DIRTY_META)) {
-			f2fs_sync_meta_pages(sbi, META, LONG_MAX,
-							FS_CP_META_IO);
-			if (unlikely(f2fs_cp_error(sbi)))
-				break;
-		}
 	}
 
 	/* write out checkpoint buffer at block 0 */
@@ -1448,6 +1438,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* Here, we have one bio having CP pack except cp pack 2 page */
 	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
+	f2fs_bug_on(sbi, get_pages(sbi, F2FS_DIRTY_META) &&
+					!f2fs_cp_error(sbi));
 
 	/* wait for previous submitted meta pages writeback */
 	f2fs_wait_on_all_pages_writeback(sbi);
-- 
2.18.0.rc1

