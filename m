Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeEVMN0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:13:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:34142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:13:21 -0400
Date: Tue, 22 May 2018 14:13:20 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Song Liu <songliubraving@fb.com>
Cc: linux-mm@kvack.org, kernel-team@fb.com, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] mm/THP: use hugepage_vma_check() in
 khugepaged_enter_vma_merge()
Message-ID: <20180522121319.GB30663@dhcp22.suse.cz>
References: <20180521193853.3089484-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521193853.3089484-1-songliubraving@fb.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Kirill]

On Mon 21-05-18 12:38:53, Song Liu wrote:
> khugepaged_enter_vma_merge() is using a different approach to check
> whether a vma is valid for khugepaged_enter():
> 
>     if (!vma->anon_vma)
>             /*
>              * Not yet faulted in so we will register later in the
>              * page fault if needed.
>              */
>             return 0;
>     if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
>             /* khugepaged not yet working on file or special mappings */
>             return 0;
> 
> This check has some problems. One of the obvious problems is that
> it doesn't check shmem_file(), so that vma backed with shmem files
> will not call khugepaged_enter().
> 
> This patch fixes these problems by reusing hugepage_vma_check() in
> khugepaged_enter_vma_merge().

It would be great to be more explicit about what are the actual
consequences. khugepaged_enter_vma_merge is called from multiple
context. Some of then do not really care about !anon case (e.g. stack
expansion). hugepage_madvise is quite convoluted so I am not really sure
from a quick look (are we simply not going to merge vmas even if we
could?).

Have you noticed this by a code inspection or you have seen this
happening in real workloads (aka, is this worth backporting to stable
trees)?
 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/khugepaged.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d7b2a4b..e50c2bd 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -430,18 +430,14 @@ int __khugepaged_enter(struct mm_struct *mm)
>  	return 0;
>  }
>  
> +static bool hugepage_vma_check(struct vm_area_struct *vma);
> +
>  int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
>  			       unsigned long vm_flags)
>  {
>  	unsigned long hstart, hend;
> -	if (!vma->anon_vma)
> -		/*
> -		 * Not yet faulted in so we will register later in the
> -		 * page fault if needed.
> -		 */
> -		return 0;
> -	if (vma->vm_ops || (vm_flags & VM_NO_KHUGEPAGED))
> -		/* khugepaged not yet working on file or special mappings */
> +
> +	if (!hugepage_vma_check(vma))
>  		return 0;
>  	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
>  	hend = vma->vm_end & HPAGE_PMD_MASK;
> -- 
> 2.9.5

-- 
Michal Hocko
SUSE Labs
