Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbeEWAIv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:08:51 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35985 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeEWAIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:08:48 -0400
X-Google-Smtp-Source: AB8JxZoj4wKXRdhtpXdU98zMJjv87Rxy/AwOiiNRmGxzMfiO6AVRFdwQtSIwvY3VicxZpTSm7O2k/TMyJRib00uXYRc=
MIME-Version: 1.0
In-Reply-To: <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org> <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org> <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org> <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org> <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 May 2018 17:08:45 -0700
X-Google-Sender-Auth: bxOrWaRPYKQnagklhUSVc9CI_i8
Message-ID: <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
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

On Tue, May 22, 2018 at 3:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> On 05/22/2018 09:43 AM, Doug Anderson wrote:
>> On Mon, May 21, 2018 at 5:00 PM, David Collins <collinsd@codeaurora.org> wrote:
> ...
>>> Returning the cached (but not sent) initial voltage equal to the min
>>> constraint voltage in get_voltage() calls should not cause any problems.
>>> This represents the highest voltage that is guaranteed to be output by the
>>> regulator.  Consumer's should call regulator_set_voltage() to specify
>>> their voltage needs.  If they simply call regulator_enable(), then the
>>> cached voltage will be sent along with the enable request.
>>
>> I'm still not seeing the argument for initial-voltage here.  If we
>> added a feature like you describe where we don't send the voltage
>> until the first enable couldn't we use the minimum voltage here?  If a
>> consumer calls regulator_enable() without setting a voltage (which
>> seems like a terrible idea for something where the voltage could vary)
>> then it would end up at the minimum voltage.
>
> I wasn't proposing the voltage caching feature to be used in the upstream
> qcom-rpmh-regulator.  I was explaining exactly how the downstream
> rpmh-regulator driver works.
>
> However, if the voltage caching feature is acceptable for upstream usage,
> then I could add it.  With that in place, I see less of a need for the
> qcom,regulator-initial-microvolt property and would be ok with removing it
> for now.

I think it's the right thing to do an Mark didn't seem to yell, so I'd
say go for it.


>> OK, so how's this for a proposal then:
>>
>> 1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
>> specified that the regulator is enabled then we don't send the
>> voltage, we just cache it.
>>
>> 2. When we see the first enable then we first send the cached voltage
>> and then do the enable.
>>
>> 3. We don't need an "initial voltage" because any rails that are
>> expected to be variable voltage the client should be choosing a
>> voltage.
>>
>>
>> ...taking the SD card case as an example: if the regulator framework
>> says "set to the minimum: 1.8V" we'll cache this but not apply it yet
>> because the rail is off as far as Linux is concerned.  Then when the
>> SD card framework starts up it will set the voltage to 3.3V which will
>> overwrite the cache.  Then the SD card framework will enable the
>> regulator and RPMh will set the voltage to 3.3V and enable.
>
> I am ok with implementing this feature.
>
> However, should the voltage be cached instead of sent immediately any time
> that Linux has not explicitly requested the regulator to be enabled, or
> only before the first time that an enable request is sent?
>
> 1. regulator_set_voltage(reg, 2960000, 2960000)
>    --> cache voltage=2960 mV
> 2. regulator_enable(reg)
>    --> Send voltage=2960 then enable=1
> 3. regulator_disable(reg)
>    --> Send enable=0
> 4. regulator_set_voltage(reg, 1800000, 2960000)
>    --> A. Send voltage=1800 OR B. cache voltage=1800?
>
> Option A is used on the downstream rpmh-regulator driver in order to avoid
> cases where AP votes to disable a regulator that is kept enabled by
> another subsystem but then does not lower the voltage requested thanks to
> regulator_set_voltage() being called after regulator_disable().  I plan to
> go with option A for qcom-rpmh-regulator unless there are objections.

So one client's vote for a voltage continues to be in effect even if
that client votes to have the regulator disabled?  That seems
fundamentally broken in RPMh.  I guess my take would be to work around
this RPMh misfeature by saying that whenever Linux votes to disable a
regulator it also votes for a voltage of 0.  Then another client of
RPMh won't be affected.

That seems like it would be beneficial in any case.  If the AP always
asks for 1.3 V and the modem always asks for 1.1 V for the same rail
then the rail should go down to 1.1 V when the AP says to disable the
rail.


