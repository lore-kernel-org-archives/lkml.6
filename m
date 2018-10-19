Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5246DECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2275021486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2275021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJTDYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:46 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E1F7B2474782;
        Sat, 20 Oct 2018 03:17:17 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:17:09 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 5/7] net: hns3: Add enable and process hw errors from IGU, EGU and NCSI
Date:   Fri, 19 Oct 2018 20:15:30 +0100
Message-ID: <20181019191532.10088-6-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181019191532.10088-1-salil.mehta@huawei.com>
References: <20181019191532.10088-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch adds enable and processing of hw errors from IGU(Ingress Unit),
EGU(Egress Unit) and NCSI(Network Controller Sideband Interface).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |   9 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 190 +++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |   8 +
 3 files changed, 207 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 8525f18..97c90aa 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -212,6 +212,15 @@ enum hclge_opcode_type {
 
 	/* Error INT commands */
 	HCLGE_COMMON_ECC_INT_CFG	= 0x1505,
+	HCLGE_IGU_EGU_TNL_INT_QUERY	= 0x1802,
+	HCLGE_IGU_EGU_TNL_INT_EN	= 0x1803,
+	HCLGE_IGU_EGU_TNL_INT_CLR	= 0x1804,
+	HCLGE_IGU_COMMON_INT_QUERY	= 0x1805,
+	HCLGE_IGU_COMMON_INT_EN		= 0x1806,
+	HCLGE_IGU_COMMON_INT_CLR	= 0x1807,
+	HCLGE_NCSI_INT_QUERY		= 0x2400,
+	HCLGE_NCSI_INT_EN		= 0x2401,
+	HCLGE_NCSI_INT_CLR		= 0x2402,
 };
 
 #define HCLGE_TQP_REG_OFFSET		0x80000
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 8b37de4..34c4edd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -85,6 +85,30 @@ static const struct hclge_hw_error hclge_tqp_int_ecc_int[] = {
 	{ /* sentinel */ }
 };
 
+static const struct hclge_hw_error hclge_igu_com_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "igu_rx_buf0_ecc_mbit_err" },
+	{ .int_msk = BIT(1), .msg = "igu_rx_buf0_ecc_1bit_err" },
+	{ .int_msk = BIT(2), .msg = "igu_rx_buf1_ecc_mbit_err" },
+	{ .int_msk = BIT(3), .msg = "igu_rx_buf1_ecc_1bit_err" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_igu_egu_tnl_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "rx_buf_overflow" },
+	{ .int_msk = BIT(1), .msg = "rx_stp_fifo_overflow" },
+	{ .int_msk = BIT(2), .msg = "rx_stp_fifo_undeflow" },
+	{ .int_msk = BIT(3), .msg = "tx_buf_overflow" },
+	{ .int_msk = BIT(4), .msg = "tx_buf_underrun" },
+	{ .int_msk = BIT(5), .msg = "rx_stp_buf_overflow" },
+	{ /* sentinel */ }
+};
+
+static const struct hclge_hw_error hclge_ncsi_err_int[] = {
+	{ .int_msk = BIT(0), .msg = "ncsi_tx_ecc_1bit_err" },
+	{ .int_msk = BIT(1), .msg = "ncsi_tx_ecc_mbit_err" },
+	{ /* sentinel */ }
+};
+
 static void hclge_log_error(struct device *dev,
 			    const struct hclge_hw_error *err_list,
 			    u32 err_sts)
@@ -229,6 +253,75 @@ static int hclge_enable_common_error(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+static int hclge_enable_ncsi_error(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc;
+	int ret;
+
+	if (hdev->pdev->revision < 0x21)
+		return 0;
+
+	/* enable/disable NCSI  error interrupts */
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_NCSI_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_NCSI_ERR_INT_EN);
+	else
+		desc.data[0] = 0;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(dev,
+			"failed(%d) to enable/disable NCSI error interrupts\n",
+			ret);
+
+	return ret;
+}
+
+static int hclge_enable_igu_egu_error(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc;
+	int ret;
+
+	/* enable/disable error interrupts */
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_IGU_COMMON_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_IGU_ERR_INT_EN);
+	else
+		desc.data[0] = 0;
+	desc.data[1] = cpu_to_le32(HCLGE_IGU_ERR_INT_EN_MASK);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(dev,
+			"failed(%d) to enable/disable IGU common interrupts\n",
+			ret);
+		return ret;
+	}
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_IGU_EGU_TNL_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_IGU_TNL_ERR_INT_EN);
+	else
+		desc.data[0] = 0;
+	desc.data[1] = cpu_to_le32(HCLGE_IGU_TNL_ERR_INT_EN_MASK);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(dev,
+			"failed(%d) to enable/disable IGU-EGU TNL interrupts\n",
+			ret);
+		return ret;
+	}
+
+	ret = hclge_enable_ncsi_error(hdev, en);
+	if (ret)
+		dev_err(dev, "fail(%d) to en/disable err int\n", ret);
+
+	return ret;
+}
+
 static void hclge_process_common_error(struct hclge_dev *hdev,
 				       enum hclge_err_int_type type)
 {
@@ -285,7 +378,104 @@ static void hclge_process_common_error(struct hclge_dev *hdev,
 			ret);
 }
 
