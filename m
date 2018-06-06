Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkAfCS7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2937B60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeFFTfc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeFFTfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:35:30 -0400
X-Google-Smtp-Source: ADUXVKJr+DvQ1EoU1kGo1ZHwG5AjYTfFFkC/1fDj1FtQ7AGEcZlVWr3NBYOI6GMnNB1jscxJYDHOQHkvS1XPGiWjQ3o=
MIME-Version: 1.0
In-Reply-To: <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com> <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <bbbd287c-437e-d7bd-d40f-6bb914d96860@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 6 Jun 2018 14:35:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
Message-ID: <CAL_JsqJCkP_c_wKGRc7Qzkiw8sZLRf6MGz-WgVsLjnQfqK8r6Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
To: Frank Rowand <frowand.list@gmail.com>
Cc: Michel Pollet <michel.pollet@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Douglas Anderson <dianders@chromium.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Carlo Caione <carlo@endlessm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Frank Rowand <frank.rowand@sony.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:30 PM, Frank Rowand <frowand.list@gmail.com> wrote:
> Hi Michel,
>
> On 06/05/18 23:36, Michel Pollet wrote:
>> Hi Frank,
>>
>> On 05 June 2018 18:34, Frank wrote:
>>> On 06/05/18 04:28, Michel Pollet wrote:
>>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>>>> it requires a special enable method to get it started.
>>>>
>>>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>>> ---
>>>>  arch/arm/mach-shmobile/Makefile        |  1 +
>>>>  arch/arm/mach-shmobile/smp-r9a06g032.c | 79
>>>> ++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 80 insertions(+)
>>>>  create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c
>>>>
>>>> diff --git a/arch/arm/mach-shmobile/Makefile
>>>> b/arch/arm/mach-shmobile/Makefile index 1939f52..d7fc98f 100644
>>>> --- a/arch/arm/mach-shmobile/Makefile
>>>> +++ b/arch/arm/mach-shmobile/Makefile
>>>> @@ -34,6 +34,7 @@ smp-$(CONFIG_ARCH_SH73A0)+= smp-sh73a0.o
>>> headsmp-scu.o platsmp-scu.o
>>>>  smp-$(CONFIG_ARCH_R8A7779)+= smp-r8a7779.o headsmp-scu.o
>>> platsmp-scu.o
>>>>  smp-$(CONFIG_ARCH_R8A7790)+= smp-r8a7790.o
>>>>  smp-$(CONFIG_ARCH_R8A7791)+= smp-r8a7791.o
>>>> +smp-$(CONFIG_ARCH_R9A06G032)+= smp-r9a06g032.o
>>>>  smp-$(CONFIG_ARCH_EMEV2)+= smp-emev2.o headsmp-scu.o
>>> platsmp-scu.o
>>>>
>>>>  # PM objects
>>>> diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> new file mode 100644
>>>> index 0000000..cd40e6e
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
>>>> @@ -0,0 +1,79 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * R9A06G032 Second CA7 enabler.
>>>> + *
>>>> + * Copyright (C) 2018 Renesas Electronics Europe Limited
>>>> + *
>>>> + * Michel Pollet <michel.pollet@bp.renesas.com>,
>>> <buserror@gmail.com>
>>>> + * Derived from action,s500-smp
>>>> + */
>>>> +
>>>> +#include <linux/io.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/smp.h>
>>>> +
>>>> +/*
>>>> + * The second CPU is parked in ROM at boot time. It requires waking
>>>> +it after
>>>> + * writing an address into the BOOTADDR register of sysctrl.
>>>> + *
>>>> + * So the default value of the "cpu-release-addr" corresponds to
>>> BOOTADDR...
>>>> + *
>>>> + * *However* the BOOTADDR register is not available when the kernel
>>>> + * starts in NONSEC mode.
>>>> + *
>>>> + * So for NONSEC mode, the bootloader re-parks the second CPU into a
>>>> +pen
>>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to a
>>>> +SRAM address,
>>>> + * which is not restricted.
>>>
>>> The binding document for cpu-release-addr does not have a definition for 32
>>> bit arm.  The existing definition is only 64 bit arm.  Please add the definition
>>> for 32 bit arm to patch 1.
>>
>> Hmmm I do find a definition in
>> Documentation/devicetree/bindings/arm/cpus.txt -- just under where I
>> added my 'enable-method' -- And it is already used as 32 bits in at least
>> arch/arm/boot/dts/stih407-family.dtsi.
>
> From cpus.txt:
>
>         - cpu-release-addr
>                 Usage: required for systems that have an "enable-method"
>                        property value of "spin-table".
>                 Value type: <prop-encoded-array>
>                 Definition:
>                         # On ARM v8 64-bit systems must be a two cell
>                           property identifying a 64-bit zero-initialised
>                           memory location.
>
> The definition specifies a two cell property for 64-bit systems.
>
> Please add to the definition that cpu-release-addr is a one cell property
> for 32-bit systems.

Actually, this is all already documented in the DT spec and it is
always 2 cells[1]. We should perhaps just remove whatever is
duplicated from the spec.

Rob

[1]
   ``cpu-release-addr``   | SD  | ``<u64>``        The
cpu-release-addr property is required for
                                                   cpu nodes that have
an enable-method property
                                                   value of
``"spin-table"``. The value specifies the
                                                   physical address of
a spin table entry that
                                                   releases a
secondary CPU from its spin loop.
