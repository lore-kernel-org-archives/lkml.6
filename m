Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753417AbeFAQz4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:55:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753199AbeFAQyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:54:01 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 04/11] net: hns3: Fix setting mac address error
Date: Fri, 1 Jun 2018 17:52:04 +0100
Message-ID: <20180601165211.46372-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180601165211.46372-1-salil.mehta@huawei.com>
References: <20180601165211.46372-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

When doing function reset or insmod hns3 dirver after rmmod,
the entries of mac vlan table are not cleared, which may cause
init mac address failed. This patch fixes it by clearing the
old mac address when doing function reset or rmmod hns3 driver.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index fe54564..235eea1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3007,6 +3007,15 @@ static void hns3_init_mac_addr(struct net_device *netdev, bool init)
 
 }
 
+static void hns3_uninit_mac_addr(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+
+	if (h->ae_algo->ops->rm_uc_addr)
+		h->ae_algo->ops->rm_uc_addr(h, netdev->dev_addr);
+}
+
 static void hns3_nic_set_priv_ops(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -3135,6 +3144,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	priv->ring_data = NULL;
 
+	hns3_uninit_mac_addr(netdev);
+
 	free_netdev(netdev);
 }
 
@@ -3451,6 +3462,8 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 
 	priv->ring_data = NULL;
 
+	hns3_uninit_mac_addr(netdev);
+
 	return ret;
 }
 
-- 
2.7.4
