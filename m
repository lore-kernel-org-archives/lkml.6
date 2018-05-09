Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964872AbeEIPMQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:12:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47091 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S964821AbeEIPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:12:13 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/6] scsi: hisi_sas: allocate slot buffer earlier
Date: Wed, 9 May 2018 23:10:47 +0800
Message-ID: <1525878650-213087-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525878650-213087-1-git-send-email-john.garry@huawei.com>
References: <1525878650-213087-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Currently we allocate the slot's memory buffer
after allocating the DQ slot.

To aid DQ lockout reduction, and allow slots to be
built in parallel, move this step (which can fail)
prior to allocating the slot.

Also a stray spin_unlock_irqrestore() is removed
from internal task exec function.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 55 ++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 2772e920..58cbe1f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -412,14 +412,22 @@ static int hisi_sas_task_prep(struct sas_task *task, struct hisi_sas_dq
 	if (rc)
 		goto err_out_dma_unmap;
 
+	slot = &hisi_hba->slot_info[slot_idx];
+	memset(slot, 0, sizeof(struct hisi_sas_slot));
+
+	slot->buf = dma_pool_alloc(hisi_hba->buffer_pool,
+				   GFP_ATOMIC, &slot->buf_dma);
+	if (!slot->buf) {
+		rc = -ENOMEM;
+		goto err_out_tag;
+	}
+
 	rc = hisi_hba->hw->get_free_slot(hisi_hba, dq);
 	if (rc)
-		goto err_out_tag;
+		goto err_out_buf;
 
 	dlvry_queue = dq->id;
 	dlvry_queue_slot = dq->wr_point;
-	slot = &hisi_hba->slot_info[slot_idx];
-	memset(slot, 0, sizeof(struct hisi_sas_slot));
 
 	slot->idx = slot_idx;
 	slot->n_elem = n_elem;
@@ -434,12 +442,6 @@ static int hisi_sas_task_prep(struct sas_task *task, struct hisi_sas_dq
 	task->lldd_task = slot;
 	INIT_WORK(&slot->abort_slot, hisi_sas_slot_abort);
 
-	slot->buf = dma_pool_alloc(hisi_hba->buffer_pool,
-				   GFP_ATOMIC, &slot->buf_dma);
-	if (!slot->buf) {
-		rc = -ENOMEM;
-		goto err_out_slot_buf;
-	}
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
 	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
 	memset(hisi_sas_status_buf_addr_mem(slot), 0, HISI_SAS_STATUS_BUF_SZ);
@@ -474,8 +476,9 @@ static int hisi_sas_task_prep(struct sas_task *task, struct hisi_sas_dq
 
 	return 0;
 
-err_out_slot_buf:
-	/* Nothing to be done */
+err_out_buf:
+	dma_pool_free(hisi_hba->buffer_pool, slot->buf,
+		      slot->buf_dma);
 err_out_tag:
 	spin_lock_irqsave(&hisi_hba->lock, flags);
 	hisi_sas_slot_index_free(hisi_hba, slot_idx);
@@ -1519,17 +1522,26 @@ static int hisi_sas_query_task(struct sas_task *task)
 	}
 	spin_unlock_irqrestore(&hisi_hba->lock, flags);
 
+	slot = &hisi_hba->slot_info[slot_idx];
+	memset(slot, 0, sizeof(struct hisi_sas_slot));
+
+	slot->buf = dma_pool_alloc(hisi_hba->buffer_pool,
+			GFP_ATOMIC, &slot->buf_dma);
+	if (!slot->buf) {
+		rc = -ENOMEM;
+		goto err_out_tag;
+	}
 	spin_lock_irqsave(&dq->lock, flags_dq);
 	rc = hisi_hba->hw->get_free_slot(hisi_hba, dq);
-	if (rc)
-		goto err_out_tag;
+	if (rc) {
+		rc = -ENOMEM;
+		spin_unlock_irqrestore(&dq->lock, flags_dq);
+		goto err_out_buf;
+	}
 
 	dlvry_queue = dq->id;
 	dlvry_queue_slot = dq->wr_point;
 
-	slot = &hisi_hba->slot_info[slot_idx];
-	memset(slot, 0, sizeof(struct hisi_sas_slot));
-
 	slot->idx = slot_idx;
 	slot->n_elem = n_elem;
 	slot->dlvry_queue = dlvry_queue;
@@ -1541,13 +1553,6 @@ static int hisi_sas_query_task(struct sas_task *task)
 	slot->is_internal = true;
 	task->lldd_task = slot;
 
-	slot->buf = dma_pool_alloc(hisi_hba->buffer_pool,
-			GFP_ATOMIC, &slot->buf_dma);
-	if (!slot->buf) {
-		rc = -ENOMEM;
-		goto err_out_tag;
-	}
-
 	memset(slot->cmd_hdr, 0, sizeof(struct hisi_sas_cmd_hdr));
 	memset(hisi_sas_cmd_hdr_addr_mem(slot), 0, HISI_SAS_COMMAND_TABLE_SZ);
 	memset(hisi_sas_status_buf_addr_mem(slot), 0, HISI_SAS_STATUS_BUF_SZ);
@@ -1570,11 +1575,13 @@ static int hisi_sas_query_task(struct sas_task *task)
 
 	return 0;
 
+err_out_buf:
+	dma_pool_free(hisi_hba->buffer_pool, slot->buf,
+		      slot->buf_dma);
 err_out_tag:
 	spin_lock_irqsave(&hisi_hba->lock, flags);
 	hisi_sas_slot_index_free(hisi_hba, slot_idx);
 	spin_unlock_irqrestore(&hisi_hba->lock, flags);
-	spin_unlock_irqrestore(&dq->lock, flags_dq);
 err_out:
 	dev_err(dev, "internal abort task prep: failed[%d]!\n", rc);
 
-- 
1.9.1
