Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D81C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE6820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965767AbeFRJe1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:34:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936041AbeFRIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C227BAD;
        Mon, 18 Jun 2018 08:24:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 191/279] drm/vc4: Fix oops dereferencing DPIs connector since panel_bridge.
Date:   Mon, 18 Jun 2018 10:12:56 +0200
Message-Id: <20180618080616.824872761@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 164c2416dd40770aba5814f93da835e8a9f7196d ]

In the cleanup, I didn't notice that we needed to dereference the
connector for the bus_format.  Fix the regression by looking up the
first (and only) connector attached to us, and assume that its
bus_format is what we want.  Some day it would be good to have that
part of display_info attached to the bridge, instead.

v2: Fix stray whitespace change

Signed-off-by: Eric Anholt <eric@anholt.net>
Fixes: 7b1298e05310 ("drm/vc4: Switch DPI to using the panel-bridge helper.")
Link: https://patchwork.freedesktop.org/patch/msgid/20180309233256.1667-1-eric@anholt.net
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_dpi.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -96,7 +96,6 @@ struct vc4_dpi {
 	struct platform_device *pdev;
 
 	struct drm_encoder *encoder;
-	struct drm_connector *connector;
 
 	void __iomem *regs;
 
@@ -164,14 +163,31 @@ static void vc4_dpi_encoder_disable(stru
 
 static void vc4_dpi_encoder_enable(struct drm_encoder *encoder)
 {
+	struct drm_device *dev = encoder->dev;
 	struct drm_display_mode *mode = &encoder->crtc->mode;
 	struct vc4_dpi_encoder *vc4_encoder = to_vc4_dpi_encoder(encoder);
 	struct vc4_dpi *dpi = vc4_encoder->dpi;
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector = NULL, *connector_scan;
 	u32 dpi_c = DPI_ENABLE | DPI_OUTPUT_ENABLE_MODE;
 	int ret;
 
-	if (dpi->connector->display_info.num_bus_formats) {
-		u32 bus_format = dpi->connector->display_info.bus_formats[0];
+	/* Look up the connector attached to DPI so we can get the
+	 * bus_format.  Ideally the bridge would tell us the
+	 * bus_format we want, but it doesn't yet, so assume that it's
+	 * uniform throughout the bridge chain.
+	 */
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector_scan, &conn_iter) {
+		if (connector_scan->encoder == encoder) {
+			connector = connector_scan;
+			break;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	if (connector && connector->display_info.num_bus_formats) {
+		u32 bus_format = connector->display_info.bus_formats[0];
 
 		switch (bus_format) {
 		case MEDIA_BUS_FMT_RGB888_1X24:
@@ -199,6 +215,9 @@ static void vc4_dpi_encoder_enable(struc
 			DRM_ERROR("Unknown media bus format %d\n", bus_format);
 			break;
 		}
+	} else {
+		/* Default to 24bit if no connector found. */
+		dpi_c |= VC4_SET_FIELD(DPI_FORMAT_24BIT_888_RGB, DPI_FORMAT);
 	}
 
 	if (mode->flags & DRM_MODE_FLAG_NHSYNC)


