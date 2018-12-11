Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2055C6783C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6386F20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Dv+dFjMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6386F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLKXeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:34:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbeLKXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:34:00 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBNUoGD019430
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:33:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=OVcPqt+jofOMEwhLLb2qDLGHFJwx2qu8RQXb9Iw0xaY=;
 b=Dv+dFjMV+6gNVaq89IpxUOV2J4/K7P/aADRx6sQddc+N4b/fmaVqeYGj7xYAY2wbpCpJ
 GcNP22/dFQrp57KCjBXIMGCLPqNZ2vF05RDKuaXZSPP1lSr1zBXM6OFea37TCDTF+AHb
 DcgZQUccmG63Gn0wlkc1z+YxZ3XHiMXzB6I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pap88g4t8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 15:33:59 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 11 Dec 2018 15:33:57 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A181762E1B75; Tue, 11 Dec 2018 15:33:55 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 perf, bpf-next 3/4] perf util: handle PERF_RECORD_BPF_EVENT
Date:   Tue, 11 Dec 2018 15:33:49 -0800
Message-ID: <20181211233351.4036381-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233351.4036381-1-songliubraving@fb.com>
References: <20181211233351.4036381-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch handles PERF_RECORD_BPF_EVENT in perf record/report.
Specifically, map and symbol are created for PERF_BPF_EVENT_PROG_LOAD,
and removed for PERF_BPF_EVENT_PROG_UNLOAD.

This patch also set perf_event_attr.bpf_event properly. The flag is
ON by default.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/Build       |  2 ++
 tools/perf/util/bpf-event.c | 66 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h | 11 +++++++
 tools/perf/util/event.c     | 23 +++++++++++++
 tools/perf/util/event.h     | 26 +++++++++++++++
 tools/perf/util/evsel.c     |  9 +++++
 tools/perf/util/evsel.h     |  1 +
 tools/perf/util/machine.c   |  3 ++
 tools/perf/util/session.c   |  4 +++
 tools/perf/util/tool.h      |  4 ++-
 10 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b7bf201fe8a8..99455f30c264 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -151,6 +151,8 @@ endif
 
 libperf-y += perf-hooks.o
 
+libperf-$(CONFIG_LIBBPF) += bpf-event.o
+
 libperf-$(CONFIG_CXX) += c++/
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
new file mode 100644
index 000000000000..2b0a45d8f1d7
--- /dev/null
+++ b/tools/perf/util/bpf-event.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <bpf/bpf.h>
+#include "bpf-event.h"
+#include "debug.h"
+#include "symbol.h"
+
+static int machine__process_bpf_prog_load(
+	struct machine *machine,
+	union perf_event *event,
+	struct perf_sample *sample __maybe_unused)
+{
+	struct symbol *sym;
+	struct map *map;
+
+	map = map_groups__find(&machine->kmaps, event->bpf_event.addr);
+	if (!map) {
+		map = dso__new_map("bpf_prog");
+		if (!map)
+			return -ENOMEM;
+
+		map->start = event->bpf_event.addr;
+		map->pgoff = map->start;
+		map->end = map->start + event->bpf_event.len;
+		map_groups__insert(&machine->kmaps, map);
+	}
+
+	sym = symbol__new(event->bpf_event.addr, event->bpf_event.len,
+			  0, 0, event->bpf_event.name);
+	if (!sym)
+		return -ENOMEM;
+	dso__insert_symbol(map->dso, sym);
+	return 0;
+}
+
+static int machine__process_bpf_prog_unload(
+	struct machine *machine,
+	union perf_event *event,
+	struct perf_sample *sample __maybe_unused)
+{
+	struct map *map;
+
+	map = map_groups__find(&machine->kmaps, event->bpf_event.addr);
+	if (map)
+		map_groups__remove(&machine->kmaps, map);
+
+	return 0;
+}
+
+int machine__process_bpf_event(struct machine *machine __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_event(event, stdout);
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		return machine__process_bpf_prog_load(machine, event, sample);
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		return machine__process_bpf_prog_unload(machine, event, sample);
+	default:
+		break;
+	}
+	return 0;
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
new file mode 100644
index 000000000000..d5ca355dd298
--- /dev/null
+++ b/tools/perf/util/bpf-event.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BPF_EVENT_H
+#define __PERF_BPF_EVENT_H
+
+#include "machine.h"
+
+int machine__process_bpf_event(struct machine *machine,
+			       union perf_event *event,
+			       struct perf_sample *sample);
+
+#endif
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index e9c108a6b1c3..de8bfbfa6860 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -24,6 +24,8 @@
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
+#include "session.h"
+#include "bpf-event.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
@@ -43,6 +45,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_SWITCH]			= "SWITCH",
 	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
