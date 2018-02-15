Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032640AbeBOCj7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:39:59 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34787 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032437AbeBOCj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:39:57 -0500
X-Google-Smtp-Source: AH8x224EFX8sTy2uVrVhhxhY9ISAywlgj6Nh4Y28rfVDaRvAHU9OmxugxX8SkidqbwzC9oyAfIRWR1rId3mK3wFVw0s=
MIME-Version: 1.0
In-Reply-To: <20180213200959.160157-3-brendanhiggins@google.com>
References: <20180213200959.160157-1-brendanhiggins@google.com> <20180213200959.160157-3-brendanhiggins@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 15 Feb 2018 13:09:35 +1030
X-Google-Sender-Auth: gZeK3yXce1S_nW_qkG7lxqDAi4g
Message-ID: <CACPK8XeU=6SooAka-eQTp1938CmMTDgA-dOP8Wur=+EzQ6Lpfw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, julien.thierry@arm.com,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 6:39 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:

> +       ahb {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus";
> +               interrupt-parent = <&gic>;
> +               ranges;
> +
> +               clk: clock-controller@f0801000 {
> +                       compatible = "nuvoton,npcm750-clk";
> +                       #clock-cells = <1>;
> +                       reg = <0xf0801000 0x1000>;
> +                       status = "okay";

Nit: The ok is redundant.

> +               };
> +
> +               apb {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "simple-bus";
> +                       interrupt-parent = <&gic>;
> +                       ranges = <0x0 0xf0000000 0x00300000>;
> +
> +                       timer0: timer@8000 {
> +                               compatible = "nuvoton,npcm750-timer";
> +                               interrupts = <0 32 4>;
> +                               reg = <0x8000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_TIMER>;
> +                       };
> +
> +                       serial0: serial@1000 {
> +                               compatible = "nuvoton,npcm750-uart";
> +                               reg = <0x1000 0x1000>;
> +                               clocks = <&clk NPCM7XX_CLK_UART_CORE>;

I really would like to see this merged, but lets get the last of these
things sorted out first.

The clocks.h that I have in the openbmc tree uses NPCM7XX_CLK_UART. Is
what you have here line up with the latest version of the clk driver
that Tomer posted?

 https://patchwork.kernel.org/patch/10200029/

His driver calls for a header called dt-bindings/clock/nuvoton,npcm7xx-clock.h.

An alternative would be to defer this by using the numbers instead of
#defines here, and omitting the header until the clock patch is
reviewed and merged. I had a similar chicken-egg problem with the
aspeed clk driver.

> +                               interrupts = <0 2 4>;

The irq header provides defines for the first and third cell. These
could instead be:

interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;

> +                               status = "disabled";

Add reg-shift = <2> to all of the uart nodes. This is required now
that we're using the generic 8250 driver.

> +                       };
> +

> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 Nuvoton Technology corporation.
> +// Copyright 2018 Google, Inc.
> +
> +#ifndef _DT_BINDINGS_CLK_NPCM7XX_H
> +#define _DT_BINDINGS_CLK_NPCM7XX_H
> +
> +#define NPCM7XX_CLK_PLL0       0
> +#define NPCM7XX_CLK_PLL1       1
> +#define NPCM7XX_CLK_PLL2       2
> +#define NPCM7XX_CLK_GFX                3
> +#define NPCM7XX_CLK_APB1       4
> +#define NPCM7XX_CLK_APB2       5
> +#define NPCM7XX_CLK_APB3       6
> +#define NPCM7XX_CLK_APB4       7
> +#define NPCM7XX_CLK_APB5       8
> +#define NPCM7XX_CLK_MC         9
> +#define NPCM7XX_CLK_CPU                10
> +#define NPCM7XX_CLK_SPI0       11
> +#define NPCM7XX_CLK_SPI3       12
> +#define NPCM7XX_CLK_SPIX       13
> +#define NPCM7XX_CLK_UART_CORE  14
> +#define NPCM7XX_CLK_TIMER      15
> +#define NPCM7XX_CLK_HOST_UART  16
> +#define NPCM7XX_CLK_MMC                17
> +#define NPCM7XX_CLK_SDHC       18
> +#define NPCM7XX_CLK_ADC                19
> +#define NPCM7XX_CLK_GFX_MEM    20
> +#define NPCM7XX_CLK_USB_BRIDGE 21
> +#define NPCM7XX_CLK_AXI                22
> +#define NPCM7XX_CLK_AHB                23
> +#define NPCM7XX_CLK_EMC                24
> +#define NPCM7XX_CLK_GMAC       25
> +
> +#endif
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
