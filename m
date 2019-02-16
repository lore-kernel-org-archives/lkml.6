Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE94C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E1222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfBPKBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 05:01:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727600AbfBPKBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 05:01:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31090A3AC2B0228E93ED;
        Sat, 16 Feb 2019 18:01:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 18:01:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: mvumi: Using plain integer as NULL pointer
Date:   Sat, 16 Feb 2019 18:01:30 +0800
Message-ID: <20190216100130.19396-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following sparse warning:

drivers/scsi/mvumi.c:1797:48: warning: Using plain integer as NULL pointer
drivers/scsi/mvumi.c:2143:50: warning: Using plain integer as NULL pointer
drivers/scsi/mvumi.c:755:58: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/mvumi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 36f6420..a8fe1f8 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -752,7 +752,7 @@ static int mvumi_issue_blocked_cmd(struct mvumi_hba *mhba,
 		spin_lock_irqsave(mhba->shost->host_lock, flags);
 		atomic_dec(&cmd->sync_cmd);
 		if (mhba->tag_cmd[cmd->frame->tag]) {
-			mhba->tag_cmd[cmd->frame->tag] = 0;
+			mhba->tag_cmd[cmd->frame->tag] = NULL;
 			dev_warn(&mhba->pdev->dev, "TIMEOUT:release tag [%d]\n",
 							cmd->frame->tag);
 			tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
@@ -1794,7 +1794,7 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
 		cmd = mhba->tag_cmd[ob_frame->tag];
 
 		atomic_dec(&mhba->fw_outstanding);
-		mhba->tag_cmd[ob_frame->tag] = 0;
+		mhba->tag_cmd[ob_frame->tag] = NULL;
 		tag_release_one(mhba, &mhba->tag_pool, ob_frame->tag);
 		if (cmd->scmd)
 			mvumi_complete_cmd(mhba, cmd, ob_frame);
@@ -2140,7 +2140,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
 	spin_lock_irqsave(mhba->shost->host_lock, flags);
 
 	if (mhba->tag_cmd[cmd->frame->tag]) {
-		mhba->tag_cmd[cmd->frame->tag] = 0;
+		mhba->tag_cmd[cmd->frame->tag] = NULL;
 		tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
 	}
 	if (!list_empty(&cmd->queue_pointer))
-- 
2.7.0


