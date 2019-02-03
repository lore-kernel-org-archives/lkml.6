Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16206C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D825D2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 16:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfBCQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 11:16:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBCQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 11:16:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gqKRC-0004KU-6N; Sun, 03 Feb 2019 17:16:06 +0100
Subject: [GIT pull] perf updates for 5.0
Message-ID: <154921049412.12839.17184514592792868263.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <154921049412.12839.6903655600742454434.tglx@nanos.tec.linutronix.de>
Date:   Sun, 03 Feb 2019 17:16:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

A pile of perf updates:

  - Fix the broken sanity check in the /proc/sys/kernel/perf_cpu_time_max_percent
    write handler.

  - Cure a perf script crash which caused by an unitinialized data structure.

  - Highlight the hottest instruction in perf top and not a random one.

  - Cure yet another clang issue when building perf python

  - Handle topology entries with no CPU correctly in the tools

  - Handle perf data which contains both tracepoints and performance
    counter entries correctly.

  - Add a missing NULL pointer check in perf ordered_events_free().

Thanks,

	tglx

------------------>
Andi Kleen (1):
      perf script: Fix crash with printing mixed trace point and other events

Arnaldo Carvalho de Melo (1):
      perf python: Remove -fstack-clash-protection when building with some clang versions

He Kuang (1):
      perf top: Fix wrong hottest instruction highlighted

Jiri Olsa (1):
      perf ordered_events: Fix crash in ordered_events__free

Stephane Eranian (2):
      perf core: Fix perf_proc_update_handler() bug
      perf tools: Handle TOPOLOGY headers with no CPU

Tony Jones (1):
      perf script: Fix crash when processing recorded stat data


 kernel/events/core.c              | 14 +++++++-------
 tools/perf/builtin-script.c       |  9 +++------
 tools/perf/ui/browsers/annotate.c | 16 ++++++++++------
 tools/perf/util/cpumap.c          | 11 +++++++++--
 tools/perf/util/ordered-events.c  |  6 ++++--
 tools/perf/util/setup.py          |  2 ++
 6 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3cd13a30f732..e5ede6918050 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -436,18 +436,18 @@ int perf_proc_update_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos)
 {
-	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-
-	if (ret || !write)
-		return ret;
-
+	int ret;
+	int perf_cpu = sysctl_perf_cpu_time_max_percent;
 	/*
 	 * If throttling is disabled don't allow the write:
 	 */
-	if (sysctl_perf_cpu_time_max_percent == 100 ||
-	    sysctl_perf_cpu_time_max_percent == 0)
+	if (write && (perf_cpu == 100 || perf_cpu == 0))
 		return -EINVAL;
 
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
 	max_samples_per_tick = DIV_ROUND_UP(sysctl_perf_event_sample_rate, HZ);
 	perf_sample_period_ns = NSEC_PER_SEC / sysctl_perf_event_sample_rate;
 	update_perf_cpu_limits();
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d079f36d342d..ac221f137ed2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,13 +1681,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 		.force_header = false,
 	};
 	struct perf_evsel *ev2;
-	static bool init;
 	u64 val;
 
-	if (!init) {
-		perf_stat__init_shadow_stats();
-		init = true;
-	}
 	if (!evsel->stats)
 		perf_evlist__alloc_stats(script->session->evlist, false);
 	if (evsel_script(evsel->leader)->gnum++ == 0)
@@ -1794,7 +1789,7 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE)) {
+	if (PRINT_FIELD(TRACE) && sample->raw_data) {
 		event_format__fprintf(evsel->tp_format, sample->cpu,
 				      sample->raw_data, sample->raw_size, fp);
 	}
@@ -2359,6 +2354,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 1d00e5ec7906..82e16bf84466 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -224,20 +224,24 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
+static double disasm__cmp(struct annotation_line *a, struct annotation_line *b,
+						  int percent_type)
 {
 	int i;
 
 	for (i = 0; i < a->data_nr; i++) {
-		if (a->data[i].percent == b->data[i].percent)
+		if (a->data[i].percent[percent_type] == b->data[i].percent[percent_type])
 			continue;
-		return a->data[i].percent < b->data[i].percent;
+		return a->data[i].percent[percent_type] -
+			   b->data[i].percent[percent_type];
 	}
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al)
+static void disasm_rb_tree__insert(struct annotate_browser *browser,
+				struct annotation_line *al)
 {
+	struct rb_root *root = &browser->entries;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct annotation_line *l;
@@ -246,7 +250,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 		parent = *p;
 		l = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (disasm__cmp(al, l))
+		if (disasm__cmp(al, l, browser->opts->percent_type) < 0)
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -329,7 +333,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, &pos->al);
+		disasm_rb_tree__insert(browser, &pos->al);
 	}
 	pthread_mutex_unlock(&notes->lock);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd3342069..383674f448fc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -134,7 +134,12 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 	if (!cpu_list)
 		return cpu_map__read_all_cpu_map();
 
-	if (!isdigit(*cpu_list))
+	/*
+	 * must handle the case of empty cpumap to cover
+	 * TOPOLOGY header for NUMA nodes with no CPU
+	 * ( e.g., because of CPU hotplug)
+	 */
+	if (!isdigit(*cpu_list) && *cpu_list != '\0')
 		goto out;
 
 	while (isdigit(*cpu_list)) {
@@ -181,8 +186,10 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 
 	if (nr_cpus > 0)
 		cpus = cpu_map__trim_new(nr_cpus, tmp_cpus);
-	else
+	else if (*cpu_list != '\0')
 		cpus = cpu_map__default_new();
+	else
+		cpus = cpu_map__dummy_new();
 invalid:
 	free(tmp_cpus);
 out:
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 63f758c655d5..64d1f36dee99 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -17,6 +17,8 @@ if cc == "clang":
             vars[var] = sub("-mcet", "", vars[var])
         if not clang_has_option("-fcf-protection"):
             vars[var] = sub("-fcf-protection", "", vars[var])
+        if not clang_has_option("-fstack-clash-protection"):
+            vars[var] = sub("-fstack-clash-protection", "", vars[var])
 
 from distutils.core import setup, Extension
 

