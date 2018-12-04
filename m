Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FD2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1A5206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8bICMI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1A5206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLDWn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39291 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeLDWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so8030287pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcsSgVishubggGNytYKHnyWfllvca0P0GPDK9c5rNNg=;
        b=A8bICMI+a90oeM8ADbb4djwlv6/Na/7hSIdAqG5jUf8U2eYCIOg2/Ygz5CFFuRyMl6
         7uVQNxbNWVYX0CBqLVZ+tH9sluO8UCsQCRjKdbwvqOgmgzb6f3d49924gE7BUjKG5f5n
         xgmoKPdDlNnmNUKjAIy6Ecp2v5L/oggaCbRtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcsSgVishubggGNytYKHnyWfllvca0P0GPDK9c5rNNg=;
        b=fx7Y9VMvNvsYfHF1zInDZetbD6tzHRKJbr0gSVODIk3jV0oaJRNBWjJXRW2SPSf0kq
         4rohE+2wc0naOGOrT9biuGUkMTIH7PqfLi0WgtNn+60Kgx0KVq7hwjdsc7YRglOSaCOP
         Hvgi87m+wPIVC813VABn3fgk3piijgnui6CjJvQvSfO0cmMOdOJpGazRLTfC7/YX21qY
         6PAdfqGh0fVJZgwRufAaasKcq1mNLwkjwuvynjHjBJJvn4UZTq7y+lJkO2CoGh+Cq25R
         vcqoGd4vz0Ys+o2PbyijQfEznDvyJ2SKCn/ubuU2jGKcTHySGiR1cT8JsJ1xm6gPP6yt
         EE5A==
X-Gm-Message-State: AA+aEWaDGgRoSeyO0UNab59BDSEzEo5mWN/AHCGGvaW1pWUAIXQY5Fu1
        ratxU8VD0tEF7bBeIMCw3pDmHg==
X-Google-Smtp-Source: AFSGD/W/xHM9uKmU6UJtxteeOv+YgQvr7s4T7dsy3uInylGfqo8Zvrag7bniXhrtDuAeBtQ5N3/bqw==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr22197205pfc.209.1543963396303;
        Tue, 04 Dec 2018 14:43:16 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:15 -0800 (PST)
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
Subject: [PATCH v4 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Date:   Tue,  4 Dec 2018 14:42:29 -0800
Message-Id: <20181204224234.62619-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204224234.62619-1-mka@chromium.org>
References: <20181204224234.62619-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the ref clock of the PHY from the device tree instead of
hardcoding its name and rate.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- always use parent rate in dsi_pll_28nm_clk_set_rate() and
   dsi_pll_28nm_clk_recalc_rate()
- pass name of VCO ref clock to pll_28nm_register() instead of
  storing it in a struct field
- updated commit message

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
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 36 +++++++++++++++-------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
index 26e3a01a99c2b..7777340b03e8d 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
@@ -40,7 +40,6 @@
 
 #define NUM_PROVIDED_CLKS		2
 
-#define VCO_REF_CLK_RATE		19200000
 #define VCO_MIN_RATE			350000000
 #define VCO_MAX_RATE			750000000
 
@@ -166,17 +165,17 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC1_CFG, 0x70);
 	pll_write(base + REG_DSI_28nm_PHY_PLL_LPFC2_CFG, 0x15);
 
-	rem = rate % VCO_REF_CLK_RATE;
+	rem = rate % parent_rate;
 	if (rem) {
 		refclk_cfg = DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
 		frac_n_mode = 1;
-		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 500);
-		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 500);
+		div_fbx1000 = rate / (parent_rate / 500);
+		gen_vco_clk = div_fbx1000 * (parent_rate / 500);
 	} else {
 		refclk_cfg = 0x0;
 		frac_n_mode = 0;
-		div_fbx1000 = rate / (VCO_REF_CLK_RATE / 1000);
-		gen_vco_clk = div_fbx1000 * (VCO_REF_CLK_RATE / 1000);
+		div_fbx1000 = rate / (parent_rate / 1000);
+		gen_vco_clk = div_fbx1000 * (parent_rate / 1000);
 	}
 
 	DBG("refclk_cfg = %d", refclk_cfg);
@@ -265,7 +264,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	void __iomem *base = pll_28nm->mmio;
 	u32 sdm0, doubler, sdm_byp_div;
 	u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
-	u32 ref_clk = VCO_REF_CLK_RATE;
+	u32 ref_clk = parent_rate;
 	unsigned long vco_rate;
 
 	VERB("parent_rate=%lu", parent_rate);
@@ -273,7 +272,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	/* Check to see if the ref clk doubler is enabled */
 	doubler = pll_read(base + REG_DSI_28nm_PHY_PLL_REFCLK_CFG) &
 			DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
-	ref_clk += (doubler * VCO_REF_CLK_RATE);
+	ref_clk += (doubler * ref_clk);
 
 	/* see if it is integer mode or sdm mode */
 	sdm0 = pll_read(base + REG_DSI_28nm_PHY_PLL_SDM_CFG0);
@@ -514,11 +513,12 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
 	pll_28nm->clk_data.clk_num = 0;
 }
 
-static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
+static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm,
+			     const char *ref_clk_name)
 {
 	char clk_name[32], parent1[32], parent2[32], vco_name[32];
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -593,6 +593,8 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 {
 	struct dsi_pll_28nm *pll_28nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
+	const char *vco_ref_clk_name;
 	int ret;
 
 	if (!pdev)
@@ -605,6 +607,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (!IS_ERR(vco_ref_clk)) {
+		vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+	} else {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret == -EPROBE_DEFER)
+			ERR_PTR(ret);
+
+		dev_warn(&pdev->dev, "'ref' clock is not specified, using default name\n");
+		vco_ref_clk_name = "xo";
+	}
+
 	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
 	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
 		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
@@ -637,7 +651,7 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ret = pll_28nm_register(pll_28nm);
+	ret = pll_28nm_register(pll_28nm, vco_ref_clk_name);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register PLL: %d\n", ret);
 		return ERR_PTR(ret);
-- 
2.20.0.rc1.387.gf8505762e3-goog

