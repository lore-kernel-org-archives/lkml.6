Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF6C43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFEF2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lNplrFvJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eotyurwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFEF2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeHXOCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:02:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeHXOCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:02:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E6E1D60710; Fri, 24 Aug 2018 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535106529;
        bh=gVlaudLZyycc2qumeC2FrjYgWzwF8omVRpLethv/VzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNplrFvJtMDTiLDtjaGNsKMnuAaQbt70gmayP0fKT80G7pkhNueYDexia5INSVCQm
         UA93pFRW6Tt6/+MuH5O/mxv8KDo/9Z3gRXcrRAnWzC1C1hZYqC39CRQs39iZ1BiX8K
         2JzoCfbNdTpI/vaSH5DsnpgXBpKsQ0OOfx4615hI=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 133F2607F7;
        Fri, 24 Aug 2018 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535106525;
        bh=gVlaudLZyycc2qumeC2FrjYgWzwF8omVRpLethv/VzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eotyurwm5S+Yj66Wc/cVK5WVcIPVuEibWZGzrCvW7LjMl1TmDUcbm+di4i8qRhmrN
         kYgEZDP/XMmyMGHRrY33f3wdTrQl8c+TVRjQb5hGExzRFeT9c38QOKNTz8yXW52o4h
         yiWDU9Gvrkz3ib842emN7xM6b5gwEwjRgwAwvz74=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 133F2607F7
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
Subject: [PATCH V5 7/8] backlight: qcom-wled: add support for short circuit handling
Date:   Fri, 24 Aug 2018 15:57:46 +0530
Message-Id: <1535106467-17843-8-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the short circuit interrupt and check if the short circuit
interrupt is valid. Re-enable the module to check if it goes
away. Disable the module altogether if the short circuit event
persists.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes from V3:
    - Added Reviewed by tag.
    - Addressed minor comments from Vinod

Changes from V4:
    - Changed the return value from -EINVAL to -ENXIO
    - Re-initializing the short_count from 0 to 1.

 drivers/video/backlight/qcom-wled.c | 132 ++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 49fdd23..d891067 100644
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
@@ -64,6 +67,16 @@
 #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
 
+/* WLED4 specific control registers */
+#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
+#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
+
+#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
+#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
+
+#define WLED4_CTRL_REG_TEST1				0xe2
+#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
+
 /* WLED4 specific sink registers */
 #define WLED4_SINK_REG_CURR_SINK			0x46
 #define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
@@ -113,17 +126,23 @@ struct wled_config {
 	bool cs_out_en;
 	bool ext_gen;
 	bool cabc;
+	bool external_pfet;
 };
 
 struct wled {
 	const char *name;
 	struct device *dev;
 	struct regmap *regmap;
+	struct mutex lock;	/* Lock to avoid race from thread irq handler */
+	ktime_t last_short_event;
 	u16 ctrl_addr;
 	u16 sink_addr;
 	u16 max_string_count;
 	u32 brightness;
 	u32 max_brightness;
+	u32 short_count;
+	bool disabled_by_short;
+	bool has_short_detect;
 
 	struct wled_config cfg;
 	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
@@ -174,6 +193,9 @@ static int wled_module_enable(struct wled *wled, int val)
 {
 	int rc;
 
+	if (wled->disabled_by_short)
+		return -ENXIO;
+
 	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
 				WLED_CTRL_REG_MOD_EN,
 				WLED_CTRL_REG_MOD_EN_MASK,
@@ -210,18 +232,19 @@ static int wled_update_status(struct backlight_device *bl)
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
 
 		rc = wled_sync_toggle(wled);
 		if (rc < 0) {
 			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
-			return rc;
+			goto unlock_mutex;
 		}
 	}
 
@@ -229,15 +252,61 @@ static int wled_update_status(struct backlight_device *bl)
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
+
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
+		wled->short_count = 1;
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
@@ -326,7 +395,7 @@ static int wled4_setup(struct wled *wled)
 	int rc, temp, i, j;
 	u16 addr;
 	u8 sink_en = 0;
-	u32 sink_cfg = 0;
+	u32 sink_cfg;
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->ctrl_addr + WLED_CTRL_REG_OVP,
@@ -348,6 +417,21 @@ static int wled4_setup(struct wled *wled)
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
@@ -433,6 +517,7 @@ static int wled4_setup(struct wled *wled)
 	.num_strings = 4,
 	.switch_freq = 11,
 	.cabc = false,
+	.external_pfet = false,
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
@@ -598,6 +683,7 @@ static int wled_configure(struct wled *wled, int version)
 		{ "qcom,cs-out", &cfg->cs_out_en, },
 		{ "qcom,ext-gen", &cfg->ext_gen, },
 		{ "qcom,cabc", &cfg->cabc, },
+		{ "qcom,external-pfet", &cfg->external_pfet, },
 	};
 
 	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
@@ -686,6 +772,38 @@ static int wled_configure(struct wled *wled, int version)
 	return 0;
 }
 
+static int wled_configure_short_irq(struct wled *wled,
+				    struct platform_device *pdev)
+{
+	int rc, short_irq;
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
@@ -719,6 +837,7 @@ static int wled_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	mutex_init(&wled->lock);
 	rc = wled_configure(wled, version);
 	if (rc)
 		return rc;
@@ -733,6 +852,7 @@ static int wled_probe(struct platform_device *pdev)
 		break;
 
 	case 4:
+		wled->has_short_detect = true;
 		rc = wled4_setup(wled);
 		if (rc) {
 			dev_err(&pdev->dev, "wled4_setup failed\n");
@@ -745,6 +865,10 @@ static int wled_probe(struct platform_device *pdev)
 		break;
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

