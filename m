Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935017AbeCHChG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:37:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934885AbeCHCfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:02 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 19/23] {topost} net: hns3: fix for loopback failure when vlan filter is enable
Date: Thu, 8 Mar 2018 11:06:44 +0800
Message-ID: <1520478408-116992-20-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When vlan ctag filter is enabled, the loopback selftest fails because
loopback selftest does not support vlan.

This patch fixes it by disabling the vlan ctag filter when runnig
loopback selftest.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 26274bc..2db127c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -309,6 +309,9 @@ static void hns3_self_test(struct net_device *ndev,
 	struct hnae3_handle *h = priv->ae_handle;
 	int st_param[HNS3_SELF_TEST_TPYE_NUM][2];
 	bool if_running = netif_running(ndev);
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	bool dis_vlan_filter;
+#endif
 	int test_index = 0;
 	u32 i;
 
@@ -323,6 +326,14 @@ static void hns3_self_test(struct net_device *ndev,
 	if (if_running)
 		dev_close(ndev);
 
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	/* Disable the vlan filter for selftest does not support it */
+	dis_vlan_filter = (ndev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+				h->ae_algo->ops->enable_vlan_filter;
+	if (dis_vlan_filter)
+		h->ae_algo->ops->enable_vlan_filter(h, false);
+#endif
+
 	set_bit(HNS3_NIC_STATE_TESTING, &priv->state);
 
 	for (i = 0; i < HNS3_SELF_TEST_TPYE_NUM; i++) {
@@ -345,6 +356,11 @@ static void hns3_self_test(struct net_device *ndev,
 
 	clear_bit(HNS3_NIC_STATE_TESTING, &priv->state);
 
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	if (dis_vlan_filter)
+		h->ae_algo->ops->enable_vlan_filter(h, true);
+#endif
+
 	if (if_running)
 		dev_open(ndev);
 }
-- 
2.9.3
