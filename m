Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeBEVie (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:38:34 -0500
Received: from terminus.zytor.com ([65.50.211.136]:33831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbeBEVi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:38:27 -0500
Date: Mon, 5 Feb 2018 13:37:17 -0800
From: tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-3a9e9a47092e302f3c75ababebfc16e196400a93@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, ravi.bangoria@linux.vnet.ibm.com,
        tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
        hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        ravi.bangoria@linux.vnet.ibm.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        namhyung@kernel.org
In-Reply-To: <20180130053053.13214-3-ravi.bangoria@linux.vnet.ibm.com>
References: <20180130053053.13214-3-ravi.bangoria@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Fix call-graph output
Git-Commit-ID: 3a9e9a47092e302f3c75ababebfc16e196400a93
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

Commit-ID:  3a9e9a47092e302f3c75ababebfc16e196400a93
Gitweb:     https://git.kernel.org/tip/3a9e9a47092e302f3c75ababebfc16e196400a93
Author:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
AuthorDate: Tue, 30 Jan 2018 11:00:53 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Feb 2018 13:53:45 -0300

perf trace: Fix call-graph output

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
index 17d11de..e7f1b18 100644
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
