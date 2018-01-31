Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753559AbeAaMAZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:00:25 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40323 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeAaMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:00:24 -0500
Subject: Re: [PATCH v2 2/2] MIPS: use generic GCC library routines from lib/
To: Antony Pavlov <antonynpavlov@gmail.com>, <linux-mips@linux-mips.org>
CC: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>
References: <20180130224202.7682-1-antonynpavlov@gmail.com>
 <20180130224202.7682-3-antonynpavlov@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <89def93a-c9a4-1c79-271a-a53fe2cd02b6@mips.com>
Date: Wed, 31 Jan 2018 11:55:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180130224202.7682-3-antonynpavlov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1517400016-637140-31742-118466-9
X-BESS-VER: 2018.1-r1801290438
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189548
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/01/18 22:42, Antony Pavlov wrote:
> The commit b35cd9884fa5 ("lib: Add shared copies of
> some GCC library routines") makes it possible
> to share generic GCC library routines by several
> architectures.
> 
> This commit removes several generic GCC library
> routines from arch/mips/lib/ in favour of similar
> routines from lib/.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/mips/Kconfig       |  5 +++++
>   arch/mips/lib/Makefile  |  2 +-
>   arch/mips/lib/ashldi3.c | 30 ------------------------------
>   arch/mips/lib/ashrdi3.c | 32 --------------------------------
>   arch/mips/lib/cmpdi2.c  | 28 ----------------------------
>   arch/mips/lib/lshrdi3.c | 30 ------------------------------
>   arch/mips/lib/ucmpdi2.c | 22 ----------------------
>   7 files changed, 6 insertions(+), 143 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 350a990fc719..6f786d576dd2 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -73,6 +73,11 @@ config MIPS
>   	select RTC_LIB if !MACH_LOONGSON64
>   	select SYSCTL_EXCEPTION_TRACE
>   	select VIRT_TO_BUS
> +	select GENERIC_ASHLDI3
> +	select GENERIC_ASHRDI3
> +	select GENERIC_CMPDI2
> +	select GENERIC_LSHRDI3
> +	select GENERIC_UCMPDI2

Please keep the alphabetical order. With that fixed,

Reviewed-by: Matt Redfearn <amtt.redfearn@mips.com>

Thanks,
Matt


>   
>   menu "Machine selection"
>   
> diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
> index 78c2affeabf8..195ab4cb0840 100644
> --- a/arch/mips/lib/Makefile
> +++ b/arch/mips/lib/Makefile
> @@ -16,4 +16,4 @@ obj-$(CONFIG_CPU_R3000)		+= r3k_dump_tlb.o
>   obj-$(CONFIG_CPU_TX39XX)	+= r3k_dump_tlb.o
>   
>   # libgcc-style stuff needed in the kernel
> -obj-y += ashldi3.o ashrdi3.o bswapsi.o bswapdi.o cmpdi2.o lshrdi3.o ucmpdi2.o
> +obj-y += bswapsi.o bswapdi.o
> diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
> deleted file mode 100644
> index 24cd6903e797..000000000000
> --- a/arch/mips/lib/ashldi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __ashldi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.low = 0;
> -		w.s.high = (unsigned int) uu.s.low << -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.low >> bm;
> -
> -		w.s.low = (unsigned int) uu.s.low << b;
> -		w.s.high = ((unsigned int) uu.s.high << b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashldi3);
> diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
> deleted file mode 100644
> index 23f5295af51e..000000000000
> --- a/arch/mips/lib/ashrdi3.c
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __ashrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		/* w.s.high = 1..1 or 0..0 */
> -		w.s.high =
> -		    uu.s.high >> 31;
> -		w.s.low = uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__ashrdi3);
> diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
> deleted file mode 100644
> index 93cfc785927d..000000000000
> --- a/arch/mips/lib/cmpdi2.c
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -word_type notrace __cmpdi2(long long a, long long b)
> -{
> -	const DWunion au = {
> -		.ll = a
> -	};
> -	const DWunion bu = {
> -		.ll = b
> -	};
> -
> -	if (au.s.high < bu.s.high)
> -		return 0;
> -	else if (au.s.high > bu.s.high)
> -		return 2;
> -
> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> -		return 0;
> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> -		return 2;
> -
> -	return 1;
> -}
> -
> -EXPORT_SYMBOL(__cmpdi2);
> diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
> deleted file mode 100644
> index 914b971aca3b..000000000000
> --- a/arch/mips/lib/lshrdi3.c
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -long long notrace __lshrdi3(long long u, word_type b)
> -{
> -	DWunion uu, w;
> -	word_type bm;
> -
> -	if (b == 0)
> -		return u;
> -
> -	uu.ll = u;
> -	bm = 32 - b;
> -
> -	if (bm <= 0) {
> -		w.s.high = 0;
> -		w.s.low = (unsigned int) uu.s.high >> -bm;
> -	} else {
> -		const unsigned int carries = (unsigned int) uu.s.high << bm;
> -
> -		w.s.high = (unsigned int) uu.s.high >> b;
> -		w.s.low = ((unsigned int) uu.s.low >> b) | carries;
> -	}
> -
> -	return w.ll;
> -}
> -
> -EXPORT_SYMBOL(__lshrdi3);
> diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
> deleted file mode 100644
> index c31c78ca4175..000000000000
> --- a/arch/mips/lib/ucmpdi2.c
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/export.h>
> -
> -#include "libgcc.h"
> -
> -word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
> -{
> -	const DWunion au = {.ll = a};
> -	const DWunion bu = {.ll = b};
> -
> -	if ((unsigned int) au.s.high < (unsigned int) bu.s.high)
> -		return 0;
> -	else if ((unsigned int) au.s.high > (unsigned int) bu.s.high)
> -		return 2;
> -	if ((unsigned int) au.s.low < (unsigned int) bu.s.low)
> -		return 0;
> -	else if ((unsigned int) au.s.low > (unsigned int) bu.s.low)
> -		return 2;
> -	return 1;
> -}
> -
> -EXPORT_SYMBOL(__ucmpdi2);
> 
