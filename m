Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009C321F43
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009C321F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeGCMSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:18:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45163 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752251AbeGCMSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:18:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E5420F37712A9;
        Tue,  3 Jul 2018 20:18:24 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Tue, 3 Jul 2018 20:18:16 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: give another chance to issue discard with current granularity
Date:   Tue, 3 Jul 2018 20:17:36 +0800
Message-ID: <20180703121736.45229-1-yuchao0@huawei.com>
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
 fs/f2fs/segment.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 60f54ed1413a..13f5e3665bf0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		pend_list = &dcc->pend_list[i];
 
 		mutex_lock(&dcc->cmd_lock);
+retry:
 		if (list_empty(pend_list))
 			goto next;
 		if (unlikely(dcc->rbtree_check))
@@ -1221,6 +1222,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 				break;
 		}
 		blk_finish_plug(&plug);
+
+		/*
+		 * if discard IO was interrupted by user IOs, give another
+		 * chance to issue discard with current granularity.
+		 */
+		if (io_interrupted)
+			goto retry;
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-- 
2.18.0.rc1

