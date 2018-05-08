Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeEHHDy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:03:54 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:38696 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754361AbeEHHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:03:52 -0400
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <lee.jones@linaro.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] backlight: gpio-backlight: Correct initial power state handling
Date: Tue, 8 May 2018 10:04:26 +0300
Message-ID: <20180508070426.32211-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default-on property - or the def_value via legacy pdata) should be
handled as:
if it is 1, the backlight must be enabled (kept enabled)
if it is 0, the backlight must be disabled (kept disabled)

This only works for the case when default-on is set. If it is not set then
the brightness of the backlight is set to 0. Now if the backlight is
enabled by external driver (graphics) the backlight will stay disabled since
the brightness is configured as 0. The backlight will not turn on.

The correct action at probe time is to configure the props.power to
FB_BLANK_UNBLANK if we want the backlight on by default or to
FB_BLANK_POWERDOWN if the backlight should be off by default.

The initial brightness should be set to 1.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

for some reason the original patch got lost:
https://patchwork.kernel.org/patch/9445539/

But it is still valid, so I'm resending it.

Regards,
Peter

 drivers/video/backlight/gpio_backlight.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index e470da95d806..904a4462cefe 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -142,7 +142,9 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.brightness = gbl->def_value;
+	bl->props.power = gbl->def_value ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
+	bl->props.brightness = 1;
+
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
