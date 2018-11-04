Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF1C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3043B2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3043B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbeKEDoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:20 -0500
Received: from mailoutvs7.siol.net ([185.57.226.198]:47598 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731652AbeKEDoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 351E8521293;
        Sun,  4 Nov 2018 19:28:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i5h9__RSLgrs; Sun,  4 Nov 2018 19:28:23 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CC86B521270;
        Sun,  4 Nov 2018 19:28:23 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 20D72521294;
        Sun,  4 Nov 2018 19:28:21 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 19/28] drm/sun4i: Add support for H6 DW HDMI controller
Date:   Sun,  4 Nov 2018 19:26:56 +0100
Message-Id: <20181104182705.18047-20-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H6 has DW HDMI 2.0b controller v2.12a.

It supports 4K at 60 Hz and HDCP 2.2.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index 99b878e380e1..445cca8d9a26 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,6 +44,17 @@ sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *co=
nnector,
 	return MODE_OK;
 }
=20
+static enum drm_mode_status
+sun8i_dw_hdmi_mode_valid_h6(struct drm_connector *connector,
+			    const struct drm_display_mode *mode)
+{
+	/* This is max for HDMI 2.0b (4K@60Hz) */
+	if (mode->clock > 594000)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
 	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
@@ -239,11 +250,19 @@ static const struct sun8i_dw_hdmi_quirks sun8i_a83t=
_quirks =3D {
 	.set_rate =3D true,
 };
=20
+static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks =3D {
+	.mode_valid =3D sun8i_dw_hdmi_mode_valid_h6,
+};
+
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] =3D {
 	{
 		.compatible =3D "allwinner,sun8i-a83t-dw-hdmi",
 		.data =3D &sun8i_a83t_quirks,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-h6-dw-hdmi",
+		.data =3D &sun50i_h6_quirks,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
--=20
2.19.1

