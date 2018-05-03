Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeECHqK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:46:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7222 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750939AbeECHqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:46:09 -0400
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] f2fs: fix the way to wake up issue_flush thread
Date: Thu, 3 May 2018 15:45:43 +0800
Message-ID: <1525333543-106702-1-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.113.189.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6f890df0 ("f2fs: fix out-of-order execution in f2fs_issue_flush")
uses waitqueue_active to wake up issue_flush thread, but there is no
wait entry to wake in this queue, so change it back to use the original
fcc->dispatch_list to wake up issue_flush thread.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 503a98a..5aa5ee4e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -612,7 +612,7 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_t ino)
 	/* update issue_list before we wake up issue_flush thread */
 	smp_mb();
 
-	if (waitqueue_active(&fcc->flush_wait_queue))
+	if (!fcc->dispatch_list)
 		wake_up(&fcc->flush_wait_queue);
 
 	if (fcc->f2fs_issue_flush) {
-- 
1.8.5.2
