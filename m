Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F90C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181A72088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181A72088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeG1HBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:01:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726052AbeG1HBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:01:21 -0400
X-UUID: bd72859f023147c893f565fdbac925cc-20180728
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1367889538; Sat, 28 Jul 2018 13:36:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 28 Jul 2018 13:36:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 28 Jul 2018 13:36:04 +0800
From:   <sean.wang@mediatek.com>
To:     <john@phrozen.org>, <davem@davemloft.net>
CC:     <nbd@openwrt.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 2/2] net-next: mediatek: cleanup unnecessary get chip id and its user
Date:   Sat, 28 Jul 2018 13:35:56 +0800
Message-ID: <d4fa77f13190aefa5cf3f609a3ae555aeef38259.1532755541.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <658dfd485c035cdae5452bc5d572125076b47a48.1532755541.git.sean.wang@mediatek.com>
References: <658dfd485c035cdae5452bc5d572125076b47a48.1532755541.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Since driver is devicetree-based, all device type and charateristic can be
determined by the compatible string and its data. It's unnecessary to
create another dependent function to check chip ID and then decide whether
the specific funciton is being supported on a certain device. It can be
totally replaced by the existing flag, so a cleanup is made by removing
the function and the only user, HWLRO.

MT2701 also have a missing HWLRO support in old code, so add it the same
patch.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 48 +++--------------------------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  2 +-
 2 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8c85a4b..6e6abdc 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2458,42 +2458,6 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	return err;
 }
 
-static int mtk_get_chip_id(struct mtk_eth *eth, u32 *chip_id)
-{
-	u32 val[2], id[4];
-
-	regmap_read(eth->ethsys, ETHSYS_CHIPID0_3, &val[0]);
-	regmap_read(eth->ethsys, ETHSYS_CHIPID4_7, &val[1]);
-
-	id[3] = ((val[0] >> 16) & 0xff) - '0';
-	id[2] = ((val[0] >> 24) & 0xff) - '0';
-	id[1] = (val[1] & 0xff) - '0';
-	id[0] = ((val[1] >> 8) & 0xff) - '0';
-
-	*chip_id = (id[3] * 1000) + (id[2] * 100) +
-		   (id[1] * 10) + id[0];
-
-	if (!(*chip_id)) {
-		dev_err(eth->dev, "failed to get chip id\n");
-		return -ENODEV;
-	}
-
-	dev_info(eth->dev, "chip id = %d\n", *chip_id);
-
-	return 0;
-}
-
-static bool mtk_is_hwlro_supported(struct mtk_eth *eth)
-{
-	switch (eth->chip_id) {
-	case MT7622_ETH:
-	case MT7623_ETH:
-		return true;
-	}
-
-	return false;
-}
-
 static int mtk_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -2572,11 +2536,7 @@ static int mtk_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	err = mtk_get_chip_id(eth, &eth->chip_id);
-	if (err)
-		return err;
-
-	eth->hwlro = mtk_is_hwlro_supported(eth);
+	eth->hwlro = MTK_HAS_CAPS(eth->soc->caps, MTK_HWLRO);
 
 	for_each_child_of_node(pdev->dev.of_node, mac_np) {
 		if (!of_device_is_compatible(mac_np,
@@ -2665,19 +2625,19 @@ static int mtk_remove(struct platform_device *pdev)
 }
 
 static const struct mtk_soc_data mt2701_data = {
-	.caps = MTK_GMAC1_TRGMII,
+	.caps = MTK_GMAC1_TRGMII | MTK_HWLRO,
 	.required_clks = MT7623_CLKS_BITMAP,
 	.required_pctl = true,
 };
 
 static const struct mtk_soc_data mt7622_data = {
-	.caps = MTK_DUAL_GMAC_SHARED_SGMII | MTK_GMAC1_ESW,
+	.caps = MTK_DUAL_GMAC_SHARED_SGMII | MTK_GMAC1_ESW | MTK_HWLRO,
 	.required_clks = MT7622_CLKS_BITMAP,
 	.required_pctl = false,
 };
 
 static const struct mtk_soc_data mt7623_data = {
-	.caps = MTK_GMAC1_TRGMII,
+	.caps = MTK_GMAC1_TRGMII | MTK_HWLRO,
 	.required_clks = MT7623_CLKS_BITMAP,
 	.required_pctl = true,
 };
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 672b8c3..4681929 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -566,6 +566,7 @@ struct mtk_rx_ring {
 #define MTK_GMAC2_SGMII			(BIT(10) | MTK_SGMII)
 #define MTK_DUAL_GMAC_SHARED_SGMII	(BIT(11) | MTK_GMAC1_SGMII | \
 					 MTK_GMAC2_SGMII)
+#define MTK_HWLRO			BIT(12)
 #define MTK_HAS_CAPS(caps, _x)		(((caps) & (_x)) == (_x))
 
 /* struct mtk_eth_data -	This is the structure holding all differences
@@ -635,7 +636,6 @@ struct mtk_eth {
 	struct regmap			*ethsys;
 	struct regmap			*sgmiisys;
 	struct regmap			*pctl;
-	u32				chip_id;
 	bool				hwlro;
 	refcount_t			dma_refcnt;
 	struct mtk_tx_ring		tx_ring;
-- 
2.7.4

