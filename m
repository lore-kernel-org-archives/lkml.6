Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F432C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6CA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ku9KSx0H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N4J2fqWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6CA20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeFTGko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:40:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeFTGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:40:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 065D060B14; Wed, 20 Jun 2018 06:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529476841;
        bh=/9EMCqZH/S5oC88qbwmef+VBEBcgapUkLVNWbxGYR1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ku9KSx0HXsaJT6h+QO+6lH+R8hWEfeQMbp1eZcYPVeQzT0taYpg00NluYlzWO8gWs
         3YiBkMc5g53e54dJuFfUgriNzeG1ks9SrHgm9Y3+UNcJ6LpASaM6HTfOmPDjLS6SAF
         BeNBk58tOJM0IE4qCeTRLQ4SyCocJH69AIQ8aFP4=
Received: from [10.204.78.68] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 125D3605FF;
        Wed, 20 Jun 2018 06:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529476836;
        bh=/9EMCqZH/S5oC88qbwmef+VBEBcgapUkLVNWbxGYR1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N4J2fqWEhpGhhlZdMhl6AAN/mLF0ubjr2vNXv4aYScf4A6WSRKSjQfbXb4YA9f3NR
         16zmza+aleMRpwY2iSj9/GCpjc/pMZBRfP3c71dXJJwVmPD4+guWZH9I7/am4CgXSV
         6qGqSQo7/0UP+BP7219SnBtKQCpWR4mfZPukpuLQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 125D3605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH 4.16 161/279] kthread, sched/wait: Fix kthread_parkme()
 completion issue
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180618080608.851973560@linuxfoundation.org>
 <20180618080615.492002239@linuxfoundation.org>
From:   "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <7ef9ee41-877b-0cc3-bd2d-f495b1d354bb@codeaurora.org>
Date:   Wed, 20 Jun 2018 12:10:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618080615.492002239@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As more patches related to this are coming in 4.17, so it is better if 
all go together on different branches, plz suggest.

Regards
Gaurav

