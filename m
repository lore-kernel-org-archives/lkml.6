Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FB4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6754820835
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6754820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeH2OvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:51:21 -0400
Received: from foss.arm.com ([217.140.101.70]:52258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeH2OvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50A680D;
        Wed, 29 Aug 2018 03:55:01 -0700 (PDT)
Received: from [10.1.34.70] (deggeman-mac.cambridge.arm.com [10.1.34.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1A283F557;
        Wed, 29 Aug 2018 03:54:59 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
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
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
Message-ID: <273b9b52-8c00-0414-ea11-214d81cd57c7@arm.com>
Date:   Wed, 29 Aug 2018 11:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 03:53 PM, Dietmar Eggemann wrote:
> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>>>
>>>>>>> When rt_mutex_setprio changes a task's scheduling class to RT,
>>>>>>> we're seeing cases where the task's vruntime is not updated
>>>>>>> correctly upon return to the fair class.
>>>>
>>>>>>> Specifically, the following is being observed:
>>>>>>> - task is deactivated while still in the fair class
>>>>>>> - task is boosted to RT via rt_mutex_setprio, which changes
>>>>>>>       the task to RT and calls check_class_changed.
>>>>>>> - check_class_changed leads to detach_task_cfs_rq, at which point
>>>>>>>       the vruntime_normalized check sees that the task's state is TASK_WAKING,
>>>>>>>       which results in skipping the subtraction of the rq's min_vruntime
>>>>>>>       from the task's vruntime
>>>>>>> - later, when the prio is deboosted and the task is moved back
>>>>>>>       to the fair class, the fair rq's min_vruntime is added to
>>>>>>>       the task's vruntime, even though it wasn't subtracted earlier.
>>>>
>>>> I'm thinking that is an incomplete scenario; where do we get to
>>>> TASK_WAKING.
>>>
>>> Yes there's a missing bit of context here at the beginning that the task to
>>> be boosted had already been put into TASK_WAKING.
>>
>> See, I'm confused...
>>
>> The only time TASK_WAKING is visible, is if we've done a remote wakeup
>> and it's 'stuck' on the remote wake_list. And in that case we've done
>> migrate_task_rq_fair() on it.
>>
>> So by the time either rt_mutex_setprio() or __sched_setscheduler() get
>> to calling check_class_changed(), under both pi_lock and rq->lock, the
>> vruntime_normalized() thing should be right.
>>
>> So please detail the exact scenario. Because I'm not seeing it.
> 
> Using Steve's test program (https://lkml.org/lkml/2018/8/24/686) I see the
> issue but only if the two tasks (rt_task, fair_task) run on 2 cpus which
> don't share LLC (e.g. CPU0 and CPU4 on hikey960).
> 
> So the wakeup goes the TTWU_QUEUE && !share_cache (ttwu_queue_remote) path.

I forgot to mention that since fair_task's cpu affinity is restricted to 
CPU4, there is no call to set_task_cpu()->migrate_task_rq_fair() since 
if (task_cpu(p) != cpu) fails.

I think the combination of cpu affinity of the fair_task to CPU4 and the 
fact that the scheduler runs on CPU1 when waking fair_task (with the two 
cpus not sharing LLC) while TTWU_QUEUE is enabled is the situation in 
which this vruntime issue can happen.

[...]
