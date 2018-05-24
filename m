Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969956AbeEXMSn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:18:43 -0400
Received: from gloria.sntech.de ([95.129.55.99]:34536 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969905AbeEXMSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:18:39 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Levin Du <djw@t-chip.com.cn>
Cc: Rob Herring <robh@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
Date: Thu, 24 May 2018 14:18:24 +0200
Message-ID: <2373122.g04ZbCo5Dh@phil>
In-Reply-To: <860b225a-94e0-c3cb-94c2-5e354e0ccb1f@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn> <CAL_Jsq+VBspzCaLD2Wy=fyC-S+LKGZbVsB+b+Etkx91ioXOCuQ@mail.gmail.com> <860b225a-94e0-c3cb-94c2-5e354e0ccb1f@t-chip.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Levin,

Am Donnerstag, 24. Mai 2018, 03:59:36 CEST schrieb Levin Du:
> Hi all, I'd like to quote reply of Robin Murphy at
>   http://lists.infradead.org/pipermail/linux-rockchip/2018-May/020619.html
> 
> >
> > I would suggest s/pin number/bit number in the associated GRF register/
> > here. At least in this RK3328 case there's only one pin, which isn't
> > numbered, and if you naively considered it pin 0 of this 'bank' you'd
> > already have the wrong number. Since we're dealing with the "random
> > SoC-specific controls" region of the GRF as opposed to the
> > relatively-consistent and organised pinmux parts, I don't think we
> > should rely on any assumptions about how things are laid out.
> >
> > I was initially going to suggest a more specific compatible string as
> > well, but on reflection I think the generic "rockchip,gpio-syscon" for
> > basic "flip this single GRF bit" functionality actually is the right way
> > to go. In the specific RK3328 GPIO_MUTE case, there look to be 4 bits in
> > total related to this pin - the enable, value, and some pull controls
> > (which I assume apply when the output is disabled) - if at some point in
> > future we *did* want to start explicitly controlling the rest of them
> > too, then would be a good time to define a separate
> > "rockchip,rk3328-gpio-mute" binding (and probably a dedicated driver)
> > for that specialised functionality, independently of this basic one.
> 
> 
> Shall we go the generic "rockchip,gpio-syscon" way, or the specific
>   "rockchip,rk3328-gpio-mute" way? I prefer the former one.
> 
> The property of "gpio,syscon-dev" in gpio-syscon driver should be 
> documented.
> Since the gpio controller is defined in the dtsi file, which inevitably 
> contains voodoo
> register addresses. But at the board level dts file, there won't be more 
> register
> addresses.

Past experience shows that the GRF is not really suitable for
generalization, as it's more of a dumping ground where chip designers
can put everything that's left over. This is especially true for
GRF_SOC_CONx registers, that really only contain pretty random bits.

So personally, I'd really prefer soc-specific compatibles as everywhere
else, instead of trying to push stuff into the devicetree that won't hold
up on future socs.


> On 2018-05-24 3:53 AM, Rob Herring wrote:
> > On Wed, May 23, 2018 at 10:12 AM, Heiko Stübner <heiko@sntech.de> wrote:
> >> Hi Rob, Levin,
> >>
> >> sorry for being late to the party.
> >>
> >> Am Mittwoch, 23. Mai 2018, 16:43:07 CEST schrieb Rob Herring:
> >>> On Tue, May 22, 2018 at 9:02 PM, Levin Du <djw@t-chip.com.cn> wrote:
> >>>> On 2018-05-23 2:02 AM, Rob Herring wrote:
> >>>>> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
> >>>>>> From: Levin Du <djw@t-chip.com.cn>
> >>>>>>
> >>>>>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
> >>>>>> which do not belong to the general pinctrl.
> >>>>>>
> >>>>>> Adding gpio-syscon support makes controlling regulator or
> >>>>>> LED using these special pins very easy by reusing existing
> >>>>>> drivers, such as gpio-regulator and led-gpio.
> >>>>>>
> >>>>>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> >>>>>>
> >>>>>> ---
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>> - Rename gpio_syscon10 to gpio_mute in doc
> >>>>>>
> >>>>>> Changes in v1:
> >>>>>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> >>>>>> - Add doc rockchip,gpio-syscon.txt
> >>>>>>
> >>>>>>    .../bindings/gpio/rockchip,gpio-syscon.txt         | 41
> >>>>>>
> >>>>>> ++++++++++++++++++++++
> >>>>>>
> >>>>>>    drivers/gpio/gpio-syscon.c                         | 30
> >>>>>>
> >>>>>> ++++++++++++++++
> >>>>>>
> >>>>>>    2 files changed, 71 insertions(+)
> >>>>>>    create mode 100644
> >>>>>>
> >>>>>> Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>>>>>
> >>>>>> diff --git
> >>>>>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>>>>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>>>>> new file mode 100644
> >>>>>> index 0000000..b1b2a67
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>>>>> @@ -0,0 +1,41 @@
> >>>>>> +* Rockchip GPIO support for GRF_SOC_CON registers
> >>>>>> +
> >>>>>> +Required properties:
> >>>>>> +- compatible: Should contain "rockchip,gpio-syscon".
> >>>>>> +- gpio-controller: Marks the device node as a gpio controller.
> >>>>>> +- #gpio-cells: Should be two. The first cell is the pin number and
> >>>>>> +  the second cell is used to specify the gpio polarity:
> >>>>>> +    0 = Active high,
> >>>>>> +    1 = Active low.
> >>>>> There's no need for this child node. Just make the parent node a gpio
> >>>>> controller.
> >>>>>
> >>>>> Rob
> >>>> Hi Rob, it is not clear to me. Do you suggest that the grf node should be
> >>>> a
> >>>> gpio controller,
> >>>> like below?
> >>>>
> >>>> +    grf: syscon at ff100000 {
> >>>> +        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf",
> >>>> "syscon", "simple-mfd";
> >>> Yes, but drop "rockchip,gpio-syscon" and "simple-mfd".
> >> I would disagree quite a bit here. The grf are the "general register files",
> >> a bunch of registers used for quite a lot of things, and so it seems
> >> among other users, also a gpio-controller for some more random pins
> >> not controlled through the regular gpio controllers.
> >>
> >> For a more fully stocked grf, please see
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rk3288.dtsi#n855
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n1338
> >>
> >> So the gpio controller should definitly also be a subnode.
> > Sigh, yes, if there are a bunch of functions needing subnodes like the
> > above, then yes that makes sense. But that's not what has been
> > presented. Please make some attempt at defining *all* the functions.
> > An actual binding would be nice, but I'll settle for just a list of
> > things. The list should have functions that have DT dependencies (like
> > clocks for phys in the above) because until you do, you don't need
> > child nodes.
> 
> In rk3328.dtsi file, there are lots of line "rockchip,grf = <&grf>;" in 
> various nodes,
> such as tsadc,  cru, gmac2io, gmac2phy, and also pinctrl, which are not 
> sub nodes of
> `grf`, but for reference only. The gpio-syscon node should also have 
> similar behavior.
>   They are not strongly coupled. The gpio-syscon node should be defined 
> outside of the
> `grf` node.

Not necessarily.

I.e. things like the tsadc, cru etc have their own register space and only
some minor additional bits inside the GRF.

Other things like some phys and your mute-gpio are _fully embedded_ inside
the GRF and thus become child devices. This describes the hardware layout
way better, helps unclutter the devicetree and also shows this distinction
between "additional bits" and "embedded" clearly.


Heiko
