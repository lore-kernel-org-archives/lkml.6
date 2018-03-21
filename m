Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeCUHS3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbeCUHST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:19 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 11/11] net: hns3: fix for not returning problem in get_link_ksettings when phy exists
Date: Wed, 21 Mar 2018 15:49:30 +0800
Message-ID: <1521618570-129694-12-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

When phy exists, phy_ethtool_ksettings_get function is enough to get the
link ksettings. If the phy exists, get_link_ksettings function can return
directly after phy_ethtool_ksettings_get is called.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 513d8d6..9d07116 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -569,9 +569,13 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	/* 1.auto_neg & speed & duplex from cmd */
-	if (netdev->phydev)
+	if (netdev->phydev) {
 		phy_ethtool_ksettings_get(netdev->phydev, cmd);
-	else if (h->ae_algo->ops->get_ksettings_an_result)
+
+		return 0;
+	}
+
+	if (h->ae_algo->ops->get_ksettings_an_result)
 		h->ae_algo->ops->get_ksettings_an_result(h,
 							 &cmd->base.autoneg,
 							 &cmd->base.speed,
-- 
2.9.3
