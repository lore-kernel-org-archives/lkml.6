Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeCIImm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:42:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbeCIImk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:40 -0500
Date: Fri, 9 Mar 2018 00:42:18 -0800
From: tip-bot for Agustin Vega-Frias <tipbot@zytor.com>
Message-ID: <tip-b2b9d3a3f0211c5d08c7befdf9d4adad48cda315@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, timur@codeaurora.org, acme@redhat.com,
        ak@linux.intel.com, tglx@linutronix.de, agustinv@codeaurora.org
Reply-To: peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, ak@linux.intel.com, acme@redhat.com,
        agustinv@codeaurora.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, timur@codeaurora.org
In-Reply-To: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf pmu: Support wildcards on pmu name in dynamic
 pmu events
Git-Commit-ID: b2b9d3a3f0211c5d08c7befdf9d4adad48cda315
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b2b9d3a3f0211c5d08c7befdf9d4adad48cda315
Gitweb:     https://git.kernel.org/tip/b2b9d3a3f0211c5d08c7befdf9d4adad48cda315
Author:     Agustin Vega-Frias <agustinv@codeaurora.org>
AuthorDate: Tue, 6 Mar 2018 09:04:42 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:25 -0300

perf pmu: Support wildcards on pmu name in dynamic pmu events

Starting on v4.12 event parsing code for dynamic pmu events already
supports prefix-based matching of multiple pmus when creating dynamic
events. E.g., in a system with the following dynamic pmus:

    mypmu_0
    mypmu_1
    mypmu_2
    mypmu_4

passing mypmu/<config>/ as an event spec will result in the creation of
the event in all of the pmus. This change expands this matching through
the use of fnmatch so glob-like expressions can be used to create events
in multiple pmus. E.g., in the system described above if a user only
wants to create the event in mypmu_0 and mypmu_1, mypmu_[01]/<config>/
can be passed.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Timur Tabi <timur@codeaurora.org>
Change-Id: Icb25653fc5d5239c20f3bffdfdf4ab4c9c9bb20b
Link: http://lkml.kernel.org/r/1520454947-16977-1-git-send-email-agustinv@codeaurora.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt |  8 +++++++-
 tools/perf/Documentation/perf-stat.txt | 13 +++++++++++++
 tools/perf/util/parse-events.l         |  2 +-
 tools/perf/util/parse-events.y         | 14 ++++++++++++--
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index e2a897ae3596..2549c34a7895 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -141,7 +141,13 @@ on the first memory controller on socket 0 of a Intel Xeon system
 
 Each memory controller has its own PMU.  Measuring the complete system
 bandwidth would require specifying all imc PMUs (see perf list output),
-and adding the values together.
+and adding the values together. To simplify creation of multiple events,
+prefix and glob matching is supported in the PMU name, and the prefix
+'uncore_' is also ignored when performing the match. So the command above
+can be expanded to all memory controllers by using the syntaxes:
+
+  perf stat -C 0 -a imc/cas_count_read/,imc/cas_count_write/ -I 1000 ...
+  perf stat -C 0 -a *imc*/cas_count_read/,*imc*/cas_count_write/ -I 1000 ...
 
 This example measures the combined core power every second
 
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 2b38e222016a..628026dbedc5 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -49,6 +49,13 @@ report::
 	  parameters are defined by corresponding entries in
 	  /sys/bus/event_source/devices/<pmu>/format/*
 
+	Note that the last two syntaxes support prefix and glob matching in
+	the PMU name to simplify creation of events accross multiple instances
+	of the same type of PMU in large systems (e.g. memory controller PMUs).
+	Multiple PMU instances are typical for uncore PMUs, so the prefix
+	'uncore_' is also ignored when performing this match.
+
+
 -i::
 --no-inherit::
         child tasks do not inherit counters
@@ -260,6 +267,12 @@ taskset.
 --no-merge::
 Do not merge results from same PMUs.
 
+When multiple events are created from a single event alias, stat will,
+by default, aggregate the event counts and show the result in a single
+row. This option disables that behavior and shows the individual events
+and counts. Aliases are listed immediately after the Kernel PMU events
+by perf list.
+
 --smi-cost::
 Measure SMI cost if msr/aperf/ and msr/smi/ events are supported.
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 655ecff636a8..a1a01b1ac8b8 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -175,7 +175,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
+name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e81a20ea8d7d..dedf184b5bed 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -8,6 +8,7 @@
 
 #define YYDEBUG 1
 
+#include <fnmatch.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -234,6 +235,10 @@ PE_NAME opt_event_config
 	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
+		char *pattern;
+
+		if (asprintf(&pattern, "%s*", $1) < 0)
+			YYABORT;
 
 		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
 			char *name = pmu->name;
@@ -241,14 +246,19 @@ PE_NAME opt_event_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!strncmp($1, name, strlen($1))) {
-				if (parse_events_copy_term_list(orig_terms, &terms))
+			if (!fnmatch(pattern, name, 0)) {
+				if (parse_events_copy_term_list(orig_terms, &terms)) {
+					free(pattern);
 					YYABORT;
+				}
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
 		}
+
+		free(pattern);
+
 		if (!ok)
 			YYABORT;
 	}
