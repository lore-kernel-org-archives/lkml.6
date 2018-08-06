Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE53921A1C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE53921A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbeHFOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:39:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730876AbeHFOjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:39:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 875CB4D4AF5D;
        Mon,  6 Aug 2018 20:30:26 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Mon, 6 Aug 2018 20:30:21 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: support discard submission error injection
Date:   Mon, 6 Aug 2018 20:30:18 +0800
Message-ID: <20180806123018.14952-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to support discard submission error injection for testing
error handling of __submit_discard_cmd().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/segment.c | 8 ++++++++
 fs/f2fs/super.c   | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae9dfad58046..1e07fcd7f580 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -56,6 +56,7 @@ enum {
 	FAULT_TRUNCATE,
 	FAULT_IO,
 	FAULT_CHECKPOINT,
+	FAULT_DISCARD,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ccad453bd2b7..db8a79ac5b3f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1045,10 +1045,18 @@ static void __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		dc->len += len;
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+		if (time_to_inject(sbi, FAULT_DISCARD)) {
+			f2fs_show_injection_info(FAULT_DISCARD);
+			err = -EIO;
+			goto submit;
+		}
+#endif
 		err = __blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, 0, &bio);
+submit:
 		if (!err && bio) {
 			/*
 			 * should keep before submission to avoid D_DONE
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ba2fd51580d2..254f74a6b481 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -55,6 +55,7 @@ char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_TRUNCATE]	= "truncate fail",
 	[FAULT_IO]		= "IO error",
 	[FAULT_CHECKPOINT]	= "checkpoint error",
+	[FAULT_DISCARD]		= "discard error",
 };
 
 void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate)
-- 
2.18.0.rc1

