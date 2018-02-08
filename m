Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeBHRev (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:34:51 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45988 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBHRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:34:49 -0500
X-Google-Smtp-Source: AH8x226ePSuRHaJ9tjhovaK5HaxTwlwuYKw0vitMt4L/xyo1XewUVwpLjMwVjVsZ5nnSTuSA1k/gdg==
Date: Thu, 08 Feb 2018 09:34:48 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 09:31:08 PST (-0800)
Subject: Re: [PATCH v3 2/2] MIPS: use generic GCC library routines from lib/
In-Reply-To: <bfe8f5e7-3372-1bfb-e5f8-f752e2b12126@mips.com>
CC: antonynpavlov@gmail.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@sifive.com>
To: matt.redfearn@mips.com
Message-ID: <mhng-f000d448-7ead-4cee-9e2f-5d58692c0922@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018 08:07:51 PST (-0800), matt.redfearn@mips.com wrote:
> Hi,
>
> On 31/01/18 15:33, Antony Pavlov wrote:
>> The commit b35cd9884fa5 ("lib: Add shared copies of
>> some GCC library routines") makes it possible
>> to share generic GCC library routines by several
>> architectures.
>>
>> This commit removes several generic GCC library
>> routines from arch/mips/lib/ in favour of similar
>> routines from lib/.
>>
>> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Matt Redfearn <matt.redfearn@mips.com>
>> Cc: James Hogan <jhogan@kernel.org>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   arch/mips/Kconfig       |  5 +++++
>>   arch/mips/lib/Makefile  |  2 +-
>>   arch/mips/lib/ashldi3.c | 30 ------------------------------
>>   arch/mips/lib/ashrdi3.c | 32 --------------------------------
>>   arch/mips/lib/cmpdi2.c  | 28 ----------------------------
>>   arch/mips/lib/lshrdi3.c | 30 ------------------------------
>>   arch/mips/lib/ucmpdi2.c | 22 ----------------------
>>   7 files changed, 6 insertions(+), 143 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 350a990fc719..b63a5422d485 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -18,16 +18,21 @@ config MIPS
>>   	select BUILDTIME_EXTABLE_SORT
>>   	select CLONE_BACKWARDS
>>   	select CPU_PM if CPU_IDLE
>> +	select GENERIC_ASHLDI3
>> +	select GENERIC_ASHRDI3
>>   	select GENERIC_ATOMIC64 if !64BIT
>>   	select GENERIC_CLOCKEVENTS
>>   	select GENERIC_CMOS_UPDATE
>> +	select GENERIC_CMPDI2
>>   	select GENERIC_CPU_AUTOPROBE
>>   	select GENERIC_IRQ_PROBE
>>   	select GENERIC_IRQ_SHOW
>> +	select GENERIC_LSHRDI3
>>   	select GENERIC_PCI_IOMAP
>>   	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>>   	select GENERIC_SMP_IDLE_THREAD
>>   	select GENERIC_TIME_VSYSCALL
>> +	select GENERIC_UCMPDI2
>>   	select HANDLE_DOMAIN_IRQ
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_KGDB
>
> OK, thanks for changing this. But to be honest, it does look pretty
> messy like this. I feel like the CONFIG names should be something a
> little more descriptive, such as CONFIG_GENERIC_LIB_*, putting them in a
> namespace that would at least group them all together. Right now, AFAIK
> there's only RISC-V using these so it shouldn't be too painful to change
> them. What do you think Antony / Palmer?

That looks good to me.  It's a bit odd that they aren't all together.

>
> Thanks,
> Matt
>
>
>> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
>> index 78c2affeabf8..195ab4cb0840 100644
>> --- a/arch/mips/lib/Makefile
>> +++ b/arch/mips/lib/Makefile
>> @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>>   obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>>
>>   # libgcc-style stuff needed in the kernel
>> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
>> +obj-y += bswapsi.o bswapdi.o
>> diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
>> deleted file mode 100644
>> index 24cd6903e797..000000000000
>> --- a/arch/mips/lib/ashldi3.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __ashldi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		w.s.low = 0;
>> -		w.s.high = (unsigned int) uu.s.low << -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
>> -
>> -		w.s.low = (unsigned int) uu.s.low << b;
>> -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__ashldi3);
>> diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
>> deleted file mode 100644
>> index 23f5295af51e..000000000000
>> --- a/arch/mips/lib/ashrdi3.c
>> +++ /dev/null
>> @@ -1,32 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __ashrdi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		/* w.s.high = 1..1 or 0..0 */
>> -		w.s.high =
>> -		    uu.s.high >> 31;
>> -		w.s.low = uu.s.high >> -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> -
>> -		w.s.high = uu.s.high >> b;
>> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__ashrdi3);
>> diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
>> deleted file mode 100644
>> index 93cfc785927d..000000000000
>> --- a/arch/mips/lib/cmpdi2.c
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -word_type notrace __cmpdi2(long long a, long long b)
>> -{
>> -	const DWunion au = {
>> -		.ll = a
>> -	};
>> -	const DWunion bu = {
>> -		.ll = b
>> -	};
>> -
>> -	if (au.s.high < bu.s.high)
>> -		return 0;
>> -	else if (au.s.high > bu.s.high)
>> -		return 2;
>> -
>> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> -		return 0;
>> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> -		return 2;
>> -
>> -	return 1;
>> -}
>> -
>> -EXPORT_SYMBOL(__cmpdi2);
>> diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
>> deleted file mode 100644
>> index 914b971aca3b..000000000000
>> --- a/arch/mips/lib/lshrdi3.c
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -long long notrace __lshrdi3(long long u, word_type b)
>> -{
>> -	DWunion uu, w;
>> -	word_type bm;
>> -
>> -	if (b == 0)
>> -		return u;
>> -
>> -	uu.ll = u;
>> -	bm = 32 - b;
>> -
>> -	if (bm <= 0) {
>> -		w.s.high = 0;
>> -		w.s.low = (unsigned int) uu.s.high >> -bm;
>> -	} else {
>> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
>> -
>> -		w.s.high = (unsigned int) uu.s.high >> b;
>> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
>> -	}
>> -
>> -	return w.ll;
>> -}
>> -
>> -EXPORT_SYMBOL(__lshrdi3);
>> diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
>> deleted file mode 100644
>> index c31c78ca4175..000000000000
>> --- a/arch/mips/lib/ucmpdi2.c
>> +++ /dev/null
>> @@ -1,22 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#include <linux/export.h>
>> -
>> -#include "libgcc.h"
>> -
>> -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
>> -{
>> -	const DWunion au = {.ll = a};
>> -	const DWunion bu = {.ll = b};
>> -
>> -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
>> -		return 0;
>> -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
>> -		return 2;
>> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
>> -		return 0;
>> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
>> -		return 2;
>> -	return 1;
>> -}
>> -
>> -EXPORT_SYMBOL(__ucmpdi2);
>>
