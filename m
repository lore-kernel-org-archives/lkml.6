Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F0B20643
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfBTCdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:33:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730324AbfBTCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:33:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D1D186B13EDAE7272D4;
        Wed, 20 Feb 2019 10:33:37 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 10:33:29 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "Huazhong Tan" <tanhuazhong@huawei.com>
Subject: [Patch net-next 04/12] net: hns3: fix port info query issue for copper port
Date:   Wed, 20 Feb 2019 10:32:43 +0800
Message-ID: <1550629971-23999-5-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
References: <1550629971-23999-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In original codes, for copper port which doesn't connect to phy,
it always returns -EOPNOTSUPP when query port information. This
patch fixes it by return the port information of MAC.

Fixes: 5f373b158523 ("net: hns3: Fix speed/duplex information loss problem when executing ethtool ethx cmd of VF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  9 +++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 38 +++++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  4 +++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    | 17 ++--------
 4 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 63f5f56..d94c90a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -621,12 +621,11 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		hns3_get_ksettings(h, cmd);
 		break;
 	case HNAE3_MEDIA_TYPE_COPPER:
-		if (!netdev->phydev)
-			return -EOPNOTSUPP;
-
 		cmd->base.port = PORT_TP;
-		phy_ethtool_ksettings_get(netdev->phydev, cmd);
-
+		if (!netdev->phydev)
+			hns3_get_ksettings(h, cmd);
+		else
+			phy_ethtool_ksettings_get(netdev->phydev, cmd);
 		break;
 	default:
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 9a442f3..87edac4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -862,14 +862,44 @@ static void hclge_parse_fiber_link_mode(struct hclge_dev *hdev,
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
 }
 
+static void hclge_parse_copper_link_mode(struct hclge_dev *hdev,
+					 u8 speed_ability)
+{
+	unsigned long *supported = hdev->hw.mac.supported;
+
+	/* default to support all speed for GE port */
+	if (!speed_ability)
+		speed_ability = HCLGE_SUPPORT_GE;
+
+	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 supported);
+
+	if (speed_ability & HCLGE_SUPPORT_100M_BIT) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				 supported);
+	}
+
+	if (speed_ability & HCLGE_SUPPORT_10M_BIT) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
+	}
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+}
+
 static void hclge_parse_link_mode(struct hclge_dev *hdev, u8 speed_ability)
 {
 	u8 media_type = hdev->hw.mac.media_type;
 
-	if (media_type != HNAE3_MEDIA_TYPE_FIBER)
-		return;
-
-	hclge_parse_fiber_link_mode(hdev, speed_ability);
+	if (media_type == HNAE3_MEDIA_TYPE_FIBER)
+		hclge_parse_fiber_link_mode(hdev, speed_ability);
+	else if (media_type == HNAE3_MEDIA_TYPE_COPPER)
+		hclge_parse_copper_link_mode(hdev, speed_ability);
 }
 
 static void hclge_parse_cfg(struct hclge_cfg *cfg, struct hclge_desc *desc)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index c939f4a..3303919 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -188,6 +188,10 @@ enum HLCGE_PORT_TYPE {
 #define HCLGE_SUPPORT_25G_BIT		BIT(2)
 #define HCLGE_SUPPORT_50G_BIT		BIT(3)
 #define HCLGE_SUPPORT_100G_BIT		BIT(4)
+#define HCLGE_SUPPORT_100M_BIT		BIT(6)
+#define HCLGE_SUPPORT_10M_BIT		BIT(7)
+#define HCLGE_SUPPORT_GE \
+	(HCLGE_SUPPORT_1G_BIT | HCLGE_SUPPORT_100M_BIT | HCLGE_SUPPORT_10M_BIT)
 
 enum HCLGE_DEV_STATE {
 	HCLGE_STATE_REINITING,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 84f2878..48eda2c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -8,12 +8,6 @@
 #include "hclge_main.h"
 #include "hclge_mdio.h"
 
-#define HCLGE_PHY_SUPPORTED_FEATURES	(SUPPORTED_Autoneg | \
-					 SUPPORTED_TP | \
-					 PHY_10BT_FEATURES | \
-					 PHY_100BT_FEATURES | \
-					 SUPPORTED_1000baseT_Full)
-
 enum hclge_mdio_c22_op_seq {
 	HCLGE_MDIO_C22_WRITE = 1,
 	HCLGE_MDIO_C22_READ = 2
@@ -217,16 +211,9 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
 		return ret;
 	}
 
-	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, mask);
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       mask);
-	linkmode_set_bit_array(phy_gbit_features_array,
-			       ARRAY_SIZE(phy_gbit_features_array),
-			       mask);
+	linkmode_copy(mask, hdev->hw.mac.supported);
 	linkmode_and(phydev->supported, phydev->supported, mask);
-	phy_support_asym_pause(phydev);
+	linkmode_copy(phydev->advertising, phydev->supported);
 
 	return 0;
 }
-- 
2.7.4

