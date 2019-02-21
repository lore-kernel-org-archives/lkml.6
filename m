Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E82BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C2E2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfBUPeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:34:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbfBUPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:34:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EA7680462;
        Thu, 21 Feb 2019 15:34:16 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 569385D706;
        Thu, 21 Feb 2019 15:34:08 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:34:06 -0500
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
Subject: Re: [PATCH v2 03/26] userfaultfd: don't retake mmap_sem to emulate
 NOPAGE
Message-ID: <20190221153406.GC2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-4-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 15:34:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:09AM +0800, Peter Xu wrote:
> The idea comes from the upstream discussion between Linus and Andrea:
> 
> https://lkml.org/lkml/2017/10/30/560
> 
> A summary to the issue: there was a special path in handle_userfault()
> in the past that we'll return a VM_FAULT_NOPAGE when we detected
> non-fatal signals when waiting for userfault handling.  We did that by
> reacquiring the mmap_sem before returning.  However that brings a risk
> in that the vmas might have changed when we retake the mmap_sem and
> even we could be holding an invalid vma structure.
> 
> This patch removes the risk path in handle_userfault() then we will be
> sure that the callers of handle_mm_fault() will know that the VMAs
> might have changed.  Meanwhile with previous patch we don't lose
> responsiveness as well since the core mm code now can handle the
> nonfatal userspace signals quickly even if we return VM_FAULT_RETRY.
> 
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  fs/userfaultfd.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 89800fc7dc9d..b397bc3b954d 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -514,30 +514,6 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	__set_current_state(TASK_RUNNING);
>  
> -	if (return_to_userland) {
> -		if (signal_pending(current) &&
> -		    !fatal_signal_pending(current)) {
> -			/*
> -			 * If we got a SIGSTOP or SIGCONT and this is
> -			 * a normal userland page fault, just let
> -			 * userland return so the signal will be
> -			 * handled and gdb debugging works.  The page
> -			 * fault code immediately after we return from
> -			 * this function is going to release the
> -			 * mmap_sem and it's not depending on it
> -			 * (unlike gup would if we were not to return
> -			 * VM_FAULT_RETRY).
> -			 *
> -			 * If a fatal signal is pending we still take
> -			 * the streamlined VM_FAULT_RETRY failure path
> -			 * and there's no need to retake the mmap_sem
> -			 * in such case.
> -			 */
> -			down_read(&mm->mmap_sem);
> -			ret = VM_FAULT_NOPAGE;
> -		}
> -	}
> -
>  	/*
>  	 * Here we race with the list_del; list_add in
>  	 * userfaultfd_ctx_read(), however because we don't ever run
> -- 
> 2.17.1
> 
