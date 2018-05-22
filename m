Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeEVN40 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:56:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52287 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeEVN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:56:24 -0400
Message-ID: <1526997363.3671.25.camel@pengutronix.de>
Subject: Re: [reset-control] How to initialize hardware state with the
 shared reset line?
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date: Tue, 22 May 2018 15:56:03 +0200
In-Reply-To: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
References: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Thu, 2018-05-10 at 18:16 +0900, Masahiro Yamada wrote:
> Hi.
> 
> 
> The previous thread was:
> "usb: dwc3: support clocks and resets for DWC3 core"
> https://patchwork.kernel.org/patch/10349623/
> 
> 
> I changed the subject because
> I think this is rather reset-control topic than USB.

Thank you for taking the time to write this up in such detail.

Indeed we were not expecting hardware that both defaults to deasserted
resets and does not have a power-on reset mechanism for the IP cores, so
yes, the framework currently assumes that all shared reset lines are
initially (or at some point in the past since power-on were) asserted.

I wonder if we are going to see this more often in the future, or
whether the Amlogic Meson SoCs will stay the exception.

> I am searching for a good way to initialize hardware devices
> in the following situation:
> 
>  - two or more hardware devices share the same reset line

So in general, at least during runtime, the driver must not expect reset
assertion to actually work, so the sharing device is not disturbed.

>  - those devices are not reset before booting the kernel
>    (i.e. flip flops in RTL are random state at driver probe)
> 
>  - the hardware IP is used by various SoCs,
>    and this issue only appears only on some.

Unfortunately for configurable IP cores like the DW ones I am not sure
to what extent these can actually be considered identical when
implemented in different SoCs.
I would expect that the hardware IP's basic requirements, like whether
the reset must be asserted at some defined point during operation, or
whether it has to be a pulse of da specific duration, does not change
between implementations.

