Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDUHro (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:47:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeDUHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:47:43 -0400
Date: Sat, 21 Apr 2018 00:47:21 -0700
From: tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-b3f35b5d5d36fba9311d1a965fcce2dd35614f2e@git.kernel.org>
Cc: tglx@linutronix.de, alexey.budankov@linux.intel.com, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com
Reply-To: tglx@linutronix.de, alexey.budankov@linux.intel.com, acme@redhat.com,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com
In-Reply-To: <6f5aebb9-b96c-f304-f08f-8f046d38de4f@linux.intel.com>
References: <6f5aebb9-b96c-f304-f08f-8f046d38de4f@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Extend raw dump (-D) out with switch
 out event type
Git-Commit-ID: b3f35b5d5d36fba9311d1a965fcce2dd35614f2e
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

Commit-ID:  b3f35b5d5d36fba9311d1a965fcce2dd35614f2e
Gitweb:     https://git.kernel.org/tip/b3f35b5d5d36fba9311d1a965fcce2dd35614f2e
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Mon, 9 Apr 2018 10:26:05 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:39 -0300

perf report: Extend raw dump (-D) out with switch out event type

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
