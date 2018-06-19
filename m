Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF0FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C0420874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nGSsVunH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogJFJyYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C0420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966300AbeFSLQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:16:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936108AbeFSLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B9CAD60B15; Tue, 19 Jun 2018 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406916;
        bh=TcrnK3m4F4MkbV6bswkR49S92ssYLoZmXWPRdGfBQ9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGSsVunHIPNyfqMr/WypJaKtHUJHAoqizC2n5LpKylW3ShGRCftMA7n2gpYmJAM19
         y6PyzmJsfv4m+jAg2kE9syIgwOpETi0/H5A/ElmnCe8iu+z4fBs6OEjOACBRx0rdj7
         ThSfk1XyvA+PQRhlzcUHLlJifPgI0vwgQfhAgeiE=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34E22608C8;
        Tue, 19 Jun 2018 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406914;
        bh=TcrnK3m4F4MkbV6bswkR49S92ssYLoZmXWPRdGfBQ9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogJFJyYyoTBg7AY+1YF9oeEDwgc688YdD5Jq1u9OR7Mvc27wIn3H/ap3gJPH5ESN5
         2QMJF9LywbTuHVwLeBYsXxnq3mIaOsgC7wrpcz9ey0MCrAPMDaKYrYEDQ4WtI9yCA8
         jagnbY5lR8MKJ2TT+/9PM0Mwf9Qfv6T62X5Bhxfg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34E22608C8
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
Subject: [PATCH V3 5/7] backlight: qcom-wled: Add support for WLED4 peripheral
Date:   Tue, 19 Jun 2018 16:43:40 +0530
Message-Id: <1529406822-15379-6-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLED4 peripheral is present on some PMICs like pmi8998 and
pm660l. It has a different register map and configurations
are also different. Add support for it.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 drivers/video/backlight/qcom-wled.c | 635 ++++++++++++++++++++++++++++--------
 1 file changed, 503 insertions(+), 132 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 812f3cb..0bc7fcd 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -15,59 +15,112 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/regmap.h>
 
 /* From DT binding */
+#define WLED_MAX_STRINGS				4
+
 #define WLED_DEFAULT_BRIGHTNESS				2048
 
 #define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
-#define WLED3_CTRL_REG_VAL_BASE				0x40
 
 /* WLED3 control registers */
 #define WLED3_CTRL_REG_MOD_EN				0x46
-#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
 #define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
 
 #define WLED3_CTRL_REG_FREQ				0x4c
-#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
+#define  WLED3_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
 
 #define WLED3_CTRL_REG_OVP				0x4d
-#define  WLED3_CTRL_REG_OVP_MASK			0x03
+#define  WLED3_CTRL_REG_OVP_MASK			GENMASK(1, 0)
 
 #define WLED3_CTRL_REG_ILIMIT				0x4e
-#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
+#define  WLED3_CTRL_REG_ILIMIT_MASK			GENMASK(2, 0)
 
 /* WLED3 sink registers */
 #define WLED3_SINK_REG_SYNC				0x47
-#define  WLED3_SINK_REG_SYNC_MASK			0x07
+#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
+#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
 #define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
 #define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
 #define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
+#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
 #define  WLED3_SINK_REG_SYNC_ALL			0x07
+#define  WLED4_SINK_REG_SYNC_ALL			0x0f
 #define  WLED3_SINK_REG_SYNC_CLEAR			0x00
 
 #define WLED3_SINK_REG_CURR_SINK			0x4f
-#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
-#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
+#define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
+#define  WLED3_SINK_REG_CURR_SINK_SHFT			5
 
 /* WLED3 per-'string' registers below */
-#define WLED3_SINK_REG_STR_OFFSET			0x10
+#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
 
-#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
+#define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
-#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
 
-#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
-#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
+#define WLED3_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x62 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(4, 0)
 
-#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
-#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
+#define WLED3_SINK_REG_STR_MOD_SRC(n)			(0x63 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		BIT(0)
 #define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
 #define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
 
-#define WLED3_SINK_REG_STR_CABC_BASE			0x66
+#define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
 #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
