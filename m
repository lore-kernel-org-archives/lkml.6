Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeC3FBt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 01:01:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:39870 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeC3FBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 01:01:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,380,1517904000";
   d="scan'208";a="38074290"
Subject: [PATCH v5 2/3] perf report: extend raw dump (-D) out with switch out
 event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Organization: Intel Corp.
Message-ID: <cafe98bd-93db-7172-23c9-940a9d14cddf@linux.intel.com>
Date: Fri, 30 Mar 2018 08:01:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <45f6ea8a-a420-d176-50aa-9b3975c0ea7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Print additional 'preempt' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit set 
designating preemption context switch out event:

tools/perf/perf report -D -i perf.data | grep _SWITCH

0 768361415226 0x27f076 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     8/8    
4 768362216813 0x28f45e [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT          next pid/tid:     0/0    
4 768362217824 0x28f486 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:  4073/4073 
0 768362414027 0x27f0ce [0x28]: PERF_RECORD_SWITCH_CPU_WIDE OUT preempt  next pid/tid:     8/8    
0 768362414367 0x27f0f6 [0x28]: PERF_RECORD_SWITCH_CPU_WIDE IN           prev pid/tid:     0/0    

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f0a6cbd033cc..98ff3a6a3d50 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	const char *in_out = out ? "OUT" : "IN ";
+	const char *in_out = !out ? "IN         " :
+		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT) ?
+				    "OUT        " : "OUT preempt";
 
 	if (event->header.type == PERF_RECORD_SWITCH)
 		return fprintf(fp, " %s\n", in_out);
