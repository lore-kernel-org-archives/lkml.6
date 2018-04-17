Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeDQLko (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:40:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1825 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752067AbeDQLkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:40:43 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] drm/stm: ltdc: add mode_valid()
Date: Tue, 17 Apr 2018 13:40:26 +0200
Message-ID: <20180417114026.8709-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mode_valid() function to filter modes according to available
pll clock values and "preferred" modes. It is particularly
useful for hdmi modes that require precise pixel clocks.

Note that "preferred" modes are always accepted:
- this is important for panels because panel clock tolerances are
  bigger than hdmi ones and there is no reason to not accept them
  (the fps may vary a little but it is not a problem).
- the hdmi preferred mode will be accepted too, but userland will
  be able to use others hdmi "valid" modes if necessary.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 014cef8cef37..616191fe98ae 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -445,6 +445,43 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 	reg_set(ldev->regs, LTDC_SRCR, SRCR_IMR);
 }
 
+#define CLK_TOLERANCE_HZ 50
+
+static enum drm_mode_status
+ltdc_crtc_mode_valid(struct drm_crtc *crtc,
+		     const struct drm_display_mode *mode)
+{
+	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	int target = mode->clock * 1000;
+	int target_min = target - CLK_TOLERANCE_HZ;
+	int target_max = target + CLK_TOLERANCE_HZ;
+	int result;
+
+	/*
+	 * Accept all "preferred" modes:
+	 * - this is important for panels because panel clock tolerances are
+	 *   bigger than hdmi ones and there is no reason to not accept them
+	 *   (the fps may vary a little but it is not a problem).
+	 * - the hdmi preferred mode will be accepted too, but userland will
+	 *   be able to use others hdmi "valid" modes if necessary.
+	 */
+	if (mode->type & DRM_MODE_TYPE_PREFERRED)
+		return MODE_OK;
+
+	result = clk_round_rate(ldev->pixel_clk, target);
+
+	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
+
+	/*
+	 * Filter modes according to the clock value, particularly useful for
+	 * hdmi modes that require precise pixel clocks.
+	 */
+	if (result < target_min || result > target_max)
+		return MODE_CLOCK_RANGE;
+
+	return MODE_OK;
+}
+
 static bool ltdc_crtc_mode_fixup(struct drm_crtc *crtc,
 				 const struct drm_display_mode *mode,
 				 struct drm_display_mode *adjusted_mode)
@@ -559,6 +596,7 @@ static void ltdc_crtc_atomic_flush(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
+	.mode_valid = ltdc_crtc_mode_valid,
 	.mode_fixup = ltdc_crtc_mode_fixup,
 	.mode_set_nofb = ltdc_crtc_mode_set_nofb,
 	.atomic_flush = ltdc_crtc_atomic_flush,
-- 
2.15.1
