Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeFARDu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752687AbeFARDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:03:44 -0400
X-Google-Smtp-Source: ADUXVKLAKVn1Cgs4WkaXLHPflbohMaTdY3hEkqRzaEp6CYXvghtoZv8GBxnmzRQgANgvHg0b2+y12FB5vpYj8n3zDGs=
MIME-Version: 1.0
In-Reply-To: <0d08ba26-77f2-6c42-8fb1-214aaf6085e9@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
 <1527737273-8387-3-git-send-email-djw@t-chip.com.cn> <CAL_JsqJK4vrmLBeN_ZeGCXAyqshshL16B0KN_+8uvt+=-O9TEw@mail.gmail.com>
 <0d08ba26-77f2-6c42-8fb1-214aaf6085e9@t-chip.com.cn>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 1 Jun 2018 12:03:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSy4q5dfVfXbRMLa7koTWufpAt3yNdE-9mwyJ-VzVQRQ@mail.gmail.com>
Message-ID: <CAL_JsqKSy4q5dfVfXbRMLa7koTWufpAt3yNdE-9mwyJ-VzVQRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: syscon: rockchip: add GPIO_MUTE support for rk3328
To: Levin <djw@t-chip.com.cn>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 9:05 PM, Levin <djw@t-chip.com.cn> wrote:
> Hi Rob,
>
>
> On 2018-05-31 10:45 PM, Rob Herring wrote:
>>
>> On Wed, May 30, 2018 at 10:27 PM,  <djw@t-chip.com.cn> wrote:
>>>
>>> From: Levin Du <djw@t-chip.com.cn>
>>>
>>> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
>>> mute control, can also be used for general purpose. It is manipulated by
>>> the GRF_SOC_CON10 register.
>>>
>>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> - Change from general gpio-syscon to specific rk3328-gpio-mute
>>>
>>> Changes in v2:
>>> - Rename gpio_syscon10 to gpio_mute in doc
>>>
>>> Changes in v1:
>>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>>> - Add doc rockchip,gpio-syscon.txt
>>>
>>>   .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28
>>> +++++++++++++++++++
>>>   drivers/gpio/gpio-syscon.c                         | 31
>>> ++++++++++++++++++++++
>>>   2 files changed, 59 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>> b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>> new file mode 100644
>>> index 0000000..10bc632
>>> --- /dev/null
>>> +++
>>> b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>>> @@ -0,0 +1,28 @@
>>> +Rockchip RK3328 GPIO controller dedicated for the GPIO_MUTE pin.
>>> +
>>> +In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
>>> mute
>>> +control, can also be used for general purpose. It is manipulated by the
>>> +GRF_SOC_CON10 register.
>>> +
>>> +Required properties:
>>> +- compatible: Should contain "rockchip,rk3328-gpio-mute".
>>> +- gpio-controller: Marks the device node as a gpio controller.
>>> +- #gpio-cells: Should be 2. The first cell is the pin number and
>>> +  the second cell is used to specify the gpio polarity:
>>> +    0 = Active high,
>>> +    1 = Active low.
>>> +
>>> +Example:
>>> +
>>> +       grf: syscon@ff100000 {
>>> +               compatible = "rockchip,rk3328-grf", "syscon",
>>> "simple-mfd";
>>> +
>>> +               gpio_mute: gpio-mute {
>>
>> Node names should be generic:
>>
>> gpio {
>>
>> This also means you can't add another GPIO node in the future and
>> you'll have to live with "rockchip,rk3328-gpio-mute" covering more
>> than 1 GPIO if you do need to add more GPIOs.
>
>
> As the first line describes, this GPIO controller is dedicated for the
> GPIO_MUTE pin.
> There's only one GPIO pin in the GRF_SOC_CON10 register. Therefore the
> gpio_mute
> name is proper IMHO.

It's how many GPIOs in the GRF, not this register. What I'm saying is
when you come along later to add another GPIO in the GRF, you had
better just add it to this same node. I'm not going to accept another
GPIO controller node within the GRF. You have the cells to support
more than 1, so it would only be a driver change. The compatible
string would then not be ideally named at that point. But compatible
strings are just unique identifiers, so it doesn't really matter what
the string is.

I'm being told both "this is the only GPIO" and "the GRF has too many
different functions for us to tell you what they all are". So which is
it?

Rob
