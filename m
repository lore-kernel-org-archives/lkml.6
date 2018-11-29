Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03C220989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03C220989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeK3Dr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:47:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729639AbeK3Dr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:47:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 15602F8776693;
        Fri, 30 Nov 2018 00:41:51 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Fri, 30 Nov 2018 00:41:43 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 1/2] net: hns3: Support "ethtool -d" for HNS3 VF driver
Date:   Thu, 29 Nov 2018 16:40:58 +0000
Message-ID: <20181129164059.25580-2-salil.mehta@huawei.com>
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

This patch adds "ethtool -d" support for HNS3 VF Driver.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 120 +++++++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  54 ++++++++++
 2 files changed, 174 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index efec1b7..417e078 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -23,6 +23,58 @@ static const struct pci_device_id ae_algovf_pci_tbl[] = {
 
 MODULE_DEVICE_TABLE(pci, ae_algovf_pci_tbl);
 
+static const u32 cmdq_reg_addr_list[] = {HCLGEVF_CMDQ_TX_ADDR_L_REG,
+					 HCLGEVF_CMDQ_TX_ADDR_H_REG,
+					 HCLGEVF_CMDQ_TX_DEPTH_REG,
+					 HCLGEVF_CMDQ_TX_TAIL_REG,
+					 HCLGEVF_CMDQ_TX_HEAD_REG,
+					 HCLGEVF_CMDQ_RX_ADDR_L_REG,
+					 HCLGEVF_CMDQ_RX_ADDR_H_REG,
+					 HCLGEVF_CMDQ_RX_DEPTH_REG,
+					 HCLGEVF_CMDQ_RX_TAIL_REG,
+					 HCLGEVF_CMDQ_RX_HEAD_REG,
+					 HCLGEVF_VECTOR0_CMDQ_SRC_REG,
+					 HCLGEVF_CMDQ_INTR_STS_REG,
+					 HCLGEVF_CMDQ_INTR_EN_REG,
+					 HCLGEVF_CMDQ_INTR_GEN_REG};
+
+static const u32 common_reg_addr_list[] = {HCLGEVF_MISC_VECTOR_REG_BASE,
+					   HCLGEVF_RST_ING,
+					   HCLGEVF_GRO_EN_REG};
+
+static const u32 ring_reg_addr_list[] = {HCLGEVF_RING_RX_ADDR_L_REG,
+					 HCLGEVF_RING_RX_ADDR_H_REG,
+					 HCLGEVF_RING_RX_BD_NUM_REG,
+					 HCLGEVF_RING_RX_BD_LENGTH_REG,
+					 HCLGEVF_RING_RX_MERGE_EN_REG,
+					 HCLGEVF_RING_RX_TAIL_REG,
+					 HCLGEVF_RING_RX_HEAD_REG,
+					 HCLGEVF_RING_RX_FBD_NUM_REG,
+					 HCLGEVF_RING_RX_OFFSET_REG,
+					 HCLGEVF_RING_RX_FBD_OFFSET_REG,
+					 HCLGEVF_RING_RX_STASH_REG,
+					 HCLGEVF_RING_RX_BD_ERR_REG,
+					 HCLGEVF_RING_TX_ADDR_L_REG,
+					 HCLGEVF_RING_TX_ADDR_H_REG,
+					 HCLGEVF_RING_TX_BD_NUM_REG,
+					 HCLGEVF_RING_TX_PRIORITY_REG,
+					 HCLGEVF_RING_TX_TC_REG,
+					 HCLGEVF_RING_TX_MERGE_EN_REG,
+					 HCLGEVF_RING_TX_TAIL_REG,
+					 HCLGEVF_RING_TX_HEAD_REG,
+					 HCLGEVF_RING_TX_FBD_NUM_REG,
+					 HCLGEVF_RING_TX_OFFSET_REG,
+					 HCLGEVF_RING_TX_EBD_NUM_REG,
+					 HCLGEVF_RING_TX_EBD_OFFSET_REG,
+					 HCLGEVF_RING_TX_BD_ERR_REG,
+					 HCLGEVF_RING_EN_REG};
+
+static const u32 tqp_intr_reg_addr_list[] = {HCLGEVF_TQP_INTR_CTRL_REG,
+					     HCLGEVF_TQP_INTR_GL0_REG,
+					     HCLGEVF_TQP_INTR_GL1_REG,
+					     HCLGEVF_TQP_INTR_GL2_REG,
+					     HCLGEVF_TQP_INTR_RL_REG};
+
 static inline struct hclgevf_dev *hclgevf_ae_get_hdev(
 	struct hnae3_handle *handle)
 {
@@ -2473,6 +2525,72 @@ static unsigned long hclgevf_ae_dev_reset_cnt(struct hnae3_handle *handle)
 	return hdev->reset_count;
 }
 
+#define MAX_SEPARATE_NUM	4
+#define SEPARATOR_VALUE		0xFFFFFFFF
+#define REG_NUM_PER_LINE	4
+#define REG_LEN_PER_LINE	(REG_NUM_PER_LINE * sizeof(u32))
+
+static int hclgevf_get_regs_len(struct hnae3_handle *handle)
+{
+	int cmdq_lines, common_lines, ring_lines, tqp_intr_lines;
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+
+	cmdq_lines = sizeof(cmdq_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	common_lines = sizeof(common_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	ring_lines = sizeof(ring_reg_addr_list) / REG_LEN_PER_LINE + 1;
+	tqp_intr_lines = sizeof(tqp_intr_reg_addr_list) / REG_LEN_PER_LINE + 1;
+
+	return (cmdq_lines + common_lines + ring_lines * hdev->num_tqps +
+		tqp_intr_lines * (hdev->num_msi_used - 1)) * REG_LEN_PER_LINE;
+}
+
+static void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
+			     void *data)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int i, j, reg_um, separator_num;
+	u32 *reg = data;
+
+	*version = hdev->fw_version;
+
+	/* fetching per-VF registers values from VF PCIe register space */
+	reg_um = sizeof(cmdq_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (i = 0; i < reg_um; i++)
+		*reg++ = hclgevf_read_dev(&hdev->hw, cmdq_reg_addr_list[i]);
+	for (i = 0; i < separator_num; i++)
+		*reg++ = SEPARATOR_VALUE;
+
+	reg_um = sizeof(common_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (i = 0; i < reg_um; i++)
+		*reg++ = hclgevf_read_dev(&hdev->hw, common_reg_addr_list[i]);
+	for (i = 0; i < separator_num; i++)
+		*reg++ = SEPARATOR_VALUE;
+
+	reg_um = sizeof(ring_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (j = 0; j < hdev->num_tqps; j++) {
+		for (i = 0; i < reg_um; i++)
+			*reg++ = hclgevf_read_dev(&hdev->hw,
+						  ring_reg_addr_list[i] +
+						  0x200 * j);
+		for (i = 0; i < separator_num; i++)
+			*reg++ = SEPARATOR_VALUE;
+	}
+
+	reg_um = sizeof(tqp_intr_reg_addr_list) / sizeof(u32);
+	separator_num = MAX_SEPARATE_NUM - reg_um % REG_NUM_PER_LINE;
+	for (j = 0; j < hdev->num_msi_used - 1; j++) {
+		for (i = 0; i < reg_um; i++)
+			*reg++ = hclgevf_read_dev(&hdev->hw,
+						  tqp_intr_reg_addr_list[i] +
+						  4 * j);
+		for (i = 0; i < separator_num; i++)
+			*reg++ = SEPARATOR_VALUE;
+	}
+}
+
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
@@ -2514,6 +2632,8 @@ static const struct hnae3_ae_ops hclgevf_ops = {
 	.set_default_reset_request = hclgevf_set_def_reset_request,
 	.get_channels = hclgevf_get_channels,
 	.get_tqps_and_rss_info = hclgevf_get_tqps_and_rss_info,
+	.get_regs_len = hclgevf_get_regs_len,
+	.get_regs = hclgevf_get_regs,
 	.get_status = hclgevf_get_status,
 	.get_ksettings_an_result = hclgevf_get_ksettings_an_result,
 	.get_media_type = hclgevf_get_media_type,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 4517b7e..787bc06 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -27,6 +27,60 @@
 #define HCLGEVF_VECTOR_REG_OFFSET	0x4
 #define HCLGEVF_VECTOR_VF_OFFSET		0x100000
 
+/* bar registers for cmdq */
+#define HCLGEVF_CMDQ_TX_ADDR_L_REG		0x27000
+#define HCLGEVF_CMDQ_TX_ADDR_H_REG		0x27004
+#define HCLGEVF_CMDQ_TX_DEPTH_REG		0x27008
+#define HCLGEVF_CMDQ_TX_TAIL_REG		0x27010
+#define HCLGEVF_CMDQ_TX_HEAD_REG		0x27014
+#define HCLGEVF_CMDQ_RX_ADDR_L_REG		0x27018
+#define HCLGEVF_CMDQ_RX_ADDR_H_REG		0x2701C
+#define HCLGEVF_CMDQ_RX_DEPTH_REG		0x27020
+#define HCLGEVF_CMDQ_RX_TAIL_REG		0x27024
+#define HCLGEVF_CMDQ_RX_HEAD_REG		0x27028
+#define HCLGEVF_CMDQ_INTR_SRC_REG		0x27100
+#define HCLGEVF_CMDQ_INTR_STS_REG		0x27104
+#define HCLGEVF_CMDQ_INTR_EN_REG		0x27108
+#define HCLGEVF_CMDQ_INTR_GEN_REG		0x2710C
+
+/* bar registers for common func */
+#define HCLGEVF_GRO_EN_REG			0x28000
+
+/* bar registers for rcb */
+#define HCLGEVF_RING_RX_ADDR_L_REG		0x80000
+#define HCLGEVF_RING_RX_ADDR_H_REG		0x80004
+#define HCLGEVF_RING_RX_BD_NUM_REG		0x80008
+#define HCLGEVF_RING_RX_BD_LENGTH_REG		0x8000C
+#define HCLGEVF_RING_RX_MERGE_EN_REG		0x80014
+#define HCLGEVF_RING_RX_TAIL_REG		0x80018
+#define HCLGEVF_RING_RX_HEAD_REG		0x8001C
+#define HCLGEVF_RING_RX_FBD_NUM_REG		0x80020
+#define HCLGEVF_RING_RX_OFFSET_REG		0x80024
+#define HCLGEVF_RING_RX_FBD_OFFSET_REG		0x80028
+#define HCLGEVF_RING_RX_STASH_REG		0x80030
+#define HCLGEVF_RING_RX_BD_ERR_REG		0x80034
+#define HCLGEVF_RING_TX_ADDR_L_REG		0x80040
+#define HCLGEVF_RING_TX_ADDR_H_REG		0x80044
+#define HCLGEVF_RING_TX_BD_NUM_REG		0x80048
+#define HCLGEVF_RING_TX_PRIORITY_REG		0x8004C
+#define HCLGEVF_RING_TX_TC_REG			0x80050
+#define HCLGEVF_RING_TX_MERGE_EN_REG		0x80054
+#define HCLGEVF_RING_TX_TAIL_REG		0x80058
+#define HCLGEVF_RING_TX_HEAD_REG		0x8005C
+#define HCLGEVF_RING_TX_FBD_NUM_REG		0x80060
+#define HCLGEVF_RING_TX_OFFSET_REG		0x80064
+#define HCLGEVF_RING_TX_EBD_NUM_REG		0x80068
+#define HCLGEVF_RING_TX_EBD_OFFSET_REG		0x80070
+#define HCLGEVF_RING_TX_BD_ERR_REG		0x80074
+#define HCLGEVF_RING_EN_REG			0x80090
+
+/* bar registers for tqp interrupt */
+#define HCLGEVF_TQP_INTR_CTRL_REG		0x20000
+#define HCLGEVF_TQP_INTR_GL0_REG		0x20100
+#define HCLGEVF_TQP_INTR_GL1_REG		0x20200
+#define HCLGEVF_TQP_INTR_GL2_REG		0x20300
+#define HCLGEVF_TQP_INTR_RL_REG			0x20900
+
 /* Vector0 interrupt CMDQ event source register(RW) */
 #define HCLGEVF_VECTOR0_CMDQ_SRC_REG	0x27100
 /* CMDQ register bits for RX event(=MBX event) */
-- 
2.7.4


