Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeCUTH0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbeCUTHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:07:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731DA21749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: David Collins <collinsd@codeaurora.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
Cc: David Collins <collinsd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
Message-ID: <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
Date: Wed, 21 Mar 2018 12:07:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Collins (2018-03-16 18:09:10)
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 097f617..e0ecd0a 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -671,6 +671,15 @@ config REGULATOR_QCOM_RPM
>           Qualcomm RPM as a module. The module will be named
>           "qcom_rpm-regulator".
>  
> +config REGULATOR_QCOM_RPMH
> +       tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
> +       depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST

What's the build dependency on OF?

> +       help
> +         This driver supports control of PMIC regulators via the RPMh hardware
> +         block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
> +         control allows for voting on regulator state between multiple
> +         processors within the SoC.
> +
>  config REGULATOR_QCOM_SMD_RPM
>         tristate "Qualcomm SMD based RPM regulator driver"
>         depends on QCOM_SMD_RPM
> diff --git a/drivers/regulator/qcom_rpmh-regulator.c b/drivers/regulator/qcom_rpmh-regulator.c
> new file mode 100644
> index 0000000..808f949
> --- /dev/null
> +++ b/drivers/regulator/qcom_rpmh-regulator.c
> @@ -0,0 +1,1124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
> +
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
> +#include <linux/bitops.h>
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

Including machine is usually a red flag in regulator drivers.

> +#include <linux/regulator/of_regulator.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +/**
> + * enum rpmh_regulator_type - supported RPMh accelerator types
> + * %RPMH_REGULATOR_TYPE_VRM:   RPMh VRM accelerator which supports voting on
> + *                             enable, voltage, mode, and headroom voltage of
> + *                             LDO, SMPS, VS, and BOB type PMIC regulators.
> + * %RPMH_REGULATOR_TYPE_XOB:   RPMh XOB accelerator which supports voting on
> + *                             the enable state of PMIC regulators.
> + */
> +enum rpmh_regulator_type {
> +       RPMH_REGULATOR_TYPE_VRM,
> +       RPMH_REGULATOR_TYPE_XOB,
> +};
> +
> +/* Min and max limits of VRM resource request parameters */
> +#define RPMH_VRM_MIN_UV                        0
> +#define RPMH_VRM_MAX_UV                        8191000
> +
> +#define RPMH_VRM_HEADROOM_MIN_UV       0
> +#define RPMH_VRM_HEADROOM_MAX_UV       511000
> +
> +#define RPMH_VRM_MODE_MIN              0
> +#define RPMH_VRM_MODE_MAX              7
> +
> +/* Register offsets: */

Why the colon?        ^
Why even have the comment?

> +#define RPMH_REGULATOR_REG_VRM_VOLTAGE         0x0
> +#define RPMH_REGULATOR_REG_ENABLE              0x4
> +#define RPMH_REGULATOR_REG_VRM_MODE            0x8
> +#define RPMH_REGULATOR_REG_VRM_HEADROOM                0xC
> +
> +/* Enable register values: */
> +#define RPMH_REGULATOR_DISABLE                 0x0
> +#define RPMH_REGULATOR_ENABLE                  0x1
> +
> +/* Number of unique hardware modes supported: */

Both above also look useless.

