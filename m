Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeECJ7Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:59:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeECJ7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:59:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA3246090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From: Kiran Gunda <kgunda@codeaurora.org>
To: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V1 5/5] backlight: qcom-wled: Add auto string detection logic
Date: Thu,  3 May 2018 15:27:12 +0530
Message-Id: <1525341432-15818-6-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auto string detection algorithm checks if the current WLED
sink configuration is valid. It tries enabling every sink and
checks if the OVP fault is observed. Based on this information
it detects and enables the valid sink configuration.
Auto calibration will be triggered when the OVP fault interrupts
are seen frequently thereby it tries to fix the sink configuration.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 drivers/video/backlight/qcom-wled.c | 302 ++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 80ae084..bacdf3f 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -33,11 +33,14 @@
 #define  WLED4_CTRL_REG_SC_FAULT_BIT			BIT(2)
 
 #define WLED3_CTRL_REG_INT_RT_STS			0x10
+#define  WLED3_CTRL_REG_OVP_FAULT_STATUS		BIT(1)
 
 #define WLED3_CTRL_REG_MOD_EN				0x46
 #define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
 #define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
 
+#define WLED3_CTRL_REG_FEEDBACK_CONTROL			0x48
+
 #define WLED3_CTRL_REG_FREQ				0x4c
 #define  WLED3_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
 
