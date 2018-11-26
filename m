Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF0EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DBE21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LiUkGTSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DBE21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeK0KIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeK0KIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so6872685pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ul42tT8KdidvKSlbruamChZE2/PFTszifOeSCwRSgtU=;
        b=LiUkGTSpOlW/DqF+P3ufV1oTnydFFffBFJzj1fbfK2CMwuWc/rbmYy/oPUyuiGzHDk
         jmGRC7vu6+2Lu/5UdNB20APDeVzI/CQySZxgfMZCLExG/YeA+cMdwq/iM84gIsPuiBpP
         9oNBxD6qMgqTdegzD4tGaGtKZ8nWqtNyv3on8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ul42tT8KdidvKSlbruamChZE2/PFTszifOeSCwRSgtU=;
        b=Vc68c4hvVQ3PNGpGsoMzIE8Yc3kdKfbjZTJI9uSn4ocpZadURj+c3zwFOh0Qwjp8E5
         CL58cqBG9nAchQ0AcPM3gYy8T52hll86NcKok7aQFMZaoxniqdSslqNzUt5lPZQ8JLRO
         bX/yKmdaj5llODSOqDmzP+sWc+rPTOylv5ZZkZlrBaAiQVn8ytG4pksOEsiPIpsXfNXQ
         RKkgBYlo66ugy9tPsjdw9R6j4aBgpd+EUW8EitEG8K21060CtTMHioijVZb7cvccuVUF
         52rtWwnPZb5y22cpL8u7ybPF/agbc0EEQXpqbIgsJafpFXNkBNko70VHQikAYLbRNK2Z
         kqzQ==
X-Gm-Message-State: AGRZ1gJVFBhYYS4RAzFLLyozcipdiLaSOZyXtanrB1rZE3pqYxpk8dDV
        el2EzON2pemRcNnqTWFreOIF/A==
X-Google-Smtp-Source: AJdET5d167jwOkGVIFHefhFkaLpTgkCg5TUW4izLvasF+qgJfcTgujKgvU5zSye9hC1QBWHWuv6qeQ==
X-Received: by 2002:a62:1541:: with SMTP id 62mr30349869pfv.230.1543273956190;
        Mon, 26 Nov 2018 15:12:36 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:35 -0800 (PST)
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
Subject: [PATCH v2 5/7] drm/msm/dsi: 28nm PHY: Get ref clock from the DT
Date:   Mon, 26 Nov 2018 15:11:57 -0800
Message-Id: <20181126231159.122298-6-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126231159.122298-1-mka@chromium.org>
References: <20181126231159.122298-1-mka@chromium.org>
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
Changes in v2:
- patch added to the series
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c | 29 +++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
index 26e3a01a99c2b..a1ab5ecbf7c7d 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
@@ -40,7 +40,6 @@
 
 #define NUM_PROVIDED_CLKS		2
 
-#define VCO_REF_CLK_RATE		19200000
 #define VCO_MIN_RATE			350000000
 #define VCO_MAX_RATE			750000000
 
@@ -81,6 +80,7 @@ struct dsi_pll_28nm {
 	struct platform_device *pdev;
 	void __iomem *mmio;
 
+	struct clk *vco_ref_clk;
 	int vco_delay;
 
 	/* private clocks: */
@@ -139,6 +139,7 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct dsi_pll_28nm *pll_28nm = to_pll_28nm(pll);
 	struct device *dev = &pll_28nm->pdev->dev;
 	void __iomem *base = pll_28nm->mmio;
+	u64 ref_clk_rate = parent_rate;
 	unsigned long div_fbx1000, gen_vco_clk;
 	u32 refclk_cfg, frac_n_mode, frac_n_value;
 	u32 sdm_cfg0, sdm_cfg1, sdm_cfg2, sdm_cfg3;
@@ -166,17 +167,17 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -265,7 +266,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	void __iomem *base = pll_28nm->mmio;
 	u32 sdm0, doubler, sdm_byp_div;
 	u32 sdm_dc_off, sdm_freq_seed, sdm2, sdm3;
-	u32 ref_clk = VCO_REF_CLK_RATE;
+	u32 ref_clk = parent_rate;
 	unsigned long vco_rate;
 
 	VERB("parent_rate=%lu", parent_rate);
@@ -273,7 +274,7 @@ static unsigned long dsi_pll_28nm_clk_recalc_rate(struct clk_hw *hw,
 	/* Check to see if the ref clk doubler is enabled */
 	doubler = pll_read(base + REG_DSI_28nm_PHY_PLL_REFCLK_CFG) &
 			DSI_28nm_PHY_PLL_REFCLK_CFG_DBLR;
-	ref_clk += (doubler * VCO_REF_CLK_RATE);
+	ref_clk += (doubler * ref_clk);
 
 	/* see if it is integer mode or sdm mode */
 	sdm0 = pll_read(base + REG_DSI_28nm_PHY_PLL_SDM_CFG0);
@@ -517,8 +518,9 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
 static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
 {
 	char clk_name[32], parent1[32], parent2[32], vco_name[32];
+	const char *ref_clk_name = __clk_get_name(pll_28nm->vco_ref_clk);
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -605,6 +607,15 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id;
 
+	pll_28nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(pll_28nm->vco_ref_clk)) {
+		ret = PTR_ERR(pll_28nm->vco_ref_clk);
+		if (ret != EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
 	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
 	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
 		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

