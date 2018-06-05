Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbeFENzf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:55:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51797 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeFENya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:30 -0400
X-Google-Smtp-Source: ADUXVKLtQ/c82TYkM7C0A3EoMmm5Dd3+/9GAaa1GdOUEXQcGyn9MzYm2a/ATfGPSUTAy3jWINEtawQ==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 4/7] drm: sti: make connectors use atomic_print_state instead of debugfs
Date: Tue,  5 Jun 2018 15:54:04 +0200
Message-Id: <20180605135407.20214-5-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all sti connectors to atomic_print_state usage rather than
use a debugfs entry.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_dvo.c  |  60 +++++--------------
 drivers/gpu/drm/sti/sti_hda.c  |  75 +++++++----------------
 drivers/gpu/drm/sti/sti_hdmi.c | 132 ++++++++++++++++-------------------------
 3 files changed, 90 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index a5979cd25cc7..5662613ae6e0 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -6,7 +6,6 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
-#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
@@ -158,52 +157,37 @@ static void dvo_awg_configure(struct sti_dvo *dvo, u32 *awg_ram_code, int nb)
 	writel(DVO_AWG_CTRL_EN, dvo->regs + DVO_AWG_DIGSYNC_CTRL);
 }
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(dvo->regs + reg))
 
-static void dvo_dbg_awg_microcode(struct seq_file *s, void __iomem *reg)
+static void dvo_dbg_awg_microcode(struct drm_printer *p, void __iomem *reg)
 {
 	unsigned int i;
 
-	seq_puts(s, "\n\n");
-	seq_puts(s, "  DVO AWG microcode:");
+	drm_printf(p, "\n\n");
+	drm_printf(p, "  DVO AWG microcode:");
 	for (i = 0; i < AWG_MAX_INST; i++) {
 		if (i % 8 == 0)
-			seq_printf(s, "\n  %04X:", i);
-		seq_printf(s, " %04X", readl(reg + i * 4));
+			drm_printf(p, "\n  %04X:", i);
+		drm_printf(p, " %04X", readl(reg + i * 4));
 	}
 }
 
-static int dvo_dbg_show(struct seq_file *s, void *data)
+static void sti_dvo_print_state(struct drm_printer *p,
+				const struct drm_connector_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_dvo *dvo = (struct sti_dvo *)node->info_ent->data;
+	struct sti_dvo_connector *dvo_connector
+		= to_sti_dvo_connector(state->connector);
+	struct sti_dvo *dvo = dvo_connector->dvo;
 
-	seq_printf(s, "DVO: (vaddr = 0x%p)", dvo->regs);
+	drm_printf(p, "DVO: (vaddr = 0x%p)", dvo->regs);
 	DBGFS_DUMP(DVO_AWG_DIGSYNC_CTRL);
 	DBGFS_DUMP(DVO_DOF_CFG);
 	DBGFS_DUMP(DVO_LUT_PROG_LOW);
 	DBGFS_DUMP(DVO_LUT_PROG_MID);
 	DBGFS_DUMP(DVO_LUT_PROG_HIGH);
-	dvo_dbg_awg_microcode(s, dvo->regs + DVO_DIGSYNC_INSTR_I);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list dvo_debugfs_files[] = {
-	{ "dvo", dvo_dbg_show, 0, NULL },
-};
-
-static int dvo_debugfs_init(struct sti_dvo *dvo, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(dvo_debugfs_files); i++)
-		dvo_debugfs_files[i].data = dvo;
-
-	return drm_debugfs_create_files(dvo_debugfs_files,
-					ARRAY_SIZE(dvo_debugfs_files),
-					minor->debugfs_root, minor);
+	dvo_dbg_awg_microcode(p, dvo->regs + DVO_DIGSYNC_INSTR_I);
+	drm_printf(p, "\n");
 }
 
 static void sti_dvo_disable(struct drm_bridge *bridge)
@@ -397,20 +381,6 @@ sti_dvo_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_disconnected;
 }
 
