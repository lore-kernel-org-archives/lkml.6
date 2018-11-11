Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF76C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D502920881
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 21:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D502920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbeKLGyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:54:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeKLGyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:54:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 681E53DDB8;
        Sun, 11 Nov 2018 21:04:35 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-16.brq.redhat.com [10.40.204.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 537E15C1B4;
        Sun, 11 Nov 2018 21:04:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] perf/cputime: Add cputime pmu
Date:   Sun, 11 Nov 2018 22:04:24 +0100
Message-Id: <20181111210426.28712-2-jolsa@kernel.org>
In-Reply-To: <20181111210426.28712-1-jolsa@kernel.org>
References: <20181111210426.28712-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 11 Nov 2018 21:04:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPUTIME_* counters account the time for CPU runtimes.
Adding 'cputime' PMU, that provides perf interface to those
counters.

The 'cputime' interface is standard software PMU, that provides
following events, meassuring their CPUTIME counterparts:

  PERF_CPUTIME_USER       - CPUTIME_USER
  PERF_CPUTIME_NICE       - CPUTIME_NICE
  PERF_CPUTIME_SYSTEM     - CPUTIME_SYSTEM
  PERF_CPUTIME_SOFTIRQ    - CPUTIME_SOFTIRQ
  PERF_CPUTIME_IRQ        - CPUTIME_IRQ
  PERF_CPUTIME_IDLE       - CPUTIME_IDLE
  PERF_CPUTIME_IOWAIT     - CPUTIME_IOWAIT
  PERF_CPUTIME_STEAL      - CPUTIME_STEAL
  PERF_CPUTIME_GUEST      - CPUTIME_GUEST
  PERF_CPUTIME_GUEST_NICE - CPUTIME_GUEST_NICE

The 'cputime' PMU adds 'events' and 'format' directory,
with above events specifics.

It can be used via perf tool like:

  # perf stat -e cputime/system/,cputime/user/ yes > /dev/null
  ^Cyes: Interrupt

   Performance counter stats for 'yes':

       2,177,550,368 ns   cputime/system/
         567,029,895 ns   cputime/user/

         2.749451438 seconds time elapsed

         0.567127000 seconds user
         2.177924000 seconds sys

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h |   2 +
 kernel/events/Makefile     |   2 +-
 kernel/events/core.c       |   1 +
 kernel/events/cputime.c    | 198 +++++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 kernel/events/cputime.c

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..47a31d01df5a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1162,6 +1162,8 @@ static inline int perf_callchain_store(struct perf_callchain_entry_ctx *ctx, u64
 	}
 }
 
+extern int __init perf_cputime_register(void);
+
 extern int sysctl_perf_event_paranoid;
 extern int sysctl_perf_event_mlock;
 extern int sysctl_perf_event_sample_rate;
diff --git a/kernel/events/Makefile b/kernel/events/Makefile
index 3c022e33c109..02271b8433a7 100644
--- a/kernel/events/Makefile
+++ b/kernel/events/Makefile
@@ -3,7 +3,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
 endif
 
-obj-y := core.o ring_buffer.o callchain.o
+obj-y := core.o ring_buffer.o callchain.o cputime.o
 
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_UPROBES) += uprobes.o
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 84530ab358c3..7403a27363f8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11723,6 +11723,7 @@ void __init perf_event_init(void)
 	perf_pmu_register(&perf_cpu_clock, NULL, -1);
 	perf_pmu_register(&perf_task_clock, NULL, -1);
 	perf_tp_register();
+	perf_cputime_register();
 	perf_event_init_cpu(smp_processor_id());
 	register_reboot_notifier(&perf_reboot_notifier);
 
