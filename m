Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E41C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADDC258A6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADDC258A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbeFYMGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:06:31 -0400
Received: from mailoutvs32.siol.net ([185.57.226.223]:48290 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755331AbeFYMFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AE7145208BF;
        Mon, 25 Jun 2018 14:05:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cXC0a0f5tG9S; Mon, 25 Jun 2018 14:05:45 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 271E35206EB;
        Mon, 25 Jun 2018 14:05:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6A6255208BF;
        Mon, 25 Jun 2018 14:05:42 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 22/24] drm/sun4i: DW HDMI: Expand algorithm for possible crtcs
Date:   Mon, 25 Jun 2018 14:03:02 +0200
Message-Id: <20180625120304.7543-23-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625120304.7543-1-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_of_find_possible_crtcs() doesn't work when DW HDMI encoder is
connected to TCON (crtc) through mux in TCON TOP.

In that case TCON TOP HDMI mux input port has to be manually traversed
and checked if it matches any known crtc.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 9f40a44b456b..d443886e055b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -12,6 +12,7 @@
 #include <drm/drm_crtc_helper.h>
 
 #include "sun8i_dw_hdmi.h"
+#include "sun8i_tcon_top.h"
 
 static void sun8i_dw_hdmi_encoder_mode_set(struct drm_encoder *encoder,
 					   struct drm_display_mode *mode,
@@ -41,6 +42,48 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
+static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
+{
+	return !!of_match_node(sun8i_tcon_top_of_table, node);
+}
+
+static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
+					     struct device_node *node)
+{
+	struct device_node *port, *ep, *remote, *remote_port;
+	u32 crtcs = 0;
+
+	port = of_graph_get_port_by_id(node, 0);
+	if (!port)
+		return 0;
+
+	ep = of_get_next_available_child(port, NULL);
+	if (!ep)
+		return 0;
+
+	remote = of_graph_get_remote_port_parent(ep);
+	if (!remote)
+		return 0;
+
+	if (sun8i_dw_hdmi_node_is_tcon_top(remote)) {
+		port = of_graph_get_port_by_id(remote, 4);
+		if (!port)
+			return 0;
+
+		for_each_child_of_node(port, ep) {
+			remote_port = of_graph_get_remote_port(ep);
+			if (remote_port) {
+				crtcs |= drm_crtc_port_mask(drm, remote_port);
+				of_node_put(remote_port);
+			}
+		}
+	} else {
+		crtcs = drm_of_find_possible_crtcs(drm, node);
+	}
+
+	return crtcs;
+}
+
 static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 			      void *data)
 {
@@ -63,7 +106,8 @@ static int sun8i_dw_hdmi_bind(struct device *dev, struct device *master,
 	hdmi->dev = &pdev->dev;
 	encoder = &hdmi->encoder;
 
-	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, dev->of_node);
+	encoder->possible_crtcs =
+		sun8i_dw_hdmi_find_possible_crtcs(drm, dev->of_node);
 	/*
 	 * If we failed to find the CRTC(s) which this encoder is
 	 * supposed to be connected to, it's because the CRTC has
-- 
2.18.0

