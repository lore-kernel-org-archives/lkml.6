Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeC3O14 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 10:27:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeC3O1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 10:27:54 -0400
Subject: Re: [RFC PATCH v2 0/4] Eliminate zone->lock contention for
 will-it-scale/page_fault1 and parallel free
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <2606b76f-be64-4cef-b1f7-055732d09251@oracle.com>
 <20180330014217.GA28440@intel.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <baef3e5c-439b-3cd4-d0f4-3b384bc8d2c9@oracle.com>
Date: Fri, 30 Mar 2018 10:27:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330014217.GA28440@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8847 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803300148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/29/2018 09:42 PM, Aaron Lu wrote:
> On Thu, Mar 29, 2018 at 03:19:46PM -0400, Daniel Jordan wrote:
>> On 03/20/2018 04:54 AM, Aaron Lu wrote:
>>> This series is meant to improve zone->lock scalability for order 0 pages.
>>> With will-it-scale/page_fault1 workload, on a 2 sockets Intel Skylake
>>> server with 112 CPUs, CPU spend 80% of its time spinning on zone->lock.
>>> Perf profile shows the most time consuming part under zone->lock is the
>>> cache miss on "struct page", so here I'm trying to avoid those cache
>>> misses.
>>
>> I ran page_fault1 comparing 4.16-rc5 to your recent work, these four patches
>> plus the three others from your github branch zone_lock_rfc_v2. Out of
>> curiosity I also threw in another 4.16-rc5 with the pcp batch size adjusted
>> so high (10922 pages) that we always stay in the pcp lists and out of buddy
>> completely.  I used your patch[*] in this last kernel.
>>
>> This was on a 2-socket, 20-core broadwell server.
>>
>> There were some small regressions a bit outside the noise at low process
>> counts (2-5) but I'm not sure they're repeatable.  Anyway, it does improve
>> the microbenchmark across the board.
> 
> Thanks for the result.
> 
> The limited improvement is expected since lock contention only shifts,
> not entirely gone. So what is interesting to see is how it performs with
> v4.16-rc5 + my_zone_lock_patchset + your_lru_lock_patchset

Yep, that's 'coming soon.'
