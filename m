Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE40ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E1621486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E1621486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbeIXT2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:28:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbeIXT2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6890F18A;
        Mon, 24 Sep 2018 06:26:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 361143F5BD;
        Mon, 24 Sep 2018 06:26:26 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:26:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] arm64/mm: Pass ttbr1 as a parameter to
 __enable_mmu().
Message-ID: <20180924132623.sageakfcvchkgw7l@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-3-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917044333.30051-3-yaojun8558363@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:43:29PM +0800, Jun Yao wrote:
> The kernel will set up the initial page table in the init_pg_dir.
> However, it will create the final page table in the swapper_pg_dir
> during the initialization process. We need to let __enable_mmu()
> know which page table to use.
> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/kernel/head.S  | 19 +++++++++++--------
>  arch/arm64/kernel/sleep.S |  1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2c83a8c47e3f..de2aaea00bd2 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -714,6 +714,7 @@ secondary_startup:
>  	 * Common entry point for secondary CPUs.
>  	 */
>  	bl	__cpu_setup			// initialise processor
> +	adrp	x1, swapper_pg_dir
>  	bl	__enable_mmu
>  	ldr	x8, =__secondary_switched
>  	br	x8
> @@ -756,6 +757,7 @@ ENDPROC(__secondary_switched)
>   * Enable the MMU.
>   *
>   *  x0  = SCTLR_EL1 value for turning on the MMU.
> + *  x1  = TTBR1_EL1 value for turning on the MMU.
>   *
>   * Returns to the caller via x30/lr. This requires the caller to be covered
>   * by the .idmap.text section.
> @@ -764,15 +766,15 @@ ENDPROC(__secondary_switched)
>   * If it isn't, park the CPU
>   */
>  ENTRY(__enable_mmu)
> -	mrs	x1, ID_AA64MMFR0_EL1
> -	ubfx	x2, x1, #ID_AA64MMFR0_TGRAN_SHIFT, 4
> -	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
> +	mrs	x5, ID_AA64MMFR0_EL1
> +	ubfx	x6, x5, #ID_AA64MMFR0_TGRAN_SHIFT, 4
> +	cmp	x6, #ID_AA64MMFR0_TGRAN_SUPPORTED
>  	b.ne	__no_granule_support
> -	update_early_cpu_boot_status 0, x1, x2
> -	adrp	x1, idmap_pg_dir
> -	adrp	x2, swapper_pg_dir
> -	phys_to_ttbr x3, x1
> -	phys_to_ttbr x4, x2
> +	update_early_cpu_boot_status 0, x5, x6
> +	adrp	x5, idmap_pg_dir
> +	mov	x6, x1
> +	phys_to_ttbr x3, x5
> +	phys_to_ttbr x4, x6
>  	msr	ttbr0_el1, x3			// load TTBR0
>  	msr	ttbr1_el1, x4			// load TTBR1
>  	isb

I think that the register shuffling here is unnecessarily confusing, as
this can be reduced to:

ENTRY(__enable_mmu)
	mrs	x2, ID_AA64MMFR0_EL1
	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
	b.ne	__no_granule_support
	update_early_cpu_boot_status 0, x2, x3
	adrp	x2, idmap_pg_dir
	phys_to_ttbr x1, x1
	phys_to_ttbr x2, x2
	msr	ttbr0_el1, x2			// load TTBR0
	msr	ttbr1_el1, x1			// load TTBR1
	isb

... otherwhise, this patch looks sane to me, so with the above change:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> @@ -831,6 +833,7 @@ __primary_switch:
>  	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
>  #endif
>  
> +	adrp	x1, swapper_pg_dir
>  	bl	__enable_mmu
>  #ifdef CONFIG_RELOCATABLE
>  	bl	__relocate_kernel
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index bebec8ef9372..3e53ffa07994 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -101,6 +101,7 @@ ENTRY(cpu_resume)
>  	bl	el2_setup		// if in EL2 drop to EL1 cleanly
>  	bl	__cpu_setup
>  	/* enable the MMU early - so we can access sleep_save_stash by va */
> +	adrp	x1, swapper_pg_dir
>  	bl	__enable_mmu
>  	ldr	x8, =_cpu_resume
>  	br	x8
> -- 
> 2.17.1
> 
