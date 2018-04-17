Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDQSXw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 14:23:52 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:44721 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeDQSXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 14:23:49 -0400
X-Google-Smtp-Source: AIpwx4+b5HxXbue0TEoV4cKzSFNqZ+GA1eUxYT0skaujZw8HW4iUtYXZbzdMfiOO2pERBjH+MguTeQ==
Date: Tue, 17 Apr 2018 11:23:47 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: David Collins <collinsd@codeaurora.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rnayak@codeaurora.org, sboyd@kernel.org,
        dianders@chromium.org
Subject: Re: [v2,2/2] regulator: add QCOM RPMh regulator driver
Message-ID: <20180417182347.GD244487@google.com>
References: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 07:50:35PM -0700, David Collins wrote:
> Add the QCOM RPMh regulator driver to manage PMIC regulators
> which are controlled via RPMh on some Qualcomm Technologies, Inc.
> SoCs.  RPMh is a hardware block which contains several
> accelerators which are used to manage various hardware resources
> that are shared between the processors of the SoC.  The final
> hardware state of a regulator is determined within RPMh by
> performing max aggregation of the requests made by all of the
> processors.
> 
> Add support for PMIC regulator control via the voltage regulator
> manager (VRM) and oscillator buffer (XOB) RPMh accelerators.  VRM
> supports manipulation of enable state, voltage, mode, and
> headroom voltage.  XOB supports manipulation of enable state.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> ---
>  drivers/regulator/Kconfig               |   9 +
>  drivers/regulator/Makefile              |   1 +
>  drivers/regulator/qcom_rpmh-regulator.c | 910 ++++++++++++++++++++++++++++++++
>  3 files changed, 920 insertions(+)
>  create mode 100644 drivers/regulator/qcom_rpmh-regulator.c
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 097f617..e0ecd0a 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -671,6 +671,15 @@ config REGULATOR_QCOM_RPM
>  	  Qualcomm RPM as a module. The module will be named
>  	  "qcom_rpm-regulator".
>  
> +config REGULATOR_QCOM_RPMH
> +	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
> +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> +	help
> +	  This driver supports control of PMIC regulators via the RPMh hardware
> +	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
> +	  control allows for voting on regulator state between multiple
> +	  processors within the SoC.
> +
>  config REGULATOR_QCOM_SMD_RPM
>  	tristate "Qualcomm SMD based RPM regulator driver"
>  	depends on QCOM_SMD_RPM
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 590674f..c2274dd 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
>  obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
> +obj-$(CONFIG_REGULATOR_QCOM_RPMH) += qcom_rpmh-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_SMD_RPM) += qcom_smd-regulator.o
>  obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
> diff --git a/drivers/regulator/qcom_rpmh-regulator.c b/drivers/regulator/qcom_rpmh-regulator.c
> new file mode 100644
> index 0000000..03b1301
> --- /dev/null
> +++ b/drivers/regulator/qcom_rpmh-regulator.c
> @@ -0,0 +1,910 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/**
> + * enum rpmh_regulator_type - supported RPMh accelerator types
> + * %VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
> + *		mode, and headroom voltage of LDO, SMPS, and BOB type PMIC
> + *		regulators.
> + * %XOB:	RPMh XOB accelerator which supports voting on the enable state
> + *		of PMIC regulators.
> + */
> +enum rpmh_regulator_type {
> +	VRM,
> +	XOB,
> +};
> +
> +#define RPMH_VRM_HEADROOM_MAX_UV		511000
> +
> +#define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
> +#define RPMH_REGULATOR_REG_ENABLE		0x4
> +#define RPMH_REGULATOR_REG_VRM_MODE		0x8
> +#define RPMH_REGULATOR_REG_VRM_HEADROOM		0xC
> +
> +#define RPMH_REGULATOR_DISABLE			0x0
> +#define RPMH_REGULATOR_ENABLE			0x1
> +
> +#define RPMH_REGULATOR_MODE_COUNT		4
> +
> +/**
> + * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
> + * @regulator_type:		RPMh accelerator type used to manage this
> + *				regulator
> + * @ops:			Pointer to regulator ops callback structure
> + * @voltage_range:		The single range of voltages supported by this
> + *				PMIC regulator type
> + * @n_voltages:			The number of unique voltage set points defined
> + *				by voltage_range
> + * @pmic_mode_map:		Array indexed by regulator framework mode
> + *				containing PMIC hardware modes.  Must be large
> + *				enough to index all framework modes supported
> + *				by this regulator hardware type.
> + * @of_map_mode:		Maps an RPMH_REGULATOR_MODE_* mode value defined
> + *				in device tree to a regulator framework mode

The name of the field is a bit misleading, this is a map of RPMh mode
to regulator framework mode, the device tree just happens to be the
place where this mapping is defined.

> + * @bypass_mode:		VRM PMIC mode value corresponding to bypass
> + *				(pass-through) for this regulator.  Only used
> + *				by BOB type via VRM.
> + */
> +struct rpmh_vreg_hw_data {
> +	enum rpmh_regulator_type		regulator_type;
> +	const struct regulator_ops		*ops;
> +	const struct regulator_linear_range	voltage_range;
> +	int					n_voltages;
> +	const u32				*pmic_mode_map;
> +	unsigned int			      (*of_map_mode)(unsigned int mode);
> +	u32					bypass_mode;
> +};
> +
> +/**
> + * struct rpmh_vreg - individual rpmh regulator data structure encapsulating a
> + *		single regulator device
> + * @rpmh_client:		Handle used for rpmh communications

nit: RPMh

> + * @addr:			Base address of the regulator resource within
> + *				an RPMh accelerator
> + * @rdesc:			Regulator descriptor
> + * @hw_data:			PMIC regulator configuration data for this RPMh
> + *				regulator
> + * @regulator_type:		RPMh accelerator type for this regulator
> + *				resource
> + * @always_wait_for_ack:	Boolean flag indicating if a request must always
> + *				wait for an ACK from RPMh before continuing even
> + *				if it corresponds to a strictly lower power
> + *				state (e.g. enabled --> disabled).
> + * @drms_mode:			Array of regulator framework modes which can
> + *				be configured dynamically for this regulator
> + *				via the set_load() callback.
> + * @drms_mode_max_uA:		Array of maximum load currents in microamps
> + *				supported by the corresponding modes in
> + *				drms_mode.  Elements must be specified in
> + *				strictly increasing order.
> + * @drms_mode_count:		The number of elements in drms_mode array.
> + * @enabled:			Boolean indicating if the regulator is enabled
> + *				or not
> + * @voltage_selector:		Selector used for get_voltage_sel() and
> + *				set_voltage_sel() callbacks
> + * @mode:			RPMh VRM regulator current framework mode
> + * @bypassed:			Boolean indicating if the regulator is in
> + *				bypass (pass-through) mode or not.  This is
> + *				only used by BOB rpmh-regulator resources.
> + */
> +struct rpmh_vreg {
> +	struct rpmh_client		*rpmh_client;
> +	u32				addr;
> +	struct regulator_desc		rdesc;
> +	const struct rpmh_vreg_hw_data	*hw_data;
> +	enum rpmh_regulator_type	regulator_type;

This value is already available via rpmh_vreg->hw_data->regulator_type,
why duplicate it? The field is assigned in rpmh_regulator_init_vreg()
and only read once in the same function, there seems to be no need for
it, not even to improve readability.

> +	bool				always_wait_for_ack;
> +	unsigned int			*drms_mode;
> +	int				*drms_mode_max_uA;
> +	size_t				drms_mode_count;
> +
> +	bool				enabled;
> +	int				voltage_selector;
> +	unsigned int			mode;
> +	bool				bypassed;
> +};
> +
> +/**
> + * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
> + * @name:			Name for the regulator which also corresponds
> + *				to the device tree subnode name of the regulator
> + * @resource_name:		RPMh regulator resource name format string.
> + *				This must include exactly one field: '%s' which
> + *				is filled at run-time with the PMIC ID provided
> + *				by device tree property qcom,pmic-id.  Example:
> + *				"ldo%s1" for RPMh resource "ldoa1".
> + * @supply_name:		Parent supply regulator name
> + * @hw_data:			Configuration data for this PMIC regulator type
> + */
> +struct rpmh_vreg_init_data {
> +	const char			*name;
> +	const char			*resource_name;
> +	const char			*supply_name;
> +	const struct rpmh_vreg_hw_data	*hw_data;
> +};
> +
> +/**
> + * rpmh_regulator_send_request() - send the request to RPMh
> + * @vreg:		Pointer to the RPMh regulator
> + * @cmd:		RPMh commands to send
> + * @count:		Size of cmd array
> + * @wait_for_ack:	Boolean indicating if execution must wait until the
> + *			request has been acknowledged as complete
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
> +			struct tcs_cmd *cmd, int count, bool wait_for_ack)
> +{
> +	int ret;
> +
> +	if (wait_for_ack || vreg->always_wait_for_ack)
> +		ret = rpmh_write(vreg->rpmh_client,
> +				RPMH_ACTIVE_ONLY_STATE, cmd, count);
> +	else
> +		ret = rpmh_write_async(vreg->rpmh_client,
> +				RPMH_ACTIVE_ONLY_STATE, cmd, count);
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +	return vreg->enabled;
> +}
> +
> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = RPMH_REGULATOR_ENABLE,
> +	};
> +	int ret;
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
> +
> +	if (!ret)
> +		vreg->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +		.data = RPMH_REGULATOR_DISABLE,
> +	};
> +	int ret;
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1, false);
> +
> +	if (!ret)
> +		vreg->enabled = false;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
> +				unsigned int selector)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
> +	};
> +	int ret;
> +
> +	/* VRM voltage control register is set with voltage in millivolts. */
> +	cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
> +							selector), 1000);
> +
> +	ret = rpmh_regulator_send_request(vreg, &cmd, 1,
> +					  selector > vreg->voltage_selector);
> +	if (!ret)
> +		vreg->voltage_selector = selector;
> +
> +	return 0;
> +}
> +
> +static int rpmh_regulator_vrm_get_voltage_sel(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +	return vreg->voltage_selector;
> +}
> +
> +static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
> +					unsigned int mode, bool bypassed)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
> +	};
> +
> +	cmd.data = bypassed ? vreg->hw_data->bypass_mode
> +			    : vreg->hw_data->pmic_mode_map[mode];
> +
> +	return rpmh_regulator_send_request(vreg, &cmd, 1, true);
> +}
> +
> +static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
> +					unsigned int mode)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	if (mode == vreg->mode)
> +		return 0;
> +	else if (mode > REGULATOR_MODE_STANDBY)
> +		return -EINVAL;
> +
> +	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, mode, vreg->bypassed);
> +	if (!ret)
> +		vreg->mode = mode;
> +
> +	return ret;
> +}
> +
> +static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +	return vreg->mode;
> +}
> +
> +static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	int i;
> +
> +	for (i = 0; i < vreg->drms_mode_count - 1; i++)
> +		if (load_uA < vreg->drms_mode_max_uA[i])

