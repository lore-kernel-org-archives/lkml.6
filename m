Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0734EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B932172A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pXU2AhDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B932172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeHTTRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:17:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45590 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeHTTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:17:04 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1E321AD2;
        Mon, 20 Aug 2018 18:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534780850;
        bh=YoXwh0d+6w93ENsBT8OAZsJAuZkO18DGR0KRkOWSM+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXU2AhDLD1z8mKZFpSdJEKdh5OZ3F0b+GYmwf101R8BIJCl+h4N3qM1yPoUKDEttw
         glPXLKqd7FW3SNLnwdQH3Qf6HevMshoO9nbM3Apfyb1NJFZtqCNHE0BYWv/YFfLsef
         hQf+oGejph/8tXNQSIEQJrWzAFc8/7IHJx3g+2KY=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH 2/2] drm: rcar-du: Add interlaced feature flag
Date:   Mon, 20 Aug 2018 17:00:44 +0100
Message-Id: <20180820160044.15783-3-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820160044.15783-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180820160044.15783-1-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upcoming implementations of the R-Car DU have removed support for
interlaced display pipelines. Provide a means to determine this based on
the feature flags of the hardware configuration structs.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---

This could be a feature to designate that there is no interlaced
support, which would then negate the need to add extra feature flags to
the existing targets... But that's a 'non-feature' rather than a
'feature', so this way at least reads better.

Tested on Salvator-XS (H3) by removing the flag and verifying interlaced
modes are rejected.

 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 14 +++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 32 +++++++++++++++++---------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 15dc9caa128b..4b43d8329695 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -684,11 +684,25 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
 		rcar_du_vsp_atomic_flush(rcrtc);
 }
 
+enum drm_mode_status rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
+				   const struct drm_display_mode *mode)
+{
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+
+	if (interlaced && !rcar_du_has(rcdu, RCAR_DU_FEATURE_INTERLACED))
+		return MODE_NO_INTERLACE;
+
+	return MODE_OK;
+}
+
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.atomic_begin = rcar_du_crtc_atomic_begin,
 	.atomic_flush = rcar_du_crtc_atomic_flush,
 	.atomic_enable = rcar_du_crtc_atomic_enable,
 	.atomic_disable = rcar_du_crtc_atomic_disable,
+	.mode_valid = rcar_du_crtc_mode_valid,
 };
 
 static struct drm_crtc_state *
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 02aee6cb0e53..49f2ae80d0f5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -39,7 +39,8 @@
 static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -60,7 +61,8 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -79,7 +81,7 @@ static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
 
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.gen = 2,
-	.features = 0,
+	.features = RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -100,7 +102,8 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
@@ -128,7 +131,8 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -150,7 +154,8 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/* R8A7792 has two RGB outputs. */
@@ -168,7 +173,8 @@ static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -190,7 +196,8 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -222,7 +229,8 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -250,7 +258,8 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(3) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -278,7 +287,8 @@ static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(0),
 	.routes = {
 		/* R8A77970 has one RGB output and one LVDS output. */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 78ea20abfb30..c4a66130a603 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -30,6 +30,7 @@ struct rcar_du_device;
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ and clock */
 #define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
 #define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has inputs from VSP1 */
+#define RCAR_DU_FEATURE_INTERLACED	BIT(3)	/* HW supports interlaced */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
 
-- 
2.17.1

