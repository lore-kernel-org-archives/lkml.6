Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0414720811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeLSXz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:55:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46267 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbeLSXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:55:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10571141pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5K4NvmVx0V9ywsxNEseAiIwc2ZzmksvTJE0cDO3q/A=;
        b=T+bVWI7TKYseNjSkG6SSy84RMUYyM1fik2xIGdgNutvb2f60gQeGsQpJ7GBRflRt6N
         6jHkL3LP2gBxncCNFXFU1HVWh+DkT1geMKWVW9Hmu2u2vMUWJYrOwyopMk+TXxoyY48K
         7f8mqCEkUYgJlpmPovp20XHOmUgN+bWLvhMPirJPDlyMLoBsV3V7SsyFoWYYMHODj3bf
         vJQpg7ZbPaQ66MbmfJ0qYOlBLDtc/ntlBOH9ebknw1ru33HRDqTi0Hc6D9NDy2X6FJTf
         HFvkP6uNsQhMaQb4mlLMb/EjGvqmzv8tw6eYt0OIlGSwcokFl7Jpwv4I9XtO2lnnQ6Md
         4/Jg==
X-Gm-Message-State: AA+aEWYzR74WYjDi80HL90pOoi9V+qP6dvvgSIlsMoTERP1O/seT8P4A
        iLovazpLuaKGEhv9fx7OgQWPlA==
X-Google-Smtp-Source: AFSGD/X4erWd9DM/LxqLQgTOwPVBkpbQ7T4WHluHtTLkhiCJcFzQ3Unc16V7hMhR3nlJ9egv8NyFnQ==
X-Received: by 2002:a63:b105:: with SMTP id r5mr21293316pgf.442.1545263750805;
        Wed, 19 Dec 2018 15:55:50 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t67sm37045048pfd.90.2018.12.19.15.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 15:55:49 -0800 (PST)
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
Subject: [PATCH v5 5/8] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
Date:   Wed, 19 Dec 2018 15:55:25 -0800
Message-Id: <20181219235528.114830-6-mka@chromium.org>
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
use the 10nm PHY

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
- remove anonymous array in clk_init_data assignment
- log error code if devm_clk_get() fails
- don't log devm_clk_get() failures for -EPROBE_DEFER
- updated commit message
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 4c03f0b7343ed..adbe5395f4f38 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -625,12 +625,14 @@ static void dsi_pll_10nm_destroy(struct msm_dsi_pll *pll)
  * state to follow the master PLL's divider/mux state. Therefore, we don't
  * require special clock ops that also configure the slave PLL registers
  */
-static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
+static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm,
+			     const char *ref_clk_name)
 {
 	char clk_name[32], parent[32], vco_name[32];
 	char parent2[32], parent3[32], parent4[32];
+
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -771,6 +773,8 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
 {
 	struct dsi_pll_10nm *pll_10nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
+	const char *vco_ref_clk_name;
 	int ret;
 
 	if (!pdev)
@@ -786,6 +790,16 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
 	pll_10nm->id = id;
 	pll_10nm_list[id] = pll_10nm;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(vco_ref_clk)) {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+	vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+
 	pll_10nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
@@ -811,7 +825,7 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
 
 	pll_10nm->vco_delay = 1;
 
-	ret = pll_10nm_register(pll_10nm);
+	ret = pll_10nm_register(pll_10nm, vco_ref_clk_name);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register PLL: %d\n", ret);
 		return ERR_PTR(ret);
-- 
2.20.1.415.g653613c723-goog

