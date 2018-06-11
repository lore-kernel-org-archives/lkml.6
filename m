Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k7ctNwM1HlscGQAAmS7hNA
	; Mon, 11 Jun 2018 08:39:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E07D60792; Mon, 11 Jun 2018 08:39:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ov6e4klw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CEF160385;
	Mon, 11 Jun 2018 08:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CEF160385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932420AbeFKIjE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:39:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57212 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sXxPHjiZcFYjtpYWBjo0pYNMaDUeKkat7J5qPMjKtg8=; b=Ov6e4klw0lsYv2RLOrD7iJM/PU
        HVG0sNhEmlLdfK1gJQ6WvvFEUgxoGRCqeRi4Zbg+7u9efXXyESoQjQBkduaX2+POSBHJ23BLdLXjU
        rfXHdNyUfqi5cuyjC+oyFhNLKJGemI7Xspjx2qJxffKura/hrqxEJHzh0RYv/iajsI+aWHq/04plJ
        MB8DR5WEaP3Og83GE+0c6ZZPPxv7DdPCG0RRIhrsalqUmB/PsEw79eoWRVicGoWgiJuwKBw4Ee1O/
        o59SY014hCwop2q0Q/PotCSfJkx3zPgSXDtdjeCyEf3/mH4VmKQHlyj3lMnwcepCFWvaxRnmlMdZc
        3HZ+zUDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSILq-0005DX-IU; Mon, 11 Jun 2018 08:38:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 365A8201EA7A6; Mon, 11 Jun 2018 10:38:57 +0200 (CEST)
Date: Mon, 11 Jun 2018 10:38:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] sched/core: Consider afffinity constrain when yield
 to a task
Message-ID: <20180611083857.GL12217@hirez.programming.kicks-ass.net>
References: <1528702730-7538-1-git-send-email-wanpengli@tencent.com>
 <1528702730-7538-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528702730-7538-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 03:38:50PM +0800, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Consider the task afffinity constrain when yield to a task.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 092f7c4..11001ff 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5102,6 +5102,9 @@ int __sched yield_to(struct task_struct *p, bool preempt)
>  	if (task_running(p_rq, p) || p->state)
>  		goto out_unlock;
>  
> +	if (!cpumask_test_cpu(smp_processor_id(), &p->cpus_allowed))
> +		goto out_unlock;
> +
>  	yielded = curr->sched_class->yield_to_task(rq, p, preempt);
>  	if (yielded) {
>  		schedstat_inc(rq->yld_count);

I'm confused... why?

So yield_to(@p) is documented as yielding @curr and getting @p to run
'sooner'. If they're on the same rq, yay, that means we'll likely switch
from @curr to @p, however if they're not on the same rq, it should still
work, except we'll reschedule 2 CPUs.

Look at the code, yield_to() will lock 2 rqs: rq and p_rq.

First if verifies p_rq == task_rq(p) (p could've been migrated while we
were waiting to acquire the lock) if this is not so, we unlock and try
again.

Then we check trivial things like actually having a ->yield_to and @curr
and @p being of the same class.

Then we check if @p is in fact already running or not runnable at all,
if either, obviously nothing to do.

So now, we have rq and p_rq locked, they need not be the same and we'll
call ->yield_to(), on success we'll force reschedule p_rq, unlock the
rqs and reschedule ourself.

So far, nothing requires @p to be runnable on the current CPU.

So let us look at yield_to_task_fair() the only yield_to implementation:

That again checks if @p is in fact runnable, if not, nothing to do.

Then it calls set_next_buddy(&p->se), which will mark @p more likely to
get picked on its rq (p_rq) _not_ our rq. Note how set_next_buddy() uses
cfs_rq_of().

Then it yields @curr on the current cpu.


Again, nothing cares if @curr and @p are on the same CPU and if @curr is
allowed to run on the current CPU -- there are no migrations.


So.. why?!
