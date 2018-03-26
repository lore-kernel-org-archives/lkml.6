Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCZJxT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:53:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeCZJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:52:25 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Heiko Stuebner <heiko@sntech.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        linux-rockchip@lists.infradead.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v6 3/5] pwm-backlight: add support for PWM delays proprieties.
Date: Mon, 26 Mar 2018 11:52:11 +0200
Message-Id: <20180326095213.18362-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180326095213.18362-1-enric.balletbo@collabora.com>
References: <20180326095213.18362-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some panels (i.e. N116BGE-L41), in their power sequence specifications,
request a delay between set the PWM signal and enable the backlight and
between clear the PWM signal and disable the backlight. Add support for
the new post-pwm-on-delay-ms and pwm-off-delay-ms proprieties to meet
the timings.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes since v5:
 - Add Acked-by: Thierry Reding <thierry.reding@gmail.com>
Changes since v4:
 - Rebased on top of mainline.
 - Added the acks from Pavel Machek, Daniel thompson and Jingoo Han
Changes since v3:
 - Use two named members instead of pwm_delay[] (Daniel and Pavel)
 - Use msleep instead of usleep_range. (Pavel)
Changes since v2:
 - Move the pwm/enable sequence to another patch (Thierry Reding)
Changes since v1:
 - As suggested by Daniel Thompson
   - Do not assume power-on delay and power-off delay will be the same
 - Move the check of dt property to the parse dt function.
---
 drivers/video/backlight/pwm_bl.c | 19 +++++++++++++++++++
 include/linux/pwm_backlight.h    |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 698ec68bcdc9..8e3f1245f5c5 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio.h>
 #include <linux/module.h>
@@ -35,6 +36,8 @@ struct pwm_bl_data {
 	struct gpio_desc	*enable_gpio;
 	unsigned int		scale;
 	bool			legacy;
+	unsigned int		post_pwm_on_delay;
+	unsigned int		pwm_off_delay;
 	int			(*notify)(struct device *,
 					  int brightness);
 	void			(*notify_after)(struct device *,
@@ -56,6 +59,9 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 
 	pwm_enable(pb->pwm);
 
+	if (pb->post_pwm_on_delay)
+		msleep(pb->post_pwm_on_delay);
+
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 1);
 
@@ -70,6 +76,9 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
+	if (pb->pwm_off_delay)
+		msleep(pb->pwm_off_delay);
+
 	pwm_config(pb->pwm, 0, pb->period);
 	pwm_disable(pb->pwm);
 
@@ -178,6 +187,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 		data->max_brightness--;
 	}
 
+	/*
+	 * These values are optional and set as 0 by default, the out values
+	 * are modified only if a valid u32 value can be decoded.
+	 */
+	of_property_read_u32(node, "post-pwm-on-delay-ms",
+			     &data->post_pwm_on_delay);
+	of_property_read_u32(node, "pwm-off-delay-ms", &data->pwm_off_delay);
+
 	data->enable_gpio = -EINVAL;
 	return 0;
 }
@@ -276,6 +293,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	pb->exit = data->exit;
 	pb->dev = &pdev->dev;
 	pb->enabled = false;
+	pb->post_pwm_on_delay = data->post_pwm_on_delay;
+	pb->pwm_off_delay = data->pwm_off_delay;
 
 	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
 						  GPIOD_ASIS);
diff --git a/include/linux/pwm_backlight.h b/include/linux/pwm_backlight.h
index e8afbd71a140..8ea265a022fd 100644
--- a/include/linux/pwm_backlight.h
+++ b/include/linux/pwm_backlight.h
@@ -14,6 +14,8 @@ struct platform_pwm_backlight_data {
 	unsigned int lth_brightness;
 	unsigned int pwm_period_ns;
 	unsigned int *levels;
+	unsigned int post_pwm_on_delay;
+	unsigned int pwm_off_delay;
 	/* TODO remove once all users are switched to gpiod_* API */
 	int enable_gpio;
 	int (*init)(struct device *dev);
-- 
2.16.2
