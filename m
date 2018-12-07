Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB703C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D30C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D30C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLGVJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16091 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbeLGVJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:58 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AE550210F911D;
        Sat,  8 Dec 2018 05:09:54 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:47 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 13/14] net: hns3: handle hw errors of SSU
Date:   Fri, 7 Dec 2018 21:08:10 +0000
Message-ID: <20181207210811.23844-14-salil.mehta@huawei.com>
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

This patch enables and handles hw errors of the Storage Switch Unit(SSU).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   2 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 187 +++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  14 ++
 3 files changed, 203 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 0223e83..eb91519 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -217,6 +217,8 @@ enum hclge_opcode_type {
 	/* Error INT commands */
 	HCLGE_MAC_COMMON_INT_EN		= 0x030E,
 	HCLGE_TM_SCH_ECC_INT_EN		= 0x0829,
+	HCLGE_SSU_ECC_INT_CMD		= 0x0989,
+	HCLGE_SSU_COMMON_INT_CMD	= 0x098C,
 	HCLGE_PPU_MPF_ECC_INT_CMD	= 0x0B40,
 	HCLGE_PPU_MPF_OTHER_INT_CMD	= 0x0B41,
 	HCLGE_PPU_PF_OTHER_INT_CMD	= 0x0B42,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 00086ce..660320d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -263,6 +263,80 @@ static const struct hclge_hw_error hclge_ppu_pf_abnormal_int[] = {
 	{ /* sentinel */ }
 };
 
+static const struct hclge_hw_error hclge_ssu_com_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "buf_sum_err" },
+	{ .int_msk = BIT(1), .msg = "ppp_mb_num_err" },
+	{ .int_msk = BIT(2), .msg = "ppp_mbid_err" },
+	{ .int_msk = BIT(3), .msg = "ppp_rlt_mac_err" },
+	{ .int_msk = BIT(4), .msg = "ppp_rlt_host_err" },
+	{ .int_msk = BIT(5), .msg = "cks_edit_position_err" },
+	{ .int_msk = BIT(6), .msg = "cks_edit_condition_err" },
+	{ .int_msk = BIT(7), .msg = "vlan_edit_condition_err" },
+	{ .int_msk = BIT(8), .msg = "vlan_num_ot_err" },
+	{ .int_msk = BIT(9), .msg = "vlan_num_in_err" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ssu_port_based_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "roc_pkt_without_key_port" },
+	{ .int_msk = BIT(1), .msg = "tpu_pkt_without_key_port" },
+	{ .int_msk = BIT(2), .msg = "igu_pkt_without_key_port" },
+	{ .int_msk = BIT(3), .msg = "roc_eof_mis_match_port" },
+	{ .int_msk = BIT(4), .msg = "tpu_eof_mis_match_port" },
+	{ .int_msk = BIT(5), .msg = "igu_eof_mis_match_port" },
+	{ .int_msk = BIT(6), .msg = "roc_sof_mis_match_port" },
+	{ .int_msk = BIT(7), .msg = "tpu_sof_mis_match_port" },
+	{ .int_msk = BIT(8), .msg = "igu_sof_mis_match_port" },
+	{ .int_msk = BIT(11), .msg = "ets_rd_int_rx_port" },
+	{ .int_msk = BIT(12), .msg = "ets_wr_int_rx_port" },
+	{ .int_msk = BIT(13), .msg = "ets_rd_int_tx_port" },
+	{ .int_msk = BIT(14), .msg = "ets_wr_int_tx_port" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ssu_fifo_overflow_int[] = {
+	{ .int_msk = BIT(0), .msg = "ig_mac_inf_int" },
+	{ .int_msk = BIT(1), .msg = "ig_host_inf_int" },
+	{ .int_msk = BIT(2), .msg = "ig_roc_buf_int" },
+	{ .int_msk = BIT(3), .msg = "ig_host_data_fifo_int" },
+	{ .int_msk = BIT(4), .msg = "ig_host_key_fifo_int" },
+	{ .int_msk = BIT(5), .msg = "tx_qcn_fifo_int" },
+	{ .int_msk = BIT(6), .msg = "rx_qcn_fifo_int" },
+	{ .int_msk = BIT(7), .msg = "tx_pf_rd_fifo_int" },
+	{ .int_msk = BIT(8), .msg = "rx_pf_rd_fifo_int" },
+	{ .int_msk = BIT(9), .msg = "qm_eof_fifo_int" },
+	{ .int_msk = BIT(10), .msg = "mb_rlt_fifo_int" },
+	{ .int_msk = BIT(11), .msg = "dup_uncopy_fifo_int" },
+	{ .int_msk = BIT(12), .msg = "dup_cnt_rd_fifo_int" },
+	{ .int_msk = BIT(13), .msg = "dup_cnt_drop_fifo_int" },
+	{ .int_msk = BIT(14), .msg = "dup_cnt_wrb_fifo_int" },
+	{ .int_msk = BIT(15), .msg = "host_cmd_fifo_int" },
+	{ .int_msk = BIT(16), .msg = "mac_cmd_fifo_int" },
+	{ .int_msk = BIT(17), .msg = "host_cmd_bitmap_empty_int" },
+	{ .int_msk = BIT(18), .msg = "mac_cmd_bitmap_empty_int" },
+	{ .int_msk = BIT(19), .msg = "dup_bitmap_empty_int" },
+	{ .int_msk = BIT(20), .msg = "out_queue_bitmap_empty_int" },
+	{ .int_msk = BIT(21), .msg = "bank2_bitmap_empty_int" },
+	{ .int_msk = BIT(22), .msg = "bank1_bitmap_empty_int" },
+	{ .int_msk = BIT(23), .msg = "bank0_bitmap_empty_int" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ssu_ets_tcg_int[] = {
+	{ .int_msk = BIT(0), .msg = "ets_rd_int_rx_tcg" },
+	{ .int_msk = BIT(1), .msg = "ets_wr_int_rx_tcg" },
+	{ .int_msk = BIT(2), .msg = "ets_rd_int_tx_tcg" },
+	{ .int_msk = BIT(3), .msg = "ets_wr_int_tx_tcg" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ssu_port_based_pf_int[] = {
+	{ .int_msk = BIT(0), .msg = "roc_pkt_without_key_port" },
+	{ .int_msk = BIT(9), .msg = "low_water_line_err_port" },
+	{ .int_msk = BIT(10), .msg = "hi_water_line_err_port" },
+	{ /* sentinel */ }
+};
+
 static void hclge_log_error(struct device *dev, char *reg,
 			    const struct hclge_hw_error *err,
 			    u32 err_sts)
@@ -606,6 +680,63 @@ static int hclge_config_ppu_hw_err_int(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+static int hclge_config_ssu_hw_err_int(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc[2];
+	int ret;
+
+	/* configure SSU ecc error interrupts */
+	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_SSU_ECC_INT_CMD, false);
+	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+	hclge_cmd_setup_basic_desc(&desc[1], HCLGE_SSU_ECC_INT_CMD, false);
+	if (en) {
+		desc[0].data[0] = cpu_to_le32(HCLGE_SSU_1BIT_ECC_ERR_INT_EN);
+		desc[0].data[1] =
+			cpu_to_le32(HCLGE_SSU_MULTI_BIT_ECC_ERR_INT_EN);
+		desc[0].data[4] = cpu_to_le32(HCLGE_SSU_BIT32_ECC_ERR_INT_EN);
+	}
+
+	desc[1].data[0] = cpu_to_le32(HCLGE_SSU_1BIT_ECC_ERR_INT_EN_MASK);
+	desc[1].data[1] = cpu_to_le32(HCLGE_SSU_MULTI_BIT_ECC_ERR_INT_EN_MASK);
+	desc[1].data[2] = cpu_to_le32(HCLGE_SSU_BIT32_ECC_ERR_INT_EN_MASK);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc[0], 2);
+	if (ret) {
+		dev_err(dev,
+			"fail(%d) to configure SSU ECC error interrupt\n", ret);
+		return ret;
+	}
+
+	/* configure SSU common error interrupts */
+	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_SSU_COMMON_INT_CMD, false);
+	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
+	hclge_cmd_setup_basic_desc(&desc[1], HCLGE_SSU_COMMON_INT_CMD, false);
+
+	if (en) {
+		if (hdev->pdev->revision >= 0x21)
+			desc[0].data[0] =
+				cpu_to_le32(HCLGE_SSU_COMMON_INT_EN);
+		else
+			desc[0].data[0] =
+				cpu_to_le32(HCLGE_SSU_COMMON_INT_EN & ~BIT(5));
+		desc[0].data[1] = cpu_to_le32(HCLGE_SSU_PORT_BASED_ERR_INT_EN);
+		desc[0].data[2] =
+			cpu_to_le32(HCLGE_SSU_FIFO_OVERFLOW_ERR_INT_EN);
+	}
+
+	desc[1].data[0] = cpu_to_le32(HCLGE_SSU_COMMON_INT_EN_MASK |
+				HCLGE_SSU_PORT_BASED_ERR_INT_EN_MASK);
+	desc[1].data[1] = cpu_to_le32(HCLGE_SSU_FIFO_OVERFLOW_ERR_INT_EN_MASK);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc[0], 2);
+	if (ret)
+		dev_err(dev,
+			"fail(%d) to configure SSU COMMON error intr\n", ret);
+
+	return ret;
+}
+
 #define HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type) \
 	do { \
 		if (ae_dev->ops->set_default_reset_request) \
@@ -676,6 +807,27 @@ static int hclge_handle_mpf_ras_error(struct hclge_dev *hdev,
 		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
 	}
 
+	/* log SSU(Storage Switch Unit) errors */
+	desc_data = (__le32 *)&desc[2];
+	status = le32_to_cpu(*(desc_data + 2));
+	if (status) {
+		dev_warn(dev, "SSU_ECC_MULTI_BIT_INT_0 ssu_ecc_mbit_int[31:0]\n");
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
+	}
+
+	status = le32_to_cpu(*(desc_data + 3)) & BIT(0);
+	if (status) {
+		dev_warn(dev, "SSU_ECC_MULTI_BIT_INT_1 ssu_ecc_mbit_int[32]\n");
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_CORE_RESET);
+	}
+
+	status = le32_to_cpu(*(desc_data + 4)) & HCLGE_SSU_COMMON_ERR_INT_MASK;
+	if (status) {
+		hclge_log_error(dev, "SSU_COMMON_ERR_INT",
+				&hclge_ssu_com_err_int[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
+	}
+
 	/* log IGU(Ingress Unit) errors */
 	desc_data = (__le32 *)&desc[3];
 	status = le32_to_cpu(*desc_data) & HCLGE_IGU_INT_MASK;
@@ -775,6 +927,7 @@ static int hclge_handle_pf_ras_error(struct hclge_dev *hdev,
 				     struct hclge_desc *desc,
 				     int num)
 {
+	struct hnae3_ae_dev *ae_dev = hdev->ae_dev;
 	struct device *dev = &hdev->pdev->dev;
 	__le32 *desc_data;
 	u32 status;
@@ -791,6 +944,28 @@ static int hclge_handle_pf_ras_error(struct hclge_dev *hdev,
 		return ret;
 	}
 
+	/* log SSU(Storage Switch Unit) errors */
+	status = le32_to_cpu(desc[0].data[0]);
+	if (status) {
+		hclge_log_error(dev, "SSU_PORT_BASED_ERR_INT",
+				&hclge_ssu_port_based_err_int[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
+	}
+
+	status = le32_to_cpu(desc[0].data[1]);
+	if (status) {
+		hclge_log_error(dev, "SSU_FIFO_OVERFLOW_INT",
+				&hclge_ssu_fifo_overflow_int[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
+	}
+
+	status = le32_to_cpu(desc[0].data[2]);
+	if (status) {
+		hclge_log_error(dev, "SSU_ETS_TCG_INT",
+				&hclge_ssu_ets_tcg_int[0], status);
+		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
+	}
+
 	/* log IGU(Ingress Unit) EGU(Egress Unit) TNL errors */
 	desc_data = (__le32 *)&desc[1];
 	status = le32_to_cpu(*desc_data) & HCLGE_IGU_EGU_TNL_INT_MASK;
@@ -858,6 +1033,10 @@ static const struct hclge_hw_blk hw_blk[] = {
 	  .config_err_int = hclge_config_ppp_hw_err_int,
 	},
 	{
+	  .msk = BIT(2), .name = "SSU",
+	  .config_err_int = hclge_config_ssu_hw_err_int,
+	},
+	{
 	  .msk = BIT(3), .name = "PPU",
 	  .config_err_int = hclge_config_ppu_hw_err_int,
 	},
@@ -1009,6 +1188,14 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		goto msi_error;
 	}
 
+	/* log SSU PF errors */
+	status = le32_to_cpu(desc[0].data[0]) & HCLGE_SSU_PORT_INT_MSIX_MASK;
+	if (status) {
+		hclge_log_error(dev, "SSU_PORT_BASED_ERR_INT",
+				&hclge_ssu_port_based_pf_int[0], status);
+		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
+	}
+
 	/* read and log PPP PF errors */
 	desc_data = (__le32 *)&desc[2];
 	status = le32_to_cpu(*desc_data);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 970d356..d2077f2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -58,7 +58,21 @@
 #define HCLGE_PPU_MPF_ABNORMAL_INT3_EN_MASK	GENMASK(23, 16)
 #define HCLGE_PPU_PF_ABNORMAL_INT_EN		GENMASK(5, 0)
 #define HCLGE_PPU_PF_ABNORMAL_INT_EN_MASK	GENMASK(5, 0)
+#define HCLGE_SSU_1BIT_ECC_ERR_INT_EN		GENMASK(31, 0)
+#define HCLGE_SSU_1BIT_ECC_ERR_INT_EN_MASK	GENMASK(31, 0)
+#define HCLGE_SSU_MULTI_BIT_ECC_ERR_INT_EN	GENMASK(31, 0)
+#define HCLGE_SSU_MULTI_BIT_ECC_ERR_INT_EN_MASK	GENMASK(31, 0)
+#define HCLGE_SSU_BIT32_ECC_ERR_INT_EN		0x0101
+#define HCLGE_SSU_BIT32_ECC_ERR_INT_EN_MASK	0x0101
+#define HCLGE_SSU_COMMON_INT_EN			GENMASK(9, 0)
+#define HCLGE_SSU_COMMON_INT_EN_MASK		GENMASK(9, 0)
+#define HCLGE_SSU_PORT_BASED_ERR_INT_EN		0x0BFF
+#define HCLGE_SSU_PORT_BASED_ERR_INT_EN_MASK	0x0BFF0000
+#define HCLGE_SSU_FIFO_OVERFLOW_ERR_INT_EN	GENMASK(23, 0)
+#define HCLGE_SSU_FIFO_OVERFLOW_ERR_INT_EN_MASK	GENMASK(23, 0)
 
+#define HCLGE_SSU_COMMON_ERR_INT_MASK	GENMASK(9, 0)
+#define HCLGE_SSU_PORT_INT_MSIX_MASK	0x7BFF
 #define HCLGE_IGU_INT_MASK		GENMASK(3, 0)
 #define HCLGE_IGU_EGU_TNL_INT_MASK	GENMASK(5, 0)
 #define HCLGE_PPP_MPF_INT_ST3_MASK	GENMASK(5, 0)
-- 
2.7.4


