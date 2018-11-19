Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C061C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94A2147D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wM4TCKIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F94A2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbeKTC7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKTC7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:59:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E529921104;
        Mon, 19 Nov 2018 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645309;
        bh=pWv/qk1YWCj16IxoZxzlCZJMeuhdZFAaCgDjcbT9LGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wM4TCKIH+OWiSUfrJxvELvJeCHdJZc/TA1HiZPA26EncFlMxkxTL2/9VnpQ7NMODY
         OtOjKNiVjpcodCk9ATTGyNRUZLXdUsuMXJqpU3vgJzYoeGLE9OaBQYY2lmrCQhtEre
         Wl2SosTcUyj7vpDvzp9XOPAxlimpANp2SJTQecjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 116/205] perf intel-pt: Insert callchain context into synthesized callchains
Date:   Mon, 19 Nov 2018 17:27:03 +0100
Message-Id: <20181119162635.410239514@linuxfoundation.org>
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

commit 242483068b4b9ad02f1653819b6e683577681e0e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/intel-pt.c     |    6 +++--
 tools/perf/util/thread-stack.c |   44 ++++++++++++++++++++++++++++++++---------
 tools/perf/util/thread-stack.h |    2 -
 3 files changed, 40 insertions(+), 12 deletions(-)

--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -763,7 +763,8 @@ static struct intel_pt_queue *intel_pt_a
 	if (pt->synth_opts.callchain) {
 		size_t sz = sizeof(struct ip_callchain);
 
-		sz += pt->synth_opts.callchain_sz * sizeof(u64);
+		/* Add 1 to callchain_sz for callchain context */
+		sz += (pt->synth_opts.callchain_sz + 1) * sizeof(u64);
 		ptq->chain = zalloc(sz);
 		if (!ptq->chain)
 			goto out_free;
@@ -1159,7 +1160,8 @@ static void intel_pt_prep_sample(struct
 
 	if (pt->synth_opts.callchain) {
 		thread_stack__sample(ptq->thread, ptq->chain,
-				     pt->synth_opts.callchain_sz, sample->ip);
+				     pt->synth_opts.callchain_sz + 1,
+				     sample->ip, pt->kernel_start);
 		sample->callchain = ptq->chain;
 	}
 
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -285,20 +285,46 @@ void thread_stack__free(struct thread *t
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
+
+	if (sz < 2) {
+		chain->nr = 0;
+		return;
+	}
 
-	if (!thread || !thread->ts)
-		chain->nr = 1;
-	else
-		chain->nr = min(sz, thread->ts->cnt + 1);
+	chain->ips[0] = context;
+	chain->ips[1] = ip;
 
-	chain->ips[0] = ip;
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
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -84,7 +84,7 @@ int thread_stack__event(struct thread *t
 			u64 to_ip, u16 insn_len, u64 trace_nr);
 void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr);
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
-			  size_t sz, u64 ip);
+			  size_t sz, u64 ip, u64 kernel_start);
 int thread_stack__flush(struct thread *thread);
 void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread);


