Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB090C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C920657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBVPNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:13:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfBVPNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:13:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 427E43097088;
        Fri, 22 Feb 2019 15:13:30 +0000 (UTC)
Received: from redhat.com (ovpn-126-14.rdu2.redhat.com [10.10.126.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F20E4600CD;
        Fri, 22 Feb 2019 15:13:23 +0000 (UTC)
Date:   Fri, 22 Feb 2019 10:13:22 -0500
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
Message-ID: <20190222151321.GB7783@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-6-peterx@redhat.com>
 <20190221160612.GE2813@redhat.com>
 <20190222044105.GE8904@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222044105.GE8904@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 22 Feb 2019 15:13:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 12:41:05PM +0800, Peter Xu wrote:
> On Thu, Feb 21, 2019 at 11:06:55AM -0500, Jerome Glisse wrote:
> > On Tue, Feb 12, 2019 at 10:56:11AM +0800, Peter Xu wrote:
> > > This is the gup counterpart of the change that allows the VM_FAULT_RETRY
> > > to happen for more than once.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Thanks for the r-b, Jerome!
> 
> Though I plan to change this patch a bit because I just noticed that I
> didn't touch up the hugetlbfs path for GUP.  Though it was not needed
> for now because hugetlbfs is not yet supported but I think maybe I'd
> better do that as well in this same patch to make follow up works
> easier on hugetlb, and the patch will be more self contained.  The new
> version will simply squash below change into current patch:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e3c738bde72e..a8eace2d5296 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4257,8 +4257,10 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>                                 fault_flags |= FAULT_FLAG_ALLOW_RETRY |
>                                         FAULT_FLAG_RETRY_NOWAIT;
>                         if (flags & FOLL_TRIED) {
> -                               VM_WARN_ON_ONCE(fault_flags &
> -                                               FAULT_FLAG_ALLOW_RETRY);
> +                               /*
> +                                * Note: FAULT_FLAG_ALLOW_RETRY and
> +                                * FAULT_FLAG_TRIED can co-exist
> +                                */
>                                 fault_flags |= FAULT_FLAG_TRIED;
>                         }
>                         ret = hugetlb_fault(mm, vma, vaddr, fault_flags);
> 
> I'd say this change is straightforward (it's the same as the
> faultin_page below but just for hugetlbfs).  Please let me know if you
> still want to offer the r-b with above change squashed (I'll be more
> than glad to take it!), or I'll just wait for your review comment when
> I post the next version.

Looks good i should have thought of hugetlbfs. You can keep my r-b.

Cheers,
Jérôme
