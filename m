Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A2BC37124
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90522063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115135;
	bh=+Jbwzs5jdOsW3epYhROMLZjoA+AIs3D7hDuiPqN3fLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ujVWhvrjzrqKl/ae4ox7/fOUszWqVXp/0dPF3kvim/YV2frlT0XGih8omP1XngMDQ
	 V6X8HkkTRwWqmSjItZa8XIYaxGwIxTY1EwgpCFveENcCm3KrXcQOSpGKC73AzmO/Ah
	 wGeRLCYHot1TijRujFkaRSJXmakH6dvDZ6nNX4XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfAUX6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E239217F5;
        Mon, 21 Jan 2019 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115129;
        bh=+Jbwzs5jdOsW3epYhROMLZjoA+AIs3D7hDuiPqN3fLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=082YSQiyZiFb2yy7kL8x21jhX1nk8jhMcMZrOz5v8wy1wkKQlADVWg7cm9eH7kLDq
         ihQgOnfySDtPWRAV7udRHxsDeiie7p5cvBAdrtGnsMyBvEjeeaE5aay/PW7ZJ+Wy6w
         g3aowPQnE785TUI6pAgGR+SHblC2Jq7Kv82cKV50=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        netdev@vger.kernel.org
Subject: [PATCH 18/24] perf tools: Handle PERF_RECORD_KSYMBOL
Date:   Mon, 21 Jan 2019 20:57:00 -0300
Message-Id: <20190121235706.20005-19-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

This patch handles PERF_RECORD_KSYMBOL in perf record/report.
Specifically, map and symbol are created for ksymbol register, and
removed for ksymbol unregister.

This patch also sets perf_event_attr.ksymbol properly. The flag is ON by
default.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-6-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c   | 21 +++++++++++++++
 tools/perf/util/event.h   | 20 ++++++++++++++
 tools/perf/util/evsel.c   | 10 ++++++-
 tools/perf/util/evsel.h   |  1 +
 tools/perf/util/machine.c | 55 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/machine.h |  3 +++
 tools/perf/util/session.c |  4 +++
 tools/perf/util/tool.h    |  4 ++-
 8 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 937a5a4f71cc..3c8a6a8dd260 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -24,6 +24,7 @@
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
+#include "session.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -45,6 +46,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_SWITCH]			= "SWITCH",
 	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
+	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1329,6 +1331,14 @@ int perf_event__process_switch(struct perf_tool *tool __maybe_unused,
 	return machine__process_switch_event(machine, event);
 }
 
+int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
+				union perf_event *event,
+				struct perf_sample *sample __maybe_unused,
+				struct machine *machine)
+{
+	return machine__process_ksymbol(machine, event, sample);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
@@ -1461,6 +1471,14 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
 }
 
+size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " ksymbol event with addr %lx len %u type %u flags 0x%x name %s\n",
+		       event->ksymbol_event.addr, event->ksymbol_event.len,
+		       event->ksymbol_event.ksym_type,
+		       event->ksymbol_event.flags, event->ksymbol_event.name);
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -1496,6 +1514,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_LOST:
 		ret += perf_event__fprintf_lost(event, fp);
 		break;
