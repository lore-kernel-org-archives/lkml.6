Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9BC4167B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B737720854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bsYx7aMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B737720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeILXid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:33 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52548 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbeILXid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:33 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AF8265C1D59;
        Wed, 12 Sep 2018 20:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkB9nO5E6tt2+BFWrHZ4d1uleQnMxz4/xU6m4RYh2ig=;
        b=bsYx7aMXrr8R5Cz2GhuF7AvoUvtkj3Jh98oljfrPgXGLpUlbjMcwIMD5+VpPGkuy+4MYm9
        K+H0vawNFFElC3f4gpikXbXMV0r5tQPYDnz5xH0lTTiq5hju9qn0TDhjOGdRNsU1edhLWx
        M+q7CgEqR5Q4RDPDPaTstPm4NXHos4c=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, Laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 3/8] drm/bridge: simplify bridge timing info
Date:   Wed, 12 Sep 2018 11:32:17 -0700
Message-Id: <20180912183222.25414-4-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bridges are typically connected to a parallel display signal with
pixel clock, sync signals and data lines. Parallel display signals
are also used in lower-end embedded display panels. For parallel
display panels we currently do not specify setup/hold times. From
discussions on the mailing list it seems not convincing that this
is currently really required for bridges either.

Remove setup/hold timings again to better align timing information
of displays and briges.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c | 17 +++++------------
 include/drm/drm_bridge.h              | 14 --------------
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index d5aa0f931ef2..b2309ad228cf 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -229,14 +229,14 @@ static int dumb_vga_remove(struct platform_device *pdev)
 /*
  * We assume the ADV7123 DAC is the "default" for historical reasons
  * Information taken from the ADV7123 datasheet, revision D.
- * NOTE: the ADV7123EP seems to have other timings and need a new timings
- * set if used.
  */
 static const struct drm_bridge_timings default_dac_timings = {
-	/* Timing specifications, datasheet page 7 */
+	/*
+	 * From Timing diagram, datasheet page 7. The bridge samples
+	 * on pixel clocks positive edge, hence the display controller
+	 * should drive signals on the negative edge.
+	 */
 	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
-	.setup_time_ps = 500,
-	.hold_time_ps = 1500,
 };
 
 /*
@@ -246,10 +246,6 @@ static const struct drm_bridge_timings default_dac_timings = {
 static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 	/* From timing diagram, datasheet page 9 */
 	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
-	/* From datasheet, page 12 */
-	.setup_time_ps = 3000,
-	/* I guess this means latched input */
-	.hold_time_ps = 0,
 };
 
 /*
@@ -259,9 +255,6 @@ static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 static const struct drm_bridge_timings ti_ths8135_dac_timings = {
 	/* From timing diagram, datasheet page 14 */
 	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
-	/* From datasheet, page 16 */
-	.setup_time_ps = 2000,
-	.hold_time_ps = 500,
 };
 
 static const struct of_device_id dumb_vga_match[] = {
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 45e90f4b46c3..1a1d08350eaf 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -251,20 +251,6 @@ struct drm_bridge_timings {
 	 * &drm_display_info->bus_flags.
 	 */
 	u32 input_bus_flags;
-	/**
-	 * @setup_time_ps:
-	 *
-	 * Defines the time in picoseconds the input data lines must be
-	 * stable before the clock edge.
-	 */
-	u32 setup_time_ps;
-	/**
-	 * @hold_time_ps:
-	 *
-	 * Defines the time in picoseconds taken for the bridge to sample the
-	 * input signal after the clock edge.
-	 */
-	u32 hold_time_ps;
 };
 
 /**
-- 
2.18.0

