Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeDSQQn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:16:43 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:33969 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753527AbeDSQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:16:41 -0400
X-Google-Smtp-Source: AIpwx481rWOyF503hN7TJahaSQ+s3Lqe0mZSxbCYg6DPlVOOVIKmMed/NCfDnMJhMWnWgiVWwJTNe79OUVwnPDRNMMA=
MIME-Version: 1.0
In-Reply-To: <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org> <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com> <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 19 Apr 2018 09:16:38 -0700
X-Google-Sender-Auth: QjW0kJDAsvOLUzZWcuRkstGm10U
Message-ID: <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 18, 2018 at 4:30 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> + * @drms_mode:                 Array of regulator framework modes which can
>>> + *                             be configured dynamically for this regulator
>>> + *                             via the set_load() callback.
>>
>> Using the singular for something that is an array is confusing.  Why
>> not "drms_modes" or "drms_mode_arr"?  In the past review you said
>> 'Perhaps something along the lines of "drms_modes"'.
>
> It seems awkward to me to use a plural for arrays as it leads to indexing
> like this: vreg->drms_modes[i].  "mode i" seems better than "modes i".
> However, I'm willing to change this to be drms_modes and drms_mode_max_uAs
> if that style is preferred.

I'd very much like a plural here.


>>> +static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
>>> +                                       unsigned int mode, bool bypassed)
>>> +{
>>> +       struct tcs_cmd cmd = {
>>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
>>> +       };
>>
>> Please add:
>>
>> if (mode & ~(REGULATOR_MODE_STANDBY |
>>      REGULATOR_MODE_IDLE |
>>      REGULATOR_MODE_NORMAL |
>>      REGULATOR_MODE_FAST))
>>   return -EINVAL;
>>
>> That way if someone adds a new mode you don't index off the end of
>> your array.  Ah, I see, you have this in rpmh_regulator_vrm_set_mode
>> by checking if mode > REGULATOR_MODE_STANDBY.  That works.  Can you
>> move it here so it's closer to where the array access is?
>
> Theoretically, the (mode > REGULATOR_MODE_STANDBY) check in
> rpmh_regulator_vrm_set_mode() shouldn't be necessary at all.  I felt safer
> leaving it in though.  The framework ensures that no mode values may be
> passed into rpmh_regulator_vrm_set_mode() which is not identified in
> constraints.valid_modes_mask.  Similar sanitization happens for internal
> rpmh_regulator_vrm_set_mode() calls.
>
> I'll move the (mode > REGULATOR_MODE_STANDBY) check into
> rpmh_regulator_vrm_set_mode_bypass().

Ah, good point about the valid_modes_mask!  I'm happy with moving the
test here.  I wouldn't mind a comment saying that the check is
probably overkill because the framework already checks
valid_modes_mask but shouldn't hurt.


>>> +
>>> +       return rpmh_regulator_vrm_set_mode(rdev, vreg->drms_mode[i]);
>>
>> Might not hurt to have a comment saying that this calls
>> rpmh_regulator_vrm_set_mode() instead of calling
>> rpmh_regulator_vrm_set_mode_bypass() directly because this is supposed
>> to change the mode returned by a future call to get_mode().
>
> This seems pretty clear on inspection of the very closely spaced
> functions.  I don't see the need for a comment about it.

It wasn't clear to me--I thought it might have just been because you
didn't want to manually pass in the current bypass state.  Then I
looked at the function and thought there might have been a bug because
it was saving the mode.  Then I looked back at the regulator framework
and finally came to the conclusion that set_load() is supposed to
change the mode (AKA: you'd expect that calling get_mode() after
set_load() would show you the mode you ended up at).

I guess this is all perhaps obvious to any regulator framework
experts, but since I spent 5 minutes digging through all that it
seemed like it deserved a comment to save the next person the 5
minutes.  ...but I won't insist.


>>> +static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
>>> +                               bool *enable)
>>> +{
>>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>>> +
>>> +       *enable = vreg->bypassed;
>>> +
>>> +       return 0;
>>
>> Should you return an error code if nobody has ever called set_bypass?
>> ...or is it OK to just return "not bypassed"?  Please document this in
>> the code.
>
> I think it is fine to return "not bypassed" by default if there is no
> configuration in place to enable bypassing.  How are you suggesting that
> this be documented in the code?

I guess I wish the function had comments and then it could be
documented there.  ...but none of the functions in this file do...

I guess you're right that it's clear enough without a comment, so
let's just leave it as is.


>>> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
>>> +                               struct device *dev, struct device_node *node)
>>> +{
>>> +       const char *prop;
>>> +       int i, len, ret, mode;
>>> +       u32 *buf;
>>> +
>>> +       /* qcom,allowed-drms-modes is optional */
>>> +       prop = "qcom,allowed-drms-modes";
>>> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
>>> +       if (len < 0)
>>> +               return 0;
>>> +
>>> +       vreg->drms_mode = devm_kcalloc(dev, len, sizeof(*vreg->drms_mode),
>>> +                                       GFP_KERNEL);
>>> +       vreg->drms_mode_max_uA = devm_kcalloc(dev, len,
>>> +                                  sizeof(*vreg->drms_mode_max_uA), GFP_KERNEL);
>>> +       if (!vreg->drms_mode || !vreg->drms_mode_max_uA)
>>> +               return -ENOMEM;
>>> +       vreg->drms_mode_count = len;
>>> +
>>> +       buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
>>> +       if (!buf)
>>> +               return -ENOMEM;
>>> +
>>> +       ret = of_property_read_u32_array(node, prop, buf, len);
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "%s: unable to read %s, ret=%d\n",
>>> +                       node->name, prop, ret);
>>> +               goto done;
>>> +       }
>>> +
>>> +       for (i = 0; i < len; i++) {
>>> +               mode = vreg->hw_data->of_map_mode(buf[i]);
>>> +               if (mode <= 0) {
>>
>> Should be < 0, not <= 0 right?  Unless we take Javier's suggestion
>> (see <https://patchwork.kernel.org/patch/10346081/>) and make 0 be
>> invalid...
>
> It looks like the way forward is REGULATOR_MODE_INVALID == 0 so '<= 0' is
> fine here.  I suppose that it could be changed to '==
> REGULATOR_MODE_INVALID' as well.

Yes, assuming my patch lands using "==" is better.  Checking whether
an unsigned value is <= 0 is confusing.


>>> +               prop = "qcom,regulator-initial-voltage";
>>> +               ret = of_property_read_u32(node, prop, &uV);
>>> +               if (!ret) {
>>> +                       range = &vreg->hw_data->voltage_range;
>>> +                       selector = DIV_ROUND_UP(uV - range->min_uV,
>>> +                                       range->uV_step) + range->min_sel;
>>> +                       if (uV < range->min_uV || selector > range->max_sel) {
>>> +                               dev_err(dev, "%s: %s=%u is invalid\n",
>>> +                                       node->name, prop, uV);
>>> +                               return -EINVAL;
>>> +                       }
>>> +
>>> +                       vreg->voltage_selector = selector;
>>> +
>>> +                       cmd[cmd_count].addr
>>> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
>>> +                       cmd[cmd_count++].data
>>> +                               = DIV_ROUND_UP(selector * range->uV_step
>>> +                                               + range->min_uV, 1000);
>>> +               }
>>
>> Seems like you want an "else { vreg->voltage_selector = -EINVAL; }".
>> Otherwise "get_voltage_sel" will return selector 0 before the first
>> set, right?
>>
>> Previously Mark said: "If the driver can't read values it should
>> return an appropriate error code."
>> ...and previously you said: "I'll try this out and see if the
>> regulator framework complains during regulator registration."
>
> I tested out what happens when vreg->voltage_selector = -EINVAL is set
> when qcom,regulator-initial-voltage is not present.  This results in
> devm_regulator_register() failing and subsequently causing the
> qcom_rpmh-regulator probe to fail.  The error happens in
> machine_constraints_voltage() [1].
>
> This leaves two courses of action:
> 1. (current patch set) allow voltage_selector to stay 0 if uninitialized
> 2. Set voltage_selector = -EINVAL by default and specify in DT binding
> documentation that qcom,regulator-initial-voltage is required for VRM
> managed RPMh regulator resources which have regulator-min-microvolt and
> regulator-max-microvolt specified.
>
> Are you ok with the DT implications of option #2?

You'd need to ask Mark if he's OK with it, but a option #3 is to add a
patch to your series fix the regulator framework to try setting the
voltage if _regulator_get_voltage() fails.  Presumably in
machine_constraints_voltage() you'd now do something like:

  int target_min, target_max;
  int current_uV = _regulator_get_voltage(rdev);
  if (current_uV < 0) {
    /* Maybe this regulator's hardware can't be read and needs to be initted */
    _regulator_do_set_voltage(
      rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
    current_uV = _regulator_get_voltage(rdev);
  }
  if (current_uV < 0) {
    rdev_err(rdev,
      "failed to get the current voltage(%d)\n",
      current_uV);
      return current_uV;
  }

If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
but this needs to be documented _somewhere_ (unlike for bypass it's
not obvious, so you need to find someplace to put it).  I'd rather not
hack the DT to deal with our software limitations.


>>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>>> +                               struct device_node *node, const char *pmic_id,
>>> +                               const struct rpmh_vreg_init_data *rpmh_data)
>>> +{
>>> +       struct regulator_config reg_config = {};
>>> +       char rpmh_resource_name[20] = "";
>>> +       struct regulator_dev *rdev;
>>> +       enum rpmh_regulator_type type;
>>> +       struct regulator_init_data *init_data;
>>> +       unsigned int mode;
>>> +       int i, ret;
>>> +
>>> +       for (; rpmh_data->name; rpmh_data++)
>>> +               if (!strcmp(rpmh_data->name, node->name))
>>> +                       break;
>>> +
>>> +       if (!rpmh_data->name) {
>>> +               dev_err(dev, "Unknown regulator %s\n", node->name);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
>>> +               rpmh_data->resource_name, pmic_id);
>>
>> If the resulting string is exactly 20 characters then
>> rpmh_resource_name won't be zero terminated.  Please handle this
>> properly.
>
> The output of scnprintf() is always null-terminated; therefore, no other
> check is needed.  Also, RPMh resource names stored in SMEM command DB data
> structure are at most 8 bytes (<= 7 char + '\0' or 8 char and no '\0') so
> using 20 chars in the buffer is overkill anyway.

Wow, not sure where I looked to see that scnprintf() didn't always
null-terminate.  Sorry.  Ignore this.


>>> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
>>
>> I may have suggested using this as an array that could be used as a
>> "map" (index by regulator framework mode and get the PMIC mode), but
>> now that I see it it doesn't seem super appealing since the regulator
>> framework mode is not 0, 1, 2, 3 but is actually 1, 2, 4, 8.  ...but I
>> guess it's not too bad--you're allocating 9 ints to map 4 elements and
>> I guess that's about as efficient as you're going to get even if it
>> feels a bit ugly.
>
> I'm ok with the sparse mapping as it makes indexing as simple as possible
> and the extra space used is insignificant.
>
>
>> ...but still a few improvements:
>>
>> * Don't specify the size of the array as "REGULATOR_MODE_STANDBY + 1".
>> Let the compiler handle this.  It should do the right thing.  Then if
>> someone ever changes the order of the #defines things will just work,
>> I think.
>>
>> * Make sure that users of these arrays check that the mode is one of
>> the mode you know about.  That way if someone does add a new mode you
>> don't index off your array.  I'll put a comment in the user.
>
> Even if a new mode was added, the relative ordering of the existing modes
> should not change and valid_modes_mask will only allow modes currently
> supported by the driver.  I'd like to keep the bound checks as simple as
> possible.  By explicitly sizing the arrays and then only checking for mode
>> REGULATOR_MODE_STANDBY when indexing into the array we can be sure that
> no out-of-bound access can ever occur.  Also, if one of the existing mode
> value was made larger than REGULATOR_MODE_STANDBY it would be easy to
> catch as it would cause a compilation error.
>
> Thus, I'd prefer to keep the array sizing and index checking as-in unless
> there is a major objection.

OK.


>>> +static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
>>> +{
>>> +       static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>>> +               [RPMH_REGULATOR_MODE_RET]  = -EINVAL,
>>> +               [RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>>> +               [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>>> +               [RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>>> +       };
>>
>> You're sticking a negative value in an array of unsigned inits.  Here
>> and in other similar functions.
>>
>> I know, I know.  The function is defined to return an unsigned int.
>> It's wrong.  of_regulator.c clearly puts the return code in a signed
>> int.  First attempt at fixing this is at
>> <https://patchwork.kernel.org/patch/10346081/>.
>
> I can change the error cases to use REGULATOR_MODE_INVALID which is added
> by this change still under review [2].

I haven't seen Mark NAK it (yet), so for lack of a better option I'd
start using it in your patch and document in the commit message that
it depends on my patch.


>>> +static const struct rpmh_vreg_hw_data pmic4_bob = {
>>> +       .regulator_type = VRM,
>>> +       .ops = &rpmh_regulator_vrm_bypass_ops,
>>> +       .voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
>>> +       .n_voltages = 84,
>>> +       .pmic_mode_map = pmic_mode_map_pmic4_bob,
>>> +       .of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
>>> +       .bypass_mode = 0,
>>
>> Remove .bypass_mode from the structure and just change
>> rpmh_regulator_vrm_set_mode_bypass() to set 0 if we're in bypass.
>> Right now 100% of PMICs that support bypass use 0 as the bypass mode.
>> If you ever have a future PMIC that uses a non-zero mode for bypass
>> then we can always add this back.  ...and if no future PMICs ever use
>> a non-zero bypass mode then we don't need the complexity of having
>> another field in this struct.
>>
>> If you don't do this you might get arguments from some people saying
>> that they don't like seeing inits of "= 0" in static structures (Linux
>> conventions seem to like you to just assume that structs are
>> zero-initted).
>
> Upcoming PMICs use 2 for bypass mode instead of 0.  That is why I left
> this in.  I suppose that I can remove this member for now and add it back
> in when newer PMIC support is added.

I'm OK with keeping it as long as there is a real user coming up.
IMHO with the #defines as suggested by Matthias this will look better
anyway (it will be more obvious that this isn't a boolean, for
instance).


>>> +cleanup:
>>> +       rpmh_release(rpmh_client);
>>
>> Still no devm_rpmh_get_client()?  If Lina is too busy spinning her
>> patch series for other stuff, just add it to RPMH as a patch in your
>> series.  I believe it's just this (untested):
>>
>> ---
>>
>> int devm_rpmh_release(struct device *dev, void *res)
>> {
>>   struct platform_device *pdev = to_platform_device(dev);
>>   rpmh_release(pdev);
>> }
>>
>> int devm_rpmh_get_client(struct device *dev)
>> {
>>   struct platform_device *pdev = to_platform_device(dev);
>>   void *dr;
>>   int rc;
>>
>>   dr = devres_alloc(devm_rpmh_release, 0, GFP_KERNEL);
>>   if (!dr)
>>     return -ENOMEM;
>>
>>   rc = rpmh_get_client(pdev);
>>   if (!rc)
>>     devres_add(dev, dr);
>>   else
>>     devres_free(dr);
>>
>>   return rc;
>> }
>>
>> ---
>>
>> Note that you'll get rid of the error handling in probe, the whole
>> remove function, and the need to do platform_set_drvdata().
>
> My understanding is that Lina is going to remove both rpmh_get_client()
> and rpmh_release().  In their place, rpmh functions will use the consumer
> device pointer as a handle and manage any necessary state internally [3].
> I'll update this patch once she uploads a new series with this interface
> modification.

OK, sounds good.  Information like this is nice to include somewhere
in the cover letter or the patch description so it's more obvious that
you wouldn't want this patch to land until that's sorted out.


-Doug
