Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D092C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7F92147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBTVEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 16:04:02 -0500
Received: from anholt.net ([50.246.234.109]:51870 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfBTVD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 16:03:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CE73C10A2D20;
        Wed, 20 Feb 2019 13:03:58 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id lu3e-IF6Qxx6; Wed, 20 Feb 2019 13:03:50 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EDF7910A2D21;
        Wed, 20 Feb 2019 13:03:44 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9B0CA2FE464E; Wed, 20 Feb 2019 13:03:43 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 3/7] drm/vc4: Use common helpers for debugfs setup by the driver components.
Date:   Wed, 20 Feb 2019 13:03:39 -0800
Message-Id: <20190220210343.28157-3-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220210343.28157-1-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global list of all debugfs entries for the driver was painful: the
list couldn't see into the components' structs, so each component had
its own debugs show function to find the component, then find the
regset and dump it.  The components also had to be careful to check
that they were actually registered in vc4 before dereferencing
themselves, in case they weren't probed on a particular platform.
They routinely failed at that.

Instead, we can have the components add their debugfs callbacks to a
little list in vc4 to be registered at drm_dev_register() time, which
gets vc4_debugfs.c out of the business of knowing the whole list of
components.

Thanks to this change, dsi0 (if it existed) would register its node.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_bo.c      |  6 +--
 drivers/gpu/drm/vc4/vc4_crtc.c    | 33 +++---------
 drivers/gpu/drm/vc4/vc4_debugfs.c | 84 ++++++++++++++++++++++++-------
 drivers/gpu/drm/vc4/vc4_dpi.c     | 20 +-------
 drivers/gpu/drm/vc4/vc4_drv.c     |  1 +
 drivers/gpu/drm/vc4/vc4_drv.h     | 38 ++++++++++----
 drivers/gpu/drm/vc4/vc4_dsi.c     | 24 ++-------
 drivers/gpu/drm/vc4/vc4_hdmi.c    |  6 +--
 drivers/gpu/drm/vc4/vc4_hvs.c     | 16 +-----
 drivers/gpu/drm/vc4/vc4_txp.c     | 20 +-------
 drivers/gpu/drm/vc4/vc4_v3d.c     | 19 ++-----
 drivers/gpu/drm/vc4/vc4_vec.c     | 20 +-------
 12 files changed, 125 insertions(+), 162 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 92e3f98d8478..8c509d560bf0 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -66,8 +66,7 @@ static void vc4_bo_stats_dump(struct vc4_dev *vc4)
 	mutex_unlock(&vc4->purgeable.lock);
 }
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
+static int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
@@ -99,7 +98,6 @@ int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
 
 	return 0;
 }
