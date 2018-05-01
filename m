Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756754AbeEAS6v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756652AbeEAS6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:10 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 5/9] net: hns3: fix for phy_addr error in hclge_mac_mdio_config
Date: Tue, 1 May 2018 19:56:01 +0100
Message-ID: <20180501185605.9584-6-salil.mehta@huawei.com>
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

From: Huazhong Tan <tanhuazhong@huawei.com>

When phy exists, phy_addr must less than PHY_MAX_ADDR.
If not, hclge_mac_mdio_config should return error.
And for fiber(phy_addr=0xff), it does not need hclge_mac_mdio_config.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 12 +++++++-----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c |  7 +++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b5e0c58..cc09713 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5503,11 +5503,13 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_sriov_disable;
 	}
 
-	ret = hclge_mac_mdio_config(hdev);
-	if (ret) {
-		dev_warn(&hdev->pdev->dev,
-			 "mdio config fail ret=%d\n", ret);
-		goto err_sriov_disable;
+	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		ret = hclge_mac_mdio_config(hdev);
+		if (ret) {
+			dev_err(&hdev->pdev->dev,
+				"mdio config fail ret=%d\n", ret);
+			goto err_sriov_disable;
+		}
 	}
 
 	ret = hclge_mac_init(hdev);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 682c2d6..9f7932e42 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -140,8 +140,11 @@ int hclge_mac_mdio_config(struct hclge_dev *hdev)
 	struct mii_bus *mdio_bus;
 	int ret;
 
-	if (hdev->hw.mac.phy_addr >= PHY_MAX_ADDR)
-		return 0;
+	if (hdev->hw.mac.phy_addr >= PHY_MAX_ADDR) {
+		dev_err(&hdev->pdev->dev, "phy_addr(%d) is too large.\n",
+			hdev->hw.mac.phy_addr);
+		return -EINVAL;
+	}
 
 	mdio_bus = devm_mdiobus_alloc(&hdev->pdev->dev);
 	if (!mdio_bus)
-- 
2.7.4