-static int sti_dvo_late_register(struct drm_connector *connector)
-{
-	struct sti_dvo_connector *dvo_connector
-		= to_sti_dvo_connector(connector);
-	struct sti_dvo *dvo = dvo_connector->dvo;
-
-	if (dvo_debugfs_init(dvo, dvo->drm_dev->primary)) {
-		DRM_ERROR("DVO debugfs setup failed\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static const struct drm_connector_funcs sti_dvo_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = sti_dvo_connector_detect,
@@ -418,7 +388,7 @@ static const struct drm_connector_funcs sti_dvo_connector_funcs = {
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-	.late_register = sti_dvo_late_register,
+	.atomic_print_state = sti_dvo_print_state,
 };
 
 static struct drm_encoder *sti_dvo_find_encoder(struct drm_device *dev)
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 67bbdb49fffc..0734f2751505 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -307,71 +307,56 @@ static void hda_enable_hd_dacs(struct sti_hda *hda, bool enable)
 	}
 }
 
-#define DBGFS_DUMP(reg) seq_printf(s, "\n  %-25s 0x%08X", #reg, \
+#define DBGFS_DUMP(reg) drm_printf(p, "\n\t\t%-25s 0x%08X", #reg, \
 				   readl(hda->regs + reg))
 
-static void hda_dbg_cfg(struct seq_file *s, int val)
+static void hda_dbg_cfg(struct drm_printer *p, int val)
 {
-	seq_puts(s, "\tAWG ");
-	seq_puts(s, val & CFG_AWG_ASYNC_EN ? "enabled" : "disabled");
+	drm_printf(p, "\tAWG ");
+	drm_printf(p, val & CFG_AWG_ASYNC_EN ? "enabled" : "disabled");
 }
 
-static void hda_dbg_awg_microcode(struct seq_file *s, void __iomem *reg)
+static void hda_dbg_awg_microcode(struct drm_printer *p, void __iomem *reg)
 {
 	unsigned int i;
 
-	seq_puts(s, "\n\n  HDA AWG microcode:");
+	drm_printf(p, "\n\n  HDA AWG microcode:");
 	for (i = 0; i < AWG_MAX_INST; i++) {
 		if (i % 8 == 0)
-			seq_printf(s, "\n  %04X:", i);
-		seq_printf(s, " %04X", readl(reg + i * 4));
+			drm_printf(p, "\n  %04X:", i);
+		drm_printf(p, " %04X", readl(reg + i * 4));
 	}
 }
 
-static void hda_dbg_video_dacs_ctrl(struct seq_file *s, void __iomem *reg)
+static void hda_dbg_video_dacs_ctrl(struct drm_printer *p, void __iomem *reg)
 {
 	u32 val = readl(reg);
 
-	seq_printf(s, "\n\n  %-25s 0x%08X", "VIDEO_DACS_CONTROL", val);
-	seq_puts(s, "\tHD DACs ");
-	seq_puts(s, val & DAC_CFG_HD_HZUVW_OFF_MASK ? "disabled" : "enabled");
+	drm_printf(p, "\n\n  %-25s 0x%08X", "VIDEO_DACS_CONTROL", val);
+	drm_printf(p, "\tHD DACs ");
+	drm_printf(p, val & DAC_CFG_HD_HZUVW_OFF_MASK ? "disabled" : "enabled");
 }
 
