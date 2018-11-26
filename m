Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B800C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339F4208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="loaw39mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339F4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeK0KIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:08:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44448 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeK0KIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:08:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so6871336pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bULpEf9pmNOFX1T2ClLP1q8zs+ON+Mf99hvsx7tQruo=;
        b=loaw39mDfgaB4bTcKSCy599EtzSGmjZfUJQCt9EFoWzCSvm/EyJ95DwIePb2swC7zZ
         PUs9Nta1jbJGhk2HRW7iquhrfIYKAkOJmQC/x2J+FRrMT2jTOCS++z6XirUyvFS0+/jV
         ycXgH4YOtnwivriswzcy3m4OHNA9GJHjs6OP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bULpEf9pmNOFX1T2ClLP1q8zs+ON+Mf99hvsx7tQruo=;
        b=awvkyE3P/2vbBAuKiKetWSfoTd+J1l7+0T3LhPxTBFXs+s/FSJqgOrVWDL2u+vbAk6
         ec/KQaoBoqqa4AZkDf140zg2eRZ5p6QO+m/LOjghR0+9I/pfd2bsArNahMav3bSt0pS+
         fPhC9UQD1dGo+GbhgATdDzKL/1eX8+qbSVt9KmHqd151+CbRm9WVFijOUaPEvJmRCtZ3
         o3WuhyVB+9k0KNMcPtQhDjz9UHB7nOUNJdq5GeAmfOZd+0erOw96XlYLHtwI1CHKI1nk
         xzvWutajd9QZCB+0qRKNizUveoV993ZyTtoMW9ru1pSFg79ubd401k1Vi+ICQwSRQqkz
         56FA==
X-Gm-Message-State: AGRZ1gKRra4koePpKi3unbqKIxiwfZUvno4PMFUgHjCHoJRB7QVVHx7k
        aXydj8A7CzjG4pd59MS3BCtLCA==
X-Google-Smtp-Source: AJdET5e9+sBNNU2J++2lxzE2GplAk5Joxt7ijj7vyo4OHwCZgHUuDd9ay2ndUAjsP9ElaAr6r8SvJQ==
X-Received: by 2002:a62:31c2:: with SMTP id x185-v6mr30355975pfx.39.1543273954304;
        Mon, 26 Nov 2018 15:12:34 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id j6sm2128625pfg.126.2018.11.26.15.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:12:33 -0800 (PST)
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
Subject: [PATCH v2 3/7] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Mon, 26 Nov 2018 15:11:55 -0800
Message-Id: <20181126231159.122298-4-mka@chromium.org>
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
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
index 49008451085b8..461975c410fc4 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
@@ -47,7 +47,6 @@
 
 #define NUM_PROVIDED_CLKS	2
 
-#define VCO_REF_CLK_RATE	27000000
 #define VCO_MIN_RATE		600000000
 #define VCO_MAX_RATE		1200000000
 
@@ -75,6 +74,8 @@ struct dsi_pll_28nm {
 	struct platform_device *pdev;
 	void __iomem *mmio;
 
+	struct clk *vco_ref_clk;
+
 	/* custom byte clock divider */
 	struct clk_bytediv *bytediv;
 
@@ -125,7 +126,7 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	DBG("rate=%lu, parent's=%lu", rate, parent_rate);
 
 	temp = rate / 10;
-	val = VCO_REF_CLK_RATE / 10;
+	val = parent_rate / 10;
 	fb_divider = (temp * VCO_PREF_DIV_RATIO) / val;
 	fb_divider = fb_divider / 2 - 1;
 	pll_write(base + REG_DSI_28nm_8960_PHY_PLL_CTRL_1,
@@ -409,8 +410,9 @@ static void dsi_pll_28nm_destroy(struct msm_dsi_pll *pll)
 static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
 {
 	char *clk_name, *parent_name, *vco_name;
+	const char *ref_clk_name = __clk_get_name(pll_28nm->vco_ref_clk);
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_names = &ref_clk_name,
 		.num_parents = 1,
 		.flags = CLK_IGNORE_UNUSED,
 		.ops = &clk_ops_dsi_pll_28nm_vco,
@@ -506,6 +508,15 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id + 1;
 
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

