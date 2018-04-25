Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeDYHJT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:09:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46767 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDYHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:09:14 -0400
X-Google-Smtp-Source: AB8JxZprzHe0kJZRd/Kk19eKWZn7ZTHnxuY0nHfyR++ytjH++HNVLmvfKezL0yEAknFBl3iAT+9mxw==
Date: Wed, 25 Apr 2018 00:09:12 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Souptick Joarder <jrdr.linux@gmail.com>
cc: akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        ross.zwisler@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        mhocko@suse.com, shli@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: huge_memory: Change return type to vm_fault_t
In-Reply-To: <20180425044326.GA21504@jordon-HP-15-Notebook-PC>
Message-ID: <alpine.DEB.2.21.1804250006120.51102@chino.kir.corp.google.com>
References: <20180425044326.GA21504@jordon-HP-15-Notebook-PC>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Souptick Joarder wrote:

> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Updated the change log
> 
>  include/linux/huge_mm.h | 5 +++--
>  mm/huge_memory.c        | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index a8a1262..d3bbf6b 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_HUGE_MM_H
>  
>  #include <linux/sched/coredump.h>
> +#include <linux/mm_types.h>
>  
>  #include <linux/fs.h> /* only for vma_is_dax() */
>  
> @@ -46,9 +47,9 @@ extern bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>  extern int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  			unsigned long addr, pgprot_t newprot,
>  			int prot_numa);
> -int vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> +vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			pmd_t *pmd, pfn_t pfn, bool write);
> -int vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> +vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  			pud_t *pud, pfn_t pfn, bool write);
>  enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_FLAG,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 87ab9b8..1fe4705 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -755,7 +755,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	spin_unlock(ptl);
>  }
>  
> -int vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> +vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			pmd_t *pmd, pfn_t pfn, bool write)
>  {
>  	pgprot_t pgprot = vma->vm_page_prot;
> @@ -815,7 +815,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  	spin_unlock(ptl);
>  }
>  
> -int vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
> +vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
>  			pud_t *pud, pfn_t pfn, bool write)
>  {
>  	pgprot_t pgprot = vma->vm_page_prot;

This isn't very useful unless functions that return the return value of 
these functions, __dev_dax_{pmd,pud}_fault(), recast it as an int.  
__dev_dax_pte_fault() would do the same thing, so it should logically also 
be vm_fault_t, so then you would convert dev_dax_huge_fault() and
dev_dax_fault() as well in the same patch.
