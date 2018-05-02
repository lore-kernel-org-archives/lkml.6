Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeEBP6u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:58:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54543 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751704AbeEBP53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:57:29 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 08/11] scsi: hisi_sas: config ATA de-reset as an constrained command for v3 hw
Date: Wed, 2 May 2018 23:56:31 +0800
Message-ID: <1525276594-92173-9-git-send-email-john.garry@huawei.com>
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

As a unconstrained command, a command can be sent to SATA
disk even if SATA disk status is BUSY, ERR or DRQ.

If an ATA reset assert is successful but ATA reset de-assert
fails, then it will retry the  reset de-assert. If reset de-
assert retry is successful, we think it is okay to probe the
device but actually it still has Err status.

Apparently we need to retry the ATA reset assertion and de-
assertion instead for this mentioned scenario.

As such, we config ATA reset assert as a constrained command,
if ATA reset de-assert fails, then ATA reset de-assert
retry will also fail. Then we will retry the proper process
of ATA reset assert and de-assert again.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index ffa3cea..026faee 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -351,10 +351,11 @@ struct hisi_sas_err_record_v3 {
 #define DIR_TO_DEVICE 2
 #define DIR_RESERVED 3
 
-#define CMD_IS_UNCONSTRAINT(cmd) \
-	((cmd == ATA_CMD_READ_LOG_EXT) || \
-	(cmd == ATA_CMD_READ_LOG_DMA_EXT) || \
-	(cmd == ATA_CMD_DEV_RESET))
+#define FIS_CMD_IS_UNCONSTRAINED(fis) \
+	((fis.command == ATA_CMD_READ_LOG_EXT) || \
+	(fis.command == ATA_CMD_READ_LOG_DMA_EXT) || \
+	((fis.command == ATA_CMD_DEV_RESET) && \
+	((fis.control & ATA_SRST) != 0)))
 
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
@@ -1075,7 +1076,7 @@ static int prep_ata_v3_hw(struct hisi_hba *hisi_hba,
 		<< CMD_HDR_FRAME_TYPE_OFF;
 	dw1 |= sas_dev->device_id << CMD_HDR_DEV_ID_OFF;
 
-	if (CMD_IS_UNCONSTRAINT(task->ata_task.fis.command))
+	if (FIS_CMD_IS_UNCONSTRAINED(task->ata_task.fis))
 		dw1 |= 1 << CMD_HDR_UNCON_CMD_OFF;
 
 	hdr->dw1 = cpu_to_le32(dw1);
-- 
1.9.1
