Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF7ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724E32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="jIKntQWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724E32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeIXV0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:26:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:48316 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbeIXV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537802644; x=1569338644;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZUec5CwWA2knDz1wV/N4Zm2Ok7pKhM/Bg5XvoUem/6o=;
  b=jIKntQWUrsSq6cPQWQST7zcnOx5uGUK0OXysp5WpTb0S35jd4JE29Fii
   s/vMJnzSZ+k4weypRvVWnyfFFgnAu6U0mKbKZLEivA/gPtZ+s4cjrOF+p
   VX7HpjYuubNX/GrFFffM9k5Nh2PUVUnCgGoalenAggAbDyTpUWOkUhAOY
   Q=;
X-IronPort-AV: E=Sophos;i="5.54,298,1534809600"; 
   d="scan'208";a="698706410"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Sep 2018 15:24:02 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-7c6d20a4.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8OFNufe084856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 24 Sep 2018 15:24:00 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8OFNtBm017216;
        Mon, 24 Sep 2018 17:23:55 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <1e3c2ab11320c1c2f320f9e24ac0d31625bd60e6.camel@surriel.com>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <a65adb0a-b62c-ca28-6a00-7684d67ff851@amazon.de>
Date:   Mon, 24 Sep 2018 17:23:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1e3c2ab11320c1c2f320f9e24ac0d31625bd60e6.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 04:40 PM, Rik van Riel wrote:
> On Fri, 2018-09-14 at 18:25 +0200, Jan H. Schönherr wrote:
>> On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
>>> On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
>>>>
>>>> B) Why would I want this?
>>>>    [one quoted use case from the original e-mail]
> 
> What are the other use cases, and what kind of performance
> numbers do you have to show examples of workloads where
> coscheduling provides a performance benefit?

For further use cases (still an incomplete list) let me redirect you to the
unabridged Section B of the original e-mail:
   https://lkml.org/lkml/2018/9/7/1521

If you want me to, I can go into more detail and make the list from that
e-mail more complete.


Note, that many coscheduling use cases are not primarily about performance.

Sure, there are the resource contention use cases, which are barely about
anything else. See, e.g., [1] for a survey with further pointers to the
potential performance gains. Realizing those use cases would require either
a user space component driving this, or another kernel component performing
a function similar to the current auto-grouping with some more complexity
depending on the desired level of sophistication. This extra component is
out of my scope. But I see a coscheduler like this as an enabler for
practical applications of these kind of use cases.

If you use coscheduling as part of a solution that closes a side-channel,
performance is a secondary aspect, and hopefully we don't lose much of it.

Then, there's the large fraction of use cases, where coscheduling is
primarily about design flexibility, because it enables different (old and
new) application designs, which usually cannot be executed in an efficient
manner without coscheduling.  For these use cases performance is important,
but there is also a trade-off against development costs of alternative
solutions to consider. These are also the use cases where we can do
measurements today, i.e., without some yet-to-be-written extra component.
For example, with coscheduling it is possible to use active waiting instead
of passive waiting/spin-blocking on non-dedicated systems, because lock
holder preemption is not an issue anymore. It also allows using
applications that were developed for dedicated scenarios in non-dedicated
settings without loss in performance -- like an (unmodified) operating
system within a VM, or HPC code. Another example is cache optimization of
parallel algorithms, where you don't have to resort to cache-oblivious
algorithms for efficiency, but where you can stay with manually tuned or
auto-tuned algorithms, even on non-dedicated systems. (You're even able to
do the tuning itself on a system that has other load.)


Now, you asked about performance numbers, that *I* have.

If a workload has issues with lock-holder preemption, I've seen up to 5x to
20x improvement with coscheduling. (This includes parallel programs [2] and
VMs with unmodified guests without PLE [3].) That is of course highly
dependent on the workload. I currently don't have any numbers comparing
coscheduling to other solutions used to reduce/avoid lock holder
preemption, that don't mix in any other aspect like resource contention.
These would have to be micro-benchmarked.

If you're happy to compare across some more moving variables, then more or
less blind coscheduling of parallel applications with some automatic
workload-driven (but application-agnostic) width adjustment of coscheduled
sets yielded an overall performance benefit between roughly 10% to 20%
compared to approaches with passive waiting [2]. It was roughly on par with
pure space-partitioning approaches (slight minus on performance, slight
plus on flexibility/fairness).

I never went much into the resource contention use cases myself. Though, I
did use coscheduling to extend the concept of "nice" to sockets by putting
all niced programs into a coscheduled task group with appropriately reduced
shares.  This way, niced programs don't just get any and all idle CPU
capacity -- taking away parts of the energy budget of more important tasks
all the time -- which leads to important tasks running at turbo frequencies
more often. Depending on the parallelism of niced workload and the
parallelism of normal workload, this translates to a performance
improvement of the normal workload that corresponds roughly to
the increase in frequency (for CPU-bound tasks) [4]. Depending on the
processor, that can be anything from just a few percent to about a factor
of 2.

Regards
Jan



References:

[1] S. Zhuravlev, J. C. Saez, S. Blagodurov, A. Fedorova, and M. Prieto,
    “Survey of scheduling techniques for addressing shared resources in
    multicore processors,” ACM Computing Surveys, vol. 45, no. 1, pp.
    4:1–4:28, Dec. 2012.

[2] J. H. Schönherr, B. Juurlink, and J. Richling, “TACO: A scheduling
    scheme for parallel applications on multicore architectures,”
    Scientific Programming, vol. 22, no. 3, pp. 223–237, 2014.

[3] J. H. Schönherr, B. Lutz, and J. Richling, “Non-intrusive coscheduling
    for general purpose operating systems,” in Proceedings of the
    International Conference on Multicore Software Engineering,
    Performance, and Tools (MSEPT ’12), ser. Lecture Notes in Computer
    Science, vol. 7303. Berlin/Heidelberg, Germany: Springer, May 2012,
    pp. 66–77.

[4] J. H. Schönherr, J. Richling, M. Werner, and G. Mühl, “A scheduling
    approach for efficient utilization of hardware-driven frequency
    scaling,” in Workshop Proceedings of the 23rd International Conference
    on Architecture of Computing Systems (ARCS 2010 Workshops), M. Beigl
    and F. J. Cazorla-Almeida, Eds. Berlin, Germany: VDE Verlag, Feb.
    2010, pp. 367–376.

