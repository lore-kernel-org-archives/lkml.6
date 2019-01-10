Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D63206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAJIke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:40:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbfAJIkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:40:33 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A4DAF12B2413C3FBEF9A;
        Thu, 10 Jan 2019 16:40:31 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 10 Jan 2019 16:40:22 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to set sbi dirty correctly
Date:   Thu, 10 Jan 2019 16:40:12 +0800
Message-ID: <20190110084012.115473-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to record direct IO count, we add two additional type in
enum count_type: F2FS_DIO_{WRITE,READ}, but those IO won't dirty
filesystem metadata, so we don't need to set filesystem dirty in
inc_page_count(), fix it.

Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 94315e8423a9..dc8498e3d03c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1793,13 +1793,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 {
 	atomic_inc(&sbi->nr_pages[count_type]);
 
-	if (count_type == F2FS_DIRTY_DATA || count_type == F2FS_INMEM_PAGES ||
-		count_type == F2FS_WB_CP_DATA || count_type == F2FS_WB_DATA ||
-		count_type == F2FS_RD_DATA || count_type == F2FS_RD_NODE ||
-		count_type == F2FS_RD_META)
-		return;
-
-	set_sbi_flag(sbi, SBI_IS_DIRTY);
+	if (count_type == F2FS_DIRTY_DENTS ||
+			count_type == F2FS_DIRTY_NODES ||
+			count_type == F2FS_DIRTY_META ||
+			count_type == F2FS_DIRTY_QDATA ||
+			count_type == F2FS_DIRTY_IMETA)
+		set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
 static inline void inode_inc_dirty_pages(struct inode *inode)
-- 
2.18.0.rc1

