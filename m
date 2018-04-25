Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756056AbeDYRn4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50662 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeDYRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:08 -0400
X-Google-Smtp-Source: AIpwx48haiJh/VIgL3up3t9bpjTQxCQjSVlHS5TkRR38XPvJRwKMfu+CoTvCjjB9kBnPw+xLBG55eA==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 4/6] staging/fbtft: Stop using BL_CORE_DRIVER1
Date: Wed, 25 Apr 2018 19:42:51 +0200
Message-Id: <20180425174253.4616-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaking driver internal tracking into the already massively confusing
backlight power tracking is really confusing.

Luckily we have already a drvdata structure, so fixing this is really
easy.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 drivers/staging/fbtft/fbtft.h      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 0e36b66ae5f7..731e47149af8 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -246,7 +246,7 @@ static int fbtft_request_gpios_dt(struct fbtft_par *par)
 static int fbtft_backlight_update_status(struct backlight_device *bd)
 {
 	struct fbtft_par *par = bl_get_data(bd);
-	bool polarity = !!(bd->props.state & BL_CORE_DRIVER1);
+	bool polarity = par->polarity;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
 		"%s: polarity=%d, power=%d, fb_blank=%d\n",
@@ -296,7 +296,7 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	/* Assume backlight is off, get polarity from current state of pin */
 	bl_props.power = FB_BLANK_POWERDOWN;
 	if (!gpio_get_value(par->gpio.led[0]))
-		bl_props.state |= BL_CORE_DRIVER1;
+		par->polarity = true;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
 				       par->info->device, par,
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index e19e64e0d094..c7cb4a7896f4 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -229,6 +229,7 @@ struct fbtft_par {
 	ktime_t update_time;
 	bool bgr;
 	void *extra;
+	bool polarity;
 };
 
 #define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))
-- 
2.17.0
