Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11264214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11264214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeHBNzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:55:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:40602 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbeHBNzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:55:32 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b62f22b0000>; Thu, 02 Aug 2018 19:59:39 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Aug 2018 04:59:36 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 02 Aug 2018 04:59:36 -0700
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Aug
 2018 11:59:33 +0000
Received: from vreddytalla-dt.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 2 Aug 2018 11:59:29 +0000
From:   Venkat Reddy Talla <vreddytalla@nvidia.com>
To:     <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <jonathanh@nvidia.com>, <pdeschrijver@nvidia.com>,
        <vivek.gautam@codeaurora.org>, <p.zabel@pengutronix.de>,
        <thierry.reding@gmail.com>, <mperttunen@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <avienamo@nvidia.com>, <talho@nvidia.com>, <ldewangan@nvidia.com>,
        <vreddytalla@nvidia.com>
Subject: [PATCH 3/3] drm/tegra: sor: change io pad power state using new pmc api
Date:   Thu, 2 Aug 2018 17:29:03 +0530
Message-ID: <1533211143-17517-3-git-send-email-vreddytalla@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
References: <1533211143-17517-1-git-send-email-vreddytalla@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support in PMC driver to configure the power state and voltage level
of the IO pads from client driver via pincontrol framework, because of this
tegra_io_pad_power_disable() and tegra_io_pad_power_enable() deprecated,
to change power state of SOR io pads using new pmc apis.

Signed-off-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
---
 drivers/gpu/drm/tegra/sor.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index d7fe9f1..6ede923 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (C) 2013-2018, NVIDIA Corporation.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -342,7 +342,6 @@ struct tegra_sor {
 	struct drm_info_list *debugfs_files;
 
 	const struct tegra_sor_ops *ops;
-	enum tegra_io_pad pad;
 
 	/* for HDMI 2.0 */
 	struct tegra_sor_hdmi_settings *settings;
@@ -1547,7 +1546,7 @@ static void tegra_sor_edp_disable(struct drm_encoder *encoder)
 			dev_err(sor->dev, "failed to disable DP: %d\n", err);
 	}
 
-	err = tegra_io_pad_power_disable(sor->pad);
+	err = tegra_io_rail_power_off(TEGRA_IO_RAIL_LVDS);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
 
@@ -1707,7 +1706,7 @@ static void tegra_sor_edp_enable(struct drm_encoder *encoder)
 	tegra_sor_writel(sor, value, sor->soc->regs->dp_padctl0);
 
 	/* step 2 */
-	err = tegra_io_pad_power_enable(sor->pad);
+	err = tegra_io_rail_power_on(TEGRA_IO_RAIL_LVDS);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power on I/O pad: %d\n", err);
 
@@ -2189,7 +2188,7 @@ static void tegra_sor_hdmi_disable(struct drm_encoder *encoder)
 	if (err < 0)
 		dev_err(sor->dev, "failed to power down SOR: %d\n", err);
 
-	err = tegra_io_pad_power_disable(sor->pad);
+	err = tegra_io_rail_power_off(TEGRA_IO_RAIL_HDMI);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
 
@@ -2225,7 +2224,7 @@ static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
 
 	div = clk_get_rate(sor->clk) / 1000000 * 4;
 
-	err = tegra_io_pad_power_enable(sor->pad);
+	err = tegra_io_rail_power_on(TEGRA_IO_RAIL_HDMI);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power on I/O pad: %d\n", err);
 
@@ -2921,7 +2920,6 @@ static int tegra_sor_parse_dt(struct tegra_sor *sor)
 		 * override the default that we already set for Tegra210 and
 		 * earlier
 		 */
-		sor->pad = TEGRA_IO_PAD_HDMI_DP0 + sor->index;
 	}
 
 	return 0;
@@ -2962,7 +2960,6 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	if (!sor->aux) {
 		if (sor->soc->supports_hdmi) {
 			sor->ops = &tegra_sor_hdmi_ops;
-			sor->pad = TEGRA_IO_PAD_HDMI;
 		} else if (sor->soc->supports_lvds) {
 			dev_err(&pdev->dev, "LVDS not supported yet\n");
 			return -ENODEV;
@@ -2973,7 +2970,6 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	} else {
 		if (sor->soc->supports_edp) {
 			sor->ops = &tegra_sor_edp_ops;
-			sor->pad = TEGRA_IO_PAD_LVDS;
 		} else if (sor->soc->supports_dp) {
 			dev_err(&pdev->dev, "DisplayPort not supported yet\n");
 			return -ENODEV;
-- 
2.1.4

