Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B917C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA382073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA382073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeI2AAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:00:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54146 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeI2AAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:00:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EF518A;
        Fri, 28 Sep 2018 10:36:04 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 885353F5BD;
        Fri, 28 Sep 2018 10:35:57 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Steve Muckle <smuckle@google.com>, Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        quentin.perret@arm.com, Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris.Redpath@arm.com, Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
 <CANRm+CwEKf9bBj3zBQAL2nYjdt-zymz1xg7=PRcFz6DUOjLVJg@mail.gmail.com>
 <62134bba-b6bd-ba16-a49b-e4887c326559@arm.com>
 <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
 <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com>
 <CANRm+CyJQ_D9BP70OmB6z6r0zxDPoB0y828+E0tqis0x=jsd5A@mail.gmail.com>
 <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <2cee0f7c-023d-7b20-0a19-c2a4427625d9@arm.com>
Date:   Fri, 28 Sep 2018 19:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c0ec8322-4256-d8ae-0978-25ab44e34d68@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 06:10 PM, Steve Muckle wrote:
> On 09/27/2018 05:43 PM, Wanpeng Li wrote:
>>>> On your CPU4:
>>>> scheduler_ipi()
>>>>    -> sched_ttwu_pending()
>>>>         -> ttwu_do_activate()    => p->sched_remote_wakeup should be
>>>> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
>>>>              -> ttwu_activate()
>>>>                   -> activate_task()
>>>>                        -> enqueue_task()
>>>>                             -> enqueue_task_fair()
>>>>                                  -> enqueue_entity()
>>>>                                       bool renorm = !(flags &
>>>> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
>>>> so renorm is false in enqueue_entity(), why you mentioned that the
>>>> cfs_rq->min_vruntime is still added to the se->vruntime in
>>>> enqueue_task_fair()?
>>>
>>> Maybe this is a misunderstanding on my side but didn't you asked me to
>>> '... Could you point out when the fair rq's min_vruntime is added to the
>>> task's vruntime in your *later* scenario? ...'
>>
>> Yeah, if the calltrace above and my analysis is correct, then the fair
>> rq's min_vruntime will not be added to the task's vruntime in your
>> *later* scenario, which means that your patch is not necessary.
> 
> In the scenario I observed, the task is not waking - it is running and 
> being deboosted from priority inheritance, transitioning from RT to CFS.
> 
> Dietmar and I both were able to reproduce the issue with the testcase I 
> posted earlier in this thread.

Correct, and with the same testcase I got this call stack in this scenario:

[   35.588509] CPU: 1 PID: 2926 Comm: fair_task Not tainted 
4.18.0-rc6-00052-g11b7dafa2edb-dirty #5
[   35.597217] Hardware name: ARM Juno development board (r0) (DT)
[   35.603080] Call trace:
[   35.605509]  dump_backtrace+0x0/0x168
[   35.609138]  show_stack+0x24/0x30
[   35.612424]  dump_stack+0xac/0xe4
[   35.615710]  enqueue_task_fair+0xae0/0x11c0
[   35.619854]  rt_mutex_setprio+0x5a0/0x628
[   35.623827]  mark_wakeup_next_waiter+0x7c/0xc8
[   35.628228]  __rt_mutex_futex_unlock+0x30/0x50
[   35.632630]  do_futex+0x74c/0xb28
[   35.635912]  sys_futex+0x118/0x198
[   35.639280]  el0_svc_naked+0x30/0x34

[...]

