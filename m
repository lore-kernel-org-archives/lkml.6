Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE583213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vWWfGXxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE583213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKTC7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKTC7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFF6208E3;
        Mon, 19 Nov 2018 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645306;
        bh=0JiSoeQHW97/MP+IElaBHz57fRuPxx4Al1zSwvOsb4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWWfGXxjdo3P/TG+0eQ9MGC5Bw3XkD3THl5g2sWLQicgLwIOMo+ws4pUvOCnDY3dG
         vAR1NVaXNJXH0LPAXzb4plJuYmpgJ5LB9Xk+3DobyB4XYpbmMixFL5fmkz731w7MRi
         dPnXiocXC6e878p9cLxesmwIpJzHbMwlVqEbg3Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 115/205] perf intel-pt/bts: Calculate cpumode for synthesized samples
Date:   Mon, 19 Nov 2018 17:27:02 +0100
Message-Id: <20181119162635.279260704@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 5d4f0edaa3ac4f1844ed7c64cd2bae6f1912bac5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-bts.c |   17 ++++++++++++-----
 tools/perf/util/intel-pt.c  |   22 +++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -269,6 +269,13 @@ static int intel_bts_do_fix_overlap(stru
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
@@ -281,12 +288,8 @@ static int intel_bts_synth_branch_sample
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
@@ -298,6 +301,10 @@ static int intel_bts_synth_branch_sample
 	sample.insn_len = btsq->intel_pt_insn.length;
 	memcpy(sample.insn, btsq->intel_pt_insn.buf, INTEL_PT_INSN_BUF_SZ);
 
+	event.sample.header.type = PERF_RECORD_SAMPLE;
+	event.sample.header.misc = sample.cpumode;
+	event.sample.header.size = sizeof(struct perf_event_header);
+
 	if (bts->synth_opts.inject) {
 		event.sample.header.size = bts->branches_event_size;
 		ret = perf_event__synthesize_sample(&event,
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -407,6 +407,13 @@ intel_pt_cache_lookup(struct dso *dso, s
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
@@ -429,10 +436,7 @@ static int intel_pt_walk_next_insn(struc
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
 
-	if (*ip >= ptq->pt->kernel_start)
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
+	cpumode = intel_pt_cpumode(ptq->pt, *ip);
 
 	thread = ptq->thread;
 	if (!thread) {
@@ -1053,15 +1057,11 @@ static void intel_pt_prep_b_sample(struc
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
@@ -1070,6 +1070,10 @@ static void intel_pt_prep_b_sample(struc
 	sample->flags = ptq->flags;
 	sample->insn_len = ptq->insn_len;
 	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.misc = sample->cpumode;
+	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,


