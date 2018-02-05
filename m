Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBET5X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbeBET5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:57:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982BB217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/10] perf trace: Fix call-graph output
Date: Mon,  5 Feb 2018 16:56:19 -0300
Message-Id: <20180205195620.9010-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180205195620.9010-1-acme@kernel.org>
References: <20180205195620.9010-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Recently, Arnaldo fixed global vs event specific --max-stack usage with
commit bd3dda9ab0fb ("perf trace: Allow overriding global --max-stack
per event"). This commit is having a regression when we don't use
--max-stack at all with perf trace. Ex,

  $ ./perf trace record -g ls
  $ ./perf trace -i perf.data
     0.076 ( 0.002 ms): ls/9109 brk(
     0.196 ( 0.008 ms): ls/9109 access(filename: 0x9f998b70, mode: R
     0.209 ( 0.031 ms): ls/9109 open(filename: 0x9f998978, flags: CLOEXEC

This is missing call-traces.
After patch:

  $ ./perf trace -i perf.data
     0.076 ( 0.002 ms): ls/9109 brk(
                                do_syscall_trace_leave ([kernel.kallsyms])
                                [0] ([unknown])
                                syscall_exit_work ([kernel.kallsyms])
                                brk (/usr/lib64/ld-2.17.so)
                                _dl_sysdep_start (/usr/lib64/ld-2.17.so)
                                _dl_start_final (/usr/lib64/ld-2.17.so)
                                _dl_start (/usr/lib64/ld-2.17.so)
                                _start (/usr/lib64/ld-2.17.so)
     0.196 ( 0.008 ms): ls/9109 access(filename: 0x9f998b70, mode: R
                                do_syscall_trace_leave ([kernel.kallsyms])
                                [0] ([unknown])

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: bd3dda9ab0fb ("perf trace: Allow overriding global --max-stack per event")
Link: http://lkml.kernel.org/r/20180130053053.13214-3-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 17d11deeb88d..e7f1b182fc15 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1661,9 +1661,12 @@ static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evse
 				    struct callchain_cursor *cursor)
 {
 	struct addr_location al;
+	int max_stack = evsel->attr.sample_max_stack ?
+			evsel->attr.sample_max_stack :
+			trace->max_stack;
 
 	if (machine__resolve(trace->host, &al, sample) < 0 ||
-	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, evsel->attr.sample_max_stack))
+	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack))
 		return -1;
 
 	return 0;
-- 
2.14.3
