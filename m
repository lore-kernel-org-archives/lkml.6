Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4277AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7920811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbeLSX4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:56:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38123 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbeLSXzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so10582577pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m6RABKy+RQ632Gx1r+iOUpX5DYoCMTAL7f9pkUnDO08=;
        b=sIgmaYgzyAQ/hX0sEtH50UocUVa1V2eTZExlEgBJYAO79ydAfYEJnuk75uDYv17Qje
         71LSqP7Mwwjfldz/ebT9H1Mj7HM3RArGpft0f5EsG7Du7qM8wlM+RtFX/uWuwq2oJbTN
         QEcijHV4GqaG8nKK/YIHyks6UCdzZ5+rfgA+gsx8yygkmJWQ8prDd7/FoLeayuGOpExT
         TO1jZoRqpJzM6ynSAMgfSTb5AAZbIQ8KrGJ4cZu/COMdlT8JyQGXYnob5ioyK3QV8VnV
         7reprSyyqcpWqiQ0Dd8iwMvUtKYJihfgMqyB3mT80V/hOZrUynH9USEmze94crBO1vDM
         fCdA==
X-Gm-Message-State: AA+aEWYa5BLu8mNZ+1Uuk/fE7jvWLW48zmQQhbw3uBD9yxRPL1krruqi
        dmzNneJpymW/kVGyqw5WRDqE3g==
X-Google-Smtp-Source: AFSGD/U7yU7mtMYGDjHOX2SIgraf8zZLQl+pRmkfSvSAfj/zF3zY+r65MK8X0u7O1NgajwaLTjwdSA==
X-Received: by 2002:aa7:868f:: with SMTP id d15mr21992413pfo.225.1545263746732;
        Wed, 19 Dec 2018 15:55:46 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:45 -0800 (PST)
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
Subject: [PATCH v5 3/8] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Date:   Wed, 19 Dec 2018 15:55:23 -0800
Message-Id: <20181219235528.114830-4-mka@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org> tag
---
Changes in v5:
- added missing return keyword in msm_dsi_pll_28nm_init()
- added "Reviewed-by: Stephen Boyd <swboyd@chromium.org>" tag

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
index 26e3a01a99c2b..c839464741927 100644
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
+			return ERR_PTR(ret);
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
2.20.1.415.g653613c723-goog

