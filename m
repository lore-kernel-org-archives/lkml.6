Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EDC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3517A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3517A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeJ3T1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:27:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ3T1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:27:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 82BC8260875
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org, robert.jarzmik@free.fr,
        daniel.thompson@linaro.org, lee.jones@linaro.org
Cc:     kernel@collabora.com, heiko@sntech.de, stable@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH v2] backlight: pwm_bl: Fix brightness levels for non-DT case.
Date:   Tue, 30 Oct 2018 11:34:41 +0100
Message-Id: <20181030103441.29145-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
data, instead, it sets the max_brightness in their platform data and the
driver calculates the level without a table. The ofending patch assumed
hat when there is no brightness levels table we should create one, but this
is clearly wrong for the non-DT case.

After this patch the code handles the DT and the non-DT case taking in
consideration also if max_brightness is set or not.

Fixes: '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")'
Cc: <stable@vger.kernel.org>
Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Changes in v2:
- Rebase on top of mainline
- Add Tested-by and Acked-by tags.

 drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 678b27063198..f9ef0673a083 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -562,7 +562,30 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	if (!data->levels) {
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
+		/* Get the PWM period (in nanoseconds) */
+		pwm_get_state(pb->pwm, &state);
+
 		ret = pwm_backlight_brightness_default(&pdev->dev, data,
 						       state.period);
 		if (ret < 0) {
@@ -570,13 +593,19 @@ static int pwm_backlight_probe(struct platform_device *pdev)
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
 
 	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
-- 
2.19.1

