Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D2CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9902086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfARIOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:14:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbfARIN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:13:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0354856CB6145A8982A;
        Fri, 18 Jan 2019 16:13:54 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 18 Jan 2019 16:13:45 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Peng Li <lipeng321@huawei.com>
Subject: [PATCH net-next 12/12] net: hns3: add HNAE3_RESTORE_CLIENT interface in enet module
Date:   Fri, 18 Jan 2019 16:13:14 +0800
Message-ID: <1547799194-38212-13-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
References: <1547799194-38212-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The HNAE3_INIT_CLIENT interface is also used when changing tc
configuration, vlan/mac hardware table does not need to be restored
when tc configuration changes.

This patch adds a HNAE3_RESTORE_CLIENT interface to restore the
vlan/mac hardware table when resetting.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 61 ++++++++++++----------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  4 ++
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  2 +-
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 81d1585..d486748 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -124,6 +124,7 @@ enum hnae3_reset_notify_type {
 	HNAE3_DOWN_CLIENT,
 	HNAE3_INIT_CLIENT,
 	HNAE3_UNINIT_CLIENT,
+	HNAE3_RESTORE_CLIENT,
 };
 
 enum hnae3_reset_type {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 10cc865..9dd8949 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4004,35 +4004,8 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 {
 	struct net_device *netdev = handle->kinfo.netdev;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	bool vlan_filter_enable;
 	int ret;
 
-	ret = hns3_init_mac_addr(netdev, false);
-	if (ret)
-		return ret;
-
-	ret = hns3_recover_hw_addr(netdev);
-	if (ret)
-		return ret;
-
-	ret = hns3_update_promisc_mode(netdev, handle->netdev_flags);
-	if (ret)
-		return ret;
-
-	vlan_filter_enable = netdev->flags & IFF_PROMISC ? false : true;
-	hns3_enable_vlan_filter(netdev, vlan_filter_enable);
-
-	/* Hardware table is only clear when pf resets */
-	if (!(handle->flags & HNAE3_SUPPORT_VF)) {
-		ret = hns3_restore_vlan(netdev);
-		if (ret)
-			return ret;
-	}
-
-	ret = hns3_restore_fd_rules(netdev);
-	if (ret)
-		return ret;
-
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
@@ -4070,6 +4043,37 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	return ret;
 }
 
+static int hns3_reset_notify_restore_enet(struct hnae3_handle *handle)
+{
+	struct net_device *netdev = handle->kinfo.netdev;
+	bool vlan_filter_enable;
+	int ret;
+
+	ret = hns3_init_mac_addr(netdev, false);
+	if (ret)
+		return ret;
+
+	ret = hns3_recover_hw_addr(netdev);
+	if (ret)
+		return ret;
+
+	ret = hns3_update_promisc_mode(netdev, handle->netdev_flags);
+	if (ret)
+		return ret;
+
+	vlan_filter_enable = netdev->flags & IFF_PROMISC ? false : true;
+	hns3_enable_vlan_filter(netdev, vlan_filter_enable);
+
+	/* Hardware table is only clear when pf resets */
+	if (!(handle->flags & HNAE3_SUPPORT_VF)) {
+		ret = hns3_restore_vlan(netdev);
+		if (ret)
+			return ret;
+	}
+
+	return hns3_restore_fd_rules(netdev);
+}
+
 static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 {
 	struct net_device *netdev = handle->kinfo.netdev;
@@ -4125,6 +4129,9 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
 	case HNAE3_UNINIT_CLIENT:
 		ret = hns3_reset_notify_uninit_enet(handle);
 		break;
+	case HNAE3_RESTORE_CLIENT:
+		ret = hns3_reset_notify_restore_enet(handle);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 97683a7..00d7acb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2866,6 +2866,10 @@ static void hclge_reset(struct hclge_dev *hdev)
 	if (ret)
 		goto err_reset_lock;
 
+	ret = hclge_notify_client(hdev, HNAE3_RESTORE_CLIENT);
+	if (ret)
+		goto err_reset_lock;
+
 	hclge_clear_reset_cause(hdev);
 
 	ret = hclge_reset_prepare_up(hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 82103d5..bb9f452 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1264,7 +1264,7 @@ static int hclgevf_reset_stack(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	return 0;
+	return hclgevf_notify_client(hdev, HNAE3_RESTORE_CLIENT);
 }
 
 static int hclgevf_reset_prepare_wait(struct hclgevf_dev *hdev)
-- 
2.7.4

