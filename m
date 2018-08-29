Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA99DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C12920657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C12920657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeH2TbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:31:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57006 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbeH2TbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:31:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1858B18A;
        Wed, 29 Aug 2018 08:33:36 -0700 (PDT)
Received: from [10.1.34.70] (deggeman-mac.cambridge.arm.com [10.1.34.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82003F557;
        Wed, 29 Aug 2018 08:33:33 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steve Muckle <smuckle@google.com>,
        Miguel de Dios <migueldedios@google.com>,
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
 <273b9b52-8c00-0414-ea11-214d81cd57c7@arm.com>
 <20180829115954.GS24124@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f7c5a86f-7d76-bf26-4763-94a9ef4bba2e@arm.com>
Date:   Wed, 29 Aug 2018 16:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829115954.GS24124@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 12:59 PM, Peter Zijlstra wrote:
> On Wed, Aug 29, 2018 at 11:54:58AM +0100, Dietmar Eggemann wrote:
>> I forgot to mention that since fair_task's cpu affinity is restricted to
>> CPU4, there is no call to set_task_cpu()->migrate_task_rq_fair() since if
>> (task_cpu(p) != cpu) fails.
>>
>> I think the combination of cpu affinity of the fair_task to CPU4 and the
>> fact that the scheduler runs on CPU1 when waking fair_task (with the two
>> cpus not sharing LLC) while TTWU_QUEUE is enabled is the situation in which
>> this vruntime issue can happen.
> 
> Ohhh, D'0h. A remote wakeup that doesn't migrate.

Ah, there is this WF_MIGRATED flag, perfect for the distinction whether 
a task migrated or not.

> That would suggest something like so:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb596f6c1..b3b62cf37fb6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9638,7 +9638,8 @@ static inline bool vruntime_normalized(struct task_struct *p)
>   	 * - A task which has been woken up by try_to_wake_up() and
>   	 *   waiting for actually being woken up by sched_ttwu_pending().
>   	 */
> -	if (!se->sum_exec_runtime || p->state == TASK_WAKING)
> +	if (!se->sum_exec_runtime ||
> +	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
>   		return true;
>   
>   	return false;
Yes, this solves the issue for the case I described. Using 
'p->sched_remote_wakeup' (WF_MIGRATED) looks more elegant than using 
'p->sched_class == &fair_sched_class'.
