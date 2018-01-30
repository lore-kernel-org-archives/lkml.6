Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeA3PYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:24:08 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37965 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeA3PYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:24:07 -0500
X-Google-Smtp-Source: AH8x227Srw0r17aiilpvu1fVo5K64vKBfuvHQGDSowpMsZX/3y4intL6cwvPhfreavFT6I54mtfnWQ==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: yannick.fertre@st.com, philippe.cornu@st.com, vincent.abriou@st.com,
        laurent.pinchart@ideasonboard.com
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] drm/stm: check pitch and size calculations even if !CONFIG_MMU
Date: Tue, 30 Jan 2018 16:24:00 +0100
Message-Id: <20180130152400.28972-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all cases we have to check pitch and size calculations.
Rely on drm_gem_cma_dumb_create for no MMU cases.

Fixes: 21f815bf773c ("drm/stm: drv: Improve data transfers")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/stm/drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8bc7e8418b8d..3e0fb5f34b8e 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -44,9 +44,11 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
 	 */
 	args->pitch = roundup(min_pitch, 128);
 	args->height = roundup(args->height, 4);
-#endif
 
 	return drm_gem_cma_dumb_create_internal(file, dev, args);
+#else
+	return drm_gem_cma_dumb_create(file, dev, args);
+#endif
 }
 
 DEFINE_DRM_GEM_CMA_FOPS(drv_driver_fops);
-- 
2.15.0
