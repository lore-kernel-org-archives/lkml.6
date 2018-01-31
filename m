Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeAaIFX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:05:23 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52566 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbeAaIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:05:21 -0500
X-Google-Smtp-Source: AH8x2251QwtDTI+REDYf+OVAqiF/PJlQhVIBEf5YUSk7c5wv9HtcdIHYsr4ouXP5TK63jiM2xT9oQQ==
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: yannick.fertre@st.com, philippe.cornu@st.com, vincent.abriou@st.com,
        laurent.pinchart@ideasonboard.com
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH v2] drm/stm: check pitch and size calculations even if !CONFIG_MMU
Date: Wed, 31 Jan 2018 09:05:08 +0100
Message-Id: <20180131080508.14356-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all cases we have to check pitch and size calculations to speed up
data transfer.

Fixes: 21f815bf773c ("drm/stm: drv: Improve data transfers")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 drivers/gpu/drm/stm/drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8bc7e8418b8d..9ab00a87f7cc 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -35,7 +35,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
 				   struct drm_device *dev,
 				   struct drm_mode_create_dumb *args)
 {
-#ifdef CONFIG_MMU
 	unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
 
 	/*
@@ -44,7 +43,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
 	 */
 	args->pitch = roundup(min_pitch, 128);
 	args->height = roundup(args->height, 4);
-#endif
 
 	return drm_gem_cma_dumb_create_internal(file, dev, args);
 }
-- 
2.15.0
