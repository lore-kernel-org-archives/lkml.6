Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934783AbeBMLhe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:37:34 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:52171 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934078AbeBMLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:37:33 -0500
Subject: Re: [PATCH v2 05/15] MIPS: KASLR: Drop relocatable fixup from
 reservation_init
To: Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <miodrag.dinic@mips.com>, <jhogan@kernel.org>, <goran.ferenc@mips.com>,
        <david.daney@cavium.com>, <paul.gortmaker@windriver.com>,
        <paul.burton@mips.com>, <alex.belits@cavium.com>,
        <Steven.Hill@cavium.com>
CC: <alexander.sverdlin@nokia.com>, <kumba@gentoo.org>,
        <marcin.nowakowski@mips.com>, <James.hogan@mips.com>,
        <Peter.Wotton@mips.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
 <20180202035458.30456-6-fancer.lancer@gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <25ae5315-0386-4709-ec73-d265ed342b58@mips.com>
Date: Tue, 13 Feb 2018 11:30:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180202035458.30456-6-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518521760-637137-26795-167917-12
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188374
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On 02/02/18 03:54, Serge Semin wrote:
> From: Matt Redfearn <matt.redfearn@mips.com>
> 
> A recent change ("MIPS: memblock: Discard bootmem initialization")
> removed the reservation of all memory below the kernel's _end symbol in
> bootmem. This makes the call to free_bootmem unnecessary, since the
> memory region is no longer marked reserved.
> 
> Additionally, ("MIPS: memblock: Print out kernel virtual mem
> layout") added a display of the kernel's virtual memory layout, so
> printing the relocation information at this point is redundant.
> 
> Remove this section of code.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Missing your SoB.

I think this change should go after you introduce the new mechanism, 
i.e. after "MIPS: memblock: Print out kernel virtual mem layout", which 
should probably go nearer the start of the series.

Thanks,
Matt

> ---
>   arch/mips/kernel/setup.c | 23 -----------------------
>   1 file changed, 23 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index b5fcacf71b3f..cf3674977170 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -528,29 +528,6 @@ static void __init bootmem_init(void)
>   		memory_present(0, start, end);
>   	}
>   
> -#ifdef CONFIG_RELOCATABLE
> -	/*
> -	 * The kernel reserves all memory below its _end symbol as bootmem,
> -	 * but the kernel may now be at a much higher address. The memory
> -	 * between the original and new locations may be returned to the system.
> -	 */
> -	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
> -		unsigned long offset;
> -		extern void show_kernel_relocation(const char *level);
> -
> -		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
> -		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> -
> -#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
> -		/*
> -		 * This information is necessary when debugging the kernel
> -		 * But is a security vulnerability otherwise!
> -		 */
> -		show_kernel_relocation(KERN_INFO);
> -#endif
> -	}
> -#endif
> -
>   	/*
>   	 * Reserve initrd memory if needed.
>   	 */
> 
