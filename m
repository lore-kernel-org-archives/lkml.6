Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeECKN2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:13:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbeECKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:13:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D56D3606DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From: Kiran Gunda <kgunda@codeaurora.org>
To: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V2 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
Date: Thu,  3 May 2018 15:42:29 +0530
Message-Id: <1525342352-25072-3-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLED4 peripheral is present on some PMICs like pmi8998
and pm660l. It has a different register map and also
configurations are different. Add support for it.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
 drivers/video/backlight/qcom-wled.c                | 749 +++++++++++++++------
 2 files changed, 696 insertions(+), 225 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index fb39e32..0ceffa1 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -1,30 +1,129 @@
 Binding for Qualcomm Technologies, Inc. WLED driver
 
-Required properties:
-- compatible: should be "qcom,pm8941-wled"
-- reg: slave address
-
-Optional properties:
-- default-brightness: brightness value on boot, value from: 0-4095
-	default: 2048
-- label: The name of the backlight device
-- qcom,cs-out: bool; enable current sink output
-- qcom,cabc: bool; enable content adaptive backlight control
-- qcom,ext-gen: bool; use externally generated modulator signal to dim
-- qcom,current-limit: mA; per-string current limit; value from 0 to 25
-	default: 20mA
-- qcom,current-boost-limit: mA; boost current limit; one of:
-	105, 385, 525, 805, 980, 1260, 1400, 1680
-	default: 805mA
-- qcom,switching-freq: kHz; switching frequency; one of:
-	600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
-	1600, 1920, 2400, 3200, 4800, 9600,
-	default: 1600kHz
-- qcom,ovp: V; Over-voltage protection limit; one of:
-	27, 29, 32, 35
-	default: 29V
-- qcom,num-strings: #; number of led strings attached; value from 1 to 3
-	default: 2
+WLED (White Light Emitting Diode) driver is used for controlling display
+backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
+platforms. The PMIC is connected to the host processor via SPMI bus.
+
+- compatible
+	Usage:        required
+	Value type:   <string>
+	Definition:   should be "qcom,pm8941-wled" or "qcom,pmi8998-wled".
+		      or "qcom,pm660l-wled".
+
+- reg
+	Usage:        required
+	Value type:   <prop encoded array>
+	Definition:   Base address of the WLED modules.
+
+- interrupts
+	Usage:        optional
+	Value type:   <prop encoded array>
+	Definition:   Interrupts associated with WLED. Interrupts can be
+		      specified as per the encoding listed under
+		      Documentation/devicetree/bindings/spmi/
+		      qcom,spmi-pmic-arb.txt.
+
+- interrupt-names
+	Usage:        optional
+	Value type:   <string>
+	Definition:   Interrupt names associated with the interrupts.
+		      Must be "short" and "ovp". The short circuit detection
+		      is not supported for PM8941.
+
+- label
+	Usage:        required
+	Value type:   <string>
+	Definition:   The name of the backlight device
+
+- default-brightness
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   brightness value on boot, value from: 0-4095
+		      Default: 2048
+
+- qcom,current-limit
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   uA; per-string current limit
+		      value:
+		      For pm8941: from 0 to 25000 with 5000 ua step
+				  Default 20000 uA
+		      For pmi8998: from 0 to 30000 with 5000 ua step
+				   Default 25000 uA.
+
+- qcom,current-boost-limit
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mA; boost current limit.
+		      For pm8941: one of: 105, 385, 525, 805, 980, 1260, 1400,
+				 1680. Default: 805 mA
+		      For pmi8998: one of: 105, 280, 450, 620, 970, 1150, 1300,
+				  1500. Default: 970 mA
+
+- qcom,switching-freq
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   kHz; switching frequency; one of: 600, 640, 685, 738,
+		      800, 872, 960, 1066, 1200, 1371, 1600, 1920, 2400, 3200,
+		      4800, 9600.
+		      Default: for pm8941: 1600 kHz
+			      for pmi8998: 800 kHz
+
+- qcom,ovp
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   mV; Over-voltage protection limit;
+		      For pm8941:  one of 27000, 29000, 32000, 35000
+				  Default: 29000 mV
+		      For pmi8998: one of 18100, 19600, 29600, 31100
+				  Default: 29600 mV
+
+- qcom,num-strings
+	Usage:        optional
+	Value type:   <u32>
+	Definition:   #; number of led strings attached;
+		      for pm8941: value 3.
+		      for pmi8998: value 4.
+
+- qcom,enabled-strings
+	Usage:        optional
+	Value tyoe:   <u32>
+	Definition:   Bit mask of the WLED strings. Bit 0 to 3 indicates strings
+		      0 to 3 respectively. Each string of leds are operated
+		      individually. Specify the strings using the bit mask. Any
+		      combination of led strings can be used.
+		      for pm8941: Default value is 7 (b111).
+		      for pmi8998: Default value is 15 (b1111).
+
+- qcom,cs-out
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   enable current sink output.
+		      This property is supported only for PM8941.
+
+- qcom,cabc
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   enable content adaptive backlight control.
+
+- qcom,ext-gen
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   use externally generated modulator signal to dim.
+		      This property is supported only for PM8941.
+
+- qcom,external-pfet
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   Specify if external PFET control for short circuit
+		      protection is used. This property is supported only
+		      for PMI8998.
+
+- qcom,auto-string-detection
+	Usage:        optional
+	Value type:   <bool>
+	Definition:   Enables auto-detection of the WLED string configuration.
+		      This feature is not supported for PM8941.
 
 Example:
 
