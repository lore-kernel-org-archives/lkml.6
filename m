Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeEUSB0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:01:26 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36936 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeEUSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:01:22 -0400
X-Google-Smtp-Source: AB8JxZriB5ywgSXlAhhbGwJ1sXGIFXB09Uyag/DPAmOr0g6fj4aLgsBvfTJRH+OwS+UQjunuS/7lSSTX/U+bS0GhSPE=
MIME-Version: 1.0
In-Reply-To: <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org> <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org> <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 May 2018 11:01:20 -0700
X-Google-Sender-Auth: SQD5Y1P9k9GzAjy7EXbXqTjXYOU
Message-ID: <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 18, 2018 at 5:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> On 05/17/2018 06:01 PM, Doug Anderson wrote:
>> On Thu, May 17, 2018 at 5:16 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> On 05/17/2018 02:22 PM, Doug Anderson wrote:
>>>> On Fri, May 11, 2018 at 7:28 PM, David Collins <collinsd@codeaurora.org> wrote:
>>>>> +- qcom,regulator-initial-microvolt
>>>>> +       Usage:      optional; VRM regulators only
>>>>> +       Value type: <u32>
>>>>> +       Definition: Specifies the initial voltage in microvolts to request for a
>>>>> +                   VRM regulator.
>>>>
>>>> Now that Mark has landed the patch adding support for the
>>>> -ENOTRECOVERABLE error code from get_voltage() / get_voltage_sel(), do
>>>> we still need the qcom,regulator-initial-microvolt property?
>>>
>>> Yes, this is still needed.  The -ENOTRECOVERABLE patch ensures that
>>> qcom-rpmh-regulator devices can be registered even if
>>> qcom,regulator-initial-microvolt is not specified.  However, that will
>>> result in the regulators being configured for the minimum voltage
>>> supported in the DT specified min/max range.  The
>>> qcom,regulator-initial-microvolt property allows us to set a specific
>>> voltage that is larger than the min constraint.
>>
>> Ah, OK.  In the device tree fragment I saw the initial was always
>> equal to the min, so I wasn't sure if this was really needed in
>> practice.  I presume it would only be important if a voltage was left
>> high by the bootloader for some peripheral that needs to continue to
>> function (and use the existing higher voltage) until a real device
>> claims it.  For all other voltages, it should be fine if it's set to
>> the min until a real device claims it.  Do you have real examples of
>> devices like this in boards using sdm845?
>
> Something to keep in mind about the downstream rpmh-regulator driver is
> that it caches the initial voltages specified in device tree and only
> sends them after a consumer driver makes a regulator framework call. This
> saves time during boot and ensures that requests are not made for
> regulators that no Linux consumer cares about.

You're saying that in the downstream driver you'd specify
"initial-voltage" in the device tree and:

* This voltage would be reported by any subsequent get_voltage() calls

* This voltage would _not_ be communicated to RPMh.

That seems really strange because you're essentially going to be
returning something from get_voltage() that could be a lie.  You don't
know if the BIOS actually set the value or not but you'll claim that
it did.  It also doesn't seem to match what I see in the downstream
driver.  There I see it read "qcom,init-voltage" and then do a
"rpmh_regulator_set_reg()".  Thus my reading of the downstream driver
is that it should do the same requests that you're doing.


> It is generally not safe to request all regulators to be set to the
> minimum allowed voltage.  Special care will be needed with the upstream
> qcom-rpmh-regulator driver to avoid disrupting the boot up state of
> regulators that are needed by other subsystems.  Therefore, I would like
> to keep the initial voltage feature supported.

I was asking for specific examples.  Do you have any?


BTW: have I already said how terrible of a design it is that you can't
read back the voltages that the BIOS set?  If we could just read back
what the BIOS set then everything would work great and we could stop
talking about this.


