Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeERI0u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:26:50 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:31371 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753844AbeERIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:24:38 -0400
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Mali DP Maintainers <malidp@foss.arm.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Stone <daniels@collabora.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v7 3/5] drm/mali-dp: Add writeback support for DP500.
Date: Fri, 18 May 2018 09:24:21 +0100
Message-Id: <20180518082423.15500-4-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518082423.15500-1-Liviu.Dudau@arm.com>
References: <20180518082423.15500-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mali DP500 behaves differently from the rest of the Mali DP IP,
in that it does not have a one-shot mode and keeps writing the
content of the current frame to the provided memory area until
stopped. As a way of emulating the one-shot behaviour, we are
going to use the CVAL interrupt that is being raised at the
start of each frame, during prefetch phase, to act as End-of-Write
signal, but with a twist: we are going to disable the memory
write engine right after we're notified that it has been enabled,
using the knowledge that the bit controlling the enabling will
only be acted upon on the next vblank/prefetch.

CVAL interrupt will fire durint the next prefetch phase every time
the global CVAL bit gets set, so we need a state byte to track
the memory write enabling.

Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c   | 77 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/arm/malidp_hw.h   |  5 +-
 drivers/gpu/drm/arm/malidp_regs.h |  3 +-
 3 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 455a83689d039..d9a7f19c9f219 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -22,6 +22,13 @@
 #include "malidp_drv.h"
 #include "malidp_hw.h"
 
+enum {
+	MW_NOT_ENABLED = 0,	/* SE writeback not enabled */
+	MW_ONESHOT,		/* SE in one-shot mode for writeback */
+	MW_START,		/* SE started writeback */
+	MW_STOP,		/* SE finished writeback */
+};
+
 static const struct malidp_format_id malidp500_de_formats[] = {
 	/*    fourcc,   layers supporting the format,     internal id  */
 	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_GRAPHICS2,  0 },
@@ -368,6 +375,50 @@ static long malidp500_se_calc_mclk(struct malidp_hw_device *hwdev,
 	return ret;
 }
 
