Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeCDKzW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:55:22 -0500
Received: from ozlabs.org ([103.22.144.67]:55727 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932292AbeCDKzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:55:21 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
In-Reply-To: <20180225172236.29650-6-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-6-malat@debian.org>
Date: Sun, 04 Mar 2018 21:55:17 +1100
Message-ID: <87lgf8gley.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> Rewrite comparison since all values compared are of type `unsigned long`.
>
> Fix a warning (treated as error in W=1):
>
>   CC      arch/powerpc/kernel/irq.o
> In file included from ./include/linux/bug.h:5:0,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/smp.h:13,
>                  from ./include/linux/kernel_stat.h:5,
>                  from arch/powerpc/kernel/irq.c:35:
> ./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned expression >= 0 is always true [-Werror=type-limits]
>  #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>                                 ^
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/powerpc/include/asm/page.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
> index 8da5d4c1cab2..19dea64e7ed2 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>  
>  #ifdef CONFIG_FLATMEM
>  #define ARCH_PFN_OFFSET		((unsigned long)(MEMORY_START >> PAGE_SHIFT))
> -#define pfn_valid(pfn)		((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
> +#define pfn_valid(pfn) \
> +		(((pfn) - ARCH_PFN_OFFSET) < (max_mapnr - ARCH_PFN_OFFSET))

I'm not a big fan of this one, because the original code is *far* more
obvious as to what it's doing.

I'm not sure if we can make this one a static inline, or whether that
would help, but it would be worth investigating.

cheers
