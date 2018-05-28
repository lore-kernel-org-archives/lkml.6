Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932805AbeE1P7F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:43546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969241AbeE1Px7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:53:59 -0400
Date: Mon, 28 May 2018 11:03:29 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
Message-ID: <20180528090329.GF1517@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
 <20180525134459.5c6f8e06f55307f72b95a901@linux-foundation.org>
 <alpine.DEB.2.21.1805251356570.7798@chino.kir.corp.google.com>
 <20180525140940.976ca667f3c6ff83238c3620@linux-foundation.org>
 <alpine.DEB.2.21.1805251505110.50062@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805251505110.50062@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-05-18 15:18:11, David Rientjes wrote:
[...]
> Let's see what Mike and Aneesh say, because they may object to using 
> VM_FAULT_OOM because there's no way to guarantee that we'll come under the 
> limit of hugetlb_cgroup as a result of the oom.  My assumption is that we 
> use VM_FAULT_SIGBUS since oom killing will not guarantee that the 
> allocation can succeed.

Yes. And the lack of hugetlb awareness in the oom killer is another
reason. There is absolutely no reason to kill a task when somebody
misconfigured the hugetlb pool.

> But now a process can get a SIGBUS if its hugetlb 
> pages are not allocatable or its under a limit imposed by hugetlb_cgroup 
> that it's not aware of.  Faulting hugetlb pages is certainly risky 
> business these days...

It's always been and I am afraid it will always be unless somebody
simply reimplements the current code to be NUMA aware for example (it is
just too easy to drain a per NODE reserves...).

> Perhaps the optimal solution for reaching hugetlb_cgroup limits is to 
> induce an oom kill from within the hugetlb_cgroup itself?  Otherwise the 
> unlucky process to fault their hugetlb pages last gets SIGBUS.

Hmm, so you expect that the killed task would simply return pages to the
pool? Wouldn't that require to have a hugetlb cgroup OOM killer that
would only care about hugetlb reservations of tasks? Is that worth all
the effort and the additional code?
-- 
Michal Hocko
SUSE Labs
