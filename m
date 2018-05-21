Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeEUKMO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 06:12:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55809 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752668AbeEUKLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 06:11:47 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, Xiaofei Tan <tanxiaofei@huawei.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 10/13] scsi: hisi_sas: Add v2 hw force PHY function for internal ATA command
Date: Mon, 21 May 2018 18:09:22 +0800
Message-ID: <1526897365-228549-11-git-send-email-john.garry@huawei.com>
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

This patch adds an force PHY function for internal ATA command for
v2 hw.

Because there is an SoC bug of v2 hw, and need send an IO through
each PHY of a port to workaround a bug which occurs after a
controller reset.

This force PHY function will be used in the later patch.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  2 ++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 60bd652..9400824 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -180,6 +180,8 @@ struct hisi_sas_device {
 };
 
 struct hisi_sas_tmf_task {
+	int force_phy;
+	int phy_id;
 	u8 tmf;
 	u16 tag_of_task_to_be_managed;
 };
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index fafb3f1..369ef7e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -296,6 +296,10 @@
 #define CMD_HDR_RESP_REPORT_MSK		(0x1 << CMD_HDR_RESP_REPORT_OFF)
 #define CMD_HDR_TLR_CTRL_OFF		6
 #define CMD_HDR_TLR_CTRL_MSK		(0x3 << CMD_HDR_TLR_CTRL_OFF)
+#define CMD_HDR_PHY_ID_OFF		8
+#define CMD_HDR_PHY_ID_MSK		(0x1ff << CMD_HDR_PHY_ID_OFF)
+#define CMD_HDR_FORCE_PHY_OFF		17
+#define CMD_HDR_FORCE_PHY_MSK		(0x1 << CMD_HDR_FORCE_PHY_OFF)
 #define CMD_HDR_PORT_OFF		18
 #define CMD_HDR_PORT_MSK		(0xf << CMD_HDR_PORT_OFF)
 #define CMD_HDR_PRIORITY_OFF		27
@@ -2512,6 +2516,7 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	struct hisi_sas_cmd_hdr *hdr = slot->cmd_hdr;
 	struct asd_sas_port *sas_port = device->port;
 	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
+	struct hisi_sas_tmf_task *tmf = slot->tmf;
 	u8 *buf_cmd;
 	int has_data = 0, hdr_tag = 0;
 	u32 dw1 = 0, dw2 = 0;
@@ -2524,6 +2529,12 @@ static void prep_ata_v2_hw(struct hisi_hba *hisi_hba,
 	else
 		hdr->dw0 |= cpu_to_le32(4 << CMD_HDR_CMD_OFF);
 
+	if (tmf && tmf->force_phy) {
+		hdr->dw0 |= CMD_HDR_FORCE_PHY_MSK;
+		hdr->dw0 |= cpu_to_le32((1 << tmf->phy_id)
+				<< CMD_HDR_PHY_ID_OFF);
+	}
+
 	/* dw1 */
 	switch (task->data_dir) {
 	case DMA_TO_DEVICE:
-- 
1.9.1
