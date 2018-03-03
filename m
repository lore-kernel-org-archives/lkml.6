Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964896AbeCCBPD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:15:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51468 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeCCBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:15:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B10E6601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=skannan@codeaurora.org
From: Saravana Kannan <skannan@codeaurora.org>
To: mark.rutland@arm.com, suzuki.poulose@arm.com,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: skannan@codeaurora.org, avilaj@codeaurora.org, rananta@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/core: Add support for PMUs that can be read from more than 1 CPU
Date: Fri,  2 Mar 2018 17:14:53 -0800
Message-Id: <1520039693-30914-1-git-send-email-skannan@codeaurora.org>
X-Mailer: git-send-email 1.8.2.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMUs events can be read from more than the one CPU. So allow the
PMU driver to mark events as such. For these events, we don't need to
reject reads or make smp calls to the event's CPU (and cause
unnecessary overhead and wake ups).

When a PMU driver marks an event as such, care must be taken by the
driver to make sure they can handle the event being read/updated from
more than 1 CPU at the same time (Eg: due to an IRQ indicating event
counter overflow and another thread trying to read the latest values).

Good examples of such events would be events from caches shared across
CPUs.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
Changes since v1:
- Use cpumasks instead of capability flag as that's more flexible.

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822..4cec431 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -629,6 +629,7 @@ struct perf_event {
 
 	int				oncpu;
 	int				cpu;
+	cpumask_t			readable_on_cpus;
 
 	struct list_head		owner_entry;
 	struct task_struct		*owner;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d3df58..1a8fbfa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3483,10 +3483,12 @@ struct perf_read_data {
 static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
 	u16 local_pkg, event_pkg;
+	int local_cpu = smp_processor_id();
 
-	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
-		int local_cpu = smp_processor_id();
+	if (cpumask_test_cpu(local_cpu, &event->readable_on_cpus))
+		return local_cpu;
 
+	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		event_pkg = topology_physical_package_id(event_cpu);
 		local_pkg = topology_physical_package_id(local_cpu);
 
@@ -3575,7 +3577,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 {
 	unsigned long flags;
 	int ret = 0;
-
+	int local_cpu = smp_processor_id();
+	bool readable = cpumask_test_cpu(local_cpu, &event->readable_on_cpus);
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
 	 * switches, timer based rotation and IPIs).
@@ -3600,7 +3603,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	/* If this is a per-CPU event, it must be for this CPU */
 	if (!(event->attach_state & PERF_ATTACH_TASK) &&
-	    event->cpu != smp_processor_id()) {
+	    event->cpu != local_cpu &&
+	    !readable) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3610,7 +3614,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event->oncpu == smp_processor_id() || readable)
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
