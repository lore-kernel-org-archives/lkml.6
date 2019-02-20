Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4570F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBTVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:03:58 -0500
Received: from anholt.net ([50.246.234.109]:51858 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfBTVD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id BE6CB10A2D20;
        Wed, 20 Feb 2019 13:03:56 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id GF87eSSRmMaE; Wed, 20 Feb 2019 13:03:47 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CBDD510A2D1A;
        Wed, 20 Feb 2019 13:03:44 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 974132FE1FE6; Wed, 20 Feb 2019 13:03:43 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/7] drm/vc4: Use drm_print_regset32() for our debug register dumping.
Date:   Wed, 20 Feb 2019 13:03:38 -0800
Message-Id: <20190220210343.28157-2-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes a bunch of duplicated boilerplate for the debugfs vs
runtime printk debug dumping.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_crtc.c |  68 ++++++-------
 drivers/gpu/drm/vc4/vc4_dpi.c  |  23 ++---
 drivers/gpu/drm/vc4/vc4_drv.h  |   7 ++
 drivers/gpu/drm/vc4/vc4_dsi.c  | 155 +++++++++++++----------------
 drivers/gpu/drm/vc4/vc4_hdmi.c | 156 +++++++++++++----------------
 drivers/gpu/drm/vc4/vc4_hvs.c  |  87 ++++++++---------
 drivers/gpu/drm/vc4/vc4_txp.c  |  28 +++---
 drivers/gpu/drm/vc4/vc4_v3d.c  | 173 ++++++++++++++++-----------------
 drivers/gpu/drm/vc4/vc4_vec.c  |  67 ++++++-------
 9 files changed, 350 insertions(+), 414 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 730008d3da76..6d7072026056 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -35,6 +35,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/clk.h>
 #include <drm/drm_fb_cma_helper.h>
@@ -67,43 +68,29 @@ to_vc4_crtc_state(struct drm_crtc_state *crtc_state)
 #define CRTC_WRITE(offset, val) writel(val, vc4_crtc->regs + (offset))
 #define CRTC_READ(offset) readl(vc4_crtc->regs + (offset))
 
-#define CRTC_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} crtc_regs[] = {
-	CRTC_REG(PV_CONTROL),
-	CRTC_REG(PV_V_CONTROL),
-	CRTC_REG(PV_VSYNCD_EVEN),
-	CRTC_REG(PV_HORZA),
-	CRTC_REG(PV_HORZB),
-	CRTC_REG(PV_VERTA),
-	CRTC_REG(PV_VERTB),
-	CRTC_REG(PV_VERTA_EVEN),
-	CRTC_REG(PV_VERTB_EVEN),
-	CRTC_REG(PV_INTEN),
-	CRTC_REG(PV_INTSTAT),
-	CRTC_REG(PV_STAT),
-	CRTC_REG(PV_HACT_ACT),
+static const struct debugfs_reg32 crtc_regs[] = {
+	VC4_REG32(PV_CONTROL),
+	VC4_REG32(PV_V_CONTROL),
+	VC4_REG32(PV_VSYNCD_EVEN),
+	VC4_REG32(PV_HORZA),
+	VC4_REG32(PV_HORZB),
+	VC4_REG32(PV_VERTA),
+	VC4_REG32(PV_VERTB),
+	VC4_REG32(PV_VERTA_EVEN),
+	VC4_REG32(PV_VERTB_EVEN),
+	VC4_REG32(PV_INTEN),
+	VC4_REG32(PV_INTSTAT),
+	VC4_REG32(PV_STAT),
+	VC4_REG32(PV_HACT_ACT),
 };
 
-static void vc4_crtc_dump_regs(struct vc4_crtc *vc4_crtc)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(crtc_regs); i++) {
-		DRM_INFO("0x%04x (%s): 0x%08x\n",
-			 crtc_regs[i].reg, crtc_regs[i].name,
-			 CRTC_READ(crtc_regs[i].reg));
-	}
-}
-
 #ifdef CONFIG_DEBUG_FS
 int vc4_crtc_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	int crtc_index = (uintptr_t)node->info_ent->data;
+	struct drm_printer p = drm_seq_file_printer(m);
 	struct drm_crtc *crtc;
 	struct vc4_crtc *vc4_crtc;
 	int i;
@@ -118,11 +105,7 @@ int vc4_crtc_debugfs_regs(struct seq_file *m, void *unused)
 		return 0;
 	vc4_crtc = to_vc4_crtc(crtc);
 
-	for (i = 0; i < ARRAY_SIZE(crtc_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   crtc_regs[i].name, crtc_regs[i].reg,
-			   CRTC_READ(crtc_regs[i].reg));
-	}
+	drm_print_regset32(&p, &vc4_crtc->regset);
 
 	return 0;
 }
@@ -434,8 +417,10 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	bool debug_dump_regs = false;
 
 	if (debug_dump_regs) {
-		DRM_INFO("CRTC %d regs before:\n", drm_crtc_index(crtc));
-		vc4_crtc_dump_regs(vc4_crtc);
+		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs before:\n",
+			 drm_crtc_index(crtc));
+		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
 
 	if (vc4_crtc->channel == 2) {
@@ -476,8 +461,10 @@ static void vc4_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	vc4_crtc_lut_load(crtc);
 
 	if (debug_dump_regs) {
-		DRM_INFO("CRTC %d regs after:\n", drm_crtc_index(crtc));
-		vc4_crtc_dump_regs(vc4_crtc);
+		struct drm_printer p = drm_info_printer(&vc4_crtc->pdev->dev);
+		dev_info(&vc4_crtc->pdev->dev, "CRTC %d regs after:\n",
+			 drm_crtc_index(crtc));
+		drm_print_regset32(&p, &vc4_crtc->regset);
 	}
 }
 
@@ -1169,11 +1156,16 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 	if (!match)
 		return -ENODEV;
 	vc4_crtc->data = match->data;
+	vc4_crtc->pdev = pdev;
 
 	vc4_crtc->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(vc4_crtc->regs))
 		return PTR_ERR(vc4_crtc->regs);
 
