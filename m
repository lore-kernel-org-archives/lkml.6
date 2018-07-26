Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8850CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5B82088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5B82088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeGZKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:31:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39884 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeGZKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:31:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4171726048B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, cl@rock-chips.com, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] backlight: pwm_bl: switch to using "atomic" PWM API
Date:   Thu, 26 Jul 2018 11:15:34 +0200
Message-Id: <20180726091534.27521-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "atomic" API allows us to configure PWM period and duty_cycle and
enable it in one call.

The patch also moves the pwm_init_state just before any use of the
pwm_state struct, this fixes a potential bug where pwm_get_state
can be called before pwm_init_state.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/video/backlight/pwm_bl.c | 48 ++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index bdfcc0a71db1..2c734d55d607 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -46,7 +46,8 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
 
-static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
+static void pwm_backlight_power_on(struct pwm_bl_data *pb,
+				   struct pwm_state *state)
 {
 	int err;
 
@@ -57,7 +58,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
-	pwm_enable(pb->pwm);
+	state->enabled = true;
+	pwm_apply_state(pb->pwm, state);
 
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
@@ -70,6 +72,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness)
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
+	struct pwm_state state;
+
 	if (!pb->enabled)
 		return;
 
@@ -79,8 +83,11 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (pb->pwm_off_delay)
 		msleep(pb->pwm_off_delay);
 
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+	pwm_get_state(pb->pwm, &state);
+	state.enabled = false;
+	state.period = pb->period;
+	state.duty_cycle = 0;
+	pwm_apply_state(pb->pwm, &state);
 
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
@@ -106,6 +113,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
 	int brightness = bl->props.brightness;
+	struct pwm_state state;
 	int duty_cycle;
 
 	if (bl->props.power != FB_BLANK_UNBLANK ||
@@ -118,8 +126,13 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 
 	if (brightness > 0) {
 		duty_cycle = compute_duty_cycle(pb, brightness);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
-		pwm_backlight_power_on(pb, brightness);
+		pwm_get_state(pb->pwm, &state);
+		state.duty_cycle = duty_cycle;
+		state.period = pb->period;
+		if (!state.enabled)
+			pwm_backlight_power_on(pb, &state);
+		else
+			pwm_apply_state(pb->pwm, &state);
 	} else
 		pwm_backlight_power_off(pb);
 
@@ -447,7 +460,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct pwm_bl_data *pb;
 	struct pwm_state state;
-	struct pwm_args pargs;
 	unsigned int i;
 	int ret;
 
@@ -539,10 +551,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
-	if (!data->levels) {
-		/* Get the PWM period (in nanoseconds) */
-		pwm_get_state(pb->pwm, &state);
+	/* Sync up PWM state and ensure it is off. */
+	pwm_init_state(pb->pwm, &state);
+	state.enabled = false;
+	ret = pwm_apply_state(pb->pwm, &state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
+			ret);
+		goto err_alloc;
+	}
 
+	if (!data->levels) {
 		ret = pwm_backlight_brightness_default(&pdev->dev, data,
 						       state.period);
 		if (ret < 0) {
@@ -559,20 +578,13 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->levels = data->levels;
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
 	 * set the period from platform data if it has not already been set
 	 * via the PWM lookup table.
 	 */
-	pwm_get_args(pb->pwm, &pargs);
-	pb->period = pargs.period;
+	pb->period = state.period;
 	if (!pb->period && (data->pwm_period_ns > 0))
 		pb->period = data->pwm_period_ns;
 
-- 
2.18.0

