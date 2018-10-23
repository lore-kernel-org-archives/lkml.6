Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7042BC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C38420652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PGrYiEMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C38420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeJXAPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:15:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40440 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeJXAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:15:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so883255pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6O+bKIpaRU1xNmIxDVHfAdJTMH9a5FqvJg2+MWooA9w=;
        b=PGrYiEMPaGMKtNxEjkt3eWFCpt9pgqXPUuPauYpZh7dt9ptv4An2Dyn3pfOeIVOHiM
         39RFla1Ht7gF6ePGwK2AgK7IuCsbILwcg2MmMgaGcbANPUsRV1aN20hA3tK3r/NWWGnQ
         BxyH/9S5/Irk7GyZBsLHuz9TNzQSwwFPNyRaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6O+bKIpaRU1xNmIxDVHfAdJTMH9a5FqvJg2+MWooA9w=;
        b=YluArqpDVbtlunWDVxkcSwysUEPhO500vUYzMf/cR3andNhAAH28xWN9cnt6HHX97O
         6oCmXWTCs0Q568218XLzNQQO2t0KfyUWQbDBp9uRBgVPC8aUE+t8czjhzG4lgbDnJDLy
         JvuFYinJtu34WYcRJE5LRhg4Uhq3dBctiFzWsCwELlfLeOsFeTnPlACGbz6DqN5BtWF8
         ok/ScO/j+yEBcLAE1eWznGyB1SvVOiMrp5+36eJz1V2aFoYDlxwp5XUout7W0fy/SpXP
         +024bB9DxMX0u7LOrB7UpLUKTl2UT6p2I0hP5LdPHgCu6SYlkutxiCVcupGGZZZ+3px0
         oq3g==
X-Gm-Message-State: ABuFfohTXTsnPyvEruCEIA8O4peA/MydXTNJOtTnpavpm7NxVyPx+5W5
        3ITBP0RP22Dh6xWlZCwGuAnp0A==
X-Google-Smtp-Source: ACcGV60D3BFv/o3UPI5UV3Eqhg64DxoH79hVRJx0QmY7lphUQUP8NxnhbPtEdxVR+gb9U/7lmEWBew==
X-Received: by 2002:a63:1c1b:: with SMTP id c27-v6mr47761734pgc.351.1540309881639;
        Tue, 23 Oct 2018 08:51:21 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:51:21 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 04/15] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
Date:   Tue, 23 Oct 2018 21:20:24 +0530
Message-Id: <20181023155035.9101-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)

So, alter has_mod_clk bool via driver data for respective
SoC's compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 47 ++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  5 +++
 2 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index e3b34a345546..8e9c76febca2 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -10,6 +10,7 @@
 #include <linux/component.h>
 #include <linux/crc-ccitt.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
@@ -981,6 +982,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	dsi->host.ops = &sun6i_dsi_host_ops;
 	dsi->host.dev = dev;
 
+	dsi->variant = of_device_get_match_data(dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base)) {
@@ -1001,17 +1004,20 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
-	dsi->mod_clk = devm_clk_get(dev, "mod");
-	if (IS_ERR(dsi->mod_clk)) {
-		dev_err(dev, "Couldn't get the DSI mod clock\n");
-		return PTR_ERR(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk) {
+		dsi->mod_clk = devm_clk_get(dev, "mod");
+		if (IS_ERR(dsi->mod_clk)) {
+			dev_err(dev, "Couldn't get the DSI mod clock\n");
+			return PTR_ERR(dsi->mod_clk);
+		}
 	}
 
 	/*
 	 * In order to operate properly, that clock seems to be always
 	 * set to 297MHz.
 	 */
-	clk_set_rate_exclusive(dsi->mod_clk, 297000000);
+	if (dsi->variant->has_mod_clk)
+		clk_set_rate_exclusive(dsi->mod_clk, 297000000);
 
 	dphy_node = of_parse_phandle(dev->of_node, "phys", 0);
 	ret = sun6i_dphy_probe(dsi, dphy_node);
@@ -1043,7 +1049,8 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 	sun6i_dphy_remove(dsi);
 err_unprotect_clk:
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 	return ret;
 }
 
@@ -1056,7 +1063,8 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	mipi_dsi_host_unregister(&dsi->host);
 	pm_runtime_disable(dev);
 	sun6i_dphy_remove(dsi);
-	clk_rate_exclusive_put(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_rate_exclusive_put(dsi->mod_clk);
 
 	return 0;
 }
@@ -1066,7 +1074,8 @@ static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
 	reset_control_deassert(dsi->reset);
-	clk_prepare_enable(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_prepare_enable(dsi->mod_clk);
 
 	/*
 	 * Enable the DSI block.
@@ -1094,7 +1103,8 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(dsi->mod_clk);
+	if (dsi->variant->has_mod_clk)
+		clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
 
 	return 0;
@@ -1106,9 +1116,24 @@ static const struct dev_pm_ops sun6i_dsi_pm_ops = {
 			   NULL)
 };
 
+static const struct sun6i_dsi_variant sun6i_a31_dsi = {
+	.has_mod_clk = true,
+};
+
+static const struct sun6i_dsi_variant sun50i_a64_dsi = {
+	.has_mod_clk = false,
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
-	{ .compatible = "allwinner,sun6i-a31-mipi-dsi" },
-	{ }
+	{
+		.compatible = "allwinner,sun6i-a31-mipi-dsi",
+		.data = &sun6i_a31_dsi,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_dsi,
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
 
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index dbbc5b3ecbda..597b62227019 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -20,6 +20,10 @@ struct sun6i_dphy {
 	struct reset_control	*reset;
 };
 
+struct sun6i_dsi_variant {
+	bool			has_mod_clk;
+};
+
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -35,6 +39,7 @@ struct sun6i_dsi {
 	struct sun4i_drv	*drv;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
+	const struct sun6i_dsi_variant	*variant;
 };
 
 static inline struct sun6i_dsi *host_to_sun6i_dsi(struct mipi_dsi_host *host)
-- 
2.18.0.321.gffc6fa0e3