+	vc4_crtc->regset.base = vc4_crtc->regs;
+	vc4_crtc->regset.regs = crtc_regs;
+	vc4_crtc->regset.nregs = ARRAY_SIZE(crtc_regs);
+
 	/* For now, we create just the primary and the legacy cursor
 	 * planes.  We should be able to stack more planes on easily,
 	 * but to do that we would need to compute the bandwidth
diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 169521e547ba..8be2264f496a 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -101,6 +101,8 @@ struct vc4_dpi {
 
 	struct clk *pixel_clock;
 	struct clk *core_clock;
+
+	struct debugfs_regset32 regset;
 };
 
 #define DPI_READ(offset) readl(dpi->regs + (offset))
@@ -118,13 +120,9 @@ to_vc4_dpi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_dpi_encoder, base.base);
 }
 
-#define DPI_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} dpi_regs[] = {
-	DPI_REG(DPI_C),
-	DPI_REG(DPI_ID),
+static const struct debugfs_reg32 dpi_regs[] = {
+	VC4_REG32(DPI_C),
+	VC4_REG32(DPI_ID),
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -134,16 +132,12 @@ int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_dpi *dpi = vc4->dpi;
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
 	if (!dpi)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(dpi_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   dpi_regs[i].name, dpi_regs[i].reg,
-			   DPI_READ(dpi_regs[i].reg));
-	}
+	drm_print_regset32(&p, &dpi->regset);
 
 	return 0;
 }
@@ -314,6 +308,9 @@ static int vc4_dpi_bind(struct device *dev, struct device *master, void *data)
 	dpi->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(dpi->regs))
 		return PTR_ERR(dpi->regs);
+	dpi->regset.base = dpi->regs;
+	dpi->regset.regs = dpi_regs;
+	dpi->regset.nregs = ARRAY_SIZE(dpi_regs);
 
 	if (DPI_READ(DPI_ID) != DPI_ID_VALUE) {
 		dev_err(dev, "Port returned 0x%08x for ID instead of 0x%08x\n",
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index ce1af06cc197..511ad884d9c3 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -285,6 +285,7 @@ struct vc4_v3d {
 	struct platform_device *pdev;
 	void __iomem *regs;
 	struct clk *clk;
+	struct debugfs_regset32 regset;
 };
 
 struct vc4_hvs {
@@ -301,6 +302,7 @@ struct vc4_hvs {
 	spinlock_t mm_lock;
 
 	struct drm_mm_node mitchell_netravali_filter;
+	struct debugfs_regset32 regset;
 };
 
 struct vc4_plane {
@@ -410,6 +412,7 @@ struct vc4_crtc_data {
 
 struct vc4_crtc {
 	struct drm_crtc base;
+	struct platform_device *pdev;
 	const struct vc4_crtc_data *data;
 	void __iomem *regs;
 
@@ -426,6 +429,8 @@ struct vc4_crtc {
 	u32 cob_size;
 
 	struct drm_pending_vblank_event *event;
+
+	struct debugfs_regset32 regset;
 };
 
 static inline struct vc4_crtc *
@@ -439,6 +444,8 @@ to_vc4_crtc(struct drm_crtc *crtc)
 #define HVS_READ(offset) readl(vc4->hvs->regs + offset)
 #define HVS_WRITE(offset, val) writel(val, vc4->hvs->regs + offset)
 
+#define VC4_REG32(reg) { .name = #reg, .offset = reg }
+
 struct vc4_exec_info {
 	/* Sequence number for this bin/render job. */
 	uint64_t seqno;
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 11702e1d9011..806cfaa2a6a7 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -545,6 +545,8 @@ struct vc4_dsi {
 
 	struct completion xfer_completion;
 	int xfer_result;
+
+	struct debugfs_regset32 regset;
 };
 
 #define host_to_dsi(host) container_of(host, struct vc4_dsi, dsi_host)
@@ -605,82 +607,56 @@ to_vc4_dsi_encoder(struct drm_encoder *encoder)
 	return container_of(encoder, struct vc4_dsi_encoder, base.base);
 }
 
-#define DSI_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} dsi0_regs[] = {
-	DSI_REG(DSI0_CTRL),
-	DSI_REG(DSI0_STAT),
-	DSI_REG(DSI0_HSTX_TO_CNT),
-	DSI_REG(DSI0_LPRX_TO_CNT),
-	DSI_REG(DSI0_TA_TO_CNT),
-	DSI_REG(DSI0_PR_TO_CNT),
-	DSI_REG(DSI0_DISP0_CTRL),
-	DSI_REG(DSI0_DISP1_CTRL),
-	DSI_REG(DSI0_INT_STAT),
-	DSI_REG(DSI0_INT_EN),
-	DSI_REG(DSI0_PHYC),
-	DSI_REG(DSI0_HS_CLT0),
-	DSI_REG(DSI0_HS_CLT1),
-	DSI_REG(DSI0_HS_CLT2),
-	DSI_REG(DSI0_HS_DLT3),
-	DSI_REG(DSI0_HS_DLT4),
-	DSI_REG(DSI0_HS_DLT5),
-	DSI_REG(DSI0_HS_DLT6),
-	DSI_REG(DSI0_HS_DLT7),
-	DSI_REG(DSI0_PHY_AFEC0),
-	DSI_REG(DSI0_PHY_AFEC1),
-	DSI_REG(DSI0_ID),
+static const struct debugfs_reg32 dsi0_regs[] = {
+	VC4_REG32(DSI0_CTRL),
+	VC4_REG32(DSI0_STAT),
+	VC4_REG32(DSI0_HSTX_TO_CNT),
+	VC4_REG32(DSI0_LPRX_TO_CNT),
+	VC4_REG32(DSI0_TA_TO_CNT),
+	VC4_REG32(DSI0_PR_TO_CNT),
+	VC4_REG32(DSI0_DISP0_CTRL),
+	VC4_REG32(DSI0_DISP1_CTRL),
+	VC4_REG32(DSI0_INT_STAT),
+	VC4_REG32(DSI0_INT_EN),
+	VC4_REG32(DSI0_PHYC),
+	VC4_REG32(DSI0_HS_CLT0),
+	VC4_REG32(DSI0_HS_CLT1),
+	VC4_REG32(DSI0_HS_CLT2),
+	VC4_REG32(DSI0_HS_DLT3),
+	VC4_REG32(DSI0_HS_DLT4),
+	VC4_REG32(DSI0_HS_DLT5),
+	VC4_REG32(DSI0_HS_DLT6),
+	VC4_REG32(DSI0_HS_DLT7),
+	VC4_REG32(DSI0_PHY_AFEC0),
+	VC4_REG32(DSI0_PHY_AFEC1),
+	VC4_REG32(DSI0_ID),
 };
 
