Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE28ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BB120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BB120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeKAHMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:12:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeKAHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:12:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VMClPk2561782
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:12:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VMCluk2561779;
        Wed, 31 Oct 2018 15:12:47 -0700
Date:   Wed, 31 Oct 2018 15:12:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-242483068b4b9ad02f1653819b6e683577681e0e@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, leo.yan@linaro.org,
        ak@linux.intel.com, hpa@zytor.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
Reply-To: hpa@zytor.com, leo.yan@linaro.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
          davem@davemloft.net, tglx@linutronix.de, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <100ea2ec-ed14-b56d-d810-e0a6d2f4b069@intel.com>
References: <100ea2ec-ed14-b56d-d810-e0a6d2f4b069@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Insert callchain context into
 synthesized callchains
Git-Commit-ID: 242483068b4b9ad02f1653819b6e683577681e0e
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

Commit-ID:  242483068b4b9ad02f1653819b6e683577681e0e
Gitweb:     https://git.kernel.org/tip/242483068b4b9ad02f1653819b6e683577681e0e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 31 Oct 2018 11:10:42 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 12:54:27 -0300

perf intel-pt: Insert callchain context into synthesized callchains

In the absence of a fallback, callchains must encode also the callchain
context. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/100ea2ec-ed14-b56d-d810-e0a6d2f4b069@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c     |  6 ++++--
 tools/perf/util/thread-stack.c | 44 +++++++++++++++++++++++++++++++++---------
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
index c091635bf7dc..61a4286a74dc 100644
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
+	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
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
