Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545C5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299832184E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLRJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:18:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726413AbeLRJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:18:50 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6563337C3C646;
        Tue, 18 Dec 2018 17:18:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 17:18:39 +0800
From:   sunqiuyang <sunqiuyang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <fangwei1@huawei.com>, <yuchangchun1@huawei.com>,
        <sunqiuyang@huawei.com>
Subject: [PATCH] f2fs: fix block address for __check_sit_bitmap
Date:   Tue, 18 Dec 2018 17:32:23 +0800
Message-ID: <20181218093223.25242-1-sunqiuyang@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiuyang Sun <sunqiuyang@huawei.com>

Should use lstart (logical start address) instead of start (in dev) here.
This fixes a bug in multi-device scenarios.

Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 204d31e..1a11e7e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1150,7 +1150,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		list_move_tail(&dc->list, wait_list);
 
 		/* sanity check on discard range */
-		__check_sit_bitmap(sbi, start, start + len);
+		__check_sit_bitmap(sbi, lstart, lstart + len);
 
 		bio->bi_private = dc;
 		bio->bi_end_io = f2fs_submit_discard_endio;
-- 
1.8.3.1