+static void hclge_process_ncsi_error(struct hclge_dev *hdev,
+				     enum hclge_err_int_type type)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc_rd;
+	struct hclge_desc desc_wr;
+	u32 err_sts;
+	int ret;
+
+	if (hdev->pdev->revision < 0x21)
+		return;
+
+	/* read NCSI error status */
+	ret = hclge_cmd_query_error(hdev, &desc_rd, HCLGE_NCSI_INT_QUERY,
+				    0, 1, HCLGE_NCSI_ERR_INT_TYPE);
+	if (ret) {
+		dev_err(dev,
+			"failed(=%d) to query NCSI error interrupt status\n",
+			ret);
+		return;
+	}
+
+	/* log err */
+	err_sts = le32_to_cpu(desc_rd.data[0]);
+	hclge_log_error(dev, &hclge_ncsi_err_int[0], err_sts);
+
+	/* clear err int */
+	ret = hclge_cmd_clear_error(hdev, &desc_wr, &desc_rd,
+				    HCLGE_NCSI_INT_CLR, 0);
+	if (ret)
+		dev_err(dev, "failed(=%d) to clear NCSI intrerrupt status\n",
+			ret);
+}
+
+static void hclge_process_igu_egu_error(struct hclge_dev *hdev,
+					enum hclge_err_int_type int_type)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc_rd;
+	struct hclge_desc desc_wr;
+	u32 err_sts;
+	int ret;
+
+	/* read IGU common err sts */
+	ret = hclge_cmd_query_error(hdev, &desc_rd,
+				    HCLGE_IGU_COMMON_INT_QUERY,
+				    0, 1, int_type);
+	if (ret) {
+		dev_err(dev, "failed(=%d) to query IGU common int status\n",
+			ret);
+		return;
+	}
+
+	/* log err */
+	err_sts = le32_to_cpu(desc_rd.data[0]) &
+				   HCLGE_IGU_COM_INT_MASK;
+	hclge_log_error(dev, &hclge_igu_com_err_int[0], err_sts);
+
+	/* clear err int */
+	ret = hclge_cmd_clear_error(hdev, &desc_wr, &desc_rd,
+				    HCLGE_IGU_COMMON_INT_CLR, 0);
+	if (ret) {
+		dev_err(dev, "failed(=%d) to clear IGU common int status\n",
+			ret);
+		return;
+	}
+
+	/* read IGU-EGU TNL err sts */
+	ret = hclge_cmd_query_error(hdev, &desc_rd,
+				    HCLGE_IGU_EGU_TNL_INT_QUERY,
+				    0, 1, int_type);
+	if (ret) {
+		dev_err(dev, "failed(=%d) to query IGU-EGU TNL int status\n",
+			ret);
+		return;
+	}
+
+	/* log err */
+	err_sts = le32_to_cpu(desc_rd.data[0]) &
+				   HCLGE_IGU_EGU_TNL_INT_MASK;
+	hclge_log_error(dev, &hclge_igu_egu_tnl_err_int[0], err_sts);
+
+	/* clear err int */
+	ret = hclge_cmd_clear_error(hdev, &desc_wr, &desc_rd,
+				    HCLGE_IGU_EGU_TNL_INT_CLR, 0);
+	if (ret) {
+		dev_err(dev, "failed(=%d) to clear IGU-EGU TNL int status\n",
+			ret);
+		return;
+	}
+
+	hclge_process_ncsi_error(hdev, HCLGE_ERR_INT_RAS_NFE);
+}
+
 static const struct hclge_hw_blk hw_blk[] = {
+	{ .msk = BIT(0), .name = "IGU_EGU",
+	  .enable_error = hclge_enable_igu_egu_error,
+	  .process_error = hclge_process_igu_egu_error, },
 	{ .msk = BIT(5), .name = "COMMON",
 	  .enable_error = hclge_enable_common_error,
 	  .process_error = hclge_process_common_error, },
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index b413141..f46c8c2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -23,6 +23,12 @@
 #define HCLGE_IMP_RD_POISON_ERR_INT_EN_MASK	0x0100
 #define HCLGE_TQP_ECC_ERR_INT_EN	0x0FFF
 #define HCLGE_TQP_ECC_ERR_INT_EN_MASK	0x0FFF
+#define HCLGE_IGU_ERR_INT_EN	0x0000066F
+#define HCLGE_IGU_ERR_INT_EN_MASK	0x000F
+#define HCLGE_IGU_TNL_ERR_INT_EN    0x0002AABF
+#define HCLGE_IGU_TNL_ERR_INT_EN_MASK  0x003F
+#define HCLGE_NCSI_ERR_INT_EN	0x3
+#define HCLGE_NCSI_ERR_INT_TYPE	0x9
 
 #define HCLGE_IMP_TCM_ECC_INT_MASK	0xFFFF
 #define HCLGE_IMP_ITCM4_ECC_INT_MASK	0x3
@@ -35,6 +41,8 @@
 #define HCLGE_CMDQ_NIC_ECC_CLR_MASK	0xFFFF
 #define HCLGE_CMDQ_ROCEE_ECC_CLR_MASK	0xFFFF0000
 #define HCLGE_TQP_IMP_ERR_CLR_MASK	0x0FFF0001
+#define HCLGE_IGU_COM_INT_MASK		0xF
+#define HCLGE_IGU_EGU_TNL_INT_MASK	0x3F
 
 enum hclge_err_int_type {
 	HCLGE_ERR_INT_MSIX = 0,
-- 
2.7.4


