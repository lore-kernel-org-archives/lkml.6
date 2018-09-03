Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3E22077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3E22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeICOnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:43:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeICOnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:43:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9F7171114CA6;
        Mon,  3 Sep 2018 18:23:24 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Mon, 3 Sep 2018 18:23:18 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>
Subject: [PATCH net-next 10/11] net: hns3: Remove redundant codes of query advertised flow control abilitiy
Date:   Mon, 3 Sep 2018 11:21:55 +0100
Message-ID: <20180903102156.18676-11-salil.mehta@huawei.com>
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

If the advertised flow control ability has been fetched using
phy_ethtool_ksettings_get() or hclge_get_link_mode() then it is
unnecessary to fetch them again later using hclge_get_flowctrl_adv().
This patch removes it.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c      | 12 ------------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 15 ---------------
 2 files changed, 27 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index dfce76e..41d817d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -591,18 +591,6 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 	/* 4.mdio_support */
 	cmd->base.mdio_support = ETH_MDIO_SUPPORTS_C22;
 
-	/* 5.get flow control setttings */
-	if (h->ae_algo->ops->get_flowctrl_adv)
-		h->ae_algo->ops->get_flowctrl_adv(h, &flowctrl_adv);
-
-	if (flowctrl_adv & ADVERTISED_Pause)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Pause);
-
-	if (flowctrl_adv & ADVERTISED_Asym_Pause)
-		ethtool_link_ksettings_add_link_mode(cmd, advertising,
-						     Asym_Pause);
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 25d4fd9..c56db06 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -5221,20 +5221,6 @@ static u32 hclge_get_fw_version(struct hnae3_handle *handle)
 	return hdev->fw_version;
 }
 
-static void hclge_get_flowctrl_adv(struct hnae3_handle *handle,
-				   u32 *flowctrl_adv)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-	struct phy_device *phydev = hdev->hw.mac.phydev;
-
-	if (!phydev)
-		return;
-
-	*flowctrl_adv |= (phydev->advertising & ADVERTISED_Pause) |
-			 (phydev->advertising & ADVERTISED_Asym_Pause);
-}
-
 static void hclge_set_flowctrl_adv(struct hclge_dev *hdev, u32 rx_en, u32 tx_en)
 {
 	struct phy_device *phydev = hdev->hw.mac.phydev;
@@ -6335,7 +6321,6 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.get_tqps_and_rss_info = hclge_get_tqps_and_rss_info,
 	.set_channels = hclge_set_channels,
 	.get_channels = hclge_get_channels,
-	.get_flowctrl_adv = hclge_get_flowctrl_adv,
 	.get_regs_len = hclge_get_regs_len,
 	.get_regs = hclge_get_regs,
 	.set_led_id = hclge_set_led_id,
-- 
2.7.4


