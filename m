Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58442C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ADC20877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EHykonc3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f15E4Dy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ADC20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbeGIKYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:24:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33534 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932923AbeGIKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:24:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1008360B26; Mon,  9 Jul 2018 10:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131852;
        bh=8+i5z+S//5l7hhiuzdNYC1hVosJ4WQdimFZu216fles=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHykonc3k4gtu92B+QWei72EsFT1r9QHHEjmFFuleafC1NFJOHN6ynK3y+cDdTLa/
         9XvdugDk/HgFqb2gpNU7IdLikbeY6Lpuat+19IcHlpqMVxo/d5GyAaMz0XCG6grhow
         uiSO6LlGczD6wYyEhKSpqZUDsBmfY1mZEr39uB1g=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC0F460B28;
        Mon,  9 Jul 2018 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531131849;
        bh=8+i5z+S//5l7hhiuzdNYC1hVosJ4WQdimFZu216fles=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f15E4Dy6aq0C12+4piRxBBDlPH0Aq0pieAP7Kagt/XAUS4rWEijkLAw04i8/ZCG7N
         rXj62+5oM/4NEDwaJhpP2NVkOocd+N37vidpF+NfuzcNvgykdhk0YTjOBdFMTXO+GS
         L2VGyyPZ6bIlzPQPmJpO/ngb9uauPggR6H19VTTA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC0F460B28
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V4 8/8] backlight: qcom-wled: Add auto string detection logic
Date:   Mon,  9 Jul 2018 15:52:21 +0530
Message-Id: <1531131741-19971-9-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auto string detection algorithm checks if the current WLED
sink configuration is valid. It tries enabling every sink and
checks if the OVP fault is observed. Based on this information
it detects and enables the valid sink configuration.
Auto calibration will be triggered when the OVP fault interrupts
are seen frequently thereby it tries to fix the sink configuration.

The auto-detection also kicks in when the connected LED string
of the display-backlight malfunctions (because of damage) and
requires the damaged string to be turned off to prevent the
complete panel and/or board from being damaged.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
Changes from V3:
	- Optimized the wled_ovp_work
	- pr_err/pr_dbg to dev_err/dev_dbg
	- removed un-necessary variable initializations
	- Addressed few other comments from Bjorn 

 drivers/video/backlight/qcom-wled.c | 402 +++++++++++++++++++++++++++++++++++-
 1 file changed, 397 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index a14f1a6..b7d4fae 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -25,10 +25,18 @@
 #define WLED_MAX_STRINGS				4
 
 #define WLED_DEFAULT_BRIGHTNESS				2048
-
+#define WLED_SOFT_START_DLY_US				10000
 #define WLED_SINK_REG_BRIGHT_MAX			0xFFF
 
 /* WLED control registers */
+#define WLED_CTRL_REG_FAULT_STATUS			0x08
+#define  WLED_CTRL_REG_ILIM_FAULT_BIT			BIT(0)
+#define  WLED_CTRL_REG_OVP_FAULT_BIT			BIT(1)
+#define  WLED4_CTRL_REG_SC_FAULT_BIT			BIT(2)
+
+#define WLED_CTRL_REG_INT_RT_STS			0x10
+#define  WLED_CTRL_REG_OVP_FAULT_STATUS			BIT(1)
+
 #define WLED_CTRL_REG_MOD_EN				0x46
 #define  WLED_CTRL_REG_MOD_EN_MASK			BIT(7)
 #define  WLED_CTRL_REG_MOD_EN_SHIFT			7
@@ -36,6 +44,8 @@
 #define WLED_CTRL_REG_FREQ				0x4c
 #define  WLED_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
 
+#define WLED_CTRL_REG_FEEDBACK_CONTROL			0x48
+
 #define WLED_CTRL_REG_OVP				0x4d
 #define  WLED_CTRL_REG_OVP_MASK				GENMASK(1, 0)
 
