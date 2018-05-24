Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935449AbeEXCAC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 22:00:02 -0400
Received: from regular1.263xmail.com ([211.150.99.131]:42414 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935126AbeEXB77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:59:59 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: djw@t-chip.com.cn
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 59.33.100.150
X-LOGIN-NAME: djw@t-chip.com.cn
X-UNIQUE-TAG: <046e582b68c403b7802518c52e56d36c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 7
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
To: Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
 <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
 <1685755.J6GI985WX3@diego>
 <CAL_Jsq+VBspzCaLD2Wy=fyC-S+LKGZbVsB+b+Etkx91ioXOCuQ@mail.gmail.com>
From: Levin Du <djw@t-chip.com.cn>
Message-ID: <860b225a-94e0-c3cb-94c2-5e354e0ccb1f@t-chip.com.cn>
Date: Thu, 24 May 2018 09:59:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+VBspzCaLD2Wy=fyC-S+LKGZbVsB+b+Etkx91ioXOCuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I'd like to quote reply of Robin Murphy at
  http://lists.infradead.org/pipermail/linux-rockchip/2018-May/020619.html

>
> I would suggest s/pin number/bit number in the associated GRF register/
> here. At least in this RK3328 case there's only one pin, which isn't
> numbered, and if you naively considered it pin 0 of this 'bank' you'd
> already have the wrong number. Since we're dealing with the "random
> SoC-specific controls" region of the GRF as opposed to the
> relatively-consistent and organised pinmux parts, I don't think we
> should rely on any assumptions about how things are laid out.
>
> I was initially going to suggest a more specific compatible string as
> well, but on reflection I think the generic "rockchip,gpio-syscon" for
> basic "flip this single GRF bit" functionality actually is the right way
> to go. In the specific RK3328 GPIO_MUTE case, there look to be 4 bits in
> total related to this pin - the enable, value, and some pull controls
> (which I assume apply when the output is disabled) - if at some point in
> future we *did* want to start explicitly controlling the rest of them
> too, then would be a good time to define a separate
> "rockchip,rk3328-gpio-mute" binding (and probably a dedicated driver)
> for that specialised functionality, independently of this basic one.


Shall we go the generic "rockchip,gpio-syscon" way, or the specific
  "rockchip,rk3328-gpio-mute" way? I prefer the former one.

The property of "gpio,syscon-dev" in gpio-syscon driver should be 
documented.
Since the gpio controller is defined in the dtsi file, which inevitably 
contains voodoo
register addresses. But at the board level dts file, there won't be more 
register
addresses.

On 2018-05-24 3:53 AM, Rob Herring wrote:
> On Wed, May 23, 2018 at 10:12 AM, Heiko Stübner <heiko@sntech.de> wrote:
>> Hi Rob, Levin,
>>
>> sorry for being late to the party.
>>
>> Am Mittwoch, 23. Mai 2018, 16:43:07 CEST schrieb Rob Herring:
>>> On Tue, May 22, 2018 at 9:02 PM, Levin Du <djw@t-chip.com.cn> wrote:
>>>> On 2018-05-23 2:02 AM, Rob Herring wrote:
>>>>> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
>>>>>> From: Levin Du <djw@t-chip.com.cn>
>>>>>>
>>>>>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
>>>>>> which do not belong to the general pinctrl.
>>>>>>
>>>>>> Adding gpio-syscon support makes controlling regulator or
>>>>>> LED using these special pins very easy by reusing existing
>>>>>> drivers, such as gpio-regulator and led-gpio.
>>>>>>
>>>>>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Rename gpio_syscon10 to gpio_mute in doc
>>>>>>
>>>>>> Changes in v1:
>>>>>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>>>>>> - Add doc rockchip,gpio-syscon.txt
>>>>>>
>>>>>>    .../bindings/gpio/rockchip,gpio-syscon.txt         | 41
>>>>>>
>>>>>> ++++++++++++++++++++++
>>>>>>
>>>>>>    drivers/gpio/gpio-syscon.c                         | 30
>>>>>>
>>>>>> ++++++++++++++++
>>>>>>
>>>>>>    2 files changed, 71 insertions(+)
>>>>>>    create mode 100644
>>>>>>
>>>>>> Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>>>>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..b1b2a67
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>>>>> @@ -0,0 +1,41 @@
>>>>>> +* Rockchip GPIO support for GRF_SOC_CON registers
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: Should contain "rockchip,gpio-syscon".
>>>>>> +- gpio-controller: Marks the device node as a gpio controller.
>>>>>> +- #gpio-cells: Should be two. The first cell is the pin number and
>>>>>> +  the second cell is used to specify the gpio polarity:
>>>>>> +    0 = Active high,
>>>>>> +    1 = Active low.
>>>>> There's no need for this child node. Just make the parent node a gpio
>>>>> controller.
>>>>>
>>>>> Rob
>>>> Hi Rob, it is not clear to me. Do you suggest that the grf node should be
>>>> a
>>>> gpio controller,
>>>> like below?
>>>>
>>>> +    grf: syscon at ff100000 {
>>>> +        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf",
>>>> "syscon", "simple-mfd";
>>> Yes, but drop "rockchip,gpio-syscon" and "simple-mfd".
>> I would disagree quite a bit here. The grf are the "general register files",
>> a bunch of registers used for quite a lot of things, and so it seems
>> among other users, also a gpio-controller for some more random pins
>> not controlled through the regular gpio controllers.
>>
>> For a more fully stocked grf, please see
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rk3288.dtsi#n855
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n1338
>>
>> So the gpio controller should definitly also be a subnode.
> Sigh, yes, if there are a bunch of functions needing subnodes like the
> above, then yes that makes sense. But that's not what has been
> presented. Please make some attempt at defining *all* the functions.
> An actual binding would be nice, but I'll settle for just a list of
> things. The list should have functions that have DT dependencies (like
> clocks for phys in the above) because until you do, you don't need
> child nodes.

In rk3328.dtsi file, there are lots of line "rockchip,grf = <&grf>;" in 
various nodes,
such as tsadc,  cru, gmac2io, gmac2phy, and also pinctrl, which are not 
sub nodes of
`grf`, but for reference only. The gpio-syscon node should also have 
similar behavior.
  They are not strongly coupled. The gpio-syscon node should be defined 
outside of the
`grf` node.


>
>> The gpio in question is called "mute", so I'd think the gpio-syscon driver
>> should just define a "rockchip,rk3328-gpio-mute" compatible and contain
>> all the register voodoo in the driver itself and not define it in the dt.
> Is there really just one GPIO? If it has a defined function, then is
> it really GP? Can you control direction? I know Linus W doesn't like
> that kind of abuse of GPIO.

The "mute" pin is a output only GPIO, which is already supported by 
setting flags in the gpio-syscon
  driver. And yes, this pin has a defined function, but can also be used 
for general purpose operation.


Thanks
Levin
