Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3601821479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:23:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3601821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbeKVA6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:58:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728283AbeKVA6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:58:05 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80A7A7862D87E;
        Wed, 21 Nov 2018 22:23:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Nov 2018 22:23:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <hch@infradead.org>,
        <maier@linux.ibm.com>, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/3] scsi: hisi_sas: Relocate some code to reduce complexity
Date:   Wed, 21 Nov 2018 22:24:31 +0800
Message-ID: <1542810273-134731-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1542810273-134731-1-git-send-email-john.garry@huawei.com>
References: <1542810273-134731-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Relocate the codes related to dma_map/unmap in hisi_sas_task_prep()
to reduce complexity, with a view to add DIF/DIX support.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 146 +++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 56 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 65dc749..d13a662 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -296,6 +296,90 @@ static void hisi_sas_task_prep_abort(struct hisi_hba *hisi_hba,
 			device_id, abort_flag, tag_to_abort);
 }
 
+static void hisi_sas_dma_unmap(struct hisi_hba *hisi_hba,
+			       struct sas_task *task, int n_elem,
+			       int n_elem_req, int n_elem_resp)
+{
+	struct device *dev = hisi_hba->dev;
+
+	if (!sas_protocol_ata(task->task_proto)) {
+		if (task->num_scatter) {
+			if (n_elem)
+				dma_unmap_sg(dev, task->scatter,
+					     task->num_scatter,
+					     task->data_dir);
+		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
+			if (n_elem_req)
+				dma_unmap_sg(dev, &task->smp_task.smp_req,
+					     1, DMA_TO_DEVICE);
+			if (n_elem_resp)
+				dma_unmap_sg(dev, &task->smp_task.smp_resp,
+					     1, DMA_FROM_DEVICE);
+		}
+	}
+}
+
+static int hisi_sas_dma_map(struct hisi_hba *hisi_hba,
+			    struct sas_task *task, int *n_elem,
+			    int *n_elem_req, int *n_elem_resp)
+{
+	struct device *dev = hisi_hba->dev;
+	int rc;
+
+	if (sas_protocol_ata(task->task_proto)) {
+		*n_elem = task->num_scatter;
+	} else {
+		unsigned int req_len, resp_len;
+
+		if (task->num_scatter) {
+			*n_elem = dma_map_sg(dev, task->scatter,
+					     task->num_scatter, task->data_dir);
+			if (!*n_elem) {
+				rc = -ENOMEM;
+				goto prep_out;
+			}
+		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
+			*n_elem_req = dma_map_sg(dev, &task->smp_task.smp_req,
+						 1, DMA_TO_DEVICE);
+			if (!*n_elem_req) {
+				rc = -ENOMEM;
+				goto prep_out;
+			}
+			req_len = sg_dma_len(&task->smp_task.smp_req);
+			if (req_len & 0x3) {
+				rc = -EINVAL;
+				goto err_out_dma_unmap;
+			}
+			*n_elem_resp = dma_map_sg(dev, &task->smp_task.smp_resp,
+						  1, DMA_FROM_DEVICE);
+			if (!*n_elem_resp) {
+				rc = -ENOMEM;
+				goto err_out_dma_unmap;
+			}
+			resp_len = sg_dma_len(&task->smp_task.smp_resp);
+			if (resp_len & 0x3) {
+				rc = -EINVAL;
+				goto err_out_dma_unmap;
+			}
+		}
+	}
+
+	if (*n_elem > HISI_SAS_SGE_PAGE_CNT) {
+		dev_err(dev, "task prep: n_elem(%d) > HISI_SAS_SGE_PAGE_CNT",
+			*n_elem);
+		rc = -EINVAL;
+		goto err_out_dma_unmap;
+	}
+	return 0;
+
+err_out_dma_unmap:
+	/* It would be better to call dma_unmap_sg() here, but it's messy */
+	hisi_sas_dma_unmap(hisi_hba, task, *n_elem,
+			   *n_elem_req, *n_elem_resp);
+prep_out:
+	return rc;
+}
+
 static int hisi_sas_task_prep(struct sas_task *task,
 			      struct hisi_sas_dq **dq_pointer,
 			      bool is_tmf, struct hisi_sas_tmf_task *tmf,
@@ -338,49 +422,10 @@ static int hisi_sas_task_prep(struct sas_task *task,
 		return -ECOMM;
 	}
 
-	if (!sas_protocol_ata(task->task_proto)) {
-		unsigned int req_len, resp_len;
-
-		if (task->num_scatter) {
-			n_elem = dma_map_sg(dev, task->scatter,
-					    task->num_scatter, task->data_dir);
-			if (!n_elem) {
-				rc = -ENOMEM;
-				goto prep_out;
-			}
-		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
-			n_elem_req = dma_map_sg(dev, &task->smp_task.smp_req,
-						1, DMA_TO_DEVICE);
-			if (!n_elem_req) {
-				rc = -ENOMEM;
-				goto prep_out;
-			}
-			req_len = sg_dma_len(&task->smp_task.smp_req);
-			if (req_len & 0x3) {
-				rc = -EINVAL;
-				goto err_out_dma_unmap;
-			}
-			n_elem_resp = dma_map_sg(dev, &task->smp_task.smp_resp,
-						 1, DMA_FROM_DEVICE);
-			if (!n_elem_resp) {
-				rc = -ENOMEM;
-				goto err_out_dma_unmap;
-			}
-			resp_len = sg_dma_len(&task->smp_task.smp_resp);
-			if (resp_len & 0x3) {
-				rc = -EINVAL;
-				goto err_out_dma_unmap;
-			}
-		}
-	} else
-		n_elem = task->num_scatter;
-
-	if (n_elem > HISI_SAS_SGE_PAGE_CNT) {
-		dev_err(dev, "task prep: n_elem(%d) > HISI_SAS_SGE_PAGE_CNT",
-			n_elem);
-		rc = -EINVAL;
-		goto err_out_dma_unmap;
-	}
+	rc = hisi_sas_dma_map(hisi_hba, task, &n_elem,
+			      &n_elem_req, &n_elem_resp);
+	if (rc < 0)
+		goto prep_out;
 
 	if (hisi_hba->hw->slot_index_alloc)
 		rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
@@ -465,19 +510,8 @@ static int hisi_sas_task_prep(struct sas_task *task,
 err_out_tag:
 	hisi_sas_slot_index_free(hisi_hba, slot_idx);
 err_out_dma_unmap:
-	if (!sas_protocol_ata(task->task_proto)) {
-		if (task->num_scatter) {
-			dma_unmap_sg(dev, task->scatter, task->num_scatter,
-			     task->data_dir);
-		} else if (task->task_proto & SAS_PROTOCOL_SMP) {
-			if (n_elem_req)
-				dma_unmap_sg(dev, &task->smp_task.smp_req,
-					     1, DMA_TO_DEVICE);
-			if (n_elem_resp)
-				dma_unmap_sg(dev, &task->smp_task.smp_resp,
-					     1, DMA_FROM_DEVICE);
-		}
-	}
+	hisi_sas_dma_unmap(hisi_hba, task, n_elem,
+			   n_elem_req, n_elem_resp);
 prep_out:
 	dev_err(dev, "task prep: failed[%d]!\n", rc);
 	return rc;
-- 
1.9.1