+static int malidp500_enable_memwrite(struct malidp_hw_device *hwdev,
+				     dma_addr_t *addrs, s32 *pitches,
+				     int num_planes, u16 w, u16 h, u32 fmt_id)
+{
+	u32 base = MALIDP500_SE_MEMWRITE_BASE;
+	u32 de_base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+
+	/* enable the scaling engine block */
+	malidp_hw_setbits(hwdev, MALIDP_SCALE_ENGINE_EN, de_base + MALIDP_DE_DISPLAY_FUNC);
+
+	hwdev->mw_state = MW_START;
+
+	malidp_hw_write(hwdev, fmt_id, base + MALIDP_MW_FORMAT);
+	switch (num_planes) {
+	case 2:
+		malidp_hw_write(hwdev, lower_32_bits(addrs[1]), base + MALIDP_MW_P2_PTR_LOW);
+		malidp_hw_write(hwdev, upper_32_bits(addrs[1]), base + MALIDP_MW_P2_PTR_HIGH);
+		malidp_hw_write(hwdev, pitches[1], base + MALIDP_MW_P2_STRIDE);
+		/* fall through */
+	case 1:
+		malidp_hw_write(hwdev, lower_32_bits(addrs[0]), base + MALIDP_MW_P1_PTR_LOW);
+		malidp_hw_write(hwdev, upper_32_bits(addrs[0]), base + MALIDP_MW_P1_PTR_HIGH);
+		malidp_hw_write(hwdev, pitches[0], base + MALIDP_MW_P1_STRIDE);
+		break;
+	default:
+		WARN(1, "Invalid number of planes");
+	}
+
+	malidp_hw_write(hwdev, MALIDP_DE_H_ACTIVE(w) | MALIDP_DE_V_ACTIVE(h),
+			MALIDP500_SE_MEMWRITE_OUT_SIZE);
+	malidp_hw_setbits(hwdev, MALIDP_SE_MEMWRITE_EN, MALIDP500_SE_CONTROL);
+
+	return 0;
+}
+
+static void malidp500_disable_memwrite(struct malidp_hw_device *hwdev)
+{
+	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+	if (hwdev->mw_state == MW_START)
+		hwdev->mw_state = MW_STOP;
+	malidp_hw_clearbits(hwdev, MALIDP_SE_MEMWRITE_EN, MALIDP500_SE_CONTROL);
+	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
+}
+
 static int malidp550_query_hw(struct malidp_hw_device *hwdev)
 {
 	u32 conf = malidp_hw_read(hwdev, MALIDP550_CONFIG_ID);
@@ -598,6 +649,8 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
 	/* enable the scaling engine block */
 	malidp_hw_setbits(hwdev, MALIDP_SCALE_ENGINE_EN, de_base + MALIDP_DE_DISPLAY_FUNC);
 
+	hwdev->mw_state = MW_ONESHOT;
+
 	malidp_hw_write(hwdev, fmt_id, base + MALIDP_MW_FORMAT);
 	switch (num_planes) {
 	case 2:
@@ -676,8 +729,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 				.vsync_irq = MALIDP500_DE_IRQ_VSYNC,
 			},
 			.se_irq_map = {
-				.irq_mask = MALIDP500_SE_IRQ_CONF_MODE,
-				.vsync_irq = 0,
+				.irq_mask = MALIDP500_SE_IRQ_CONF_MODE |
+					    MALIDP500_SE_IRQ_CONF_VALID,
+				.vsync_irq = MALIDP500_SE_IRQ_CONF_VALID,
 			},
 			.dc_irq_map = {
 				.irq_mask = MALIDP500_DE_IRQ_CONF_VALID,
@@ -696,6 +750,8 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 		.rotmem_required = malidp500_rotmem_required,
 		.se_set_scaling_coeffs = malidp500_se_set_scaling_coeffs,
 		.se_calc_mclk = malidp500_se_calc_mclk,
+		.enable_memwrite = malidp500_enable_memwrite,
+		.disable_memwrite = malidp500_disable_memwrite,
 		.features = MALIDP_DEVICE_LV_HAS_3_STRIDES,
 	},
 	[MALIDP_550] = {
@@ -934,7 +990,21 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 	mask = malidp_hw_read(hwdev, hw->map.se_base + MALIDP_REG_MASKIRQ);
 	status = malidp_hw_read(hwdev, hw->map.se_base + MALIDP_REG_STATUS);
 	status &= mask;
-	/* ToDo: status decoding and firing up of VSYNC and page flip events */
+
+	if (status & se->vsync_irq) {
+		switch (hwdev->mw_state) {
+		case MW_STOP:
+		case MW_ONESHOT:
+			/* disable writeback after stop or oneshot */
+			hwdev->mw_state = MW_NOT_ENABLED;
+			break;
+		case MW_START:
+			/* writeback started, need to emulate one-shot mode */
+			hw->disable_memwrite(hwdev);
+			hw->set_config_valid(hwdev);
+			break;
+		}
+	}
 
 	malidp_hw_clear_irq(hwdev, MALIDP_SE_BLOCK, status);
 
@@ -964,6 +1034,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)
 		return ret;
 	}
 
+	hwdev->mw_state = MW_NOT_ENABLED;
 	malidp_hw_enable_irq(hwdev, MALIDP_SE_BLOCK,
 			     hwdev->hw->map.se_irq_map.irq_mask);
 
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index a242e97cf6428..c479738b81af5 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -178,7 +178,7 @@ struct malidp_hw {
 	long (*se_calc_mclk)(struct malidp_hw_device *hwdev,
 			     struct malidp_se_config *se_config,
 			     struct videomode *vm);
-	/**
+	/*
 	 * Enable writing to memory the content of the next frame
 	 * @param hwdev - malidp_hw_device structure containing the HW description
 	 * @param addrs - array of addresses for each plane
@@ -232,6 +232,9 @@ struct malidp_hw_device {
 	/* track the device PM state */
 	bool pm_suspended;
 
+	/* track the SE memory writeback state */
+	u8 mw_state;
+
 	/* size of memory used for rotating layers, up to two banks available */
 	u32 rotation_memory[2];
 };
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index e2b2c496225e3..93b198f3af864 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -198,7 +198,8 @@
 #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
 #define MALIDP500_SE_BASE		0x00c00
 #define MALIDP500_SE_CONTROL		0x00c0c
-#define MALIDP500_SE_PTR_BASE		0x00e0c
+#define MALIDP500_SE_MEMWRITE_OUT_SIZE	0x00c2c
+#define MALIDP500_SE_MEMWRITE_BASE	0x00e00
 #define MALIDP500_DC_IRQ_BASE		0x00f00
 #define MALIDP500_CONFIG_VALID		0x00f00
 #define MALIDP500_CONFIG_ID		0x00fd4
-- 
2.17.0