-static const struct {
-	u32 reg;
-	const char *name;
-} dsi1_regs[] = {
-	DSI_REG(DSI1_CTRL),
-	DSI_REG(DSI1_STAT),
-	DSI_REG(DSI1_HSTX_TO_CNT),
-	DSI_REG(DSI1_LPRX_TO_CNT),
-	DSI_REG(DSI1_TA_TO_CNT),
-	DSI_REG(DSI1_PR_TO_CNT),
-	DSI_REG(DSI1_DISP0_CTRL),
-	DSI_REG(DSI1_DISP1_CTRL),
-	DSI_REG(DSI1_INT_STAT),
-	DSI_REG(DSI1_INT_EN),
-	DSI_REG(DSI1_PHYC),
-	DSI_REG(DSI1_HS_CLT0),
-	DSI_REG(DSI1_HS_CLT1),
-	DSI_REG(DSI1_HS_CLT2),
-	DSI_REG(DSI1_HS_DLT3),
-	DSI_REG(DSI1_HS_DLT4),
-	DSI_REG(DSI1_HS_DLT5),
-	DSI_REG(DSI1_HS_DLT6),
-	DSI_REG(DSI1_HS_DLT7),
-	DSI_REG(DSI1_PHY_AFEC0),
-	DSI_REG(DSI1_PHY_AFEC1),
-	DSI_REG(DSI1_ID),
+static const struct debugfs_reg32 dsi1_regs[] = {
+	VC4_REG32(DSI1_CTRL),
+	VC4_REG32(DSI1_STAT),
+	VC4_REG32(DSI1_HSTX_TO_CNT),
+	VC4_REG32(DSI1_LPRX_TO_CNT),
+	VC4_REG32(DSI1_TA_TO_CNT),
+	VC4_REG32(DSI1_PR_TO_CNT),
+	VC4_REG32(DSI1_DISP0_CTRL),
+	VC4_REG32(DSI1_DISP1_CTRL),
+	VC4_REG32(DSI1_INT_STAT),
+	VC4_REG32(DSI1_INT_EN),
+	VC4_REG32(DSI1_PHYC),
+	VC4_REG32(DSI1_HS_CLT0),
+	VC4_REG32(DSI1_HS_CLT1),
+	VC4_REG32(DSI1_HS_CLT2),
+	VC4_REG32(DSI1_HS_DLT3),
+	VC4_REG32(DSI1_HS_DLT4),
+	VC4_REG32(DSI1_HS_DLT5),
+	VC4_REG32(DSI1_HS_DLT6),
+	VC4_REG32(DSI1_HS_DLT7),
+	VC4_REG32(DSI1_PHY_AFEC0),
+	VC4_REG32(DSI1_PHY_AFEC1),
+	VC4_REG32(DSI1_ID),
 };
 
-static void vc4_dsi_dump_regs(struct vc4_dsi *dsi)
-{
-	int i;
-
-	if (dsi->port == 0) {
-		for (i = 0; i < ARRAY_SIZE(dsi0_regs); i++) {
-			DRM_INFO("0x%04x (%s): 0x%08x\n",
-				 dsi0_regs[i].reg, dsi0_regs[i].name,
-				 DSI_READ(dsi0_regs[i].reg));
-		}
-	} else {
-		for (i = 0; i < ARRAY_SIZE(dsi1_regs); i++) {
-			DRM_INFO("0x%04x (%s): 0x%08x\n",
-				 dsi1_regs[i].reg, dsi1_regs[i].name,
-				 DSI_READ(dsi1_regs[i].reg));
-		}
-	}
-}
-
 #ifdef CONFIG_DEBUG_FS
 int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused)
 {
@@ -689,24 +665,12 @@ int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused)
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 	int dsi_index = (uintptr_t)node->info_ent->data;
 	struct vc4_dsi *dsi = (dsi_index == 1 ? vc4->dsi1 : NULL);
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
 	if (!dsi)
 		return 0;
 
-	if (dsi->port == 0) {
-		for (i = 0; i < ARRAY_SIZE(dsi0_regs); i++) {
-			seq_printf(m, "0x%04x (%s): 0x%08x\n",
-				   dsi0_regs[i].reg, dsi0_regs[i].name,
-				   DSI_READ(dsi0_regs[i].reg));
-		}
-	} else {
-		for (i = 0; i < ARRAY_SIZE(dsi1_regs); i++) {
-			seq_printf(m, "0x%04x (%s): 0x%08x\n",
-				   dsi1_regs[i].reg, dsi1_regs[i].name,
-				   DSI_READ(dsi1_regs[i].reg));
-		}
-	}
+	drm_print_regset32(&p, &dsi->regset);
 
 	return 0;
 }
