Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8807321B1A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405586AbfBNDsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:48:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405156AbfBNDsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:48:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0A492B3E2310A5137E49;
        Thu, 14 Feb 2019 11:48:44 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 11:48:35 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH net-next 2/2] net: hns3: add fixup handle for hns3 driver
Date:   Thu, 14 Feb 2019 12:31:07 +0800
Message-ID: <1550118667-119947-3-git-send-email-shenjian15@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default led configuration of marvell 88E1510 is not fit
for hns3 driver, this patch fixes it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 84f2878..4c8346e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2016-2017 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
+#include <linux/marvell_phy.h>
 #include <linux/kernel.h>
 
 #include "hclge_cmd.h"
@@ -125,6 +126,13 @@ static int hclge_mdio_read(struct mii_bus *bus, int phyid, int regnum)
 	return le16_to_cpu(mdio_cmd->data_rd);
 }
 
+static int hclge_phy_marvell_fixup(struct phy_device *phydev)
+{
+	phydev->dev_flags |= MARVELL_PHY_M1510_HNS3_LEDS;
+
+	return 0;
+}
+
 int hclge_mac_mdio_config(struct hclge_dev *hdev)
 {
 	struct hclge_mac *mac = &hdev->hw.mac;
@@ -168,6 +176,15 @@ int hclge_mac_mdio_config(struct hclge_dev *hdev)
 	mac->phydev = phydev;
 	mac->mdio_bus = mdio_bus;
 
+	/* register the PHY board fixup (for Marvell 88E1510) */
+	ret = phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1510,
+					 MARVELL_PHY_ID_MASK,
+					 hclge_phy_marvell_fixup);
+	/* we can live without it, so just issue a warning */
+	if (ret)
+		dev_warn(&hdev->pdev->dev,
+			 "Cannot register PHY board fixup\n");
+
 	return 0;
 }
 
@@ -240,6 +257,8 @@ void hclge_mac_disconnect_phy(struct hnae3_handle *handle)
 	if (!phydev)
 		return;
 
+	phy_unregister_fixup_for_uid(MARVELL_PHY_ID_88E1510,
+				     MARVELL_PHY_ID_MASK);
 	phy_disconnect(phydev);
 }
 
-- 
1.9.1

