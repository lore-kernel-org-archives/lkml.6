Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeDIIeN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:34:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbeDIIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:33:46 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Alexandru Stan <amstan@google.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [RESEND PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED linearly to human eye.
Date: Mon,  9 Apr 2018 10:33:32 +0200
Message-Id: <20180409083333.1249-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180409083333.1249-1-enric.balletbo@collabora.com>
References: <20180409083333.1249-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When you want to change the brightness using a PWM signal, one thing you
need to consider is how human perceive the brightness. Human perceive
the brightness change non-linearly, we have better sensitivity at low
luminance than high luminance, so to achieve perceived linear dimming,
the brightness must be matches to the way our eyes behave. The CIE 1931
lightness formula is what actually describes how we perceive light.

This patch computes a default table with the brightness levels filled
with the numbers provided by the CIE 1931 algorithm, the number of the
brightness levels is calculated based on the PWM resolution.

The calculation of the table using the CIE 1931 algorithm is enabled by
default when you do not define the 'brightness-levels' propriety in your
device tree.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/pwm_bl.c | 149 +++++++++++++++++++++++++++++++++++----
 1 file changed, 136 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f0a108ab570a..d047d875f251 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -143,6 +143,107 @@ static const struct backlight_ops pwm_backlight_ops = {
 };
 
 #ifdef CONFIG_OF
+#define PWM_LUMINANCE_SCALE	10000 /* luminance scale */
+
+/* An integer based power function */
+static u64 int_pow(u64 base, int exp)
+{
+	u64 result = 1;
+
+	while (exp) {
+		if (exp & 1)
+			result *= base;
+		exp >>= 1;
+		base *= base;
+	}
+
+	return result;
+}
+
+/*
+ * CIE lightness to PWM conversion.
+ *
+ * The CIE 1931 lightness formula is what actually describes how we perceive
+ * light:
+ *          Y = (L* / 902.3)           if L* ≤ 0.08856
+ *          Y = ((L* + 16) / 116)^3    if L* > 0.08856
+ *
+ * Where Y is the luminance, the amount of light coming out of the screen, and
+ * is a number between 0.0 and 1.0; and L* is the lightness, how bright a human
+ * perceives the screen to be, and is a number between 0 and 100.
+ *
+ * The following function does the fixed point maths needed to implement the
+ * above formula.
+ */
+static u64 cie1931(unsigned int lightness, unsigned int scale)
+{
+	u64 retval;
+
+	lightness *= 100;
+	if (lightness <= (8 * scale)) {
+		retval = DIV_ROUND_CLOSEST_ULL(lightness * 10, 9023);
+	} else {
+		retval = int_pow((lightness + (16 * scale)) / 116, 3);
+		retval = DIV_ROUND_CLOSEST_ULL(retval, (scale * scale));
+	}
+
+	return retval;
+}
+
+/*
+ * Create a default correction table for PWM values to create linear brightness
+ * for LED based backlights using the CIE1931 algorithm.
+ */
+static
+int pwm_backlight_brightness_default(struct device *dev,
+				     struct platform_pwm_backlight_data *data,
+				     unsigned int period)
+{
+	unsigned int counter = 0;
+	unsigned int i, n;
+	u64 retval;
+
+	/*
+	 * Count the number of bits needed to represent the period number. The
+	 * number of bits is used to calculate the number of levels used for the
+	 * brightness-levels table, the purpose of this calculation is have a
+	 * pre-computed table with enough levels to get linear brightness
+	 * perception. The period is divided by the number of bits so for a
+	 * 8-bit PWM we have 255 / 8 = 32 brightness levels or for a 16-bit PWM
+	 * we have 65535 / 16 = 4096 brightness levels.
+	 *
+	 * Note that this method is based on empirical testing on different
+	 * devices with PWM of 8 and 16 bits of resolution.
+	 */
+	n = period;
+	while (n) {
+		counter += n % 2;
+		n >>= 1;
+	}
+
+	data->max_brightness = DIV_ROUND_UP(period, counter);
+	data->levels = devm_kcalloc(dev, data->max_brightness,
+				    sizeof(*data->levels), GFP_KERNEL);
+	if (!data->levels)
+		return -ENOMEM;
+
+	/* Fill the table using the cie1931 algorithm */
+	for (i = 0; i < data->max_brightness; i++) {
+		retval = cie1931((i * PWM_LUMINANCE_SCALE) /
+				 data->max_brightness, PWM_LUMINANCE_SCALE) *
+				 period;
+		retval = DIV_ROUND_CLOSEST_ULL(retval, PWM_LUMINANCE_SCALE);
+		if (retval > UINT_MAX)
+			return -EINVAL;
+		data->levels[i] = (unsigned int)retval;
+	}
+
+	data->dft_brightness = data->max_brightness / 2;
+	data->max_brightness--;
+
+	return 0;
+}
+
 static int pwm_backlight_parse_dt(struct device *dev,
 				  struct platform_pwm_backlight_data *data)
 {
@@ -161,10 +262,13 @@ static int pwm_backlight_parse_dt(struct device *dev,
 
 	memset(data, 0, sizeof(*data));
 
-	/* determine the number of brightness levels */
+	/*
+	 * Determine the number of brightness levels, if this property is not
+	 * set a default table of brightness levels will be used.
+	 */
 	prop = of_find_property(node, "brightness-levels", &length);
 	if (!prop)
-		return -EINVAL;
+		return 0;
 
 	data->max_brightness = length / sizeof(u32);
 
@@ -294,6 +398,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
 {
 	return -ENODEV;
 }
+
+static
+int pwm_backlight_brightness_default(struct device *dev,
+				     struct platform_pwm_backlight_data *data,
+				     unsigned int period)
+{
+	return -ENODEV;
+}
 #endif
 
 static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
@@ -334,7 +446,9 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct backlight_device *bl;
 	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
+	struct pwm_state state;
 	struct pwm_args pargs;
+	unsigned int i;
 	int ret;
 
 	if (!data) {
@@ -359,17 +473,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	if (data->levels) {
-		unsigned int i;
-
-		for (i = 0; i <= data->max_brightness; i++)
-			if (data->levels[i] > pb->scale)
-				pb->scale = data->levels[i];
-
-		pb->levels = data->levels;
-	} else
-		pb->scale = data->max_brightness;
-
 	pb->notify = data->notify;
 	pb->notify_after = data->notify_after;
 	pb->check_fb = data->check_fb;
@@ -436,6 +539,26 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
+	if (!data->levels) {
+		/* Get the PWM period (in nanoseconds) */
+		pwm_get_state(pb->pwm, &state);
+
+		ret = pwm_backlight_brightness_default(&pdev->dev, data,
+						       state.period);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"failed to setup default brightness table\n");
+			goto err_alloc;
+		}
+	}
+
+	for (i = 0; i <= data->max_brightness; i++) {
+		if (data->levels[i] > pb->scale)
+			pb->scale = data->levels[i];
+
+		pb->levels = data->levels;
+	}
+
 	/*
 	 * FIXME: pwm_apply_args() should be removed when switching to
 	 * the atomic PWM API.
-- 
2.16.3
