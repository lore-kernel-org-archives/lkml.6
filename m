Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB512C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9532081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kupznE6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9532081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeLDWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34695 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLDWnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so8052460pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9a0MShRejczGXlfzag4OTdzWDGfbAzuHBv0f6t1FeA=;
        b=kupznE6/3p14T4HWafu9VvDuqzvHmGNKDZd+bAuzBKlHDC6z8I53mdhOouXkisWNZo
         0xBMlsIfp3cnOl222NacGHA2om3tDIXMuOQMweWGfaWPFy+Wi+m9t0HgJB/CfINzHqiV
         3Z+PhIDb0e6yAGLTqhRDnvrH954SgawyMQjxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9a0MShRejczGXlfzag4OTdzWDGfbAzuHBv0f6t1FeA=;
        b=fFU836At/JQ04iEyJt1Pgh7PyY0uAwPf5JT53CPJD2IGUnyB4vVyhMNNj5sgxXdoLb
         7OV0+cm/FMTOI5LS7RFGqZWdS8WXsL+kg4yXwflK+K1nfpq/7Hu29NEbhx3aIh1QCsZ6
         /eRKwGynNzpZJknYjcnxppI5zYtQ20vaXm8Ctf1si+c1gqpNzsVPZuMoZ9x79hzBTl2L
         W2Qq0Zz5+FS/3mDGH8SkZmlQxcTjFnmooobeEMzPB50Xt/xCQcQg7joRcolD81SLa030
         5DUcJ7p4lq/eQS3j+8+WHbTgXYNiFM1MwU2mFKGMfLMkLZpLOdjMMaHZdl05SS1r41hs
         PM3A==
X-Gm-Message-State: AA+aEWaHMbOWXbSZlW3YLnM511c+K+fiZadpFg8lO7Cld4gQUDTuu1FE
        Zck3MvwS3BNLbY5iu/W2+oep6A==
X-Google-Smtp-Source: AFSGD/WLFJdbLniQpTXMfF2BP1YPFyzxTe/lyPkkBo0jpNWV4+KRg8afAG4fR1VraGHt1dpJ/E4OcA==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr18060039pgn.286.1543963398453;
        Tue, 04 Dec 2018 14:43:18 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y184sm21961917pgd.71.2018.12.04.14.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:43:17 -0800 (PST)
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
Subject: [PATCH v4 5/8] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
Date:   Tue,  4 Dec 2018 14:42:31 -0800
Message-Id: <20181204224234.62619-6-mka@chromium.org>
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
use the 10nm PHY

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
- remove anonymous array in clk_init_data assignment
- log error code if devm_clk_get() fails
- don't log devm_clk_get() failures for -EPROBE_DEFER
- updated commit message
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 4c03f0b7343ed..2d23372acd20d 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
@@ -91,6 +91,7 @@ struct dsi_pll_10nm {
 	void __iomem *phy_cmn_mmio;
 	void __iomem *mmio;
 
+	struct clk *vco_ref_clk;
 	u64 vco_ref_clk_rate;
 	u64 vco_current_rate;
 
@@ -629,8 +630,9 @@ static int pll_10nm_register(struct dsi_pll_10nm *pll_10nm)
 {
 	char clk_name[32], parent[32], vco_name[32];
 	char parent2[32], parent3[32], parent4[32];
+	const char *ref_clk_name = __clk_get_name(pll_10nm->vco_ref_clk);
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "xo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.name = vco_name,
 		.flags = CLK_IGNORE_UNUSED,
@@ -786,6 +788,15 @@ struct msm_dsi_pll *msm_dsi_pll_10nm_init(struct platform_device *pdev, int id)
 	pll_10nm->id = id;
 	pll_10nm_list[id] = pll_10nm;
 
+	pll_10nm->vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (IS_ERR(pll_10nm->vco_ref_clk)) {
+		ret = PTR_ERR(pll_10nm->vco_ref_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
 	pll_10nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
-- 
2.20.0.rc1.387.gf8505762e3-goog

