Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C0AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A21213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GZYV0MVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A21213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeK0KIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:18 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0KIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so7340792pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7HNDUjimOuljzH9xDciQlzrcjWgVDUvXpjMz/dY9FU=;
        b=GZYV0MVLBrouSdBqXV6OcgDqaeN0Sp97kYsVkii7mfG81V29Yb6mjvvqjsUeI3u50Z
         6iSvFtZITUXk4x+xLnnKPYDDy8pCXdWNTioMcMjtZa6HvIMs2GCvVSYLoXu/JGA3/K/P
         g6TY3Rkk5tN0H/rgS3/9193HkAJ+niTZuPW0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7HNDUjimOuljzH9xDciQlzrcjWgVDUvXpjMz/dY9FU=;
        b=lreZlTXha1MxS1BRFbYuxJvWOIiV+Y2rN766yk0DyNn832jStZknMTHkbtXHZ9LFhh
         rX7eahSBdrVZ7yEtT+XQF4+ltg67bagEKIbVchxWbWEbqqrBV9K3PceSLc4MyKjcXin6
         hO1MbWHG2qL/9BJAeCSIogW8bkcE1kg2lcFQJUIcYsKl+O+Zy06JPdJTc5Re0WcjmGat
         4fhYGRaUyqEL232HlpeI7K0MSny1gIeMxeM4Lxop7368+gEUr6/97u8HTJry9Br4vyZK
         ziu9PziuPP53hLqa01GMfVvCWvdU98haboKxzI8TJJ4ALmuD86uYSCqcpmv2Qdqc4xqW
         CJ4g==
X-Gm-Message-State: AGRZ1gIubnie1xYeGpA8uN0Qo0JFIAbW258pf0mp1SvdsC1FoetUeRgV
        78xWHFppRY6+BppciJUSKl8/kQ==
X-Google-Smtp-Source: AJdET5ePMWHQxdLqO6dlkCvB/QhF06uC/vtsOgq4u1/jVszQyLSweCnWG+ccLxOxWM8bh4Awn4hhpQ==
X-Received: by 2002:a62:7652:: with SMTP id r79mr31137094pfc.241.1543273953050;
        Mon, 26 Nov 2018 15:12:33 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:32 -0800 (PST)
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
Subject: [PATCH v2 2/7] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
Date:   Mon, 26 Nov 2018 15:11:54 -0800
Message-Id: <20181126231159.122298-3-mka@chromium.org>
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
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
index 71fe60e5f01f1..f58298bd6c423 100644
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
+		if (ret != EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
 	pll_14nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_14nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

