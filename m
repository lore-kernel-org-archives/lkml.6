Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbeDZNLZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:11:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52854 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755671AbeDZNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:11:23 -0400
X-Google-Smtp-Source: AB8JxZpT6QpOmOW7qEwAKaMW4AMnTGCRlaabGzFA9kcOp6cg6+utESYQr7dH8iVk9dqBxeSO4hasr9/S+eoAzHhUK6w=
MIME-Version: 1.0
In-Reply-To: <20180426114956.GJ4064@hirez.programming.kicks-ass.net>
References: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org> <20180426114956.GJ4064@hirez.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Apr 2018 15:11:02 +0200
Message-ID: <CAKfTPtAT6khrY=3yfZdntG6ZEkYx9dg9yjEYtbcEcaxa3KU7DA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: use RETRY_TASK in idle_balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 April 2018 at 13:49, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Apr 26, 2018 at 12:37:02PM +0200, Vincent Guittot wrote:
>> Use RETRY_TASK in idle_balance when we want select_task_rq() function to
>> rerun the complete task selection path
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>  kernel/sched/fair.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0951d1c..ba49f83 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9862,7 +9862,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>>
>>       /* Is there a task of a high priority class? */
>>       if (this_rq->nr_running != this_rq->cfs.h_nr_running)
>> -             pulled_task = -1;
>> +             pulled_task = RETRY_TASK;
>
> This doesn't make sense, pulled_task is an integer, not a task pointer.
> Also see how the caller in select_task_rq_fair() converts a negative
> into RETRY_TASK.

My goal was to try to make it a bit more readable about the meaning of
-1 but it fails with the type returned by idle_balance
