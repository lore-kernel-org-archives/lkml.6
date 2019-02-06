Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCACC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3B2075D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfBFKlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:41:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:23275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfBFKle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:41:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 02:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,339,1544515200"; 
   d="scan'208";a="115647697"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga008.jf.intel.com with ESMTP; 06 Feb 2019 02:41:32 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] perf auxtrace: Add timestamp to auxtrace errors
Date:   Wed,  6 Feb 2019 12:39:47 +0200
Message-Id: <20190206103947.15750-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206103947.15750-1-adrian.hunter@intel.com>
References: <20190206103947.15750-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timestamp can use useful to find part of a trace that has an error
without outputting all of the trace e.g. using the itrace 's' option to
skip initial number of events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c    | 22 ++++++++++++++++++++--
 tools/perf/util/auxtrace.h    |  2 +-
 tools/perf/util/event.h       |  3 ++-
 tools/perf/util/intel-bts.c   |  4 ++--
 tools/perf/util/intel-pt.c    | 23 ++++++++++++++++-------
 tools/perf/util/s390-cpumsf.c |  7 ++++---
 tools/perf/util/session.c     |  3 +++
 7 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ad186d3255d1..267e54df511b 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -27,6 +27,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/string.h>
+#include <linux/time64.h>
 
 #include <sys/param.h>
 #include <stdlib.h>
@@ -858,7 +859,7 @@ void auxtrace_buffer__free(struct auxtrace_buffer *buffer)
 
 void auxtrace_synth_error(struct auxtrace_error_event *auxtrace_error, int type,
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
-			  const char *msg)
+			  const char *msg, u64 timestamp)
 {
 	size_t size;
 
@@ -870,7 +871,9 @@ void auxtrace_synth_error(struct auxtrace_error_event *auxtrace_error, int type,
 	auxtrace_error->cpu = cpu;
 	auxtrace_error->pid = pid;
 	auxtrace_error->tid = tid;
+	auxtrace_error->fmt = 1;
 	auxtrace_error->ip = ip;
+	auxtrace_error->time = timestamp;
 	strlcpy(auxtrace_error->msg, msg, MAX_AUXTRACE_ERROR_MSG);
 
 	size = (void *)auxtrace_error->msg - (void *)auxtrace_error +
@@ -1160,12 +1163,27 @@ static const char *auxtrace_error_name(int type)
 size_t perf_event__fprintf_auxtrace_error(union perf_event *event, FILE *fp)
 {
 	struct auxtrace_error_event *e = &event->auxtrace_error;
+	unsigned long long nsecs = e->time;
+	const char *msg = e->msg;
 	int ret;
 
 	ret = fprintf(fp, " %s error type %u",
 		      auxtrace_error_name(e->type), e->type);
+
+	if (e->fmt && nsecs) {
+		unsigned long secs = nsecs / NSEC_PER_SEC;
+
+		nsecs -= secs * NSEC_PER_SEC;
+		ret += fprintf(fp, " time %lu.%09llu", secs, nsecs);
+	} else {
+		ret += fprintf(fp, " time 0");
+	}
+
+	if (!e->fmt)
+		msg = (const char *)&e->time;
+
 	ret += fprintf(fp, " cpu %d pid %d tid %d ip %#"PRIx64" code %u: %s\n",
-		       e->cpu, e->pid, e->tid, e->ip, e->code, e->msg);
+		       e->cpu, e->pid, e->tid, e->ip, e->code, msg);
 	return ret;
 }
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index fac32482db61..c69bcd9a3091 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -519,7 +519,7 @@ void auxtrace_index__free(struct list_head *head);
 
 void auxtrace_synth_error(struct auxtrace_error_event *auxtrace_error, int type,
 			  int code, int cpu, pid_t pid, pid_t tid, u64 ip,
-			  const char *msg);
+			  const char *msg, u64 timestamp);
 
 int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 					 struct perf_tool *tool,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index feba1aa819b4..36ae7e92dab1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -532,8 +532,9 @@ struct auxtrace_error_event {
 	u32 cpu;
 	u32 pid;
 	u32 tid;
-	u32 reserved__; /* For alignment */
+	u32 fmt;
 	u64 ip;
+	u64 time;
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 };
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index f99ac0cbe3ff..0c0180c67574 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -144,7 +144,7 @@ static int intel_bts_lost(struct intel_bts *bts, struct perf_sample *sample)
 
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
 			     INTEL_BTS_ERR_LOST, sample->cpu, sample->pid,
-			     sample->tid, 0, "Lost trace data");
+			     sample->tid, 0, "Lost trace data", sample->time);
 
 	err = perf_session__deliver_synth_event(bts->session, &event, NULL);
 	if (err)