-#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
+
+/* WLED4 sink registers */
+#define WLED4_SINK_REG_CURR_SINK			0x46
+#define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
+#define  WLED4_SINK_REG_CURR_SINK_SHFT			4
+
+/* WLED4 per-'string' registers below */
+#define WLED4_SINK_REG_STR_MOD_EN(n)			(0x50 + (n * 0x10))
+#define  WLED4_SINK_REG_STR_MOD_MASK			BIT(7)
+
+#define WLED4_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x52 + (n * 0x10))
+#define  WLED4_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(3, 0)
+
+#define WLED4_SINK_REG_STR_MOD_SRC(n)			(0x53 + (n * 0x10))
+#define  WLED4_SINK_REG_STR_MOD_SRC_MASK		BIT(0)
+#define  WLED4_SINK_REG_STR_MOD_SRC_INT			0x00
+#define  WLED4_SINK_REG_STR_MOD_SRC_EXT			0x01
+
+#define WLED4_SINK_REG_STR_CABC(n)			(0x56 + (n * 0x10))
+#define  WLED4_SINK_REG_STR_CABC_MASK			BIT(7)
+
+#define WLED4_SINK_REG_BRIGHT(n)			(0x57 + (n * 0x10))
+
+enum wled_version {
+	WLED_PM8941 = 3,
+	WLED_PMI8998,
+	WLED_PM660L,
+};
+
+static const int version_table[] = {
+	[0] = WLED_PM8941,
+	[1] = WLED_PMI8998,
+	[2] = WLED_PM660L,
+};
+
+struct wled_var_cfg {
+	const u32 *values;
+	u32 (*fn)(u32);
+	int size;
+};
+
+struct wled_u32_opts {
+	const char *name;
+	u32 *val_ptr;
+	const struct wled_var_cfg *cfg;
+};
+
+struct wled_bool_opts {
+	const char *name;
+	bool *val_ptr;
+};
 
 struct wled_config {
 	u32 boost_i_limit;
@@ -75,132 +128,224 @@ struct wled_config {
 	u32 switch_freq;
 	u32 num_strings;
 	u32 string_i_limit;
+	u32 enabled_strings[WLED_MAX_STRINGS];
 	bool cs_out_en;
 	bool ext_gen;
-	bool cabc_en;
+	bool cabc;
 };
 
 struct wled {
 	const char *name;
+	struct device *dev;
 	struct regmap *regmap;
-	u16 addr;
+	u16 ctrl_addr;
+	u16 sink_addr;
+	u32 brightness;
+	u32 max_brightness;
+	const int *version;
 
 	struct wled_config cfg;
+	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
+	int (*wled_sync_toggle)(struct wled *wled);
 };
 
-static int wled_update_status(struct backlight_device *bl)
+static int wled3_set_brightness(struct wled *wled, u16 brightness)
 {
-	struct wled *wled = bl_get_data(bl);
-	u16 val = bl->props.brightness;
-	u8 ctrl = 0;
-	int rc;
-	int i;
+	int rc, i;
+	u8 v[2];
 
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & BL_CORE_FBBLANK)
-		val = 0;
+	v[0] = brightness & 0xff;
+	v[1] = (brightness >> 8) & 0xf;
 
-	if (val != 0)
-		ctrl = WLED3_CTRL_REG_MOD_EN_BIT;
+	for (i = 0;  i < wled->cfg.num_strings; ++i) {
+		rc = regmap_bulk_write(wled->regmap, wled->ctrl_addr +
+				       WLED3_SINK_REG_BRIGHT(i), v, 2);
+		if (rc < 0)
+			return rc;
+	}
 
-	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_CTRL_REG_MOD_EN,
-			WLED3_CTRL_REG_MOD_EN_MASK, ctrl);
-	if (rc)
-		return rc;
+	return 0;
+}
 