+	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1335,6 +1338,14 @@ int perf_event__process_switch(struct perf_tool *tool __maybe_unused,
 	return machine__process_switch_event(machine, event);
 }
 
+int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused,
+				  struct machine *machine)
+{
+	return machine__process_bpf_event(machine, event, sample);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
@@ -1467,6 +1478,15 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
 }
 
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " bpf event with type %u, flags %u, id %u sub_id %u addr %lx len %lu name %s\n",
+		       event->bpf_event.type, event->bpf_event.flags,
+		       event->bpf_event.id, event->bpf_event.sub_id,
+		       event->bpf_event.addr, event->bpf_event.len,
+		       event->bpf_event.name);
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -1502,6 +1522,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_LOST:
 		ret += perf_event__fprintf_lost(event, fp);
 		break;
+	case PERF_RECORD_BPF_EVENT:
+		ret += perf_event__fprintf_bpf_event(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bcafbde..cea19b1b128a 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -5,6 +5,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <linux/kernel.h>
+#include <linux/bpf.h>
 
 #include "../perf.h"
 #include "build-id.h"
@@ -84,6 +85,25 @@ struct throttle_event {
 	u64 stream_id;
 };
 
+#ifndef KSYM_NAME_LEN
+#define KSYM_NAME_LEN 256
+#endif
+
+/* Record different types of bpf events, see enum perf_bpf_event_type */
+struct bpf_event {
+	struct perf_event_header header;
+	u32 type;
+	u32 flags;
+	u32 id;
+	u32 sub_id;
+
+	/* for bpf_prog types */
+	u8 tag[BPF_TAG_SIZE];  // prog tag
+	u64 addr;
+	u64 len;
+	char name[KSYM_NAME_LEN];
+};
+
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
@@ -651,6 +671,7 @@ union perf_event {
 	struct stat_round_event		stat_round;
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
+	struct bpf_event		bpf_event;
 };
 
 void perf_event__print_totals(void);
@@ -750,6 +771,10 @@ int perf_event__process_exit(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine);
+int perf_event__process_bpf_event(struct perf_tool *tool,
+				  union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine);
 int perf_tool__process_synth_event(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct machine *machine,
@@ -814,6 +839,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466db368..6e13e28c0bf0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1035,6 +1035,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap  = track;
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
+	attr->bpf_event = track && !perf_missing_features.bpf_event;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1652,6 +1653,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(context_switch, p_unsigned);
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
+	PRINT_ATTRf(bpf_event, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -1811,6 +1813,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 				     PERF_SAMPLE_BRANCH_NO_CYCLES);
 	if (perf_missing_features.group_read && evsel->attr.inherit)
 		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
+	if (perf_missing_features.bpf_event)
+		evsel->attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1955,6 +1959,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		perf_missing_features.exclude_guest = true;
 		pr_debug2("switching off exclude_guest, exclude_host\n");
 		goto fallback_missing_features;
+	} else if (!perf_missing_features.bpf_event &&
+		   evsel->attr.bpf_event) {
+		perf_missing_features.bpf_event = true;
+		pr_debug2("switching off bpf_event\n");
+		goto fallback_missing_features;
 	} else if (!perf_missing_features.sample_id_all) {
 		perf_missing_features.sample_id_all = true;
 		pr_debug2("switching off sample_id_all\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3147ca76c6fc..ee7e7cc23c6c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -168,6 +168,7 @@ struct perf_missing_features {
 	bool lbr_flags;
 	bool write_backward;
 	bool group_read;
+	bool bpf_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8f36ce813bc5..29c18989ba4f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -21,6 +21,7 @@
 #include "unwind.h"
 #include "linux/hash.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
@@ -1812,6 +1813,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_SWITCH:
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		ret = machine__process_switch_event(machine, event); break;
+	case PERF_RECORD_BPF_EVENT:
+		ret = machine__process_bpf_event(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..dffe5120d2d3 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -371,6 +371,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->itrace_start = perf_event__process_itrace_start;
 	if (tool->context_switch == NULL)
 		tool->context_switch = perf_event__process_switch;
+	if (tool->bpf_event == NULL)
+		tool->bpf_event = perf_event__process_bpf_event;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1300,6 +1302,8 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_SWITCH:
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return tool->context_switch(tool, event, sample, machine);
+	case PERF_RECORD_BPF_EVENT:
+		return tool->bpf_event(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 56e4ca54020a..69ae898ca024 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -53,7 +53,9 @@ struct perf_tool {
 			itrace_start,
 			context_switch,
 			throttle,
-			unthrottle;
+			unthrottle,
+			bpf_event;
+
 	event_attr_op	attr;
 	event_attr_op	event_update;
 	event_op2	tracing_data;
-- 
2.17.1

