Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5341C2147E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5341C2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934484AbeGFRxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:53:42 -0400
Received: from mailoutvs13.siol.net ([185.57.226.204]:41562 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934196AbeGFRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:53:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id AC7BD52107C;
        Fri,  6 Jul 2018 19:53:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gXCYxe7hItp4; Fri,  6 Jul 2018 19:53:36 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 28FE252099D;
        Fri,  6 Jul 2018 19:53:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A14F352107C;
        Fri,  6 Jul 2018 19:53:33 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 12/17] drm/sun4i: tcon: Add support for R40 TCON
Date:   Fri,  6 Jul 2018 19:51:08 +0200
Message-Id: <20180706175113.26698-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706175113.26698-1-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 TV TCON is basically the same as on A83T. However, it needs special
handling, because it has to set up TCON TOP muxes at runtime.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 44ec3a3d4d64..5676b7faaca0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1291,6 +1291,40 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
 	return 0;
 }
 
+static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder)
+{
+	struct device_node *port, *remote;
+	struct platform_device *pdev;
+	int id, ret;
+
+	/* find TCON TOP platform device and TCON id */
+
+	port = of_graph_get_port_by_id(tcon->dev->of_node, 0);
+	if (!port)
+		return -EINVAL;
+
+	id = sun4i_tcon_of_get_id_from_port(port);
+	of_node_put(port);
+
+	remote = of_graph_get_remote_node(tcon->dev->of_node, 0, -1);
+	if (!remote)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(remote);
+	of_node_put(remote);
+	if (!pdev)
+		return -EINVAL;
+
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
+		ret = sun8i_tcon_top_set_hdmi_src(&pdev->dev, id);
+		if (ret)
+			return ret;
+	}
+
+	return sun8i_tcon_top_de_config(&pdev->dev, tcon->id, id);
+}
+
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
 	.has_channel_0		= true,
 	.has_channel_1		= true,
@@ -1338,6 +1372,11 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
+	.has_channel_1		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	.has_channel_0		= true,
 };
@@ -1362,6 +1401,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = &sun9i_a80_tcon_tv_quirks },
-- 
2.18.0

