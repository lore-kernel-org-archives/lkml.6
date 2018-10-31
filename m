Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD61C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBC320664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBC320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeKAHN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:13:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:13:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VMDLd52561835
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:13:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VMDLdc2561832;
        Wed, 31 Oct 2018 15:13:21 -0700
Date:   Wed, 31 Oct 2018 15:13:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5@git.kernel.org>
Cc:     leo.yan@linaro.org, tglx@linutronix.de, adrian.hunter@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        ak@linux.intel.com, mathieu.poirier@linaro.org
Reply-To: mathieu.poirier@linaro.org, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org, ak@linux.intel.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          davem@davemloft.net, tglx@linutronix.de, leo.yan@linaro.org
In-Reply-To: <20181031091043.23465-6-adrian.hunter@intel.com>
References: <20181031091043.23465-6-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt/bts: Calculate cpumode for
 synthesized samples
Git-Commit-ID: 5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5
Gitweb:     https://git.kernel.org/tip/5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 31 Oct 2018 11:10:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 12:56:26 -0300

perf intel-pt/bts: Calculate cpumode for synthesized samples

In the absence of a fallback, samples must provide a correct cpumode for
the 'ip'. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181031091043.23465-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