>> This whole thing makes me worry about another problem, though.  You
>> say that the bootloader left the SD card rail on, right?  ...but as
>> far as Linux is concerned the SD card rail is off (argh, it can't read
>> the state that the bootloader left the rail in!)
>>
>> ...now imagine any of the following:
>>
>> * The user boots up a kernel where the SD card driver is disabled.
>>
>> * The user ejects the SD card right after the bootloader used it but
>> before the kernel driver started.
>>
>> When the kernel comes up it will believe that the SD card rail is
>> disabled so it won't try to disable it.  So the voltage will be left
>> on.
>
> We have not encountered issues with regulators getting left on
> indefinitely because Linux devices failed to take control of them during
> boot.  I don't think that this hypothetical issue needs to be addressed in
> the first qcom-rpmh-regulator driver patch if at all.

I don't think it hypothetical at all.  Linux takes control of a
regulator and then at bootup it disables all regulators that aren't
currently used/enabled.  In your case you will report that regulators
are already disabled and thus you'll neuter the kernel's attempt to
disable regulators that nobody is using but that might have been left
on by the bootloader.  It seemed like Mark agreed here.


>> You can even come up with a less contrived use case here.  One could
>> argue that the SD card framework really ought to be ensuring VMMC and
>> VQMMC are off before it starts tweaking with them just in case the
>> bootloader left them on.  Thus, it should do:
>>
>> A) Turn off VMMC and VQMMC
>> B) Program VMMC and VQMMC to defaults
>> C) Turn on VMMC and VQMMC
>>
>> ...right now we bootup and pretend to Linux that VMMC and VQMMC start
>> off, so step A) will be no-op.  Sigh.
>
> Step A) would not work because the regulator's use_count would be 0 and
> regulator_disable() can only be called successfully if use_count > 0.  The
> call would have no impact and it would return an error.

Are you sure regulator_force_disable() won't do the trick on most
boards (which will report the regulator being enabled at bootup)?  I
haven't tried it, but it seems like it might.

...I think you're right that this is a theoretical case at the moment
because I don't think the MMC framework attempts to get this right,
but I don't have time to dig right now.  I think it just sets the
voltage to 3.3V and turns the rail on and if the card thinks it should
be at 1.8V because the bootloader left the card in that state then:
whoops.  I'd have to walk through the regulator framework more closely
to confirm that though.  Certainly on all other boards besides ones
using RPMh the bootloader can leave regulators on and the kernel can
query that state.  It seems sane that there would be some way to turn
a regulator in this state off.  I know for a fact that if you just
leave the regulator alone (don't claim it or try to enable it) that
Linux will turn it off.


> I don't think that this is an avenue that we want to pursue.  Consumers
> should not be expected to call regulator_disable() before regulator_enable().
>
>
>> Do we need to have ".is_enabled" return -ENOTRECOVERABLE to help the
>> regulator framework understand that we don't know the state?  I think
>> that might require a pile of patches to the regulator framework, but
>> it can't be helped unless we can somehow get RPMh to give us back the
>> status of how the bootloader left us (if we had that, we could return
>> 0 for anything the bootloader didn't touch and that would be correct
>> from the point of view of the AP).
>
> I'm not following what the regulator framework would do as a result of
> is_enabled() returning -ENOTRECOVERABLE.  If it saw this while processing
> a regulator_enable() call then it would continue to enable the regulator.

The important use case here is at bootup when we try to disable all
unused regulators.  We need the framework to know that these
regulators might not be disabled so it should go ahead and try to
disable them.


> This value could not be seen while handling a regulator_disable() call
> since the is_enabled() callback is not invoked in the disable call-path.
> This also seems like an optimization for a problem that we are not
> encountering now (or likely to ever encounter).  Therefore, I would
> suggest that we not try to work this into the initial qcom-rpmh-regulator
> patch.

I think you haven't thought through the bootup case of disabling all
unused regulators.  When you look at that path I think you'll find
it's important to make sure that the regulator framework knows that
you don't know if you're disabled or enabled yet.  I think you want to
look at regulator_late_cleanup().  Note that right now
regulator_late_cleanup() doesn't handle error codes from is_enabled
(actually, several places in the regulator core don't), but actually
since the error case and the "enabled" case are probably the same this
might be OK.


-Doug