@@ -127,6 +137,7 @@ struct wled_config {
 	bool ext_gen;
 	bool cabc;
 	bool external_pfet;
+	bool auto_detection_enabled;
 };
 
 struct wled {
@@ -135,16 +146,22 @@ struct wled {
 	struct regmap *regmap;
 	struct mutex lock;	/* Lock to avoid race from thread irq handler */
 	ktime_t last_short_event;
+	ktime_t start_ovp_fault_time;
 	u16 ctrl_addr;
 	u16 sink_addr;
 	u16 max_string_count;
+	u16 auto_detection_ovp_count;
 	u32 brightness;
 	u32 max_brightness;
 	u32 short_count;
+	u32 auto_detect_count;
 	bool disabled_by_short;
 	bool has_short_detect;
+	int ovp_irq;
+	bool ovp_irq_disabled;
 
 	struct wled_config cfg;
+	struct delayed_work ovp_work;
 	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
 };
 
@@ -189,6 +206,15 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
 	return 0;
 }
 
+static void wled_ovp_work(struct work_struct *work)
+{
+	struct wled *wled = container_of(work,
+					 struct wled, ovp_work.work);
+
+	if (wled->ovp_irq > 0)
+		enable_irq(wled->ovp_irq);
+}
+
 static int wled_module_enable(struct wled *wled, int val)
 {
 	int rc;
@@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, int val)
 				WLED_CTRL_REG_MOD_EN,
 				WLED_CTRL_REG_MOD_EN_MASK,
 				val << WLED_CTRL_REG_MOD_EN_SHIFT);
-	return rc;
+	if (rc < 0)
+		return rc;
+
+	if (val) {
+		schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
+	} else {
+		cancel_delayed_work_sync(&wled->ovp_work);
+		if (wled->ovp_irq > 0)
+			disable_irq(wled->ovp_irq);
+	}
+
+	return 0;
 }
 
 static int wled_sync_toggle(struct wled *wled)
@@ -307,6 +344,312 @@ static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
 	return IRQ_HANDLED;
 }
 
