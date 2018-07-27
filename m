Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802862088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802862088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbeG0Q6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:58:30 -0400
Received: from foss.arm.com ([217.140.101.70]:45178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388309AbeG0Q6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:58:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A522ED1;
        Fri, 27 Jul 2018 08:36:04 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 592403F6A8;
        Fri, 27 Jul 2018 08:36:02 -0700 (PDT)
Date:   Fri, 27 Jul 2018 16:35:59 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Galbraith <efault@gmx.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v3] arm64: fpsimd: use preemp_disable in addition to
 local_bh_disable()
Message-ID: <20180727153559.GA4240@e103592.cambridge.arm.com>
References: <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
 <20180726150634.cl3wccqur6qhle6p@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726150634.cl3wccqur6qhle6p@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:06:34PM +0200, Sebastian Andrzej Siewior wrote:
> In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> code disables BH and expects that it is not preemptible. On -RT the
> task remains preemptible but remains the same CPU. This may corrupt the
> content of the SIMD registers if the task is preempted during
> saving/restoring those registers.
> 
> Add preempt_disable()/enable() to enfore the required semantic on -RT.

Does this supersede the local_lock based approach?

That would have been nice to have, but if there are open questions about
how to do it then I guess something like this patch makes sense as a
stopgap solution.

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> This should work. Compiling currently gcc-6 on the box to see what
> happens. Since the crypto disables preemption "frequently" and I don't
> expect or see anything to worry about.
> 
>  arch/arm64/kernel/fpsimd.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -157,6 +157,15 @@ static void sve_free(struct task_struct
>  	__sve_free(task);
>  }
>  
> +static void *sve_free_atomic(struct task_struct *task)
> +{
> +	void *sve_state = task->thread.sve_state;
> +
> +	WARN_ON(test_tsk_thread_flag(task, TIF_SVE));
> +
> +	task->thread.sve_state = NULL;
> +	return sve_state;
> +}

This feels a bit excessive.  Since there's only one call site, I'd
prefer if the necessary code were simply inlined.  We wouldn't need the
WARN either in that case, since (IIUC) it's only there to check for
accidental misuse of this helper.

>  /* Offset of FFR in the SVE register dump */
>  static size_t sve_ffr_offset(int vl)
> @@ -594,6 +603,7 @@ int sve_set_vector_length(struct task_st
>  	 * non-SVE thread.
>  	 */
>  	if (task == current) {
> +		preempt_disable();
>  		local_bh_disable();
>  
>  		task_fpsimd_save();
> @@ -604,8 +614,10 @@ int sve_set_vector_length(struct task_st
>  	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
>  		sve_to_fpsimd(task);
>  
> -	if (task == current)
> +	if (task == current) {
>  		local_bh_enable();
> +		preempt_enable();
> +	}
>  
>  	/*
>  	 * Force reallocation of task SVE state to the correct size
> @@ -837,6 +849,7 @@ asmlinkage void do_sve_acc(unsigned int
>  
>  	sve_alloc(current);
>  
> +	preempt_disable();
>  	local_bh_disable();

I think we should have local helpers for the preempt+local_bh
maintenance, since they're needed all over the place in this
file.

[...]

Cheers
---Dave
