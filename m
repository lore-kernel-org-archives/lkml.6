Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F783ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D532E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D532E206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeGQVDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:03:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51731 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:03:04 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LlVhP-1gDUU02G1P-00bIVW; Tue, 17 Jul 2018 22:28:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nand: ranw: qcom_nand: stop using phys_to_dma()
Date:   Tue, 17 Jul 2018 22:27:42 +0200
Message-Id: <20180717202759.2288076-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:GgXbCwUIYC5OxfpXPg4WR65Who6Naz28NA//J4Mm5WXTJd7ZFBI
 QelOwV4m+mLy5dTUSRLkCDSq/rPTO3csluXGWt6MBK/SPzXwLSPK/hTb6gDRPPXbFNHEQ5U
 lJs+2qz29lBG5XZKpbLyNvWpexWer4JzKbWLw1z38tRGxLUZKZv9MlURqZrt7MQMvEOPXxj
 A/MOlcLTGVXVHUEcFwMhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SokgHTinA8c=:t7Ve2WgcvNwYw6SBiBCsd7
 WVDRHLBJc3LtAjX6Y3Tj2IM51IuFOnsfcDXcOy8lhfA1Bk0MnevHgWwUa0cIDA+AGMrlLIaXW
 h4mXY7dbuamSbB9lTuUInU1qemi3zW4s0oa7kd6PyXZJJJLjaFH8rncvb3MAvoSDL9VbTJERs
 iEJKj+j5DsGNsuElp4BUf/Dj+p9863M8It7TZysClcrpfFSxZVRWYojLehhnGTN6pqVBv+6E8
 g7Kx7U4Li54ofYLKYs90eTZSiALHDW/gz3d5kzSq/arR8eJ2o6+hR5WGhOK8fr1EOz3Ol2VJ6
 BSeJ+7jdcTQIq5Cw2OVTqCg7knjXD7p3vdxoJ0h+EVvGrDzDzIZcw1Qs/3vzQO2wuhyz9XXJP
 sAr0oGC7WqNiU6A8q5etozoZpbJGnb+MeGDcXb5vi+9K/GxUIkMrRf/SHH7098Uy1sWoGLeOD
 GWCt4c1bP7UXsgyeryEBWJ+wxdf8IMrjZTW2Z2Ub3ikNC/ogjXQL9UQSF+BUi711GLHwNkKuv
 SeJLQsmlp1denzF30vqUf6mIgU2WxZJZOxFq9qFsoZuHJ/p3b2UG8pXgFOfKv1Ifo/U/50D15
 TuU7IHr16Za4QGvNv23QT1M9i7CKz/RGBOE6c5mGA/+T/9N7pLcSV5AAw8hsve6qh+P45NoFj
 FKPyDZTgMD53F2W/pIbph7IVfV2dvWScg/RXZTO8Zv3RuJHVT6LWBPASxXZqoYvz3OfM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing this driver on x86 caused a link error:

ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!

The problem here is that the driver attempts to convert the physical
address into the DMA controller as a dma_addr_t and calls phys_to_dma()
to do the conversion.

The correct way to do the conversion is using the dma mapping interfaces.

Fixes: c76b78d8ec05 ("mtd: nand: Qualcomm NAND controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 994f980c6d86..645630953f38 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2957,14 +2957,6 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 
 	nandc->props = dev_data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nandc->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(nandc->base))
-		return PTR_ERR(nandc->base);
-
-	nandc->base_phys = res->start;
-	nandc->base_dma = phys_to_dma(dev, (phys_addr_t)res->start);
-
 	nandc->core_clk = devm_clk_get(dev, "core");
 	if (IS_ERR(nandc->core_clk))
 		return PTR_ERR(nandc->core_clk);
@@ -2977,9 +2969,21 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	nandc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(nandc->base))
+		return PTR_ERR(nandc->base);
+
+	nandc->base_phys = res->start;
+	nandc->base_dma = dma_map_resource(dev, res->start,
+					   resource_size(res),
+					   DMA_BIDIRECTIONAL, 0);
+	if (!nandc->base_dma)
+		return -ENXIO;
+
 	ret = qcom_nandc_alloc(nandc);
 	if (ret)
-		goto err_core_clk;
+		goto err_nandc_alloc;
 
 	ret = clk_prepare_enable(nandc->core_clk);
 	if (ret)
@@ -3005,6 +3009,9 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(nandc->core_clk);
 err_core_clk:
 	qcom_nandc_unalloc(nandc);
+err_nandc_alloc:
+	dma_unmap_resource(dev, res->start, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
 
 	return ret;
 }
@@ -3012,16 +3019,21 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 static int qcom_nandc_remove(struct platform_device *pdev)
 {
 	struct qcom_nand_controller *nandc = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct qcom_nand_host *host;
 
 	list_for_each_entry(host, &nandc->host_list, node)
 		nand_release(nand_to_mtd(&host->chip));
 
+
 	qcom_nandc_unalloc(nandc);
 
 	clk_disable_unprepare(nandc->aon_clk);
 	clk_disable_unprepare(nandc->core_clk);
 
+	dma_unmap_resource(&pdev->dev, nandc->base_dma, resource_size(res),
+			   DMA_BIDIRECTIONAL, 0);
+
 	return 0;
 }
 
-- 
2.9.0

