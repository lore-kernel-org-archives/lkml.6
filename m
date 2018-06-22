Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AFAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6421223EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6421223EAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeFVIIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:08:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751351AbeFVIIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:08:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0EB49EB0CB5CA;
        Fri, 22 Jun 2018 16:07:52 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.382.0; Fri, 22 Jun 2018 16:07:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: disable f2fs_check_rb_tree_consistence
Date:   Fri, 22 Jun 2018 16:06:59 +0800
Message-ID: <20180622080659.10469-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is millions of discard entries cached in rb tree, each
sanity check of it can cause very long latency as held cmd_lock
blocking other lock grabbers.

In other aspect, we have enabled the check very long time, as
we see, there is no such inconsistent condition caused by bugs.

But still we do not choose to kill it directly, instead, adding
an flag to disable the check now, if there is related code change,
we can reuse it to detect bugs.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: use unlikely suggested by Jaegeuk.
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 99ad25513b4c..5302bad1566b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -309,6 +309,7 @@ struct discard_cmd_control {
 	atomic_t issing_discard;		/* # of issing discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
 	struct rb_root root;			/* root of discard rb-tree */
+	bool rbtree_check;			/* config for consistence check */
 };
 
 /* for the list of fsync inodes, used only during recovery */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 553075973be4..f7eaefe8b1d1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1199,8 +1199,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		mutex_lock(&dcc->cmd_lock);
 		if (list_empty(pend_list))
 			goto next;
-		f2fs_bug_on(sbi,
-			!f2fs_check_rb_tree_consistence(sbi, &dcc->root));
+		if (unlikely(dcc->rbtree_check))
+			f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
+								&dcc->root));
 		blk_start_plug(&plug);
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
@@ -1752,6 +1753,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->undiscard_blks = 0;
 	dcc->root = RB_ROOT;
+	dcc->rbtree_check = false;
 
 	init_waitqueue_head(&dcc->discard_wait_queue);
 	SM_I(sbi)->dcc_info = dcc;
@@ -2381,7 +2383,9 @@ static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 	issued = 0;
 
 	mutex_lock(&dcc->cmd_lock);
-	f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi, &dcc->root));
+	if (unlikely(dcc->rbtree_check))
+		f2fs_bug_on(sbi, !f2fs_check_rb_tree_consistence(sbi,
+								&dcc->root));
 
 	dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
 					NULL, start,
-- 
2.18.0.rc1