@@ -900,8 +864,9 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	}
 
 	if (debug_dump_regs) {
-		DRM_INFO("DSI regs before:\n");
-		vc4_dsi_dump_regs(dsi);
+		struct drm_printer p = drm_info_printer(&dsi->pdev->dev);
+		dev_info(&dsi->pdev->dev, "DSI regs before:\n");
+		drm_print_regset32(&p, &dsi->regset);
 	}
 
 	/* Round up the clk_set_rate() request slightly, since
@@ -1135,8 +1100,9 @@ static void vc4_dsi_encoder_enable(struct drm_encoder *encoder)
 	drm_bridge_enable(dsi->bridge);
 
 	if (debug_dump_regs) {
-		DRM_INFO("DSI regs after:\n");
-		vc4_dsi_dump_regs(dsi);
+		struct drm_printer p = drm_info_printer(&dsi->pdev->dev);
+		dev_info(&dsi->pdev->dev, "DSI regs after:\n");
+		drm_print_regset32(&p, &dsi->regset);
 	}
 }
 
@@ -1527,6 +1493,15 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(dsi->regs))
 		return PTR_ERR(dsi->regs);
 
+	dsi->regset.base = dsi->regs;
+	if (dsi->port == 0) {
+		dsi->regset.regs = dsi0_regs;
+		dsi->regset.nregs = ARRAY_SIZE(dsi0_regs);
+	} else {
+		dsi->regset.regs = dsi1_regs;
+		dsi->regset.nregs = ARRAY_SIZE(dsi1_regs);
+	}
+
 	if (DSI_PORT_READ(ID) != DSI_ID_VALUE) {
 		dev_err(dev, "Port returned 0x%08x for ID instead of 0x%08x\n",
 			DSI_PORT_READ(ID), DSI_ID_VALUE);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 88fd5df7e7dc..38c9172cfe52 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -97,6 +97,9 @@ struct vc4_hdmi {
 
 	struct clk *pixel_clock;
 	struct clk *hsm_clock;
+
+	struct debugfs_regset32 hdmi_regset;
+	struct debugfs_regset32 hd_regset;
 };
 
 #define HDMI_READ(offset) readl(vc4->hdmi->hdmicore_regs + offset)
@@ -134,61 +137,54 @@ to_vc4_hdmi_connector(struct drm_connector *connector)
 	return container_of(connector, struct vc4_hdmi_connector, base);
 }
 
-#define HDMI_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} hdmi_regs[] = {
-	HDMI_REG(VC4_HDMI_CORE_REV),
-	HDMI_REG(VC4_HDMI_SW_RESET_CONTROL),
-	HDMI_REG(VC4_HDMI_HOTPLUG_INT),
-	HDMI_REG(VC4_HDMI_HOTPLUG),
-	HDMI_REG(VC4_HDMI_MAI_CHANNEL_MAP),
-	HDMI_REG(VC4_HDMI_MAI_CONFIG),
-	HDMI_REG(VC4_HDMI_MAI_FORMAT),
-	HDMI_REG(VC4_HDMI_AUDIO_PACKET_CONFIG),
-	HDMI_REG(VC4_HDMI_RAM_PACKET_CONFIG),
-	HDMI_REG(VC4_HDMI_HORZA),
-	HDMI_REG(VC4_HDMI_HORZB),
-	HDMI_REG(VC4_HDMI_FIFO_CTL),
-	HDMI_REG(VC4_HDMI_SCHEDULER_CONTROL),
-	HDMI_REG(VC4_HDMI_VERTA0),
-	HDMI_REG(VC4_HDMI_VERTA1),
-	HDMI_REG(VC4_HDMI_VERTB0),
-	HDMI_REG(VC4_HDMI_VERTB1),
-	HDMI_REG(VC4_HDMI_TX_PHY_RESET_CTL),
-	HDMI_REG(VC4_HDMI_TX_PHY_CTL0),
-
-	HDMI_REG(VC4_HDMI_CEC_CNTRL_1),
-	HDMI_REG(VC4_HDMI_CEC_CNTRL_2),
-	HDMI_REG(VC4_HDMI_CEC_CNTRL_3),
-	HDMI_REG(VC4_HDMI_CEC_CNTRL_4),
-	HDMI_REG(VC4_HDMI_CEC_CNTRL_5),
-	HDMI_REG(VC4_HDMI_CPU_STATUS),
-	HDMI_REG(VC4_HDMI_CPU_MASK_STATUS),
-
-	HDMI_REG(VC4_HDMI_CEC_RX_DATA_1),
-	HDMI_REG(VC4_HDMI_CEC_RX_DATA_2),
-	HDMI_REG(VC4_HDMI_CEC_RX_DATA_3),
-	HDMI_REG(VC4_HDMI_CEC_RX_DATA_4),
-	HDMI_REG(VC4_HDMI_CEC_TX_DATA_1),
-	HDMI_REG(VC4_HDMI_CEC_TX_DATA_2),
-	HDMI_REG(VC4_HDMI_CEC_TX_DATA_3),
-	HDMI_REG(VC4_HDMI_CEC_TX_DATA_4),
+static const struct debugfs_reg32 hdmi_regs[] = {
+	VC4_REG32(VC4_HDMI_CORE_REV),
+	VC4_REG32(VC4_HDMI_SW_RESET_CONTROL),
+	VC4_REG32(VC4_HDMI_HOTPLUG_INT),
+	VC4_REG32(VC4_HDMI_HOTPLUG),
+	VC4_REG32(VC4_HDMI_MAI_CHANNEL_MAP),
+	VC4_REG32(VC4_HDMI_MAI_CONFIG),
+	VC4_REG32(VC4_HDMI_MAI_FORMAT),
+	VC4_REG32(VC4_HDMI_AUDIO_PACKET_CONFIG),
+	VC4_REG32(VC4_HDMI_RAM_PACKET_CONFIG),
+	VC4_REG32(VC4_HDMI_HORZA),
+	VC4_REG32(VC4_HDMI_HORZB),
+	VC4_REG32(VC4_HDMI_FIFO_CTL),
+	VC4_REG32(VC4_HDMI_SCHEDULER_CONTROL),
+	VC4_REG32(VC4_HDMI_VERTA0),
+	VC4_REG32(VC4_HDMI_VERTA1),
+	VC4_REG32(VC4_HDMI_VERTB0),
+	VC4_REG32(VC4_HDMI_VERTB1),
+	VC4_REG32(VC4_HDMI_TX_PHY_RESET_CTL),
+	VC4_REG32(VC4_HDMI_TX_PHY_CTL0),
+
+	VC4_REG32(VC4_HDMI_CEC_CNTRL_1),
+	VC4_REG32(VC4_HDMI_CEC_CNTRL_2),
+	VC4_REG32(VC4_HDMI_CEC_CNTRL_3),
+	VC4_REG32(VC4_HDMI_CEC_CNTRL_4),
+	VC4_REG32(VC4_HDMI_CEC_CNTRL_5),
+	VC4_REG32(VC4_HDMI_CPU_STATUS),
+	VC4_REG32(VC4_HDMI_CPU_MASK_STATUS),
+
+	VC4_REG32(VC4_HDMI_CEC_RX_DATA_1),
+	VC4_REG32(VC4_HDMI_CEC_RX_DATA_2),
+	VC4_REG32(VC4_HDMI_CEC_RX_DATA_3),
+	VC4_REG32(VC4_HDMI_CEC_RX_DATA_4),
+	VC4_REG32(VC4_HDMI_CEC_TX_DATA_1),
+	VC4_REG32(VC4_HDMI_CEC_TX_DATA_2),
+	VC4_REG32(VC4_HDMI_CEC_TX_DATA_3),
+	VC4_REG32(VC4_HDMI_CEC_TX_DATA_4),
 };
 
-static const struct {
-	u32 reg;
-	const char *name;
-} hd_regs[] = {
-	HDMI_REG(VC4_HD_M_CTL),
-	HDMI_REG(VC4_HD_MAI_CTL),
-	HDMI_REG(VC4_HD_MAI_THR),
-	HDMI_REG(VC4_HD_MAI_FMT),
-	HDMI_REG(VC4_HD_MAI_SMP),
-	HDMI_REG(VC4_HD_VID_CTL),
-	HDMI_REG(VC4_HD_CSC_CTL),
-	HDMI_REG(VC4_HD_FRAME_COUNT),
+static const struct debugfs_reg32 hd_regs[] = {
+	VC4_REG32(VC4_HD_M_CTL),
+	VC4_REG32(VC4_HD_MAI_CTL),
+	VC4_REG32(VC4_HD_MAI_THR),
+	VC4_REG32(VC4_HD_MAI_FMT),
+	VC4_REG32(VC4_HD_MAI_SMP),
+	VC4_REG32(VC4_HD_VID_CTL),
+	VC4_REG32(VC4_HD_CSC_CTL),
+	VC4_REG32(VC4_HD_FRAME_COUNT),
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -197,41 +193,16 @@ int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hdmi_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   hdmi_regs[i].name, hdmi_regs[i].reg,
-			   HDMI_READ(hdmi_regs[i].reg));
-	}
+	struct vc4_hdmi *hdmi = vc4->hdmi;
+	struct drm_printer p = drm_seq_file_printer(m);
 
-	for (i = 0; i < ARRAY_SIZE(hd_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   hd_regs[i].name, hd_regs[i].reg,
-			   HD_READ(hd_regs[i].reg));
-	}
+	drm_print_regset32(&p, &hdmi->hdmi_regset);
+	drm_print_regset32(&p, &hdmi->hd_regset);
 
 	return 0;
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static void vc4_hdmi_dump_regs(struct drm_device *dev)
-{
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hdmi_regs); i++) {
-		DRM_INFO("0x%04x (%s): 0x%08x\n",
-			 hdmi_regs[i].reg, hdmi_regs[i].name,
-			 HDMI_READ(hdmi_regs[i].reg));
-	}
-	for (i = 0; i < ARRAY_SIZE(hd_regs); i++) {
-		DRM_INFO("0x%04x (%s): 0x%08x\n",
-			 hd_regs[i].reg, hd_regs[i].name,
-			 HD_READ(hd_regs[i].reg));
-	}
-}
-
 static enum drm_connector_status
 vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
@@ -561,8 +532,11 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	HDMI_WRITE(VC4_HDMI_TX_PHY_RESET_CTL, 0);
 
 	if (debug_dump_regs) {
-		DRM_INFO("HDMI regs before:\n");
-		vc4_hdmi_dump_regs(dev);
+		struct drm_printer p = drm_info_printer(&hdmi->pdev->dev);
+
+		dev_info(&hdmi->pdev->dev, "HDMI regs before:\n");
+		drm_print_regset32(&p, &hdmi->hdmi_regset);
+		drm_print_regset32(&p, &hdmi->hd_regset);
 	}
 
 	HD_WRITE(VC4_HD_VID_CTL, 0);
@@ -637,8 +611,11 @@ static void vc4_hdmi_encoder_enable(struct drm_encoder *encoder)
 	HDMI_WRITE(VC4_HDMI_FIFO_CTL, VC4_HDMI_FIFO_CTL_MASTER_SLAVE_N);
 
 	if (debug_dump_regs) {
-		DRM_INFO("HDMI regs after:\n");
-		vc4_hdmi_dump_regs(dev);
+		struct drm_printer p = drm_info_printer(&hdmi->pdev->dev);
+
+		dev_info(&hdmi->pdev->dev, "HDMI regs after:\n");
+		drm_print_regset32(&p, &hdmi->hdmi_regset);
+		drm_print_regset32(&p, &hdmi->hd_regset);
 	}
 
 	HD_WRITE(VC4_HD_VID_CTL,
@@ -1333,6 +1310,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(hdmi->hd_regs))
 		return PTR_ERR(hdmi->hd_regs);
 
+	hdmi->hdmi_regset.base = hdmi->hdmicore_regs;
+	hdmi->hdmi_regset.regs = hdmi_regs;
+	hdmi->hdmi_regset.nregs = ARRAY_SIZE(hdmi_regs);
+	hdmi->hd_regset.base = hdmi->hd_regs;
+	hdmi->hd_regset.regs = hd_regs;
+	hdmi->hd_regset.nregs = ARRAY_SIZE(hd_regs);
+
 	hdmi->pixel_clock = devm_clk_get(dev, "pixel");
 	if (IS_ERR(hdmi->pixel_clock)) {
 		DRM_ERROR("Failed to get pixel clock\n");
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 5d8c749c9749..45405f76cd40 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -26,54 +26,47 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-#define HVS_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} hvs_regs[] = {
-	HVS_REG(SCALER_DISPCTRL),
-	HVS_REG(SCALER_DISPSTAT),
-	HVS_REG(SCALER_DISPID),
-	HVS_REG(SCALER_DISPECTRL),
-	HVS_REG(SCALER_DISPPROF),
-	HVS_REG(SCALER_DISPDITHER),
-	HVS_REG(SCALER_DISPEOLN),
-	HVS_REG(SCALER_DISPLIST0),
-	HVS_REG(SCALER_DISPLIST1),
-	HVS_REG(SCALER_DISPLIST2),
-	HVS_REG(SCALER_DISPLSTAT),
-	HVS_REG(SCALER_DISPLACT0),
-	HVS_REG(SCALER_DISPLACT1),
-	HVS_REG(SCALER_DISPLACT2),
-	HVS_REG(SCALER_DISPCTRL0),
-	HVS_REG(SCALER_DISPBKGND0),
-	HVS_REG(SCALER_DISPSTAT0),
-	HVS_REG(SCALER_DISPBASE0),
-	HVS_REG(SCALER_DISPCTRL1),
-	HVS_REG(SCALER_DISPBKGND1),
-	HVS_REG(SCALER_DISPSTAT1),
-	HVS_REG(SCALER_DISPBASE1),
-	HVS_REG(SCALER_DISPCTRL2),
-	HVS_REG(SCALER_DISPBKGND2),
-	HVS_REG(SCALER_DISPSTAT2),
-	HVS_REG(SCALER_DISPBASE2),
-	HVS_REG(SCALER_DISPALPHA2),
-	HVS_REG(SCALER_OLEDOFFS),
-	HVS_REG(SCALER_OLEDCOEF0),
-	HVS_REG(SCALER_OLEDCOEF1),
-	HVS_REG(SCALER_OLEDCOEF2),
+static const struct debugfs_reg32 hvs_regs[] = {
+	VC4_REG32(SCALER_DISPCTRL),
+	VC4_REG32(SCALER_DISPSTAT),
+	VC4_REG32(SCALER_DISPID),
+	VC4_REG32(SCALER_DISPECTRL),
+	VC4_REG32(SCALER_DISPPROF),
+	VC4_REG32(SCALER_DISPDITHER),
+	VC4_REG32(SCALER_DISPEOLN),
+	VC4_REG32(SCALER_DISPLIST0),
+	VC4_REG32(SCALER_DISPLIST1),
+	VC4_REG32(SCALER_DISPLIST2),
+	VC4_REG32(SCALER_DISPLSTAT),
+	VC4_REG32(SCALER_DISPLACT0),
+	VC4_REG32(SCALER_DISPLACT1),
+	VC4_REG32(SCALER_DISPLACT2),
+	VC4_REG32(SCALER_DISPCTRL0),
+	VC4_REG32(SCALER_DISPBKGND0),
+	VC4_REG32(SCALER_DISPSTAT0),
+	VC4_REG32(SCALER_DISPBASE0),
+	VC4_REG32(SCALER_DISPCTRL1),
+	VC4_REG32(SCALER_DISPBKGND1),
+	VC4_REG32(SCALER_DISPSTAT1),
+	VC4_REG32(SCALER_DISPBASE1),
+	VC4_REG32(SCALER_DISPCTRL2),
+	VC4_REG32(SCALER_DISPBKGND2),
+	VC4_REG32(SCALER_DISPSTAT2),
+	VC4_REG32(SCALER_DISPBASE2),
+	VC4_REG32(SCALER_DISPALPHA2),
+	VC4_REG32(SCALER_OLEDOFFS),
+	VC4_REG32(SCALER_OLEDCOEF0),
+	VC4_REG32(SCALER_OLEDCOEF1),
+	VC4_REG32(SCALER_OLEDCOEF2),
 };
 
 void vc4_hvs_dump_state(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct drm_printer p = drm_info_printer(&vc4->hvs->pdev->dev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(hvs_regs); i++) {
-		DRM_INFO("0x%04x (%s): 0x%08x\n",
-			 hvs_regs[i].reg, hvs_regs[i].name,
-			 HVS_READ(hvs_regs[i].reg));
-	}
+	drm_print_regset32(&p, &vc4->hvs->regset);
 
 	DRM_INFO("HVS ctx:\n");
 	for (i = 0; i < 64; i += 4) {
@@ -92,13 +85,9 @@ int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
-	for (i = 0; i < ARRAY_SIZE(hvs_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   hvs_regs[i].name, hvs_regs[i].reg,
-			   HVS_READ(hvs_regs[i].reg));
-	}
+	drm_print_regset32(&p, &vc4->hvs->regset);
 
 	return 0;
 }
@@ -185,6 +174,10 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	if (IS_ERR(hvs->regs))
 		return PTR_ERR(hvs->regs);
 
+	hvs->regset.base = hvs->regs;
+	hvs->regset.regs = hvs_regs;
+	hvs->regset.nregs = ARRAY_SIZE(hvs_regs);
+
 	hvs->dlist = hvs->regs + SCALER_DLIST_START;
 
 	spin_lock_init(&hvs->mm_lock);
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index afb1c4ec4f18..c8f80064c179 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -148,6 +148,7 @@ struct vc4_txp {
 	struct drm_writeback_connector connector;
 
 	void __iomem *regs;
+	struct debugfs_regset32 regset;
 };
 
 static inline struct vc4_txp *encoder_to_vc4_txp(struct drm_encoder *encoder)
@@ -160,16 +161,12 @@ static inline struct vc4_txp *connector_to_vc4_txp(struct drm_connector *conn)
 	return container_of(conn, struct vc4_txp, connector.base);
 }
 
-#define TXP_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} txp_regs[] = {
-	TXP_REG(TXP_DST_PTR),
-	TXP_REG(TXP_DST_PITCH),
-	TXP_REG(TXP_DIM),
-	TXP_REG(TXP_DST_CTRL),
-	TXP_REG(TXP_PROGRESS),
+static const struct debugfs_reg32 txp_regs[] = {
+	VC4_REG32(TXP_DST_PTR),
+	VC4_REG32(TXP_DST_PITCH),
+	VC4_REG32(TXP_DIM),
+	VC4_REG32(TXP_DST_CTRL),
+	VC4_REG32(TXP_PROGRESS),
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -179,16 +176,12 @@ int vc4_txp_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_txp *txp = vc4->txp;
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
 	if (!txp)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(txp_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   txp_regs[i].name, txp_regs[i].reg,
-			   TXP_READ(txp_regs[i].reg));
-	}
+	drm_print_regset32(&p, &txp->regset);
 
 	return 0;
 }
@@ -410,6 +403,9 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	txp->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(txp->regs))
 		return PTR_ERR(txp->regs);
+	txp->regset.base = txp->regs;
+	txp->regset.regs = txp_regs;
+	txp->regset.nregs = ARRAY_SIZE(txp_regs);
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index e47e29426078..e1e728e95562 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -23,89 +23,85 @@
 #include "vc4_regs.h"
 
 #ifdef CONFIG_DEBUG_FS
-#define REGDEF(reg) { reg, #reg }
-static const struct {
-	uint32_t reg;
-	const char *name;
-} vc4_reg_defs[] = {
-	REGDEF(V3D_IDENT0),
-	REGDEF(V3D_IDENT1),
-	REGDEF(V3D_IDENT2),
-	REGDEF(V3D_SCRATCH),
-	REGDEF(V3D_L2CACTL),
-	REGDEF(V3D_SLCACTL),
-	REGDEF(V3D_INTCTL),
-	REGDEF(V3D_INTENA),
-	REGDEF(V3D_INTDIS),
-	REGDEF(V3D_CT0CS),
-	REGDEF(V3D_CT1CS),
-	REGDEF(V3D_CT0EA),
-	REGDEF(V3D_CT1EA),
-	REGDEF(V3D_CT0CA),
-	REGDEF(V3D_CT1CA),
-	REGDEF(V3D_CT00RA0),
-	REGDEF(V3D_CT01RA0),
-	REGDEF(V3D_CT0LC),
-	REGDEF(V3D_CT1LC),
-	REGDEF(V3D_CT0PC),
-	REGDEF(V3D_CT1PC),
-	REGDEF(V3D_PCS),
-	REGDEF(V3D_BFC),
-	REGDEF(V3D_RFC),
-	REGDEF(V3D_BPCA),
-	REGDEF(V3D_BPCS),
-	REGDEF(V3D_BPOA),
-	REGDEF(V3D_BPOS),
-	REGDEF(V3D_BXCF),
-	REGDEF(V3D_SQRSV0),
-	REGDEF(V3D_SQRSV1),
-	REGDEF(V3D_SQCNTL),
-	REGDEF(V3D_SRQPC),
-	REGDEF(V3D_SRQUA),
-	REGDEF(V3D_SRQUL),
-	REGDEF(V3D_SRQCS),
-	REGDEF(V3D_VPACNTL),
-	REGDEF(V3D_VPMBASE),
-	REGDEF(V3D_PCTRC),
-	REGDEF(V3D_PCTRE),
-	REGDEF(V3D_PCTR(0)),
-	REGDEF(V3D_PCTRS(0)),
-	REGDEF(V3D_PCTR(1)),
-	REGDEF(V3D_PCTRS(1)),
-	REGDEF(V3D_PCTR(2)),
-	REGDEF(V3D_PCTRS(2)),
-	REGDEF(V3D_PCTR(3)),
-	REGDEF(V3D_PCTRS(3)),
-	REGDEF(V3D_PCTR(4)),
-	REGDEF(V3D_PCTRS(4)),
-	REGDEF(V3D_PCTR(5)),
-	REGDEF(V3D_PCTRS(5)),
-	REGDEF(V3D_PCTR(6)),
-	REGDEF(V3D_PCTRS(6)),
-	REGDEF(V3D_PCTR(7)),
-	REGDEF(V3D_PCTRS(7)),
-	REGDEF(V3D_PCTR(8)),
-	REGDEF(V3D_PCTRS(8)),
-	REGDEF(V3D_PCTR(9)),
-	REGDEF(V3D_PCTRS(9)),
-	REGDEF(V3D_PCTR(10)),
-	REGDEF(V3D_PCTRS(10)),
-	REGDEF(V3D_PCTR(11)),
-	REGDEF(V3D_PCTRS(11)),
-	REGDEF(V3D_PCTR(12)),
-	REGDEF(V3D_PCTRS(12)),
-	REGDEF(V3D_PCTR(13)),
-	REGDEF(V3D_PCTRS(13)),
-	REGDEF(V3D_PCTR(14)),
-	REGDEF(V3D_PCTRS(14)),
-	REGDEF(V3D_PCTR(15)),
-	REGDEF(V3D_PCTRS(15)),
-	REGDEF(V3D_DBGE),
-	REGDEF(V3D_FDBGO),
-	REGDEF(V3D_FDBGB),
-	REGDEF(V3D_FDBGR),
-	REGDEF(V3D_FDBGS),
-	REGDEF(V3D_ERRSTAT),
+static const struct debugfs_reg32 v3d_regs[] = {
+	VC4_REG32(V3D_IDENT0),
+	VC4_REG32(V3D_IDENT1),
+	VC4_REG32(V3D_IDENT2),
+	VC4_REG32(V3D_SCRATCH),
+	VC4_REG32(V3D_L2CACTL),
+	VC4_REG32(V3D_SLCACTL),
+	VC4_REG32(V3D_INTCTL),
+	VC4_REG32(V3D_INTENA),
+	VC4_REG32(V3D_INTDIS),
+	VC4_REG32(V3D_CT0CS),
+	VC4_REG32(V3D_CT1CS),
+	VC4_REG32(V3D_CT0EA),
+	VC4_REG32(V3D_CT1EA),
+	VC4_REG32(V3D_CT0CA),
+	VC4_REG32(V3D_CT1CA),
+	VC4_REG32(V3D_CT00RA0),
+	VC4_REG32(V3D_CT01RA0),
+	VC4_REG32(V3D_CT0LC),
+	VC4_REG32(V3D_CT1LC),
+	VC4_REG32(V3D_CT0PC),
+	VC4_REG32(V3D_CT1PC),
+	VC4_REG32(V3D_PCS),
+	VC4_REG32(V3D_BFC),
+	VC4_REG32(V3D_RFC),
+	VC4_REG32(V3D_BPCA),
+	VC4_REG32(V3D_BPCS),
+	VC4_REG32(V3D_BPOA),
+	VC4_REG32(V3D_BPOS),
+	VC4_REG32(V3D_BXCF),
+	VC4_REG32(V3D_SQRSV0),
+	VC4_REG32(V3D_SQRSV1),
+	VC4_REG32(V3D_SQCNTL),
+	VC4_REG32(V3D_SRQPC),
+	VC4_REG32(V3D_SRQUA),
+	VC4_REG32(V3D_SRQUL),
+	VC4_REG32(V3D_SRQCS),
+	VC4_REG32(V3D_VPACNTL),
+	VC4_REG32(V3D_VPMBASE),
+	VC4_REG32(V3D_PCTRC),
+	VC4_REG32(V3D_PCTRE),
+	VC4_REG32(V3D_PCTR(0)),
+	VC4_REG32(V3D_PCTRS(0)),
+	VC4_REG32(V3D_PCTR(1)),
+	VC4_REG32(V3D_PCTRS(1)),
+	VC4_REG32(V3D_PCTR(2)),
+	VC4_REG32(V3D_PCTRS(2)),
+	VC4_REG32(V3D_PCTR(3)),
+	VC4_REG32(V3D_PCTRS(3)),
+	VC4_REG32(V3D_PCTR(4)),
+	VC4_REG32(V3D_PCTRS(4)),
+	VC4_REG32(V3D_PCTR(5)),
+	VC4_REG32(V3D_PCTRS(5)),
+	VC4_REG32(V3D_PCTR(6)),
+	VC4_REG32(V3D_PCTRS(6)),
+	VC4_REG32(V3D_PCTR(7)),
+	VC4_REG32(V3D_PCTRS(7)),
+	VC4_REG32(V3D_PCTR(8)),
+	VC4_REG32(V3D_PCTRS(8)),
+	VC4_REG32(V3D_PCTR(9)),
+	VC4_REG32(V3D_PCTRS(9)),
+	VC4_REG32(V3D_PCTR(10)),
+	VC4_REG32(V3D_PCTRS(10)),
+	VC4_REG32(V3D_PCTR(11)),
+	VC4_REG32(V3D_PCTRS(11)),
+	VC4_REG32(V3D_PCTR(12)),
+	VC4_REG32(V3D_PCTRS(12)),
+	VC4_REG32(V3D_PCTR(13)),
+	VC4_REG32(V3D_PCTRS(13)),
+	VC4_REG32(V3D_PCTR(14)),
+	VC4_REG32(V3D_PCTRS(14)),
+	VC4_REG32(V3D_PCTR(15)),
+	VC4_REG32(V3D_PCTRS(15)),
+	VC4_REG32(V3D_DBGE),
+	VC4_REG32(V3D_FDBGO),
+	VC4_REG32(V3D_FDBGB),
+	VC4_REG32(V3D_FDBGR),
+	VC4_REG32(V3D_FDBGS),
+	VC4_REG32(V3D_ERRSTAT),
 };
 
 int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused)
@@ -113,13 +109,9 @@ int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
-	for (i = 0; i < ARRAY_SIZE(vc4_reg_defs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   vc4_reg_defs[i].name, vc4_reg_defs[i].reg,
-			   V3D_READ(vc4_reg_defs[i].reg));
-	}
+	drm_print_regset32(&p, &vc4->v3d->regset);
 
 	return 0;
 }
@@ -354,6 +346,9 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	v3d->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(v3d->regs))
 		return PTR_ERR(v3d->regs);
+	v3d->regset.base = v3d->regs;
+	v3d->regset.regs = v3d_regs;
+	v3d->regset.nregs = ARRAY_SIZE(v3d_regs);
 
 	vc4->v3d = v3d;
 	v3d->vc4 = vc4;
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 858c3a483229..83227d2440aa 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -176,6 +176,8 @@ struct vc4_vec {
 	struct clk *clock;
 
 	const struct vc4_vec_tv_mode *tv_mode;
+
+	struct debugfs_regset32 regset;
 };
 
 #define VEC_READ(offset) readl(vec->regs + (offset))
@@ -223,35 +225,31 @@ struct vc4_vec_tv_mode {
 	void (*mode_set)(struct vc4_vec *vec);
 };
 
-#define VEC_REG(reg) { reg, #reg }
-static const struct {
-	u32 reg;
-	const char *name;
-} vec_regs[] = {
-	VEC_REG(VEC_WSE_CONTROL),
-	VEC_REG(VEC_WSE_WSS_DATA),
-	VEC_REG(VEC_WSE_VPS_DATA1),
-	VEC_REG(VEC_WSE_VPS_CONTROL),
-	VEC_REG(VEC_REVID),
-	VEC_REG(VEC_CONFIG0),
-	VEC_REG(VEC_SCHPH),
-	VEC_REG(VEC_CLMP0_START),
-	VEC_REG(VEC_CLMP0_END),
-	VEC_REG(VEC_FREQ3_2),
-	VEC_REG(VEC_FREQ1_0),
-	VEC_REG(VEC_CONFIG1),
-	VEC_REG(VEC_CONFIG2),
-	VEC_REG(VEC_INTERRUPT_CONTROL),
-	VEC_REG(VEC_INTERRUPT_STATUS),
-	VEC_REG(VEC_FCW_SECAM_B),
-	VEC_REG(VEC_SECAM_GAIN_VAL),
-	VEC_REG(VEC_CONFIG3),
-	VEC_REG(VEC_STATUS0),
-	VEC_REG(VEC_MASK0),
-	VEC_REG(VEC_CFG),
-	VEC_REG(VEC_DAC_TEST),
-	VEC_REG(VEC_DAC_CONFIG),
-	VEC_REG(VEC_DAC_MISC),
+static const struct debugfs_reg32 vec_regs[] = {
+	VC4_REG32(VEC_WSE_CONTROL),
+	VC4_REG32(VEC_WSE_WSS_DATA),
+	VC4_REG32(VEC_WSE_VPS_DATA1),
+	VC4_REG32(VEC_WSE_VPS_CONTROL),
+	VC4_REG32(VEC_REVID),
+	VC4_REG32(VEC_CONFIG0),
+	VC4_REG32(VEC_SCHPH),
+	VC4_REG32(VEC_CLMP0_START),
+	VC4_REG32(VEC_CLMP0_END),
+	VC4_REG32(VEC_FREQ3_2),
+	VC4_REG32(VEC_FREQ1_0),
+	VC4_REG32(VEC_CONFIG1),
+	VC4_REG32(VEC_CONFIG2),
+	VC4_REG32(VEC_INTERRUPT_CONTROL),
+	VC4_REG32(VEC_INTERRUPT_STATUS),
+	VC4_REG32(VEC_FCW_SECAM_B),
+	VC4_REG32(VEC_SECAM_GAIN_VAL),
+	VC4_REG32(VEC_CONFIG3),
+	VC4_REG32(VEC_STATUS0),
+	VC4_REG32(VEC_MASK0),
+	VC4_REG32(VEC_CFG),
+	VC4_REG32(VEC_DAC_TEST),
+	VC4_REG32(VEC_DAC_CONFIG),
+	VC4_REG32(VEC_DAC_MISC),
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -261,16 +259,12 @@ int vc4_vec_debugfs_regs(struct seq_file *m, void *unused)
 	struct drm_device *dev = node->minor->dev;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_vec *vec = vc4->vec;
-	int i;
+	struct drm_printer p = drm_seq_file_printer(m);
 
 	if (!vec)
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(vec_regs); i++) {
-		seq_printf(m, "%s (0x%04x): 0x%08x\n",
-			   vec_regs[i].name, vec_regs[i].reg,
-			   VEC_READ(vec_regs[i].reg));
-	}
+	drm_print_regset32(&p, &vec->regset);
 
 	return 0;
 }
@@ -587,6 +581,9 @@ static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
 	vec->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(vec->regs))
 		return PTR_ERR(vec->regs);
+	vec->regset.base = vec->regs;
+	vec->regset.regs = vec_regs;
+	vec->regset.nregs = ARRAY_SIZE(vec_regs);
 
 	vec->clock = devm_clk_get(dev, NULL);
 	if (IS_ERR(vec->clock)) {
-- 
2.20.1

