Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeFENyi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:54:38 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36055 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbeFENyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:54:35 -0400
X-Google-Smtp-Source: ADUXVKLYQXDUzefywpkhIgdfWvuoqPjMydTvXhik/9353eAj2B4j95uTRvyCRsPvkMCO2QTLwaMK5g==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie, vincent.abriou@st.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v1 7/7] drm: sti: remove the last call to debugfs
Date: Tue,  5 Jun 2018 15:54:07 +0200
Message-Id: <20180605135407.20214-8-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all the hooks in drm structure, custom debugfs could be
removed of sti driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/sti/sti_drv.c | 50 -------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 90c46b49c931..95b0ac4d819c 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -7,7 +7,6 @@
 #include <drm/drmP.h>
 
 #include <linux/component.h>
-#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -72,53 +71,6 @@ static int sti_drm_fps_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(sti_drm_fps_fops,
 			sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
 
-static int sti_drm_fps_dbg_show(struct seq_file *s, void *data)
-{
-	struct drm_info_node *node = s->private;
-	struct drm_device *dev = node->minor->dev;
-	struct drm_plane *p;
-
-	list_for_each_entry(p, &dev->mode_config.plane_list, head) {
-		struct sti_plane *plane = to_sti_plane(p);
-
-		seq_printf(s, "%s%s\n",
-			   plane->fps_info.fps_str,
-			   plane->fps_info.fips_str);
-	}
-
-	return 0;
-}
-
-static struct drm_info_list sti_drm_dbg_list[] = {
-	{"fps_get", sti_drm_fps_dbg_show, 0},
-};
-
-static int sti_drm_dbg_init(struct drm_minor *minor)
-{
-	struct dentry *dentry;
-	int ret;
-
-	ret = drm_debugfs_create_files(sti_drm_dbg_list,
-				       ARRAY_SIZE(sti_drm_dbg_list),
-				       minor->debugfs_root, minor);
-	if (ret)
-		goto err;
-
-	dentry = debugfs_create_file("fps_show", S_IRUGO | S_IWUSR,
-				     minor->debugfs_root, minor->dev,
-				     &sti_drm_fps_fops);
-	if (!dentry) {
-		ret = -ENOMEM;
-		goto err;
-	}
-
-	DRM_INFO("%s: debugfs installed\n", DRIVER_NAME);
-	return 0;
-err:
-	DRM_ERROR("%s: cannot install debugfs\n", DRIVER_NAME);
-	return ret;
-}
-
 static const struct drm_mode_config_funcs sti_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create,
 	.output_poll_changed = drm_fb_helper_output_poll_changed,
@@ -167,8 +119,6 @@ static struct drm_driver sti_driver = {
 	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap = drm_gem_cma_prime_mmap,
 
-	.debugfs_init = sti_drm_dbg_init,
-
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 	.date = DRIVER_DATE,
-- 
2.15.0
