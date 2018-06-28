Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3E6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A8925E2D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A8925E2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeF1DlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:41:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753203AbeF1DlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9934686500677;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:53 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 07/11] net: hns3: extraction an interface for state init|uninit
Date:   Thu, 28 Jun 2018 12:12:25 +0800
Message-ID: <1530159149-122284-8-git-send-email-lipeng321@huawei.com>
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

Extraction an interface for state init|uninit to make the code
easier to read.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 42 +++++++++++++---------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2b903f4..805c780 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5568,6 +5568,30 @@ static void hclge_pci_uninit(struct hclge_dev *hdev)
 	pci_disable_device(pdev);
 }
 
+static void hclge_state_init(struct hclge_dev *hdev)
+{
+	set_bit(HCLGE_STATE_SERVICE_INITED, &hdev->state);
+	set_bit(HCLGE_STATE_DOWN, &hdev->state);
+	clear_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state);
+	clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
+	clear_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state);
+	clear_bit(HCLGE_STATE_MBX_HANDLING, &hdev->state);
+}
+
+static void hclge_state_uninit(struct hclge_dev *hdev)
+{
+	set_bit(HCLGE_STATE_DOWN, &hdev->state);
+
+	if (hdev->service_timer.function)
+		del_timer_sync(&hdev->service_timer);
+	if (hdev->service_task.func)
+		cancel_work_sync(&hdev->service_task);
+	if (hdev->rst_service_task.func)
+		cancel_work_sync(&hdev->rst_service_task);
+	if (hdev->mbx_service_task.func)
+		cancel_work_sync(&hdev->mbx_service_task);
+}
+
 static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 {
 	struct pci_dev *pdev = ae_dev->pdev;
@@ -5708,12 +5732,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	/* Enable MISC vector(vector0) */
 	hclge_enable_vector(&hdev->misc_vector, true);
 
-	set_bit(HCLGE_STATE_SERVICE_INITED, &hdev->state);
-	set_bit(HCLGE_STATE_DOWN, &hdev->state);
-	clear_bit(HCLGE_STATE_RST_SERVICE_SCHED, &hdev->state);
-	clear_bit(HCLGE_STATE_RST_HANDLING, &hdev->state);
-	clear_bit(HCLGE_STATE_MBX_SERVICE_SCHED, &hdev->state);
-	clear_bit(HCLGE_STATE_MBX_HANDLING, &hdev->state);
+	hclge_state_init(hdev);
 
 	pr_info("%s driver initialization finished.\n", HCLGE_DRIVER_NAME);
 	return 0;
@@ -5818,16 +5837,7 @@ static void hclge_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
 	struct hclge_dev *hdev = ae_dev->priv;
 	struct hclge_mac *mac = &hdev->hw.mac;
 
-	set_bit(HCLGE_STATE_DOWN, &hdev->state);
-
-	if (hdev->service_timer.function)
-		del_timer_sync(&hdev->service_timer);
-	if (hdev->service_task.func)
-		cancel_work_sync(&hdev->service_task);
-	if (hdev->rst_service_task.func)
-		cancel_work_sync(&hdev->rst_service_task);
-	if (hdev->mbx_service_task.func)
-		cancel_work_sync(&hdev->mbx_service_task);
+	hclge_state_uninit(hdev);
 
 	if (mac->phydev)
 		mdiobus_unregister(mac->mdio_bus);
-- 
2.9.3

