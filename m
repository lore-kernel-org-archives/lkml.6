Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933808AbeCEJng (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:43:36 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40407 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933485AbeCEJnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:43:32 -0500
X-Google-Smtp-Source: AG47ELscUy5geLI45beFcCIlwkflYKCxuQvyDQKx+AtTlj4Q5AKLHmzvCxhuKv9r4uNBcbXFfQGBTDmFApcWNNSyrvM=
MIME-Version: 1.0
In-Reply-To: <1519647518-15579-2-git-send-email-michel.pollet@bp.renesas.com>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com> <1519647518-15579-2-git-send-email-michel.pollet@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 5 Mar 2018 10:43:29 +0100
X-Google-Sender-Auth: Fxp-27fuDuqgi3GAyOXtYfiNGKA
Message-ID: <CAMuHMdWV+_L0MO3vY0w4tec37Ycs2rDN-a93B0YwBeSnG2_wrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: add basic support for Renesas RZ/N1 boards
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

On Mon, Feb 26, 2018 at 1:18 PM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> This adds the Renesas RZ/N1 CPU and bare bone support.
>
> This currently only handles generic parts (gic, architected timer)
> and a UART.
> This also relies on the bootloader to set the pinctrl and clocks.
>
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>

Thanks for your patch!

This should be split in separate patches:

>  Documentation/devicetree/bindings/arm/shmobile.txt |   3 +-

1. DT bindings

>  arch/arm/boot/dts/rzn1.dtsi                        |  94 +++

2. SoC DTS file

>  arch/arm/mach-shmobile/Kconfig                     |   5 +

3. Platform Kconfig symbol

>  arch/arm/mach-shmobile/Makefile                    |   1 +
>  arch/arm/mach-shmobile/setup-r9a06g032.c           |  60 ++

Please no more board files for new platforms (see below).

>  .../dt-bindings/interrupt-controller/rzn1-irq.h    | 137 ++++

DTS files are much easier to compare with the datasheet if the interrupt
numbers are present in the DTS files theirselves.

>  include/dt-bindings/soc/renesas,rzn1-map.h         | 173 +++++

Same for base addresses.

> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -47,7 +47,8 @@ SoCs:
>      compatible = "renesas,r8a77980"
>    - R-Car D3 (R8A77995)
>      compatible = "renesas,r8a77995"
> -
> +  - RZ/N1D (R9A06G032)
> +    compatible = "renesas,r9a06g032"

BTW, are R9A06G032NGBG and R9A06G032VGBA the same SoC,
just in different packages?

> --- /dev/null
> +++ b/arch/arm/boot/dts/rzn1.dtsi

So faw we always named the SoC-specific DTS files after the SoC part
number => r9a06g032.dtsi.

> @@ -0,0 +1,94 @@
> +/*
> + * Base Device Tree Source for the Renesas RZ/N1 SoC
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/rzn1-irq.h>
> +#include <dt-bindings/soc/renesas,rzn1-map.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "skeleton.dtsi"
> +
> +/ {
> +       compatible = "renesas,r9a06g032";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <0>;
> +               };
> +               cpu@1 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a7";
> +                       reg = <1>;
> +               };
> +       };
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +       arm_timer: timer {
> +               compatible = "arm,armv7-timer";
> +               arm,cpu-registers-not-fw-configured;
> +               interrupts =
> +                       <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +                               IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> +                               IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
> +                               IRQ_TYPE_LEVEL_LOW)>,
> +                       <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> +                               IRQ_TYPE_LEVEL_LOW)>;
> +       };
> +       gic: interrupt-controller@RZN1_GIC_BASE {

On-SoC devices should be grouped under an "soc" node.
You can move the "interrupt-parent = <&gic>;" there, too.

> +               compatible = "arm,cortex-a7-gic";

As the RZ/N1D's User's Manul refers to the GIC-400 manuals, I assume
this is a GIC-400 => "arm,gic-400".

You can check by reading the GIC_DIST_IIDR register.

> +               reg = <0x44101000 0x1000>,      /* Distributer */
> +                     <0x44102000 0x1000>,      /* CPU interface */

Shouldn't the size of the second region be 0x2000?

> +       bus {

Oh, you do have an "soc" node. Please call it "soc".

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/setup-r9a06g032.c
> @@ -0,0 +1,60 @@
> +/*
> + * RZ/N1 processor support file
> + *
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + *
> + */
> + /* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm/mach/arch.h>
> +#include <dt-bindings/soc/renesas,rzn1-map.h>
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +#include <soc/rzn1/sysctrl.h>
> +
> +static void __iomem *sysctrl_base_addr;
> +
> +static void rzn1_sysctrl_init(void)
> +{
> +       if (sysctrl_base_addr)
> +               return;
> +       sysctrl_base_addr = ioremap(RZN1_SYSTEM_CTRL_BASE,
> +                                       RZN1_SYSTEM_CTRL_SIZE);

These values should be obtained from DT.

> +       BUG_ON(!sysctrl_base_addr);
> +}
> +
> +void __iomem *rzn1_sysctrl_base(void)
> +{
> +       if (!sysctrl_base_addr)
> +               rzn1_sysctrl_init();
> +       return sysctrl_base_addr;
> +}
> +EXPORT_SYMBOL(rzn1_sysctrl_base);

Looks like this is a "system controller", providing a bunch of registers
to a collection of random functionality, to be used by various drivers.

Please see:
  Documentation/devicetree/bindings/mfd/syscon.txt
  include/linux/mfd/syscon.h
  drivers/mfd/syscon.c

> +static void rzn1_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       rzn1_sysctrl_writel(
> +                       rzn1_sysctrl_readl(RZN1_SYSCTRL_REG_RSTEN) |
> +                       BIT(RZN1_SYSCTRL_REG_RSTEN_SWRST_EN) |
> +                               BIT(RZN1_SYSCTRL_REG_RSTEN_MRESET_EN),
> +                       RZN1_SYSCTRL_REG_RSTEN);
> +       rzn1_sysctrl_writel(
> +                       rzn1_sysctrl_readl(RZN1_SYSCTRL_REG_RSTCTRL) |
> +                       BIT(RZN1_SYSCTRL_REG_RSTCTRL_SWRST_REQ),
> +                       RZN1_SYSCTRL_REG_RSTCTRL);
> +}

This should be a reset driver under drivers/power/reset/.
Or perhaps you can even do without a driver, check
Documentation/devicetree/bindings/power/reset/syscon-reboot.txt

> --- /dev/null
> +++ b/include/soc/rzn1/sysctrl.h
> @@ -0,0 +1,736 @@
> +/*
> + * Copyright (C) 2018 Renesas Electronics Europe Limited
> + * All rights reserved.
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)

Not mentioned in Documentation/process/license-rules.rst

Do you mean any of:

    SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
    SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause

or something different?

> +/*
> + * Get the base address for the sysctrl block.
> + * Ensure use does not conflict with anything else that acesses the SYSCTRL
> + */
> +void __iomem *rzn1_sysctrl_base(void);
> +
> +static inline u32 rzn1_sysctrl_readl(u32 reg)
> +{
> +       BUG_ON(reg >= RZN1_SYSTEM_CTRL_SIZE);

Please no BUG_ON().

> +       return readl(rzn1_sysctrl_base() + reg);
> +}
> +
> +static inline void rzn1_sysctrl_writel(u32 value, u32 reg)
> +{
> +       BUG_ON(reg >= RZN1_SYSTEM_CTRL_SIZE);
> +       writel(value, rzn1_sysctrl_base() + reg);
> +}

Probably all of this can be removed if you use the syscon abstraction.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
