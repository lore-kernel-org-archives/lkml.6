Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755167AbeEaMwa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:52:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38658 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754733AbeEaMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:52:19 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 1/9] scsi: hisi_sas: Use dmam_alloc_coherent()
Date: Thu, 31 May 2018 20:50:42 +0800
Message-ID: <1527771050-200916-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527771050-200916-1-git-send-email-john.garry@huawei.com>
References: <1527771050-200916-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

This patch replaces the usage of dma_alloc_coherent() with the managed
version, dmam_alloc_coherent(), hereby reducing replicated code.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by; John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 80 +++++++++--------------------------
 1 file changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 6f56297..1c424bb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2045,15 +2045,17 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 
 		/* Delivery queue */
 		s = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
-		hisi_hba->cmd_hdr[i] = dma_alloc_coherent(dev, s,
-					&hisi_hba->cmd_hdr_dma[i], GFP_KERNEL);
+		hisi_hba->cmd_hdr[i] = dmam_alloc_coherent(dev, s,
+						&hisi_hba->cmd_hdr_dma[i],
+						GFP_KERNEL);
 		if (!hisi_hba->cmd_hdr[i])
 			goto err_out;
 
 		/* Completion queue */
 		s = hisi_hba->hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
-		hisi_hba->complete_hdr[i] = dma_alloc_coherent(dev, s,
-				&hisi_hba->complete_hdr_dma[i], GFP_KERNEL);
+		hisi_hba->complete_hdr[i] = dmam_alloc_coherent(dev, s,
+						&hisi_hba->complete_hdr_dma[i],
+						GFP_KERNEL);
 		if (!hisi_hba->complete_hdr[i])
 			goto err_out;
 	}
@@ -2064,10 +2066,11 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 		goto err_out;
 
 	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
-	hisi_hba->itct = dma_zalloc_coherent(dev, s, &hisi_hba->itct_dma,
-					    GFP_KERNEL);
+	hisi_hba->itct = dmam_alloc_coherent(dev, s, &hisi_hba->itct_dma,
+					     GFP_KERNEL);
 	if (!hisi_hba->itct)
 		goto err_out;
+	memset(hisi_hba->itct, 0, s);
 
 	hisi_hba->slot_info = devm_kcalloc(dev, max_command_entries,
 					   sizeof(struct hisi_sas_slot),
@@ -2076,14 +2079,15 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 		goto err_out;
 
 	s = max_command_entries * sizeof(struct hisi_sas_iost);
-	hisi_hba->iost = dma_alloc_coherent(dev, s, &hisi_hba->iost_dma,
-					    GFP_KERNEL);
+	hisi_hba->iost = dmam_alloc_coherent(dev, s, &hisi_hba->iost_dma,
+					     GFP_KERNEL);
 	if (!hisi_hba->iost)
 		goto err_out;
 
 	s = max_command_entries * sizeof(struct hisi_sas_breakpoint);
-	hisi_hba->breakpoint = dma_alloc_coherent(dev, s,
-				&hisi_hba->breakpoint_dma, GFP_KERNEL);
+	hisi_hba->breakpoint = dmam_alloc_coherent(dev, s,
+						   &hisi_hba->breakpoint_dma,
+						   GFP_KERNEL);
 	if (!hisi_hba->breakpoint)
 		goto err_out;
 
@@ -2094,14 +2098,16 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 		goto err_out;
 
 	s = sizeof(struct hisi_sas_initial_fis) * HISI_SAS_MAX_PHYS;
-	hisi_hba->initial_fis = dma_alloc_coherent(dev, s,
-				&hisi_hba->initial_fis_dma, GFP_KERNEL);
+	hisi_hba->initial_fis = dmam_alloc_coherent(dev, s,
+						    &hisi_hba->initial_fis_dma,
+						    GFP_KERNEL);
 	if (!hisi_hba->initial_fis)
 		goto err_out;
 
 	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_sata_breakpoint);
-	hisi_hba->sata_breakpoint = dma_alloc_coherent(dev, s,
-				&hisi_hba->sata_breakpoint_dma, GFP_KERNEL);
+	hisi_hba->sata_breakpoint = dmam_alloc_coherent(dev, s,
+					&hisi_hba->sata_breakpoint_dma,
+					GFP_KERNEL);
 	if (!hisi_hba->sata_breakpoint)
 		goto err_out;
 	hisi_sas_init_mem(hisi_hba);
@@ -2122,54 +2128,8 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 
 void hisi_sas_free(struct hisi_hba *hisi_hba)
 {
-	struct device *dev = hisi_hba->dev;
-	int i, s, max_command_entries = hisi_hba->hw->max_command_entries;
-
-	for (i = 0; i < hisi_hba->queue_count; i++) {
-		s = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
-		if (hisi_hba->cmd_hdr[i])
-			dma_free_coherent(dev, s,
-					  hisi_hba->cmd_hdr[i],
-					  hisi_hba->cmd_hdr_dma[i]);
-
-		s = hisi_hba->hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
-		if (hisi_hba->complete_hdr[i])
-			dma_free_coherent(dev, s,
-					  hisi_hba->complete_hdr[i],
-					  hisi_hba->complete_hdr_dma[i]);
-	}
-
 	dma_pool_destroy(hisi_hba->buffer_pool);
 
-	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
-	if (hisi_hba->itct)
-		dma_free_coherent(dev, s,
-				  hisi_hba->itct, hisi_hba->itct_dma);
-
-	s = max_command_entries * sizeof(struct hisi_sas_iost);
-	if (hisi_hba->iost)
-		dma_free_coherent(dev, s,
-				  hisi_hba->iost, hisi_hba->iost_dma);
-
-	s = max_command_entries * sizeof(struct hisi_sas_breakpoint);
-	if (hisi_hba->breakpoint)
-		dma_free_coherent(dev, s,
-				  hisi_hba->breakpoint,
-				  hisi_hba->breakpoint_dma);
-
-
-	s = sizeof(struct hisi_sas_initial_fis) * HISI_SAS_MAX_PHYS;
-	if (hisi_hba->initial_fis)
-		dma_free_coherent(dev, s,
-				  hisi_hba->initial_fis,
-				  hisi_hba->initial_fis_dma);
-
-	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_sata_breakpoint);
-	if (hisi_hba->sata_breakpoint)
-		dma_free_coherent(dev, s,
-				  hisi_hba->sata_breakpoint,
-				  hisi_hba->sata_breakpoint_dma);
-
 	if (hisi_hba->wq)
 		destroy_workqueue(hisi_hba->wq);
 }
-- 
1.9.1