> Specifically, the DWC3 USB IP case is in my mind,
> but this should apply to any hardware in general.
> 
> 
> 
> 
> Issue in detail
> ---------------
> 
> The DWC3 USB IP is very popular and used by various SoCs
> as you see in drivers/usb/dwc3/.
> 
> SoCs are using the same RTL as provided by Synopsys.
> (SoC vendors could tweak the RTL if they like,
> but it would rarely happen because it would just be troublesome)
> 
> So, let's assume we use the same IP with the same RTL version.
> It is *compatible* in terms of device tree.
> In this case, we should avoid differentiating the driver code per-SoC.
> 
> In fact, we ended up with
> commit ff0a632 ("usb: dwc3: of-simple: add support for shared and
> pulsed reset lines")
> commit e8284db ("usb: dwc3: of-simple: add support for the Amlogic
> Meson GXL and AXG SoCs")

I'm surprised, didn't all Meson SoCs gain level reset support for this
purpose?
I agree this should not be needed in the drivers, and I'd be very happy
if we could make this work on Meson with the dwc3 driver always
requesting shared resets.

> This means, the difference that comes from the reset _provider_
> must be implemented in the reset _consumer_.
> This is unfortunate.

I am not entirely happy about the shared vs. exclusive naming of the
API, but I have no better names. By choosing between the two, the
driver states its requirements of the API, not whether the SoC it is
implemented in actually shares the reset line with other devices.

> So, I wonder if we can support it in sub-system level somehow
> instead of messing up the reset consumer driver.

I'd like to deflect and, hoping that this is an exception, ask whether
we could just do this in the driver?

>  - The reset topology is SoC-dependent.
>    A reset line is dedicated for single hardware for some SoCs,
>    and shared by multiple hardware for others.

In which case the driver must be able to cope with shared reset lines,
so it should use the shared reset API.

>  - The reset policy (pulse reset, level reset, or both of them)
>    are SoC-dependent (reset controller dependent).

While that may be the case for some hardware IP, I don't think it is the
case for the dwc3 driver. It doesn't need to assert the reset at any
time during normal operation, and it works with level resets. The
pulsed/exclusive reset handling really is just a workaround for the
missing power-on reset.

> RTL generally contains state machines.
> The initial state of flip flops are undefined on power-on
> hence the initial state of state machines are also undefined.
> 
> So, digital circuits needs explicit reset in general.
> 
> In some cases, the reset is performed before booting the kernel.
> 
>  - power-on reset
>    (FFs are put into defined state on power-on automatically)
> 
>  - a reset controller assert reset lines by default
>    (FFs are fixed to defined state.  If a reset consumer
>    driver deasserts the reset line, HW starts from the define state)
> 
>  - Firmware may reset the hardware before booting the kernel
> 
> 
> If nothing above is done, and the reset line is shared by multiple devices,
> we do not have a good way to put the hardware into the sane state.
> 
> 
> Reset consumers choose the required reset type:
> 
> - Shared reset:
>     reset_control_assert / reset_control_deassert work like
> clock_disable / clock_enable.
>     The consumer must be tolerant to the situation where the HW may
> not reset-asserted.
> 
> - Exclusive reset:
>     It is guaranteed reset_control_assert() really asserts the reset line,
>     but only one reset consumer grabs the reset line at the same time.

Yes. The last part is a limitation of the current framework
implementation, but one that I'd like to keep as long as possible.

To support shared resets with guaranteed assertion, we'd need a
notification framework with a possibility for drivers to temporarily
suspend their own operations to allow a reset request from a different
device, or to veto reset requests if that is not possible. And drivers
that try to reset need to properly handle failed or deferred reset
requests. That would introduce a level of complexity that I'd very much
like to avoid.

> As above, the state machines in digital circuits must start from a
> defined state.
> So, we want exclusive reset to reset the FFs.
> However, this is too much requirement
> since it is a reset line is often shared.

For missing power-on resets, what we really want is not "exclusive
reset", and not even "guaranteed reset assertion". We want that after
the initial reset_deassert, the reset line is deasserted and the device
has been in reset *at any point in the past* since power-on.

> How to save such an Amlogic case?

I think this case can be solved by either just initializing the reset
lines to asserted in the reset controller driver (in which case the
controller driver needs to know about which lines have to be asserted,
and needs to support assert/deassert ops) or by adding a fallback from
.deassert to .reset for reset controllers that don't have level reset
hardware support. That is, if the first driver calls
reset_control_deassert, the reset controller driver actually issues a
reset pulse.

> Hogging solve the problem?
> --------------------------
> 
> 
> I was thinking of a solution.
> 
> I may be missing something, but
> one solution might be reset hogging on the
> reset provider side.  This allows us to describe
> the initial state of reset lines in the reset controller.
> 
> The idea for "reset-hog" is similar to:
>  - "gpio-hog" defined in
>    Documentation/devicetree/bindings/gpio/gpio.txt
>  - "assigned-clocks" defined in
>    Documetation/devicetree/bindings/clock/clock-bindings.txt
> 
> 
> 
> For example,
> 
>    reset-controller {
>             ....
> 
>             line_a {
>                   reset-hog;
>                   resets = <1>;
>                   reset-assert;
>             };
>    }
> 
> 
> When the reset controller is registered,
> the reset ID '1' is asserted.
> 
> 
> So, all reset consumers that share the reset line '1'
> will start from the asserted state
> (i.e. defined state machine state).
> 
> 
> From the discussion with Martin Blumenstingl
> (https://lkml.org/lkml/2018/4/28/115),
> the problem for Amlogic is that
> the reset line is "de-asserted" by default.
> If so, the 'reset-hog' would fix the problem,
> and DWC3 driver would be able to use
> shared, level reset, I think.
> 
> 
> I think something may be missing from my mind,
> but I hope this will prompt the discussion,
> and we will find a better idea.

My question would is: do we need this complexity, or can this be solved
by just adding a workaround in the meson driver? If a lot of SoCs using
the simple reset driver had this requirement, I'd seriously consider
this, but it currently seems to me that this is just an issue with a
single SoC family.

regards
Philipp
