Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbeEVQnf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:43:35 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46490 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbeEVQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:43:04 -0400
X-Google-Smtp-Source: AB8JxZrub4GwQExIXUbbMU+HS81lnG6jdl/P5a1POtsQKgCWiFO0SwmHiULyg6uorVxNSHAGn45IJaYReWeRzaOG2gw=
MIME-Version: 1.0
In-Reply-To: <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
References: <cover.1526088081.git.collinsd@codeaurora.org> <41d5df73ddac772551d2966e0752bb0c357b1ded.1526088081.git.collinsd@codeaurora.org>
 <CAD=FV=XegPeFR8pdZM-YiBBJjrbej=C+2biBt4zJKnE90uTYZA@mail.gmail.com>
 <869aad59-1cc5-28ef-1fb5-4ef846696c40@codeaurora.org> <CAD=FV=U-QOQekUHj=ck57YJbTFdFjCAWr4t2A92x+fCNf+yV9A@mail.gmail.com>
 <dc1fbe9c-8973-1c4d-0fbd-809c1ec0a6be@codeaurora.org> <CAD=FV=XfSGs14VB464cvMGDNwGS4yvSXjN8itZLffm+Sj-D=ww@mail.gmail.com>
 <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 May 2018 09:43:02 -0700
X-Google-Sender-Auth: H2eSxaDGSUHtO4eL44PwSQztf6g
Message-ID: <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
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

On Mon, May 21, 2018 at 5:00 PM, David Collins <collinsd@codeaurora.org> wrote:
> On 05/21/2018 11:01 AM, Doug Anderson wrote:
>> On Fri, May 18, 2018 at 5:46 PM, David Collins <collinsd@codeaurora.org> wrote:
> ...
>>> Something to keep in mind about the downstream rpmh-regulator driver is
>>> that it caches the initial voltages specified in device tree and only
>>> sends them after a consumer driver makes a regulator framework call. This
>>> saves time during boot and ensures that requests are not made for
>>> regulators that no Linux consumer cares about.
>>
>> You're saying that in the downstream driver you'd specify
>> "initial-voltage" in the device tree and:
>>
>> * This voltage would be reported by any subsequent get_voltage() calls
>>
>> * This voltage would _not_ be communicated to RPMh.
>>
>> That seems really strange because you're essentially going to be
>> returning something from get_voltage() that could be a lie.  You don't
>> know if the BIOS actually set the value or not but you'll claim that
>> it did.  It also doesn't seem to match what I see in the downstream
>> driver.  There I see it read "qcom,init-voltage" and then do a
>> "rpmh_regulator_set_reg()".  Thus my reading of the downstream driver
>> is that it should do the same requests that you're doing.
>
> In the downstream rpmh-regulator driver [1], the value specified via the
> "qcom,init-voltage" DT property is only sent to RPMh at probe time if the
> "qcom,send-defaults" property is also specified.  "qcom,send-defaults" is
> currently specified only for PMI8998 BOB.  The rpmh_regulator_set_reg()
> function only updates the cached RPMh request value to be sent in the next
> request.  The rpmh_regulator_send_aggregate_requests() function must be
> called to actually issue the request.

Got it.  This wasn't in the "snapshot" of the downstream driver that I saw.


> Returning the cached (but not sent) initial voltage equal to the min
> constraint voltage in get_voltage() calls should not cause any problems.
> This represents the highest voltage that is guaranteed to be output by the
> regulator.  Consumer's should call regulator_set_voltage() to specify
> their voltage needs.  If they simply call regulator_enable(), then the
> cached voltage will be sent along with the enable request.

I'm still not seeing the argument for initial-voltage here.  If we
added a feature like you describe where we don't send the voltage
until the first enable couldn't we use the minimum voltage here?  If a
consumer calls regulator_enable() without setting a voltage (which
seems like a terrible idea for something where the voltage could vary)
then it would end up at the minimum voltage.


