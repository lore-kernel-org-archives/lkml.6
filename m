Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeEDXLY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:11:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56022 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751777AbeEDXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:11:22 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To: <linux-kernel@vger.kernel.org>
CC: Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        <tj@kernel.org>, <peterz@infradead.org>, <jolsa@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [RFC 1/2] perf: add move_dup() for PMU sharing.
Date: Fri, 4 May 2018 16:11:01 -0700
Message-ID: <20180504231102.2850679-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180504231102.2850679-1-songliubraving@fb.com>
References: <20180504231102.2850679-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To share PMU across different counters, we need a "master event" that
handles interaction with hardware or other software parts. It is
necessary to switch master event to another event. To make this move
compatible with the PMU, it is necessary to move connection or data
from one perf_event to another.

This patch adds a new function to struct pmu, which moves data and/or
data connection from one perf_event to another.
---
 arch/x86/events/core.c          |  8 ++++++++
 include/linux/perf_event.h      |  7 +++++++
 include/linux/trace_events.h    |  3 +++
 kernel/events/core.c            |  3 +++
 kernel/trace/trace_event_perf.c | 11 +++++++++++
 5 files changed, 32 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a6006e7..f850a36 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2267,6 +2267,13 @@ void perf_check_microcode(void)
 		x86_pmu.check_microcode();
 }
 
+/* RFC NOTE: not fully tested */
+static void x86_pmu_move_dup(struct perf_event *old,
+			     struct perf_event *new)
+{
+	memcpy(&new->hw, &old->hw, sizeof(old->hw));
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2280,6 +2287,7 @@ static struct pmu pmu = {
 
 	.add			= x86_pmu_add,
 	.del			= x86_pmu_del,
+	.move_dup		= x86_pmu_move_dup,
 	.start			= x86_pmu_start,
 	.stop			= x86_pmu_stop,
 	.read			= x86_pmu_read,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99e..4c84549 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -333,6 +333,13 @@ struct pmu {
 	void (*del)			(struct perf_event *event, int flags);
 
 	/*
+	 * ->move_dup() moves necessary data connection (list, etc.) from
+	 * an old dup master to a new dup master
+	 */
+	void (*move_dup)		(struct perf_event *old,
+					 struct perf_event *new);
+
+	/*
 	 * Starts/Stops a counter present on the PMU.
 	 *
 	 * The PMI handler should stop the counter when perf_event_overflow()
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 2bde3ef..ca48e65 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -557,6 +557,9 @@ extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
 extern int  perf_trace_add(struct perf_event *event, int flags);
 extern void perf_trace_del(struct perf_event *event, int flags);
+extern void perf_trace_move_dup(struct perf_event *old,
+				struct perf_event *new);
+
 #ifdef CONFIG_KPROBE_EVENTS
 extern int  perf_kprobe_init(struct perf_event *event, bool is_retprobe);
 extern void perf_kprobe_destroy(struct perf_event *event);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce..bec1840 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8349,6 +8349,7 @@ static struct pmu perf_tracepoint = {
 	.event_init	= perf_tp_event_init,
 	.add		= perf_trace_add,
 	.del		= perf_trace_del,
+	.move_dup	= perf_trace_move_dup,
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
@@ -8391,6 +8392,7 @@ static struct pmu perf_kprobe = {
 	.event_init	= perf_kprobe_event_init,
 	.add		= perf_trace_add,
 	.del		= perf_trace_del,
+	.move_dup	= perf_trace_move_dup,
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
@@ -8432,6 +8434,7 @@ static struct pmu perf_uprobe = {
 	.event_init	= perf_uprobe_event_init,
 	.add		= perf_trace_add,
 	.del		= perf_trace_del,
+	.move_dup	= perf_trace_move_dup,
 	.start		= perf_swevent_start,
 	.stop		= perf_swevent_stop,
 	.read		= perf_swevent_read,
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index c79193e..58b0479 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -383,6 +383,17 @@ void perf_trace_del(struct perf_event *p_event, int flags)
 		hlist_del_rcu(&p_event->hlist_entry);
 }
 
+void perf_trace_move_dup(struct perf_event *old,
+			 struct perf_event *new)
+{
+	struct trace_event_call *tp_event = old->tp_event;
+	struct hlist_head __percpu *pcpu_list = tp_event->perf_events;
+	struct hlist_head *list = this_cpu_ptr(pcpu_list);
+
+	hlist_del_rcu(&old->hlist_entry);
+	hlist_add_head_rcu(&new->hlist_entry, list);
+}
+
 void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
 {
 	char *raw_data;
-- 
2.9.5
