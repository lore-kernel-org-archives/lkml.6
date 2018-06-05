Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeFENyz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43557 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFENyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:33 -0400
X-Google-Smtp-Source: ADUXVKLpc6lqJdUStd46szG+yzVG2/Vsvt/oEzyaCMJ8H56vKQyUhVEyiUqvVNE1I+HdIXhRl7AWaQ==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 6/7] drm: sti: make encoders use atomic_print_state instead of debugfs
Date: Tue,  5 Jun 2018 15:54:06 +0200
Message-Id: <20180605135407.20214-7-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all sti encoders to atomic_print usage rather than use a
debugfs entry.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_tvout.c | 162 ++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index ea4a3b87fa55..8aa23710b695 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -442,10 +442,10 @@ static void tvout_hda_start(struct sti_tvout *tvout, bool main_path)
 	tvout_write(tvout, 0, TVO_HD_DAC_CFG_OFF);
 }
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(tvout->regs + reg))
 
-static void tvout_dbg_vip(struct seq_file *s, int val)
+static void tvout_dbg_vip(struct drm_printer *p, int val)
 {
 	int r, g, b, tmp, mask;
 	char *const reorder[] = {"Y_G", "Cb_B", "Cr_R"};
@@ -459,86 +459,94 @@ static void tvout_dbg_vip(struct seq_file *s, int val)
 				   "Aux (color matrix by-passed)",
 				   "", "", "", "", "", "Force value"};
 
-	seq_putc(s, '\t');
+	drm_printf(p, "\n\t\t\t");
 	mask = TVO_VIP_REORDER_MASK << TVO_VIP_REORDER_R_SHIFT;
 	r = (val & mask) >> TVO_VIP_REORDER_R_SHIFT;
 	mask = TVO_VIP_REORDER_MASK << TVO_VIP_REORDER_G_SHIFT;
 	g = (val & mask) >> TVO_VIP_REORDER_G_SHIFT;
 	mask = TVO_VIP_REORDER_MASK << TVO_VIP_REORDER_B_SHIFT;
 	b = (val & mask) >> TVO_VIP_REORDER_B_SHIFT;
