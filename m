Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeBVAHG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:07:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751327AbeBVAHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:07:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B76921795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELu7ljeSaQVcNq9qdo1mc1ULa9/WIedfuu3C4gEIbQJsofSrZjkRUc7i9zDaBuU6lfM3IImBNuAgwOUYnOEif3k=
MIME-Version: 1.0
In-Reply-To: <b08ab2cd-d6a0-b5da-e33e-ad150370776b@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
 <20180218231938.goeht7tomfkab6uu@rob-hp-laptop> <b08ab2cd-d6a0-b5da-e33e-ad150370776b@st.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 21 Feb 2018 18:06:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJdqd9rpSy9Vra4tjGcAWMLyiXmEmquCUDn8dTXj1YWGQ@mail.gmail.com>
Message-ID: <CAL_JsqJdqd9rpSy9Vra4tjGcAWMLyiXmEmquCUDn8dTXj1YWGQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander driver
To: Amelie DELAUNAY <amelie.delaunay@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 9:59 AM, Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>
>
> On 02/19/2018 12:19 AM, Rob Herring wrote:
>> On Thu, Feb 08, 2018 at 03:27:32PM +0100, Amelie Delaunay wrote:
>>> This patch adds documentation of device tree bindings for the
>>> STMicroelectronics Multi-Function eXpander (MFX).
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/st-mfx.txt | 51 ++++++++++++++++++++++++
>>>   1 file changed, 51 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/st-mfx.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/st-mfx.txt b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>>> new file mode 100644
>>> index 0000000..423d800
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/st-mfx.txt
>>> @@ -0,0 +1,51 @@
>>> +STMicroelectronics Multi-Function eXpander
>>> +
>>> +ST Multi-Function eXpander (MFX) is a slave controller using I2C for
>>> +communication with the main MCU. Its main features are gpio expansion, main
>>> +MCU IDD measurement (IDD is the amount of current that flows through VDD)
>>> +and resistive touchscreen controller.
>>
>> You don't have to implement all the drivers now, but please completely
>> describe the device. As is, there is no reason to have a child GPIO
>> node.
>>
> The MFD driver will be abandoned as only GPIO part is used. I'll send a
> V2 soon.
>>> +
>>> +Required properties:
>>> +- compatible: must be "st,mfx"
>>
>> Kind of generic. Only 1 single version ever?
>>
> "st-mfx" compatible will disappear in V2 (we keep only GPIO driver). MFX
> version can be read in MFX FW_VERSION register. So do I keep
> "st,mfx-gpio" compatible or you want to see mfx version ?

That sounds a bit worrying. The other functions will *never* get
accessed? The DT should reflect the h/w including any future needs,
not just what you have a driver for today.

>>> +- reg: I2C address of the device
>>> +- interrupts: interrupt triggered by MFX_IRQ_OUT signal
>>> +- interrupt-parent: interrupt controller MFX is connected to
>>> +- interrupt-controller: marks the device as an interrupt controller
>>> +- #interrupt-cells: should be <1>, index of the interrupt within the
>>> +  controller, in accordance with the "one cell" variant of
>>> +  <devicetree/bindings/interrupt-controller/interrupt.txt>
>>> +
>>> +Optional nodes:
>>> +
>>> +* GPIO eXpander
>>> +MFX provides 16 programmable GPIOs, and it is also possible to recover 8
>>> +alternate GPIOs if the main functions are not used (touchscreen controller and
>>> +IDD measurement not enabled).
>>> +
>>> +Required properties:
>>> +- compatible : must be "st,mfx-gpio"
>>> +- interrupt-parent : must be <&mfx>
>>
>> Not necessary. A parent node with 'interrupt-controller' property is the
>> interrupt's parent.
>>
> I will keep it in mind.
>>> +- interrupts = must be <0>
>>> +- gpio-controller: marks the device node as a GPIO controller
>>> +- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
>>> +  controller, the second cell is the gpio flags in accordance with
>>> +  <dt-bindings/gpio/st-mfx-gpio.h>.
>>
>> Custom flags? Use standard flags.
>>
>> DT binding headers should be part of this patch.
>>
> Custom flags because MFX GPIOs have several types:
> - Output open drain with internal pull-up resistor
> - Output open drain without internal pull-up resistor
> - Output push pull without internal pull resistor
> - Input with internal pull-up resistor
> - Input with internal pull-down resistor
> - Input floating
> - Input analog.
> Standard flags don't have pull up or down information. That's why I am
> using custom flags, they overloads standard flags.

I'll leave this one to Linus to comment on.

> I will add DT bindings header in this patch V2.
