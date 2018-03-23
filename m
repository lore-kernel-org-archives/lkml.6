Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCWUAy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 16:00:54 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:45417 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752119AbeCWUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 16:00:51 -0400
X-Google-Smtp-Source: AG47ELsvWfCCqODgcDFMbQP7jNpXRtTI7TUjt8u1qG5nTaUvjYb1nP1KmPLf4+wrvAcXLv7ZQDM6mgv1ULgCth1cHkw=
MIME-Version: 1.0
In-Reply-To: <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org> <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com> <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Mar 2018 13:00:47 -0700
X-Google-Sender-Auth: 3XTSUrQ_fnk6uJMydWGGdkXHzsY
Message-ID: <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        ilina@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2018 at 3:31 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> +static int rpmh_regulator_is_enabled(struct regulator_dev *rdev)
>>> +{
>>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>>> +
>>> +       return vreg->enabled;
>>
>> You can't read hardware?  The regulator framework expects you to read
>> hardware.  If it was common not to be able to read hardware then the
>> regulator framework would just keep track of the enabled state for
>> you.  Right now if a regulator was left on by the BIOS (presumably
>> some have to be since otherwise you're running on a computer that
>> takes no power), you'll still return false at bootup?  Seems
>> non-ideal.
>
> Correct, the RPMh interface provides no mechanism to poll the physical
> PMIC regulator hardware state.
>
> However, that isn't entirely a bad thing due to the nature of RPMh
> regulator control.  Several processors within the SoC besides the
> application processor are able to vote on the state of PMIC regulators via
> RPMh.  The VRM and XOB RPMh hardware blocks perform max aggregation across
> votes from different processors for each votable quantity for a given
> regulator (enable, voltage, mode, and headroom voltage for VRM; enable for
> XOB).  The aggregated values are then configured in the PMIC regulator via
> SPMI transactions.
>
> If Linux could read the physical PMIC regulator state and report it back
> via is_enabled(), get_voltage() and get_mode() regulator ops, then we
> could get into situations where the applications processor fails to vote
> on a regulator which is requested by a Linux consumer.  For example, say
> that the modem processor has requested a given regulator to be enabled via
> RPMh.  Later, a Linux consumer driver on the application processor calls
> regulator_enable() for the regulator.  The regulator framework will call
> the is_enabled() callback which will return true.  This would then
> short-circuit the regulator_enable() call and skip calling the
> rpmh-regulator enable() callback.  This means that the application
> processor would have no enable vote present within RPMh for the regulator.
>  If the modem processor then voted to disable the regulator, it would
> physically be disabled even though a consumer on the application processor
> expects it to stay enabled.

How about if I say it another way: can you read the vote that the boot
code (pre-Linux) might have left for this regulator?  ...if the boot
code didn't init it, then I guess you could return 0, but if it did it
would be nice to report it.

AKA: I understand your concerns about other (non-AP) users.  I just
want to read the state that the BIOS left us in.


>>> +static int rpmh_regulator_vrm_set_voltage(struct regulator_dev *rdev,
>>> +                               int min_uv, int max_uv, unsigned int *selector)
>>> +{
>>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>>> +       struct tcs_cmd cmd = {
>>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
>>> +       };
>>> +       const struct regulator_linear_range *range;
>>> +       int mv, uv, ret;
>>> +       bool wait_for_ack;
>>> +
>>> +       mv = DIV_ROUND_UP(min_uv, 1000);
>>> +       uv = mv * 1000;
>>> +       if (uv > max_uv) {
>>> +               vreg_err(vreg, "no set points available in range %d-%d uV\n",
>>> +                       min_uv, max_uv);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       range = vreg->hw_data->voltage_range;
>>> +       *selector = DIV_ROUND_UP(uv - range->min_uV, range->uV_step);
>>
>> It seems like you should remove the existing check you have for "if
>> (uv > max_uv)" and replace with a check here.  Specifically, it seems
>> like the DIV_ROUND_UP for the selector could also bump you over the
>> max.  AKA:
>>
>> ...
>> bool wait_for_ack;
>>
>> range = vreg->hw_data->voltage_range;
>> *selector = DIV_ROUND_UP(min_uv - range->min_uV, range->uV_step);
>> uv = *selector * range->uV_step + range->min_uV
>> if (uv > max_uv) {
>>   ...
>> }
>
> The VRM voltage vote register has units of mV (as does the voltage control
> register for the PMIC regulators).  The PMIC hardware automatically rounds
> up the mV requests to the next physically available set point.  This was
> designed to simplify the life for software so that there isn't a need to
> worry about voltage step size which varies between regulator types.
>
> The intention of the mv check was to verify that what is being programmed
> into VRM is within the requested min_uv-max_uv range.  However, since this
> driver is forced to be aware of the step size, I can modify this as you
> suggested with the stricter step-size bounding.
>
>
>> Hold up, though.  Why don't you implement set_voltage_sel() instead of
>> set_voltage()?  That's what literally everyone else does, well except
>> PWM regulators.  Using that will get rid of most of this code, won't
>> it?  Even the check to see if perhaps the voltage isn't changing.
>
> There are two cases that I can think of: 1. Having a set_voltage()
> callback allows for delaying for an RPMh request ACK during certain
> voltage set point decreasing scenarios (to be elaborated below).

Can't you still have a delay in set_voltage_sel()?


> 2.
> Having a get_voltage() as opposed to get_voltage_sel() callback allows an
> uninitialized voltage of 0 to be returned in the case that no initial
> voltage is specified in device tree.  This eliminates the possibility of
> the regulator framework short-circuiting a regulator_set_voltage() call
> that happens to match the voltage corresponding to selector 0.

Interesting.  I suppose you could mix them (have set_voltage_sel() and
get_voltage()) as long as you documented why you were doing it.  Then
we'd have to see if Mark was happy with that...


>>> +
>>> +       if (uv == vreg->voltage)
>>> +               return 0;
>>> +
>>> +       wait_for_ack = uv > vreg->voltage || max_uv < vreg->voltage;
>>
>> Do you often see "wait_for_ack = false" in reality?  Most regulator
>> usage I've seen requests a fairly tight range.  AKA: I don't often
>> see:
>>
>>   set_voltage(min=3000mV, max=3300mV)
>>   set_voltage(min=1800mV, max=3300mV)
>
> I can't think of a good example off the top of my head.  However, this
> situation is certainly valid and can arise any time that there is a shared
> rail and the hardware connected to it has minimum voltage requirements per
> use case but large maximum voltage allowed.

Yup.  I'm not saying it's not allowed, it's just not something I've
come across so far.  ...but (assuming I read the code correctly) this
is the only case your "wait_for_ack" was optimizing for.  I don't mind
having the optimization if it's needed, I just don't want it if there
are no known users.


>> Instead, I see:
>>
>>   set_voltage(min=3000mV, max=3300mV)
>>   set_voltage(min=1800mV, max=1900mV)
>>
>> So you'll always have wait_for_ack = true in the cases I've seen.
>>
>> ...but are you certain it's useful to wait for an ack anyway when the
>> voltage is falling?  Most regulators won't guarantee that the voltage
>> has actually fallen even after they ack you.  Specifically if a
>> regulator is under light load and it doesn't have an active discharge
>> circuit then the regulator might fall very slowly over time.  As a
>> specific example, see commit 7c5209c315ea ("mmc: core: Increase delay
>> for voltage to stabilize from 3.3V to 1.8V").
>
> I'm aware of one important instance in which decreasing voltage needs a
> delay: SD card voltage change from 3.3 V to 1.8 V.  This is the use case
> that I had in mind with the 'max_uv < vreg->voltage' check.  However, you
> are correct that hardware will report completion of the voltage slewing
> early in this case since the comparator is checking for output >= set
> point.  I can remove this special case check.
>
>
>> That was a lot of words, so to sum it all up:
>>
>> * If you have no actual examples where you see "wait_for_ack = false"
>> then remove this code and always wait.
>>
>> * If you have evidence that the time spent waiting for the ack is
>> slowing you down, consider always setting wait_for_ack to false when
>> you're lowering the voltage.  Anyone who truly cares could just set
>> something like the device tree property
>> regulator-settling-time-down-us.  ...or, assuming Mark doesn't hate
>> it, they could set the always-wait-for-ack property in the device
>> tree.
>
> I'm ok with changing the logic so that it waits for an ACK when increasing
> voltage (required for correctness) and does not wait for an ACK when
> decreasing voltage.

Sounds fine with me.  You could even add a comment saying that waiting
for an Ack when falling isn't so useful unless the line has some sort
of active discharge.  You've already got a device tree feature for
this, so it would be a good to document it there too.

We'll also have to see if Mark wants this to be more generic in some
way.  It seems that other regulators could benefit from this type of
knowledge and it would be nice if drivers could specify this and have
it work on all PMICs.


>> NOTE: I think you don't use VRMs for DVFS anyway (you use the fancy
>> ARC things for this?), we're probably talking about a small handful of
>> voltage transitions per boot, right?
>
> VRM isn't used for CPU DVFS.  I haven't profiled the quantity of RPMh
> regulator requests made during different use cases.
>
>
>>> +static int rpmh_regulator_vrm_get_voltage(struct regulator_dev *rdev)
>>> +{
>>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>>> +
>>> +       return vreg->voltage;
>>
>> I guess there's no way to read the voltage at bootup?  So this will
>> return 0 until someone sets it?  ...maybe less of a big deal due to
>> the "qcom,regulator-initial-voltage" property?
>
> Correct.  As mentioned above, there is no way to read the physical PMIC
> regulator voltage from RPMh.  Yes, this will return 0 unless
> qcom,regulator-initial-voltage is specified or the set_voltage() regulator
> op is called.  Returning an invalid voltage of 0 uV here is convenient as
> it ensures that there is no way to accidentally skip setting the voltage
> due to returning the voltage of selector 0.

I actually wonder if it would be wiser to return an error code if you
try to read a regulator that has never been set.


>>> +static int rpmh_regulator_vrm_set_mode(struct regulator_dev *rdev,
>>> +                                       unsigned int mode)
>>> +{
>>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>>> +       struct tcs_cmd cmd = {
>>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
>>> +       };
>>> +       int i, ret;
>>> +
>>> +       if (mode == vreg->mode)
>>> +               return 0;
>>> +
>>> +       for (i = 0; i < RPMH_REGULATOR_MODE_COUNT; i++)
>>> +               if (vreg->hw_data->mode_map[i].framework_mode == mode)
>>> +                       break;
>>> +       if (i >= RPMH_REGULATOR_MODE_COUNT) {
>>> +               vreg_err(vreg, "invalid mode=%u\n", mode);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       cmd.data = vreg->hw_data->mode_map[i].pmic_mode;
>>> +
>>> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1,
>>> +                                         mode < vreg->mode || !vreg->mode);
>>
>> Please explain the "mode < vreg->mode || !vreg->mode" test in words.
>
> This waits for an ACK from RPMh of successfully mode transition when
> switching to a higher power mode (regulator framework modes are ordered
> with highest power == lowest numerical value) or when setting the first mode.

Sorry, I meant: please add this explanation to comments in the function.


>> IMHO it would be better to have a table like "dt_to_linux_mode" that
>> was just a simple list:
>>
>> static const int dt_to_linux_mode_bob[] = [
>>  [RPMH_REGULATOR_MODE_PASS] = REGULATOR_MODE_STANDBY,
>>  [RPMH_REGULATOR_MODE_RET] = -EINVAL,
>>  [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
>>  [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>>  [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
>> ];
>>
>> static const int dt_to_linux_mode_ldo_smps[] =
>>  [RPMH_REGULATOR_MODE_PASS] = -EINVAL,
>>  [RPMH_REGULATOR_MODE_RET] = REGULATOR_MODE_STANDBY,
>>  [RPMH_REGULATOR_MODE_LPM] = REGULATOR_MODE_IDLE,
>>  [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>>  [RPMH_REGULATOR_MODE_HPM] = REGULATOR_MODE_FAST
>> ];
>>
>> You'd only use that in the "map_mode" functions and when parsing
>> qcom,allowed-modes.  ...and, in fact, parsing qcom,allowed-modes could
>> actually just call the map_mode function.  This would be especially a
>> good way to do this if you moved "allowed-modes" into the regulator
>> core, which seems like a good idea.
>>
>> The nice thing about this is that only place you need to conceptually
>> keep track of RPMH_REGULATOR_MODE_XYZ is in the device tree parsing
>> code.  Otherwise you just think of the Linux version.
>
> I would be ok with defining arrays like these to handle the mapping of
> PMIC regulator hardware agnostic "device tree mode" to "framework mode".
> However, a second set of arrays would then be needed to map from
> "framework mode" to hardware specific "pmic mode".  I suppose that having
> the second array indexed by framework mode would make the code a little
> simpler since iteration would not be needed.

Yeah, I was thinking that with 2 arrays the code would be more obvious.


> Here is an explanation for why the "device tree mode" abstraction is
> present in the first place.  Between different Qualcomm Technologies, Inc.
> PMICs, regulators support a subset of the same modes (HPM/PWM, AUTO,
> LPM/PFM, Retention, and pass-through).  However, the register values for
> the same modes vary between different regulator types and different PMIC
> families.  This patch is adding support for several PMIC4 family PMICs.
> The values needed for to-be-released PMIC5 PMIC regulators are different.
> As an example, here are the different values for LPM/PFM across PMIC
> families and regulator types: PMIC4 LDO/SMPS = 5, PMIC4 BOB = 1, PMIC5
> LDO/HFSMPS/BOB = 4, PMIC5 FTSMPS = N/A.  Having the "device tree mode"
> ensures that it is not possible to inadvertently specify a PMIC specific
> mode in device tree which corresponds to the wrong type or family but
> which aliases a value that would be accepted as correct.

I'm OK with having the "device tree mode" abstraction, and in fact the
current regulator framework seems to want you to have this anyway.  If
I read the code correctly, you're required to have the conversion
function and there's no default.


>> Once you do the above, then your other list could just be named
>> "allowed_modes".  This would make it obvious that this isn't a map
>> itself but that you could iterate over it to accomplish a mapping.
>
> I'm concerned with using the name "allowed_modes" as it tends to imply the
> wrong idea.  Perhaps something along the lines of "drms_modes" would be
> better (to go along with REGULATOR_CHANGE_DRMS).  These would be the modes
> utilized by the set_load() callback along with corresponding threshold
> load currents.

Yeah, that name is OK by me.  At least I can lookup in the header file
to find out that DRMS means "Dynamic Regulator Mode Switching".  :)


>>> +static const struct rpmh_regulator_mode
>>> +rpmh_regulator_mode_map_pmic4_bob[RPMH_REGULATOR_MODE_COUNT] = {
>>> +       [RPMH_REGULATOR_MODE_PASS] = {
>>> +               .pmic_mode = 0,
>>> +               .framework_mode = REGULATOR_MODE_STANDBY,
>>
>> Is "PASS" truly the same concept as the Linux concept of STANDBY.  If
>> so, why do you need a separate define for it?
>>
>> If it truly is the same, it seems like you can simplify everything by
>> just changing your defines.  Get rid of "RPMH_REGULATOR_MODE_RET" and
>> "RPMH_REGULATOR_MODE_PASS" and just call it
>> "RPMH_REGULATOR_MODE_STANDBY".  You can add comments saying that
>> "standby" maps to "retention" for some regulators and maps to "pass"
>> for other regulators if you want to map PMIC documentation.  ...but
>> getting rid of this distinction simply means less error checking and
>> fewer tables in Linux.
>>
>> If "pass" really shouldn't map to "standby" then this seems like a
>> hack and you should add the concept of "pass" to the core regulator
>> framework.
>
> For Qualcomm Technologies, Inc. PMIC regulators, retention mode (RET) is a
> very low power mode which offers better power effeciency (i.e. lower
> ground current) than low power mode (LPM) for low load scenarios with the
> trade off of worse load regulator.  It is typically applied when the
> system is asleep for regulators that must stay on but which have very low
> and stable load.  Retention maps very well to REGULATOR_MODE_STANDBY.

Yup, this seems like a perfect mapping between the Qualcomm mode and
the regulator framework.


> Pass-through mode (PASS) a.k.a. bypass is supported by Qualcomm
> Technologies, Inc. buck-or-boost regulators (BOB).  When PASS is selected,
> the BOB output is directly connected to the BOB input (typically Vbat).
> This does not map exactly to REGULATOR_MODE_STANDBY.  I agree that it is
> somewhat hacky to use it in this way.  However, doing so makes
> qcom_rpmh-regulator substantially simpler.  I suppose that BOB PASS mode
> could be handled via get_bypass() and set_bypass() regulator ops.  Doing
> this would require more complicated ops selections in the driver since it
> could no longer be determined simply by VRM vs XOB, it would instead need
> to be BOB VRM, other VRM, and XOB.  The BOB set_mode() and set_bypass()
> callbacks would be complicated because both would be writing to the same
> VRM address (mode control) with bypass==true taking precedence.
> Additionally, there is currently no way to specify default bypass from DT.
>  A BOB-specific property would be needed to get this information.

I've never poked at the get_bypass() / set_bypass(), but it sounds
better to me to use them.  I'm not a fan of the current hack.  Even
aside from the bit of hackiness, I'm slightly concerned that some of
your logic that generally assumes lower integers = lower power modes
would break.

For instance in rpmh_regulator_vrm_set_mode() switching to "PASS"
would look like you're switching to a low power mode so you'd skip the
"wait for ack", right?  I could sorta imagine things getting confused
when trying to specify the mA load and having it switch modes
automatically.


I'd also notice that "regulator/qcom_spmi-regulator.c" seems to be
using get_bypass() / set_bypass(), so maybe qcom-related clients will
expect this?


>>> +       },
>>> +       .probe          = rpmh_regulator_probe,
>>> +       .remove         = rpmh_regulator_remove,
>>> +};
>>> +
>>> +static int rpmh_regulator_init(void)
>>> +{
>>> +       return platform_driver_register(&rpmh_regulator_driver);
>>> +}
>>> +
>>> +static void rpmh_regulator_exit(void)
>>> +{
>>> +       platform_driver_unregister(&rpmh_regulator_driver);
>>> +}
>>> +
>>> +arch_initcall(rpmh_regulator_init);
>>
>> I always get yelled at when I try to use arch_initcall() for stuff
>> like this.  You should do what everyone else does and use
>> module_platform_driver() to declare your driver.  Yeah, regulators are
>> important and (as I remember) they get probed slightly early anyway,
>> but everything else in the system just gotta deal with the fact that
>> they'll sometimes get deferred probes.
>
> I agree that consumers should handle probe deferral.  Unfortunately,
> reality isn't always so nice.  Also, probe deferrals increase boot-up time
> which is particularly problematic in the mobile space.

Sigh, yeah.  I'm not a fan either.  If you can convince Mark that you
should use arch_initcall() or subsys_initcall() I won't yell.  ...but
in the past I've seen others get yelled at.

Note: in actuality it doesn't always increase boot time a whole lot.
In theory as long as the CPU is running full bore and you're not
killing parallelism too much then the only "waste" is the bit of time
to run the start of the probe.  It's not much.  Every time someone
claims "but my boot is slow because of deferrals" others say "where is
the evidence?" and I don't remember a whole lot of evidence being
presented.  Maybe you have evidence?

...but deferrals _do_ for sure increase the time for certain
peripherals to come up, and if those peripherals are things like the
LCD displays then it sucks.


> I suppose that I
> can change this to module_platform_driver() for now.  If any major issues
> arise it could be changed back to arch_initcall().

Probably wise.


> Note that both qcom_rpm-regulator.c and qcom_smd-regulator.c are using
> subsys_initcall() right now in place of module_platform_driver().

Yeah, I've made the argument before and been told "they are grandfathered in."


-Doug
