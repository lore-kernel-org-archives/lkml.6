Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6994C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0A02081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k2vxh+Ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLDWnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40895 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLDWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:15 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so9013984plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHna8u9FKf6J9ziMeKKaX8sDyEF2n0RgvcE1So7rIQI=;
        b=k2vxh+Evf9lsyWVrN9fS36QB3Ng0vE/z7UShF5YeK7s/GVgjWi8cSxWqAzpmmej+Jr
         aDebf4Y4iMLix4pmlppvtnP4fNw3Js3jaadey9sr7EkLBKkAgnqDlGGIhwSR7QMJvir0
         uT2x+y8R9VoSg+QZdL/EZcKNKsWsUcf/sDp5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHna8u9FKf6J9ziMeKKaX8sDyEF2n0RgvcE1So7rIQI=;
        b=g3YFj18f8jkZrjqOikcUtoNDp6zFBAX3PQRwrPhMYnV2hRcXIkm4CQyDXfIxXaHHzK
         6wHW4wbS3MqU6KSBb+JZi3NuNQkRKU3gXM17p4oL5z6ecYhdaZOJT/Gf9dPpSMHF9e12
         sdUiCNJe/ypA8+q1sYpkYuuZwr1kJHxrG1hxxDT8bt+OVP/7+G2ORV70pwznEX9u5/Hg
         0+Jm6EwvizsfckMLWbWZ1ywzmBC4o5gFyPSasYcomz1LExCHIrNvVShW09q1ESYqdd87
         +udx+dQTCq5V+6JaG+/9EBpvW7/LIm1YzJOLAJ/EQ07v/BjYIkNc4HAfGrJ3xbGD0P+r
         GUFQ==
X-Gm-Message-State: AA+aEWYGPVhgxFjht8PDTWeauxr0c5sswuuqFYyp0LF6VzAhrD3sM9ch
        FBGCA4lPD5zB4XNkdOhgg3ovJQ==
X-Google-Smtp-Source: AFSGD/W3KyMz+d4oTcSdX4UD3mgvHaq25DPtv0Xd51dzH+9s0/gWhzBc9BYJRhjqfKt2QHim6okhaA==
X-Received: by 2002:a17:902:6113:: with SMTP id t19mr21091745plj.248.1543963395251;
        Tue, 04 Dec 2018 14:43:15 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:14 -0800 (PST)
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
Subject: [PATCH v4 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Tue,  4 Dec 2018 14:42:28 -0800
Message-Id: <20181204224234.62619-3-mka@chromium.org>
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
2.20.0.rc1.387.gf8505762e3-goog

