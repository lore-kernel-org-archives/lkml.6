Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeERI0s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:26:48 -0400
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:31372 "EHLO
        cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753845AbeERIYi (ORCPT
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
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [PATCH v7 1/5] drm: mali-dp: Add support for writeback on DP550/DP650
Date: Fri, 18 May 2018 09:24:19 +0100
Message-Id: <20180518082423.15500-2-Liviu.Dudau@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518082423.15500-1-Liviu.Dudau@arm.com>
References: <20180518082423.15500-1-Liviu.Dudau@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mali-DP display processors are able to write the composition result to a
memory buffer via the SE.

Add entry points in the HAL for enabling/disabling this feature, and
implement support for it on DP650 and DP550. DP500 acts differently and
so is omitted from this change.

Changes since v3:
 - Fix missing vsync interrupt for DP550

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Signed-off-by: Brian Starkey <brian.starkey@arm.com>
[rebased and fixed conflicts]
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c   | 54 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/arm/malidp_hw.h   | 17 ++++++++++
 drivers/gpu/drm/arm/malidp_regs.h | 15 +++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index d789b46dc8173..7a0f1ee161feb 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -588,6 +588,48 @@ static long malidp550_se_calc_mclk(struct malidp_hw_device *hwdev,
 	return ret;
 }
 
+static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
+				     dma_addr_t *addrs, s32 *pitches,
+				     int num_planes, u16 w, u16 h, u32 fmt_id)
+{
+	u32 base = MALIDP550_SE_MEMWRITE_BASE;
+	u32 de_base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+
+	/* enable the scaling engine block */
+	malidp_hw_setbits(hwdev, MALIDP_SCALE_ENGINE_EN, de_base + MALIDP_DE_DISPLAY_FUNC);
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
+			MALIDP550_SE_MEMWRITE_OUT_SIZE);
+	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
+			  MALIDP550_SE_CONTROL);
+
+	return 0;
+}
+
+static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
+{
+	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
+	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
+			    MALIDP550_SE_CONTROL);
+	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);
+}
+
 static int malidp650_query_hw(struct malidp_hw_device *hwdev)
 {
 	u32 conf = malidp_hw_read(hwdev, MALIDP550_CONFIG_ID);
@@ -673,9 +715,11 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 			.se_irq_map = {
 				.irq_mask = MALIDP550_SE_IRQ_EOW |
 					    MALIDP550_SE_IRQ_AXI_ERR,
+				.vsync_irq = MALIDP550_SE_IRQ_EOW,
 			},
 			.dc_irq_map = {
-				.irq_mask = MALIDP550_DC_IRQ_CONF_VALID,
+				.irq_mask = MALIDP550_DC_IRQ_CONF_VALID |
+					    MALIDP550_DC_IRQ_SE,
 				.vsync_irq = MALIDP550_DC_IRQ_CONF_VALID,
 			},
 			.pixel_formats = malidp550_de_formats,
@@ -691,6 +735,8 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 		.rotmem_required = malidp550_rotmem_required,
 		.se_set_scaling_coeffs = malidp550_se_set_scaling_coeffs,
 		.se_calc_mclk = malidp550_se_calc_mclk,
+		.enable_memwrite = malidp550_enable_memwrite,
+		.disable_memwrite = malidp550_disable_memwrite,
 		.features = 0,
 	},
 	[MALIDP_650] = {
@@ -711,9 +757,11 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 			.se_irq_map = {
 				.irq_mask = MALIDP550_SE_IRQ_EOW |
 					    MALIDP550_SE_IRQ_AXI_ERR,
+				.vsync_irq = MALIDP550_SE_IRQ_EOW,
 			},
 			.dc_irq_map = {
-				.irq_mask = MALIDP550_DC_IRQ_CONF_VALID,
+				.irq_mask = MALIDP550_DC_IRQ_CONF_VALID |
+					    MALIDP550_DC_IRQ_SE,
 				.vsync_irq = MALIDP550_DC_IRQ_CONF_VALID,
 			},
 			.pixel_formats = malidp550_de_formats,
@@ -729,6 +777,8 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES] = {
 		.rotmem_required = malidp550_rotmem_required,
 		.se_set_scaling_coeffs = malidp550_se_set_scaling_coeffs,
 		.se_calc_mclk = malidp550_se_calc_mclk,
+		.enable_memwrite = malidp550_enable_memwrite,
+		.disable_memwrite = malidp550_disable_memwrite,
 		.features = 0,
 	},
 };
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_hw.h
index b5dd6c73ec9f2..72cc22f828360 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -177,6 +177,23 @@ struct malidp_hw {
 	long (*se_calc_mclk)(struct malidp_hw_device *hwdev,
 			     struct malidp_se_config *se_config,
 			     struct videomode *vm);
+	/**
+	 * Enable writing to memory the content of the next frame
+	 * @param hwdev - malidp_hw_device structure containing the HW description
+	 * @param addrs - array of addresses for each plane
+	 * @param pitches - array of pitches for each plane
+	 * @param num_planes - number of planes to be written
+	 * @param w - width of the output frame
+	 * @param h - height of the output frame
+	 * @param fmt_id - internal format ID of output buffer
+	 */
+	int (*enable_memwrite)(struct malidp_hw_device *hwdev, dma_addr_t *addrs,
+			       s32 *pitches, int num_planes, u16 w, u16 h, u32 fmt_id);
+
+	/*
+	 * Disable the writing to memory of the next frame's content.
+	 */
+	void (*disable_memwrite)(struct malidp_hw_device *hwdev);
 
 	u8 features;
 };
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
index 149024fb44327..e2b2c496225e3 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -66,6 +66,8 @@
 #define   MALIDP_DISP_FUNC_GAMMA	(1 << 0)
 #define   MALIDP_DISP_FUNC_CADJ		(1 << 4)
 #define   MALIDP_DISP_FUNC_ILACED	(1 << 8)
