Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeESAqh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:46:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeESAqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:46:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A744760392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
To: Doug Anderson <dianders@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <cover.1526088081.git.collinsd@codeaurora.org>
 <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org>
 <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
Date: Fri, 18 May 2018 17:46:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/2018 06:01 PM, Doug Anderson wrote:
> On Thu, May 17, 2018 at 5:16 PM, David Collins <collinsd@codeaurora.org> wrote:
>> On 05/17/2018 02:22 PM, Doug Anderson wrote:
>>> On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
>>>> +- qcom,regulator-initial-microvolt
>>>> +       Usage:      optional; VRM regulators only
>>>> +       Value type: <u32>
>>>> +       Definition: Specifies the initial voltage in microvolts to request for a
>>>> +                   VRM regulator.
>>>
>>> Now that Mark has landed the patch adding support for the
>>> -ENOTRECOVERABLE error code from get_voltage() / get_voltage_sel(), do
>>> we still need the qcom,regulator-initial-microvolt property?
>>
>> Yes, this is still needed.  The -ENOTRECOVERABLE patch ensures that
>> qcom-rpmh-regulator devices can be registered even if
>> qcom,regulator-initial-microvolt is not specified.  However, that will
>> result in the regulators being configured for the minimum voltage
>> supported in the DT specified min/max range.  The
>> qcom,regulator-initial-microvolt property allows us to set a specific
>> voltage that is larger than the min constraint.
> 
> Ah, OK.  In the device tree fragment I saw the initial was always
> equal to the min, so I wasn't sure if this was really needed in
> practice.  I presume it would only be important if a voltage was left
> high by the bootloader for some peripheral that needs to continue to
> function (and use the existing higher voltage) until a real device
> claims it.  For all other voltages, it should be fine if it's set to
> the min until a real device claims it.  Do you have real examples of
> devices like this in boards using sdm845?

Something to keep in mind about the downstream rpmh-regulator driver is
that it caches the initial voltages specified in device tree and only
sends them after a consumer driver makes a regulator framework call.  This
saves time during boot and ensures that requests are not made for
regulators that no Linux consumer cares about.

It is generally not safe to request all regulators to be set to the
minimum allowed voltage.  Special care will be needed with the upstream
qcom-rpmh-regulator driver to avoid disrupting the boot up state of
regulators that are needed by other subsystems.  Therefore, I would like
to keep the initial voltage feature supported.


>>>> +- regulator-initial-mode
>>>> +       Usage:      optional; VRM regulators only
>>>> +       Value type: <u32>
>>>> +       Definition: Specifies the initial mode to request for a VRM regulator.
>>>> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
>>>> +                   in [1] (i.e. 0 to 3).  This property may be specified even
>>>> +                   if the regulator-allow-set-load property is not specified.
>>>
>>> Every time I read the above I wonder why you're documenting a standard
>>> regulator regulator property in your bindings.  ...then I realize it's
>>> because you're doing it because you want to explicitly document what
>>> the valid modes are.  I wonder if it makes sense to just put a
>>> reference somewhere else in this document to go look at the header
>>> file where these are all nicely documented.
>>
>> Isn't that what the [1] in the above snippet is currently doing.  Further
>> down in qcom,rpmh-regulator.txt is this line:
>>
>> +[1] include/dt-bindings/regulator/qcom,rpmh-regulator.h
> 
> Right, but I want to move it so it doesn't look like you're defining a
> property that's already defined in the common bindings.  AKA get rid
> of the "regulator-initial-mode" property description.  Then add above
> Examples:
> 
> ========================
> Regulator Modes
> ========================
> 
> RPMh regulators are designed to work with the standard regulator mode
> bindings, using properties like "regulator-initial-mode".  See
> include/dt-bindings/regulator/qcom,rpmh-regulator.h for information on
> the modes relevant to RPMh regulators.
> 
> Some RPMh regulators (BOB regulators only) also support bypass using
> the standard "regulator-allow-bypass" binding.
> 
> 
> ...feel fee to reword, but basically the idea is to document it but
> not make it look like you're defining a novel property.

Ok, I'll try rewording the mode explanation and move it into another
section of the binding doc.


>>> Speaking of documenting things like that, it might be worth finding
>>> somewhere in this doc to mention that the "bob" regulator on PMI8998
>>> can support "regulator-allow-bypass".  That tidbit got lost when we
>>> moved to the standard regulator bindings for bypass.
>>
>> I suppose that I could add something like this:
>>
>> +- regulator-allow-bypass
>> +       Usage:      optional; BOB type VRM regulators only
>> +       Value type: <empty>
>> +       Definition: See [2] for details.
>> ...
>> +[2]: Documentation/devicetree/bindings/regulator.txt
>>
>> However, I don't want the patch to get NACKed because it is defining a
>> property that is already defined in the common regulator.txt file.
> 
> See above for my suggestion.

Ok.


