Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE54C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748272083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfBUSTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfBUSTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:19:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E0B459452;
        Thu, 21 Feb 2019 18:19:41 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 932D95D9D3;
        Thu, 21 Feb 2019 18:19:33 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:19:32 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 19/26] userfaultfd: introduce helper vma_find_uffd
Message-ID: <20190221181931.GS2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-20-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-20-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 21 Feb 2019 18:19:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:25AM +0800, Peter Xu wrote:
> We've have multiple (and more coming) places that would like to find a
> userfault enabled VMA from a mm struct that covers a specific memory
> range.  This patch introduce the helper for it, meanwhile apply it to
> the code.
> 
> Suggested-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/userfaultfd.c | 54 +++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 80bcd642911d..fefa81c301b7 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -20,6 +20,34 @@
>  #include <asm/tlbflush.h>
>  #include "internal.h"
>  
> +/*
> + * Find a valid userfault enabled VMA region that covers the whole
> + * address range, or NULL on failure.  Must be called with mmap_sem
> + * held.
> + */
> +static struct vm_area_struct *vma_find_uffd(struct mm_struct *mm,
> +					    unsigned long start,
> +					    unsigned long len)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, start);
> +
> +	if (!vma)
> +		return NULL;
> +
> +	/*
> +	 * Check the vma is registered in uffd, this is required to
> +	 * enforce the VM_MAYWRITE check done at uffd registration
> +	 * time.
> +	 */
> +	if (!vma->vm_userfaultfd_ctx.ctx)
> +		return NULL;
> +
> +	if (start < vma->vm_start || start + len > vma->vm_end)
> +		return NULL;
> +
> +	return vma;
> +}
> +
>  static int mcopy_atomic_pte(struct mm_struct *dst_mm,
>  			    pmd_t *dst_pmd,
>  			    struct vm_area_struct *dst_vma,
> @@ -228,20 +256,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  	 */
>  	if (!dst_vma) {
>  		err = -ENOENT;
> -		dst_vma = find_vma(dst_mm, dst_start);
> +		dst_vma = vma_find_uffd(dst_mm, dst_start, len);
>  		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
>  			goto out_unlock;
> -		/*
> -		 * Check the vma is registered in uffd, this is
> -		 * required to enforce the VM_MAYWRITE check done at
> -		 * uffd registration time.
> -		 */
> -		if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -			goto out_unlock;
> -
> -		if (dst_start < dst_vma->vm_start ||
> -		    dst_start + len > dst_vma->vm_end)
> -			goto out_unlock;
>  
>  		err = -EINVAL;
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
> @@ -488,20 +505,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
>  	 * both valid and fully within a single existing vma.
>  	 */
>  	err = -ENOENT;
> -	dst_vma = find_vma(dst_mm, dst_start);
> +	dst_vma = vma_find_uffd(dst_mm, dst_start, len);
>  	if (!dst_vma)
>  		goto out_unlock;
> -	/*
> -	 * Check the vma is registered in uffd, this is required to
> -	 * enforce the VM_MAYWRITE check done at uffd registration
> -	 * time.
> -	 */
> -	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -		goto out_unlock;
> -
> -	if (dst_start < dst_vma->vm_start ||
> -	    dst_start + len > dst_vma->vm_end)
> -		goto out_unlock;
>  
>  	err = -EINVAL;
>  	/*
> -- 
> 2.17.1
> 
