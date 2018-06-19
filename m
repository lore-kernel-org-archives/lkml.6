Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE96C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F3C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GIbDhcvu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kRgN7//d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F3C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937763AbeFSLP0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:15:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937694AbeFSLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E3BD1607EB; Tue, 19 Jun 2018 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406921;
        bh=wU1d6VQqWmkaKz1stQ899N1UULgjHt/yeZLr5HeiEvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIbDhcvuILuCY/JONdKV1YbL7O8dHVx2DLfgHxWp4c1tKiyNgErFHaCwKQE9TTPby
         84RHkVmRVZ0l5CEHBiHxHQG/tl0umOUVj6NBzRTBTpF6R3usW+iIFxgSKY8aMH+ppi
         DqF0LMhsK+m3XNtJr0fBoHX3A24MZjcJ2HJRp/KQ=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CD5B607EB;
        Tue, 19 Jun 2018 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406920;
        bh=wU1d6VQqWmkaKz1stQ899N1UULgjHt/yeZLr5HeiEvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRgN7//donecXCNJJ2dSgELt7t+OGvFzq9wepqDkDH65NHzMxb1r2OWZ8CYDiaPgM
         Saxpsmyb0Y3V6MW9jFCmICyY9QDzrNsTYWyH3VeplIYddEcxEOwKRI+OIUD1L0e0Sd
         xoMjcrIF+1Hcvp/E6w8tVz2paLUMgZdGalGNJhkE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CD5B607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 6/7] backlight: qcom-wled: add support for short circuit handling
Date:   Tue, 19 Jun 2018 16:43:41 +0530
Message-Id: <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the short circuit interrupt and check if the short circuit
interrupt is valid. Re-enable the module to check if it goes
away. Disable the module altogether if the short circuit event
persists.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 drivers/video/backlight/qcom-wled.c | 130 +++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 0bc7fcd..e87ba70 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -10,6 +10,9 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
 #include <linux/kernel.h>
 #include <linux/backlight.h>
 #include <linux/module.h>
@@ -38,6 +41,16 @@
 #define WLED3_CTRL_REG_ILIMIT				0x4e
 #define  WLED3_CTRL_REG_ILIMIT_MASK			GENMASK(2, 0)
 
+/* WLED4 control registers */
+#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
+#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
+
+#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
+#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
+
+#define WLED4_CTRL_REG_TEST1				0xe2
+#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
+
 /* WLED3 sink registers */
 #define WLED3_SINK_REG_SYNC				0x47
 #define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
@@ -132,17 +145,23 @@ struct wled_config {
 	bool cs_out_en;
 	bool ext_gen;
 	bool cabc;
+	bool external_pfet;
 };
 
 struct wled {
 	const char *name;
 	struct device *dev;
 	struct regmap *regmap;
+	struct mutex lock;	/* Lock to avoid race from ISR */
+	ktime_t last_short_event;
 	u16 ctrl_addr;
 	u16 sink_addr;
 	u32 brightness;
 	u32 max_brightness;
+	u32 short_count;
 	const int *version;
+	bool disabled_by_short;
+	bool has_short_detect;
 
 	struct wled_config cfg;
 	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
@@ -194,6 +213,9 @@ static int wled_module_enable(struct wled *wled, int val)
 {
 	int rc;
 
+	if (wled->disabled_by_short)
+		return -EFAULT;
+
 	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
 				WLED3_CTRL_REG_MOD_EN,
 				WLED3_CTRL_REG_MOD_EN_MASK,
@@ -250,18 +272,19 @@ static int wled_update_status(struct backlight_device *bl)
 	    bl->props.state & BL_CORE_FBBLANK)
 		brightness = 0;
 
+	mutex_lock(&wled->lock);
 	if (brightness) {
 		rc = wled->wled_set_brightness(wled, brightness);
 		if (rc < 0) {
 			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
 				rc);
-			return rc;
+			goto unlock_mutex;
 		}
 
 		rc = wled->wled_sync_toggle(wled);
 		if (rc < 0) {
 			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
-			return rc;
+			goto unlock_mutex;
 		}
 	}
 
@@ -269,15 +292,60 @@ static int wled_update_status(struct backlight_device *bl)
 		rc = wled_module_enable(wled, !!brightness);
 		if (rc < 0) {
 			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
-			return rc;
+			goto unlock_mutex;
 		}
 	}
 
 	wled->brightness = brightness;
 
+unlock_mutex:
+	mutex_unlock(&wled->lock);
+
 	return rc;
 }
 
