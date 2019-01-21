Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF173C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EA32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfAUQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:25:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfAUQZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:25:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F4617F3F7;
        Mon, 21 Jan 2019 16:25:05 +0000 (UTC)
Received: from redhat.com (ovpn-125-147.rdu2.redhat.com [10.10.125.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7F4B17F60;
        Mon, 21 Jan 2019 16:24:57 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:24:55 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 04/24] mm: gup: allow VM_FAULT_RETRY for multiple
 times
Message-ID: <20190121162455.GC3711@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121075722.7945-5-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 21 Jan 2019 16:25:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:57:02PM +0800, Peter Xu wrote:
> This is the gup counterpart of the change that allows the VM_FAULT_RETRY
> to happen for more than once.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

So it would be nice to add a comment in the code and in the commit message
about possible fault starvation (mostly due to previous patch changes) as
if some one experience that and try to bisect it might overlook the commit.

Otherwise:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/gup.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7b1f452cc2ef..22f1d419a849 100644
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
