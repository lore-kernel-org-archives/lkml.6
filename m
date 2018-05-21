Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeEUKOZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:14:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55756 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752257AbeEUKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:11:41 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 03/13] scsi: hisi_sas: Change common allocation mode of device id
Date: Mon, 21 May 2018 18:09:15 +0800
Message-ID: <1526897365-228549-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526897365-228549-1-git-send-email-john.garry@huawei.com>
References: <1526897365-228549-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

To reduce possibility of hitting unknown SoC bugs and aid
debugging and test, change allocation mode of device id from
last used device id instead of lowest available index.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      | 1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 3c88400..b4717bd 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -275,6 +275,7 @@ struct hisi_hba {
 
 	int slot_index_count;
 	int last_slot_index;
+	int last_dev_id;
 	unsigned long *slot_index_tags;
 	unsigned long reject_stp_links_msk;
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 1d300a2..04a3eb4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -596,10 +596,12 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 	struct hisi_hba *hisi_hba = dev_to_hisi_hba(device);
 	struct hisi_sas_device *sas_dev = NULL;
 	unsigned long flags;
+	int last = hisi_hba->last_dev_id;
+	int first = (hisi_hba->last_dev_id + 1) % HISI_SAS_MAX_DEVICES;
 	int i;
 
 	spin_lock_irqsave(&hisi_hba->lock, flags);
-	for (i = 0; i < HISI_SAS_MAX_DEVICES; i++) {
+	for (i = first; i != last; i %= HISI_SAS_MAX_DEVICES) {
 		if (hisi_hba->devices[i].dev_type == SAS_PHY_UNUSED) {
 			int queue = i % hisi_hba->queue_count;
 			struct hisi_sas_dq *dq = &hisi_hba->dq[queue];
@@ -614,7 +616,9 @@ static struct hisi_sas_device *hisi_sas_alloc_dev(struct domain_device *device)
 			INIT_LIST_HEAD(&hisi_hba->devices[i].list);
 			break;
 		}
+		i++;
 	}
+	hisi_hba->last_dev_id = i;
 	spin_unlock_irqrestore(&hisi_hba->lock, flags);
 
 	return sas_dev;
-- 
1.9.1
