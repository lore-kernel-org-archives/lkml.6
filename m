Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756735AbeEAS6s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756654AbeEAS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:10 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 6/9] net: hns3: Fix to support autoneg only for port attached with phy
Date: Tue, 1 May 2018 19:56:02 +0100
Message-ID: <20180501185605.9584-7-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

This patch adds a check to support autoneg(ethtool -A) only when PHY
is attached with the port.

Fixes: e2cb1dec9779 ("net: hns3: Add HNS3 VF HCL(Hardware Compatibility
Layer) Support")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index cc09713..a4e9991 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5169,12 +5169,6 @@ static int hclge_set_pauseparam(struct hnae3_handle *handle, u32 auto_neg,
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 	u32 fc_autoneg;
 
-	/* Only support flow control negotiation for netdev with
-	 * phy attached for now.
-	 */
-	if (!phydev)
-		return -EOPNOTSUPP;
-
 	fc_autoneg = hclge_get_autoneg(handle);
 	if (auto_neg != fc_autoneg) {
 		dev_info(&hdev->pdev->dev,
@@ -5193,6 +5187,12 @@ static int hclge_set_pauseparam(struct hnae3_handle *handle, u32 auto_neg,
 	if (!fc_autoneg)
 		return hclge_cfg_pauseparam(hdev, rx_en, tx_en);
 
+	/* Only support flow control negotiation for netdev with
+	 * phy attached for now.
+	 */
+	if (!phydev)
+		return -EOPNOTSUPP;
+
 	return phy_start_aneg(phydev);
 }
 
-- 
2.7.4
