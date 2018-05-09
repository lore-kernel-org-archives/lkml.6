Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965588AbeEIQ0Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:26:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965532AbeEIQ0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:26:22 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net-next 1/4] net: hns3: Fix for setting mac address when resetting
Date: Wed, 9 May 2018 17:24:38 +0100
Message-ID: <20180509162441.18068-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180509162441.18068-1-salil.mehta@huawei.com>
References: <20180509162441.18068-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

When hns3_init_mac_addr is called during reset process, it will
get the mac address from NCL_CONFIG and set it to hardware. If
user has changed the mac address, then the mac address set by
user is lost during resetting.

This patch fixes it by not getting the mac address from NCL_CONFIG
when resetting.

Fixes: 424eb834a9be ("net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 729bcab..a55c8f515 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3046,13 +3046,13 @@ int hns3_uninit_all_ring(struct hns3_nic_priv *priv)
 }
 
 /* Set mac addr if it is configured. or leave it to the AE driver */
-static void hns3_init_mac_addr(struct net_device *netdev)
+static void hns3_init_mac_addr(struct net_device *netdev, bool init)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
 	u8 mac_addr_temp[ETH_ALEN];
 
-	if (h->ae_algo->ops->get_mac_addr) {
+	if (h->ae_algo->ops->get_mac_addr && init) {
 		h->ae_algo->ops->get_mac_addr(h, mac_addr_temp);
 		ether_addr_copy(netdev->dev_addr, mac_addr_temp);
 	}
@@ -3106,7 +3106,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	handle->kinfo.netdev = netdev;
 	handle->priv = (void *)priv;
 
-	hns3_init_mac_addr(netdev);
+	hns3_init_mac_addr(netdev, true);
 
 	hns3_set_default_feature(netdev);
 
@@ -3353,7 +3353,7 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
-	hns3_init_mac_addr(netdev);
+	hns3_init_mac_addr(netdev, false);
 	hns3_nic_set_rx_mode(netdev);
 	hns3_recover_hw_addr(netdev);
 
-- 
2.7.4
