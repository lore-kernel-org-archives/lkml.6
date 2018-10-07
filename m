Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0FC65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9884120895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 09:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9884120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeJGQqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 12:46:53 -0400
Received: from mailoutvs5.siol.net ([185.57.226.196]:40033 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728371AbeJGQqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 12:46:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1E0ED520432;
        Sun,  7 Oct 2018 11:40:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Kfr6m8OTSmuI; Sun,  7 Oct 2018 11:40:07 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9FDE45202E0;
        Sun,  7 Oct 2018 11:40:07 +0200 (CEST)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3EE7A520CCE;
        Sun,  7 Oct 2018 11:40:05 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 20/29] drm/sun4i: Add support for H6 DW HDMI controller
Date:   Sun,  7 Oct 2018 11:38:56 +0200
Message-Id: <20181007093905.11253-21-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007093905.11253-1-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
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
index e9e93f174b35..0306a51e1b35 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -43,6 +43,17 @@ sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *co=
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
@@ -240,11 +251,19 @@ static const struct sun8i_dw_hdmi_quirks sun8i_a83t=
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
2.19.0

