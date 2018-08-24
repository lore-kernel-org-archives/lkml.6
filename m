Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1757C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844F7208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844F7208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHXT3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:29:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXT3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:29:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 09E2727DD2A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org, robert.jarzmik@free.fr,
        daniel.thompson@linaro.org, lee.jones@linaro.org
Cc:     kernel@collabora.com, heiko@sntech.de, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH] backlight: pwm_bl: Fix brightness levels for non-DT case.
Date:   Fri, 24 Aug 2018 17:54:02 +0200
Message-Id: <20180824155402.2822-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
linearly to human eye")' allows the possibility to compute a default
brightness table when there isn't the brightness-levels property in the
DT. Unfortunately the changes made broke the pwm backlight for the
non-DT boards.

Usually, the non-DT boards don't pass the brightness levels via platform
data, instead, they set the max_brightness in their platform data and the
driver calculates the level without a table. The ofending patch assumed
that when there is no brightness levels table we should create one, but this
is clearly wrong for the non-DT case.

After this patch the code handles the DT and the non-DT case taking in
consideration also if max_brightness is set or not. The default table is
only created when neither, brightness-levels and max_brightness, are
set.

The patch also fixes another issue found by Robert. Before this patch
looks like a division by 0 was possible when state.period returned 0 by
pwm_get_state(). This is because pwm_get_state() was called before
pwm_apply_args() so state.period was not initialized. The patch moves
the pwm_apply_args() call before any call to pwm_get_state().

Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/video/backlight/pwm_bl.c | 50 ++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index bdfcc0a71db1..19770f7bffe4 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -539,7 +539,33 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
-	if (!data->levels) {
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(pb->pwm);
+
+	if (data->levels) {
+		/*
+		 * For the DT case, only when brightness levels is defined
+		 * data->levels is filled. For the non-DT case, data->levels
+		 * can come from platform data, however is not usual.
+		 */
+		for (i = 0; i <= data->max_brightness; i++) {
+			if (data->levels[i] > pb->scale)
+				pb->scale = data->levels[i];
+
+			pb->levels = data->levels;
+		}
+	} else if (!data->max_brightness) {
+		/*
+		 * If no brightness levels are provided and max_brightness is
+		 * not set, use the default brightness table. For the DT case,
+		 * max_brightness is set to 0 when brightness levels is not
+		 * specified. For the non-DT case, max_brightness is usually
+		 * set to some value.
+		 */
+
 		/* Get the PWM period (in nanoseconds) */
 		pwm_get_state(pb->pwm, &state);
 
@@ -550,21 +576,21 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 				"failed to setup default brightness table\n");
 			goto err_alloc;
 		}
-	}
 
-	for (i = 0; i <= data->max_brightness; i++) {
-		if (data->levels[i] > pb->scale)
-			pb->scale = data->levels[i];
+		for (i = 0; i <= data->max_brightness; i++) {
+			if (data->levels[i] > pb->scale)
+				pb->scale = data->levels[i];
 
-		pb->levels = data->levels;
+			pb->levels = data->levels;
+		}
+	} else {
+		/*
+		 * That only happens for the non-DT case, where platform data
+		 * sets the max_brightness value.
+		 */
+		pb->scale = data->max_brightness;
 	}
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(pb->pwm);
-
 	/*
 	 * The DT case will set the pwm_period_ns field to 0 and store the
 	 * period, parsed from the DT, in the PWM device. For the non-DT case,
-- 
2.18.0

