Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C8C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BAA21568
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BAA21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeI0Exa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:53:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbeI0Exa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3361218A;
        Wed, 26 Sep 2018 15:38:20 -0700 (PDT)
Received: from [192.168.0.102] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A2B3F5B3;
        Wed, 26 Sep 2018 15:38:17 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, smuckle@google.com,
        migueldedios@google.com, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        joaodias@google.com, Wanpeng Li <wanpengli@tencent.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
 <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com>
Date:   Thu, 27 Sep 2018 00:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/26/2018 11:50 AM, Wanpeng Li wrote:
> Hi Dietmar,
> On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
>>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
>>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:

[...]

>>>>>>>> - later, when the prio is deboosted and the task is moved back
>>>>>>>>       to the fair class, the fair rq's min_vruntime is added to
>>>>>>>>       the task's vruntime, even though it wasn't subtracted earlier.
> 
> Could you point out when the fair rq's min_vruntime is added to the
> task's vruntime in your *later* scenario? attach_task_cfs_rq will not
> do that the same reason as detach_task_cfs_rq. fair task's
> sched_remote_wakeup is false which results in vruntime will not be
> renormalized in enqueue_entity.

The cfs_rq->min_vruntime is still added to the se->vruntime in
enqueue_task_fair().

It's just that without this patch, which adds the '&&
p->sched_remote_wakeup' bit to the condition under which
vruntime_normalized() returns true, detach_task_cfs_rq() won't go into the
'if (!vruntime_normalized(p))' path and not subtract cfs_rq->min_vruntime
from se->vruntime. 

Since 'task_cpu(p) equal cpu' in try_to_wake_up() for the fair task,
WF_MIGRATED is not set and set_task_cpu() -> migrate_task_rq_fair()
is not called which could subtract cfs_rq->min_vruntime from
se->vruntime as well.

My former example with a different set of trace events:

fair_task-3580  [004]    35.389346: sched_stat_runtime:   comm=fair_task pid=3580 runtime=45312 [ns] vruntime=46922871 [ns] <-- se->vruntime=46.922.871
...
  rt_task-3579  [000]    35.391573: sched_waking:         comm=fair_task pid=3580 prio=120 target_cpu=004
...
  rt_task-3579  [000]    35.391627: sched_pi_setprio:     comm=fair_task pid=3580 oldprio=120 newprio=19
...
  rt_task-3579  [000]    35.391661: bprint:               detach_task_cfs_rq: task=fair_task pid=3580 cpu=4 vruntime_normalized=1
  rt_task-3579  [000]    35.391706: sched_switch:         rt_task:3579 [19] D ==> swapper/0:0 [120]
   <idle>-0     [004]    35.391834: sched_wakeup:         fair_task:3580 [19] success=1 CPU:004
   <idle>-0     [004]    35.391840: sched_switch:         swapper/4:0 [120] S ==> fair_task:3580 [19]
fair_task-3580  [004]    35.391853: sched_pi_setprio:     comm=fair_task pid=3580 oldprio=19 newprio=120
...
fair_task-3580  [004]    35.391863: bprint:               enqueue_task_fair: task=fair_task pid=3580 curr=0 se->vruntime=93845742 cpu=4 cfs_rq->min_vruntime=46922871
...
fair_task-3580  [004]    35.391877: sched_waking:         comm=rt_task pid=3579 prio=19 target_cpu=000
...
fair_task-3580  [004]    35.391885: sched_stat_runtime:   comm=fair_task pid=3580 runtime=31250 [ns] vruntime=93876992 [ns] <-- se->vruntime=93.876.992
