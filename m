Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeFENzM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:55:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42364 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeFENyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:32 -0400
X-Google-Smtp-Source: ADUXVKLnXszg968JNEBVY482vdla3inx7dPKrqMYVNxZGMtk4L9De2/DdIiolESpeoGr22Xb0xHacw==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 5/7] drm: sti: make crtc use atomic_print_state instead of debugfs
Date: Tue,  5 Jun 2018 15:54:05 +0200
Message-Id: <20180605135407.20214-6-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sti crtc to atomic_print_state usage rather than use a
debugfs entry.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_compositor.c | 16 -------
 drivers/gpu/drm/sti/sti_compositor.h |  3 --
 drivers/gpu/drm/sti/sti_crtc.c       | 17 ++++---
 drivers/gpu/drm/sti/sti_mixer.c      | 89 ++++++++++--------------------------
 drivers/gpu/drm/sti/sti_mixer.h      |  3 +-
 drivers/gpu/drm/sti/sti_vid.c        | 60 ++++++++----------------
 drivers/gpu/drm/sti/sti_vid.h        |  2 +-
 7 files changed, 59 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
index 021b8fcaa0b9..c08d5c560557 100644
--- a/drivers/gpu/drm/sti/sti_compositor.c
+++ b/drivers/gpu/drm/sti/sti_compositor.c
@@ -39,22 +39,6 @@ static const struct sti_compositor_data stih407_compositor_data = {
 	},
 };
 
-int sti_compositor_debugfs_init(struct sti_compositor *compo,
-				struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < STI_MAX_VID; i++)
-		if (compo->vid[i])
-			vid_debugfs_init(compo->vid[i], minor);
-
-	for (i = 0; i < STI_MAX_MIXER; i++)
-		if (compo->mixer[i])
-			sti_mixer_debugfs_init(compo->mixer[i], minor);
-
-	return 0;
-}
-
 static int sti_compositor_bind(struct device *dev,
 			       struct device *master,
 			       void *data)
diff --git a/drivers/gpu/drm/sti/sti_compositor.h b/drivers/gpu/drm/sti/sti_compositor.h
index ac4bb3834810..eb8b233e68a2 100644
--- a/drivers/gpu/drm/sti/sti_compositor.h
+++ b/drivers/gpu/drm/sti/sti_compositor.h
@@ -79,7 +79,4 @@ struct sti_compositor {
 	struct notifier_block vtg_vblank_nb[STI_MAX_MIXER];
 };
 
-int sti_compositor_debugfs_init(struct sti_compositor *compo,
-				struct drm_minor *minor);
-
 #endif
diff --git a/drivers/gpu/drm/sti/sti_crtc.c b/drivers/gpu/drm/sti/sti_crtc.c
index 5824e6aca8f4..4e137932ffe4 100644
--- a/drivers/gpu/drm/sti/sti_crtc.c
+++ b/drivers/gpu/drm/sti/sti_crtc.c
@@ -316,15 +316,20 @@ void sti_crtc_disable_vblank(struct drm_device *drm_dev, unsigned int pipe)
 		DRM_DEBUG_DRIVER("Warning: cannot unregister VTG notifier\n");
 }
 
-static int sti_crtc_late_register(struct drm_crtc *crtc)
+static void sti_crtc_print_state(struct drm_printer *p,
+				 const struct drm_crtc_state *state)
 {
-	struct sti_mixer *mixer = to_sti_mixer(crtc);
+	struct sti_mixer *mixer = to_sti_mixer(state->crtc);
 	struct sti_compositor *compo = dev_get_drvdata(mixer->dev);
+	unsigned int i;
 
-	if (drm_crtc_index(crtc) == 0)
-		return sti_compositor_debugfs_init(compo, crtc->dev->primary);
+	for (i = 0; i < STI_MAX_VID; i++)
+		if (compo->vid[i])
+			sti_vid_print_state(p, compo->vid[i]);
 
-	return 0;
+	for (i = 0; i < STI_MAX_MIXER; i++)
+		if (compo->mixer[i])
+			sti_mixer_print_state(p, compo->mixer[i]);
 }
 
 static const struct drm_crtc_funcs sti_crtc_funcs = {
@@ -335,7 +340,7 @@ static const struct drm_crtc_funcs sti_crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-	.late_register = sti_crtc_late_register,
+	.atomic_print_state = sti_crtc_print_state,
 };
 
 bool sti_crtc_is_main(struct drm_crtc *crtc)
diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
index a4f45c74d678..22525139d315 100644
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -70,20 +70,20 @@ static inline void sti_mixer_reg_write(struct sti_mixer *mixer,
 	writel(val, mixer->regs + reg_id);
 }
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   sti_mixer_reg_read(mixer, reg))
 
-static void mixer_dbg_ctl(struct seq_file *s, int val)
+static void mixer_dbg_ctl(struct drm_printer *p, int val)
 {
 	unsigned int i;
 	int count = 0;
 	char *const disp_layer[] = {"BKG", "VID0", "VID1", "GDP0",
 				    "GDP1", "GDP2", "GDP3"};
 
-	seq_puts(s, "\tEnabled: ");
+	drm_printf(p, "\tEnabled: ");
 	for (i = 0; i < 7; i++) {
 		if (val & 1) {
-			seq_printf(s, "%s ", disp_layer[i]);
+			drm_printf(p, "%s ", disp_layer[i]);
 			count++;
 		}
 		val = val >> 1;
@@ -91,114 +91,75 @@ static void mixer_dbg_ctl(struct seq_file *s, int val)
 
 	val = val >> 2;
 	if (val & 1) {
-		seq_puts(s, "CURS ");
+		drm_printf(p, "CURS ");
 		count++;
 	}
 	if (!count)
-		seq_puts(s, "Nothing");
+		drm_printf(p, "Nothing");
 }
 
-static void mixer_dbg_crb(struct seq_file *s, int val)
+static void mixer_dbg_crb(struct drm_printer *p, int val)
 {
 	int i;
 
-	seq_puts(s, "\tDepth: ");
+	drm_printf(p, "\tDepth: ");
 	for (i = 0; i < GAM_MIXER_NB_DEPTH_LEVEL; i++) {
 		switch (val & GAM_DEPTH_MASK_ID) {
 		case GAM_DEPTH_VID0_ID:
-			seq_puts(s, "VID0");
+			drm_printf(p, "VID0");
 			break;
 		case GAM_DEPTH_VID1_ID:
-			seq_puts(s, "VID1");
+			drm_printf(p, "VID1");
 			break;
 		case GAM_DEPTH_GDP0_ID:
-			seq_puts(s, "GDP0");
+			drm_printf(p, "GDP0");
 			break;
 		case GAM_DEPTH_GDP1_ID:
-			seq_puts(s, "GDP1");
+			drm_printf(p, "GDP1");
 			break;
 		case GAM_DEPTH_GDP2_ID:
-			seq_puts(s, "GDP2");
+			drm_printf(p, "GDP2");
 			break;
 		case GAM_DEPTH_GDP3_ID:
-			seq_puts(s, "GDP3");
+			drm_printf(p, "GDP3");
 			break;
 		default:
-			seq_puts(s, "---");
+			drm_printf(p, "---");
 		}
 
 		if (i < GAM_MIXER_NB_DEPTH_LEVEL - 1)
-			seq_puts(s, " < ");
+			drm_printf(p, " < ");
 		val = val >> 3;
 	}
 }
 
-static void mixer_dbg_mxn(struct seq_file *s, void *addr)
+static void mixer_dbg_mxn(struct drm_printer *p, void *addr)
 {
 	int i;
 
 	for (i = 1; i < 8; i++)
-		seq_printf(s, "-0x%08X", (int)readl(addr + i * 4));
+		drm_printf(p, "-0x%08X", (int)readl(addr + i * 4));
 }
 
-static int mixer_dbg_show(struct seq_file *s, void *arg)
+void sti_mixer_print_state(struct drm_printer *p, struct sti_mixer *mixer)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_mixer *mixer = (struct sti_mixer *)node->info_ent->data;
-
-	seq_printf(s, "%s: (vaddr = 0x%p)",
+	drm_printf(p, "\t%s: (vaddr = 0x%pK)",
 		   sti_mixer_to_str(mixer), mixer->regs);
 
 	DBGFS_DUMP(GAM_MIXER_CTL);
-	mixer_dbg_ctl(s, sti_mixer_reg_read(mixer, GAM_MIXER_CTL));
+	mixer_dbg_ctl(p, sti_mixer_reg_read(mixer, GAM_MIXER_CTL));
 	DBGFS_DUMP(GAM_MIXER_BKC);
 	DBGFS_DUMP(GAM_MIXER_BCO);
 	DBGFS_DUMP(GAM_MIXER_BCS);
 	DBGFS_DUMP(GAM_MIXER_AVO);
 	DBGFS_DUMP(GAM_MIXER_AVS);
 	DBGFS_DUMP(GAM_MIXER_CRB);
-	mixer_dbg_crb(s, sti_mixer_reg_read(mixer, GAM_MIXER_CRB));
+	mixer_dbg_crb(p, sti_mixer_reg_read(mixer, GAM_MIXER_CRB));
 	DBGFS_DUMP(GAM_MIXER_ACT);
 	DBGFS_DUMP(GAM_MIXER_MBP);
 	DBGFS_DUMP(GAM_MIXER_MX0);
-	mixer_dbg_mxn(s, mixer->regs + GAM_MIXER_MX0);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list mixer0_debugfs_files[] = {
-	{ "mixer_main", mixer_dbg_show, 0, NULL },
-};
-
-static struct drm_info_list mixer1_debugfs_files[] = {
-	{ "mixer_aux", mixer_dbg_show, 0, NULL },
-};
-
-int sti_mixer_debugfs_init(struct sti_mixer *mixer, struct drm_minor *minor)
-{
-	unsigned int i;
-	struct drm_info_list *mixer_debugfs_files;
-	int nb_files;
-
-	switch (mixer->id) {
-	case STI_MIXER_MAIN:
-		mixer_debugfs_files = mixer0_debugfs_files;
-		nb_files = ARRAY_SIZE(mixer0_debugfs_files);
-		break;
-	case STI_MIXER_AUX:
-		mixer_debugfs_files = mixer1_debugfs_files;
-		nb_files = ARRAY_SIZE(mixer1_debugfs_files);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i = 0; i < nb_files; i++)
-		mixer_debugfs_files[i].data = mixer;
-
-	return drm_debugfs_create_files(mixer_debugfs_files,
-					nb_files,
-					minor->debugfs_root, minor);
+	mixer_dbg_mxn(p, mixer->regs + GAM_MIXER_MX0);
+	drm_printf(p, "\n");
 }
 
 void sti_mixer_set_background_status(struct sti_mixer *mixer, bool enable)
@@ -367,7 +328,7 @@ struct sti_mixer *sti_mixer_create(struct device *dev,
 	mixer->dev = dev;
 	mixer->id = id;
 
-	DRM_DEBUG_DRIVER("%s created. Regs=%p\n",
+	DRM_DEBUG_DRIVER("%s created. Regs=%pK\n",
 			 sti_mixer_to_str(mixer), mixer->regs);
 
 	return mixer;
diff --git a/drivers/gpu/drm/sti/sti_mixer.h b/drivers/gpu/drm/sti/sti_mixer.h
index 4cb3cfddc03a..067093270bb0 100644
--- a/drivers/gpu/drm/sti/sti_mixer.h
+++ b/drivers/gpu/drm/sti/sti_mixer.h
@@ -53,7 +53,8 @@ int sti_mixer_active_video_area(struct sti_mixer *mixer,
 
 void sti_mixer_set_background_status(struct sti_mixer *mixer, bool enable);
 
-int sti_mixer_debugfs_init(struct sti_mixer *mixer, struct drm_minor *minor);
+void sti_mixer_print_state(struct drm_printer *p, struct sti_mixer *mixer);
+
 
 /* depth in Cross-bar control = z order */
 #define GAM_MIXER_NB_DEPTH_LEVEL 6
diff --git a/drivers/gpu/drm/sti/sti_vid.c b/drivers/gpu/drm/sti/sti_vid.c
index 2aac36c95835..9730e9cf2a87 100644
--- a/drivers/gpu/drm/sti/sti_vid.c
+++ b/drivers/gpu/drm/sti/sti_vid.c
@@ -55,54 +55,51 @@
 
 #define VID_MIN_HD_HEIGHT       720
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(vid->regs + reg))
 
-static void vid_dbg_ctl(struct seq_file *s, int val)
+static void vid_dbg_ctl(struct drm_printer *p, int val)
 {
 	val = val >> 30;
-	seq_putc(s, '\t');
+	drm_printf(p, "\t");
 
 	if (!(val & 1))
-		seq_puts(s, "NOT ");
-	seq_puts(s, "ignored on main mixer - ");
+		drm_printf(p, "NOT ");
+	drm_printf(p, "ignored on main mixer - ");
 
 	if (!(val & 2))
-		seq_puts(s, "NOT ");
-	seq_puts(s, "ignored on aux mixer");
+		drm_printf(p, "NOT ");
+	drm_printf(p, "ignored on aux mixer");
 }
 
-static void vid_dbg_vpo(struct seq_file *s, int val)
+static void vid_dbg_vpo(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\txdo:%4d\tydo:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
+	drm_printf(p, "\txdo:%4d\tydo:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
 }
 
-static void vid_dbg_vps(struct seq_file *s, int val)
+static void vid_dbg_vps(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\txds:%4d\tyds:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
+	drm_printf(p, "\txds:%4d\tyds:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
 }
 
-static void vid_dbg_mst(struct seq_file *s, int val)
+static void vid_dbg_mst(struct drm_printer *p, int val)
 {
 	if (val & 1)
-		seq_puts(s, "\tBUFFER UNDERFLOW!");
+		drm_printf(p, "\tBUFFER UNDERFLOW!");
 }
 
-static int vid_dbg_show(struct seq_file *s, void *arg)
+void sti_vid_print_state(struct drm_printer *p, struct sti_vid *vid)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_vid *vid = (struct sti_vid *)node->info_ent->data;
-
-	seq_printf(s, "VID: (vaddr= 0x%p)", vid->regs);
+	drm_printf(p, "\tVID: (vaddr= 0x%pK)", vid->regs);
 
 	DBGFS_DUMP(VID_CTL);
-	vid_dbg_ctl(s, readl(vid->regs + VID_CTL));
+	vid_dbg_ctl(p, readl(vid->regs + VID_CTL));
 	DBGFS_DUMP(VID_ALP);
 	DBGFS_DUMP(VID_CLF);
 	DBGFS_DUMP(VID_VPO);
-	vid_dbg_vpo(s, readl(vid->regs + VID_VPO));
+	vid_dbg_vpo(p, readl(vid->regs + VID_VPO));
 	DBGFS_DUMP(VID_VPS);
-	vid_dbg_vps(s, readl(vid->regs + VID_VPS));
+	vid_dbg_vps(p, readl(vid->regs + VID_VPS));
 	DBGFS_DUMP(VID_KEY1);
 	DBGFS_DUMP(VID_KEY2);
 	DBGFS_DUMP(VID_MPR0);
@@ -110,28 +107,11 @@ static int vid_dbg_show(struct seq_file *s, void *arg)
 	DBGFS_DUMP(VID_MPR2);
 	DBGFS_DUMP(VID_MPR3);
 	DBGFS_DUMP(VID_MST);
-	vid_dbg_mst(s, readl(vid->regs + VID_MST));
+	vid_dbg_mst(p, readl(vid->regs + VID_MST));
 	DBGFS_DUMP(VID_BC);
 	DBGFS_DUMP(VID_TINT);
 	DBGFS_DUMP(VID_CSAT);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list vid_debugfs_files[] = {
-	{ "vid", vid_dbg_show, 0, NULL },
-};
-
-int vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(vid_debugfs_files); i++)
-		vid_debugfs_files[i].data = vid;
-
-	return drm_debugfs_create_files(vid_debugfs_files,
-					ARRAY_SIZE(vid_debugfs_files),
-					minor->debugfs_root, minor);
+	drm_printf(p, "\n");
 }
 
 void sti_vid_commit(struct sti_vid *vid,
diff --git a/drivers/gpu/drm/sti/sti_vid.h b/drivers/gpu/drm/sti/sti_vid.h
index 9dbd78461de1..27656dbbd2bc 100644
--- a/drivers/gpu/drm/sti/sti_vid.h
+++ b/drivers/gpu/drm/sti/sti_vid.h
@@ -26,6 +26,6 @@ void sti_vid_disable(struct sti_vid *vid);
 struct sti_vid *sti_vid_create(struct device *dev, struct drm_device *drm_dev,
 			       int id, void __iomem *baseaddr);
 
-int vid_debugfs_init(struct sti_vid *vid, struct drm_minor *minor);
+void sti_vid_print_state(struct drm_printer *p, struct sti_vid *vid);
 
 #endif
-- 
2.15.0
