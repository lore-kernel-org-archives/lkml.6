Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969676AbeEXMHc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:07:32 -0400
Received: from gloria.sntech.de ([95.129.55.99]:34242 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966644AbeEXMH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:07:26 -0400
From: Heiko Stuebner <heiko@sntech.de>
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
Date: Thu, 24 May 2018 14:07:09 +0200
Message-ID: <3307687.qJF5Pr3uHG@phil>
In-Reply-To: <CAL_Jsq+VBspzCaLD2Wy=fyC-S+LKGZbVsB+b+Etkx91ioXOCuQ@mail.gmail.com>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn> <1685755.J6GI985WX3@diego> <CAL_Jsq+VBspzCaLD2Wy=fyC-S+LKGZbVsB+b+Etkx91ioXOCuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am Mittwoch, 23. Mai 2018, 21:53:53 CEST schrieb Rob Herring:
> On Wed, May 23, 2018 at 10:12 AM, Heiko Stübner <heiko@sntech.de> wrote:
> > Am Mittwoch, 23. Mai 2018, 16:43:07 CEST schrieb Rob Herring:
> >> On Tue, May 22, 2018 at 9:02 PM, Levin Du <djw@t-chip.com.cn> wrote:
> >> > On 2018-05-23 2:02 AM, Rob Herring wrote:
> >> >> On Fri, May 18, 2018 at 11:52:05AM +0800, djw@t-chip.com.cn wrote:
> >> >>> From: Levin Du <djw@t-chip.com.cn>
> >> >>>
> >> >>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
> >> >>> which do not belong to the general pinctrl.
> >> >>>
> >> >>> Adding gpio-syscon support makes controlling regulator or
> >> >>> LED using these special pins very easy by reusing existing
> >> >>> drivers, such as gpio-regulator and led-gpio.
> >> >>>
> >> >>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> >> >>>
> >> >>> ---
> >> >>>
> >> >>> Changes in v2:
> >> >>> - Rename gpio_syscon10 to gpio_mute in doc
> >> >>>
> >> >>> Changes in v1:
> >> >>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> >> >>> - Add doc rockchip,gpio-syscon.txt
> >> >>>
> >> >>>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41
> >> >>>
> >> >>> ++++++++++++++++++++++
> >> >>>
> >> >>>   drivers/gpio/gpio-syscon.c                         | 30
> >> >>>
> >> >>> ++++++++++++++++
> >> >>>
> >> >>>   2 files changed, 71 insertions(+)
> >> >>>   create mode 100644
> >> >>>
> >> >>> Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >> >>>
> >> >>> diff --git
> >> >>> a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >> >>> b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >> >>> new file mode 100644
> >> >>> index 0000000..b1b2a67
> >> >>> --- /dev/null
> >> >>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
> >> >>> @@ -0,0 +1,41 @@
> >> >>> +* Rockchip GPIO support for GRF_SOC_CON registers
> >> >>> +
> >> >>> +Required properties:
> >> >>> +- compatible: Should contain "rockchip,gpio-syscon".
> >> >>> +- gpio-controller: Marks the device node as a gpio controller.
> >> >>> +- #gpio-cells: Should be two. The first cell is the pin number and
> >> >>> +  the second cell is used to specify the gpio polarity:
> >> >>> +    0 = Active high,
> >> >>> +    1 = Active low.
> >> >>
> >> >> There's no need for this child node. Just make the parent node a gpio
> >> >> controller.
> >> >>
> >> >> Rob
> >> >
> >> > Hi Rob, it is not clear to me. Do you suggest that the grf node should be
> >> > a
> >> > gpio controller,
> >> > like below?
> >> >
> >> > +    grf: syscon at ff100000 {
> >> > +        compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf",
> >> > "syscon", "simple-mfd";
> >>
> >> Yes, but drop "rockchip,gpio-syscon" and "simple-mfd".
> >
> > I would disagree quite a bit here. The grf are the "general register files",
> > a bunch of registers used for quite a lot of things, and so it seems
> > among other users, also a gpio-controller for some more random pins
> > not controlled through the regular gpio controllers.
> >
> > For a more fully stocked grf, please see
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/rk3288.dtsi#n855
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399.dtsi#n1338
> >
> > So the gpio controller should definitly also be a subnode.
> 
> Sigh, yes, if there are a bunch of functions needing subnodes like the
> above, then yes that makes sense. But that's not what has been
> presented. Please make some attempt at defining *all* the functions.
> An actual binding would be nice, but I'll settle for just a list of
> things. The list should have functions that have DT dependencies (like
> clocks for phys in the above) because until you do, you don't need
> child nodes.

That's the problem with the Rockchip-GRF, you only realize its content
when implementing specific features. 

Like on the rk3399 the table of the register-list of the GRF alone is 11
pages long with the register details tables taking up another 230 pages.
And functional description is often somewhat thin.

So I'm not sure I fully understand what you're asking, but in general
we define the bindings for sub-devices when tackling these individual
components, see for example
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=72580a49a837c2c7da83f698c00592eac41537d8

which also has a real phy-driver behind it and binding against that
subnode of the GRF simple-mfd.

These are real IP blocks somewhere on the socs, with regular supplies
like resets, clocks etc in most cases. Only their controlling registers
got dumped into the GRF for some reason.

And in retrospect it really looks like we're doing something right,
because it seems these bindings seem quite stable over time.


> > The gpio in question is called "mute", so I'd think the gpio-syscon driver
> > should just define a "rockchip,rk3328-gpio-mute" compatible and contain
> > all the register voodoo in the driver itself and not define it in the dt.
> 
> Is there really just one GPIO? If it has a defined function, then is
> it really GP? Can you control direction? I know Linus W doesn't like
> that kind of abuse of GPIO.

looks like I convinced Linus that we're not abusing anything with this :-) .


Heiko
