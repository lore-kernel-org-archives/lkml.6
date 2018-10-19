Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A0ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA82054F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="SGi3o2Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EA82054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeJTDPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:15:52 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:28580 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeJTDPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1539976108; x=1571512108;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=q29roiUNkq/Z+of4emmJaXBjvmE65VBTVOdszfE7OeA=;
  b=SGi3o2SljYX3rEcuMXlyf0O8ZBDEsYkYVmrvRcO4fqbx724nHBrACKrA
   SvRSlTHXwdXDi8iOZpQBCZAcNVPieTJJejYn9T125qosLWuiCKWDux5OW
   94k+hVdv6hM/T/KVNyA8gKzUeYUi7RI3BlVD9kplW6P4PMb7MOVo0S8Eh
   4=;
X-IronPort-AV: E=Sophos;i="5.54,401,1534809600"; 
   d="scan'208";a="700791798"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Oct 2018 19:07:59 +0000
Received: from u7588a65da6b65f.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9JJ7mQD025860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 19 Oct 2018 19:07:52 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9JJ7jIu013509;
        Fri, 19 Oct 2018 21:07:45 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Rik van Riel <riel@surriel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20181017020933.GC24723@lerouge>
 <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
 <824154aacf8a5cbff57b4df6cb072b7d6e277f34.camel@surriel.com>
 <20181019153316.GB15416@lerouge>
 <e34f720326a03ac07e3156abf77f0f6c22ce4289.camel@surriel.com>
From:   =?UTF-8?Q?Jan_H=2e_Sch=c3=b6nherr?= <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <37fe7d2a-5ec6-067b-e446-6c5a0fb10153@amazon.de>
Date:   Fri, 19 Oct 2018 21:07:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e34f720326a03ac07e3156abf77f0f6c22ce4289.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2018 17.45, Rik van Riel wrote:
> On Fri, 2018-10-19 at 17:33 +0200, Frederic Weisbecker wrote:
>> On Fri, Oct 19, 2018 at 11:16:49AM -0400, Rik van Riel wrote:
>>> On Fri, 2018-10-19 at 13:40 +0200, Jan H. Schönherr wrote:
>>>> 
>>>> Now, it would be possible to "invent" relocatable cpusets to 
>>>> address that issue ("I want affinity restricted to a core, I don't
>>>> care which"), but then, the current way how cpuset affinity is
>>>> enforced doesn't scale for making use of it from within the
>>>> balancer. (The upcoming load balancing portion of the coscheduler
>>>> currently uses a file similar to cpu.scheduled to restrict
>>>> affinity to a load-balancer-controlled subset of the system.)
>>> 
>>> Oh boy, so the coscheduler is going to get its own load balancer?

Not "its own". The load balancer already aggregates statistics about
sched-groups. With the coscheduler as posted, there is now a runqueue per
scheduling group. The current "ad-hoc" gathering of data per scheduling
group is then basically replaced with looking up that data at the
corresponding runqueue, where it is kept up-to-date automatically.


>>> At that point, why bother integrating the coscheduler into CFS,
>>> instead of making it its own scheduling class?
>>> 
>>> CFS is already complicated enough that it borders on unmaintainable.
>>> I would really prefer to have the coscheduler code separate from
>>> CFS, unless there is a really compelling reason to do otherwise.
>> 
>> I guess he wants to reuse as much as possible from the CFS features 
>> and code present or to come (nice, fairness, load balancing, power
>> aware, NUMA aware, etc...).

Exactly. I want a user to be able to "switch on" coscheduling for those
parts of the workload that profit from it, without affecting the behavior
we are all used to. For both: scheduling behavior for tasks that are not
coscheduled, as well as scheduling behavior for tasks *within* the group of
coscheduled tasks.


> I wonder if things like nice levels, fairness, and balancing could be
> broken out into code that could be reused from both CFS and a new 
> co-scheduler scheduling class.
> 
> A bunch of the cgroup code is already broken out, but maybe some more
> could be broken out and shared, too?

Maybe.


>> OTOH you're right, the thing has specific enough requirements to 
>> consider a new sched policy.

The primary issue that I have with a new scheduling class, is that they are
strictly priority ordered. If there is a runnable task in a higher class,
it is executed, no matter the situation in lower classes. "Coscheduling"
would have to be higher in the class hierarchy than CFS. And then, all
kinds of issues appear from starvation of CFS threads and other unfairness,
to the necessity of (re-)defining a set of preemption rules, nice and other
things that are given with CFS.


> Some bits of functionality come to mind:
> 
> - track groups of tasks that should be co-scheduled (eg all the VCPUs of
> a virtual machine)

cgroups

> - track the subsets of those groups that are runnable (eg. the currently
> runnable VCPUs of a virtual machine)

runqueues

> - figure out time slots and CPU assignments to efficiently use CPU time
> for the co-scheduled tasks (while leaving some configurable(?) amount of
> CPU time available for other tasks)

CFS runqueues and associated rules for preemption/time slices/etc.

> - configuring some lower-level code on each affected CPU to "run task A
> in slot X", etc

There is no "slot" concept, as it does not fit my idea of interactive
usage. (As in "slot X will execute from time T to T+1.) It is purely
event-driven right now (eg, "group X just became runnable, it is considered
more important than the currently running group Y; all CPUs (in the
affected part of the system) switch to group X", or "group X ran long
enough, next group").

While some planning ahead seems possible (as demonstrated by the Tableau
scheduler that Peter already pointed me at), I currently cannot imagine
such an approach working for general purpose workloads. The absence of true
preemption being my primary concern.


> This really does not seem like something that could be shoehorned into
> CFS without making it unmaintainable.
> 
> Furthermore, it also seems like the thing that you could never really
> get into a highly efficient state as long as it is weighed down by the
> rest of CFS.

I still have this idealistic notion, that there is no "weighing down". I
see it more as profiting from all the hard work that went into CFS,
avoiding the same mistakes, being backwards compatible, etc.



If I were to do this "outside of CFS", I'd overhaul the scheduling class
concept as it exists today. Instead, I'd probably attempt to schedule
instantiations of scheduling classes. In its easiest setup, nothing would
change: one CFS instance, one RT instance, one DL instance, strictly
ordered by priority (on each CPU). The coscheduler as it is posted (and
task groups in general), are effectively some form of multiple CFS
instances being governed by a CFS instance.

This approach would allow, for example, multiple CFS instances that are
scheduled with explicit priorities; or some tasks that are scheduled with a
custom scheduling class, while the whole group of tasks competes for time
with other tasks via CFS rules.

I'd still keep the feature of "coscheduling" orthogonal to everything else,
though. Essentially, I'd just give the user/admin the possibility to choose
the set of rules that shall be applied to entities in a runqueue.



Your idea of further modularization seems to go in a similar direction, or
at least is not incompatible with that. If it helps keeping things
maintainable, I'm all for it. For example, some of the (upcoming) load
balancing changes are just generalizations, so that the functions don't
operate on *the* set of CFS runqueues, but just *a* set of CFS runqueues.
Similarly in the already posted code, where task picking now starts at
*some* top CFS runqueue, instead of *the* top CFS runqueue.

Regards
Jan
