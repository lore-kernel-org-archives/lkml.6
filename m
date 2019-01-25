Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA54A218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfAYOWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728641AbfAYOWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:07 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 471E79C91A481FA10234;
        Fri, 25 Jan 2019 22:22:04 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:53 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 11/13] scsi: hisi_sas: Some misc tidy-up
Date:   Fri, 25 Jan 2019 22:22:37 +0800
Message-ID: <1548426159-225679-12-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
References: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse detected some problems in the driver, so tidy them up.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 89f1bc5..e48b627 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2075,14 +2075,18 @@ void hisi_sas_kill_tasklets(struct hisi_hba *hisi_hba)
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
 {
-	int i, s, max_command_entries = hisi_hba->hw->max_command_entries;
+	int i, s, j, max_command_entries = hisi_hba->hw->max_command_entries;
+	struct hisi_sas_breakpoint *sata_breakpoint = hisi_hba->sata_breakpoint;
 
 	for (i = 0; i < hisi_hba->queue_count; i++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[i];
 		struct hisi_sas_dq *dq = &hisi_hba->dq[i];
+		struct hisi_sas_cmd_hdr *cmd_hdr = hisi_hba->cmd_hdr[i];
+
+		s = sizeof(struct hisi_sas_cmd_hdr);
+		for (j = 0; j < HISI_SAS_QUEUE_SLOTS; j++)
+			memset(&cmd_hdr[j], 0, s);
 
-		s = sizeof(struct hisi_sas_cmd_hdr) * HISI_SAS_QUEUE_SLOTS;
-		memset(hisi_hba->cmd_hdr[i], 0, s);
 		dq->wr_point = 0;
 
 		s = hisi_hba->hw->complete_hdr_size * HISI_SAS_QUEUE_SLOTS;
@@ -2099,8 +2103,9 @@ void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
 	s = max_command_entries * sizeof(struct hisi_sas_breakpoint);
 	memset(hisi_hba->breakpoint, 0, s);
 
-	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_sata_breakpoint);
-	memset(hisi_hba->sata_breakpoint, 0, s);
+	s = sizeof(struct hisi_sas_sata_breakpoint);
+	for (j = 0; j < HISI_SAS_MAX_ITCT_ENTRIES; j++)
+		memset(&sata_breakpoint[j], 0, s);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_init_mem);
 
@@ -2157,10 +2162,9 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba)
 
 	s = HISI_SAS_MAX_ITCT_ENTRIES * sizeof(struct hisi_sas_itct);
 	hisi_hba->itct = dmam_alloc_coherent(dev, s, &hisi_hba->itct_dma,
-					     GFP_KERNEL);
+					     GFP_KERNEL | __GFP_ZERO);
 	if (!hisi_hba->itct)
 		goto err_out;
-	memset(hisi_hba->itct, 0, s);
 
 	hisi_hba->slot_info = devm_kcalloc(dev, max_command_entries,
 					   sizeof(struct hisi_sas_slot),
@@ -2505,10 +2509,17 @@ static void hisi_sas_debugfs_snapshot_dq_reg(struct hisi_hba *hisi_hba)
 	int queue_entry_size = sizeof(struct hisi_sas_cmd_hdr);
 	int i;
 
-	for (i = 0; i < hisi_hba->queue_count; i++)
-		memcpy(hisi_hba->debugfs_cmd_hdr[i],
-		       hisi_hba->cmd_hdr[i],
-		       HISI_SAS_QUEUE_SLOTS * queue_entry_size);
+	for (i = 0; i < hisi_hba->queue_count; i++) {
+		struct hisi_sas_cmd_hdr	*debugfs_cmd_hdr, *cmd_hdr;
+		int j;
+
+		debugfs_cmd_hdr = hisi_hba->debugfs_cmd_hdr[i];
+		cmd_hdr = hisi_hba->cmd_hdr[i];
+
+		for (j = 0; j < HISI_SAS_QUEUE_SLOTS; j++)
+			memcpy(&debugfs_cmd_hdr[j], &cmd_hdr[j],
+			       queue_entry_size);
+	}
 }
 
 static void hisi_sas_debugfs_snapshot_port_reg(struct hisi_hba *hisi_hba)
-- 
1.9.1

