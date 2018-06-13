Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C8E63C5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EBE20660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EBE20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935283AbeFMBEL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:04:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:64691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935059AbeFMBBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283504"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:33 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 14/23] watchdog/hardlockup: Decouple the hardlockup detector from perf
Date:   Tue, 12 Jun 2018 17:57:34 -0700
Message-Id: <1528851463-21140-15-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current default implementation of the hardlockup detector assumes that
it is implemented using perf events. However, the hardlockup detector can
be driven by other sources of non-maskable interrupts (e.g., a properly
configured timer).

Put in a separate file all the code that is specific to perf: create and
manage events, stop and start the detector. This perf-specific code is put
in the new file watchdog_hld_perf.c

The code generic code used to monitor the timers' thresholds, check
timestamps and detect hardlockups remains in watchdog_hld.c

Functions and variables are simply relocated to a new file. No functional
changes were made.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/Makefile            |   2 +-
 kernel/watchdog_hld.c      | 162 ----------------------------------------
 kernel/watchdog_hld_perf.c | 182 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+), 163 deletions(-)
 create mode 100644 kernel/watchdog_hld_perf.c

diff --git a/kernel/Makefile b/kernel/Makefile
index f85ae5d..0a0d86d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -85,7 +85,7 @@ obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o watchdog_hld_perf.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 28a00c3..96615a2 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -22,12 +22,8 @@
 
 static DEFINE_PER_CPU(bool, hard_watchdog_warn);
 static DEFINE_PER_CPU(bool, watchdog_nmi_touch);
-static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-static DEFINE_PER_CPU(struct perf_event *, dead_event);
-static struct cpumask dead_events_mask;
 
 static unsigned long hardlockup_allcpu_dumped;