-static int hda_dbg_show(struct seq_file *s, void *data)
+static void sti_hda_print_state(struct drm_printer *p,
+				const struct drm_connector_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_hda *hda = (struct sti_hda *)node->info_ent->data;
+	struct sti_hda_connector *hda_connector
+		= to_sti_hda_connector(state->connector);
+	struct sti_hda *hda = hda_connector->hda;
 
-	seq_printf(s, "HD Analog: (vaddr = 0x%p)", hda->regs);
+	drm_printf(p, "HD Analog: (vaddr = 0x%pK)", hda->regs);
 	DBGFS_DUMP(HDA_ANA_CFG);
-	hda_dbg_cfg(s, readl(hda->regs + HDA_ANA_CFG));
+	hda_dbg_cfg(p, readl(hda->regs + HDA_ANA_CFG));
 	DBGFS_DUMP(HDA_ANA_SCALE_CTRL_Y);
 	DBGFS_DUMP(HDA_ANA_SCALE_CTRL_CB);
 	DBGFS_DUMP(HDA_ANA_SCALE_CTRL_CR);
 	DBGFS_DUMP(HDA_ANA_ANC_CTRL);
 	DBGFS_DUMP(HDA_ANA_SRC_Y_CFG);
 	DBGFS_DUMP(HDA_ANA_SRC_C_CFG);
-	hda_dbg_awg_microcode(s, hda->regs + HDA_SYNC_AWGI);
+	hda_dbg_awg_microcode(p, hda->regs + HDA_SYNC_AWGI);
 	if (hda->video_dacs_ctrl)
-		hda_dbg_video_dacs_ctrl(s, hda->video_dacs_ctrl);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list hda_debugfs_files[] = {
-	{ "hda", hda_dbg_show, 0, NULL },
-};
-
-static int hda_debugfs_init(struct sti_hda *hda, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(hda_debugfs_files); i++)
-		hda_debugfs_files[i].data = hda;
-
-	return drm_debugfs_create_files(hda_debugfs_files,
-					ARRAY_SIZE(hda_debugfs_files),
-					minor->debugfs_root, minor);
+		hda_dbg_video_dacs_ctrl(p, hda->video_dacs_ctrl);
+	drm_printf(p, "\n");
 }
 
 /**
@@ -632,27 +617,13 @@ struct drm_connector_helper_funcs sti_hda_connector_helper_funcs = {
 	.mode_valid = sti_hda_connector_mode_valid,
 };
 
-static int sti_hda_late_register(struct drm_connector *connector)
-{
-	struct sti_hda_connector *hda_connector
-		= to_sti_hda_connector(connector);
-	struct sti_hda *hda = hda_connector->hda;
-
-	if (hda_debugfs_init(hda, hda->drm_dev->primary)) {
-		DRM_ERROR("HDA debugfs setup failed\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static const struct drm_connector_funcs sti_hda_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-	.late_register = sti_hda_late_register,
+	.atomic_print_state = sti_hda_print_state,
 };
 
 static struct drm_encoder *sti_hda_find_encoder(struct drm_device *dev)
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 58f431102512..b1313b3321bf 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -584,49 +584,49 @@ static void hdmi_swreset(struct sti_hdmi *hdmi)
 	clk_disable_unprepare(hdmi->clk_audio);
 }
 
-#define DBGFS_PRINT_STR(str1, str2) seq_printf(s, "%-24s %s\n", str1, str2)
-#define DBGFS_PRINT_INT(str1, int2) seq_printf(s, "%-24s %d\n", str1, int2)
-#define DBGFS_DUMP(str, reg) seq_printf(s, "%s  %-25s 0x%08X", str, #reg, \
+#define DBGFS_PRINT_STR(str1, str2) drm_printf(p, "%-24s %s\n", str1, str2)
+#define DBGFS_PRINT_INT(str1, int2) drm_printf(p, "%-24s %d\n", str1, int2)
+#define DBGFS_DUMP(str, reg) drm_printf(p, "%s\t%-25s 0x%08X", str, #reg, \
 					hdmi_read(hdmi, reg))
-#define DBGFS_DUMP_DI(reg, slot) DBGFS_DUMP("\n", reg(slot))
+#define DBGFS_DUMP_DI(reg, slot) DBGFS_DUMP("\n\t\t", reg(slot))
 
-static void hdmi_dbg_cfg(struct seq_file *s, int val)
+static void hdmi_dbg_cfg(struct drm_printer *p, int val)
 {
 	int tmp;
 
-	seq_putc(s, '\t');
+	drm_printf(p, "\t");
 	tmp = val & HDMI_CFG_HDMI_NOT_DVI;
 	DBGFS_PRINT_STR("mode:", tmp ? "HDMI" : "DVI");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = val & HDMI_CFG_HDCP_EN;
 	DBGFS_PRINT_STR("HDCP:", tmp ? "enable" : "disable");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = val & HDMI_CFG_ESS_NOT_OESS;
 	DBGFS_PRINT_STR("HDCP mode:", tmp ? "ESS enable" : "OESS enable");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = val & HDMI_CFG_H_SYNC_POL_NEG;
 	DBGFS_PRINT_STR("Hsync polarity:", tmp ? "inverted" : "normal");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = val & HDMI_CFG_V_SYNC_POL_NEG;
 	DBGFS_PRINT_STR("Vsync polarity:", tmp ? "inverted" : "normal");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = val & HDMI_CFG_422_EN;
 	DBGFS_PRINT_STR("YUV422 format:", tmp ? "enable" : "disable");
 }
 
-static void hdmi_dbg_sta(struct seq_file *s, int val)
+static void hdmi_dbg_sta(struct drm_printer *p, int val)
 {
 	int tmp;
 
-	seq_putc(s, '\t');
+	drm_printf(p, "\t");
 	tmp = (val & HDMI_STA_DLL_LCK);
 	DBGFS_PRINT_STR("pll:", tmp ? "locked" : "not locked");
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_STA_HOT_PLUG);
 	DBGFS_PRINT_STR("hdmi cable:", tmp ? "connected" : "not connected");
 }
 
-static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
+static void hdmi_dbg_sw_di_cfg(struct drm_printer *p, int val)
 {
 	int tmp;
 	char *const en_di[] = {"no transmission",
@@ -634,57 +634,59 @@ static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
 			       "once every field",
 			       "once every frame"};
 
-	seq_putc(s, '\t');
+	drm_printf(p, "\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 1));
 	DBGFS_PRINT_STR("Data island 1:", en_di[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 2)) >> 4;
 	DBGFS_PRINT_STR("Data island 2:", en_di[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 3)) >> 8;
 	DBGFS_PRINT_STR("Data island 3:", en_di[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 4)) >> 12;
 	DBGFS_PRINT_STR("Data island 4:", en_di[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 5)) >> 16;
 	DBGFS_PRINT_STR("Data island 5:", en_di[tmp]);
-	seq_puts(s, "\t\t\t\t\t");
+	drm_printf(p, "\t\t\t\t\t");
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 6)) >> 20;
 	DBGFS_PRINT_STR("Data island 6:", en_di[tmp]);
 }
 
-static int hdmi_dbg_show(struct seq_file *s, void *data)
+static void sti_hdmi_print_state(struct drm_printer *p,
+				 const struct drm_connector_state *state)
 {
-	struct drm_info_node *node = s->private;
-	struct sti_hdmi *hdmi = (struct sti_hdmi *)node->info_ent->data;
-
-	seq_printf(s, "HDMI: (vaddr = 0x%p)", hdmi->regs);
-	DBGFS_DUMP("\n", HDMI_CFG);
-	hdmi_dbg_cfg(s, hdmi_read(hdmi, HDMI_CFG));
-	DBGFS_DUMP("", HDMI_INT_EN);
-	DBGFS_DUMP("\n", HDMI_STA);
-	hdmi_dbg_sta(s, hdmi_read(hdmi, HDMI_STA));
-	DBGFS_DUMP("", HDMI_ACTIVE_VID_XMIN);
-	seq_putc(s, '\t');
+	struct sti_hdmi_connector *hdmi_connector
+		= to_sti_hdmi_connector(state->connector);
+	struct sti_hdmi *hdmi = hdmi_connector->hdmi;
+
+	drm_printf(p, "\tHDMI: (vaddr = 0x%pK)", hdmi->regs);
+	DBGFS_DUMP("\n\t\t", HDMI_CFG);
+	hdmi_dbg_cfg(p, hdmi_read(hdmi, HDMI_CFG));
+	DBGFS_DUMP("\t\t", HDMI_INT_EN);
+	DBGFS_DUMP("\n\t\t", HDMI_STA);
+	hdmi_dbg_sta(p, hdmi_read(hdmi, HDMI_STA));
+	DBGFS_DUMP("\t\t", HDMI_ACTIVE_VID_XMIN);
+	drm_printf(p, "\t");
 	DBGFS_PRINT_INT("Xmin:", hdmi_read(hdmi, HDMI_ACTIVE_VID_XMIN));
-	DBGFS_DUMP("", HDMI_ACTIVE_VID_XMAX);
-	seq_putc(s, '\t');
+	DBGFS_DUMP("\t\t", HDMI_ACTIVE_VID_XMAX);
+	drm_printf(p, "\t");
 	DBGFS_PRINT_INT("Xmax:", hdmi_read(hdmi, HDMI_ACTIVE_VID_XMAX));
-	DBGFS_DUMP("", HDMI_ACTIVE_VID_YMIN);
-	seq_putc(s, '\t');
+	DBGFS_DUMP("\t\t", HDMI_ACTIVE_VID_YMIN);
+	drm_printf(p, "\t");
 	DBGFS_PRINT_INT("Ymin:", hdmi_read(hdmi, HDMI_ACTIVE_VID_YMIN));
-	DBGFS_DUMP("", HDMI_ACTIVE_VID_YMAX);
-	seq_putc(s, '\t');
+	DBGFS_DUMP("\t\t", HDMI_ACTIVE_VID_YMAX);
+	drm_printf(p, "\t");
 	DBGFS_PRINT_INT("Ymax:", hdmi_read(hdmi, HDMI_ACTIVE_VID_YMAX));
-	DBGFS_DUMP("", HDMI_SW_DI_CFG);
-	hdmi_dbg_sw_di_cfg(s, hdmi_read(hdmi, HDMI_SW_DI_CFG));
+	DBGFS_DUMP("\t\t", HDMI_SW_DI_CFG);
+	hdmi_dbg_sw_di_cfg(p, hdmi_read(hdmi, HDMI_SW_DI_CFG));
 
-	DBGFS_DUMP("\n", HDMI_AUDIO_CFG);
-	DBGFS_DUMP("\n", HDMI_SPDIF_FIFO_STATUS);
-	DBGFS_DUMP("\n", HDMI_AUDN);
+	DBGFS_DUMP("\n\t\t", HDMI_AUDIO_CFG);
+	DBGFS_DUMP("\n\t\t", HDMI_SPDIF_FIFO_STATUS);
+	DBGFS_DUMP("\n\t\t", HDMI_AUDN);
 
-	seq_printf(s, "\n AVI Infoframe (Data Island slot N=%d):",
+	drm_printf(p, "\n\t\tAVI Infoframe (Data Island slot N=%d):",
 		   HDMI_IFRAME_SLOT_AVI);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_HEAD_WORD, HDMI_IFRAME_SLOT_AVI);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD0, HDMI_IFRAME_SLOT_AVI);
@@ -694,7 +696,7 @@ static int hdmi_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD4, HDMI_IFRAME_SLOT_AVI);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD5, HDMI_IFRAME_SLOT_AVI);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD6, HDMI_IFRAME_SLOT_AVI);
-	seq_printf(s, "\n\n AUDIO Infoframe (Data Island slot N=%d):",
+	drm_printf(p, "\n\t\tAUDIO Infoframe (Data Island slot N=%d):",
 		   HDMI_IFRAME_SLOT_AUDIO);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_HEAD_WORD, HDMI_IFRAME_SLOT_AUDIO);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD0, HDMI_IFRAME_SLOT_AUDIO);
@@ -704,7 +706,8 @@ static int hdmi_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD4, HDMI_IFRAME_SLOT_AUDIO);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD5, HDMI_IFRAME_SLOT_AUDIO);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD6, HDMI_IFRAME_SLOT_AUDIO);
-	seq_printf(s, "\n\n VENDOR SPECIFIC Infoframe (Data Island slot N=%d):",
+	drm_printf(p,
+		   "\n\t\tVENDOR SPECIFIC Infoframe (Data Island slot N=%d):",
 		   HDMI_IFRAME_SLOT_VENDOR);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_HEAD_WORD, HDMI_IFRAME_SLOT_VENDOR);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD0, HDMI_IFRAME_SLOT_VENDOR);
@@ -714,24 +717,7 @@ static int hdmi_dbg_show(struct seq_file *s, void *data)
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD4, HDMI_IFRAME_SLOT_VENDOR);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD5, HDMI_IFRAME_SLOT_VENDOR);
 	DBGFS_DUMP_DI(HDMI_SW_DI_N_PKT_WORD6, HDMI_IFRAME_SLOT_VENDOR);
-	seq_putc(s, '\n');
-	return 0;
-}
-
-static struct drm_info_list hdmi_debugfs_files[] = {
-	{ "hdmi", hdmi_dbg_show, 0, NULL },
-};
-
-static int hdmi_debugfs_init(struct sti_hdmi *hdmi, struct drm_minor *minor)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_files); i++)
-		hdmi_debugfs_files[i].data = hdmi;
-
-	return drm_debugfs_create_files(hdmi_debugfs_files,
-					ARRAY_SIZE(hdmi_debugfs_files),
-					minor->debugfs_root, minor);
+	drm_printf(p, "\n");
 }
 
 static void sti_hdmi_disable(struct drm_bridge *bridge)
@@ -1099,20 +1085,6 @@ sti_hdmi_connector_get_property(struct drm_connector *connector,
 	return -EINVAL;
 }
 
-static int sti_hdmi_late_register(struct drm_connector *connector)
-{
-	struct sti_hdmi_connector *hdmi_connector
-		= to_sti_hdmi_connector(connector);
-	struct sti_hdmi *hdmi = hdmi_connector->hdmi;
-
-	if (hdmi_debugfs_init(hdmi, hdmi->drm_dev->primary)) {
-		DRM_ERROR("HDMI debugfs setup failed\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static const struct drm_connector_funcs sti_hdmi_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.detect = sti_hdmi_connector_detect,
@@ -1122,7 +1094,7 @@ static const struct drm_connector_funcs sti_hdmi_connector_funcs = {
 	.atomic_get_property = sti_hdmi_connector_get_property,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-	.late_register = sti_hdmi_late_register,
+	.atomic_print_state = sti_hdmi_print_state,
 };
 
 static struct drm_encoder *sti_hdmi_find_encoder(struct drm_device *dev)
-- 
2.15.0
