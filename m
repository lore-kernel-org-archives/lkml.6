Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96133C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56227216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56227216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeI0TlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:41:17 -0400
Received: from foss.arm.com ([217.140.101.70]:34572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0TlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:41:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5FC18A;
        Thu, 27 Sep 2018 06:23:01 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6FBE3F5B7;
        Thu, 27 Sep 2018 06:22:52 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steve Muckle <smuckle@google.com>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <fab279dd-0f6c-af7a-5a06-d26e77afad6a@arm.com>
Date:   Thu, 27 Sep 2018 15:22:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANRm+CzasXnjUtA_Xkm27=YDArc-gcpLmpSHv1cAqxihfocxRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/2018 03:19 AM, Wanpeng Li wrote:
> On Thu, 27 Sep 2018 at 06:38, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> Hi,
>>
>> On 09/26/2018 11:50 AM, Wanpeng Li wrote:
>>> Hi Dietmar,
>>> On Tue, 28 Aug 2018 at 22:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 08/27/2018 12:14 PM, Peter Zijlstra wrote:
>>>>> On Fri, Aug 24, 2018 at 02:24:48PM -0700, Steve Muckle wrote:
>>>>>> On 08/24/2018 02:47 AM, Peter Zijlstra wrote:
>>>>>>>>> On 08/17/2018 11:27 AM, Steve Muckle wrote:
>>
>> [...]
>>
>>>>>>>>>> - later, when the prio is deboosted and the task is moved back
>>>>>>>>>>        to the fair class, the fair rq's min_vruntime is added to
>>>>>>>>>>        the task's vruntime, even though it wasn't subtracted earlier.
>>>
>>> Could you point out when the fair rq's min_vruntime is added to the
>>> task's vruntime in your *later* scenario? attach_task_cfs_rq will not
>>> do that the same reason as detach_task_cfs_rq. fair task's
>>> sched_remote_wakeup is false which results in vruntime will not be
>>> renormalized in enqueue_entity.
>>
>> The cfs_rq->min_vruntime is still added to the se->vruntime in
>> enqueue_task_fair().
> 
> I understand what your patch done,

It's not my patch ;-) I just helped to find out under which 
circumstances this issue can happen.

> On your CPU4:
> scheduler_ipi()
>   -> sched_ttwu_pending()
>        -> ttwu_do_activate()    => p->sched_remote_wakeup should be
> false, so ENQUEUE_WAKEUP is set, ENQUEUE_MIGRATED is not
>             -> ttwu_activate()
>                  -> activate_task()
>                       -> enqueue_task()
>                            -> enqueue_task_fair()
>                                 -> enqueue_entity()
>                                      bool renorm = !(flags &
> ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATE)
> so renorm is false in enqueue_entity(), why you mentioned that the
> cfs_rq->min_vruntime is still added to the se->vruntime in
> enqueue_task_fair()?

Maybe this is a misunderstanding on my side but didn't you asked me to 
'... Could you point out when the fair rq's min_vruntime is added to the 
task's vruntime in your *later* scenario? ...'
