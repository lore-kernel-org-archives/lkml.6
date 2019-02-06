Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE4DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50C2217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfBFKwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:52:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728188AbfBFKwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:52:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E742C5D33B30F33D84AC;
        Wed,  6 Feb 2019 18:52:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Feb 2019 18:52:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 4/6] scsi: hisi_sas: Issue internal abort on all relevant queues
Date:   Wed, 6 Feb 2019 18:52:54 +0800
Message-ID: <1549450376-114929-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
References: <1549450376-114929-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support queue mapped to a CPU, it needs to be ensured that issuing an
internal abort is safe, in that it is guaranteed that an internal abort
is processed for a single IO or a device after all the relevant
command(s) which it is attempting to abort have been processed by
the controller.

Currently we only deliver commands for any device on a single queue to
solve this problem, as we know that commands issued on the same queue
will be processed in order, and we will not have a scenario where the
internal abort is racing against a command(s) which it is trying to abort.

To enqueue commands on queue mapped to a CPU, choosing a queue for an
command is based on the associated queue for the current CPU, so
this is not safe for internal abort since it would definitely not be
guaranteed that commands for the command devices are issued on the
same queue.

To solve this issue, we take a bludgeoning approach, and issue a separate
internal abort on any queue(s) relevant to the command or device, in that
we will be guaranteed that at least one of these internal aborts will be
received last in the controller.

So, for aborting a single command, we can just force the internal abort to
be issued on the same queue as the command which we are trying to abort.

For aborting all commands associated with a device, we issue a separate
internal abort on all relevant queues. Issuing multiple internal aborts in
this fashion would have not side affect.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  2 +
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 64 ++++++++++++++++++++------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  2 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  2 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  8 +++-
 5 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index ff844d4ba0d3..5accad05a86f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -365,6 +365,8 @@ struct hisi_hba {
 	u32 intr_coal_ticks;	/* Time of interrupt coalesce in us */
 	u32 intr_coal_count;	/* Interrupt count to coalesce */
 
+	int cq_nvecs;
+
 	/* debugfs memories */
 	u32 *debugfs_global_reg;
 	u32 *debugfs_port_reg[HISI_SAS_MAX_PHYS];
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 35619bdad1d5..40a402f09afb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1023,7 +1023,7 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 
 	if (!test_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags)) {
 		hisi_sas_internal_task_abort(hisi_hba, device,
-				     HISI_SAS_INT_ABT_DEV, 0);
+					     HISI_SAS_INT_ABT_DEV, 0);
 
 		hisi_sas_dereg_device(hisi_hba, device);
 
@@ -1630,7 +1630,8 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		task->task_proto & SAS_PROTOCOL_STP) {
 		if (task->dev->dev_type == SAS_SATA_DEV) {
 			rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						HISI_SAS_INT_ABT_DEV, 0);
+							  HISI_SAS_INT_ABT_DEV,
+							  0);
 			if (rc < 0) {
 				dev_err(dev, "abort task: internal abort failed\n");
 				goto out;
@@ -1645,7 +1646,7 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		struct hisi_sas_cq *cq = &hisi_hba->cq[slot->dlvry_queue];
 
 		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-			     HISI_SAS_INT_ABT_CMD, tag);
