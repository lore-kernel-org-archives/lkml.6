Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeCTNFZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:05:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:44434 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753276AbeCTNFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:05:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="184418624"
Subject: [PATCH v1 2/3] perf report: extend raw dump (-D) out with switch out
 event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <86313484-3601-b218-48b8-1f54843e52de@linux.intel.com>
Date: Tue, 20 Mar 2018 16:05:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4857e3ba-a42f-a9a2-2668-91ca9b44727c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print additional 'yield' tag for PERF_RECORD_SWITCH[_CPU_WIDE] OUT records when
event header misc field contains PERF_RECORD_MISC_SWITCH_OUT_YIELD bit set 
designating synchronization context switch out event:

perf report -D -i system-wide.perf: 

0x1b9c50 [0x30]: event: 15
.
. ... raw event: size 48 bytes
.  0000:  0f 00 00 00 00 20 30 00 01 1e 00 00 01 1e 00 00  ..... 0.........
.  0010:  00 00 00 00 00 00 00 00 85 ae d4 e3 3e 0e 00 00  ............>...
.  0020:  54 00 00 00 00 00 00 00 05 00 00 00 00 00 00 00  T...............

5 15663273127557 0x1b9c50 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT  next pid/tid:  7681/7681 

0x2646c0 [0x30]: event: 15
.
. ... raw event: size 48 bytes
.  0000:  0f 00 00 00 00 60 30 00 00 00 00 00 00 00 00 00  .....`0.........
.  0010:  00 1e 00 00 00 1e 00 00 29 1e d5 e3 3e 0e 00 00  ........)...>...
.  0020:  56 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00  V...............

7 15663273156137 0x2646c0 [0x30]: PERF_RECORD_SWITCH_CPU_WIDE OUT yield  next pid/tid:     0/0

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index f0a6cbd033cc..af5a85d56446 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1421,7 +1421,9 @@ size_t perf_event__fprintf_itrace_start(union perf_event *event, FILE *fp)
 size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp)
 {
 	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-	const char *in_out = out ? "OUT" : "IN ";
+	const char *in_out = !out ? "IN " :
+		!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_YIELD) ?
+				"OUT" : "OUT yield";
 
 	if (event->header.type == PERF_RECORD_SWITCH)
 		return fprintf(fp, " %s\n", in_out);
