Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E6BC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF912075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfAAExL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 23:53:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:31113 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727370AbfAAExK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 23:53:10 -0500
X-UUID: 80db2e4edc424da3be63f1615359206f-20190101
X-UUID: 80db2e4edc424da3be63f1615359206f-20190101
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 232489272; Tue, 01 Jan 2019 12:53:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:53:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:53:02 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
Date:   Tue, 1 Jan 2019 12:51:14 +0800
Message-ID: <1546318276-18993-12-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 763C6A7E7CF2199B37B7CB189F52E0010B63FEC48DC0003EBCE5814974BE44872000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU should wait for smi larb which need wait for the
power domain(mtk-scpsys.c) and the multimedia ccf who both are
module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
Switch to builtin_platform_driver.

Meanwhile, the ".remove" can be removed. Move its content to
".shutdown".

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 23 ++---------------------
 drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
 2 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 735ae8d..2798b12 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
+static void mtk_iommu_shutdown(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 
@@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
-static void mtk_iommu_shutdown(struct platform_device *pdev)
-{
-	mtk_iommu_remove(pdev);
 }
 
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
@@ -791,7 +785,6 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu",
@@ -799,16 +792,4 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init mtk_iommu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register MTK IOMMU driver\n");
-
-	return ret;
-}
-
-subsys_initcall(mtk_iommu_init)
+builtin_platform_driver(mtk_iommu_driver);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 022bad9..5464918 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -648,7 +648,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
+static void mtk_iommu_shutdown(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 
@@ -661,12 +661,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
-static void mtk_iommu_shutdown(struct platform_device *pdev)
-{
-	mtk_iommu_remove(pdev);
 }
 
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
@@ -705,7 +699,6 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu-v1",
@@ -713,9 +706,4 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init m4u_init(void)
-{
-	return platform_driver_register(&mtk_iommu_driver);
-}
-subsys_initcall(m4u_init);
+builtin_platform_driver(mtk_iommu_driver);
-- 
1.9.1

