Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB153C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F412083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfBUQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:07:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbfBUQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:07:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B3D537F46;
        Thu, 21 Feb 2019 16:07:09 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBE9A1001DD8;
        Thu, 21 Feb 2019 16:06:57 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:06:55 -0500
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
Subject: Re: [PATCH v2 05/26] mm: gup: allow VM_FAULT_RETRY for multiple times
Message-ID: <20190221160612.GE2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-6-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Feb 2019 16:07:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:11AM +0800, Peter Xu wrote:
> This is the gup counterpart of the change that allows the VM_FAULT_RETRY
> to happen for more than once.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/gup.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index fa75a03204c1..ba387aec0d80 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -528,7 +528,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
>  	if (*flags & FOLL_NOWAIT)
>  		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
>  	if (*flags & FOLL_TRIED) {
> -		VM_WARN_ON_ONCE(fault_flags & FAULT_FLAG_ALLOW_RETRY);
> +		/*
> +		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
> +		 * can co-exist
> +		 */
>  		fault_flags |= FAULT_FLAG_TRIED;
>  	}
>  
> @@ -943,17 +946,23 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
>  		pages += ret;
>  		start += ret << PAGE_SHIFT;
> +		lock_dropped = true;
>  
> +retry:
>  		/*
>  		 * Repeat on the address that fired VM_FAULT_RETRY
> -		 * without FAULT_FLAG_ALLOW_RETRY but with
> +		 * with both FAULT_FLAG_ALLOW_RETRY and
>  		 * FAULT_FLAG_TRIED.
>  		 */
>  		*locked = 1;
> -		lock_dropped = true;
>  		down_read(&mm->mmap_sem);
>  		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> -				       pages, NULL, NULL);
> +				       pages, NULL, locked);
> +		if (!*locked) {
> +			/* Continue to retry until we succeeded */
> +			BUG_ON(ret != 0);
> +			goto retry;
> +		}
>  		if (ret != 1) {
>  			BUG_ON(ret > 1);
>  			if (!pages_done)
> -- 
> 2.17.1
> 
