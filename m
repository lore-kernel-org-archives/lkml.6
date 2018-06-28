Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD5FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8E25963
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B8E25963
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeF1DlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:41:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753198AbeF1DlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7D2D84E0064E5;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:52 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 03/11] net: hns3: add vector status check before free vector
Date:   Thu, 28 Jun 2018 12:12:21 +0800
Message-ID: <1530159149-122284-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
References: <1530159149-122284-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hdev->vector_status[vector_id] is already HCLGE_INVALID_VPORT,
should log the error and return.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 6 ++++++
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index d318d35..2b903f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2614,6 +2614,12 @@ static irqreturn_t hclge_misc_irq_handle(int irq, void *data)
 
 static void hclge_free_vector(struct hclge_dev *hdev, int vector_id)
 {
+	if (hdev->vector_status[vector_id] == HCLGE_INVALID_VPORT) {
+		dev_warn(&hdev->pdev->dev,
+			 "vector(vector_id %d) has been freed.\n", vector_id);
+		return;
+	}
+
 	hdev->vector_status[vector_id] = HCLGE_INVALID_VPORT;
 	hdev->num_msi_left += 1;
 	hdev->num_msi_used -= 1;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 3a8d7e0..1eb61c1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -330,6 +330,12 @@ static int hclgevf_set_handle_info(struct hclgevf_dev *hdev)
 
 static void hclgevf_free_vector(struct hclgevf_dev *hdev, int vector_id)
 {
+	if (hdev->vector_status[vector_id] == HCLGEVF_INVALID_VPORT) {
+		dev_warn(&hdev->pdev->dev,
+			 "vector(vector_id %d) has been freed.\n", vector_id);
+		return;
+	}
+
 	hdev->vector_status[vector_id] = HCLGEVF_INVALID_VPORT;
 	hdev->num_msi_left += 1;
 	hdev->num_msi_used -= 1;
-- 
2.9.3

