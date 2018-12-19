Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368A8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeLSXzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45137 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730103AbeLSXzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so10189020plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KugJw0T6WpNIgN6GeDyzlbgkEP0KJTcUcd6c7Oo1r4A=;
        b=eivUsCSRq9w3e2fhsM36mBdkvraJmx5dfaBY6rY6PILMJ6AftP9pebPcx3N8nrwaUe
         Y8unYHvfh9oT/21BPXhRismmwN+Y9dqcCzmWihry4vBx25SeUz9/ogocoyyygUQ3TVoO
         qLSYwso3HzpjysYLti2pqX9CChlZlP0bPiBouWur9bZTPplKpkI+8pGYotOYI3NyAy2u
         fBa3kFV+havxBRjsFw4Cz2DlNa7B6Ip/BuWsGgr0WpIJpWsaE7ciAcI/w/43fq1rgll5
         jTGf1x11tnTrmUme4JlsC7RBYEshvedcX9mWy0QItWAyTturad2c4DXF5dGMnpwgkrTH
         UrJw==
X-Gm-Message-State: AA+aEWZrXydIgmSIUhkS61Tu9OE0Zbhu1ZxArqREb1S6WtNeIvl2poXp
        w+sW5Ngys6SjvM9Sy0+JEg1Q9Q==
X-Google-Smtp-Source: AFSGD/UlJRsTVEYMAMX1t4IhY5Z2sB1XzBGmrU/ulxs7aUZyMyZ1XvmkaDf1dAaFvYzPkh0ynK/bKA==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr21827005pld.258.1545263744466;
        Wed, 19 Dec 2018 15:55:44 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:43 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Wed, 19 Dec 2018 15:55:22 -0800
Message-Id: <20181219235528.114830-3-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the ref clock of the PHY from the device tree instead of
hardcoding its name and rate.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes in v5:
- added "Reviewed-by: Stephen Boyd <swboyd@chromium.org>" tag

Changes in v4:
- always use parent rate in dsi_pll_28nm_clk_set_rate()
- pass name of VCO ref clock to pll_28nm_register() instead of
  storing it in a struct field
- updated commit message

Changes in v3:
- use default name and rate if the ref clock is not specified
  in the DT
- store vco_ref_clk_name instead of vco_ref_clk
- fixed check for EPROBE_DEFER
- renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE

Changes in v2:
- patch added to the series
---
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
index 49008451085b8..76e5188169b91 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
@@ -47,7 +47,6 @@
 
 #define NUM_PROVIDED_CLKS	2
 
-#define VCO_REF_CLK_RATE	27000000
 #define VCO_MIN_RATE		600000000
 #define VCO_MAX_RATE		1200000000
 
@@ -125,7 +124,7 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	DBG("rate=%lu, parent's=%lu", rate, parent_rate);
 
 	temp = rate / 10;
-	val = VCO_REF_CLK_RATE / 10;
+	val = parent_rate / 10;
 	fb_divider = (temp * VCO_PREF_DIV_RATIO) / val;
 	fb_divider = fb_divider / 2 - 1;
 	pll_write(base + REG_DSI_28nm_8960_PHY_PLL_CTRL_1,
@@ -406,11 +405,12 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
 					pll_28nm->clks, pll_28nm->num_clks);
 }
 
-static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
+static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm,
+			     const char *ref_clk_name)
 {
 	char *clk_name, *parent_name, *vco_name;
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.flags = CLK_IGNORE_UNUSED,
 		.ops = &clk_ops_dsi_pll_28nm_vco,
@@ -494,6 +494,8 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 {
 	struct dsi_pll_28nm *pll_28nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
+	const char *vco_ref_clk_name;
 	int ret;
 
 	if (!pdev)
@@ -506,6 +508,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id + 1;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (!IS_ERR(vco_ref_clk)) {
+		vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+	} else {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret == -EPROBE_DEFER)
+			return ERR_PTR(ret);
+
+		dev_warn(&pdev->dev, "'ref' clock is not specified, using default name\n");
+		vco_ref_clk_name = "pxo";
+	}
+
 	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
 	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
 		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
@@ -524,7 +538,7 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 	pll->en_seq_cnt = 1;
 	pll->enable_seqs[0] = dsi_pll_28nm_enable_seq;
 
-	ret = pll_28nm_register(pll_28nm);
+	ret = pll_28nm_register(pll_28nm, vco_ref_clk_name);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register PLL: %d\n", ret);
 		return ERR_PTR(ret);
-- 
2.20.1.415.g653613c723-goog

