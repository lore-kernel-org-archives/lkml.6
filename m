Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC1CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AEA2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AEA2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbeIXVMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:12:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728512AbeIXVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:12:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0711468DEFC99;
        Mon, 24 Sep 2018 23:09:39 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Mon, 24 Sep 2018 23:09:31 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/7] scsi: hisi_sas: Fix the race between IO completion and timeout for SMP/internal IO
Date:   Mon, 24 Sep 2018 23:06:30 +0800
Message-ID: <1537801594-207139-4-git-send-email-john.garry@huawei.com>
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

If SMP/internal IO times out, we will possibly free the task immediately.

However if the IO actually completes at the same time, the IO completion
may refer to task which have been freed.

So to solve the issue, flush the tasklet to finish IO completion before
free'ing slot/task.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 55 +++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 3b95a7a..416f2c0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -956,8 +956,7 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 
 static void hisi_sas_task_done(struct sas_task *task)
 {
-	if (!del_timer(&task->slow_task->timer))
-		return;
+	del_timer(&task->slow_task->timer);
 	complete(&task->slow_task->completion);
 }
 
@@ -966,13 +965,17 @@ static void hisi_sas_tmf_timedout(struct timer_list *t)
 	struct sas_task_slow *slow = from_timer(slow, t, timer);
 	struct sas_task *task = slow->task;
 	unsigned long flags;
+	bool is_completed = true;
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
-	if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+		is_completed = false;
+	}
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
-	complete(&task->slow_task->completion);
+	if (!is_completed)
+		complete(&task->slow_task->completion);
 }
 
 #define TASK_TIMEOUT 20
@@ -1023,10 +1026,18 @@ static int hisi_sas_exec_internal_tmf_task(struct domain_device *device,
 		if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
 			if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 				struct hisi_sas_slot *slot = task->lldd_task;
+				struct hisi_sas_cq *cq =
+					&hisi_hba->cq[slot->dlvry_queue];
 
 				dev_err(dev, "abort tmf: TMF task timeout and not done\n");
-				if (slot)
+				if (slot) {
+					/*
+					 * flush tasklet to avoid free'ing task
+					 * before using task in IO completion
+					 */
+					tasklet_kill(&cq->tasklet);
 					slot->task = NULL;
+				}
 
 				goto ex_err;
 			} else
@@ -1402,6 +1413,17 @@ static int hisi_sas_abort_task(struct sas_task *task)
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
+		struct hisi_sas_slot *slot = task->lldd_task;
+		struct hisi_sas_cq *cq;
+
+		if (slot) {
+			/*
+			 * flush tasklet to avoid free'ing task
+			 * before using task in IO completion
+			 */
+			cq = &hisi_hba->cq[slot->dlvry_queue];
+			tasklet_kill(&cq->tasklet);
+		}
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
 		rc = TMF_RESP_FUNC_COMPLETE;
 		goto out;
@@ -1457,12 +1479,19 @@ static int hisi_sas_abort_task(struct sas_task *task)
 		/* SMP */
 		struct hisi_sas_slot *slot = task->lldd_task;
 		u32 tag = slot->idx;
+		struct hisi_sas_cq *cq = &hisi_hba->cq[slot->dlvry_queue];
 
 		rc = hisi_sas_internal_task_abort(hisi_hba, device,
 			     HISI_SAS_INT_ABT_CMD, tag);
 		if (((rc < 0) || (rc == TMF_RESP_FUNC_FAILED)) &&
-					task->lldd_task)
-			hisi_sas_do_release_task(hisi_hba, task, slot);
+					task->lldd_task) {
+			/*
+			 * flush tasklet to avoid free'ing task
+			 * before using task in IO completion
+			 */
+			tasklet_kill(&cq->tasklet);
+			slot->task = NULL;
+		}
 	}
 
 out:
@@ -1828,9 +1857,17 @@ static int hisi_sas_query_task(struct sas_task *task)
 	if ((task->task_state_flags & SAS_TASK_STATE_ABORTED)) {
 		if (!(task->task_state_flags & SAS_TASK_STATE_DONE)) {
 			struct hisi_sas_slot *slot = task->lldd_task;
-
-			if (slot)
+			struct hisi_sas_cq *cq =
+				&hisi_hba->cq[slot->dlvry_queue];
+
+			if (slot) {
+				/*
+				 * flush tasklet to avoid free'ing task
+				 * before using task in IO completion
+				 */
+				tasklet_kill(&cq->tasklet);
 				slot->task = NULL;
+			}
 			dev_err(dev, "internal task abort: timeout and not done.\n");
 			res = -EIO;
 			goto exit;
-- 
1.9.1

