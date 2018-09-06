Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1426C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656492077C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656492077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeIFRUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:20:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727609AbeIFRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:20:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EA4B1E9C752EA;
        Thu,  6 Sep 2018 20:44:47 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Thu, 6 Sep 2018 20:44:39 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Yunlei He <heyunlei@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: report error if quota off error during umount
Date:   Thu, 6 Sep 2018 20:44:35 +0800
Message-ID: <20180906124436.89193-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlei He <heyunlei@huawei.com>

Now, we depend on fsck to ensure quota file data is ok,
so we scan whole partition if checkpoint without umount
flag. It's same for quota off error case, which may make
quota file data inconsistent.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/super.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8f026ba226fb..c026aaccf218 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1874,7 +1874,9 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	if (!inode || !igrab(inode))
 		return dquot_quota_off(sb, type);
 
-	f2fs_quota_sync(sb, type);
+	err = f2fs_quota_sync(sb, type);
+	if (err)
+		goto out_put;
 
 	err = dquot_quota_off(sb, type);
 	if (err || f2fs_sb_has_quota_ino(sb))
@@ -1893,9 +1895,18 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 void f2fs_quota_off_umount(struct super_block *sb)
 {
 	int type;
+	int err;
 
-	for (type = 0; type < MAXQUOTAS; type++)
-		f2fs_quota_off(sb, type);
+	for (type = 0; type < MAXQUOTAS; type++) {
+		err = f2fs_quota_off(sb, type);
+		if (err) {
+			f2fs_msg(sb, KERN_ERR,
+				"Fail to turn off disk quota "
+				"(type: %d, err: %d), Please "
+				"run fsck to fix it.", type, err);
+			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+		}
+	}
 }
 
 static int f2fs_dquot_commit(struct dquot *dquot)
-- 
2.18.0.rc1

