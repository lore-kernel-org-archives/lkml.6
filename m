Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A77BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485B520868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485B520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLGVKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:10:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56847 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbeLGVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:47 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4BF0A2AA65BA6;
        Sat,  8 Dec 2018 05:09:45 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:39 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 10/14] net: hns3: add handling of hw errors of MAC
Date:   Fri, 7 Dec 2018 21:08:07 +0000
Message-ID: <20181207210811.23844-11-salil.mehta@huawei.com>
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

This patch adds enable and handling of hw errors of
the MAC block.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  1 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 48 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  2 +
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 08d02b9..46af567 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -215,6 +215,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_SFP_GET_SPEED		= 0x7104,
 
 	/* Error INT commands */
+	HCLGE_MAC_COMMON_INT_EN		= 0x030E,
 	HCLGE_TM_SCH_ECC_INT_EN		= 0x0829,
 	HCLGE_COMMON_ECC_INT_CFG	= 0x1505,
 	HCLGE_QUERY_RAS_INT_STS_BD_NUM	= 0x1510,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 0676670..20f8bb5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -210,6 +210,18 @@ static const struct hclge_hw_error hclge_qcn_ecc_rint[] = {
 	{ /* sentinel */ }
 };
 
+static const struct hclge_hw_error hclge_mac_afifo_tnl_int[] = {
+	{ .int_msk = BIT(0), .msg = "egu_cge_afifo_ecc_1bit_err" },
+	{ .int_msk = BIT(1), .msg = "egu_cge_afifo_ecc_mbit_err" },
+	{ .int_msk = BIT(2), .msg = "egu_lge_afifo_ecc_1bit_err" },
+	{ .int_msk = BIT(3), .msg = "egu_lge_afifo_ecc_mbit_err" },
+	{ .int_msk = BIT(4), .msg = "cge_igu_afifo_ecc_1bit_err" },
+	{ .int_msk = BIT(5), .msg = "cge_igu_afifo_ecc_mbit_err" },
+	{ .int_msk = BIT(6), .msg = "lge_igu_afifo_ecc_1bit_err" },
+	{ .int_msk = BIT(7), .msg = "lge_igu_afifo_ecc_mbit_err" },
+	{ /* sentinel */ }
+};
+
 static void hclge_log_error(struct device *dev, char *reg,
 			    const struct hclge_hw_error *err,
 			    u32 err_sts)
@@ -452,6 +464,27 @@ static int hclge_config_tm_hw_err_int(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
+static int hclge_config_mac_err_int(struct hclge_dev *hdev, bool en)
+{
+	struct device *dev = &hdev->pdev->dev;
+	struct hclge_desc desc;
+	int ret;
+
+	/* configure MAC common error interrupts */
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_MAC_COMMON_INT_EN, false);
+	if (en)
+		desc.data[0] = cpu_to_le32(HCLGE_MAC_COMMON_ERR_INT_EN);
+
+	desc.data[1] = cpu_to_le32(HCLGE_MAC_COMMON_ERR_INT_EN_MASK);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret)
+		dev_err(dev,
+			"fail(%d) to configure MAC COMMON error intr\n", ret);
+
+	return ret;
+}
+
 #define HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type) \
 	do { \
 		if (ae_dev->ops->set_default_reset_request) \
@@ -688,6 +721,10 @@ static const struct hclge_hw_blk hw_blk[] = {
 	  .msk = BIT(5), .name = "COMMON",
 	  .config_err_int = hclge_config_common_hw_err_int,
 	},
+	{
+	  .msk = BIT(8), .name = "MAC",
+	  .config_err_int = hclge_config_mac_err_int,
+	},
 	{ /* sentinel */ }
 };
 
@@ -735,7 +772,9 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 	u32 mpf_bd_num, pf_bd_num, bd_num;
 	struct hclge_desc desc_bd;
 	struct hclge_desc *desc;
+	__le32 *desc_data;
 	int ret = 0;
+	u32 status;
 
 	/* set default handling */
 	set_bit(HNAE3_FUNC_RESET, reset_requests);
@@ -774,6 +813,15 @@ int hclge_handle_hw_msix_error(struct hclge_dev *hdev,
 		goto msi_error;
 	}
 
+	/* log MAC errors */
+	desc_data = (__le32 *)&desc[1];
+	status = le32_to_cpu(*desc_data);
+	if (status) {
+		hclge_log_error(dev, "MAC_AFIFO_TNL_INT_R",
+				&hclge_mac_afifo_tnl_int[0], status);
+		set_bit(HNAE3_GLOBAL_RESET, reset_requests);
+	}
+
 	/* clear all main PF MSIx errors */
 	hclge_cmd_reuse_desc(&desc[0], false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 05adccb..8e7d151 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -44,6 +44,8 @@
 #define HCLGE_TM_QCN_MEM_ERR_INT_EN	0xFFFFFF
 #define HCLGE_NCSI_ERR_INT_EN	0x3
 #define HCLGE_NCSI_ERR_INT_TYPE	0x9
+#define HCLGE_MAC_COMMON_ERR_INT_EN		GENMASK(7, 0)
+#define HCLGE_MAC_COMMON_ERR_INT_EN_MASK	GENMASK(7, 0)
 
 #define HCLGE_IGU_INT_MASK		GENMASK(3, 0)
 #define HCLGE_IGU_EGU_TNL_INT_MASK	GENMASK(5, 0)
-- 
2.7.4


