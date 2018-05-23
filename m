Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933369AbeEWOnb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933199AbeEWOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:43:29 -0400
X-Google-Smtp-Source: AB8JxZqppVJZSS2IlWV4C/ynZ0MCWzbROEbi7suymlic8dyrC0jarcz3NtKjD8TsNKh9mD2S29XcwXoXuZ6PQMIFZkA=
MIME-Version: 1.0
In-Reply-To: <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn> <1526615528-9707-2-git-send-email-djw@t-chip.com.cn>
 <20180522180238.GA7328@rob-hp-laptop> <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 May 2018 09:43:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
Message-ID: <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
To: Levin Du <djw@t-chip.com.cn>
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

On Tue, May 22, 2018 at 9:02 PM, Levin Du <djw@t-chip.com.cn> wrote:
> On 2018-05-23 2:02 AM, Rob Herring wrote:
>>
>> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
>>>
>>> From: Levin Du <djw@t-chip.com.cn>
>>>
>>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
>>> which do not belong to the general pinctrl.
>>>
>>> Adding gpio-syscon support makes controlling regulator or
>>> LED using these special pins very easy by reusing existing
>>> drivers, such as gpio-regulator and led-gpio.
>>>
>>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Rename gpio_syscon10 to gpio_mute in doc
>>>
>>> Changes in v1:
>>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>>> - Add doc rockchip,gpio-syscon.txt
>>>
>>>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41
>>> ++++++++++++++++++++++
>>>   drivers/gpio/gpio-syscon.c                         | 30
>>> ++++++++++++++++
>>>   2 files changed, 71 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>> new file mode 100644
>>> index 0000000..b1b2a67
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>> @@ -0,0 +1,41 @@
>>> +* Rockchip GPIO support for GRF_SOC_CON registers
>>> +
>>> +Required properties:
>>> +- compatible: Should contain "rockchip,gpio-syscon".
>>> +- gpio-controller: Marks the device node as a gpio controller.
>>> +- #gpio-cells: Should be two. The first cell is the pin number and
>>> +  the second cell is used to specify the gpio polarity:
>>> +    0 = Active high,
>>> +    1 = Active low.
>>
>> There's no need for this child node. Just make the parent node a gpio
>> controller.
>>
>> Rob
>
> Hi Rob, it is not clear to me. Do you suggest that the grf node should be a
> gpio controller,
> like below?
>
> +    grf: syscon at ff100000 {
> +        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf",
> "syscon", "simple-mfd";

Yes, but drop "rockchip,gpio-syscon" and "simple-mfd".

> +        //...
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio,syscon-dev = <&grf 0x0428 0>;

And drop this. It may be used in the kernel, but it is not a
documented property.

> +    };
>
> or just reserve the following case in the doc?
>
> +    grf: syscon at ff100000 {
> +        compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> +        //...
> +    };
> +
> +    gpio_mute: gpio-mute {
> +        compatible = "rockchip,gpio-syscon";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio,syscon-dev = <&grf 0x0428 0>;
> +    };
>
>
> Thanks
> Levin
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
