Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B5CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721F921939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfAaU3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:29:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:4802 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbfAaU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:28:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:28:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="143176554"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 12:28:51 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 03/13] perf script: Support data page size
Date:   Thu, 31 Jan 2019 12:27:56 -0800
Message-Id: <1548966486-49963-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Display the data page size if it is available.

Can be configured by the user, for example:
  perf script --fields comm,event,phys_addr,data_page_size
            dtlb mem-loads:uP:        3fec82ea8 4K
            dtlb mem-loads:uP:        3fec82e90 4K
            dtlb mem-loads:uP:        3e23700a4 4K
            dtlb mem-loads:uP:        3fec82f20 4K
            dtlb mem-loads:uP:        3e23700a4 4K
            dtlb mem-loads:uP:        3b4211bec 4K
            dtlb mem-loads:uP:        382205dc0 2M
            dtlb mem-loads:uP:        36fa082c0 2M
            dtlb mem-loads:uP:        377607340 2M
            dtlb mem-loads:uP:        330010180 2M
            dtlb mem-loads:uP:        33200fd80 2M
            dtlb mem-loads:uP:        31b012b80 2M

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3
- Use the real page size to replace enum.
- Modify the get_page_size_name()

 tools/perf/Documentation/perf-script.txt |  5 +++--
 tools/perf/builtin-script.c              | 19 +++++++++++++++++--
 tools/perf/util/event.h                  |  3 +++
 tools/perf/util/session.c                | 23 +++++++++++++++++++++++
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 9e4def0..14ae84c1 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -116,8 +116,9 @@ OPTIONS
 --fields::
         Comma separated list of fields to print. Options are:
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
-        srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output, brstackinsn,
-        brstackoff, callindent, insn, insnlen, synth, phys_addr, metric, misc, srccode.
+        srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
+        brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
+        metric, misc, srccode, data_page_size.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d079f36..440ae80 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -27,6 +27,7 @@
 #include "util/thread-stack.h"
 #include "util/time-utils.h"
 #include "util/path.h"
+#include "util/event.h"
 #include "print_binary.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
@@ -97,6 +98,7 @@ enum perf_output_field {
 	PERF_OUTPUT_METRIC	    = 1U << 28,
 	PERF_OUTPUT_MISC            = 1U << 29,
 	PERF_OUTPUT_SRCCODE	    = 1U << 30,
+	PERF_OUTPUT_DATA_PAGE_SIZE  = 1U << 31,
 };
 
 struct output_option {
@@ -134,6 +136,7 @@ struct output_option {
 	{.str = "metric", .field = PERF_OUTPUT_METRIC},
 	{.str = "misc", .field = PERF_OUTPUT_MISC},
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
+	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
 };
 
 enum {
@@ -204,7 +207,8 @@ static struct {
 			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
 			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
-			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR,
+			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
+			      PERF_OUTPUT_DATA_PAGE_SIZE,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -468,6 +472,11 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					PERF_OUTPUT_PHYS_ADDR))
 		return -EINVAL;
 
+	if (PRINT_FIELD(DATA_PAGE_SIZE) &&
+		perf_evsel__check_stype(evsel, PERF_SAMPLE_DATA_PAGE_SIZE, "DATA_PAGE_SIZE",
+					PERF_OUTPUT_DATA_PAGE_SIZE))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -1762,6 +1771,7 @@ static void process_event(struct perf_script *script,
 	unsigned int type = output_type(attr->type);
 	struct perf_evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
+	char str[PAGE_SIZE_NAME_LEN];
 
 	if (output[type].fields == 0)
 		return;
@@ -1842,6 +1852,10 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(PHYS_ADDR))
 		fprintf(fp, "%16" PRIx64, sample->phys_addr);
+
+	if (PRINT_FIELD(DATA_PAGE_SIZE))
+		fprintf(fp, " %s", get_page_size_name(sample->data_page_size, str));
+
 	fprintf(fp, "\n");
 
 	if (PRINT_FIELD(SRCCODE)) {
@@ -3337,7 +3351,8 @@ int cmd_script(int argc, const char **argv)
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
-		     "callindent,insn,insnlen,synth,phys_addr,metric,misc",
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,"
+		     "data_page_size",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 53d1a41..7ef06fc 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -846,4 +846,7 @@ extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
 extern unsigned int proc_map_timeout;
 
+#define PAGE_SIZE_NAME_LEN	10
+char *get_page_size_name(u64 size, char *str);
+
 #endif /* __PERF_RECORD_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 24fd625..9ad3686 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1082,10 +1082,30 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
 	       event->header.size, perf_event__name(event->header.type));
 }
 
+char *get_page_size_name(u64 size, char *str)
+{
+	const char suffixes[5] = { 'B', 'K', 'M', 'G', 'T' };
+	int i;
+
+	if (size == 0) {
+		snprintf(str, PAGE_SIZE_NAME_LEN, "%s", "N/A");
+		return str;
+	}
+	for (i = 0; i < 5; i++) {
+		if (size < 1024)
+			break;
+		size /= 1024;
+	}
+
+	snprintf(str, PAGE_SIZE_NAME_LEN, "%lu%c", size, suffixes[i]);
+	return str;
+}
+
 static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 			struct perf_sample *sample)
 {
 	u64 sample_type;
+	char str[PAGE_SIZE_NAME_LEN];
 
 	if (!dump_trace)
 		return;
@@ -1120,6 +1140,9 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
 		printf(" .. phys_addr: 0x%"PRIx64"\n", sample->phys_addr);
 
+	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size, str));
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
-- 
2.7.4

