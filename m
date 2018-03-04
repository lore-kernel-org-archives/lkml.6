Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeCDMcC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 07:32:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCDMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 07:31:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E5B31601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
        mark.rutland@arm.com
Cc: ilialin@codeaurora.org, amit.kucheria@linaro.org,
        nicolas.dechesne@linaro.org, celster@codeaurora.org,
        tfinkel@codeaurora.org
Subject: [PATCH 1/2] regulator: qcom_spmi: Add support for SAW
Date: Sun,  4 Mar 2018 14:31:48 +0200
Message-Id: <1520166709-554-2-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520166709-554-1-git-send-email-ilialin@codeaurora.org>
References: <1520166709-554-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SAW controlled regulators.
The regulators defined as SAW controlled in the device tree
will be controlled through special CPU registers instead of direct
SPMI accesses.
This is required especially for CPU supply regulators to synchronize
with clock scaling and for Automatic Voltage Switching.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 133 +++++++++++++++++++++++++++++++-
 1 file changed, 130 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 63c7a0c..9817f1a 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -25,6 +25,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/regmap.h>
 #include <linux/list.h>
+#include <linux/mfd/syscon.h>
+#include <linux/io.h>
 
 /* Pin control enable input pins. */
 #define SPMI_REGULATOR_PIN_CTRL_ENABLE_NONE		0x00
@@ -181,6 +183,23 @@ enum spmi_boost_byp_registers {
 	SPMI_BOOST_BYP_REG_CURRENT_LIMIT	= 0x4b,
 };
 
+enum spmi_saw3_registers {
+	SAW3_SECURE				= 0x00,
+	SAW3_ID					= 0x04,
+	SAW3_SPM_STS				= 0x0C,
+	SAW3_AVS_STS				= 0x10,
+	SAW3_PMIC_STS				= 0x14,
+	SAW3_RST				= 0x18,
+	SAW3_VCTL				= 0x1C,
+	SAW3_AVS_CTL				= 0x20,
+	SAW3_AVS_LIMIT				= 0x24,
+	SAW3_AVS_DLY				= 0x28,
+	SAW3_AVS_HYSTERESIS			= 0x2C,
+	SAW3_SPM_STS2				= 0x38,
+	SAW3_SPM_PMIC_DATA_3			= 0x4C,
+	SAW3_VERSION				= 0xFD0,
+};
+
 /* Used for indexing into ctrl_reg.  These are offets from 0x40 */
 enum spmi_common_control_register_index {
 	SPMI_COMMON_IDX_VOLTAGE_RANGE		= 0,
@@ -1035,6 +1054,89 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#define SAW3_VCTL_DATA_MASK	0xFF
+#define SAW3_VCTL_CLEAR_MASK	0x700FF
+#define SAW3_AVS_CTL_EN_MASK	0x1
+#define SAW3_AVS_CTL_TGGL_MASK	0x8000000
+#define SAW3_AVS_CTL_CLEAR_MASK	0x7efc00
+
+static struct regmap *saw_regmap = NULL;
+
+static void spmi_saw_set_vdd(void *data)
+{
+	u32 vctl, data3, avs_ctl, pmic_sts;
+	bool avs_enabled = false;
+	unsigned long timeout;
+	u8 voltage_sel = *(u8 *)data;
+
+	regmap_read(saw_regmap, SAW3_AVS_CTL, &avs_ctl);
+	regmap_read(saw_regmap, SAW3_VCTL, &vctl);
+	regmap_read(saw_regmap, SAW3_SPM_PMIC_DATA_3, &data3);
+
+	/* select the band */
+	vctl &= ~SAW3_VCTL_CLEAR_MASK;
+	vctl |= (u32)voltage_sel;
+
+	data3 &= ~SAW3_VCTL_CLEAR_MASK;
+	data3 |= (u32)voltage_sel;
+
+	/* If AVS is enabled, switch it off during the voltage change */
+	avs_enabled = SAW3_AVS_CTL_EN_MASK & avs_ctl;
+	if (avs_enabled) {
+		avs_ctl &= ~SAW3_AVS_CTL_TGGL_MASK;
+		regmap_write(saw_regmap, SAW3_AVS_CTL, avs_ctl);
+	}
+
+	regmap_write(saw_regmap, SAW3_RST, 1);
+	regmap_write(saw_regmap, SAW3_VCTL, vctl);
+	regmap_write(saw_regmap, SAW3_SPM_PMIC_DATA_3, data3);
+
+	timeout = jiffies + usecs_to_jiffies(100);
+	do {
+		regmap_read(saw_regmap, SAW3_PMIC_STS, &pmic_sts);
+		pmic_sts &= SAW3_VCTL_DATA_MASK;
+		if (pmic_sts == (u32)voltage_sel)
+			break;
+
+		cpu_relax();
+
+	} while (time_before(jiffies, timeout));
+
+	/* After successful voltage change, switch the AVS back on */
+	if (avs_enabled) {
+		pmic_sts &= 0x3f;
+		avs_ctl &= ~SAW3_AVS_CTL_CLEAR_MASK;
+		avs_ctl |= ((pmic_sts - 4) << 10);
+		avs_ctl |= (pmic_sts << 17);
+		avs_ctl |= SAW3_AVS_CTL_TGGL_MASK;
+		regmap_write(saw_regmap, SAW3_AVS_CTL, avs_ctl);
+	}
+}
+
+static int
+spmi_regulator_saw_set_voltage(struct regulator_dev *rdev, unsigned selector)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	int ret;
+	u8 range_sel, voltage_sel;
+
+	ret = spmi_sw_selector_to_hw(vreg, selector, &range_sel, &voltage_sel);
+	if (ret)
+		return ret;
+
+	if (0 != range_sel) {
+		dev_dbg(&rdev->dev, "range_sel = %02X voltage_sel = %02X", \
+			range_sel, voltage_sel);
+		return -EINVAL;
+	}
+
+	/* Always do the SAW register writes on the first CPU */
+	return smp_call_function_single(0, spmi_saw_set_vdd, \
+					&voltage_sel, true);
+}
+
+static struct regulator_ops spmi_saw_ops = {};
+
 static struct regulator_ops spmi_smps_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -1250,6 +1352,7 @@ static int spmi_regulator_match(struct spmi_regulator *vreg, u16 force_type)
 	}
 	dig_major_rev	= version[SPMI_COMMON_REG_DIG_MAJOR_REV
 					- SPMI_COMMON_REG_DIG_MAJOR_REV];
