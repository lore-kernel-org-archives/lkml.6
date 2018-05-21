Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeEUKO1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:14:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55781 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752291AbeEUKLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:11:41 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 07/13] scsi: hisi_sas: Init disks after controller reset
Date: Mon, 21 May 2018 18:09:19 +0800
Message-ID: <1526897365-228549-8-git-send-email-john.garry@huawei.com>
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

From: Xiaofei Tan <tanxiaofei@huawei.com>

After the controller is reset, it is possible that the
disks attached still have outstanding IO to complete.

Thus, when the PHYs come back up after controller reset, it
is possible that these IOs complete at some unknown point
later.

We want to ensure that all IOs are complete after the
controller reset so that all associated IPTT and other
resources can be recycled safely.

To achieve this, re-init the disks by TMF or softreset
(in case of ATA devices).

If the init fails - maybe because the device was removed
or link has not come up - then do not release the device
resources, but rather rely on SCSI EH to handle the timeout
for these resources later on.

This patch also does some cleanup to hisi_sas_init_disk(), including
removing superfluous cases in the switch statement.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 7b8623b..0dfefdf 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1259,6 +1259,23 @@ static void hisi_sas_rescan_topology(struct hisi_hba *hisi_hba, u32 old_state,
 	}
 }
 
+static void hisi_sas_reset_init_all_devices(struct hisi_hba *hisi_hba)
+{
+	struct hisi_sas_device *sas_dev;
+	struct domain_device *device;
+	int i;
+
+	for (i = 0; i < HISI_SAS_MAX_DEVICES; i++) {
+		sas_dev = &hisi_hba->devices[i];
+		device = sas_dev->sas_device;
+
+		if ((sas_dev->dev_type == SAS_PHY_UNUSED) || !device)
+			continue;
+
+		hisi_sas_init_device(device);
+	}
+}
+
 static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 {
 	struct device *dev = hisi_hba->dev;
@@ -1287,7 +1304,6 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 		scsi_unblock_requests(shost);
 		goto out;
 	}
-	hisi_sas_release_tasks(hisi_hba);
 
 	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 
@@ -1295,6 +1311,7 @@ static int hisi_sas_controller_reset(struct hisi_hba *hisi_hba)
 	hisi_hba->hw->phys_init(hisi_hba);
 	msleep(1000);
 	hisi_sas_refresh_port_id(hisi_hba);
+	hisi_sas_reset_init_all_devices(hisi_hba);
 	scsi_unblock_requests(shost);
 
 	state = hisi_hba->hw->get_phys_state(hisi_hba);
-- 
1.9.1
