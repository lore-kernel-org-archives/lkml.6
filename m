Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC17C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1B820936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1B820936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbeGKAst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732275AbeGKAst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:48:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B9A208E5;
        Wed, 11 Jul 2018 00:47:09 +0000 (UTC)
Date:   Tue, 10 Jul 2018 20:47:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Subject: Re: [PATCH v9 6/7] lib: Add module to simulate atomic sections for
 testing preemptoff tracers
Message-ID: <20180710204707.2fbaef87@gandalf.local.home>
In-Reply-To: <20180628182149.226164-7-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-7-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 11:21:48 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> In this patch we introduce a test module for simulating a long atomic
> section in the kernel which the preemptoff or irqsoff tracers can
> detect. This module is to be used only for test purposes and is default
> disabled.
> 
> Following is the expected output (only briefly shown) that can be parsed
> to verify that the tracers are working correctly. We will use this from
> the kselftests in future patches.
> 
> For the preemptoff tracer:
> 
> echo preemptoff > /d/tracing/current_tracer
> sleep 1
> insmod ./test_atomic_sections.ko atomic_mode=preempt atomic_time=500000
> sleep 1
> bash-4.3# cat /d/tracing/trace
> preempt -1066    2...2    0us@: atomic_sect_run <-atomic_sect_run
> preempt -1066    2...2 500002us : atomic_sect_run <-atomic_sect_run
> preempt -1066    2...2 500004us : tracer_preempt_on <-atomic_sect_run
> preempt -1066    2...2 500012us : <stack trace>
>  => kthread
>  => ret_from_fork  
> 
> For the irqsoff tracer:
> 
> echo irqsoff > /d/tracing/current_tracer
> sleep 1
> insmod ./test_atomic_sections.ko atomic_mode=irq atomic_time=500000
> sleep 1
> bash-4.3# cat /d/tracing/trace
> irq dis -1069    1d..1    0us@: atomic_sect_run
> irq dis -1069    1d..1 500001us : atomic_sect_run
> irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-atomic_sect_run
> irq dis -1069    1d..1 500005us : <stack trace>
>  => ret_from_fork  
> 
> Co-developed-by: Erick Reyes <erickreyes@google.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  lib/Kconfig.debug          |  8 ++++
>  lib/Makefile               |  1 +
>  lib/test_atomic_sections.c | 77 ++++++++++++++++++++++++++++++++++++++

I think this code should reside in kernel/trace directory. I already
have modules there. See the ring_buffer_benchmark code and the test
module for mmio tracer.

>  3 files changed, 86 insertions(+)
>  create mode 100644 lib/test_atomic_sections.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 8838d1158d19..622c90e1e066 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1956,6 +1956,14 @@ config TEST_KMOD
>  
>  	  If unsure, say N.
>  
> +config TEST_ATOMIC_SECTIONS
> +	tristate "Simulate atomic sections for tracers to detect"

Hmm, I don't like this title. It's not very obvious to what it is
about. What about "Preempt / IRQ disable delay thread to test latency
tracers" ? Or something along those lines.


> +	depends on m
> +	help
> +	  Select this option to build a test module that can help test atomic
> +	  sections by simulating them with a duration supplied as a module
> +	  parameter. Preempt disable and irq disable modes can be requested.

"If unsure say N"

> +
>  config TEST_DEBUG_VIRTUAL
>  	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
>  	depends on DEBUG_VIRTUAL
> diff --git a/lib/Makefile b/lib/Makefile
> index 90dc5520b784..7831e747bf72 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -44,6 +44,7 @@ obj-y += string_helpers.o
>  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
>  obj-y += hexdump.o
>  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> +obj-$(CONFIG_TEST_ATOMIC_SECTIONS) += test_atomic_sections.o
>  obj-y += kstrtox.o
>  obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
>  obj-$(CONFIG_TEST_BPF) += test_bpf.o
> diff --git a/lib/test_atomic_sections.c b/lib/test_atomic_sections.c
> new file mode 100644
> index 000000000000..1eef518f0974
> --- /dev/null
> +++ b/lib/test_atomic_sections.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Atomic section emulation test module
> + *
> + * Emulates atomic sections by disabling IRQs or preemption
> + * and doing a busy wait for a specified amount of time.
> + * This can be used for testing of different atomic section
> + * tracers such as irqsoff tracers.
> + *
> + * (c) 2018. Google LLC
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
> +static ulong atomic_time = 100;
> +static char atomic_mode[10] = "irq";
> +
> +module_param_named(atomic_time, atomic_time, ulong, S_IRUGO);
> +module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
> +MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");

It's not a "Period", it's a delay. "Length of time in critical section"

> +MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");

  "Mode of the test: preempt or irq disabled (default irq)"

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
> +int atomic_sect_run(void *data)
> +{
> +	unsigned long flags;
> +
> +	if (!strcmp(atomic_mode, "irq")) {
> +		local_irq_save(flags);
> +		busy_wait(atomic_time);
> +		local_irq_restore(flags);
> +	} else if (!strcmp(atomic_mode, "preempt")) {
> +		preempt_disable();
> +		busy_wait(atomic_time);
> +		preempt_enable();
> +	}

So this is a one shot deal? That should be explained somewhere,
probably in the config help message. In fact, I think the config help
message should show how to use this.

-- Steve

> +
> +	return 0;
> +}
> +
> +static int __init atomic_sect_init(void)
> +{
> +	char task_name[50];
> +	struct task_struct *test_task;
> +
> +	snprintf(task_name, sizeof(task_name), "%s_test", atomic_mode);
> +
> +	test_task = kthread_run(atomic_sect_run, NULL, task_name);
> +	return PTR_ERR_OR_ZERO(test_task);
> +}
> +
> +static void __exit atomic_sect_exit(void)
> +{
> +	return;
> +}
> +
> +module_init(atomic_sect_init)
> +module_exit(atomic_sect_exit)
> +MODULE_LICENSE("GPL v2");

