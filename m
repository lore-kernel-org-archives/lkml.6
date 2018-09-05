Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE48C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142320857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Q/hMYvLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8142320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIEJt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 05:49:58 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56230 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeIEJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 05:49:57 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EF5F05C07CF;
        Wed,  5 Sep 2018 07:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536124889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=vjaoQ5opbOITH9IdH/Wkvz05L0MiLlzWybBQa43v3fE=;
        b=Q/hMYvLs2Ucdh/y10e/tjHcBmBH10qDj0rn3h1s8f4t4UPdKxeXA8ihZQeHwsInSoETbCi
        mIFHPb3C7grqjzXKK/ZLJbQ6r4/qrea1e6vcJ/BiU8phxudW1+jc3ULW761csu8P4S7mwa
        eUF+9E5hGvFJkbZ35fvBPgRQrMsTXGw=
From:   Stefan Agner <stefan@agner.ch>
To:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/6] drm/bridge: use bus flags in bridge timings
Date:   Tue,  4 Sep 2018 22:21:08 -0700
Message-Id: <20180905052113.21262-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM bus flags convey additional information on pixel data on
the bus. All current available bus flags might be of interest for
a bridge. Remove the sampling_edge field and use bus_flags.

In the case at hand a dumb VGA bridge needs a specific data enable
polarity (DRM_BUS_FLAG_DE_LOW).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
 include/drm/drm_bridge.h              | 11 +++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9b706789a341..7a5c24967115 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
  */
 static const struct drm_bridge_timings default_dac_timings = {
 	/* Timing specifications, datasheet page 7 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	.setup_time_ps = 500,
 	.hold_time_ps = 1500,
 };
@@ -245,7 +245,7 @@ static const struct drm_bridge_timings default_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 	/* From timing diagram, datasheet page 9 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	/* From datasheet, page 12 */
 	.setup_time_ps = 3000,
 	/* I guess this means latched input */
@@ -258,7 +258,7 @@ static const struct drm_bridge_timings ti_ths8134_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8135_dac_timings = {
 	/* From timing diagram, datasheet page 14 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_POSEDGE,
 	/* From datasheet, page 16 */
 	.setup_time_ps = 2000,
 	.hold_time_ps = 500,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..85d4b51eae19 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -244,14 +244,13 @@ struct drm_bridge_funcs {
  */
 struct drm_bridge_timings {
 	/**
-	 * @sampling_edge:
+	 * @bus_flags:
 	 *
-	 * Tells whether the bridge samples the digital input signal
-	 * from the display engine on the positive or negative edge of the
-	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
-	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
+	 * Tells what additional settings for the pixel data on the bus
+	 * this bridge requires (like pixel signal polarity). See also
+	 * &drm_display_info->bus_flags.
 	 */
-	u32 sampling_edge;
+	u32 bus_flags;
 	/**
 	 * @setup_time_ps:
 	 *
-- 
2.18.0

