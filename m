Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9871FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395AF24D8E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 15:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395AF24D8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeF3P5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 11:57:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56685 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751113AbeF3P5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 11:57:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2515D5DFCF78E;
        Sat, 30 Jun 2018 23:57:20 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.382.0; Sat, 30 Jun
 2018 23:57:12 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
CC:     Gao Xiang <gaoxiang25@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: avoid the global name 'fault_name'
Date:   Sat, 30 Jun 2018 23:57:03 +0800
Message-ID: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-prefix global name 'fault_name' will pollute global
namespace, fix it.

Refer to:
https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html

To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/f2fs.h  | 4 ++--
 fs/f2fs/super.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de..11a2e09 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -65,7 +65,7 @@ struct f2fs_fault_info {
 	unsigned int inject_type;
 };
 
-extern char *fault_name[FAULT_MAX];
+extern char *f2fs_fault_name[FAULT_MAX];
 #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
 #endif
 
@@ -1279,7 +1279,7 @@ struct f2fs_sb_info {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(type)				\
 	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
-		KERN_INFO, fault_name[type],			\
+		KERN_INFO, f2fs_fault_name[type],		\
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e92..df12dcd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -41,7 +41,7 @@
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
-char *fault_name[FAULT_MAX] = {
+char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
-- 
1.9.1

