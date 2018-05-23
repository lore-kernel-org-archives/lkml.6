Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbeEWPMa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:12:30 -0400
Received: from gloria.sntech.de ([95.129.55.99]:48012 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933522AbeEWPMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:12:22 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>
Cc: Levin Du <djw@t-chip.com.cn>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
Date: Wed, 23 May 2018 17:12:10 +0200
Message-ID: <1685755.J6GI985WX3@diego>
In-Reply-To: <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn> <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn> <CAL_Jsq+_QEBWdxW=J4oVGWeokc-+nMzxzX_pgCayaxg-ehivfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Levin,

sorry for being late to the party.

Am Mittwoch, 23. Mai 2018, 16:43:07 CEST schrieb Rob Herring:
> On Tue, May 22, 2018 at 9:02 PM, Levin Du <djw@t-chip.com.cn> wrote:
> > On 2018-05-23 2:02 AM, Rob Herring wrote:
> >> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
> >>> From: Levin Du <djw@t-chip.com.cn>
> >>> 
> >>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
> >>> which do not belong to the general pinctrl.
> >>> 
> >>> Adding gpio-syscon support makes controlling regulator or
> >>> LED using these special pins very easy by reusing existing
> >>> drivers, such as gpio-regulator and led-gpio.
> >>> 
> >>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> >>> 
> >>> ---
> >>> 
> >>> Changes in v2:
> >>> - Rename gpio_syscon10 to gpio_mute in doc
> >>> 
> >>> Changes in v1:
> >>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> >>> - Add doc rockchip,gpio-syscon.txt
> >>> 
> >>>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41
> >>> 
> >>> ++++++++++++++++++++++
> >>> 
> >>>   drivers/gpio/gpio-syscon.c                         | 30
> >>> 
> >>> ++++++++++++++++
> >>> 
> >>>   2 files changed, 71 insertions(+)
> >>>   create mode 100644
> >>> 
> >>> Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>> 
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>> new file mode 100644
> >>> index 0000000..b1b2a67
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >>> @@ -0,0 +1,41 @@
> >>> +* Rockchip GPIO support for GRF_SOC_CON registers
> >>> +
> >>> +Required properties:
> >>> +- compatible: Should contain "rockchip,gpio-syscon".
> >>> +- gpio-controller: Marks the device node as a gpio controller.
> >>> +- #gpio-cells: Should be two. The first cell is the pin number and
> >>> +  the second cell is used to specify the gpio polarity:
> >>> +    0 = Active high,
> >>> +    1 = Active low.
> >> 
> >> There's no need for this child node. Just make the parent node a gpio
> >> controller.
> >> 
> >> Rob
> > 
> > Hi Rob, it is not clear to me. Do you suggest that the grf node should be
> > a
> > gpio controller,
> > like below?
> > 
> > +    grf: syscon at ff100000 {
> > +        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf",
> > "syscon", "simple-mfd";
> 
> Yes, but drop "rockchip,gpio-syscon" and "simple-mfd".

I would disagree quite a bit here. The grf are the "general register files",
a bunch of registers used for quite a lot of things, and so it seems
among other users, also a gpio-controller for some more random pins
not controlled through the regular gpio controllers.

For a more fully stocked grf, please see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rk3288.dtsi#n855
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n1338

So the gpio controller should definitly also be a subnode.

The gpio in question is called "mute", so I'd think the gpio-syscon driver
should just define a "rockchip,rk3328-gpio-mute" compatible and contain
all the register voodoo in the driver itself and not define it in the dt.

So it should probably look like

grf: syscon at ff100000 {
        compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";

	[all the other syscon sub-devices]

	gpio_mute: gpio-mute {
		compatible = "rockchip,rk3328-gpio-mute";
		gpio-controller;
		#gpio-cells = <2>;
	};

	[more other syscon sub-devices]
};


Heiko	
	



> > +        //...
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +        gpio,syscon-dev = <&grf 0x0428 0>;
> 
> And drop this. It may be used in the kernel, but it is not a
> documented property.
> 
> > +    };
> > 
> > or just reserve the following case in the doc?
> > 
> > +    grf: syscon at ff100000 {
> > +        compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> > +        //...
> > +    };
> > +
> > +    gpio_mute: gpio-mute {
> > +        compatible = "rockchip,gpio-syscon";
> > +        gpio-controller;
> > +        #gpio-cells = <2>;
> > +        gpio,syscon-dev = <&grf 0x0428 0>;
> > +    };
> > 
> > 
> > Thanks
> > Levin
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
