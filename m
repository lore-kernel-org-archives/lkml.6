Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDKIaD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:30:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45644 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeDKIaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:30:00 -0400
X-Google-Smtp-Source: AIpwx4/ab0EfJ/xQZ6QAzwPo7wJlX0nn91e16J5DUAEZJVZIXlPov15EmywDbRDzCDrdE1wL9zNxRA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: airlied@redhat.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] gpu: drm: ast: Replace mdelay with msleep in reset_mmc_2500
Date: Wed, 11 Apr 2018 16:29:36 +0800
Message-Id: <1523435376-4210-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reset_mmc_2500() is never called in atomic context.

The call chains ending up at reset_mmc_2500() are:
[1] reset_mmc_2500() <- ast_dram_init_2500() <- ast_post_chip_2500() <- 
	ast_post_gpu() <- ast_drm_thaw()
[2] reset_mmc_2500() <- ast_dram_init_2500() <- ast_post_chip_2500() <- 
	ast_post_gpu() <- ast_driver_load()

ast_drm_thaw() calls console_lock() which can sleep.
ast_driver_load() is set as ".load" in struct drm_driver.
These functions are not called in atomic context.

Despite never getting called from atomic context, reset_mmc_2500()
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
index f7d4213..12bbf64 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -1840,7 +1840,7 @@ static void reset_mmc_2500(struct ast_private *ast)
 	ast_moutdwm(ast, 0x1E785044, 0x00000001);
 	ast_moutdwm(ast, 0x1E785048, 0x00004755);
 	ast_moutdwm(ast, 0x1E78504C, 0x00000013);
-	mdelay(100);
+	msleep(100);
 	ast_moutdwm(ast, 0x1E785054, 0x00000077);
 	ast_moutdwm(ast, 0x1E6E0000, 0xFC600309);
 }
-- 
1.9.1
