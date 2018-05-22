Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeEVWqN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:46:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753139AbeEVWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:46:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7D85601D7
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
From: David Collins <collinsd@codeaurora.org>
Message-ID: <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
Date: Tue, 22 May 2018 15:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 09:43 AM, Doug Anderson wrote:
> On Mon, May 21, 2018 at 5:00 PM, David Collins <collinsd@codeaurora.org> wrote:
...
>> Returning the cached (but not sent) initial voltage equal to the min
>> constraint voltage in get_voltage() calls should not cause any problems.
>> This represents the highest voltage that is guaranteed to be output by the
>> regulator.  Consumer's should call regulator_set_voltage() to specify
>> their voltage needs.  If they simply call regulator_enable(), then the
>> cached voltage will be sent along with the enable request.
> 
> I'm still not seeing the argument for initial-voltage here.  If we
> added a feature like you describe where we don't send the voltage
> until the first enable couldn't we use the minimum voltage here?  If a
> consumer calls regulator_enable() without setting a voltage (which
> seems like a terrible idea for something where the voltage could vary)
> then it would end up at the minimum voltage.

I wasn't proposing the voltage caching feature to be used in the upstream
qcom-rpmh-regulator.  I was explaining exactly how the downstream
rpmh-regulator driver works.

However, if the voltage caching feature is acceptable for upstream usage,
then I could add it.  With that in place, I see less of a need for the
qcom,regulator-initial-microvolt property and would be ok with removing it
for now.


>>> BTW: have I already said how terrible of a design it is that you can't
>>> read back the voltages that the BIOS set?  If we could just read back
>>> what the BIOS set then everything would work great and we could stop
>>> talking about this.
>>
>> Even if such reading were feasible, it would not help the situation
>> substantially.  Very few requests are made via the AP RSC before Linux
>> kernel boot, so 0 V values would still be read back for most regulators.
> 
> Sure, but all the regulators we're talking about are ones where this
> would help.  Said another way: are there any rails that are not
> touched by the bootloader where it's bad to set the minimum voltage?

I'm not sure about this.


> OK, so how's this for a proposal then:
> 
> 1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
> specified that the regulator is enabled then we don't send the
> voltage, we just cache it.
> 
> 2. When we see the first enable then we first send the cached voltage
> and then do the enable.
> 
> 3. We don't need an "initial voltage" because any rails that are
> expected to be variable voltage the client should be choosing a
> voltage.
> 
> 
> ...taking the SD card case as an example: if the regulator framework
> says "set to the minimum: 1.8V" we'll cache this but not apply it yet
> because the rail is off as far as Linux is concerned.  Then when the
> SD card framework starts up it will set the voltage to 3.3V which will
> overwrite the cache.  Then the SD card framework will enable the
> regulator and RPMh will set the voltage to 3.3V and enable.

I am ok with implementing this feature.

However, should the voltage be cached instead of sent immediately any time
that Linux has not explicitly requested the regulator to be enabled, or
only before the first time that an enable request is sent?

1. regulator_set_voltage(reg, 2960000, 2960000)
   --> cache voltage=2960 mV
2. regulator_enable(reg)
   --> Send voltage=2960 then enable=1
3. regulator_disable(reg)
   --> Send enable=0
4. regulator_set_voltage(reg, 1800000, 2960000)
   --> A. Send voltage=1800 OR B. cache voltage=1800?

Option A is used on the downstream rpmh-regulator driver in order to avoid
cases where AP votes to disable a regulator that is kept enabled by
another subsystem but then does not lower the voltage requested thanks to
regulator_set_voltage() being called after regulator_disable().  I plan to
go with option A for qcom-rpmh-regulator unless there are objections.


> This whole thing makes me worry about another problem, though.  You
> say that the bootloader left the SD card rail on, right?  ...but as
> far as Linux is concerned the SD card rail is off (argh, it can't read
> the state that the bootloader left the rail in!)
> 
> ...now imagine any of the following:
> 
> * The user boots up a kernel where the SD card driver is disabled.
> 
> * The user ejects the SD card right after the bootloader used it but
> before the kernel driver started.
> 
> When the kernel comes up it will believe that the SD card rail is
> disabled so it won't try to disable it.  So the voltage will be left
> on.

We have not encountered issues with regulators getting left on
indefinitely because Linux devices failed to take control of them during
boot.  I don't think that this hypothetical issue needs to be addressed in
the first qcom-rpmh-regulator driver patch if at all.


> You can even come up with a less contrived use case here.  One could
> argue that the SD card framework really ought to be ensuring VMMC and
> VQMMC are off before it starts tweaking with them just in case the
> bootloader left them on.  Thus, it should do:
> 
> A) Turn off VMMC and VQMMC
> B) Program VMMC and VQMMC to defaults
> C) Turn on VMMC and VQMMC
> 
> ...right now we bootup and pretend to Linux that VMMC and VQMMC start
> off, so step A) will be no-op.  Sigh.

Step A) would not work because the regulator's use_count would be 0 and
regulator_disable() can only be called successfully if use_count > 0.  The
call would have no impact and it would return an error.

I don't think that this is an avenue that we want to pursue.  Consumers
should not be expected to call regulator_disable() before regulator_enable().


> Do we need to have ".is_enabled" return -ENOTRECOVERABLE to help the
> regulator framework understand that we don't know the state?  I think
> that might require a pile of patches to the regulator framework, but
> it can't be helped unless we can somehow get RPMh to give us back the
> status of how the bootloader left us (if we had that, we could return
> 0 for anything the bootloader didn't touch and that would be correct
> from the point of view of the AP).

I'm not following what the regulator framework would do as a result of
is_enabled() returning -ENOTRECOVERABLE.  If it saw this while processing
a regulator_enable() call then it would continue to enable the regulator.
This value could not be seen while handling a regulator_disable() call
since the is_enabled() callback is not invoked in the disable call-path.
This also seems like an optimization for a problem that we are not
encountering now (or likely to ever encounter).  Therefore, I would
suggest that we not try to work this into the initial qcom-rpmh-regulator
patch.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
