Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF89208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF89208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbeGMPMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:12:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbeGMPMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:12:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7B57A9;
        Fri, 13 Jul 2018 07:57:51 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0130B3F5B1;
        Fri, 13 Jul 2018 07:57:48 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Remove setting task's se->runnable_weight
 during PELT update
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        kernel-team@android.com, Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org
References: <20180709164753.24699-1-dietmar.eggemann@arm.com>
 <20180710230917.GA187293@joelaf.mtv.corp.google.com>
 <0aba9bb6-eec7-130e-373f-5f87f192f2d4@arm.com>
 <20180712081722.GB154647@joelaf.mtv.corp.google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a8b4d514-f242-70ac-05c2-4ed31e2f66b8@arm.com>
Date:   Fri, 13 Jul 2018 16:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712081722.GB154647@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 10:17 AM, Joel Fernandes wrote:
> On Wed, Jul 11, 2018 at 10:43:28AM +0200, Dietmar Eggemann wrote:
>> On 07/11/2018 01:09 AM, Joel Fernandes wrote:
>>> On Mon, Jul 09, 2018 at 05:47:53PM +0100, Dietmar Eggemann wrote:
>>>> A CFS (SCHED_OTHER, SCHED_BATCH or SCHED_IDLE policy) task's
>>>> se->runnable_weight must always be in sync with its se->load.weight.
>>>>
>>>> se->runnable_weight is set to se->load.weight when the task is
>>>> forked (init_entity_runnable_average()) or reniced (reweight_entity()).
>>>>
>>>> There are two cases in set_load_weight() which since they currently only
>>>> set se->load.weight could lead to a situation in which se->load.weight
>>>> is different to se->runnable_weight for a CFS task:
>>>>
>>>> (1) A task switches to SCHED_IDLE.
>>>>
>>>> (2) A SCHED_FIFO, SCHED_RR or SCHED_DEADLINE task which has been reniced
>>>>       (during which only its static priority gets set) switches to
>>>>       SCHED_OTHER or SCHED_BATCH.
>>>>
>>>> Set se->runnable_weight to se->load.weight in these two cases to prevent
>>>> this. This eliminates the need to explicitly set it to se->load.weight
>>>> during PELT updates in the CFS scheduler fastpath.
>>>
>>> Looks good to me. By the way just asking, is there a chance where
>>> se_weight(se) and se_runnable(se) can ever be different?
>>
>> Yes they can be different, not for a task though but for se's representing
>> task groups. It got introduced to be able to propagate load and runnable
>> load independently through the task groups hierarchies.
> 
> I know that task-group se has different values. I was saying for task ses,
> the extra division can be skipped possibly improving performance (if at all).

Ah, OK, I didn't pay attention to the '... if the sa belongs to the 
task:' part.

Since ___update_load_sum() is either called with !!se->on_rq or 0 for 
both ('load' and 'runnable'), sa->load_sum and sa->runnable_load_sum 
should be equal for a task.

And since se_weight(se) and se_runnable(se) for 'load' and 'runnable' of 
___update_load_avg() are the same for a task, sa->load_avg and 
sa->runnable_load_avg should be also equal for a task.

You would have to pass the information that sa belongs to a se and not 
to a cfs_rq into ___update_load_avg() though to be able to use 
entity_is_task().

[...]
