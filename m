Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A95FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7016320882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Xrpo1d8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7016320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbeINVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:41:12 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:7588 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeINVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1536942355; x=1568478355;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YDqurQgY7+fT3bL+X7sDzw/zqnJtrSAfwnOUYjkq3v4=;
  b=Xrpo1d8CB2cpHF0pCY+KV4xxp91ZChZaNfEP1172b7k2xMsNCF59pQnW
   ysivX1a69HeYXDD/+55K6/h3EXb+W2mBrdy7I2LvSzLGRtM3ANkub+Y6m
   aIpuQF5/H0zdrJuvigRWysR9hwD7Qh0cwVOUNiOx0DZs+TWiUb7L/8zbO
   M=;
X-IronPort-AV: E=Sophos;i="5.53,373,1531785600"; 
   d="scan'208";a="630656206"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 16:25:52 +0000
Received: from u7588a65da6b65f.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w8EGPnd2099713
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 14 Sep 2018 16:25:51 GMT
Received: from u7588a65da6b65f.ant.amazon.com (localhost [127.0.0.1])
        by u7588a65da6b65f.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w8EGPjOk019032;
        Fri, 14 Sep 2018 18:25:45 +0200
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20180914111251.GC24106@hirez.programming.kicks-ass.net>
From:   "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Openpgp: preference=signencrypt
Message-ID: <1d86f497-9fef-0b19-50d6-d46ef1c0bffa@amazon.de>
Date:   Fri, 14 Sep 2018 18:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914111251.GC24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/2018 01:12 PM, Peter Zijlstra wrote:
> On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
>> This patch series extends CFS with support for coscheduling. The
>> implementation is versatile enough to cover many different coscheduling
>> use-cases, while at the same time being non-intrusive, so that behavior of
>> legacy workloads does not change.
> 
> I don't call this non-intrusive.

Mm... there is certainly room for interpretation. :) For example, it is still
possible to set affinities, to use nice, and to tune all the other existing CFS
knobs. That is, if you have tuned the scheduler to your workload or your workload
depends on some CFS feature to work efficiently (whether on purpose or not), then
running with this patch set should not change the behavior of said workload.

This patch set should "just" give the user the additional ability to coordinate
scheduling decisions across multiple CPUs. At least, that's my goal.

If someone doesn't need it, they don't have to use it. Just like task groups.

But maybe, people start experimenting with coordinated scheduling decisions --
after all, there is a ton of research on what one *could* do, if there was
coscheduling. I did look over much of that research. What I didn't like about
many of them, is that evaluation is based on a "prototype", that -- while
making the point that coscheduling might be beneficial for that use case --
totally screws over the scheduler for any other use case. Like coscheduling
based on deterministic, timed context switches across all CPUs. Bye bye
interactivity. That is, what I call intrusive.

As mentioned before, existing scheduler features, like preemption, (should)
still work as before with this variant of coscheduling, with the same look and
feel.

And who knows, maybe someone will come up with a use case that moves coscheduling
out of its niche; like the auto-grouping feature promoted the use of task groups.


>> Peter Zijlstra once called coscheduling a "scalability nightmare waiting to
>> happen". Well, with this patch series, coscheduling certainly happened.
> 
> I'll beg to differ; this isn't anywhere near something to consider
> merging. Also 'happened' suggests a certain stage of completeness, this
> again doesn't qualify.

I agree, that this isn't ready to be merged. Still, the current state is good
to start a discussion about the involved mechanics.


>> However, I disagree on the scalability nightmare. :)
> 
> There are known scalability problems with the existing cgroup muck; you
> just made things a ton worse. The existing cgroup overhead is
> significant, you also made that many times worse.
> 
> The cgroup stuff needs cleanups and optimization, not this.

Are you referring to cgroups in general, or task groups (aka. the cpu
controller) specifically?


With respect to scalability: many coscheduling use cases don't require
synchronization across the whole system. With this patch set, only those
parts that are actually coscheduled are involved in synchronization.
So, conceptually, this scales to larger systems from that point of view.

If coscheduling of a larger fraction of the system is required, costs
increase. So what? It's a trade-off. It may *still* be beneficial for a
use case. If it is, it might get adopted. If not, that particular use
case may be considered impractical unless someone comes up with a better
implementation of coscheduling.


