Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDJB27 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 21:28:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:41109 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeDJB26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 21:28:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="30858982"
From: "Huang\, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrei Vagin <avagin@openvz.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Daniel Colascione <dancol@google.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH -mm] mm, pagemap: Fix swap offset value for PMD migration entry
References: <20180408033737.10897-1-ying.huang@intel.com>
Date: Tue, 10 Apr 2018 09:28:54 +0800
In-Reply-To: <20180408033737.10897-1-ying.huang@intel.com> (Ying Huang's
        message of "Sun, 8 Apr 2018 11:37:37 +0800")
Message-ID: <87fu43lui1.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

"Huang, Ying" <ying.huang@intel.com> writes:

> From: Huang Ying <ying.huang@intel.com>
>
> The swap offset reported by /proc/<pid>/pagemap may be not correct for
> PMD migration entry.  If addr passed into pagemap_range() isn't
> aligned with PMD start address, the swap offset reported doesn't
> reflect this.  And in the loop to report information of each sub-page,
> the swap offset isn't increased accordingly as that for PFN.
>
> BTW: migration swap entries have PFN information, do we need to
> restrict whether to show them?
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andrei Vagin <avagin@openvz.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Jerome Glisse" <jglisse@redhat.com>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Zi Yan <zi.yan@cs.rutgers.edu>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> ---
>  fs/proc/task_mmu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 65ae54659833..757e748da613 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1310,9 +1310,11 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  		else if (is_swap_pmd(pmd)) {
>  			swp_entry_t entry = pmd_to_swp_entry(pmd);
> +			unsigned long offset = swp_offset(entry);
>  
> +			offset += (addr & ~PMD_MASK) >> PAGE_SHIFT;
>  			frame = swp_type(entry) |
> -				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> +				(offset << MAX_SWAPFILES_SHIFT);
>  			flags |= PM_SWAP;
>  			if (pmd_swp_soft_dirty(pmd))
>  				flags |= PM_SOFT_DIRTY;
> @@ -1332,6 +1334,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  				break;
>  			if (pm->show_pfn && (flags & PM_PRESENT))
>  				frame++;
> +			else if (flags | PM_SWAP)

Oops, I just found a typo here, it should be,

+			else if (flags & PM_SWAP)

Sorry about that.  Do I need to refresh the patch or you will fix it
inline?

Best Regards,
Huang, Ying

> +				frame += (1 << MAX_SWAPFILES_SHIFT);
>  		}
>  		spin_unlock(ptl);
>  		return err;