-static atomic_t watchdog_cpus = ATOMIC_INIT(0);
 
 void arch_touch_nmi_watchdog(void)
 {
@@ -98,14 +94,6 @@ static inline bool watchdog_check_timestamp(void)
 }
 #endif
 
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
 void inspect_for_hardlockups(struct pt_regs *regs)
 {
 	if (__this_cpu_read(watchdog_nmi_touch) == true) {
@@ -155,153 +143,3 @@ void inspect_for_hardlockups(struct pt_regs *regs)
 	__this_cpu_write(hard_watchdog_warn, false);
 	return;
 }
-
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
-{
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-	inspect_for_hardlockups(regs);
-}
-
-static int hardlockup_detector_event_create(void)
-{
-	unsigned int cpu = smp_processor_id();
-	struct perf_event_attr *wd_attr;
-	struct perf_event *evt;
-
-	wd_attr = &wd_hw_attr;
-	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
-
-	/* Try to register using hardware perf events */
-	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
-					       watchdog_overflow_callback, NULL);
-	if (IS_ERR(evt)) {
-		pr_info("Perf event create on CPU %d failed with %ld\n", cpu,
-			PTR_ERR(evt));
-		return PTR_ERR(evt);
-	}
-	this_cpu_write(watchdog_ev, evt);
-	return 0;
-}
-
-/**
- * hardlockup_detector_perf_enable - Enable the local event
- */
-static void hardlockup_detector_perf_enable(void)
-{
-	if (hardlockup_detector_event_create())
-		return;
-
-	/* use original value for check */
-	if (!atomic_fetch_inc(&watchdog_cpus))
-		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
-
-	perf_event_enable(this_cpu_read(watchdog_ev));
-}
-
-/**
- * hardlockup_detector_perf_disable - Disable the local event
- */
-static void hardlockup_detector_perf_disable(void)
-{
-	struct perf_event *event = this_cpu_read(watchdog_ev);
-
-	if (event) {
-		perf_event_disable(event);
-		this_cpu_write(watchdog_ev, NULL);
-		this_cpu_write(dead_event, event);
-		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
-		atomic_dec(&watchdog_cpus);
-	}
-}
-
-/**
- * hardlockup_detector_perf_cleanup - Cleanup disabled events and destroy them
- *
- * Called from lockup_detector_cleanup(). Serialized by the caller.
- */
-static void hardlockup_detector_perf_cleanup(void)
-{
-	int cpu;
-
-	for_each_cpu(cpu, &dead_events_mask) {
-		struct perf_event *event = per_cpu(dead_event, cpu);
-
-		/*
-		 * Required because for_each_cpu() reports  unconditionally
-		 * CPU0 as set on UP kernels. Sigh.
-		 */
-		if (event)
-			perf_event_release_kernel(event);
-		per_cpu(dead_event, cpu) = NULL;
-	}
-	cpumask_clear(&dead_events_mask);
-}
-
-/**
- * hardlockup_detector_perf_stop - Globally stop watchdog events
- *
- * Special interface for x86 to handle the perf HT bug.
- */
-void __init hardlockup_detector_perf_stop(void)
-{
-	int cpu;
-
-	lockdep_assert_cpus_held();
-
-	for_each_online_cpu(cpu) {
-		struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-		if (event)
-			perf_event_disable(event);
-	}
-}
-
-/**
- * hardlockup_detector_perf_restart - Globally restart watchdog events
- *
- * Special interface for x86 to handle the perf HT bug.
- */
-void __init hardlockup_detector_perf_restart(void)
-{
-	int cpu;
-
-	lockdep_assert_cpus_held();
-
-	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
-		return;
-
-	for_each_online_cpu(cpu) {
-		struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-		if (event)
-			perf_event_enable(event);
-	}
-}
-
-/**
- * hardlockup_detector_perf_init - Probe whether NMI event is available at all
- */
-static int __init hardlockup_detector_perf_init(void)
-{
-	int ret = hardlockup_detector_event_create();
-
-	if (ret) {
-		pr_info("Perf NMI watchdog permanently disabled\n");
-	} else {
-		perf_event_release_kernel(this_cpu_read(watchdog_ev));
-		this_cpu_write(watchdog_ev, NULL);
-	}
-
-	return ret;
-}
-
-struct nmi_watchdog_ops hardlockup_detector_perf_ops = {
-	.init		= hardlockup_detector_perf_init,
-	.enable		= hardlockup_detector_perf_enable,
-	.disable	= hardlockup_detector_perf_disable,
-	.cleanup	= hardlockup_detector_perf_cleanup,
-};
diff --git a/kernel/watchdog_hld_perf.c b/kernel/watchdog_hld_perf.c
new file mode 100644
index 0000000..abc8edc
--- /dev/null
+++ b/kernel/watchdog_hld_perf.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Detect hard lockups on a system
+ *
+ * started by Ricardo Neri, Copyright (C) 2018 Intel Corporation.
+ *
+ * Note: All of this code comes from the previous perf-specific hardlockup
+ * detector.
+ */
+
+#define pr_fmt(fmt) "NMI perf watchdog: " fmt
+
+#include <linux/nmi.h>
+#include <linux/atomic.h>
+#include <linux/module.h>
+#include <linux/sched/debug.h>
+#include <linux/perf_event.h>
+#include <asm/irq_regs.h>
+
+static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
+static DEFINE_PER_CPU(struct perf_event *, dead_event);
+static struct cpumask dead_events_mask;
+
+static atomic_t watchdog_cpus = ATOMIC_INIT(0);
+
+static struct perf_event_attr wd_hw_attr = {
+	.type		= PERF_TYPE_HARDWARE,
+	.config		= PERF_COUNT_HW_CPU_CYCLES,
+	.size		= sizeof(struct perf_event_attr),
+	.pinned		= 1,
+	.disabled	= 1,
+};
+
+/* Callback function for perf event subsystem */
+static void watchdog_overflow_callback(struct perf_event *event,
+				       struct perf_sample_data *data,
+				       struct pt_regs *regs)
+{
+	/* Ensure the watchdog never gets throttled */
+	event->hw.interrupts = 0;
+	inspect_for_hardlockups(regs);
+}
+
+static int hardlockup_detector_event_create(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct perf_event_attr *wd_attr;
+	struct perf_event *evt;
+
+	wd_attr = &wd_hw_attr;
+	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
+
+	/* Try to register using hardware perf events */
+	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
+					       watchdog_overflow_callback, NULL);
+	if (IS_ERR(evt)) {
+		pr_info("Perf event create on CPU %d failed with %ld\n", cpu,
+			PTR_ERR(evt));
+		return PTR_ERR(evt);
+	}
+	this_cpu_write(watchdog_ev, evt);
+	return 0;
+}
+
+/**
+ * hardlockup_detector_perf_enable - Enable the local event
+ */
+static void hardlockup_detector_perf_enable(void)
+{
+	if (hardlockup_detector_event_create())
+		return;
+
+	/* use original value for check */
+	if (!atomic_fetch_inc(&watchdog_cpus))
+		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
+
+	perf_event_enable(this_cpu_read(watchdog_ev));
+}
+
+/**
+ * hardlockup_detector_perf_disable - Disable the local event
+ */
+static void hardlockup_detector_perf_disable(void)
+{
+	struct perf_event *event = this_cpu_read(watchdog_ev);
+
+	if (event) {
+		perf_event_disable(event);
+		this_cpu_write(watchdog_ev, NULL);
+		this_cpu_write(dead_event, event);
+		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
+		atomic_dec(&watchdog_cpus);
+	}
+}
+
+/**
+ * hardlockup_detector_perf_cleanup - Cleanup disabled events and destroy them
+ *
+ * Called from lockup_detector_cleanup(). Serialized by the caller.
+ */
+static void hardlockup_detector_perf_cleanup(void)
+{
+	int cpu;
+
+	for_each_cpu(cpu, &dead_events_mask) {
+		struct perf_event *event = per_cpu(dead_event, cpu);
+
+		/*
+		 * Required because for_each_cpu() reports  unconditionally
+		 * CPU0 as set on UP kernels. Sigh.
+		 */
+		if (event)
+			perf_event_release_kernel(event);
+		per_cpu(dead_event, cpu) = NULL;
+	}
+	cpumask_clear(&dead_events_mask);
+}
+
+/**
+ * hardlockup_detector_perf_stop - Globally stop watchdog events
+ *
+ * Special interface for x86 to handle the perf HT bug.
+ */
+void __init hardlockup_detector_perf_stop(void)
+{
+	int cpu;
+
+	lockdep_assert_cpus_held();
+
+	for_each_online_cpu(cpu) {
+		struct perf_event *event = per_cpu(watchdog_ev, cpu);
+
+		if (event)
+			perf_event_disable(event);
+	}
+}
+
+/**
+ * hardlockup_detector_perf_restart - Globally restart watchdog events
+ *
+ * Special interface for x86 to handle the perf HT bug.
+ */
+void __init hardlockup_detector_perf_restart(void)
+{
+	int cpu;
+
+	lockdep_assert_cpus_held();
+
+	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
+		return;
+
+	for_each_online_cpu(cpu) {
+		struct perf_event *event = per_cpu(watchdog_ev, cpu);
+
+		if (event)
+			perf_event_enable(event);
+	}
+}
+
+/**
+ * hardlockup_detector_perf_init - Probe whether NMI event is available at all
+ */
+static int __init hardlockup_detector_perf_init(void)
+{
+	int ret = hardlockup_detector_event_create();
+
+	if (ret) {
+		pr_info("Perf NMI watchdog permanently disabled\n");
+	} else {
+		perf_event_release_kernel(this_cpu_read(watchdog_ev));
+		this_cpu_write(watchdog_ev, NULL);
+	}
+
+	return ret;
+}
+
+struct nmi_watchdog_ops hardlockup_detector_perf_ops = {
+	.init		= hardlockup_detector_perf_init,
+	.enable		= hardlockup_detector_perf_enable,
+	.disable	= hardlockup_detector_perf_disable,
+	.cleanup	= hardlockup_detector_perf_cleanup,
+};
-- 
2.7.4

