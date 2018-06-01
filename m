Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeFAQ5w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:57:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752429AbeFAQxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:53:55 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 03/11] net: hns3: Add repeat address checking for setting mac address
Date: Fri, 1 Jun 2018 17:52:03 +0100
Message-ID: <20180601165211.46372-4-salil.mehta@huawei.com>
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

Add checking for new mac address. It doesn't need to config
the mac vlan table if it's already in use.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 0a6876a..fe54564 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1132,6 +1132,12 @@ static int hns3_nic_net_set_mac_address(struct net_device *netdev, void *p)
 	if (!mac_addr || !is_valid_ether_addr((const u8 *)mac_addr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	if (ether_addr_equal(netdev->dev_addr, mac_addr->sa_data)) {
+		netdev_info(netdev, "already using mac address %pM\n",
+			    mac_addr->sa_data);
+		return 0;
+	}
+
 	ret = h->ae_algo->ops->set_mac_addr(h, mac_addr->sa_data, false);
 	if (ret) {
 		netdev_err(netdev, "set_mac_address fail, ret=%d!\n", ret);
-- 
2.7.4
