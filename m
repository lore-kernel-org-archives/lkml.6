Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589F82146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfBSJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:08:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727011AbfBSJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:08:33 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 496785EE43C6572027D9;
        Tue, 19 Feb 2019 17:08:32 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 17:08:23 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: make fault injection covering __submit_flush_wait()
Date:   Tue, 19 Feb 2019 17:08:18 +0800
Message-ID: <20190219090818.9881-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes to allow failure of f2fs_bio_alloc() in
__submit_flush_wait(), which can simulate flush error in checkpoint()
for covering more error paths.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1334903b97f5..f454af871d5b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -561,9 +561,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
-	struct bio *bio = f2fs_bio_alloc(sbi, 0, true);
+	struct bio *bio;
 	int ret;
 
+	bio = f2fs_bio_alloc(sbi, 0, false);
+	if (!bio)
+		return -ENOMEM;
+
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	bio_set_dev(bio, bdev);
 	ret = submit_bio_wait(bio);
-- 
2.18.0.rc1

