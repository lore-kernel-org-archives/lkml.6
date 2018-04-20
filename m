Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeDTWJE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:09:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60766 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeDTWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:09:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32A7260310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: Doug Anderson <dianders@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
Date: Fri, 20 Apr 2018 15:08:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 09:16 AM, Doug Anderson wrote:
> On Wed, Apr 18, 2018 at 4:30 PM, David Collins <collinsd@codeaurora.org> wrote:
>>>> + * @drms_mode:                 Array of regulator framework modes which can
>>>> + *                             be configured dynamically for this regulator
>>>> + *                             via the set_load() callback.
>>>
>>> Using the singular for something that is an array is confusing.  Why
>>> not "drms_modes" or "drms_mode_arr"?  In the past review you said
>>> 'Perhaps something along the lines of "drms_modes"'.
>>
>> It seems awkward to me to use a plural for arrays as it leads to indexing
>> like this: vreg->drms_modes[i].  "mode i" seems better than "modes i".
>> However, I'm willing to change this to be drms_modes and drms_mode_max_uAs
>> if that style is preferred.
> 
> I'd very much like a plural here.

Ok.  I'll change this to be plural.


>>>> +               prop = "qcom,regulator-initial-voltage";
>>>> +               ret = of_property_read_u32(node, prop, &uV);
>>>> +               if (!ret) {
>>>> +                       range = &vreg->hw_data->voltage_range;
>>>> +                       selector = DIV_ROUND_UP(uV - range->min_uV,
>>>> +                                       range->uV_step) + range->min_sel;
>>>> +                       if (uV < range->min_uV || selector > range->max_sel) {
>>>> +                               dev_err(dev, "%s: %s=%u is invalid\n",
>>>> +                                       node->name, prop, uV);
>>>> +                               return -EINVAL;
>>>> +                       }
>>>> +
>>>> +                       vreg->voltage_selector = selector;
>>>> +
>>>> +                       cmd[cmd_count].addr
>>>> +                               = vreg->addr + RPMH_REGULATOR_REG_VRM_VOLTAGE;
>>>> +                       cmd[cmd_count++].data
>>>> +                               = DIV_ROUND_UP(selector * range->uV_step
>>>> +                                               + range->min_uV, 1000);
>>>> +               }
>>>
>>> Seems like you want an "else { vreg->voltage_selector = -EINVAL; }".
>>> Otherwise "get_voltage_sel" will return selector 0 before the first
>>> set, right?
>>>
>>> Previously Mark said: "If the driver can't read values it should
>>> return an appropriate error code."
>>> ...and previously you said: "I'll try this out and see if the
>>> regulator framework complains during regulator registration."
>>
>> I tested out what happens when vreg->voltage_selector = -EINVAL is set
>> when qcom,regulator-initial-voltage is not present.  This results in
>> devm_regulator_register() failing and subsequently causing the
>> qcom_rpmh-regulator probe to fail.  The error happens in
>> machine_constraints_voltage() [1].
>>
>> This leaves two courses of action:
>> 1. (current patch set) allow voltage_selector to stay 0 if uninitialized
>> 2. Set voltage_selector = -EINVAL by default and specify in DT binding
>> documentation that qcom,regulator-initial-voltage is required for VRM
>> managed RPMh regulator resources which have regulator-min-microvolt and
>> regulator-max-microvolt specified.
>>
>> Are you ok with the DT implications of option #2?
> 
> You'd need to ask Mark if he's OK with it, but a option #3 is to add a
> patch to your series fix the regulator framework to try setting the
> voltage if _regulator_get_voltage() fails.  Presumably in
> machine_constraints_voltage() you'd now do something like:
> 
>   int target_min, target_max;
>   int current_uV = _regulator_get_voltage(rdev);
>   if (current_uV < 0) {
>     /* Maybe this regulator's hardware can't be read and needs to be initted */
>     _regulator_do_set_voltage(
>       rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
>     current_uV = _regulator_get_voltage(rdev);
>   }
>   if (current_uV < 0) {
>     rdev_err(rdev,
>       "failed to get the current voltage(%d)\n",
>       current_uV);
>       return current_uV;
>   }
> 
> If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
> but this needs to be documented _somewhere_ (unlike for bypass it's
> not obvious, so you need to find someplace to put it).  I'd rather not
> hack the DT to deal with our software limitations.

I'm not opposed to your option #3 though it does seem a little hacky and
tailored to the qcom_rpmh-regulator specific case.  Note that I think it
would be better to vote for min_uV to max_uV than min_uV to min_uV though.

Mark, what are your thoughts on the best way to handle this situation?


>>>> +static unsigned int rpmh_regulator_pmic4_bob_of_map_mode(unsigned int mode)
>>>> +{
>>>> +       static const unsigned int of_mode_map[RPMH_REGULATOR_MODE_COUNT] = {
>>>> +               [RPMH_REGULATOR_MODE_RET]  = -EINVAL,
>>>> +               [RPMH_REGULATOR_MODE_LPM]  = REGULATOR_MODE_IDLE,
>>>> +               [RPMH_REGULATOR_MODE_AUTO] = REGULATOR_MODE_NORMAL,
>>>> +               [RPMH_REGULATOR_MODE_HPM]  = REGULATOR_MODE_FAST,
>>>> +       };
>>>
>>> You're sticking a negative value in an array of unsigned inits.  Here
>>> and in other similar functions.
>>>
>>> I know, I know.  The function is defined to return an unsigned int.
>>> It's wrong.  of_regulator.c clearly puts the return code in a signed
>>> int.  First attempt at fixing this is at
>>> <https://patchwork.kernel.org/patch/10346081/>.
>>
>> I can change the error cases to use REGULATOR_MODE_INVALID which is added
>> by this change still under review [2].
> 
> I haven't seen Mark NAK it (yet), so for lack of a better option I'd
> start using it in your patch and document in the commit message that
> it depends on my patch.

Your patch was accepted.  I'll switch to using REGULATOR_MODE_INVALID.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
