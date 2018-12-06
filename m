Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9655C20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107422;
	bh=ZgHKG2NfqULpAy49a5Ct09VIqWCmMciZ7s/aKdcnEmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIZnyMxUL2G/RxUqBlIqkbA8Xt9talIuI/BXCI/oMRtg84D2icgSw3RXE9iwfwn1V
	 blw5d8tA71xsvLIuHp42IgeiI/Vvk6TpPkcG7oO1EnKE2mOkhgKYrF78Xi2lBboRLH
	 mL9vEGS041DMCG+EOxOL1nsplkIg3tmRoxttqQVc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9655C20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeLFOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbeLFOnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D224920892;
        Thu,  6 Dec 2018 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107416;
        bh=ZgHKG2NfqULpAy49a5Ct09VIqWCmMciZ7s/aKdcnEmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/gHhDvKu+B9HUW/dLKyyGONa/1qnMYRFbCOL8moUWV0o4dgJKSg4TZUkxljLoAo+
         LeZjJaF5SlBTeb5TbqYyLsTp6SonYiNfX8qdo8EwDs82cY5sA8xwR+i+QQWiR+x+x6
         lWTnu6adFbr+aRSpYYqddFIscJt5/cA2BO5rXdbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.14 52/55] thermal/drivers/hisi: Remove costly sensor inspection
Date:   Thu,  6 Dec 2018 15:39:26 +0100
Message-Id: <20181206143004.548910244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 10d7e9a9181f4637640f388d334c6740c1b5d0e8 upstream.

The sensor is all setup, bind, resetted, acked, etc... every single second.

That was the way to workaround a problem with the interrupt bouncing again and
again.

With the following changes, we fix all in one:

 - Do the setup, one time, at probe time

 - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler

 - Remove the interrupt handler

 - Set the correct value for the LAG register

 - Remove all the irq_enabled stuff in the code as the interruption
   handling is fixed

 - Remove the 3ms delay

 - Reorder the initialization routine to be in the right order

It ends up to a nicer code and more efficient, the 3-5ms delay is removed from
the get_temp() path.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/hisi_thermal.c |  205 ++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 111 deletions(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -41,6 +41,7 @@
 #define HISI_TEMP_BASE			(-60000)
 #define HISI_TEMP_RESET			(100000)
 #define HISI_TEMP_STEP			(784)
+#define HISI_TEMP_LAG			(3500)
 
 #define HISI_MAX_SENSORS		4
 #define HISI_DEFAULT_SENSOR		2
@@ -60,8 +61,6 @@ struct hisi_thermal_data {
 	struct clk *clk;
 	struct hisi_thermal_sensor sensors;
 	int irq;
-	bool irq_enabled;
-
 	void __iomem *regs;
 };
 
@@ -99,9 +98,40 @@ static inline long hisi_thermal_round_te
 		hisi_thermal_temp_to_step(temp));
 }
 
+/*
+ * The lag register contains 5 bits encoding the temperature in steps.
+ *
+ * Each time the temperature crosses the threshold boundary, an
+ * interrupt is raised. It could be when the temperature is going
+ * above the threshold or below. However, if the temperature is
+ * fluctuating around this value due to the load, we can receive
+ * several interrupts which may not desired.
+ *
+ * We can setup a temperature representing the delta between the
+ * threshold and the current temperature when the temperature is
+ * decreasing.
+ *
+ * For instance: the lag register is 5°C, the threshold is 65°C, when
+ * the temperature reaches 65°C an interrupt is raised and when the
+ * temperature decrease to 65°C - 5°C another interrupt is raised.
+ *
+ * A very short lag can lead to an interrupt storm, a long lag
+ * increase the latency to react to the temperature changes.  In our
+ * case, that is not really a problem as we are polling the
+ * temperature.
+ *
+ * [0:4] : lag register
+ *
+ * The temperature is coded in steps, cf. HISI_TEMP_STEP.
+ *
+ * Min : 0x00 :  0.0 °C
+ * Max : 0x1F : 24.3 °C
+ *
+ * The 'value' parameter is in milliCelsius.
+ */
 static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_LAG);
+	writel((value / HISI_TEMP_STEP) & 0x1F, addr + TEMP0_LAG);
 }
 
 static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
@@ -171,71 +201,6 @@ static inline void hisi_thermal_hdak_set
 	       (value << 4), addr + TEMP0_CFG);
 }
 
