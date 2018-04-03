Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeDCO5f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:57:35 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49828 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751241AbeDCO5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:57:33 -0400
Date: Tue, 3 Apr 2018 10:58:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memcg, thp: do not invoke oom killer on thp charges
Message-ID: <20180403145853.GB21411@cmpxchg.org>
References: <20180321205928.22240-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321205928.22240-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:59:28PM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> David has noticed that THP memcg charge can trigger the oom killer
> since 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
> madvised allocations"). We have used an explicit __GFP_NORETRY
> previously which ruled the OOM killer automagically.
> 
> Memcg charge path should be semantically compliant with the allocation
> path and that means that if we do not trigger the OOM killer for costly
> orders which should do the same in the memcg charge path as well.
> Otherwise we are forcing callers to distinguish the two and use
> different gfp masks which is both non-intuitive and bug prone. Not to
> mention the maintenance burden.
> 
> Teach mem_cgroup_oom to bail out on costly order requests to fix the THP
> issue as well as any other costly OOM eligible allocations to be added
> in future.
> 
> Fixes: 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and madvised allocations")
> Reported-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

I also prefer this fix over having separate OOM behaviors (which is
user-visible, and not just about technical ability to satisfy the
allocation) between the allocator and memcg.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
