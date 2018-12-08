Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE969C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823B820868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823B820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeLHInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 03:43:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:8898 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726132AbeLHInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 03:43:03 -0500
X-UUID: 4460baa5bb2646329bf21dc285fe92a1-20181208
X-UUID: 4460baa5bb2646329bf21dc285fe92a1-20181208
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 755524579; Sat, 08 Dec 2018 16:42:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Dec 2018 16:42:54 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 8 Dec 2018 16:42:53 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <arnd@arndb.de>,
        <yingjoe.chen@mediatek.com>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v4 12/18] memory: mtk-smi: Invoke pm runtime_callback to enable clocks
Date:   Sat, 8 Dec 2018 16:39:25 +0800
Message-ID: <1544258371-4600-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only move the clk_prepare_enable and config_port into the
runtime suspend/resume callback. It doesn't change the code content
and sequence.

This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
(SMI_BUS_SEL need to be restored after smi-common resume every time.)
Also it gives a chance to get rid of mtk_smi_larb_get/put which could
be a next topic.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index bced778..ee6165e 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-static int mtk_smi_enable(const struct mtk_smi *smi)
+static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(smi->dev);
-	if (ret < 0)
-		return ret;
-
 	ret = clk_prepare_enable(smi->clk_apb);
 	if (ret)
-		goto err_put_pm;
+		return ret;
 
 	ret = clk_prepare_enable(smi->clk_smi);
 	if (ret)
@@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
-err_put_pm:
-	pm_runtime_put_sync(smi->dev);
 	return ret;
 }
 
-static void mtk_smi_disable(const struct mtk_smi *smi)
+static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 {
 	clk_disable_unprepare(smi->clk_gals1);
 	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
-	pm_runtime_put_sync(smi->dev);
 }
 
 int mtk_smi_larb_get(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-	int ret;
+	int ret = pm_runtime_get_sync(larbdev);
 
-	/* Enable the smi-common's power and clocks */
-	ret = mtk_smi_enable(common);
-	if (ret)
-		return ret;
-
-	/* Enable the larb's power and clocks */
-	ret = mtk_smi_enable(&larb->smi);
-	if (ret) {
-		mtk_smi_disable(common);
-		return ret;
-	}
-
-	/* Configure the iommu info for this larb */
-	larb_gen->config_port(larbdev);
-
-	return 0;
+	return (ret < 0) ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
 
 void mtk_smi_larb_put(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-
-	/*
-	 * Don't de-configure the iommu info for this larb since there may be
-	 * several modules in this larb.
-	 * The iommu info will be reset after power off.
-	 */
-
-	mtk_smi_disable(&larb->smi);
-	mtk_smi_disable(common);
+	pm_runtime_put_sync(larbdev);
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
@@ -384,12 +349,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	int ret;
+
+	/* Power on smi-common. */
+	ret = pm_runtime_get_sync(larb->smi_common_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
+		return ret;
+	}
+
+	ret = mtk_smi_clk_enable(&larb->smi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+		pm_runtime_put_sync(larb->smi_common_dev);
+		return ret;
+	}
+
+	/* Configure the basic setting for this larb */
+	larb_gen->config_port(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(&larb->smi);
+	pm_runtime_put_sync(larb->smi_common_dev);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_larb_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
 	.remove	= mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
+		.pm             = &smi_larb_pm_ops,
 	}
 };
 
@@ -488,12 +493,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_common_resume(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mtk_smi_clk_enable(common);
+	if (ret) {
+		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(common);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_common_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
 	.remove = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
+		.pm             = &smi_common_pm_ops,
 	}
 };
 
-- 
1.9.1

