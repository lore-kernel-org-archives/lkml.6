Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DF1217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129296;
	bh=NP9dcI+kECawYLNBo+wfyqwnqv3OGZu0pRMO1x5THV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A0qYhymIsfulex4tRnRKOmRtlgiIYQNn7Aty29KSXmR17dj7dDQpAjDCiWJXofRju
	 CIHluExNKp53b6PRiOght+B4WXEAppOSmAO4z2fFAAOh1gvHkp5QNJhJa+Q32W+AO1
	 FwsFvhJrB1npksWQXdjSri/rPiYplfhdEd41mo3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfBYVOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbfBYVOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:14:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31E02173C;
        Mon, 25 Feb 2019 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129293;
        bh=NP9dcI+kECawYLNBo+wfyqwnqv3OGZu0pRMO1x5THV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmlA9swZPmRoRtI9mHL4m+hCQDgy5a7SKMDNF1RwdChyFEeuh3BcAlFPvSxpWa1QU
         wLw8VDqn2MbW3KxgDA8E3uXrNpnV2VePF0aaqbr3mHBLwZw60GEZSXyU1yhtLoQTWQ
         8CYxz4GcVs+m+kVG9ciqIv8idgwSuTn34vdFsrpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 47/63] drm/i915: Consistently use enum pipe for PCH transcoders
Date:   Mon, 25 Feb 2019 22:11:47 +0100
Message-Id: <20190225195039.426088913@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195035.713274200@linuxfoundation.org>
References: <20190225195035.713274200@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit a21960339c8c107eae99d68c85e6355189b22192 upstream.

The current code uses in some instances enum transcoder for PCH
transcoders and enum pipe in others. This is error prone and clang
raises warnings like this:

drivers/gpu/drm/i915/intel_dp.c:3546:51: warning: implicit conversion
  from enumeration type 'enum pipe' to different enumeration type
  'enum transcoder' [-Wenum-conversion]
    intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A, false);

Consistently use the type enum pipe for PCH transcoders.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20170717181403.57324-1-mka@chromium.org
[nc: Backport to 4.9; adjust context and drop unneeded hunks]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_irq.c            |   10 +++++-----
 drivers/gpu/drm/i915/intel_display.c       |   14 +++++++-------
 drivers/gpu/drm/i915/intel_drv.h           |    4 ++--
 drivers/gpu/drm/i915/intel_fifo_underrun.c |    4 ++--
 4 files changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -1985,10 +1985,10 @@ static void ibx_irq_handler(struct drm_i
 		DRM_DEBUG_DRIVER("PCH transcoder CRC error interrupt\n");
 
 	if (pch_iir & SDE_TRANSA_FIFO_UNDER)
-		intel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_A);
+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_A);
 
 	if (pch_iir & SDE_TRANSB_FIFO_UNDER)
-		intel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_B);
+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_B);
 }
 
 static void ivb_err_int_handler(struct drm_i915_private *dev_priv)
@@ -2022,13 +2022,13 @@ static void cpt_serr_int_handler(struct
 		DRM_ERROR("PCH poison interrupt\n");
 
 	if (serr_int & SERR_INT_TRANS_A_FIFO_UNDERRUN)
-		intel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_A);
+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_A);
 
 	if (serr_int & SERR_INT_TRANS_B_FIFO_UNDERRUN)
-		intel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_B);
+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_B);
 
 	if (serr_int & SERR_INT_TRANS_C_FIFO_UNDERRUN)
