Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C9C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6E9208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6E9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeGJOUz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933280AbeGJOUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:20:54 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EC2208E5;
        Tue, 10 Jul 2018 14:20:52 +0000 (UTC)
Date:   Tue, 10 Jul 2018 10:20:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180710102050.78ae0ea8@gandalf.local.home>
In-Reply-To: <20180628182149.226164-6-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-6-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 11:21:47 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
> new file mode 100644
> index 000000000000..dc01c7f4d326
> --- /dev/null
> +++ b/kernel/trace/trace_preemptirq.c
> @@ -0,0 +1,71 @@

Can you send a patch on top of this, that adds a SPDX header here. Just
add another patch, no need to resend this one.

I need to go through all the files in kernel/trace/* and add SPDX
headers. I don't want to add more files that don't have them.

I'm still playing around with this patch, and testing it.

-- Steve

> +/*
> + * preemptoff and irqoff tracepoints
> + *
> + * Copyright (C) Joel Fernandes (Google) <joel@joelfernandes.org>
> + */
> +
> +#include <linux/kallsyms.h>
> +#include <linux/uaccess.h>
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/preemptirq.h>
> +
> +#ifdef CONFIG_TRACE_IRQFLAGS
> +/* Per-cpu variable to prevent redundant calls when IRQs already off */
> +static DEFINE_PER_CPU(int, tracing_irq_cpu);
> +
> +void trace_hardirqs_on(void)
> +{
> +	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
> +		return;
> +
> +	trace_irq_enable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +	this_cpu_write(tracing_irq_cpu, 0);
> +}
> +EXPORT_SYMBOL(trace_hardirqs_on);
> +
> +void trace_hardirqs_off(void)
> +{
> +	if (lockdep_recursing(current) || this_cpu_read(tracing_irq_cpu))
> +		return;
> +
> +	this_cpu_write(tracing_irq_cpu, 1);
> +	trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
> +}
> +EXPORT_SYMBOL(trace_hardirqs_off);
> +
> +__visible void trace_hardirqs_on_caller(unsigned long caller_addr)
> +{
> +	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
> +		return;
> +
> +	trace_irq_enable_rcuidle(CALLER_ADDR0, caller_addr);
> +	this_cpu_write(tracing_irq_cpu, 0);
> +}
> +EXPORT_SYMBOL(trace_hardirqs_on_caller);
> +
> +__visible void trace_hardirqs_off_caller(unsigned long caller_addr)
> +{
> +	if (lockdep_recursing(current) || this_cpu_read(tracing_irq_cpu))
> +		return;
> +
> +	this_cpu_write(tracing_irq_cpu, 1);
> +	trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
> +}
> +EXPORT_SYMBOL(trace_hardirqs_off_caller);
> +#endif /* CONFIG_TRACE_IRQFLAGS */
> +
> +#ifdef CONFIG_TRACE_PREEMPT_TOGGLE
> +
> +void trace_preempt_on(unsigned long a0, unsigned long a1)
> +{
> +	trace_preempt_enable_rcuidle(a0, a1);
> +}
> +
> +void trace_preempt_off(unsigned long a0, unsigned long a1)
> +{
> +	trace_preempt_disable_rcuidle(a0, a1);
> +}
> +#endif

