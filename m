Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeCFH4B (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 02:56:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:35524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCFHz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 02:55:59 -0500
Subject: Re: [PATCH v4 3/3] mm/free_pcppages_bulk: prefetch buddy while not
 holding lock
To: Aaron Lu <aaron.lu@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20180301062845.26038-1-aaron.lu@intel.com>
 <20180301062845.26038-4-aaron.lu@intel.com>
 <20180301140044.GK15057@dhcp22.suse.cz>
 <cb158b3d-c992-6679-24df-b37d2bb170e0@suse.cz>
 <20180305114159.GA32573@intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bdec481f-b402-64b6-75b0-350b370f3eac@suse.cz>
Date: Tue, 6 Mar 2018 08:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305114159.GA32573@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 12:41 PM, Aaron Lu wrote:
> On Fri, Mar 02, 2018 at 06:55:25PM +0100, Vlastimil Babka wrote:
>> On 03/01/2018 03:00 PM, Michal Hocko wrote:
>>>
>>> I am really surprised that this has such a big impact.
>>
>> It's even stranger to me. Struct page is 64 bytes these days, exactly a
>> a cache line. Unless that changed, Intel CPUs prefetched a "buddy" cache
>> line (that forms an aligned 128 bytes block with the one we touch).
>> Which is exactly a order-0 buddy struct page! Maybe that implicit
>> prefetching stopped at L2 and explicit goes all the way to L1, can't
> 
> The Intel Architecture Optimization Manual section 7.3.2 says:
> 
> prefetchT0 - fetch data into all cache levels
> Intel Xeon Processors based on Nehalem, Westmere, Sandy Bridge and newer
> microarchitectures: 1st, 2nd and 3rd level cache.
> 
> prefetchT2 - fetch data into 2nd and 3rd level caches (identical to
> prefetchT1)
> Intel Xeon Processors based on Nehalem, Westmere, Sandy Bridge and newer
> microarchitectures: 2nd and 3rd level cache.
> 
> prefetchNTA - fetch data into non-temporal cache close to the processor,
> minimizing cache pollution
> Intel Xeon Processors based on Nehalem, Westmere, Sandy Bridge and newer
> microarchitectures: must fetch into 3rd level cache with fast replacement.
> 
> I tried 'prefetcht0' and 'prefetcht2' instead of the default
> 'prefetchNTA' on a 2 sockets Intel Skylake, the two ended up with about
> the same performance number as prefetchNTA. I had expected prefetchT0 to
> deliver a better score if it was indeed due to L1D since prefetchT2 will
> not place data into L1 while prefetchT0 will, but looks like it is not
> the case here.
> 
> It feels more like the buddy cacheline isn't in any level of the caches
> without prefetch for some reason.

So the adjacent line prefetch might be disabled? Could you check bios or
the MSR mentioned in
https://software.intel.com/en-us/articles/disclosure-of-hw-prefetcher-control-on-some-intel-processors

>> remember. Would that make such a difference? It would be nice to do some
>> perf tests with cache counters to see what is really going on...
> 
> Compare prefetchT2 to no-prefetch, I saw these metrics change:
> 
> no-prefetch          change  prefetchT2       metrics
>             \                          \
> 	   stddev                     stddev
> ------------------------------------------------------------------------
>       0.18            +0.0        0.18        perf-stat.branch-miss-rate%                                       
>  8.268e+09            +3.8%  8.585e+09        perf-stat.branch-misses                               
>  2.333e+10            +4.7%  2.443e+10        perf-stat.cache-misses                                            
>  2.402e+11            +5.0%  2.522e+11        perf-stat.cache-references                                    
>       3.52            -1.1%       3.48        perf-stat.cpi                                                     
>       0.02            -0.0        0.01 ±3%    perf-stat.dTLB-load-miss-rate%                           
>  8.677e+08            -7.3%  8.048e+08 ±3%    perf-stat.dTLB-load-misses                                        
>       1.18            +0.0        1.19        perf-stat.dTLB-store-miss-rate%             
>  2.359e+10            +6.0%  2.502e+10        perf-stat.dTLB-store-misses                                       
>  1.979e+12            +5.0%  2.078e+12        perf-stat.dTLB-stores                     
>  6.126e+09           +10.1%  6.745e+09 ±3%    perf-stat.iTLB-load-misses                                        
>       3464            -8.4%       3172 ±3%    perf-stat.instructions-per-iTLB-miss            
>       0.28            +1.1%       0.29        perf-stat.ipc                                                     
>  2.929e+09            +5.1%  3.077e+09        perf-stat.minor-faults                         
>  9.244e+09            +4.7%  9.681e+09        perf-stat.node-loads                                              
>  2.491e+08            +5.8%  2.634e+08        perf-stat.node-store-misses               
>  6.472e+09            +6.1%  6.869e+09        perf-stat.node-stores                                             
>  2.929e+09            +5.1%  3.077e+09        perf-stat.page-faults                          
>    2182469            -4.2%    2090977        perf-stat.path-length
> 
> Not sure if this is useful though...

Looks like most stats increased in absolute values as the work done
increased and this is a time-limited benchmark? Although number of
instructions (calculated from itlb misses and insns-per-itlb-miss) shows
less than 1% increase, so dunno. And the improvement comes from reduced
dTLB-load-misses? That makes no sense for order-0 buddy struct pages
which always share a page. And the memmap mapping should use huge pages.
BTW what is path-length?