diff --git a/kernel/events/cputime.c b/kernel/events/cputime.c
new file mode 100644
index 000000000000..efad24543f13
--- /dev/null
+++ b/kernel/events/cputime.c
@@ -0,0 +1,198 @@
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/perf_event.h>
+
+enum perf_cputime_id {
+	PERF_CPUTIME_USER,
+	PERF_CPUTIME_NICE,
+	PERF_CPUTIME_SYSTEM,
+	PERF_CPUTIME_SOFTIRQ,
+	PERF_CPUTIME_IRQ,
+	PERF_CPUTIME_IDLE,
+	PERF_CPUTIME_IOWAIT,
+	PERF_CPUTIME_STEAL,
+	PERF_CPUTIME_GUEST,
+	PERF_CPUTIME_GUEST_NICE,
+	PERF_CPUTIME_MAX,
+};
+
+static enum cpu_usage_stat map[PERF_CPUTIME_MAX] = {
+	[PERF_CPUTIME_USER]		= CPUTIME_USER,
+	[PERF_CPUTIME_NICE]		= CPUTIME_NICE,
+	[PERF_CPUTIME_SYSTEM]		= CPUTIME_SYSTEM,
+	[PERF_CPUTIME_SOFTIRQ]		= CPUTIME_SOFTIRQ,
+	[PERF_CPUTIME_IRQ]		= CPUTIME_IRQ,
+	[PERF_CPUTIME_IDLE]		= CPUTIME_IDLE,
+	[PERF_CPUTIME_IOWAIT]		= CPUTIME_IOWAIT,
+	[PERF_CPUTIME_STEAL]		= CPUTIME_STEAL,
+	[PERF_CPUTIME_GUEST]		= CPUTIME_GUEST,
+	[PERF_CPUTIME_GUEST_NICE]	= CPUTIME_GUEST_NICE,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *cputime_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group cputime_format_attr_group = {
+	.name = "format",
+	.attrs = cputime_format_attrs,
+};
+
+static ssize_t
+cputime_event_attr_show(struct device *dev, struct device_attribute *attr,
+		    char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=%llu\n", pmu_attr->id);
+}
+
+#define __A(__n, __e)					\
+	PMU_EVENT_ATTR(__n, cputime_attr_##__n,		\
+		       __e, cputime_event_attr_show);	\
+	PMU_EVENT_ATTR_STRING(__n.unit,			\
+			cputime_attr_##__n##_unit, "ns");
+
+__A(user,	PERF_CPUTIME_USER)
+__A(nice,	PERF_CPUTIME_NICE)
+__A(system,	PERF_CPUTIME_SYSTEM)
+__A(softirq,	PERF_CPUTIME_SOFTIRQ)
+__A(irq,	PERF_CPUTIME_IRQ)
+__A(idle,	PERF_CPUTIME_IDLE)
+__A(iowait,	PERF_CPUTIME_IOWAIT)
+__A(steal,	PERF_CPUTIME_STEAL)
+__A(guest,	PERF_CPUTIME_GUEST)
+__A(guest_nice,	PERF_CPUTIME_GUEST_NICE)
+
+#undef __A
+
+static struct attribute *cputime_events_attrs[] = {
+#define __A(__n)				\
+	&cputime_attr_##__n.attr.attr,		\
+	&cputime_attr_##__n##_unit.attr.attr,
+
+	__A(user)
+	__A(nice)
+	__A(system)
+	__A(softirq)
+	__A(irq)
+	__A(idle)
+	__A(iowait)
+	__A(steal)
+	__A(guest)
+	__A(guest_nice)
+
+	NULL,
+
+#undef __A
+};
+
+static struct attribute_group cputime_events_attr_group = {
+	.name = "events",
+	.attrs = cputime_events_attrs,
+};
+
+static const struct attribute_group *cputime_attr_groups[] = {
+	&cputime_format_attr_group,
+	&cputime_events_attr_group,
+	NULL,
+};
+
+static u64 cputime_read_counter(struct perf_event *event)
+{
+	int cpu = event->oncpu;
+
+	return kcpustat_cpu(cpu).cpustat[event->hw.config];
+}
+
+static void perf_cputime_update(struct perf_event *event)
+{
+	u64 prev, now;
+	s64 delta;
+
+	/* Careful, an NMI might modify the previous event value: */
+again:
+	prev = local64_read(&event->hw.prev_count);
+	now = cputime_read_counter(event);
+
+	if (local64_cmpxchg(&event->hw.prev_count, prev, now) != prev)
+		goto again;
+
+	delta = now - prev;
+	local64_add(delta, &event->count);
+}
+
+static void cputime_event_start(struct perf_event *event, int flags)
+{
+	u64 now = cputime_read_counter(event);
+
+	local64_set(&event->hw.prev_count, now);
+}
+
+static void cputime_event_stop(struct perf_event *event, int flags)
+{
+	perf_cputime_update(event);
+}
+
+static int cputime_event_add(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_START)
+		cputime_event_start(event, flags);
+
+	return 0;
+}
+
+static void cputime_event_del(struct perf_event *event, int flags)
+{
+	cputime_event_stop(event, PERF_EF_UPDATE);
+}
+
+static void perf_cputime_read(struct perf_event *event)
+{
+	perf_cputime_update(event);
+}
+
+static int cputime_event_init(struct perf_event *event)
+{
+	u64 cfg = event->attr.config;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* unsupported modes and filters */
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest  ||
+	    event->attr.sample_period) /* no sampling */
+		return -EINVAL;
+
+	if (cfg >= PERF_CPUTIME_MAX)
+		return -EINVAL;
+
+	event->hw.config = map[cfg];
+	return 0;
+}
+
+static struct pmu perf_cputime = {
+	.task_ctx_nr	= perf_sw_context,
+	.attr_groups	= cputime_attr_groups,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
+	.event_init	= cputime_event_init,
+	.add		= cputime_event_add,
+	.del		= cputime_event_del,
+	.start		= cputime_event_start,
+	.stop		= cputime_event_stop,
+	.read		= perf_cputime_read,
+};
+
+int __init perf_cputime_register(void)
+{
+	return perf_pmu_register(&perf_cputime, "cputime", -1);
+}
-- 
2.17.2

