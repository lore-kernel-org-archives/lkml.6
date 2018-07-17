Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF2DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A9620693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBAVjyOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A9620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbeGQWfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbeGQWfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:35:01 -0400
Received: from ziggy.de (144.pool85-56-49.dynamic.orange.es [85.56.49.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D6C20839;
        Tue, 17 Jul 2018 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531864821;
        bh=U0ilIxN8f7Iu4VX226MDd/I68fU+92CDuDprBIA7res=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vBAVjyORFFQMawttVv3rgLWSF1uYsOBTytLRAR+N4iHjs2SUeCAINgKMgjPsky+FF
         woQwQLnmfnaN8xeQKNAGitVoXcsmclE0Dl/K5mQ0xgzLrKBfWGGBdeQuRvdsSrcx85
         m6NouAJVX5pj89+wZSPCc3oa9CCY7YhX6D8uI47A=
From:   matthias.bgg@kernel.org
To:     laurent.pinchart@ideasonboard.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab@kernel.org, rdunlap@infradead.org,
        pi-cheng.chen@linaro.org, sean.wang@mediatek.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v4--to=ulrich.hecht+renesas@gmail.com 3/5] clk: mediatek: mt8173: switch mmsys to platform device probing
Date:   Tue, 17 Jul 2018 23:59:49 +0200
Message-Id: <20180717215951.378-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717215951.378-1-matthias.bgg@kernel.org>
References: <20180717215951.378-1-matthias.bgg@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Switch probing for the MMSYS to support invocation to a
plain paltform device. The driver will be probed by the DRM subsystem.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 96c292c3e440..10b6a0251123 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -13,8 +13,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
@@ -791,7 +794,7 @@ static const struct mtk_gate_regs mm1_cg_regs __initconst = {
 		.ops = &mtk_clk_gate_ops_setclr,		\
 	}
 
-static const struct mtk_gate mm_clks[] __initconst = {
+static const struct mtk_gate mm_clks[] = {
 	/* MM0 */
 	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
 	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
@@ -1152,22 +1155,56 @@ static void __init mtk_imgsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
-static void __init mtk_mmsys_init(struct device_node *node)
-{
+struct mtk_mmsys_priv {
 	struct clk_onecell_data *clk_data;
+};
+
+static int mtk_mmsys_probe(struct platform_device *pdev)
+{
 	int r;
+	struct device_node *node;
+	struct mtk_mmsys_priv *private;
+
+	node = pdev->dev.parent->of_node;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+	private = devm_kzalloc(&pdev->dev, sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+
+	private->clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+
+	platform_set_drvdata(pdev, private);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+					private->clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(node, of_clk_src_onecell_get,
+					private->clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	return r;
+}
+
+static int mtk_mmsys_remove(struct platform_device *pdev)
+{
+	struct mtk_mmsys_priv *private = platform_get_drvdata(pdev);
+
+	kfree(private->clk_data);
+	kfree(private);
+
+	return 0;
 }
-CLK_OF_DECLARE(mtk_mmsys, "mediatek,mt8173-mmsys", mtk_mmsys_init);
+
+static struct platform_driver clk_mt8173_mm_drv = {
+	.probe = mtk_mmsys_probe,
+	.probe = mtk_mmsys_remove,
+	.driver = {
+		.name = "clk-mt8173-mm",
+	},
+};
+module_platform_driver(clk_mt8173_mm_drv);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-- 
2.17.1

