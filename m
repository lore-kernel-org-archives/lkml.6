Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D28C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8526223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8526223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeHJQH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:07:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:31368 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbeHJQHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 06:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,219,1531810800"; 
   d="scan'208";a="80633157"
Received: from otc-lr-04.jf.intel.com ([10.54.39.114])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2018 06:37:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RFC 5/7] perf mem: Clean up output format and sort order string
Date:   Fri, 10 Aug 2018 06:36:25 -0700
Message-Id: <1533908187-25204-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
References: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Now, "--phys-data" is the only option which impacts the output format and
sort order. A simple "if else" is enough to handle the option.
But there will be more options added, e.g. "--page-size", which also
impact the output format and sort order. The code will become too
complex to be maintained.

Divide the big printf into several small pieces. Output the specific
piece only if the related option is applied.

Divide the big sort order string into several small pieces as well.
Appends specific sort string only if the related option is applied.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-mem.c | 132 +++++++++++++++++++++++------------------------
 tools/perf/util/sort.h   |   2 +
 2 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 57393e9..6048fca 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -14,6 +14,7 @@
 #include "util/mem-events.h"
 #include "util/debug.h"
 #include "util/symbol.h"
+#include "util/sort.h"
 
 #define MEM_OPERATION_LOAD	0x1
 #define MEM_OPERATION_STORE	0x2
@@ -153,7 +154,7 @@ dump_raw_samples(struct perf_tool *tool,
 {
 	struct perf_mem *mem = container_of(tool, struct perf_mem, tool);
 	struct addr_location al;
-	const char *fmt;
+	const char *fmt, *field_sep;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		fprintf(stderr, "problem processing %d event, skipping it.\n",
@@ -167,60 +168,45 @@ dump_raw_samples(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
-	if (mem->phys_addr) {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
-			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
-			      "%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
-
-		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->phys_addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+	field_sep = symbol_conf.field_sep;
+	if (field_sep) {
+		fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s";
 	} else {
-		if (symbol_conf.field_sep) {
-			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
-			      "%s0x%"PRIx64"%s%s:%s\n";
-		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
-			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
-			symbol_conf.field_sep = " ";
-		}
+		fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64"%s";
+		symbol_conf.field_sep = " ";
+	}
+	printf(fmt,
+		sample->pid,
+		symbol_conf.field_sep,
+		sample->tid,
+		symbol_conf.field_sep,
+		sample->ip,
+		symbol_conf.field_sep,
+		sample->addr,
+		symbol_conf.field_sep);
 
+	if (mem->phys_addr) {
+		if (field_sep)
+			fmt = "0x%"PRIx64"%s";
+		else
+			fmt = "0x%016"PRIx64"%s";
 		printf(fmt,
-			sample->pid,
-			symbol_conf.field_sep,
-			sample->tid,
-			symbol_conf.field_sep,
-			sample->ip,
-			symbol_conf.field_sep,
-			sample->addr,
-			symbol_conf.field_sep,
-			sample->weight,
-			symbol_conf.field_sep,
-			sample->data_src,
-			symbol_conf.field_sep,
-			al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
-			al.sym ? al.sym->name : "???");
+			sample->phys_addr,
+			symbol_conf.field_sep);
 	}
+
+	if (field_sep)
+		fmt = "%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
+	else
+		fmt = "%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
+
+	printf(fmt,
+		sample->weight,
+		symbol_conf.field_sep,
+		sample->data_src,
+		symbol_conf.field_sep,
+		al.map ? (al.map->dso ? al.map->dso->long_name : "???") : "???",
+		al.sym ? al.sym->name : "???");
 out_put:
 	addr_location__put(&al);
 	return 0;
@@ -262,10 +248,12 @@ static int report_raw_events(struct perf_mem *mem)
 	if (ret < 0)
 		goto out_delete;
 
+	printf("# PID, TID, IP, ADDR, ");
+
 	if (mem->phys_addr)
-		printf("# PID, TID, IP, ADDR, PHYS ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
-	else
-		printf("# PID, TID, IP, ADDR, LOCAL WEIGHT, DSRC, SYMBOL\n");
+		printf("PHYS ADDR, ");
+
+	printf("LOCAL WEIGHT, DSRC, SYMBOL\n");
 
 	ret = perf_session__process_events(session);
 
@@ -273,11 +261,30 @@ static int report_raw_events(struct perf_mem *mem)
 	perf_session__delete(session);
 	return ret;
 }
+static char *get_sort_order(struct perf_mem *mem)
+{
+	char sort[MAX_SORT_ORDER_STR];
+
+	/*
+	 * there is no weight (cost) associated with stores, so don't print
+	 * the column
+	 */
+	if (mem->operation & MEM_OPERATION_STORE)
+		strcpy(sort, "--sort=mem,sym,dso,symbol_daddr,dso_daddr,tlb,locked");
+	else
+		strcpy(sort, default_mem_sort_order);
+
+	if (mem->phys_addr)
+		strcat(sort, ",phys_daddr");
+
+	return strdup(sort);
+}
 
 static int report_events(int argc, const char **argv, struct perf_mem *mem)
 {
 	const char **rep_argv;
 	int ret, i = 0, j, rep_argc;
+	char *new_sort_order;
 
 	if (mem->dump_raw)
 		return report_raw_events(mem);
@@ -291,20 +298,9 @@ static int report_events(int argc, const char **argv, struct perf_mem *mem)
 	rep_argv[i++] = "--mem-mode";
 	rep_argv[i++] = "-n"; /* display number of samples */
 
-	/*
-	 * there is no weight (cost) associated with stores, so don't print
-	 * the column
-	 */
-	if (!(mem->operation & MEM_OPERATION_LOAD)) {
-		if (mem->phys_addr)
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked,phys_daddr";
-		else
-			rep_argv[i++] = "--sort=mem,sym,dso,symbol_daddr,"
-					"dso_daddr,tlb,locked";
-	} else if (mem->phys_addr)
-		rep_argv[i++] = "--sort=local_weight,mem,sym,dso,symbol_daddr,"
-				"dso_daddr,snoop,tlb,locked,phys_daddr";
+	new_sort_order = get_sort_order(mem);
+	if (new_sort_order)
+		rep_argv[i++] = new_sort_order;
 
 	for (j = 1; j < argc; j++, i++)
 		rep_argv[i] = argv[j];
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index c6b2f30..4632e25 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -46,6 +46,8 @@ extern struct sort_entry sort_srcline;
 extern enum sort_type sort__first_dimension;
 extern const char default_mem_sort_order[];
 
+#define MAX_SORT_ORDER_STR	128
+
 struct he_stat {
 	u64			period;
 	u64			period_sys;
-- 
2.7.4