@@ -34,9 +133,26 @@ pm8941-wled@d800 {
 	label = "backlight";
 
 	qcom,cs-out;
-	qcom,current-limit = <20>;
+	qcom,current-limit = <20000>;
+	qcom,current-boost-limit = <805>;
+	qcom,switching-freq = <1600>;
+	qcom,ovp = <29000>;
+	qcom,num-strings = <3>;
+	qcom,enabled-strings = <7>;
+};
+
+pmi8998-wled@d800 {
+	compatible = "qcom,pmi8998-wled";
+	reg = <0xd800 0xd900>;
+	label = "backlight";
+
+	interrupts = <3 0xd8 2 IRQ_TYPE_EDGE_RISING>,
+		     <3 0xd8 1 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "short", "ovp";
+	qcom,current-limit = <25000>;
 	qcom,current-boost-limit = <805>;
 	qcom,switching-freq = <1600>;
-	qcom,ovp = <29>;
-	qcom,num-strings = <2>;
+	qcom,ovp = <29600>;
+	qcom,num-strings = <4>;
+	qcom,enabled-strings = <15>;
 };
diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 0b6d219..be8b8d3 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -15,253 +15,529 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/regmap.h>
 
 /* From DT binding */
-#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
+#define WLED_DEFAULT_BRIGHTNESS				2048
 
-#define PM8941_WLED_REG_VAL_BASE		0x40
-#define  PM8941_WLED_REG_VAL_MAX		0xFFF
+#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
 
-#define PM8941_WLED_REG_MOD_EN			0x46
-#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
-#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
+/* Control registers */
+#define WLED3_CTRL_REG_MOD_EN				0x46
+#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
 
-#define PM8941_WLED_REG_SYNC			0x47
-#define  PM8941_WLED_REG_SYNC_MASK		0x07
-#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
-#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
-#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
-#define  PM8941_WLED_REG_SYNC_ALL		0x07
-#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
+#define WLED3_CTRL_REG_FREQ				0x4c
+#define  WLED3_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
 
-#define PM8941_WLED_REG_FREQ			0x4c
-#define  PM8941_WLED_REG_FREQ_MASK		0x0f
+#define WLED3_CTRL_REG_OVP				0x4d
+#define  WLED3_CTRL_REG_OVP_MASK			GENMASK(1, 0)
 
-#define PM8941_WLED_REG_OVP			0x4d
-#define  PM8941_WLED_REG_OVP_MASK		0x03
+#define WLED3_CTRL_REG_ILIMIT				0x4e
+#define  WLED3_CTRL_REG_ILIMIT_MASK			GENMASK(2, 0)
 
