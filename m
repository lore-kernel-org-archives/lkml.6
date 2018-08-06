Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BFAC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8065621A3A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc6Xgr4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8065621A3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeHFQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbeHFQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:14:56 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F6421A34;
        Mon,  6 Aug 2018 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533564340;
        bh=9gGrIi8dWYj25wd843ZKxaqaU70mPpGD2hdXizsph4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vc6Xgr4MYJGF/eTrx2+9QOJW6hjU/ayl59MMnoAMSwuEUIsIYKkuAjWkdXnHsQFsX
         1sjhUNp/wkk26E7M7YEfNvncLkRlNA4wcSJt+jIk6HzWuLjMyXrT2bBRc9T9+vRLGK
         p0iHESfQ5ULSxYhv7T2/LbF+2YUKFVctZ1g+i//8=
Date:   Mon, 6 Aug 2018 23:05:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        paulmck@linux.vnet.ibm.com, mathieu.desnoyers@efficios.com,
        namhyung@kernel.org, peterz@infradead.org
Subject: Re: [PATCH ftrace/core] tracing: irqsoff: Account for additional
 preempt_disable
Message-Id: <20180806230536.ef217b2c2c008838606bedc3@kernel.org>
In-Reply-To: <20180806034049.67949-1-joel@joelfernandes.org>
References: <20180806034049.67949-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Aug 2018 20:40:49 -0700
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> Recently we tried to make the preemptirqsoff tracer to use irqsoff
> tracepoint probes. However this causes issues as reported by Masami:
> 
> [2.271078] Testing tracer preemptirqsoff: .. no entries found ..FAILED!
> [2.381015] WARNING: CPU: 0 PID: 1 at /home/mhiramat/ksrc/linux/kernel/
> trace/trace.c:1512 run_tracer_selftest+0xf3/0x154
> 
> This is due to the tracepoint code increasing the preempt nesting count
> by calling an additional preempt_disable before calling into the
> preemptoff tracer which messes up the preempt_count() check in
> tracer_hardirqs_off.
> 
> To fix this, make the irqsoff tracer probes balance the additional outer
> preempt_disable with a preempt_enable_notrace.

I've tested it and ensured this fixes the problem.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

And I have a comment on this code.

> 
> The other way to fix this is to just use SRCU for all tracepoints.
> However we can't do that because we can't use NMIs from RCU context.
> 
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints
>                       and unify their usage")
> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> index 770cd30cda40..ffbf1505d5bc 100644
> --- a/kernel/trace/trace_irqsoff.c
> +++ b/kernel/trace/trace_irqsoff.c
> @@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
>   */
>  static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
>  {

To ensure this function must not be preempted even if we increment preempt
count, I think you should check irq_disabled() whole this process, put below
here.

	if (unlikely(!irq_disabled()))
		return;

Since irq_disabled() will be checked in irq_trace() anyway, so no problem
to return here when !irq_disabled().

> +	/*
> +	 * Tracepoint probes are expected to be called with preempt disabled,
> +	 * We don't care about being called with preempt disabled but we need
> +	 * to know in the future if that changes so we can remove the next
> +	 * preempt_enable.
> +	 */
> +	WARN_ON_ONCE(!preempt_count());
> +
> +	/* Tracepoint probes disable preemption atleast once, account for that */

	 * Even we do this here, we are sure that irq is disabled in this context.
	 * which means preemption is kept disabled.

> +	preempt_enable_notrace();
> +
>  	if (!preempt_trace() && irq_trace())
>  		stop_critical_timing(a0, a1);
> +
> +	preempt_disable_notrace();
>  }
>  
>  static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
>  {

Same here.


Any though :) ?

Thank you,

> +	/*
> +	 * Tracepoint probes are expected to be called with preempt disabled,
> +	 * We don't care about being called with preempt disabled but we need
> +	 * to know in the future if that changes so we can remove the next
> +	 * preempt_enable.
> +	 */
> +	WARN_ON_ONCE(!preempt_count());
> +
> +	/* Tracepoint probes disable preemption atleast once, account for that */
> +	preempt_enable_notrace();
> +
>  	if (!preempt_trace() && irq_trace())
>  		start_critical_timing(a0, a1);
> +
> +	preempt_disable_notrace();
>  }
>  
>  static int irqsoff_tracer_init(struct trace_array *tr)
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
