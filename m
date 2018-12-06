Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9B2C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86AE20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86AE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeLFNdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:33:37 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727685AbeLFNdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:33:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C66303CE7AFED;
        Thu,  6 Dec 2018 21:33:27 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 21:33:21 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v4 4/5] scsi: hisi_sas: Add support for DIF feature for v3 hw
Date:   Thu, 6 Dec 2018 21:34:43 +0800
Message-ID: <1544103284-100497-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
References: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

For v3 hw, we support DIF operation for SAS, but not SATA.

This patchset adds the SW support for the described features. The main
components are as follows:
- Get DIF enablement from module param
- Fill PI fields
- Fill related to DIF in DQ and protection iu memories

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |   2 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 122 ++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 912d234..5c780fe 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -268,6 +268,8 @@ struct hisi_hba {
 	struct pci_dev *pci_dev;
 	struct device *dev;
 
+	bool enable_dif;
+
 	void __iomem *regs;
 	void __iomem *sgpio_regs;
 	struct regmap *ctrl;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 44781e3..c707bb1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -127,6 +127,8 @@
 #define PHY_CTRL			(PORT_BASE + 0x14)
 #define PHY_CTRL_RESET_OFF		0
 #define PHY_CTRL_RESET_MSK		(0x1 << PHY_CTRL_RESET_OFF)
+#define CMD_HDR_PIR_OFF			8
+#define CMD_HDR_PIR_MSK			(0x1 << CMD_HDR_PIR_OFF)
 #define SL_CFG				(PORT_BASE + 0x84)
 #define AIP_LIMIT			(PORT_BASE + 0x90)
 #define SL_CONTROL			(PORT_BASE + 0x94)
@@ -333,6 +335,16 @@
 #define ITCT_HDR_RTOLT_OFF		48
 #define ITCT_HDR_RTOLT_MSK		(0xffffULL << ITCT_HDR_RTOLT_OFF)
 
+struct hisi_sas_protect_iu_v3_hw {
+	u32 dw0;
+	u32 lbrtcv;
+	u32 lbrtgv;
+	u32 dw3;
+	u32 dw4;
+	u32 dw5;
+	u32 rsv;
+};
+
 struct hisi_sas_complete_v3_hdr {
 	__le32 dw0;
 	__le32 dw1;
@@ -372,9 +384,27 @@ struct hisi_sas_err_record_v3 {
 	((fis.command == ATA_CMD_DEV_RESET) && \
 	((fis.control & ATA_SRST) != 0)))
 
+#define T10_INSRT_EN_OFF    0
+#define T10_INSRT_EN_MSK    (1 << T10_INSRT_EN_OFF)
+#define T10_RMV_EN_OFF	    1
+#define T10_RMV_EN_MSK	    (1 << T10_RMV_EN_OFF)
+#define T10_RPLC_EN_OFF	    2
+#define T10_RPLC_EN_MSK	    (1 << T10_RPLC_EN_OFF)
+#define T10_CHK_EN_OFF	    3
+#define T10_CHK_EN_MSK	    (1 << T10_CHK_EN_OFF)
+#define INCR_LBRT_OFF	    5
+#define INCR_LBRT_MSK	    (1 << INCR_LBRT_OFF)
+#define USR_DATA_BLOCK_SZ_OFF	20
+#define USR_DATA_BLOCK_SZ_MSK	(0x3 << USR_DATA_BLOCK_SZ_OFF)
+#define T10_CHK_MSK_OFF	    16
+
 static bool hisi_sas_intr_conv;
 MODULE_PARM_DESC(intr_conv, "interrupt converge enable (0-1)");
 
+static bool enable_dif;
+module_param(enable_dif, bool, 0444);
+MODULE_PARM_DESC(enable_dif, "DIF enable (0-1)");
+
 static u32 hisi_sas_read32(struct hisi_hba *hisi_hba, u32 off)
 {
 	void __iomem *regs = hisi_hba->regs + off;
@@ -941,6 +971,54 @@ static void prep_prd_sge_v3_hw(struct hisi_hba *hisi_hba,
 	hdr->sg_len = cpu_to_le32(n_elem << CMD_HDR_DATA_SGL_LEN_OFF);
 }
 
+static void fill_prot_v3_hw(struct scsi_cmnd *scsi_cmnd,
+			    struct hisi_sas_protect_iu_v3_hw *prot)
+{
+	u8 prot_type = scsi_get_prot_type(scsi_cmnd);
+	u8 prot_op = scsi_get_prot_op(scsi_cmnd);
+	unsigned int interval = scsi_prot_interval(scsi_cmnd);
+	u32 lbrt_chk_val;
+
+	if (interval == 4096)
+		lbrt_chk_val = (u32)(scsi_get_lba(scsi_cmnd) >> 3);
+	else
+		lbrt_chk_val = (u32)scsi_get_lba(scsi_cmnd);
+
+	switch (prot_op) {
+	case SCSI_PROT_READ_STRIP:
+		prot->dw0 |= (T10_RMV_EN_MSK | T10_CHK_EN_MSK);
+		prot->lbrtcv = lbrt_chk_val;
+		if (prot_type == SCSI_PROT_DIF_TYPE1)
+			prot->dw4 |= (0xc << 16);
+		else if (prot_type == SCSI_PROT_DIF_TYPE3)
+			prot->dw4 |= (0xfc << 16);
+		break;
+	case SCSI_PROT_WRITE_INSERT:
+		prot->dw0 |= T10_INSRT_EN_MSK;
+		prot->lbrtgv = lbrt_chk_val;
+		break;
+	default:
+		WARN_ONCE(1, "prot_op(0x%x) is not valid\n", prot_op);
+		break;
+	}
+
+	switch (interval) {
+	case 512:
+		break;
+	case 4096:
+		prot->dw0 |= (0x1 << USR_DATA_BLOCK_SZ_OFF);
+		break;
+	case 520:
+		prot->dw0 |= (0x2 << USR_DATA_BLOCK_SZ_OFF);
+		break;
+	default:
+		WARN_ONCE(1, "protection interval (0x%x) invalid\n", interval);
+		break;
+	}
+
+	prot->dw0 |= INCR_LBRT_MSK;
+}
+
 static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 			  struct hisi_sas_slot *slot)
 {
@@ -952,9 +1030,10 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 	struct sas_ssp_task *ssp_task = &task->ssp_task;
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
 	struct hisi_sas_tmf_task *tmf = slot->tmf;
+	unsigned char prot_op = scsi_get_prot_op(scsi_cmnd);
 	int has_data = 0, priority = !!tmf;
 	u8 *buf_cmd;
-	u32 dw1 = 0, dw2 = 0;
+	u32 dw1 = 0, dw2 = 0, len = 0;
 
 	hdr->dw0 = cpu_to_le32((1 << CMD_HDR_RESP_REPORT_OFF) |
 			       (2 << CMD_HDR_TLR_CTRL_OFF) |
@@ -984,7 +1063,6 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 
 	/* map itct entry */
 	dw1 |= sas_dev->device_id << CMD_HDR_DEV_ID_OFF;
-	hdr->dw1 = cpu_to_le32(dw1);
 
 	dw2 = (((sizeof(struct ssp_command_iu) + sizeof(struct ssp_frame_hdr)
 	      + 3) / 4) << CMD_HDR_CFL_OFF) |
@@ -997,7 +1075,6 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 		prep_prd_sge_v3_hw(hisi_hba, slot, hdr, task->scatter,
 					slot->n_elem);
 
-	hdr->data_transfer_len = cpu_to_le32(task->total_xfer_len);
 	hdr->cmd_table_addr = cpu_to_le64(hisi_sas_cmd_hdr_addr_dma(slot));
 	hdr->sts_buffer_addr = cpu_to_le64(hisi_sas_status_buf_addr_dma(slot));
 
@@ -1022,6 +1099,33 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 			break;
 		}
 	}
+
+	if (has_data && (prot_op != SCSI_PROT_NORMAL)) {
+		struct hisi_sas_protect_iu_v3_hw prot;
+		u8 *buf_cmd_prot;
+
+		hdr->dw7 |= cpu_to_le32(1 << CMD_HDR_ADDR_MODE_SEL_OFF);
+		dw1 |= CMD_HDR_PIR_MSK;
+		buf_cmd_prot = hisi_sas_cmd_hdr_addr_mem(slot) +
+			       sizeof(struct ssp_frame_hdr) +
+			       sizeof(struct ssp_command_iu);
+
+		memset(&prot, 0, sizeof(struct hisi_sas_protect_iu_v3_hw));
+		fill_prot_v3_hw(scsi_cmnd, &prot);
+		memcpy(buf_cmd_prot, &prot,
+		       sizeof(struct hisi_sas_protect_iu_v3_hw));
+
+		if (prot_op == SCSI_PROT_WRITE_INSERT) {
+			unsigned int interval = scsi_prot_interval(scsi_cmnd);
+			unsigned int ilog2_interval = ilog2(interval);
+
+			len = (task->total_xfer_len >> ilog2_interval) * 8;
+		}
+	}
+
+	hdr->dw1 = cpu_to_le32(dw1);
+
+	hdr->data_transfer_len = cpu_to_le32(task->total_xfer_len + len);
 }
 
 static void prep_smp_v3_hw(struct hisi_hba *hisi_hba,
@@ -2291,6 +2395,7 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	hisi_hba->dev = dev;
 	hisi_hba->shost = shost;
 	SHOST_TO_SAS_HA(shost) = &hisi_hba->sha;
+	hisi_hba->enable_dif = enable_dif;
 
 	timer_setup(&hisi_hba->timer, NULL, 0);
 
@@ -2319,6 +2424,7 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	struct asd_sas_port **arr_port;
 	struct sas_ha_struct *sha;
 	int rc, phy_nr, port_nr, i;
+	unsigned int prot;
 
 	rc = pci_enable_device(pdev);
 	if (rc)
@@ -2402,6 +2508,16 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	if (rc)
 		goto err_out_register_ha;
 
+	prot = 0;
+	if (hisi_hba->enable_dif) {
+		dev_info(dev, "Registering for DIF type 1/2/3 protection.\n");
+		prot |=	SHOST_DIF_TYPE1_PROTECTION |
+			SHOST_DIF_TYPE2_PROTECTION |
+			SHOST_DIF_TYPE3_PROTECTION;
+	}
+
+	scsi_host_set_prot(hisi_hba->shost, prot);
+
 	scsi_scan_host(shost);
 
 	return 0;
-- 
1.9.1

