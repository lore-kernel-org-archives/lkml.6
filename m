Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEDOlj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:41:39 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34947 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:41:00 -0400
X-Google-Smtp-Source: AB8JxZq4k0U4jh+Vz2d8IOj+2SRJbTVrr3bcw6GbA/jD6Cyl9rJmJmy8Gr5mcgrTIDTogbGUdg0UtA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/tegra: dc: Enable plane scaling filters
Date: Fri,  4 May 2018 17:39:58 +0300
Message-Id: <20180504144000.8597-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504144000.8597-1-digetx@gmail.com>
References: <20180504144000.8597-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently resized plane produces a "pixelated" image which doesn't look
nice, especially in a case of a video overlay. Enable scaling filters that
significantly improve image quality of a scaled overlay.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 81 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h |  7 ++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 9f83a65b5ea9..79aac38f4ed2 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -224,6 +224,39 @@ static void tegra_plane_setup_blending(struct tegra_plane *plane,
 	tegra_plane_writel(plane, value, DC_WIN_BLEND_LAYER_CONTROL);
 }
 
+static bool tegra_dc_window_can_use_horizontal_filtering(
+					struct tegra_plane *plane,
+					const struct tegra_dc_window *window)
+{
+	struct tegra_dc *dc = plane->dc;
+
+	if (window->src.w == window->dst.w)
+		return false;
+
+	if (plane->index == 0 && dc->soc->has_win_a_without_filters)
+		return false;
+
+	return true;
+}
+
+static bool tegra_dc_window_can_use_vertical_filtering(
+					struct tegra_plane *plane,
+					const struct tegra_dc_window *window)
+{
+	struct tegra_dc *dc = plane->dc;
+
+	if (window->src.h == window->dst.h)
+		return false;
+
+	if (plane->index == 0 && dc->soc->has_win_a_without_filters)
+		return false;
+
+	if (plane->index == 2 && dc->soc->has_win_c_without_vert_filter)
+		return false;
+
+	return true;
+}
+
 static void tegra_dc_setup_window(struct tegra_plane *plane,
 				  const struct tegra_dc_window *window)
 {
@@ -361,6 +394,44 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 	if (window->bottom_up)
 		value |= V_DIRECTION;
 
+	if (tegra_dc_window_can_use_horizontal_filtering(plane, window)) {
+		/*
+		 * Enable horizontal 6-tap filter and set filtering
+		 * coefficients to the default values defined in TRM.
+		 */
+		tegra_plane_writel(plane, 0x00008000, DC_WIN_H_FILTER_P(0));
+		tegra_plane_writel(plane, 0x3e087ce1, DC_WIN_H_FILTER_P(1));
+		tegra_plane_writel(plane, 0x3b117ac1, DC_WIN_H_FILTER_P(2));
+		tegra_plane_writel(plane, 0x591b73aa, DC_WIN_H_FILTER_P(3));
+		tegra_plane_writel(plane, 0x57256d9a, DC_WIN_H_FILTER_P(4));
+		tegra_plane_writel(plane, 0x552f668b, DC_WIN_H_FILTER_P(5));
+		tegra_plane_writel(plane, 0x73385e8b, DC_WIN_H_FILTER_P(6));
+		tegra_plane_writel(plane, 0x72435583, DC_WIN_H_FILTER_P(7));
+		tegra_plane_writel(plane, 0x714c4c8b, DC_WIN_H_FILTER_P(8));
+		tegra_plane_writel(plane, 0x70554393, DC_WIN_H_FILTER_P(9));
+		tegra_plane_writel(plane, 0x715e389b, DC_WIN_H_FILTER_P(10));
+		tegra_plane_writel(plane, 0x71662faa, DC_WIN_H_FILTER_P(11));
+		tegra_plane_writel(plane, 0x536d25ba, DC_WIN_H_FILTER_P(12));
+		tegra_plane_writel(plane, 0x55731bca, DC_WIN_H_FILTER_P(13));
+		tegra_plane_writel(plane, 0x387a11d9, DC_WIN_H_FILTER_P(14));
+		tegra_plane_writel(plane, 0x3c7c08f1, DC_WIN_H_FILTER_P(15));
+
+		value |= H_FILTER;
+	}
+
+	if (tegra_dc_window_can_use_vertical_filtering(plane, window)) {
+		unsigned int i, k;
+
+		/*
+		 * Enable vertical 2-tap filter and set filtering
+		 * coefficients to the default values defined in TRM.
+		 */
+		for (i = 0, k = 128; i < 16; i++, k -= 8)
+			tegra_plane_writel(plane, k, DC_WIN_V_FILTER_P(i));
+
+		value |= V_FILTER;
+	}
+
 	tegra_plane_writel(plane, value, DC_WIN_WIN_OPTIONS);
 
 	if (dc->soc->supports_blending)
@@ -1978,6 +2049,8 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra20_overlay_formats),
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_without_filters = true,
+	.has_win_c_without_vert_filter = true,
 };
 
 static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
@@ -1995,6 +2068,8 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra20_overlay_formats),
 	.overlay_formats = tegra20_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_without_filters = false,
+	.has_win_c_without_vert_filter = false,
 };
 
 static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
@@ -2012,6 +2087,8 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra114_overlay_formats),
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra20_modifiers,
+	.has_win_a_without_filters = false,
+	.has_win_c_without_vert_filter = false,
 };
 
 static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
@@ -2029,6 +2106,8 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra124_overlay_formats),
 	.overlay_formats = tegra124_overlay_formats,
 	.modifiers = tegra124_modifiers,
+	.has_win_a_without_filters = false,
+	.has_win_c_without_vert_filter = false,
 };
 
 static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
@@ -2046,6 +2125,8 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.num_overlay_formats = ARRAY_SIZE(tegra114_overlay_formats),
 	.overlay_formats = tegra114_overlay_formats,
 	.modifiers = tegra124_modifiers,
+	.has_win_a_without_filters = false,
+	.has_win_c_without_vert_filter = false,
 };
 
 static const struct tegra_windowgroup_soc tegra186_dc_wgrps[] = {
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index d2b50d32de4d..8673cd97afc3 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -67,6 +67,8 @@ struct tegra_dc_soc_info {
 	const u32 *overlay_formats;
 	unsigned int num_overlay_formats;
 	const u64 *modifiers;
+	bool has_win_a_without_filters;
+	bool has_win_c_without_vert_filter;
 };
 
 struct tegra_dc {
@@ -553,6 +555,9 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define  THREAD_NUM(x) (((x) & 0x1f) << 1)
 #define  THREAD_GROUP_ENABLE (1 << 0)
 
+#define DC_WIN_H_FILTER_P(p)			(0x601 + (p))
+#define DC_WIN_V_FILTER_P(p)			(0x619 + (p))
+
 #define DC_WIN_CSC_YOF				0x611
 #define DC_WIN_CSC_KYRGB			0x612
 #define DC_WIN_CSC_KUR				0x613
@@ -566,6 +571,8 @@ int tegra_dc_rgb_exit(struct tegra_dc *dc);
 #define H_DIRECTION  (1 <<  0)
 #define V_DIRECTION  (1 <<  2)
 #define COLOR_EXPAND (1 <<  6)
+#define H_FILTER     (1 <<  8)
+#define V_FILTER     (1 << 10)
 #define CSC_ENABLE   (1 << 18)
 #define WIN_ENABLE   (1 << 30)
 
-- 
2.17.0
