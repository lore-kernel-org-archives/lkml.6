Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62965C65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27B2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B27B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeLGVKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:10:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbeLGVJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:53 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A230EE79086DE;
        Sat,  8 Dec 2018 05:09:49 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:44 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 12/14] net: hns3: handle hw errors of PPU(RCB)
Date:   Fri, 7 Dec 2018 21:08:09 +0000
Message-ID: <20181207210811.23844-13-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch enables and handles hw RAS and MSIx errors of PPU(RCB).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 162 +++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  15 ++
 3 files changed, 180 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 46af567..0223e83 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -217,6 +217,9 @@ enum hclge_opcode_type {
 	/* Error INT commands */
 	HCLGE_MAC_COMMON_INT_EN		= 0x030E,
 	HCLGE_TM_SCH_ECC_INT_EN		= 0x0829,
+	HCLGE_PPU_MPF_ECC_INT_CMD	= 0x0B40,
+	HCLGE_PPU_MPF_OTHER_INT_CMD	= 0x0B41,
+	HCLGE_PPU_PF_OTHER_INT_CMD	= 0x0B42,
 	HCLGE_COMMON_ECC_INT_CFG	= 0x1505,
 	HCLGE_QUERY_RAS_INT_STS_BD_NUM	= 0x1510,
 	HCLGE_QUERY_CLEAR_MPF_RAS_INT	= 0x1511,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index e82ef4f..00086ce 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -222,6 +222,47 @@ static const struct hclge_hw_error hclge_mac_afifo_tnl_int[] = {
 	{ /* sentinel */ }
 };
 
+static const struct hclge_hw_error hclge_ppu_mpf_abnormal_int_st2[] = {
+	{ .int_msk = BIT(13), .msg = "rpu_rx_pkt_bit32_ecc_mbit_err" },
+	{ .int_msk = BIT(14), .msg = "rpu_rx_pkt_bit33_ecc_mbit_err" },
+	{ .int_msk = BIT(15), .msg = "rpu_rx_pkt_bit34_ecc_mbit_err" },
+	{ .int_msk = BIT(16), .msg = "rpu_rx_pkt_bit35_ecc_mbit_err" },
+	{ .int_msk = BIT(17), .msg = "rcb_tx_ring_ecc_mbit_err" },
+	{ .int_msk = BIT(18), .msg = "rcb_rx_ring_ecc_mbit_err" },
+	{ .int_msk = BIT(19), .msg = "rcb_tx_fbd_ecc_mbit_err" },
+	{ .int_msk = BIT(20), .msg = "rcb_rx_ebd_ecc_mbit_err" },
+	{ .int_msk = BIT(21), .msg = "rcb_tso_info_ecc_mbit_err" },
+	{ .int_msk = BIT(22), .msg = "rcb_tx_int_info_ecc_mbit_err" },
+	{ .int_msk = BIT(23), .msg = "rcb_rx_int_info_ecc_mbit_err" },
+	{ .int_msk = BIT(24), .msg = "tpu_tx_pkt_0_ecc_mbit_err" },
+	{ .int_msk = BIT(25), .msg = "tpu_tx_pkt_1_ecc_mbit_err" },
+	{ .int_msk = BIT(26), .msg = "rd_bus_err" },
+	{ .int_msk = BIT(27), .msg = "wr_bus_err" },
+	{ .int_msk = BIT(28), .msg = "reg_search_miss" },
+	{ .int_msk = BIT(29), .msg = "rx_q_search_miss" },
+	{ .int_msk = BIT(30), .msg = "ooo_ecc_err_detect" },
+	{ .int_msk = BIT(31), .msg = "ooo_ecc_err_multpl" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ppu_mpf_abnormal_int_st3[] = {
+	{ .int_msk = BIT(4), .msg = "gro_bd_ecc_mbit_err" },
+	{ .int_msk = BIT(5), .msg = "gro_context_ecc_mbit_err" },
+	{ .int_msk = BIT(6), .msg = "rx_stash_cfg_ecc_mbit_err" },
+	{ .int_msk = BIT(7), .msg = "axi_rd_fbd_ecc_mbit_err" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ppu_pf_abnormal_int[] = {
+	{ .int_msk = BIT(0), .msg = "over_8bd_no_fe" },
+	{ .int_msk = BIT(1), .msg = "tso_mss_cmp_min_err" },
+	{ .int_msk = BIT(2), .msg = "tso_mss_cmp_max_err" },
+	{ .int_msk = BIT(3), .msg = "tx_rd_fbd_poison" },
+	{ .int_msk = BIT(4), .msg = "rx_rd_ebd_poison" },
+	{ .int_msk = BIT(5), .msg = "buf_wait_timeout" },
+	{ /* sentinel */ }
+};
+
 static void hclge_log_error(struct device *dev, char *reg,
 			    const struct hclge_hw_error *err,
 			    u32 err_sts)
@@ -489,6 +530,82 @@ static int hclge_config_mac_err_int(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+static int hclge_config_ppu_error_interrupts(struct hclge_dev *hdev, u32 cmd,
+					     bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc[2];
+	int num = 1;
+	int ret;
+
+	/* configure PPU error interrupts */
+	if (cmd == HCLGE_PPU_MPF_ECC_INT_CMD) {
+		hclge_cmd_setup_basic_desc(&desc[0], cmd, false);
+		desc[0].flag |= HCLGE_CMD_FLAG_NEXT;
+		hclge_cmd_setup_basic_desc(&desc[1], cmd, false);
+		if (en) {
+			desc[0].data[0] = HCLGE_PPU_MPF_ABNORMAL_INT0_EN;
+			desc[0].data[1] = HCLGE_PPU_MPF_ABNORMAL_INT1_EN;
+			desc[1].data[3] = HCLGE_PPU_MPF_ABNORMAL_INT3_EN;
+			desc[1].data[4] = HCLGE_PPU_MPF_ABNORMAL_INT2_EN;
+		}
+
+		desc[1].data[0] = HCLGE_PPU_MPF_ABNORMAL_INT0_EN_MASK;
+		desc[1].data[1] = HCLGE_PPU_MPF_ABNORMAL_INT1_EN_MASK;
+		desc[1].data[2] = HCLGE_PPU_MPF_ABNORMAL_INT2_EN_MASK;
+		desc[1].data[3] |= HCLGE_PPU_MPF_ABNORMAL_INT3_EN_MASK;
+		num = 2;
+	} else if (cmd == HCLGE_PPU_MPF_OTHER_INT_CMD) {
+		hclge_cmd_setup_basic_desc(&desc[0], cmd, false);
+		if (en)
+			desc[0].data[0] = HCLGE_PPU_MPF_ABNORMAL_INT2_EN2;
+
+		desc[0].data[2] = HCLGE_PPU_MPF_ABNORMAL_INT2_EN2_MASK;
+	} else if (cmd == HCLGE_PPU_PF_OTHER_INT_CMD) {
+		hclge_cmd_setup_basic_desc(&desc[0], cmd, false);
+		if (en)
+			desc[0].data[0] = HCLGE_PPU_PF_ABNORMAL_INT_EN;
+
+		desc[0].data[2] = HCLGE_PPU_PF_ABNORMAL_INT_EN_MASK;
+	} else {
+		dev_err(dev, "Invalid cmd to configure PPU error interrupts\n");
+		return -EINVAL;
+	}
+
+	ret = hclge_cmd_send(&hdev->hw, &desc[0], num);
+
+	return ret;
+}
+
+static int hclge_config_ppu_hw_err_int(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	int ret;
+
+	ret = hclge_config_ppu_error_interrupts(hdev, HCLGE_PPU_MPF_ECC_INT_CMD,
+						en);
+	if (ret) {
+		dev_err(dev, "fail(%d) to configure PPU MPF ECC error intr\n",
+			ret);
+		return ret;
+	}
+
+	ret = hclge_config_ppu_error_interrupts(hdev,
+						HCLGE_PPU_MPF_OTHER_INT_CMD,
+						en);
+	if (ret) {
+		dev_err(dev, "fail(%d) to configure PPU MPF other intr\n", ret);
+		return ret;
+	}
+
+	ret = hclge_config_ppu_error_interrupts(hdev,
+						HCLGE_PPU_PF_OTHER_INT_CMD, en);
+	if (ret)
+		dev_err(dev, "fail(%d) to configure PPU PF error interrupts\n",
+			ret);
+	return ret;
+}
+
 #define HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type) \
 	do { \
 		if (ae_dev->ops->set_default_reset_request) \
@@ -578,6 +695,29 @@ static int hclge_handle_mpf_ras_error(struct hclge_dev *hdev,
 		hclge_log_error(dev, "PPP_MPF_ABNORMAL_INT_ST3",
 				&hclge_ppp_mpf_abnormal_int_st3[0], status);
 
+	/* log PPU(RCB) errors */
+	desc_data = (__le32 *)&desc[5];
+	status = le32_to_cpu(*(desc_data + 1));
+	if (status) {
+		dev_warn(dev, "PPU_MPF_ABNORMAL_INT_ST1 %s found\n",
+			 "rpu_rx_pkt_ecc_mbit_err");
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
+	}
+
+	status = le32_to_cpu(*(desc_data + 2));
+	if (status) {
+		hclge_log_error(dev, "PPU_MPF_ABNORMAL_INT_ST2",
+				&hclge_ppu_mpf_abnormal_int_st2[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
+	}
+
+	status = le32_to_cpu(*(desc_data + 3)) & HCLGE_PPU_MPF_INT_ST3_MASK;
+	if (status) {
+		hclge_log_error(dev, "PPU_MPF_ABNORMAL_INT_ST3",
+				&hclge_ppu_mpf_abnormal_int_st3[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
+	}
+
 	/* log TM(Traffic Manager) errors */
 	desc_data = (__le32 *)&desc[6];
 	status = le32_to_cpu(*desc_data);
@@ -718,6 +858,10 @@ static const struct hclge_hw_blk hw_blk[] = {
 	  .config_err_int = hclge_config_ppp_hw_err_int,
 	},
 	{
+	  .msk = BIT(3), .name = "PPU",
+	  .config_err_int = hclge_config_ppu_hw_err_int,
+	},
+	{
 	  .msk = BIT(4), .name = "TM",
 	  .config_err_int = hclge_config_tm_hw_err_int,
 	},
@@ -826,6 +970,17 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
 	}
 
+	/* log PPU(RCB) errors */
+	desc_data = (__le32 *)&desc[5];
+	status = le32_to_cpu(*(desc_data + 2)) &
+			HCLGE_PPU_MPF_INT_ST2_MSIX_MASK;
+	if (status) {
+		dev_warn(dev,
+			 "PPU_MPF_ABNORMAL_INT_ST2[28:29], err_status(0x%x)\n",
+			 status);
+		set_bit(HNAE3_CORE_RESET, reset_requests);
+	}
+
 	/* clear all main PF MSIx errors */
 	hclge_cmd_reuse_desc(&desc[0], false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
@@ -861,6 +1016,13 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		hclge_log_error(dev, "PPP_PF_ABNORMAL_INT_ST0",
 				&hclge_ppp_pf_abnormal_int[0], status);
 
+	/* PPU(RCB) PF errors */
+	desc_data = (__le32 *)&desc[3];
+	status = le32_to_cpu(*desc_data) & HCLGE_PPU_PF_INT_MSIX_MASK;
+	if (status)
+		hclge_log_error(dev, "PPU_PF_ABNORMAL_INT_ST",
+				&hclge_ppu_pf_abnormal_int[0], status);
+
 	/* clear all PF MSIx errors */
 	hclge_cmd_reuse_desc(&desc[0], false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 8e7d151..970d356 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -46,10 +46,25 @@
 #define HCLGE_NCSI_ERR_INT_TYPE	0x9
 #define HCLGE_MAC_COMMON_ERR_INT_EN		GENMASK(7, 0)
 #define HCLGE_MAC_COMMON_ERR_INT_EN_MASK	GENMASK(7, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT0_EN		GENMASK(31, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT0_EN_MASK	GENMASK(31, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT1_EN		GENMASK(31, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT1_EN_MASK	GENMASK(31, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT2_EN		0x3FFF3FFF
+#define HCLGE_PPU_MPF_ABNORMAL_INT2_EN_MASK	0x3FFF3FFF
+#define HCLGE_PPU_MPF_ABNORMAL_INT2_EN2		0xB
+#define HCLGE_PPU_MPF_ABNORMAL_INT2_EN2_MASK	0xB
+#define HCLGE_PPU_MPF_ABNORMAL_INT3_EN		GENMASK(7, 0)
+#define HCLGE_PPU_MPF_ABNORMAL_INT3_EN_MASK	GENMASK(23, 16)
+#define HCLGE_PPU_PF_ABNORMAL_INT_EN		GENMASK(5, 0)
+#define HCLGE_PPU_PF_ABNORMAL_INT_EN_MASK	GENMASK(5, 0)
 
 #define HCLGE_IGU_INT_MASK		GENMASK(3, 0)
 #define HCLGE_IGU_EGU_TNL_INT_MASK	GENMASK(5, 0)
 #define HCLGE_PPP_MPF_INT_ST3_MASK	GENMASK(5, 0)
+#define HCLGE_PPU_MPF_INT_ST3_MASK	GENMASK(7, 0)
+#define HCLGE_PPU_MPF_INT_ST2_MSIX_MASK	GENMASK(29, 28)
+#define HCLGE_PPU_PF_INT_MSIX_MASK	0x27
 #define HCLGE_QCN_FIFO_INT_MASK		GENMASK(17, 0)
 #define HCLGE_QCN_ECC_INT_MASK		GENMASK(21, 0)
 #define HCLGE_NCSI_ECC_INT_MASK		GENMASK(1, 0)
-- 
2.7.4


