Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DB5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0921729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0921729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeHHLze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:55:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39956 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbeHHLze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:55:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 250E6D9F17F32;
        Wed,  8 Aug 2018 17:36:38 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 17:36:31 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to return success when trimming meta area
Date:   Wed, 8 Aug 2018 17:36:29 +0800
Message-ID: <20180808093629.84207-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic/251
    --- tests/generic/251.out	2016-05-03 20:20:11.381899000 +0800
     QA output created by 251
     Running the test: done.
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    +fstrim: /mnt/scratch_f2fs: FITRIM ioctl failed: Invalid argument
    ...
Ran: generic/251
Failures: generic/251

The reason is coverage of fstrim locates in meta area, previously we
just return -EINVAL for such case, making generic/251 failed, to fix
this problem, let's relieve restriction to return success with no
block discarded.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8826ea683804..ce55e93958c8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2637,8 +2637,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
 		return -EINVAL;
 
-	if (end <= MAIN_BLKADDR(sbi))
-		return -EINVAL;
+	if (end < MAIN_BLKADDR(sbi))
+		goto out;
 
 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
 		f2fs_msg(sbi->sb, KERN_WARNING,
-- 
2.18.0.rc1

