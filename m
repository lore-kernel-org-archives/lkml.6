Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27D8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0D520862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0D520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408051AbeHATZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:25:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436520AbeHATSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1005DDF;
        Wed,  1 Aug 2018 16:53:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Imre Deak <imre.deak@intel.com>,
        Clint Taylor <clinton.a.taylor@intel.com>,
        Daniel Scheller <d.scheller.oss@gmail.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.17 014/336] drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.
Date:   Wed,  1 Aug 2018 18:45:49 +0200
Message-Id: <20180801165029.496921690@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clint Taylor <clinton.a.taylor@intel.com>

commit 0ca9488193e61ec5f31a631d8147f74525629e8a upstream.

On GLK NUC platforms the HDMI retiming buffer needs additional disabled
time to correctly sync to a faster incoming signal.

When measured on a scope the highspeed lines of the HDMI clock turn off
 for ~400uS during a normal resolution change. The HDMI retimer on the
 GLK NUC appears to require at least a full frame of quiet time before a
new faster clock can be correctly sync'd. Wait 100ms due to msleep
inaccuracies while waiting for a completed frame. Add a quirk to the
driver for GLK boards that use ITE66317 HDMI retimers.

V2: Add more devices to the quirk list
V3: Delay increased to 100ms, check to confirm crtc type is HDMI.
V4: crtc type check extended to include _DDI and whitespace fixes
v5: Fix white spaces, remove the macro for delay. Revert the crtc type
    check introduced in v4.

Cc: Imre Deak <imre.deak@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105887
Signed-off-by: Clint Taylor <clinton.a.taylor@intel.com>
Tested-by: Daniel Scheller <d.scheller.oss@gmail.com>
Signed-off-by: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Reviewed-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180710200205.1478-1-radhakrishna.sripada@intel.com
(cherry picked from commit 90c3e2198777aaa355b6994a31a79c636c8d4306)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_drv.h      |    1 +
 drivers/gpu/drm/i915/intel_ddi.c     |   13 +++++++++++--
 drivers/gpu/drm/i915/intel_display.c |   21 ++++++++++++++++++++-
 drivers/gpu/drm/i915/intel_drv.h     |    3 +--
 4 files changed, 33 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -804,6 +804,7 @@ enum intel_sbi_destination {
 #define QUIRK_BACKLIGHT_PRESENT (1<<3)
 #define QUIRK_PIN_SWIZZLED_PAGES (1<<5)
 #define QUIRK_INCREASE_T12_DELAY (1<<6)
+#define QUIRK_INCREASE_DDI_DISABLED_TIME (1<<7)
 
 struct intel_fbdev;
 struct intel_fbc_work;
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -1605,15 +1605,24 @@ void intel_ddi_enable_transcoder_func(co
 	I915_WRITE(TRANS_DDI_FUNC_CTL(cpu_transcoder), temp);
 }
 
-void intel_ddi_disable_transcoder_func(struct drm_i915_private *dev_priv,
-				       enum transcoder cpu_transcoder)
+void intel_ddi_disable_transcoder_func(const struct intel_crtc_state *crtc_state)
 {
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->base.crtc);
+	struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 	i915_reg_t reg = TRANS_DDI_FUNC_CTL(cpu_transcoder);
 	uint32_t val = I915_READ(reg);
 
 	val &= ~(TRANS_DDI_FUNC_ENABLE | TRANS_DDI_PORT_MASK | TRANS_DDI_DP_VC_PAYLOAD_ALLOC);
 	val |= TRANS_DDI_PORT_NONE;
 	I915_WRITE(reg, val);
+
+	if (dev_priv->quirks & QUIRK_INCREASE_DDI_DISABLED_TIME &&
+	    intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI)) {
+		DRM_DEBUG_KMS("Quirk Increase DDI disabled time\n");
+		/* Quirk time at 100ms for reliable operation */
+		msleep(100);
+	}
 }
 
 int intel_ddi_toggle_hdcp_signalling(struct intel_encoder *intel_encoder,
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -5685,7 +5685,7 @@ static void haswell_crtc_disable(struct
 		intel_ddi_set_vc_payload_alloc(intel_crtc->config, false);
 
 	if (!transcoder_is_dsi(cpu_transcoder))
-		intel_ddi_disable_transcoder_func(dev_priv, cpu_transcoder);
+		intel_ddi_disable_transcoder_func(old_crtc_state);
 
 	if (INTEL_GEN(dev_priv) >= 9)
 		skylake_scaler_disable(intel_crtc);
@@ -14388,6 +14388,18 @@ static void quirk_increase_t12_delay(str
 	DRM_INFO("Applying T12 delay quirk\n");
 }
 
+/*
+ * GeminiLake NUC HDMI outputs require additional off time
+ * this allows the onboard retimer to correctly sync to signal
+ */
+static void quirk_increase_ddi_disabled_time(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv = to_i915(dev);
+
+	dev_priv->quirks |= QUIRK_INCREASE_DDI_DISABLED_TIME;
+	DRM_INFO("Applying Increase DDI Disabled quirk\n");
+}
+
 struct intel_quirk {
 	int device;
 	int subsystem_vendor;
@@ -14474,6 +14486,13 @@ static struct intel_quirk intel_quirks[]
 
 	/* Toshiba Satellite P50-C-18C */
 	{ 0x191B, 0x1179, 0xF840, quirk_increase_t12_delay },
+
+	/* GeminiLake NUC */
+	{ 0x3185, 0x8086, 0x2072, quirk_increase_ddi_disabled_time },
+	{ 0x3184, 0x8086, 0x2072, quirk_increase_ddi_disabled_time },
+	/* ASRock ITX*/
+	{ 0x3185, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
+	{ 0x3184, 0x1849, 0x2212, quirk_increase_ddi_disabled_time },
 };
 
 static void intel_init_quirks(struct drm_device *dev)
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -1368,8 +1368,7 @@ void hsw_fdi_link_train(struct intel_crt
 void intel_ddi_init(struct drm_i915_private *dev_priv, enum port port);
 bool intel_ddi_get_hw_state(struct intel_encoder *encoder, enum pipe *pipe);
 void intel_ddi_enable_transcoder_func(const struct intel_crtc_state *crtc_state);
-void intel_ddi_disable_transcoder_func(struct drm_i915_private *dev_priv,
-				       enum transcoder cpu_transcoder);
+void intel_ddi_disable_transcoder_func(const struct intel_crtc_state *crtc_state);
 void intel_ddi_enable_pipe_clock(const struct intel_crtc_state *crtc_state);
 void intel_ddi_disable_pipe_clock(const  struct intel_crtc_state *crtc_state);
 struct intel_encoder *


