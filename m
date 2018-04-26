Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754956AbeDZI5f (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:57:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754539AbeDZI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:57:32 -0400
Date: Thu, 26 Apr 2018 10:57:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gaurav Kohli <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180426085719.GW4129@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426084131.GV4129@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 10:41:31AM +0200, Peter Zijlstra wrote:
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index cd50e99202b0..4b6503c6a029 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -177,12 +177,13 @@ void *kthread_probe_data(struct task_struct *task)
>  
>  static void __kthread_parkme(struct kthread *self)
>  {
> -	__set_current_state(TASK_PARKED);
> -	while (test_bit(KTHREAD_SHOULD_PARK, &self->flags)) {
> +	for (;;) {
> +		__set_task_state(TASK_PARKED);

		set_current_state(TASK_PARKED);

of course..

> +		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
> +			break;
>  		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
>  			complete(&self->parked);
>  		schedule();
> -		__set_current_state(TASK_PARKED);
>  	}
>  	clear_bit(KTHREAD_IS_PARKED, &self->flags);
>  	__set_current_state(TASK_RUNNING);
> 
