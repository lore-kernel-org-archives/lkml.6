Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044DBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23A12087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23A12087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeH1SqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:46:01 -0400
Received: from foss.arm.com ([217.140.101.70]:39664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbeH1SqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:46:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 819EA18A;
        Tue, 28 Aug 2018 07:53:59 -0700 (PDT)
Received: from [10.1.37.73] (deggeman-mac.cambridge.arm.com [10.1.37.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C1063F557;
        Tue, 28 Aug 2018 07:53:57 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Peter Zijlstra <peterz@infradead.org>,
        Steve Muckle <smuckle@google.com>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
Date:   Tue, 28 Aug 2018 15:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827111458.GB24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>>
>>>>>> When rt_mutex_setprio changes a task's scheduling class to RT,
>>>>>> we're seeing cases where the task's vruntime is not updated
>>>>>> correctly upon return to the fair class.
>>>
>>>>>> Specifically, the following is being observed:
>>>>>> - task is deactivated while still in the fair class
>>>>>> - task is boosted to RT via rt_mutex_setprio, which changes
>>>>>>      the task to RT and calls check_class_changed.
>>>>>> - check_class_changed leads to detach_task_cfs_rq, at which point
>>>>>>      the vruntime_normalized check sees that the task's state is TASK_WAKING,
>>>>>>      which results in skipping the subtraction of the rq's min_vruntime
>>>>>>      from the task's vruntime
>>>>>> - later, when the prio is deboosted and the task is moved back
>>>>>>      to the fair class, the fair rq's min_vruntime is added to
>>>>>>      the task's vruntime, even though it wasn't subtracted earlier.
>>>
>>> I'm thinking that is an incomplete scenario; where do we get to
>>> TASK_WAKING.
>>
>> Yes there's a missing bit of context here at the beginning that the task to
>> be boosted had already been put into TASK_WAKING.
> 
> See, I'm confused...
> 
> The only time TASK_WAKING is visible, is if we've done a remote wakeup
> and it's 'stuck' on the remote wake_list. And in that case we've done
> migrate_task_rq_fair() on it.
> 
> So by the time either rt_mutex_setprio() or __sched_setscheduler() get
> to calling check_class_changed(), under both pi_lock and rq->lock, the
> vruntime_normalized() thing should be right.
> 
> So please detail the exact scenario. Because I'm not seeing it.

Using Steve's test program (https://lkml.org/lkml/2018/8/24/686) I see the
issue but only if the two tasks (rt_task, fair_task) run on 2 cpus which
don't share LLC (e.g. CPU0 and CPU4 on hikey960).

So the wakeup goes the TTWU_QUEUE && !share_cache (ttwu_queue_remote) path.

...
rt_task-3579  [000] 35.391573: sched_waking:     comm=fair_task pid=3580 prio=120 target_cpu=004
rt_task-3579  [000] 35.391580: bprint:           try_to_wake_up: try_to_wake_up: task=fair_task pid=3580 task_cpu(p)=4 p->on_rq=0
rt_task-3579  [000] 35.391584: bprint:           try_to_wake_up: ttwu_queue: task=fair_task pid=3580
rt_task-3579  [000] 35.391588: bprint:           try_to_wake_up: ttwu_queue_remote: task=fair_task pid=3580
rt_task-3579  [000] 35.391591: bprint:           try_to_wake_up: ttwu_queue_remote: cpu=4 smp_send_reschedule
rt_task-3579  [000] 35.391627: sched_pi_setprio: comm=fair_task pid=3580 oldprio=120 newprio=19
rt_task-3579  [000] 35.391635: bprint:           rt_mutex_setprio: task=fair_task pid=3580 prio=120->19 queued=0 running=0 state=0x200 vruntime=46922871 cpu=4 cfs_rq->min_vruntime=7807420844
rt_task-3579  [000] 35.391641: bprint:           rt_mutex_setprio: p->prio set: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
rt_task-3579  [000] 35.391646: bprint:           rt_mutex_setprio: queued checked: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
rt_task-3579  [000] 35.391652: bprint:           rt_mutex_setprio: running checked: task=fair_task pid=3580 prio=19 queued=0 running=0 state=0x200 vruntime=46922871
rt_task-3579  [000] 35.391657: bprint:           rt_mutex_setprio: fair_class=0xffff000008da2c80 rt_class=0xffff000008da2d70 prev_class=0xffff000008da2c80 p->sched_class=0xffff000008da2d70 oldprio=120 p->prio=19
rt_task-3579  [000] 35.391661: bprint:           detach_task_cfs_rq: task=fair_task pid=3580 cpu=4 vruntime_normalized=1
rt_task-3579  [000] 35.391706: sched_switch:     rt_task:3579 [19] D ==> swapper/0:0 [120] 
 <idle>-0     [004] 35.391828: bprint:           ttwu_do_activate: ttwu_do_activate: task=fair_task pid=3580
 <idle>-0     [004] 35.391832: bprint:           ttwu_do_activate: ttwu_activate: task=fair_task pid=3580
 <idle>-0     [004] 35.391833: bprint:           ttwu_do_wakeup: ttwu_do_wakeup: task=fair_task pid=3580
 <idle>-0     [004] 35.391834: sched_wakeup:     fair_task:3580 [19] success=1 CPU:004

It doesn't happen on hikey960 when I use two cpus of the same LLC or on my
laptop (i7-4750HQ).
