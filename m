Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5890C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC08521900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBQJIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:08:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45722 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbfBQJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:08:37 -0500
X-UUID: b3eb5efb2b774a4c9afe1c8fbbe6f2d4-20190217
X-UUID: b3eb5efb2b774a4c9afe1c8fbbe6f2d4-20190217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 694387630; Sun, 17 Feb 2019 17:08:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 17:08:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 17 Feb 2019 17:08:29 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 12/22] memory: mtk-smi: Add gals support
Date:   Sun, 17 Feb 2019 17:04:50 +0800
Message-ID: <1550394300-17420-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some SoCs like mt8183, SMI add GALS(Global Async Local Sync) module
which can help synchronize for the modules in different clock frequency.
It can be seen as a "asynchronous fifo". This is a example diagram:

            M4U
             |
         ----------
         |        |
     gals0-rx   gals1-rx
         |        |
         |        |
     gals0-tx   gals1-tx
         |        |
        ------------
         SMI Common
        ------------
             |
  +-----+--------+-----+- ...
  |     |        |     |
  |  gals-rx  gals-rx  |
  |     |        |     |
  |     |        |     |
  |  gals-tx  gals-tx  |
  |     |        |     |
larb1 larb2   larb3  larb4

GALS only help transfer the command/data while it doesn't have the
configuring register, thus it has the special "smi" clock and doesn't
have the "apb" clock. From the diagram above, we add "gals0" and
"gals1" clocks for smi-common and add a "gals" clock for smi-larb.

This patch adds gals clock supporting in the SMI. Note that some larbs
may still don't have the "gals" clock like larb1 and larb4 above.

This is also a preparing patch for mt8183 which has GALS.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/memory/mtk-smi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 8a2f968..91634d7 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -56,6 +56,7 @@ enum mtk_smi_gen {
 
 struct mtk_smi_common_plat {
 	enum mtk_smi_gen gen;
+	bool             has_gals;
 };
 
 struct mtk_smi_larb_gen {
@@ -63,11 +64,13 @@ struct mtk_smi_larb_gen {
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
 	unsigned int larb_direct_to_common_mask;
+	bool             has_gals;
 };
 
 struct mtk_smi {
 	struct device			*dev;
 	struct clk			*clk_apb, *clk_smi;
+	struct clk			*clk_gals0, *clk_gals1;
 	struct clk			*clk_async; /*only needed by mt2701*/
 	void __iomem			*smi_ao_base;
 
@@ -99,8 +102,20 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	if (ret)
 		goto err_disable_apb;
 
+	ret = clk_prepare_enable(smi->clk_gals0);
+	if (ret)
+		goto err_disable_smi;
+
+	ret = clk_prepare_enable(smi->clk_gals1);
+	if (ret)
+		goto err_disable_gals0;
+
 	return 0;
 
+err_disable_gals0:
+	clk_disable_unprepare(smi->clk_gals0);
+err_disable_smi:
+	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
 err_put_pm:
@@ -110,6 +125,8 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 
 static void mtk_smi_disable(const struct mtk_smi *smi)
 {
+	clk_disable_unprepare(smi->clk_gals1);
+	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
 	pm_runtime_put_sync(smi->dev);
@@ -310,6 +327,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	larb->smi.clk_smi = devm_clk_get(dev, "smi");
 	if (IS_ERR(larb->smi.clk_smi))
 		return PTR_ERR(larb->smi.clk_smi);
+
+	if (larb->larb_gen->has_gals) {
+		/* The larbs may still haven't gals even if the SoC support.*/
+		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
+		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
+			larb->smi.clk_gals0 = NULL;
+		else if (IS_ERR(larb->smi.clk_gals0))
+			return PTR_ERR(larb->smi.clk_gals0);
+	}
 	larb->smi.dev = dev;
 
 	if (larb->larb_gen->need_larbid) {
@@ -402,6 +428,16 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	if (IS_ERR(common->clk_smi))
 		return PTR_ERR(common->clk_smi);
 
+	if (common->plat->has_gals) {
+		common->clk_gals0 = devm_clk_get(dev, "gals0");
+		if (IS_ERR(common->clk_gals0))
+			return PTR_ERR(common->clk_gals0);
+
+		common->clk_gals1 = devm_clk_get(dev, "gals1");
+		if (IS_ERR(common->clk_gals1))
+			return PTR_ERR(common->clk_gals1);
+	}
+
 	/*
 	 * for mtk smi gen 1, we need to get the ao(always on) base to config
 	 * m4u port, and we need to enable the aync clock for transform the smi
-- 
1.9.1

