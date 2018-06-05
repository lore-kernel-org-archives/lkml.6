Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932095AbeFEXBh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 19:01:37 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39687 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752405AbeFEXBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 19:01:35 -0400
X-Google-Smtp-Source: ADUXVKIVIkB7IA57iGjEb/ReTcb0vNojZmDZbmd7eSlNnu4XCWrZ+JHWUneXJqpfD1AttvkA26PQFw==
Date: Tue, 5 Jun 2018 16:01:33 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v8 7/8] lib: Add module to simulate atomic sections for
 testing preemptoff tracers
Message-ID: <20180605230133.GA57315@joelaf.mtv.corp.google.com>
References: <20180530000500.257225-1-joel@joelfernandes.org>
 <20180530000500.257225-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530000500.257225-8-joel@joelfernandes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 29, 2018 at 05:04:59PM -0700, Joel Fernandes wrote:
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

Andy, previously made some suggestions to this patch. The updated version is
below and I am planning to send it along with this series as v9. I have
included it in advance below for your Review.

Andy, would you be Ok with adding your Reviewed-by to it?

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Date: Wed, 16 May 2018 23:46:06 -0700
Subject: [PATCH v9 7/8] lib: Add module to simulate atomic sections for testing
 preemptoff tracers

In this patch we introduce a test module for simulating a long atomic
section in the kernel which the preemptoff or irqsoff tracers can
detect. This module is to be used only for test purposes and is default
disabled.

Following is the expected output (only briefly shown) that can be parsed
to verify that the tracers are working correctly. We will use this from
the kselftests in future patches.

For the preemptoff tracer:

echo preemptoff > /d/tracing/current_tracer
sleep 1
insmod ./test_atomic_sections.ko atomic_mode=preempt atomic_time=500000
sleep 1
bash-4.3# cat /d/tracing/trace
preempt -1066    2...2    0us@: atomic_sect_run <-atomic_sect_run
preempt -1066    2...2 500002us : atomic_sect_run <-atomic_sect_run
preempt -1066    2...2 500004us : tracer_preempt_on <-atomic_sect_run
preempt -1066    2...2 500012us : <stack trace>
 => kthread
 => ret_from_fork

For the irqsoff tracer:

echo irqsoff > /d/tracing/current_tracer
sleep 1
insmod ./test_atomic_sections.ko atomic_mode=irq atomic_time=500000
sleep 1
bash-4.3# cat /d/tracing/trace
irq dis -1069    1d..1    0us@: atomic_sect_run
irq dis -1069    1d..1 500001us : atomic_sect_run
irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-atomic_sect_run
irq dis -1069    1d..1 500005us : <stack trace>
 => ret_from_fork

Co-developed-by: Erick Reyes <erickreyes@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/Kconfig.debug          |  8 ++++
 lib/Makefile               |  1 +
 lib/test_atomic_sections.c | 77 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 lib/test_atomic_sections.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c40c7b734cd1..faebf0fe3bcf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1933,6 +1933,14 @@ config TEST_KMOD
 
 	  If unsure, say N.
 
+config TEST_ATOMIC_SECTIONS
+	tristate "Simulate atomic sections for tracers to detect"
+	depends on m
+	help
+	  Select this option to build a test module that can help test atomic
+	  sections by simulating them with a duration supplied as a module
+	  parameter. Preempt disable and irq disable modes can be requested.
+
 config TEST_DEBUG_VIRTUAL
 	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
 	depends on DEBUG_VIRTUAL
diff --git a/lib/Makefile b/lib/Makefile
index ce20696d5a92..e82cf5445b7b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -46,6 +46,7 @@ obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
 obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
+obj-$(CONFIG_TEST_ATOMIC_SECTIONS) += test_atomic_sections.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
diff --git a/lib/test_atomic_sections.c b/lib/test_atomic_sections.c
new file mode 100644
index 000000000000..1eef518f0974
--- /dev/null
+++ b/lib/test_atomic_sections.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Atomic section emulation test module
+ *
+ * Emulates atomic sections by disabling IRQs or preemption
+ * and doing a busy wait for a specified amount of time.
+ * This can be used for testing of different atomic section
+ * tracers such as irqsoff tracers.
+ *
+ * (c) 2018. Google LLC
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/string.h>
+
+static ulong atomic_time = 100;
+static char atomic_mode[10] = "irq";
+
+module_param_named(atomic_time, atomic_time, ulong, S_IRUGO);
+module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");
+
+static void busy_wait(ulong time)
+{
+	ktime_t start, end;
+	start = ktime_get();
+	do {
+		end = ktime_get();
+		if (kthread_should_stop())
+			break;
+	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
+}
+
+int atomic_sect_run(void *data)
+{
+	unsigned long flags;
+
+	if (!strcmp(atomic_mode, "irq")) {
+		local_irq_save(flags);
+		busy_wait(atomic_time);
+		local_irq_restore(flags);
+	} else if (!strcmp(atomic_mode, "preempt")) {
+		preempt_disable();
+		busy_wait(atomic_time);
+		preempt_enable();
+	}
+
+	return 0;
+}
+
+static int __init atomic_sect_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, sizeof(task_name), "%s_test", atomic_mode);
+
+	test_task = kthread_run(atomic_sect_run, NULL, task_name);
+	return PTR_ERR_OR_ZERO(test_task);
+}
+
+static void __exit atomic_sect_exit(void)
+{
+	return;
+}
+
+module_init(atomic_sect_init)
+module_exit(atomic_sect_exit)
+MODULE_LICENSE("GPL v2");
-- 
2.17.1.1185.g55be947832-goog
