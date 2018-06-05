Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeFENyc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40544 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFENy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:28 -0400
X-Google-Smtp-Source: ADUXVKLZHifzJMtjYSBpT2zW8RVJrnmfCyk0V92Mujty8N+cynwyU/OXJnKBznSyXKMLASHZdhpFrg==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 3/7] drm: sti: make planes use atomic_print_state instead of debugfs
Date: Tue,  5 Jun 2018 15:54:03 +0200
Message-Id: <20180605135407.20214-4-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all sti planes to atomic_print_state usage rather than use a debugfs
entry.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_cursor.c |  65 +++++--------
 drivers/gpu/drm/sti/sti_gdp.c    | 196 +++++++++++++--------------------------
 drivers/gpu/drm/sti/sti_hqvdp.c  | 149 +++++++++++++----------------
 3 files changed, 146 insertions(+), 264 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index df0a282b9615..69f6b1091422 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -74,72 +74,57 @@ static const uint32_t cursor_supported_formats[] = {
 
 #define to_sti_cursor(x) container_of(x, struct sti_cursor, plane)
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(cursor->regs + reg))
 
-static void cursor_dbg_vpo(struct seq_file *s, u32 val)
+static void cursor_dbg_vpo(struct drm_printer *p, u32 val)
 {
-	seq_printf(s, "\txdo:%4d\tydo:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
+	drm_printf(p, "\txdo:%4d\tydo:%4d", val & 0x0FFF, (val >> 16) & 0x0FFF);
 }
 
-static void cursor_dbg_size(struct seq_file *s, u32 val)
+static void cursor_dbg_size(struct drm_printer *p, u32 val)
 {
-	seq_printf(s, "\t%d x %d", val & 0x07FF, (val >> 16) & 0x07FF);
+	drm_printf(p, "\t%d x %d", val & 0x07FF, (val >> 16) & 0x07FF);
 }
 
-static void cursor_dbg_pml(struct seq_file *s,
+static void cursor_dbg_pml(struct drm_printer *p,
 			   struct sti_cursor *cursor, u32 val)
 {
 	if (cursor->pixmap.paddr == val)
-		seq_printf(s, "\tVirt @: %p", cursor->pixmap.base);
+		drm_printf(p, "\tVirt @: %pK", cursor->pixmap.base);
 }
 
-static void cursor_dbg_cml(struct seq_file *s,
+static void cursor_dbg_cml(struct drm_printer *p,
 			   struct sti_cursor *cursor, u32 val)
 {
 	if (cursor->clut_paddr == val)
-		seq_printf(s, "\tVirt @: %p", cursor->clut);
+		drm_printf(p, "\tVirt @: %pK", cursor->clut);
 }
 
-static int cursor_dbg_show(struct seq_file *s, void *data)
+static void sti_cursor_plane_print_state(struct drm_printer *p,
+					 const struct drm_plane_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_cursor *cursor = (struct sti_cursor *)node->info_ent->data;
+	struct sti_plane *plane = to_sti_plane(state->plane);
+	struct sti_cursor *cursor = to_sti_cursor(plane);
 
-	seq_printf(s, "%s: (vaddr = 0x%p)",
+	drm_printf(p, "\t%s: (vaddr = 0x%pK)",
 		   sti_plane_to_str(&cursor->plane), cursor->regs);
 
 	DBGFS_DUMP(CUR_CTL);
 	DBGFS_DUMP(CUR_VPO);
-	cursor_dbg_vpo(s, readl(cursor->regs + CUR_VPO));
+	cursor_dbg_vpo(p, readl(cursor->regs + CUR_VPO));
 	DBGFS_DUMP(CUR_PML);
-	cursor_dbg_pml(s, cursor, readl(cursor->regs + CUR_PML));
+	cursor_dbg_pml(p, cursor, readl(cursor->regs + CUR_PML));
 	DBGFS_DUMP(CUR_PMP);
 	DBGFS_DUMP(CUR_SIZE);
-	cursor_dbg_size(s, readl(cursor->regs + CUR_SIZE));
+	cursor_dbg_size(p, readl(cursor->regs + CUR_SIZE));
 	DBGFS_DUMP(CUR_CML);
-	cursor_dbg_cml(s, cursor, readl(cursor->regs + CUR_CML));
+	cursor_dbg_cml(p, cursor, readl(cursor->regs + CUR_CML));
 	DBGFS_DUMP(CUR_AWS);
 	DBGFS_DUMP(CUR_AWE);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list cursor_debugfs_files[] = {
-	{ "cursor", cursor_dbg_show, 0, NULL },
-};
-
-static int cursor_debugfs_init(struct sti_cursor *cursor,
-			       struct drm_minor *minor)
-{
-	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(cursor_debugfs_files); i++)
-		cursor_debugfs_files[i].data = cursor;
-
-	return drm_debugfs_create_files(cursor_debugfs_files,
-					ARRAY_SIZE(cursor_debugfs_files),
-					minor->debugfs_root, minor);
+	drm_printf(p, "\t%s%s\n",
+		   plane->fps_info.fps_str, plane->fps_info.fips_str);
 }
 
 static void sti_cursor_argb8888_to_clut8(struct sti_cursor *cursor, u32 *src)
@@ -336,14 +321,6 @@ static void sti_cursor_destroy(struct drm_plane *drm_plane)
 	drm_plane_cleanup(drm_plane);
 }
 
-static int sti_cursor_late_register(struct drm_plane *drm_plane)
-{
-	struct sti_plane *plane = to_sti_plane(drm_plane);
-	struct sti_cursor *cursor = to_sti_cursor(plane);
-
-	return cursor_debugfs_init(cursor, drm_plane->dev->primary);
-}
-
 static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -351,7 +328,7 @@ static const struct drm_plane_funcs sti_cursor_plane_helpers_funcs = {
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.late_register = sti_cursor_late_register,
+	.atomic_print_state = sti_cursor_plane_print_state,
 };
 
 struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 49813d34bdf0..55789bae72c1 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -139,42 +139,42 @@ static const uint32_t gdp_supported_formats[] = {
 	DRM_FORMAT_RGB888,
 };
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(gdp->regs + reg ## _OFFSET))
 
-static void gdp_dbg_ctl(struct seq_file *s, int val)
+static void gdp_dbg_ctl(struct drm_printer *p, int val)
 {
 	int i;
 
-	seq_puts(s, "\tColor:");
+	drm_printf(p, "\tColor:");
 	for (i = 0; i < ARRAY_SIZE(gdp_format_to_str); i++) {
 		if (gdp_format_to_str[i].format == (val & 0x1F)) {
-			seq_puts(s, gdp_format_to_str[i].name);
+			drm_printf(p, gdp_format_to_str[i].name);
 			break;
 		}
 	}
 	if (i == ARRAY_SIZE(gdp_format_to_str))
-		seq_puts(s, "<UNKNOWN>");
+		drm_printf(p, "<UNKNOWN>");
 
-	seq_printf(s, "\tWaitNextVsync:%d", val & WAIT_NEXT_VSYNC ? 1 : 0);
+	drm_printf(p, "\tWaitNextVsync:%d", val & WAIT_NEXT_VSYNC ? 1 : 0);
 }
 
-static void gdp_dbg_vpo(struct seq_file *s, int val)
+static void gdp_dbg_vpo(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\txdo:%4d\tydo:%4d", val & 0xFFFF, (val >> 16) & 0xFFFF);
+	drm_printf(p, "\txdo:%4d\tydo:%4d", val & 0xFFFF, (val >> 16) & 0xFFFF);
 }
 
-static void gdp_dbg_vps(struct seq_file *s, int val)
+static void gdp_dbg_vps(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\txds:%4d\tyds:%4d", val & 0xFFFF, (val >> 16) & 0xFFFF);
+	drm_printf(p, "\txds:%4d\tyds:%4d", val & 0xFFFF, (val >> 16) & 0xFFFF);
 }
 
-static void gdp_dbg_size(struct seq_file *s, int val)
+static void gdp_dbg_size(struct drm_printer *p, int val)
 {
-	seq_printf(s, "\t%d x %d", val & 0xFFFF, (val >> 16) & 0xFFFF);
+	drm_printf(p, "\t%d x %d", val & 0xFFFF, (val >> 16) & 0xFFFF);
 }
 
-static void gdp_dbg_nvn(struct seq_file *s, struct sti_gdp *gdp, int val)
+static void gdp_dbg_nvn(struct drm_printer *p, struct sti_gdp *gdp, int val)
 {
 	void *base = NULL;
 	unsigned int i;
@@ -191,157 +191,93 @@ static void gdp_dbg_nvn(struct seq_file *s, struct sti_gdp *gdp, int val)
 	}
 
 	if (base)
-		seq_printf(s, "\tVirt @: %p", base);
+		drm_printf(p, "\tVirt @: %pK", base);
 }
 
-static void gdp_dbg_ppt(struct seq_file *s, int val)
+static void gdp_dbg_ppt(struct drm_printer *p, int val)
 {
 	if (val & GAM_GDP_PPT_IGNORE)
-		seq_puts(s, "\tNot displayed on mixer!");
+		drm_printf(p, "\tNot displayed on mixer!");
 }
 
-static void gdp_dbg_mst(struct seq_file *s, int val)
+static void gdp_dbg_mst(struct drm_printer *p, int val)
 {
 	if (val & 1)
-		seq_puts(s, "\tBUFFER UNDERFLOW!");
+		drm_printf(p, "\tBUFFER UNDERFLOW!");
 }
 
-static int gdp_dbg_show(struct seq_file *s, void *data)
+static int gdp_dbg_show(struct drm_printer *p, struct sti_gdp *gdp)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_gdp *gdp = (struct sti_gdp *)node->info_ent->data;
-	struct drm_plane *drm_plane = &gdp->plane.drm_plane;
-	struct drm_crtc *crtc;
-
-	drm_modeset_lock(&drm_plane->mutex, NULL);
-	crtc = drm_plane->state->crtc;
-	drm_modeset_unlock(&drm_plane->mutex);
-
-	seq_printf(s, "%s: (vaddr = 0x%p)",
+	drm_printf(p, "\t%s: (vaddr = 0x%pK)",
 		   sti_plane_to_str(&gdp->plane), gdp->regs);
 
 	DBGFS_DUMP(GAM_GDP_CTL);
-	gdp_dbg_ctl(s, readl(gdp->regs + GAM_GDP_CTL_OFFSET));
+	gdp_dbg_ctl(p, readl(gdp->regs + GAM_GDP_CTL_OFFSET));
 	DBGFS_DUMP(GAM_GDP_AGC);
 	DBGFS_DUMP(GAM_GDP_VPO);
-	gdp_dbg_vpo(s, readl(gdp->regs + GAM_GDP_VPO_OFFSET));
+	gdp_dbg_vpo(p, readl(gdp->regs + GAM_GDP_VPO_OFFSET));
 	DBGFS_DUMP(GAM_GDP_VPS);
-	gdp_dbg_vps(s, readl(gdp->regs + GAM_GDP_VPS_OFFSET));
+	gdp_dbg_vps(p, readl(gdp->regs + GAM_GDP_VPS_OFFSET));
 	DBGFS_DUMP(GAM_GDP_PML);
 	DBGFS_DUMP(GAM_GDP_PMP);
 	DBGFS_DUMP(GAM_GDP_SIZE);
-	gdp_dbg_size(s, readl(gdp->regs + GAM_GDP_SIZE_OFFSET));
+	gdp_dbg_size(p, readl(gdp->regs + GAM_GDP_SIZE_OFFSET));
 	DBGFS_DUMP(GAM_GDP_NVN);
-	gdp_dbg_nvn(s, gdp, readl(gdp->regs + GAM_GDP_NVN_OFFSET));
+	gdp_dbg_nvn(p, gdp, readl(gdp->regs + GAM_GDP_NVN_OFFSET));
 	DBGFS_DUMP(GAM_GDP_KEY1);
 	DBGFS_DUMP(GAM_GDP_KEY2);
 	DBGFS_DUMP(GAM_GDP_PPT);
-	gdp_dbg_ppt(s, readl(gdp->regs + GAM_GDP_PPT_OFFSET));
+	gdp_dbg_ppt(p, readl(gdp->regs + GAM_GDP_PPT_OFFSET));
 	DBGFS_DUMP(GAM_GDP_CML);
 	DBGFS_DUMP(GAM_GDP_MST);
-	gdp_dbg_mst(s, readl(gdp->regs + GAM_GDP_MST_OFFSET));
-
-	seq_puts(s, "\n\n");
-	if (!crtc)
-		seq_puts(s, "  Not connected to any DRM CRTC\n");
-	else
-		seq_printf(s, "  Connected to DRM CRTC #%d (%s)\n",
-			   crtc->base.id, sti_mixer_to_str(to_sti_mixer(crtc)));
+	gdp_dbg_mst(p, readl(gdp->regs + GAM_GDP_MST_OFFSET));
 
+	drm_printf(p, "\n");
 	return 0;
 }
 
-static void gdp_node_dump_node(struct seq_file *s, struct sti_gdp_node *node)
+static void gdp_node_dump_node(struct drm_printer *p, struct sti_gdp_node *node)
 {
-	seq_printf(s, "\t@:0x%p", node);
-	seq_printf(s, "\n\tCTL  0x%08X", node->gam_gdp_ctl);
-	gdp_dbg_ctl(s, node->gam_gdp_ctl);
-	seq_printf(s, "\n\tAGC  0x%08X", node->gam_gdp_agc);
-	seq_printf(s, "\n\tVPO  0x%08X", node->gam_gdp_vpo);
-	gdp_dbg_vpo(s, node->gam_gdp_vpo);
-	seq_printf(s, "\n\tVPS  0x%08X", node->gam_gdp_vps);
-	gdp_dbg_vps(s, node->gam_gdp_vps);
-	seq_printf(s, "\n\tPML  0x%08X", node->gam_gdp_pml);
-	seq_printf(s, "\n\tPMP  0x%08X", node->gam_gdp_pmp);
-	seq_printf(s, "\n\tSIZE 0x%08X", node->gam_gdp_size);
-	gdp_dbg_size(s, node->gam_gdp_size);
-	seq_printf(s, "\n\tNVN  0x%08X", node->gam_gdp_nvn);
-	seq_printf(s, "\n\tKEY1 0x%08X", node->gam_gdp_key1);
-	seq_printf(s, "\n\tKEY2 0x%08X", node->gam_gdp_key2);
-	seq_printf(s, "\n\tPPT  0x%08X", node->gam_gdp_ppt);
-	gdp_dbg_ppt(s, node->gam_gdp_ppt);
-	seq_printf(s, "\n\tCML  0x%08X\n", node->gam_gdp_cml);
+	drm_printf(p, "\t@:0x%pK", node);
+	drm_printf(p, "\n\t\tCTL  0x%08X", node->gam_gdp_ctl);
+	gdp_dbg_ctl(p, node->gam_gdp_ctl);
+	drm_printf(p, "\n\t\tAGC  0x%08X", node->gam_gdp_agc);
+	drm_printf(p, "\n\t\tVPO  0x%08X", node->gam_gdp_vpo);
+	gdp_dbg_vpo(p, node->gam_gdp_vpo);
+	drm_printf(p, "\n\t\tVPS  0x%08X", node->gam_gdp_vps);
+	gdp_dbg_vps(p, node->gam_gdp_vps);
+	drm_printf(p, "\n\t\tPML  0x%08X", node->gam_gdp_pml);
+	drm_printf(p, "\n\t\tPMP  0x%08X", node->gam_gdp_pmp);
+	drm_printf(p, "\n\t\tSIZE 0x%08X", node->gam_gdp_size);
+	gdp_dbg_size(p, node->gam_gdp_size);
+	drm_printf(p, "\n\t\tNVN  0x%08X", node->gam_gdp_nvn);
+	drm_printf(p, "\n\t\tKEY1 0x%08X", node->gam_gdp_key1);
+	drm_printf(p, "\n\t\tKEY2 0x%08X", node->gam_gdp_key2);
+	drm_printf(p, "\n\t\tPPT  0x%08X", node->gam_gdp_ppt);
+	gdp_dbg_ppt(p, node->gam_gdp_ppt);
+	drm_printf(p, "\n\t\tCML  0x%08X\n", node->gam_gdp_cml);
 }
 
-static int gdp_node_dbg_show(struct seq_file *s, void *arg)
+static void sti_gdp_plane_print_state(struct drm_printer *p,
+				      const struct drm_plane_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_gdp *gdp = (struct sti_gdp *)node->info_ent->data;
+	struct sti_plane *plane = to_sti_plane(state->plane);
+	struct sti_gdp *gdp = to_sti_gdp(plane);
 	unsigned int b;
 
-	for (b = 0; b < GDP_NODE_NB_BANK; b++) {
-		seq_printf(s, "\n%s[%d].top", sti_plane_to_str(&gdp->plane), b);
-		gdp_node_dump_node(s, gdp->node_list[b].top_field);
-		seq_printf(s, "\n%s[%d].btm", sti_plane_to_str(&gdp->plane), b);
-		gdp_node_dump_node(s, gdp->node_list[b].btm_field);
-	}
-
-	return 0;
-}
-
-static struct drm_info_list gdp0_debugfs_files[] = {
-	{ "gdp0", gdp_dbg_show, 0, NULL },
-	{ "gdp0_node", gdp_node_dbg_show, 0, NULL },
-};
-
-static struct drm_info_list gdp1_debugfs_files[] = {
-	{ "gdp1", gdp_dbg_show, 0, NULL },
-	{ "gdp1_node", gdp_node_dbg_show, 0, NULL },
-};
-
-static struct drm_info_list gdp2_debugfs_files[] = {
-	{ "gdp2", gdp_dbg_show, 0, NULL },
-	{ "gdp2_node", gdp_node_dbg_show, 0, NULL },
-};
-
-static struct drm_info_list gdp3_debugfs_files[] = {
-	{ "gdp3", gdp_dbg_show, 0, NULL },
-	{ "gdp3_node", gdp_node_dbg_show, 0, NULL },
-};
-
-static int gdp_debugfs_init(struct sti_gdp *gdp, struct drm_minor *minor)
-{
-	unsigned int i;
-	struct drm_info_list *gdp_debugfs_files;
-	int nb_files;
+	gdp_dbg_show(p, gdp);
 
-	switch (gdp->plane.desc) {
-	case STI_GDP_0:
-		gdp_debugfs_files = gdp0_debugfs_files;
-		nb_files = ARRAY_SIZE(gdp0_debugfs_files);
-		break;
-	case STI_GDP_1:
-		gdp_debugfs_files = gdp1_debugfs_files;
-		nb_files = ARRAY_SIZE(gdp1_debugfs_files);
-		break;
-	case STI_GDP_2:
-		gdp_debugfs_files = gdp2_debugfs_files;
-		nb_files = ARRAY_SIZE(gdp2_debugfs_files);
-		break;
-	case STI_GDP_3:
-		gdp_debugfs_files = gdp3_debugfs_files;
-		nb_files = ARRAY_SIZE(gdp3_debugfs_files);
-		break;
-	default:
-		return -EINVAL;
+	for (b = 0; b < GDP_NODE_NB_BANK; b++) {
+		drm_printf(p, "\t%s[%d].top\n",
+			   sti_plane_to_str(&gdp->plane), b);
+		gdp_node_dump_node(p, gdp->node_list[b].top_field);
+		drm_printf(p, "\t%s[%d].btm\n",
+			   sti_plane_to_str(&gdp->plane), b);
+		gdp_node_dump_node(p, gdp->node_list[b].btm_field);
 	}
 
-	for (i = 0; i < nb_files; i++)
-		gdp_debugfs_files[i].data = gdp;
-
-	return drm_debugfs_create_files(gdp_debugfs_files,
-					nb_files,
-					minor->debugfs_root, minor);
+	drm_printf(p, "\t%s%s\n",
+		   plane->fps_info.fps_str, plane->fps_info.fips_str);
 }
 
 static int sti_gdp_fourcc2format(int fourcc)
@@ -887,14 +823,6 @@ static void sti_gdp_destroy(struct drm_plane *drm_plane)
 	drm_plane_cleanup(drm_plane);
 }
 
-static int sti_gdp_late_register(struct drm_plane *drm_plane)
-{
-	struct sti_plane *plane = to_sti_plane(drm_plane);
-	struct sti_gdp *gdp = to_sti_gdp(plane);
-
-	return gdp_debugfs_init(gdp, drm_plane->dev->primary);
-}
-
 static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -902,7 +830,7 @@ static const struct drm_plane_funcs sti_gdp_plane_helpers_funcs = {
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.late_register = sti_gdp_late_register,
+	.atomic_print_state = sti_gdp_plane_print_state,
 };
 
 struct drm_plane *sti_gdp_create(struct drm_device *drm_dev,
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 106be8c4e58b..f218f636966c 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -441,7 +441,7 @@ static int sti_hqvdp_get_next_cmd(struct sti_hqvdp *hqvdp)
 	return -1;
 }
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(hqvdp->regs + reg))
 
 static const char *hqvdp_dbg_get_lut(u32 *coef)
@@ -469,99 +469,100 @@ static const char *hqvdp_dbg_get_lut(u32 *coef)
 	return "<UNKNOWN>";
 }
 
-static void hqvdp_dbg_dump_cmd(struct seq_file *s, struct sti_hqvdp_cmd *c)
+static void hqvdp_dbg_dump_cmd(struct drm_printer *p, struct sti_hqvdp_cmd *c)
 {
 	int src_w, src_h, dst_w, dst_h;
 
-	seq_puts(s, "\n\tTOP:");
-	seq_printf(s, "\n\t %-20s 0x%08X", "Config", c->top.config);
+	drm_printf(p, "\n\tTOP:");
+	drm_printf(p, "\n\t %-20s 0x%08X", "Config", c->top.config);
 	switch (c->top.config) {
 	case TOP_CONFIG_PROGRESSIVE:
-		seq_puts(s, "\tProgressive");
+		drm_printf(p, "\tProgressive");
 		break;
 	case TOP_CONFIG_INTER_TOP:
-		seq_puts(s, "\tInterlaced, top field");
+		drm_printf(p, "\tInterlaced, top field");
 		break;
 	case TOP_CONFIG_INTER_BTM:
-		seq_puts(s, "\tInterlaced, bottom field");
+		drm_printf(p, "\tInterlaced, bottom field");
 		break;
 	default:
-		seq_puts(s, "\t<UNKNOWN>");
+		drm_printf(p, "\t<UNKNOWN>");
 		break;
 	}
 
-	seq_printf(s, "\n\t %-20s 0x%08X", "MemFormat", c->top.mem_format);
-	seq_printf(s, "\n\t %-20s 0x%08X", "CurrentY", c->top.current_luma);
-	seq_printf(s, "\n\t %-20s 0x%08X", "CurrentC", c->top.current_chroma);
-	seq_printf(s, "\n\t %-20s 0x%08X", "YSrcPitch", c->top.luma_src_pitch);
-	seq_printf(s, "\n\t %-20s 0x%08X", "CSrcPitch",
+	drm_printf(p, "\n\t %-20s 0x%08X", "MemFormat", c->top.mem_format);
+	drm_printf(p, "\n\t %-20s 0x%08X", "CurrentY", c->top.current_luma);
+	drm_printf(p, "\n\t %-20s 0x%08X", "CurrentC", c->top.current_chroma);
+	drm_printf(p, "\n\t %-20s 0x%08X", "YSrcPitch", c->top.luma_src_pitch);
+	drm_printf(p, "\n\t %-20s 0x%08X", "CSrcPitch",
 		   c->top.chroma_src_pitch);
-	seq_printf(s, "\n\t %-20s 0x%08X", "InputFrameSize",
+	drm_printf(p, "\n\t %-20s 0x%08X", "InputFrameSize",
 		   c->top.input_frame_size);
-	seq_printf(s, "\t%dx%d",
+	drm_printf(p, "\t%dx%d",
 		   c->top.input_frame_size & 0x0000FFFF,
 		   c->top.input_frame_size >> 16);
-	seq_printf(s, "\n\t %-20s 0x%08X", "InputViewportSize",
+	drm_printf(p, "\n\t %-20s 0x%08X", "InputViewportSize",
 		   c->top.input_viewport_size);
 	src_w = c->top.input_viewport_size & 0x0000FFFF;
 	src_h = c->top.input_viewport_size >> 16;
-	seq_printf(s, "\t%dx%d", src_w, src_h);
+	drm_printf(p, "\t%dx%d", src_w, src_h);
 
-	seq_puts(s, "\n\tHVSRC:");
-	seq_printf(s, "\n\t %-20s 0x%08X", "OutputPictureSize",
+	drm_printf(p, "\n\tHVSRC:");
+	drm_printf(p, "\n\t %-20s 0x%08X", "OutputPictureSize",
 		   c->hvsrc.output_picture_size);
 	dst_w = c->hvsrc.output_picture_size & 0x0000FFFF;
 	dst_h = c->hvsrc.output_picture_size >> 16;
-	seq_printf(s, "\t%dx%d", dst_w, dst_h);
-	seq_printf(s, "\n\t %-20s 0x%08X", "ParamCtrl", c->hvsrc.param_ctrl);
+	drm_printf(p, "\t%dx%d", dst_w, dst_h);
+	drm_printf(p, "\n\t %-20s 0x%08X", "ParamCtrl", c->hvsrc.param_ctrl);
 
-	seq_printf(s, "\n\t %-20s %s", "yh_coef",
+	drm_printf(p, "\n\t %-20s %s", "yh_coef",
 		   hqvdp_dbg_get_lut(c->hvsrc.yh_coef));
-	seq_printf(s, "\n\t %-20s %s", "ch_coef",
+	drm_printf(p, "\n\t %-20s %s", "ch_coef",
 		   hqvdp_dbg_get_lut(c->hvsrc.ch_coef));
-	seq_printf(s, "\n\t %-20s %s", "yv_coef",
+	drm_printf(p, "\n\t %-20s %s", "yv_coef",
 		   hqvdp_dbg_get_lut(c->hvsrc.yv_coef));
-	seq_printf(s, "\n\t %-20s %s", "cv_coef",
+	drm_printf(p, "\n\t %-20s %s", "cv_coef",
 		   hqvdp_dbg_get_lut(c->hvsrc.cv_coef));
 
-	seq_printf(s, "\n\t %-20s", "ScaleH");
+	drm_printf(p, "\n\t %-20s", "ScaleH");
 	if (dst_w > src_w)
-		seq_printf(s, " %d/1", dst_w / src_w);
+		drm_printf(p, " %d/1", dst_w / src_w);
 	else
-		seq_printf(s, " 1/%d", src_w / dst_w);
+		drm_printf(p, " 1/%d", src_w / dst_w);
 
-	seq_printf(s, "\n\t %-20s", "tScaleV");
+	drm_printf(p, "\n\t %-20s", "tScaleV");
 	if (dst_h > src_h)
-		seq_printf(s, " %d/1", dst_h / src_h);
+		drm_printf(p, " %d/1", dst_h / src_h);
 	else
-		seq_printf(s, " 1/%d", src_h / dst_h);
+		drm_printf(p, " 1/%d", src_h / dst_h);
 
-	seq_puts(s, "\n\tCSDI:");
-	seq_printf(s, "\n\t %-20s 0x%08X\t", "Config", c->csdi.config);
+	drm_printf(p, "\n\tCSDI:");
+	drm_printf(p, "\n\t %-20s 0x%08X\t", "Config", c->csdi.config);
 	switch (c->csdi.config) {
 	case CSDI_CONFIG_PROG:
-		seq_puts(s, "Bypass");
+		drm_printf(p, "Bypass");
 		break;
 	case CSDI_CONFIG_INTER_DIR:
-		seq_puts(s, "Deinterlace, directional");
+		drm_printf(p, "Deinterlace, directional");
 		break;
 	default:
-		seq_puts(s, "<UNKNOWN>");
+		drm_printf(p, "<UNKNOWN>");
 		break;
 	}
 
-	seq_printf(s, "\n\t %-20s 0x%08X", "Config2", c->csdi.config2);
-	seq_printf(s, "\n\t %-20s 0x%08X", "DcdiConfig", c->csdi.dcdi_config);
+	drm_printf(p, "\n\t %-20s 0x%08X", "Config2", c->csdi.config2);
+	drm_printf(p, "\n\t %-20s 0x%08X", "DcdiConfig", c->csdi.dcdi_config);
 }
 
-static int hqvdp_dbg_show(struct seq_file *s, void *data)
+static void sti_hqvdp_plane_print_state(struct drm_printer *p,
+					const struct drm_plane_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_hqvdp *hqvdp = (struct sti_hqvdp *)node->info_ent->data;
+	struct sti_plane *plane = to_sti_plane(state->plane);
+	struct sti_hqvdp *hqvdp = to_sti_hqvdp(plane);
 	int cmd, cmd_offset, infoxp70;
 	void *virt;
 
-	seq_printf(s, "%s: (vaddr = 0x%p)",
+	drm_printf(p, "\t%s: (vaddr = 0x%pK)",
 		   sti_plane_to_str(&hqvdp->plane), hqvdp->regs);
 
 	DBGFS_DUMP(HQVDP_MBX_IRQ_TO_XP70);
@@ -569,80 +570,64 @@ static int hqvdp_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP(HQVDP_MBX_IRQ_TO_HOST);
 	DBGFS_DUMP(HQVDP_MBX_INFO_XP70);
 	infoxp70 = readl(hqvdp->regs + HQVDP_MBX_INFO_XP70);
-	seq_puts(s, "\tFirmware state: ");
+	drm_printf(p, "\tFirmware state: ");
 	if (infoxp70 & INFO_XP70_FW_READY)
-		seq_puts(s, "idle and ready");
+		drm_printf(p, "idle and ready");
 	else if (infoxp70 & INFO_XP70_FW_PROCESSING)
-		seq_puts(s, "processing a picture");
+		drm_printf(p, "processing a picture");
 	else if (infoxp70 & INFO_XP70_FW_INITQUEUES)
-		seq_puts(s, "programming queues");
+		drm_printf(p, "programming queues");
 	else
-		seq_puts(s, "NOT READY");
+		drm_printf(p, "NOT READY");
 
 	DBGFS_DUMP(HQVDP_MBX_SW_RESET_CTRL);
 	DBGFS_DUMP(HQVDP_MBX_STARTUP_CTRL1);
 	if (readl(hqvdp->regs + HQVDP_MBX_STARTUP_CTRL1)
 					& STARTUP_CTRL1_RST_DONE)
-		seq_puts(s, "\tReset is done");
+		drm_printf(p, "\tReset is done");
 	else
-		seq_puts(s, "\tReset is NOT done");
+		drm_printf(p, "\tReset is NOT done");
 	DBGFS_DUMP(HQVDP_MBX_STARTUP_CTRL2);
 	if (readl(hqvdp->regs + HQVDP_MBX_STARTUP_CTRL2)
 					& STARTUP_CTRL2_FETCH_EN)
-		seq_puts(s, "\tFetch is enabled");
+		drm_printf(p, "\tFetch is enabled");
 	else
-		seq_puts(s, "\tFetch is NOT enabled");
+		drm_printf(p, "\tFetch is NOT enabled");
 	DBGFS_DUMP(HQVDP_MBX_GP_STATUS);
 	DBGFS_DUMP(HQVDP_MBX_NEXT_CMD);
 	DBGFS_DUMP(HQVDP_MBX_CURRENT_CMD);
 	DBGFS_DUMP(HQVDP_MBX_SOFT_VSYNC);
 	if (!(readl(hqvdp->regs + HQVDP_MBX_SOFT_VSYNC) & 3))
-		seq_puts(s, "\tHW Vsync");
+		drm_printf(p, "\tHW Vsync");
 	else
-		seq_puts(s, "\tSW Vsync ?!?!");
+		drm_printf(p, "\tSW Vsync ?!?!");
 
 	/* Last command */
 	cmd = readl(hqvdp->regs + HQVDP_MBX_CURRENT_CMD);
 	cmd_offset = sti_hqvdp_get_curr_cmd(hqvdp);
 	if (cmd_offset == -1) {
-		seq_puts(s, "\n\n  Last command: unknown");
+		drm_printf(p, "\n\n\t\tLast command: unknown");
 	} else {
 		virt = hqvdp->hqvdp_cmd + cmd_offset;
-		seq_printf(s, "\n\n  Last command: address @ 0x%x (0x%p)",
+		drm_printf(p, "\n\n\t\tLast command: address @ 0x%x (0x%p)",
 			   cmd, virt);
-		hqvdp_dbg_dump_cmd(s, (struct sti_hqvdp_cmd *)virt);
+		hqvdp_dbg_dump_cmd(p, (struct sti_hqvdp_cmd *)virt);
 	}
 
 	/* Next command */
 	cmd = readl(hqvdp->regs + HQVDP_MBX_NEXT_CMD);
 	cmd_offset = sti_hqvdp_get_next_cmd(hqvdp);
 	if (cmd_offset == -1) {
-		seq_puts(s, "\n\n  Next command: unknown");
+		drm_printf(p, "\n\n\t\tNext command: unknown");
 	} else {
 		virt = hqvdp->hqvdp_cmd + cmd_offset;
-		seq_printf(s, "\n\n  Next command address: @ 0x%x (0x%p)",
+		drm_printf(p, "\n\n\t\tNext command address: @ 0x%x (0x%p)",
 			   cmd, virt);
-		hqvdp_dbg_dump_cmd(s, (struct sti_hqvdp_cmd *)virt);
+		hqvdp_dbg_dump_cmd(p, (struct sti_hqvdp_cmd *)virt);
 	}
 
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list hqvdp_debugfs_files[] = {
-	{ "hqvdp", hqvdp_dbg_show, 0, NULL },
-};
-
-static int hqvdp_debugfs_init(struct sti_hqvdp *hqvdp, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(hqvdp_debugfs_files); i++)
-		hqvdp_debugfs_files[i].data = hqvdp;
-
-	return drm_debugfs_create_files(hqvdp_debugfs_files,
-					ARRAY_SIZE(hqvdp_debugfs_files),
-					minor->debugfs_root, minor);
+	drm_printf(p, "\t%s%s\n",
+		   plane->fps_info.fps_str, plane->fps_info.fips_str);
 }
 
 /**
@@ -1264,14 +1249,6 @@ static void sti_hqvdp_destroy(struct drm_plane *drm_plane)
 	drm_plane_cleanup(drm_plane);
 }
 
-static int sti_hqvdp_late_register(struct drm_plane *drm_plane)
-{
-	struct sti_plane *plane = to_sti_plane(drm_plane);
-	struct sti_hqvdp *hqvdp = to_sti_hqvdp(plane);
-
-	return hqvdp_debugfs_init(hqvdp, drm_plane->dev->primary);
-}
-
 static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -1279,7 +1256,7 @@ static const struct drm_plane_funcs sti_hqvdp_plane_helpers_funcs = {
 	.reset = sti_plane_reset,
 	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
-	.late_register = sti_hqvdp_late_register,
+	.atomic_print_state = sti_hqvdp_plane_print_state,
 };
 
 static struct drm_plane *sti_hqvdp_create(struct drm_device *drm_dev,
-- 
2.15.0
