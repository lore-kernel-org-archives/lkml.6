Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeBMB7z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:59:55 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42967 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeBMB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:59:53 -0500
X-Google-Smtp-Source: AH8x226DFzhsO+xNs+MY8NlMjmTDU6tN2QK1SN412j6VEbbTVGDiVSJc1SVj4oMcgjyWIM/T7Sf0/ZquZA1JhCyf+eM=
MIME-Version: 1.0
In-Reply-To: <20180212205833.151019-2-brendanhiggins@google.com>
References: <20180212205833.151019-1-brendanhiggins@google.com> <20180212205833.151019-2-brendanhiggins@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Feb 2018 12:29:32 +1030
X-Google-Sender-Auth: G4ne0I8r1gIRZQetIGO_tzRv0p4
Message-ID: <CACPK8XcGhxTq7QGeub2rAEtGSyrOmnobspVJfhE5YmB6MQRM9w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm: npcm: add low-level debug support for NPCM7XX
To: Brendan Higgins <brendanhiggins@google.com>,
        Jeremy Kerr <jk@ozlabs.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On Tue, Feb 13, 2018 at 7:28 AM, Brendan Higgins
<brendanhiggins@google.com> wrote:
> Enable low-level debug support for Nuvoton NPCM7XX family by adding the
> debug port definitions for the SoC.

When playing with the Poleg boards at the recent OpenBMC hackathon
Jeremy discovered that the UART is a normal-ish 8250, with a custom
divisor and a few extra bits to be set.

I found that we can us the generic 8250 low level debugging support
just fine. This is because u-boot sets up the divisor settings for us
(as you've assumed with your version here), and from there it's just
reading/writing characters.

Assuming you can reproduce our results, I suggest we drop these
patches in favour of adding the correct configuration the Poleg.

Cheers,

Joel

>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/arm/Kconfig.debug           | 11 +++++++++++
>  arch/arm/include/debug/npcm7xx.S | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 arch/arm/include/debug/npcm7xx.S
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 447629d89884..d8f925cb8872 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -595,6 +595,12 @@ choice
>                   Say Y here if you want kernel low-level debugging support
>                   on Hilscher NetX based platforms.
>
> +       config DEBUG_NPCM7XX_UART
> +               bool "Kernel low-level debugging messages via Nuvoton NPCMx50 UART"
> +               help
> +                 Say Y here if you want kernel low-level debugging support
> +                 on Nuvoton based platforms.
> +
>         config DEBUG_NOMADIK_UART
>                 bool "Kernel low-level debugging messages via NOMADIK UART"
>                 depends on ARCH_NOMADIK
> @@ -1444,6 +1450,7 @@ config DEBUG_LL_INCLUDE
>         default "debug/ks8695.S" if DEBUG_KS8695_UART
>         default "debug/msm.S" if DEBUG_QCOM_UARTDM
>         default "debug/netx.S" if DEBUG_NETX_UART
> +       default "debug/npcm7xx.S" if DEBUG_NPCM7XX_UART
>         default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
>         default "debug/renesas-scif.S" if DEBUG_R7S72100_SCIF2
>         default "debug/renesas-scif.S" if DEBUG_RCAR_GEN1_SCIF0
> @@ -1481,6 +1488,7 @@ config DEBUG_UART_8250
>  config DEBUG_UART_PHYS
>         hex "Physical base address of debug UART"
>         default 0x00100a00 if DEBUG_NETX_UART
> +       default 0xf0004000 if DEBUG_NPCM7XX_UART
>         default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
>         default 0x01c28000 if DEBUG_SUNXI_UART0
>         default 0x01c28400 if DEBUG_SUNXI_UART1
> @@ -1589,6 +1597,7 @@ config DEBUG_UART_PHYS
>                 DEBUG_LL_UART_EFM32 || \
>                 DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
>                 DEBUG_NETX_UART || \
> +               DEBUG_NPCM7XX_UART || \
>                 DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
>                 DEBUG_RCAR_GEN1_SCIF0 || DEBUG_RCAR_GEN1_SCIF2 || \
>                 DEBUG_RCAR_GEN2_SCIF0 || DEBUG_RCAR_GEN2_SCIF2 || \
> @@ -1605,6 +1614,7 @@ config DEBUG_UART_VIRT
>         default 0xc8821000 if DEBUG_RV1108_UART1
>         default 0xc8912000 if DEBUG_RV1108_UART0
>         default 0xe0000a00 if DEBUG_NETX_UART
> +       default 0xf0001000 if DEBUG_NPCM7XX_UART
>         default 0xe0010fe0 if ARCH_RPC
>         default 0xf0000be0 if ARCH_EBSA110
>         default 0xf0010000 if DEBUG_ASM9260_UART
> @@ -1695,6 +1705,7 @@ config DEBUG_UART_VIRT
>         depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
>                 DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
>                 DEBUG_NETX_UART || \
> +               DEBUG_NPCM7XX_UART || \
>                 DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
>                 DEBUG_S3C64XX_UART || \
>                 DEBUG_BCM63XX_UART || DEBUG_ASM9260_UART || \
> diff --git a/arch/arm/include/debug/npcm7xx.S b/arch/arm/include/debug/npcm7xx.S
> new file mode 100644
> index 000000000000..d08e14e73d79
> --- /dev/null
> +++ b/arch/arm/include/debug/npcm7xx.S
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2018 Google, Inc.
> +// This is heavily based on arch/arm/include/debug/at91.S
> +
> +#define NPCM7XX_SR     (0x14)  /* Status Register */
> +#define NPCM7XX_THR    (0x00)  /* Transmitter Holding Register */
> +#define NPCM7XX_TXRDY  (1 << 6)        /* Transmitter Ready */
> +#define NPCM7XX_TXEMPTY        (1 << 6)        /* Transmitter Empty */
> +
> +       .macro  addruart, rp, rv, tmp
> +       ldr     \rp, =CONFIG_DEBUG_UART_PHYS    @ System peripherals (phys)
> +       ldr     \rv, =CONFIG_DEBUG_UART_VIRT    @ System peripherals (virt)
> +       .endm
> +
> +       .macro  senduart,rd,rx
> +       strb    \rd, [\rx, #(NPCM7XX_THR)]      @ Write to Transmit Holding Reg
> +       .endm
> +
> +       .macro  waituart,rd,rx
> +1001:  ldr     \rd, [\rx, #(NPCM7XX_SR)]       @ Read Status Register
> +       tst     \rd, #NPCM7XX_TXRDY             @ TXRDY = 1 when ready to tx
> +       beq     1001b
> +       .endm
> +
> +       .macro  busyuart,rd,rx
> +1001:  ldr     \rd, [\rx, #(NPCM7XX_SR)]       @ Read Status Register
> +       tst     \rd, #NPCM7XX_TXEMPTY           @ TXEMPTY = 1 when tx complete
> +       beq     1001b
> +       .endm
> +
> --
> 2.16.0.rc1.238.g530d649a79-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
