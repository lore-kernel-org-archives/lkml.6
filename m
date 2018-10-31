Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B1C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67642064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67642064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJaSJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:09:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:16419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbeJaSJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:09:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 02:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="104759446"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2018 02:12:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4/5] perf intel-pt: Insert callchain context into synthesized callchains
Date:   Wed, 31 Oct 2018 11:10:42 +0200
Message-Id: <20181031091043.23465-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031091043.23465-1-adrian.hunter@intel.com>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the absence of a fallback, callchains must encode also the callchain
context. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 4.19
---
 tools/perf/util/intel-pt.c     |  6 +++--
 tools/perf/util/thread-stack.c | 44 +++++++++++++++++++++++++++-------
 tools/perf/util/thread-stack.h |  2 +-
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ffa385a029b3..60732213d16a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -759,7 +759,8 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->synth_opts.callchain) {
 		size_t sz = sizeof(struct ip_callchain);
 
-		sz += pt->synth_opts.callchain_sz * sizeof(u64);
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
 		ptq->chain = zalloc(sz);
 		if (!ptq->chain)
 			goto out_free;
@@ -1160,7 +1161,8 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 
 	if (pt->synth_opts.callchain) {
 		thread_stack__sample(ptq->thread, ptq->chain,
-				     pt->synth_opts.callchain_sz, sample->ip);
+				     pt->synth_opts.callchain_sz + 1,
+				     sample->ip, pt->kernel_start);
 		sample->callchain = ptq->chain;
 	}
 
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index c091635bf7dc..afdf36852ac8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -310,20 +310,46 @@ void thread_stack__free(struct thread *thread)
 	}
 }
 
+static inline u64 callchain_context(u64 ip, u64 kernel_start)
+{
+	return ip < kernel_start ? PERF_CONTEXT_USER : PERF_CONTEXT_KERNEL;
+}
+
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
-			  size_t sz, u64 ip)
+			  size_t sz, u64 ip, u64 kernel_start)
 {
-	size_t i;
+	u64 context = callchain_context(ip, kernel_start);
+	u64 last_context;
+	size_t i, j;
 
-	if (!thread || !thread->ts)
-		chain->nr = 1;
-	else
-		chain->nr = min(sz, thread->ts->cnt + 1);
+	if (sz < 2) {
+		chain->nr = 0;
+		return;
+	}
 
-	chain->ips[0] = ip;
+	chain->ips[0] = context;
+	chain->ips[1] = ip;
+
+	if (!thread || !thread->ts) {
+		chain->nr = 2;
+		return;
+	}
+
+	last_context = context;
+
+	for (i = 2, j = 0; i < sz && j < thread->ts->cnt; i++, j++) {
+		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
+		context = callchain_context(ip, kernel_start);
+		if (context != last_context) {
+			if (i >= sz - 1)
+				break;
+			chain->ips[i++] = context;
+			last_context = context;
+		}
+		chain->ips[i] = ip;
+	}
 
-	for (i = 1; i < chain->nr; i++)
-		chain->ips[i] = thread->ts->stack[thread->ts->cnt - i].ret_addr;
+	chain->nr = i;
 }
 
 struct call_return_processor *
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b7e41c4ebfdd..f97c00a8c251 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -84,7 +84,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr);
 void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
-			  size_t sz, u64 ip);
+			  size_t sz, u64 ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread);
-- 
2.17.1

