Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98361206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfBWJXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbfBWJXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:19 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B23B98B3A6A800001438;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:01 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [Patch net-next 11/12] net: hns3: fix setting of the hns reset_type for rdma hw errors
Date:   Sat, 23 Feb 2019 17:22:18 +0800
Message-ID: <1550913739-13232-12-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Presently the hns reset_type for the roce errors is set
in the hclge_log_and_clear_rocee_ras_error function.
This function is also called to detect and clear roce errors
while enabling the rdma error interrupts. However there is no hns
reset requested for this case. This can cause issue of wrong
reset_type used with subsequent hns reset as the
reset_type set in the above case was not cleared.

This patch moves setting of hns reset_type for the roce errors from
hclge_log_and_clear_rocee_ras_error function
to hclge_handle_rocee_ras_error.

Fixes: 630ba007f475 ("net: hns3: add handling of RDMA RAS errors")
Reported-by: Huazhong Tan <tanhuazhong@huawei.com>
Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 36 ++++++++++++----------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index b9d363f..1feceff 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1148,10 +1148,10 @@ static int hclge_log_rocee_ovf_error(struct hclge_dev *hdev)
 	return 0;
 }
 
-static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
+static enum hnae3_reset_type
+hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 {
-	enum hnae3_reset_type reset_type = HNAE3_FUNC_RESET;
-	struct hnae3_ae_dev *ae_dev = hdev->ae_dev;
+	enum hnae3_reset_type reset_type = HNAE3_NONE_RESET;
 	struct device *dev = &hdev->pdev->dev;
 	struct hclge_desc desc[2];
 	unsigned int status;
@@ -1164,17 +1164,20 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(dev, "failed(%d) to query ROCEE RAS INT SRC\n", ret);
 		/* reset everything for now */
-		HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
-		return ret;
+		return HNAE3_GLOBAL_RESET;
 	}
 
 	status = le32_to_cpu(desc[0].data[0]);
 
-	if (status & HCLGE_ROCEE_RERR_INT_MASK)
+	if (status & HCLGE_ROCEE_RERR_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS AXI rresp error\n");
+		reset_type = HNAE3_FUNC_RESET;
+	}
 
-	if (status & HCLGE_ROCEE_BERR_INT_MASK)
+	if (status & HCLGE_ROCEE_BERR_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS AXI bresp error\n");
+		reset_type = HNAE3_FUNC_RESET;
+	}
 
 	if (status & HCLGE_ROCEE_ECC_INT_MASK) {
 		dev_warn(dev, "ROCEE RAS 2bit ECC error\n");
@@ -1186,9 +1189,9 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 		if (ret) {
 			dev_err(dev, "failed(%d) to process ovf error\n", ret);
 			/* reset everything for now */
-			HCLGE_SET_DEFAULT_RESET_REQUEST(HNAE3_GLOBAL_RESET);
-			return ret;
+			return HNAE3_GLOBAL_RESET;
 		}
+		reset_type = HNAE3_FUNC_RESET;
 	}
 
 	/* clear error status */
@@ -1197,12 +1200,10 @@ static int hclge_log_and_clear_rocee_ras_error(struct hclge_dev *hdev)
 	if (ret) {
 		dev_err(dev, "failed(%d) to clear ROCEE RAS error\n", ret);
 		/* reset everything for now */
-		reset_type = HNAE3_GLOBAL_RESET;
+		return HNAE3_GLOBAL_RESET;
 	}
 
-	HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type);
-
-	return ret;
+	return reset_type;
 }
 
 static int hclge_config_rocee_ras_interrupt(struct hclge_dev *hdev, bool en)
@@ -1232,15 +1233,18 @@ static int hclge_config_rocee_ras_interrupt(struct hclge_dev *hdev, bool en)
 	return ret;
 }
 
-static int hclge_handle_rocee_ras_error(struct hnae3_ae_dev *ae_dev)
+static void hclge_handle_rocee_ras_error(struct hnae3_ae_dev *ae_dev)
 {
+	enum hnae3_reset_type reset_type = HNAE3_NONE_RESET;
 	struct hclge_dev *hdev = ae_dev->priv;
 
 	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
 	    hdev->pdev->revision < 0x21)
-		return HNAE3_NONE_RESET;
+		return;
 
-	return hclge_log_and_clear_rocee_ras_error(hdev);
+	reset_type = hclge_log_and_clear_rocee_ras_error(hdev);
+	if (reset_type != HNAE3_NONE_RESET)
+		HCLGE_SET_DEFAULT_RESET_REQUEST(reset_type);
 }
 
 static const struct hclge_hw_blk hw_blk[] = {
-- 
2.7.4

