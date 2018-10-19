Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57537ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320B62148E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320B62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJTDYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:24:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727680AbeJTDYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:24:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 329A578EB2AF8;
        Sat, 20 Oct 2018 03:17:12 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 20 Oct 2018 03:17:03 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 3/7] net: hns3: Add support to enable and disable hw errors
Date:   Fri, 19 Oct 2018 20:15:28 +0100
Message-ID: <20181019191532.10088-4-salil.mehta@huawei.com>
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

This patch adds functions to enable and disable hw errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 22 ++++++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h |  2 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 83aca6f..d2640d1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -7,6 +7,28 @@ static const struct hclge_hw_blk hw_blk[] = {
 	{ /* sentinel */ }
 };
 
+int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state)
+{
+	struct device *dev = &hdev->pdev->dev;
+	int ret = 0;
+	int i = 0;
+
+	while (hw_blk[i].name) {
+		if (!hw_blk[i].enable_error) {
+			i++;
+			continue;
+		}
+		ret = hw_blk[i].enable_error(hdev, state);
+		if (ret) {
+			dev_err(dev, "fail(%d) to en/disable err int\n", ret);
+			return ret;
+		}
+		i++;
+	}
+
+	return ret;
+}
+
 pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev)
 {
 	struct hclge_dev *hdev = ae_dev->priv;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
index ea1637c..373e9bf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.h
@@ -21,9 +21,11 @@ enum hclge_err_int_type {
 struct hclge_hw_blk {
 	u32 msk;
 	const char *name;
+	int (*enable_error)(struct hclge_dev *hdev, bool en);
 	void (*process_error)(struct hclge_dev *hdev,
 			      enum hclge_err_int_type type);
 };
 
+int hclge_hw_error_set_state(struct hclge_dev *hdev, bool state);
 pci_ers_result_t hclge_process_ras_hw_error(struct hnae3_ae_dev *ae_dev);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5075365..082ea97 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6759,6 +6759,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_mdiobus_unreg;
 	}
 
+	ret = hclge_hw_error_set_state(hdev, true);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"hw error interrupts enable failed, ret =%d\n", ret);
+		goto err_mdiobus_unreg;
+	}
+
 	hclge_dcb_ops_set(hdev);
 
 	timer_setup(&hdev->service_timer, hclge_service_timer, 0);
@@ -6896,6 +6903,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	hclge_enable_vector(&hdev->misc_vector, false);
 	synchronize_irq(hdev->misc_vector.vector_irq);
 
+	hclge_hw_error_set_state(hdev, false);
 	hclge_destroy_cmd_queue(&hdev->hw);
 	hclge_misc_irq_uninit(hdev);
 	hclge_pci_uninit(hdev);
-- 
2.7.4


