Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBTJZD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 04:25:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeBTJY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 04:24:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2323A602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
To: Hanjun Guo <guohanjun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
        Toshi Kani <toshi.kani@hpe.com>, Xuefeng Wang <wxf.wang@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linuxarm@huawei.com,
        linux-mm@kvack.org, Hanjun Guo <hanjun.guo@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
Date: Tue, 20 Feb 2018 14:54:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2017 4:54 PM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> When we using iounmap() to free the 4K mapping, it just clear the PTEs
> but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> tables.
> 
> This will cause issues on ARM64 platform (not sure if other archs have
> the same issue) for this case:
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>     then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>     which will lead to kernel panic.
> 
> Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> zero.
> 
One obvious problem I see here is, once any 2nd level entry has 3rd 
level mapping, this entry can't map 2M section ever in future. This way, 
we will fragment entire virtual space over time.

The code you are changing is common between 32-bit systems as well (I 
think). And running out of section mapping would be a reality in 
practical terms.

So, if we can do the following as a fix up, we would be saved.
1) Invalidate 2nd level entry from TLB, and
2) Free the page which holds last level page table

BTW, is there any further discussion going on this topic which I am 
missing ?

> Reported-by: Lei Li <lious.lilei@hisilicon.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Toshi Kani <toshi.kani@hpe.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Xuefeng Wang <wxf.wang@hisilicon.com>
> ---
> 
> Not sure if this is the right direction, this patch has a obvious
> side effect that a mapped address with 4K will not back to 2M.  I may
> miss something and just wrong, so this is just a RFC version, comments
> are welcomed.
> 
>   lib/ioremap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index b808a39..4e6f19a 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -89,7 +89,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>   	do {
>   		next = pmd_addr_end(addr, end);
>   
> -		if (ioremap_pmd_enabled() &&
> +		if (ioremap_pmd_enabled() && pmd_none(*pmd) &&
>   		    ((next - addr) == PMD_SIZE) &&
>   		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
>   			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> @@ -115,7 +115,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>   	do {
>   		next = pud_addr_end(addr, end);
>   
> -		if (ioremap_pud_enabled() &&
> +		if (ioremap_pud_enabled() && pud_none(*pud) &&
>   		    ((next - addr) == PUD_SIZE) &&
>   		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
>   			if (pud_set_huge(pud, phys_addr + addr, prot))
> @@ -141,7 +141,7 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
>   	do {
>   		next = p4d_addr_end(addr, end);
>   
> -		if (ioremap_p4d_enabled() &&
> +		if (ioremap_p4d_enabled() && p4d_none(*p4d) &&
>   		    ((next - addr) == P4D_SIZE) &&
>   		    IS_ALIGNED(phys_addr + addr, P4D_SIZE)) {
>   			if (p4d_set_huge(p4d, phys_addr + addr, prot))
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
