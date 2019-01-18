Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCBBC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfAROv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:51:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48100 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfAROv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:51:57 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 288932247E; Fri, 18 Jan 2019 15:51:55 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4230720A7D;
        Fri, 18 Jan 2019 15:51:44 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH RESEND v5 13/23] drm/sun4i: Add buffer stride and offset configuration for tiling mode
Date:   Fri, 18 Jan 2019 15:51:23 +0100
Message-Id: <20190118145133.21281-14-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces stride and offset configuration for the VPU tiling mode.
Stride is calculated differently than it is for linear formats and an
offset is calculated, for which new register definitions are introduced.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_frontend.c | 49 ++++++++++++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_frontend.h | 19 ++++++++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index e950370792ce..6ede40aab515 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -126,21 +126,64 @@ void sun4i_frontend_update_buffer(struct sun4i_frontend *frontend,
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
+	unsigned int strides[3] = {};
+
 	dma_addr_t paddr;
 	bool swap;
 
+	if (fb->modifier == DRM_FORMAT_MOD_ALLWINNER_TILED) {
+		unsigned int width = state->src_w >> 16;
+		unsigned int offset;
+
+		strides[0] = SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[0]);
+
+		/*
+		 * The X1 offset is the offset to the bottom-right point in the
+		 * end tile, which is the final pixel (at offset width - 1)
+		 * within the end tile (with a 32-byte mask).
+		 */
+		offset = (width - 1) & (32 - 1);
+
+		regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF0_REG,
+			     SUN4I_FRONTEND_TB_OFF_X1(offset));
+
+		if (fb->format->num_planes > 1) {
+			strides[1] =
+				SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[1]);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF1_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+
+		if (fb->format->num_planes > 2) {
+			strides[2] =
+				SUN4I_FRONTEND_LINESTRD_TILED(fb->pitches[2]);
+
+			regmap_write(frontend->regs, SUN4I_FRONTEND_TB_OFF2_REG,
+				     SUN4I_FRONTEND_TB_OFF_X1(offset));
+		}
+	} else {
+		strides[0] = fb->pitches[0];
+
+		if (fb->format->num_planes > 1)
+			strides[1] = fb->pitches[1];
+
+		if (fb->format->num_planes > 2)
+			strides[2] = fb->pitches[2];
+	}
+
 	/* Set the line width */
 	DRM_DEBUG_DRIVER("Frontend stride: %d bytes\n", fb->pitches[0]);
 	regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD0_REG,
-		     fb->pitches[0]);
+		     strides[0]);
 
 	if (fb->format->num_planes > 1)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD1_REG,
-			     fb->pitches[1]);
+			     strides[1]);
 
 	if (fb->format->num_planes > 2)
 		regmap_write(frontend->regs, SUN4I_FRONTEND_LINESTRD2_REG,
-			     fb->pitches[2]);
+			     strides[2]);
 
 	/* Some planar formats require chroma channel swapping by hand. */
 	swap = sun4i_frontend_format_chroma_requires_swap(fb->format->format);
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.h b/drivers/gpu/drm/sun4i/sun4i_frontend.h
index 6c4d7797bb8a..235109199b9d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.h
@@ -25,10 +25,29 @@
 #define SUN4I_FRONTEND_BUF_ADDR1_REG		0x024
 #define SUN4I_FRONTEND_BUF_ADDR2_REG		0x028
 
+#define SUN4I_FRONTEND_TB_OFF0_REG		0x030
+#define SUN4I_FRONTEND_TB_OFF1_REG		0x034
+#define SUN4I_FRONTEND_TB_OFF2_REG		0x038
+#define SUN4I_FRONTEND_TB_OFF_X1(x1)			((x1) << 16)
+#define SUN4I_FRONTEND_TB_OFF_Y0(y0)			((y0) << 8)
+#define SUN4I_FRONTEND_TB_OFF_X0(x0)			(x0)
+
 #define SUN4I_FRONTEND_LINESTRD0_REG		0x040
 #define SUN4I_FRONTEND_LINESTRD1_REG		0x044
 #define SUN4I_FRONTEND_LINESTRD2_REG		0x048
 
+/*
+ * In tiled mode, the stride is defined as the distance between the start of the
+ * end line of the current tile and the start of the first line in the next
+ * vertical tile.
+ *
+ * Tiles are represented in row-major order, thus the end line of current tile
+ * starts at: 31 * 32 (31 lines of 32 cols), the next vertical tile starts at:
+ * 32-bit-aligned-width * 32 and the distance is:
+ * 32 * (32-bit-aligned-width - 31).
+ */
+#define SUN4I_FRONTEND_LINESTRD_TILED(stride)		(((stride) - 31) * 32)
+
 #define SUN4I_FRONTEND_INPUT_FMT_REG		0x04c
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PLANAR	(0 << 8)
 #define SUN4I_FRONTEND_INPUT_FMT_DATA_MOD_PACKED	(1 << 8)
-- 
2.20.1

