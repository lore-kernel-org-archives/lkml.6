Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeEWFKx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:10:53 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34752 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEWFKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:10:50 -0400
X-Google-Smtp-Source: AB8JxZrejnF0YRQHEMjACOkYLqludFbAWXj6JN/p1xQrntYoBD7DO70K/UhIC+8VZO18cbUWM5bmmnncnCiv6Eroxes=
MIME-Version: 1.0
In-Reply-To: <b5078a17-4cbb-905e-4cd1-f252a02f97e9@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org> <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org> <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org> <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org> <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org> <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <b5078a17-4cbb-905e-4cd1-f252a02f97e9@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 May 2018 22:10:47 -0700
X-Google-Sender-Auth: BCBYiAq0zSaBssAwBf2X02Jbo4o
Message-ID: <CAD=FV=Vo3PaHLSA3voEEQ30O+nFFErKfVK9oRo3H2-d17LSQkw@mail.gmail.com>
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

On Tue, May 22, 2018 at 6:19 PM, David Collins <collinsd@codeaurora.org> wrote:
>>>> OK, so how's this for a proposal then:
>>>>
>>>> 1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
>>>> specified that the regulator is enabled then we don't send the
>>>> voltage, we just cache it.
>>>>
>>>> 2. When we see the first enable then we first send the cached voltage
>>>> and then do the enable.
>>>>
>>>> 3. We don't need an "initial voltage" because any rails that are
>>>> expected to be variable voltage the client should be choosing a
>>>> voltage.
>>>>
>>>>
>>>> ...taking the SD card case as an example: if the regulator framework
>>>> says "set to the minimum: 1.8V" we'll cache this but not apply it yet
>>>> because the rail is off as far as Linux is concerned.  Then when the
>>>> SD card framework starts up it will set the voltage to 3.3V which will
>>>> overwrite the cache.  Then the SD card framework will enable the
>>>> regulator and RPMh will set the voltage to 3.3V and enable.
>>>
>>> I am ok with implementing this feature.
>>>
>>> However, should the voltage be cached instead of sent immediately any time
>>> that Linux has not explicitly requested the regulator to be enabled, or
>>> only before the first time that an enable request is sent?
>>>
>>> 1. regulator_set_voltage(reg, 2960000, 2960000)
>>>    --> cache voltage=2960 mV
>>> 2. regulator_enable(reg)
>>>    --> Send voltage=2960 then enable=1
>>> 3. regulator_disable(reg)
>>>    --> Send enable=0
>>> 4. regulator_set_voltage(reg, 1800000, 2960000)
>>>    --> A. Send voltage=1800 OR B. cache voltage=1800?
>>>
>>> Option A is used on the downstream rpmh-regulator driver in order to avoid
>>> cases where AP votes to disable a regulator that is kept enabled by
>>> another subsystem but then does not lower the voltage requested thanks to
>>> regulator_set_voltage() being called after regulator_disable().  I plan to
>>> go with option A for qcom-rpmh-regulator unless there are objections.
>>
>> So one client's vote for a voltage continues to be in effect even if
>> that client votes to have the regulator disabled?  That seems
>> fundamentally broken in RPMh.  I guess my take would be to work around
>> this RPMh misfeature by saying that whenever Linux votes to disable a
>> regulator it also votes for a voltage of 0.  Then another client of
>> RPMh won't be affected.
>>
>> That seems like it would be beneficial in any case.  If the AP always
>> asks for 1.3 V and the modem always asks for 1.1 V for the same rail
>> then the rail should go down to 1.1 V when the AP says to disable the
>> rail.
>
> The VRM in RPMh hardware aggregates enable state, output voltage, mode,
> and headroom voltage requests independently for each regulator.  This
> allows for maximum request flexibility and makes no assumptions about
> consumer use cases.  There is nothing inherently wrong about this approach.

Just to confirm I'm understanding correctly:

1. AP: request that regulator A be at 1.3 V and enabled
==> actual output: regulator A is 1.3 V and enabled

2. modem: requests that regulator A be at 1.1 V and enabled
==> actual output: regulator A is 1.3 V and enabled

3. AP: request that regulator A be disabled

You're saying that here the output of regulator A will be "1.3 V" and
"enabled".

I just can't see how that can be correct behavior.  A given client's
vote for the voltage should really only make sense if that client
wants the regulator enabled.  In the case above the kernel would have
no idea that someone else might have the regulator enabled.  Why would
it care if that other user gets it at 1.3 V or at 1.1 V?

You have some use case in mind where the kernel would need to have
control over the voltage of a regulator that it thinks is disabled?

Now obviously if the kernel re-enables the regulator then its old
voltage vote should be re-instated right away, but until then its vote
about the voltage shouldn't count.  If that means that the kernel has
to "vote" for 0V then I guess that's the way the API works.


> I'm concerned about a blanket policy of setting voltage=0 when issuing
> disable requests.  That seems to violate the semantics of the
> regulator_set_voltage() API which enforces the requested voltage range
> until a new range is specified.  There may be workarounds that require a
> regulator to operate at a specific voltage even when no Linux consumers
> explicitly need the regulator enabled.
>
> Given that not masking the voltage on disable is guaranteed to be safe and
> does not silently break potential use cases, I plan to stick with this
> approach.  Therefore, the question about option A or B for voltage caching
> is still relevant.  I think that option A is safer/more API conforming so
> I plan to implement that.

I still can't understand how it ever makes sense to vote for a voltage
for a regulator that you think is disabled.  ...but if there's some
reason it does then I guess I'm OK with A.


>>>> This whole thing makes me worry about another problem, though.  You
>>>> say that the bootloader left the SD card rail on, right?  ...but as
>>>> far as Linux is concerned the SD card rail is off (argh, it can't read
>>>> the state that the bootloader left the rail in!)
>>>>
>>>> ...now imagine any of the following:
>>>>
>>>> * The user boots up a kernel where the SD card driver is disabled.
>>>>
>>>> * The user ejects the SD card right after the bootloader used it but
>>>> before the kernel driver started.
>>>>
>>>> When the kernel comes up it will believe that the SD card rail is
>>>> disabled so it won't try to disable it.  So the voltage will be left
>>>> on.
>>>
>>> We have not encountered issues with regulators getting left on
>>> indefinitely because Linux devices failed to take control of them during
>>> boot.  I don't think that this hypothetical issue needs to be addressed in
>>> the first qcom-rpmh-regulator driver patch if at all.
>>
>> I don't think it hypothetical at all.  Linux takes control of a
>> regulator and then at bootup it disables all regulators that aren't
>> currently used/enabled.  In your case you will report that regulators
>> are already disabled and thus you'll neuter the kernel's attempt to
>> disable regulators that nobody is using but that might have been left
>> on by the bootloader.  It seemed like Mark agreed here.
>
> I did not consider regulator_late_cleanup().  I'll initialize the enabled
> value in qcom-rpmh-regulator to -EINVAL to handle this case and also so
> that _regulator_enable() succeeds without further core modification.

That's weird that the regulator code has a special case for -EINVAL in
_regulator_enable().  Given how most of the code in the
regulator/core.c doesn't seem to check for error codes I wonder if
anyone is using that...  I guess I'd leave it to Mark whether he's
happy with -EINVAL for this case even though it's asymmetric to using
-ENOTRECOVERABLE for getting the voltage.

Are we really sure there aren't any places that the regulator code
needs to handle an error from _regulator_enable()?  An an example, in
regulator_resolve_supply() are we sure we should be passing a
regulator_enable() on to our parent supply even if
_regulator_is_enabled() returns an error?  I haven't looked in depth
of all use cases, though...


I see you posted a new version.  Thanks!  I'll try to find some time
soon to review it, but I'll be a bit busy over the next few days.

-Doug
