Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeDKId6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:33:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35134 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDKId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:33:56 -0400
X-Google-Smtp-Source: AIpwx4//zpnzrddpE2RHTf688CFD/OiQ5DgtVQY0exfImZntl3ufrOPVXutmQlBUTCruEK5fsEag2A==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel.vetter@ffwll.ch, bhumirks@gmail.com, narmstrong@baylibre.com,
        inki.dae@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: bridge: adv7511: Replace mdelay with usleep_range in adv7511_probe
Date: Wed, 11 Apr 2018 16:33:42 +0800
Message-Id: <1523435622-4329-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adv7511_probe() is never called in atomic context.
This function is only set as ".probe" in struct i2c_driver.

Despite never getting called from atomic context, adv7511_probe()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index b2431ae..2cf7fa1 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1054,7 +1054,7 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 	}
 
 	if (adv7511->gpio_pd) {
-		mdelay(5);
+		usleep_range(5000, 6000);
 		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
 	}
 
-- 
1.9.1
