Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D73AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627E2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbeIXTDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:03:45 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35400 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbeIXTDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:03:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3523818A;
        Mon, 24 Sep 2018 06:01:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 029263F5BD;
        Mon, 24 Sep 2018 06:01:39 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:01:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] arm64/mm: Introduce the init_pg_dir.
Message-ID: <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-2-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917044333.30051-2-yaojun8558363@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:43:28PM +0800, Jun Yao wrote:
> To make the swapper_pg_dir read only, we will move it to the rodata
> section. And force the kernel to set up the initial page table in
> the init_pg_dir. After generating all levels page table, we copy
> only the top level into the swapper_pg_dir during paging_init().
> 
> In this patch, just add the init_pg_dir to vmlinux.lds.S and
> boiler-plate clearing/cleaning/invalidating it in head.S.

I don't believe it is necessary to explicitly zero init_pg_dir.

We have to clear swapper_pg_dir and idmap_pg_dir since they're after
_edata, and the bootloader won't have zeroed the relevant memory (nor
will it have cleaned that memory to the PoC).

However, anything in .init must have been loaded and cleaned to the PoC
by the bootloader per the arm64 Linux boot protocol. So as long as
that's zero in the kernel Image, that must be zero in memory (and any
caches).

> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
>  arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
>  3 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98dbba56..e7bdc324d538 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>  	b.ne	9998b
>  	.endm
>  
> +/*
> + * clear_page - clear one page
> + *
> + *	start:	page aligned virtual address
> + */
> +	.macro clear_page, start:req
> +9996:	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	tst	\start, #(PAGE_SIZE - 1)
> +	b.ne	9996b
> +	.endm
> +
> +/*
> + * clear_pages - clear contiguous pages
> + *
> + *	start, end:	page aligned virtual addresses
> + */
> +	.macro clear_pages, start:req, end:req
> +	sub	\end, \end, \start
> +	lsr	\end, \end, #(PAGE_SHIFT)
> +9997:	cbz	\end, 9998f
> +	clear_page \start
> +	sub	\end, \end, #1
> +	b	9997b
> +9998:
> +	.endm

Given the above, I don't think that we need these macros. In a
subsequent patch, we can just limit the range of pages that we zero.

> +
>  /*
>   * Annotate a function as position independent, i.e., safe to be called before
>   * the kernel virtual mapping is activated.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..2c83a8c47e3f 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -295,18 +295,21 @@ __create_page_tables:
>  	sub	x1, x1, x0
>  	bl	__inval_dcache_area
>  
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	sub	x1, x1, x0
> +	bl	__inval_dcache_area
> +
>  	/*
>  	 * Clear the idmap and swapper page tables.
>  	 */
>  	adrp	x0, idmap_pg_dir
>  	adrp	x1, swapper_pg_end
> -	sub	x1, x1, x0
> -1:	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	subs	x1, x1, #64
> -	b.ne	1b
> +	clear_pages x0, x1
> +
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	clear_pages x0, x1
>  
>  	mov	x7, SWAPPER_MM_MMUFLAGS
>  
> @@ -395,6 +398,11 @@ __create_page_tables:
>  	dmb	sy
>  	bl	__inval_dcache_area
>  
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	sub	x1, x1, x0
> +	bl	__inval_dcache_area
> +
>  	ret	x28
>  ENDPROC(__create_page_tables)
>  	.ltorg
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..612ffc0bbe11 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -68,6 +68,12 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define INIT_PG_TABLES					\
> +	. = ALIGN(PAGE_SIZE);				\
> +	init_pg_dir = .;				\
> +	. += SWAPPER_DIR_SIZE;				\
> +	init_pg_end = .;

This will allocate a full set of PGD + PUD + PMD (+ PTE) levels, but the
commit message says we only copy the top level table.

The memory for otjher levels of table can be re-allocated once the
kernel init phase is over, so that seems a bit worrying.

Do we switch over to new copies of those levels, or do we continue using
the entries from INIT_PG_TABLES?

Thanks,
Mark.

> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -161,6 +167,8 @@ SECTIONS
>  	__inittext_end = .;
>  	__initdata_begin = .;
>  
> +	INIT_PG_TABLES
> +
>  	.init.data : {
>  		INIT_DATA
>  		INIT_SETUP(16)
> -- 
> 2.17.1
> 
