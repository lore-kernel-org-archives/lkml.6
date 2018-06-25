Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79392C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EF23C5E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2EF23C5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeFYMeX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:34:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53173 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933135AbeFYMeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:34:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9DDDE9A6D8C6D;
        Mon, 25 Jun 2018 20:34:17 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Mon, 25 Jun 2018 20:34:07 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to correct return value of f2fs_trim_fs
Date:   Mon, 25 Jun 2018 20:33:24 +0800
Message-ID: <20180625123324.88616-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should account trimmed block number from __wait_all_discard_cmd
in __issue_discard_cmd_range, otherwise trimmed blocks returned
by f2fs_trim_fs will be wrong, this patch fixes it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b613d2a64586..cb509760fb45 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1320,21 +1320,22 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	return trimmed;
 }
 
-static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
+static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy)
 {
 	struct discard_policy dp;
+	unsigned int discard_blks;
 
-	if (dpolicy) {
-		__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
-		return;
-	}
+	if (dpolicy)
+		return __wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
 
 	/* wait all */
 	__init_discard_policy(sbi, &dp, DPOLICY_FSTRIM, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks = __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
 	__init_discard_policy(sbi, &dp, DPOLICY_UMOUNT, 1);
-	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+	discard_blks += __wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
+
+	return discard_blks;
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
@@ -2368,7 +2369,7 @@ bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 	return has_candidate;
 }
 
-static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
+static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy,
 					unsigned int start, unsigned int end)
 {
@@ -2378,6 +2379,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	int issued;
+	unsigned int trimmed = 0;
 
 next:
 	issued = 0;
@@ -2415,7 +2417,7 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
-			__wait_all_discard_cmd(sbi, NULL);
+			trimmed += __wait_all_discard_cmd(sbi, NULL);
 			congestion_wait(BLK_RW_ASYNC, HZ/50);
 			goto next;
 		}
@@ -2429,6 +2431,8 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
+
+	return trimmed;
 }
 
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
@@ -2486,9 +2490,10 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	end_block = START_BLOCK(sbi, end_segno + 1);
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+	trimmed = __issue_discard_cmd_range(sbi, &dpolicy,
+					start_block, end_block);
 
-	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	trimmed += __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
 	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
-- 
2.18.0.rc1

