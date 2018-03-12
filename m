Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeCLLnT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:43:19 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34937 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLLnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:43:18 -0400
X-Google-Smtp-Source: AG47ELveX0PEO2qBHoCClIkx7go3FII2a+WKsoVsEdTe2duyTTqN+pJnGNsKpsKjJgXsANhocQKwU52rPjJI/aAqe0Y=
MIME-Version: 1.0
In-Reply-To: <CAP6Zq1ikUJ9jTLbR6ehdRLjkQHxzFa2VSdXN1G2ocMw9RyhGjg@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de> <20180307162430.2664523-2-arnd@arndb.de>
 <CAP6Zq1ikUJ9jTLbR6ehdRLjkQHxzFa2VSdXN1G2ocMw9RyhGjg@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 12 Mar 2018 13:43:17 +0200
Message-ID: <CAP6Zq1hzDCRUHJMnnh96u3YOmg_7s6UeqUu=UrK3ynL9s+VX5A@mail.gmail.com>
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

Hi Arnd,

Please discard my previous mail, (I have more things to ask... please
read this mail)

Sorry for the delayed reply,

Before entering the long mail (sorry about it) just a technical thing
I think we should add ARM_GIC configuration, It is not implied in ARCH_MULTI_V7.

Now for the real story :-)

The NPCM7xx is a family of BMC's that include NPCM750, NPCM730 and more

All of the NPCM7xx BMC's have the same basic modules like Cortex-A9,
WDT, timers, etc - must included shared modules, and there are a
optional modules that can be added (for example the USB is not in
NPCM730)
so the additional optional modules give us the differences between the
NPCM7xx BMC's

I will like to use the same method that SPEAR using
(arch/arm/mach-spear/Kconfig)

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
        select CACHE_L2X0
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
        select HAVE_ARM_SCU if SMP
        select ARM_ERRATA_764369 if SMP
        help
          General support for NPCM750 BMC (Poleg).

          Nuvoton NPCM750 BMC based on the Cortex A9.

config ARCH_NPCM730
        bool "NPCM730 BMC support with Device Tree"
        select HAVE_ARM_TWD if SMP
        select HAVE_ARM_SCU if SMP
        select ARM_ERRATA_764369 if SMP
        help
          General support for NPCM730 BMC (Poleg).

          Nuvoton NPCM730 BMC based on the Cortex A9.

endif #ARCH_NPCM7XX

endif

if we use the above approach can we unite the two sections into one
(since they are the same) as follows:

config ARCH_NPCM750_NPCM730
        bool "NPCM750 or NPCM730 BMC support with Device Tree"
        select HAVE_ARM_TWD if SMP
        select HAVE_ARM_SCU if SMP
         select ARM_ERRATA_764369 if SMP
        help
          General support for NPCM750 or NPCM730 BMC (Poleg).

          Nuvoton NPCM750 or NPCM730 BMC based on the Cortex A9.

or even better include it in ARCH_NPCM7XX and remove the ARCH_NPCM750
and ARCH_NPCM730?

Regarding another matter, defconfig file:
We would like to consult how to describe the various chips (e.g.
NPCM750, NPCM730) in the defconfig file.
One option is to include all modules (as included in NPCM750 chip,
which is a superset chip) and all the chips.
The we call it npcm7xx_defconfig (same as spear13xx_deconfig) .
In this option customers of NPCM730 will need to manually undef
non-existing modules.

Another option is to create different defconfig files for each chip of
this NPCM7xx family, e.g. npcm750_defconfig and npcm730_defconfig.

Which approach should be adopt ? We will appreciate your advise.

Thanks a lot,

Tomer

