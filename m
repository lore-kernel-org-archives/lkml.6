Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883EDC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B614216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 18:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B614216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeHYWDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 18:03:10 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50020 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHYWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 18:03:10 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1CD5F20021;
        Sat, 25 Aug 2018 20:23:21 +0200 (CEST)
Date:   Sat, 25 Aug 2018 20:23:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] atmel_lcdfb: support native-mode display-timings
Message-ID: <20180825182320.GA3285@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=XYAwZIGsAAAA:8 a=hD80L64hAAAA:8
        a=P-IC7800AAAA:8 a=cBEqf397xypOQntOsbQA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=E8ToXWR_bxluHZ7gmE-Z:22
        a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device tree set a display-timing using native-mode
then according to the bindings doc this should:

    native-mode:
    The native mode for the display, in case multiple
    modes are provided.
    When omitted, assume the first node is the native.

The atmel_lcdfb used the last timing subnode and did not
respect the timing mode specified with native-mode.

Introduce use of of_get_videomode() which allowed
a nice simplification of the code while also
added support for native-mode.

As a nice side-effect this fixes a memory leak where the
data used for timings and the display_np was not freed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

v1 => v2
Rebased on top of v4.18, resend

 drivers/video/fbdev/atmel_lcdfb.c | 43 ++++++++-------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 076d24afbd72..4ed55e6bbb84 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <video/of_videomode.h>
 #include <video/of_display_timing.h>
 #include <linux/regulator/consumer.h>
 #include <video/videomode.h>
@@ -1028,11 +1029,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct device *dev = &sinfo->pdev->dev;
 	struct device_node *np =dev->of_node;
 	struct device_node *display_np;
-	struct device_node *timings_np;
-	struct display_timings *timings;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power = false;
+	struct fb_videomode fb_vm;
 	struct gpio_desc *gpiod;
+	struct videomode vm;
 	int ret = -ENOENT;
 	int i;
 
@@ -1105,44 +1106,18 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	pdata->lcdcon_is_backlight = of_property_read_bool(display_np, "atmel,lcdcon-backlight");
 	pdata->lcdcon_pol_negative = of_property_read_bool(display_np, "atmel,lcdcon-backlight-inverted");
 
-	timings = of_get_display_timings(display_np);
-	if (!timings) {
-		dev_err(dev, "failed to get display timings\n");
-		ret = -EINVAL;
+	ret = of_get_videomode(display_np, &vm, OF_USE_NATIVE_MODE);
+	if (ret) {
+		dev_err(dev, "failed to get videomode from DT\n");
 		goto put_display_node;
 	}
 
-	timings_np = of_get_child_by_name(display_np, "display-timings");
-	if (!timings_np) {
-		dev_err(dev, "failed to find display-timings node\n");
-		ret = -ENODEV;
+	ret = fb_videomode_from_videomode(&vm, &fb_vm);
+	if (ret < 0)
 		goto put_display_node;
-	}
 
-	for (i = 0; i < of_get_child_count(timings_np); i++) {
-		struct videomode vm;
-		struct fb_videomode fb_vm;
-
-		ret = videomode_from_timings(timings, &vm, i);
-		if (ret < 0)
-			goto put_timings_node;
-		ret = fb_videomode_from_videomode(&vm, &fb_vm);
-		if (ret < 0)
-			goto put_timings_node;
-
-		fb_add_videomode(&fb_vm, &info->modelist);
-	}
-
-	/*
-	 * FIXME: Make sure we are not referencing any fields in display_np
-	 * and timings_np and drop our references to them before returning to
-	 * avoid leaking the nodes on probe deferral and driver unbind.
-	 */
-
-	return 0;
+	fb_add_videomode(&fb_vm, &info->modelist);
 
-put_timings_node:
-	of_node_put(timings_np);
 put_display_node:
 	of_node_put(display_np);
 	return ret;
-- 
2.12.0

