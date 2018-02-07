Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeBGSDj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 13:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753951AbeBGSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 13:03:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010442179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x225LMxGOIqlp9/w7Mhohv6Eia41kfsvM0ovw9BAFDNel8ZNJpUd1WJS7nGbHzuDRO78wxSDKETgJfKIfxdqfcfc=
MIME-Version: 1.0
In-Reply-To: <19273eb9-0c8c-cd2a-d100-f25f25e93234@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
 <1517580222-23301-2-git-send-email-gabriel.fernandez@st.com>
 <20180205042238.64xjrrguls2drtrg@rob-hp-laptop> <19273eb9-0c8c-cd2a-d100-f25f25e93234@st.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Feb 2018 12:03:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFD5g46mkyEWo2uH_ogYLhnvBLQ0f6mU9DG_bdh9n7sA@mail.gmail.com>
Message-ID: <CAL_JsqJFD5g46mkyEWo2uH_ogYLhnvBLQ0f6mU9DG_bdh9n7sA@mail.gmail.com>
Subject: Re: [PATCH 01/14] dt-bindings: Document STM32MP1 Reset Clock
 Controller (RCC) bindings
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "gabriel.fernandez.st@gmail.com" <gabriel.fernandez.st@gmail.com>,
        Olivier BIDEAU <olivier.bideau@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 1:01 AM, Gabriel FERNANDEZ
<gabriel.fernandez@st.com> wrote:
> Hi Rob,
>
> Thanks for reviewing.
>
>
> On 02/05/2018 07:09 AM, Rob Herring wrote:
>> On Fri, Feb 02, 2018 at 03:03:29PM +0100, gabriel.fernandez@st.com wrote:
>>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>
>>> The RCC block is responsible of the management of the clock and reset
>>> generation for the complete circuit.
>>>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>> ---
>>>   .../devicetree/bindings/mfd/st,stm32-rcc.txt       | 85 ++++++++++++++++++++++
>>>   1 file changed, 85 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>>> new file mode 100644
>>> index 0000000..28017a1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
>>> @@ -0,0 +1,85 @@
>>> +STMicroelectronics STM32 Peripheral Reset Clock Controller
>>> +==========================================================
>>> +
>>> +The RCC IP is both a reset and a clock controller.
>>> +
>>> +Please also refer to reset.txt for common reset controller binding usage.
>>> +
>>> +Please also refer to clock-bindings.txt for common clock controller
>>> +binding usage.
>>> +
>>> +
>>> +Required properties:
>>> +- compatible: "simple-mfd", "syscon"
>>
>>> +- reg: should be register base and length as documented in the datasheet
>>> +
>>> +- Sub-nodes:
>>> +  - compatible: "st,stm32mp1-rcc-clk"
>>> +    - #clock-cells: 1, device nodes should specify the clock in their
>>> +      "clocks" property, containing a phandle to the clock device node,
>>> +      an index specifying the clock to use.
>>> +
>>> +  - compatible: "st,stm32mp1-rcc-rst"
>>> +    - #reset-cells: Shall be 1
>>> +
>>> +Example:
>>> +    rcc: rcc@50000000 {
>>> +            compatible = "syscon", "simple-mfd";
>>> +            reg = <0x50000000 0x1000>;
>>> +
>>> +            rcc_clk: rcc-clk@50000000 {
>>> +                    #clock-cells = <1>;
>>> +                    compatible = "st,stm32mp1-rcc-clk";
>>> +            };
>>> +
>>> +            rcc_rst: rcc-reset@50000000 {
>> You should not have the same unit-address twice.
>>
>> IMO, this should just be:
>>
>>       rcc: rcc@50000000 {
>>               compatible = "st-stm32mp1-rcc";
>>               reg = <0x50000000 0x1000>;
>>               #clock-cells = <1>;
>>               #reset-cells = <1>;
>>       };
>>
>> There's no reason a node can't provide more than 1 function.
> RCC is an dedicated IP for clocks and resets, but also for power
> management (patches will be sent later)

If there's additional functions, they should be part of the binding
now, not later. bindings should not unnecessarily evolve.

> Then i need to probe 3 drivers with same IP.

Drivers and DT nodes don't have to be 1-1. A parent driver can create
additional child devices.

Also, looking at your existing bindings for RCC IP, it is done as I suggested.

> It's also a way to avoid use of 'CLK_OF_DECLARE_DRIVER' and i need it to
> probe the 3th driver.

Sounds like a Linux problem, not a DT issue.

Rob