-		intel_pch_fifo_underrun_irq_handler(dev_priv, TRANSCODER_C);
+		intel_pch_fifo_underrun_irq_handler(dev_priv, PIPE_C);
 
 	I915_WRITE(SERR_INT, serr_int);
 }
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -1849,7 +1849,7 @@ static void lpt_enable_pch_transcoder(st
 
 	/* FDI must be feeding us bits for PCH ports */
 	assert_fdi_tx_enabled(dev_priv, (enum pipe) cpu_transcoder);
-	assert_fdi_rx_enabled(dev_priv, TRANSCODER_A);
+	assert_fdi_rx_enabled(dev_priv, PIPE_A);
 
 	/* Workaround: set timing override bit. */
 	val = I915_READ(TRANS_CHICKEN2(PIPE_A));
@@ -1950,7 +1950,7 @@ static void intel_enable_pipe(struct int
 	assert_sprites_disabled(dev_priv, pipe);
 
 	if (HAS_PCH_LPT(dev_priv))
-		pch_transcoder = TRANSCODER_A;
+		pch_transcoder = PIPE_A;
 	else
 		pch_transcoder = pipe;
 
@@ -4636,7 +4636,7 @@ static void lpt_pch_enable(struct drm_cr
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
 	enum transcoder cpu_transcoder = intel_crtc->config->cpu_transcoder;
 
-	assert_pch_transcoder_disabled(dev_priv, TRANSCODER_A);
+	assert_pch_transcoder_disabled(dev_priv, PIPE_A);
 
 	lpt_program_iclkip(crtc);
 
@@ -5410,7 +5410,7 @@ static void haswell_crtc_enable(struct i
 		return;
 
 	if (intel_crtc->config->has_pch_encoder)
-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,
+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,
 						      false);
 
 	intel_encoders_pre_pll_enable(crtc, pipe_config, old_state);
@@ -5498,7 +5498,7 @@ static void haswell_crtc_enable(struct i
 		intel_wait_for_vblank(dev, pipe);
 		intel_wait_for_vblank(dev, pipe);
 		intel_set_cpu_fifo_underrun_reporting(dev_priv, pipe, true);
-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,
+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,
 						      true);
 	}
 
@@ -5597,7 +5597,7 @@ static void haswell_crtc_disable(struct
 	enum transcoder cpu_transcoder = intel_crtc->config->cpu_transcoder;
 
 	if (intel_crtc->config->has_pch_encoder)
-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,
+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,
 						      false);
 
 	intel_encoders_disable(crtc, old_crtc_state, old_state);
@@ -5626,7 +5626,7 @@ static void haswell_crtc_disable(struct
 	intel_encoders_post_disable(crtc, old_crtc_state, old_state);
 
 	if (old_crtc_state->has_pch_encoder)
-		intel_set_pch_fifo_underrun_reporting(dev_priv, TRANSCODER_A,
+		intel_set_pch_fifo_underrun_reporting(dev_priv, PIPE_A,
 						      true);
 }
 
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1095,12 +1095,12 @@ static inline unsigned int intel_num_pla
 bool intel_set_cpu_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
 					   enum pipe pipe, bool enable);
 bool intel_set_pch_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
-					   enum transcoder pch_transcoder,
+					   enum pipe pch_transcoder,
 					   bool enable);
 void intel_cpu_fifo_underrun_irq_handler(struct drm_i915_private *dev_priv,
 					 enum pipe pipe);
 void intel_pch_fifo_underrun_irq_handler(struct drm_i915_private *dev_priv,
-					 enum transcoder pch_transcoder);
+					 enum pipe pch_transcoder);
 void intel_check_cpu_fifo_underruns(struct drm_i915_private *dev_priv);
 void intel_check_pch_fifo_underruns(struct drm_i915_private *dev_priv);
 
--- a/drivers/gpu/drm/i915/intel_fifo_underrun.c
+++ b/drivers/gpu/drm/i915/intel_fifo_underrun.c
@@ -311,7 +311,7 @@ bool intel_set_cpu_fifo_underrun_reporti
  * Returns the previous state of underrun reporting.
  */
 bool intel_set_pch_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
-					   enum transcoder pch_transcoder,
+					   enum pipe pch_transcoder,
 					   bool enable)
 {
 	struct drm_crtc *crtc = dev_priv->pipe_to_crtc_mapping[pch_transcoder];
@@ -384,7 +384,7 @@ void intel_cpu_fifo_underrun_irq_handler
  * interrupt to avoid an irq storm.
  */
 void intel_pch_fifo_underrun_irq_handler(struct drm_i915_private *dev_priv,
-					 enum transcoder pch_transcoder)
+					 enum pipe pch_transcoder)
 {
 	if (intel_set_pch_fifo_underrun_reporting(dev_priv, pch_transcoder,
 						  false))


