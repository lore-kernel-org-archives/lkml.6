Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126FC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA7420854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="M8/MAaJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA7420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeILXiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:38:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52478 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeILXiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:38:23 -0400
Received: from trochilidae.toradex.int (75-146-58-181-Washington.hfc.comcastbusiness.net [75.146.58.181])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D4A9B5C1C76;
        Wed, 12 Sep 2018 20:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536777155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V6+oPM943uxS6RfuErtjmlhuyTqbit9vm48qMTVtsso=;
        b=M8/MAaJ0ZnAQCiFgsvQW0U4bGqJ5jqX0HxEn9VT2jtQpzwQs3rVr3HJzDELavgxPvxj75d
        FabdFodfvAg/7Cz5R4W9DtZgwWtuRSGZvg48CthG257jmLXkT4AtpTZwk9A3elRJp3uzrs
        7KqQEV5aDAPb91zja0u2BafYPKtd8LY=
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
Subject: [PATCH v2 1/8] drm/bridge: use bus flags in bridge timings
Date:   Wed, 12 Sep 2018 11:32:15 -0700
Message-Id: <20180912183222.25414-2-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM bus flags conveys additional information on pixel data on
the bus. All currently available bus flags might be of interest for
a bridge. In the case at hand a dumb VGA bridge needs a specific
data enable polarity (DRM_BUS_FLAG_DE_LOW).

Replace the sampling_edge field with input_bus_flags and allow all
currently documented bus flags.

This changes the perspective from sampling side to the driving
side for the currently supported flags. We assume that the sampling
edge is always the opposite of the driving edge (hence we need to
invert the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE flags). This is an
assumption we already make for displays. For all we know it is a
safe assumption for bridges too.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/bridge/dumb-vga-dac.c |  6 +++---
 include/drm/drm_bridge.h              | 11 +++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index 9b706789a341..d5aa0f931ef2 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -234,7 +234,7 @@ static int dumb_vga_remove(struct platform_device *pdev)
  */
 static const struct drm_bridge_timings default_dac_timings = {
 	/* Timing specifications, datasheet page 7 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	.setup_time_ps = 500,
 	.hold_time_ps = 1500,
 };
@@ -245,7 +245,7 @@ static const struct drm_bridge_timings default_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8134_dac_timings = {
 	/* From timing diagram, datasheet page 9 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	/* From datasheet, page 12 */
 	.setup_time_ps = 3000,
 	/* I guess this means latched input */
@@ -258,7 +258,7 @@ static const struct drm_bridge_timings ti_ths8134_dac_timings = {
  */
 static const struct drm_bridge_timings ti_ths8135_dac_timings = {
 	/* From timing diagram, datasheet page 14 */
-	.sampling_edge = DRM_BUS_FLAG_PIXDATA_POSEDGE,
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_NEGEDGE,
 	/* From datasheet, page 16 */
 	.setup_time_ps = 2000,
 	.hold_time_ps = 500,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index bd850747ce54..45e90f4b46c3 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -244,14 +244,13 @@ struct drm_bridge_funcs {
  */
 struct drm_bridge_timings {
 	/**
-	 * @sampling_edge:
+	 * @input_bus_flags:
 	 *
-	 * Tells whether the bridge samples the digital input signal
-	 * from the display engine on the positive or negative edge of the
-	 * clock, this should reuse the DRM_BUS_FLAG_PIXDATA_[POS|NEG]EDGE
-	 * bitwise flags from the DRM connector (bit 2 and 3 valid).
+	 * Additional settings this bridge requires for the pixel data on
+	 * the input bus (e.g. pixel signal polarity). See also
+	 * &drm_display_info->bus_flags.
 	 */
-	u32 sampling_edge;
+	u32 input_bus_flags;
 	/**
 	 * @setup_time_ps:
 	 *
-- 
2.18.0

