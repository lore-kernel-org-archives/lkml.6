Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeELC2V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 22:28:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34314 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeELC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 22:28:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03E5B60B23
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
From: David Collins <collinsd@codeaurora.org>
To: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: [PATCH v3 2/2] regulator: add QCOM RPMh regulator driver
Date: Fri, 11 May 2018 19:28:06 -0700
Message-Id: <3a4195365ab0d252fdf064d2300f45b9b777991c.1526088081.git.collinsd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1526088081.git.collinsd@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org>
In-Reply-To: <cover.1526088081.git.collinsd@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QCOM RPMh regulator driver to manage PMIC regulators
which are controlled via RPMh on some Qualcomm Technologies, Inc.
SoCs.  RPMh is a hardware block which contains several
accelerators which are used to manage various hardware resources
that are shared between the processors of the SoC.  The final
hardware state of a regulator is determined within RPMh by
performing max aggregation of the requests made by all of the
processors.

Add support for PMIC regulator control via the voltage regulator
manager (VRM) and oscillator buffer (XOB) RPMh accelerators.  VRM
supports manipulation of enable state, voltage, mode, and
headroom voltage.  XOB supports manipulation of enable state.

Signed-off-by: David Collins <collinsd@codeaurora.org>
---
 drivers/regulator/Kconfig               |   9 +
 drivers/regulator/Makefile              |   1 +
 drivers/regulator/qcom-rpmh-regulator.c | 925 ++++++++++++++++++++++++++++++++
 3 files changed, 935 insertions(+)
 create mode 100644 drivers/regulator/qcom-rpmh-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 4efae3b..1a69bdc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -671,6 +671,15 @@ config REGULATOR_QCOM_RPM
 	  Qualcomm RPM as a module. The module will be named
 	  "qcom_rpm-regulator".
 