With respect to the need of cleanups and optimizations: I agree, that
task groups are a bit messy. For example, here's my current wish list
off the top of my head:

a) lazy scheduler operations; for example: when dequeuing a task, don't bother
   walking up the task group hierarchy to dequeue all the SEs -- do it lazily
   when encountering an empty CFS RQ during picking when we hold the lock anyway.

b) ability to move CFS RQs between CPUs: someone changed the affinity of
   a cpuset? No problem, just attach the runqueue with all the tasks elsewhere.
   No need to touch each and every task.

c) light-weight task groups: don't allocate a runqueue for every CPU in the
   system, when it is known that tasks in the task group will only ever run
   on at most two CPUs, or so. (And while there is of course a use case for
   VMs in this, another class of use cases are auxiliary tasks, see eg, [1-5].)

Is this the level of optimizations, you're thinking about? Or do you want
to throw away the whole nested CFS RQ experience in the code?


>> B) Why would I want this?
> 
>>    In the L1TF context, it prevents other applications from loading
>>    additional data into the L1 cache, while one application tries to leak
>>    data.
> 
> That is the whole and only reason you did this;
It really isn't. But as your mind seems made up, I'm not going to bother
to argue.


> and it doesn't even
> begin to cover the requirements for it.
> 
> Not to mention I detest cgroups; for their inherent complixity and the
> performance costs associated with them.  _If_ we're going to do
> something for L1TF then I feel it should not depend on cgroups.
> 
> It is after all, perfectly possible to run a kvm thingy without cgroups.

Yes it is. But, for example, you won't have group-based fairness between
multiple kvm thingies.

Assuming, there is a cgroup-less solution that can prevent simultaneous
execution of tasks on a core, when they're not supposed to. How would you
tell the scheduler, which tasks these are?


>> 1. Execute parallel applications that rely on active waiting or synchronous
>>    execution concurrently with other applications.
>>
>>    The prime example in this class are probably virtual machines. Here,
>>    coscheduling is an alternative to paravirtualized spinlocks, pause loop
>>    exiting, and other techniques with its own set of advantages and
>>    disadvantages over the other approaches.
> 
> Note that in order to avoid PLE and paravirt spinlocks and paravirt
> tlb-invalidate you have to gang-schedule the _entire_ VM, not just SMT
> siblings.
> 
> Now explain to me how you're going to gang-schedule a VM with a good
> number of vCPU threads (say spanning a number of nodes) and preserving
> the rest of CFS without it turning into a massive trainwreck?

You probably don't -- for the same reason, why it is a bad idea to give
an endless loop realtime priority. It's just a bad idea. As I said in the
text you quoted: coscheduling comes with its own set of advantages and
disadvantages. Just because you find one example, where it is a bad idea,
doesn't make it a bad thing in general.


> Such things (gang scheduling VMs) _are_ possible, but not within the
> confines of something like CFS, they are also fairly inefficient
> because, as you do note, you will have to explicitly schedule idle time
> for idle vCPUs.

With gang scheduling as defined by Feitelson and Rudolph [6], you'd have to
explicitly schedule idle time. With coscheduling as defined by Ousterhout [7],
you don't. In this patch set, the scheduling of idle time is "merely" a quirk
of the implementation. And even with this implementation, there's nothing
stopping you from down-sizing the width of the coscheduled set to take out
the idle vCPUs dynamically, cutting down on fragmentation.


> Things like the Tableau scheduler are what come to mind; but I'm not
> sure how to integrate that with a general purpose scheduling scheme. You
> pretty much have to dedicate a set of CPUs to just scheduling VMs with
> such a scheduler.
> 
> And that would call for cpuset-v2 integration along with a new
> scheduling class.
> 
> And then people will complain again that partitioning a system isn't
> dynamic enough and we need magic :/
> 
> (and this too would be tricky to virtualize itself)

Hence my "counter" suggestion in the form of this patch set: Integrated
into a general purpose scheduler, no need to partition off a part of the system,
not tied to just VM use cases.


>> C) How does it work?
>> --------------------
>>
>> This patch series introduces hierarchical runqueues, that represent larger
>> and larger fractions of the system. By default, there is one runqueue per
>> scheduling domain. These additional levels of runqueues are activated by
>> the "cosched_max_level=" kernel command line argument. The bottom level is
>> 0.
> 
> You gloss over a ton of details here; 

