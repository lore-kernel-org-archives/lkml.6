Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9339BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B23220657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MFZjKwYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfAPQaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:30:13 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfAPQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:30:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0GGU0Jx007297
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:30:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=HsY2eGbUmk2g4hjQb+qRPYs8WqLr8yWcl8o0oLJ9SsI=;
 b=MFZjKwYHDqYf6FypHX4hoxAL/nHQyhVzZShe0Bkh0n+8eF7J8zFXF4eLCoWe9hIGO07W
 yZ3xbtR0GIHwsFyg2WCYyi90BmF2Xlnf2Z7CxL4e7e8VikKY1GDQ7oiMG7yQb+z6Yu3e
 RlbqWTvhTeAW4weMAGD1DblGnChoJtsCXoc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q23b80xyg-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:30:07 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 16 Jan 2019 08:29:55 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2F84E62E1D13; Wed, 16 Jan 2019 08:29:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 perf, bpf-next 6/9] perf util: handle PERF_RECORD_BPF_EVENT
Date:   Wed, 16 Jan 2019 08:29:28 -0800
Message-ID: <20190116162931.1542429-7-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116162931.1542429-1-songliubraving@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic handling of PERF_RECORD_BPF_EVENT.
Tracking of PERF_RECORD_BPF_EVENT is OFF by default. Option --bpf-event
is added to turn it on.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |  1 +
 tools/perf/perf.h           |  1 +
 tools/perf/util/Build       |  2 ++
 tools/perf/util/bpf-event.c | 15 +++++++++++++++
 tools/perf/util/bpf-event.h | 11 +++++++++++
 tools/perf/util/event.c     | 20 ++++++++++++++++++++
 tools/perf/util/event.h     | 16 ++++++++++++++++
 tools/perf/util/evsel.c     | 11 ++++++++++-
 tools/perf/util/evsel.h     |  1 +
 tools/perf/util/machine.c   |  3 +++
 tools/perf/util/session.c   |  4 ++++
 tools/perf/util/tool.h      |  3 ++-
 12 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf-event.c
 create mode 100644 tools/perf/util/bpf-event.h

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..deaf9b902094 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1839,6 +1839,7 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
+	OPT_BOOLEAN(0, "bpf-event", &record.opts.bpf_event, "record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd128b8..5941fb6eccfc 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -66,6 +66,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
+	bool	     bpf_event;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index af72be7f5b3b..fa8305390315 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -152,6 +152,8 @@ endif
 
 libperf-y += perf-hooks.o
 
+libperf-$(CONFIG_LIBBPF) += bpf-event.o
+
 libperf-$(CONFIG_CXX) += c++/
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
new file mode 100644
index 000000000000..87004706874f
--- /dev/null
+++ b/tools/perf/util/bpf-event.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <bpf/bpf.h>
+#include "bpf-event.h"
+#include "debug.h"
+#include "symbol.h"
+
+int machine__process_bpf_event(struct machine *machine __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_event(event, stdout);
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
index 3c8a6a8dd260..3b646d27374e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -25,6 +25,7 @@
 #include "asm/bug.h"
 #include "stat.h"
 #include "session.h"
+#include "bpf-event.h"
 
 #define DEFAULT_PROC_MAP_PARSE_TIMEOUT 500
 
@@ -47,6 +48,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
+	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1339,6 +1341,14 @@ int perf_event__process_ksymbol(struct perf_tool *tool __maybe_unused,
 	return machine__process_ksymbol(machine, event, sample);
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
@@ -1479,6 +1489,13 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
 }
 
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " bpf event with type %u, flags %u, id %u\n",
+		       event->bpf_event.type, event->bpf_event.flags,
+		       event->bpf_event.id);
+}
+
 size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
@@ -1517,6 +1534,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_KSYMBOL:
 		ret += perf_event__fprintf_ksymbol(event, fp);
 		break;
+	case PERF_RECORD_BPF_EVENT:
+		ret += perf_event__fprintf_bpf_event(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 018322f2a13e..dad32b81fe71 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -98,6 +98,16 @@ struct ksymbol_event {
 	char name[KSYM_NAME_LEN];
 };
 
+struct bpf_event {
+	struct perf_event_header header;
+	u16 type;
+	u16 flags;
+	u32 id;
+
+	/* for bpf_prog types */
+	u8 tag[BPF_TAG_SIZE];  // prog tag
+};
+
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
@@ -666,6 +676,7 @@ union perf_event {
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
 	struct ksymbol_event		ksymbol_event;
+	struct bpf_event		bpf_event;
 };
 
 void perf_event__print_totals(void);
@@ -767,6 +778,10 @@ int perf_event__process_ksymbol(struct perf_tool *tool,
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
@@ -831,6 +846,7 @@ size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9c8dc6d1aa7f..684c893ca6bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1036,6 +1036,8 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
+	attr->bpf_event = track && opts->bpf_event &&
+		!perf_missing_features.bpf_event;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1654,6 +1656,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
 	PRINT_ATTRf(ksymbol, p_unsigned);
+	PRINT_ATTRf(bpf_event, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -1815,6 +1818,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		evsel->attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 	if (perf_missing_features.ksymbol)
 		evsel->attr.ksymbol = 0;
+	if (perf_missing_features.bpf_event)
+		evsel->attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
@@ -1934,7 +1939,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
+	if (!perf_missing_features.bpf_event && evsel->attr.bpf_event) {
+		perf_missing_features.bpf_event = true;
+		pr_debug2("switching off bpf_event\n");
+		goto fallback_missing_features;
+	} else if (!perf_missing_features.ksymbol && evsel->attr.ksymbol) {
 		perf_missing_features.ksymbol = true;
 		pr_debug2("switching off ksymbol\n");
 		goto fallback_missing_features;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4a8c3e7f4808..29c5eb68c44b 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -169,6 +169,7 @@ struct perf_missing_features {
 	bool write_backward;
 	bool group_read;
 	bool ksymbol;
+	bool bpf_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9bca61c7d5bf..ae85106bb5bf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -21,6 +21,7 @@
 #include "unwind.h"
 #include "linux/hash.h"
 #include "asm/bug.h"
+#include "bpf-event.h"
 
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
@@ -1867,6 +1868,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_switch_event(machine, event); break;
 	case PERF_RECORD_KSYMBOL:
 		ret = machine__process_ksymbol(machine, event, sample); break;
+	case PERF_RECORD_BPF_EVENT:
+		ret = machine__process_bpf_event(machine, event, sample); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2efa75bb0c0a..026bf04bba74 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -378,6 +378,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->context_switch = perf_event__process_switch;
 	if (tool->ksymbol == NULL)
 		tool->ksymbol = perf_event__process_ksymbol;
+	if (tool->bpf_event == NULL)
+		tool->bpf_event = perf_event__process_bpf_event;
 	if (tool->read == NULL)
 		tool->read = process_event_sample_stub;
 	if (tool->throttle == NULL)
@@ -1309,6 +1311,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->context_switch(tool, event, sample, machine);
 	case PERF_RECORD_KSYMBOL:
 		return tool->ksymbol(tool, event, sample, machine);
+	case PERF_RECORD_BPF_EVENT:
+		return tool->bpf_event(tool, event, sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9c81ca2f3cf7..250391672f9f 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -54,7 +54,8 @@ struct perf_tool {
 			context_switch,
 			throttle,
 			unthrottle,
-			ksymbol;
+			ksymbol,
+			bpf_event;
 
 	event_attr_op	attr;
 	event_attr_op	event_update;
-- 
2.17.1

