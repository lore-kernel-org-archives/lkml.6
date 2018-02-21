Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753477AbeBUJz3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:55:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:56375 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbeBUJz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:55:28 -0500
Date: Wed, 21 Feb 2018 10:55:26 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Dan Rue <dan.rue@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] mm, hugetlb: further simplify hugetlb allocation API
Message-ID: <20180221095526.GB2231@dhcp22.suse.cz>
References: <20180103093213.26329-1-mhocko@kernel.org>
 <20180103093213.26329-6-mhocko@kernel.org>
 <20180221042457.uolmhlmv5je5dqx7@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221042457.uolmhlmv5je5dqx7@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-02-18 22:24:57, Dan Rue wrote:
> On Wed, Jan 03, 2018 at 10:32:12AM +0100, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Hugetlb allocator has several layer of allocation functions depending
> > and the purpose of the allocation. There are two allocators depending
> > on whether the page can be allocated from the page allocator or we need
> > a contiguous allocator. This is currently opencoded in alloc_fresh_huge_page
> > which is the only path that might allocate giga pages which require the
> > later allocator. Create alloc_fresh_huge_page which hides this
> > implementation detail and use it in all callers which hardcoded the
> > buddy allocator path (__hugetlb_alloc_buddy_huge_page). This shouldn't
> > introduce any funtional change because both migration and surplus
> > allocators exlude giga pages explicitly.
> > 
> > While we are at it let's do some renaming. The current scheme is not
> > consistent and overly painfull to read and understand. Get rid of prefix
> > underscores from most functions. There is no real reason to make names
> > longer.
> > * alloc_fresh_huge_page is the new layer to abstract underlying
> >   allocator
> > * __hugetlb_alloc_buddy_huge_page becomes shorter and neater
> >   alloc_buddy_huge_page.
> > * Former alloc_fresh_huge_page becomes alloc_pool_huge_page because we put
> >   the new page directly to the pool
> > * alloc_surplus_huge_page can drop the opencoded prep_new_huge_page code
> >   as it uses alloc_fresh_huge_page now
> > * others lose their excessive prefix underscores to make names shorter
> 
> Hi Michal -
> 
> We (Linaro) run the libhugetlbfs test suite continuously against
> mainline and recently (Feb 1), the 'counters' test started failing on
> with the following error:
> 
>     root@localhost:~# mount_point="/mnt/hugetlb/"
>     root@localhost:~# echo 200 > /proc/sys/vm/nr_hugepages
>     root@localhost:~# mkdir -p "${mount_point}"
>     root@localhost:~# mount -t hugetlbfs hugetlbfs "${mount_point}"
>     root@localhost:~# export LD_LIBRARY_PATH=/root/libhugetlbfs/libhugetlbfs-2.20/obj64
>     root@localhost:~# /root/libhugetlbfs/libhugetlbfs-2.20/tests/obj64/counters
>     Starting testcase "/root/libhugetlbfs/libhugetlbfs-2.20/tests/obj64/counters", pid 3319
>     Base pool size: 0
>     Clean...
>     FAIL    Line 326: Bad HugePages_Total: expected 0, actual 1
> 
> Line 326 refers to the test source @
> https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/counters.c#L326

Thanks for the report. I am fighting to get hugetlb tests working. My
previous deployment is gone and the new git snapshot fails to build. I
will look into it further but ...

> I bisected the failure to this commit. The problem is seen on multiple
> architectures (tested x86-64 and arm64).

The patch shouldn't have introduced any functional changes IIRC. But let
me have a look
-- 
Michal Hocko
SUSE Labs
