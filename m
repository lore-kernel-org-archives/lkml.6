Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891A720841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891A720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeGaU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:27:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38777 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbeGaU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:27:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so9523397pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/YRFKb3RzI0H1RpA3VS7FFvDUztiE2CUhFcLa1cepw=;
        b=b7KA8HKzx2q3622GzoHGt5ouauPpIRRjCLt2SqLMLhIgpvQtnokbgDgaPyjEh6KU1Z
         GwNWsYm+fQURIdYbEGZy8NEeZTiuSgwYU/3mq/6Nh2r5PNos4exm1qNZxu7vGJJosdwv
         itRdG70KGX0J/5ILzN87QBL6wGOJUyEAPUzh4OWQoy8fIn5t7F4VKV4HRf2NM+n8Kqb/
         tU4MDkLV4GXSmm815ys9jX0qxfEARcQEQG1W5DG4dc1acev6aahyNg5W8Z/RyqRLmzAL
         x5gq9eNPXis8RzBqmJs22L6+Ajv0EIf++kw7UZrHbCRSmkGrhShtHC7AUZI8/FcJWKGo
         htCA==
X-Gm-Message-State: AOUpUlFDAqGyWXh/vLu7eGDDiWc9IgKDh7mY5UKvNx+7PGQaCZoFv1ak
        Ioo1RSezzkYTLRi3uOS12BsHow==
X-Google-Smtp-Source: AAOMgpd5Y9/gGZpcCGj2VNMQwFfy35IKEc6nOpW09ux6vVqe69BO8U4OWn65/YRQvZkmoyNio7VsZA==
X-Received: by 2002:a62:20f:: with SMTP id 15-v6mr3962082pfc.100.1533062778045;
        Tue, 31 Jul 2018 11:46:18 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b21-v6sm4981683pgw.79.2018.07.31.11.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:46:17 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 3/5] thermal: qcom-spmi: Use PMIC thermal stage 2 for critical trip points
Date:   Tue, 31 Jul 2018 11:45:54 -0700
Message-Id: <20180731184556.169290-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731184556.169290-1-mka@chromium.org>
References: <20180731184556.169290-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three thermal stages defined in the PMIC:

stage 1: warning
stage 2: system should shut down
stage 3: emergency shut down

By default the PMIC assumes that the OS isn't doing anything and thus
at stage 2 it does a partial PMIC shutdown and at stage 3 it kills
all power. When switching between thermal stages the PMIC generates an
interrupt which is handled by the driver. The partial PMIC shutdown at
stage 2 can be disabled by software, which allows the OS to initiate a
shutdown at stage 2 with a thermal zone configured accordingly.

If a critical trip point is configured in the thermal zone the driver
adjusts the stage 1-3 temperature thresholds to (closely) match the
critical temperature with a stage 2 threshold (125/130/135/140 °C).
If a suitable match is found the partial shutdown at stage 2 is
disabled. If for some reason the system doesn't shutdown at stage 2
the emergency shutdown at stage 3 kicks in.

The partial shutdown at stage 2 remains enabled in these cases:
- no critical trip point defined
- the temperature of the critical trip point is < 125°C
- the temperature of the critical trip point is > 140°C and no
  ADC channel is configured (thus the OS is not notified when the critical
  temperature is reached)

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v6:
- fixed condition to check if ADC is configured in
  qpnp_tm_update_critical_trip_temp()
- changed °C in logs to C
- removed needless evaluation of qpnp_tm_write() return value in
  qpnp_tm_update_critical_trip_temp()
- move assignment of chip->initialized to true to qpnp_tm_init(),
  where the lock is held
- call thermal_zone_device_update() after initialization is
  completed
- split some #define + comment in two lines to avoid exceeding
  chars per line limit
- removed extra closing parenthesis in qpnp_tm_get_temp()
- remove unnecessary parentheses around conditions in
  qpnp_tm_update_critical_trip_temp() and qpnp_tm_get_critical_trip_temp()
- fixed indentation of call devm_thermal_zone_of_sensor_register() call
  in qpnp_tm_probe()

Changes in v5:
- patch added to the series
---
 drivers/thermal/qcom-spmi-temp-alarm.c | 158 ++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index ad4f3a8d6560..b2d5d5bf4a9b 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -23,6 +23,8 @@
 #include <linux/regmap.h>
 #include <linux/thermal.h>
 
