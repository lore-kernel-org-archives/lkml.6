Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeC3Bl0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 21:41:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:32235 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeC3BlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 21:41:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="32653901"
Date: Fri, 30 Mar 2018 09:42:17 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH v2 0/4] Eliminate zone->lock contention for
 will-it-scale/page_fault1 and parallel free
Message-ID: <20180330014217.GA28440@intel.com>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <2606b76f-be64-4cef-b1f7-055732d09251@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2606b76f-be64-4cef-b1f7-055732d09251@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 03:19:46PM -0400, Daniel Jordan wrote:
> On 03/20/2018 04:54 AM, Aaron Lu wrote:
> > This series is meant to improve zone->lock scalability for order 0 pages.
> > With will-it-scale/page_fault1 workload, on a 2 sockets Intel Skylake
> > server with 112 CPUs, CPU spend 80% of its time spinning on zone->lock.
> > Perf profile shows the most time consuming part under zone->lock is the
> > cache miss on "struct page", so here I'm trying to avoid those cache
> > misses.
> 
> I ran page_fault1 comparing 4.16-rc5 to your recent work, these four patches
> plus the three others from your github branch zone_lock_rfc_v2. Out of
> curiosity I also threw in another 4.16-rc5 with the pcp batch size adjusted
> so high (10922 pages) that we always stay in the pcp lists and out of buddy
> completely.  I used your patch[*] in this last kernel.
> 
> This was on a 2-socket, 20-core broadwell server.
> 
> There were some small regressions a bit outside the noise at low process
> counts (2-5) but I'm not sure they're repeatable.  Anyway, it does improve
> the microbenchmark across the board.

Thanks for the result.

The limited improvement is expected since lock contention only shifts,
not entirely gone. So what is interesting to see is how it performs with
v4.16-rc5 + my_zone_lock_patchset + your_lru_lock_patchset
