Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeDGVa0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 17:30:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44397 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751572AbeDGVaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 17:30:24 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Fabien Dessenne <fabien.dessenne@st.com>,
        Mickael Reulier <mickael.reulier@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH] drm/stm: move enable/disable_vblank to crtc
Date: Sat, 7 Apr 2018 23:29:37 +0200
Message-ID: <20180407212937.30407-1-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.9]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-07_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable/disable_vblank() functions at drm_driver level
are deprecated. Move them to the ltdc drm_crtc_funcs
structure.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/stm/drv.c  |  2 --
 drivers/gpu/drm/stm/ltdc.c | 10 ++++++----
 drivers/gpu/drm/stm/ltdc.h |  2 --
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 9ab00a87f7cc..8698e08313e1 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -72,8 +72,6 @@ static struct drm_driver drv_driver = {
 	.gem_prime_vmap = drm_gem_cma_prime_vmap,
 	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap = drm_gem_cma_prime_mmap,
-	.enable_vblank = ltdc_crtc_enable_vblank,
-	.disable_vblank = ltdc_crtc_disable_vblank,
 };
 
 static int drv_load(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 1a3277e483d5..2b745cfc9000 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -569,9 +569,9 @@ static const struct drm_crtc_helper_funcs ltdc_crtc_helper_funcs = {
 	.atomic_disable = ltdc_crtc_atomic_disable,
 };
 
-int ltdc_crtc_enable_vblank(struct drm_device *ddev, unsigned int pipe)
+static int ltdc_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct ltdc_device *ldev = ddev->dev_private;
+	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 
 	DRM_DEBUG_DRIVER("\n");
 	reg_set(ldev->regs, LTDC_IER, IER_LIE);
@@ -579,9 +579,9 @@ int ltdc_crtc_enable_vblank(struct drm_device *ddev, unsigned int pipe)
 	return 0;
 }
 
-void ltdc_crtc_disable_vblank(struct drm_device *ddev, unsigned int pipe)
+static void ltdc_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct ltdc_device *ldev = ddev->dev_private;
+	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 
 	DRM_DEBUG_DRIVER("\n");
 	reg_clear(ldev->regs, LTDC_IER, IER_LIE);
@@ -594,6 +594,8 @@ static const struct drm_crtc_funcs ltdc_crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank = ltdc_crtc_enable_vblank,
+	.disable_vblank = ltdc_crtc_disable_vblank,
 	.gamma_set = drm_atomic_helper_legacy_gamma_set,
 };
 
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index edb268129c54..61a80d00bc3b 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -29,8 +29,6 @@ struct ltdc_device {
 	u32 irq_status;
 };
 
-int ltdc_crtc_enable_vblank(struct drm_device *dev, unsigned int pipe);
-void ltdc_crtc_disable_vblank(struct drm_device *dev, unsigned int pipe);
 int ltdc_load(struct drm_device *ddev);
 void ltdc_unload(struct drm_device *ddev);
 
-- 
2.15.1
