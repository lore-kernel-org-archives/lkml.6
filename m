Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031045AbeCAOAw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:00:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:60648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031003AbeCAOAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:00:50 -0500
Date: Thu, 1 Mar 2018 15:00:44 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
Message-ID: <20180301140044.GK15057@dhcp22.suse.cz>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301062845.26038-4-aaron.lu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-03-18 14:28:45, Aaron Lu wrote:
> When a page is freed back to the global pool, its buddy will be checked
> to see if it's possible to do a merge. This requires accessing buddy's
> page structure and that access could take a long time if it's cache cold.
> 
> This patch adds a prefetch to the to-be-freed page's buddy outside of
> zone->lock in hope of accessing buddy's page structure later under
> zone->lock will be faster. Since we *always* do buddy merging and check
> an order-0 page's buddy to try to merge it when it goes into the main
> allocator, the cacheline will always come in, i.e. the prefetched data
> will never be unused.
> 
> In the meantime, there are two concerns:
> 1 the prefetch could potentially evict existing cachelines, especially
>   for L1D cache since it is not huge;
> 2 there is some additional instruction overhead, namely calculating
>   buddy pfn twice.
> 
> For 1, it's hard to say, this microbenchmark though shows good result but
> the actual benefit of this patch will be workload/CPU dependant;
> For 2, since the calculation is a XOR on two local variables, it's expected
> in many cases that cycles spent will be offset by reduced memory latency
> later. This is especially true for NUMA machines where multiple CPUs are
> contending on zone->lock and the most time consuming part under zone->lock
> is the wait of 'struct page' cacheline of the to-be-freed pages and their
> buddies.
> 
> Test with will-it-scale/page_fault1 full load:
> 
> kernel      Broadwell(2S)  Skylake(2S)   Broadwell(4S)  Skylake(4S)
> v4.16-rc2+  9034215        7971818       13667135       15677465
> patch2/3    9536374 +5.6%  8314710 +4.3% 14070408 +3.0% 16675866 +6.4%
> this patch 10338868 +8.4%  8544477 +2.8% 14839808 +5.5% 17155464 +2.9%
> Note: this patch's performance improvement percent is against patch2/3.

I am really surprised that this has such a big impact.  Is this a win on
other architectures as well?
 
> [changelog stole from Dave Hansen and Mel Gorman's comments]
> https://lkml.org/lkml/2018/1/24/551

Please use http://lkml.kernel.org/r/<msg-id> for references because
lkml.org is quite unstable. It would be
http://lkml.kernel.org/r/148a42d8-8306-2f2f-7f7c-86bc118f8ccd@intel.com
here.
-- 
Michal Hocko
SUSE Labs
