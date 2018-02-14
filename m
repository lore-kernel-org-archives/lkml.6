Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966687AbeBNDPS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 22:15:18 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39733 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966600AbeBNDPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 22:15:16 -0500
X-Google-Smtp-Source: AH8x224Pu0Hrvw0nLiJz2AGj/KTpZq9U79KoBA5fT3uep+Ty3wiGbSBsiaV4sTv0khh3oQuXpfk0v7IMmpqdDtQl3Z0=
MIME-Version: 1.0
In-Reply-To: <20180213233945.55mfqpydfxmimak2@rob-hp-laptop>
References: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
 <20180213233945.55mfqpydfxmimak2@rob-hp-laptop>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 14 Feb 2018 11:15:15 +0800
Message-ID: <CAMz4ku+btJkpfE1BvZuuUSHVmiydsJ2i=0dePQocx67DKip8yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: Add Spreadtrum EIC controller documentation
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 14 February 2018 at 07:39, Rob Herring <robh@kernel.org> wrote:
> On Thu, Feb 08, 2018 at 04:01:42PM +0800, Baolin Wang wrote:
>> This patch adds the device tree bindings for the Spreadtrum EIC
>> controller. The EIC can be recognized as one special type of GPIO,
>> which can only be used as input.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../devicetree/bindings/gpio/gpio-eic-sprd.txt     |   51 ++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
>> new file mode 100644
>> index 0000000..34f194f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
>> @@ -0,0 +1,51 @@
>> +Spreadtrum EIC controller bindings
>> +
>> +The EIC is the abbreviation of external interrupt controller, which
>> +is only can be used as input mode. The EIC controller includes 4
>> +sub-modules: EIC-Debounce, EIC-Latch, EIC-Async, EIC-Sync.
>> +
>> +The EIC-debounce sub-module provides up to 8 source input signal
>> +connection. A debounce machanism is used to capture input signal's
>> +stable status (ms grade) and a single-trigger mechanism is introduced
>> +into this sub-module to enhance the input event detection reliability.
>> +In addition, this sub-module's clock can be shut-off automatically to
>> +reduce power dissipation. The debounce range is from 1ms to 4s with
>> +the step of 1ms. If the input signal is shorter than 1ms, it will be
>> +omitted as this sub-module.
>> +
>> +The EIC-latch sub-module is used to latch some special input signal
>> +and send interrupts to MCU core, and it can provide up to 8 latch
>> +source input signal connection.
>> +
>> +The EIC-async sub-module uses 32k clock to capture short signal (us
>> +grade) to generate interrupt to MCU by level or edge trigger.
>> +
>> +The EIC-sync is similar with GPIO's input function.
>> +
>> +Required properties:
>> +- compatible: Should be one of the following:
>> +  "sprd,sc9860-eic-debounce",
>> +  "sprd,sc9860-eic-latch",
>> +  "sprd,sc9860-eic-async",
>> +  "sprd,sc9860-eic-sync",
>> +  "sprd,sc27xx-eic-debounce".
>> +- reg: Define the base and range of the I/O address space containing
>> +  the GPIO controller registers.
>> +- gpio-controller: Marks the device node as a GPIO controller.
>
> Why a gpio controller? Do you read the input pin state?

We always regard it as GPIO except it only can be used as input mode.
Like debounce eic, we still need request it before using it.

>
>> +- #gpio-cells: Should be <2>. The first cell is the gpio number and
>> +  the second cell is used to specify optional parameters.
>> +- interrupt-controller: Marks the device node as an interrupt controller.
>> +- #interrupt-cells: Should be <2>. Specifies the number of cells needed
>> +  to encode interrupt source.
>> +- interrupts: Should be the port interrupt shared by all the gpios.
>> +
>> +Example:
>> +     eic_debounce: eic@40210000 {
>
> interrupt-controller@...
>
> Or (if this remains a gpio controller)
>
> gpio@...

OK.

>
>> +             compatible = "sprd,sc9860-eic-debounce";
>> +             reg = <0 0x40210000 0 0x80>;
>> +             gpio-controller;
>> +             #gpio-cells = <2>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <2>;
>> +             interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>
> The example doesn't seem to match your description of the block or
> blocks. You talk about a bunch of sub modules and then there's just this
> one node?

I just list one as one example, and I will list all of them in next
version. Thanks.

-- 
Baolin.wang
Best Regards
