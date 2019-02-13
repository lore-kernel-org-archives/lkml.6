Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36C3C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B1420835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083608;
	bh=asTD+xd63cC1YSFBXgmKuTPQn4ndp+Z50QHt0HEn0Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q28okUu3qL2DuRbnt+QqEJiOOGrzRZr3Ls7i8BWl+2Uj9Htm3AsddXZWBPB64eT4h
	 d8wmxMjAy9EBJDEn8FNCeqTlBUqN+c24nLrphC/xzlctCDkz8eM2B7XZ5z8pnPAi1m
	 6EZscCYurCkkkVgPE/7JRlLG4o6iiKXvCHjh7Ngg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406511AbfBMSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406473AbfBMSql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:46:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB87520835;
        Wed, 13 Feb 2019 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083600;
        bh=asTD+xd63cC1YSFBXgmKuTPQn4ndp+Z50QHt0HEn0Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFKP+QwXsaFlX1DxVZIbeAOp/T7p70bSe8OCvz9h+bV8SLA31M+133XNpmZhoo3/5
         xvtfpugQ5hw1C0QPCxcAgFcZPwJDf+AJ2sjPXV5Z6CNf0SUCzN1vdszmjBVFvWP8Ss
         QlgWFc6MfvJhcCLNT3+x9QH7KqpSzaIMFS84nnSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Kamil Kozar <dkk089@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Mika Kahola <mika.kahola@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.20 45/50] drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen
Date:   Wed, 13 Feb 2019 19:38:50 +0100
Message-Id: <20190213183659.236060986@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit d028a646e84b9b131e4ff2cb5bbdd3825d141028 upstream.

Certain SNB machines (eg. ASUS K53SV) seem to have a broken BIOS
which misprograms the hardware badly when encountering a suitably
high resolution display. The programmed pipe timings are somewhat
bonkers and the DPLL is totally misprogrammed (P divider == 0).
That will result in atomic commit timeouts as apparently the pipe
is sufficiently stuck to not signal vblank interrupts.

IIRC something like this was also observed on some other SNB
machine years ago (might have been a Dell XPS 8300) but a BIOS
update cured it. Sadly looks like this was never fixed for the
ASUS K53SV as the latest BIOS (K53SV.320 11/11/2011) is still
broken.

The quickest way to deal with this seems to be to shut down
the pipe+ports+DPLL. Unfortunately doing this during the
normal sanitization phase isn't quite soon enough as we
already spew several WARNs about the bogus hardware state.
But it's better than hanging the boot for a few dozen seconds.
Since this is limited to a few old machines it doesn't seem
entirely worthwile to try and rework the readout+sanitization
code to handle it more gracefully.

v2: Fix potential NULL deref (kbuild test robot)
    Constify has_bogus_dpll_config()

Cc: stable@vger.kernel.org # v4.20+
Cc: Daniel Kamil Kozar <dkk089@gmail.com>
Reported-by: Daniel Kamil Kozar <dkk089@gmail.com>
Tested-by: Daniel Kamil Kozar <dkk089@gmail.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109245
Fixes: 516a49cc1946 ("drm/i915: Fix assert_plane() warning on bootup with external display")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190111174950.10681-1-ville.syrjala@linux.intel.com
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
(cherry picked from commit 7bed8adcd9f86231bb69bbc02f88ad89330f99e3)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190205141846.6053-1-ville.syrjala@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_display.c |   51 ++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -15684,15 +15684,44 @@ static void intel_sanitize_crtc(struct i
 	}
 }
 
+static bool has_bogus_dpll_config(const struct intel_crtc_state *crtc_state)
+{
+	struct drm_i915_private *dev_priv = to_i915(crtc_state->base.crtc->dev);
+
+	/*
+	 * Some SNB BIOSen (eg. ASUS K53SV) are known to misprogram
+	 * the hardware when a high res displays plugged in. DPLL P
+	 * divider is zero, and the pipe timings are bonkers. We'll
+	 * try to disable everything in that case.
+	 *
+	 * FIXME would be nice to be able to sanitize this state
+	 * without several WARNs, but for now let's take the easy
+	 * road.
+	 */
+	return IS_GEN6(dev_priv) &&
+		crtc_state->base.active &&
+		crtc_state->shared_dpll &&
+		crtc_state->port_clock == 0;
+}
+
 static void intel_sanitize_encoder(struct intel_encoder *encoder)
 {
 	struct intel_connector *connector;
+	struct intel_crtc *crtc = to_intel_crtc(encoder->base.crtc);
+	struct intel_crtc_state *crtc_state = crtc ?
+		to_intel_crtc_state(crtc->base.state) : NULL;
 
 	/* We need to check both for a crtc link (meaning that the
 	 * encoder is active and trying to read from a pipe) and the
 	 * pipe itself being active. */
-	bool has_active_crtc = encoder->base.crtc &&
-		to_intel_crtc(encoder->base.crtc)->active;
+	bool has_active_crtc = crtc_state &&
+		crtc_state->base.active;
+
+	if (crtc_state && has_bogus_dpll_config(crtc_state)) {
+		DRM_DEBUG_KMS("BIOS has misprogrammed the hardware. Disabling pipe %c\n",
+			      pipe_name(crtc->pipe));
+		has_active_crtc = false;
+	}
 
 	connector = intel_encoder_find_connector(encoder);
 	if (connector && !has_active_crtc) {
@@ -15703,15 +15732,25 @@ static void intel_sanitize_encoder(struc
 		/* Connector is active, but has no active pipe. This is
 		 * fallout from our resume register restoring. Disable
 		 * the encoder manually again. */
-		if (encoder->base.crtc) {
-			struct drm_crtc_state *crtc_state = encoder->base.crtc->state;
+		if (crtc_state) {
+			struct drm_encoder *best_encoder;
 
 			DRM_DEBUG_KMS("[ENCODER:%d:%s] manually disabled\n",
 				      encoder->base.base.id,
 				      encoder->base.name);
-			encoder->disable(encoder, to_intel_crtc_state(crtc_state), connector->base.state);
+
+			/* avoid oopsing in case the hooks consult best_encoder */
+			best_encoder = connector->base.state->best_encoder;
+			connector->base.state->best_encoder = &encoder->base;
+
+			if (encoder->disable)
+				encoder->disable(encoder, crtc_state,
+						 connector->base.state);
 			if (encoder->post_disable)
-				encoder->post_disable(encoder, to_intel_crtc_state(crtc_state), connector->base.state);
+				encoder->post_disable(encoder, crtc_state,
+						      connector->base.state);
+
+			connector->base.state->best_encoder = best_encoder;
 		}
 		encoder->base.crtc = NULL;
 


