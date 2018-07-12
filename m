Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D08ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D611021486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D611021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbeGLVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732383AbeGLVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:33:59 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A060213A2;
        Thu, 12 Jul 2018 21:22:33 +0000 (UTC)
Date:   Thu, 12 Jul 2018 17:22:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH 1/2] lib: Add module for testing preemptoff/irqsoff
 latency tracers
Message-ID: <20180712172232.00e4c01e@gandalf.local.home>
In-Reply-To: <20180711063540.91101-2-joel@joelfernandes.org>
References: <20180711063540.91101-1-joel@joelfernandes.org>
        <20180711063540.91101-2-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 23:35:39 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> 
> Co-developed-by: Erick Reyes <erickreyes@google.com>

A co-developer needs to add their signed off by. To specify that Erick
is a co-author, you could do:

[ Erick is a co-developer of this commit ]
Signed-off-by: Add Erick's SOB here.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/trace/Kconfig                 | 15 ++++++
>  kernel/trace/Makefile                |  1 +
>  kernel/trace/preemptirq_delay_test.c | 72 ++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 kernel/trace/preemptirq_delay_test.c
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 8d51351e3149..eb5ab6b511e2 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -699,6 +699,21 @@ config RING_BUFFER_STARTUP_TEST
>  
>  	 If unsure, say N
>  
> +config PREEMPTIRQ_DELAY_TEST
> +	tristate "Preempt / IRQ disable delay thread to test latency tracers"
> +	depends on m
> +	help
> +	  Select this option to build a test module that can help test latency
> +	  tracers by executing a preempt or irq disable section with a user
> +	  configurable delay. The module busy waits for the duration of the
> +	  critical section.
> +
> +	  For example, the following invocation forces a one-time irq-disabled
> +	  critical section for 500us:
> +	  modprobe preemptirq_delay_test test_mode=irq delay=500000
> +
> +	  If unsure, say N
> +
>  config TRACE_EVAL_MAP_FILE
>         bool "Show eval mappings for trace events"
>         depends on TRACING
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 84a0cb222f20..677540bb1b62 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_TRACING_MAP) += tracing_map.o
>  obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
>  obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
>  obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
> +obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
>  obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
>  obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
>  obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
> new file mode 100644
> index 000000000000..c97a026c0720
> --- /dev/null
> +++ b/kernel/trace/preemptirq_delay_test.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Preempt / IRQ disable delay thread to test latency tracers
> + *
> + * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/kthread.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>
> +
> +static ulong delay = 100;
> +static char test_mode[10] = "irq";
> +
> +module_param_named(delay, delay, ulong, S_IRUGO);
> +module_param_string(test_mode, test_mode, 10, S_IRUGO);
> +MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
> +MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
> +
> +static void busy_wait(ulong time)
> +{
> +	ktime_t start, end;
> +	start = ktime_get();
> +	do {
> +		end = ktime_get();
> +		if (kthread_should_stop())
> +			break;
> +	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
> +}
> +
> +int preemptirq_delay_run(void *data)
> +{
> +	unsigned long flags;
> +
> +	if (!strcmp(test_mode, "irq")) {
> +		local_irq_save(flags);
> +		busy_wait(delay);
> +		local_irq_restore(flags);
> +	} else if (!strcmp(test_mode, "preempt")) {
> +		preempt_disable();
> +		busy_wait(delay);
> +		preempt_enable();
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init preemptirq_delay_init(void)
> +{
> +	char task_name[50];
> +	struct task_struct *test_task;
> +
> +	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
> +
> +	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
> +	return PTR_ERR_OR_ZERO(test_task);
> +}
> +
> +static void __exit preemptirq_delay_exit(void)
> +{
> +	return;
> +}
> +
> +module_init(preemptirq_delay_init)
> +module_exit(preemptirq_delay_exit)
> +MODULE_LICENSE("GPL v2");