On 12 March 2018 at 12:16, Tomer Maimon <tmaimon77@gmail.com> wrote:
> Hi Amd,
>
> Sorry for the delayed reply,
>
> the NPCM7xx is a family of BMC's that include NPCM750, NPCM730 and more
>
> All of the NPCM7xx BMC's have the same basic modules like Cortex-A9,
> WDT, timers and more
>
> can we reflacte the NPCM7xx as follow in the Kconfig:
>
> menuconfig ARCH_NPCM
>         bool "Nuvoton NPCM Architecture"
>         depends on ARCH_MULTI_V7
>         select USE_OF
>         select PINCTRL
>
> if ARCH_NPCM
>
> config ARCH_NPCM7XX
>         bool "Support for NPCM7xx BMC (Poleg)"
>         depends on ARCH_MULTI_V7
>         select HAVE_ARM_SCU
>         select PINCTRL_NPCM7XX
>         select NPCM7XX_TIMER
>         select ARCH_REQUIRE_GPIOLIB
>         select ARM_GIC
>         select ARM_ERRATA_720789
>         select ARM_ERRATA_754322
>         select ARM_ERRATA_794072
>         select PL310_ERRATA_588369
>         select PL310_ERRATA_727915
>         select MFD_SYSCON
>         help
>           General support for NPCM7xx BMC (Poleg).
>
>           Nuvoton NPCM7xx BMC based on the Cortex A9.
>
> if ARCH_NPCM7XX
>
> config ARCH_NPCM750
>         bool "NPCM750 BMC support with Device Tree"
>         select HAVE_ARM_TWD if SMP
>         help
>           General support for NPCM750 BMC (Poleg).
>
>           Nuvoton NPCM750 BMC based on the Cortex A9.
>
> config ARCH_NPCM730
>         bool "NPCM730 BMC support with Device Tree"
>         select HAVE_ARM_TWD if SMP
>         select ARM_ERRATA_764369 if SMP
>         help
>           General support for NPCM730 BMC (Poleg).
>
>           Nuvoton NPCM730 BMC based on the Cortex A9.
>
> endif #ARCH_NPCM7XX
>
> endif
>
> On 7 March 2018 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
>> While looking at the build regression, I noticed that the
>> platform selects a lot of other Kconfig symbols that it really
>> should not:
>>
>> CPU_V7, ARM_GIC, HAVE_SMP, COMMON_CLK, GENERIC_CLOCKEVENTS,
>> and CLKDEV_LOOKUP are all implied by ARCH_MULTI_V7, so they
>> can be dropped.
>>
>> CACHE_L2X0, SMP and USB are meant to be user-selectable, we
>> want to be able to turn those off for testing purposes.
>>
>> CPU_USE_DOMAINS looks completely misplaced here, we should not
>> select that for an ARMv7 platform.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm/mach-npcm/Kconfig | 18 ------------------
>>  1 file changed, 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
>> index 2bc6697c8d97..c6a16230e8ef 100644
>> --- a/arch/arm/mach-npcm/Kconfig
>> +++ b/arch/arm/mach-npcm/Kconfig
>> @@ -12,12 +12,6 @@ comment "NPCM7XX CPU type"
>>  config ARCH_NPCM750
>>         depends on ARCH_NPCM
>>         bool "Support for NPCM750 BMC CPU (Poleg)"
>> -       select CACHE_L2X0
>> -       select CPU_V7
>> -       select ARM_GIC
>> -       select HAVE_SMP
>> -       select SMP
>> -       select SMP_ON_UP
>>         select HAVE_ARM_SCU
>>         select HAVE_ARM_TWD if SMP
>>         select ARM_ERRATA_720789
>> @@ -26,18 +20,6 @@ config ARCH_NPCM750
>>         select ARM_ERRATA_794072
>>         select PL310_ERRATA_588369
>>         select PL310_ERRATA_727915
>> -       select USB_EHCI_ROOT_HUB_TT
>> -       select USB_ARCH_HAS_HCD
>> -       select USB_ARCH_HAS_EHCI
>> -       select USB_EHCI_HCD
>> -       select USB_ARCH_HAS_OHCI
>> -       select USB_OHCI_HCD
>> -       select USB
>> -       select FIQ
>> -       select CPU_USE_DOMAINS
>> -       select GENERIC_CLOCKEVENTS
>> -       select CLKDEV_LOOKUP
>> -       select COMMON_CLK if OF
>>         select NPCM750_TIMER
>>         select MFD_SYSCON
>>         help
>> --
>> 2.9.0
>>
