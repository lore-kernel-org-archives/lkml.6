Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeDKIa1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:30:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52356 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeDKIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:30:25 -0400
X-Google-Smtp-Source: AIpwx4/AYLDhcG+2HC5/OVsj3X2Yb4GFbUay2NCYVGn1LepwvDMjOgwaxSarJykHsKnUvnMg3vXEtw==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: airlied@redhat.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] gpu: drm: ast: Replace mdelay with msleep in ast_post_chip_2500
Date: Wed, 11 Apr 2018 16:30:16 +0800
Message-Id: <1523435416-4256-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ast_post_chip_2500() is never called in atomic context.

The call chains ending up at reset_mmc_2500() are:
[1] ast_post_chip_2500() <- ast_post_gpu() <- ast_drm_thaw()
[2] ast_post_chip_2500() <- ast_post_gpu() <- ast_driver_load()

ast_drm_thaw() calls console_lock() which can sleep.
ast_driver_load() is set as ".load" in struct drm_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, ast_post_chip_2500()
calls mdelay() to busily wait.
This is not necessary and can be replaced with msleep() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/ast/ast_post.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index f7d4213..67c5e50 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -2063,7 +2063,7 @@ void ast_post_chip_2500(struct drm_device *dev)
 		temp  = ast_mindwm(ast, 0x1e6e2070);
 		if (temp & 0x00800000) {
 			ast_moutdwm(ast, 0x1e6e207c, 0x00800000);
-			mdelay(100);
+			msleep(100);
 			ast_moutdwm(ast, 0x1e6e2070, 0x00800000);
 		}
 
-- 
1.9.1
