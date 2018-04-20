Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeDTTHU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 15:07:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56574 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeDTTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 15:07:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 906EE60500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Stephen Boyd <swboyd@chromium.org>, broonie@kernel.org,
        lgirdwood@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <dcd4e178-cfd3-1c3f-da7c-1eb66a58cf15@codeaurora.org>
Date: Fri, 20 Apr 2018 12:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2018 10:55 PM, Stephen Boyd wrote:
> Quoting David Collins (2018-03-22 18:30:06)
>> On 03/21/2018 12:07 PM, Stephen Boyd wrote:
>>> Quoting David Collins (2018-03-16 18:09:10)
>>>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>>>> index 097f617..e0ecd0a 100644
>>>> --- a/drivers/regulator/Kconfig
>>>> +++ b/drivers/regulator/Kconfig
>>>> @@ -671,6 +671,15 @@ config REGULATOR_QCOM_RPM
>>>>           Qualcomm RPM as a module. The module will be named
>>>>           "qcom_rpm-regulator".
>>>>  
>>>> +config REGULATOR_QCOM_RPMH
>>>> +       tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
>>>> +       depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
>>>
>>> What's the build dependency on OF?
>>
>> The qcom_rpmh-regulator driver cannot function without device tree support
>> enabled.  I suppose that it might be able to compile, but it wouldn't be
>> useful.
> 
> If it isn't a build dependency then we usually leave it out because it's
> not always useful to express runtime constraints in Kconfig. Probably
> all we need is depends on QCOM_RPMH || COMPILE_TEST and then stubs take
> care of it from there.

Ok.  I'll change this to:

depends on QCOM_RPMH || COMPILE_TEST


>>>> + * struct rpmh_vreg_init_data - initialization data for an RPMh regulator
>>>> + * @name:                      Name for the regulator which also corresponds
>>>> + *                             to the device tree subnode name of the regulator
>>>> + * @resource_name_base:                RPMh regulator resource name prefix.  E.g.
>>>> + *                             "ldo" for RPMh resource "ldoa1".
>>>
>>> Maybe it should be "ldo%c1"? Then we could kasprintf the name with the
>>> pmic_id and drop the 'id' member entirely.
>>
>> I can make this modification (though with %s instead of %c for simplicity
>> with DT string parsing).  Hopefully having a variable format string
>> doesn't trigger any static analysis tools.
> 
> Oh it's variable how many digits in the 'id' number there are? I'll look
> at v2.

At the moment, the id field has only ever been a single character.
However, that isn't set in stone.  I was mainly interested in using %s
instead of %c since it doesn't require any special handling of the string
read directly from DT.


>>>> +       int                                     vreg_count;
>>>> +       const char                              *pmic_id;
>>>> +       const struct rpmh_pmic_init_data        *init_data;
>>>
>>> Hopefully we don't really need this entire struct and we can just use
>>> local variables instead.
>>
>> Outside of probe-time, this is used by struct rpmh_vreg in order to access
>> rpmh_client (for RPMh transactions) and pmic->init_data->name (for debug
>> and error messages).  I suppose that rpmh_client could be specified in
>> struct rpmh_vreg directly.
>>
> 
> Hopefully rpm_client goes away. Maybe it would just be dev pointer to
> hold onto then and possibly rip the name of each regulator out of the
> framework name for it?

In the v2 patch set, I removed this top-level struct and moved rpmh_client
into struct rpmh_vreg.  Now that v6 of the rpmh series is out with
rpmh_client removed and dev pointer in its place, I'll add the dev pointer
to struct rpmh_vreg in my v3 patch set.


