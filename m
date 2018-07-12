Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC0EECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE16E208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pGK/gLjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE16E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbeGLVrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:47:39 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41730 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbeGLVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:47:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so16730813pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EThkfo811/RaZ0l5M8LKbaX6Tep7le8XWq9TbjNzm5w=;
        b=pGK/gLjr4kYbAQgwRl/FlFkfWPe5frkxW8G/Efs5wF7Qg5/XlwhsCxKWNc64JkxRRa
         FCAStD3vryAxffdep4bIrDgjCWEeBumaSHa+JYcAoq39CCr4UGOufcBGYi4PVUr+8AKy
         TE2TANGdMOqosgzdVn2cedR4as6MBFZo5ClGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EThkfo811/RaZ0l5M8LKbaX6Tep7le8XWq9TbjNzm5w=;
        b=XzI/CbjiHFQQ7M91JN+ADsCcAa9+BTKcTsHAut6AlL6bu0+44qjC3D5JrlNoJQqaAX
         yiGEBPBhuF6Azb7PkM8bl26CZtG1bzlCCRVDpVVjhGjIv39mY9XSkDM+XlUZrIXxr8Mb
         uQlKGkNMzwpbbRcXb3fyuywM7fL0+kcHE9T2P8ZplZd+Be4Uv2jSaSOLHm32MOJfIU3H
         iYUIcKCksTXwO+F1FfY2hf10+w6K9S10SHeWe2tUjlp+BuobH1Quyg6CJXjSFi44QIXN
         RQHhgcr8LuJvZ2P+JNbItGZMmb9j3oMFq2el7IgjzOdPox0dzlUPhlH5xcYebLMjnvNT
         fDLA==
X-Gm-Message-State: AOUpUlEtHDxQ7cR+GYQE1GdqXJB7Ne/FdD0uMQlcPcr9xH0SA7B+UDn+
        UC7yXYJWTvxmUBzI/grIbe3u0P9GyVk=
X-Google-Smtp-Source: AAOMgpcM3OOxQEuT70Vi8JGK0FxCxtFS7Kv7YUasNPlu1xTwUdRL4Ee9womc9gml2cw68M3f/jaHFw==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr3513802pgp.200.1531431372504;
        Thu, 12 Jul 2018 14:36:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id z10-v6sm38480559pgo.58.2018.07.12.14.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:36:12 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:36:11 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20180712213611.GA8743@joelaf.mtv.corp.google.com>
References: <20180711063540.91101-1-joel@joelfernandes.org>
 <20180711063540.91101-2-joel@joelfernandes.org>
 <20180712172232.00e4c01e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172232.00e4c01e@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:22:32PM -0400, Steven Rostedt wrote:
> On Tue, 10 Jul 2018 23:35:39 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > 
> > Co-developed-by: Erick Reyes <erickreyes@google.com>
> 
> A co-developer needs to add their signed off by. To specify that Erick
> is a co-author, you could do:
> 
> [ Erick is a co-developer of this commit ]
> Signed-off-by: Add Erick's SOB here.

Sure, I added this below. Hope its easy for you to apply, if not let me know
and I can send it again separately. thanks.

------------>8----------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH 1/2] lib: Add module for testing preemptoff/irqsoff latency  tracers

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

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[ Erick is a co-developer of this commit ]
Signed-off-by: Erick Reyes <erickreyes@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/Kconfig                 | 15 ++++++
 kernel/trace/Makefile                |  1 +
 kernel/trace/preemptirq_delay_test.c | 72 ++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 kernel/trace/preemptirq_delay_test.c

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 8d51351e3149..eb5ab6b511e2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -699,6 +699,21 @@ config RING_BUFFER_STARTUP_TEST
 
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
index 84a0cb222f20..677540bb1b62 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_TRACING_MAP) += tracing_map.o
 obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
 obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
+obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
 obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_PREEMPT_TRACER) += trace_irqsoff.o
 obj-$(CONFIG_SCHED_TRACER) += trace_sched_wakeup.o
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
2.18.0.203.gfac676dfb9-goog


