Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFBAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8D821902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfBSIYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:24:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:24:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 07675A3D661D95641300;
        Tue, 19 Feb 2019 16:24:03 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 16:23:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to retry fill_super only if recovery failed
Date:   Tue, 19 Feb 2019 16:23:53 +0800
Message-ID: <20190219082353.6554-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current retry mechanism in f2fs_fill_super, first fill_super
fails due to no memory, then second fill_super runs w/o recovery,
if we succeed, we may lose fsynced data, it doesn't make sense.

Let's retry fill_super only if it occurs non-ENOMEM error during
recovery.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3dc7f56889da..5f692e10d094 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3052,10 +3052,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct f2fs_super_block *raw_super;
 	struct inode *root;
 	int err;
-	bool retry = true, need_fsck = false;
+	bool skip_recovery = false, need_fsck = false;
 	char *options = NULL;
 	int recovery, i, valid_super_block;
 	struct curseg_info *seg_i;
+	int retry_cnt = 1;
 
 try_onemore:
 	err = -EINVAL;
@@ -3344,7 +3345,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_meta;
 
 	if (unlikely(is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)))
-		goto skip_recovery;
+		goto reset_checkpoint;
 
 	/* recover fsynced data */
 	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
@@ -3361,11 +3362,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (need_fsck)
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
 
-		if (!retry)
-			goto skip_recovery;
+		if (skip_recovery)
+			goto reset_checkpoint;
 
 		err = f2fs_recover_fsync_data(sbi, false);
 		if (err < 0) {
+			if (err != -ENOMEM)
+				skip_recovery = true;
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
 				"Cannot recover all fsync data errno=%d", err);
@@ -3381,7 +3384,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 		}
 	}
-skip_recovery:
+reset_checkpoint:
 	/* f2fs_recover_fsync_data() cleared this already */
 	clear_sbi_flag(sbi, SBI_POR_DOING);
 
@@ -3427,7 +3430,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 sync_free_meta:
 	/* safe to flush all the data */
 	sync_filesystem(sbi->sb);
-	retry = false;
+	retry_cnt = 0;
 
 free_meta:
 #ifdef CONFIG_QUOTA
@@ -3487,8 +3490,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	kvfree(sbi);
 
 	/* give only one another chance */
-	if (retry) {
-		retry = false;
+	if (retry_cnt > 0 && skip_recovery) {
+		retry_cnt--;
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
-- 
2.18.0.rc1