>>>> +/**
>>>> + * rpmh_regulator_parse_vrm_modes() - parse the supported mode configurations
>>>> + *             for a VRM RPMh resource from device tree
>>>> + * vreg:               Pointer to the rpmh regulator resource
>>>> + *
>>>> + * This function initializes the mode[] array of vreg based upon the values
>>>> + * of optional device tree properties.
>>>> + *
>>>> + * Return: 0 on success, errno on failure
>>>> + */
>>>> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg)
>>>> +{
>>>
>>> I have a feeling this should all come from the driver data, not DT.
>>> Doubtful this really changes for each board.
>>
>> This needs to be determined at a board level instead of hard-coded per
>> regulator type.  For LDOs switching between LPM and HPM typically happens
>> at 10 mA or 30 mA per hardware documentation.  Unfortunately, sharing
>> control of regulators with other processors adds some subtlety.
>>
>> Consider the case of a regulator with 10 mA LPM/HPM threshold physically.
>> Say that modem and application processors each have a load on the
>> regulator that draws 9 mA.  If they each respect the 10 mA threshold, then
>> they'd each vote for LPM.  VRM will aggregate these requests together
>> which will result in the regulator being set to LPM even though the total
>> load is 18 mA (which would require HPM).  To get around this corner case,
>> a threshold of 1 uA can be used for all supplies that have non-application
>> processor consumers.  Thus, any non-zero current request will result in
>> setting the regulator to HPM (which is always safe).
> 
> Sad. Sounds like the rpmh interface is broken and should be expressing
> the load instead of the mode so that aggregation on the rpm side can
> pick the right mode. So now we have a workaround by specifying some
> default minimum value that we add in?

RPMh hardware is not going to support load current aggregation.  The
aggregation method in hardware is to pick the highest mode control
register value requested by all processors and send that to the PMIC.

We are avoiding the LPM + LPM request issue on downstream targets by
configuring the LPM vs HPM threshold current such that any load_uA total
greater than 0 from Linux consumers results in a HPM request.


>> Another example is SMPS regulators which should theoretically always be
>> able to operate in AUTO mode.  However, there may be board/system issues
>> that require switching to PWM mode (HPM) for certain use cases as it has
>> better load regulation (even though it can source the same amount of
>> current as AUTO mode).  If there is more than one consumer that requires
>> this ability for a given regulator, then regulator_set_load() is the only
>> option since it provides aggregation, where as regulator_set_mode() does not.
> 
> I lost the code context, but my general comment was that the modes that
> the hardware supports should come from the driver. If there's some sort
> of constraint on what those modes end up being because some board has an
> issue with some mode then we would want a binding that indicates such a
> mode needs to be avoided, instead of listing the ones that are
> supported. So default assume what registers support is there and then
> knock out things when board designs constrain it. That's all I'm saying.
> Maybe it's just "supported" that threw me off.

As Mark explained, modes need to be explicitly allowed per board-specific
configurations.


>>>> +/**
>>>> + * rpmh_regulator_load_default_parameters() - initialize the RPMh resource
>>>> + *             request for this regulator based on optional device tree
>>>> + *             properties
>>>> + * @vreg:              Pointer to the RPMh regulator
>>>> + *
>>>> + * Return: 0 on success, errno on failure
>>>> + */
>>>> +static int rpmh_regulator_load_default_parameters(struct rpmh_vreg *vreg)
>>>> +{
>>>> +       struct tcs_cmd cmd[2] = { };
>>>> +       const char *prop;
>>>> +       int cmd_count = 0;
>>>> +       int ret;
>>>> +       u32 temp;
>>>> +
>>>> +       if (vreg->regulator_type == RPMH_REGULATOR_TYPE_VRM) {
>>>> +               prop = "qcom,headroom-voltage";
>>>
>>> Is this regulator-microvolt-offset? Ah I guess it's a thing in the RPMh
>>> registers. This probably needs to be pushed into the framework and come
>>> down through a 'set_headroom' op in the regulator ops via a
>>> regulator-headroom-microvolt property that's parsed in of_regulator.c.
>>
>> The qcom,headroom-voltage property is equivalent to struct
>> regulator_desc.min_dropout_uV, but handled in hardware.  I don't see the
>> need to make a new regulator op to configure this value dynamically.
>> Headroom typically does not need to change.  Also, we don't really want
>> this particular value plumbed into min_dropout_uV since we need to pass it
>> directly to hardware and not have the regulator framework attempt to use
>> it for a parent.
> 
> Ok? We have other regulator ops just to configure boot time things. The
> goal is to come up with generic regulator properties that can be applied
> from the framework perspective and be used by other regulator drivers in
> the future.

Hardware enforced headroom voltage is a feature very specific to RPMh.  It
is not generic.  I don't see any need to add general support for this in
the regulator framework.  Software managed headroom voltage is already
present in the framework.


>>>> +               prop = "qcom,regulator-initial-voltage";
>>>
>>> DT constraints should take care of this by setting voltages on all
>>> regulators that need them?
>>
>> Unfortunately not.  At regulator registration time, the regulator
>> framework machine_constraints_voltage() function will call get_voltage()
>> op and check if the voltage is in the min_uV to max_uV constraint range.
>> If it is, then nothing happens.  If it's not, then it will call the
>> set_voltage() call back to set the voltage to min_uV if current_uV <
>> min_uV or max_uV if current_uV > max_uV.  Since the rpmh regulator driver
>> doesn't know the initial voltage, get_voltage() will return 0 initially.
>> As a result, machine_constraints_voltage() will always set the regulator
>> to the minimum constraint voltage specified in DT.
>>
>> That behavior may not be acceptable for some regulators depending upon the
>> hardware state at kernel initialization.  Therefore, we need a DT
>> mechanism to specify a single voltage to configure by default.
> 
> Cool. This should be a generic regulator DT property that all regulators
> can use. We have the same problem on other RPM based regulator drivers
> where boot sends a bunch of voltages because we don't know what it is by
> default out of boot and we can't read it.

I suppose that I can look into adding a generic
regulator-initial-microvolt property if that is strongly preferred over an
rpmh-regulator specific one.


>>>> +       /* Optional override for the default RPMh accelerator type */
>>>> +       ret = of_property_read_string(vreg->of_node, "qcom,rpmh-resource-type",
>>>
>>> Can this property have override in the name? And then because it is
>>> called override, perhaps it should come from the driver instead of DT
>>> because DT may need an override itself.
>>
>> Yes, I can add 'override' to the name of the property.  I'm not following
>> your second sentence.  We require the ability to specify that a given
>> regulator is using XOB instead of VRM at a board level.  This means that
>> the override needs to happen in DT instead of the driver.  See [1] for
>> more details.
> 
> Ah ok. Can this be "discovered" through cmd-db by probing for VRM and
> then for XOB if there isn't a VRM one? Just wondering why we need to
> describe it in DT at all if cmd-db will have one or the other.

Unfortunately, this cannot be determined via command DB.  Command DB will
only show us the mapping from resource name string to RPMh address.  The
address does not distinguish VRM vs XOB.  There are plans for adding
command DB AUX data to specify VRM vs XOB in future chips, but this is not
present for SDM845.


>>>> +       if (type == RPMH_REGULATOR_TYPE_XOB && init_data->constraints.min_uV) {
>>>> +               vreg->rdesc.fixed_uV = init_data->constraints.min_uV;
>>>> +               init_data->constraints.apply_uV = 0;
>>>> +               vreg->rdesc.n_voltages = 1;
>>>> +       }
>>>
>>> What is this doing? Usually constraints aren't touched by the driver.
>>
>> For XOB managed regulators, we need to set fixed_uV to match the DT
>> constraint voltage and n_voltages = 1.  This allows consumers
>> regulator_set_voltage() calls to succeed for such regulators.  It works
>> the same as a fixed regulator.  I think that apply_uV = 0 could be left out.
>>
> 
> Wouldn't XOB regulators only have one voltage specified for min/max in
> DT already though? I seem to recall that's how we make set_voltage() in
> those cases work. Or it could be that drivers aren't supposed to call
> set_voltage() on single or fixed voltage regulators anyway, because
> constraints take care of it for them.

The XOB regulators will indeed have regulator-min-microvolt ==
regulator-max-microvolt in DT.  However, this is not sufficient to ensure
that consumer regulator_set_voltage() calls intersecting the constraint
voltage return successfully.  I have not specified any set_voltage() or
get_voltage() callbacks for XOB regulators because it is physically not
possible to configure their voltage.  As a result, consumer
regulator_set_voltage calls can only succeed if desc.fixed_uV is set and
desc.n_voltages == 1.  See [1] and [2].  Note that I removed
init_data->constraints.apply_uV manipulation in the qcom_rpmh-regulator v2
patch set.

Using the existing fixed_uV feature of the regulator framework seemed like
a better option than open-coding a get_voltage() callback for XOB which
returns a new struct rpmh_vreg field that stores the fixed XOB voltage.
Do you agree with this approach?  I'll add init_data->constraints.min_uV
== init_data->constraints.max_uV to the above check as well.


>>>> +
>>>> +       if (vreg->hw_data->mode_map) {
>>>> +               init_data->constraints.valid_ops_mask |= REGULATOR_CHANGE_MODE;
>>>
>>> Huh, I thought this was assigned by the framework.
>>
>> No, this is not set anywhere in the regulator framework.  There isn't a DT
>> method to configure it.  It seems that it could only be handled before
>> with board files.  Other regulator drivers also configure it.
> 
> Hmm ok. Would something be bad if we did support it through DT? I can't
> seem to recall the history here.

I'll send out a patch to support this in of_get_regulation_constraints().


>>>> +       ret = cmd_db_ready();
>>>> +       if (ret < 0) {
>>>> +               if (ret != -EPROBE_DEFER)
>>>> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>
>>> We should just make rpmh parent device call cmd_db_ready() so that these
>>> devices aren't even populated until then and so that cmd_db_ready() is
>>> only in one place. Lina?
>>
>> Let's see if Lina has qualms about this plan.
> 
> Sounds like you're ok with it.

Sure, I'll remove this check if Lina agrees to add it in the rpmh driver.

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/core.c?h=v4.17-rc1#n2940
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/core.c?h=v4.17-rc1#n3319

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
