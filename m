Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF253C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C302082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C302082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLGVLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:11:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbeLGVJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:28 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E67B83EBB8A11;
        Sat,  8 Dec 2018 05:09:24 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:16 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 02/14] net: hns3: rename enable error interrupt functions
Date:   Fri, 7 Dec 2018 21:07:59 +0000
Message-ID: <20181207210811.23844-3-salil.mehta@huawei.com>
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

This patch
- renames the enable error interrupt functions.
  The reason is that these functions
  are used for both enable and disable error interrupts.

- removes redundant logs from the enable error interrupt functions.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 83 ++++++++--------------
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  4 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  2 +-
 3 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index ac9ab3c..21437fe 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -372,18 +372,18 @@ static int hclge_cmd_query_error(struct hclge_dev *hdev,
 	return ret;
 }
 
-static int hclge_enable_common_error(struct hclge_dev *hdev, bool en)
+static int hclge_config_common_hw_err_int(struct hclge_dev *hdev, bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc[2];
 	int ret;
 
+	/* configure common error interrupts */
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_COMMON_ECC_INT_CFG, false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
 	hclge_cmd_setup_basic_desc(&desc[1], HCLGE_COMMON_ECC_INT_CFG, false);
 
 	if (en) {
-		/* enable COMMON error interrupts */
 		desc[0].data[0] = cpu_to_le32(HCLGE_IMP_TCM_ECC_ERR_INT_EN);
 		desc[0].data[2] = cpu_to_le32(HCLGE_CMDQ_NIC_ECC_ERR_INT_EN |
 					HCLGE_CMDQ_ROCEE_ECC_ERR_INT_EN);
@@ -391,7 +391,6 @@ static int hclge_enable_common_error(struct hclge_dev *hdev, bool en)
 		desc[0].data[4] = cpu_to_le32(HCLGE_TQP_ECC_ERR_INT_EN);
 		desc[0].data[5] = cpu_to_le32(HCLGE_IMP_ITCM4_ECC_ERR_INT_EN);
 	} else {
-		/* disable COMMON error interrupts */
 		desc[0].data[0] = 0;
 		desc[0].data[2] = 0;
 		desc[0].data[3] = 0;
@@ -408,13 +407,12 @@ static int hclge_enable_common_error(struct hclge_dev *hdev, bool en)
 	ret = hclge_cmd_send(&hdev->hw, &desc[0], 2);
 	if (ret)
 		dev_err(dev,
-			"failed(%d) to enable/disable COMMON err interrupts\n",
-			ret);
+			"fail(%d) to configure common err interrupts\n", ret);
 
 	return ret;
 }
 
-static int hclge_enable_ncsi_error(struct hclge_dev *hdev, bool en)
+static int hclge_config_ncsi_hw_err_int(struct hclge_dev *hdev, bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc;
@@ -423,7 +421,7 @@ static int hclge_enable_ncsi_error(struct hclge_dev *hdev, bool en)
 	if (hdev->pdev->revision < 0x21)
 		return 0;
 
-	/* enable/disable NCSI  error interrupts */
+	/* configure NCSI error interrupts */
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_NCSI_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_NCSI_ERR_INT_EN);
@@ -433,19 +431,18 @@ static int hclge_enable_ncsi_error(struct hclge_dev *hdev, bool en)
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
 		dev_err(dev,
-			"failed(%d) to enable/disable NCSI error interrupts\n",
-			ret);
+			"fail(%d) to configure  NCSI error interrupts\n", ret);
 
 	return ret;
 }
 
-static int hclge_enable_igu_egu_error(struct hclge_dev *hdev, bool en)
+static int hclge_config_igu_egu_hw_err_int(struct hclge_dev *hdev, bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc;
 	int ret;
 
-	/* enable/disable error interrupts */
+	/* configure IGU,EGU error interrupts */
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_IGU_COMMON_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_IGU_ERR_INT_EN);
@@ -456,8 +453,7 @@ static int hclge_enable_igu_egu_error(struct hclge_dev *hdev, bool en)
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
 		dev_err(dev,
-			"failed(%d) to enable/disable IGU common interrupts\n",
-			ret);
+			"fail(%d) to configure IGU common interrupts\n", ret);
 		return ret;
 	}
 
@@ -471,26 +467,23 @@ static int hclge_enable_igu_egu_error(struct hclge_dev *hdev, bool en)
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
 		dev_err(dev,
-			"failed(%d) to enable/disable IGU-EGU TNL interrupts\n",
-			ret);
+			"fail(%d) to configure IGU-EGU TNL interrupts\n", ret);
 		return ret;
 	}
 
-	ret = hclge_enable_ncsi_error(hdev, en);
-	if (ret)
-		dev_err(dev, "fail(%d) to en/disable err int\n", ret);
+	ret = hclge_config_ncsi_hw_err_int(hdev, en);
 
 	return ret;
 }
 
-static int hclge_enable_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
+static int hclge_config_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
 					    bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc[2];
 	int ret;
 
-	/* enable/disable PPP error interrupts */
+	/* configure PPP error interrupts */
 	hclge_cmd_setup_basic_desc(&desc[0], cmd, false);
 	desc[0].flag |= cpu_to_le16(HCLGE_CMD_FLAG_NEXT);
 	hclge_cmd_setup_basic_desc(&desc[1], cmd, false);
