Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754989AbeBCSkP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 13:40:15 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41260 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeBCSio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 13:38:44 -0500
X-Google-Smtp-Source: AH8x226r3XGcpaRy+9uDtKk6KL45Gbgg9gNiEGuzIUKkVx82Ix8Tsu+o/0aMD/VaaYUEDbYfv9mqDQ==
From: Craig Tatlor <ctatlor97@gmail.com>
Cc: ctatlor97@gmail.com, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Call msm_init_vram before binding the gpu
Date: Sat,  3 Feb 2018 18:38:26 +0000
Message-Id: <20180203183826.25760-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.15.1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vram.size is needed when binding a gpu without an iommu and is defined
in msm_init_vram(), so run that before binding it.

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 drivers/gpu/drm/msm/msm_drv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index bdf0fe754f7b..82d4126ca017 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -400,6 +400,14 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 
 	drm_mode_config_init(ddev);
 
+	ret = msm_init_vram(ddev);
+	if (ret) {
+		msm_mdss_destroy(ddev);
+		kfree(priv);
+		drm_dev_unref(ddev);
+		return ret;
+	}
+
 	/* Bind all our sub-components: */
 	ret = component_bind_all(dev, ddev);
 	if (ret) {
@@ -409,10 +417,6 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 		return ret;
 	}
 
-	ret = msm_init_vram(ddev);
-	if (ret)
-		goto fail;
-
 	msm_gem_shrinker_init(ddev);
 
 	switch (get_mdp_ver(pdev)) {
-- 
2.15.1
