Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D40C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A357720989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfAURGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:06:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:19647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfAURGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:06:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 09:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="111540193"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2019 09:06:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 10/12] perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 21 Jan 2019 09:05:16 -0800
Message-Id: <1548090318-19149-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
References: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Add a new perf script filter called code_page_size. There will be more
than 32 filters. Extend the enum perf_output_field from U to UL.
Display sampled code page sizes when PERF_SAMPLE_CODE_PAGE_SIZE was set.

For example,
perf script --fields comm,event,ip,code_page_size
            dtlb mem-loads:uP:            445777 4K
            dtlb mem-loads:uP:            40f724 4K
            dtlb mem-loads:uP:            474926 4K
            dtlb mem-loads:uP:            401075 4K
            dtlb mem-loads:uP:            401095 4K
            dtlb mem-loads:uP:            401095 4K
            dtlb mem-loads:uP:            4010cc 4K
            dtlb mem-loads:uP:            440b6f 4K

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 76 ++++++++++++++++++--------------
 tools/perf/util/session.c                |  3 ++
 3 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 14ae84c1..08c6deb 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -118,7 +118,7 @@ OPTIONS
         comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackoff, callindent, insn, insnlen, synth, phys_addr,
-        metric, misc, srccode, data_page_size.
+        metric, misc, srccode, data_page_size, code_page_size.
         Field list can be prepended with the type, trace, sw or hw,
         to indicate to which event type the field list applies.
         e.g., -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trace
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 0aa55ca..9a7d93b8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -67,38 +67,39 @@ static int			max_blocks;
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 enum perf_output_field {
-	PERF_OUTPUT_COMM            = 1U << 0,
-	PERF_OUTPUT_TID             = 1U << 1,
-	PERF_OUTPUT_PID             = 1U << 2,
-	PERF_OUTPUT_TIME            = 1U << 3,
-	PERF_OUTPUT_CPU             = 1U << 4,
-	PERF_OUTPUT_EVNAME          = 1U << 5,
-	PERF_OUTPUT_TRACE           = 1U << 6,
-	PERF_OUTPUT_IP              = 1U << 7,
-	PERF_OUTPUT_SYM             = 1U << 8,
-	PERF_OUTPUT_DSO             = 1U << 9,
-	PERF_OUTPUT_ADDR            = 1U << 10,
-	PERF_OUTPUT_SYMOFFSET       = 1U << 11,
-	PERF_OUTPUT_SRCLINE         = 1U << 12,
-	PERF_OUTPUT_PERIOD          = 1U << 13,
-	PERF_OUTPUT_IREGS	    = 1U << 14,
-	PERF_OUTPUT_BRSTACK	    = 1U << 15,
-	PERF_OUTPUT_BRSTACKSYM	    = 1U << 16,
-	PERF_OUTPUT_DATA_SRC	    = 1U << 17,
-	PERF_OUTPUT_WEIGHT	    = 1U << 18,
-	PERF_OUTPUT_BPF_OUTPUT	    = 1U << 19,
-	PERF_OUTPUT_CALLINDENT	    = 1U << 20,
-	PERF_OUTPUT_INSN	    = 1U << 21,
-	PERF_OUTPUT_INSNLEN	    = 1U << 22,
-	PERF_OUTPUT_BRSTACKINSN	    = 1U << 23,
-	PERF_OUTPUT_BRSTACKOFF	    = 1U << 24,
-	PERF_OUTPUT_SYNTH           = 1U << 25,
-	PERF_OUTPUT_PHYS_ADDR       = 1U << 26,
-	PERF_OUTPUT_UREGS	    = 1U << 27,
-	PERF_OUTPUT_METRIC	    = 1U << 28,
-	PERF_OUTPUT_MISC            = 1U << 29,
-	PERF_OUTPUT_SRCCODE	    = 1U << 30,
-	PERF_OUTPUT_DATA_PAGE_SIZE  = 1U << 31,
+	PERF_OUTPUT_COMM            = 1UL << 0,
+	PERF_OUTPUT_TID             = 1UL << 1,
+	PERF_OUTPUT_PID             = 1UL << 2,
+	PERF_OUTPUT_TIME            = 1UL << 3,
+	PERF_OUTPUT_CPU             = 1UL << 4,
+	PERF_OUTPUT_EVNAME          = 1UL << 5,
+	PERF_OUTPUT_TRACE           = 1UL << 6,
+	PERF_OUTPUT_IP              = 1UL << 7,
+	PERF_OUTPUT_SYM             = 1UL << 8,
+	PERF_OUTPUT_DSO             = 1UL << 9,
+	PERF_OUTPUT_ADDR            = 1UL << 10,
+	PERF_OUTPUT_SYMOFFSET       = 1UL << 11,
+	PERF_OUTPUT_SRCLINE         = 1UL << 12,
+	PERF_OUTPUT_PERIOD          = 1UL << 13,
+	PERF_OUTPUT_IREGS	    = 1UL << 14,
+	PERF_OUTPUT_BRSTACK	    = 1UL << 15,
+	PERF_OUTPUT_BRSTACKSYM	    = 1UL << 16,
+	PERF_OUTPUT_DATA_SRC	    = 1UL << 17,
+	PERF_OUTPUT_WEIGHT	    = 1UL << 18,
+	PERF_OUTPUT_BPF_OUTPUT	    = 1UL << 19,
+	PERF_OUTPUT_CALLINDENT	    = 1UL << 20,
+	PERF_OUTPUT_INSN	    = 1UL << 21,
+	PERF_OUTPUT_INSNLEN	    = 1UL << 22,
+	PERF_OUTPUT_BRSTACKINSN	    = 1UL << 23,
+	PERF_OUTPUT_BRSTACKOFF	    = 1UL << 24,
+	PERF_OUTPUT_SYNTH           = 1UL << 25,
+	PERF_OUTPUT_PHYS_ADDR       = 1UL << 26,
+	PERF_OUTPUT_UREGS	    = 1UL << 27,
+	PERF_OUTPUT_METRIC	    = 1UL << 28,
+	PERF_OUTPUT_MISC            = 1UL << 29,
+	PERF_OUTPUT_SRCCODE	    = 1UL << 30,
+	PERF_OUTPUT_DATA_PAGE_SIZE  = 1UL << 31,
+	PERF_OUTPUT_CODE_PAGE_SIZE  = 1UL << 32,
 };
 
 struct output_option {
@@ -137,6 +138,7 @@ struct output_option {
 	{.str = "misc", .field = PERF_OUTPUT_MISC},
 	{.str = "srccode", .field = PERF_OUTPUT_SRCCODE},
 	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
+	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
 };
 
 enum {
@@ -208,7 +210,7 @@ static struct {
 			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD |
 			      PERF_OUTPUT_ADDR | PERF_OUTPUT_DATA_SRC |
 			      PERF_OUTPUT_WEIGHT | PERF_OUTPUT_PHYS_ADDR |
-			      PERF_OUTPUT_DATA_PAGE_SIZE,
+			      PERF_OUTPUT_DATA_PAGE_SIZE | PERF_OUTPUT_CODE_PAGE_SIZE,
 
 		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
 	},
@@ -475,7 +477,10 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 	if (PRINT_FIELD(DATA_PAGE_SIZE) &&
 		perf_evsel__check_stype(evsel, PERF_SAMPLE_DATA_PAGE_SIZE, "DATA_PAGE_SIZE",
 					PERF_OUTPUT_DATA_PAGE_SIZE))
-		return -EINVAL;
+	if (PRINT_FIELD(CODE_PAGE_SIZE) &&
+		perf_evsel__check_stype(evsel, PERF_SAMPLE_CODE_PAGE_SIZE, "CODE_PAGE_SIZE",
+					PERF_OUTPUT_CODE_PAGE_SIZE))
+			return -EINVAL;
 
 	return 0;
 }
@@ -1855,6 +1860,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(DATA_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->data_page_size));
 
+	if (PRINT_FIELD(CODE_PAGE_SIZE))
+		fprintf(fp, " %s", get_page_size_name(sample->code_page_size));
+
 	fprintf(fp, "\n");
 
 	if (PRINT_FIELD(SRCCODE)) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3401ff9..67e0436 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1136,6 +1136,9 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size));
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		printf(" .. code page size: %s\n", get_page_size_name(sample->code_page_size));
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
-- 
2.7.4

