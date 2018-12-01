Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5700FC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F6820673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HLEX+LOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeLAMEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:04:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46224 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLAMEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so3190722pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWrCM77WkjJNs0uHmwXhClZRMn7AWk6Q6pGsnoalkDY=;
        b=HLEX+LOLmxw8EYZlBga+1D1IQ4/kpgdTGf48q6/1PBACScqMRuAnWOCmZQZn1QS4sz
         w6v1NbOSovg49iDMr8QqoPLY3pqtIxxbAoDwfpkRX+DdmvdHf1gH5Sl+Vs5NWXyO8QkI
         CutI/ZHRK3sQQ5aNfttrVt5AoatCFJAVwmwyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWrCM77WkjJNs0uHmwXhClZRMn7AWk6Q6pGsnoalkDY=;
        b=Ih6W5sHPKjeX7kbH1fc7ROCRau27DkMahLZHA7sfTBZ78D34qk+i1lzxVjEaA25M+R
         UmO08BG7XiBa+lKGCWHqvMGBggWAl/02jy/M6wAGfBPe/JJdgz55YMyv5DVcttvmbmAP
         GauatB7livuA7RnoUvFu77e6qHbx2JKIYLlZWknSycUxMO+xICdGyQ4rl61D+avlEE1b
         Zqd1KVfWdw2jSSj/0nA8cSJmSDJJ9GKW6qqb+TP/HS07bUbkh9Q6xIfYpupwv6fVrpu7
         JgtpPu8pmqtdPY5aLO9o89MmnHsW4SVDaXailt78pfmMOXjfxGevQ0AW7IVOf6i5P5Kr
         NKug==
X-Gm-Message-State: AA+aEWZp/juP40jtcJxVPXOX1b+pyIiaF+L7P0h2zVq+3Bpr6i96jEhJ
        k8Mu8N9vtC+eeBKEM1rkAgBfYg==
X-Google-Smtp-Source: AFSGD/WKbOJth2zgfWP4ngfPgpRi4fxDd1si6+gja5iW3oMIK9BioglwnKqp4zoO011+lIA/V2aIFQ==
X-Received: by 2002:a63:8d44:: with SMTP id z65mr6610004pgd.57.1543625610226;
        Fri, 30 Nov 2018 16:53:30 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:29 -0800 (PST)
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
Subject: [PATCH v3 5/8] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
Date:   Fri, 30 Nov 2018 16:52:51 -0800
Message-Id: <20181201005254.139908-6-mka@chromium.org>
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
hardcoding its name and rate.

Note: This change could break old out-of-tree DTS files that
use the 10nm PHY

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
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

