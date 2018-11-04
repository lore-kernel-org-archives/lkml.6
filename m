Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B0C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80FC2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80FC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeKEDoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:44:14 -0500
Received: from mailoutvs52.siol.net ([185.57.226.243]:47530 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387642AbeKEDoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:44:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0E1AF5212AF;
        Sun,  4 Nov 2018 19:28:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qEY29JUYDUWJ; Sun,  4 Nov 2018 19:28:18 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 8C85B52128D;
        Sun,  4 Nov 2018 19:28:18 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id E19DF5212CB;
        Sun,  4 Nov 2018 19:28:15 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 17/28] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
Date:   Sun,  4 Nov 2018 19:26:54 +0100
Message-Id: <20181104182705.18047-18-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
all. At this point it is not clear whether it is just not necessary or
it would cause some kind of issues.

Add a quirk for it.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 4 +++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.c
index ec122136ee9d..99b878e380e1 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -21,7 +21,8 @@ static void sun8i_dw_hdmi_encoder_mode_set(struct drm_e=
ncoder *encoder,
 {
 	struct sun8i_dw_hdmi *hdmi =3D encoder_to_sun8i_dw_hdmi(encoder);
=20
-	clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
+	if (hdmi->quirks->set_rate)
+		clk_set_rate(hdmi->clk_tmds, mode->crtc_clock * 1000);
 }
=20
 static const struct drm_encoder_helper_funcs
@@ -235,6 +236,7 @@ static int sun8i_dw_hdmi_remove(struct platform_devic=
e *pdev)
=20
 static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks =3D {
 	.mode_valid =3D sun8i_dw_hdmi_mode_valid_a83t,
+	.set_rate =3D true,
 };
=20
 static const struct of_device_id sun8i_dw_hdmi_dt_ids[] =3D {
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4=
i/sun8i_dw_hdmi.h
index a645b8bc9f58..49c9e80c46ea 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -173,6 +173,7 @@ struct sun8i_hdmi_phy {
 struct sun8i_dw_hdmi_quirks {
 	enum drm_mode_status (*mode_valid)(struct drm_connector *connector,
 					   const struct drm_display_mode *mode);
+	unsigned int set_rate : 1;
 };
=20
 struct sun8i_dw_hdmi {
--=20
2.19.1

