Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426896AbeBORDa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:03:30 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:50558 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423381AbeBOPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:38:49 -0500
Date: Thu, 15 Feb 2018 16:38:44 +0100
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/15] ARM64: dts: Add R-Car Salvator-x M3-N support
Message-ID: <20180215153843.b33svmvuhofstw4e@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdW0SYdwNNWfzNttY8xdfnB-oLR4MvhWpO7Pks-WY76=3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW0SYdwNNWfzNttY8xdfnB-oLR4MvhWpO7Pks-WY76=3g@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 02:58:34PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
> <jacopo+renesas@jmondi.org> wrote:
> > Add initial support for R-Car M3-N Salvator-x and r8a77965 SoC in
> > device tree with cpg-mssr, reset and clock nodes.
> >
> > Add place-holder device nodes for all nodes referred by
> > "salvator-common.dtsi"
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Thanks for your patch!
> 
> Looks mostly fine to me.
> 
> P.S. scripts/dtc/dtx_diff arch/arm64/boot/dts/renesas/r8a7796{,5}-salvator-x.dtb
>      is your friend.
> 
> >  arch/arm64/Kconfig.platforms                       |   6 +
> >  arch/arm64/boot/dts/renesas/Makefile               |   1 +
> >  .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |  30 ++
> >  arch/arm64/boot/dts/renesas/r8a77965.dtsi          | 495 +++++++++++++++++++++
> >  4 files changed, 532 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a77965.dtsi
> 
> The maintainer will probably ask you to split this in three parts:
>   - ARCH_R8A77965
>   - r8a77965.dtsi
>   - r8a77965-salvator-x.dts

Yes, I would like to ask for that.

> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.
> > +/*
> > + * Device Tree Source for the Salvator-X board
> 
> with R-Car M3-N
> 
> > + *
> > + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> > + */
> > +
> > +/dts-v1/;
> > +#include "r8a77965.dtsi"
> > +#include "salvator-x.dtsi"
> > +
> > +/ {
> > +       model = "Renesas Salvator-X board based on r8a77965";
> > +       compatible = "renesas,salvator-x", "renesas,r8a77965";
> > +
> > +       aliases {
> > +               serial0 = &scif2;
> > +       };
> > +
> > +       chosen {
> > +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> > +               stdout-path = "serial0:115200n8";
> > +       };
> 
> Both aliases and chosen are already defined in salvator-common.dtsi,
> included via salvator-x.dtsi.
> 
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > @@ -0,0 +1,495 @@
> > +// SPDX-License-Identifier: GPL-2.
> > +/*
> > + * Device Tree Source for the r8a77965 SoC
> > + *
> > + * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
> > + *
> > + * Based on r8a7796.dtsi
> > + * Copyright (C) 2016 Renesas Electronics Corp.
> > + */
> > +
> > +#include <dt-bindings/clock/r8a77965-cpg-mssr.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/r8a77965-sysc.h>
> > +
> > +#define CPG_AUDIO_CLK_I                R8A77965_CLK_S0D4
> > +
> > +/ {
> 
> > +       soc {
> > +               compatible = "simple-bus";
> > +               interrupt-parent = <&gic>;
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> 
> > +               timer {
> > +                       compatible = "arm,armv8-timer";
> > +                       interrupts = <GIC_PPI 13
> > +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> > +                                    <GIC_PPI 14
> > +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> > +                                    <GIC_PPI 11
> > +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> > +                                    <GIC_PPI 10
> > +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> > +               };
> 
> Please move the timer out of the soc node, as it does't have a unit address
> and a reg property.
> 
> > +               pmu_a57 {
> > +                       compatible = "arm,cortex-a57-pmu";
> > +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> > +                                    <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> > +                       interrupt-affinity = <&a57_0>,
> > +                                            <&a57_1>;
> > +               };
> 
> Please move the pmu out of the soc node, as it does't have a unit address
> and a reg property.

Please refer to one of the upstream Gen3 dtsi files for examples of the
above.
