Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753793AbeEWBT0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 21:19:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeEWBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 21:19:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01DB5604D4
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
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org>
 <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <b5078a17-4cbb-905e-4cd1-f252a02f97e9@codeaurora.org>
Date: Tue, 22 May 2018 18:19:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 05:08 PM, Doug Anderson wrote:
> On Tue, May 22, 2018 at 3:46 PM, David Collins <collinsd@codeaurora.org> wrote:
>> On 05/22/2018 09:43 AM, Doug Anderson wrote:
>>> On Mon, May 21, 2018 at 5:00 PM, David Collins <collinsd@codeaurora.org> wrote:
...
>> However, if the voltage caching feature is acceptable for upstream usage,
>> then I could add it.  With that in place, I see less of a need for the
>> qcom,regulator-initial-microvolt property and would be ok with removing it
>> for now.
> 
> I think it's the right thing to do an Mark didn't seem to yell, so I'd
> say go for it.

I'll remove qcom,regulator-initial-microvolt support and add voltage caching.


>>> OK, so how's this for a proposal then:
>>>
>>> 1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
>>> specified that the regulator is enabled then we don't send the
>>> voltage, we just cache it.
>>>
>>> 2. When we see the first enable then we first send the cached voltage
>>> and then do the enable.
>>>
>>> 3. We don't need an "initial voltage" because any rails that are
>>> expected to be variable voltage the client should be choosing a
>>> voltage.
>>>
>>>
>>> ...taking the SD card case as an example: if the regulator framework
>>> says "set to the minimum: 1.8V" we'll cache this but not apply it yet
>>> because the rail is off as far as Linux is concerned.  Then when the
>>> SD card framework starts up it will set the voltage to 3.3V which will
>>> overwrite the cache.  Then the SD card framework will enable the
>>> regulator and RPMh will set the voltage to 3.3V and enable.
>>
>> I am ok with implementing this feature.
>>
>> However, should the voltage be cached instead of sent immediately any time
>> that Linux has not explicitly requested the regulator to be enabled, or
>> only before the first time that an enable request is sent?
>>
>> 1. regulator_set_voltage(reg, 2960000, 2960000)
>>    --> cache voltage=2960 mV
>> 2. regulator_enable(reg)
>>    --> Send voltage=2960 then enable=1
>> 3. regulator_disable(reg)
>>    --> Send enable=0
>> 4. regulator_set_voltage(reg, 1800000, 2960000)
>>    --> A. Send voltage=1800 OR B. cache voltage=1800?
>>
>> Option A is used on the downstream rpmh-regulator driver in order to avoid
>> cases where AP votes to disable a regulator that is kept enabled by
>> another subsystem but then does not lower the voltage requested thanks to
>> regulator_set_voltage() being called after regulator_disable().  I plan to
>> go with option A for qcom-rpmh-regulator unless there are objections.
> 
> So one client's vote for a voltage continues to be in effect even if
> that client votes to have the regulator disabled?  That seems
> fundamentally broken in RPMh.  I guess my take would be to work around
> this RPMh misfeature by saying that whenever Linux votes to disable a
> regulator it also votes for a voltage of 0.  Then another client of
> RPMh won't be affected.
> 
> That seems like it would be beneficial in any case.  If the AP always
> asks for 1.3 V and the modem always asks for 1.1 V for the same rail
> then the rail should go down to 1.1 V when the AP says to disable the
> rail.

The VRM in RPMh hardware aggregates enable state, output voltage, mode,
and headroom voltage requests independently for each regulator.  This
allows for maximum request flexibility and makes no assumptions about
consumer use cases.  There is nothing inherently wrong about this approach.

I'm concerned about a blanket policy of setting voltage=0 when issuing
disable requests.  That seems to violate the semantics of the
regulator_set_voltage() API which enforces the requested voltage range
until a new range is specified.  There may be workarounds that require a
regulator to operate at a specific voltage even when no Linux consumers
explicitly need the regulator enabled.

Given that not masking the voltage on disable is guaranteed to be safe and
does not silently break potential use cases, I plan to stick with this
approach.  Therefore, the question about option A or B for voltage caching
is still relevant.  I think that option A is safer/more API conforming so
I plan to implement that.


>>> This whole thing makes me worry about another problem, though.  You
>>> say that the bootloader left the SD card rail on, right?  ...but as
>>> far as Linux is concerned the SD card rail is off (argh, it can't read
>>> the state that the bootloader left the rail in!)
>>>
>>> ...now imagine any of the following:
>>>
>>> * The user boots up a kernel where the SD card driver is disabled.
>>>
>>> * The user ejects the SD card right after the bootloader used it but
>>> before the kernel driver started.
>>>
>>> When the kernel comes up it will believe that the SD card rail is
>>> disabled so it won't try to disable it.  So the voltage will be left
>>> on.
>>
>> We have not encountered issues with regulators getting left on
>> indefinitely because Linux devices failed to take control of them during
>> boot.  I don't think that this hypothetical issue needs to be addressed in
>> the first qcom-rpmh-regulator driver patch if at all.
> 
> I don't think it hypothetical at all.  Linux takes control of a
> regulator and then at bootup it disables all regulators that aren't
> currently used/enabled.  In your case you will report that regulators
> are already disabled and thus you'll neuter the kernel's attempt to
> disable regulators that nobody is using but that might have been left
> on by the bootloader.  It seemed like Mark agreed here.

I did not consider regulator_late_cleanup().  I'll initialize the enabled
value in qcom-rpmh-regulator to -EINVAL to handle this case and also so
that _regulator_enable() succeeds without further core modification.


>>> You can even come up with a less contrived use case here.  One could
>>> argue that the SD card framework really ought to be ensuring VMMC and
>>> VQMMC are off before it starts tweaking with them just in case the
>>> bootloader left them on.  Thus, it should do:
>>>
>>> A) Turn off VMMC and VQMMC
>>> B) Program VMMC and VQMMC to defaults
>>> C) Turn on VMMC and VQMMC
>>>
>>> ...right now we bootup and pretend to Linux that VMMC and VQMMC start
>>> off, so step A) will be no-op.  Sigh.
>>
>> Step A) would not work because the regulator's use_count would be 0 and
>> regulator_disable() can only be called successfully if use_count > 0.  The
>> call would have no impact and it would return an error.
> 
> Are you sure regulator_force_disable() won't do the trick on most
> boards (which will report the regulator being enabled at bootup)?  I
> haven't tried it, but it seems like it might.

regulator_force_disable() would indeed call the disable() callback.
However, this function is designed for emergency uses only and will cause
the use_count to become out of sync with the requested regulator state.  I
don't think that we want to suggest to consumers that they call
regulator_force_disable().  It would completely break any shared regulator
uses cases between multiple Linux consumers.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
