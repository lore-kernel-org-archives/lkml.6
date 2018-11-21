Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1912151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j7MpPsO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1912151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbeKVGbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:31:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48610 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387514AbeKVGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:31:24 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wALJrvxk026815
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jR8aU5G0D0Zon5mwVKCuyeBXl0fXgQz1+uBhguKyJaA=;
 b=j7MpPsO/bLzTS88yeWkBYZ+qkNA0UuiAKYEgtSBC7nPk5DBbBadRIRcBp6+FsRq5ltI3
 a67c8oM+jfa/tyfUnxtuLsEAHAIFDJ0DrfpPuR0nw6JbwSGEcHQ7hF7vTxWitzdMUWpW
 RbdCwQZamYHBomEcERAXAxeWcPGNSGiqcOw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2nwccr8bam-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 11:55:41 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 21 Nov 2018 11:55:38 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1A76562E1AB3; Wed, 21 Nov 2018 11:55:34 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <acme@kernel.org>, <peterz@infradead.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH perf,bpf 3/5] perf util: basic handling of PERF_RECORD_BPF_EVENT
Date:   Wed, 21 Nov 2018 11:55:00 -0800
Message-ID: <20181121195502.3259930-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121195502.3259930-1-songliubraving@fb.com>
References: <20181121195502.3259930-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic handling of PERF_RECORD_BPF_EVENT in perf util.
Following patches add more logic that leverages these events.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/event.c   | 20 ++++++++++++++++++++
 tools/perf/util/event.h   | 15 +++++++++++++++
 tools/perf/util/evsel.c   |  1 +
 tools/perf/util/machine.c | 10 ++++++++++
 tools/perf/util/machine.h |  2 ++
 tools/perf/util/session.c |  4 ++++
 tools/perf/util/tool.h    |  4 +++-
 7 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..04104a4ffe93 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -24,6 +24,7 @@
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
+#include "session.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
@@ -43,6 +44,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_SWITCH]			= "SWITCH",
 	[PERF_RECORD_SWITCH_CPU_WIDE]		= "SWITCH_CPU_WIDE",
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
+	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1333,6 +1335,14 @@ int perf_event__process_switch(struct perf_tool *tool __maybe_unused,
 	return machine__process_switch_event(machine, event);
 }
 
+int perf_event__process_bpf_event(struct perf_tool *tool __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused,
+				  struct machine *machine)
+{
+	return machine__process_bpf_event(machine, event);
+}
+
 size_t perf_event__fprintf_mmap(union perf_event *event, FILE *fp)
 {
 	return fprintf(fp, " %d/%d: [%#" PRIx64 "(%#" PRIx64 ") @ %#" PRIx64 "]: %c %s\n",
@@ -1465,6 +1475,13 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 	return fprintf(fp, " lost %" PRIu64 "\n", event->lost.lost);
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
@@ -1500,6 +1517,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
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
index bfa60bcafbde..13a0c64dd0ed 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -84,6 +84,15 @@ struct throttle_event {
 	u64 stream_id;
 };
 
+
+/* Record different types of bpf events, see enum perf_bpf_event_type */
+struct bpf_event {
+	struct perf_event_header header;
+	u16 type;
+	u16 flags;
+	u32 id;
+};
+
 #define PERF_SAMPLE_MASK				\
 	(PERF_SAMPLE_IP | PERF_SAMPLE_TID |		\
 	 PERF_SAMPLE_TIME | PERF_SAMPLE_ADDR |		\
@@ -651,6 +660,7 @@ union perf_event {
 	struct stat_round_event		stat_round;
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
+	struct bpf_event		bpf_event;
 };
 
 void perf_event__print_totals(void);
@@ -750,6 +760,10 @@ int perf_event__process_exit(struct perf_tool *tool,
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
@@ -814,6 +828,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cb7f01059940..af9d539e4b6a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1635,6 +1635,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(context_switch, p_unsigned);
 	PRINT_ATTRf(write_backward, p_unsigned);
 	PRINT_ATTRf(namespaces, p_unsigned);
+	PRINT_ATTRf(bpf_event, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..74c295f6fdc4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -681,6 +681,14 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+int machine__process_bpf_event(struct machine *machine __maybe_unused,
+			       union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_event(event, stdout);
+	return 0;
+}
+
 static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
 {
 	const char *dup_filename;
@@ -1795,6 +1803,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_SWITCH:
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		ret = machine__process_switch_event(machine, event); break;
+	case PERF_RECORD_BPF_EVENT:
+		ret = machine__process_bpf_event(machine, event); break;
 	default:
 		ret = -1;
 		break;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..0ed237d6fd0a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -127,6 +127,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
 				 struct perf_sample *sample);
+int machine__process_bpf_event(struct machine *machine,
+			       union perf_event *event);
 int machine__process_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 
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

