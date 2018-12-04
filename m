Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC8AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D9E206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBU18CCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLDWnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeLDWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so8028205pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0jFelkzXdX0sdnSwl2wHgfI7CmGxa6D2F+msr9ytBY=;
        b=lBU18CCaDdTStAcCb4JvlxrXv8h5wMIOS9eN1iMKjan7gTziyyfCdOUXClziC3iJ70
         VAJ2eYCipw+1u3XxarXoZXNX6bK4otylJsUmlWN+Mx0QiSzy4D0SxxhFRBm6muQkbzuZ
         eRF9ERRMzDYYy/0qphGt8mnNaQXBBXsICjiXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0jFelkzXdX0sdnSwl2wHgfI7CmGxa6D2F+msr9ytBY=;
        b=jTwzD79/RjWE0w7Y/3kFfKVHErDrJ50JYFfpEClIesFVX9YTnOF6HJHljZNmyGvYC4
         GuYJiq5x4DvbnXVo8u9tMrKynGGOSf1K6IQRFSJG/6qR/MxN9q5NzQbXFEJbSH4eTbNa
         58qidTO5uRh79uw6NyyeEf1y/7dm71/GAmhXUMIONYLyRZPol3TsiZ0JlY46ogVbqELR
         fvvg/lFHi3oNoqkc3+CigcEuw/hGMZmHKP9h8hJiOIWAoMbx8V9V5Nd6GXBQfAzbTbFG
         dD/SqkAGSKnen6qx1Lm+30rWaaFdNnsEceZbyITtU3jaOFI5MZV8Rz8gSbHQGwCuQZZQ
         eRsg==
X-Gm-Message-State: AA+aEWZfhEyQo2/HC//zx/B7cSsQovAcDfsFHkPo0WnKdRl1ii7sPdRC
        T/IrBn2QcafMcfDX1PyQ6FjOxQ==
X-Google-Smtp-Source: AFSGD/VcRNB10UrcZdYJIHDpWENO2Lsxi/rSfS4QXCOG6QoNWnFScSGCGhwUWox9Uq4AvJnUYzW3HQ==
X-Received: by 2002:a63:c447:: with SMTP id m7mr18283874pgg.27.1543963397397;
        Tue, 04 Dec 2018 14:43:17 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:16 -0800 (PST)
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
Subject: [PATCH v4 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Date:   Tue,  4 Dec 2018 14:42:30 -0800
Message-Id: <20181204224234.62619-5-mka@chromium.org>
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

Note: This change could break old out-of-tree DTS files that
use the 14nm PHY.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v4:
- none

Changes in v3:
- fixed check for EPROBE_DEFER
- added note to commit message about breaking old DTS files
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v2:
- patch added to the series
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
index 71fe60e5f01f1..032bf3e8614bd 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
@@ -40,7 +40,6 @@
 
 #define NUM_PROVIDED_CLKS		2
 
-#define VCO_REF_CLK_RATE		19200000
 #define VCO_MIN_RATE			1300000000UL
 #define VCO_MAX_RATE			2600000000UL
 
@@ -139,6 +138,7 @@ struct dsi_pll_14nm {
 	/* protects REG_DSI_14nm_PHY_CMN_CLK_CFG0 register */
 	spinlock_t postdiv_lock;
 
+	struct clk *vco_ref_clk;
 	u64 vco_current_rate;
 	u64 vco_ref_clk_rate;
 
@@ -591,7 +591,7 @@ static int dsi_pll_14nm_vco_set_rate(struct clk_hw *hw, unsigned long rate,
 	    parent_rate);
 
 	pll_14nm->vco_current_rate = rate;
-	pll_14nm->vco_ref_clk_rate = VCO_REF_CLK_RATE;
+	pll_14nm->vco_ref_clk_rate = parent_rate;
 
 	dsi_pll_14nm_input_init(pll_14nm);
 
@@ -950,8 +950,9 @@ static struct clk_hw *pll_14nm_postdiv_register(struct dsi_pll_14nm *pll_14nm,
 static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm)
 {
 	char clk_name[32], parent[32], vco_name[32];
+	const char *ref_clk_name = __clk_get_name(pll_14nm->vco_ref_clk);
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -1065,6 +1066,15 @@ struct msm_dsi_pll *msm_dsi_pll_14nm_init(struct platform_device *pdev, int id)
 	pll_14nm->id = id;
 	pll_14nm_list[id] = pll_14nm;
 
+	pll_14nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(pll_14nm->vco_ref_clk)) {
+		ret = PTR_ERR(pll_14nm->vco_ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
 	pll_14nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_14nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
-- 
2.20.0.rc1.387.gf8505762e3-goog