-	for (i = 0; i < wled->cfg.num_strings; ++i) {
-		u8 v[2] = { val & 0xff, (val >> 8) & 0xf };
+static int wled4_set_brightness(struct wled *wled, u16 brightness)
+{
+	int rc, i;
+	u16 low_limit = wled->max_brightness * 4 / 1000;
+	u8 v[2];
 
-		rc = regmap_bulk_write(wled->regmap,
-				wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
-				v, 2);
-		if (rc)
+	/* WLED4's lower limit of operation is 0.4% */
+	if (brightness > 0 && brightness < low_limit)
+		brightness = low_limit;
+
+	v[0] = brightness & 0xff;
+	v[1] = (brightness >> 8) & 0xf;
+
+	for (i = 0;  i < wled->cfg.num_strings; ++i) {
+		rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
+				       WLED4_SINK_REG_BRIGHT(i), v, 2);
+		if (rc < 0)
 			return rc;
 	}
 
+	return 0;
+}
+
+static int wled_module_enable(struct wled *wled, int val)
+{
+	int rc;
+
+	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+				WLED3_CTRL_REG_MOD_EN,
+				WLED3_CTRL_REG_MOD_EN_MASK,
+				WLED3_CTRL_REG_MOD_EN_MASK);
+	return rc;
+}
+
+static int wled3_sync_toggle(struct wled *wled)
+{
+	int rc;
+
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_SINK_REG_SYNC,
-			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_ALL);
-	if (rc)
+				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
+				WLED3_SINK_REG_SYNC_MASK,
+				WLED3_SINK_REG_SYNC_MASK);
+	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_SINK_REG_SYNC,
-			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_CLEAR);
+				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
+				WLED3_SINK_REG_SYNC_MASK,
+				WLED3_SINK_REG_SYNC_CLEAR);
+
 	return rc;
 }
 
-static int wled_setup(struct wled *wled)
+static int wled4_sync_toggle(struct wled *wled)
 {
 	int rc;
-	int i;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_CTRL_REG_OVP,
-			WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
-	if (rc)
+				wled->sink_addr + WLED3_SINK_REG_SYNC,
+				WLED4_SINK_REG_SYNC_MASK,
+				WLED4_SINK_REG_SYNC_MASK);
+	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_CTRL_REG_ILIMIT,
-			WLED3_CTRL_REG_ILIMIT_MASK, wled->cfg.boost_i_limit);
+				wled->sink_addr + WLED3_SINK_REG_SYNC,
+				WLED4_SINK_REG_SYNC_MASK,
+				WLED3_SINK_REG_SYNC_CLEAR);
+
+	return rc;
+}
+
+static int wled_update_status(struct backlight_device *bl)
+{
+	struct wled *wled = bl_get_data(bl);
+	u16 brightness = bl->props.brightness;
+	int rc = 0;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK)
+		brightness = 0;
+
+	if (brightness) {
+		rc = wled->wled_set_brightness(wled, brightness);
+		if (rc < 0) {
+			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
+				rc);
+			return rc;
+		}
+
+		rc = wled->wled_sync_toggle(wled);
+		if (rc < 0) {
+			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
+			return rc;
+		}
+	}
+
+	if (!!brightness != !!wled->brightness) {
+		rc = wled_module_enable(wled, !!brightness);
+		if (rc < 0) {
+			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
+			return rc;
+		}
+	}
+
+	wled->brightness = brightness;
+
+	return rc;
+}
+
+static int wled3_setup(struct wled *wled)
+{
+	u16 addr;
+	u8 sink_en = 0;
+	int rc, i, j;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_OVP,
+				WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
 	if (rc)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + WLED3_CTRL_REG_FREQ,
-			WLED3_CTRL_REG_FREQ_MASK, wled->cfg.switch_freq);
+				wled->ctrl_addr + WLED3_CTRL_REG_ILIMIT,
+				WLED3_CTRL_REG_ILIMIT_MASK,
+				wled->cfg.boost_i_limit);
 	if (rc)
 		return rc;
 
