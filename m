Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C09C18E01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8657C2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5Lzqv/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8657C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeKUAYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:24:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKUAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f4caVRl1YSFu92WRfBk2pZCc3fhCI/oytYx9ZPmT6d0=; b=n5Lzqv/KKtzAvjQTqyazlr3Dl
        beXEgrkW1IXcMpW76Zn4riDYe8V33wLN6rPAX0e9LR9vibJqeyt1t9wLSmI/f7W/9vjaxhZWw6Uyr
        UxDFbj4hZWHYFs9Zxj5ss9+7ap24TxZ7DuRjpECYJkaytfGqgH2LW6YqNp2YSaNwJpbEevMdQgoqc
        vCrAGefWtOAO9H9mmEe0WYuFMCk5Z97VzFN071a5dpZxmDj0jx9KHgcHRs7vuqBOyEKg+abFy2BfD
        psAqvoglJ/JeIn6oGWpiHH2uaDa1W05RPdK2WSiv1W/s0ANPKvnPNLFZB05b4Zdbfs9iVw7zmPST2
        iwDKAOk3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP6UW-0008FI-Sx; Tue, 20 Nov 2018 13:55:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 709D42029F87F; Tue, 20 Nov 2018 14:54:59 +0100 (CET)
Date:   Tue, 20 Nov 2018 14:54:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 08/25] vtime: Exit vtime before exit_notify()
Message-ID: <20181120135459.GR2131@hirez.programming.kicks-ass.net>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-9-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542163569-20047-9-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 03:45:52AM +0100, Frederic Weisbecker wrote:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d458d65..27e0544 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -265,6 +265,8 @@ struct task_cputime {
>  enum vtime_state {
>  	/* Task is sleeping or running in a CPU with VTIME inactive: */
>  	VTIME_INACTIVE = 0,
> +	/* Task has passed exit_notify() */
> +	VTIME_DEAD,

How does it make sense for VTIME_DEAD > VTIME_INACTIVE ?

>  	/* Task is idle */
>  	VTIME_IDLE,
>  	/* Task runs in kernelspace in a CPU with VTIME active: */


> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index f64afd7..a0c3a82 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -813,17 +813,31 @@ void vtime_task_switch_generic(struct task_struct *prev)
>  {
>  	struct vtime *vtime = &prev->vtime;
>  
> -	write_seqcount_begin(&vtime->seqcount);
> -	if (vtime->state == VTIME_IDLE)
> -		vtime_account_idle(prev);
> -	else
> -		__vtime_account_kernel(prev, vtime);
> -	vtime->state = VTIME_INACTIVE;
> -	vtime->cpu = -1;
> -	write_seqcount_end(&vtime->seqcount);
> +	/*
> +	 * Flush the prev task vtime, unless it has passed
> +	 * vtime_exit_task(), in which case there is nothing
> +	 * left to account.
> +	 */
> +	if (vtime->state != VTIME_DEAD) {
> +		write_seqcount_begin(&vtime->seqcount);
> +		if (vtime->state == VTIME_IDLE)
> +			vtime_account_idle(prev);
> +		else
> +			__vtime_account_kernel(prev, vtime);
> +		vtime->state = VTIME_INACTIVE;
> +		vtime->cpu = -1;
> +		write_seqcount_end(&vtime->seqcount);
> +	}
>  
>  	vtime = &current->vtime;
>  
> +	/*
> +	 * Ignore the next task if it has been preempted after
> +	 * vtime_exit_task().
> +	 */
> +	if (vtime->state == VTIME_DEAD)
> +		return;
> +
>  	write_seqcount_begin(&vtime->seqcount);
>  	if (is_idle_task(current))
>  		vtime->state = VTIME_IDLE;

Bit inconsistent; having the one as a indent and the other as an early
return.

> @@ -850,6 +864,30 @@ void vtime_init_idle(struct task_struct *t, int cpu)
>  	local_irq_restore(flags);
>  }
>  
> +/*
> + * This is the final settlement point after which we don't account
> + * anymore vtime for this task.
> + */
> +void vtime_exit_task(struct task_struct *t)
> +{
> +	struct vtime *vtime = &t->vtime;
> +	unsigned long flags;

Note that the code in vtime_task_switch_generic() (above) relies on @t
== current (which is true, but not explicit).

> +	local_irq_save(flags);
> +	write_seqcount_begin(&vtime->seqcount);
> +	/*
> +	 * A task that has never run on a nohz_full CPU hasn't
> +	 * been tracked by vtime. Thus it's in VTIME_INACTIVE
> +	 * state. Nothing to account for it.
> +	 */
> +	if (vtime->state != VTIME_INACTIVE)
> +		vtime_account_system(t, vtime);
> +	vtime->state = VTIME_DEAD;
> +	vtime->cpu = -1;
> +	write_seqcount_end(&vtime->seqcount);
> +	local_irq_restore(flags);
> +}
> +
>  u64 task_gtime(struct task_struct *t)
>  {
>  	struct vtime *vtime = &t->vtime;
> -- 
> 2.7.4
> 
