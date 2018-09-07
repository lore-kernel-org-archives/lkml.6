Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE769C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02E320861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02E320861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeIGOhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:37:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57870 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGOhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:37:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA10518A;
        Fri,  7 Sep 2018 02:57:39 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA9D73F614;
        Fri,  7 Sep 2018 02:57:38 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 3/6] arm64/mm: Create the initial page table in
 the init_pg_dir.
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-4-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <67fddf32-092f-4661-9d33-93654f668ac2@arm.com>
Date:   Fri, 7 Sep 2018 10:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095432.12125-4-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> Create the initial page table in the init_pg_dir. And before
> calling kasan_early_init(), we update the init_mm.pgd by
> introducing set_init_mm_pgd(). This will ensure that pgd_offset_k()
> works correctly. When the final page table is created, we redirect
> the init_mm.pgd to the swapper_pg_dir.

> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index c3e4b1886cde..ede2e964592b 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -402,7 +402,6 @@ __create_page_tables:
>  	adrp	x1, init_pg_end
>  	sub	x1, x1, x0
>  	bl	__inval_dcache_area
> -
>  	ret	x28
>  ENDPROC(__create_page_tables)
>  	.ltorg

Nit: spurious whitespace change.


> @@ -439,6 +438,9 @@ __primary_switched:
>  	bl	__pi_memset
>  	dsb	ishst				// Make zero page visible to PTW
>  
> +	adrp	x0, init_pg_dir
> +	bl	set_init_mm_pgd

Having a C helper to just do a store is a bit strange, calling C code before
kasan is ready is clearly causing some pain.

Couldn't we just do store in assembly here?:
------------------%<------------------
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ede2e964592b..7464fb31452d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -439,7 +439,8 @@ __primary_switched:
        dsb     ishst                           // Make zero page visible to PTW

        adrp    x0, init_pg_dir
-       bl      set_init_mm_pgd
+       adr_l   x1, init_mm
+       str     x0, [x1, #MM_PGD]

 #ifdef CONFIG_KASAN
        bl      kasan_early_init
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 323aeb5f2fe6..43f52cfdfad4 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -82,6 +82,7 @@ int main(void)
   DEFINE(S_FRAME_SIZE,      sizeof(struct pt_regs));
   BLANK();
   DEFINE(MM_CONTEXT_ID,     offsetof(struct mm_struct, context.id.counter));
+  DEFINE(MM_PGD,            offsetof(struct mm_struct, pgd));
   BLANK();
   DEFINE(VMA_VM_MM,         offsetof(struct vm_area_struct, vm_mm));
   DEFINE(VMA_VM_FLAGS,      offsetof(struct vm_area_struct, vm_flags));
------------------%<------------------


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 65f86271f02b..f7e544f6f3eb 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -623,6 +623,19 @@ static void __init map_kernel(pgd_t *pgdp)
>  	kasan_copy_shadow(pgdp);
>  }
>  
> +/*
> + * set_init_mm_pgd() just updates init_mm.pgd. The purpose of using
> + * assembly is to prevent KASAN instrumentation, as KASAN has not
> + * been initialized when this function is called.

You're hiding the store from KASAN as its shadow region hasn't been initialized yet?

I think newer versions of the compiler let KASAN check stack accesses too, and
the compiler may generate those all by itself. Hiding things like this gets us
into an arms-race with the compiler.


> +void __init set_init_mm_pgd(pgd_t *pgd)
> +{
> +	pgd_t **addr = &(init_mm.pgd);
> +
> +	asm volatile("str %x0, [%1]\n"
> +			: : "r" (pgd), "r" (addr) : "memory");
> +}
> +
>  /*
>   * paging_init() sets up the page tables, initialises the zone memory
>   * maps and sets up the zero page.


Thanks,

James