>>> It is generally not safe to request all regulators to be set to the
>>> minimum allowed voltage.  Special care will be needed with the upstream
>>> qcom-rpmh-regulator driver to avoid disrupting the boot up state of
>>> regulators that are needed by other subsystems.  Therefore, I would like
>>> to keep the initial voltage feature supported.
>>
>> I was asking for specific examples.  Do you have any?
>
> I was able to track down an example that requires initialization at a
> non-minimum voltage: PM8998 LDO 13 on SDM845 MTP.  This regulator supplies
> the microSD card with a voltage in the range 1.8 V to 2.96 V.  The boot
> loader leaves this regulator enabled at 2.96 V.  It is only guaranteed to
> be safe to reduce the voltage to 1.8 V on UHS type cards and only after
> following the proper SD identification and command sequence.

Ironically, this is also a perfect example of why we _shouldn't_ have
an "initial-voltage" specified in the device tree.  It is certainly
plausible to imagine a bootloader that might enable UHS speeds on an
SD card and leave the rail on at 1.8V.  Having an initial-voltage
specified in the device tree would be a bad idea here because it's
even worse to transition to 2.96V when the card was expecting 1.8V.

I suppose this is a theoretical example since (as far as I know) no
bootloaders run the micro SD card at UHS speeds, but it is still
worrying that the kernel needs to have a hardcoded initial voltage in
it.  ...basically whenever we're playing with the voltage at bootup
before a regulator has been claimed it's not amazingly safe.
Generally Linux doesn't need to worry about this because it will only
play with voltages if they are out of the constrained range, but in
Qualcomm's case where we can't read the existing voltages then we get
badness.


>> BTW: have I already said how terrible of a design it is that you can't
>> read back the voltages that the BIOS set?  If we could just read back
>> what the BIOS set then everything would work great and we could stop
>> talking about this.
>
> Even if such reading were feasible, it would not help the situation
> substantially.  Very few requests are made via the AP RSC before Linux
> kernel boot, so 0 V values would still be read back for most regulators.

Sure, but all the regulators we're talking about are ones where this
would help.  Said another way: are there any rails that are not
touched by the bootloader where it's bad to set the minimum voltage?


OK, so how's this for a proposal then:

1. For RPMh-regulator whenever we see a "set voltage" but Linux hasn't
specified that the regulator is enabled then we don't send the
voltage, we just cache it.

2. When we see the first enable then we first send the cached voltage
and then do the enable.

3. We don't need an "initial voltage" because any rails that are
expected to be variable voltage the client should be choosing a
voltage.


...taking the SD card case as an example: if the regulator framework
says "set to the minimum: 1.8V" we'll cache this but not apply it yet
because the rail is off as far as Linux is concerned.  Then when the
SD card framework starts up it will set the voltage to 3.3V which will
overwrite the cache.  Then the SD card framework will enable the
regulator and RPMh will set the voltage to 3.3V and enable.


This whole thing makes me worry about another problem, though.  You
say that the bootloader left the SD card rail on, right?  ...but as
far as Linux is concerned the SD card rail is off (argh, it can't read
the state that the bootloader left the rail in!)

...now imagine any of the following:

* The user boots up a kernel where the SD card driver is disabled.

* The user ejects the SD card right after the bootloader used it but
before the kernel driver started.

When the kernel comes up it will believe that the SD card rail is
disabled so it won't try to disable it.  So the voltage will be left
on.


You can even come up with a less contrived use case here.  One could
argue that the SD card framework really ought to be ensuring VMMC and
VQMMC are off before it starts tweaking with them just in case the
bootloader left them on.  Thus, it should do:

A) Turn off VMMC and VQMMC
B) Program VMMC and VQMMC to defaults
C) Turn on VMMC and VQMMC

...right now we bootup and pretend to Linux that VMMC and VQMMC start
off, so step A) will be no-op.  Sigh.


Do we need to have ".is_enabled" return -ENOTRECOVERABLE to help the
regulator framework understand that we don't know the state?  I think
that might require a pile of patches to the regulator framework, but
it can't be helped unless we can somehow get RPMh to give us back the
status of how the bootloader left us (if we had that, we could return
0 for anything the bootloader didn't touch and that would be correct
from the point of view of the AP).


-Doug
