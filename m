Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC1921905
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550059414;
	bh=YBU7UOtVu0Gyl7Wfp3xjCgc5QHE+y072cUNDnHmYmA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UK5E+hlstTAKUcLVlRsrQze3f+UTJmxs93Fv5EWThudsLRqYe5xlAxY5e5T2XJaoh
	 sHlvjDsDwK5qUtZ8+x2sdIGl6Wd1ekKhHv6Xp+/dpOJ3Lf2mUM1Pio1YZ9mkC1OTuT
	 KkIishDvZ/xtfEt/MMrYCljs/LEb3u7oE8k1lmiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfBMMDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:03:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:53372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728015AbfBMMDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:03:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D23A0ACAE;
        Wed, 13 Feb 2019 12:03:31 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:03:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190213120330.GD4525@dhcp22.suse.cz>
References: <20190213112900.33963-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213112900.33963-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-02-19 20:29:00, Minchan Kim wrote:
> [1] was backported to v4.9 stable tree but it introduces pgtable
> memory leak because with fault retrial, preallocated pagetable
> could be leaked in second iteration.
> To fix the problem, this patch backport [2].
> 
> [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> [2] b0b9b3df27d10, mm: stop leaking PageTables
> 
> Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: <stable@vger.kernel.org> [4.9]
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Thanks for catching this dependency. Do I assume it correctly that this
is stable-4.9 only?

> ---
>  mm/memory.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 35d8217bb0467..47248dc0b9e1a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3329,15 +3329,24 @@ static int do_fault(struct fault_env *fe)
>  {
>  	struct vm_area_struct *vma = fe->vma;
>  	pgoff_t pgoff = linear_page_index(vma, fe->address);
> +	int ret;
>  
>  	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
>  	if (!vma->vm_ops->fault)
> -		return VM_FAULT_SIGBUS;
> -	if (!(fe->flags & FAULT_FLAG_WRITE))
> -		return do_read_fault(fe, pgoff);
> -	if (!(vma->vm_flags & VM_SHARED))
> -		return do_cow_fault(fe, pgoff);
> -	return do_shared_fault(fe, pgoff);
> +		ret = VM_FAULT_SIGBUS;
> +	else if (!(fe->flags & FAULT_FLAG_WRITE))
> +		ret = do_read_fault(fe, pgoff);
> +	else if (!(vma->vm_flags & VM_SHARED))
> +		ret = do_cow_fault(fe, pgoff);
> +	else
> +		ret = do_shared_fault(fe, pgoff);
> +
> +	/* preallocated pagetable is unused: free it */
> +	if (fe->prealloc_pte) {
> +		pte_free(vma->vm_mm, fe->prealloc_pte);
> +		fe->prealloc_pte = 0;
> +	}
> +	return ret;
>  }
>  
>  static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 

-- 
Michal Hocko
SUSE Labs
