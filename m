Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDRXad (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:30:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeDRXaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:30:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C9666030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
Date: Wed, 18 Apr 2018 16:30:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 01:02 PM, Doug Anderson wrote:
> On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
>> +#define RPMH_REGULATOR_DISABLE                 0x0
>> +#define RPMH_REGULATOR_ENABLE                  0x1
> 
> In the last version Stephen said he didn't like the above two #defines
> and you said you'd remove them, yet they are still here.  Explanation?

I thought that he was referring to the comments above the constants since
his review comment was immediately following the second of two comments as
opposed to these constants.  I'll let him follow-up on this point if
necessary.


>> + * @drms_mode:                 Array of regulator framework modes which can
>> + *                             be configured dynamically for this regulator
>> + *                             via the set_load() callback.
> 
> Using the singular for something that is an array is confusing.  Why
> not "drms_modes" or "drms_mode_arr"?  In the past review you said
> 'Perhaps something along the lines of "drms_modes"'.

It seems awkward to me to use a plural for arrays as it leads to indexing
like this: vreg->drms_modes[i].  "mode i" seems better than "modes i".
However, I'm willing to change this to be drms_modes and drms_mode_max_uAs
if that style is preferred.


>> +struct rpmh_vreg {
>> +       struct rpmh_client              *rpmh_client;
>> +       u32                             addr;
>> +       struct regulator_desc           rdesc;
>> +       const struct rpmh_vreg_hw_data  *hw_data;
>> +       enum rpmh_regulator_type        regulator_type;
>> +       bool                            always_wait_for_ack;
>> +       unsigned int                    *drms_mode;
>> +       int                             *drms_mode_max_uA;
>> +       size_t                          drms_mode_count;
>> +
>> +       bool                            enabled;
>> +       int                             voltage_selector;
>> +       unsigned int                    mode;
>> +       bool                            bypassed;
> 
> nit: stick next to "enabled" to make slightly better structure packing...

Ok


>> +static int rpmh_regulator_vrm_set_voltage_sel(struct regulator_dev *rdev,
>> +                               unsigned int selector)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE,
>> +       };
>> +       int ret;
>> +
>> +       /* VRM voltage control register is set with voltage in millivolts. */
>> +       cmd.data = DIV_ROUND_UP(regulator_list_voltage_linear_range(rdev,
>> +                                                       selector), 1000);
>> +
>> +       ret = rpmh_regulator_send_request(vreg, &cmd, 1,
>> +                                         selector > vreg->voltage_selector);
> 
> If you init vreg->voltage_selector to an error as I suggest in
> rpmh_regulator_load_default_parameters() you'll need to handle it
> here.  See below.

Ok


>> +static int rpmh_regulator_vrm_set_mode_bypass(struct rpmh_vreg *vreg,
>> +                                       unsigned int mode, bool bypassed)
>> +{
>> +       struct tcs_cmd cmd = {
>> +               .addr = vreg->addr + RPMH_REGULATOR_REG_VRM_MODE,
>> +       };
> 
> Please add:
> 
> if (mode & ~(REGULATOR_MODE_STANDBY |
>      REGULATOR_MODE_IDLE |
>      REGULATOR_MODE_NORMAL |
>      REGULATOR_MODE_FAST))
>   return -EINVAL;
> 
> That way if someone adds a new mode you don't index off the end of
> your array.  Ah, I see, you have this in rpmh_regulator_vrm_set_mode
> by checking if mode > REGULATOR_MODE_STANDBY.  That works.  Can you
> move it here so it's closer to where the array access is?

Theoretically, the (mode > REGULATOR_MODE_STANDBY) check in
rpmh_regulator_vrm_set_mode() shouldn't be necessary at all.  I felt safer
leaving it in though.  The framework ensures that no mode values may be
passed into rpmh_regulator_vrm_set_mode() which is not identified in
constraints.valid_modes_mask.  Similar sanitization happens for internal
rpmh_regulator_vrm_set_mode() calls.

I'll move the (mode > REGULATOR_MODE_STANDBY) check into
rpmh_regulator_vrm_set_mode_bypass().


>> +static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       int i;
>> +
>> +       for (i = 0; i < vreg->drms_mode_count - 1; i++)
>> +               if (load_uA < vreg->drms_mode_max_uA[i])
>> +                       break;
> 
> Can you put a warning here if the requested load_uA is larger than the
> largest supported, and/or perhaps consider it an error case?

I'll add a warning.


>> +
>> +       return rpmh_regulator_vrm_set_mode(rdev, vreg->drms_mode[i]);
> 
> Might not hurt to have a comment saying that this calls
> rpmh_regulator_vrm_set_mode() instead of calling
> rpmh_regulator_vrm_set_mode_bypass() directly because this is supposed
> to change the mode returned by a future call to get_mode().

This seems pretty clear on inspection of the very closely spaced
functions.  I don't see the need for a comment about it.


>> +static int rpmh_regulator_vrm_set_bypass(struct regulator_dev *rdev,
>> +                               bool enable)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +       int ret;
>> +
>> +       if (vreg->bypassed == enable)
>> +               return 0;
> 
> Just like for enable, remove this check.  The regulator core does it for you.

Ok


>> +static int rpmh_regulator_vrm_get_bypass(struct regulator_dev *rdev,
>> +                               bool *enable)
>> +{
>> +       struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
>> +
>> +       *enable = vreg->bypassed;
>> +
>> +       return 0;
> 
> Should you return an error code if nobody has ever called set_bypass?
> ...or is it OK to just return "not bypassed"?  Please document this in
> the code.

I think it is fine to return "not bypassed" by default if there is no
configuration in place to enable bypassing.  How are you suggesting that
this be documented in the code?


>> +static int rpmh_regulator_parse_vrm_modes(struct rpmh_vreg *vreg,
>> +                               struct device *dev, struct device_node *node)
>> +{
>> +       const char *prop;
>> +       int i, len, ret, mode;
>> +       u32 *buf;
>> +
>> +       /* qcom,allowed-drms-modes is optional */
>> +       prop = "qcom,allowed-drms-modes";
>> +       len = of_property_count_elems_of_size(node, prop, sizeof(u32));
>> +       if (len < 0)
>> +               return 0;
>> +
>> +       vreg->drms_mode = devm_kcalloc(dev, len, sizeof(*vreg->drms_mode),
>> +                                       GFP_KERNEL);
>> +       vreg->drms_mode_max_uA = devm_kcalloc(dev, len,
>> +                                  sizeof(*vreg->drms_mode_max_uA), GFP_KERNEL);
>> +       if (!vreg->drms_mode || !vreg->drms_mode_max_uA)
>> +               return -ENOMEM;
>> +       vreg->drms_mode_count = len;
>> +
>> +       buf = kcalloc(len, sizeof(*buf), GFP_KERNEL);
>> +       if (!buf)
>> +               return -ENOMEM;
>> +
>> +       ret = of_property_read_u32_array(node, prop, buf, len);
>> +       if (ret < 0) {
>> +               dev_err(dev, "%s: unable to read %s, ret=%d\n",
>> +                       node->name, prop, ret);
>> +               goto done;
>> +       }
>> +
>> +       for (i = 0; i < len; i++) {
>> +               mode = vreg->hw_data->of_map_mode(buf[i]);
>> +               if (mode <= 0) {
> 
> Should be < 0, not <= 0 right?  Unless we take Javier's suggestion
> (see <https://patchwork.kernel.org/patch/10346081/>) and make 0 be
> invalid...

It looks like the way forward is REGULATOR_MODE_INVALID == 0 so '<= 0' is
fine here.  I suppose that it could be changed to '==
REGULATOR_MODE_INVALID' as well.


>> +               prop = "qcom,regulator-initial-voltage";
>> +               ret = of_property_read_u32(node, prop, &uV);
>> +               if (!ret) {
>> +                       range = &vreg->hw_data->voltage_range;
>> +                       selector = DIV_ROUND_UP(uV - range->min_uV,
>> +                                       range->uV_step) + range->min_sel;
>> +                       if (uV < range->min_uV || selector > range->max_sel) {
>> +                               dev_err(dev, "%s: %s=%u is invalid\n",
>> +                                       node->name, prop, uV);
>> +                               return -EINVAL;
>> +                       }
>> +
>> +                       vreg->voltage_selector = selector;
>> +
>> +                       cmd[cmd_count].addr
>> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
>> +                       cmd[cmd_count++].data
>> +                               = DIV_ROUND_UP(selector * range->uV_step
>> +                                               + range->min_uV, 1000);
>> +               }
> 
> Seems like you want an "else { vreg->voltage_selector = -EINVAL; }".
> Otherwise "get_voltage_sel" will return selector 0 before the first
> set, right?
> 
> Previously Mark said: "If the driver can't read values it should
> return an appropriate error code."
> ...and previously you said: "I'll try this out and see if the
> regulator framework complains during regulator registration."

I tested out what happens when vreg->voltage_selector = -EINVAL is set
when qcom,regulator-initial-voltage is not present.  This results in
devm_regulator_register() failing and subsequently causing the
qcom_rpmh-regulator probe to fail.  The error happens in
machine_constraints_voltage() [1].

This leaves two courses of action:
1. (current patch set) allow voltage_selector to stay 0 if uninitialized
2. Set voltage_selector = -EINVAL by default and specify in DT binding
documentation that qcom,regulator-initial-voltage is required for VRM
managed RPMh regulator resources which have regulator-min-microvolt and
regulator-max-microvolt specified.

Are you ok with the DT implications of option #2?


>> +static int rpmh_regulator_init_vreg(struct rpmh_vreg *vreg, struct device *dev,
>> +                               struct device_node *node, const char *pmic_id,
>> +                               const struct rpmh_vreg_init_data *rpmh_data)
>> +{
>> +       struct regulator_config reg_config = {};
>> +       char rpmh_resource_name[20] = "";
>> +       struct regulator_dev *rdev;
>> +       enum rpmh_regulator_type type;
>> +       struct regulator_init_data *init_data;
>> +       unsigned int mode;
>> +       int i, ret;
>> +
>> +       for (; rpmh_data->name; rpmh_data++)
>> +               if (!strcmp(rpmh_data->name, node->name))
>> +                       break;
>> +
>> +       if (!rpmh_data->name) {
>> +               dev_err(dev, "Unknown regulator %s\n", node->name);
>> +               return -EINVAL;
>> +       }
>> +
>> +       scnprintf(rpmh_resource_name, sizeof(rpmh_resource_name),
>> +               rpmh_data->resource_name, pmic_id);
> 
> If the resulting string is exactly 20 characters then
> rpmh_resource_name won't be zero terminated.  Please handle this
> properly.

The output of scnprintf() is always null-terminated; therefore, no other
check is needed.  Also, RPMh resource names stored in SMEM command DB data
structure are at most 8 bytes (<= 7 char + '\0' or 8 char and no '\0') so
using 20 chars in the buffer is overkill anyway.


>> +static const u32 pmic_mode_map_pmic4_ldo[REGULATOR_MODE_STANDBY + 1] = {
> 
> I may have suggested using this as an array that could be used as a
> "map" (index by regulator framework mode and get the PMIC mode), but
> now that I see it it doesn't seem super appealing since the regulator
> framework mode is not 0, 1, 2, 3 but is actually 1, 2, 4, 8.  ...but I
> guess it's not too bad--you're allocating 9 ints to map 4 elements and
> I guess that's about as efficient as you're going to get even if it
> feels a bit ugly.

I'm ok with the sparse mapping as it makes indexing as simple as possible
and the extra space used is insignificant.


> ...but still a few improvements:
> 
> * Don't specify the size of the array as "REGULATOR_MODE_STANDBY + 1".
> Let the compiler handle this.  It should do the right thing.  Then if
> someone ever changes the order of the #defines things will just work,
> I think.
> 
> * Make sure that users of these arrays check that the mode is one of
> the mode you know about.  That way if someone does add a new mode you
> don't index off your array.  I'll put a comment in the user.

Even if a new mode was added, the relative ordering of the existing modes
should not change and valid_modes_mask will only allow modes currently
supported by the driver.  I'd like to keep the bound checks as simple as
possible.  By explicitly sizing the arrays and then only checking for mode
> REGULATOR_MODE_STANDBY when indexing into the array we can be sure that
no out-of-bound access can ever occur.  Also, if one of the existing mode
value was made larger than REGULATOR_MODE_STANDBY it would be easy to
catch as it would cause a compilation error.

Thus, I'd prefer to keep the array sizing and index checking as-in unless
there is a major objection.


> Also: the type of this array is 'u32' but you're assigning -EINVAL in
> some cases.  Please fix to be signed.  Here and on other similar
> arrays.

Ok.


>> +static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
>> +{
>> +       static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>> +               [RPMH_REGULATOR_MODE_RET]  = -EINVAL,
>> +               [RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>> +               [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>> +               [RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>> +       };
> 
> You're sticking a negative value in an array of unsigned inits.  Here
> and in other similar functions.
> 
> I know, I know.  The function is defined to return an unsigned int.
> It's wrong.  of_regulator.c clearly puts the return code in a signed
> int.  First attempt at fixing this is at
> <https://patchwork.kernel.org/patch/10346081/>.

I can change the error cases to use REGULATOR_MODE_INVALID which is added
by this change still under review [2].


>> +static const struct rpmh_vreg_hw_data pmic4_bob = {
>> +       .regulator_type = VRM,
>> +       .ops = &rpmh_regulator_vrm_bypass_ops,
>> +       .voltage_range = REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
>> +       .n_voltages = 84,
>> +       .pmic_mode_map = pmic_mode_map_pmic4_bob,
>> +       .of_map_mode = rpmh_regulator_pmic4_bob_of_map_mode,
>> +       .bypass_mode = 0,
> 
> Remove .bypass_mode from the structure and just change
> rpmh_regulator_vrm_set_mode_bypass() to set 0 if we're in bypass.
> Right now 100% of PMICs that support bypass use 0 as the bypass mode.
> If you ever have a future PMIC that uses a non-zero mode for bypass
> then we can always add this back.  ...and if no future PMICs ever use
> a non-zero bypass mode then we don't need the complexity of having
> another field in this struct.
> 
> If you don't do this you might get arguments from some people saying
> that they don't like seeing inits of "= 0" in static structures (Linux
> conventions seem to like you to just assume that structs are
> zero-initted).

Upcoming PMICs use 2 for bypass mode instead of 0.  That is why I left
this in.  I suppose that I can remove this member for now and add it back
in when newer PMIC support is added.


>> +static int rpmh_regulator_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       const struct rpmh_vreg_init_data *vreg_data;
>> +       struct rpmh_client *rpmh_client;
>> +       struct device_node *node;
>> +       struct rpmh_vreg *vreg;
>> +       const char *pmic_id;
>> +       int ret;
>> +
>> +       ret = cmd_db_ready();
>> +       if (ret < 0) {
>> +               if (ret != -EPROBE_DEFER)
>> +                       dev_err(dev, "Command DB not available, ret=%d\n", ret);
>> +               return ret;
>> +       }
> 
> In the last patch Stephen said:
> 
>> We should just make rpmh parent device call cmd_db_ready() so that these
>> devices aren't even populated until then and so that cmd_db_ready() is
>> only in one place. Lina?
> 
> Any news here?

I don't think that Lina has tried to include this in her rpmh series yet.


>> +cleanup:
>> +       rpmh_release(rpmh_client);
> 
> Still no devm_rpmh_get_client()?  If Lina is too busy spinning her
> patch series for other stuff, just add it to RPMH as a patch in your
> series.  I believe it's just this (untested):
> 
> ---
> 
> int devm_rpmh_release(struct device *dev, void *res)
> {
>   struct platform_device *pdev = to_platform_device(dev);
>   rpmh_release(pdev);
> }
> 
> int devm_rpmh_get_client(struct device *dev)
> {
>   struct platform_device *pdev = to_platform_device(dev);
>   void *dr;
>   int rc;
> 
>   dr = devres_alloc(devm_rpmh_release, 0, GFP_KERNEL);
>   if (!dr)
>     return -ENOMEM;
> 
>   rc = rpmh_get_client(pdev);
>   if (!rc)
>     devres_add(dev, dr);
>   else
>     devres_free(dr);
> 
>   return rc;
> }
> 
> ---
> 
> Note that you'll get rid of the error handling in probe, the whole
> remove function, and the need to do platform_set_drvdata().

My understanding is that Lina is going to remove both rpmh_get_client()
and rpmh_release().  In their place, rpmh functions will use the consumer
device pointer as a handle and manage any necessary state internally [3].
I'll update this patch once she uploads a new series with this interface
modification.

Thanks,
David

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/core.c?h=v4.17-rc1#n888
[2]: https://patchwork.kernel.org/patch/10348631/
[3]: https://lkml.org/lkml/2018/4/10/1273

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
