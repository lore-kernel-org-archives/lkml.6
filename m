Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BEDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33706208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT4Rqhx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33706208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbeKTDPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbeKTDPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C89206BA;
        Mon, 19 Nov 2018 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646300;
        bh=ZXrCUiToWH/1O+0vZlUopyzCpnX8hWl8QMtJ81SlZEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MT4Rqhx5gyTjP8m9IiFr686VMzZA58b5+NQRivOgEXEab5k265y1joiYZ/7PA62Py
         wB9NTJogjqkxCIk4QTxkK3n28uVDpW76202w02uc0xClME1d1C/BTM9ZVJCe82EDQM
         hqaXh8rjZVletFcwNjP6DE0IdqepeEg/RK/EzSyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dennis <dennis.nezic@utoronto.ca>,
        Peter Nowee <peter.nowee@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 112/124] drm/i915: Restore vblank interrupts earlier
Date:   Mon, 19 Nov 2018 17:29:26 +0100
Message-Id: <20181119162632.797685176@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 7cada4d0b7a0fb813dbc9777fec092e9ed0546e9 upstream.

Plane sanitation needs vblank interrupts (on account of CxSR disable).
So let's restore vblank interrupts earlier.

v2: Make it actually build
v3: Add comment to explain why we need this (Daniel)

Cc: stable@vger.kernel.org
Cc: Dennis <dennis.nezic@utoronto.ca>
Tested-by: Dennis <dennis.nezic@utoronto.ca>
Tested-by: Peter Nowee <peter.nowee@gmail.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105637
Fixes: b1e01595a66d ("drm/i915: Redo plane sanitation during readout")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181003144951.4397-1-ville.syrjala@linux.intel.com
(cherry picked from commit 68bc30deac625b8be8d3950b30dc93d09a3645f5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -14829,13 +14829,9 @@ static void intel_sanitize_crtc(struct i
 			   I915_READ(reg) & ~PIPECONF_FRAME_START_DELAY_MASK);
 	}
 
-	/* restore vblank interrupts to correct state */
-	drm_crtc_vblank_reset(&crtc->base);
 	if (crtc->active) {
 		struct intel_plane *plane;
 
-		drm_crtc_vblank_on(&crtc->base);
-
 		/* Disable everything but the primary plane */
 		for_each_intel_plane_on_crtc(dev, crtc, plane) {
 			const struct intel_plane_state *plane_state =
@@ -15148,7 +15144,6 @@ intel_modeset_setup_hw_state(struct drm_
 			     struct drm_modeset_acquire_ctx *ctx)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
-	enum pipe pipe;
 	struct intel_crtc *crtc;
 	struct intel_encoder *encoder;
 	int i;
@@ -15167,15 +15162,23 @@ intel_modeset_setup_hw_state(struct drm_
 	/* HW state is read out, now we need to sanitize this mess. */
 	get_encoder_power_domains(dev_priv);
 
-	intel_sanitize_plane_mapping(dev_priv);
+	/*
+	 * intel_sanitize_plane_mapping() may need to do vblank
+	 * waits, so we need vblank interrupts restored beforehand.
+	 */
+	for_each_intel_crtc(&dev_priv->drm, crtc) {
+		drm_crtc_vblank_reset(&crtc->base);
 
-	for_each_intel_encoder(dev, encoder) {
-		intel_sanitize_encoder(encoder);
+		if (crtc->active)
+			drm_crtc_vblank_on(&crtc->base);
 	}
 
-	for_each_pipe(dev_priv, pipe) {
-		crtc = intel_get_crtc_for_pipe(dev_priv, pipe);
+	intel_sanitize_plane_mapping(dev_priv);
+
+	for_each_intel_encoder(dev, encoder)
+		intel_sanitize_encoder(encoder);
 
+	for_each_intel_crtc(&dev_priv->drm, crtc) {
 		intel_sanitize_crtc(crtc, ctx);
 		intel_dump_pipe_config(crtc, crtc->config,
 				       "[setup_hw_state]");


