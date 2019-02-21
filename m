Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D119C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142F82084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfBUPaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:30:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBUPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:30:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C204D3DD99;
        Thu, 21 Feb 2019 15:30:07 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63BAE6015C;
        Thu, 21 Feb 2019 15:29:58 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:29:56 -0500
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
Subject: Re: [PATCH v2 02/26] mm: userfault: return VM_FAULT_RETRY on signals
Message-ID: <20190221152956.GB2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-3-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 21 Feb 2019 15:30:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:08AM +0800, Peter Xu wrote:
> The idea comes from the upstream discussion between Linus and Andrea:
> 
>   https://lkml.org/lkml/2017/10/30/560
> 
> A summary to the issue: there was a special path in handle_userfault()
> in the past that we'll return a VM_FAULT_NOPAGE when we detected
> non-fatal signals when waiting for userfault handling.  We did that by
> reacquiring the mmap_sem before returning.  However that brings a risk
> in that the vmas might have changed when we retake the mmap_sem and
> even we could be holding an invalid vma structure.
> 
> This patch removes the special path and we'll return a VM_FAULT_RETRY
> with the common path even if we have got such signals.  Then for all
> the architectures that is passing in VM_FAULT_ALLOW_RETRY into
> handle_mm_fault(), we check not only for SIGKILL but for all the rest
> of userspace pending signals right after we returned from
> handle_mm_fault().  This can allow the userspace to handle nonfatal
> signals faster than before.
> 
> This patch is a preparation work for the next patch to finally remove
> the special code path mentioned above in handle_userfault().
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

See maybe minor improvement

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

[...]

> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 58f69fa07df9..c41c021bbe40 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -314,12 +314,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  
>  	fault = __do_page_fault(mm, addr, fsr, flags, tsk);
>  
> -	/* If we need to retry but a fatal signal is pending, handle the
> +	/* If we need to retry but a signal is pending, handle the
>  	 * signal first. We do not need to release the mmap_sem because
>  	 * it would already be released in __lock_page_or_retry in
>  	 * mm/filemap.c. */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> -		if (!user_mode(regs))
> +	if (unlikely(fault & VM_FAULT_RETRY && signal_pending(current))) {

I rather see (fault & VM_FAULT_RETRY) ie with the parenthesis as it
avoids the need to remember operator precedence rules :)

[...]

> diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
> index 68d5f2a27f38..9f6e477b9e30 100644
> --- a/arch/nds32/mm/fault.c
> +++ b/arch/nds32/mm/fault.c
> @@ -206,12 +206,12 @@ void do_page_fault(unsigned long entry, unsigned long addr,
>  	fault = handle_mm_fault(vma, addr, flags);
>  
>  	/*
> -	 * If we need to retry but a fatal signal is pending, handle the
> +	 * If we need to retry but a signal is pending, handle the
>  	 * signal first. We do not need to release the mmap_sem because it
>  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
>  	 */
> -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> -		if (!user_mode(regs))
> +	if (fault & VM_FAULT_RETRY && signal_pending(current)) {

Same as above parenthesis maybe.

[...]

> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index 0e8b6158f224..09baf37b65b9 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -76,8 +76,11 @@ int handle_page_fault(unsigned long address, unsigned long ip,
>  
>  		fault = handle_mm_fault(vma, address, flags);
>  
> -		if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> +		if (fault & VM_FAULT_RETRY && signal_pending(current)) {

Same as above parenthesis maybe.

[...]