+#include "thermal_core.h"
+
 #define QPNP_TM_REG_TYPE		0x04
 #define QPNP_TM_REG_SUBTYPE		0x05
 #define QPNP_TM_REG_STATUS		0x08
@@ -37,9 +39,11 @@
 #define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
 #define STATUS_GEN2_STATE_SHIFT		4
 
-#define SHUTDOWN_CTRL1_OVERRIDE_MASK	GENMASK(7, 6)
+#define SHUTDOWN_CTRL1_OVERRIDE_S2	BIT(6)
 #define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
 
+#define SHUTDOWN_CTRL1_RATE_25HZ	BIT(3)
+
 #define ALARM_CTRL_FORCE_ENABLE		BIT(7)
 
 /*
@@ -56,12 +60,19 @@
 #define TEMP_THRESH_STEP		5000	/* Threshold step: 5 C */
 
 #define THRESH_MIN			0
+#define THRESH_MAX			3
+
+/* Stage 2 Threshold Min: 125 C */
+#define STAGE2_THRESHOLD_MIN		125000
+/* Stage 2 Threshold Max: 140 C */
+#define STAGE2_THRESHOLD_MAX		140000
 
 /* Temperature in Milli Celsius reported during stage 0 if no ADC is present */
 #define DEFAULT_TEMP			37000
 
 struct qpnp_tm_chip {
 	struct regmap			*map;
+	struct device			*dev;
 	struct thermal_zone_device	*tz_dev;
 	unsigned int			subtype;
 	long				temp;
@@ -69,6 +80,10 @@ struct qpnp_tm_chip {
 	unsigned int			stage;
 	unsigned int			prev_stage;
 	unsigned int			base;
+	/* protects .thresh, .stage and chip registers */
+	struct mutex			lock;
+	bool				initialized;
+
 	struct iio_channel		*adc;
 };
 
@@ -125,6 +140,8 @@ static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
 	unsigned int stage, stage_new, stage_old;
 	int ret;
 
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
 	ret = qpnp_tm_get_temp_stage(chip);
 	if (ret < 0)
 		return ret;
@@ -163,8 +180,15 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 	if (!temp)
 		return -EINVAL;
 
+	if (!chip->initialized) {
+		*temp = DEFAULT_TEMP;
+		return 0;
+	}
+
 	if (!chip->adc) {
+		mutex_lock(&chip->lock);
 		ret = qpnp_tm_update_temp_no_adc(chip);
+		mutex_unlock(&chip->lock);
 		if (ret < 0)
 			return ret;
 	} else {
@@ -180,8 +204,72 @@ static int qpnp_tm_get_temp(void *data, int *temp)
 	return 0;
 }
 
+static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
+					     int temp)
+{
+	u8 reg;
+	bool disable_s2_shutdown = false;
+
+	WARN_ON(!mutex_is_locked(&chip->lock));
+
+	/*
+	 * Default: S2 and S3 shutdown enabled, thresholds at
+	 * 105C/125C/145C, monitoring at 25Hz
+	 */
+	reg = SHUTDOWN_CTRL1_RATE_25HZ;
+
+	if (temp == THERMAL_TEMP_INVALID ||
+	    temp < STAGE2_THRESHOLD_MIN) {
+		chip->thresh = THRESH_MIN;
+		goto skip;
+	}
+
+	if (temp <= STAGE2_THRESHOLD_MAX) {
+		chip->thresh = THRESH_MAX -
+			((STAGE2_THRESHOLD_MAX - temp) /
+			 TEMP_THRESH_STEP);
+		disable_s2_shutdown = true;
+	} else {
+		chip->thresh = THRESH_MAX;
+
+		if (chip->adc)
+			disable_s2_shutdown = true;
+		else
+			dev_warn(chip->dev,
+				 "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140 C! Configuring stage 2 shutdown at 140 C.\n");
+	}
+
+skip:
+	reg |= chip->thresh;
+	if (disable_s2_shutdown)
+		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
+
+	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
+}
+
+static int qpnp_tm_set_trip_temp(void *data, int trip, int temp)
+{
+	struct qpnp_tm_chip *chip = data;
+	const struct thermal_trip *trip_points;
+	int ret;
+
+	trip_points = of_thermal_get_trip_points(chip->tz_dev);
+	if (!trip_points)
+		return -EINVAL;
+
+	if (trip_points[trip].type != THERMAL_TRIP_CRITICAL)
+		return 0;
+
+	mutex_lock(&chip->lock);
+	ret = qpnp_tm_update_critical_trip_temp(chip, temp);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
 static const struct thermal_zone_of_device_ops qpnp_tm_sensor_ops = {
 	.get_temp = qpnp_tm_get_temp,
+	.set_trip_temp = qpnp_tm_set_trip_temp,
 };
 
 static irqreturn_t qpnp_tm_isr(int irq, void *data)
@@ -193,6 +281,29 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int qpnp_tm_get_critical_trip_temp(struct qpnp_tm_chip *chip)
+{
+	int ntrips;
+	const struct thermal_trip *trips;
+	int i;
+
+	ntrips = of_thermal_get_ntrips(chip->tz_dev);
+	if (ntrips <= 0)
+		return THERMAL_TEMP_INVALID;
+
+	trips = of_thermal_get_trip_points(chip->tz_dev);
+	if (!trips)
+		return THERMAL_TEMP_INVALID;
+
+	for (i = 0; i < ntrips; i++) {
+		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
+		    trips[i].type == THERMAL_TRIP_CRITICAL)
+			return trips[i].temperature;
+	}
+
+	return THERMAL_TEMP_INVALID;
+}
+
 /*
  * This function initializes the internal temp value based on only the
  * current thermal stage and threshold. Setup threshold control and
@@ -203,17 +314,20 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 	unsigned int stage;
 	int ret;
 	u8 reg = 0;
+	int crit_temp;
+
+	mutex_lock(&chip->lock);
 
 	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	chip->thresh = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
 	chip->temp = DEFAULT_TEMP;
 
 	ret = qpnp_tm_get_temp_stage(chip);
 	if (ret < 0)
-		return ret;
+		goto out;
 	chip->stage = ret;
 
 	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
@@ -224,21 +338,19 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
 			     (stage - 1) * TEMP_STAGE_STEP +
 			     TEMP_THRESH_MIN;
 
-	/*
-	 * Set threshold and disable software override of stage 2 and 3
-	 * shutdowns.
-	 */
-	chip->thresh = THRESH_MIN;
-	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_MASK | SHUTDOWN_CTRL1_THRESHOLD_MASK);
-	reg |= chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
+	crit_temp = qpnp_tm_get_critical_trip_temp(chip);
+	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	/* Enable the thermal alarm PMIC module in always-on mode. */
 	reg = ALARM_CTRL_FORCE_ENABLE;
 	ret = qpnp_tm_write(chip, QPNP_TM_REG_ALARM_CTRL, reg);
 