-	seq_printf(s, "%-24s %s->%s %s->%s %s->%s\n", "Reorder:",
+	drm_printf(p, "%-24s %s->%s %s->%s %s->%s", "Reorder:",
 		   reorder[r], reorder[TVO_VIP_REORDER_CR_R_SEL],
 		   reorder[g], reorder[TVO_VIP_REORDER_Y_G_SEL],
 		   reorder[b], reorder[TVO_VIP_REORDER_CB_B_SEL]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\n\t\t\t");
 	mask = TVO_VIP_CLIP_MASK << TVO_VIP_CLIP_SHIFT;
 	tmp = (val & mask) >> TVO_VIP_CLIP_SHIFT;
-	seq_printf(s, "%-24s %s\n", "Clipping:", clipping[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "%-24s %s", "Clipping:", clipping[tmp]);
+	drm_printf(p, "\n\t\t\t");
 	mask = TVO_VIP_RND_MASK << TVO_VIP_RND_SHIFT;
 	tmp = (val & mask) >> TVO_VIP_RND_SHIFT;
-	seq_printf(s, "%-24s input data rounded to %s per component\n",
+	drm_printf(p, "%-24s input data rounded to %s per component",
 		   "Round:", round[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\n\t\t\t");
 	tmp = (val & TVO_VIP_SEL_INPUT_MASK);
-	seq_printf(s, "%-24s %s", "Input selection:", input_sel[tmp]);
+	drm_printf(p, "%-24s %s", "Input selection:", input_sel[tmp]);
 }
 
-static void tvout_dbg_hd_dac_cfg(struct seq_file *s, int val)
+static void tvout_dbg_hd_dac_cfg(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\t%-24s %s", "HD DAC:",
+	drm_printf(p, "\t%-24s %s", "HD DAC:",
 		   val & 1 ? "disabled" : "enabled");
 }
 
-static int tvout_dbg_show(struct seq_file *s, void *data)
+static void sti_tvout_print(struct drm_printer *p, struct drm_encoder *encoder)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_tvout *tvout = (struct sti_tvout *)node->info_ent->data;
+	struct sti_tvout *tvout = to_sti_tvout(encoder);
 	struct drm_crtc *crtc;
 
-	seq_printf(s, "TVOUT: (vaddr = 0x%p)", tvout->regs);
-
-	seq_puts(s, "\n\n  HDMI encoder: ");
-	crtc = tvout->hdmi->crtc;
-	if (crtc) {
-		seq_printf(s, "connected to %s path",
-			   sti_crtc_is_main(crtc) ? "main" : "aux");
-		DBGFS_DUMP(TVO_HDMI_SYNC_SEL);
-		DBGFS_DUMP(TVO_VIP_HDMI);
-		tvout_dbg_vip(s, readl(tvout->regs + TVO_VIP_HDMI));
-	} else {
-		seq_puts(s, "disabled");
+	drm_printf(p, "\tTVOUT: (vaddr = 0x%pK)\n", tvout->regs);
+
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS) {
+		drm_printf(p, "\tHDMI encoder: ");
+		crtc = tvout->hdmi->crtc;
+		if (crtc) {
+			drm_printf(p, "connected to %s path",
+				   sti_crtc_is_main(crtc) ? "main" : "aux");
+			DBGFS_DUMP(TVO_HDMI_SYNC_SEL);
+			DBGFS_DUMP(TVO_VIP_HDMI);
+			tvout_dbg_vip(p, readl(tvout->regs + TVO_VIP_HDMI));
+		} else {
+			drm_printf(p, "disabled\n");
+			return;
+		}
 	}
 
-	seq_puts(s, "\n\n  DVO encoder: ");
-	crtc = tvout->dvo->crtc;
-	if (crtc) {
-		seq_printf(s, "connected to %s path",
-			   sti_crtc_is_main(crtc) ? "main" : "aux");
-		DBGFS_DUMP(TVO_DVO_SYNC_SEL);
-		DBGFS_DUMP(TVO_DVO_CONFIG);
-		DBGFS_DUMP(TVO_VIP_DVO);
-		tvout_dbg_vip(s, readl(tvout->regs + TVO_VIP_DVO));
-	} else {
-		seq_puts(s, "disabled");
+	if (encoder->encoder_type == DRM_MODE_ENCODER_LVDS) {
+		drm_printf(p, "\tDVO encoder: ");
+		crtc = tvout->dvo->crtc;
+		if (crtc) {
+			drm_printf(p, "connected to %s path",
+				   sti_crtc_is_main(crtc) ? "main" : "aux");
+			DBGFS_DUMP(TVO_DVO_SYNC_SEL);
+			DBGFS_DUMP(TVO_DVO_CONFIG);
+			DBGFS_DUMP(TVO_VIP_DVO);
+			tvout_dbg_vip(p, readl(tvout->regs + TVO_VIP_DVO));
+		} else {
+			drm_printf(p, "disabled\n");
+			return;
+		}
 	}
 
-	seq_puts(s, "\n\n  HDA encoder: ");
-	crtc = tvout->hda->crtc;
-	if (crtc) {
-		seq_printf(s, "connected to %s path",
-			   sti_crtc_is_main(crtc) ? "main" : "aux");
-		DBGFS_DUMP(TVO_HD_SYNC_SEL);
-		DBGFS_DUMP(TVO_HD_DAC_CFG_OFF);
-		tvout_dbg_hd_dac_cfg(s,
-				     readl(tvout->regs + TVO_HD_DAC_CFG_OFF));
-		DBGFS_DUMP(TVO_VIP_HDF);
-		tvout_dbg_vip(s, readl(tvout->regs + TVO_VIP_HDF));
-	} else {
-		seq_puts(s, "disabled");
+	if (encoder->encoder_type == DRM_MODE_ENCODER_DAC) {
+		drm_printf(p, "\tHDA encoder: ");
+		crtc = tvout->hda->crtc;
+		if (crtc) {
+			drm_printf(p, "connected to %s path",
+				   sti_crtc_is_main(crtc) ? "main" : "aux");
+			DBGFS_DUMP(TVO_HD_SYNC_SEL);
+			DBGFS_DUMP(TVO_HD_DAC_CFG_OFF);
+			tvout_dbg_hd_dac_cfg(p,
+				readl(tvout->regs + TVO_HD_DAC_CFG_OFF));
+			DBGFS_DUMP(TVO_VIP_HDF);
+			tvout_dbg_vip(p, readl(tvout->regs + TVO_VIP_HDF));
+		} else {
+			drm_printf(p, "disabled\n");
+			return;
+		}
 	}
 
-	seq_puts(s, "\n\n  main path configuration");
+	drm_printf(p, "\n\t\tmain path configuration");
 	DBGFS_DUMP(TVO_CSC_MAIN_M0);
 	DBGFS_DUMP(TVO_CSC_MAIN_M1);
 	DBGFS_DUMP(TVO_CSC_MAIN_M2);
@@ -549,7 +557,7 @@ static int tvout_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP(TVO_CSC_MAIN_M7);
 	DBGFS_DUMP(TVO_MAIN_IN_VID_FORMAT);
 
-	seq_puts(s, "\n\n  auxiliary path configuration");
+	drm_printf(p, "\n\t\tauxiliary path configuration");
 	DBGFS_DUMP(TVO_CSC_AUX_M0);
 	DBGFS_DUMP(TVO_CSC_AUX_M2);
 	DBGFS_DUMP(TVO_CSC_AUX_M3);
@@ -558,24 +566,7 @@ static int tvout_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP(TVO_CSC_AUX_M6);
 	DBGFS_DUMP(TVO_CSC_AUX_M7);
 	DBGFS_DUMP(TVO_AUX_IN_VID_FORMAT);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list tvout_debugfs_files[] = {
-	{ "tvout", tvout_dbg_show, 0, NULL },
-};
-
-static int tvout_debugfs_init(struct sti_tvout *tvout, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tvout_debugfs_files); i++)
-		tvout_debugfs_files[i].data = tvout;
-
-	return drm_debugfs_create_files(tvout_debugfs_files,
-					ARRAY_SIZE(tvout_debugfs_files),
-					minor->debugfs_root, minor);
+	drm_printf(p, "\n");
 }
 
 static void sti_tvout_encoder_dpms(struct drm_encoder *encoder, int mode)
@@ -596,36 +587,9 @@ static void sti_tvout_encoder_destroy(struct drm_encoder *encoder)
 	kfree(sti_encoder);
 }
 
-static int sti_tvout_late_register(struct drm_encoder *encoder)
-{
-	struct sti_tvout *tvout = to_sti_tvout(encoder);
-	int ret;
-
-	if (tvout->debugfs_registered)
-		return 0;
-
-	ret = tvout_debugfs_init(tvout, encoder->dev->primary);
-	if (ret)
-		return ret;
-
-	tvout->debugfs_registered = true;
-	return 0;
-}
-
-static void sti_tvout_early_unregister(struct drm_encoder *encoder)
-{
-	struct sti_tvout *tvout = to_sti_tvout(encoder);
-
-	if (!tvout->debugfs_registered)
-		return;
-
-	tvout->debugfs_registered = false;
-}
-
 static const struct drm_encoder_funcs sti_tvout_encoder_funcs = {
 	.destroy = sti_tvout_encoder_destroy,
-	.late_register = sti_tvout_late_register,
-	.early_unregister = sti_tvout_early_unregister,
+	.atomic_print = sti_tvout_print
 };
 
 static void sti_dvo_encoder_enable(struct drm_encoder *encoder)
-- 
2.15.0
