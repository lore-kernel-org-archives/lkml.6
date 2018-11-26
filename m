Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D1D208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRhOZ2Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D1D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeK0KIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeK0KIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so14618139plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIVHbVb70bSW4VFog/QlcHwPp+zltJ2Z0ttdTfVSELs=;
        b=TRhOZ2BnQGplOqlJbh/WHW6aam6+lwZO8dhxQ6MwJS6cbHzHS8sWr2H7lmlZn0MFPd
         zZG0bN01at+wAPazx8cfks/iA6bWSr3HjBJyKIekGueymgTtb3FOlAJnRUTupmPFR1iW
         mNFPB21ibVJ9DTUkEQpuWmhiW53aRP0/P/cWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIVHbVb70bSW4VFog/QlcHwPp+zltJ2Z0ttdTfVSELs=;
        b=gpawSV5Z0YwKiHPWtWuwzZx7kcaypMeIOeD0+meWozago6V+jpGjWZKI8zR/xPozpo
         YLY0xeaUkGnK3rqQg9NgNGK1iDjJCYPULajrCZ8oXOGovlNabr9cZLxn/ndNJzZWcX4z
         4EceyHaXMFcf1i6Nj5u2TjeCtama9doPe5E3ZlA/7IUzdRaP9FNe95VCfCiY9z1LDxGC
         NSvxC/qpbVkx6X7ZgEzc1O4KxNmxAq0+kyHJc9/UERyaSfZ4Zv1GDHzx7A5zSaRdJ/JI
         xjDZrMXJQuuOeqt/hTSNNcoEkquf0dllLW7FYY5RDRVnlGD/Pa/0JNHfdOLoPoRQ57Bo
         IGRA==
X-Gm-Message-State: AA+aEWYRq4AH9hLcOjOvWiJrKCMGNx0N0N6FofqecYVLhrgO4DKEaoq/
        HFHr4w2SPKEnYeZUR1s6ABG9Ng==
X-Google-Smtp-Source: AFSGD/X9s6Bz9D/JvK0sEODz3nxrCQ9q06e+9oI3VPVOtSp033o3ix0qfAZpsrYNTiEdOBYg2Jhksw==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr25806016ply.143.1543273958136;
        Mon, 26 Nov 2018 15:12:38 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:37 -0800 (PST)
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
Subject: [PATCH v2 7/7] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
Date:   Mon, 26 Nov 2018 15:11:59 -0800
Message-Id: <20181126231159.122298-8-mka@chromium.org>
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
- remove anonymous array in clk_init_data assignment
- log error code if devm_clk_get() fails
- don't log devm_clk_get() failures for -EPROBE_DEFER
- updated commit message
---
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
index 4c03f0b7343ed..32e31574e1432 100644
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
+		if (ret != EPROBE_DEFER)
+			dev_err(&pdev->dev, "couldn't get 'ref' clock: %d\n",
+				ret);
+		return ERR_PTR(ret);
+	}
+
 	pll_10nm->phy_cmn_mmio = msm_ioremap(pdev, "dsi_phy", "DSI_PHY");
 	if (IS_ERR_OR_NULL(pll_10nm->phy_cmn_mmio)) {
 		dev_err(&pdev->dev, "failed to map CMN PHY base\n");
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

