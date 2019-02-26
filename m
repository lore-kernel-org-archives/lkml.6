Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDA72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfBZPMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:12:40 -0500
Received: from foss.arm.com ([217.140.101.70]:48998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfBZPMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:12:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 953BBA78;
        Tue, 26 Feb 2019 07:12:39 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32803F575;
        Tue, 26 Feb 2019 07:12:36 -0800 (PST)
Date:   Tue, 26 Feb 2019 15:12:31 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] arm64: mm: use appropriate ctors for page tables
Message-ID: <20190226151230.GA20230@lakrids.cambridge.arm.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 18, 2019 at 04:13:17PM -0700, Yu Zhao wrote:
> For pte page, use pgtable_page_ctor(); for pmd page, use
> pgtable_pmd_page_ctor() if not folded; and for the rest (pud,
> p4d and pgd), don't use any.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)

[...]

> -static phys_addr_t pgd_pgtable_alloc(void)
> +static phys_addr_t pgd_pgtable_alloc(int shift)
>  {
>  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> -	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
> -		BUG();
> +	BUG_ON(!ptr);
> +
> +	/*
> +	 * Initialize page table locks in case later we need to
> +	 * call core mm functions like apply_to_page_range() on
> +	 * this pre-allocated page table.
> +	 */
> +	if (shift == PAGE_SHIFT)
> +		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
> +	else if (shift == PMD_SHIFT && PMD_SHIFT != PUD_SHIFT)
> +		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));

IIUC, this is for nopmd kernels, where we only have real PGD and PTE
levels of table. From my PoV, that would be clearer if we did:

	else if (shift == PMD_SHIFT && !is_defined(__PAGETABLE_PMD_FOLDED))

... though IMO it would be a bit nicer if the generic
pgtable_pmd_page_ctor() were nop'd out for __PAGETABLE_PMD_FOLDED
builds, so that callers don't have to be aware of folding.

I couldn't think of a nicer way of distinguishing levels of table, and
having separate function pointers for each level seems over-the-top, so
otehr than that this looks good to me.

Assuming you're happy with the above change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
