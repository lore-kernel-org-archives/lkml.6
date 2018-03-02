Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424157AbeCBPeI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:34:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:38783 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423376AbeCBPeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:34:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="205024748"
Subject: Re: [PATCH v4 2/3] mm/free_pcppages_bulk: do not hold lock when
 picking pages to free
To: Aaron Lu <aaron.lu@intel.com>, Michal Hocko <mhocko@kernel.org>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-3-aaron.lu@intel.com>
 <20180301135518.GJ15057@dhcp22.suse.cz> <20180302071533.GA6356@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <aa14d724-525c-7532-2e8e-6c4c6094e03f@intel.com>
Date: Fri, 2 Mar 2018 07:34:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302071533.GA6356@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2018 11:15 PM, Aaron Lu wrote:
> 
>> I am still quite surprised that this would have such a large impact.
> Most likely due to the cachelines for these page structures are warmed
> up outside of zone->lock.

The workload here is a pretty tight microbenchmark and single biggest
bottleneck is cache misses on 'struct page'.  It's not memory bandwidth
bound.  So, anything you can give the CPU keep it fed and not waiting on
cache misses will be a win.

There's never going to be a real-world workload that sees this kind of
increase, but the change in the micro isn't super-surprising because it
so directly targets the bottleneck.
