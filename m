Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC0C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FCA20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yq+XJ2lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLAMEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44630 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeLAMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so3578456pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ob9vpSU1+1nD+bwLCyctkKfXPK21XNBnKf3G59AN/2s=;
        b=Yq+XJ2loJ4NwndoutH7UWBG5NADYr5m4oS/Cxl0NZgaxgrgDPmwkHvTpCZ68s9wsRt
         Pi/gvFfYPeCuM5gxJNQj//1FGBq/GD6cNf2S1hr3mOK87kpqsv2t9U5kjxpsyg0govC9
         QUCSHIlW8fRGhg/5SkePOOTBj1YtFYd0yTjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ob9vpSU1+1nD+bwLCyctkKfXPK21XNBnKf3G59AN/2s=;
        b=bTgTAxA70mbECm8f2gwMo9CHVys3x7ZgGwbzLmIedEdxiZGcVaRzIFsHr8Jr3Mz62Q
         N9syzxif/McKpLAs9Hpwtcnu90IyJvbydDyqep8kg+MVeKGedjxZ4WlfKnJfyNtMEgri
         0nQ+mZ1cxRS5TLCA3VjTPImwa698AFj3qvNOPbtfFeRtmllA1bfu87eccD6uoCDkegLx
         iZrPeW5Q/KmkTAYvXDyD7pzH36yt0R2hv9JqTQw17GVyJNveU41QN3X0J2QuAiX59jlE
         5CpXEMY+5WKoFPK9ugONBErBmXoddr42gOVmq/5W0yV1mRwQHcuXnzGuGwfT92ESG3js
         Ew0A==
X-Gm-Message-State: AA+aEWYHFPFBtDhLcca7IRzsnPLB/SoHFP8xhvvScfwKPgRYvEZOf63T
        2pABh5qwonWhnY5Qopv0ytbmBw==
X-Google-Smtp-Source: AFSGD/WtbMF0k4XF3B4vC1zfgQMAbMscvD5azipj2OxsD80IfS1cZ8H+DgsYI+kdKY6i9S/A1JAA3Q==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr7849325pls.281.1543625608053;
        Fri, 30 Nov 2018 16:53:28 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:27 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Date:   Fri, 30 Nov 2018 16:52:49 -0800
Message-Id: <20181201005254.139908-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181201005254.139908-1-mka@chromium.org>
References: <20181201005254.139908-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the ref clock of the PHY from the device tree instead of
hardcoding its name and rate. Use default values if the ref
clock is not specified.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- use default name and rate if the ref clock is not specified
  in the DT
- store vco_ref_clk_name instead of vco_ref_clk
- dsi_pll_28nm_clk_set_rate: changed data type of ref_clk_rate to
  unsigned long
- fixed check for EPROBE_DEFER
- renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE

Changes in v2:
- patch added to the series
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 35 ++++++++++++++++------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
index 26e3a01a99c2b..4a84c69ca0b2b 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
@@ -40,7 +40,7 @@
 
 #define NUM_PROVIDED_CLKS		2
 
-#define VCO_REF_CLK_RATE		19200000
+#define VCO_REF_CLK_DEFAULT_RATE	19200000
 #define VCO_MIN_RATE			350000000
 #define VCO_MAX_RATE			750000000
 
@@ -81,6 +81,7 @@ struct dsi_pll_28nm {
 	struct platform_device *pdev;
 	void __iomem *mmio;
 
+	const char *vco_ref_clk_name;
 	int vco_delay;
 
 	/* private clocks: */
@@ -139,6 +140,8 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(pll);
 	struct device *dev = &pll_28nm->pdev->dev;
 	void __iomem *base = pll_28nm->mmio;
+	unsigned long ref_clk_rate = parent_rate ?
+		parent_rate : VCO_REF_CLK_DEFAULT_RATE;
 	unsigned long div_fbx1000, gen_vco_clk;
 	u32 refclk_cfg, frac_n_mode, frac_n_value;
 	u32 sdm_cfg0, sdm_cfg1, sdm_cfg2, sdm_cfg3;
@@ -166,17 +169,17 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC1_CFG, 0x70);
 	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC2_CFG, 0x15);
 
-	rem = rate % VCO_REF_CLK_RATE;
+	rem = rate % ref_clk_rate;
 	if (rem) {
 		refclk_cfg = DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
 		frac_n_mode = 1;
-		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 500);
-		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 500);
+		div_fbx1000 = rate / (ref_clk_rate / 500);
+		gen_vco_clk = div_fbx1000 * (ref_clk_rate / 500);
 	} else {
 		refclk_cfg = 0x0;
 		frac_n_mode = 0;
-		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 1000);
-		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 1000);
+		div_fbx1000 = rate / (ref_clk_rate / 1000);
+		gen_vco_clk = div_fbx1000 * (ref_clk_rate / 1000);
 	}
 
 	DBG("refclk_cfg = %d", refclk_cfg);
@@ -265,7 +268,8 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	void __iomem *base = pll_28nm->mmio;
 	u32 sdm0, doubler, sdm_byp_div;
 	u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
-	u32 ref_clk = VCO_REF_CLK_RATE;
+	u32 ref_clk = parent_rate ?
+		parent_rate : VCO_REF_CLK_DEFAULT_RATE;
 	unsigned long vco_rate;
 
 	VERB("parent_rate=%lu", parent_rate);
@@ -273,7 +277,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	/* Check to see if the ref clk doubler is enabled */
 	doubler = pll_read(base + REG_DSI_28nm_PHY_PLL_REFCLK_CFG) &
 			DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
-	ref_clk += (doubler * VCO_REF_CLK_RATE);
+	ref_clk += (doubler * ref_clk);
 
 	/* see if it is integer mode or sdm mode */
 	sdm0 = pll_read(base + REG_DSI_28nm_PHY_PLL_SDM_CFG0);
@@ -518,7 +522,7 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
 {
 	char clk_name[32], parent1[32], parent2[32], vco_name[32];
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &pll_28nm->vco_ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -593,6 +597,7 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 {
 	struct dsi_pll_28nm *pll_28nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
 	int ret;
 
 	if (!pdev)
@@ -605,6 +610,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (!IS_ERR(vco_ref_clk)) {
+		pll_28nm->vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+	} else {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret == -EPROBE_DEFER)
+			ERR_PTR(ret);
+
+		dev_warn(&pdev->dev, "'ref' clock is not specified, using default name\n");
+		pll_28nm->vco_ref_clk_name = "xo";
+	}
+
 	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
 	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
 		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
-- 
2.20.0.rc1.387.gf8505762e3-goog

