Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEDAJe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:09:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36741 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeEDAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:09:29 -0400
X-Google-Smtp-Source: AB8JxZoDX/o2vSWleI3sw0WPD5Oq3hehx27QPYnBPOsi7JyoOuz/1y6wq7ls9hG6Pb0S0Q9f46DCfg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] drm/tegra: dc: Rename supports_blending to has_legacy_blending
Date: Fri,  4 May 2018 03:08:44 +0300
Message-Id: <20180504000844.18661-4-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504000844.18661-1-digetx@gmail.com>
References: <20180504000844.18661-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Tegra's support blending. Rename SoC info entry supports_blending
to has_legacy_blending to eliminate confusion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 20 ++++++++++----------
 drivers/gpu/drm/tegra/dc.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index ba5481cd470d..fe00b3250f6a 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -478,10 +478,10 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 
 	tegra_plane_writel(plane, value, DC_WIN_WIN_OPTIONS);
 
-	if (dc->soc->supports_blending)
-		tegra_plane_setup_blending(plane, window);
-	else
+	if (dc->soc->has_legacy_blending)
 		tegra_plane_setup_blending_legacy(plane);
+	else
+		tegra_plane_setup_blending(plane, window);
 }
 
 static const u32 tegra20_primary_formats[] = {
@@ -587,7 +587,7 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	 * the corresponding opaque formats. However, the opaque formats can
 	 * be emulated by disabling alpha blending for the plane.
 	 */
-	if (!dc->soc->supports_blending) {
+	if (dc->soc->has_legacy_blending) {
 		err = tegra_plane_setup_legacy_state(tegra, plane_state);
 		if (err < 0)
 			return err;
@@ -2069,7 +2069,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.has_legacy_blending = true,
 	.pitch_align = 8,
 	.has_powergate = false,
 	.coupled_pm = true,
@@ -2088,7 +2088,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.has_legacy_blending = true,
 	.pitch_align = 8,
 	.has_powergate = false,
 	.coupled_pm = false,
@@ -2107,7 +2107,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.has_legacy_blending = true,
 	.pitch_align = 64,
 	.has_powergate = true,
 	.coupled_pm = false,
@@ -2126,7 +2126,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.has_legacy_blending = false,
 	.pitch_align = 64,
 	.has_powergate = true,
 	.coupled_pm = false,
@@ -2145,7 +2145,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.has_legacy_blending = false,
 	.pitch_align = 64,
 	.has_powergate = true,
 	.coupled_pm = false,
@@ -2198,7 +2198,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.has_legacy_blending = false,
 	.pitch_align = 64,
 	.has_powergate = false,
 	.coupled_pm = false,
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 5c3d1d6faa3b..ca5cac6bf8ea 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -55,7 +55,7 @@ struct tegra_dc_soc_info {
 	bool supports_interlacing;
 	bool supports_cursor;
 	bool supports_block_linear;
-	bool supports_blending;
+	bool has_legacy_blending;
 	unsigned int pitch_align;
 	bool has_powergate;
 	bool coupled_pm;
-- 
2.17.0
