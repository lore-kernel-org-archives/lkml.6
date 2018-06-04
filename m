Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeFDF4f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:56:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56094 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeFDF4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:56:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC3B8605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v12 0/5] Fix issues with huge mapping in ioremap for ARM64
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <1a648674-da56-6664-bf3c-0cdf825ad1e3@codeaurora.org>
Date: Mon, 4 Jun 2018 11:26:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Just curious to know, is there anything that I should be addressing
in these patches ? For now, I don't see anything from my side that
requires modification, unless one has some more review comments on
this.

Status so far on and around this:
  - Status of Toshi's series of patches is still not clear to me.
    However, if this series can get through first, there won't
    be conflicting scenarios as far as arm64 is concerned.
  - I've rebased these patches on tip
  - Also re-tested these patches for long duration tests with
    1 GB mapping case also exercised enough. Test ended positively.

Thanks,

On 6/1/2018 6:09 PM, Chintan Pandya wrote:
> This series of patches re-bring huge vmap back for arm64.
> 
> Patch 1/4 has been taken by Toshi in his series of patches
> by name "[PATCH v3 0/3] fix free pmd/pte page handlings on x86"
> to avoid merge conflict with this series.
> 
> These patches are tested on 4.16 kernel with Cortex-A75 based SoC.
> 
> The test used for verifying these patches is a stress test on
> ioremap/unmap which tries to re-use same io-address but changes
> size of mapping randomly i.e. 4K to 2M to 1G etc. The same test
> used to reproduce 3rd level translation fault without these fixes
> (and also of course with Revert "arm64: Enforce BBM for huge IO/VMAP
> mappings" being part of the tree).
> 
> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.
> 
>  From V11->V12:
>   - Introduced p*d_page_vaddr helper macros and using them
>   - Rebased over current tip
> 
>  From V10->V11:
>   - Updated pud_free_pmd_page & pmd_free_pte_page to use consistent
>     conding style
>   - Fixed few bugs by using pmd_page_paddr & pud_page_paddr
> 
>  From V9->V10:
>   - Updated commit log for patch 1/4 by Toshi
>   - Addressed review comments by Will on patch 3/4
> 
>  From V8->V9:
>   - Used __TLBI_VADDR macros in new TLB flush API
> 
>  From V7->V8:
>   - Properly fixed compilation issue in x86 file
> 
>  From V6->V7:
>   - Fixed compilation issue in x86 case
>   - V6 patches were not properly enumarated
> 
>  From V5->V6:
>   - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
>     "bool tlb_inv" based variance as it is not need now
>   - Re-naming for consistency
> 
>  From V4->V5:
>   - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
>     for kernel addresses
> 
>  From V3->V4:
>   - Add header for 'addr' in x86 implementation
>   - Re-order pmd/pud clear and table free
>   - Avoid redundant TLB invalidatation in one perticular case
> 
>  From V2->V3:
>   - Use the exisiting page table free interface to do arm64
>     specific things
> 
>  From V1->V2:
>   - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
>     Add interfaces to free unmapped page table"
>   - Honored BBM for ARM64
> 
> Chintan Pandya (5):
>    ioremap: Update pgtable free interfaces with addr
>    arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
>    arm64: pgtable: Add p*d_page_vaddr helper macros
>    arm64: Implement page table free interfaces
>    arm64: Re-enable huge io mappings
> 
>   arch/arm64/include/asm/pgtable.h  |  3 +++
>   arch/arm64/include/asm/tlbflush.h |  7 +++++
>   arch/arm64/mm/mmu.c               | 56 +++++++++++++++++++++++++--------------
>   arch/x86/mm/pgtable.c             |  8 +++---
>   include/asm-generic/pgtable.h     |  8 +++---
>   lib/ioremap.c                     |  4 +--
>   6 files changed, 57 insertions(+), 29 deletions(-)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
