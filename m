Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15027C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1820836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfBUSGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:06:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUSGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:06:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8717E59446;
        Thu, 21 Feb 2019 18:06:39 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8717A5C290;
        Thu, 21 Feb 2019 18:06:33 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:06:31 -0500
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
Subject: Re: [PATCH v2 15/26] userfaultfd: wp: drop _PAGE_UFFD_WP properly
 when fork
Message-ID: <20190221180631.GO2813@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212025632.28946-16-peterx@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 21 Feb 2019 18:06:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:21AM +0800, Peter Xu wrote:
> UFFD_EVENT_FORK support for uffd-wp should be already there, except
> that we should clean the uffd-wp bit if uffd fork event is not
> enabled.  Detect that to avoid _PAGE_UFFD_WP being set even if the VMA
> is not being tracked by VM_UFFD_WP.  Do this for both small PTEs and
> huge PMDs.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This patch must be earlier in the serie, before the patch that introduce
the userfaultfd API so that bisect can not end up on version where this
can happen.

Otherwise the patch itself is:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/huge_memory.c | 8 ++++++++
>  mm/memory.c      | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 817335b443c2..fb2234cb595a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -938,6 +938,14 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	ret = -EAGAIN;
>  	pmd = *src_pmd;
>  
> +	/*
> +	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
> +	 * does not have the VM_UFFD_WP, which means that the uffd
> +	 * fork event is not enabled.
> +	 */
> +	if (!(vma->vm_flags & VM_UFFD_WP))
> +		pmd = pmd_clear_uffd_wp(pmd);
> +
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>  	if (unlikely(is_swap_pmd(pmd))) {
>  		swp_entry_t entry = pmd_to_swp_entry(pmd);
> diff --git a/mm/memory.c b/mm/memory.c
> index b5d67bafae35..c2035539e9fd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -788,6 +788,14 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		pte = pte_mkclean(pte);
>  	pte = pte_mkold(pte);
>  
> +	/*
> +	 * Make sure the _PAGE_UFFD_WP bit is cleared if the new VMA
> +	 * does not have the VM_UFFD_WP, which means that the uffd
> +	 * fork event is not enabled.
> +	 */
> +	if (!(vm_flags & VM_UFFD_WP))
> +		pte = pte_clear_uffd_wp(pte);
> +
>  	page = vm_normal_page(vma, addr, pte);
>  	if (page) {
>  		get_page(page);
> -- 
> 2.17.1
> 
