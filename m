Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D6025C2C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D6025C2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965377AbeGBKR3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:17:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37320 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965036AbeGBKR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:17:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 807AAACCE;
        Mon,  2 Jul 2018 10:17:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CE351E3C07; Mon,  2 Jul 2018 12:17:25 +0200 (CEST)
Date:   Mon, 2 Jul 2018 12:17:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 1/6] mm: get_user_pages: consolidate error handling
Message-ID: <20180702101725.esnjyo4zp3726i3n@quack2.suse.cz>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702005654.20369-2-jhubbard@nvidia.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-07-18 17:56:49, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> An upcoming patch requires a way to operate on each page that
> any of the get_user_pages_*() variants returns.
> 
> In preparation for that, consolidate the error handling for
> __get_user_pages(). This provides a single location (the "out:" label)
> for operating on the collected set of pages that are about to be returned.
> 
> As long every use of the "ret" variable is being edited, rename
> "ret" --> "err", so that its name matches its true role.
> This also gets rid of two shadowed variable declarations, as a
> tiny beneficial a side effect.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

This looks nice! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/gup.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index b70d7ba7cc13..73f0b3316fa7 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -660,6 +660,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		struct vm_area_struct **vmas, int *nonblocking)
>  {
>  	long i = 0;
> +	int err = 0;
>  	unsigned int page_mask;
>  	struct vm_area_struct *vma = NULL;
>  
> @@ -685,18 +686,19 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		if (!vma || start >= vma->vm_end) {
>  			vma = find_extend_vma(mm, start);
>  			if (!vma && in_gate_area(mm, start)) {
> -				int ret;
> -				ret = get_gate_page(mm, start & PAGE_MASK,
> +				err = get_gate_page(mm, start & PAGE_MASK,
>  						gup_flags, &vma,
>  						pages ? &pages[i] : NULL);
> -				if (ret)
> -					return i ? : ret;
> +				if (err)
> +					goto out;
>  				page_mask = 0;
>  				goto next_page;
>  			}
>  
> -			if (!vma || check_vma_flags(vma, gup_flags))
> -				return i ? : -EFAULT;
> +			if (!vma || check_vma_flags(vma, gup_flags)) {
> +				err = -EFAULT;
> +				goto out;
> +			}
>  			if (is_vm_hugetlb_page(vma)) {
>  				i = follow_hugetlb_page(mm, vma, pages, vmas,
>  						&start, &nr_pages, i,
> @@ -709,23 +711,25 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		 * If we have a pending SIGKILL, don't keep faulting pages and
>  		 * potentially allocating memory.
>  		 */
> -		if (unlikely(fatal_signal_pending(current)))
> -			return i ? i : -ERESTARTSYS;
> +		if (unlikely(fatal_signal_pending(current))) {
> +			err = -ERESTARTSYS;
> +			goto out;
> +		}
>  		cond_resched();
>  		page = follow_page_mask(vma, start, foll_flags, &page_mask);
>  		if (!page) {
> -			int ret;
> -			ret = faultin_page(tsk, vma, start, &foll_flags,
> +			err = faultin_page(tsk, vma, start, &foll_flags,
>  					nonblocking);
> -			switch (ret) {
> +			switch (err) {
>  			case 0:
>  				goto retry;
>  			case -EFAULT:
>  			case -ENOMEM:
>  			case -EHWPOISON:
> -				return i ? i : ret;
> +				goto out;
>  			case -EBUSY:
> -				return i;
> +				err = 0;
> +				goto out;
>  			case -ENOENT:
>  				goto next_page;
>  			}
> @@ -737,7 +741,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  			 */
>  			goto next_page;
>  		} else if (IS_ERR(page)) {
> -			return i ? i : PTR_ERR(page);
> +			err = PTR_ERR(page);
> +			goto out;
>  		}
>  		if (pages) {
>  			pages[i] = page;
> @@ -757,7 +762,9 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		start += page_increm * PAGE_SIZE;
>  		nr_pages -= page_increm;
>  	} while (nr_pages);
> -	return i;
> +
> +out:
> +	return i ? i : err;
>  }
>  
>  static bool vma_permits_fault(struct vm_area_struct *vma,
> -- 
> 2.18.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
