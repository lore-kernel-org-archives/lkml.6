Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCVQNH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:13:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:27517 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeCVQNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:13:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,345,1517904000";
   d="scan'208";a="27549028"
Subject: [PATCH v1 2/3] perf report: extend raw dump (-D) out with switch out
 event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8cdb0aa4-5b99-c692-49c2-c615729afe2b@linux.intel.com>
Date: Thu, 22 Mar 2018 19:13:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Print additional 'yield' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_YIELD bit set 
designating synchronization context switch out event:

perf report -D -i system-wide.perf | grep _SWITCH: 

1 113807080924003 0x26db26 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT        next pid/tid: 20495/20495
1 113807080925644 0x26db4e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 31479/31479
1 113807080937266 0x26db76 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:    16/16   
1 113807080938445 0x26db9e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN         prev pid/tid: 20495/20495
1 113807080945455 0x26dbc6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid: 20495/20495

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f0a6cbd033cc..324f44f02e66 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	const char *in_out = out ? "OUT" : "IN ";
+	const char *in_out = !out ? "IN       " :
+		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_YIELD) ?
+				"OUT      " : "OUT yield";
 
 	if (event->header.type == PERF_RECORD_SWITCH)
 		return fprintf(fp, " %s\n", in_out);
