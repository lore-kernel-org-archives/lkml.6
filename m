Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbeEQMcA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeEQMb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:31:57 -0400
X-Google-Smtp-Source: AB8JxZpcBL3AqUMXSO9m1K9MQH6vtJJXI0DqjlPB/mrqhiGIbgjBt0u+Ow5tSgpC1xCnh8+4Mxp2ocT6FmMBOGPI/4s=
MIME-Version: 1.0
In-Reply-To: <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org> <20180507162004.GB2259@tuxbook-pro>
 <f970143860bd64624e7fad58333df1be@codeaurora.org> <82fa847760309cb3382bf0a8da50162c@codeaurora.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 17 May 2018 07:31:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQvSpB3CiS1sA5AXwbvC0xkd1HqEYsjY+=oripMXSwuA@mail.gmail.com>
Message-ID: <CAL_JsqLQvSpB3CiS1sA5AXwbvC0xkd1HqEYsjY+=oripMXSwuA@mail.gmail.com>
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4 peripheral
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 4:47 AM,  <kgunda@codeaurora.org> wrote:
> On 2018-05-08 15:55, kgunda@codeaurora.org wrote:
>>
>> On 2018-05-07 21:50, Bjorn Andersson wrote:
>>>
>>> On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
>>>
>>>> WLED4 peripheral is present on some PMICs like pmi8998
>>>> and pm660l. It has a different register map and also
>>>> configurations are different. Add support for it.
>>>>
>>>
>>> Several things are going on in this patch, it needs to be split to
>>> not hide the functional changes from the structural/renames.
>>>
>> Ok. I will split it in the next series.
>>>>
>>>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>>>> ---
>>>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
>>>>  drivers/video/backlight/qcom-wled.c                | 749
>>>> +++++++++++++++------
>>>>  2 files changed, 696 insertions(+), 225 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> index fb39e32..0ceffa1 100644
>>>> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>>>> @@ -1,30 +1,129 @@
>>>>  Binding for Qualcomm Technologies, Inc. WLED driver
>>>>
>>>> -Required properties:
>>>> -- compatible: should be "qcom,pm8941-wled"
>>>> -- reg: slave address
>>>> -
>>>> -Optional properties:
>>>> -- default-brightness: brightness value on boot, value from: 0-4095
>>>> -       default: 2048
>>>> -- label: The name of the backlight device
>>>> -- qcom,cs-out: bool; enable current sink output
>>>> -- qcom,cabc: bool; enable content adaptive backlight control
>>>> -- qcom,ext-gen: bool; use externally generated modulator signal to dim
>>>> -- qcom,current-limit: mA; per-string current limit; value from 0 to 25
>>>> -       default: 20mA
>>>> -- qcom,current-boost-limit: mA; boost current limit; one of:
>>>> -       105, 385, 525, 805, 980, 1260, 1400, 1680
>>>> -       default: 805mA
>>>> -- qcom,switching-freq: kHz; switching frequency; one of:
>>>> -       600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
>>>> -       1600, 1920, 2400, 3200, 4800, 9600,
>>>> -       default: 1600kHz
>>>> -- qcom,ovp: V; Over-voltage protection limit; one of:
>>>> -       27, 29, 32, 35
>>>> -       default: 29V
>>>> -- qcom,num-strings: #; number of led strings attached; value from 1 to
>>>> 3
>>>> -       default: 2
>>>> +WLED (White Light Emitting Diode) driver is used for controlling
>>>> display
>>>> +backlight that is part of PMIC on Qualcomm Technologies, Inc. reference
>>>> +platforms. The PMIC is connected to the host processor via SPMI bus.
>>>> +
>>>> +- compatible
>>>> +       Usage:        required
>>>> +       Value type:   <string>
>>>> +       Definition:   should be "qcom,pm8941-wled" or
>>>> "qcom,pmi8998-wled".
>>>> +                     or "qcom,pm660l-wled".
>>>
>>>
>>> Better written as
>>>
>>>                 should be one of:
>>>                         X
>>>                         Y
>>>                         Z
>>>
>> Will do it in the next series.
>>>>
>>>> +
>>>> +- reg
>>>> +       Usage:        required
>>>> +       Value type:   <prop encoded array>
>>>> +       Definition:   Base address of the WLED modules.
>>>> +
>>>> +- interrupts
>>>> +       Usage:        optional
>>>> +       Value type:   <prop encoded array>
>>>> +       Definition:   Interrupts associated with WLED. Interrupts can be
>>>> +                     specified as per the encoding listed under
>>>> +                     Documentation/devicetree/bindings/spmi/
>>>> +                     qcom,spmi-pmic-arb.txt.
>>>
>>>
>>> Better to describe that this should be the "short" and "ovp" interrupts
>>> in this property than in the interrupt-names.
>>>
>> Ok. I will do it in the next series.
>>>>
>>>> +
>>>> +- interrupt-names
>>>> +       Usage:        optional
>>>> +       Value type:   <string>
>>>> +       Definition:   Interrupt names associated with the interrupts.
>>>> +                     Must be "short" and "ovp". The short circuit
>>>> detection
>>>> +                     is not supported for PM8941.
>>>> +
>>>> +- label
>>>> +       Usage:        required
>>>> +       Value type:   <string>
>>>> +       Definition:   The name of the backlight device
>>>> +
>>>> +- default-brightness
>>>> +       Usage:        optional
>>>> +       Value type:   <u32>
>>>> +       Definition:   brightness value on boot, value from: 0-4095
>>>> +                     Default: 2048
>>>> +
>>>> +- qcom,current-limit
>>>> +       Usage:        optional
>>>> +       Value type:   <u32>
>>>> +       Definition:   uA; per-string current limit
>>>
>>>
>>> You can't change unit on an existing property, that breaks any existing
>>> dts using the qcom,pm8941-wled compatible.
>>>
>>
>>>> +                     value:
>>>> +                     For pm8941: from 0 to 25000 with 5000 ua step
>>>> +                                 Default 20000 uA
>>>> +                     For pmi8998: from 0 to 30000 with 5000 ua step
>>>> +                                  Default 25000 uA.
>>>
>>>
>>> These values could be described just as well in mA, so keep the original
>>> unit - in particular since the boot-limit is in mA...
>>>
>> Ok. Will keep the original as is in the next series.
>
> Here, I may have to go with the approach as in "qcom,ovp". Because for
> pm8941
> the current step is 1 mA (I have wrongly mentioned as 5000uA here) and for
> PMI8998
> the current step is 2.5 mA. Hence, I will add another variable
> "qcom,current-limit-ua"
> just like "qcom,ovp-mv".

Use unit suffixes defined in bindings/property-units.txt.

Rob