-#endif
 
 /* Takes ownership of *name and returns the appropriate slot for it in
  * the bo_labels[] array, extending it as necessary.
@@ -1025,6 +1023,8 @@ int vc4_bo_cache_init(struct drm_device *dev)
 
 	mutex_init(&vc4->bo_lock);
 
+	vc4_debugfs_add_file(dev, "bo_stats", vc4_bo_stats_debugfs, NULL);
+
 	INIT_LIST_HEAD(&vc4->bo_cache.time_list);
 
 	INIT_WORK(&vc4->bo_cache.time_work, vc4_bo_cache_time_work);
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 6d7072026056..9a62f12aca54 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -84,33 +84,6 @@ static const struct debugfs_reg32 crtc_regs[] = {
 	VC4_REG32(PV_HACT_ACT),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_crtc_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	int crtc_index = (uintptr_t)node->info_ent->data;
-	struct drm_printer p = drm_seq_file_printer(m);
-	struct drm_crtc *crtc;
-	struct vc4_crtc *vc4_crtc;
-	int i;
-
-	i = 0;
-	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-		if (i == crtc_index)
-			break;
-		i++;
-	}
-	if (!crtc)
-		return 0;
-	vc4_crtc = to_vc4_crtc(crtc);
-
-	drm_print_regset32(&p, &vc4_crtc->regset);
-
-	return 0;
-}
-#endif
-
 bool vc4_crtc_get_scanoutpos(struct drm_device *dev, unsigned int crtc_id,
 			     bool in_vblank_irq, int *vpos, int *hpos,
 			     ktime_t *stime, ktime_t *etime,
@@ -1062,6 +1035,7 @@ static const struct drm_crtc_helper_funcs vc4_crtc_helper_funcs = {
 
 static const struct vc4_crtc_data pv0_data = {
 	.hvs_channel = 0,
+	.debugfs_name = "crtc0_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI0,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_DPI,
@@ -1070,6 +1044,7 @@ static const struct vc4_crtc_data pv0_data = {
 
 static const struct vc4_crtc_data pv1_data = {
 	.hvs_channel = 2,
+	.debugfs_name = "crtc1_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DSI] = VC4_ENCODER_TYPE_DSI1,
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_SMI,
@@ -1078,6 +1053,7 @@ static const struct vc4_crtc_data pv1_data = {
 
 static const struct vc4_crtc_data pv2_data = {
 	.hvs_channel = 1,
+	.debugfs_name = "crtc2_regs",
 	.encoder_types = {
 		[PV_CONTROL_CLK_SELECT_DPI_SMI_HDMI] = VC4_ENCODER_TYPE_HDMI,
 		[PV_CONTROL_CLK_SELECT_VEC] = VC4_ENCODER_TYPE_VEC,
@@ -1239,6 +1215,9 @@ static int vc4_crtc_bind(struct device *dev, struct device *master, void *data)
 
 	platform_set_drvdata(pdev, vc4_crtc);
 
+	vc4_debugfs_add_regset32(drm, vc4_crtc->data->debugfs_name,
+				 &vc4_crtc->regset);
+
 	return 0;
 
 err_destroy_planes:
diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 7a0003de71ab..ead7271b4363 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -15,26 +15,76 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-static const struct drm_info_list vc4_debugfs_list[] = {
-	{"bo_stats", vc4_bo_stats_debugfs, 0},
-	{"dpi_regs", vc4_dpi_debugfs_regs, 0},
-	{"dsi1_regs", vc4_dsi_debugfs_regs, 0, (void *)(uintptr_t)1},
-	{"hdmi_regs", vc4_hdmi_debugfs_regs, 0},
-	{"vec_regs", vc4_vec_debugfs_regs, 0},
-	{"txp_regs", vc4_txp_debugfs_regs, 0},
-	{"hvs_regs", vc4_hvs_debugfs_regs, 0},
-	{"crtc0_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)0},
-	{"crtc1_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)1},
-	{"crtc2_regs", vc4_crtc_debugfs_regs, 0, (void *)(uintptr_t)2},
-	{"v3d_ident", vc4_v3d_debugfs_ident, 0},
-	{"v3d_regs", vc4_v3d_debugfs_regs, 0},
+struct vc4_debugfs_info_entry {
+	struct list_head link;
+	struct drm_info_list info;
 };
 
-#define VC4_DEBUGFS_ENTRIES ARRAY_SIZE(vc4_debugfs_list)
-
+/**
+ * Called at drm_dev_register() time on each of the minors registered
+ * by the DRM device, to attach the debugfs files.
+ */
 int
 vc4_debugfs_init(struct drm_minor *minor)
 {
-	return drm_debugfs_create_files(vc4_debugfs_list, VC4_DEBUGFS_ENTRIES,
-					minor->debugfs_root, minor);
+	struct drm_device *dev = minor->dev;
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct vc4_debugfs_info_entry *entry;
+
+	list_for_each_entry(entry, &vc4->debugfs_list, link) {
+		int ret = drm_debugfs_create_files(&entry->info, 1,
+						   minor->debugfs_root, minor);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int vc4_debugfs_regset32(struct seq_file *m, void *unused)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct debugfs_regset32 *regset = node->info_ent->data;
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	drm_print_regset32(&p, regset);
+
+	return 0;
+}
+
+/**
+ * Registers a debugfs file with a callback function for a vc4 component.
+ *
+ * This is like drm_debugfs_create_files(), but that can only be
+ * called a given DRM minor, while the various VC4 components want to
+ * register their debugfs files during the component bind process.  We
+ * track the request and delay it to be called on each minor during
+ * vc4_debugfs_init().
+ */
+void vc4_debugfs_add_file(struct drm_device *dev,
+			  const char *name,
+			  int (*show)(struct seq_file*, void*),
+			  void *data)
+{
+	struct vc4_dev *vc4 = to_vc4_dev(dev);
+
+	struct vc4_debugfs_info_entry *entry =
+		devm_kzalloc(dev->dev, sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return;
+
+	entry->info.name = name;
+	entry->info.show = show;
+	entry->info.data = data;
+
+	list_add(&entry->link, &vc4->debugfs_list);
+}
+
+void vc4_debugfs_add_regset32(struct drm_device *drm,
+			      const char *name,
+			      struct debugfs_regset32 *regset)
+{
+	vc4_debugfs_add_file(drm, name, vc4_debugfs_regset32, regset);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 8be2264f496a..34f90ca8f479 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -125,24 +125,6 @@ static const struct debugfs_reg32 dpi_regs[] = {
 	VC4_REG32(DPI_ID),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_dpi *dpi = vc4->dpi;
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	if (!dpi)
-		return 0;
-
-	drm_print_regset32(&p, &dpi->regset);
-
-	return 0;
-}
-#endif
-
 static const struct drm_encoder_funcs vc4_dpi_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -349,6 +331,8 @@ static int vc4_dpi_bind(struct device *dev, struct device *master, void *data)
 
 	vc4->dpi = dpi;
 
+	vc4_debugfs_add_regset32(drm, "dpi_regs", &dpi->regset);
+
 	return 0;
 
 err_destroy_encoder:
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 52576dee809e..1927d1b756f5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -265,6 +265,7 @@ static int vc4_drm_bind(struct device *dev)
 	platform_set_drvdata(pdev, drm);
 	vc4->dev = drm;
 	drm->dev_private = vc4;
+	INIT_LIST_HEAD(&vc4->debugfs_list);
 
 	ret = vc4_bo_cache_init(drm);
 	if (ret)
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 511ad884d9c3..495c5a13a948 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -200,6 +200,11 @@ struct vc4_dev {
 
 	struct drm_modeset_lock ctm_state_lock;
 	struct drm_private_obj ctm_manager;
+
+	/* List of vc4_debugfs_info_entry for adding to debugfs once
+	 * the minor is available (after drm_dev_register()).
+	 */
+	struct list_head debugfs_list;
 };
 
 static inline struct vc4_dev *
@@ -408,6 +413,7 @@ struct vc4_crtc_data {
 	int hvs_channel;
 
 	enum vc4_encoder_type encoder_types[4];
+	const char *debugfs_name;
 };
 
 struct vc4_crtc {
@@ -694,7 +700,6 @@ struct drm_gem_object *vc4_prime_import_sg_table(struct drm_device *dev,
 void *vc4_prime_vmap(struct drm_gem_object *obj);
 int vc4_bo_cache_init(struct drm_device *dev);
 void vc4_bo_cache_destroy(struct drm_device *dev);
-int vc4_bo_stats_debugfs(struct seq_file *m, void *arg);
 int vc4_bo_inc_usecnt(struct vc4_bo *bo);
 void vc4_bo_dec_usecnt(struct vc4_bo *bo);
 void vc4_bo_add_to_purgeable_pool(struct vc4_bo *bo);
@@ -702,7 +707,6 @@ void vc4_bo_remove_from_purgeable_pool(struct vc4_bo *bo);
 
 /* vc4_crtc.c */
 extern struct platform_driver vc4_crtc_driver;
-int vc4_crtc_debugfs_regs(struct seq_file *m, void *arg);
 bool vc4_crtc_get_scanoutpos(struct drm_device *dev, unsigned int crtc_id,
 			     bool in_vblank_irq, int *vpos, int *hpos,
 			     ktime_t *stime, ktime_t *etime,
@@ -715,17 +719,37 @@ void vc4_crtc_get_margins(struct drm_crtc_state *state,
 
 /* vc4_debugfs.c */
 int vc4_debugfs_init(struct drm_minor *minor);
+#ifdef CONFIG_DEBUG_FS
+void vc4_debugfs_add_file(struct drm_device *drm,
+			  const char *filename,
+			  int (*show)(struct seq_file*, void*),
+			  void *data);
+void vc4_debugfs_add_regset32(struct drm_device *drm,
+			      const char *filename,
+			      struct debugfs_regset32 *regset);
+#else
+static inline void vc4_debugfs_add_file(struct drm_device *drm,
+					const char *filename,
+					int (*show)(struct seq_file*, void*),
+					void *data)
+{
+}
+
+static inline void vc4_debugfs_add_regset32(struct drm_device *drm,
+					    const char *filename,
+					    struct debugfs_regset32 *regset)
+{
+}
+#endif
 
 /* vc4_drv.c */
 void __iomem *vc4_ioremap_regs(struct platform_device *dev, int index);
 
 /* vc4_dpi.c */
 extern struct platform_driver vc4_dpi_driver;
-int vc4_dpi_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_dsi.c */
 extern struct platform_driver vc4_dsi_driver;
-int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_fence.c */
 extern const struct dma_fence_ops vc4_fence_ops;
@@ -753,15 +777,12 @@ int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
 
 /* vc4_hdmi.c */
 extern struct platform_driver vc4_hdmi_driver;
-int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_vec.c */
 extern struct platform_driver vc4_vec_driver;
-int vc4_vec_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_txp.c */
 extern struct platform_driver vc4_txp_driver;
-int vc4_txp_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_irq.c */
 irqreturn_t vc4_irq(int irq, void *arg);
@@ -773,7 +794,6 @@ void vc4_irq_reset(struct drm_device *dev);
 /* vc4_hvs.c */
 extern struct platform_driver vc4_hvs_driver;
 void vc4_hvs_dump_state(struct drm_device *dev);
-int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused);
 
 /* vc4_kms.c */
 int vc4_kms_load(struct drm_device *dev);
@@ -788,8 +808,6 @@ void vc4_plane_async_set_fb(struct drm_plane *plane,
 
 /* vc4_v3d.c */
 extern struct platform_driver vc4_v3d_driver;
-int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused);
-int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused);
 int vc4_v3d_get_bin_slot(struct vc4_dev *vc4);
 
 /* vc4_validate.c */
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 806cfaa2a6a7..9412709067f5 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -657,25 +657,6 @@ static const struct debugfs_reg32 dsi1_regs[] = {
 	VC4_REG32(DSI1_ID),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_dsi_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *drm = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
-	int dsi_index = (uintptr_t)node->info_ent->data;
-	struct vc4_dsi *dsi = (dsi_index == 1 ? vc4->dsi1 : NULL);
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	if (!dsi)
-		return 0;
-
-	drm_print_regset32(&p, &dsi->regset);
-
-	return 0;
-}
-#endif
-
 static void vc4_dsi_encoder_destroy(struct drm_encoder *encoder)
 {
 	drm_encoder_cleanup(encoder);
@@ -1637,6 +1618,11 @@ static int vc4_dsi_bind(struct device *dev, struct device *master, void *data)
 	 */
 	dsi->encoder->bridge = NULL;
 
+	if (dsi->port == 0)
+		vc4_debugfs_add_regset32(drm, "dsi0_regs", &dsi->regset);
+	else
+		vc4_debugfs_add_regset32(drm, "dsi1_regs", &dsi->regset);
+
 	pm_runtime_enable(dev);
 
 	return 0;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 38c9172cfe52..99fc8569e0f5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -187,8 +187,7 @@ static const struct debugfs_reg32 hd_regs[] = {
 	VC4_REG32(VC4_HD_FRAME_COUNT),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
+static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
@@ -201,7 +200,6 @@ int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
 
 	return 0;
 }
-#endif /* CONFIG_DEBUG_FS */
 
 static enum drm_connector_status
 vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
@@ -1432,6 +1430,8 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_destroy_encoder;
 
+	vc4_debugfs_add_file(drm, "hdmi_regs", vc4_hdmi_debugfs_regs, hdmi);
+
 	return 0;
 
 #ifdef CONFIG_DRM_VC4_HDMI_CEC
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 45405f76cd40..7a8d71fbf04d 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -79,20 +79,6 @@ void vc4_hvs_dump_state(struct drm_device *dev)
 	}
 }
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_hvs_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	drm_print_regset32(&p, &vc4->hvs->regset);
-
-	return 0;
-}
-#endif
-
 /* The filter kernel is composed of dwords each containing 3 9-bit
  * signed integers packed next to each other.
  */
@@ -221,6 +207,8 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 
 	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
 
+	vc4_debugfs_add_regset32(drm, "hvs_regs", &hvs->regset);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index c8f80064c179..1220f4a5aac4 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -169,24 +169,6 @@ static const struct debugfs_reg32 txp_regs[] = {
 	VC4_REG32(TXP_PROGRESS),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_txp_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_txp *txp = vc4->txp;
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	if (!txp)
-		return 0;
-
-	drm_print_regset32(&p, &txp->regset);
-
-	return 0;
-}
-#endif
-
 static int vc4_txp_connector_get_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
@@ -424,6 +406,8 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	dev_set_drvdata(dev, txp);
 	vc4->txp = txp;
 
+	vc4_debugfs_add_regset32(drm, "txp_regs", &txp->regset);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index e1e728e95562..f008584eb739 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -22,7 +22,6 @@
 #include "vc4_drv.h"
 #include "vc4_regs.h"
 
-#ifdef CONFIG_DEBUG_FS
 static const struct debugfs_reg32 v3d_regs[] = {
 	VC4_REG32(V3D_IDENT0),
 	VC4_REG32(V3D_IDENT1),
@@ -104,19 +103,7 @@ static const struct debugfs_reg32 v3d_regs[] = {
 	VC4_REG32(V3D_ERRSTAT),
 };
 
-int vc4_v3d_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	drm_print_regset32(&p, &vc4->v3d->regset);
-
-	return 0;
-}
-
-int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
+static int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *dev = node->minor->dev;
@@ -136,7 +123,6 @@ int vc4_v3d_debugfs_ident(struct seq_file *m, void *unused)
 
 	return 0;
 }
-#endif /* CONFIG_DEBUG_FS */
 
 static void vc4_v3d_init_hw(struct drm_device *dev)
 {
@@ -404,6 +390,9 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
 	pm_runtime_enable(dev);
 
+	vc4_debugfs_add_file(drm, "v3d_ident", vc4_v3d_debugfs_ident, NULL);
+	vc4_debugfs_add_regset32(drm, "v3d_regs", &v3d->regset);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 83227d2440aa..0a27e48fab31 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -252,24 +252,6 @@ static const struct debugfs_reg32 vec_regs[] = {
 	VC4_REG32(VEC_DAC_MISC),
 };
 
-#ifdef CONFIG_DEBUG_FS
-int vc4_vec_debugfs_regs(struct seq_file *m, void *unused)
-{
-	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	struct vc4_vec *vec = vc4->vec;
-	struct drm_printer p = drm_seq_file_printer(m);
-
-	if (!vec)
-		return 0;
-
-	drm_print_regset32(&p, &vec->regset);
-
-	return 0;
-}
-#endif
-
 static void vc4_vec_ntsc_mode_set(struct vc4_vec *vec)
 {
 	VEC_WRITE(VEC_CONFIG0, VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN);
@@ -609,6 +591,8 @@ static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
 
 	vc4->vec = vec;
 
+	vc4_debugfs_add_regset32(drm, "vec_regs", &vec->regset);
+
 	return 0;
 
 err_destroy_encoder:
-- 
2.20.1

