Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53754C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B734218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfAYOWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:22:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2757 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbfAYOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:02 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 306954F42F6138253C5E;
        Fri, 25 Jan 2019 22:21:59 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 01/13] scsi: hisi_sas: No need to check return value of debugfs_create functions
Date:   Fri, 25 Jan 2019 22:22:27 +0800
Message-ID: <1548426159-225679-2-git-send-email-john.garry@huawei.com>
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

When calling debugfs functions, there is no need to ever check the return
value. The function can work or not, but the code logic should never do
something different based on this.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |  1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c | 53 +++++++++++------------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 6a1a5ad..b8b1ded 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -368,6 +368,7 @@ struct hisi_hba {
 
 	struct dentry *debugfs_dir;
 	struct dentry *debugfs_dump_dentry;
+	bool debugfs_snapshot;
 };
 
 /* Generic HW DMA host memory structures */
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 535d347..72d2295 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1429,8 +1429,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	struct Scsi_Host *shost = hisi_hba->shost;
 	int rc;
 
-	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct &&
-	    !hisi_hba->debugfs_dump_dentry)
+	if (hisi_sas_debugfs_enable && hisi_hba->debugfs_itct)
 		queue_work(hisi_hba->wq, &hisi_hba->debugfs_work);
 
 	if (!hisi_hba->hw->soft_reset)
@@ -2784,63 +2783,42 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 
 	/* Create dump dir inside device dir */
 	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
-	if (!dump_dentry)
-		goto fail;
-
 	hisi_hba->debugfs_dump_dentry = dump_dentry;
 
-	if (!debugfs_create_file("global", 0400, dump_dentry, hisi_hba,
-				 &hisi_sas_debugfs_global_fops))
-		goto fail;
+	debugfs_create_file("global", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_global_fops);
 
 	/* Create port dir and files */
 	dentry = debugfs_create_dir("port", dump_dentry);
-	if (!dentry)
-		goto fail;
-
 	for (p = 0; p < hisi_hba->n_phy; p++) {
 		snprintf(name, 256, "%d", p);
-		if (!debugfs_create_file(name, 0400, dentry,
-					 &hisi_hba->phy[p],
-					 &hisi_sas_debugfs_port_fops))
-			goto fail;
+
+		debugfs_create_file(name, 0400, dentry, &hisi_hba->phy[p],
+				    &hisi_sas_debugfs_port_fops);
 	}
 
 	/* Create CQ dir and files */
 	dentry = debugfs_create_dir("cq", dump_dentry);
-	if (!dentry)
-		goto fail;
-
 	for (c = 0; c < hisi_hba->queue_count; c++) {
 		snprintf(name, 256, "%d", c);
 
-		if (!debugfs_create_file(name, 0400, dentry,
-					 &hisi_hba->cq[c],
-					 &hisi_sas_debugfs_cq_fops))
-			goto fail;
+		debugfs_create_file(name, 0400, dentry, &hisi_hba->cq[c],
+				    &hisi_sas_debugfs_cq_fops);
 	}
 
 	/* Create DQ dir and files */
 	dentry = debugfs_create_dir("dq", dump_dentry);
-	if (!dentry)
-		goto fail;
-
 	for (d = 0; d < hisi_hba->queue_count; d++) {
 		snprintf(name, 256, "%d", d);
 
-		if (!debugfs_create_file(name, 0400, dentry,
-					 &hisi_hba->dq[d],
-					 &hisi_sas_debugfs_dq_fops))
-			goto fail;
+		debugfs_create_file(name, 0400, dentry, &hisi_hba->dq[d],
+				    &hisi_sas_debugfs_dq_fops);
 	}
 
-	if (!debugfs_create_file("iost", 0400, dump_dentry, hisi_hba,
-				 &hisi_sas_debugfs_iost_fops))
-		goto fail;
+	debugfs_create_file("iost", 0400, dump_dentry, hisi_hba,
+			    &hisi_sas_debugfs_iost_fops);
 
 	return;
-fail:
-	debugfs_remove_recursive(hisi_hba->debugfs_dir);
 }
 
 static void hisi_sas_debugfs_snapshot_regs(struct hisi_hba *hisi_hba)
@@ -2864,6 +2842,10 @@ void hisi_sas_debugfs_work_handler(struct work_struct *work)
 	struct hisi_hba *hisi_hba =
 		container_of(work, struct hisi_hba, debugfs_work);
 
+	if (hisi_hba->debugfs_snapshot)
+		return;
+	hisi_hba->debugfs_snapshot = true;
+
 	hisi_sas_debugfs_snapshot_regs(hisi_hba);
 }
 EXPORT_SYMBOL_GPL(hisi_sas_debugfs_work_handler);
@@ -2878,9 +2860,6 @@ void hisi_sas_debugfs_init(struct hisi_hba *hisi_hba)
 	hisi_hba->debugfs_dir = debugfs_create_dir(dev_name(dev),
 						   hisi_sas_debugfs_dir);
 
-	if (!hisi_hba->debugfs_dir)
-		return;
-
 	/* Alloc buffer for global */
 	sz = hisi_hba->hw->debugfs_reg_global->count * 4;
 	hisi_hba->debugfs_global_reg =
-- 
1.9.1

