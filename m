Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5063FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217920850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E217920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeGROyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9693 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeGROyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E03B06D0FE8C;
        Wed, 18 Jul 2018 22:16:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:57 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 7/9] scsi: hisi_sas: Tidy hisi_sas_task_prep()
Date:   Wed, 18 Jul 2018 22:14:31 +0800
Message-ID: <1531923273-193768-8-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
References: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

To decrease the usage of spinlock during delivery IO, relocate some code
in hisi_sas_task_prep().

Also an invalid comment is removed.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index b0bcd14..432a38a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -296,8 +296,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
 	struct device *dev = hisi_hba->dev;
 	int dlvry_queue_slot, dlvry_queue, rc, slot_idx;
 	int n_elem = 0, n_elem_req = 0, n_elem_resp = 0;
-	unsigned long flags, flags_dq;
 	struct hisi_sas_dq *dq;
+	unsigned long flags;
 	int wr_q_index;
 
 	if (!sas_port) {
@@ -393,16 +393,17 @@ static int hisi_sas_task_prep(struct sas_task *task,
 
 	slot = &hisi_hba->slot_info[slot_idx];
 
-	spin_lock_irqsave(&dq->lock, flags_dq);
+	spin_lock_irqsave(&dq->lock, flags);
 	wr_q_index = hisi_hba->hw->get_free_slot(hisi_hba, dq);
 	if (wr_q_index < 0) {
-		spin_unlock_irqrestore(&dq->lock, flags_dq);
+		spin_unlock_irqrestore(&dq->lock, flags);
 		rc = -EAGAIN;
 		goto err_out_tag;
 	}
 
 	list_add_tail(&slot->delivery, &dq->list);
-	spin_unlock_irqrestore(&dq->lock, flags_dq);
+	list_add_tail(&slot->entry, &sas_dev->list);
+	spin_unlock_irqrestore(&dq->lock, flags);
 
 	dlvry_queue = dq->id;
 	dlvry_queue_slot = wr_q_index;
@@ -440,9 +441,6 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		break;
 	}
 
-	spin_lock_irqsave(&dq->lock, flags);
-	list_add_tail(&slot->entry, &sas_dev->list);
-	spin_unlock_irqrestore(&dq->lock, flags);
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
@@ -818,7 +816,6 @@ static void hisi_sas_do_release_task(struct hisi_hba *hisi_hba, struct sas_task
 	hisi_sas_slot_task_free(hisi_hba, task, slot);
 }
 
-/* hisi_hba.lock should be locked */
 static void hisi_sas_release_task(struct hisi_hba *hisi_hba,
 			struct domain_device *device)
 {
-- 
1.9.1

