Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCA5C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634FD217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634FD217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHKQ1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbeHKQY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:29 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A534F21A5E;
        Sat, 11 Aug 2018 13:50:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHT-00061d-LM; Sat, 11 Aug 2018 09:50:11 -0400
Message-Id: <20180811135011.558827646@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Erick Reyes <erickreyes@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 04/34] lib: Add module for testing preemptoff/irqsoff latency tracers
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Here we introduce a test module for introducing a long preempt or irq
disable delay in the kernel which the preemptoff or irqsoff tracers can
detect. This module is to be used only for test purposes and is default
disabled.

Following is the expected output (only briefly shown) that can be parsed
to verify that the tracers are working correctly. We will use this from
the kselftests in future patches.

For the preemptoff tracer:

echo preemptoff > /d/tracing/current_tracer
sleep 1
insmod ./preemptirq_delay_test.ko test_mode=preempt delay=500000
sleep 1
bash-4.3# cat /d/tracing/trace
preempt -1066    2...2    0us@: preemptirq_delay_run <-preemptirq_delay_run
preempt -1066    2...2 500002us : preemptirq_delay_run <-preemptirq_delay_run
preempt -1066    2...2 500004us : tracer_preempt_on <-preemptirq_delay_run
preempt -1066    2...2 500012us : <stack trace>
 => kthread
 => ret_from_fork

For the irqsoff tracer:

echo irqsoff > /d/tracing/current_tracer
sleep 1
insmod ./preemptirq_delay_test.ko test_mode=irq delay=500000
sleep 1
bash-4.3# cat /d/tracing/trace
irq dis -1069    1d..1    0us@: preemptirq_delay_run
irq dis -1069    1d..1 500001us : preemptirq_delay_run
irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-preemptirq_delay_run
irq dis -1069    1d..1 500005us : <stack trace>
 => ret_from_fork

Link: http://lkml.kernel.org/r/20180712213611.GA8743@joelaf.mtv.corp.google.com

Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Julia Cartwright <julia@ni.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Glexiner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ Erick is a co-developer of this commit ]
Signed-off-by: Erick Reyes <erickreyes@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig                 | 15 ++++++
 kernel/trace/Makefile                |  1 +
 kernel/trace/preemptirq_delay_test.c | 72 ++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 kernel/trace/preemptirq_delay_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dcc0166d1997..e15fadbe5dfb 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -687,6 +687,21 @@ config RING_BUFFER_STARTUP_TEST
 
 	 If unsure, say N
 
+config PREEMPTIRQ_DELAY_TEST
+	tristate "Preempt / IRQ disable delay thread to test latency tracers"
+	depends on m
+	help
+	  Select this option to build a test module that can help test latency
+	  tracers by executing a preempt or irq disable section with a user
+	  configurable delay. The module busy waits for the duration of the
+	  critical section.
+
+	  For example, the following invocation forces a one-time irq-disabled
+	  critical section for 500us:
+	  modprobe preemptirq_delay_test test_mode=irq delay=500000
+
+	  If unsure, say N
+
 config TRACE_EVAL_MAP_FILE
        bool "Show eval mappings for trace events"
        depends on TRACING
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e2538c7638d4..31c6b524c260 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TRACING) += trace_seq.o
 obj-$(CONFIG_TRACING) += trace_stat.o
 obj-$(CONFIG_TRACING) += trace_printk.o
 obj-$(CONFIG_TRACING_MAP) += tracing_map.o
+obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_EVENTS) += trace_irqsoff.o
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
new file mode 100644
index 000000000000..c97a026c0720
--- /dev/null
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Preempt / IRQ disable delay thread to test latency tracers
+ *
+ * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
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
+static ulong delay = 100;
+static char test_mode[10] = "irq";
+
+module_param_named(delay, delay, ulong, S_IRUGO);
+module_param_string(test_mode, test_mode, 10, S_IRUGO);
+MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
+MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
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
+int preemptirq_delay_run(void *data)
+{
+	unsigned long flags;
+
+	if (!strcmp(test_mode, "irq")) {
+		local_irq_save(flags);
+		busy_wait(delay);
+		local_irq_restore(flags);
+	} else if (!strcmp(test_mode, "preempt")) {
+		preempt_disable();
+		busy_wait(delay);
+		preempt_enable();
+	}
+
+	return 0;
+}
+
+static int __init preemptirq_delay_init(void)
+{
+	char task_name[50];
+	struct task_struct *test_task;
+
+	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
+
+	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
+	return PTR_ERR_OR_ZERO(test_task);
+}
+
+static void __exit preemptirq_delay_exit(void)
+{
+	return;
+}
+
+module_init(preemptirq_delay_init)
+module_exit(preemptirq_delay_exit)
+MODULE_LICENSE("GPL v2");
-- 
2.18.0


