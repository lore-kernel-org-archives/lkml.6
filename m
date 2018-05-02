Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbeEBFEt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:04:49 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:43998 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBFEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:04:47 -0400
Subject: Re: [PATCH v9 24/27] dt-bindings: timer: new bindings for TI DaVinci
 timer
To: David Lechner <david@lechnology.com>, Rob Herring <robh@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-25-david@lechnology.com>
 <20180427140522.npmhjamhwxgp7y73@rob-hp-laptop>
 <7cea07f1-e174-8496-a27a-01f0e3082054@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <5d60bf07-0b86-f971-3d84-2e0bf4599891@ti.com>
Date: Wed, 2 May 2018 10:33:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7cea07f1-e174-8496-a27a-01f0e3082054@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 May 2018 07:22 AM, David Lechner wrote:
> Sekhar,
> 
> On 04/27/2018 09:05 AM, Rob Herring wrote:
>> On Thu, Apr 26, 2018 at 07:17:42PM -0500, David Lechner wrote:
>>> This adds new device tree bindings for the timer IP block of TI
>>> DaVinci-like SoCs.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>> ---
>>>
>>> v9 changes:
>>> - new patch in v9
>>>
>>>
>>>   .../bindings/timer/ti,davinci-timer.txt       | 24 +++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
>>> b/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
>>> new file mode 100644
>>> index 000000000000..2091eca46981
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/ti,davinci-timer.txt
>>> @@ -0,0 +1,24 @@
>>> +* Device tree bindings for Texas Instruments DaVinci timer
>>> +
>>> +This document provides bindings for the 64-bit timer in the DaVinci
>>> +architecture devices. The timer can be configured as a
>>> general-purpose 64-bit
>>> +timer, dual general-purpose 32-bit timers. When configured as dual
>>> 32-bit
>>> +timers, each half can operate in conjunction (chain mode) or
>>> independently
>>> +(unchained mode) of each other.
>>> +
>>> +It is global timer is a free running up-counter and can generate
>>> interrupt
>>
>> Doesn't make sense, too many 'is'.
>>
>> There's no interrupt property listed.
>>
>>> +when the counter reaches preset counter values.
>>> +
>>> +Required properties:
>>> +
>>> +- compatible : should be "ti,davinci-timer".
>>> +- reg : specifies base physical address and count of the registers.
>>> +- clocks : the clock feeding the timer clock.
>>> +
>>> +Example:
>>> +
>>> +    clocksource: timer@20000 {
>>> +        compatible = "ti,davinci-timer";
>>> +        reg = <0x20000 0x1000>;
>>> +        clocks = <&pll0_auxclk>;
>>> +    };
>>> -- 
>>> 2.17.0
>>>
> 
> What do you think about trying to reuse the keystone timer here instead of
> introducing our own binding? I assume it is basically the same since the
> watchdog timer is shared already between davinci and keystone.

When we move to using timer support to drivers/clocksource, surely we
should look at reusing the keystone timer. But even then, I think having
a separate binding document for DaVinci is not illegal. Since we are not
at a stage where we re-use Keystone driver, I prefer the binding to be
separate as well.

The timer IP on DA830/DA850 is not the same as that available on
Keystone and older DaVinci devices. There are additional compare
registers (starting at 0x60) on DA830/DA850 devices which allow the same
timer to be used for both clocksource and clockevent. We use that
facility on DA830 today because there was a shortage of timers on that
device and majority of timers had to be dedicated for DSP use.

So, I think its safer to introduce a "ti,da830-timer" compatible for
DA830 and DA850 timers.

On interrupts question, yes, we dont use interrupt number from DT today.
But defining an interrupt property that looks correct is fine, I think.

Thanks,
Sekhar