@@ -374,7 +374,7 @@ static int intel_bts_synth_error(struct intel_bts *bts, int cpu, pid_t pid,
 
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
 			     INTEL_BTS_ERR_NOINSN, cpu, pid, tid, ip,
-			     "Failed to get instruction");
+			     "Failed to get instruction", 0);
 
 	err = perf_session__deliver_synth_event(bts->session, &event, NULL);
 	if (err)
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 2e72373ec6df..3b497bab4324 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1411,7 +1411,7 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
-				pid_t pid, pid_t tid, u64 ip)
+				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
 	union perf_event event;
 	char msg[MAX_AUXTRACE_ERROR_MSG];
@@ -1420,7 +1420,7 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 	intel_pt__strerror(code, msg, MAX_AUXTRACE_ERROR_MSG);
 
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
-			     code, cpu, pid, tid, ip, msg);
+			     code, cpu, pid, tid, ip, msg, timestamp);
 
 	err = perf_session__deliver_synth_event(pt->session, &event, NULL);
 	if (err)
@@ -1430,6 +1430,18 @@ static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 	return err;
 }
 
+static int intel_ptq_synth_error(struct intel_pt_queue *ptq,
+				 const struct intel_pt_state *state)
+{
+	struct intel_pt *pt = ptq->pt;
+	u64 tm = ptq->timestamp;
+
+	tm = pt->timeless_decoding ? 0 : tsc_to_perf_time(tm, &pt->tc);
+
+	return intel_pt_synth_error(pt, state->err, ptq->cpu, ptq->pid,
+				    ptq->tid, state->from_ip, tm);
+}
+
 static int intel_pt_next_tid(struct intel_pt *pt, struct intel_pt_queue *ptq)
 {
 	struct auxtrace_queue *queue;
@@ -1676,10 +1688,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 				intel_pt_next_tid(pt, ptq);
 			}
 			if (pt->synth_opts.errors) {
-				err = intel_pt_synth_error(pt, state->err,
-							   ptq->cpu, ptq->pid,
-							   ptq->tid,
-							   state->from_ip);
+				err = intel_ptq_synth_error(ptq, state);
 				if (err)
 					return err;
 			}
@@ -1804,7 +1813,7 @@ static int intel_pt_process_timeless_queues(struct intel_pt *pt, pid_t tid,
 static int intel_pt_lost(struct intel_pt *pt, struct perf_sample *sample)
 {
 	return intel_pt_synth_error(pt, INTEL_PT_ERR_LOST, sample->cpu,
-				    sample->pid, sample->tid, 0);
+				    sample->pid, sample->tid, 0, sample->time);
 }
 
 static struct intel_pt_queue *intel_pt_cpu_to_ptq(struct intel_pt *pt, int cpu)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 835249c77f56..d9525d220db1 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -819,7 +819,7 @@ static int s390_cpumsf_process_queues(struct s390_cpumsf *sf, u64 timestamp)
 }
 
 static int s390_cpumsf_synth_error(struct s390_cpumsf *sf, int code, int cpu,
-				   pid_t pid, pid_t tid, u64 ip)
+				   pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
 	char msg[MAX_AUXTRACE_ERROR_MSG];
 	union perf_event event;
@@ -827,7 +827,7 @@ static int s390_cpumsf_synth_error(struct s390_cpumsf *sf, int code, int cpu,
 
 	strncpy(msg, "Lost Auxiliary Trace Buffer", sizeof(msg) - 1);
 	auxtrace_synth_error(&event.auxtrace_error, PERF_AUXTRACE_ERROR_ITRACE,
-			     code, cpu, pid, tid, ip, msg);
+			     code, cpu, pid, tid, ip, msg, timestamp);
 
 	err = perf_session__deliver_synth_event(sf->session, &event, NULL);
 	if (err)
@@ -839,7 +839,8 @@ static int s390_cpumsf_synth_error(struct s390_cpumsf *sf, int code, int cpu,
 static int s390_cpumsf_lost(struct s390_cpumsf *sf, struct perf_sample *sample)
 {
 	return s390_cpumsf_synth_error(sf, 1, sample->cpu,
-				       sample->pid, sample->tid, 0);
+				       sample->pid, sample->tid, 0,
+				       sample->time);
 }
 
 static int
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2012396abb7c..18fb9c8cbf9c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -703,7 +703,10 @@ static void perf_event__auxtrace_error_swap(union perf_event *event,
 	event->auxtrace_error.cpu  = bswap_32(event->auxtrace_error.cpu);
 	event->auxtrace_error.pid  = bswap_32(event->auxtrace_error.pid);
 	event->auxtrace_error.tid  = bswap_32(event->auxtrace_error.tid);
+	event->auxtrace_error.fmt  = bswap_32(event->auxtrace_error.fmt);
 	event->auxtrace_error.ip   = bswap_64(event->auxtrace_error.ip);
+	if (event->auxtrace_error.fmt)
+		event->auxtrace_error.time = bswap_64(event->auxtrace_error.time);
 }
 
 static void perf_event__thread_map_swap(union perf_event *event,
-- 
2.17.1

