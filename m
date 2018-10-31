Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655CDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E32064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370E32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJaSKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:10:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:16423 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeJaSKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:10:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 02:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104759453"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2018 02:12:40 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 5/5] perf intel-pt/bts: Calculate cpumode for synthesized samples
Date:   Wed, 31 Oct 2018 11:10:43 +0200
Message-Id: <20181031091043.23465-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031091043.23465-1-adrian.hunter@intel.com>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of a fallback, samples must provide a correct cpumode for
the 'ip'. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 4.19
---
 tools/perf/util/intel-bts.c | 17 ++++++++++++-----
 tools/perf/util/intel-pt.c  | 22 +++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 3b3a3d55dca1..7b27d77306c2 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -269,6 +269,13 @@ static int intel_bts_do_fix_overlap(struct auxtrace_queue *queue,
 	return 0;
 }
 
+static inline u8 intel_bts_cpumode(struct intel_bts *bts, uint64_t ip)
+{
+	return machine__kernel_ip(bts->machine, ip) ?
+	       PERF_RECORD_MISC_KERNEL :
+	       PERF_RECORD_MISC_USER;
+}
+
 static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 					 struct branch *branch)
 {
@@ -281,12 +288,8 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 	    bts->num_events++ <= bts->synth_opts.initial_skip)
 		return 0;
 
-	event.sample.header.type = PERF_RECORD_SAMPLE;
-	event.sample.header.misc = PERF_RECORD_MISC_USER;
-	event.sample.header.size = sizeof(struct perf_event_header);
-
-	sample.cpumode = PERF_RECORD_MISC_USER;
 	sample.ip = le64_to_cpu(branch->from);
+	sample.cpumode = intel_bts_cpumode(bts, sample.ip);
 	sample.pid = btsq->pid;
 	sample.tid = btsq->tid;
 	sample.addr = le64_to_cpu(branch->to);
@@ -298,6 +301,10 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 	sample.insn_len = btsq->intel_pt_insn.length;
 	memcpy(sample.insn, btsq->intel_pt_insn.buf, INTEL_PT_INSN_BUF_SZ);
 
+	event.sample.header.type = PERF_RECORD_SAMPLE;
+	event.sample.header.misc = sample.cpumode;
+	event.sample.header.size = sizeof(struct perf_event_header);
+
 	if (bts->synth_opts.inject) {
 		event.sample.header.size = bts->branches_event_size;
 		ret = perf_event__synthesize_sample(&event,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 60732213d16a..86cc9a64e982 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -407,6 +407,13 @@ intel_pt_cache_lookup(struct dso *dso, struct machine *machine, u64 offset)
 	return auxtrace_cache__lookup(dso->auxtrace_cache, offset);
 }
 
+static inline u8 intel_pt_cpumode(struct intel_pt *pt, uint64_t ip)
+{
+	return ip >= pt->kernel_start ?
+	       PERF_RECORD_MISC_KERNEL :
+	       PERF_RECORD_MISC_USER;
+}
+
 static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				   uint64_t *insn_cnt_ptr, uint64_t *ip,
 				   uint64_t to_ip, uint64_t max_insn_cnt,
@@ -429,10 +436,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
 
-	if (*ip >= ptq->pt->kernel_start)
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
+	cpumode = intel_pt_cpumode(ptq->pt, *ip);
 
 	thread = ptq->thread;
 	if (!thread) {
@@ -1059,15 +1063,11 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 				   union perf_event *event,
 				   struct perf_sample *sample)
 {
-	event->sample.header.type = PERF_RECORD_SAMPLE;
-	event->sample.header.misc = PERF_RECORD_MISC_USER;
-	event->sample.header.size = sizeof(struct perf_event_header);
-
 	if (!pt->timeless_decoding)
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
-	sample->cpumode = PERF_RECORD_MISC_USER;
 	sample->ip = ptq->state->from_ip;
+	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
 	sample->pid = ptq->pid;
 	sample->tid = ptq->tid;
 	sample->addr = ptq->state->to_ip;
@@ -1076,6 +1076,10 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 	sample->flags = ptq->flags;
 	sample->insn_len = ptq->insn_len;
 	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.misc = sample->cpumode;
+	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,
-- 
2.17.1

