Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeEBP5g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:57:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54537 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751658AbeEBP51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:57:27 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 01/11] scsi: hisi_sas: optimise the usage of DQ locking
Date: Wed, 2 May 2018 23:56:24 +0800
Message-ID: <1525276594-92173-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
References: <1525276594-92173-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

In the DQ tasklet processing it is not necessary to take the DQ
lock, as there is no contention between adding slots to the CQ and
removing slots from the matching DQ.

In addition, since we run each DQ in a separate tasklet context,
there would be no possible contention between DQ processing
running for the same queue in parallel.

It is still necessary to take hisi_hba lock when free'ing slots.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 ---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a5abde8..384e4ef 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3151,14 +3151,12 @@ static void cq_tasklet_v2_hw(unsigned long val)
 	struct hisi_sas_complete_v2_hdr *complete_queue;
 	u32 rd_point = cq->rd_point, wr_point, dev_id;
 	int queue = cq->id;
-	struct hisi_sas_dq *dq = &hisi_hba->dq[queue];
 
 	if (unlikely(hisi_hba->reject_stp_links_msk))
 		phys_try_accept_stp_links_v2_hw(hisi_hba);
 
 	complete_queue = hisi_hba->complete_hdr[queue];
 
-	spin_lock(&dq->lock);
 	wr_point = hisi_sas_read32(hisi_hba, COMPL_Q_0_WR_PTR +
 				   (0x14 * queue));
 
@@ -3208,7 +3206,6 @@ static void cq_tasklet_v2_hw(unsigned long val)
 	/* update rd_point */
 	cq->rd_point = rd_point;
 	hisi_sas_write32(hisi_hba, COMPL_Q_0_RD_PTR + (0x14 * queue), rd_point);
-	spin_unlock(&dq->lock);
 }
 
 static irqreturn_t cq_interrupt_v2_hw(int irq_no, void *p)
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 33735a7..afc1242 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1721,11 +1721,9 @@ static void cq_tasklet_v3_hw(unsigned long val)
 	struct hisi_sas_complete_v3_hdr *complete_queue;
 	u32 rd_point = cq->rd_point, wr_point;
 	int queue = cq->id;
-	struct hisi_sas_dq *dq = &hisi_hba->dq[queue];
 
 	complete_queue = hisi_hba->complete_hdr[queue];
 
-	spin_lock(&dq->lock);
 	wr_point = hisi_sas_read32(hisi_hba, COMPL_Q_0_WR_PTR +
 				   (0x14 * queue));
 
@@ -1752,7 +1750,6 @@ static void cq_tasklet_v3_hw(unsigned long val)
 	/* update rd_point */
 	cq->rd_point = rd_point;
 	hisi_sas_write32(hisi_hba, COMPL_Q_0_RD_PTR + (0x14 * queue), rd_point);
-	spin_unlock(&dq->lock);
 }
 
 static irqreturn_t cq_interrupt_v3_hw(int irq_no, void *p)
-- 
1.9.1
