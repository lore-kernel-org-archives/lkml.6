Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27464C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C7720673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FlXqIosx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C7720673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLAMFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 07:05:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42565 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLAMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 07:04:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id x21-v6so3587214pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LI45bFlsD7zVrMZGddVOy1VzB8cFZD00h+Kdx5fCJbc=;
        b=FlXqIosx3pr6oWnUp5bveL5TXIetbdq47hmrILLuoI+4QMMbiUclRT/HVolYM3MMkP
         +FZC4TnTpDVpOBikmZaQ0NgJjjEfF8V7vXI0HkGzb4+Sbz4xieQF8uPbiO/V8pm4qaGT
         uV9VedCPw1fRQagZzSzAubwenbPhKyZDb+BtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LI45bFlsD7zVrMZGddVOy1VzB8cFZD00h+Kdx5fCJbc=;
        b=Tz2SCb9aBICI67VXr/OfCRqkYxtctFw+f+d3TueQW2Fjnv3sxKPD0fjHca9p+QjLTs
         4sB/EElsMXOEbVdWimJdkWkvPK42dxfv6qBrWj2ObOpK/+3UMFZNyI07/gjyKcCq03V6
         MQRIZAVfwzMl4TK3jjLAOZa6K+wtzyiNWJwdKMfCPRlGyDXMSE5VC+9wTLLVkxioEKNl
         r0GAF/EyPQcVOJ+DUkr939LKkCcY5BMqbMVgPuIhHfvEwAeL7MRIOKHyG/4Dx03y+8AH
         3HzgPbGQFHg115MSfy5aO+T4Y8Qi7ZvOPVsZHOqfScUUNeZOTB9Nd6GQEqA8D3GIJNfp
         AnHA==
X-Gm-Message-State: AA+aEWb2RGsOI7kB9f3VtucuUjzCMQ/wwa+ZijlW4AuEOYJ7EllEAJ5T
        R98UZWFZGIPGQNsjSYXjad8Y4A==
X-Google-Smtp-Source: AFSGD/VinoBrgeOVmxagIOQrCeQQ6pc5cJSTqRrEsx7rUxpce3XePKXfjHEwZTqXAfvpdy/AL5oKYA==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr7718839pll.111.1543625606947;
        Fri, 30 Nov 2018 16:53:26 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id z8sm16518566pgz.53.2018.11.30.16.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:53:26 -0800 (PST)
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
Subject: [PATCH v3 2/8] drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
Date:   Fri, 30 Nov 2018 16:52:48 -0800
Message-Id: <20181201005254.139908-3-mka@chromium.org>
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
hardcoding its name and rate. Use default values if the ref
clock is not specified.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- use default name and rate if the ref clock is not specified
  in the DT
- store vco_ref_clk_name instead of vco_ref_clk
- fixed check for EPROBE_DEFER
- renamed VCO_REF_CLK_RATE to VCO_REF_CLK_DEFAULT_RATE

Changes in v2:
- patch added to the series
---
 .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
index 49008451085b8..3af678d3317f6 100644
--- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
@@ -47,9 +47,9 @@
 
 #define NUM_PROVIDED_CLKS	2
 
-#define VCO_REF_CLK_RATE	27000000
-#define VCO_MIN_RATE		600000000
-#define VCO_MAX_RATE		1200000000
+#define VCO_REF_CLK_DEFAULT_RATE	27000000
+#define VCO_MIN_RATE			600000000
+#define VCO_MAX_RATE			1200000000
 
 #define DSI_BYTE_PLL_CLK	0
 #define DSI_PIXEL_PLL_CLK	1
@@ -75,6 +75,8 @@ struct dsi_pll_28nm {
 	struct platform_device *pdev;
 	void __iomem *mmio;
 
+	const char *vco_ref_clk_name;
+
 	/* custom byte clock divider */
 	struct clk_bytediv *bytediv;
 
@@ -125,7 +127,10 @@ static int dsi_pll_28nm_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	DBG("rate=%lu, parent's=%lu", rate, parent_rate);
 
 	temp = rate / 10;
-	val = VCO_REF_CLK_RATE / 10;
+	if (parent_rate)
+		val = parent_rate / 10;
+	else
+		val = VCO_REF_CLK_DEFAULT_RATE / 10;
 	fb_divider = (temp * VCO_PREF_DIV_RATIO) / val;
 	fb_divider = fb_divider / 2 - 1;
 	pll_write(base + REG_DSI_28nm_8960_PHY_PLL_CTRL_1,
@@ -410,7 +415,7 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm)
 {
 	char *clk_name, *parent_name, *vco_name;
 	struct clk_init_data vco_init = {
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_names = &pll_28nm->vco_ref_clk_name,
 		.num_parents = 1,
 		.flags = CLK_IGNORE_UNUSED,
 		.ops = &clk_ops_dsi_pll_28nm_vco,
@@ -494,6 +499,7 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 {
 	struct dsi_pll_28nm *pll_28nm;
 	struct msm_dsi_pll *pll;
+	struct clk *vco_ref_clk;
 	int ret;
 
 	if (!pdev)
@@ -506,6 +512,18 @@ struct msm_dsi_pll *msm_dsi_pll_28nm_8960_init(struct platform_device *pdev,
 	pll_28nm->pdev = pdev;
 	pll_28nm->id = id + 1;
 
+	vco_ref_clk = devm_clk_get(&pdev->dev, "ref");
+	if (!IS_ERR(vco_ref_clk)) {
+		pll_28nm->vco_ref_clk_name = __clk_get_name(vco_ref_clk);
+	} else {
+		ret = PTR_ERR(vco_ref_clk);
+		if (ret == -EPROBE_DEFER)
+			return ERR_PTR(ret);
+
+		dev_warn(&pdev->dev, "'ref' clock is not specified, using default name\n");
+		pll_28nm->vco_ref_clk_name = "pxo";
+	}
+
 	pll_28nm->mmio = msm_ioremap(pdev, "dsi_pll", "DSI_PLL");
 	if (IS_ERR_OR_NULL(pll_28nm->mmio)) {
 		dev_err(&pdev->dev, "%s: failed to map pll base\n", __func__);
-- 
2.20.0.rc1.387.gf8505762e3-goog

