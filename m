Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbeCLN2Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:28:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35237 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeCLN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:28:24 -0400
X-Google-Smtp-Source: AG47ELvWlR3hGcwCM3ez/Gx9swFA7F7niYhDfxAFWypE06MPzLuhC1/mEP4AfVyyUj20gNUcUzePGGwFCm8R6Ktz7FY=
MIME-Version: 1.0
In-Reply-To: <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
References: <20180307162430.2664523-1-arnd@arndb.de> <CAFd5g45h3wAZtx-4oJb_uLbtDTzSsD6eLM5G0VF=3BBHNmW8YQ@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 12 Mar 2018 15:28:23 +0200
Message-ID: <CAP6Zq1jEAg2OrmnHzJdk9UBjPkDctu5oGHYyJ+QLBzN+E31sPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: npcm: add CONFIG_ARCH_MULTI_V7 dependency
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

According to the last mail I have with Arnd can you modify the Kconfig
as follow:

+menuconfig ARCH_NPCM
+       bool "Nuvoton NPCM Architecture"
+       depends on ARCH_MULTI_V7
+       select PINCTRL
+
+if ARCH_NPCM
+
+config ARCH_NPCM7XX
+       bool "Support for NPCM7xx BMC (Poleg)"
+       depends on ARCH_MULTI_V7
+       select PINCTRL_NPCM7XX
+       select NPCM7XX_TIMER
+       select ARCH_REQUIRE_GPIOLIB
+       select CACHE_L2X0
+       select ARM_GIC
+       select HAVE_ARM_TWD if SMP
+       select HAVE_ARM_SCU if SMP
+       select ARM_ERRATA_764369 if SMP
+       select ARM_ERRATA_720789
+       select ARM_ERRATA_754322
+       select ARM_ERRATA_794072
+       select PL310_ERRATA_588369
+       select PL310_ERRATA_727915
+       select MFD_SYSCON
+       help
+         General support for NPCM7xx BMC (Poleg).
+
+         Nuvoton NPCM7xx BMC based on the Cortex A9.
+
+endif

Thanks!

Tomer

On 9 March 2018 at 04:08, Brendan Higgins <brendanhiggins@google.com> wrote:
> On Wed, Mar 7, 2018 at 8:24 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
>> The top-level CONFIG_ARCH_NPCM symbol is not guarded with a
>> dependency, and can be selected for builds of traditional
>> (non-multiplatform) builds as well, where it causes a build
>> failure:
>
>> arch/arm/boot/Makefile:17: arch/arm/mach-npcm//Makefile.boot: No such
> file or directory
>
>> This moves the dependency to avoid that particular condition.
>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   arch/arm/mach-npcm/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
>> index 6ff9df2636be..2bc6697c8d97 100644
>> --- a/arch/arm/mach-npcm/Kconfig
>> +++ b/arch/arm/mach-npcm/Kconfig
>> @@ -1,5 +1,5 @@
>>   menuconfig ARCH_NPCM
>> -       bool "Nuvoton NPCM Architecture"
>> +       bool "Nuvoton NPCM Architecture" if ARCH_MULTI_V7
>>          select ARCH_REQUIRE_GPIOLIB
>>          select USE_OF
>>          select PINCTRL
>> @@ -10,7 +10,7 @@ if ARCH_NPCM
>>   comment "NPCM7XX CPU type"
>
>>   config ARCH_NPCM750
>> -       depends on ARCH_NPCM && ARCH_MULTI_V7
>> +       depends on ARCH_NPCM
>>          bool "Support for NPCM750 BMC CPU (Poleg)"
>>          select CACHE_L2X0
>>          select CPU_V7
>> --
>> 2.9.0
>
>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>
> Thanks!
