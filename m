Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeEWOkE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933174AbeEWOkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:40:02 -0400
X-Google-Smtp-Source: ADUXVKIe8PnBGP4Bg2/YJoygp/LKzqPErVw7vvbV8RFUQEW3aOyggFLfmBN9EzeP0xqo8i99fhSKCfxH/lt6EgO9QEA=
MIME-Version: 1.0
In-Reply-To: <5B0461D1.1050900@codeaurora.org>
References: <1526629965-28729-1-git-send-email-skannan@codeaurora.org>
 <20180522180838.GA13423@rob-hp-laptop> <5B0461D1.1050900@codeaurora.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 May 2018 09:39:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8W5219_rCQFCbo+Vc0Yv6HvrpXTpOpgixH4sNg7gg1w@mail.gmail.com>
Message-ID: <CAL_JsqL8W5219_rCQFCbo+Vc0Yv6HvrpXTpOpgixH4sNg7gg1w@mail.gmail.com>
Subject: Re: [PATCH v2] PM / devfreq: Add support for QCOM devfreq firmware
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 1:30 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 05/22/2018 11:08 AM, Rob Herring wrote:
>>
>> On Fri, May 18, 2018 at 12:52:40AM -0700, Saravana Kannan wrote:
>>>
>>> The firmware present in some QCOM chipsets offloads the steps necessary
>>> for
>>> changing the frequency of some devices (Eg: L3). This driver implements
>>> the
>>> devfreq interface for this firmware so that various governors could be
>>> used
>>> to scale the frequency of these devices.
>>>
>>> Each client (say cluster 0 and cluster 1) that wants to vote for a
>>> particular device's frequency (say, L3 frequency) is represented as a
>>> separate voter device (qcom,devfreq-fw-voter) that's a child of the
>>> firmware device (qcom,devfreq-fw).
>>>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>> ---
>>>   .../bindings/devfreq/devfreq-qcom-fw.txt           |  41 +++
>>>   drivers/devfreq/Kconfig                            |  14 +
>>>   drivers/devfreq/Makefile                           |   1 +
>>>   drivers/devfreq/devfreq_qcom_fw.c                  | 330
>>> +++++++++++++++++++++
>>>   4 files changed, 386 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>>   create mode 100644 drivers/devfreq/devfreq_qcom_fw.c
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>> b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>> new file mode 100644
>>> index 0000000..f882a0b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-qcom-fw.txt
>>> @@ -0,0 +1,41 @@
>>> +QCOM Devfreq firmware device
>>> +
>>> +Some Qualcomm Technologies, Inc. (QTI) chipsets have a firmware that
>>> +offloads the steps for frequency switching. It provides a table of
>>> +supported frequencies and a register to request one of the supported
>>> +freqencies.
>>> +
>>> +The qcom,devfreq-fw represents this firmware as a device. Sometimes,
>>> +multiple entities want to vote on the frequency request that is sent to
>>> the
>>> +firmware. The qcom,devfreq-fw-voter represents these voters as child
>>> +devices of the corresponding qcom,devfreq-fw device.
>>> +
>>> +Required properties:
>>> +- compatible:          Must be "qcom,devfreq-fw" or
>>> "qcom,devfreq-fw-voter"
>>
>>
>> No versions of firmware?
>
>
> Sure, I can add a v1. Right now the interface has always been identical. I
> thought if it changed in the future I'll add -v2.

Sounds like you are making up version numbers. If you don't have real
h/w or firmware version numbers, then use an SoC specific compatible
string.

>>> +Only for qcom,devfreq-fw:
>>> +- reg:                 Pairs of physical base addresses and region sizes
>>> of
>>> +                       memory mapped registers.
>>
>>
>> Registers? Is this firmware or h/w block?
>
>
> It's a HW block that has its own firmware.

So you have 2 things that could change: the h/w interface and the
firmware version. Make sure the compatible string(s) is specific
enough for the OS to know the exact combination.

>>> +- reg-names:           Names of the bases for the above registers.
>>> +                       Required register regions are:
>>> +                       - "en-base": address of register to check if the
>>> +                         firmware is enabled.
>>> +                       - "ftbl-base": address region for the frequency
>>> +                         table.
>>> +                       - "perf-base": address of register to request a
>>> +                         frequency.
>>> +
>>> +Example:
>>> +
>>> +       qcom,devfreq-l3 {
>>> +               compatible = "qcom,devfreq-fw";
>>> +               reg-names = "en-base", "ftbl-base", "perf-base";
>>> +               reg = <0x18321000 0x4>, <0x18321110 0x600>, <0x18321920
>>> 0x4>;
>>> +
>>> +               qcom,cpu0-l3 {
>>> +                       compatible = "qcom,devfreq-fw-voter";
>>
>>
>> There's no point in these nodes. They don't have any properties or
>> resources.
>
>
> These nodes decide how many voters this device supports. Each voter would be
> a devfreq node that will have its own governor set. For example, one of them
> would use this governor:
> http://lkml.iu.edu/hypermail/linux/kernel/1805.2/02474.html
>
> You can also attach different devfreq-event devices to each one of these
> voter devices based on what events you want to use for scaling each voter.
> So, the devices are definitely needed in the larger context.

Sorry, I still don't understand.

Rob
