Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F711C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8796420661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 04:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8796420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeICIpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 04:45:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeICIpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 04:45:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A38A680D;
        Sun,  2 Sep 2018 21:27:17 -0700 (PDT)
Received: from [192.168.1.76] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E143F575;
        Sun,  2 Sep 2018 21:27:16 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: fix vruntime_normalized for remote
 non-migration wakeup
To:     Steve Muckle <smuckle@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Miguel de Dios <migueldedios@google.com>,
        John Dias <joaodias@google.com>
References: <20180831224217.169476-1-smuckle@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bb8f4581-20e1-772b-7c98-98ba22443a45@arm.com>
Date:   Sun, 2 Sep 2018 21:27:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831224217.169476-1-smuckle@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 03:42 PM, Steve Muckle wrote:
> When a task which previously ran on a given CPU is remotely queued to
> wake up on that same CPU, there is a period where the task's state is
> TASK_WAKING and its vruntime is not normalized. This is not accounted
> for in vruntime_normalized() which will cause an
> error in the task's vruntime if it is switched from the fair class
> during this time, for example if it is boosted to RT priority via
> rt_mutex_setprio. The rq's min_vruntime will not be subtracted from the
> task's vruntime but it will be added again when the task returns to the
> fair class. The task's vruntime will have been erroneously doubled and
> the effective priority of the task will be reduced.
> 
> Note this will also lead to inflation of all vruntimes since the doubled
> vruntime value will become the rq's min_vruntime when other tasks leave
> the rq. This leads to repeated doubling of the vruntime and priority
> penalty.
> 
> Fix this by recognizing a WAKING task's vruntime as normalized only if
> sched_remote_wakeup is true. This indicates a migration, in which case
> the vruntime would have been normalized in migrate_task_rq_fair().
> 
> Based on a similar patch from joaodias@google.com.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>   kernel/sched/fair.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
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
> 

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