+config REGULATOR_QCOM_RPMH
+	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
+	depends on QCOM_RPMH || COMPILE_TEST
+	help
+	  This driver supports control of PMIC regulators via the RPMh hardware
+	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
+	  control allows for voting on regulator state between multiple
+	  processors within the SoC.
+
 config REGULATOR_QCOM_SMD_RPM
 	tristate "Qualcomm SMD based RPM regulator driver"
 	depends on QCOM_SMD_RPM
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index d81fb02..906f048 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
+obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
new file mode 100644
index 0000000..991ecc1
--- /dev/null
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -0,0 +1,925 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+/**
+ * enum rpmh_regulator_type - supported RPMh accelerator types
+ * %VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
+ *		mode, and headroom voltage of LDO, SMPS, and BOB type PMIC
+ *		regulators.
+ * %XOB:	RPMh XOB accelerator which supports voting on the enable state
+ *		of PMIC regulators.
+ */
+enum rpmh_regulator_type {
+	VRM,
+	XOB,
+};
+
+#define RPMH_VRM_HEADROOM_MAX_UV		511000
+
+#define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
+#define RPMH_REGULATOR_REG_ENABLE		0x4
+#define RPMH_REGULATOR_REG_VRM_MODE		0x8
+#define RPMH_REGULATOR_REG_VRM_HEADROOM		0xC
+
+#define RPMH_REGULATOR_MODE_COUNT		4
+
+#define PMIC4_LDO_MODE_RETENTION		4
+#define PMIC4_LDO_MODE_LPM			5
+#define PMIC4_LDO_MODE_HPM			7
+
+#define PMIC4_SMPS_MODE_RETENTION		4
+#define PMIC4_SMPS_MODE_PFM			5
+#define PMIC4_SMPS_MODE_AUTO			6
+#define PMIC4_SMPS_MODE_PWM			7
+
+#define PMIC4_BOB_MODE_PASS			0
+#define PMIC4_BOB_MODE_PFM			1
+#define PMIC4_BOB_MODE_AUTO			2
+#define PMIC4_BOB_MODE_PWM			3
+
+/**
+ * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
+ * @regulator_type:		RPMh accelerator type used to manage this
+ *				regulator
+ * @ops:			Pointer to regulator ops callback structure
+ * @voltage_range:		The single range of voltages supported by this
+ *				PMIC regulator type
+ * @n_voltages:			The number of unique voltage set points defined
+ *				by voltage_range
+ * @pmic_mode_map:		Array indexed by regulator framework mode
+ *				containing PMIC hardware modes.  Must be large
+ *				enough to index all framework modes supported
+ *				by this regulator hardware type.
+ * @of_map_mode:		Maps an RPMH_REGULATOR_MODE_* mode value defined
+ *				in device tree to a regulator framework mode
+ */
+struct rpmh_vreg_hw_data {
+	enum rpmh_regulator_type		regulator_type;
+	const struct regulator_ops		*ops;
+	const struct regulator_linear_range	voltage_range;
+	int					n_voltages;
+	const int				*pmic_mode_map;
+	unsigned int			      (*of_map_mode)(unsigned int mode);
+};
+
+/**
+ * struct rpmh_vreg - individual RPMh regulator data structure encapsulating a
+ *		single regulator device
+ * @dev:			Device pointer for the top-level PMIC RPMh
+ *				regulator parent device.  This is used as a
+ *				handle in RPMh write requests.
+ * @addr:			Base address of the regulator resource within
+ *				an RPMh accelerator
+ * @rdesc:			Regulator descriptor
+ * @hw_data:			PMIC regulator configuration data for this RPMh
+ *				regulator
+ * @always_wait_for_ack:	Boolean flag indicating if a request must always
+ *				wait for an ACK from RPMh before continuing even
+ *				if it corresponds to a strictly lower power
+ *				state (e.g. enabled --> disabled).
+ * @drms_modes:			Array of regulator framework modes which can
+ *				be configured dynamically for this regulator
+ *				via the set_load() callback.
+ * @drms_mode_max_uAs:		Array of maximum load currents in microamps
+ *				supported by the corresponding modes in
+ *				drms_mode.  Elements must be specified in
+ *				strictly increasing order.
+ * @drms_mode_count:		The number of elements in drms_mode array.
+ * @enabled:			Boolean indicating if the regulator is enabled
+ *				or not
+ * @bypassed:			Boolean indicating if the regulator is in
+ *				bypass (pass-through) mode or not.  This is
+ *				only used by BOB rpmh-regulator resources.
+ * @voltage_selector:		Selector used for get_voltage_sel() and
+ *				set_voltage_sel() callbacks
+ * @mode:			RPMh VRM regulator current framework mode
+ */
+struct rpmh_vreg {
+	struct device			*dev;
+	u32				addr;
+	struct regulator_desc		rdesc;
+	const struct rpmh_vreg_hw_data	*hw_data;
+	bool				always_wait_for_ack;
+	unsigned int			*drms_modes;
+	int				*drms_mode_max_uAs;
+	size_t				drms_mode_count;
+
+	bool				enabled;
+	bool				bypassed;
+	int				voltage_selector;
+	unsigned int			mode;
+};
+
+/**
+ * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
+ * @name:			Name for the regulator which also corresponds
+ *				to the device tree subnode name of the regulator
+ * @resource_name:		RPMh regulator resource name format string.
+ *				This must include exactly one field: '%s' which
+ *				is filled at run-time with the PMIC ID provided
+ *				by device tree property qcom,pmic-id.  Example:
+ *				"ldo%s1" for RPMh resource "ldoa1".
+ * @supply_name:		Parent supply regulator name
+ * @hw_data:			Configuration data for this PMIC regulator type
+ */
+struct rpmh_vreg_init_data {
+	const char			*name;
+	const char			*resource_name;
+	const char			*supply_name;
+	const struct rpmh_vreg_hw_data	*hw_data;
+};
+
+/**
+ * rpmh_regulator_send_request() - send the request to RPMh
+ * @vreg:		Pointer to the RPMh regulator
+ * @cmd:		RPMh commands to send
+ * @count:		Size of cmd array
+ * @wait_for_ack:	Boolean indicating if execution must wait until the
+ *			request has been acknowledged as complete
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
+			struct tcs_cmd *cmd, int count, bool wait_for_ack)
+{
+	int ret;
+
+	if (wait_for_ack || vreg->always_wait_for_ack)
+		ret = rpmh_write(vreg->dev, RPMH_ACTIVE_ONLY_STATE, cmd, count);
+	else
+		ret = rpmh_write_async(vreg->dev, RPMH_ACTIVE_ONLY_STATE, cmd,
+					count);
+
+	return ret;
+}
+
+static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+
+	return vreg->enabled;
+}
+
+static int rpmh_regulator_enable(struct regulator_dev *rdev)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
+		.data = 1,
+	};
+	int ret;
+
+	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
+
+	if (!ret)
+		vreg->enabled = true;
+
+	return ret;
+}
+
+static int rpmh_regulator_disable(struct regulator_dev *rdev)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
+		.data = 0,
+	};
+	int ret;
+
+	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
+
+	if (!ret)
+		vreg->enabled = false;
+
+	return ret;
+}
+
+static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
+				unsigned int selector)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
+	};
+	int ret;
+
+	/* VRM voltage control register is set with voltage in millivolts. */
+	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
+							selector), 1000);
+
+	ret = rpmh_regulator_send_request(vreg, &cmd, 1,
+					  selector > vreg->voltage_selector);
+	if (!ret)
+		vreg->voltage_selector = selector;
+
+	return 0;
+}
+
+static int rpmh_regulator_vrm_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+
+	return vreg->voltage_selector;
+}
+
+static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
+					unsigned int mode, bool bypassed)
+{
+	struct tcs_cmd cmd = {
+		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
+	};
+	int pmic_mode;
+
+	if (mode > REGULATOR_MODE_STANDBY)
+		return -EINVAL;
+
+	pmic_mode = vreg->hw_data->pmic_mode_map[mode];
+	if (pmic_mode < 0)
+		return pmic_mode;
+
+	cmd.data = bypassed ? PMIC4_BOB_MODE_PASS : pmic_mode;
+
+	return rpmh_regulator_send_request(vreg, &cmd, 1, true);
+}
+
+static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
+					unsigned int mode)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	int ret;
+
+	if (mode == vreg->mode)
+		return 0;
+
+	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
+	if (!ret)
+		vreg->mode = mode;
+
+	return ret;
+}
+
+static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+
+	return vreg->mode;
+}
+
+/**
+ * rpmh_regulator_vrm_set_load() - set the regulator mode based upon the load
+ *		current requested
+ * @rdev:		Regulator device pointer for the rpmh-regulator
+ * @load_uA:		Aggregated load current in microamps
+ *
+ * This function is used in the regulator_ops for VRM type RPMh regulator
+ * devices.  It updates the mode of the regulator using a table of maximum
+ * load currents per mode specified in device tree properties.
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	int i;
+
+	for (i = 0; i < vreg->drms_mode_count - 1; i++)
+		if (vreg->drms_mode_max_uAs[i] >= load_uA)
+			break;
+	if (load_uA > vreg->drms_mode_max_uAs[vreg->drms_mode_count - 1])
+		dev_warn(vreg->dev, "%s: requested load=%d uA greater than max=%d uA\n",
+			vreg->rdesc.name, load_uA,
+			vreg->drms_mode_max_uAs[vreg->drms_mode_count - 1]);
+
+	return rpmh_regulator_vrm_set_mode(rdev, vreg->drms_modes[i]);
+}
+
+static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
+				bool enable)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+	int ret;
+
+	if (vreg->bypassed == enable)
+		return 0;
+
+	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, vreg->mode, enable);
+	if (!ret)
+		vreg->bypassed = enable;
+
+	return ret;
+}
+
+static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
+				bool *enable)
+{
+	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
+
+	*enable = vreg->bypassed;
+
+	return 0;
+}
+
+static const struct regulator_ops rpmh_regulator_vrm_ops = {
+	.enable			= rpmh_regulator_enable,
+	.disable		= rpmh_regulator_disable,
+	.is_enabled		= rpmh_regulator_is_enabled,
+	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
+	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.set_mode		= rpmh_regulator_vrm_set_mode,
+	.get_mode		= rpmh_regulator_vrm_get_mode,
+	.set_load		= rpmh_regulator_vrm_set_load,
+};
+
+static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
+	.enable			= rpmh_regulator_enable,
+	.disable		= rpmh_regulator_disable,
+	.is_enabled		= rpmh_regulator_is_enabled,
+	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
+	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.set_mode		= rpmh_regulator_vrm_set_mode,
+	.get_mode		= rpmh_regulator_vrm_get_mode,
+	.set_load		= rpmh_regulator_vrm_set_load,
+	.set_bypass		= rpmh_regulator_vrm_set_bypass,
+	.get_bypass		= rpmh_regulator_vrm_get_bypass,
+};
+
+static const struct regulator_ops rpmh_regulator_xob_ops = {
+	.enable			= rpmh_regulator_enable,
+	.disable		= rpmh_regulator_disable,
+	.is_enabled		= rpmh_regulator_is_enabled,
+};
+
+/**
+ * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
+ *		for a VRM RPMh resource from device tree
+ * vreg:		Pointer to the individual rpmh-regulator resource
+ * dev:			Pointer to the top level rpmh-regulator PMIC device
+ * node:		Pointer to the individual rpmh-regulator resource
+ *			device node
+ *
+ * This function initializes the drms_modes[] and drms_mode_max_uAs[] arrays of
+ * vreg based upon the values of optional device tree properties.
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
+				struct device *dev, struct device_node *node)
+{
+	const char *prop;
+	int i, len, ret, mode;
+	u32 *buf;
+
+	/* qcom,allowed-drms-modes is optional */
+	prop = "qcom,allowed-drms-modes";
+	len = of_property_count_elems_of_size(node, prop, sizeof(u32));
+	if (len < 0)
+		return 0;
+
+	vreg->drms_modes = devm_kcalloc(dev, len, sizeof(*vreg->drms_modes),
+					GFP_KERNEL);
+	vreg->drms_mode_max_uAs = devm_kcalloc(dev, len,
+					       sizeof(*vreg->drms_mode_max_uAs),
+					       GFP_KERNEL);
+	if (!vreg->drms_modes || !vreg->drms_mode_max_uAs)
+		return -ENOMEM;
+	vreg->drms_mode_count = len;
+
+	buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(node, prop, buf, len);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to read %s, ret=%d\n",
+			node->name, prop, ret);
+		goto done;
+	}
+
+	for (i = 0; i < len; i++) {
+		mode = vreg->hw_data->of_map_mode(buf[i]);
+		if (mode == REGULATOR_MODE_INVALID) {
+			dev_err(dev, "%s: element %d of %s = %u is invalid for this regulator\n",
+				node->name, i, prop, buf[i]);
+			ret = -EINVAL;
+			goto done;
+		}
+
+		vreg->drms_modes[i] = mode;
+	}
+
+	prop = "qcom,drms-mode-max-microamps";
+	len = of_property_count_elems_of_size(node, prop, sizeof(u32));
+	if (len != vreg->drms_mode_count) {
+		dev_err(dev, "%s: invalid element count=%d for %s\n",
+			node->name, len, prop);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = of_property_read_u32_array(node, prop, buf, len);
+	if (ret < 0) {
+		dev_err(dev, "%s: unable to read %s, ret=%d\n",
+			node->name, prop, ret);
+		goto done;
+	}
+
+	for (i = 0; i < len; i++) {
+		vreg->drms_mode_max_uAs[i] = buf[i];
+
+		if (i > 0 && vreg->drms_mode_max_uAs[i]
+				<= vreg->drms_mode_max_uAs[i - 1]) {
+			dev_err(dev, "%s: %s elements are not in ascending order\n",
+				node->name, prop);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+done:
+	kfree(buf);
+	return ret;
+}
+
+/**
+ * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
+ *		request for this regulator based on optional device tree
+ *		properties
+ * vreg:		Pointer to the individual rpmh-regulator resource
+ * dev:			Pointer to the top level rpmh-regulator PMIC device
+ * node:		Pointer to the individual rpmh-regulator resource
+ *			device node
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg,
+				struct device *dev, struct device_node *node)
+{
+	struct tcs_cmd cmd[2] = {};
+	const struct regulator_linear_range *range;
+	const char *prop;
+	int cmd_count = 0;
+	int ret, selector;
+	u32 uV;
+
+	if (vreg->hw_data->regulator_type == VRM) {
+		/*
+		 * This will be set when devm_regulator_register() is called
+		 * if regulator-initial-mode is specified in device tree.
+		 */
+		vreg->mode = REGULATOR_MODE_INVALID;
+
+		prop = "qcom,headroom-microvolt";
+		ret = of_property_read_u32(node, prop, &uV);
+		if (!ret) {
+			if (uV > RPMH_VRM_HEADROOM_MAX_UV) {
+				dev_err(dev, "%s: %s=%u is invalid\n",
+					node->name, prop, uV);
+				return -EINVAL;
+			}
+
+			cmd[cmd_count].addr
+				= vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
+			cmd[cmd_count++].data = DIV_ROUND_UP(uV, 1000);
+		}
+
+		prop = "qcom,regulator-initial-microvolt";
+		ret = of_property_read_u32(node, prop, &uV);
+		if (!ret) {
+			range = &vreg->hw_data->voltage_range;
+			selector = DIV_ROUND_UP(uV - range->min_uV,
+					range->uV_step) + range->min_sel;
+			if (uV < range->min_uV || selector > range->max_sel) {
+				dev_err(dev, "%s: %s=%u is invalid\n",
+					node->name, prop, uV);
+				return -EINVAL;
+			}
+
+			vreg->voltage_selector = selector;
+
+			cmd[cmd_count].addr
+				= vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
+			cmd[cmd_count++].data
+				= DIV_ROUND_UP(selector * range->uV_step
+						+ range->min_uV, 1000);
+		} else {
+			/*
+			 * Default the voltage selector to an error value in the
+			 * case that qcom,regulator-initial-microvolt is not
+			 * specified in device tree since the true voltage is
+			 * not known.  Note that this value causes
+			 * devm_regulator_register() to fail in the case that
+			 * regulator-min-microvolt and regulator-max-microvolt
+			 * are specified in device tree due to
+			 * machine_constraints_voltage() bailing when the
+			 * get_voltage_sel() callback returns this error value.
+			 */
+			vreg->voltage_selector = -EINVAL;
+		}
+	}
+
+	if (cmd_count) {
+		ret = rpmh_regulator_send_request(vreg, cmd, cmd_count, true);
+		if (ret < 0) {
+			dev_err(dev, "%s: could not send default config, ret=%d\n",
+				node->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
+ * vreg:		Pointer to the individual rpmh-regulator resource
+ * dev:			Pointer to the top level rpmh-regulator PMIC device
+ * node:		Pointer to the individual rpmh-regulator resource
+ *			device node
+ * pmic_id:		String used to identify the top level rpmh-regulator
+ *			PMIC device on the board
+ * rpmh_data:		Pointer to a null-terminated array of rpmh-regulator
+ *			resources defined for the top level PMIC device
+ *
+ * Return: 0 on success, errno on failure
+ */
+static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
+				struct device_node *node, const char *pmic_id,
+				const struct rpmh_vreg_init_data *rpmh_data)
+{
+	struct regulator_config reg_config = {};
+	char rpmh_resource_name[20] = "";
+	struct regulator_dev *rdev;
+	enum rpmh_regulator_type type;
+	struct regulator_init_data *init_data;
+	int ret;
+
+	vreg->dev = dev;
+
+	for (; rpmh_data->name; rpmh_data++)
+		if (!strcmp(rpmh_data->name, node->name))
+			break;
+
+	if (!rpmh_data->name) {
+		dev_err(dev, "Unknown regulator %s\n", node->name);
+		return -EINVAL;
+	}
+
+	scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
+		rpmh_data->resource_name, pmic_id);
+
+	vreg->addr = cmd_db_read_addr(rpmh_resource_name);
+	if (!vreg->addr) {
+		dev_err(dev, "%s: could not find RPMh address for resource %s\n",
+			node->name, rpmh_resource_name);
+		return -ENODEV;
+	}
+
+	vreg->rdesc.name = rpmh_data->name;
+	vreg->rdesc.supply_name = rpmh_data->supply_name;
+	vreg->hw_data = rpmh_data->hw_data;
+
+	if (rpmh_data->hw_data->n_voltages) {
+		vreg->rdesc.linear_ranges = &rpmh_data->hw_data->voltage_range;
+		vreg->rdesc.n_linear_ranges = 1;
+		vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
+	}
+
+	type = rpmh_data->hw_data->regulator_type;
+	if (type == VRM) {
+		ret = rpmh_regulator_parse_vrm_modes(vreg, dev, node);
+		if (ret < 0)
+			return ret;
+	}
+
+	vreg->always_wait_for_ack = of_property_read_bool(node,
+						"qcom,always-wait-for-ack");
+
+	vreg->rdesc.owner	= THIS_MODULE;
+	vreg->rdesc.type	= REGULATOR_VOLTAGE;
+	vreg->rdesc.ops		= vreg->hw_data->ops;
+	vreg->rdesc.of_map_mode	= vreg->hw_data->of_map_mode;
+
+	init_data = of_get_regulator_init_data(dev, node, &vreg->rdesc);
+	if (!init_data)
+		return -ENOMEM;
+
+	if (type == XOB && init_data->constraints.min_uV &&
+	    init_data->constraints.min_uV == init_data->constraints.max_uV) {
+		vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
+		vreg->rdesc.n_voltages = 1;
+	}
+
+	reg_config.dev		= dev;
+	reg_config.init_data	= init_data;
+	reg_config.of_node	= node;
+	reg_config.driver_data	= vreg;
+
+	ret = rpmh_regulator_load_default_parameters(vreg, dev, node);
+	if (ret < 0)
+		return ret;
+
+	rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		rdev = NULL;
+		dev_err(dev, "%s: devm_regulator_register() failed, ret=%d\n",
+			node->name, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "%s regulator registered for RPMh resource %s @ 0x%05X\n",
+		node->name, rpmh_resource_name, vreg->addr);
+
+	return ret;
+}
+
+static const int pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
+	[REGULATOR_MODE_INVALID] = -EINVAL,
+	[REGULATOR_MODE_STANDBY] = PMIC4_LDO_MODE_RETENTION,
+	[REGULATOR_MODE_IDLE]    = PMIC4_LDO_MODE_LPM,
+	[REGULATOR_MODE_NORMAL]  = -EINVAL,
+	[REGULATOR_MODE_FAST]    = PMIC4_LDO_MODE_HPM,
+};
+
+static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
+{
+	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
+		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
+		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
+		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_INVALID,
+		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
+	};
+
+	if (mode >= RPMH_REGULATOR_MODE_COUNT)
+		return -EINVAL;
+
+	return of_mode_map[mode];
+}
+
+static const int pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
+	[REGULATOR_MODE_INVALID] = -EINVAL,
+	[REGULATOR_MODE_STANDBY] = PMIC4_SMPS_MODE_RETENTION,
+	[REGULATOR_MODE_IDLE]    = PMIC4_SMPS_MODE_PFM,
+	[REGULATOR_MODE_NORMAL]  = PMIC4_SMPS_MODE_AUTO,
+	[REGULATOR_MODE_FAST]    = PMIC4_SMPS_MODE_PWM,
+};
+
+static unsigned int rpmh_regulator_pmic4_smps_of_map_mode(unsigned int mode)
+{
+	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
+		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
+		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
+		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
+		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
+	};
+
+	if (mode >= RPMH_REGULATOR_MODE_COUNT)
+		return -EINVAL;
+
+	return of_mode_map[mode];
+}
+
+static const int pmic_mode_map_pmic4_bob[REGULATOR_MODE_STANDBY + 1] = {
+	[REGULATOR_MODE_INVALID] = -EINVAL,
+	[REGULATOR_MODE_STANDBY] = -EINVAL,
+	[REGULATOR_MODE_IDLE]    = PMIC4_BOB_MODE_PFM,
+	[REGULATOR_MODE_NORMAL]  = PMIC4_BOB_MODE_AUTO,
+	[REGULATOR_MODE_FAST]    = PMIC4_BOB_MODE_PWM,
+};
+
+static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
+{
+	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
+		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_INVALID,
+		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
+		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
+		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
+	};
+
+	if (mode >= RPMH_REGULATOR_MODE_COUNT)
+		return -EINVAL;
+
+	return of_mode_map[mode];
+}
+
+static const struct rpmh_vreg_hw_data pmic4_pldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	.n_voltages = 256,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	.n_voltages = 128,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_nldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	.n_voltages = 128,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 216,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	.n_voltages = 259,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_bob = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_bypass_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
+	.n_voltages = 84,
+	.pmic_mode_map = pmic_mode_map_pmic4_bob,
+	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic4_lvs = {
+	.regulator_type = XOB,
+	.ops = &rpmh_regulator_xob_ops,
+	/* LVS hardware does not support voltage or mode configuration. */
+};
+
+#define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
+{ \
+	.name		= _name, \
+	.resource_name	= _resource_name, \
+	.hw_data	= _hw_data, \
+	.supply_name	= _supply_name, \
+}
+
+static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd-s10"),
+	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd-s11"),
+	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd-s12"),
+	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd-s13"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l16-l28"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd-l26"),
+	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
+	RPMH_VREG("lvs1",   "vs%s1",   &pmic4_lvs,       "vin-lvs-1-2"),
+	RPMH_VREG("lvs2",   "vs%s2",   &pmic4_lvs,       "vin-lvs-1-2"),
+	{},
+};
+
+static const struct rpmh_vreg_init_data pmi8998_vreg_data[] = {
+	RPMH_VREG("bob",    "bob%s1",  &pmic4_bob,       "vdd-bob"),
+	{},
+};
+
+static const struct rpmh_vreg_init_data pm8005_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic4_ftsmps426, "vdd-s4"),
+	{},
+};
+
+static int rpmh_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct rpmh_vreg_init_data *vreg_data;
+	struct device_node *node;
+	struct rpmh_vreg *vreg;
+	const char *pmic_id;
+	int ret;
+
+	ret = cmd_db_ready();
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Command DB not available, ret=%d\n", ret);
+		return ret;
+	}
+
+	vreg_data = of_device_get_match_data(dev);
+	if (!vreg_data)
+		return -ENODEV;
+
+	ret = of_property_read_string(dev->of_node, "qcom,pmic-id", &pmic_id);
+	if (ret < 0) {
+		dev_err(dev, "qcom,pmic-id missing in DT node\n");
+		return ret;
+	}
+
+	for_each_available_child_of_node(dev->of_node, node) {
+		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
+		if (!vreg) {
+			of_node_put(node);
+			return -ENOMEM;
+		}
+
+		ret = rpmh_regulator_init_vreg(vreg, dev, node, pmic_id,
+						vreg_data);
+		if (ret < 0) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rpmh_regulator_match_table[] = {
+	{
+		.compatible = "qcom,pm8998-rpmh-regulators",
+		.data = pm8998_vreg_data,
+	},
+	{
+		.compatible = "qcom,pmi8998-rpmh-regulators",
+		.data = pmi8998_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8005-rpmh-regulators",
+		.data = pm8005_vreg_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
+
+static struct platform_driver rpmh_regulator_driver = {
+	.driver = {
+		.name = "qcom-rpmh-regulator",
+		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
+	},
+	.probe = rpmh_regulator_probe,
+};
+module_platform_driver(rpmh_regulator_driver);
+
+MODULE_DESCRIPTION("Qualcomm RPMh regulator driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