-static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
-					 struct hisi_thermal_sensor *sensor)
-{
-	long val;
-
-	mutex_lock(&data->thermal_lock);
-
-	/* disable interrupt */
-	hisi_thermal_alarm_enable(data->regs, 0);
-	hisi_thermal_alarm_clear(data->regs, 1);
-
-	/* disable module firstly */
-	hisi_thermal_enable(data->regs, 0);
-
-	/* select sensor id */
-	hisi_thermal_sensor_select(data->regs, sensor->id);
-
-	/* enable module */
-	hisi_thermal_enable(data->regs, 1);
-
-	usleep_range(3000, 5000);
-
-	val = hisi_thermal_get_temperature(data->regs);
-
-	mutex_unlock(&data->thermal_lock);
-
-	return val;
-}
-
-static void hisi_thermal_enable_bind_irq_sensor
-			(struct hisi_thermal_data *data)
-{
-	struct hisi_thermal_sensor *sensor;
-
-	mutex_lock(&data->thermal_lock);
-
-	sensor = &data->sensors;
-
-	/* setting the hdak time */
-	hisi_thermal_hdak_set(data->regs, 0);
-
-	/* disable module firstly */
-	hisi_thermal_reset_enable(data->regs, 0);
-	hisi_thermal_enable(data->regs, 0);
-
-	/* select sensor id */
-	hisi_thermal_sensor_select(data->regs, sensor->id);
-
-	/* enable for interrupt */
-	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
-
-	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
-
-	/* enable module */
-	hisi_thermal_reset_enable(data->regs, 1);
-	hisi_thermal_enable(data->regs, 1);
-
-	hisi_thermal_alarm_clear(data->regs, 0);
-	hisi_thermal_alarm_enable(data->regs, 1);
-
-	usleep_range(3000, 5000);
-
-	mutex_unlock(&data->thermal_lock);
-}
-
 static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
 {
 	mutex_lock(&data->thermal_lock);
@@ -253,25 +218,10 @@ static int hisi_thermal_get_temp(void *_
 	struct hisi_thermal_sensor *sensor = _sensor;
 	struct hisi_thermal_data *data = sensor->thermal;
 
-	*temp = hisi_thermal_get_sensor_temp(data, sensor);
+	*temp = hisi_thermal_get_temperature(data->regs);
 
-	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%d, thres=%d\n",
-		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
-	/*
-	 * Bind irq to sensor for two cases:
-	 *   Reenable alarm IRQ if temperature below threshold;
-	 *   if irq has been enabled, always set it;
-	 */
-	if (data->irq_enabled) {
-		hisi_thermal_enable_bind_irq_sensor(data);
-		return 0;
-	}
-
-	if (*temp < sensor->thres_temp) {
-		data->irq_enabled = true;
-		hisi_thermal_enable_bind_irq_sensor(data);
-		enable_irq(data->irq);
-	}
+	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
+		sensor->id, *temp, sensor->thres_temp);
 
 	return 0;
 }
@@ -280,26 +230,27 @@ static const struct thermal_zone_of_devi
 	.get_temp = hisi_thermal_get_temp,
 };
 
-static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
-{
-	struct hisi_thermal_data *data = dev;
-
-	disable_irq_nosync(irq);
-	data->irq_enabled = false;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
 	struct hisi_thermal_sensor *sensor = &data->sensors;
+	int temp;
 
-	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
-		 sensor->thres_temp);
+	hisi_thermal_alarm_clear(data->regs, 1);
 
-	thermal_zone_device_update(data->sensors.tzd,
-				   THERMAL_EVENT_UNSPECIFIED);
+	temp = hisi_thermal_get_temperature(data->regs);
+
+	if (temp >= sensor->thres_temp) {
+		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
+			 temp, sensor->thres_temp);
+
+		thermal_zone_device_update(data->sensors.tzd,
+					   THERMAL_EVENT_UNSPECIFIED);
+
+	} else if (temp < sensor->thres_temp) {
+		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
+			 temp, sensor->thres_temp);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -352,6 +303,40 @@ static void hisi_thermal_toggle_sensor(s
 		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
 }
 
+static int hisi_thermal_setup(struct hisi_thermal_data *data)
+{
+	struct hisi_thermal_sensor *sensor;
+
+	sensor = &data->sensors;
+
+	/* disable module firstly */
+	hisi_thermal_reset_enable(data->regs, 0);
+	hisi_thermal_enable(data->regs, 0);
+
+	/* select sensor id */
+	hisi_thermal_sensor_select(data->regs, sensor->id);
+
+	/* setting the hdak time */
+	hisi_thermal_hdak_set(data->regs, 0);
+
+	/* setting lag value between current temp and the threshold */
+	hisi_thermal_set_lag(data->regs, HISI_TEMP_LAG);
+
+	/* enable for interrupt */
+	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
+
+	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
+
+	/* enable module */
+	hisi_thermal_reset_enable(data->regs, 1);
+	hisi_thermal_enable(data->regs, 1);
+
+	hisi_thermal_alarm_clear(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 1);
+
+	return 0;
+}
+
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
@@ -394,9 +379,6 @@ static int hisi_thermal_probe(struct pla
 		return ret;
 	}
 
-	hisi_thermal_enable_bind_irq_sensor(data);
-	data->irq_enabled = true;
-
 	ret = hisi_thermal_register_sensor(pdev, data,
 					   &data->sensors,
 					   HISI_DEFAULT_SENSOR);
@@ -406,10 +388,15 @@ static int hisi_thermal_probe(struct pla
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
-					hisi_thermal_alarm_irq,
+	ret = hisi_thermal_setup(data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to setup the sensor: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq, NULL,
 					hisi_thermal_alarm_irq_thread,
-					0, "hisi_thermal", data);
+					IRQF_ONESHOT, "hisi_thermal", data);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
 		return ret;
@@ -417,8 +404,6 @@ static int hisi_thermal_probe(struct pla
 
 	hisi_thermal_toggle_sensor(&data->sensors, true);
 
-	enable_irq(data->irq);
-
 	return 0;
 }
 
@@ -440,7 +425,6 @@ static int hisi_thermal_suspend(struct d
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
 	hisi_thermal_disable_sensor(data);
-	data->irq_enabled = false;
 
 	clk_disable_unprepare(data->clk);
 
@@ -456,8 +440,7 @@ static int hisi_thermal_resume(struct de
 	if (ret)
 		return ret;
 
-	data->irq_enabled = true;
-	hisi_thermal_enable_bind_irq_sensor(data);
+	hisi_thermal_setup(data);
 
 	return 0;
 }


