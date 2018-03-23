Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCWBaN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 21:30:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbeCWBaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 21:30:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E58B5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Stephen Boyd <sboyd@kernel.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
Date: Thu, 22 Mar 2018 18:30:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Thank you for the very detailed review feedback.

On 03/21/2018 12:07 PM, Stephen Boyd wrote:
> Quoting David Collins (2018-03-16 18:09:10)
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index 097f617..e0ecd0a 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -671,6 +671,15 @@ config REGULATOR_QCOM_RPM
>>           Qualcomm RPM as a module. The module will be named
>>           "qcom_rpm-regulator".
>>  
>> +config REGULATOR_QCOM_RPMH
>> +       tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
>> +       depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> 
> What's the build dependency on OF?

The qcom_rpmh-regulator driver cannot function without device tree support
enabled.  I suppose that it might be able to compile, but it wouldn't be
useful.


>> diff --git a/drivers/regulator/qcom_rpmh-regulator.c b/drivers/regulator/qcom_rpmh-regulator.c
...
>> +#include <linux/string.h>
>> +#include <linux/regulator/driver.h>
>> +#include <linux/regulator/machine.h>
> 
> Including machine is usually a red flag in regulator drivers.

Many of the regulator drivers include machine.h.  It is done here in order
to allow manipulation of constraints.valid_ops_mask (to set
REGULATOR_CHANGE_MODE) and constraints.valid_mode_mask.  There is no DT
method to configure these fields.


>> +/* Register offsets: */
> 
> Why the colon?        ^
> Why even have the comment?

I can remove such comments if they are not preferred in upstream code.


>> +/* Enable register values: */
>> +#define RPMH_REGULATOR_DISABLE                 0x0
>> +#define RPMH_REGULATOR_ENABLE                  0x1
>> +
>> +/* Number of unique hardware modes supported: */
> 
> Both above also look useless.

I'll remove them too.


>> + * @rdev:                      Regulator device pointer returned by
>> + *                             devm_regulator_register()
> 
> Is this used? Why save it around?

I'll remove it.


>> + * @voltage:                   RPMh VRM regulator voltage in microvolts
> 
> So call it uV?

Ok.


>> + * @mode:                      RPMh VRM regulator current framework mode
>> + * @headroom_voltage:          RPMh VRM regulator minimum headroom voltage
>> + *                             required
> 
> headroom_uV?

Ok.


