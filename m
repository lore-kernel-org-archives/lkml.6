Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA19060764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbeFFHs4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:48:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:60016 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932263AbeFFHsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:48:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="64712513"
Message-ID: <05c0f2af4e9160ef4c02373dac4141a2018f00ae.camel@linux.intel.com>
Subject: Re: [PATCH v8 7/8] lib: Add module to simulate atomic sections for
 testing preemptoff tracers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc: kernel-team@android.com, Boqun Feng <boqun.feng@gmail.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Date: Wed, 06 Jun 2018 10:48:48 +0300
In-Reply-To: <20180605235305.GA72953@joelaf.mtv.corp.google.com>
References: <20180530000500.257225-1-joel@joelfernandes.org>
         <20180530000500.257225-8-joel@joelfernandes.org>
         <20180605235305.GA72953@joelaf.mtv.corp.google.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 16:53 -0700, Joel Fernandes wrote:
> (Resending since Andy wasn't on CC - sorry)

> Andy, previously made some suggestions to this patch. The updated
> version is
> below and I am planning to send it along with this series as v9. I
> have
> included it in advance below for your Review.
> 
> Andy, would you be Ok with adding your Reviewed-by to it?
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. I'm not familiar with the topic so much to have any insights about
implementation, though.

> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Wed, 16 May 2018 23:46:06 -0700
> Subject: [PATCH v9 7/8] lib: Add module to simulate atomic sections
> for testing
>  preemptoff tracers
> 
> In this patch we introduce a test module for simulating a long atomic
> section in the kernel which the preemptoff or irqsoff tracers can
> detect. This module is to be used only for test purposes and is
> default
> disabled.
> 
> Following is the expected output (only briefly shown) that can be
> parsed
> to verify that the tracers are working correctly. We will use this
> from
> the kselftests in future patches.
> 
> For the preemptoff tracer:
> 
> echo preemptoff > /d/tracing/current_tracer
> sleep 1
> insmod ./test_atomic_sections.ko atomic_mode=preempt
> atomic_time=500000
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
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  lib/Kconfig.debug          |  8 ++++
>  lib/Makefile               |  1 +
>  lib/test_atomic_sections.c | 77
> ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 lib/test_atomic_sections.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c40c7b734cd1..faebf0fe3bcf 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1933,6 +1933,14 @@ config TEST_KMOD
>  
>  	  If unsure, say N.
>  
> +config TEST_ATOMIC_SECTIONS
> +	tristate "Simulate atomic sections for tracers to detect"
> +	depends on m
> +	help
> +	  Select this option to build a test module that can help
> test atomic
> +	  sections by simulating them with a duration supplied as a
> module
> +	  parameter. Preempt disable and irq disable modes can be
> requested.
> +
>  config TEST_DEBUG_VIRTUAL
>  	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
>  	depends on DEBUG_VIRTUAL
> diff --git a/lib/Makefile b/lib/Makefile
> index ce20696d5a92..e82cf5445b7b 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -46,6 +46,7 @@ obj-y += string_helpers.o
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
> +MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS
> default)");
> +MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or
> irq (default irq)");
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
> +
> +	return 0;
> +}
> +
> +static int __init atomic_sect_init(void)
> +{
> +	char task_name[50];
> +	struct task_struct *test_task;
> +
> +	snprintf(task_name, sizeof(task_name), "%s_test",
> atomic_mode);
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

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
