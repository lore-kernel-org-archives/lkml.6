Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A6BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE12C2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE12C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbeIXWZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:25:04 -0400
Received: from foss.arm.com ([217.140.101.70]:38316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeIXWZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:25:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50EB18A;
        Mon, 24 Sep 2018 09:22:07 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.emea.arm.com [10.4.12.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B326A3F5BD;
        Mon, 24 Sep 2018 09:22:05 -0700 (PDT)
Date:   Mon, 24 Sep 2018 17:22:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk,
        steve.capper@linaro.org, juju.sung@mediatek.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        miles.chen@mediatek.com, Simon Horman <horms@verge.net.au>,
        jian-min.lui@mediatek.com, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] arm: mm: reordering memory type table
Message-ID: <20180924162202.GD52978@arrakis.emea.arm.com>
References: <20180917004451.174527-1-minchan@kernel.org>
 <20180917004451.174527-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917004451.174527-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 09:44:49AM +0900, Minchan Kim wrote:
> To use bit 5 in page table as L_PTE_SPECIAL, we need a room for that.
> It seems we don't need 4 bits for the memory type with ARMv6+.
> If it's true, let's reorder bits to make bit 5 free.
> 
> We will use the bit for L_PTE_SPECIAL in next patch.
> 
> A note from Catalin
> "
> > Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to

I meant 'ARMv7+LPAE' since ARMv6 never had the LPAE feature (please
correct the code comment below as well).

I was wrong with the classic ARMv7, only ARMv7+LPAE makes all device
memory shareable in hardware (even if not enabled). With classic ARMv7
(that is pre-Cortex-A7/A15), the shareable bit in combination with PRRR
allows the Device Non-shareable configuration.

Anyway, it doesn't matter here since the L_PTE_SHARED bit is set
separately in the mem_types[] array, the L_PTE_MT_* definitions are just
for the actual memory type ignoring shareability. We just need to make
sure the comments are correct.

> > shared device in hardware. Looking through the arm32 code, it seems that
> > MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> > and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> > should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> > DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on shmbile).

It would be good to figure out the DEV_NONSHARED on ARMv6 relevance. I
don't think we break R-Car H1 since the shareability bit wouldn't be set
for DEV_NONSHARED.

> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 92fd2c8a9af0..514b13c27b43 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -164,14 +164,25 @@
>  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
>  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
>  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> +#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
>  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
>  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> +#if defined(CONFIG_CPU_V7) || defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> +/*
> + * On ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> + * shared device in hardware.
> + */

I would change this to something like:

/*
 * On ARMv7 or ARMv7+LPAE, the non-shared and shared device types get
 * mapped to the same TEX remapping index. On classic ARMv7, the
 * shareability is controlled by the PRRR[17:16] field, indexed by
 * L_PTE_SHARED. On ARMv7+LPAE the device mapping is always shareable.
 */

> +#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_DEV_SHARED
> +#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
> +#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
> +#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
> +#else
>  #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
>  #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
> -#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
> -#define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
> +#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> +#define L_PTE_MT_MASK           (_AT(pteval_t, 0x0f) << 2)
> +#endif
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 81d0efb055c6..367a89d5aeca 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -138,7 +138,7 @@
>  	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
>  	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
>  	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
> -	.long	0x00						@ unused
> +	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
>  	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
>  	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
>  	.long	0x00						@ unused
> @@ -148,7 +148,7 @@
>  	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
>  	.long	0x00						@ unused
>  	.long	0x00						@ unused
> -	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
> +	.long	0x00						@ unused
>  	.endm

Looking at the L_PTE_MT_VECTORS uses, I don't think this gives you what
you intended. vecs_pgprot in build_mem_type_table() actually combines
the cache policy bits with L_PTE_MT_VECTORS and this might have been the
reason why it was on the last position (all bits 1). So the default
cachepolicy of L_PTE_MT_WRITEBACK or'ed with the new L_PTE_MT_VECTORS
gives you 0b0111 which is position 7 instead of 5. This would map onto
L_PTE_MT_WRITEALLOC (which is not that bad) but misses the APX bit which
marks the vectors page r/w for kernel and ro for user.

I don't think this matters since the kernel no longer writes to the
vectors page at run-time but it needs cleaning up a bit (and testing in
case I missed something). IOW, do we still need a dedicated mapping type
for the vectors or we can simply use the read-only user page attributes?

-- 
Catalin
