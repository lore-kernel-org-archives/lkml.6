Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeDDKHd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 06:07:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40946 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDDKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 06:07:32 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
From: Buddy Lumpkin <buddy.lumpkin@oracle.com>
In-Reply-To: <20180403211253.GC30145@bombadil.infradead.org>
Date: Wed, 4 Apr 2018 03:07:01 -0700
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com,
        mgorman@suse.de, akpm@linux-foundation.org
Message-Id: <2D4C5B98-6B19-4430-AFA0-83C9D72DB86C@oracle.com>
References: <1522661062-39745-1-git-send-email-buddy.lumpkin@oracle.com>
 <1522661062-39745-2-git-send-email-buddy.lumpkin@oracle.com>
 <20180403133115.GA5501@dhcp22.suse.cz>
 <20180403190759.GB6779@bombadil.infradead.org>
 <A1EF8129-7F59-49CB-BEEC-E615FB878CE2@oracle.com>
 <20180403211253.GC30145@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804040107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34A7aPw006590


> On Apr 3, 2018, at 2:12 PM, Matthew Wilcox <willy@infradead.org> wrote:
> 
> On Tue, Apr 03, 2018 at 01:49:25PM -0700, Buddy Lumpkin wrote:
>>> Yes, very much this.  If you have a single-threaded workload which is
>>> using the entirety of memory and would like to use even more, then it
>>> makes sense to use as many CPUs as necessary getting memory out of its
>>> way.  If you have N CPUs and N-1 threads happily occupying themselves in
>>> their own reasonably-sized working sets with one monster process trying
>>> to use as much RAM as possible, then I'd be pretty unimpressed to see
>>> the N-1 well-behaved threads preempted by kswapd.
>> 
>> The default value provides one kswapd thread per NUMA node, the same
>> it was without the patch. Also, I would point out that just because you devote
>> more threads to kswapd, doesn’t mean they are busy. If multiple kswapd threads
>> are busy, they are almost certainly doing work that would have resulted in
>> direct reclaims, which are often substantially more expensive than a couple
>> extra context switches due to preemption.
> 
> [...]
> 
>> In my previous response to Michal Hocko, I described
>> how I think we could scale watermarks in response to direct reclaims, and
>> launch more kswapd threads when kswapd peaks at 100% CPU usage.
> 
> I think you're missing my point about the workload ... kswapd isn't
> "nice", so it will compete with the N-1 threads which are chugging along
> at 100% CPU inside their working sets.  In this scenario, we _don't_
> want to kick off kswapd at all; we want the monster thread to clean up
> its own mess.  If we have idle CPUs, then yes, absolutely, lets have
> them clean up for the monster, but otherwise, I want my N-1 threads
> doing their own thing.

For the scenario you describe above. I have my own opinions, but I would rather not
speculate on what happens. Tomorrow I will try to simulate this situation and i’ll
report back on the results. I think this actually makes a case for accepting the patch 
as-is for now.  Please hear me out on this:

You mentioned being concerned that an admin will do the wrong thing with this
tunable. I worked in the System Administrator/System Engineering job families for
many years and even though I transitioned to spending most of my time on
performance and kernel work, I still maintain an active role in System Engineering
related projects, hiring and mentoring.

The kswapd_threads tunable defaults to a value of one, which is the current default
behavior. I think there are plenty of sysctls that are more confusing than this one. 
If you want to make a comparison, I would say that Transparent Hugepages is one
of the best examples of a feature that has confused System Administrators. I am sure
it works a lot better today, but it has a history of really sharp edges, and it has been
shipping enabled by default for a long time in the OS distributions I am familiar with.
I am hopeful that it works better in later kernels as I think we need more features
like it. Specifically, features that bring high performance to naive third party apps
that do not make use of advanced features like hugetlbfs, spoke, direct IO, or clumsy
interfaces like posix_fadvise. But until they are absolutely polished, I wish these kinds
of features would not be turned on by default. This includes kswapd_threads.

More reasons why implementing this tunable makes sense for now:
- A feature like this is a lot easier to reason about after it has been used in the field
   for a while. This includes trying to auto-tune it
- We need an answer for this problem today. Today there are single NVMe drives
   capable of 10GB/s and larger systems than the system I used for testing
- In the scenario you describe above, an admin would have no reason to touch
  this sysctl
- I think I mentioned this before. I honestly thought a lot of tuning would be necessary
  after implementing this but so far that hasn’t been the case. It works pretty well.


> 
> Maybe we should renice kswapd anyway ... thoughts?  We don't seem to have
> had a nice'd kswapd since 2.6.12, but maybe we played with that earlier
> and discovered it was a bad idea?
> 
