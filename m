Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426699AbeCBSJt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:09:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423570AbeCBSJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:09:48 -0500
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
To: Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301140044.GK15057@dhcp22.suse.cz>
 <cb158b3d-c992-6679-24df-b37d2bb170e0@suse.cz>
 <2433e857-fea7-9af4-d124-538ad17de454@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <787e53b9-20d3-a2df-44fc-ea8c31a6ced3@suse.cz>
Date: Fri, 2 Mar 2018 19:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2433e857-fea7-9af4-d124-538ad17de454@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 07:00 PM, Dave Hansen wrote:
> On 03/02/2018 09:55 AM, Vlastimil Babka wrote:
>> It's even stranger to me. Struct page is 64 bytes these days, exactly a
>> a cache line. Unless that changed, Intel CPUs prefetched a "buddy" cache
>> line (that forms an aligned 128 bytes block with the one we touch).
> 
> I believe that was a behavior that was specific to the Pentium 4
> "Netburst" era.  I don't think the 128-byte line behavior exists on
> modern Intel cpus.

I remember it on Core 2 something (Nehalem IIRC). And this page suggests
up to Broadwell, and it can be disabled. And it's an L2 prefetcher indeed.
https://software.intel.com/en-us/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors
