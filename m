Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932486AbeEWKuj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:50:39 -0400
Received: from foss.arm.com ([217.140.101.70]:53200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932312AbeEWKuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:50:35 -0400
Date: Wed, 23 May 2018 11:51:02 +0100
From: Will Deacon <will.deacon@arm.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] arm64: Make sure permission updates happen for pmd/pud
Message-ID: <20180523105102.GB26965@arm.com>
References: <20180522235049.23400-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522235049.23400-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Tue, May 22, 2018 at 04:50:49PM -0700, Laura Abbott wrote:
> Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> disallowed block mappings for ioremap since that code does not honor
> break-before-make. The same APIs are also used for permission updating
> though and the extra checks prevent the permission updates from happening,
> even though this should be permitted. This results in read-only permissions
> not being fully applied. Visibly, this can occasionaly be seen as a failure
> on the built in rodata test when the test data ends up in a section or
> as an odd RW gap on the page table dump. Fix this by keeping the check
> for the top level p*d_set_huge APIs but using separate functions for the
> update APIs.
> 
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/arm64/mm/mmu.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

Thanks for sending the fix. One thing below...

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9f1ec1..57517ad86910 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -66,6 +66,9 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
> +static void __pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot);
> +static void __pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot);
> +
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> @@ -200,7 +203,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>  		/* try section mapping first */
>  		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
>  		    (flags & NO_BLOCK_MAPPINGS) == 0) {
> -			pmd_set_huge(pmdp, phys, prot);
> +			__pmd_set_huge(pmdp, phys, prot);

Given that there is ongoing work to fix the core ioremap code, it would
be nice to avoid adding '__' versions if we can help it. Would it work
if we replaced the pXd_present check with a call to pgattr_change_is_safe
instead?

Will