>>>>> +- qcom,allowed-drms-modes
>>>>> +       Usage:      required if regulator-allow-set-load is specified;
>>>>> +                   VRM regulators only
>>>>> +       Value type: <prop-encoded-array>
>>>>> +       Definition: A list of integers specifying the PMIC regulator modes which
>>>>> +                   can be configured at runtime based upon consumer load needs.
>>>>> +                   Supported values are RPMH_REGULATOR_MODE_* which are defined
>>>>> +                   in [1] (i.e. 0 to 3).
>>>>
>>>> Why is this still here?  You moved it to the core regulator framework,
>>>> right?  It's still in your examples too.  Shouldn't this be removed?
>>>> It looks like the driver still needs this and it needs to be an exact
>>>> duplicate of the common binding.  That doesn't seem right...
>>>
>>> The qcom,allowed-drms-modes property supports a different feature than the
>>> regulator-allowed-modes property accepted in [2].  The latter specifies
>>> the modes that may be used at all (e.g. in regulator_set_mode() calls) and
>>> it lists the mode values in an unordered fashion.
>>>
>>> qcom,allowed-drms-modes defines a specific subset of the possible allowed
>>> modes that should be set based on DRMS (e.g. in regulator_set_load()
>>> calls).  Its values are listed in a specific order and must match 1-to-1
>>> with qcom,drms-mode-max-microamps entries.
>>>
>>> It would probably be good to change the name of the property from
>>> qcom,allowed-drms-modes to qcom,regulator-drms-modes.
>>
>> Ah, I see.  It's unfortunate that now we need to effectively list all
>> modes twice.  Have you seen real-life examples where these sets of
>> modes need to be different, or is this just theoretical?  If not can
>> we start with one property (that controls both things) and if we
>> really see that we need to specify different sets of modes for the two
>> cases we can add a separate property?  ...actually, even if you do
>> have real-life examples of where these need to be different, if 90% of
>> the time they are the same it would still be nice to just have one
>> property apply to both cases.
>
> I plan to keep qcom,regulator-drms-modes (and
> qcom,drms-mode-max-microamps) around as a property specifically handled
> for qcom-rpmh-regulator.  It serves a purpose that is distinct from that
> of the generic regulator-allowed-modes.  Without it, there will not be a
> way to utilize regulator_set_load() to configure the regulator modes.

I guess we'll have to wait for Mark's opinion here.  If it were up to
me I wouldn't accept things with two properties, but if Mark is happy
with it then I won't yell.  To make it really clear what we're talking
about, currently the bindings want you to specify both:

regulator-allowed-modes =
  <RPMH_REGULATOR_MODE_LPM
   RPMH_REGULATOR_MODE_HPM>;
qcom,allowed-drms-modes =
  <RPMH_REGULATOR_MODE_LPM
   RPMH_REGULATOR_MODE_HPM>;
qcom,drms-mode-max-microamps = <1 500000>;

...with the argument that "regulator-allowed-modes" is unordered and
"qcom,allowed-drms-modes" is ordered and needs to match with
"qcom,drms-mode-max-microamps".  ...and also (in theory) you could
come up with an example where the set of allowed modes could be
different sometimes.


>>>>> +- qcom,drms-mode-max-microamps
>>>>> +       Usage:      required if regulator-allow-set-load is specified;
>>>>> +                   VRM regulators only
>>>>> +       Value type: <prop-encoded-array>
>>>>> +       Definition: A list of integers specifying the maximum allowed load
>>>>> +                   current in microamps for each of the modes listed in
>>>>> +                   qcom,allowed-drms-modes (matched 1-to-1 in order).  Elements
>>>>> +                   must be specified in order from lowest to highest value.
>>>>
>>>> Any reason this can't go into the regulator core?  You'd basically
>>>> just take the existing concept of rpmh_regulator_vrm_set_load() and
>>>> put it in the core.
>>>
>>> This could be implemented in the core via new constraint elements parsed
>>> in of_regulator and a helper function to specify in regulator_ops.
>>> However, I'm not sure about the wide-spread applicability of this feature.
>>>  I'd prefer to leave it in the driver unless Mark would like me to add it
>>> into the core.
>>
>> You're already using pre-existing APIs around specifying the current
>> and having the regulator core call you to map the total current into a
>> mode.  That implies that this is applicable to others.  Adding this
>> tiny amount of code to the core makes the pre-existing APIs generally
>> useful.
>
> I don't see the benefit of making struct regulation_constraints more
> complicated with DRMS mode and current arrays that would only every be
> used by the qcom-rpmh-regulator driver.  Other regulator drivers are able
> to hard code this information in the driver code using get_optimum_mode()
> callbacks.

IMO this belongs in the core since it's a generic mechanism and if
drivers want to implement their own custom thing they can, but again
whatever Mark says goes so I guess we'll leave it to him.


> As a side note, changing qcom-rpmh-regulator to use a get_optimum_mode()
> callback instead of a set_load() callback would probably be a good idea too.

Yeah, I remember wondering this earlier and it seemed like it was 6 of
one half dozen of the other.  ...the downside of using
get_optimum_mode() is that it requires a valid input voltage to be
supplied.  It also makes a handful of other calls that you probably
don't need in your case.


-Doug
