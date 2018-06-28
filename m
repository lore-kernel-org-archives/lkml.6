Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56227795
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="un0dNIDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D56227795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967799AbeF1SWX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:22:23 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40933 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030451AbeF1SWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:22:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so2978795pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CV7DtXnAt/lUvrvcf20HpsDANAEU7RcF1ExBUfQsZos=;
        b=un0dNIDDQBTGqhcGZ1lVPrV7UYIXqfE0FEVnnM+NseEarBpSo/jcXd0y1qTT5oauBp
         JKb+cyfA9hEGEFyaOG4+Q5sYKWfaY8255Qlzk8O9K9BxJTVKeKlRzIFH6A9E3yW8x/IZ
         IL7+ap5Ew2xrYHJZV8WvbuTt/XoG3u4vMgTN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CV7DtXnAt/lUvrvcf20HpsDANAEU7RcF1ExBUfQsZos=;
        b=FTwnr/j29cFYv0BpPxyQjbW/p7Q81azN/mjzcGguVCjZUwXdjPYnSscufNY589f5K7
         xwPniR9qnEglpm+j4nO7oNCZQj7NB92onbjFk4BR68exIRWmpHwZEJsEtc2L7rpk/ITo
         /E2YOR+F2ybZVFjsD5gRQs0QF+AZeoFR/p/rvWoadE/8Tm1UOUrMPAyreNOTFGSOJZYk
         isF0wr1NAoV/A4MeOD2cqOzctSSz3IkqQdr71fPBe1wsWK8c3aMMXORZfmosK0QvAwfC
         LBiRDNRed8ZYxu7H/NTIvioN5gZ4D1Yb93NN1ktkfAPCj6+wh65FjJU6cl1AQFYFSPyB
         GQ1Q==
X-Gm-Message-State: APt69E1NUX0n87X/V9fy8mruflbilq1kfFCYCvZPBlE6w8IxTlH9JnEf
        KD6ELJgaeCxnBXzZI41+UtbxOkds7bY=
X-Google-Smtp-Source: ADUXVKJsHvuNAhWrzrMOVF6zs96xj5P84vZMLiUJKfHlSF2ad2zYKS5beFm501ihOHkGc8gpS9+YFw==
X-Received: by 2002:a65:4dc3:: with SMTP id q3-v6mr9659697pgt.331.1530210123334;
        Thu, 28 Jun 2018 11:22:03 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id q10-v6sm13686027pfj.7.2018.06.28.11.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:22:02 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v9 6/7] lib: Add module to simulate atomic sections for testing preemptoff tracers
Date:   Thu, 28 Jun 2018 11:21:48 -0700
Message-Id: <20180628182149.226164-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180628182149.226164-1-joel@joelfernandes.org>
References: <20180628182149.226164-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Co-developed-by: Erick Reyes <erickreyes@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/Kconfig.debug          |  8 ++++
 lib/Makefile               |  1 +
 lib/test_atomic_sections.c | 77 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 lib/test_atomic_sections.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..622c90e1e066 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1956,6 +1956,14 @@ config TEST_KMOD
 
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
index 90dc5520b784..7831e747bf72 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -44,6 +44,7 @@ obj-y += string_helpers.o
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
2.18.0.rc2.346.g013aa6912e-goog