+						  HISI_SAS_INT_ABT_CMD, tag);
 		if (((rc < 0) || (rc == TMF_RESP_FUNC_FAILED)) &&
 					task->lldd_task) {
 			/*
@@ -1671,7 +1672,7 @@ static int hisi_sas_abort_task_set(struct domain_device *device, u8 *lun)
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
-					HISI_SAS_INT_ABT_DEV, 0);
+					  HISI_SAS_INT_ABT_DEV, 0);
 	if (rc < 0) {
 		dev_err(dev, "abort task set: internal abort rc=%d\n", rc);
 		return TMF_RESP_FUNC_FAILED;
@@ -1743,7 +1744,7 @@ static int hisi_sas_I_T_nexus_reset(struct domain_device *device)
 	int rc = TMF_RESP_FUNC_FAILED;
 
 	rc = hisi_sas_internal_task_abort(hisi_hba, device,
-					HISI_SAS_INT_ABT_DEV, 0);
+					  HISI_SAS_INT_ABT_DEV, 0);
 	if (rc < 0) {
 		dev_err(dev, "I_T nexus reset: internal abort (%d)\n", rc);
 		return TMF_RESP_FUNC_FAILED;
@@ -1788,7 +1789,7 @@ static int hisi_sas_lu_reset(struct domain_device *device, u8 *lun)
 		struct hisi_sas_tmf_task tmf_task = { .tmf =  TMF_LU_RESET };
 
 		rc = hisi_sas_internal_task_abort(hisi_hba, device,
-						HISI_SAS_INT_ABT_DEV, 0);
+						  HISI_SAS_INT_ABT_DEV, 0);
 		if (rc < 0) {
 			dev_err(dev, "lu_reset: internal abort failed\n");
 			goto out;
@@ -1874,7 +1875,7 @@ static int hisi_sas_query_task(struct sas_task *task)
 static int
 hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 				  struct sas_task *task, int abort_flag,
-				  int task_tag)
+				  int task_tag, struct hisi_sas_dq *dq)
 {
 	struct domain_device *device = task->dev;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
@@ -1883,7 +1884,6 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 	struct hisi_sas_slot *slot;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_cmd_hdr *cmd_hdr_base;
-	struct hisi_sas_dq *dq = sas_dev->dq;
 	int dlvry_queue_slot, dlvry_queue, n_elem = 0, rc, slot_idx;
 	unsigned long flags, flags_dq = 0;
 	int wr_q_index;
@@ -1955,18 +1955,19 @@ hisi_sas_internal_abort_task_exec(struct hisi_hba *hisi_hba, int device_id,
 }
 
 /**
- * hisi_sas_internal_task_abort -- execute an internal
+ * _hisi_sas_internal_task_abort -- execute an internal
  * abort command for single IO command or a device
  * @hisi_hba: host controller struct
  * @device: domain device
  * @abort_flag: mode of operation, device or single IO
  * @tag: tag of IO to be aborted (only relevant to single
  *       IO mode)
+ * @dq: delivery queue for this internal abort command
  */
 static int
-hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
-			     struct domain_device *device,
-			     int abort_flag, int tag)
+_hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
+			      struct domain_device *device, int abort_flag,
+			      int tag, struct hisi_sas_dq *dq)
 {
 	struct sas_task *task;
 	struct hisi_sas_device *sas_dev = device->lldd_dev;
@@ -1994,7 +1995,7 @@ hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	add_timer(&task->slow_task->timer);
 
 	res = hisi_sas_internal_abort_task_exec(hisi_hba, sas_dev->device_id,
-						task, abort_flag, tag);
+						task, abort_flag, tag, dq);
 	if (res) {
 		del_timer(&task->slow_task->timer);
 		dev_err(dev, "internal task abort: executing internal task failed: %d\n",
@@ -2051,6 +2052,41 @@ hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
 	return res;
 }
 
+static int
+hisi_sas_internal_task_abort(struct hisi_hba *hisi_hba,
+			     struct domain_device *device,
+			     int abort_flag, int tag)
+{
+	struct hisi_sas_slot *slot;
+	struct device *dev = hisi_hba->dev;
+	struct hisi_sas_dq *dq;
+	int i, rc;
+
+	switch (abort_flag) {
+	case HISI_SAS_INT_ABT_CMD:
+		slot = &hisi_hba->slot_info[tag];
+		dq = &hisi_hba->dq[slot->dlvry_queue];
+		return _hisi_sas_internal_task_abort(hisi_hba, device,
+						     abort_flag, tag, dq);
+	case HISI_SAS_INT_ABT_DEV:
+		for (i = 0; i < hisi_hba->cq_nvecs; i++) {
+			dq = &hisi_hba->dq[i];
+			rc = _hisi_sas_internal_task_abort(hisi_hba, device,
+							   abort_flag, tag,
+							   dq);
+			if (rc)
+				return rc;
+		}
+		break;
+	default:
+		dev_err(dev, "Unrecognised internal abort flag (%d)\n",
+			abort_flag);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void hisi_sas_port_formed(struct asd_sas_phy *sas_phy)
 {
 	hisi_sas_port_notify_formed(sas_phy);
@@ -2117,7 +2153,7 @@ void hisi_sas_kill_tasklets(struct hisi_hba *hisi_hba)
 {
 	int i;
 
-	for (i = 0; i < hisi_hba->queue_count; i++) {
+	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 
 		tasklet_kill(&cq->tasklet);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index c8f808faed95..293807443480 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1749,6 +1749,8 @@ static int interrupt_init_v1_hw(struct hisi_hba *hisi_hba)
 		}
 	}
 
+	hisi_hba->cq_nvecs = hisi_hba->queue_count;
+
 	return 0;
 }
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index aa90f17a1cac..39233a9cd1f5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3400,6 +3400,8 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 		tasklet_init(t, cq_tasklet_v2_hw, (unsigned long)cq);
 	}
 
+	hisi_hba->cq_nvecs = hisi_hba->queue_count;
+
 	return 0;
 
 free_cq_int_irqs:
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 0455fba93daf..20cec1d2439c 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -402,6 +402,8 @@ struct hisi_sas_err_record_v3 {
 #define T10_CHK_REF_TAG_MSK (0xf0 << T10_CHK_MSK_OFF)
 #define T10_CHK_APP_TAG_MSK (0xc << T10_CHK_MSK_OFF)
 
+#define BASE_VECTORS_V3_HW  16
+
 static bool hisi_sas_intr_conv;
 MODULE_PARM_DESC(intr_conv, "interrupt converge enable (0-1)");
 
@@ -2050,6 +2052,8 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 		return -ENOENT;
 	}
 
+	hisi_hba->cq_nvecs = vectors - BASE_VECTORS_V3_HW;
+
 	rc = devm_request_irq(dev, pci_irq_vector(pdev, 1),
 			      int_phy_up_down_bcast_v3_hw, 0,
 			      DRV_NAME " phy", hisi_hba);
@@ -2078,7 +2082,7 @@ static int interrupt_init_v3_hw(struct hisi_hba *hisi_hba)
 	}
 
 	/* Init tasklets for cq only */
-	for (i = 0; i < hisi_hba->queue_count; i++) {
+	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 		struct tasklet_struct *t = &cq->tasklet;
 		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
@@ -2795,7 +2799,7 @@ hisi_sas_v3_destroy_irqs(struct pci_dev *pdev, struct hisi_hba *hisi_hba)
 	free_irq(pci_irq_vector(pdev, 1), hisi_hba);
 	free_irq(pci_irq_vector(pdev, 2), hisi_hba);
 	free_irq(pci_irq_vector(pdev, 11), hisi_hba);
-	for (i = 0; i < hisi_hba->queue_count; i++) {
+	for (i = 0; i < hisi_hba->cq_nvecs; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 		int nr = hisi_sas_intr_conv ? 16 : 16 + i;
 
-- 
2.17.1

