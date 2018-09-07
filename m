Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83731C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43921204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43921204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeIGOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:37:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57848 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGOha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:37:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D99915AD;
        Fri,  7 Sep 2018 02:57:19 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698B73F614;
        Fri,  7 Sep 2018 02:57:18 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 2/6] arm64/mm: Pass ttbr1 as a parameter to
 __enable_mmu().
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-3-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4279135f-393c-d3c1-91dd-cc77159a6062@arm.com>
Date:   Fri, 7 Sep 2018 10:57:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095432.12125-3-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> The kernel sets up the initial page table in the init_pg_dir.

(Nit: 'will set up', it doesn't until patch 3.)

> However, it will create the final page table in the swapper_pg_dir
> during the initialization process. We need to let __enable_mmu()
> know which page table to use.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 2c83a8c47e3f..c3e4b1886cde 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
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
> @@ -791,7 +793,7 @@ ENDPROC(__enable_mmu)
>  
>  __no_granule_support:
>  	/* Indicate that this CPU can't boot and is stuck in the kernel */


> -	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x1, x2
> +	update_early_cpu_boot_status CPU_STUCK_IN_KERNEL, x5, x6

(You don't need to change these as they are both temporary registers.)

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
