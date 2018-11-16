Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5698C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629FD223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYpdYAGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629FD223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbeKPXHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:07:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeKPXHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:07:54 -0500
Received: from ziggy.de (unknown [93.176.133.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F2520989;
        Fri, 16 Nov 2018 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372936;
        bh=YWa3oRPVlT/S63uQvThApqIKb9DzRSCSP+OAynmBwf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYpdYAGREL8rC/98+2atoSVHhmJBzkuuyZym5BrQ+pp92C8+ukAY045+yTqhYkGek
         oqBXxhgzlRS2e3pV1G7S673+hUKXsaXhMzhLOpEvwvPUIJyKisoCYplQciqqX2Dc7v
         zV5Sxq2+QlEWFW4funxYFx8SyS/FaNYAU3lLwk2s=
From:   matthias.bgg@kernel.org
To:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com
Cc:     sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 02/12] clk: mediatek: mt2701-mmsys: switch to platform device probing
Date:   Fri, 16 Nov 2018 13:54:39 +0100
Message-Id: <20181116125449.23581-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116125449.23581-1-matthias.bgg@kernel.org>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Switch probing for the MMSYS to support invocation to a plain
paltform device. The driver will be probed by the DRM subsystem.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/clk/mediatek/clk-mt2701-mm.c | 42 ++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index fe1f85072fc5..200b1842b94b 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -12,14 +12,20 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/module.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
+struct clk_mt2701_mm_priv {
+	struct clk_onecell_data *clk_data;
+};
+
 static const struct mtk_gate_regs disp0_cg_regs = {
 	.set_ofs = 0x0104,
 	.clr_ofs = 0x0108,
@@ -87,23 +93,25 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
 };
 
-static const struct of_device_id of_match_clk_mt2701_mm[] = {
-	{ .compatible = "mediatek,mt2701-mmsys", },
-	{}
-};
-
 static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
+	struct device_node *node = pdev->dev.parent->of_node;
+	struct clk_mt2701_mm_priv *private;
+
+	private = devm_kzalloc(&pdev->dev, sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
 
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
+	private->clk_data = mtk_alloc_clk_data(CLK_MM_NR);
+
+	platform_set_drvdata(pdev, private);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
-						clk_data);
+					private->clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_provider(node, of_clk_src_onecell_get,
+					private->clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -112,12 +120,22 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt2701_mm_remove(struct platform_device *pdev)
+{
+	struct clk_mt2701_mm_priv *private = platform_get_drvdata(pdev);
+
+	kfree(private->clk_data);
+	kfree(private);
+
+	return 0;
+}
+
 static struct platform_driver clk_mt2701_mm_drv = {
 	.probe = clk_mt2701_mm_probe,
+	.remove = clk_mt2701_mm_remove,
 	.driver = {
 		.name = "clk-mt2701-mm",
-		.of_match_table = of_match_clk_mt2701_mm,
 	},
 };
 
-builtin_platform_driver(clk_mt2701_mm_drv);
+module_platform_driver(clk_mt2701_mm_drv);
-- 
2.19.1