+
 	if (!force_type) {
 		type		= version[SPMI_COMMON_REG_TYPE -
 					  SPMI_COMMON_REG_DIG_MAJOR_REV];
@@ -1648,7 +1751,9 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	const char *name;
 	struct device *dev = &pdev->dev;
-	int ret;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *syscon;
+	int ret, lenp;
 	struct list_head *vreg_list;
 
 	vreg_list = devm_kzalloc(dev, sizeof(*vreg_list), GFP_KERNEL);
@@ -1665,7 +1770,22 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 
+	if (of_find_property(node, "qcom,saw-reg", &lenp)) {
+		syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
+		saw_regmap = syscon_node_to_regmap(syscon);
+		of_node_put(syscon);
+		if (IS_ERR(regmap))
+			dev_err(dev, "ERROR reading SAW regmap\n");
+	}
+
 	for (reg = match->data; reg->name; reg++) {
+
+		if (saw_regmap && \
+		    of_find_property(of_find_node_by_name(node, reg->name), \
+				     "qcom,saw-slave", &lenp)) {
+			continue;
+		}
+
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
 		if (!vreg)
 			return -ENOMEM;
@@ -1673,7 +1793,6 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		vreg->dev = dev;
 		vreg->base = reg->base;
 		vreg->regmap = regmap;
-
 		if (reg->ocp) {
 			vreg->ocp_irq = platform_get_irq_byname(pdev, reg->ocp);
 			if (vreg->ocp_irq < 0) {
@@ -1681,7 +1800,6 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 				goto err;
 			}
 		}
-
 		vreg->desc.id = -1;
 		vreg->desc.owner = THIS_MODULE;
 		vreg->desc.type = REGULATOR_VOLTAGE;
@@ -1698,6 +1816,15 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		if (ret)
 			continue;
 
+		if (saw_regmap && \
+		    of_find_property(of_find_node_by_name(node, reg->name), \
+				     "qcom,saw-leader", &lenp)) {
+			spmi_saw_ops = *(vreg->desc.ops);
+			spmi_saw_ops.set_voltage_sel = \
+				spmi_regulator_saw_set_voltage;
+			vreg->desc.ops = &spmi_saw_ops;
+		}
+
 		config.dev = dev;
 		config.driver_data = vreg;
 		config.regmap = regmap;
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
