Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F9BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CA620850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CA620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLCKDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:03:50 -0500
Received: from foss.arm.com ([217.140.101.70]:33136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbeLCKDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:03:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1297280D;
        Mon,  3 Dec 2018 02:03:29 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0AA03F59C;
        Mon,  3 Dec 2018 02:03:27 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix assignment of boolean variables
To:     Peter Zijlstra <peterz@infradead.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Patrick Bellasi <Patrick.Bellasi@arm.com>
References: <20181201090936.10175-1-wen.yang99@zte.com.cn>
 <20181203083329.GG11614@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c586c0cb-d867-4b01-e8d0-eea65b1b62ba@arm.com>
Date:   Mon, 3 Dec 2018 10:03:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203083329.GG11614@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 08:33, Peter Zijlstra wrote:
> On Sat, Dec 01, 2018 at 05:09:36PM +0800, Wen Yang wrote:
>> Fix the following warnings reported by coccinelle:
>> kernel//sched/fair.c:7958:3-12: WARNING: Assignment of bool to 0/1
>>

Duh, Patrick raised that one to me last week but I got caught up in other
things. I realized I could keep the local 'overload' as bool in

    575638d1047e ("sched/core: Change root_domain->overload type to int")

but probably forgot to update 

    757ffdd705ee ("sched/fair: Set rq->rd->overload when misfit")

accordingly.

>> This also makes the code more readable.
> 
> I disagree; anybody that has trouble with 0/1 vs false/true needs to
> stay away from C.
> 
>> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: linux-kernel@vger.kernel.org
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a2e8160968cb..f19aa66f9b15 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7955,7 +7955,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>  		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
>>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>>  			sgs->group_misfit_task_load = rq->misfit_task_load;
>> -			*overload = 1;
>> +			*overload = true;
>>  		}
>>  	}
>>  
> 
> Anyway, this code is going away anyway:
> 
>   https://lkml.kernel.org/r/20181119141857.8625-12-quentin.perret@arm.com
> 
