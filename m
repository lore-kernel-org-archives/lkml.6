Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032686AbeEXK4M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:56:12 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:51940 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030314AbeEXK4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:56:07 -0400
Date: Thu, 24 May 2018 06:58:07 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>, Shaohua Li <shli@fb.com>,
        Rik van Riel <riel@surriel.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH REPOST] mm: memcg: allow lowering memory.swap.max below
 the current usage
Message-ID: <20180524105807.GA1362@cmpxchg.org>
References: <20180523185041.GR1718769@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523185041.GR1718769@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:50:41AM -0700, Tejun Heo wrote:
> Currently an attempt to set swap.max into a value lower than the
> actual swap usage fails, which causes configuration problems as
> there's no way of lowering the configuration below the current usage
> short of turning off swap entirely.  This makes swap.max difficult to
> use and allows delegatees to lock the delegator out of reducing swap
> allocation.
> 
> This patch updates swap_max_write() so that the limit can be lowered
> below the current usage.  It doesn't implement active reclaiming of
> swap entries for the following reasons.
> 
> * mem_cgroup_swap_full() already tells the swap machinary to
>   aggressively reclaim swap entries if the usage is above 50% of
>   limit, so simply lowering the limit automatically triggers gradual
>   reclaim.
> 
> * Forcing back swapped out pages is likely to heavily impact the
>   workload and mess up the working set.  Given that swap usually is a
>   lot less valuable and less scarce, letting the existing usage
>   dissipate over time through the above gradual reclaim and as they're
>   falted back in is likely the better behavior.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Roman Gushchin <guro@fb.com>
> Acked-by: Rik van Riel <riel@surriel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
