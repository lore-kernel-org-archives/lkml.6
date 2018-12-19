Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5EC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AC4217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeLSPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:55:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727799AbeLSPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:55:56 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BDAA1F0FA7C9;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5/8] scsi: hisi_sas: Add debugfs for port registers
Date:   Wed, 19 Dec 2018 23:56:43 +0800
Message-ID: <1545235006-151716-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
References: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

This patch create debugfs file for port register and add file operations.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 43 ++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index fd85934..fbd9b4a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2604,9 +2604,38 @@ static int hisi_sas_debugfs_global_open(struct inode *inode, struct file *filp)
 	.owner = THIS_MODULE,
 };
 
+static int hisi_sas_debugfs_port_show(struct seq_file *s, void *p)
+{
+	struct hisi_sas_phy *phy = s->private;
+	struct hisi_hba *hisi_hba = phy->hisi_hba;
+	const struct hisi_sas_hw *hw = hisi_hba->hw;
+	const struct hisi_sas_debugfs_reg *reg_port = hw->debugfs_reg_port;
+	u32 *databuf = hisi_hba->debugfs_port_reg[phy->sas_phy.id];
+
+	hisi_sas_debugfs_print_reg(databuf, reg_port, s);
+
+	return 0;
+}
+
+static int hisi_sas_debugfs_port_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, hisi_sas_debugfs_port_show, inode->i_private);
+}
+
+static const struct file_operations hisi_sas_debugfs_port_fops = {
+	.open = hisi_sas_debugfs_port_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.owner = THIS_MODULE,
+};
+
 static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 {
 	struct dentry *dump_dentry;
+	struct dentry *dentry;
+	char name[256];
+	int p;
 
 	/* Create dump dir inside device dir */
 	dump_dentry = debugfs_create_dir("dump", hisi_hba->debugfs_dir);
@@ -2618,6 +2647,20 @@ static void hisi_sas_debugfs_create_files(struct hisi_hba *hisi_hba)
 	if (!debugfs_create_file("global", 0400, dump_dentry, hisi_hba,
 				 &hisi_sas_debugfs_global_fops))
 		goto fail;
+
+	/* Create port dir and files */
+	dentry = debugfs_create_dir("port", dump_dentry);
+	if (!dentry)
+		goto fail;
+
+	for (p = 0; p < hisi_hba->n_phy; p++) {
+		snprintf(name, 256, "%d", p);
+		if (!debugfs_create_file(name, 0400, dentry,
+					 &hisi_hba->phy[p],
+					 &hisi_sas_debugfs_port_fops))
+			goto fail;
+	}
+
 	return;
 fail:
 	debugfs_remove_recursive(hisi_hba->debugfs_dir);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index ca3d13b..cda1e40 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -186,6 +186,7 @@
 #define CHL_INT0_MSK			(PORT_BASE + 0x1c0)
 #define CHL_INT1_MSK			(PORT_BASE + 0x1c4)
 #define CHL_INT2_MSK			(PORT_BASE + 0x1c8)
+#define SAS_EC_INT_COAL_TIME		(PORT_BASE + 0x1cc)
 #define CHL_INT_COAL_EN			(PORT_BASE + 0x1d0)
 #define SAS_RX_TRAIN_TIMER		(PORT_BASE + 0x2a4)
 #define PHY_CTRL_RDY_MSK		(PORT_BASE + 0x2b0)
@@ -205,6 +206,7 @@
 #define ERR_CNT_DWS_LOST		(PORT_BASE + 0x380)
 #define ERR_CNT_RESET_PROB		(PORT_BASE + 0x384)
 #define ERR_CNT_INVLD_DW		(PORT_BASE + 0x390)
+#define ERR_CNT_CODE_ERR		(PORT_BASE + 0x394)
 #define ERR_CNT_DISP_ERR		(PORT_BASE + 0x398)
 
 #define DEFAULT_ITCT_HW		2048 /* reset value, not reprogrammed */
@@ -2339,7 +2341,60 @@ static ssize_t intr_coal_count_v3_hw_store(struct device *dev,
 	NULL
 };
 
+static const struct hisi_sas_debugfs_reg_lu debugfs_port_reg_lu[] = {
+	HISI_SAS_DEBUGFS_REG(PHY_CFG),
+	HISI_SAS_DEBUGFS_REG(HARD_PHY_LINKRATE),
+	HISI_SAS_DEBUGFS_REG(PROG_PHY_LINK_RATE),
+	HISI_SAS_DEBUGFS_REG(PHY_CTRL),
+	HISI_SAS_DEBUGFS_REG(SL_CFG),
+	HISI_SAS_DEBUGFS_REG(AIP_LIMIT),
+	HISI_SAS_DEBUGFS_REG(SL_CONTROL),
+	HISI_SAS_DEBUGFS_REG(RX_PRIMS_STATUS),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD0),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD1),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD2),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD3),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD4),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD5),
+	HISI_SAS_DEBUGFS_REG(TX_ID_DWORD6),
+	HISI_SAS_DEBUGFS_REG(TXID_AUTO),
+	HISI_SAS_DEBUGFS_REG(RX_IDAF_DWORD0),
+	HISI_SAS_DEBUGFS_REG(RXOP_CHECK_CFG_H),
+	HISI_SAS_DEBUGFS_REG(STP_LINK_TIMER),
+	HISI_SAS_DEBUGFS_REG(STP_LINK_TIMEOUT_STATE),
+	HISI_SAS_DEBUGFS_REG(CON_CFG_DRIVER),
+	HISI_SAS_DEBUGFS_REG(SAS_SSP_CON_TIMER_CFG),
+	HISI_SAS_DEBUGFS_REG(SAS_SMP_CON_TIMER_CFG),
+	HISI_SAS_DEBUGFS_REG(SAS_STP_CON_TIMER_CFG),
+	HISI_SAS_DEBUGFS_REG(CHL_INT0),
+	HISI_SAS_DEBUGFS_REG(CHL_INT1),
+	HISI_SAS_DEBUGFS_REG(CHL_INT2),
+	HISI_SAS_DEBUGFS_REG(CHL_INT0_MSK),
+	HISI_SAS_DEBUGFS_REG(CHL_INT1_MSK),
+	HISI_SAS_DEBUGFS_REG(CHL_INT2_MSK),
+	HISI_SAS_DEBUGFS_REG(SAS_EC_INT_COAL_TIME),
+	HISI_SAS_DEBUGFS_REG(CHL_INT_COAL_EN),
+	HISI_SAS_DEBUGFS_REG(SAS_RX_TRAIN_TIMER),
+	HISI_SAS_DEBUGFS_REG(PHY_CTRL_RDY_MSK),
+	HISI_SAS_DEBUGFS_REG(PHYCTRL_NOT_RDY_MSK),
+	HISI_SAS_DEBUGFS_REG(PHYCTRL_DWS_RESET_MSK),
+	HISI_SAS_DEBUGFS_REG(PHYCTRL_PHY_ENA_MSK),
+	HISI_SAS_DEBUGFS_REG(SL_RX_BCAST_CHK_MSK),
+	HISI_SAS_DEBUGFS_REG(PHYCTRL_OOB_RESTART_MSK),
+	HISI_SAS_DEBUGFS_REG(DMA_TX_STATUS),
+	HISI_SAS_DEBUGFS_REG(DMA_RX_STATUS),
+	HISI_SAS_DEBUGFS_REG(COARSETUNE_TIME),
+	HISI_SAS_DEBUGFS_REG(ERR_CNT_DWS_LOST),
+	HISI_SAS_DEBUGFS_REG(ERR_CNT_RESET_PROB),
+	HISI_SAS_DEBUGFS_REG(ERR_CNT_INVLD_DW),
+	HISI_SAS_DEBUGFS_REG(ERR_CNT_CODE_ERR),
+	HISI_SAS_DEBUGFS_REG(ERR_CNT_DISP_ERR),
+	{}
+};
+
 static const struct hisi_sas_debugfs_reg debugfs_port_reg = {
+	.lu = debugfs_port_reg_lu,
+	.count = 0x100,
 	.base_off = PORT_BASE,
 	.read_port_reg = hisi_sas_phy_read32,
 };
-- 
1.9.1