-	if (wled->cfg.cs_out_en) {
-		u8 all = (BIT(wled->cfg.num_strings) - 1)
-				<< WLED3_SINK_REG_CURR_SINK_SHFT;
-
-		rc = regmap_update_bits(wled->regmap,
-				wled->addr + WLED3_SINK_REG_CURR_SINK,
-				WLED3_SINK_REG_CURR_SINK_MASK, all);
-		if (rc)
-			return rc;
-	}
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_FREQ,
+				WLED3_CTRL_REG_FREQ_MASK,
+				wled->cfg.switch_freq);
+	if (rc)
+		return rc;
 
 	for (i = 0; i < wled->cfg.num_strings; ++i) {
-		u16 addr = wled->addr + WLED3_SINK_REG_STR_OFFSET * i;
-
-		rc = regmap_update_bits(wled->regmap,
-				addr + WLED3_SINK_REG_STR_MOD_EN_BASE,
-				WLED3_SINK_REG_STR_MOD_MASK,
-				WLED3_SINK_REG_STR_MOD_EN);
+		j = wled->cfg.enabled_strings[i];
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_EN(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_MOD_MASK,
+					WLED3_SINK_REG_STR_MOD_MASK);
 		if (rc)
 			return rc;
 
 		if (wled->cfg.ext_gen) {
-			rc = regmap_update_bits(wled->regmap,
-					addr + WLED3_SINK_REG_STR_MOD_SRC_BASE,
-					WLED3_SINK_REG_STR_MOD_SRC_MASK,
-					WLED3_SINK_REG_STR_MOD_SRC_EXT);
+			addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_SRC(j);
+			rc = regmap_update_bits(wled->regmap, addr,
+						WLED3_SINK_REG_STR_MOD_SRC_MASK,
+						WLED3_SINK_REG_STR_MOD_SRC_EXT);
 			if (rc)
 				return rc;
 		}
 
-		rc = regmap_update_bits(wled->regmap,
-				addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR,
-				WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
-				wled->cfg.string_i_limit);
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
+					wled->cfg.string_i_limit);
 		if (rc)
 			return rc;
 
-		rc = regmap_update_bits(wled->regmap,
-				addr + WLED3_SINK_REG_STR_CABC_BASE,
-				WLED3_SINK_REG_STR_CABC_MASK,
-				wled->cfg.cabc_en ?
-					WLED3_SINK_REG_STR_CABC_EN : 0);
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_CABC(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_CABC_MASK,
+					wled->cfg.cabc ?
+					WLED3_SINK_REG_STR_CABC_MASK : 0);
 		if (rc)
 			return rc;
+
+		sink_en |= BIT(j + WLED3_SINK_REG_CURR_SINK_SHFT);
 	}
 
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_SINK_REG_CURR_SINK,
+				WLED3_SINK_REG_CURR_SINK_MASK, sink_en);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
@@ -208,17 +353,125 @@ static int wled_setup(struct wled *wled)
 	.boost_i_limit = 3,
 	.string_i_limit = 20,
 	.ovp = 2,
+	.num_strings = 3,
 	.switch_freq = 5,
-	.num_strings = 0,
 	.cs_out_en = false,
 	.ext_gen = false,
-	.cabc_en = false,
+	.cabc = false,
 };
 
