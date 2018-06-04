Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeFDMOX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:14:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42440 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751992AbeFDMOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:14:22 -0400
Date: Mon, 4 Jun 2018 13:14:52 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 5/5] arm64: Allow huge io mappings again
Message-ID: <20180604121452.GK9482@arm.com>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-6-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527856758-27169-6-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:09:18PM +0530, Chintan Pandya wrote:
> Huge mappings have had stability issues due to stale
> TLB entry and memory leak issues. Since, those are
> addressed in this series of patches, it is now safe
> to allow huge mappings.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6e7e16c..c65abc4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -934,15 +934,8 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>  {
>  	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
>  					pgprot_val(mk_sect_prot(prot)));
> -	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
> -
> -	/* Only allow permission changes for now */
> -	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
> -				   pud_val(new_pud)))
> -		return 0;

Do you actually need to remove these checks? If we're doing
break-before-make properly, then the check won't fire but it would be
good to keep it there so we can catch misuse of these in future.

In other words, can we drop this patch?

Will
