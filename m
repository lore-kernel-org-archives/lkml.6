Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27870C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53B8253FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53B8253FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeF1DoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:44:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753002AbeF1DlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:41:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 296ABF0E09C8C;
        Thu, 28 Jun 2018 11:40:58 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 11:40:52 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: rename the interface for init_client_instance and uninit_client_instance
Date:   Thu, 28 Jun 2018 12:12:20 +0800
Message-ID: <1530159149-122284-3-git-send-email-lipeng321@huawei.com>
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

The interface init_client_instance and uninit_client_instance
do not register anything, only initialize the client instance.
This patch rename the related interface to make the function
name to indicate the purpose.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 31 +++++++---------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b3d8237..3a8d7e0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1586,9 +1586,10 @@ static void hclgevf_misc_irq_uninit(struct hclgevf_dev *hdev)
 	hclgevf_free_vector(hdev, 0);
 }
 
-static int hclgevf_init_instance(struct hclgevf_dev *hdev,
-				 struct hnae3_client *client)
+static int hclgevf_init_client_instance(struct hnae3_client *client,
+					struct hnae3_ae_dev *ae_dev)
 {
+	struct hclgevf_dev *hdev = ae_dev->priv;
 	int ret;
 
 	switch (client->type) {
@@ -1639,9 +1640,11 @@ static int hclgevf_init_instance(struct hclgevf_dev *hdev,
 	return 0;
 }
 
-static void hclgevf_uninit_instance(struct hclgevf_dev *hdev,
-				    struct hnae3_client *client)
+static void hclgevf_uninit_client_instance(struct hnae3_client *client,
+					   struct hnae3_ae_dev *ae_dev)
 {
+	struct hclgevf_dev *hdev = ae_dev->priv;
+
 	/* un-init roce, if it exists */
 	if (hdev->roce_client)
 		hdev->roce_client->ops->uninit_instance(&hdev->roce, 0);
@@ -1652,22 +1655,6 @@ static void hclgevf_uninit_instance(struct hclgevf_dev *hdev,
 		client->ops->uninit_instance(&hdev->nic, 0);
 }
 
-static int hclgevf_register_client(struct hnae3_client *client,
-				   struct hnae3_ae_dev *ae_dev)
-{
-	struct hclgevf_dev *hdev = ae_dev->priv;
-
-	return hclgevf_init_instance(hdev, client);
-}
-
-static void hclgevf_unregister_client(struct hnae3_client *client,
-				      struct hnae3_ae_dev *ae_dev)
-{
-	struct hclgevf_dev *hdev = ae_dev->priv;
-
-	hclgevf_uninit_instance(hdev, client);
-}
-
 static int hclgevf_pci_init(struct hclgevf_dev *hdev)
 {
 	struct pci_dev *pdev = hdev->pdev;
@@ -1928,8 +1915,8 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 static const struct hnae3_ae_ops hclgevf_ops = {
 	.init_ae_dev = hclgevf_init_ae_dev,
 	.uninit_ae_dev = hclgevf_uninit_ae_dev,
-	.init_client_instance = hclgevf_register_client,
-	.uninit_client_instance = hclgevf_unregister_client,
+	.init_client_instance = hclgevf_init_client_instance,
+	.uninit_client_instance = hclgevf_uninit_client_instance,
 	.start = hclgevf_ae_start,
 	.stop = hclgevf_ae_stop,
 	.map_ring_to_vector = hclgevf_map_ring_to_vector,
-- 
2.9.3

