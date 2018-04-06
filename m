Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeDFUjG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:39:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:20577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeDFUiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:38:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="30134904"
From: Andi Kleen <andi@firstfloor.org>
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/4] perf, tools, mem: Allow all record/report options
Date: Fri,  6 Apr 2018 13:38:09 -0700
Message-Id: <20180406203812.3087-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406203812.3087-1-andi@firstfloor.org>
References: <20180406203812.3087-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For perf mem report / perf mem record, pass all unknown options
through to the underlying report/record commands. This makes things
like

perf mem record -a sleep 1

work. Matches how c2c and other tools work.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-mem.txt | 3 +++
 tools/perf/builtin-mem.c              | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index b0211410969b..8806ed5f3802 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -67,6 +67,9 @@ OPTIONS
 --phys-data::
 	Record/Report sample physical addresses
 
+In addition, for report all perf report options are valid, and for record
+all perf record options.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 506564651cda..57393e94d156 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -83,7 +83,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	};
 
 	argc = parse_options(argc, argv, options, record_mem_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_KEEP_UNKNOWN);
 
 	rec_argc = argc + 9; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
@@ -436,7 +436,7 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
-					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
-- 
2.14.3
