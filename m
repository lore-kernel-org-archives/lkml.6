Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EBC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D38820658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 06:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D38820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeICKXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 06:23:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48061 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbeICKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 06:23:30 -0400
X-UUID: be0754271a5d4da9b93b8c579913d9ce-20180903
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1369114137; Mon, 03 Sep 2018 14:04:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 3 Sep 2018 14:04:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 3 Sep 2018 14:04:44 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        Daniel Kurtz <djkurtz@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>
Subject: [PATCH 12/13] memory: mtk-smi: Get rid of need_larbid
Date:   Mon, 3 Sep 2018 14:01:41 +0800
Message-ID: <1535954502-30646-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
References: <1535954502-30646-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
It's no need to parse it again in SMI driver. Only clean some codes.
This patch is fit for all the current mt2701, mt2712, mt8173 and
mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 31d0431..1a00f5b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
 };
 
 struct mtk_smi_larb_gen {
-	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
 	unsigned int larb_special_mask; /* The special larbs mask. */
@@ -152,18 +151,9 @@ void mtk_smi_larb_put(struct device *larbdev)
 	struct mtk_smi_iommu *smi_iommu = data;
 	unsigned int         i;
 
-	if (larb->larb_gen->need_larbid) {
-		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
-		return 0;
-	}
-
-	/*
-	 * If there is no larbid property, Loop to find the corresponding
-	 * iommu information.
-	 */
-	for (i = 0; i < smi_iommu->larb_nr; i++) {
+	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
 		if (dev == smi_iommu->larb_imu[i].dev) {
-			/* The 'mmu' may be updated in iommu-attach/detach. */
+			larb->larbid = i;
 			larb->mmu = &smi_iommu->larb_imu[i].mmu;
 			return 0;
 		}
@@ -242,7 +232,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
-	.need_larbid = true,
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
 		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
@@ -251,13 +240,11 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
-	.need_larbid = true,
 	.config_port = mtk_smi_larb_config_port_gen2_general,
 	.larb_special_mask = BIT(8) | BIT(9), /* bdpsys */
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
-	.need_larbid = true,
 	.config_port = mtk_smi_larb_config_port_gen2_general,
 	.larb_special_mask = BIT(7), /* CCU */
 };
@@ -289,7 +276,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
-	int err;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
@@ -316,15 +302,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		return PTR_ERR(larb->smi.clk_gals0);
 	larb->smi.dev = dev;
 
-	if (larb->larb_gen->need_larbid) {
-		err = of_property_read_u32(dev->of_node, "mediatek,larb-id",
-					   &larb->larbid);
-		if (err) {
-			dev_err(dev, "missing larbid property\n");
-			return err;
-		}
-	}
-
 	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
 	if (!smi_node)
 		return -EINVAL;
-- 
1.9.1

