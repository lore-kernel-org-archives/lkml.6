Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82208214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfAJNbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:31:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728702AbfAJNby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:31:54 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B3F73597EFA230B72652;
        Thu, 10 Jan 2019 21:31:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Thu, 10 Jan 2019 21:31:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: hisi_sas: Set protection parameters prior to adding SCSI host
Date:   Thu, 10 Jan 2019 21:32:41 +0800
Message-ID: <1547127161-213124-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we set the protection parameters after calling scsi_add_host()
for v3 hw.

They should be set beforehand, so make this change.

Appearantly this fixes our DIX issue (not mainline yet) also, but more
testing required.

Fixes: d6a9000b81be ("scsi: hisi_sas: Add support for DIF feature for v2 hw")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index b780b52..18d1f2cb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2675,6 +2675,12 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
 	if (hisi_sas_debugfs_enable)
 		hisi_sas_debugfs_init(hisi_hba);
 
+	if (hisi_hba->prot_mask) {
+		dev_info(dev, "Registering for DIF/DIX prot_mask=0x%x\n",
+			 prot_mask);
+		scsi_host_set_prot(hisi_hba->shost, prot_mask);
+	}
+
 	rc = scsi_add_host(shost, dev);
 	if (rc)
 		goto err_out_ha;
@@ -2687,12 +2693,6 @@ static void debugfs_snapshot_restore_v3_hw(struct hisi_hba *hisi_hba)
 	if (rc)
 		goto err_out_register_ha;
 
-	if (hisi_hba->prot_mask) {
-		dev_info(dev, "Registering for DIF/DIX prot_mask=0x%x\n",
-			 prot_mask);
-		scsi_host_set_prot(hisi_hba->shost, prot_mask);
-	}
-
 	scsi_scan_host(shost);
 
 	return 0;
-- 
1.9.1

