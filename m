Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030575AbeEYWSO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 18:18:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44767 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030394AbeEYWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 18:18:13 -0400
X-Google-Smtp-Source: AB8JxZpBg0qRw8DLF5jbDMFoMJelZKAkuC5izQc33jkGRg1kjHWWSPzdmrdp9UFiDejoiOHfiU785Q==
Date: Fri, 25 May 2018 15:18:11 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
In-Reply-To: <20180525140940.976ca667f3c6ff83238c3620@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1805251505110.50062@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com> <20180525134459.5c6f8e06f55307f72b95a901@linux-foundation.org> <alpine.DEB.2.21.1805251356570.7798@chino.kir.corp.google.com>
 <20180525140940.976ca667f3c6ff83238c3620@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018, Andrew Morton wrote:

> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -2006,8 +2006,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> > > >  	 * code of zero indicates a reservation exists (no change).
> > > >  	 */
> > > >  	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
> > > > -	if (map_chg < 0)
> > > > -		return ERR_PTR(-ENOMEM);
> > > > +	if (map_chg < 0) {
> > > > +		ret = -ENOMEM;
> > > > +		goto out;
> > > > +	}
> > > 
> > > This doesn't change the return value.
> > > 
> > 
> > This, and the subsequent comments, are referring to the third paragraph of 
> > the changelog.
> > 
> > The functional part of the change is for the 
> > hugetlb_cgroup_charge_cgroup() return value that is now actually used.
> 
> 
> Ah.  Missed that bit.
> 

If you'd like this separated into two separate patches, one that fixes the 
actual issue with the hugetlb_cgroup_charge_cgroup() return value and the 
other to use a single exit path with ERR_PTR(ret), that might make it 
easier.  I think the latter is why the bug was introduced: it's too easy 
to force -ENOSPC unintentionally.

> Altered changelog:
> 
> : When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
> : ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
> : page fault handler.
> : 
> : This is because the return value from hugetlb_cgroup_charge_cgroup() is
> : overwritten with ERR_PTR(-ENOSPC).
> : 
> : Instead, propagate the error code from hugetlb_cgroup_charge_cgroup()
> : (ERR_PTR(-ENOMEM)), so VM_FAULT_OOM is handled correctly.  This is
> : consistent with failing mem cgroup charges in the non-hugetlb fault path.
> : 
> : At the same time, restructure the return paths of alloc_huge_page() so it
> : is consistent.
> 

LGTM, thanks.

> >
> > > It would be nice if you could add a comment over alloc_huge_page()
> > > explaining the return values (at least).  Why sometimes ENOMEM, other
> > > times ENOSPC?
> > > 
> > 
> > The ENOSPC is used to specifically induce a VM_FAULT_SIGBUS, which 
> > Documentation/vm/hugetlbfs_reserv.txt specifies is how faults are handled 
> > if no hugetlb pages are available.
> 
> That wasn't a code comment ;) Nobody will know to go looking in
> hugetlbfs_reserv.txt - it isn't even referred to from mm/*.c.
> 

Let's see what Mike and Aneesh say, because they may object to using 
VM_FAULT_OOM because there's no way to guarantee that we'll come under the 
limit of hugetlb_cgroup as a result of the oom.  My assumption is that we 
use VM_FAULT_SIGBUS since oom killing will not guarantee that the 
allocation can succeed.  But now a process can get a SIGBUS if its hugetlb 
pages are not allocatable or its under a limit imposed by hugetlb_cgroup 
that it's not aware of.  Faulting hugetlb pages is certainly risky 
business these days...

Perhaps the optimal solution for reaching hugetlb_cgroup limits is to 
induce an oom kill from within the hugetlb_cgroup itself?  Otherwise the 
unlucky process to fault their hugetlb pages last gets SIGBUS.
