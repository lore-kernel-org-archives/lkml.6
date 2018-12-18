Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E65AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799312184E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeLRLUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:20:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLRLUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:20:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBF592FEFF1AD;
        Tue, 18 Dec 2018 19:20:30 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:20:26 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to dirty inode synchronously
Date:   Tue, 18 Dec 2018 19:20:17 +0800
Message-ID: <20181218112017.80555-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20181218112017.80555-1-yuchao0@huawei.com>
References: <20181218112017.80555-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user change inode's i_flags via ioctl, let's add it into global
dirty list, so that checkpoint can guarantee its persistence before
fsync, it can make checkpoint keeping strong consistency.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ca9bdbb8651b..7bf28be811ab 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1685,7 +1685,7 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
-	f2fs_mark_inode_dirty_sync(inode, false);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
-- 
2.18.0.rc1

