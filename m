Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeCWQHb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:07:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752019AbeCWQGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:06:08 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/8] scsi: hisi_sas: delete timer when removing hisi_sas driver
Date: Sat, 24 Mar 2018 00:05:10 +0800
Message-ID: <1521821115-120040-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521821115-120040-1-git-send-email-john.garry@huawei.com>
References: <1521821115-120040-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Delete timer for v1 and v3 hw when removing hisi_sas driver.

Signed-off-by: Xiang chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 3 +++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 ---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 49c1fa6..a216795 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2177,6 +2177,9 @@ int hisi_sas_remove(struct platform_device *pdev)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct Scsi_Host *shost = sha->core.shost;
 
+	if (timer_pending(&hisi_hba->timer))
+		del_timer(&hisi_hba->timer);
+
 	sas_unregister_ha(sha);
 	sas_remove_host(sha->core.shost);
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 89b9505..bed6afb 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3599,9 +3599,6 @@ static int hisi_sas_v2_remove(struct platform_device *pdev)
 	struct sas_ha_struct *sha = platform_get_drvdata(pdev);
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 
-	if (timer_pending(&hisi_hba->timer))
-		del_timer(&hisi_hba->timer);
-
 	hisi_sas_kill_tasklets(hisi_hba);
 
 	return hisi_sas_remove(pdev);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index df5414a..efe64bc 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2183,6 +2183,9 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
 	struct Scsi_Host *shost = sha->core.shost;
 
+	if (timer_pending(&hisi_hba->timer))
+		del_timer(&hisi_hba->timer);
+
 	sas_unregister_ha(sha);
 	sas_remove_host(sha->core.shost);
 
-- 
1.9.1
