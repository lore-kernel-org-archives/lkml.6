Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeCVWbk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:31:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCVWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:31:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AE84607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        ilina@codeaurora.org
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
Date: Thu, 22 Mar 2018 15:31:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Doug,

Thank you for the very detailed review feedback.

On 03/20/2018 07:16 PM, Doug Anderson wrote:
> On Fri, Mar 16, 2018 at 6:09 PM, David Collins <collinsd@codeaurora.org> wrote:
>> +/**
>> + * struct rpmh_regulator_mode - RPMh VRM mode attributes
>> + * @pmic_mode:                 Raw PMIC mode value written into VRM mode voting
>> + *                             register (i.e. RPMH_REGULATOR_MODE_*)
>> + * @framework_mode:            Regulator framework mode value
>> + *                             (i.e. REGULATOR_MODE_*)
>> + * @min_load_ua:               The minimum load current in microamps which
>> + *                             would utilize this mode
> 
> Thinking of this as "min load" seems backward to me.  Shouldn't we be
> keeping track of "max load".  AKA:
> 
> Use "idle" if the load is less than 1000 mA
> Use "normal" if the load is more than 1000 mA but less than 5000 mA
> Use "fast" if the load is more than 5000 mA.
> 
> I'd think of "1000 mA as the max load that "idle" can handle".  The
> reason I don't think of it as "min" is that you can't say "1000 mA is
> the min load the "normal" can handle".  Normal can handle smaller
> loads just fine, it's just not ideal.
> 
> Thinking of it in terms of "max" would also get rid of that weird
> "needs to be 0" entry in the device tree too.  You could either leave
> the number off the top one (and set to INT_MAX in software?) or you
> could use that to put in some sort of sane maximum current.  I'd bet
> there's something in the datasheet for this.  If someone in software
> got mixed up and kept requesting more and more current, this could
> catch their error.

Sure, I'll change the logic to use max instead of min threshold currents
in the driver and device tree.


>> +static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +
>> +       return vreg->enabled;
> 
> You can't read hardware?  The regulator framework expects you to read
> hardware.  If it was common not to be able to read hardware then the
> regulator framework would just keep track of the enabled state for
> you.  Right now if a regulator was left on by the BIOS (presumably
> some have to be since otherwise you're running on a computer that
> takes no power), you'll still return false at bootup?  Seems
> non-ideal.

Correct, the RPMh interface provides no mechanism to poll the physical
PMIC regulator hardware state.

However, that isn't entirely a bad thing due to the nature of RPMh
regulator control.  Several processors within the SoC besides the
application processor are able to vote on the state of PMIC regulators via
RPMh.  The VRM and XOB RPMh hardware blocks perform max aggregation across
votes from different processors for each votable quantity for a given
regulator (enable, voltage, mode, and headroom voltage for VRM; enable for
XOB).  The aggregated values are then configured in the PMIC regulator via
SPMI transactions.

If Linux could read the physical PMIC regulator state and report it back
via is_enabled(), get_voltage() and get_mode() regulator ops, then we
could get into situations where the applications processor fails to vote
on a regulator which is requested by a Linux consumer.  For example, say
that the modem processor has requested a given regulator to be enabled via
RPMh.  Later, a Linux consumer driver on the application processor calls
regulator_enable() for the regulator.  The regulator framework will call
the is_enabled() callback which will return true.  This would then
short-circuit the regulator_enable() call and skip calling the
rpmh-regulator enable() callback.  This means that the application
processor would have no enable vote present within RPMh for the regulator.
 If the modem processor then voted to disable the regulator, it would
physically be disabled even though a consumer on the application processor
expects it to stay enabled.


>> +}
>> +
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
> 
> Does the "if" test above ever hit?  I'd think the regulator framework
> would handle this.

I'm not sure if it has ever been hit.  I can remove it.


>> +static int rpmh_regulator_disable(struct regulator_dev *rdev)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_ENABLE,
>> +               .data = RPMH_REGULATOR_DISABLE,
>> +       };
>> +       int ret;
>> +
>> +       if (!vreg->enabled)
>> +               return 0;
> 
> Does the "if" test above ever hit?  I'd think the regulator framework
> would handle this.

I'm not sure if it has ever been hit.  I can remove it.


>> +static int rpmh_regulator_vrm_set_voltage(struct regulator_dev *rdev,
>> +                               int min_uv, int max_uv, unsigned int *selector)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
>> +       };
>> +       const struct regulator_linear_range *range;
>> +       int mv, uv, ret;
>> +       bool wait_for_ack;
>> +
>> +       mv = DIV_ROUND_UP(min_uv, 1000);
>> +       uv = mv * 1000;
>> +       if (uv > max_uv) {
>> +               vreg_err(vreg, "no set points available in range %d-%d uV\n",
>> +                       min_uv, max_uv);
>> +               return -EINVAL;
>> +       }
>> +
>> +       range = vreg->hw_data->voltage_range;
>> +       *selector = DIV_ROUND_UP(uv - range->min_uV, range->uV_step);
> 
> It seems like you should remove the existing check you have for "if
> (uv > max_uv)" and replace with a check here.  Specifically, it seems
> like the DIV_ROUND_UP for the selector could also bump you over the
> max.  AKA:
> 
> ...
> bool wait_for_ack;
> 
> range = vreg->hw_data->voltage_range;
> *selector = DIV_ROUND_UP(min_uv - range->min_uV, range->uV_step);
> uv = *selector * range->uV_step + range->min_uV
> if (uv > max_uv) {
>   ...
> }

The VRM voltage vote register has units of mV (as does the voltage control
register for the PMIC regulators).  The PMIC hardware automatically rounds
up the mV requests to the next physically available set point.  This was
designed to simplify the life for software so that there isn't a need to
worry about voltage step size which varies between regulator types.

The intention of the mv check was to verify that what is being programmed
into VRM is within the requested min_uv-max_uv range.  However, since this
driver is forced to be aware of the step size, I can modify this as you
suggested with the stricter step-size bounding.


> Hold up, though.  Why don't you implement set_voltage_sel() instead of
> set_voltage()?  That's what literally everyone else does, well except
> PWM regulators.  Using that will get rid of most of this code, won't
> it?  Even the check to see if perhaps the voltage isn't changing.

There are two cases that I can think of: 1. Having a set_voltage()
callback allows for delaying for an RPMh request ACK during certain
voltage set point decreasing scenarios (to be elaborated below).  2.
Having a get_voltage() as opposed to get_voltage_sel() callback allows an
uninitialized voltage of 0 to be returned in the case that no initial
voltage is specified in device tree.  This eliminates the possibility of
the regulator framework short-circuiting a regulator_set_voltage() call
that happens to match the voltage corresponding to selector 0.


>> +
>> +       if (uv == vreg->voltage)
>> +               return 0;
>> +
>> +       wait_for_ack = uv > vreg->voltage || max_uv < vreg->voltage;
> 
> Do you often see "wait_for_ack = false" in reality?  Most regulator
> usage I've seen requests a fairly tight range.  AKA: I don't often
> see:
> 
>   set_voltage(min=3000mV, max=3300mV)
>   set_voltage(min=1800mV, max=3300mV)

I can't think of a good example off the top of my head.  However, this
situation is certainly valid and can arise any time that there is a shared
rail and the hardware connected to it has minimum voltage requirements per
use case but large maximum voltage allowed.

> Instead, I see:
> 
>   set_voltage(min=3000mV, max=3300mV)
>   set_voltage(min=1800mV, max=1900mV)
> 
> So you'll always have wait_for_ack = true in the cases I've seen.
> 
> ...but are you certain it's useful to wait for an ack anyway when the
> voltage is falling?  Most regulators won't guarantee that the voltage
> has actually fallen even after they ack you.  Specifically if a
> regulator is under light load and it doesn't have an active discharge
> circuit then the regulator might fall very slowly over time.  As a
> specific example, see commit 7c5209c315ea ("mmc: core: Increase delay
> for voltage to stabilize from 3.3V to 1.8V").

I'm aware of one important instance in which decreasing voltage needs a
delay: SD card voltage change from 3.3 V to 1.8 V.  This is the use case
that I had in mind with the 'max_uv < vreg->voltage' check.  However, you
are correct that hardware will report completion of the voltage slewing
early in this case since the comparator is checking for output >= set
point.  I can remove this special case check.


> That was a lot of words, so to sum it all up:
> 
> * If you have no actual examples where you see "wait_for_ack = false"
> then remove this code and always wait.
> 
> * If you have evidence that the time spent waiting for the ack is
> slowing you down, consider always setting wait_for_ack to false when
> you're lowering the voltage.  Anyone who truly cares could just set
> something like the device tree property
> regulator-settling-time-down-us.  ...or, assuming Mark doesn't hate
> it, they could set the always-wait-for-ack property in the device
> tree.

I'm ok with changing the logic so that it waits for an ACK when increasing
voltage (required for correctness) and does not wait for an ACK when
decreasing voltage.


> NOTE: I think you don't use VRMs for DVFS anyway (you use the fancy
> ARC things for this?), we're probably talking about a small handful of
> voltage transitions per boot, right?

VRM isn't used for CPU DVFS.  I haven't profiled the quantity of RPMh
regulator requests made during different use cases.


>> +static int rpmh_regulator_vrm_get_voltage(struct regulator_dev *rdev)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +
>> +       return vreg->voltage;
> 
> I guess there's no way to read the voltage at bootup?  So this will
> return 0 until someone sets it?  ...maybe less of a big deal due to
> the "qcom,regulator-initial-voltage" property?

Correct.  As mentioned above, there is no way to read the physical PMIC
regulator voltage from RPMh.  Yes, this will return 0 unless
qcom,regulator-initial-voltage is specified or the set_voltage() regulator
op is called.  Returning an invalid voltage of 0 uV here is convenient as
it ensures that there is no way to accidentally skip setting the voltage
due to returning the voltage of selector 0.


>> +static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
>> +                                       unsigned int mode)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
>> +       };
>> +       int i, ret;
>> +
>> +       if (mode == vreg->mode)
>> +               return 0;
>> +
>> +       for (i = 0; i < RPMH_REGULATOR_MODE_COUNT; i++)
>> +               if (vreg->hw_data->mode_map[i].framework_mode == mode)
>> +                       break;
>> +       if (i >= RPMH_REGULATOR_MODE_COUNT) {
>> +               vreg_err(vreg, "invalid mode=%u\n", mode);
>> +               return -EINVAL;
>> +       }
>> +
>> +       cmd.data = vreg->hw_data->mode_map[i].pmic_mode;
>> +
>> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1,
>> +                                         mode < vreg->mode || !vreg->mode);
> 
> Please explain the "mode < vreg->mode || !vreg->mode" test in words.

This waits for an ACK from RPMh of successfully mode transition when
switching to a higher power mode (regulator framework modes are ordered
with highest power == lowest numerical value) or when setting the first mode.


>> +static unsigned int rpmh_regulator_vrm_get_mode(struct regulator_dev *rdev)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +
>> +       return vreg->mode;
> 
> You'll probably guess that I'd expect you to read this from hardware.

As mentioned above, there is no way to read the physical PMIC regulator
mode from RPMh.


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
>> +       struct device_node *node = vreg->of_node;
>> +       const struct rpmh_regulator_mode *map;
>> +       const char *prop;
>> +       int i, len, ret;
>> +       u32 *buf;
>> +
>> +       map = vreg->hw_data->mode_map;
>> +       if (!map)
>> +               return 0;
>> +
>> +       /* qcom,allowed-modes is optional */
>> +       prop = "qcom,allowed-modes";
>> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
>> +       if (len < 0)
>> +               return 0;
> 
> Seems like it might be worth it to count
> "qcom,mode-threshold-currents" too and confirm the count is the same?
> If someone left in an extra threshold current you won't notice
> otherwise (right?)

