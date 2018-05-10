Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756949AbeEJJRb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 05:17:31 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:54552 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756820AbeEJJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 05:17:24 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w4A9HHi6004984
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AB8JxZragqN12G7S2JVYLa1JC1Y5aRFQiGh2IarJP0VXIdFUxDigADJlWq1tVFbQoY/SwQrg+BdlHnRq8lReDbre2gQ=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 10 May 2018 18:16:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
Message-ID: <CAK7LNATZgJ4MxOFLUCNARWv3Zz=gpL-jGReDnBnArquiaXRWoQ@mail.gmail.com>
Subject: [reset-control] How to initialize hardware state with the shared
 reset line?
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


The previous thread was:
"usb: dwc3: support clocks and resets for DWC3 core"
https://patchwork.kernel.org/patch/10349623/


I changed the subject because
I think this is rather reset-control topic than USB.


I am searching for a good way to initialize hardware devices
in the following situation:

 - two or more hardware devices share the same reset line

 - those devices are not reset before booting the kernel
   (i.e. flip flops in RTL are random state at driver probe)

 - the hardware IP is used by various SoCs,
   and this issue only appears only on some.



Specifically, the DWC3 USB IP case is in my mind,
but this should apply to any hardware in general.




Issue in detail
---------------

The DWC3 USB IP is very popular and used by various SoCs
as you see in drivers/usb/dwc3/.

SoCs are using the same RTL as provided by Synopsys.
(SoC vendors could tweak the RTL if they like,
but it would rarely happen because it would just be troublesome)

So, let's assume we use the same IP with the same RTL version.
It is *compatible* in terms of device tree.
In this case, we should avoid differentiating the driver code per-SoC.

In fact, we ended up with
commit ff0a632 ("usb: dwc3: of-simple: add support for shared and
pulsed reset lines")
commit e8284db ("usb: dwc3: of-simple: add support for the Amlogic
Meson GXL and AXG SoCs")


This means, the difference that comes from the reset _provider_
must be implemented in the reset _consumer_.
This is unfortunate.

So, I wonder if we can support it in sub-system level somehow
instead of messing up the reset consumer driver.

 - The reset topology is SoC-dependent.
   A reset line is dedicated for single hardware for some SoCs,
   and shared by multiple hardware for others.

 - The reset policy (pulse reset, level reset, or both of them)
   are SoC-dependent (reset controller dependent).



RTL generally contains state machines.
The initial state of flip flops are undefined on power-on
hence the initial state of state machines are also undefined.

So, digital circuits needs explicit reset in general.

In some cases, the reset is performed before booting the kernel.

 - power-on reset
   (FFs are put into defined state on power-on automatically)

 - a reset controller assert reset lines by default
   (FFs are fixed to defined state.  If a reset consumer
   driver deasserts the reset line, HW starts from the define state)

 - Firmware may reset the hardware before booting the kernel


If nothing above is done, and the reset line is shared by multiple devices,
we do not have a good way to put the hardware into the sane state.


Reset consumers choose the required reset type:

- Shared reset:
    reset_control_assert / reset_control_deassert work like
clock_disable / clock_enable.
    The consumer must be tolerant to the situation where the HW may
not reset-asserted.

- Exclusive reset:
    It is guaranteed reset_control_assert() really asserts the reset line,
    but only one reset consumer grabs the reset line at the same time.


As above, the state machines in digital circuits must start from a
defined state.
So, we want exclusive reset to reset the FFs.
However, this is too much requirement
since it is a reset line is often shared.


How to save such an Amlogic case?


Hogging solve the problem?
--------------------------


I was thinking of a solution.

I may be missing something, but
one solution might be reset hogging on the
reset provider side.  This allows us to describe
the initial state of reset lines in the reset controller.

The idea for "reset-hog" is similar to:
 - "gpio-hog" defined in
   Documentation/devicetree/bindings/gpio/gpio.txt
 - "assigned-clocks" defined in
   Documetation/devicetree/bindings/clock/clock-bindings.txt



For example,

   reset-controller {
            ....

            line_a {
                  reset-hog;
                  resets = <1>;
                  reset-assert;
            };
   }


When the reset controller is registered,
the reset ID '1' is asserted.


So, all reset consumers that share the reset line '1'
will start from the asserted state
(i.e. defined state machine state).


>From the discussion with Martin Blumenstingl
(https://lkml.org/lkml/2018/4/28/115),
the problem for Amlogic is that
the reset line is "de-asserted" by default.
If so, the 'reset-hog' would fix the problem,
and DWC3 driver would be able to use
shared, level reset, I think.


I think something may be missing from my mind,
but I hope this will prompt the discussion,
and we will find a better idea.

Thanks.

-- 
Best Regards
Masahiro Yamada
