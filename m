Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48507C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2FD2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2FD2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeICOnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:43:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeICOnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:43:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 648176D79E4E2;
        Mon,  3 Sep 2018 18:23:30 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:23:21 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 11/11] net: hns3: Refine hns3_get_link_ksettings()
Date:   Mon, 3 Sep 2018 11:21:56 +0100
Message-ID: <20180903102156.18676-12-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180903102156.18676-1-salil.mehta@huawei.com>
References: <20180903102156.18676-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In the previous implement, the query operation for fibre port and copper
port are mixed. This patch refines it by seperating them based on the port
type.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 68 +++++++++++++---------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 41d817d..3019007 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -546,26 +546,56 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
-	u32 flowctrl_adv = 0;
+	const struct hnae3_ae_ops *ops;
 	u8 link_stat;
 
 	if (!h->ae_algo || !h->ae_algo->ops)
 		return -EOPNOTSUPP;
 
-	/* 1.auto_neg & speed & duplex from cmd */
-	if (netdev->phydev) {
+	ops = h->ae_algo->ops;
+	if (ops->get_port_type)
+		ops->get_port_type(h, &cmd->base.port);
+	else
+		return -EOPNOTSUPP;
+
+	switch (cmd->base.port) {
+	case PORT_FIBRE:
+		/* 1.auto_neg & speed & duplex from cmd */
+		if (ops->get_ksettings_an_result)
+			ops->get_ksettings_an_result(h,
+						     &cmd->base.autoneg,
+						     &cmd->base.speed,
+						     &cmd->base.duplex);
+		else
+			return -EOPNOTSUPP;
+
+		/* 2.get link mode*/
+		if (ops->get_link_mode)
+			ops->get_link_mode(h,
+					   cmd->link_modes.supported,
+					   cmd->link_modes.advertising);
+
+		/* 3.mdix_ctrl&mdix get from phy reg */
+		if (ops->get_mdix_mode)
+			ops->get_mdix_mode(h, &cmd->base.eth_tp_mdix_ctrl,
+					   &cmd->base.eth_tp_mdix);
+
+		break;
+	case PORT_TP:
+		if (!netdev->phydev)
+			return -EOPNOTSUPP;
+
 		phy_ethtool_ksettings_get(netdev->phydev, cmd);
 
+		break;
+	default:
+		netdev_warn(netdev,
+			    "Unknown port type, neither Fibre/Copper detected");
 		return 0;
 	}
 
-	if (h->ae_algo->ops->get_ksettings_an_result)
-		h->ae_algo->ops->get_ksettings_an_result(h,
-							 &cmd->base.autoneg,
-							 &cmd->base.speed,
-							 &cmd->base.duplex);
-	else
-		return -EOPNOTSUPP;
+	/* mdio_support */
+	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C22;
 
 	link_stat = hns3_get_link(netdev);
 	if (!link_stat) {
@@ -573,24 +603,6 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 
-	/* 2.get link mode and port type*/
-	if (h->ae_algo->ops->get_link_mode)
-		h->ae_algo->ops->get_link_mode(h,
-					       cmd->link_modes.supported,
-					       cmd->link_modes.advertising);
-
-	cmd->base.port = PORT_NONE;
-	if (h->ae_algo->ops->get_port_type)
-		h->ae_algo->ops->get_port_type(h,
-					       &cmd->base.port);
-
-	/* 3.mdix_ctrl&mdix get from phy reg */
-	if (h->ae_algo->ops->get_mdix_mode)
-		h->ae_algo->ops->get_mdix_mode(h, &cmd->base.eth_tp_mdix_ctrl,
-					       &cmd->base.eth_tp_mdix);
-	/* 4.mdio_support */
-	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C22;
-
 	return 0;
 }
 
-- 
2.7.4


