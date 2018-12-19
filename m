Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1017E20811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeLSXzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbeLSXzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so10558554pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EY1N6rx8t3eaW7PQ/P9Ram/E12rfORnATiv+M8wBb0A=;
        b=a6yHgkW7qLs4vV7+afpWcjzIOdLGLlvwV5yq/Dc8+RHGK52V5/To0J/yBa6XpTfm+u
         OTRskGhSIIN84ZB6B7dQaQ1nGlvufy/53qzMXra49vwVdZNHcdJctohhyjK4AVVqKVGB
         V642HWSGuYIyL7Ve7IR2au1CX88xKhwN4iw4Ab+3skaE3MVUBiDEgfUW/P0zDPFJwUar
         iloZFxaD6AcCZPPmp0t9cPuz9Lai0bLHTAlg5vFsumFLfgZqApp60PbqnRkKKVvaGbAj
         jtS2rgWuFb/tl2Wo5V/1MJ/UzPwCrTqb/mupX+brS16hPlrXPytgOxMqEG16Brrl/tKe
         3ugw==
X-Gm-Message-State: AA+aEWYxEYoeu2bLiho/fWgDBQBwwjrU1DnnC/0+V0kJAP/bT5yHvy/1
        Z3tMF6njPvzCccbutHsdzh4CCg==
X-Google-Smtp-Source: AFSGD/Ukcf+yv3BwkcRNMuA9qjmhs9vB1UxHkHHHSJ9hjdTmRAjQ5td7jkKl5Ye9UWWDJhgTWHhbeg==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr22316872pfc.198.1545263748782;
        Wed, 19 Dec 2018 15:55:48 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:47 -0800 (PST)
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
Subject: [PATCH v5 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Date:   Wed, 19 Dec 2018 15:55:24 -0800
Message-Id: <20181219235528.114830-5-mka@chromium.org>
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

Note: This change could break old out-of-tree DTS files that
use the 14nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v5:
- pass the ref clock name to _register() instead of storing a point
  to the clk object in the PLL data structure

Changes in v4:
- none

Changes in v3:
- fixed check for EPROBE_DEFER
- added note to commit message about breaking old DTS files
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
index 71fe60e5f01f1..9a647d93a7e0b 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
@@ -40,7 +40,6 @@
 
 #define NUM_PROVIDED_CLKS		2
 
-#define VCO_REF_CLK_RATE		19200000
 #define VCO_MIN_RATE			1300000000UL
 #define VCO_MAX_RATE			2600000000UL
 
@@ -591,7 +590,7 @@ static int dsi_pll_14nm_vco_set_rate(struct clk_hw *hw, unsigned long rate,
 	    parent_rate);
 
 	pll_14nm->vco_current_rate = rate;
-	pll_14nm->vco_ref_clk_rate = VCO_REF_CLK_RATE;
+	pll_14nm->vco_ref_clk_rate = parent_rate;
 
 	dsi_pll_14nm_input_init(pll_14nm);
 
@@ -947,11 +946,12 @@ static struct clk_hw *pll_14nm_postdiv_register(struct dsi_pll_14nm *pll_14nm,
 	return &pll_postdiv->hw;
 }
 
-static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm)
+static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm,
+			     const char *ref_clk_name)
 {
 	char clk_name[32], parent[32], vco_name[32];
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -1050,6 +1050,8 @@ struct msm_dsi_pll *msm_dsi_pll_14nm_init(struct platform_device *pdev, int id)
 {
 	struct dsi_pll_14nm *pll_14nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
+	const char *vco_ref_clk_name;
 	int ret;
 
 	if (!pdev)
@@ -1065,6 +1067,17 @@ struct msm_dsi_pll *msm_dsi_pll_14nm_init(struct platform_device *pdev, int id)
 	pll_14nm->id = id;
 	pll_14nm_list[id] = pll_14nm;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(vco_ref_clk)) {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
+	vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+
 	pll_14nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_14nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
@@ -1094,7 +1107,7 @@ struct msm_dsi_pll *msm_dsi_pll_14nm_init(struct platform_device *pdev, int id)
 	pll->en_seq_cnt = 1;
 	pll->enable_seqs[0] = dsi_pll_14nm_enable_seq;
 
-	ret = pll_14nm_register(pll_14nm);
+	ret = pll_14nm_register(pll_14nm, vco_ref_clk_name);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register PLL: %d\n", ret);
 		return ERR_PTR(ret);
-- 
2.20.1.415.g653613c723-goog