-struct wled_var_cfg {
-	const u32 *values;
-	u32 (*fn)(u32);
-	int size;
+static int wled4_setup(struct wled *wled)
+{
+	int rc, temp, i, j;
+	u16 addr;
+	u8 sink_en = 0;
+	u32 sink_cfg = 0;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_OVP,
+				WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_ILIMIT,
+				WLED3_CTRL_REG_ILIMIT_MASK,
+				wled->cfg.boost_i_limit);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_FREQ,
+				WLED3_CTRL_REG_FREQ_MASK,
+				wled->cfg.switch_freq);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_read(wled->regmap, wled->sink_addr +
+			 WLED4_SINK_REG_CURR_SINK, &sink_cfg);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		j = wled->cfg.enabled_strings[i];
+		temp = j + WLED4_SINK_REG_CURR_SINK_SHFT;
+		sink_en |= 1 << temp;
+	}
+
+	if (sink_cfg == sink_en)
+		return 0;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
+				WLED4_SINK_REG_CURR_SINK_MASK, 0);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+				WLED3_CTRL_REG_MOD_EN,
+				WLED3_CTRL_REG_MOD_EN_MASK, 0);
+	if (rc < 0)
+		return rc;
+
+	/* Per sink/string configuration */
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		j = wled->cfg.enabled_strings[i];
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_MOD_EN(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_MOD_MASK,
+					WLED4_SINK_REG_STR_MOD_MASK);
+		if (rc < 0)
+			return rc;
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_FULL_SCALE_CURR(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_FULL_SCALE_CURR_MASK,
+					wled->cfg.string_i_limit);
+		if (rc < 0)
+			return rc;
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_CABC(j);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_CABC_MASK,
+					wled->cfg.cabc ?
+					WLED4_SINK_REG_STR_CABC_MASK : 0);
+		if (rc < 0)
+			return rc;
+	}
+
+	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+				WLED3_CTRL_REG_MOD_EN,
+				WLED3_CTRL_REG_MOD_EN_MASK,
+				WLED3_CTRL_REG_MOD_EN_MASK);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
+				WLED4_SINK_REG_CURR_SINK_MASK, sink_en);
+	if (rc < 0)
+		return rc;
+
+	rc = wled->wled_sync_toggle(wled);
+	if (rc < 0) {
+		dev_err(wled->dev, "Failed to toggle sync reg rc:%d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static const struct wled_config wled4_config_defaults = {
+	.boost_i_limit = 4,
+	.string_i_limit = 10,
+	.ovp = 1,
+	.num_strings = 4,
+	.switch_freq = 11,
+	.cabc = false,
 };
 
 static const u32 wled3_boost_i_limit_values[] = {
@@ -230,6 +483,15 @@ struct wled_var_cfg {
 	.size = ARRAY_SIZE(wled3_boost_i_limit_values),
 };
 
+static const u32 wled4_boost_i_limit_values[] = {
+	105, 280, 450, 620, 970, 1150, 1300, 1500,
+};
+
+static const struct wled_var_cfg wled4_boost_i_limit_cfg = {
+	.values = wled4_boost_i_limit_values,
+	.size = ARRAY_SIZE(wled4_boost_i_limit_values),
+};
+
 static const u32 wled3_ovp_values[] = {
 	35, 32, 29, 27,
 };
@@ -239,6 +501,15 @@ struct wled_var_cfg {
 	.size = ARRAY_SIZE(wled3_ovp_values),
 };
 
+static const u32 wled4_ovp_values[] = {
+	31100, 29600, 19600, 18100,
+};
+
+static const struct wled_var_cfg wled4_ovp_cfg = {
+	.values = wled4_ovp_values,
+	.size = ARRAY_SIZE(wled4_ovp_values),
+};
+
 static u32 wled3_num_strings_values_fn(u32 idx)
 {
 	return idx + 1;
@@ -249,6 +520,11 @@ static u32 wled3_num_strings_values_fn(u32 idx)
 	.size = 3,
 };
 
+static const struct wled_var_cfg wled4_num_strings_cfg = {
+	.fn = wled3_num_strings_values_fn,
+	.size = 4,
+};
+
 static u32 wled3_switch_freq_values_fn(u32 idx)
 {
 	return 19200 / (2 * (1 + idx));
@@ -263,7 +539,25 @@ static u32 wled3_switch_freq_values_fn(u32 idx)
 	.size = 26,
 };
 
-static u32 wled3_values(const struct wled_var_cfg *cfg, u32 idx)
+static const u32 wled4_string_i_limit_values[] = {
+	0, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000,
+	22500, 25000, 27500, 30000,
+};
+
+static const struct wled_var_cfg wled4_string_i_limit_cfg = {
+	.values = wled4_string_i_limit_values,
+	.size = ARRAY_SIZE(wled4_string_i_limit_values),
+};
+
+static const struct wled_var_cfg wled3_string_cfg = {
+	.size = 8,
+};
+
+static const struct wled_var_cfg wled4_string_cfg = {
+	.size = 16,
+};
+
+static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
 {
 	if (idx >= cfg->size)
 		return UINT_MAX;
@@ -274,68 +568,113 @@ static u32 wled3_values(const struct wled_var_cfg *cfg, u32 idx)
 	return idx;
 }
 
-static int wled_configure(struct wled *wled, struct device *dev)
+static int wled_configure(struct wled *wled)
 {
 	struct wled_config *cfg = &wled->cfg;
-	u32 val;
-	int rc;
-	u32 c;
-	int i;
-	int j;
-
-	const struct {
-		const char *name;
-		u32 *val_ptr;
-		const struct wled_var_cfg *cfg;
-	} u32_opts[] = {
+	struct device *dev = wled->dev;
+	const __be32 *prop_addr;
+	u32 size, val, c, string_len;
+	int rc, i, j;
+
+	const struct wled_u32_opts *u32_opts = NULL;
+	const struct wled_u32_opts wled3_opts[] = {
 		{
-			"qcom,current-boost-limit",
-			&cfg->boost_i_limit,
+			.name = "qcom,current-boost-limit",
+			.val_ptr = &cfg->boost_i_limit,
 			.cfg = &wled3_boost_i_limit_cfg,
 		},
 		{
-			"qcom,current-limit",
-			&cfg->string_i_limit,
+			.name = "qcom,current-limit",
+			.val_ptr = &cfg->string_i_limit,
 			.cfg = &wled3_string_i_limit_cfg,
 		},
 		{
-			"qcom,ovp",
-			&cfg->ovp,
+			.name = "qcom,ovp",
+			.val_ptr = &cfg->ovp,
 			.cfg = &wled3_ovp_cfg,
 		},
 		{
-			"qcom,switching-freq",
-			&cfg->switch_freq,
+			.name = "qcom,switching-freq",
+			.val_ptr = &cfg->switch_freq,
 			.cfg = &wled3_switch_freq_cfg,
 		},
 		{
-			"qcom,num-strings",
-			&cfg->num_strings,
+			.name = "qcom,num-strings",
+			.val_ptr = &cfg->num_strings,
 			.cfg = &wled3_num_strings_cfg,
 		},
 	};
-	const struct {
-		const char *name;
-		bool *val_ptr;
-	} bool_opts[] = {
+
+	const struct wled_u32_opts wled4_opts[] = {
+		{
+			.name = "qcom,current-boost-limit",
+			.val_ptr = &cfg->boost_i_limit,
+			.cfg = &wled4_boost_i_limit_cfg,
+		},
+		{
+			.name = "qcom,current-limit-microamp",
+			.val_ptr = &cfg->string_i_limit,
+			.cfg = &wled4_string_i_limit_cfg,
+		},
+		{
+			.name = "qcom,ovp-millivolt",
+			.val_ptr = &cfg->ovp,
+			.cfg = &wled4_ovp_cfg,
+		},
+		{
+			.name = "qcom,switching-freq",
+			.val_ptr = &cfg->switch_freq,
+			.cfg = &wled3_switch_freq_cfg,
+		},
+		{
+			.name = "qcom,num-strings",
+			.val_ptr = &cfg->num_strings,
+			.cfg = &wled4_num_strings_cfg,
+		},
+	};
+
+	const struct wled_bool_opts bool_opts[] = {
 		{ "qcom,cs-out", &cfg->cs_out_en, },
 		{ "qcom,ext-gen", &cfg->ext_gen, },
-		{ "qcom,cabc", &cfg->cabc_en, },
+		{ "qcom,cabc", &cfg->cabc, },
 	};
 
-	rc = of_property_read_u32(dev->of_node, "reg", &val);
-	if (rc || val > 0xffff) {
-		dev_err(dev, "invalid IO resources\n");
-		return rc ? rc : -EINVAL;
+	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
+	if (!prop_addr) {
+		dev_err(wled->dev, "invalid IO resources\n");
+		return -EINVAL;
+	}
+	wled->ctrl_addr = be32_to_cpu(*prop_addr);
+
+	if (*wled->version != WLED_PM8941) {
+		prop_addr = of_get_address(dev->of_node, 1, NULL, NULL);
+		if (!prop_addr) {
+			dev_err(wled->dev, "invalid IO resources\n");
+			return -EINVAL;
+		}
+		wled->sink_addr = be32_to_cpu(*prop_addr);
 	}
-	wled->addr = val;
 
 	rc = of_property_read_string(dev->of_node, "label", &wled->name);
 	if (rc)
 		wled->name = dev->of_node->name;
 
-	*cfg = wled3_config_defaults;
-	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
+	if (*wled->version == WLED_PM8941) {
+		u32_opts = wled3_opts;
+		size = ARRAY_SIZE(wled3_opts);
+		*cfg = wled3_config_defaults;
+		wled->wled_set_brightness = wled3_set_brightness;
+		wled->wled_sync_toggle = wled3_sync_toggle;
+	} else if (*wled->version == WLED_PMI8998 ||
+			*wled->version == WLED_PM660L) {
+		u32_opts = wled4_opts;
+		size = ARRAY_SIZE(wled4_opts);
+		*cfg = wled4_config_defaults;
+		wled->wled_set_brightness = wled4_set_brightness;
+		wled->wled_sync_toggle = wled4_sync_toggle;
+	}
+
+	for (i = 0; i < size; ++i) {
 		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);
 		if (rc == -EINVAL) {
 			continue;
@@ -346,12 +685,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
 
 		c = UINT_MAX;
 		for (j = 0; c != val; j++) {
-			c = wled3_values(u32_opts[i].cfg, j);
+			c = wled_values(u32_opts[i].cfg, j);
 			if (c == UINT_MAX) {
 				dev_err(dev, "invalid value for '%s'\n",
 					u32_opts[i].name);
 				return -EINVAL;
 			}
+
+			if (c == val)
+				break;
 		}
 
 		dev_dbg(dev, "'%s' = %u\n", u32_opts[i].name, c);
@@ -365,6 +707,15 @@ static int wled_configure(struct wled *wled, struct device *dev)
 
 	cfg->num_strings = cfg->num_strings + 1;
 
+	string_len = of_property_count_elems_of_size(dev->of_node,
+						     "qcom,enabled-strings",
+						     sizeof(u32));
+	if (string_len > 0)
+		rc = of_property_read_u32_array(dev->of_node,
+						"qcom,enabled-strings",
+						wled->cfg.enabled_strings,
+						sizeof(u32));
+
 	return 0;
 }
 
@@ -392,15 +743,33 @@ static int wled_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wled->regmap = regmap;
+	wled->dev = &pdev->dev;
 
-	rc = wled_configure(wled, &pdev->dev);
-	if (rc)
-		return rc;
+	wled->version = of_device_get_match_data(&pdev->dev);
+	if (!wled->version) {
+		dev_err(&pdev->dev, "Unknown device version\n");
+		return -ENODEV;
+	}
 
-	rc = wled_setup(wled);
+	rc = wled_configure(wled);
 	if (rc)
 		return rc;
 
+	if (*wled->version == WLED_PM8941) {
+		rc = wled3_setup(wled);
+		if (rc) {
+			dev_err(&pdev->dev, "wled3_setup failed\n");
+			return rc;
+		}
+	} else if (*wled->version == WLED_PMI8998 ||
+			*wled->version == WLED_PM660L) {
+		rc = wled4_setup(wled);
+		if (rc) {
+			dev_err(&pdev->dev, "wled4_setup failed\n");
+			return rc;
+		}
+	}
+
 	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
@@ -415,7 +784,9 @@ static int wled_probe(struct platform_device *pdev)
 };
 
 static const struct of_device_id wled_match_table[] = {
-	{ .compatible = "qcom,pm8941-wled" },
+	{ .compatible = "qcom,pm8941-wled", .data = &version_table[0] },
+	{ .compatible = "qcom,pmi8998-wled", .data = &version_table[1] },
+	{ .compatible = "qcom,pm660l-wled", .data = &version_table[2] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, wled_match_table);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