Yes, I do. :) I wanted a summary, not a design document. Maybe I was a bit
to eager in condensing the design to just a few paragraphs...


> many of which are non trivial and
> marked broken in your patches. Unless you have solid suggestions on how
> to deal with all of them, this is a complete non-starter.

Address them one by one. Probably do some of the optimizations you suggested
to just get rid of some of them. It's work in progress. Though, at this
stage I am also really interested in things that are broken, that I am not
aware of yet.


> The per-cpu IRQ/steal time accounting for example. The task timeline
> isn't the same on every CPU because of those.
> 
> You now basically require steal time and IRQ load to match between CPUs.
> That places very strict requirements and effectively breaks virt
> invariance. That is, the scheduler now behaves significantly different
> inside a VM than it does outside of it -- without the guest being gang
> scheduled itself and having physical pinning to reflect the same
> topology the coschedule=1 thing should not be exposed in a guest. And
> that is a mayor failing IMO.

I'll have to read up some more code to make a qualified statement here.


> Also; I think you're sharing a cfs_rq between CPUs:
> 
> +       init_cfs_rq(&sd->shared->rq.cfs);
> 
> that is broken, the virtual runtime stuff needs nontrivial modifications
> for multiple CPUs. And if you do that, I've no idea how you're dealing
> with SMP affinities.

It is not shared per se. There's only one CPU (the leader) making the scheduling
decision for that runqueue and if another CPU needs to modify the runqueue, it
works like it does for CPU runqueues as well: the other CPU works with the
leader's time. There are also no tasks in a runqueue when it is responsible for
more than one CPU.

Assuming, that a runqueue is responsible for a core and there are runnable
tasks within the task group on said core, then there will one SE enqueued in
that runqueue, a so called SD-SE (scheduling domain SE, or synchronization
domain SE). This SD-SE represents the per CPU runqueues of this core of this
task group. (As opposed to a "normal" task group SE (TG-SE), which represents
just one runqueue in a different task group.) Tasks are still only enqueued
in the per CPU runqueues.


>> You currently have to explicitly set affinities of tasks within coscheduled
>> task groups, as load balancing is not implemented for them at this point.
> 
> You don't even begin to outline how you preserve smp-nice fairness.

Works as before (or will work as before): a coscheduled task group has its
own set of per CPU runqueues that hold the tasks of this group (per CPU).
The load balancer will work on this subset of runqueues as it does on the
"normal" per CPU runqueues -- smp-nice fairness and all.


>> D) What can I *not* do with this?
>> ---------------------------------
>>
>> Besides the missing load-balancing within coscheduled task-groups, this
>> implementation has the following properties, which might be considered
>> short-comings.
>>
>> This particular implementation focuses on SCHED_OTHER tasks managed by CFS
>> and allows coscheduling them. Interrupts as well as tasks in higher
>> scheduling classes are currently out-of-scope: they are assumed to be
>> negligible interruptions as far as coscheduling is concerned and they do
>> *not* cause a preemption of a whole group. This implementation could be
>> extended to cover higher scheduling classes. Interrupts, however, are an
>> orthogonal issue.
>>
>> The collective context switch from one coscheduled set of tasks to another
>> -- while fast -- is not atomic. If a use-case needs the absolute guarantee
>> that all tasks of the previous set have stopped executing before any task
>> of the next set starts executing, an additional hand-shake/barrier needs to
>> be added.
> 
> IOW it's completely friggin useless for L1TF.

Do you believe me now, that L1TF is not "the whole and only reason" I did this? :D


>> E) What's the overhead?
>> -----------------------
>>
>> Each (active) hierarchy level has roughly the same effect as one additional
>> level of nested cgroups. In addition -- at this stage -- there may be some
>> additional lock contention if you coschedule larger fractions of the system
>> with a dynamic task set.
> 
> Have you actually read your own code?
> 
> What about that atrocious locking you sprinkle all over the place?
> 'some additional lock contention' doesn't even begin to describe that
> horror show.

Currently, there are more code paths than I like, that climb up the se->parent
relation to the top. They need to go, if we want to coschedule larger parts of
the system in a more efficient manner. Hence, parts of my wish list further up.

