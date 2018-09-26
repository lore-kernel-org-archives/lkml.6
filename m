Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AD420645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tWQKnmTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AD420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeIZPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:48:02 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:61362 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZPsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537954557; x=1569490557;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nph0eEWFDIa4QIGdQp3jl/qJEC5U9euGkCAiG9Fuinw=;
  b=tWQKnmTy78gMzsJH1WxOiDwzqiqkEUzG1+8swUWFkuFgutzLcqLy8Z7t
   cvREeYtfKmmIA7stnh/1sHlViIaKp/ErQwXPqE6BYjKayxpm/yV/91urY
   GTe3IATUv1Vkhkm754JhK/9jFqDwpXv4V/UbUaOo+KJNGrzWFzDVzJXUO
   A=;
X-IronPort-AV: E=Sophos;i="5.54,305,1534809600"; 
   d="scan'208";a="632751626"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 09:35:53 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w8Q9ZkvT092100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 26 Sep 2018 09:35:49 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8Q9Zi1b018067;
        Wed, 26 Sep 2018 11:35:44 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <20180917133703.GU24124@hirez.programming.kicks-ass.net>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <88a58ef0-4175-a247-9b48-076ffe1c750e@amazon.de>
Date:   Wed, 26 Sep 2018 11:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917133703.GU24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 03:37 PM, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 06:25:44PM +0200, Jan H. Schönherr wrote:
>> With gang scheduling as defined by Feitelson and Rudolph [6], you'd have to
>> explicitly schedule idle time. With coscheduling as defined by Ousterhout [7],
>> you don't. In this patch set, the scheduling of idle time is "merely" a quirk
>> of the implementation. And even with this implementation, there's nothing
>> stopping you from down-sizing the width of the coscheduled set to take out
>> the idle vCPUs dynamically, cutting down on fragmentation.
> 
> The thing is, if you drop the full width gang scheduling, you instantly
> require the paravirt spinlock / tlb-invalidate stuff again.

Can't say much about tlb-invalidate, but yes to the spinlock stuff: if
there isn't any additional information available, all runnable tasks/vCPUs
have to be coscheduled to avoid lock holder preemption.

With additional information about tasks potentially holding locks or
potentially spinning on a lock, it would be possible to coschedule smaller
subsets -- no idea if that would be any more efficient though.


> Of course, the constraints of L1TF itself requires the explicit
> scheduling of idle time under a bunch of conditions.

That is true for some of the resource contention use cases, too. Though,
they are much more relaxed wrt. their requirements on the simultaneousness
of the context switch.


> I did not read your [7] in much detail (also very bad quality scan that
> :-/; but I don't get how they leap from 'thrashing' to co-scheduling.

In my personal interpretation, that analogy refers to the case where the
waiting time for a lock is shorter than the time for a context switch --
but where the context switch was done anyway, "thrashing" the CPU.


Anyway. I only brought it up, because everyone has a different
understanding of what "coscheduling" or "gang scheduling" actually means.
The memorable quotes are from Ousterhout:

  "A task force is coscheduled if all of its runnable processes are exe-
   cuting simultaneously on different processors. Each of the processes
   in that task force is also said to be coscheduled."

(where a "task force" is a group of closely cooperating tasks), and from
Feitelson and Rudolph:

  "[Gang scheduling is defined] as the scheduling of a group of threads
   to run on a set of processors at the same time, on a one-to-one
   basis."

(with the additional assumption of time slices, collective preemption,
and that threads don't relinquish the CPU during their time slice).

That makes gang scheduling much more specific, while coscheduling just
refers to the fact that some things are executed simultaneously.


> Their initial problem, where A generates data that B needs and the 3
> scenarios:
> 
>  1) A has to wait for B
>  2) B has to wait for A
>  3) the data gets buffered
> 
> Seems fairly straight forward and is indeed quite common, needing
> co-scheduling for that, I'm not convinced.
> 
> We have of course added all sorts of adaptive wait loops in the kernel
> to deal with just that issue.
> 
> With co-scheduling you 'ensure' B is running when A is, but that doesn't
> mean you can actually make more progress, you could just be burning a
> lot of CPu cycles (which could've been spend doing other work).

I don't think, that coscheduling should be applied blindly.

Just like the adaptive wait loops you mentioned: in the beginning there
was active waiting; it wasn't that great, so passive waiting was invented;
turns out, the overhead is too high in some cases, so let's spin adaptively
for a moment.

We went from uncoordinated scheduling to system-wide coordinated scheduling
(which turned out to be not very efficient for many cases). And now we are
in the phase to find the right adaptiveness. There is work on enabling
coscheduling only on-demand (when a parallel application profits from it)
or to be more fuzzy about it (giving the scheduler more freedom); there is
work to go away from system-wide coordination to (dynamically) smaller
isles (where I see my own work as well). And "recently" we also have the
resource contention and security use cases leaving their impression on the
topic as well.


> I'm also not convinced co-scheduling makes _any_ sense outside SMT --
> does one of the many papers you cite make a good case for !SMT
> co-scheduling? It just doesn't make sense to co-schedule the LLC domain,
> that's 16+ cores on recent chips.

There's the resource contention stuff, much of which targets the last
level cache or memory controller bandwidth. So, that is making a case for
coscheduling larger parts than SMT. However, I didn't find anything in a
short search that would already cover some of the more recent processors
with 16+ cores.

There's the auto-tuning of parallel algorithms to a certain system
architecture. That would also profit from LLC coscheduling (and slightly
larger time slices) to run multiple of those in parallel. Again, no idea
for recent processors.

There's work to coschedule whole clusters, which goes beyond the scope of a
single system, but also predates recent systems. (Search for, e.g.,
"implicit coscheduling").

So, 16+ cores is unknown territory, AFAIK. But not every recent system has
16+ cores, or will have 16+ cores in the near future.

Regards
Jan