+#define AUTO_DETECT_BRIGHTNESS		200
+
+static void wled_auto_string_detection(struct wled *wled)
+{
+	int rc = 0, i;
+	u32 sink_config = 0, int_sts;
+	u8 sink_test = 0, sink_valid = 0, val;
+
+	/* read configured sink configuration */
+	rc = regmap_read(wled->regmap, wled->sink_addr +
+			 WLED4_SINK_REG_CURR_SINK, &sink_config);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to read SINK configuration rc=%d\n",
+			rc);
+		goto failed_detect;
+	}
+
+	/* disable the module before starting detection */
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED_CTRL_REG_MOD_EN,
+				WLED_CTRL_REG_MOD_EN_MASK, 0);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to disable WLED module rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* set low brightness across all sinks */
+	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to set brightness for auto detection rc=%d\n",
+			rc);
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
+		dev_err(wled->dev, "Failed to disable all sinks rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+	/* iterate through the strings one by one */
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		sink_test = BIT((WLED4_SINK_REG_CURR_SINK_SHFT + i));
+
+		/* Enable feedback control */
+		rc = regmap_write(wled->regmap, wled->ctrl_addr +
+				  WLED_CTRL_REG_FEEDBACK_CONTROL, i + 1);
+		if (rc < 0) {
+			dev_err(wled->dev, "Failed to enable feedback for SINK %d rc = %d\n",
+				i + 1, rc);
+			goto failed_detect;
+		}
+
+		/* enable the sink */
+		rc = regmap_write(wled->regmap, wled->sink_addr +
+				  WLED4_SINK_REG_CURR_SINK, sink_test);
+		if (rc < 0) {
+			dev_err(wled->dev, "Failed to configure SINK %d rc=%d\n",
+				i + 1, rc);
+			goto failed_detect;
+		}
+
+		/* Enable the module */
+		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+					WLED_CTRL_REG_MOD_EN,
+					WLED_CTRL_REG_MOD_EN_MASK,
+					WLED_CTRL_REG_MOD_EN_MASK);
+		if (rc < 0) {
+			dev_err(wled->dev, "Failed to enable WLED module rc=%d\n",
+				rc);
+			goto failed_detect;
+		}
+
+		usleep_range(WLED_SOFT_START_DLY_US,
+			     WLED_SOFT_START_DLY_US + 1000);
+
+		rc = regmap_read(wled->regmap, wled->ctrl_addr +
+				 WLED_CTRL_REG_INT_RT_STS, &int_sts);
+		if (rc < 0) {
+			dev_err(wled->dev, "Error in reading WLED3_CTRL_INT_RT_STS rc=%d\n",
+				rc);
+			goto failed_detect;
+		}
+
+		if (int_sts & WLED_CTRL_REG_OVP_FAULT_STATUS)
+			dev_dbg(wled->dev, "WLED OVP fault detected with SINK %d\n",
+				i + 1);
+		else
+			sink_valid |= sink_test;
+
+		/* Disable the module */
+		rc = regmap_update_bits(wled->regmap,
+					wled->ctrl_addr + WLED_CTRL_REG_MOD_EN,
+					WLED_CTRL_REG_MOD_EN_MASK, 0);
+		if (rc < 0) {
+			dev_err(wled->dev, "Failed to disable WLED module rc=%d\n",
+				rc);
+			goto failed_detect;
+		}
+	}
+
+	if (!sink_valid) {
+		dev_err(wled->dev, "No valid WLED sinks found\n");
+		wled->disabled_by_short = true;
+		goto failed_detect;
+	}
+
+	if (sink_valid == sink_config) {
+		dev_dbg(wled->dev, "WLED auto-detection complete, sink-config=%x OK!\n",
+			sink_config);
+	} else {
+		dev_warn(wled->dev, "New WLED string configuration found %x\n",
+			 sink_valid);
+		sink_config = sink_valid;
+	}
+
+	/* write the new sink configuration */
+	rc = regmap_write(wled->regmap,
+			  wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
+			  sink_config);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to reconfigure the default sink rc=%d\n",
+			rc);
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
+			dev_err(wled->dev, "Failed to configure MODULATOR_EN rc=%d\n",
+				rc);
+			goto failed_detect;
+		}
+	}
+
+	/* restore the feedback setting */
+	rc = regmap_write(wled->regmap,
+			  wled->ctrl_addr + WLED_CTRL_REG_FEEDBACK_CONTROL, 0);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to restore feedback setting rc=%d\n",
+			rc);
+		goto failed_detect;
+	}
+
+	/* restore brightness */
+	rc = wled4_set_brightness(wled, wled->brightness);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to set brightness after auto detection rc=%d\n",
+			rc);
+		goto failed_detect;
+	}
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED_CTRL_REG_MOD_EN,
+				WLED_CTRL_REG_MOD_EN_MASK,
+				WLED_CTRL_REG_MOD_EN_MASK);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to enable WLED module rc=%d\n", rc);
+		goto failed_detect;
+	}
+
+failed_detect:
+	return;
+}
+
+#define WLED_AUTO_DETECT_OVP_COUNT		5
+#define WLED_AUTO_DETECT_CNT_DLY_US		USEC_PER_SEC
+static bool wled_auto_detection_required(struct wled *wled)
+{
+	s64 elapsed_time_us;
+
+	if (!wled->cfg.auto_detection_enabled)
+		return false;
+
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
+	u32 fault_status, rt_status;
+
+	if (!wled->cfg.auto_detection_enabled)
+		return 0;
+
+	rc = regmap_read(wled->regmap,
+			 wled->ctrl_addr + WLED_CTRL_REG_INT_RT_STS,
+			 &rt_status);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to read RT status rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = regmap_read(wled->regmap,
+			 wled->ctrl_addr + WLED_CTRL_REG_FAULT_STATUS,
+			 &fault_status);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to read fault status rc=%d\n", rc);
+		return rc;
+	}
+
+	if ((rt_status & WLED_CTRL_REG_OVP_FAULT_STATUS) ||
+	    (fault_status & WLED_CTRL_REG_OVP_FAULT_BIT)) {
+		mutex_lock(&wled->lock);
+		wled_auto_string_detection(wled);
+		mutex_unlock(&wled->lock);
+	}
+
+	return rc;
+}
+
+static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
+{
+	struct wled *wled = _wled;
+	int rc;
+	u32 int_sts, fault_sts;
+
+	rc = regmap_read(wled->regmap,
+			 wled->ctrl_addr + WLED_CTRL_REG_INT_RT_STS, &int_sts);
+	if (rc < 0) {
+		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
+			rc);
+		return IRQ_HANDLED;
+	}
+
+	rc = regmap_read(wled->regmap, wled->ctrl_addr +
+			 WLED_CTRL_REG_FAULT_STATUS, &fault_sts);
+	if (rc < 0) {
+		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
+			rc);
+		return IRQ_HANDLED;
+	}
+
+	if (fault_sts &
+		(WLED_CTRL_REG_OVP_FAULT_BIT | WLED_CTRL_REG_ILIM_FAULT_BIT))
+		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
+			int_sts, fault_sts);
+
+	if (fault_sts & WLED_CTRL_REG_OVP_FAULT_BIT) {
+		mutex_lock(&wled->lock);
+		disable_irq_nosync(wled->ovp_irq);
+
+		if (wled_auto_detection_required(wled))
+			wled_auto_string_detection(wled);
+
+		enable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = false;
+
+		mutex_unlock(&wled->lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int wled3_setup(struct wled *wled)
 {
 	u16 addr;
@@ -442,8 +785,10 @@ static int wled4_setup(struct wled *wled)
 		sink_en |= 1 << temp;
 	}
 
-	if (sink_cfg == sink_en)
-		return 0;
+	if (sink_cfg == sink_en) {
+		rc = wled_auto_detection_at_init(wled);
+		return rc;
+	}
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
@@ -506,7 +851,9 @@ static int wled4_setup(struct wled *wled)
 		return rc;
 	}
 
-	return 0;
+	rc = wled_auto_detection_at_init(wled);
+
+	return rc;
 }
 
 static const struct wled_config wled4_config_defaults = {
@@ -517,6 +864,7 @@ static int wled4_setup(struct wled *wled)
 	.switch_freq = 11,
 	.cabc = false,
 	.external_pfet = false,
+	.auto_detection_enabled = false,
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
@@ -686,6 +1034,7 @@ static int wled_configure(struct wled *wled, int version)
 		{ "qcom,ext-gen", &cfg->ext_gen, },
 		{ "qcom,cabc", &cfg->cabc, },
 		{ "qcom,external-pfet", &cfg->external_pfet, },
+		{ "qcom,auto-string-detection", &cfg->auto_detection_enabled, },
 	};
 
 	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