Sure, I'll add a check for that.


>> +
>> +       vreg->mode_map = devm_kcalloc(vreg->pmic->dev, len,
>> +                               sizeof(*vreg->mode_map), GFP_KERNEL);
> 
> I keep getting myself confused because you have two things called
> "mode_map" and they work differently:
> 
> vreg->mode_map - contains 1 element per allowed mode.  Need to iterate
> through this to map "framework mode" to "pmic mode".  Note: because of
> the need to iterate this isn't really a "map" in my mind.
> 
> vreg->hw_data->mode_map - contains 1 element for each possible "device
> tree mode".  Index into this using "device tree mode" and you get both
> a "framework mode" and "pmic mode".

I agree that this is confusing.  I reused struct rpmh_regulator_mode for
both tables out of convenience.  I'll change this.


> IMHO it would be better to have a table like "dt_to_linux_mode" that
> was just a simple list:
> 
> static const int dt_to_linux_mode_bob[] = [
>  [RPMH_REGULATOR_MODE_PASS] = REGULATOR_MODE_STANDBY,
>  [RPMH_REGULATOR_MODE_RET] = -EINVAL,
>  [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
>  [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>  [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
> ];
> 
> static const int dt_to_linux_mode_ldo_smps[] =
>  [RPMH_REGULATOR_MODE_PASS] = -EINVAL,
>  [RPMH_REGULATOR_MODE_RET] = REGULATOR_MODE_STANDBY,
>  [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
>  [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>  [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
> ];
> 
> You'd only use that in the "map_mode" functions and when parsing
> qcom,allowed-modes.  ...and, in fact, parsing qcom,allowed-modes could
> actually just call the map_mode function.  This would be especially a
> good way to do this if you moved "allowed-modes" into the regulator
> core, which seems like a good idea.
> 
> The nice thing about this is that only place you need to conceptually
> keep track of RPMH_REGULATOR_MODE_XYZ is in the device tree parsing
> code.  Otherwise you just think of the Linux version.

I would be ok with defining arrays like these to handle the mapping of
PMIC regulator hardware agnostic "device tree mode" to "framework mode".
However, a second set of arrays would then be needed to map from
"framework mode" to hardware specific "pmic mode".  I suppose that having
the second array indexed by framework mode would make the code a little
simpler since iteration would not be needed.

Here is an explanation for why the "device tree mode" abstraction is
present in the first place.  Between different Qualcomm Technologies, Inc.
PMICs, regulators support a subset of the same modes (HPM/PWM, AUTO,
LPM/PFM, Retention, and pass-through).  However, the register values for
the same modes vary between different regulator types and different PMIC
families.  This patch is adding support for several PMIC4 family PMICs.
The values needed for to-be-released PMIC5 PMIC regulators are different.
As an example, here are the different values for LPM/PFM across PMIC
families and regulator types: PMIC4 LDO/SMPS = 5, PMIC4 BOB = 1, PMIC5
LDO/HFSMPS/BOB = 4, PMIC5 FTSMPS = N/A.  Having the "device tree mode"
ensures that it is not possible to inadvertently specify a PMIC specific
mode in device tree which corresponds to the wrong type or family but
which aliases a value that would be accepted as correct.


> Once you do the above, then your other list could just be named
> "allowed_modes".  This would make it obvious that this isn't a map
> itself but that you could iterate over it to accomplish a mapping.

I'm concerned with using the name "allowed_modes" as it tends to imply the
wrong idea.  Perhaps something along the lines of "drms_modes" would be
better (to go along with REGULATOR_CHANGE_DRMS).  These would be the modes
utilized by the set_load() callback along with corresponding threshold
load currents.


>> +/**
>> + * rpmh_regulator_allocate_vreg() - allocate space for the regulators associated
>> + *             with the PMIC and initialize important pointers for each
>> + *             regulator
>> + * @pmic:              Pointer to the RPMh regulator PMIC
>> + *
>> + * Return: 0 on success, errno on failure
>> + */
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
>> +
>> +       i = 0;
>> +       for_each_available_child_of_node(pmic->dev->of_node, node) {
>> +               pmic->vreg[i].of_node = node;
>> +               pmic->vreg[i].pmic = pmic;
>> +
>> +               i++;
>> +       }
> 
> While I can believe that things don't crash, you're not quite using
> for_each_available_child_of_node() correctly.  You need to reorganize
> your code structure to fix.  Specifically the "node" that's provided
> to each iteration only has its refcount held for each iteration.  By
> the end of your function the refcount of all the "of_node"s that you
> stored wil be 0.  Doh.
> 
> You could try to fix this by adding a of_node_get() before storing the
> node and that would work, but that would complicate your error
> handling.  You'll need to do this in a "cleanup" error path of probe
> and in remove.  :(
> 
> A better solution is to get rid of the rpmh_regulator_allocate_vreg()
> function and move the functionality into probe.  There, instead of
> iterating over pmic->vreg_count, just use the
> for_each_available_child_of_node() function.  If
> rpmh_regulator_init_vreg() you'll have to manually of_node_put() but
> that should be OK.
> 
> Why will that work?  You'll call rpmh_regulator_init_vreg() while the
> reference count is still held.  In that function you'll call
> devm_regulator_register(), which will grab the refcount if it needs
> it.  Since that's a devm_ function you can be sure that it will
> properly drop the refcount at the right times.
> 
> NOTE: with this you presumably should remove the "of_node" from the
> "struct rpmh_vreg".  It seems like it shouldn't be needed anymore and
> it's good not to keep the pointer around if you didn't call
> of_node_get() yourself.

I'll make this change.


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
>> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
>> +               if (!ret) {
>> +                       if (temp < RPMH_VRM_HEADROOM_MIN_UV ||
>> +                           temp > RPMH_VRM_HEADROOM_MAX_UV) {
>> +                               vreg_err(vreg, "%s=%u is invalid\n",
>> +                                       prop, temp);
>> +                               return -EINVAL;
>> +                       }
>> +                       vreg->headroom_voltage = temp;
>> +
>> +                       cmd[cmd_count].addr
>> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_HEADROOM;
>> +                       cmd[cmd_count++].data
>> +                               = DIV_ROUND_UP(vreg->headroom_voltage, 1000);
>> +               }
>> +
>> +               prop = "qcom,regulator-initial-voltage";
>> +               ret = of_property_read_u32(vreg->of_node, prop, &temp);
>> +               if (!ret) {
>> +                       if (temp < RPMH_VRM_MIN_UV || temp > RPMH_VRM_MAX_UV) {
>> +                               vreg_err(vreg, "%s=%u is invalid\n",
>> +                                       prop, temp);
>> +                               return -EINVAL;
>> +                       }
>> +                       vreg->voltage = temp;
>> +
>> +                       cmd[cmd_count].addr
>> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
>> +                       cmd[cmd_count++].data
>> +                               = DIV_ROUND_UP(vreg->voltage, 1000);
> 
> It seems like you should set vreg->voltage to the actual result of the
> division * 1000.  AKA: if the user said the initial voltage was
> 123,456 then vreg->voltage should become 124,000.

Sure, I'll change this.

> Actually, shouldn't you somehow resolve this with "struct
> rpmh_vreg_hw_data".  It seems like some regulators have 128 steps,
> some have 256 steps, etc.  You should have a function that reconciles
> the requested voltage with the one that hardware will actually
> provide.
> 
> ...and, actually, you should share code for this reconciliation with
> rpmh_regulator_vrm_set_voltage().

I'll see what I can do about this.


>> +/**
>> + * rpmh_regulator_init_vreg() - initialize all abbributes of an rpmh-regulator
>> + * @vreg:              Pointer to the RPMh regulator
>> + *
>> + * Return: 0 on success, errno on failure
>> + */
>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg)
>> +{
>> +       struct device *dev = vreg->pmic->dev;
>> +       struct regulator_config reg_config = {};
>> +       const struct rpmh_vreg_init_data *rpmh_data = NULL;
>> +       const char *type_name = NULL;
>> +       enum rpmh_regulator_type type;
>> +       struct regulator_init_data *init_data;
>> +       int ret, i;
>> +
>> +       for (i = 0; i < vreg->pmic->init_data->count; i++) {
>> +               if (!strcmp(vreg->pmic->init_data->vreg_data[i].name,
>> +                           vreg->of_node->name)) {
>> +                       rpmh_data = &vreg->pmic->init_data->vreg_data[i];
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (!rpmh_data) {
>> +               dev_err(dev, "Unknown regulator %s for %s RPMh regulator PMIC\n",
>> +                       vreg->of_node->name, vreg->pmic->init_data->name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       vreg->resource_name = devm_kasprintf(dev, GFP_KERNEL, "%s%s%d",
>> +                       rpmh_data->resource_name_base, vreg->pmic->pmic_id,
>> +                       rpmh_data->id);
>> +       if (!vreg->resource_name)
>> +               return -ENOMEM;
>> +
>> +       vreg->addr = cmd_db_read_addr(vreg->resource_name);
>> +       if (!vreg->addr) {
>> +               vreg_err(vreg, "could not find RPMh address for resource %s\n",
>> +                       vreg->resource_name);
>> +               return -ENODEV;
>> +       }
>> +
>> +       vreg->rdesc.name = rpmh_data->name;
>> +       vreg->rdesc.supply_name = rpmh_data->supply_name;
>> +       vreg->regulator_type = rpmh_data->regulator_type;
>> +       vreg->hw_data = rpmh_data->hw_data;
>> +
>> +       if (rpmh_data->hw_data->voltage_range) {
>> +               vreg->rdesc.linear_ranges = rpmh_data->hw_data->voltage_range;
>> +               vreg->rdesc.n_linear_ranges = 1;
>> +               vreg->rdesc.n_voltages = rpmh_data->hw_data->n_voltages;
>> +       }
>> +
>> +       /* Optional override for the default RPMh accelerator type */
>> +       ret = of_property_read_string(vreg->of_node, "qcom,rpmh-resource-type",
>> +                                       &type_name);
>> +       if (!ret) {
>> +               if (!strcmp("vrm", type_name)) {
>> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_VRM;
>> +               } else if (!strcmp("xob", type_name)) {
>> +                       vreg->regulator_type = RPMH_REGULATOR_TYPE_XOB;
>> +               } else {
>> +                       vreg_err(vreg, "Unknown RPMh accelerator type %s\n",
>> +                               type_name);
>> +                       return -EINVAL;
>> +               }
> 
> As per comment in device tree patch, it seems really weird that you
> can override this.  Are you sure?

Yes, we definitely need to have a board-specific mechanism to specify that
a regulator which could be handled via VRM must be handled via XOB on a
given board.  I explained this in more detail in [1].


>> +static const struct rpmh_regulator_mode
>> +rpmh_regulator_mode_map_pmic4_bob[RPMH_REGULATOR_MODE_COUNT] = {
>> +       [RPMH_REGULATOR_MODE_PASS] = {
>> +               .pmic_mode = 0,
>> +               .framework_mode = REGULATOR_MODE_STANDBY,
> 
> Is "PASS" truly the same concept as the Linux concept of STANDBY.  If
> so, why do you need a separate define for it?
> 
> If it truly is the same, it seems like you can simplify everything by
> just changing your defines.  Get rid of "RPMH_REGULATOR_MODE_RET" and
> "RPMH_REGULATOR_MODE_PASS" and just call it
> "RPMH_REGULATOR_MODE_STANDBY".  You can add comments saying that
> "standby" maps to "retention" for some regulators and maps to "pass"
> for other regulators if you want to map PMIC documentation.  ...but
> getting rid of this distinction simply means less error checking and
> fewer tables in Linux.
> 
> If "pass" really shouldn't map to "standby" then this seems like a
> hack and you should add the concept of "pass" to the core regulator
> framework.

For Qualcomm Technologies, Inc. PMIC regulators, retention mode (RET) is a
very low power mode which offers better power effeciency (i.e. lower
ground current) than low power mode (LPM) for low load scenarios with the
trade off of worse load regulator.  It is typically applied when the
system is asleep for regulators that must stay on but which have very low
and stable load.  Retention maps very well to REGULATOR_MODE_STANDBY.

Pass-through mode (PASS) a.k.a. bypass is supported by Qualcomm
Technologies, Inc. buck-or-boost regulators (BOB).  When PASS is selected,
the BOB output is directly connected to the BOB input (typically Vbat).
This does not map exactly to REGULATOR_MODE_STANDBY.  I agree that it is
somewhat hacky to use it in this way.  However, doing so makes
qcom_rpmh-regulator substantially simpler.  I suppose that BOB PASS mode
could be handled via get_bypass() and set_bypass() regulator ops.  Doing
this would require more complicated ops selections in the driver since it
could no longer be determined simply by VRM vs XOB, it would instead need
to be BOB VRM, other VRM, and XOB.  The BOB set_mode() and set_bypass()
callbacks would be complicated because both would be writing to the same
VRM address (mode control) with bypass==true taking precedence.
Additionally, there is currently no way to specify default bypass from DT.
 A BOB-specific property would be needed to get this information.


>> +static const struct rpmh_vreg_hw_data pmic4_pldo_hw_data = {
>> +       .voltage_range = &(const struct regulator_linear_range)
>> +                       REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
> 
> This seems pretty iffy to me.  You're relying on the compiler to make
> an anonymous chunk of memory with a "struct regulator_linear_range" in
> it and then storing a pointer to said anonymous chunk of memory?
> Nobody else using REGULATOR_LINEAR_RANGE() does this.

A similiar approach is used in qcom_smd-regulator.c [2]:

static const struct regulator_desc pm8941_nldo = {
	.linear_ranges = (struct regulator_linear_range[]) {
		REGULATOR_LINEAR_RANGE(750000, 0, 63, 12500),
	},
	.n_linear_ranges = 1,
	.n_voltages = 64,
	.ops = &rpm_smps_ldo_ops,
};

> Why not just get rid of the pointer and put the structure right inside
> "struct rpmh_vreg_hw_data"?  It'll get rid of the weird cast / strange
> anonymous chunk, save an indirection, and save 4 bytes for a pointer.

I'll make this change.


>> +/**
>> + * rpmh_regulator_probe() - probe an RPMh PMIC and register regulators for each
>> + *             of the regulator nodes associated with it
>> + * @pdev:              Pointer to the platform device of the RPMh PMIC
>> + *
>> + * Return: 0 on success, errno on failure
>> + */
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
>> +
>> +       ret = cmd_db_ready();
>> +       if (ret < 0) {
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
>> +       if (!pmic)
>> +               return -ENOMEM;
>> +
>> +       pmic->dev = dev;
>> +       platform_set_drvdata(pdev, pmic);
>> +
>> +       pmic->rpmh_client = rpmh_get_client(pdev);
> 
> It seems like you'd do yourself (and the other clients of rpmh) a
> favor if you added a devm_rpmh_get_client() in a patch before this
> one.  Adding a devm version of a calls is pretty easy and you'll be
> able to completely get rid of your "remove" function.  ...and get rid
> of the "cleanup" exit here.

Lina, could you please add this to your rpmh patch series since it is
still undergoing review? [3]


>> +static struct platform_driver rpmh_regulator_driver = {
>> +       .driver         = {
>> +               .name           = "qcom-rpmh-regulator",
>> +               .of_match_table = rpmh_regulator_match_table,
>> +               .owner          = THIS_MODULE,
> 
> As per the robot, no need to set .owner here. The core will do it.

I'll remove this.


>> +       },
>> +       .probe          = rpmh_regulator_probe,
>> +       .remove         = rpmh_regulator_remove,
>> +};
>> +
>> +static int rpmh_regulator_init(void)
>> +{
>> +       return platform_driver_register(&rpmh_regulator_driver);
>> +}
>> +
>> +static void rpmh_regulator_exit(void)
>> +{
>> +       platform_driver_unregister(&rpmh_regulator_driver);
>> +}
>> +
>> +arch_initcall(rpmh_regulator_init);
> 
> I always get yelled at when I try to use arch_initcall() for stuff
> like this.  You should do what everyone else does and use
> module_platform_driver() to declare your driver.  Yeah, regulators are
> important and (as I remember) they get probed slightly early anyway,
> but everything else in the system just gotta deal with the fact that
> they'll sometimes get deferred probes.

I agree that consumers should handle probe deferral.  Unfortunately,
reality isn't always so nice.  Also, probe deferrals increase boot-up time
which is particularly problematic in the mobile space.  I suppose that I
can change this to module_platform_driver() for now.  If any major issues
arise it could be changed back to arch_initcall().

Note that both qcom_rpm-regulator.c and qcom_smd-regulator.c are using
subsys_initcall() right now in place of module_platform_driver().


>> +module_exit(rpmh_regulator_exit);
>> +
>> +MODULE_DESCRIPTION("Qualcomm RPMh regulator driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
>> new file mode 100644
>> index 0000000..f854e0e
>> --- /dev/null
>> +++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
> 
> Device tree guys will yell at you here.  The "include/dt-bindings"
> bits are supposed to be together with the bindings.  Different
> maintainers have different beliefs here, but I think the way that's
> least likely to get you yelled at by the most people is:
> 
> Patch #1: bindings (.txt and include file)
> Patch #2: the driver
> 
> ...with the idea being that if another operating system wanted just
> the bindings they could get it all in one patch.

I'll move the header into the DT patch of my series.


>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
>> +
>> +#ifndef __QCOM_RPMH_REGULATOR_H
>> +#define __QCOM_RPMH_REGULATOR_H
>> +
>> +/*
>> + * These mode constants may be used for qcom,allowed-modes and qcom,init-mode
> 
> Not "qcom,init-mode".  This is actually "regulator-initial-mode" now.

I'll correct this.

Take care,
David

[1]: https://lkml.org/lkml/2018/3/21/877
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/qcom_smd-regulator.c?h=v4.16-rc6#n252
[3]: https://lkml.org/lkml/2018/3/9/979

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