-#define PM8941_WLED_REG_BOOST			0x4e
-#define  PM8941_WLED_REG_BOOST_MASK		0x07
+/* sink registers */
+#define WLED3_SINK_REG_SYNC				0x47
+#define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
+#define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
+#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
+#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
+#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
+#define  WLED4_SINK_REG_SYNC_LED4			BIT(3)
+#define  WLED3_SINK_REG_SYNC_ALL			0x07
+#define  WLED4_SINK_REG_SYNC_ALL			0x0f
+#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
 
-#define PM8941_WLED_REG_SINK			0x4f
-#define  PM8941_WLED_REG_SINK_MASK		0xe0
-#define  PM8941_WLED_REG_SINK_SHFT		0x05
+#define WLED3_SINK_REG_CURR_SINK			0x4f
+#define  WLED3_SINK_REG_CURR_SINK_MASK			GENMASK(7, 5)
+#define  WLED3_SINK_REG_CURR_SINK_SHFT			5
 
-/* Per-'string' registers below */
-#define PM8941_WLED_REG_STR_OFFSET		0x10
+/* WLED3 Per-'string' registers below */
+#define WLED3_SINK_REG_BRIGHT(n)			(0x40 + n)
 
-#define PM8941_WLED_REG_STR_MOD_EN_BASE		0x60
-#define  PM8941_WLED_REG_STR_MOD_MASK		BIT(7)
-#define  PM8941_WLED_REG_STR_MOD_EN		BIT(7)
+#define WLED3_SINK_REG_STR_MOD_EN(n)			(0x60 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
 
-#define PM8941_WLED_REG_STR_SCALE_BASE		0x62
-#define  PM8941_WLED_REG_STR_SCALE_MASK		0x1f
+#define WLED3_SINK_REG_STR_FULL_SCALE_CURR(n)		(0x62 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	GENMASK(4, 0)
 
-#define PM8941_WLED_REG_STR_MOD_SRC_BASE	0x63
-#define  PM8941_WLED_REG_STR_MOD_SRC_MASK	0x01
-#define  PM8941_WLED_REG_STR_MOD_SRC_INT	0x00
-#define  PM8941_WLED_REG_STR_MOD_SRC_EXT	0x01
+#define WLED3_SINK_REG_STR_MOD_SRC(n)			(0x63 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		BIT(0)
+#define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
+#define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
 
-#define PM8941_WLED_REG_STR_CABC_BASE		0x66
-#define  PM8941_WLED_REG_STR_CABC_MASK		BIT(7)
-#define  PM8941_WLED_REG_STR_CABC_EN		BIT(7)
+#define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
+#define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
 
-struct pm8941_wled_config {
-	u32 i_boost_limit;
+/* WLED4 sink specific registers */
+#define WLED4_SINK_REG_CURR_SINK			0x46
+#define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
+#define  WLED4_SINK_REG_CURR_SINK_SHFT			4
+
+/* WLED4 Per-'string' registers below */
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
+
+struct wled_config {
+	u32 boost_i_limit;
 	u32 ovp;
 	u32 switch_freq;
 	u32 num_strings;
-	u32 i_limit;
+	u32 string_i_limit;
+	u32 enabled_strings;
 	bool cs_out_en;
 	bool ext_gen;
-	bool cabc_en;
+	bool cabc;
 };
 
-struct pm8941_wled {
+struct wled {
 	const char *name;
+	struct device *dev;
 	struct regmap *regmap;
-	u16 addr;
-
-	struct pm8941_wled_config cfg;
+	u16 ctrl_addr;
+	u16 sink_addr;
+	u32 brightness;
+	u32 max_brightness;
+	const int *version;
+
+	struct wled_config cfg;
+	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
+	int (*wled_sync_toggle)(struct wled *wled);
 };
 
-static int pm8941_wled_update_status(struct backlight_device *bl)
+static int wled3_set_brightness(struct wled *wled, u16 brightness)
 {
-	struct pm8941_wled *wled = bl_get_data(bl);
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
-		ctrl = PM8941_WLED_REG_MOD_EN_BIT;
+	for (i = 0;  i < wled->cfg.num_strings; ++i) {
+		rc = regmap_bulk_write(wled->regmap, wled->ctrl_addr +
+				       WLED3_SINK_REG_BRIGHT(i), v, 2);
+		if (rc < 0)
+			return rc;
+	}
 
-	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_MOD_EN,
-			PM8941_WLED_REG_MOD_EN_MASK, ctrl);
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
-				wled->addr + PM8941_WLED_REG_VAL_BASE + 2 * i,
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
-			wled->addr + PM8941_WLED_REG_SYNC,
-			PM8941_WLED_REG_SYNC_MASK, PM8941_WLED_REG_SYNC_ALL);
-	if (rc)
+				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
+				WLED3_SINK_REG_SYNC_MASK,
+				WLED3_SINK_REG_SYNC_MASK);
+	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_SYNC,
-			PM8941_WLED_REG_SYNC_MASK, PM8941_WLED_REG_SYNC_CLEAR);
+				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
+				WLED3_SINK_REG_SYNC_MASK,
+				WLED3_SINK_REG_SYNC_CLEAR);
+
 	return rc;
 }
 
