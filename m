Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0ADC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83D12148E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83D12148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeHVMmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:42:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727396AbeHVMmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:42:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B7E9CAF526DFC;
        Wed, 22 Aug 2018 17:17:59 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Wed, 22 Aug 2018 17:17:52 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] Revert "f2fs: use printk_ratelimited for f2fs_msg"
Date:   Wed, 22 Aug 2018 17:17:47 +0800
Message-ID: <20180822091747.35046-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't limit printing log, so that we will not miss any key messages.

This reverts commit a36c106dffb616250117efb1cab271c19a8f94ff.

In addition, we use printk_ratelimited to avoid too many log prints.
- error injection
- discard submission failure

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 6 +++---
 fs/f2fs/segment.c | 6 +++---
 fs/f2fs/super.c   | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 57cd6d7f36ea..20f4afa161d0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1312,9 +1312,9 @@ struct f2fs_sb_info {
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-#define f2fs_show_injection_info(type)				\
-	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
-		KERN_INFO, f2fs_fault_name[type],		\
+#define f2fs_show_injection_info(type)					\
+	printk_ratelimited("%sF2FS-fs : inject %s in %s of %pF\n",	\
+		KERN_INFO, f2fs_fault_name[type],			\
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f9007360e59a..9dd896171976 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -905,9 +905,9 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->error = 0;
 
 	if (dc->error)
-		f2fs_msg(sbi->sb, KERN_INFO,
-			"Issue discard(%u, %u, %u) failed, ret: %d",
-			dc->lstart, dc->start, dc->len, dc->error);
+		printk_ratelimited(
+			"%sF2FS-fs: Issue discard(%u, %u, %u) failed, ret: %d",
+			KERN_INFO, dc->lstart, dc->start, dc->len, dc->error);
 	__detach_discard_cmd(dcc, dc);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 64daf9f415fa..b0291c528898 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -207,7 +207,7 @@ void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...)
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk_ratelimited("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
+	printk("%sF2FS-fs (%s): %pV\n", level, sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.18.0.rc1