>>>> +- qcom,allowed-drms-modes
>>>> +       Usage:      required if regulator-allow-set-load is specified;
>>>> +                   VRM regulators only
>>>> +       Value type: <prop-encoded-array>
>>>> +       Definition: A list of integers specifying the PMIC regulator modes which
>>>> +                   can be configured at runtime based upon consumer load needs.
>>>> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
>>>> +                   in [1] (i.e. 0 to 3).
>>>
>>> Why is this still here?  You moved it to the core regulator framework,
>>> right?  It's still in your examples too.  Shouldn't this be removed?
>>> It looks like the driver still needs this and it needs to be an exact
>>> duplicate of the common binding.  That doesn't seem right...
>>
>> The qcom,allowed-drms-modes property supports a different feature than the
>> regulator-allowed-modes property accepted in [2].  The latter specifies
>> the modes that may be used at all (e.g. in regulator_set_mode() calls) and
>> it lists the mode values in an unordered fashion.
>>
>> qcom,allowed-drms-modes defines a specific subset of the possible allowed
>> modes that should be set based on DRMS (e.g. in regulator_set_load()
>> calls).  Its values are listed in a specific order and must match 1-to-1
>> with qcom,drms-mode-max-microamps entries.
>>
>> It would probably be good to change the name of the property from
>> qcom,allowed-drms-modes to qcom,regulator-drms-modes.
> 
> Ah, I see.  It's unfortunate that now we need to effectively list all
> modes twice.  Have you seen real-life examples where these sets of
> modes need to be different, or is this just theoretical?  If not can
> we start with one property (that controls both things) and if we
> really see that we need to specify different sets of modes for the two
> cases we can add a separate property?  ...actually, even if you do
> have real-life examples of where these need to be different, if 90% of
> the time they are the same it would still be nice to just have one
> property apply to both cases.

I plan to keep qcom,regulator-drms-modes (and
qcom,drms-mode-max-microamps) around as a property specifically handled
for qcom-rpmh-regulator.  It serves a purpose that is distinct from that
of the generic regulator-allowed-modes.  Without it, there will not be a
way to utilize regulator_set_load() to configure the regulator modes.


>>>> +- qcom,drms-mode-max-microamps
>>>> +       Usage:      required if regulator-allow-set-load is specified;
>>>> +                   VRM regulators only
>>>> +       Value type: <prop-encoded-array>
>>>> +       Definition: A list of integers specifying the maximum allowed load
>>>> +                   current in microamps for each of the modes listed in
>>>> +                   qcom,allowed-drms-modes (matched 1-to-1 in order).  Elements
>>>> +                   must be specified in order from lowest to highest value.
>>>
>>> Any reason this can't go into the regulator core?  You'd basically
>>> just take the existing concept of rpmh_regulator_vrm_set_load() and
>>> put it in the core.
>>
>> This could be implemented in the core via new constraint elements parsed
>> in of_regulator and a helper function to specify in regulator_ops.
>> However, I'm not sure about the wide-spread applicability of this feature.
>>  I'd prefer to leave it in the driver unless Mark would like me to add it
>> into the core.
> 
> You're already using pre-existing APIs around specifying the current
> and having the regulator core call you to map the total current into a
> mode.  That implies that this is applicable to others.  Adding this
> tiny amount of code to the core makes the pre-existing APIs generally
> useful.

I don't see the benefit of making struct regulation_constraints more
complicated with DRMS mode and current arrays that would only every be
used by the qcom-rpmh-regulator driver.  Other regulator drivers are able
to hard code this information in the driver code using get_optimum_mode()
callbacks.

As a side note, changing qcom-rpmh-regulator to use a get_optimum_mode()
callback instead of a set_load() callback would probably be a good idea too.


>>>> +- qcom,headroom-microvolt
>>>> +       Usage:      optional; VRM regulators only
>>>> +       Value type: <u32>
>>>> +       Definition: Specifies the headroom voltage in microvolts to request for
>>>> +                   a VRM regulator.  RPMh hardware automatically ensures that
>>>> +                   the parent of this regulator outputs a voltage high enough
>>>> +                   to satisfy the requested headroom.  Supported values are
>>>> +                   0 to 511000.
>>>
>>> I'm curious: is this a voted-for value, or a global value?
>>>
>>> Said another way: the whole point of RPMh is that there may be more
>>> than one processor that needs the same rails, right?  So the AP might
>>> request 1.1 V for a rail and the modem might request 1.3 V.  RPMh
>>> would decide to pick the higher of those two (1.3 V), but if the modem
>>> said it no longer needs the rail it will drop down to 1.1 V.
>>>
>>> ...and as an example of why the headroom needs to be in hardware, if
>>> the source voltage was normally 1.4 V and the headroom was 200 mV then
>>> the hardware would need to know to bump up the source voltage to 1.5V
>>> during the period of of time that the modem wants the rail at 1.3V.
>>>
>>> So my question is: do the AP and modem in the above situation
>>> separately vote for headroom?  How is it aggregated?  ...or is it a
>>> global value and this sets the headroom for all clients of RPMh?  It
>>> would be interesting to document this as it might help with figuring
>>> out how this value should be set.
>>
>> The headroom voltage voting is supported in hardware per-regulator and
>> per-master (AP, modem, etc).  The headroom voltage and output voltage are
>> each aggregated (using max) per-regulator across masters.  If the
>> aggregated enable state for a regulator is on, then the aggregated output
>> voltage and headroom voltage are added together and applied as a min
>> constraint on the parent's output voltage (if there is a parent).
> 
> Ah, interesting.  I'm not 100% convinced that the RPMh API is at the
> right abstraction level here.  I guess you increase the headroom
> voltage if you expect a lot of current and need the regulator to still
> give a clean signal?  If you truly wanted to aggregate then if both
> the modem and AP wanted to draw a lot of current they would both need
> to increase the headroom and then the headroom should maybe not be the
> max but something slightly more (you wouldn't want to add, but ...)
> 
> Since it's just a max, in theory it seems like you get 99% of the way
> there by just using the Linux APIs to deal with dropout voltage.  If
> Linux was managing it in software then if it needed to account for
> extra headroom it would just increase the supply voltage.  That should
> play just fine with the modem (which might be using the hardware
> headroom feature) since it will be making its own completely separate
> requests and they should be aggregated OK.
> 
> In another thread you said you'd be OK dropping the headroom voltage
> since it wasn't needed on SDM845.  Maybe we should do that?  ...and if
> someone later needs to account for a larger dropout they can figure
> out how to hookup the standard linux min_dropout_uV?

I will remove qcom,headroom-microvolt.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
