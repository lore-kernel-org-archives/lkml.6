Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeCLKQu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:16:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39150 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:16:48 -0400
X-Google-Smtp-Source: AG47ELsMbE+nWtSi7ZdImprSITy+fARCwZmplrF+KqkmVG0C2URS5WUG+nkTURe9vuYpj1hI0j0nRq92OnE8ICt2sv4=
MIME-Version: 1.0
In-Reply-To: <20180307162430.2664523-2-arnd@arndb.de>
References: <20180307162430.2664523-1-arnd@arndb.de> <20180307162430.2664523-2-arnd@arndb.de>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 12 Mar 2018 12:16:47 +0200
Message-ID: <CAP6Zq1ikUJ9jTLbR6ehdRLjkQHxzFa2VSdXN1G2ocMw9RyhGjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: npcm: drop extraneous 'select' statements
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-arm-kernel@lists.infradead.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amd,

Sorry for the delayed reply,

the NPCM7xx is a family of BMC's that include NPCM750, NPCM730 and more

All of the NPCM7xx BMC's have the same basic modules like Cortex-A9,
WDT, timers and more

can we reflacte the NPCM7xx as follow in the Kconfig:

menuconfig ARCH_NPCM
        bool "Nuvoton NPCM Architecture"
        depends on ARCH_MULTI_V7
        select USE_OF
        select PINCTRL

if ARCH_NPCM

config ARCH_NPCM7XX
        bool "Support for NPCM7xx BMC (Poleg)"
        depends on ARCH_MULTI_V7
        select HAVE_ARM_SCU
        select PINCTRL_NPCM7XX
        select NPCM7XX_TIMER
        select ARCH_REQUIRE_GPIOLIB
        select ARM_GIC
        select ARM_ERRATA_720789
        select ARM_ERRATA_754322
        select ARM_ERRATA_794072
        select PL310_ERRATA_588369
        select PL310_ERRATA_727915
        select MFD_SYSCON
        help
          General support for NPCM7xx BMC (Poleg).

          Nuvoton NPCM7xx BMC based on the Cortex A9.

if ARCH_NPCM7XX

config ARCH_NPCM750
        bool "NPCM750 BMC support with Device Tree"
        select HAVE_ARM_TWD if SMP
        help
          General support for NPCM750 BMC (Poleg).

          Nuvoton NPCM750 BMC based on the Cortex A9.

config ARCH_NPCM730
        bool "NPCM730 BMC support with Device Tree"
        select HAVE_ARM_TWD if SMP
        select ARM_ERRATA_764369 if SMP
        help
          General support for NPCM730 BMC (Poleg).

          Nuvoton NPCM730 BMC based on the Cortex A9.

endif #ARCH_NPCM7XX

endif

On 7 March 2018 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
> While looking at the build regression, I noticed that the
> platform selects a lot of other Kconfig symbols that it really
> should not:
>
> CPU_V7, ARM_GIC, HAVE_SMP, COMMON_CLK, GENERIC_CLOCKEVENTS,
> and CLKDEV_LOOKUP are all implied by ARCH_MULTI_V7, so they
> can be dropped.
>
> CACHE_L2X0, SMP and USB are meant to be user-selectable, we
> want to be able to turn those off for testing purposes.
>
> CPU_USE_DOMAINS looks completely misplaced here, we should not
> select that for an ARMv7 platform.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-npcm/Kconfig | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 2bc6697c8d97..c6a16230e8ef 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -12,12 +12,6 @@ comment "NPCM7XX CPU type"
>  config ARCH_NPCM750
>         depends on ARCH_NPCM
>         bool "Support for NPCM750 BMC CPU (Poleg)"
> -       select CACHE_L2X0
> -       select CPU_V7
> -       select ARM_GIC
> -       select HAVE_SMP
> -       select SMP
> -       select SMP_ON_UP
>         select HAVE_ARM_SCU
>         select HAVE_ARM_TWD if SMP
>         select ARM_ERRATA_720789
> @@ -26,18 +20,6 @@ config ARCH_NPCM750
>         select ARM_ERRATA_794072
>         select PL310_ERRATA_588369
>         select PL310_ERRATA_727915
> -       select USB_EHCI_ROOT_HUB_TT
> -       select USB_ARCH_HAS_HCD
> -       select USB_ARCH_HAS_EHCI
> -       select USB_EHCI_HCD
> -       select USB_ARCH_HAS_OHCI
> -       select USB_OHCI_HCD
> -       select USB
> -       select FIQ
> -       select CPU_USE_DOMAINS
> -       select GENERIC_CLOCKEVENTS
> -       select CLKDEV_LOOKUP
> -       select COMMON_CLK if OF
>         select NPCM750_TIMER
>         select MFD_SYSCON
>         help
> --
> 2.9.0
>
