Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeEHLRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:17:43 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:45031 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754297AbeEHLRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:17:42 -0400
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH -mm] mm, pagemap: Hide swap entry for unprivileged users
To: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>, Michal Hocko <mhocko@suse.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20180508012745.7238-1-ying.huang@intel.com>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <19a9a3f8-3113-f2bb-b83f-1c423069e3d0@yandex-team.ru>
Date: Tue, 8 May 2018 14:17:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508012745.7238-1-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.2018 04:27, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> In ab676b7d6fbf ("pagemap: do not leak physical addresses to
> non-privileged userspace"), the /proc/PID/pagemap is restricted to be
> readable only by CAP_SYS_ADMIN to address some security issue.  In
> 1c90308e7a77 ("pagemap: hide physical addresses from non-privileged
> users"), the restriction is relieved to make /proc/PID/pagemap
> readable, but hide the physical addresses for non-privileged users.
> But the swap entries are readable for non-privileged users too.  This
> has some security issues.  For example, for page under migrating, the
> swap entry has physical address information.  So, in this patch, the
> swap entries are hided for non-privileged users too.
> 
> Fixes: 1c90308e7a77 ("pagemap: hide physical addresses from non-privileged users")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Looks good.

Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> ---
>   fs/proc/task_mmu.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index a20c6e495bb2..ff947fdd7c71 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1258,8 +1258,9 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>   		if (pte_swp_soft_dirty(pte))
>   			flags |= PM_SOFT_DIRTY;
>   		entry = pte_to_swp_entry(pte);
> -		frame = swp_type(entry) |
> -			(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> +		if (pm->show_pfn)
> +			frame = swp_type(entry) |
> +				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
>   		flags |= PM_SWAP;
>   		if (is_migration_entry(entry))
>   			page = migration_entry_to_page(entry);
> @@ -1310,11 +1311,14 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>   		else if (is_swap_pmd(pmd)) {
>   			swp_entry_t entry = pmd_to_swp_entry(pmd);
> -			unsigned long offset = swp_offset(entry);
> +			unsigned long offset;
>   
> -			offset += (addr & ~PMD_MASK) >> PAGE_SHIFT;
> -			frame = swp_type(entry) |
> -				(offset << MAX_SWAPFILES_SHIFT);
> +			if (pm->show_pfn) {
> +				offset = swp_offset(entry) +
> +					((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +				frame = swp_type(entry) |
> +					(offset << MAX_SWAPFILES_SHIFT);
> +			}
>   			flags |= PM_SWAP;
>   			if (pmd_swp_soft_dirty(pmd))
>   				flags |= PM_SOFT_DIRTY;
> @@ -1332,10 +1336,12 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>   			err = add_to_pagemap(addr, &pme, pm);
>   			if (err)
>   				break;
> -			if (pm->show_pfn && (flags & PM_PRESENT))
> -				frame++;
> -			else if (flags & PM_SWAP)
> -				frame += (1 << MAX_SWAPFILES_SHIFT);
> +			if (pm->show_pfn) {
> +				if (flags & PM_PRESENT)
> +					frame++;
> +				else if (flags & PM_SWAP)
> +					frame += (1 << MAX_SWAPFILES_SHIFT);
> +			}
>   		}
>   		spin_unlock(ptl);
>   		return err;
> 
