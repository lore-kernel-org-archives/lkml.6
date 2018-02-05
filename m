Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbeBEWRZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:17:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:42658 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbeBEWRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:17:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,466,1511856000";
   d="scan'208";a="171899784"
Subject: Re: [RFC PATCH 1/2] __free_one_page: skip merge for order-0 page
 unless compaction is in progress
To: Aaron Lu <aaron.lu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180124023050.20097-1-aaron.lu@intel.com>
 <20180205053013.GB16980@intel.com> <20180205053139.GC16980@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <57fd532f-8fb7-33c4-914a-fb816db47ea9@intel.com>
Date: Mon, 5 Feb 2018 14:17:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205053139.GC16980@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2018 09:31 PM, Aaron Lu wrote:
> Running will-it-scale/page_fault1 process mode workload on a 2 sockets
> Intel Skylake server showed severe lock contention of zone->lock, as
> high as about 80%(43% on allocation path and 38% on free path) CPU
> cycles are burnt spinning. With perf, the most time consuming part inside
> that lock on free path is cache missing on page structures, mostly on
> the to-be-freed page's buddy due to merging.
> 
> One way to avoid this overhead is not do any merging at all for order-0
> pages and leave the need for high order pages to compaction.

I think the RFC here is: we *know* this hurts high-order allocations and
Aaron demonstrated that it does make the latency worse.  But,
unexpectedly, it didn't totally crater them.

So, is the harm to large allocations worth the performance benefit
afforded to smaller ones by this patch?  How would we make a decision on
something like that?

If nothing else, this would make a nice companion topic to Daniel
Jordan's "lru_lock scalability" proposal for LSF/MM.
