Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDEERE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 00:17:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 00:17:03 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
From: Buddy Lumpkin <buddy.lumpkin@oracle.com>
In-Reply-To: <20180403211253.GC30145@bombadil.infradead.org>
Date: Wed, 4 Apr 2018 21:08:15 -0700
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org, riel@surriel.com,
        mgorman@suse.de, akpm@linux-foundation.org
Message-Id: <A3DE5382-B5AA-4E6F-9E78-55CE6132CF71@oracle.com>
References: <1522661062-39745-1-git-send-email-buddy.lumpkin@oracle.com>
 <1522661062-39745-2-git-send-email-buddy.lumpkin@oracle.com>
 <20180403133115.GA5501@dhcp22.suse.cz>
 <20180403190759.GB6779@bombadil.infradead.org>
 <A1EF8129-7F59-49CB-BEEC-E615FB878CE2@oracle.com>
 <20180403211253.GC30145@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8853 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w354HA3C017916


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
> 
> Maybe we should renice kswapd anyway ... thoughts?  We don't seem to have
> had a nice'd kswapd since 2.6.12, but maybe we played with that earlier
> and discovered it was a bad idea?
> 


Trying to distinguish between the monster and a high value task that you want
to run as quickly as possible would be challenging. I like your idea of using
renice. It probably makes sense to continue to run the first thread on each node
at a standard nice value, and run each additional task with a positive nice value.