Shouldn't this be '<='?

nit: IMO 'vreg->drms_mode_max_uA[i] >= load_uA' would be more readable.

> +			break;
> +
> +	return rpmh_regulator_vrm_set_mode(rdev, vreg->drms_mode[i]);
> +}
> +
> +static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
> +				bool enable)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +	int ret;
> +
> +	if (vreg->bypassed == enable)
> +		return 0;
> +
> +	ret = rpmh_regulator_vrm_set_mode_bypass(vreg, vreg->mode, enable);
> +	if (!ret)
> +		vreg->bypassed = enable;
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
> +				bool *enable)
> +{
> +	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +
> +	*enable = vreg->bypassed;
> +
> +	return 0;
> +}
> +
> +static const struct regulator_ops rpmh_regulator_vrm_ops = {
> +	.enable			= rpmh_regulator_enable,
> +	.disable		= rpmh_regulator_disable,
> +	.is_enabled		= rpmh_regulator_is_enabled,
> +	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
> +	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.set_mode		= rpmh_regulator_vrm_set_mode,
> +	.get_mode		= rpmh_regulator_vrm_get_mode,
> +	.set_load		= rpmh_regulator_vrm_set_load,
> +};
> +
> +static const struct regulator_ops rpmh_regulator_vrm_bypass_ops = {
> +	.enable			= rpmh_regulator_enable,
> +	.disable		= rpmh_regulator_disable,
> +	.is_enabled		= rpmh_regulator_is_enabled,
> +	.set_voltage_sel	= rpmh_regulator_vrm_set_voltage_sel,
> +	.get_voltage_sel	= rpmh_regulator_vrm_get_voltage_sel,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.set_mode		= rpmh_regulator_vrm_set_mode,
> +	.get_mode		= rpmh_regulator_vrm_get_mode,
> +	.set_load		= rpmh_regulator_vrm_set_load,
> +	.set_bypass		= rpmh_regulator_vrm_set_bypass,
> +	.get_bypass		= rpmh_regulator_vrm_get_bypass,
> +};
> +
> +static const struct regulator_ops rpmh_regulator_xob_ops = {
> +	.enable			= rpmh_regulator_enable,
> +	.disable		= rpmh_regulator_disable,
> +	.is_enabled		= rpmh_regulator_is_enabled,
> +};
> +
> +/**
> + * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
> + *		for a VRM RPMh resource from device tree
> + * vreg:		Pointer to the individual rpmh-regulator resource
> + * dev:			Pointer to the top level rpmh-regulator PMIC device
> + * node:		Pointer to the individual rpmh-regulator resource
> + *			device node
> + *
> + * This function initializes the drms_mode[] and drms_mode_max_uA[] arrays of
> + * vreg based upon the values of optional device tree properties.
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
> +				struct device *dev, struct device_node *node)
> +{
> +	const char *prop;
> +	int i, len, ret, mode;
> +	u32 *buf;
> +
> +	/* qcom,allowed-drms-modes is optional */
> +	prop = "qcom,allowed-drms-modes";
> +	len = of_property_count_elems_of_size(node, prop, sizeof(u32));
> +	if (len < 0)
> +		return 0;
> +
> +	vreg->drms_mode = devm_kcalloc(dev, len, sizeof(*vreg->drms_mode),
> +					GFP_KERNEL);
> +	vreg->drms_mode_max_uA = devm_kcalloc(dev, len,
> +				   sizeof(*vreg->drms_mode_max_uA), GFP_KERNEL);
> +	if (!vreg->drms_mode || !vreg->drms_mode_max_uA)
> +		return -ENOMEM;
> +	vreg->drms_mode_count = len;
> +
> +	buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_u32_array(node, prop, buf, len);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: unable to read %s, ret=%d\n",
> +			node->name, prop, ret);
> +		goto done;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		mode = vreg->hw_data->of_map_mode(buf[i]);
> +		if (mode <= 0) {
> +			dev_err(dev, "%s: element %d of %s = %u is invalid for this regulator\n",
> +				node->name, i, prop, buf[i]);
> +			ret = -EINVAL;
> +			goto done;
> +		}
> +
> +		vreg->drms_mode[i] = mode;
> +	}
> +
> +	prop = "qcom,drms-mode-threshold-currents";
> +	len = of_property_count_elems_of_size(node, prop, sizeof(u32));
> +	if (len != vreg->drms_mode_count) {
> +		dev_err(dev, "%s: invalid element count=%d for %s\n",
> +			node->name, len, prop);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	ret = of_property_read_u32_array(node, prop, buf, len);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: unable to read %s, ret=%d\n",
> +			node->name, prop, ret);
> +		goto done;
> +	}
> +
> +	for (i = 0; i < len; i++) {
> +		vreg->drms_mode_max_uA[i] = buf[i];
> +
> +		if (i > 0 && vreg->drms_mode_max_uA[i]
> +				<= vreg->drms_mode_max_uA[i - 1]) {
> +			dev_err(dev, "%s: %s elements are not in ascending order\n",
> +				node->name, prop);
> +			ret = -EINVAL;
> +			goto done;
> +		}
> +	}
> +
> +done:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +/**
> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
> + *		request for this regulator based on optional device tree
> + *		properties
> + * vreg:		Pointer to the individual rpmh-regulator resource
> + * dev:			Pointer to the top level rpmh-regulator PMIC device
> + * node:		Pointer to the individual rpmh-regulator resource
> + *			device node
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg,
> +				struct device *dev, struct device_node *node)
> +{
> +	struct tcs_cmd cmd[2] = {};
> +	const struct regulator_linear_range *range;
> +	const char *prop;
> +	int cmd_count = 0;
> +	int ret, selector;
> +	u32 uV;
> +
> +	if (vreg->hw_data->regulator_type == VRM) {
> +		prop = "qcom,headroom-voltage";
> +		ret = of_property_read_u32(node, prop, &uV);
> +		if (!ret) {
> +			if (uV > RPMH_VRM_HEADROOM_MAX_UV) {
> +				dev_err(dev, "%s: %s=%u is invalid\n",
> +					node->name, prop, uV);
> +				return -EINVAL;
> +			}
> +
> +			cmd[cmd_count].addr
> +				= vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
> +			cmd[cmd_count++].data = DIV_ROUND_UP(uV, 1000);
> +		}
> +
> +		prop = "qcom,regulator-initial-voltage";
> +		ret = of_property_read_u32(node, prop, &uV);
> +		if (!ret) {
> +			range = &vreg->hw_data->voltage_range;
> +			selector = DIV_ROUND_UP(uV - range->min_uV,
> +					range->uV_step) + range->min_sel;
> +			if (uV < range->min_uV || selector > range->max_sel) {
> +				dev_err(dev, "%s: %s=%u is invalid\n",
> +					node->name, prop, uV);
> +				return -EINVAL;
> +			}
> +
> +			vreg->voltage_selector = selector;
> +
> +			cmd[cmd_count].addr
> +				= vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
> +			cmd[cmd_count++].data
> +				= DIV_ROUND_UP(selector * range->uV_step
> +						+ range->min_uV, 1000);
> +		}
> +	}
> +
> +	if (cmd_count) {
> +		ret = rpmh_regulator_send_request(vreg, cmd, cmd_count, true);
> +		if (ret < 0) {
> +			dev_err(dev, "%s: could not send default config, ret=%d\n",
> +				node->name, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
> + * vreg:		Pointer to the individual rpmh-regulator resource
> + * dev:			Pointer to the top level rpmh-regulator PMIC device
> + * node:		Pointer to the individual rpmh-regulator resource
> + *			device node
> + * pmic_id:		String used to identify the top level rpmh-regulator
> + *			PMIC device on the board
> + * rpmh_data:		Pointer to a null-terminated array of rpmh-regulator
> + *			resources defined for the top level PMIC device
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
> +				struct device_node *node, const char *pmic_id,
> +				const struct rpmh_vreg_init_data *rpmh_data)
> +{
> +	struct regulator_config reg_config = {};
> +	char rpmh_resource_name[20] = "";
> +	struct regulator_dev *rdev;
> +	enum rpmh_regulator_type type;
> +	struct regulator_init_data *init_data;
> +	unsigned int mode;
> +	int i, ret;
> +
> +	for (; rpmh_data->name; rpmh_data++)
> +		if (!strcmp(rpmh_data->name, node->name))
> +			break;
> +
> +	if (!rpmh_data->name) {
> +		dev_err(dev, "Unknown regulator %s\n", node->name);
> +		return -EINVAL;
> +	}
> +
> +	scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
> +		rpmh_data->resource_name, pmic_id);
> +
> +	vreg->addr = cmd_db_read_addr(rpmh_resource_name);
> +	if (!vreg->addr) {
> +		dev_err(dev, "%s: could not find RPMh address for resource %s\n",
> +			node->name, rpmh_resource_name);
> +		return -ENODEV;
> +	}
> +
> +	vreg->rdesc.name = rpmh_data->name;
> +	vreg->rdesc.supply_name = rpmh_data->supply_name;
> +	vreg->regulator_type = rpmh_data->hw_data->regulator_type;
> +	vreg->hw_data = rpmh_data->hw_data;
> +
> +	if (rpmh_data->hw_data->n_voltages) {
> +		vreg->rdesc.linear_ranges = &rpmh_data->hw_data->voltage_range;
> +		vreg->rdesc.n_linear_ranges = 1;
> +		vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
> +	}
> +
> +	type = vreg->regulator_type;
> +
> +	if (type == VRM) {
> +		ret = rpmh_regulator_parse_vrm_modes(vreg, dev, node);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	vreg->always_wait_for_ack = of_property_read_bool(node,
> +						"qcom,always-wait-for-ack");
> +
> +	vreg->rdesc.owner	= THIS_MODULE;
> +	vreg->rdesc.type	= REGULATOR_VOLTAGE;
> +	vreg->rdesc.ops		= vreg->hw_data->ops;
> +	vreg->rdesc.of_map_mode	= vreg->hw_data->of_map_mode;
> +
> +	init_data = of_get_regulator_init_data(dev, node, &vreg->rdesc);
> +	if (!init_data)
> +		return -ENOMEM;
> +
> +	if (type == XOB && init_data->constraints.min_uV) {
> +		vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
> +		vreg->rdesc.n_voltages = 1;
> +	}
> +
> +	if (vreg->hw_data->of_map_mode) {
> +		init_data->constraints.valid_ops_mask |= REGULATOR_CHANGE_MODE;
> +		for (i = 0; i < RPMH_REGULATOR_MODE_COUNT; i++) {
> +			mode = vreg->hw_data->of_map_mode(i);
> +			if (mode > 0)
> +				init_data->constraints.valid_modes_mask |= mode;
> +		}
> +	}
> +
> +	reg_config.dev		= dev;
> +	reg_config.init_data	= init_data;
> +	reg_config.of_node	= node;
> +	reg_config.driver_data	= vreg;
> +
> +	ret = rpmh_regulator_load_default_parameters(vreg, dev, node);
> +	if (ret < 0)
> +		return ret;
> +
> +	rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
> +	if (IS_ERR(rdev)) {
> +		ret = PTR_ERR(rdev);
> +		rdev = NULL;
> +		dev_err(dev, "%s: devm_regulator_register() failed, ret=%d\n",
> +			node->name, ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "%s regulator registered for RPMh resource %s @ 0x%05X\n",
> +		node->name, rpmh_resource_name, vreg->addr);
> +
> +	return ret;
> +}
> +
> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
> +	[REGULATOR_MODE_STANDBY] = 4,
> +	[REGULATOR_MODE_IDLE]    = 5,
> +	[REGULATOR_MODE_NORMAL]  = -EINVAL,
> +	[REGULATOR_MODE_FAST]    = 7,
> +};

Define constants for the modes on the PMIC4 side?

> +
> +static unsigned int rpmh_regulator_pmic4_ldo_of_map_mode(unsigned int mode)
> +{
> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> +		[RPMH_REGULATOR_MODE_AUTO] = -EINVAL,
> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> +	};
> +
> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
> +		return -EINVAL;
> +
> +	return of_mode_map[mode];
> +}
> +
> +static const u32 pmic_mode_map_pmic4_smps[REGULATOR_MODE_STANDBY + 1] = {
> +	[REGULATOR_MODE_STANDBY] = 4,
> +	[REGULATOR_MODE_IDLE]    = 5,
> +	[REGULATOR_MODE_NORMAL]  = 6,
> +	[REGULATOR_MODE_FAST]    = 7,
> +};
> +
> +static unsigned int rpmh_regulator_pmic4_smps_of_map_mode(unsigned int mode)
> +{
> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> +		[RPMH_REGULATOR_MODE_RET]  = REGULATOR_MODE_STANDBY,
> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> +	};
> +
> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
> +		return -EINVAL;
> +
> +	return of_mode_map[mode];
> +}
> +
> +static const u32 pmic_mode_map_pmic4_bob[REGULATOR_MODE_STANDBY + 1] = {
> +	[REGULATOR_MODE_STANDBY] = -EINVAL,
> +	[REGULATOR_MODE_IDLE]    = 1,
> +	[REGULATOR_MODE_NORMAL]  = 2,
> +	[REGULATOR_MODE_FAST]    = 3,
> +};
> +
> +static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
> +{
> +	static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
> +		[RPMH_REGULATOR_MODE_RET]  = -EINVAL,
> +		[RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
> +		[RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
> +		[RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
> +	};
> +
> +	if (mode >= RPMH_REGULATOR_MODE_COUNT)
> +		return -EINVAL;
> +
> +	return of_mode_map[mode];
> +}
> +
> +static const struct rpmh_vreg_hw_data pmic4_pldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
> +	.n_voltages = 256,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
> +	.n_voltages = 128,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_nldo = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
> +	.n_voltages = 128,
> +	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
> +	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
> +	.n_voltages = 216,
> +	.pmic_mode_map = pmic_mode_map_pmic4_smps,
> +	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
> +	.n_voltages = 259,
> +	.pmic_mode_map = pmic_mode_map_pmic4_smps,
> +	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_bob = {
> +	.regulator_type = VRM,
> +	.ops = &rpmh_regulator_vrm_bypass_ops,
> +	.voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
> +	.n_voltages = 84,
> +	.pmic_mode_map = pmic_mode_map_pmic4_bob,
> +	.of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
> +	.bypass_mode = 0,
> +};
> +
> +static const struct rpmh_vreg_hw_data pmic4_lvs = {
> +	.regulator_type = XOB,
> +	.ops = &rpmh_regulator_xob_ops,
> +	/* LVS hardware does not support voltage or mode configuration. */
> +};
> +
> +#define RPMH_VREG(_name, _resource_name, _hw_data, _supply_name) \
> +{ \
> +	.name		= _name, \
> +	.resource_name	= _resource_name, \
> +	.hw_data	= _hw_data, \
> +	.supply_name	= _supply_name, \
> +}
> +
> +static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd_s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd_s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd_s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd_s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd_s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd_s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd_s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd_s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd_s9"),
> +	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd_s10"),
> +	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd_s11"),
> +	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd_s12"),
> +	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd_s13"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd_l1_l27"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd_l2_l8_l17"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd_l3_l11"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd_l4_l5"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd_l4_l5"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd_l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd_l7_l12_l14_l15"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd_l2_l8_l17"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd_l9"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd_l10_l23_l25"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd_l3_l11"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd_l7_l12_l14_l15"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd_l13_l19_l21"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd_l7_l12_l14_l15"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd_l7_l12_l14_l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd_l16_l28"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd_l2_l8_l17"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd_l18_l22"),
> +	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd_l13_l19_l21"),
> +	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd_l20_l24"),
> +	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd_l13_l19_l21"),
> +	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd_l18_l22"),
> +	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd_l10_l23_l25"),
> +	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd_l20_l24"),
> +	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd_l10_l23_l25"),
> +	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd_l26"),
> +	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd_l1_l27"),
> +	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd_l16_l28"),
> +	RPMH_VREG("lvs1",   "vs%s1",   &pmic4_lvs,       "vdd_lvs1_lvs2"),
> +	RPMH_VREG("lvs2",   "vs%s2",   &pmic4_lvs,       "vdd_lvs1_lvs2"),
> +	{},
> +};
> +
> +static const struct rpmh_vreg_init_data pmi8998_vreg_data[] = {
> +	RPMH_VREG("bob",    "bob%s1",  &pmic4_bob,       "vdd_bob"),
> +	{},
> +};
> +
> +static const struct rpmh_vreg_init_data pm8005_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd_s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd_s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic4_ftsmps426, "vdd_s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic4_ftsmps426, "vdd_s4"),
> +	{},
> +};
> +
> +static int rpmh_regulator_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct rpmh_vreg_init_data *vreg_data;
> +	struct rpmh_client *rpmh_client;
> +	struct device_node *node;
> +	struct rpmh_vreg *vreg;
> +	const char *pmic_id;
> +	int ret;
> +
> +	ret = cmd_db_ready();
> +	if (ret < 0) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Command DB not available, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	vreg_data = of_device_get_match_data(dev);
> +	if (!vreg_data)
> +		return -ENODEV;
> +
> +	ret = of_property_read_string(dev->of_node, "qcom,pmic-id", &pmic_id);
> +	if (ret < 0) {
> +		dev_err(dev, "qcom,pmic-id missing in DT node\n");
> +		return ret;
> +	}
> +
> +	rpmh_client = rpmh_get_client(pdev);
> +	if (IS_ERR(rpmh_client))
> +		return PTR_ERR(rpmh_client);
> +	platform_set_drvdata(pdev, rpmh_client);
> +
> +	for_each_available_child_of_node(dev->of_node, node) {
> +		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
> +		if (!vreg) {
> +			ret = -ENOMEM;
> +			of_node_put(node);
> +			goto cleanup;
> +		}
> +
> +		vreg->rpmh_client = rpmh_client;
> +
> +		ret = rpmh_regulator_init_vreg(vreg, dev, node, pmic_id,
> +						vreg_data);
> +		if (ret < 0) {
> +			of_node_put(node);
> +			goto cleanup;
> +		}
> +	}
> +
> +	return 0;
> +
> +cleanup:
> +	rpmh_release(rpmh_client);
> +
> +	return ret;
> +}
> +
> +static int rpmh_regulator_remove(struct platform_device *pdev)
> +{
> +	struct rpmh_client *rpmh_client = platform_get_drvdata(pdev);
> +
> +	rpmh_release(rpmh_client);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpmh_regulator_match_table[] = {
> +	{
> +		.compatible = "qcom,pm8998-rpmh-regulators",
> +		.data = pm8998_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pmi8998-rpmh-regulators",
> +		.data = pmi8998_vreg_data,
> +	},
> +	{
> +		.compatible = "qcom,pm8005-rpmh-regulators",
> +		.data = pm8005_vreg_data,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
> +
> +static struct platform_driver rpmh_regulator_driver = {
> +	.driver		= {
> +		.name		= "qcom-rpmh-regulator",
> +		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
> +	},
> +	.probe		= rpmh_regulator_probe,
> +	.remove		= rpmh_regulator_remove,
> +};
> +module_platform_driver(rpmh_regulator_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm RPMh regulator driver");
> +MODULE_LICENSE("GPL v2");
