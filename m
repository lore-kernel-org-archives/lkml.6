Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547B920863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBHR5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:57:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:40733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbfBHR4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:56:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 09:56:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="142716523"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2019 09:56:46 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net, vbabka@suse.cz,
        will.deacon@arm.com, kirill@shutemov.name,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 12/14] perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Fri,  8 Feb 2019 09:55:07 -0800
Message-Id: <1549648509-12704-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
References: <1549648509-12704-1-git-send-email-kan.liang@linux.intel.com>
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

No changes since V4

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
index a8b7a84..c299b20 100644
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
+	PERF_OUTPUT_COMM            = 1ULL << 0,
+	PERF_OUTPUT_TID             = 1ULL << 1,
+	PERF_OUTPUT_PID             = 1ULL << 2,
+	PERF_OUTPUT_TIME            = 1ULL << 3,
+	PERF_OUTPUT_CPU             = 1ULL << 4,
+	PERF_OUTPUT_EVNAME          = 1ULL << 5,
+	PERF_OUTPUT_TRACE           = 1ULL << 6,
+	PERF_OUTPUT_IP              = 1ULL << 7,
+	PERF_OUTPUT_SYM             = 1ULL << 8,
+	PERF_OUTPUT_DSO             = 1ULL << 9,
+	PERF_OUTPUT_ADDR            = 1ULL << 10,
+	PERF_OUTPUT_SYMOFFSET       = 1ULL << 11,
+	PERF_OUTPUT_SRCLINE         = 1ULL << 12,
+	PERF_OUTPUT_PERIOD          = 1ULL << 13,
+	PERF_OUTPUT_IREGS	    = 1ULL << 14,
+	PERF_OUTPUT_BRSTACK	    = 1ULL << 15,
+	PERF_OUTPUT_BRSTACKSYM	    = 1ULL << 16,
+	PERF_OUTPUT_DATA_SRC	    = 1ULL << 17,
+	PERF_OUTPUT_WEIGHT	    = 1ULL << 18,
+	PERF_OUTPUT_BPF_OUTPUT	    = 1ULL << 19,
+	PERF_OUTPUT_CALLINDENT	    = 1ULL << 20,
+	PERF_OUTPUT_INSN	    = 1ULL << 21,
+	PERF_OUTPUT_INSNLEN	    = 1ULL << 22,
+	PERF_OUTPUT_BRSTACKINSN	    = 1ULL << 23,
+	PERF_OUTPUT_BRSTACKOFF	    = 1ULL << 24,
+	PERF_OUTPUT_SYNTH           = 1ULL << 25,
+	PERF_OUTPUT_PHYS_ADDR       = 1ULL << 26,
+	PERF_OUTPUT_UREGS	    = 1ULL << 27,
+	PERF_OUTPUT_METRIC	    = 1ULL << 28,
+	PERF_OUTPUT_MISC            = 1ULL << 29,
+	PERF_OUTPUT_SRCCODE	    = 1ULL << 30,
+	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 31,
+	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 32,
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
@@ -1851,6 +1856,9 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(DATA_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->data_page_size, str));
 
+	if (PRINT_FIELD(CODE_PAGE_SIZE))
+		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
+
 	fprintf(fp, "\n");
 
 	if (PRINT_FIELD(SRCCODE)) {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3d86afd..4e7dd45 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1143,6 +1143,9 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		printf(" .. data page size: %s\n", get_page_size_name(sample->data_page_size, str));
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		printf(" .. code page size: %s\n", get_page_size_name(sample->code_page_size, str));
+
 	if (sample_type & PERF_SAMPLE_TRANSACTION)
 		printf("... transaction: %" PRIx64 "\n", sample->transaction);
 
-- 
2.7.4

