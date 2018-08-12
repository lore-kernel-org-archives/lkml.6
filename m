Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5DBC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3827621943
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 09:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3827621943
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeHLM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 08:26:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727736AbeHLM0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 08:26:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C3F5F70A7DC4;
        Sun, 12 Aug 2018 17:48:34 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.93.119) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 12 Aug 2018 17:48:29 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 3/9] net: hns3: Fix for information of phydev lost problem when down/up
Date:   Sun, 12 Aug 2018 10:47:32 +0100
Message-ID: <20180812094738.14852-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180812094738.14852-1-salil.mehta@huawei.com>
References: <20180812094738.14852-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.93.119]
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

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 24 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    | 25 ++++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |  4 +++-
 3 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 18ae11d8de73..3b7cd6744280 100644
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
index 2065ee2fd358..85a123d40e8b 100644
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
index bb3ce35e0d66..5fbf7dddb5d9 100644
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
2.11.0