That said, it is not as bad as you make it sound for the following three reasons:

a) The amount of CPUs that compete for a lock is currently governed by the
   "cosched_max_level" command line argument, making it a conscious decision to
   increase the overall overhead. Hence, coscheduling at, e.g., core level
   does not have a too serious impact on lock contention.

b) The runqueue locks are usually only taken by the leader of said runqueue.
   Hence, there is often only one user per lock even at higher levels.
   The prominent exception at this stage of the patch set is that enqueue and
   dequeue operations walk up the hierarchy up to the "cosched_max_level".
   And even then, due to lock chaining, multiple enqueue/dequeue operations
   on different CPUs can bubble up the shared part of the hierarchy in parallel.

c) The scheduling decision does not cause any lock contention by itself. Each
   CPU only accesses runqueues, where itself is the leader. Hence, once you
   have a relatively stable situation, lock contention is not an issue.


> Hint: we're not going to increase the lockdep subclasses, and most
> certainly not for scheduler locking.

That's fine. Due to the overhead of nesting cgroups that you mentioned earlier,
that many levels in the runqueue hierarchy are likely to be impracticable
anyway. For the future, I imagine a more dynamic variant of task groups/scheduling
domains, that can provide all the flexibility one would want without that deep
of a nesting. At this stage, it is just a way to experiment with larger systems
without having to disable lockdep.

Of course, if you have a suggestion for a different locking scheme, we can
discuss that as well. The current one, is what I considered most suitable
among some alternatives under the premise I was working: integrate coscheduling
in a scheduler as an additional feature (instead of, eg, write a scheduler
capable of coscheduling). So, I probably haven't considered all alternatives.


> All in all, I'm not inclined to consider this approach, it complicates
> an already overly complicated thing (cpu-cgroups) and has a ton of
> unresolved issues
Even if you're not inclined -- at this stage, if I may be so bold :) --
your feedback is valuable. Thank you for that.

Regards
Jan


References (for those that are into that kind of thing):

[1] D. Kim, S. S.-w. Liao, P. H. Wang, J. del Cuvillo, X. Tian, X. Zou,
    H. Wang, D. Yeung, M. Girkar, and J. P. Shen, “Physical experimentation
    with prefetching helper threads on Intel’s hyper-threaded processors,”
    in Proceedings of the International Symposium on Code Generation and
    Optimization (CGO ’04). Los Alamitos, CA, USA: IEEE Computer
    Society, Mar. 2004, pp. 27–38.

[2] C. Jung, D. Lim, J. Lee, and D. Solihin, “Helper thread prefetching for
    loosely-coupled multiprocessor systems,” in Parallel and Distributed Pro-
    cessing Symposium, 2006. IPDPS 2006. 20th International, April 2006.

[3] C. G. Quiñones, C. Madriles, J. Sánchez, P. Marcuello, A. González,
    and D. M. Tullsen, “Mitosis compiler: An infrastructure for speculative
    threading based on pre-computation slices,” in Proceedings of the 2005
    ACM SIGPLAN Conference on Programming Language Design and
    Implementation, ser. PLDI ’05. New York, NY, USA: ACM, 2005, pp.
    269–279.

[4] J. Mars, L. Tang, and M. L. Soffa, “Directly characterizing cross
    core interference through contention synthesis,” in Proceedings of the
    6th International Conference on High Performance and Embedded
    Architectures and Compilers, ser. HiPEAC ’11. New York, NY, USA:
    ACM, 2011, pp. 167–176.

[5] Q. Zeng, D. Wu, and P. Liu, “Cruiser: Concurrent heap buffer overflow
    monitoring using lock-free data structures,” in Proceedings of the 32Nd
    ACM SIGPLAN Conference on Programming Language Design and
    Implementation, ser. PLDI ’11. New York, NY, USA: ACM, 2011, pp.
    367–377.

[6] D. G. Feitelson and L. Rudolph, “Distributed hierarchical control for
    parallel processing,” Computer, vol. 23, no. 5, pp. 65–77, May 1990.

[7] J. Ousterhout, “Scheduling techniques for concurrent systems,” in
    Proceedings of the 3rd International Conference on Distributed Computing
    Systems (ICDCS ’82). Los Alamitos, CA, USA: IEEE Computer Society,
    Oct. 1982, pp. 22–30.