@@ -152,6 +155,7 @@ struct wled_config {
 	bool ext_gen;
 	bool cabc;
 	bool external_pfet;
+	bool auto_detection_enabled;
 };
 
 struct wled {
@@ -160,8 +164,10 @@ struct wled {
 	struct regmap *regmap;
 	struct mutex lock;	/* Lock to avoid race from ISR */
 	ktime_t last_short_event;
+	ktime_t start_ovp_fault_time;
 	u16 ctrl_addr;
 	u16 sink_addr;
+	u16 auto_detection_ovp_count;
 	u32 brightness;
 	u32 max_brightness;
 	u32 short_count;
@@ -170,6 +176,7 @@ struct wled {
 	int ovp_irq;
 	bool force_mod_disable;
 	bool ovp_irq_disabled;
+	bool auto_detection_done;
 
 	struct wled_config cfg;
 	struct delayed_work ovp_work;
@@ -386,6 +393,292 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
 	return IRQ_HANDLED;
 }
 
+#define AUTO_DETECT_BRIGHTNESS		200
+static int wled_auto_string_detection(struct wled *wled)
+{
+	int rc = 0, i;
+	u32 sink_config = 0, int_sts;
+	u8 sink_test = 0, sink_valid = 0, val;
+
+	if (wled->auto_detection_done)
+		return 0;
+
+	/* read configured sink configuration */
+	rc = regmap_read(wled->regmap, wled->sink_addr +
+			 WLED4_SINK_REG_CURR_SINK, &sink_config);
+	if (rc < 0) {
+		pr_err("Failed to read SINK configuration rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* disable the module before starting detection */
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+				WLED3_CTRL_REG_MOD_EN_MASK, 0);
+	if (rc < 0) {
+		pr_err("Failed to disable WLED module rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* set low brightness across all sinks */
+	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	if (rc < 0) {
+		pr_err("Failed to set brightness for auto detection rc=%d\n",
+		       rc);
+		goto failed_detect;
+	}
+
+	if (wled->cfg.cabc) {
+		for (i = 0; i < wled->cfg.num_strings; i++) {
+			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
+						WLED4_SINK_REG_STR_CABC(i),
+						WLED4_SINK_REG_STR_CABC_MASK,
+						0);
+			if (rc < 0)
+				goto failed_detect;
+		}
+	}
+
+	/* disable all sinks */
+	rc = regmap_write(wled->regmap,
+			  wled->sink_addr + WLED4_SINK_REG_CURR_SINK, 0);
+	if (rc < 0) {
+		pr_err("Failed to disable all sinks rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* iterate through the strings one by one */
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		sink_test = BIT((WLED4_SINK_REG_CURR_SINK_SHFT + i));
+
+		/* Enable feedback control */
+		rc = regmap_write(wled->regmap, wled->ctrl_addr +
+				  WLED3_CTRL_REG_FEEDBACK_CONTROL, i + 1);
+		if (rc < 0) {
+			pr_err("Failed to enable feedback for SINK %d rc = %d\n",
+			       i + 1, rc);
+			goto failed_detect;
+		}
+
+		/* enable the sink */
+		rc = regmap_write(wled->regmap, wled->sink_addr +
+				  WLED4_SINK_REG_CURR_SINK, sink_test);
+		if (rc < 0) {
+			pr_err("Failed to configure SINK %d rc=%d\n", i + 1,
+			       rc);
+			goto failed_detect;
+		}
+
+		/* Enable the module */
+		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+					WLED3_CTRL_REG_MOD_EN,
+					WLED3_CTRL_REG_MOD_EN_MASK,
+					WLED3_CTRL_REG_MOD_EN_MASK);
+		if (rc < 0) {
+			pr_err("Failed to enable WLED module rc=%d\n", rc);
+			goto failed_detect;
+		}
+
+		usleep_range(WLED_SOFT_START_DLY_US,
+			     WLED_SOFT_START_DLY_US + 1000);
+
+		rc = regmap_read(wled->regmap, wled->ctrl_addr +
+				 WLED3_CTRL_REG_INT_RT_STS, &int_sts);
+		if (rc < 0) {
+			pr_err("Error in reading WLED3_CTRL_INT_RT_STS rc=%d\n",
+			       rc);
+			goto failed_detect;
+		}
+
+		if (int_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
+			pr_debug("WLED OVP fault detected with SINK %d\n",
+				 i + 1);
+		else
+			sink_valid |= sink_test;
+
+		/* Disable the module */
+		rc = regmap_update_bits(wled->regmap,
+					wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+					WLED3_CTRL_REG_MOD_EN_MASK, 0);
+		if (rc < 0) {
+			pr_err("Failed to disable WLED module rc=%d\n", rc);
+			goto failed_detect;
+		}
+	}
+
+	if (sink_valid == sink_config) {
+		pr_debug("WLED auto-detection complete, default sink-config=%x OK!\n",
+			 sink_config);
+	} else {
+		pr_warn("Invalid WLED default sink config=%x changing it to=%x\n",
+			sink_config, sink_valid);
+		sink_config = sink_valid;
+	}
+
+	if (!sink_config) {
+		pr_err("No valid WLED sinks found\n");
+		wled->force_mod_disable = true;
+		goto failed_detect;
+	}
+
+	/* write the new sink configuration */
+	rc = regmap_write(wled->regmap,
+			  wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
+			  sink_config);
+	if (rc < 0) {
+		pr_err("Failed to reconfigure the default sink rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* Enable valid sinks */
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		if (wled->cfg.cabc) {
+			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
+						WLED4_SINK_REG_STR_CABC(i),
+						WLED4_SINK_REG_STR_CABC_MASK,
+						WLED4_SINK_REG_STR_CABC_MASK);
+			if (rc < 0)
+				goto failed_detect;
+		}
+
+		if (sink_config & BIT(WLED4_SINK_REG_CURR_SINK_SHFT + i))
+			val = WLED4_SINK_REG_STR_MOD_MASK;
+		else
+			val = 0x0; /* disable modulator_en for unused sink */
+
+		rc = regmap_write(wled->regmap, wled->sink_addr +
+				  WLED4_SINK_REG_STR_MOD_EN(i), val);
+		if (rc < 0) {
+			pr_err("Failed to configure MODULATOR_EN rc=%d\n", rc);
+			goto failed_detect;
+		}
+	}
+
+	/* restore the feedback setting */
+	rc = regmap_write(wled->regmap,
+			  wled->ctrl_addr + WLED3_CTRL_REG_FEEDBACK_CONTROL, 0);
+	if (rc < 0) {
+		pr_err("Failed to restore feedback setting rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* restore  brightness */
+	rc = wled4_set_brightness(wled, wled->brightness);
+	if (rc < 0) {
+		pr_err("Failed to set brightness after auto detection rc=%d\n",
+		       rc);
+		goto failed_detect;
+	}
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+				WLED3_CTRL_REG_MOD_EN_MASK,
+				WLED3_CTRL_REG_MOD_EN_MASK);
+	if (rc < 0) {
+		pr_err("Failed to enable WLED module rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	wled->auto_detection_done = true;
+
+failed_detect:
+	return rc;
+}
+
+#define WLED_AUTO_DETECT_OVP_COUNT		5
+#define WLED_AUTO_DETECT_CNT_DLY_US		HZ /* 1 second */
+static bool wled_auto_detection_required(struct wled *wled)
+{
+	s64 elapsed_time_us;
+
+	if (*wled->version == WLED_PM8941)
+		return false;
+	/*
+	 * Check if the OVP fault was an occasional one
+	 * or if it's firing continuously, the latter qualifies
+	 * for an auto-detection check.
+	 */
+	if (!wled->auto_detection_ovp_count) {
+		wled->start_ovp_fault_time = ktime_get();
+		wled->auto_detection_ovp_count++;
+	} else {
+		elapsed_time_us = ktime_us_delta(ktime_get(),
+						 wled->start_ovp_fault_time);
+		if (elapsed_time_us > WLED_AUTO_DETECT_CNT_DLY_US)
+			wled->auto_detection_ovp_count = 0;
+		else
+			wled->auto_detection_ovp_count++;
+
+		if (wled->auto_detection_ovp_count >=
+				WLED_AUTO_DETECT_OVP_COUNT) {
+			wled->auto_detection_ovp_count = 0;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static int wled_auto_detection_at_init(struct wled *wled)
+{
+	int rc;
+	u32 fault_status = 0, rt_status = 0;
+
+	if (*wled->version == WLED_PM8941)
+		return 0;
+
+	if (!wled->cfg.auto_detection_enabled)
+		return 0;
+
+	rc = regmap_read(wled->regmap,
+			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS,
+			 &rt_status);
+	if (rc < 0) {
+		pr_err("Failed to read RT status rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = regmap_read(wled->regmap,
+			 wled->ctrl_addr + WLED3_CTRL_REG_FAULT_STATUS,
+			 &fault_status);
+	if (rc < 0) {
+		pr_err("Failed to read fault status rc=%d\n", rc);
+		return rc;
+	}
+
+	if ((rt_status & WLED3_CTRL_REG_OVP_FAULT_STATUS) ||
+	    (fault_status & WLED3_CTRL_REG_OVP_FAULT_BIT)) {
+		mutex_lock(&wled->lock);
+		rc = wled_auto_string_detection(wled);
+		if (!rc)
+			wled->auto_detection_done = true;
+		mutex_unlock(&wled->lock);
+	}
+
+	return rc;
+}
+
+static void handle_ovp_fault(struct wled *wled)
+{
+	if (!wled->cfg.auto_detection_enabled)
+		return;
+
+	mutex_lock(&wled->lock);
+	if (wled->ovp_irq > 0 && !wled->ovp_irq_disabled) {
+		disable_irq_nosync(wled->ovp_irq);
+		wled->ovp_irq_disabled = true;
+	}
+
+	if (wled_auto_detection_required(wled))
+		wled_auto_string_detection(wled);
+
+	if (wled->ovp_irq > 0 && wled->ovp_irq_disabled) {
+		enable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = false;
+	}
+	mutex_unlock(&wled->lock);
+}
+
 static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 {
 	struct wled *wled = _wled;
@@ -413,6 +706,9 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
 		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
 			int_sts, fault_sts);
 
+	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT)
+		handle_ovp_fault(wled);
+
 	return IRQ_HANDLED;
 }
 
@@ -575,6 +871,10 @@ static int wled4_setup(struct wled *wled)
 		return rc;
 	}
 
+	rc = wled_auto_detection_at_init(wled);
+	if (rc < 0)
+		return rc;
+
 	if (wled->cfg.external_pfet) {
 		/* Unlock the secure register access */
 		rc = regmap_write(wled->regmap, wled->ctrl_addr +
@@ -602,6 +902,7 @@ static int wled4_setup(struct wled *wled)
 	.enabled_strings = 0xf,
 	.cabc = false,
 	.external_pfet = true,
+	.auto_detection_enabled = false,
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
@@ -785,6 +1086,7 @@ static int wled_configure(struct wled *wled)
 		{ "qcom,ext-gen", &cfg->ext_gen, },
 		{ "qcom,cabc", &cfg->cabc, },
 		{ "qcom,external-pfet", &cfg->external_pfet, },
+		{ "qcom,auto-string-detection", &cfg->auto_detection_enabled, },
 	};
 
 	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