On 6/18/2018 1:42 PM, Greg Kroah-Hartman wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Peter Zijlstra <peterz@infradead.org>
> 
> [ Upstream commit 85f1abe0019fcb3ea10df7029056cf42702283a8 ]
> 
> Even with the wait-loop fixed, there is a further issue with
> kthread_parkme(). Upon hotplug, when we do takedown_cpu(),
> smpboot_park_threads() can return before all those threads are in fact
> blocked, due to the placement of the complete() in __kthread_parkme().
> 
> When that happens, sched_cpu_dying() -> migrate_tasks() can end up
> migrating such a still runnable task onto another CPU.
> 
> Normally the task will have hit schedule() and gone to sleep by the
> time we do kthread_unpark(), which will then do __kthread_bind() to
> re-bind the task to the correct CPU.
> 
> However, when we loose the initial TASK_PARKED store to the concurrent
> wakeup issue described previously, do the complete(), get migrated, it
> is possible to either:
> 
>   - observe kthread_unpark()'s clearing of SHOULD_PARK and terminate
>     the park and set TASK_RUNNING, or
> 
>   - __kthread_bind()'s wait_task_inactive() to observe the competing
>     TASK_RUNNING store.
> 
> Either way the WARN() in __kthread_bind() will trigger and fail to
> correctly set the CPU affinity.
> 
> Fix this by only issuing the complete() when the kthread has scheduled
> out. This does away with all the icky 'still running' nonsense.
> 
> The alternative is to promote TASK_PARKED to a special state, this
> guarantees wait_task_inactive() cannot observe a 'stale' TASK_RUNNING
> and we'll end up doing the right thing, but this preserves the whole
> icky business of potentially migating the still runnable thing.
> 
> Reported-by: Gaurav Kohli <gkohli@codeaurora.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   include/linux/kthread.h |    1 +
>   kernel/kthread.c        |   43 +++++++++++++++++++------------------------
>   kernel/sched/core.c     |   32 +++++++++++++++++++++-----------
>   3 files changed, 41 insertions(+), 35 deletions(-)
> 
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -62,6 +62,7 @@ void *kthread_probe_data(struct task_str
>   int kthread_park(struct task_struct *k);
>   void kthread_unpark(struct task_struct *k);
>   void kthread_parkme(void);
> +void kthread_park_complete(struct task_struct *k);
>   
>   int kthreadd(void *unused);
>   extern struct task_struct *kthreadd_task;
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -55,7 +55,6 @@ enum KTHREAD_BITS {
>   	KTHREAD_IS_PER_CPU = 0,
>   	KTHREAD_SHOULD_STOP,
>   	KTHREAD_SHOULD_PARK,
> -	KTHREAD_IS_PARKED,
>   };
>   
>   static inline void set_kthread_struct(void *kthread)
> @@ -181,11 +180,8 @@ static void __kthread_parkme(struct kthr
>   		set_current_state(TASK_PARKED);
>   		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>   			break;
> -		if (!test_and_set_bit(KTHREAD_IS_PARKED, &self->flags))
> -			complete(&self->parked);
>   		schedule();
>   	}
> -	clear_bit(KTHREAD_IS_PARKED, &self->flags);
>   	__set_current_state(TASK_RUNNING);
>   }
>   
> @@ -195,6 +191,11 @@ void kthread_parkme(void)
>   }
>   EXPORT_SYMBOL_GPL(kthread_parkme);
>   
> +void kthread_park_complete(struct task_struct *k)
> +{
> +	complete(&to_kthread(k)->parked);
> +}
> +
>   static int kthread(void *_create)
>   {
>   	/* Copy data: it's on kthread's stack */
> @@ -451,22 +452,15 @@ void kthread_unpark(struct task_struct *
>   {
>   	struct kthread *kthread = to_kthread(k);
>   
> -	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
>   	/*
> -	 * We clear the IS_PARKED bit here as we don't wait
> -	 * until the task has left the park code. So if we'd
> -	 * park before that happens we'd see the IS_PARKED bit
> -	 * which might be about to be cleared.
> +	 * Newly created kthread was parked when the CPU was offline.
> +	 * The binding was lost and we need to set it again.
>   	 */
> -	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
> -		/*
> -		 * Newly created kthread was parked when the CPU was offline.
> -		 * The binding was lost and we need to set it again.
> -		 */
> -		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
> -			__kthread_bind(k, kthread->cpu, TASK_PARKED);
> -		wake_up_state(k, TASK_PARKED);
> -	}
> +	if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
> +		__kthread_bind(k, kthread->cpu, TASK_PARKED);
> +
> +	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> +	wake_up_state(k, TASK_PARKED);
>   }
>   EXPORT_SYMBOL_GPL(kthread_unpark);
>   
> @@ -489,12 +483,13 @@ int kthread_park(struct task_struct *k)
>   	if (WARN_ON(k->flags & PF_EXITING))
>   		return -ENOSYS;
>   
> -	if (!test_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
> -		set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> -		if (k != current) {
> -			wake_up_process(k);
> -			wait_for_completion(&kthread->parked);
> -		}
> +	if (WARN_ON_ONCE(test_bit(KTHREAD_SHOULD_PARK, &kthread->flags)))
> +		return -EBUSY;
> +
> +	set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> +	if (k != current) {
> +		wake_up_process(k);
> +		wait_for_completion(&kthread->parked);
>   	}
>   
>   	return 0;
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -30,6 +30,8 @@
>   #include <linux/syscalls.h>
>   #include <linux/sched/isolation.h>
>   
> +#include <linux/kthread.h>
> +
>   #include <asm/switch_to.h>
>   #include <asm/tlb.h>
>   #ifdef CONFIG_PARAVIRT
> @@ -2733,20 +2735,28 @@ static struct rq *finish_task_switch(str
>   		membarrier_mm_sync_core_before_usermode(mm);
>   		mmdrop(mm);
>   	}
> -	if (unlikely(prev_state == TASK_DEAD)) {
> -		if (prev->sched_class->task_dead)
> -			prev->sched_class->task_dead(prev);
> +	if (unlikely(prev_state & (TASK_DEAD|TASK_PARKED))) {
> +		switch (prev_state) {
> +		case TASK_DEAD:
> +			if (prev->sched_class->task_dead)
> +				prev->sched_class->task_dead(prev);
> +
> +			/*
> +			 * Remove function-return probe instances associated with this
> +			 * task and put them back on the free list.
> +			 */
> +			kprobe_flush_task(prev);
>   
> -		/*
> -		 * Remove function-return probe instances associated with this
> -		 * task and put them back on the free list.
> -		 */
> -		kprobe_flush_task(prev);
> +			/* Task is done with its stack. */
> +			put_task_stack(prev);
>   
> -		/* Task is done with its stack. */
> -		put_task_stack(prev);
> +			put_task_struct(prev);
> +			break;
>   
> -		put_task_struct(prev);
> +		case TASK_PARKED:
> +			kthread_park_complete(prev);
> +			break;
> +		}
>   	}
>   
>   	tick_nohz_task_switch();
> 
> 

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
