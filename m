Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2F12159F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2F12159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbeIUVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:32:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390678AbeIUVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:32:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41ED74BC6DED3;
        Fri, 21 Sep 2018 23:43:18 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 23:43:12 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 11/12] net: hns3: Fix speed/duplex information loss problem when executing ethtool ethx cmd of VF
Date:   Fri, 21 Sep 2018 16:41:47 +0100
Message-ID: <20180921154148.26756-12-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180921154148.26756-1-salil.mehta@huawei.com>
References: <20180921154148.26756-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

Our VF has not implemented the ops for get_port_type. So when we executing
ethtool ethx cmd of VF, hns3_get_link_ksettings will return directly. And
we can not query anything.

To support get_link_ksettings for VF, this patch replaces get_port_type
with get_media_type. If the media type is HNAE3_MEDIA_TYPE_NONE,
hns3_get_link_ksettings will return link information of VF.

Fixes: 12f46bc1d447 ("net: hns3: Refine hns3_get_link_ksettings()")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 66 +++++++++++++---------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 46701cf..8803a87 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -545,55 +545,67 @@ static int hns3_set_pauseparam(struct net_device *netdev,
 	return -EOPNOTSUPP;
 }
 
+static void hns3_get_ksettings(struct hnae3_handle *h,
+			       struct ethtool_link_ksettings *cmd)
+{
+	const struct hnae3_ae_ops *ops = h->ae_algo->ops;
+
+	/* 1.auto_neg & speed & duplex from cmd */
+	if (ops->get_ksettings_an_result)
+		ops->get_ksettings_an_result(h,
+					     &cmd->base.autoneg,
+					     &cmd->base.speed,
+					     &cmd->base.duplex);
+
+	/* 2.get link mode*/
+	if (ops->get_link_mode)
+		ops->get_link_mode(h,
+				   cmd->link_modes.supported,
+				   cmd->link_modes.advertising);
+
+	/* 3.mdix_ctrl&mdix get from phy reg */
+	if (ops->get_mdix_mode)
+		ops->get_mdix_mode(h, &cmd->base.eth_tp_mdix_ctrl,
+				   &cmd->base.eth_tp_mdix);
+}
+
 static int hns3_get_link_ksettings(struct net_device *netdev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
+	u8 media_type;
 	u8 link_stat;
 
 	if (!h->ae_algo || !h->ae_algo->ops)
 		return -EOPNOTSUPP;
 
 	ops = h->ae_algo->ops;
-	if (ops->get_port_type)
-		ops->get_port_type(h, &cmd->base.port);
+	if (ops->get_media_type)
+		ops->get_media_type(h, &media_type);
 	else
 		return -EOPNOTSUPP;
 
-	switch (cmd->base.port) {
-	case PORT_FIBRE:
-		/* 1.auto_neg & speed & duplex from cmd */
-		if (ops->get_ksettings_an_result)
-			ops->get_ksettings_an_result(h,
-						     &cmd->base.autoneg,
-						     &cmd->base.speed,
-						     &cmd->base.duplex);
-		else
-			return -EOPNOTSUPP;
-
-		/* 2.get link mode*/
-		if (ops->get_link_mode)
-			ops->get_link_mode(h,
-					   cmd->link_modes.supported,
-					   cmd->link_modes.advertising);
-
-		/* 3.mdix_ctrl&mdix get from phy reg */
-		if (ops->get_mdix_mode)
-			ops->get_mdix_mode(h, &cmd->base.eth_tp_mdix_ctrl,
-					   &cmd->base.eth_tp_mdix);
-
+	switch (media_type) {
+	case HNAE3_MEDIA_TYPE_NONE:
+		cmd->base.port = PORT_NONE;
+		hns3_get_ksettings(h, cmd);
+		break;
+	case HNAE3_MEDIA_TYPE_FIBER:
+		cmd->base.port = PORT_FIBRE;
+		hns3_get_ksettings(h, cmd);
 		break;
-	case PORT_TP:
+	case HNAE3_MEDIA_TYPE_COPPER:
 		if (!netdev->phydev)
 			return -EOPNOTSUPP;
 
+		cmd->base.port = PORT_TP;
 		phy_ethtool_ksettings_get(netdev->phydev, cmd);
 
 		break;
 	default:
-		netdev_warn(netdev,
-			    "Unknown port type, neither Fibre/Copper detected");
+
+		netdev_warn(netdev, "Unknown media type");
 		return 0;
 	}
 
-- 
2.7.4


