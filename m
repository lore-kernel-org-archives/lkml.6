Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85142C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4868C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4868C204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbeIXVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:12:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729737AbeIXVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:12:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F103E63A0974B;
        Mon, 24 Sep 2018 23:09:38 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 23:09:32 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 4/7] scsi: hisi_sas: Free slot later in slot_complete_vx_hw()
Date:   Mon, 24 Sep 2018 23:06:31 +0800
Message-ID: <1537801594-207139-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

If an SSP/SMP IO times out, it may be actually in reality be
simultaneously processing completion of the slot in slot_complete_vx_hw().

Then if the slot is freed in slot_complete_vx_hw() (this IPTT is freed and
it may be re-used by other slot), and we may abort the wrong slot in
hisi_sas_abort_task().

So to solve the issue, free the slot after the check of
SAS_TASK_STATE_ABORTED in slot_complete_vx_hw().

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 9c5c5a6..67134b4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -2483,7 +2483,6 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	}
 
 out:
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
 	sts = ts->stat;
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
@@ -2493,6 +2492,7 @@ static void slot_err_v2_hw(struct hisi_hba *hisi_hba,
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
+	hisi_sas_slot_task_free(hisi_hba, task, slot);
 
 	if (!is_internal && (task->task_proto != SAS_PROTOCOL_SMP)) {
 		spin_lock_irqsave(&device->done_lock, flags);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 08b503e2..3995ff6 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1751,7 +1751,6 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	}
 
 out:
-	hisi_sas_slot_task_free(hisi_hba, task, slot);
 	sts = ts->stat;
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
@@ -1761,6 +1760,7 @@ static irqreturn_t fatal_axi_int_v3_hw(int irq_no, void *p)
 	}
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
+	hisi_sas_slot_task_free(hisi_hba, task, slot);
 
 	if (!is_internal && (task->task_proto != SAS_PROTOCOL_SMP)) {
 		spin_lock_irqsave(&device->done_lock, flags);
-- 
1.9.1

