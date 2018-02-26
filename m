Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeBZGcH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 01:32:07 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21327 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbeBZGcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 01:32:05 -0500
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in
 pfn_valid
To: Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-6-malat@debian.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
Date: Mon, 26 Feb 2018 07:32:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225172236.29650-6-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
> Rewrite comparison since all values compared are of type `unsigned long`.
> 
> Fix a warning (treated as error in W=1):
> 
>    CC      arch/powerpc/kernel/irq.o
> In file included from ./include/linux/bug.h:5:0,
>                   from ./include/linux/cpumask.h:13,
>                   from ./include/linux/smp.h:13,
>                   from ./include/linux/kernel_stat.h:5,
>                   from arch/powerpc/kernel/irq.c:35:
> ./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>   #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>                                  ^
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/include/asm/page.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 8da5d4c1cab2..19dea64e7ed2 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>   
>   #ifdef CONFIG_FLATMEM
>   #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
> -#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> +#define pfn_valid(pfn) \
> +		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))

What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than 
ARCH_PFN_OFFSET ?

Christophe

>   #endif
>   
>   #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
> 
