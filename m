Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC8C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835F52084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfBBOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:42:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727713AbfBBOkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:53 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95DF2836A4E8A0802D03;
        Sat,  2 Feb 2019 22:40:50 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.97.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 2 Feb 2019 22:40:44 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: Modify parameter type from int to bool in set_gro_en
Date:   Sat, 2 Feb 2019 22:39:28 +0800
Message-ID: <20190202143937.8924-4-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190202143937.8924-1-tanhuazhong@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.97.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

The second parameter to the hook function set_gro_en is always passed in
true/false, so modify it's type from int to bool.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  2 +-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 26 +++++++------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  2 +-
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index e05b4926feb2..10f1cc2ba157 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -461,7 +461,7 @@ struct hnae3_ae_ops {
 	bool (*get_hw_reset_stat)(struct hnae3_handle *handle);
 	bool (*ae_dev_resetting)(struct hnae3_handle *handle);
 	unsigned long (*ae_dev_reset_cnt)(struct hnae3_handle *handle);
-	int (*set_gro_en)(struct hnae3_handle *handle, int enable);
+	int (*set_gro_en)(struct hnae3_handle *handle, bool enable);
 	u16 (*get_global_queue_id)(struct hnae3_handle *handle, u16 queue_id);
 	void (*set_timer_task)(struct hnae3_handle *handle, bool enable);
 	int (*mac_connect_phy)(struct hnae3_handle *handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index bc571b3d8ddc..db06d36d408f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1349,6 +1349,7 @@ static int hns3_nic_set_features(struct net_device *netdev,
 	netdev_features_t changed = netdev->features ^ features;
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
+	bool enable;
 	int ret;
 
 	if (changed & (NETIF_F_TSO | NETIF_F_TSO6)) {
@@ -1359,38 +1360,29 @@ static int hns3_nic_set_features(struct net_device *netdev,
 	}
 
 	if (changed & (NETIF_F_GRO_HW) && h->ae_algo->ops->set_gro_en) {
-		if (features & NETIF_F_GRO_HW)
-			ret = h->ae_algo->ops->set_gro_en(h, true);
-		else
-			ret = h->ae_algo->ops->set_gro_en(h, false);
+		enable = !!(features & NETIF_F_GRO_HW);
+		ret = h->ae_algo->ops->set_gro_en(h, enable);
 		if (ret)
 			return ret;
 	}
 
 	if ((changed & NETIF_F_HW_VLAN_CTAG_FILTER) &&
 	    h->ae_algo->ops->enable_vlan_filter) {
-		if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
-			h->ae_algo->ops->enable_vlan_filter(h, true);
-		else
-			h->ae_algo->ops->enable_vlan_filter(h, false);
+		enable = !!(features & NETIF_F_HW_VLAN_CTAG_FILTER);
+		h->ae_algo->ops->enable_vlan_filter(h, enable);
 	}
 
 	if ((changed & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    h->ae_algo->ops->enable_hw_strip_rxvtag) {
-		if (features & NETIF_F_HW_VLAN_CTAG_RX)
-			ret = h->ae_algo->ops->enable_hw_strip_rxvtag(h, true);
-		else
-			ret = h->ae_algo->ops->enable_hw_strip_rxvtag(h, false);
-
+		enable = !!(features & NETIF_F_HW_VLAN_CTAG_RX);
+		ret = h->ae_algo->ops->enable_hw_strip_rxvtag(h, enable);
 		if (ret)
 			return ret;
 	}
 
 	if ((changed & NETIF_F_NTUPLE) && h->ae_algo->ops->enable_fd) {
-		if (features & NETIF_F_NTUPLE)
-			h->ae_algo->ops->enable_fd(h, true);
-		else
-			h->ae_algo->ops->enable_fd(h, false);
+		enable = !!(features & NETIF_F_NTUPLE);
+		h->ae_algo->ops->enable_fd(h, enable);
 	}
 
 	netdev->features = features;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 52fc57284be8..9630bbce5932 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7989,7 +7989,7 @@ static void hclge_get_link_mode(struct hnae3_handle *handle,
 	}
 }
 
-static int hclge_gro_en(struct hnae3_handle *handle, int enable)
+static int hclge_gro_en(struct hnae3_handle *handle, bool enable)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b9cdbd5dd6cb..bc2f29e67280 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2550,7 +2550,7 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 	hdev->hw.mac.duplex = duplex;
 }
 
-static int hclgevf_gro_en(struct hnae3_handle *handle, int enable)
+static int hclgevf_gro_en(struct hnae3_handle *handle, bool enable)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
-- 
2.20.1


