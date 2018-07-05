Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F797C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3258241AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3258241AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeGEGZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:25:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752906AbeGEGZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:25:13 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94ED5D7390793;
        Thu,  5 Jul 2018 14:24:59 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.382.0; Thu, 5 Jul 2018 14:24:52 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: enable real-time discard by default
Date:   Thu, 5 Jul 2018 14:24:11 +0800
Message-ID: <20180705062411.3757-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs is focused on flash based storage, so let's enable real-time
discard by default, if user don't want to enable it, 'nodiscard'
mount option should be used on mount.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 848badda50ad..980edeb0b650 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1366,12 +1366,11 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, NOHEAP);
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_sb_has_blkzoned(sbi->sb)) {
+	set_opt(sbi, DISCARD);
+	if (f2fs_sb_has_blkzoned(sbi->sb))
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
-		set_opt(sbi, DISCARD);
-	} else {
+	else
 		set_opt_mode(sbi, F2FS_MOUNT_ADAPTIVE);
-	}
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.18.0.rc1