@@ -806,6 +1155,42 @@ static int wled_configure_short_irq(struct wled *wled,
 	return rc;
 }
 
+static int wled_configure_ovp_irq(struct wled *wled,
+				  struct platform_device *pdev)
+{
+	int rc;
+	u32 val;
+
+	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
+	if (wled->ovp_irq < 0) {
+		dev_dbg(&pdev->dev, "ovp irq is not used\n");
+		return 0;
+	}
+
+	rc = devm_request_threaded_irq(wled->dev, wled->ovp_irq, NULL,
+				       wled_ovp_irq_handler, IRQF_ONESHOT,
+				       "wled_ovp_irq", wled);
+	if (rc < 0) {
+		dev_err(wled->dev, "Unable to request ovp_irq (err:%d)\n",
+			rc);
+		wled->ovp_irq = 0;
+		return 0;
+	}
+
+	rc = regmap_read(wled->regmap, wled->ctrl_addr +
+			 WLED_CTRL_REG_MOD_EN, &val);
+	if (rc < 0)
+		return rc;
+
+	/* Keep OVP irq disabled until module is enabled */
+	if (!(val & WLED_CTRL_REG_MOD_EN_MASK)) {
+		disable_irq(wled->ovp_irq);
+		wled->ovp_irq_disabled = true;
+	}
+
+	return 0;
+}
+
 static const struct backlight_ops wled_ops = {
 	.update_status = wled_update_status,
 };
@@ -846,6 +1231,7 @@ static int wled_probe(struct platform_device *pdev)
 
 	switch (version) {
 	case WLED3:
+		wled->cfg.auto_detection_enabled = false;
 		rc = wled3_setup(wled);
 		if (rc) {
 			dev_err(&pdev->dev, "wled3_setup failed\n");
@@ -867,10 +1253,16 @@ static int wled_probe(struct platform_device *pdev)
 		break;
 	}
 
+	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
+
 	rc = wled_configure_short_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
+	rc = wled_configure_ovp_irq(wled, pdev);
+	if (rc < 0)
+		return rc;
+
 	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