> +#define RPMH_REGULATOR_MODE_COUNT              5
> +
> +/**
> + * struct rpmh_regulator_mode - RPMh VRM mode attributes
> + * @pmic_mode:                 Raw PMIC mode value written into VRM mode voting
> + *                             register (i.e. RPMH_REGULATOR_MODE_*)
> + * @framework_mode:            Regulator framework mode value
> + *                             (i.e. REGULATOR_MODE_*)
> + * @min_load_ua:               The minimum load current in microamps which
> + *                             would utilize this mode
> + *
> + * Software selects the lowest mode for which aggr_load_ua >= min_load_ua.
> + */
> +struct rpmh_regulator_mode {
> +       u32                             pmic_mode;
> +       u32                             framework_mode;
> +       int                             min_load_ua;
> +};
> +
> +/**
> + * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
> + * @mode_map:                  Array of size RPMH_REGULATOR_MODE_COUNT which
> + *                             maps RPMH_REGULATOR_MODE_* indices into PMIC
> + *                             mode and regulator framework mode that are
> + *                             supported by this PMIC regulator type
> + * @voltage_range:             The single range of voltages supported by this
> + *                             PMIC regulator type
> + * @n_voltages:                        The number of unique voltage set points defined
> + *                             by voltage_range
> + * @of_map_mode:               Maps an RPMH_REGULATOR_MODE_* mode value defined
> + *                             in device tree to a regulator framework mode
> + */
> +struct rpmh_vreg_hw_data {
> +       const struct rpmh_regulator_mode        *mode_map;
> +       const struct regulator_linear_range     *voltage_range;
> +       int                                     n_voltages;
> +       unsigned int                          (*of_map_mode)(unsigned int mode);
> +};
> +
> +struct rpmh_pmic;
> +
> +/**
> + * struct rpmh_vreg - individual rpmh regulator data structure encapsulating a
> + *             single regulator device
> + * @of_node:                   Device tree node pointer of the regulator
> + * @pmic:                      Pointer to the PMIC containing the regulator
> + * @resource_name:             Name of the RPMh regulator resource which is
> + *                             mapped to an RPMh accelerator address via
> + *                             command DB.  This name must match to one that is
> + *                             defined by the bootloader.
> + * @addr:                      Base address of the regulator resource within
> + *                             an RPMh accelerator
> + * @rdesc:                     Regulator descriptor
> + * @rdev:                      Regulator device pointer returned by
> + *                             devm_regulator_register()

Is this used? Why save it around?

> + * @hw_data:                   PMIC regulator configuration data for this RPMh
> + *                             regulator
> + * @regulator_type:            RPMh accelerator type for this regulator
> + *                             resource
> + * @always_wait_for_ack:       Boolean flag indicating if a request must always
> + *                             wait for an ACK from RPMh before continuing even
> + *                             if it corresponds to a strictly lower power
> + *                             state (e.g. enabled --> disabled).
> + * @mode_map:                  An array of modes which may be configured at
> + *                             runtime by setting the load current
> + * @mode_count:                        The number of entries in the mode_map array.
> + * @enabled:                   Boolean indicating if the regulator is enabled
> + *                             or not
> + * @voltage:                   RPMh VRM regulator voltage in microvolts

So call it uV?

> + * @mode:                      RPMh VRM regulator current framework mode
> + * @headroom_voltage:          RPMh VRM regulator minimum headroom voltage
> + *                             required

headroom_uV?

> + */
> +struct rpmh_vreg {
> +       struct device_node              *of_node;
> +       struct rpmh_pmic                *pmic;
> +       const char                      *resource_name;
> +       u32                             addr;
> +       struct regulator_desc           rdesc;
> +       struct regulator_dev            *rdev;
> +       const struct rpmh_vreg_hw_data  *hw_data;
> +       enum rpmh_regulator_type        regulator_type;
> +       bool                            always_wait_for_ack;
> +       struct rpmh_regulator_mode      *mode_map;
> +       int                             mode_count;

size_t?

> +
> +       bool                            enabled;
> +       int                             voltage;
> +       unsigned int                    mode;
> +       int                             headroom_voltage;

Please try to limit the things that are assigned into these structs and
then never used outside of init. It adds complexity to the code when a
local variable in the function would work just as well.

> +};
> +
> +/**
> + * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
> + * @name:                      Name for the regulator which also corresponds
> + *                             to the device tree subnode name of the regulator
> + * @resource_name_base:                RPMh regulator resource name prefix.  E.g.
> + *                             "ldo" for RPMh resource "ldoa1".

Maybe it should be "ldo%c1"? Then we could kasprintf the name with the
pmic_id and drop the 'id' member entirely.

> + * @supply_name:               Parent supply regulator name
> + * @id:                                Regulator number within the PMIC
> + * @regulator_type:            RPMh accelerator type used to manage this
> + *                             regulator
> + * @hw_data:                   Configuration data for this PMIC regulator type
> + */
> +struct rpmh_vreg_init_data {
> +       const char                      *name;
> +       const char                      *resource_name_base;
> +       const char                      *supply_name;
> +       int                             id;
> +       enum rpmh_regulator_type        regulator_type;
> +       const struct rpmh_vreg_hw_data  *hw_data;
> +};
> +
> +/**
> + * struct rpmh_pmic_init_data - initialization data for a PMIC
> + * @name:                      PMIC name
> + * @vreg_data:                 Array of data for each regulator in the PMIC
> + * @count:                     Number of entries in vreg_data
> + */
> +struct rpmh_pmic_init_data {
> +       const char                              *name;
> +       const struct rpmh_vreg_init_data        *vreg_data;
> +       int                                     count;
> +};
> +
> +/**
> + * struct rpmh_pmic - top level data structure of all regulators found on a PMIC
> + * @dev:                       Device pointer of the PMIC device for the
> + *                             regulators
> + * @rpmh_client:               Handle used for rpmh communications
> + * @vreg:                      Array of rpmh regulator structs representing the
> + *                             individual regulators found on this PMIC chip
> + *                             which are configured via device tree.
> + * @vreg_count:                        The number of entries in the vreg array.
> + * @pmic_id:                   Letter used to identify this PMIC within the
> + *                             system.  This is dictated by boot loader
> + *                             specifications on a given target.
> + * @init_data:                 Pointer to the matched PMIC initialization data
> + */
> +struct rpmh_pmic {
> +       struct device                           *dev;
> +       struct rpmh_client                      *rpmh_client;
> +       struct rpmh_vreg                        *vreg;

It's a circle! Life is a circle! It's a circle!

> +       int                                     vreg_count;
> +       const char                              *pmic_id;
> +       const struct rpmh_pmic_init_data        *init_data;

Hopefully we don't really need this entire struct and we can just use
local variables instead.

> +};
> +
> +#define vreg_err(vreg, message, ...) \
> +       pr_err("%s %s: " message, (vreg)->pmic->init_data->name, \
> +               (vreg)->rdesc.name, ##__VA_ARGS__)
> +#define vreg_info(vreg, message, ...) \
> +       pr_info("%s %s: " message, (vreg)->pmic->init_data->name, \
> +               (vreg)->rdesc.name, ##__VA_ARGS__)
> +#define vreg_debug(vreg, message, ...) \
> +       pr_debug("%s %s: " message, (vreg)->pmic->init_data->name, \
> +               (vreg)->rdesc.name, ##__VA_ARGS__)
> +
> +/**
> + * rpmh_regulator_send_request() - send the request to RPMh
> + * @vreg:              Pointer to the RPMh regulator
> + * @cmd:               RPMh commands to send
> + * @count:             Size of cmd array
> + * @wait_for_ack:      Boolean indicating if execution must wait until the
> + *                     request has been acknowledged as complete
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_send_request(struct rpmh_vreg *vreg,
> +                       struct tcs_cmd *cmd, int count, bool wait_for_ack)
> +{
> +       int ret;
> +
> +       if (wait_for_ack || vreg->always_wait_for_ack)
> +               ret = rpmh_write(vreg->pmic->rpmh_client,
> +                               RPMH_ACTIVE_ONLY_STATE, cmd, count);
> +       else
> +               ret = rpmh_write_async(vreg->pmic->rpmh_client,
> +                               RPMH_ACTIVE_ONLY_STATE, cmd, count);
> +       if (ret < 0)
> +               vreg_err(vreg, "rpmh_write() failed, ret=%d\n", ret);
> +
> +       return ret;
> +}
> +
[...]
> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       struct tcs_cmd cmd = {
> +               .addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
> +               .data = RPMH_REGULATOR_ENABLE,
> +       };
> +       int ret;
> +
> +       if (vreg->enabled)
> +               return 0;
> +
> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
> +       if (ret < 0) {
> +               vreg_err(vreg, "enable failed, ret=%d\n", ret);

Do we really need all these error messages deep down in the regulator
drivers? If consumers care, they'll print some error message themselves
anyway.

> +               return ret;
> +       }
> +
> +       vreg->enabled = true;
> +
> +       return 0;
> +}
[...]
> +
> +/**
> + * rpmh_regulator_vrm_set_load() - set the PMIC mode based upon the maximum load
> + *             required from the VRM rpmh-regulator
> + * @rdev:              Regulator device pointer for the rpmh-regulator
> + * @load_ua:           Maximum current required from all consumers in microamps
> + *
> + * This function is passed as a callback function into the regulator ops that
> + * are registered for each VRM rpmh-regulator device.
> + *
> + * This function sets the mode of the regulator to that which has the highest
> + * min support load less than or equal to load_ua.  Example:

s/support/supported/

> + *     mode_count = 3
> + *     mode_map[].min_load_ua = 0, 100000, 6000000
> + *
> + *     load_ua = 10000   --> i = 0
> + *     load_ua = 250000  --> i = 1
> + *     load_ua = 7000000 --> i = 2
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_ua)
> +{
> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
> +       int i;
> +
> +       /* No need to check element 0 as it will be the default. */
> +       for (i = vreg->mode_count - 1; i > 0; i--)
> +               if (vreg->mode_map[i].min_load_ua <= load_ua)
> +                       break;
> +
> +       return rpmh_regulator_vrm_set_mode(rdev,
> +                                          vreg->mode_map[i].framework_mode);
> +}
> +
> +static const struct regulator_ops rpmh_regulator_vrm_ops = {
> +       .enable                 = rpmh_regulator_enable,
> +       .disable                = rpmh_regulator_disable,
> +       .is_enabled             = rpmh_regulator_is_enabled,
> +       .set_voltage            = rpmh_regulator_vrm_set_voltage,
> +       .get_voltage            = rpmh_regulator_vrm_get_voltage,
> +       .list_voltage           = regulator_list_voltage_linear_range,
> +       .set_mode               = rpmh_regulator_vrm_set_mode,
> +       .get_mode               = rpmh_regulator_vrm_get_mode,
> +       .set_load               = rpmh_regulator_vrm_set_load,
> +};
> +
> +static const struct regulator_ops rpmh_regulator_xob_ops = {
> +       .enable                 = rpmh_regulator_enable,
> +       .disable                = rpmh_regulator_disable,
> +       .is_enabled             = rpmh_regulator_is_enabled,
> +};
> +
> +static const struct regulator_ops *rpmh_regulator_ops[] = {
> +       [RPMH_REGULATOR_TYPE_VRM]       = &rpmh_regulator_vrm_ops,
> +       [RPMH_REGULATOR_TYPE_XOB]       = &rpmh_regulator_xob_ops,
> +};
> +
> +/**
> + * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
> + *             for a VRM RPMh resource from device tree
> + * vreg:               Pointer to the rpmh regulator resource
> + *
> + * This function initializes the mode[] array of vreg based upon the values
> + * of optional device tree properties.
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg)
> +{

I have a feeling this should all come from the driver data, not DT.
Doubtful this really changes for each board.

> +       struct device_node *node = vreg->of_node;
> +       const struct rpmh_regulator_mode *map;
> +       const char *prop;
> +       int i, len, ret;
> +       u32 *buf;
> +
> +       map = vreg->hw_data->mode_map;
> +       if (!map)
> +               return 0;
> +
> +       /* qcom,allowed-modes is optional */
> +       prop = "qcom,allowed-modes";
> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
> +       if (len < 0)
> +               return 0;
> +
> +       vreg->mode_map = devm_kcalloc(vreg->pmic->dev, len,
> +                               sizeof(*vreg->mode_map), GFP_KERNEL);
> +       if (!vreg->mode_map)
> +               return -ENOMEM;
> +       vreg->mode_count = len;
> +
> +       buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       ret = of_property_read_u32_array(node, prop, buf, len);
> +       if (ret < 0) {
> +               vreg_err(vreg, "unable to read %s, ret=%d\n",
> +                       prop, ret);
> +               goto done;
> +       }
> +
> +       for (i = 0; i < len; i++) {
> +               if (buf[i] >= RPMH_REGULATOR_MODE_COUNT
> +                   || !map[buf[i]].framework_mode) {
> +                       vreg_err(vreg, "element %d of %s = %u is invalid for this regulator\n",
> +                               i, prop, buf[i]);
> +                       ret = -EINVAL;
> +                       goto done;
> +               }
> +
> +               vreg->mode_map[i].pmic_mode = map[buf[i]].pmic_mode;
> +               vreg->mode_map[i].framework_mode = map[buf[i]].framework_mode;
> +
> +               if (i > 0 && vreg->mode_map[i].pmic_mode
> +                               <= vreg->mode_map[i - 1].pmic_mode) {
> +                       vreg_err(vreg, "%s elements are not in ascending order\n",
> +                               prop);
> +                       ret = -EINVAL;
> +                       goto done;
> +               }
> +       }
> +
> +       prop = "qcom,mode-threshold-currents";
> +       ret = of_property_read_u32_array(node, prop, buf, len);
> +       if (ret < 0) {
> +               vreg_err(vreg, "unable to read %s, ret=%d\n",
> +                       prop, ret);
> +               goto done;
> +       }
> +
> +       for (i = 0; i < len; i++) {
> +               vreg->mode_map[i].min_load_ua = buf[i];
> +
> +               if (i > 0 && vreg->mode_map[i].min_load_ua
> +                               <= vreg->mode_map[i - 1].min_load_ua) {
> +                       vreg_err(vreg, "%s elements are not in ascending order\n",
> +                               prop);
> +                       ret = -EINVAL;
> +                       goto done;
> +               }
> +       }
> +
> +done:
> +       kfree(buf);
> +       return ret;
> +}
> +
> +/**
> + * rpmh_regulator_allocate_vreg() - allocate space for the regulators associated
> + *             with the PMIC and initialize important pointers for each
> + *             regulator
> + * @pmic:              Pointer to the RPMh regulator PMIC
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_allocate_vreg(struct rpmh_pmic *pmic)
> +{
> +       struct device_node *node;
> +       int i;
> +
> +       pmic->vreg_count = of_get_available_child_count(pmic->dev->of_node);
> +       if (pmic->vreg_count == 0) {
> +               dev_err(pmic->dev, "could not find any regulator subnodes\n");
> +               return -ENODEV;
> +       }
> +
> +       pmic->vreg = devm_kcalloc(pmic->dev, pmic->vreg_count,
> +                       sizeof(*pmic->vreg), GFP_KERNEL);
> +       if (!pmic->vreg)
> +               return -ENOMEM;

Please just allocate one at a time. It's not like we have thousands of
these things to worry about.

> +
> +       i = 0;
> +       for_each_available_child_of_node(pmic->dev->of_node, node) {
> +               pmic->vreg[i].of_node = node;
> +               pmic->vreg[i].pmic = pmic;
> +
> +               i++;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
> + *             request for this regulator based on optional device tree
> + *             properties
> + * @vreg:              Pointer to the RPMh regulator
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg)
> +{
> +       struct tcs_cmd cmd[2] = { };
> +       const char *prop;
> +       int cmd_count = 0;
> +       int ret;
> +       u32 temp;
> +
> +       if (vreg->regulator_type == RPMH_REGULATOR_TYPE_VRM) {
> +               prop = "qcom,headroom-voltage";

Is this regulator-microvolt-offset? Ah I guess it's a thing in the RPMh
registers. This probably needs to be pushed into the framework and come
down through a 'set_headroom' op in the regulator ops via a
regulator-headroom-microvolt property that's parsed in of_regulator.c.

> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
> +               if (!ret) {
> +                       if (temp < RPMH_VRM_HEADROOM_MIN_UV ||
> +                           temp > RPMH_VRM_HEADROOM_MAX_UV) {
> +                               vreg_err(vreg, "%s=%u is invalid\n",
> +                                       prop, temp);
> +                               return -EINVAL;
> +                       }
> +                       vreg->headroom_voltage = temp;
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
> +                       cmd[cmd_count++].data
> +                               = DIV_ROUND_UP(vreg->headroom_voltage, 1000);
> +               }
> +
> +               prop = "qcom,regulator-initial-voltage";

DT constraints should take care of this by setting voltages on all
regulators that need them?

> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
> +               if (!ret) {
> +                       if (temp < RPMH_VRM_MIN_UV || temp > RPMH_VRM_MAX_UV) {
> +                               vreg_err(vreg, "%s=%u is invalid\n",
> +                                       prop, temp);
> +                               return -EINVAL;
> +                       }
> +                       vreg->voltage = temp;
> +
> +                       cmd[cmd_count].addr
> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
> +                       cmd[cmd_count++].data
> +                               = DIV_ROUND_UP(vreg->voltage, 1000);
> +               }
> +       }
> +
> +       if (cmd_count) {
> +               ret = rpmh_regulator_send_request(vreg, cmd, cmd_count, true);
> +               if (ret < 0) {
> +                       vreg_err(vreg, "could not send default config, ret=%d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * rpmh_regulator_init_vreg() - initialize all abbributes of an rpmh-regulator

Heh, abbributes.

> + * @vreg:              Pointer to the RPMh regulator
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg)
> +{
> +       struct device *dev = vreg->pmic->dev;
> +       struct regulator_config reg_config = {};
> +       const struct rpmh_vreg_init_data *rpmh_data = NULL;
> +       const char *type_name = NULL;
> +       enum rpmh_regulator_type type;
> +       struct regulator_init_data *init_data;
> +       int ret, i;
> +
> +       for (i = 0; i < vreg->pmic->init_data->count; i++) {
> +               if (!strcmp(vreg->pmic->init_data->vreg_data[i].name,
> +                           vreg->of_node->name)) {
> +                       rpmh_data = &vreg->pmic->init_data->vreg_data[i];
> +                       break;
> +               }
> +       }
> +
> +       if (!rpmh_data) {
> +               dev_err(dev, "Unknown regulator %s for %s RPMh regulator PMIC\n",
> +                       vreg->of_node->name, vreg->pmic->init_data->name);
> +               return -EINVAL;
> +       }
> +
> +       vreg->resource_name = devm_kasprintf(dev, GFP_KERNEL, "%s%s%d",
> +                       rpmh_data->resource_name_base, vreg->pmic->pmic_id,
> +                       rpmh_data->id);
> +       if (!vreg->resource_name)
> +               return -ENOMEM;

This isn't used outside of this function, so remove the
vreg::resource_name member and use a local variable that gets freed
on exit please.

> +
> +       vreg->addr = cmd_db_read_addr(vreg->resource_name);
> +       if (!vreg->addr) {
> +               vreg_err(vreg, "could not find RPMh address for resource %s\n",
> +                       vreg->resource_name);
> +               return -ENODEV;
> +       }
> +
> +       vreg->rdesc.name = rpmh_data->name;
> +       vreg->rdesc.supply_name = rpmh_data->supply_name;
> +       vreg->regulator_type = rpmh_data->regulator_type;
> +       vreg->hw_data = rpmh_data->hw_data;
> +
> +       if (rpmh_data->hw_data->voltage_range) {
> +               vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_range;
> +               vreg->rdesc.n_linear_ranges = 1;
> +               vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
> +       }
> +
> +       /* Optional override for the default RPMh accelerator type */
> +       ret = of_property_read_string(vreg->of_node, "qcom,rpmh-resource-type",

Can this property have override in the name? And then because it is
called override, perhaps it should come from the driver instead of DT
because DT may need an override itself.

Also, is this currently being used? If not I'd prefer we drop this until we
need it.

> +                                       &type_name);
> +       if (!ret) {
> +               if (!strcmp("vrm", type_name)) {
> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_VRM;
> +               } else if (!strcmp("xob", type_name)) {
> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_XOB;
> +               } else {
> +                       vreg_err(vreg, "Unknown RPMh accelerator type %s\n",
> +                               type_name);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       type = vreg->regulator_type;
> +
> +       if (type == RPMH_REGULATOR_TYPE_VRM) {
> +               ret = rpmh_regulator_parse_vrm_modes(vreg);
> +               if (ret < 0) {
> +                       vreg_err(vreg, "could not parse vrm mode mapping, ret=%d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       vreg->always_wait_for_ack = of_property_read_bool(vreg->of_node,
> +                                               "qcom,always-wait-for-ack");
> +
> +       vreg->rdesc.owner       = THIS_MODULE;
> +       vreg->rdesc.type        = REGULATOR_VOLTAGE;
> +       vreg->rdesc.ops         = rpmh_regulator_ops[type];
> +       vreg->rdesc.of_map_mode = vreg->hw_data->of_map_mode;
> +
> +       init_data = of_get_regulator_init_data(dev, vreg->of_node,
> +                                               &vreg->rdesc);
> +       if (!init_data)
> +               return -ENOMEM;
> +
> +       if (type == RPMH_REGULATOR_TYPE_XOB && init_data->constraints.min_uV) {
> +               vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
> +               init_data->constraints.apply_uV = 0;
> +               vreg->rdesc.n_voltages = 1;
> +       }

What is this doing? Usually constraints aren't touched by the driver.

> +
> +       if (vreg->hw_data->mode_map) {
> +               init_data->constraints.valid_ops_mask |= REGULATOR_CHANGE_MODE;

Huh, I thought this was assigned by the framework.

> +               for (i = 0; i < RPMH_REGULATOR_MODE_COUNT; i++)
> +                       init_data->constraints.valid_modes_mask
> +                               |= vreg->hw_data->mode_map[i].framework_mode;
> +       }
> +
> +       reg_config.dev                  = dev;
> +       reg_config.init_data            = init_data;
> +       reg_config.of_node              = vreg->of_node;
> +       reg_config.driver_data          = vreg;
> +
> +       ret = rpmh_regulator_load_default_parameters(vreg);
> +       if (ret < 0) {
> +               vreg_err(vreg, "unable to load default parameters, ret=%d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       vreg->rdev = devm_regulator_register(dev, &vreg->rdesc, &reg_config);
> +       if (IS_ERR(vreg->rdev)) {
> +               ret = PTR_ERR(vreg->rdev);
> +               vreg->rdev = NULL;
> +               vreg_err(vreg, "devm_regulator_register() failed, ret=%d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       vreg_debug(vreg, "registered RPMh resource %s @ 0x%05X\n",
> +               vreg->resource_name, vreg->addr);
> +
> +       return ret;
> +}
> +
[...]
> +
> +static const struct rpmh_pmic_init_data pm8005_pmic_data = {
> +       .name           = "PM8005",
> +       .vreg_data      = pm8005_vreg_data,
> +       .count          = ARRAY_SIZE(pm8005_vreg_data),
> +};

Kill 'name' please, and then get rid of 'count' and NUL terminate the
array instead. This follows previous rpm regulator driver styles. Also,
drop the macro that does stringification. We should end up with the
match_table pointing to static arrays of structs that look like:

	{ "s1", VRM, "smp", 1, &pmic4_ftsmps42, "vdd_s1", },

And yes, drop the RPMH_REGULATOR_TYPE_ prefix and _hw_data postfix.

> +
> +static const struct of_device_id rpmh_regulator_match_table[] = {
> +       {
> +               .compatible = "qcom,pm8998-rpmh-regulators",
> +               .data = &pm8998_pmic_data,
> +       },
> +       {
> +               .compatible = "qcom,pmi8998-rpmh-regulators",
> +               .data = &pmi8998_pmic_data,
> +       },
> +       {
> +               .compatible = "qcom,pm8005-rpmh-regulators",
> +               .data = &pm8005_pmic_data,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);

Please move this array next to the driver structure.

> +
> +/**
> + * rpmh_regulator_probe() - probe an RPMh PMIC and register regulators for each
> + *             of the regulator nodes associated with it
> + * @pdev:              Pointer to the platform device of the RPMh PMIC
> + *
> + * Return: 0 on success, errno on failure
> + */
> +static int rpmh_regulator_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct of_device_id *match;
> +       struct rpmh_pmic *pmic;
> +       struct device_node *node;
> +       int ret, i;
> +
> +       node = dev->of_node;
> +
> +       if (!node) {
> +               dev_err(dev, "Device tree node is missing\n");
> +               return -EINVAL;
> +       }

This should never happen. Please remove.

> +
> +       ret = cmd_db_ready();
> +       if (ret < 0) {
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
> +               return ret;
> +       }

We should just make rpmh parent device call cmd_db_ready() so that these
devices aren't even populated until then and so that cmd_db_ready() is
only in one place. Lina?

> +
> +       pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +       if (!pmic)
> +               return -ENOMEM;
> +
> +       pmic->dev = dev;
> +       platform_set_drvdata(pdev, pmic);
> +
> +       pmic->rpmh_client = rpmh_get_client(pdev);
> +       if (IS_ERR(pmic->rpmh_client)) {
> +               ret = PTR_ERR(pmic->rpmh_client);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to request RPMh client, ret=%d\n",
> +                               ret);

I fail to see how this happens given that rpmh creates this device.

> +               return ret;
> +       }
> +
> +       match = of_match_node(rpmh_regulator_match_table, node);
> +       if (match) {
> +               pmic->init_data = match->data;
> +       } else {
> +               dev_err(dev, "could not find compatible string match\n");
> +               ret = -ENODEV;
> +               goto cleanup;
> +       }

Use of_device_get_match_data() instead and print nothing on error.

> +
> +       ret = of_property_read_string(node, "qcom,pmic-id",
> +                                    &pmic->pmic_id);
> +       if (ret < 0) {
> +               dev_err(dev, "qcom,pmic-id missing in DT node\n");
> +               goto cleanup;
> +       }
> +
> +       ret = rpmh_regulator_allocate_vreg(pmic);

_allocate_vregs (plural)?

> +       if (ret < 0) {
> +               dev_err(dev, "failed to allocate regulator subnode array, ret=%d\n",

Please no allocation error messages, kmalloc already prints a bunch of
info.

> +                       ret);
> +               goto cleanup;
> +       }
> +
> +       for (i = 0; i < pmic->vreg_count; i++) {
> +               ret = rpmh_regulator_init_vreg(&pmic->vreg[i]);
> +               if (ret < 0) {
> +                       dev_err(dev, "unable to initialize rpmh-regulator vreg %s, ret=%d\n",
> +                               pmic->vreg[i].of_node->name, ret);
> +                       goto cleanup;
> +               }
> +       }
> +
> +       dev_dbg(dev, "successfully probed %d %s regulators\n",
> +               pmic->vreg_count, pmic->init_data->name);

Doesn't the regulator framework already print a bunch of constraint
stuff when regulators are registered? Seems sort of spammy even for
debug mode. Plus it's the only reason for pmic::name right now.

> +
> +       return ret;
> +
> +cleanup:
> +       rpmh_release(pmic->rpmh_client);
> +
> +       return ret;
> +}
> +
> +static int rpmh_regulator_remove(struct platform_device *pdev)
> +{
> +       struct rpmh_pmic *pmic = platform_get_drvdata(pdev);
> +
> +       rpmh_release(pmic->rpmh_client);

I'm still lost on what rpmh_client is giving us besides more code we
don't need. I'll ping the rpmh thread again.

> +
> +       return 0;
> +}