-static int pm8941_wled_setup(struct pm8941_wled *wled)
+static int wled4_sync_toggle(struct wled *wled)
 {
 	int rc;
-	int i;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_OVP,
-			PM8941_WLED_REG_OVP_MASK, wled->cfg.ovp);
-	if (rc)
+				wled->sink_addr + WLED3_SINK_REG_SYNC,
+				WLED4_SINK_REG_SYNC_MASK,
+				WLED4_SINK_REG_SYNC_MASK);
+	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_BOOST,
-			PM8941_WLED_REG_BOOST_MASK, wled->cfg.i_boost_limit);
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
+	u8 enabled_strings = wled->cfg.enabled_strings;
+	u8 sink_en = 0;
+	int rc, i;
+
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_CTRL_REG_OVP,
+				WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
 	if (rc)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_FREQ,
-			PM8941_WLED_REG_FREQ_MASK, wled->cfg.switch_freq);
+				wled->ctrl_addr + WLED3_CTRL_REG_ILIMIT,
+				WLED3_CTRL_REG_ILIMIT_MASK,
+				wled->cfg.boost_i_limit);
 	if (rc)
 		return rc;
 
-	if (wled->cfg.cs_out_en) {
-		u8 all = (BIT(wled->cfg.num_strings) - 1)
-				<< PM8941_WLED_REG_SINK_SHFT;
-
-		rc = regmap_update_bits(wled->regmap,
-				wled->addr + PM8941_WLED_REG_SINK,
-				PM8941_WLED_REG_SINK_MASK, all);
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
-		u16 addr = wled->addr + PM8941_WLED_REG_STR_OFFSET * i;
+		if (!(enabled_strings & BIT(i)))
+			continue;
 
-		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_MOD_EN_BASE,
-				PM8941_WLED_REG_STR_MOD_MASK,
-				PM8941_WLED_REG_STR_MOD_EN);
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_EN(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_MOD_MASK,
+					WLED3_SINK_REG_STR_MOD_MASK);
 		if (rc)
 			return rc;
 
 		if (wled->cfg.ext_gen) {
-			rc = regmap_update_bits(wled->regmap,
-					addr + PM8941_WLED_REG_STR_MOD_SRC_BASE,
-					PM8941_WLED_REG_STR_MOD_SRC_MASK,
-					PM8941_WLED_REG_STR_MOD_SRC_EXT);
+			addr = wled->ctrl_addr + WLED3_SINK_REG_STR_MOD_SRC(i);
+			rc = regmap_update_bits(wled->regmap, addr,
+						WLED3_SINK_REG_STR_MOD_SRC_MASK,
+						WLED3_SINK_REG_STR_MOD_SRC_EXT);
 			if (rc)
 				return rc;
 		}
 
-		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_SCALE_BASE,
-				PM8941_WLED_REG_STR_SCALE_MASK,
-				wled->cfg.i_limit);
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
+					wled->cfg.string_i_limit);
 		if (rc)
 			return rc;
 
-		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_CABC_BASE,
-				PM8941_WLED_REG_STR_CABC_MASK,
-				wled->cfg.cabc_en ?
-					PM8941_WLED_REG_STR_CABC_EN : 0);
+		addr = wled->ctrl_addr + WLED3_SINK_REG_STR_CABC(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED3_SINK_REG_STR_CABC_MASK,
+					wled->cfg.cabc ?
+					WLED3_SINK_REG_STR_CABC_MASK : 0);
 		if (rc)
 			return rc;
