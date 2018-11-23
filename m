Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78753C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4935C20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4935C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409069AbeKWUKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:10:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49514 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409042AbeKWUKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:10:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 554D621668; Fri, 23 Nov 2018 10:27:08 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78451207BB;
        Fri, 23 Nov 2018 10:26:38 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 42/43] drm/sun4i: frontend: Move the FIR filter phases to our quirks
Date:   Fri, 23 Nov 2018 10:25:14 +0100
Message-Id: <20181123092515.2511-43-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The FIR filters phase depend on the SoC, so let's move it to our quirks
structure instead of removing them.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 28 ++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_frontend.h |  5 +++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index f50507ee6d75..427c51029a9c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -438,12 +438,18 @@ int sun4i_frontend_update_formats(struct sun4i_frontend *frontend,
 	 * I have no idea what this does exactly, but it seems to be
 	 * related to the scaler FIR filter phase parameters.
 	 */
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG, 0x400);
-	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG, 0x400);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_HORZPHASE_REG,
+		     frontend->data->ch_phase[0].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_HORZPHASE_REG,
+		     frontend->data->ch_phase[1].horzphase);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE0_REG,
+		     frontend->data->ch_phase[0].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE0_REG,
+		     frontend->data->ch_phase[1].vertphase[0]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH0_VERTPHASE1_REG,
+		     frontend->data->ch_phase[0].vertphase[1]);
+	regmap_write(frontend->regs, SUN4I_FRONTEND_CH1_VERTPHASE1_REG,
+		     frontend->data->ch_phase[1].vertphase[1]);
 
 	if (fb->format->is_yuv && !drm_format_is_yuv(out_fmt)) {
 		/* Setup the CSC engine for YUV to RGB conversion. */
@@ -671,6 +677,16 @@ static const struct dev_pm_ops sun4i_frontend_pm_ops = {
 };
 
 static const struct sun4i_frontend_data sun8i_a33_frontend = {
+	.ch_phase		= {
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+		{
+			.horzphase = 0x400,
+			.vertphase = { 0x400, 0x400 },
+		},
+	},
 	.has_coef_access_ctrl	= true,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 3618993f8e49..45f5f4f3d06f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -103,6 +103,11 @@ struct reset_control;
 struct sun4i_frontend_data {
 	bool	has_coef_access_ctrl;
 	bool	has_coef_rdy;
+
+	struct {
+		u32	horzphase;
+		u32	vertphase[2];
+	} ch_phase[2];
 };
 
 struct sun4i_frontend {
-- 
2.19.1