+	case PERF_RECORD_KSYMBOL:
+		ret += perf_event__fprintf_ksymbol(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb95f3384958..018322f2a13e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -5,6 +5,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <linux/kernel.h>
+#include <linux/bpf.h>
 
 #include "../perf.h"
 #include "build-id.h"
@@ -84,6 +85,19 @@ struct throttle_event {
 	u64 stream_id;
 };
 
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+struct ksymbol_event {
+	struct perf_event_header header;
+	u64 addr;
+	u32 len;
+	u16 ksym_type;
+	u16 flags;
+	char name[KSYM_NAME_LEN];
+};
+
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
@@ -651,6 +665,7 @@ union perf_event {
 	struct stat_round_event		stat_round;
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
+	struct ksymbol_event		ksymbol_event;
 };
 
 void perf_event__print_totals(void);
@@ -748,6 +763,10 @@ int perf_event__process_exit(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__process_ksymbol(struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine);
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
@@ -811,6 +830,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466db368..9c8dc6d1aa7f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1035,6 +1035,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap  = track;
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
+	attr->ksymbol = track && !perf_missing_features.ksymbol;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1652,6 +1653,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(context_switch, p_unsigned);
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
+	PRINT_ATTRf(ksymbol, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -1811,6 +1813,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
 	if (perf_missing_features.group_read && evsel->attr.inherit)
 		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
+	if (perf_missing_features.ksymbol)
+		evsel->attr.ksymbol = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1930,7 +1934,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.write_backward && evsel->attr.write_backward) {
+	if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
+		perf_missing_features.ksymbol = true;
+		pr_debug2("switching off ksymbol\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.write_backward && evsel->attr.write_backward) {
 		perf_missing_features.write_backward = true;
 		pr_debug2("switching off write_backward\n");
 		goto out_close;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 82a289ce8b0c..4a8c3e7f4808 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -168,6 +168,7 @@ struct perf_missing_features {
 	bool lbr_flags;
 	bool write_backward;
 	bool group_read;
+	bool ksymbol;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 143f7057d581..9bca61c7d5bf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -681,6 +681,59 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int machine__process_ksymbol_register(struct machine *machine,
+					     union perf_event *event,
+					     struct perf_sample *sample __maybe_unused)
+{
+	struct symbol *sym;
+	struct map *map;
+
+	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	if (!map) {
+		map = dso__new_map(event->ksymbol_event.name);
+		if (!map)
+			return -ENOMEM;
+
+		map->start = event->ksymbol_event.addr;
+		map->pgoff = map->start;
+		map->end = map->start + event->ksymbol_event.len;
+		map_groups__insert(&machine->kmaps, map);
+	}
+
+	sym = symbol__new(event->ksymbol_event.addr, event->ksymbol_event.len,
+			  0, 0, event->ksymbol_event.name);
+	if (!sym)
+		return -ENOMEM;
+	dso__insert_symbol(map->dso, sym);
+	return 0;
+}
+
+static int machine__process_ksymbol_unregister(struct machine *machine,
+					       union perf_event *event,
+					       struct perf_sample *sample __maybe_unused)
+{
+	struct map *map;
+
+	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
+	if (map)
+		map_groups__remove(&machine->kmaps, map);
+
+	return 0;
+}
+
+int machine__process_ksymbol(struct machine *machine __maybe_unused,
+			     union perf_event *event,
+			     struct perf_sample *sample)
+{
+	if (dump_trace)
+		perf_event__fprintf_ksymbol(event, stdout);
+
+	if (event->ksymbol_event.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
+		return machine__process_ksymbol_unregister(machine, event,
+							   sample);
+	return machine__process_ksymbol_register(machine, event, sample);
+}
+
 static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
 {
 	const char *dup_filename;
@@ -1812,6 +1865,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_SWITCH:
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		ret = machine__process_switch_event(machine, event); break;
+	case PERF_RECORD_KSYMBOL:
+		ret = machine__process_ksymbol(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index a5d1da60f751..4ecd380ce1b4 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -130,6 +130,9 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
 				 struct perf_sample *sample);
+int machine__process_ksymbol(struct machine *machine,
+			     union perf_event *event,
+			     struct perf_sample *sample);
 int machine__process_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b26bc9c54200..dcfacfb036a3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -379,6 +379,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->itrace_start = perf_event__process_itrace_start;
 	if (tool->context_switch == NULL)
 		tool->context_switch = perf_event__process_switch;
+	if (tool->ksymbol == NULL)
+		tool->ksymbol = perf_event__process_ksymbol;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1310,6 +1312,8 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_SWITCH:
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return tool->context_switch(tool, event, sample, machine);
+	case PERF_RECORD_KSYMBOL:
+		return tool->ksymbol(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 56e4ca54020a..9c81ca2f3cf7 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -53,7 +53,9 @@ struct perf_tool {
 			itrace_start,
 			context_switch,
 			throttle,
-			unthrottle;
+			unthrottle,
+			ksymbol;
+
 	event_attr_op	attr;
 	event_attr_op	event_update;
 	event_op2	tracing_data;
-- 
2.20.1

