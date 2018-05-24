Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935499AbeEXBX2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:23:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35410 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935433AbeEXBWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:22:37 -0400
X-Google-Smtp-Source: AB8JxZpXmNjtXCTIxsBgtnzthM1Ay4KIgDq7Z1zrdLemG5eprEAQven6jy9Z02m0yoJA/PFizjFsFA==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
Subject: [PATCH v7 7/8] lib: Add module to simulate atomic sections for testing preemptoff tracers
Date: Wed, 23 May 2018 18:21:56 -0700
Message-Id: <20180524012157.181277-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180524012157.181277-1-joel@joelfernandes.org>
References: <20180524012157.181277-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

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

Co-authored-by: Erick Reyes <erickreyes@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/Kconfig.debug          |  8 ++++
 lib/Makefile               |  1 +
 lib/test_atomic_sections.c | 79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
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
index 000000000000..2c8c6419d183
--- /dev/null
+++ b/lib/test_atomic_sections.c
@@ -0,0 +1,79 @@
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
+static int atomic_time = 100;
+static char atomic_mode[10] = "irq";
+
+module_param_named(atomic_time, atomic_time, int, S_IRUGO);
+module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");
+
+static void busy_wait(int time)
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
+void atomic_sect_run(void *data)
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
+	do_exit(0);
+}
+
+static int __init atomic_sect_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, 50, "%s dis test", atomic_mode);
+
+	test_task = kthread_run((void*)atomic_sect_run, NULL, task_name);
+	if (IS_ERR(test_task))
+		return PTR_ERR(test_task);
+
+	return 0;
+}
+
+static void __exit atomic_sect_exit(void)
+{
+	return;
+}
+
+module_init(atomic_sect_init)
+module_exit(atomic_sect_exit)
+MODULE_LICENSE("GPL");
-- 
2.17.0.441.gb46fe60e1d-goog
