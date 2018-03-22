Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeCVLVJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:21:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47450 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeCVLVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:21:06 -0400
Subject: Re: [RFC PATCH v2 0/4] Eliminate zone->lock contention for
 will-it-scale/page_fault1 and parallel free
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
References: <20180320085452.24641-1-aaron.lu@intel.com>
 <1dfd4b33-6eff-160e-52fd-994d9bcbffed@oracle.com>
 <20180322013049.GA4056@intel.com>
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Organization: Oracle
Message-ID: <5fa1b7f6-4614-c0d9-9f85-007cdd049a5b@oracle.com>
Date: Thu, 22 Mar 2018 07:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322013049.GA4056@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 09:30 PM, Aaron Lu wrote:
> On Wed, Mar 21, 2018 at 01:44:25PM -0400, Daniel Jordan wrote:
>> On 03/20/2018 04:54 AM, Aaron Lu wrote:
>> ...snip...
>>> reduced zone->lock contention on free path from 35% to 1.1%. Also, it
>>> shows good result on parallel free(*) workload by reducing zone->lock
>>> contention from 90% to almost zero(lru lock increased from almost 0 to
>>> 90% though).
>>
>> Hi Aaron, I'm looking through your series now.  Just wanted to mention that I'm seeing the same interaction between zone->lock and lru_lock in my own testing.  IOW, it's not enough to fix just one or the other: both need attention to get good performance on a big system, at least in this microbenchmark we've both been using.
> 
> Agree.
> 
>>
>> There's anti-scaling at high core counts where overall system page faults per second actually decrease with more CPUs added to the test.  This happens when either zone->lock or lru_lock contention are completely removed, but the anti-scaling goes away when both locks are fixed.
>>
>> Anyway, I'll post some actual data on this stuff soon.
> 
> Looking forward to that, thanks.
> 
> In the meantime, I'll also try your lru_lock optimization work on top of
> this patchset to see if the lock contention shifts back to zone->lock.

The lru_lock series I posted is pretty outdated by now, and I've got a 
totally new approach I plan to post soon, so it might make sense to wait 
for that.
