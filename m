Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeC2TQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:16:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39414 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeC2TQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:16:52 -0400
Subject: Re: [RFC PATCH v2 3/4] mm/rmqueue_bulk: alloc without touching
 individual page structure
To: Aaron Lu <aaron.lu@intel.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <20180320085452.24641-4-aaron.lu@intel.com>
 <12a89171-27b8-af4f-450e-41e5775683c5@suse.cz>
 <20180321150140.GA1838@intel.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle
Message-ID: <1df1e702-98bb-8785-206b-d0a44bcc0ec0@oracle.com>
Date: Thu, 29 Mar 2018 15:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321150140.GA1838@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8847 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 11:01 AM, Aaron Lu wrote:
>> I'm sorry, but I feel the added complexity here is simply too large to
>> justify the change. Especially if the motivation seems to be just the
>> microbenchmark. It would be better if this was motivated by a real
>> workload where zone lock contention was identified as the main issue,
>> and we would see the improvements on the workload. We could also e.g.
>> find out that the problem can be avoided at a different level.
> 
> One thing I'm aware of is there is some app that consumes a ton of
> memory and when it misbehaves or crashes, it takes some 10-20 minutes to
> have it exit(munmap() takes a long time to free all those consumed
> memory).
> 
> THP could help a lot, but it's beyond my understanding why they didn't
> use it.

One of our apps has the same issue with taking a long time to exit.  The 
time is in the kernel's munmap/exit path.

Also, Vlastimil, to your point about real workloads, I've seen 
zone->lock and lru_lock heavily contended in a decision support 
benchmark.  Setting the pcp list sizes artificially high with 
percpu_pagelist_fraction didn't make it go any faster, but given that 
Aaron and I have seen the contention shift to lru_lock in this case, I'm 
curious what will happen to the benchmark when both locks are no longer 
contended.  Will report back once this experiment is done.
