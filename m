Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752424AbeDKH62 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:58:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51197 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeDKH61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:58:27 -0400
X-Google-Smtp-Source: AIpwx4922YguRN47fZZrBlfMlFXM6SuCn04+pUrysDhuV/ca9zf9nVDqXx/BuKOgtff6FD2JPDRYZA==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: thierry.reding@gmail.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] panel-jdi-lt070me05000: Replace mdelay with usleep_range and msleep in jdi_panel_init
Date: Wed, 11 Apr 2018 15:58:10 +0800
Message-Id: <1523433490-4032-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jdi_panel_init() is never called in atomic context.

Despite never getting called from atomic context, jdi_panel_init()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() 
and msleep() to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index 5b2340e..46b12a6 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -128,7 +128,7 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 		return ret;
 	}
 
-	mdelay(10);
+	usleep_range(10000, 11000);
 
 	/* Interface setting, video mode */
 	ret = mipi_dsi_generic_write(dsi, (u8[])
@@ -139,7 +139,7 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 		return ret;
 	}
 
-	mdelay(20);
+	msleep(20);
 
 	ret = mipi_dsi_generic_write(dsi, (u8[]){0xB0, 0x03}, 2);
 	if (ret < 0) {
-- 
1.9.1
