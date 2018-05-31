Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbeEaMw0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:52:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38674 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754918AbeEaMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:52:19 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 3/9] scsi: hisi_sas: Fix the conflict between dev gone and host reset
Date: Thu, 31 May 2018 20:50:44 +0800
Message-ID: <1527771050-200916-4-git-send-email-john.garry@huawei.com>
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

From: Xiaofei Tan <tanxiaofei@huawei.com>

There is a possible conflict when a device is removed and host reset
occurs concurrently.

The reason is that then the device is notified as gone, we try to clear
the ITCT, which is notified via an interrupt. The dev gone function pends
on this event with a completion, which is completed when the ITCT
interrupt occurs.

But host reset will disable all interrupts, the wait_for_completion() may
wait indefinitely.

This patch adds an semaphore to synchronise this two processes. The
semaphore is taken by the host reset as the basis of synchronising.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      | 1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 7052a5d..78e5a92 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -277,6 +277,7 @@ struct hisi_hba {
 
 	int n_phy;
 	spinlock_t lock;
+	struct semaphore sem;
 
 	struct timer_list timer;
 	struct workqueue_struct *wq;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 1c424bb..823386f 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -914,7 +914,9 @@ static void hisi_sas_dev_gone(struct domain_device *device)
 
 		hisi_sas_dereg_device(hisi_hba, device);
 
+		down(&hisi_hba->sem);
 		hisi_hba->hw->clear_itct(hisi_hba, sas_dev);
+		up(&hisi_hba->sem);
 		device->lldd_dev = NULL;
 	}
 
@@ -1364,6 +1366,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
 		return -1;
 
+	down(&hisi_hba->sem);
 	dev_info(dev, "controller resetting...\n");
 	old_state = hisi_hba->hw->get_phys_state(hisi_hba);
 
@@ -1378,6 +1381,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	if (rc) {
 		dev_warn(dev, "controller reset failed (%d)\n", rc);
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+		up(&hisi_hba->sem);
 		scsi_unblock_requests(shost);
 		goto out;
 	}
@@ -1388,6 +1392,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	hisi_hba->hw->phys_init(hisi_hba);
 	msleep(1000);
 	hisi_sas_refresh_port_id(hisi_hba);
+	up(&hisi_hba->sem);
 
 	if (hisi_hba->reject_stp_links_msk)
 		hisi_sas_terminate_stp_reject(hisi_hba);
@@ -2016,6 +2021,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct Scsi_Host *shost)
 	struct device *dev = hisi_hba->dev;
 	int i, s, max_command_entries = hisi_hba->hw->max_command_entries;
 
+	sema_init(&hisi_hba->sem, 1);
 	spin_lock_init(&hisi_hba->lock);
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		hisi_sas_phy_init(hisi_hba, i);
-- 
1.9.1
