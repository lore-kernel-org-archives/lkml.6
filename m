Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F0820989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F0820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeK3Drx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:47:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbeK3Drw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:47:52 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0F73F6FDD40FB;
        Fri, 30 Nov 2018 00:41:51 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Fri, 30 Nov 2018 00:41:46 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 2/2] net: hns3: Adds support to dump(using ethool-d) PCIe regs in HNS3 PF driver
Date:   Thu, 29 Nov 2018 16:40:59 +0000
Message-ID: <20181129164059.25580-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181129164059.25580-1-salil.mehta@huawei.com>
References: <20181129164059.25580-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

This patch adds support to dump PF PCIe registers using ethtool -d
for HNS3 PF Driver.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 120 ++++++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  56 ++++++++++
 2 files changed, 171 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1c8cf84..8432c84 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -48,6 +48,62 @@ static const struct pci_device_id ae_algo_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, ae_algo_pci_tbl);
 
+static const u32 cmdq_reg_addr_list[] = {HCLGE_CMDQ_TX_ADDR_L_REG,
+					 HCLGE_CMDQ_TX_ADDR_H_REG,
+					 HCLGE_CMDQ_TX_DEPTH_REG,
+					 HCLGE_CMDQ_TX_TAIL_REG,
+					 HCLGE_CMDQ_TX_HEAD_REG,
+					 HCLGE_CMDQ_RX_ADDR_L_REG,
+					 HCLGE_CMDQ_RX_ADDR_H_REG,
+					 HCLGE_CMDQ_RX_DEPTH_REG,
+					 HCLGE_CMDQ_RX_TAIL_REG,
+					 HCLGE_CMDQ_RX_HEAD_REG,
+					 HCLGE_VECTOR0_CMDQ_SRC_REG,
+					 HCLGE_CMDQ_INTR_STS_REG,
+					 HCLGE_CMDQ_INTR_EN_REG,
+					 HCLGE_CMDQ_INTR_GEN_REG};
+
+static const u32 common_reg_addr_list[] = {HCLGE_MISC_VECTOR_REG_BASE,
+					   HCLGE_VECTOR0_OTER_EN_REG,
+					   HCLGE_MISC_RESET_STS_REG,
+					   HCLGE_MISC_VECTOR_INT_STS,
+					   HCLGE_GLOBAL_RESET_REG,
+					   HCLGE_FUN_RST_ING,
+					   HCLGE_GRO_EN_REG};
+
+static const u32 ring_reg_addr_list[] = {HCLGE_RING_RX_ADDR_L_REG,
+					 HCLGE_RING_RX_ADDR_H_REG,
+					 HCLGE_RING_RX_BD_NUM_REG,
+					 HCLGE_RING_RX_BD_LENGTH_REG,
+					 HCLGE_RING_RX_MERGE_EN_REG,
+					 HCLGE_RING_RX_TAIL_REG,
+					 HCLGE_RING_RX_HEAD_REG,
+					 HCLGE_RING_RX_FBD_NUM_REG,
+					 HCLGE_RING_RX_OFFSET_REG,
+					 HCLGE_RING_RX_FBD_OFFSET_REG,
+					 HCLGE_RING_RX_STASH_REG,
+					 HCLGE_RING_RX_BD_ERR_REG,
+					 HCLGE_RING_TX_ADDR_L_REG,
+					 HCLGE_RING_TX_ADDR_H_REG,
+					 HCLGE_RING_TX_BD_NUM_REG,
+					 HCLGE_RING_TX_PRIORITY_REG,
+					 HCLGE_RING_TX_TC_REG,
+					 HCLGE_RING_TX_MERGE_EN_REG,
+					 HCLGE_RING_TX_TAIL_REG,
+					 HCLGE_RING_TX_HEAD_REG,
+					 HCLGE_RING_TX_FBD_NUM_REG,
+					 HCLGE_RING_TX_OFFSET_REG,
+					 HCLGE_RING_TX_EBD_NUM_REG,
+					 HCLGE_RING_TX_EBD_OFFSET_REG,
+					 HCLGE_RING_TX_BD_ERR_REG,
+					 HCLGE_RING_EN_REG};
+
+static const u32 tqp_intr_reg_addr_list[] = {HCLGE_TQP_INTR_CTRL_REG,
+					     HCLGE_TQP_INTR_GL0_REG,
+					     HCLGE_TQP_INTR_GL1_REG,
+					     HCLGE_TQP_INTR_GL2_REG,
+					     HCLGE_TQP_INTR_RL_REG};
+
 static const char hns3_nic_test_strs[][ETH_GSTRING_LEN] = {
 	"App    Loopback test",
 	"Serdes serial Loopback test",
@@ -7637,8 +7693,15 @@ static int hclge_get_64_bit_regs(struct hclge_dev *hdev, u32 regs_num,
 	return 0;
 }
 
+#define MAX_SEPARATE_NUM	4
+#define SEPARATOR_VALUE		0xFFFFFFFF
+#define REG_NUM_PER_LINE	4
+#define REG_LEN_PER_LINE	(REG_NUM_PER_LINE * sizeof(u32))
+
 static int hclge_get_regs_len(struct hnae3_handle *handle)
 {
+	int cmdq_lines, common_lines, ring_lines, tqp_intr_lines;
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	u32 regs_num_32_bit, regs_num_64_bit;
@@ -7651,15 +7714,25 @@ static int hclge_get_regs_len(struct hnae3_handle *handle)
 		return -EOPNOTSUPP;
 	}
 
-	return regs_num_32_bit * sizeof(u32) + regs_num_64_bit * sizeof(u64);
+	cmdq_lines = sizeof(cmdq_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	common_lines = sizeof(common_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	ring_lines = sizeof(ring_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	tqp_intr_lines = sizeof(tqp_intr_reg_addr_list) / REG_LEN_PER_LINE + 1;
+
+	return (cmdq_lines + common_lines + ring_lines * kinfo->num_tqps +
+		tqp_intr_lines * (hdev->num_msi_used - 1)) * REG_LEN_PER_LINE +
+		regs_num_32_bit * sizeof(u32) + regs_num_64_bit * sizeof(u64);
 }
 
 static void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
 			   void *data)
 {
+	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 	u32 regs_num_32_bit, regs_num_64_bit;
+	int i, j, reg_um, separator_num;
+	u32 *reg = data;
 	int ret;
 
 	*version = hdev->fw_version;
@@ -7671,16 +7744,53 @@ static void hclge_get_regs(struct hnae3_handle *handle, u32 *version,
 		return;
 	}
 
-	ret = hclge_get_32_bit_regs(hdev, regs_num_32_bit, data);
+	/* fetching per-PF registers valus from PF PCIe register space */
+	reg_um = sizeof(cmdq_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (i = 0; i < reg_um; i++)
+		*reg++ = hclge_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
+	for (i = 0; i < separator_num; i++)
+		*reg++ = SEPARATOR_VALUE;
+
+	reg_um = sizeof(common_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (i = 0; i < reg_um; i++)
+		*reg++ = hclge_read_dev(&hdev->hw, common_reg_addr_list[i]);
+	for (i = 0; i < separator_num; i++)
+		*reg++ = SEPARATOR_VALUE;
+
+	reg_um = sizeof(ring_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (j = 0; j < kinfo->num_tqps; j++) {
+		for (i = 0; i < reg_um; i++)
+			*reg++ = hclge_read_dev(&hdev->hw,
+						ring_reg_addr_list[i] +
+						0x200 * j);
+		for (i = 0; i < separator_num; i++)
+			*reg++ = SEPARATOR_VALUE;
+	}
+
+	reg_um = sizeof(tqp_intr_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (j = 0; j < hdev->num_msi_used - 1; j++) {
+		for (i = 0; i < reg_um; i++)
+			*reg++ = hclge_read_dev(&hdev->hw,
+						tqp_intr_reg_addr_list[i] +
+						4 * j);
+		for (i = 0; i < separator_num; i++)
+			*reg++ = SEPARATOR_VALUE;
+	}
+
+	/* fetching PF common registers values from firmware */
+	ret = hclge_get_32_bit_regs(hdev, regs_num_32_bit, reg);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"Get 32 bit register failed, ret = %d.\n", ret);
 		return;
 	}
 
-	data = (u32 *)data + regs_num_32_bit;
-	ret = hclge_get_64_bit_regs(hdev, regs_num_64_bit,
-				    data);
+	reg += regs_num_32_bit;
+	ret = hclge_get_64_bit_regs(hdev, regs_num_64_bit, reg);
 	if (ret)
 		dev_err(&hdev->pdev->dev,
 			"Get 64 bit register failed, ret = %d.\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 0dd23a1..ee60242 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -28,6 +28,62 @@
 #define HCLGE_VECTOR_REG_OFFSET		0x4
 #define HCLGE_VECTOR_VF_OFFSET		0x100000
 
+#define HCLGE_CMDQ_TX_ADDR_L_REG	0x27000
+#define HCLGE_CMDQ_TX_ADDR_H_REG	0x27004
+#define HCLGE_CMDQ_TX_DEPTH_REG		0x27008
+#define HCLGE_CMDQ_TX_TAIL_REG		0x27010
+#define HCLGE_CMDQ_TX_HEAD_REG		0x27014
+#define HCLGE_CMDQ_RX_ADDR_L_REG	0x27018
+#define HCLGE_CMDQ_RX_ADDR_H_REG	0x2701C
+#define HCLGE_CMDQ_RX_DEPTH_REG		0x27020
+#define HCLGE_CMDQ_RX_TAIL_REG		0x27024
+#define HCLGE_CMDQ_RX_HEAD_REG		0x27028
+#define HCLGE_CMDQ_INTR_SRC_REG		0x27100
+#define HCLGE_CMDQ_INTR_STS_REG		0x27104
+#define HCLGE_CMDQ_INTR_EN_REG		0x27108
+#define HCLGE_CMDQ_INTR_GEN_REG		0x2710C
+
+/* bar registers for common func */
+#define HCLGE_VECTOR0_OTER_EN_REG	0x20600
+#define HCLGE_RAS_OTHER_STS_REG		0x20B00
+#define HCLGE_FUNC_RESET_STS_REG	0x20C00
+#define HCLGE_GRO_EN_REG		0x28000
+
+/* bar registers for rcb */
+#define HCLGE_RING_RX_ADDR_L_REG	0x80000
+#define HCLGE_RING_RX_ADDR_H_REG	0x80004
+#define HCLGE_RING_RX_BD_NUM_REG	0x80008
+#define HCLGE_RING_RX_BD_LENGTH_REG	0x8000C
+#define HCLGE_RING_RX_MERGE_EN_REG	0x80014
+#define HCLGE_RING_RX_TAIL_REG		0x80018
+#define HCLGE_RING_RX_HEAD_REG		0x8001C
+#define HCLGE_RING_RX_FBD_NUM_REG	0x80020
+#define HCLGE_RING_RX_OFFSET_REG	0x80024
+#define HCLGE_RING_RX_FBD_OFFSET_REG	0x80028
+#define HCLGE_RING_RX_STASH_REG		0x80030
+#define HCLGE_RING_RX_BD_ERR_REG	0x80034
+#define HCLGE_RING_TX_ADDR_L_REG	0x80040
+#define HCLGE_RING_TX_ADDR_H_REG	0x80044
+#define HCLGE_RING_TX_BD_NUM_REG	0x80048
+#define HCLGE_RING_TX_PRIORITY_REG	0x8004C
+#define HCLGE_RING_TX_TC_REG		0x80050
+#define HCLGE_RING_TX_MERGE_EN_REG	0x80054
+#define HCLGE_RING_TX_TAIL_REG		0x80058
+#define HCLGE_RING_TX_HEAD_REG		0x8005C
+#define HCLGE_RING_TX_FBD_NUM_REG	0x80060
+#define HCLGE_RING_TX_OFFSET_REG	0x80064
+#define HCLGE_RING_TX_EBD_NUM_REG	0x80068
+#define HCLGE_RING_TX_EBD_OFFSET_REG	0x80070
+#define HCLGE_RING_TX_BD_ERR_REG	0x80074
+#define HCLGE_RING_EN_REG		0x80090
+
+/* bar registers for tqp interrupt */
+#define HCLGE_TQP_INTR_CTRL_REG		0x20000
+#define HCLGE_TQP_INTR_GL0_REG		0x20100
+#define HCLGE_TQP_INTR_GL1_REG		0x20200
+#define HCLGE_TQP_INTR_GL2_REG		0x20300
+#define HCLGE_TQP_INTR_RL_REG		0x20900
+
 #define HCLGE_RSS_IND_TBL_SIZE		512
 #define HCLGE_RSS_SET_BITMAP_MSK	GENMASK(15, 0)
 #define HCLGE_RSS_KEY_SIZE		40
-- 
2.7.4