@@ -527,44 +520,33 @@ static int hclge_enable_ppp_error_interrupt(struct hclge_dev *hdev, u32 cmd,
 
 	ret = hclge_cmd_send(&hdev->hw, &desc[0], 2);
 	if (ret)
-		dev_err(dev,
-			"failed(%d) to enable/disable PPP error interrupts\n",
-			ret);
+		dev_err(dev, "fail(%d) to configure PPP error intr\n", ret);
 
 	return ret;
 }
 
-static int hclge_enable_ppp_error(struct hclge_dev *hdev, bool en)
+static int hclge_config_ppp_hw_err_int(struct hclge_dev *hdev, bool en)
 {
-	struct device *dev = &hdev->pdev->dev;
 	int ret;
 
-	ret = hclge_enable_ppp_error_interrupt(hdev, HCLGE_PPP_CMD0_INT_CMD,
+	ret = hclge_config_ppp_error_interrupt(hdev, HCLGE_PPP_CMD0_INT_CMD,
 					       en);
-	if (ret) {
-		dev_err(dev,
-			"failed(%d) to enable/disable PPP error intr 0,1\n",
-			ret);
+	if (ret)
 		return ret;
-	}
 
-	ret = hclge_enable_ppp_error_interrupt(hdev, HCLGE_PPP_CMD1_INT_CMD,
+	ret = hclge_config_ppp_error_interrupt(hdev, HCLGE_PPP_CMD1_INT_CMD,
 					       en);
-	if (ret)
-		dev_err(dev,
-			"failed(%d) to enable/disable PPP error intr 2,3\n",
-			ret);
 
 	return ret;
 }
 
-int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en)
+int hclge_config_tm_hw_err_int(struct hclge_dev *hdev, bool en)
 {
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc;
 	int ret;
 
-	/* enable TM SCH hw errors */
+	/* configure TM SCH hw errors */
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_TM_SCH_ECC_INT_EN, false);
 	if (en)
 		desc.data[0] = cpu_to_le32(HCLGE_TM_SCH_ECC_ERR_INT_EN);
@@ -573,15 +555,15 @@ int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en)
 
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret) {
-		dev_err(dev, "failed(%d) to configure TM SCH errors\n", ret);
+		dev_err(dev, "fail(%d) to configure TM SCH errors\n", ret);
 		return ret;
 	}
 
-	/* enable TM QCN hw errors */
+	/* configure TM QCN hw errors */
 	ret = hclge_cmd_query_error(hdev, &desc, HCLGE_TM_QCN_MEM_INT_CFG,
 				    0, 0, 0);
 	if (ret) {
-		dev_err(dev, "failed(%d) to read TM QCN CFG status\n", ret);
+		dev_err(dev, "fail(%d) to read TM QCN CFG status\n", ret);
 		return ret;
 	}
 
@@ -594,7 +576,7 @@ int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en)
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret)
 		dev_err(dev,
-			"failed(%d) to configure TM QCN mem errors\n", ret);
+			"fail(%d) to configure TM QCN mem errors\n", ret);
 
 	return ret;
 }
@@ -602,39 +584,36 @@ int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en)
 static const struct hclge_hw_blk hw_blk[] = {
 	{
 	  .msk = BIT(0), .name = "IGU_EGU",
-	  .enable_error = hclge_enable_igu_egu_error,
+	  .config_err_int = hclge_config_igu_egu_hw_err_int,
 	},
 	{
 	  .msk = BIT(1), .name = "PPP",
-	  .enable_error = hclge_enable_ppp_error,
+	  .config_err_int = hclge_config_ppp_hw_err_int,
 	},
 	{
 	  .msk = BIT(4), .name = "TM",
-	  .enable_error = hclge_enable_tm_hw_error,
+	  .config_err_int = hclge_config_tm_hw_err_int,
 	},
 	{
 	  .msk = BIT(5), .name = "COMMON",
-	  .enable_error = hclge_enable_common_error,
+	  .config_err_int = hclge_config_common_hw_err_int,
 	},
 	{ /* sentinel */ }
 };
 
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state)
 {
-	struct device *dev = &hdev->pdev->dev;
 	int ret = 0;
 	int i = 0;
 
 	while (hw_blk[i].name) {
-		if (!hw_blk[i].enable_error) {
+		if (!hw_blk[i].config_err_int) {
 			i++;
 			continue;
 		}
-		ret = hw_blk[i].enable_error(hdev, state);
-		if (ret) {
-			dev_err(dev, "fail(%d) to en/disable err int\n", ret);
+		ret = hw_blk[i].config_err_int(hdev, state);
+		if (ret)
 			return ret;
-		}
 		i++;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index 1c5514d..856374c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -50,7 +50,7 @@ enum hclge_err_int_type {
 struct hclge_hw_blk {
 	u32 msk;
 	const char *name;
-	int (*enable_error)(struct hclge_dev *hdev, bool en);
+	int (*config_err_int)(struct hclge_dev *hdev, bool en);
 };
 
 struct hclge_hw_error {
@@ -59,6 +59,6 @@ struct hclge_hw_error {
 };
 
 int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state);
-int hclge_enable_tm_hw_error(struct hclge_dev *hdev, bool en);
+int hclge_config_tm_hw_err_int(struct hclge_dev *hdev, bool en);
 pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 8432c84..5cea95c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7408,7 +7408,7 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 	/* Re-enable the TM hw error interrupts because
 	 * they get disabled on core/global reset.
 	 */
-	if (hclge_enable_tm_hw_error(hdev, true))
+	if (hclge_config_tm_hw_err_int(hdev, true))
 		dev_err(&pdev->dev, "failed to enable TM hw error interrupts\n");
 
 	hclge_reset_vport_state(hdev);
-- 
2.7.4


