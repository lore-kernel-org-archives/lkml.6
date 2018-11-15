Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82D121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82D121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeKOQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:33:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51651 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbeKOQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:33:22 -0500
X-UUID: b600bb10c7f04d44851bcc942b9e6235-20181115
X-UUID: b600bb10c7f04d44851bcc942b9e6235-20181115
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2143731266; Thu, 15 Nov 2018 14:26:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 15 Nov 2018 14:26:36 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 15 Nov 2018 14:26:37 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-mtd@lists.infradead.org>,
        "Weijie Gao" <weijie.gao@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        "Guochun Mao" <guochun.mao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/4] mtd: spi-nor: mtk-quadspi: use ofpart for parsing partitions
Date:   Thu, 15 Nov 2018 14:26:24 +0800
Message-ID: <f2ca7e285c5b48a616813f2ceb5838d8b3f136d6.1542262833.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
References: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guochun Mao <guochun.mao@mediatek.com>

Replace mtd_device_register with mtd_device_parse_register for
parsing partitions.
Add ofpart support.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
Tested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 5442993..2278677 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -118,6 +118,8 @@ struct mtk_nor {
 	struct clk *nor_clk;
 };
 
+static const char * const probes[] = { "ofpart", NULL };
+
 static void mtk_nor_set_read_mode(struct mtk_nor *mtk_nor)
 {
 	struct spi_nor *nor = &mtk_nor->nor;
@@ -457,7 +459,7 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
 	if (ret)
 		return ret;
 
-	return mtd_device_register(&nor->mtd, NULL, 0);
+	return mtd_device_parse_register(&nor->mtd, probes, NULL, NULL, 0);
 }
 
 static int mtk_nor_drv_probe(struct platform_device *pdev)
-- 
1.9.1

