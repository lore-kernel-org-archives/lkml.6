Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeA3F3e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:29:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752809AbeA3F30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:29:26 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf trace: Fix call-graph output
Date: Tue, 30 Jan 2018 11:00:53 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180130053053.13214-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18013005-0016-0000-0000-0000051D43EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013005-0017-0000-0000-00002859DEBB
Message-Id: <20180130053053.13214-3-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300071
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, Arnaldo fixed global vs event specific --max-stack usage
with commit bd3dda9ab0fb ("perf trace: Allow overriding global
--max-stack per event"). This commit is having a regression when
we don't use --max-stack at all with perf trace. Ex,

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

Fixes: bd3dda9ab0fb ("perf trace: Allow overriding global --max-stack per event")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 17d11de..e90f5c3 100644
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
1.8.3.1
