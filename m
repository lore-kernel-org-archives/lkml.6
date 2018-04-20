Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755270AbeDTOdH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754968AbeDTOdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BB421838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/17] perf report: Extend raw dump (-D) out with switch out event type
Date: Fri, 20 Apr 2018 11:32:13 -0300
Message-Id: <20180420143227.16030-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/6f5aebb9-b96c-f304-f08f-8f046d38de4f@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
-- 
2.14.3
