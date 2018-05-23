Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeEWGw7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:52:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40163 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753985AbeEWGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:52:57 -0400
X-Google-Smtp-Source: ADUXVKLeEbS8NNXkTFKkWg2yLBNNnJia2AglCTeA9zYiZY5BNPfwOfsul3VSP9pvB/bmjldSVWb5UhGOFw/iPE7AlYM=
MIME-Version: 1.0
References: <1526983321-41949-1-git-send-email-michel.pollet@bp.renesas.com>
 <1526983321-41949-4-git-send-email-michel.pollet@bp.renesas.com> <20180522160913.GA7755@rob-hp-laptop>
In-Reply-To: <20180522160913.GA7755@rob-hp-laptop>
From: M P <buserror@gmail.com>
Date: Wed, 23 May 2018 07:52:45 +0100
Message-ID: <CAMMfpEwn3+fCZZZ8ADNxjun+jzNSnH+8xPcA8OUS_jPUJ-o6LA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] dt-bindings: clock: renesas,rzn1-clocks: document
 RZ/N1 clock driver
To: robh@kernel.org
Cc: michel.pollet@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        horms@verge.net.au, Phil Edworthy <phil.edworthy@renesas.com>,
        buserror+upstream@gmail.com, magnus.damm@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 22 May 2018 at 17:09, Rob Herring <robh@kernel.org> wrote:

> On Tue, May 22, 2018 at 11:01:23AM +0100, Michel Pollet wrote:
> > The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
> > to provide the SoC clock infrastructure for Linux.
> >
> > This documents the driver bindings.
> >
> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> > ---
> >  .../bindings/clock/renesas,rzn1-clocks.txt         | 44
++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644
Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
> >
> > diff --git
a/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
> > new file mode 100644
> > index 0000000..0c41137
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/renesas,rzn1-clocks.txt
> > @@ -0,0 +1,44 @@
> > +* Renesas RZ/N1 Clock Driver
> > +
> > +This driver provides the clock infrastructure used by all the other
drivers.

> Bindings document h/w not drivers.

> > +
> > +One of the 'special' feature of this infrastructure is that Linux
doesn't

> Bindings are not just for Linux.

> > +necessary 'own' all the clocks on the SoC, some other OS runs on
> > +the Cortex-M3 core and that OS can access and claim it's own clocks.

> How is this relevant to the binding?

Well you just said it, if the binding is not just for linux, it's probably
a good idea to mention it somewhere since I can promise you it's *not*
documented in the hardware manual. Whatever this binding is for, it's
relevant to point out it is different from the other clock drivers in the
same directory... ?


> > +
> > +Required Properties:
> > +
> > +  - compatible: Must be
> > +    - "renesas,r9a06g032-clocks" for the RZ/N1D
> > +    and "renesas,rzn1-clocks" as a fallback.

> Is "clocks" how the chip reference manual refers to this block?

No, the block is called 'sysctrl' and has tons of other stuff in there.
I've tried multiple times to get a 'sysctrl' driver in the previous
versions of the patch, in various shape or form, and I can't because I'd be
supposed to 'document' binding for stuff that has no code, no purpose, no
testing, and have all wildly different topics. So, after some more
lengthily discussion with Geert, we've decided to make the 'primary'
feature of that block (clocks) as a driver, and see from there onward.

Thanks for all the other comments, all taken onboard for next version!
Michel


> > +  - reg: Base address and length of the memory resource used by the
driver
> > +  - #clock-cells: Must be 1
> > +
> > +Examples
> > +--------
> > +
> > +  - Clock driver device node:
> > +
> > +     clock: clocks@4000c000 {

> clock-controller@...

> > +             compatible = "renesas,r9a06g032-clocks",
> > +                             "renesas,rzn1-clocks";
> > +             reg = <0x4000c000 0x1000>;
> > +             status = "okay";

> Don't show status in examples. (Plus, I doubt you ever want to have this
> disabled, so you don't need the property in your dts files either).

> > +             #clock-cells = <1>;
> > +     };
> > +
> > +
> > +  - Other drivers can use the clocks as in:

> s/drivers/nodes/

> > +
> > +     uart0: serial@40060000 {
> > +             compatible = "snps,dw-apb-uart";
> > +             reg = <0x40060000 0x400>;
> > +             interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> > +             reg-shift = <2>;
> > +             reg-io-width = <4>;
> > +             clocks = <&clock RZN1_CLK_UART0>;
> > +             clock-names = "baudclk";
> > +     };
> > +    Note the use of RZN1_CLK_UART0 -- these constants are declared in
> > +    the rzn1-clocks.h header file. These are not hardware based
constants
> > +    and are Linux specific.

> No, they are not Linux specific. They are part of the DT ABI.

> While it is not a requirement to base them on some h/w numbering, it is
> preferred if you can. That usually only works if you can base them on
> bit positions or register offsets.

> Rob
