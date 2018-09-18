Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D35ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2F22146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ByWUl6Yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2F22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeIRSy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:54:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5354 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeIRSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1537276943; x=1568812943;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=h0zmUFZbcNN32fP2ieocv51laGIG6Pny3lv/jyYKAx8=;
  b=ByWUl6Yd0X8OfEcKb3t6CSc9tuG69nuwg24+Vr6s5Y2ZtT5dMjDgy1pC
   c5vOHLAquobo11ZyeLGpQgtPCUR4TDXDgzi3r/dlkRmV+G0HUoljUchSX
   jSjOtTF7+KPI5oWW5hdC+SSrMNEhaw1tMVmMZpRbkEQFBAiD/tmufqckm
   A=;
X-IronPort-AV: E=Sophos;i="5.53,389,1531785600"; 
   d="scan'208";a="753792909"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Sep 2018 13:22:20 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8IDMGPB043239
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 18 Sep 2018 13:22:18 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8IDMD2g032216;
        Tue, 18 Sep 2018 15:22:14 +0200
Subject: Re: Task group cleanups and optimizations (was: Re: [RFC 00/60]
 Coscheduling for Linux)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
 <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
 <282230fe-b8de-01f9-c19b-6070717ba5f8@amazon.de>
 <20180917094844.GR24124@hirez.programming.kicks-ass.net>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <08b930d9-7ffe-7df3-ab35-e7b58073e489@amazon.de>
Date:   Tue, 18 Sep 2018 15:22:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917094844.GR24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 11:48 AM, Peter Zijlstra wrote:
> On Sat, Sep 15, 2018 at 10:48:20AM +0200, Jan H. Schönherr wrote:
>> On 09/14/2018 06:25 PM, Jan H. Schönherr wrote:
> 
>>> b) ability to move CFS RQs between CPUs: someone changed the affinity of
>>>    a cpuset? No problem, just attach the runqueue with all the tasks elsewhere.
>>>    No need to touch each and every task.
> 
> Can't do that, tasks might have individual constraints that are tighter
> than the cpuset.

AFAIK, changing the affinity of a cpuset overwrites the individual affinities of tasks
within them. Thus, it shouldn't be an issue.

> Also, changing affinities isn't really a hot path, so
> who cares.

This kind of code path gets a little hotter, when a coscheduled set gets load-balanced
from one core to another.

Apart from that, I also think, that normal user-space applications should never have
to concern themselves with actual affinities. More often than not, they only want to
express a relation to some other task (or sometimes resource), like "run on the same
NUMA node", "run on the same core", so that application design assumptions are
fulfilled. That's an interface, that I'd like to see as a cgroup controller at some
point. It would also benefit from the ability to move/balance whole runqueues.

(It might also be a way to just bulk-balance a bunch of tasks in the current code,
by exchanging two CFS runqueues. But that has probably some additional issues.)


>>> c) light-weight task groups: don't allocate a runqueue for every CPU in the
>>>    system, when it is known that tasks in the task group will only ever run
>>>    on at most two CPUs, or so. (And while there is of course a use case for
>>>    VMs in this, another class of use cases are auxiliary tasks, see eg, [1-5].)
> 
> I have yet to go over your earlier email; but no. The scheduler is very
> much per-cpu. And as I mentioned earlier, CFS as is doesn't work right
> if you share the runqueue between multiple CPUs (and 'fixing' that is
> non trivial).

No sharing. Just not allocating runqueues that won't be used anyway.
Assume you express this "always run on the same core" or have other reasons
to always restrict tasks in a task group to just one core/node/whatever. On an
SMT system, you would typically need at most two runqueues for a core; the memory
foot-print of a task group would no longer increase linearly with system size.

It would be possible to (space-)efficiently express nested parallelism use cases
without having to resort to managing affinities manually (which restrict the
scheduler more than necessary).

(And it would be okay for an adjustment of the maximum number of runqueues to fail
with an -ENOMEM in dire situations, as this adjustment would be an explicit
(user-)action.)


>>> Is this the level of optimizations, you're thinking about? Or do you want
>>> to throw away the whole nested CFS RQ experience in the code?
>>
>> I guess, it would be possible to flatten the task group hierarchy, that is usually
>> created when nesting cgroups. That is, enqueue task group SEs always within the
>> root task group.
>>
>> That should take away much of the (runtime-)overhead, no?
> 
> Yes, Rik was going to look at trying this. Put all the tasks in the root
> rq and adjust the vtime calculations. Facebook is seeing significant
> overhead from cpu-cgroup and has to disable it because of that on at
> least part of their setup IIUC.
> 
>> The calculation of shares would need to be a different kind of complex than it is
>> now. But that might be manageable.
> 
> That is the hope; indeed. We'll still need to create the hierarchy for
> accounting purposes, but it can be a smaller/simpler data structure.
> 
> So the weight computation would be the normalized product of the parents
> etc.. and since PELT only updates the values on ~1ms scale, we can keep
> a cache of the product -- that is, we don't have to recompute that
> product and walk the hierarchy all the time either.
> 
>> CFS bandwidth control would also need to change significantly as we would now
>> have to dequeue/enqueue nested cgroups below a throttled/unthrottled hierarchy.
>> Unless *those* task groups don't participate in this flattening.
> 
> Right, so the whole bandwidth thing becomes a pain; the simplest
> solution is to detect the throttle at task-pick time, dequeue and try
> again. But that is indeed quite horrible.
> 
> I'm not quite sure how this will play out.
> 
> Anyway, if we pull off this flattening feat, then you can no longer use
> the hierarchy for this co-scheduling stuff.

Yeah. I might be a bit biased towards keeping or at least not fully throwing away
the nesting of CFS runqueues. ;)

However, the only efficient way that I can currently think of, is a hybrid model
between the "full nesting" that is currently there, and the "no nesting" you were
describing above.

It would flatten all task groups that do not actively contribute some function,
which would be all task groups purely for accounting purposes and those for
*unthrottled* CFS hierarchies (and those for coscheduling that contain exactly
one SE in a runqueue). The nesting would still be kept for *throttled* hierarchies
(and the coscheduling stuff). (And if you wouldn't have mentioned a way to get
rid of nesting completely, I would have kept a single level of nesting for
accounting purposes as well.)

This would allow us to lazily dequeue SEs that have run out of bandwidth when
we encounter them, and already enqueue them in the nested task group (whose SE
is not enqueued at the moment). That way, it's still a O(1) operation to re-enable
all tasks, once runtime is available again. And O(1) to throttle a repeat offender.

Regards
Jan