+#define WLED_SHORT_DLY_MS			20
+#define WLED_SHORT_CNT_MAX			5
+#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
+static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
+{
+	struct wled *wled = _wled;
+	int rc;
+	s64 elapsed_time;
+
+	wled->short_count++;
+	mutex_lock(&wled->lock);
+	rc = wled_module_enable(wled, false);
+	if (rc < 0) {
+		dev_err(wled->dev, "wled disable failed rc:%d\n", rc);
+		goto unlock_mutex;
+	}
+
+	elapsed_time = ktime_us_delta(ktime_get(),
+				      wled->last_short_event);
+	if (elapsed_time > WLED_SHORT_RESET_CNT_DLY_US)
+		wled->short_count = 0;
+
+	if (wled->short_count > WLED_SHORT_CNT_MAX) {
+		dev_err(wled->dev, "Short trigged %d times, disabling WLED forever!\n",
+			wled->short_count);
+		wled->disabled_by_short = true;
+		goto unlock_mutex;
+	}
+
+	wled->last_short_event = ktime_get();
+
+	msleep(WLED_SHORT_DLY_MS);
+	rc = wled_module_enable(wled, true);
+	if (rc < 0)
+		dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
+
+unlock_mutex:
+	mutex_unlock(&wled->lock);
+
+	return IRQ_HANDLED;
+}
+
 static int wled3_setup(struct wled *wled)
 {
 	u16 addr;
@@ -387,6 +455,21 @@ static int wled4_setup(struct wled *wled)
 	if (rc < 0)
 		return rc;
 
+	if (wled->cfg.external_pfet) {
+		/* Unlock the secure register access */
+		rc = regmap_write(wled->regmap, wled->ctrl_addr +
+				  WLED4_CTRL_REG_SEC_ACCESS,
+				  WLED4_CTRL_REG_SEC_UNLOCK);
+		if (rc < 0)
+			return rc;
+
+		rc = regmap_write(wled->regmap,
+				  wled->ctrl_addr + WLED4_CTRL_REG_TEST1,
+				  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2);
+		if (rc < 0)
+			return rc;
+	}
+
 	rc = regmap_read(wled->regmap, wled->sink_addr +
 			 WLED4_SINK_REG_CURR_SINK, &sink_cfg);
 	if (rc < 0)
@@ -472,6 +555,7 @@ static int wled4_setup(struct wled *wled)
 	.num_strings = 4,
 	.switch_freq = 11,
 	.cabc = false,
+	.external_pfet = false,
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
@@ -637,6 +721,7 @@ static int wled_configure(struct wled *wled)
 		{ "qcom,cs-out", &cfg->cs_out_en, },
 		{ "qcom,ext-gen", &cfg->ext_gen, },
 		{ "qcom,cabc", &cfg->cabc, },
+		{ "qcom,external-pfet", &cfg->external_pfet, },
 	};
 
 	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
@@ -719,6 +804,38 @@ static int wled_configure(struct wled *wled)
 	return 0;
 }
 
+static int wled_configure_short_irq(struct wled *wled,
+				    struct platform_device *pdev)
+{
+	int rc = 0, short_irq;
+
+	if (!wled->has_short_detect)
+		return 0;
+
+	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+				WLED4_CTRL_REG_SHORT_PROTECT,
+				WLED4_CTRL_REG_SHORT_EN_MASK,
+				WLED4_CTRL_REG_SHORT_EN_MASK);
+	if (rc < 0)
+		return rc;
+
+	short_irq = platform_get_irq_byname(pdev, "short");
+	if (short_irq < 0) {
+		dev_dbg(&pdev->dev, "short irq is not used\n");
+		return 0;
+	}
+
+	rc = devm_request_threaded_irq(wled->dev, short_irq,
+				       NULL, wled_short_irq_handler,
+				       IRQF_ONESHOT,
+				       "wled_short_irq", wled);
+	if (rc < 0)
+		dev_err(wled->dev, "Unable to request short_irq (err:%d)\n",
+			rc);
+
+	return rc;
+}
+
 static const struct backlight_ops wled_ops = {
 	.update_status = wled_update_status,
 };
@@ -751,6 +868,8 @@ static int wled_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	mutex_init(&wled->lock);
+
 	rc = wled_configure(wled);
 	if (rc)
 		return rc;
@@ -763,6 +882,7 @@ static int wled_probe(struct platform_device *pdev)
 		}
 	} else if (*wled->version == WLED_PMI8998 ||
 			*wled->version == WLED_PM660L) {
+		wled->has_short_detect = true;
 		rc = wled4_setup(wled);
 		if (rc) {
 			dev_err(&pdev->dev, "wled4_setup failed\n");
@@ -770,6 +890,10 @@ static int wled_probe(struct platform_device *pdev)
 		}
 	}
 
+	rc = wled_configure_short_irq(wled, pdev);
+	if (rc < 0)
+		return rc;
+
 	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

