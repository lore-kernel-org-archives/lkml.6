Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65C0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC07216EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC07216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbeHNTCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:02:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732514AbeHNTCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:02:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75996BD1AC84E;
        Wed, 15 Aug 2018 00:14:11 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 15 Aug 2018 00:14:05 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH V2 net-next 3/8] net: hns3: Fix for information of phydev lost problem when down/up
Date:   Tue, 14 Aug 2018 17:13:14 +0100
Message-ID: <20180814161319.16392-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180814161319.16392-1-salil.mehta@huawei.com>
References: <20180814161319.16392-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

Function call of phy_connect_direct will reinitialize phydev. Some
information like advertising will be lost. Phy_connect_direct only
needs to be called once. And driver can run well. This patch adds
some functions to ensure that phy_connect_direct is called only once
to solve the information of phydev lost problem occurring when we stop
the net and open it again.

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 24 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    | 25 ++++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |  4 +++-
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5f30ea4..2e9c8b9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3782,7 +3782,7 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < vport->alloc_tqps; i++)
 		hclge_tqp_enable(hdev, i, 0, true);
@@ -3796,9 +3796,7 @@ static int hclge_ae_start(struct hnae3_handle *handle)
 	/* reset tqp stats */
 	hclge_reset_tqp_stats(handle);
 
-	ret = hclge_mac_start_phy(hdev);
-	if (ret)
-		return ret;
+	hclge_mac_start_phy(hdev);
 
 	return 0;
 }
@@ -5417,6 +5415,16 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 		*tp_mdix = ETH_TP_MDI;
 }
 
+static int hclge_init_instance_hw(struct hclge_dev *hdev)
+{
+	return hclge_mac_connect_phy(hdev);
+}
+
+static void hclge_uninit_instance_hw(struct hclge_dev *hdev)
+{
+	hclge_mac_disconnect_phy(hdev);
+}
+
 static int hclge_init_client_instance(struct hnae3_client *client,
 				      struct hnae3_ae_dev *ae_dev)
 {
@@ -5436,6 +5444,13 @@ static int hclge_init_client_instance(struct hnae3_client *client,
 			if (ret)
 				return ret;
 
+			ret = hclge_init_instance_hw(hdev);
+			if (ret) {
+			        client->ops->uninit_instance(&vport->nic,
+			                                     0);
+			        return ret;
+			}
+
 			if (hdev->roce_client &&
 			    hnae3_dev_roce_supported(hdev)) {
 				struct hnae3_client *rc = hdev->roce_client;
@@ -5498,6 +5513,7 @@ static void hclge_uninit_client_instance(struct hnae3_client *client,
 		if (client->type == HNAE3_CLIENT_ROCE)
 			return;
 		if (client->ops->uninit_instance) {
+			hclge_uninit_instance_hw(hdev);
 			client->ops->uninit_instance(&vport->nic, 0);
 			hdev->nic_client = NULL;
 			vport->nic.client = NULL;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 2065ee2f..85a123d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -193,7 +193,7 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 		netdev_err(netdev, "failed to configure flow control.\n");
 }
 
-int hclge_mac_start_phy(struct hclge_dev *hdev)
+int hclge_mac_connect_phy(struct hclge_dev *hdev)
 {
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
 	struct phy_device *phydev = hdev->hw.mac.phydev;
@@ -213,11 +213,29 @@ int hclge_mac_start_phy(struct hclge_dev *hdev)
 	phydev->supported &= HCLGE_PHY_SUPPORTED_FEATURES;
 	phydev->advertising = phydev->supported;
 
-	phy_start(phydev);
-
 	return 0;
 }
 
+void hclge_mac_disconnect_phy(struct hclge_dev *hdev)
+{
+	struct phy_device *phydev = hdev->hw.mac.phydev;
+
+	if (!phydev)
+		return;
+
+	phy_disconnect(phydev);
+}
+
+void hclge_mac_start_phy(struct hclge_dev *hdev)
+{
+	struct phy_device *phydev = hdev->hw.mac.phydev;
+
+	if (!phydev)
+		return;
+
+	phy_start(phydev);
+}
+
 void hclge_mac_stop_phy(struct hclge_dev *hdev)
 {
 	struct net_device *netdev = hdev->vport[0].nic.netdev;
@@ -227,5 +245,4 @@ void hclge_mac_stop_phy(struct hclge_dev *hdev)
 		return;
 
 	phy_stop(phydev);
-	phy_disconnect(phydev);
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
index bb3ce35..5fbf7dd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h
@@ -5,7 +5,9 @@
 #define __HCLGE_MDIO_H
 
 int hclge_mac_mdio_config(struct hclge_dev *hdev);
-int hclge_mac_start_phy(struct hclge_dev *hdev);
+int hclge_mac_connect_phy(struct hclge_dev *hdev);
+void hclge_mac_disconnect_phy(struct hclge_dev *hdev);
+void hclge_mac_start_phy(struct hclge_dev *hdev);
 void hclge_mac_stop_phy(struct hclge_dev *hdev);
 
 #endif
-- 
2.7.4