>> +struct rpmh_vreg {
>> +       struct device_node              *of_node;
>> +       struct rpmh_pmic                *pmic;
>> +       const char                      *resource_name;
>> +       u32                             addr;
>> +       struct regulator_desc           rdesc;
>> +       struct regulator_dev            *rdev;
>> +       const struct rpmh_vreg_hw_data  *hw_data;
>> +       enum rpmh_regulator_type        regulator_type;
>> +       bool                            always_wait_for_ack;
>> +       struct rpmh_regulator_mode      *mode_map;
>> +       int                             mode_count;
> 
> size_t?

Ok.


>> +
>> +       bool                            enabled;
>> +       int                             voltage;
>> +       unsigned int                    mode;
>> +       int                             headroom_voltage;
> 
> Please try to limit the things that are assigned into these structs and
> then never used outside of init. It adds complexity to the code when a
> local variable in the function would work just as well.

I'll remove headroom_voltage from this struct.


>> + * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
>> + * @name:                      Name for the regulator which also corresponds
>> + *                             to the device tree subnode name of the regulator
>> + * @resource_name_base:                RPMh regulator resource name prefix.  E.g.
>> + *                             "ldo" for RPMh resource "ldoa1".
> 
> Maybe it should be "ldo%c1"? Then we could kasprintf the name with the
> pmic_id and drop the 'id' member entirely.

I can make this modification (though with %s instead of %c for simplicity
with DT string parsing).  Hopefully having a variable format string
doesn't trigger any static analysis tools.


>> +struct rpmh_pmic {
>> +       struct device                           *dev;
>> +       struct rpmh_client                      *rpmh_client;
>> +       struct rpmh_vreg                        *vreg;
> 
> It's a circle! Life is a circle! It's a circle!

I can get rid of the vreg array.


>> +       int                                     vreg_count;
>> +       const char                              *pmic_id;
>> +       const struct rpmh_pmic_init_data        *init_data;
> 
> Hopefully we don't really need this entire struct and we can just use
> local variables instead.

Outside of probe-time, this is used by struct rpmh_vreg in order to access
rpmh_client (for RPMh transactions) and pmic->init_data->name (for debug
and error messages).  I suppose that rpmh_client could be specified in
struct rpmh_vreg directly.


>> +static int rpmh_regulator_enable(struct regulator_dev *rdev)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +               .data = RPMH_REGULATOR_ENABLE,
>> +       };
>> +       int ret;
>> +
>> +       if (vreg->enabled)
>> +               return 0;
>> +
>> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1, true);
>> +       if (ret < 0) {
>> +               vreg_err(vreg, "enable failed, ret=%d\n", ret);
> 
> Do we really need all these error messages deep down in the regulator
> drivers? If consumers care, they'll print some error message themselves
> anyway.

I'd prefer to keep error messages in place unless you have a strong
objection.  They make debugging simpler.


>> +/**
>> + * rpmh_regulator_vrm_set_load() - set the PMIC mode based upon the maximum load
>> + *             required from the VRM rpmh-regulator
>> + * @rdev:              Regulator device pointer for the rpmh-regulator
>> + * @load_ua:           Maximum current required from all consumers in microamps
>> + *
>> + * This function is passed as a callback function into the regulator ops that
>> + * are registered for each VRM rpmh-regulator device.
>> + *
>> + * This function sets the mode of the regulator to that which has the highest
>> + * min support load less than or equal to load_ua.  Example:
> 
> s/support/supported/

ACK


>> +/**
>> + * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
>> + *             for a VRM RPMh resource from device tree
>> + * vreg:               Pointer to the rpmh regulator resource
>> + *
>> + * This function initializes the mode[] array of vreg based upon the values
>> + * of optional device tree properties.
>> + *
>> + * Return: 0 on success, errno on failure
>> + */
>> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg)
>> +{
> 
> I have a feeling this should all come from the driver data, not DT.
> Doubtful this really changes for each board.

This needs to be determined at a board level instead of hard-coded per
regulator type.  For LDOs switching between LPM and HPM typically happens
at 10 mA or 30 mA per hardware documentation.  Unfortunately, sharing
control of regulators with other processors adds some subtlety.

Consider the case of a regulator with 10 mA LPM/HPM threshold physically.
Say that modem and application processors each have a load on the
regulator that draws 9 mA.  If they each respect the 10 mA threshold, then
they'd each vote for LPM.  VRM will aggregate these requests together
which will result in the regulator being set to LPM even though the total
load is 18 mA (which would require HPM).  To get around this corner case,
a threshold of 1 uA can be used for all supplies that have non-application
processor consumers.  Thus, any non-zero current request will result in
setting the regulator to HPM (which is always safe).

Another example is SMPS regulators which should theoretically always be
able to operate in AUTO mode.  However, there may be board/system issues
that require switching to PWM mode (HPM) for certain use cases as it has
better load regulation (even though it can source the same amount of
current as AUTO mode).  If there is more than one consumer that requires
this ability for a given regulator, then regulator_set_load() is the only
option since it provides aggregation, where as regulator_set_mode() does not.


>> +static int rpmh_regulator_allocate_vreg(struct rpmh_pmic *pmic)
>> +{
>> +       struct device_node *node;
>> +       int i;
>> +
>> +       pmic->vreg_count = of_get_available_child_count(pmic->dev->of_node);
>> +       if (pmic->vreg_count == 0) {
>> +               dev_err(pmic->dev, "could not find any regulator subnodes\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       pmic->vreg = devm_kcalloc(pmic->dev, pmic->vreg_count,
>> +                       sizeof(*pmic->vreg), GFP_KERNEL);
>> +       if (!pmic->vreg)
>> +               return -ENOMEM;
> 
> Please just allocate one at a time. It's not like we have thousands of
> these things to worry about.

Sure, I'll change this.


>> +/**
>> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
>> + *             request for this regulator based on optional device tree
>> + *             properties
>> + * @vreg:              Pointer to the RPMh regulator
>> + *
>> + * Return: 0 on success, errno on failure
>> + */
>> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg)
>> +{
>> +       struct tcs_cmd cmd[2] = { };
>> +       const char *prop;
>> +       int cmd_count = 0;
>> +       int ret;
>> +       u32 temp;
>> +
>> +       if (vreg->regulator_type == RPMH_REGULATOR_TYPE_VRM) {
>> +               prop = "qcom,headroom-voltage";
> 
> Is this regulator-microvolt-offset? Ah I guess it's a thing in the RPMh
> registers. This probably needs to be pushed into the framework and come
> down through a 'set_headroom' op in the regulator ops via a
> regulator-headroom-microvolt property that's parsed in of_regulator.c.

The qcom,headroom-voltage property is equivalent to struct
regulator_desc.min_dropout_uV, but handled in hardware.  I don't see the
need to make a new regulator op to configure this value dynamically.
Headroom typically does not need to change.  Also, we don't really want
this particular value plumbed into min_dropout_uV since we need to pass it
directly to hardware and not have the regulator framework attempt to use
it for a parent.


>> +               prop = "qcom,regulator-initial-voltage";
> 
> DT constraints should take care of this by setting voltages on all
> regulators that need them?

Unfortunately not.  At regulator registration time, the regulator
framework machine_constraints_voltage() function will call get_voltage()
op and check if the voltage is in the min_uV to max_uV constraint range.
If it is, then nothing happens.  If it's not, then it will call the
set_voltage() call back to set the voltage to min_uV if current_uV <
min_uV or max_uV if current_uV > max_uV.  Since the rpmh regulator driver
doesn't know the initial voltage, get_voltage() will return 0 initially.
As a result, machine_constraints_voltage() will always set the regulator
to the minimum constraint voltage specified in DT.

That behavior may not be acceptable for some regulators depending upon the
hardware state at kernel initialization.  Therefore, we need a DT
mechanism to specify a single voltage to configure by default.


>> + * rpmh_regulator_init_vreg() - initialize all abbributes of an rpmh-regulator
> 
> Heh, abbributes.

I'll fix this.


>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg)
...
>> +       vreg->resource_name = devm_kasprintf(dev, GFP_KERNEL, "%s%s%d",
>> +                       rpmh_data->resource_name_base, vreg->pmic->pmic_id,
>> +                       rpmh_data->id);
>> +       if (!vreg->resource_name)
>> +               return -ENOMEM;
> 
> This isn't used outside of this function, so remove the
> vreg::resource_name member and use a local variable that gets freed
> on exit please.

Ok.


>> +       /* Optional override for the default RPMh accelerator type */
>> +       ret = of_property_read_string(vreg->of_node, "qcom,rpmh-resource-type",
> 
> Can this property have override in the name? And then because it is
> called override, perhaps it should come from the driver instead of DT
> because DT may need an override itself.

Yes, I can add 'override' to the name of the property.  I'm not following
your second sentence.  We require the ability to specify that a given
regulator is using XOB instead of VRM at a board level.  This means that
the override needs to happen in DT instead of the driver.  See [1] for
more details.

> Also, is this currently being used? If not I'd prefer we drop this until we
> need it.

It will be needed on a to-be-released Qualcomm Technologies, Inc. SoC that
is currently under development.  I suppose that I can leave this property
out for the initial patch.  However, we would still need to ensure that
the driver architecture allows for this property to be read in a later
patch and determine the regulator ops and whether or not to perform VRM
specific initialization.


>> +       if (type == RPMH_REGULATOR_TYPE_XOB && init_data->constraints.min_uV) {
>> +               vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
>> +               init_data->constraints.apply_uV = 0;
>> +               vreg->rdesc.n_voltages = 1;
>> +       }
> 
> What is this doing? Usually constraints aren't touched by the driver.

For XOB managed regulators, we need to set fixed_uV to match the DT
constraint voltage and n_voltages = 1.  This allows consumers
regulator_set_voltage() calls to succeed for such regulators.  It works
the same as a fixed regulator.  I think that apply_uV = 0 could be left out.


>> +
>> +       if (vreg->hw_data->mode_map) {
>> +               init_data->constraints.valid_ops_mask |= REGULATOR_CHANGE_MODE;
> 
> Huh, I thought this was assigned by the framework.

No, this is not set anywhere in the regulator framework.  There isn't a DT
method to configure it.  It seems that it could only be handled before
with board files.  Other regulator drivers also configure it.


>> +static const struct rpmh_pmic_init_data pm8005_pmic_data = {
>> +       .name           = "PM8005",
>> +       .vreg_data      = pm8005_vreg_data,
>> +       .count          = ARRAY_SIZE(pm8005_vreg_data),
>> +};
> 
> Kill 'name' please, and then get rid of 'count' and NUL terminate the
> array instead. This follows previous rpm regulator driver styles. Also,
> drop the macro that does stringification. We should end up with the
> match_table pointing to static arrays of structs that look like:
> 
> 	{ "s1", VRM, "smp", 1, &pmic4_ftsmps42, "vdd_s1", },
> 
> And yes, drop the RPMH_REGULATOR_TYPE_ prefix and _hw_data postfix.

Ok.


>> +static const struct of_device_id rpmh_regulator_match_table[] = {
>> +       {
>> +               .compatible = "qcom,pm8998-rpmh-regulators",
>> +               .data = &pm8998_pmic_data,
>> +       },
>> +       {
>> +               .compatible = "qcom,pmi8998-rpmh-regulators",
>> +               .data = &pmi8998_pmic_data,
>> +       },
>> +       {
>> +               .compatible = "qcom,pm8005-rpmh-regulators",
>> +               .data = &pm8005_pmic_data,
>> +       },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
> 
> Please move this array next to the driver structure.

Ok.


>> +static int rpmh_regulator_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       const struct of_device_id *match;
>> +       struct rpmh_pmic *pmic;
>> +       struct device_node *node;
>> +       int ret, i;
>> +
>> +       node = dev->of_node;
>> +
>> +       if (!node) {
>> +               dev_err(dev, "Device tree node is missing\n");
>> +               return -EINVAL;
>> +       }
> 
> This should never happen. Please remove.

Ok.


>> +
>> +       ret = cmd_db_ready();
>> +       if (ret < 0) {
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
>> +               return ret;
>> +       }
> 
> We should just make rpmh parent device call cmd_db_ready() so that these
> devices aren't even populated until then and so that cmd_db_ready() is
> only in one place. Lina?

Let's see if Lina has qualms about this plan.


>> +       pmic->rpmh_client = rpmh_get_client(pdev);
>> +       if (IS_ERR(pmic->rpmh_client)) {
>> +               ret = PTR_ERR(pmic->rpmh_client);
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "failed to request RPMh client, ret=%d\n",
>> +                               ret);
> 
> I fail to see how this happens given that rpmh creates this device.

I'll remove the EPROBE_DEFER check.


>> +       match = of_match_node(rpmh_regulator_match_table, node);
>> +       if (match) {
>> +               pmic->init_data = match->data;
>> +       } else {
>> +               dev_err(dev, "could not find compatible string match\n");
>> +               ret = -ENODEV;
>> +               goto cleanup;
>> +       }
> 
> Use of_device_get_match_data() instead and print nothing on error.

Ok.


>> +       ret = rpmh_regulator_allocate_vreg(pmic);
> 
> _allocate_vregs (plural)?

This function is going to be removed per Doug's suggestions.


>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to allocate regulator subnode array, ret=%d\n",
> 
> Please no allocation error messages, kmalloc already prints a bunch of
> info.

Ok.


>> +       dev_dbg(dev, "successfully probed %d %s regulators\n",
>> +               pmic->vreg_count, pmic->init_data->name);
> 
> Doesn't the regulator framework already print a bunch of constraint
> stuff when regulators are registered? Seems sort of spammy even for
> debug mode. Plus it's the only reason for pmic::name right now.

I think that the regulator framework will only print something if it has
to set the voltage in order to bring the regulator voltage into the
constraint range.  I suppose that I can remove this message.


>> +static int rpmh_regulator_remove(struct platform_device *pdev)
>> +{
>> +       struct rpmh_pmic *pmic = platform_get_drvdata(pdev);
>> +
>> +       rpmh_release(pmic->rpmh_client);
> 
> I'm still lost on what rpmh_client is giving us besides more code we
> don't need. I'll ping the rpmh thread again.

Let's see if Lina is willing to add some devm_* calls so that no cleanup
is required.

Take care,
David

[1]: https://lkml.org/lkml/2018/3/21/877

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
