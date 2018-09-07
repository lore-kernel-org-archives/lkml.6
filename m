Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D1C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670E6204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670E6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeIGOig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:38:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57910 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbeIGOif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:38:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF6CF15AD;
        Fri,  7 Sep 2018 02:58:24 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E839A3F614;
        Fri,  7 Sep 2018 02:58:23 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com>
Date:   Fri, 7 Sep 2018 10:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095432.12125-6-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> Since we will move the swapper_pg_dir to rodata section, we need a
> way to update it. The fixmap can handle it. When the swapper_pg_dir
> needs to be updated, we map it dynamically. The map will be
> canceled after the update is complete. In this way, we can defend
> against KSMA(Kernel Space Mirror Attack).


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 46ef21ebfe47..d5c3df99af7b 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -428,8 +435,32 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PUD_TYPE_TABLE)
>  #endif
>  
> +extern spinlock_t swapper_pgdir_lock;

Hmmm, it would be good if we could avoid exposing this lock.
Wherever this ends up needs to include spinlock.h, and we don't have to do that
in arch headers today.


>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +	if (in_swapper_pgdir(pmdp)) {
> +		pmd_t *fixmap_pmdp;
> +
> +		spin_lock(&swapper_pgdir_lock);
> +		fixmap_pmdp = (pmd_t *)pgd_set_fixmap(__pa(pmdp));
> +		WRITE_ONCE(*fixmap_pmdp, pmd);
> +		dsb(ishst);
> +		pgd_clear_fixmap();
> +		spin_unlock(&swapper_pgdir_lock);
> +		return;
> +	}
> +#endif

You have this pattern multiple times, it ought to be a macro. (Any reason why
the last copy for pgd is different?)

Putting all this directly into the inlined helper is noisy and risks bloating
the locations it appears. Could we do the in_swappper_pgdir() test, and if it
passes call some out-of-line set_swapper_pgd() that lives in mm/mmu.c? Once we
know we're using the fixmap I don't think there is a benefit to inline-ing the code.

Doing this would avoid moving the extern defines and p?d_set_fixmap() helpers
around in this header and let us avoid extern-ing the lock or including
spinlock.h in here.


>  	WRITE_ONCE(*pmdp, pmd);
>  	dsb(ishst);
>  }
> @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if (in_swapper_pgdir(pudp)) {
> +		pud_t *fixmap_pudp;
> +
> +		spin_lock(&swapper_pgdir_lock);
> +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));

This is a bit subtle: are you using the pgd fixmap entry because the path from
map_mem() uses the other three?

Using the pgd fix slot for a pud looks a bit strange to me, but its arguably a
side-effect of the folding.

I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
be during paging_init(). What do you think to keeping paging_init()s use of the
pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
during paging_init()?


> +		WRITE_ONCE(*fixmap_pudp, pud);

> +		dsb(ishst);
> +		pgd_clear_fixmap();

Hmm,

p?d_clear_fixmap() is done by calling __set_fixmap(FIX_P?G, 0, __pgprot(0)).

__set_fixmap() calls flush_tlb_kernel_range() if the flags are 0.

flush_tlb_kernel_range() has a dsb(ishst) before it does the maintenance, (even
via flush_tlb_all()).

I think we can replace replace the dsb() before each p?d_clear_fixmap() call
with a comment that the flush_tlb_*() will do it for us. Something like:

|/*
| * We need dsb(ishst) here to ensure the page-table-walker sees our new entry
| * before set_p?d() returns. The fixmap's flush_tlb_kernel_range() via
| * clear_fixmap() does this for us.
| */


> +		spin_unlock(&swapper_pgdir_lock);
> +		return;
> +	}
> +#endif
>  	WRITE_ONCE(*pudp, pud);
>  	dsb(ishst);
>  }


Thanks,

James