+#define   MALIDP_SCALE_ENGINE_EN	(1 << 16)
+#define   MALIDP_SE_MEMWRITE_EN		(2 << 5)
 
 /* register offsets for IRQ management */
 #define MALIDP_REG_STATUS		0x00000
@@ -153,6 +155,16 @@
 		(((x) & MALIDP_SE_ENH_LIMIT_MASK) << 16)
 #define   MALIDP_SE_ENH_COEFF0			0x04
 
+
+/* register offsets relative to MALIDP5x0_SE_MEMWRITE_BASE */
+#define MALIDP_MW_FORMAT		0x00000
+#define MALIDP_MW_P1_STRIDE		0x00004
+#define MALIDP_MW_P2_STRIDE		0x00008
+#define MALIDP_MW_P1_PTR_LOW		0x0000c
+#define MALIDP_MW_P1_PTR_HIGH		0x00010
+#define MALIDP_MW_P2_PTR_LOW		0x0002c
+#define MALIDP_MW_P2_PTR_HIGH		0x00030
+
 /* register offsets and bits specific to DP500 */
 #define MALIDP500_ADDR_SPACE_SIZE	0x01000
 #define MALIDP500_DC_BASE		0x00000
@@ -217,6 +229,9 @@
 #define MALIDP550_DE_PERF_BASE		0x00500
 #define MALIDP550_SE_BASE		0x08000
 #define MALIDP550_SE_CONTROL		0x08010
+#define   MALIDP550_SE_MEMWRITE_ONESHOT	(1 << 7)
+#define MALIDP550_SE_MEMWRITE_OUT_SIZE	0x08030
+#define MALIDP550_SE_MEMWRITE_BASE	0x08100
 #define MALIDP550_DC_BASE		0x0c000
 #define MALIDP550_DC_CONTROL		0x0c010
 #define   MALIDP550_DC_CONFIG_REQ	(1 << 16)
-- 
2.17.0
