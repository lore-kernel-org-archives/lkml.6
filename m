Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDKDx1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 23:53:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDKDx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 23:53:26 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
From: Buddy Lumpkin <buddy.lumpkin@oracle.com>
In-Reply-To: <20180403190759.GB6779@bombadil.infradead.org>
Date: Tue, 10 Apr 2018 20:52:55 -0700
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com,
        mgorman@suse.de, akpm@linux-foundation.org
Message-Id: <2E72CC2C-871C-41C1-8238-6BA04C361D4E@oracle.com>
References: <1522661062-39745-1-git-send-email-buddy.lumpkin@oracle.com>
 <1522661062-39745-2-git-send-email-buddy.lumpkin@oracle.com>
 <20180403133115.GA5501@dhcp22.suse.cz>
 <20180403190759.GB6779@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8859 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110036
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3B3rWqt026274


> On Apr 3, 2018, at 12:07 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Tue, Apr 03, 2018 at 03:31:15PM +0200, Michal Hocko wrote:
>> On Mon 02-04-18 09:24:22, Buddy Lumpkin wrote:
>>> The presence of direct reclaims 10 years ago was a fairly reliable
>>> indicator that too much was being asked of a Linux system. Kswapd was
>>> likely wasting time scanning pages that were ineligible for eviction.
>>> Adding RAM or reducing the working set size would usually make the problem
>>> go away. Since then hardware has evolved to bring a new struggle for
>>> kswapd. Storage speeds have increased by orders of magnitude while CPU
>>> clock speeds stayed the same or even slowed down in exchange for more
>>> cores per package. This presents a throughput problem for a single
>>> threaded kswapd that will get worse with each generation of new hardware.
>> 
>> AFAIR we used to scale the number of kswapd workers many years ago. It
>> just turned out to be not all that great. We have a kswapd reclaim
>> window for quite some time and that can allow to tune how much proactive
>> kswapd should be.
>> 
>> Also please note that the direct reclaim is a way to throttle overly
>> aggressive memory consumers. The more we do in the background context
>> the easier for them it will be to allocate faster. So I am not really
>> sure that more background threads will solve the underlying problem. It
>> is just a matter of memory hogs tunning to end in the very same
>> situtation AFAICS. Moreover the more they are going to allocate the more
>> less CPU time will _other_ (non-allocating) task get.
>> 
>>> Test Details
>> 
>> I will have to study this more to comment.
>> 
>> [...]
>>> By increasing the number of kswapd threads, throughput increased by ~50%
>>> while kernel mode CPU utilization decreased or stayed the same, likely due
>>> to a decrease in the number of parallel tasks at any given time doing page
>>> replacement.
>> 
>> Well, isn't that just an effect of more work being done on behalf of
>> other workload that might run along with your tests (and which doesn't
>> really need to allocate a lot of memory)? In other words how
>> does the patch behaves with a non-artificial mixed workloads?
>> 
>> Please note that I am not saying that we absolutely have to stick with the
>> current single-thread-per-node implementation but I would really like to
>> see more background on why we should be allowing heavy memory hogs to
>> allocate faster or how to prevent that. I would be also very interested
>> to see how to scale the number of threads based on how CPUs are utilized
>> by other workloads.
> 
> Yes, very much this.  If you have a single-threaded workload which is
> using the entirety of memory and would like to use even more, then it
> makes sense to use as many CPUs as necessary getting memory out of its
> way.  If you have N CPUs and N-1 threads happily occupying themselves in
> their own reasonably-sized working sets with one monster process trying
> to use as much RAM as possible, then I'd be pretty unimpressed to see
> the N-1 well-behaved threads preempted by kswapd.

A single thread cannot create the demand to keep any number of kswapd tasks
busy, so this memory hog is going to need to have multiple threads if it is going
to do any measurable damage to the amount of work performed by the compute
bound tasks, and once we increase the number of tasks used for the memory
hog, preemption is already happening.

So let’s say we are willing to accept that it is going to take multiple threads to
create enough demand to keep multiple kswapd tasks busy, we just do not want
any additional preemptions strictly due to additional kswapd tasks. You have to
consider, If we managed to create enough demand to keep multiple kswapd tasks
busy, then we are creating enough demand to trigger direct reclaims. A _lot_ of
direct reclaims, and direct reclaims consume A _lot_ of cpu. So if we are running
multiple kswapd threads, they might be preempting your N-1 threads, but if they
were not running, the memory hog tasks would be preempting your N-1 threads.

> 
> My biggest problem with the patch-as-presented is that it's yet one more
> thing for admins to get wrong.  We should spawn more threads automatically
> if system conditions are right to do that.

One thing about this patch-as-presented that an admin could get wrong is by
starting with a setting of 16, deciding that it didn’t help and reducing it back to
one. It allows for 16 threads because I actually saw a benefit with large numbers
of kswapd threads when a substantial amount of the memory pressure was 
created using anonymous memory mappings that do not involve the page cache.
This really is a special case, and the maximum number of threads allowed should
probably be reduced to a more sensible value like 8 or even 6 if there is concern
about admins doing the wrong thing.
