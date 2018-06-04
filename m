Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbeFDPJb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:09:31 -0400
Received: from foss.arm.com ([217.140.101.70]:44686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbeFDPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:09:30 -0400
Date: Mon, 4 Jun 2018 16:10:00 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 3/5] arm64: pgtable: Add p*d_page_vaddr helper macros
Message-ID: <20180604150959.GC8593@arm.com>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-4-git-send-email-cpandya@codeaurora.org>
 <20180604121351.GJ9482@arm.com>
 <28cc339e-b184-5f15-eca3-cf54e9376e01@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cc339e-b184-5f15-eca3-cf54e9376e01@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 07:13:48PM +0530, Chintan Pandya wrote:
> 
> 
> On 6/4/2018 5:43 PM, Will Deacon wrote:
> >On Fri, Jun 01, 2018 at 06:09:16PM +0530, Chintan Pandya wrote:
> >>Add helper macros to give virtual references to page
> >>tables. These will be used while freeing dangling
> >>page tables.
> >>
> >>Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> >>---
> >>  arch/arm64/include/asm/pgtable.h | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >>diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >>index 7c4c8f3..ef4047f 100644
> >>--- a/arch/arm64/include/asm/pgtable.h
> >>+++ b/arch/arm64/include/asm/pgtable.h
> >>@@ -580,6 +580,9 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
> >>  #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
> >>+#define pmd_page_vaddr(pmd) __va(pmd_page_paddr(pmd))
> >>+#define pud_page_vaddr(pud) __va(pud_page_paddr(pud))
> >
> >Are these actually needed, or do pte_offset_kernel and pmd_offset do the
> >job already?
> >
> 
> I introduced these macros for consistency across different arch.
> 
> Looking at pte_offset_kernel, it seems to use READ_ONCE() which looks
> little costly for its intended use (in next patch) where we already have
> dereferenced value. Do you still suggest to remove this ?

It's only an additional load instruction on the freeing path and it matches
what we do in other page table code, so I'd rather use the existing API
unless we have numbers to show otherwise.

Will