+
+		sink_en |= BIT(i + WLED3_SINK_REG_CURR_SINK_SHFT);
 	}
 
+	rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + WLED3_SINK_REG_CURR_SINK,
+				WLED3_SINK_REG_CURR_SINK_MASK, sink_en);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
-static const struct pm8941_wled_config pm8941_wled_config_defaults = {
-	.i_boost_limit = 3,
-	.i_limit = 20,
+static const struct wled_config wled3_config_defaults = {
+	.boost_i_limit = 3,
+	.string_i_limit = 20,
 	.ovp = 2,
+	.num_strings = 3,
 	.switch_freq = 5,
-	.num_strings = 0,
+	.enabled_strings = 7,
 	.cs_out_en = false,
 	.ext_gen = false,
-	.cabc_en = false,
+	.cabc = false,
 };
 
-struct pm8941_wled_var_cfg {
-	const u32 *values;
-	u32 (*fn)(u32);
-	int size;
+static int wled4_setup(struct wled *wled)
+{
+	int rc, temp, i;
+	u16 addr;
+	u8 sink_en = 0;
+	u8 enabled_strings = wled->cfg.enabled_strings;
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
+	/* Per sink/string configuration */
+	for (i = 0; i < wled->cfg.num_strings; i++) {
+		if (!(enabled_strings & BIT(i)))
+			continue;
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_MOD_EN(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_MOD_MASK,
+					WLED4_SINK_REG_STR_MOD_MASK);
+		if (rc < 0)
+			return rc;
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_FULL_SCALE_CURR(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_FULL_SCALE_CURR_MASK,
+					wled->cfg.string_i_limit);
+		if (rc < 0)
+			return rc;
+
+		addr = wled->sink_addr +
+				WLED4_SINK_REG_STR_CABC(i);
+		rc = regmap_update_bits(wled->regmap, addr,
+					WLED4_SINK_REG_STR_CABC_MASK,
+					wled->cfg.cabc ?
+					WLED4_SINK_REG_STR_CABC_MASK : 0);
+		if (rc < 0)
+			return rc;
+
+		temp = i + WLED4_SINK_REG_CURR_SINK_SHFT;
+		sink_en |= 1 << temp;
+	}
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
+	.enabled_strings = 0xf,
+	.cabc = false,
 };
 
-static const u32 pm8941_wled_i_boost_limit_values[] = {
+static const u32 wled3_boost_i_limit_values[] = {
 	105, 385, 525, 805, 980, 1260, 1400, 1680,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_i_boost_limit_cfg = {
-	.values = pm8941_wled_i_boost_limit_values,
-	.size = ARRAY_SIZE(pm8941_wled_i_boost_limit_values),
+static const struct wled_var_cfg wled3_boost_i_limit_cfg = {
+	.values = wled3_boost_i_limit_values,
+	.size = ARRAY_SIZE(wled3_boost_i_limit_values),
 };
 
-static const u32 pm8941_wled_ovp_values[] = {
-	35, 32, 29, 27,
+static const u32 wled4_boost_i_limit_values[] = {
+	105, 280, 450, 620, 970, 1150, 1300, 1500,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_ovp_cfg = {
-	.values = pm8941_wled_ovp_values,
-	.size = ARRAY_SIZE(pm8941_wled_ovp_values),
+static const struct wled_var_cfg wled4_boost_i_limit_cfg = {
+	.values = wled4_boost_i_limit_values,
+	.size = ARRAY_SIZE(wled4_boost_i_limit_values),
 };
 
-static u32 pm8941_wled_num_strings_values_fn(u32 idx)
+static const u32 wled3_ovp_values[] = {
+	35000, 32000, 29000, 27000,
+};
+
+static const struct wled_var_cfg wled3_ovp_cfg = {
+	.values = wled3_ovp_values,
+	.size = ARRAY_SIZE(wled3_ovp_values),
+};
+
+static const u32 wled4_ovp_values[] = {
+	31100, 29600, 19600, 18100,
+};
+
+static const struct wled_var_cfg wled4_ovp_cfg = {
+	.values = wled4_ovp_values,
+	.size = ARRAY_SIZE(wled4_ovp_values),
+};
+
+static u32 wled3_num_strings_values_fn(u32 idx)
 {
 	return idx + 1;
 }
 
-static const struct pm8941_wled_var_cfg pm8941_wled_num_strings_cfg = {
-	.fn = pm8941_wled_num_strings_values_fn,
+static const struct wled_var_cfg wled3_num_strings_cfg = {
+	.fn = wled3_num_strings_values_fn,
 	.size = 3,
 };
 
-static u32 pm8941_wled_switch_freq_values_fn(u32 idx)
+static const struct wled_var_cfg wled4_num_strings_cfg = {
+	.fn = wled3_num_strings_values_fn,
+	.size = 4,
+};
+
+static u32 wled3_switch_freq_values_fn(u32 idx)
 {
 	return 19200 / (2 * (1 + idx));
 }
 
-static const struct pm8941_wled_var_cfg pm8941_wled_switch_freq_cfg = {
-	.fn = pm8941_wled_switch_freq_values_fn,
+static const struct wled_var_cfg wled3_switch_freq_cfg = {
+	.fn = wled3_switch_freq_values_fn,
 	.size = 16,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_i_limit_cfg = {
-	.size = 26,
+static const u32 wled3_string_i_limit_values[] = {
+	0, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000,
+	22500, 25000,
 };
 
-static u32 pm8941_wled_values(const struct pm8941_wled_var_cfg *cfg, u32 idx)
+static const struct wled_var_cfg wled3_string_i_limit_cfg = {
+	.values = wled3_string_i_limit_values,
+	.size = ARRAY_SIZE(wled3_string_i_limit_values),
+};
+
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
@@ -272,68 +548,124 @@ static u32 pm8941_wled_values(const struct pm8941_wled_var_cfg *cfg, u32 idx)
 	return idx;
 }
 
-static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
+static int wled_configure(struct wled *wled)
 {
-	struct pm8941_wled_config *cfg = &wled->cfg;
-	u32 val;
-	int rc;
-	u32 c;
-	int i;
-	int j;
-
-	const struct {
-		const char *name;
-		u32 *val_ptr;
-		const struct pm8941_wled_var_cfg *cfg;
-	} u32_opts[] = {
+	struct wled_config *cfg = &wled->cfg;
+	struct device *dev = wled->dev;
+	const __be32 *prop_addr;
+	u32 size, val, c;
+	int rc, i, j;
+
+	const struct wled_u32_opts *u32_opts = NULL;
+	const struct wled_u32_opts wled3_opts[] = {
+		{
+			.name = "qcom,current-boost-limit",
+			.val_ptr = &cfg->boost_i_limit,
+			.cfg = &wled3_boost_i_limit_cfg,
+		},
+		{
+			.name = "qcom,current-limit",
+			.val_ptr = &cfg->string_i_limit,
+			.cfg = &wled3_string_i_limit_cfg,
+		},
+		{
+			.name = "qcom,ovp",
+			.val_ptr = &cfg->ovp,
+			.cfg = &wled3_ovp_cfg,
+		},
+		{
+			.name = "qcom,switching-freq",
+			.val_ptr = &cfg->switch_freq,
+			.cfg = &wled3_switch_freq_cfg,
+		},
+		{
+			.name = "qcom,num-strings",
+			.val_ptr = &cfg->num_strings,
+			.cfg = &wled3_num_strings_cfg,
+		},
+		{
+			.name = "qcom,enabled-strings",
+			.val_ptr = &cfg->enabled_strings,
+			.cfg = &wled3_string_cfg,
+		},
+	};
+
+	const struct wled_u32_opts wled4_opts[] = {
 		{
-			"qcom,current-boost-limit",
-			&cfg->i_boost_limit,
-			.cfg = &pm8941_wled_i_boost_limit_cfg,
+			.name = "qcom,current-boost-limit",
+			.val_ptr = &cfg->boost_i_limit,
+			.cfg = &wled4_boost_i_limit_cfg,
 		},
 		{
-			"qcom,current-limit",
-			&cfg->i_limit,
-			.cfg = &pm8941_wled_i_limit_cfg,
+			.name = "qcom,current-limit",
+			.val_ptr = &cfg->string_i_limit,
+			.cfg = &wled4_string_i_limit_cfg,
 		},
 		{
-			"qcom,ovp",
-			&cfg->ovp,
-			.cfg = &pm8941_wled_ovp_cfg,
+			.name = "qcom,ovp",
+			.val_ptr = &cfg->ovp,
+			.cfg = &wled4_ovp_cfg,
 		},
 		{
-			"qcom,switching-freq",
-			&cfg->switch_freq,
-			.cfg = &pm8941_wled_switch_freq_cfg,
+			.name = "qcom,switching-freq",
+			.val_ptr = &cfg->switch_freq,
+			.cfg = &wled3_switch_freq_cfg,
 		},
 		{
-			"qcom,num-strings",
-			&cfg->num_strings,
-			.cfg = &pm8941_wled_num_strings_cfg,
+			.name = "qcom,num-strings",
+			.val_ptr = &cfg->num_strings,
+			.cfg = &wled4_num_strings_cfg,
 		},
+		{
+			.name = "qcom,enabled-strings",
+			.val_ptr = &cfg->enabled_strings,
+			.cfg = &wled4_string_cfg,
+		},
+
 	};
-	const struct {
-		const char *name;
-		bool *val_ptr;
-	} bool_opts[] = {
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
 
-	*cfg = pm8941_wled_config_defaults;
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
@@ -344,12 +676,15 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 
 		c = UINT_MAX;
 		for (j = 0; c != val; j++) {
-			c = pm8941_wled_values(u32_opts[i].cfg, j);
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
@@ -366,15 +701,15 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 	return 0;
 }
 
-static const struct backlight_ops pm8941_wled_ops = {
-	.update_status = pm8941_wled_update_status,
+static const struct backlight_ops wled_ops = {
+	.update_status = wled_update_status,
 };
 
-static int pm8941_wled_probe(struct platform_device *pdev)
+static int wled_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
-	struct pm8941_wled *wled;
+	struct wled *wled;
 	struct regmap *regmap;
 	u32 val;
 	int rc;
@@ -390,43 +725,63 @@ static int pm8941_wled_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wled->regmap = regmap;
+	wled->dev = &pdev->dev;
 
-	rc = pm8941_wled_configure(wled, &pdev->dev);
-	if (rc)
-		return rc;
+	wled->version = of_device_get_match_data(&pdev->dev);
+	if (!wled->version) {
+		dev_err(&pdev->dev, "Unknown device version\n");
+		return -ENODEV;
+	}
 
-	rc = pm8941_wled_setup(wled);
+	rc = wled_configure(wled);
 	if (rc)
 		return rc;
 
-	val = PM8941_WLED_DEFAULT_BRIGHTNESS;
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
+	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = val;
-	props.max_brightness = PM8941_WLED_REG_VAL_MAX;
+	props.max_brightness = WLED3_SINK_REG_BRIGHT_MAX;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
-					    &pm8941_wled_ops, &props);
+					    &wled_ops, &props);
 	return PTR_ERR_OR_ZERO(bl);
 };
 
-static const struct of_device_id pm8941_wled_match_table[] = {
-	{ .compatible = "qcom,pm8941-wled" },
+static const struct of_device_id wled_match_table[] = {
+	{ .compatible = "qcom,pm8941-wled", .data = &version_table[0] },
+	{ .compatible = "qcom,pmi8998-wled", .data = &version_table[1] },
+	{ .compatible = "qcom,pm660l-wled", .data = &version_table[2] },
 	{}
 };
-MODULE_DEVICE_TABLE(of, pm8941_wled_match_table);
+MODULE_DEVICE_TABLE(of, wled_match_table);
 
-static struct platform_driver pm8941_wled_driver = {
-	.probe = pm8941_wled_probe,
+static struct platform_driver wled_driver = {
+	.probe = wled_probe,
 	.driver	= {
-		.name = "pm8941-wled",
-		.of_match_table	= pm8941_wled_match_table,
+		.name = "qcom,wled",
+		.of_match_table	= wled_match_table,
 	},
 };
 
-module_platform_driver(pm8941_wled_driver);
+module_platform_driver(wled_driver);
 
-MODULE_DESCRIPTION("pm8941 wled driver");
+MODULE_DESCRIPTION("qcom wled driver");
 MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
