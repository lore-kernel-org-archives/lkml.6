Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755413AbeDPMSW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:18:22 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42261 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755206AbeDPMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:17:33 -0400
X-Google-Smtp-Source: AIpwx49ykl7nFMrrfuYOznY2NQ0G/OxUj20F4Q0vuOWhiBpkBH4Q2gXnFccN+ocOcEb5HRxCEOkAsQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] drm/tegra: dc: Rename supports_blending to legacy_blending
Date: Mon, 16 Apr 2018 15:16:26 +0300
Message-Id: <9a70c238b02fabb2af14508dc31d41820a71bebd.1523880381.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
In-Reply-To: <cover.1523880381.git.digetx@gmail.com>
References: <cover.1523880381.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older Tegra's support blending. Rename SoC info entry supports_blending
to legacy_blending to eliminate confusion.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 20 ++++++++++----------
 drivers/gpu/drm/tegra/dc.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a2bf216d8854..a54eefea2513 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -440,10 +440,10 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
 
 	tegra_plane_writel(plane, value, DC_WIN_WIN_OPTIONS);
 
-	if (dc->soc->supports_blending)
-		tegra_plane_setup_blending(plane, window);
-	else
+	if (dc->soc->legacy_blending)
 		tegra_plane_setup_blending_legacy(plane);
+	else
+		tegra_plane_setup_blending(plane, window);
 }
 
 static const u32 tegra20_primary_formats[] = {
@@ -549,7 +549,7 @@ static int tegra_plane_atomic_check(struct drm_plane *plane,
 	 * the corresponding opaque formats. However, the opaque formats can
 	 * be emulated by disabling alpha blending for the plane.
 	 */
-	if (!dc->soc->supports_blending) {
+	if (dc->soc->legacy_blending) {
 		err = tegra_plane_setup_legacy_state(tegra, plane_state);
 		if (err < 0)
 			return err;
@@ -2092,7 +2092,7 @@ static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.legacy_blending = true,
 	.pitch_align = 8,
 	.has_iommu = false,
 	.has_powergate = false,
@@ -2110,7 +2110,7 @@ static const struct tegra_dc_soc_info tegra30_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.legacy_blending = true,
 	.pitch_align = 8,
 	.has_iommu = true,
 	.has_powergate = false,
@@ -2128,7 +2128,7 @@ static const struct tegra_dc_soc_info tegra114_dc_soc_info = {
 	.supports_interlacing = false,
 	.supports_cursor = false,
 	.supports_block_linear = false,
-	.supports_blending = false,
+	.legacy_blending = true,
 	.pitch_align = 64,
 	.has_iommu = true,
 	.has_powergate = true,
@@ -2146,7 +2146,7 @@ static const struct tegra_dc_soc_info tegra124_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.legacy_blending = false,
 	.pitch_align = 64,
 	.has_iommu = true,
 	.has_powergate = true,
@@ -2164,7 +2164,7 @@ static const struct tegra_dc_soc_info tegra210_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.legacy_blending = false,
 	.pitch_align = 64,
 	.has_iommu = true,
 	.has_powergate = true,
@@ -2216,7 +2216,7 @@ static const struct tegra_dc_soc_info tegra186_dc_soc_info = {
 	.supports_interlacing = true,
 	.supports_cursor = true,
 	.supports_block_linear = true,
-	.supports_blending = true,
+	.legacy_blending = false,
 	.pitch_align = 64,
 	.has_powergate = false,
 	.coupled_pm = false,
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index d0bbcbcde4c1..3156006e75c6 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -55,7 +55,7 @@ struct tegra_dc_soc_info {
 	bool supports_interlacing;
 	bool supports_cursor;
 	bool supports_block_linear;
-	bool supports_blending;
+	bool legacy_blending;
 	unsigned int pitch_align;
 	bool has_iommu;
 	bool has_powergate;
-- 
2.17.0