+	chip->initialized = true;
+
+out:
+	mutex_unlock(&chip->lock);
 	return ret;
 }
 
@@ -257,6 +369,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dev_set_drvdata(&pdev->dev, chip);
+	chip->dev = &pdev->dev;
+
+	mutex_init(&chip->lock);
 
 	chip->map = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!chip->map)
@@ -302,6 +417,18 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	chip->subtype = subtype;
 
+	/*
+	 * Register the sensor before initializing the hardware to be able to
+	 * read the trip points. get_temp() returns the default temperature
+	 * before the hardware initialization is completed.
+	 */
+	chip->tz_dev = devm_thermal_zone_of_sensor_register(
+		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
+	if (IS_ERR(chip->tz_dev)) {
+		dev_err(&pdev->dev, "failed to register sensor\n");
+		return PTR_ERR(chip->tz_dev);
+	}
+
 	ret = qpnp_tm_init(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "init failed\n");
@@ -313,12 +440,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
-							&qpnp_tm_sensor_ops);
-	if (IS_ERR(chip->tz_dev)) {
-		dev_err(&pdev->dev, "failed to register sensor\n");
-		return PTR_ERR(chip->tz_dev);
-	}
+	thermal_zone_device_update(chip->tz_dev, THERMAL_EVENT_UNSPECIFIED);
 
 	return 0;
 }
-- 
2.18.0.345.g5c9ce644c3-goog

