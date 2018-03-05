Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934790AbeCELio (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:38:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:61868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933036AbeCELil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:38:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="32474943"
Subject: [PATCH v1 2/3] perf report: extend raw dump (-D) out with switch out
 event type
From: Alexey Budankov <alexey.budankov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitri Prokhorov <Dmitry.Prohorov@intel.com>
References: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5ccb869f-e8fa-afc5-c113-4cf9e9ac74e2@linux.intel.com>
Date: Mon, 5 Mar 2018 14:38:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6db586f3-36da-285c-b008-f2722419fbf8@linux.intel.com>
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

...

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

...


Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 5 +++++
 tools/perf/util/event.c               | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 6f873503552d..0339c829cda5 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -654,6 +654,11 @@ struct perf_event_mmap_page {
  * perf_event_attr::precise_ip.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+/*
+ * Indicates that thread explicitly yielded cpu due to
+ * a call of some synchronization API e.g. futex system call
+ */
+#define PERF_RECORD_MISC_SWITCH_OUT_YIELD	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
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
