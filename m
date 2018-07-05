Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCCAC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAFA241A7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAFA241A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeGEGQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:16:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33283 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753231AbeGEGQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:16:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B88E32B77418E;
        Thu,  5 Jul 2018 14:16:37 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Thu, 5 Jul 2018 14:16:32 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: give another chance to issue discard with current granularity
Date:   Thu, 5 Jul 2018 14:15:51 +0800
Message-ID: <20180705061551.2961-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If discard IOs are blocked by user IO, do not skip to select and issue
discard with lower granularity, retry with current granularity.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix deadloop.
 fs/f2fs/segment.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1f9ae8270f86..6e2b2e717a40 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1191,7 +1191,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
 	int i, iter = 0, issued = 0;
-	bool io_interrupted = false;
+	bool io_interrupted = false, end_up = false;
 
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
 		if (i + 1 < dpolicy->granularity)
@@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
+retry:
 		if (list_empty(pend_list))
 			goto next;
 		if (unlikely(dcc->rbtree_check))
@@ -1217,14 +1218,23 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			__submit_discard_cmd(sbi, dpolicy, dc);
 			issued++;
 skip:
-			if (++iter >= dpolicy->max_requests)
+			if (++iter >= dpolicy->max_requests) {
+				end_up = true;
 				break;
+			}
 		}
 		blk_finish_plug(&plug);
+
+		/*
+		 * if discard IO was interrupted by user IOs, give another
+		 * chance to issue discard with current granularity.
+		 */
+		if (io_interrupted && !end_up)
+			goto retry;
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-		if (iter >= dpolicy->max_requests)
+		if (end_up)
 			break;
 	}
 
-- 
2.18.0.rc1

