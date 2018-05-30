Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeE3Uvs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:51:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37849 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeE3Uvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:51:44 -0400
X-Google-Smtp-Source: ADUXVKLavMM+TdN+R8JLmUmW5NZaloPMWO/wLsg/HDGHRtevWW2f324v13c67gC7BURfhui6KR/qzA==
Date: Wed, 30 May 2018 13:51:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Mike Kravetz <mike.kravetz@oracle.com>
cc: Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
In-Reply-To: <7cf79250-a58a-b8a3-50ca-5e472762b510@oracle.com>
Message-ID: <alpine.DEB.2.21.1805301342430.149715@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com> <7cf79250-a58a-b8a3-50ca-5e472762b510@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Tue, 29 May 2018, Mike Kravetz wrote:

> > When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
> > ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
> > page fault handler.
> > 
> > Instead, return the proper error code, ERR_PTR(-ENOMEM), so VM_FAULT_OOM
> > is handled correctly.  This is consistent with failing mem cgroup charges
> > in the non-hugetlb fault path.
> 
> Apologies for the late reply.
> 
> I am not %100 sure we want to make this change.  When hugetlb cgroup support
> was added by Aneesh, the intention was for the application to get SIGBUS.
> 
> commit 2bc64a204697
> https://lwn.net/Articles/499255/
> 
> Since the code has always caused SIGBUS when exceeding cgroup limit, there
> may be applications depending on this behavior.  I would be especially
> concerned with HPC applications which were the original purpose for adding
> the feature.
> 
> Perhaps, the original code should have returned ENOMEM to be consistent as
> in your patch.  That does seem to be the more correct behavior.  But, do we
> want to change behavior now (admittedly undocumented) and potentially break
> some application?
> 
> I echo Michal's question about the reason for the change.  If there is a
> real problem or issue to solve, that makes more of a case for making the
> change.  If it is simply code/behavior cleanup for consistency then I would
> suggest not making the change, but rather documenting this as another
> hugetlbfs "special behavior".
> 

Yes, I mentioned the backwards compatibility issue and I'm not sure there 
is a likely way around it.  But it's rather unfortunate that applications 
can become constrained in such a way that SIGBUS may be unavoidable if 
alloc_buddy_huge_page_with_mpol() cannot allocate from surplus and/or the 
hugetlb_cgroup limit is reached.  Not only are both racy, but applications 
prior to hugetlb_cgroup was introduced may have avoided SIGBUS by checking 
global hstate and are now limited to hugetlb_cgroup constraints 
unknowingly.  It's also not possible to avoid the SIGBUS by trying to 
terminate a lower priority process that has hugetlb reservations.

I'm not sure there is a path forward that can make this more 
deterministic.  We have customers who have reported receiving SIGBUS deep 
in their allocation stack using MAP_HUGETLB and were checking global 
hstate but were unaware of any hugetlb_cgroup restriction.

Andrew, please drop the patch.  I'd like to know if anybody has any ideas 
on how this can be more userspace friendly, however.
