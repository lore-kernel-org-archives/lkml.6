Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA77ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25156205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25156205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeJaXUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:20:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:45008 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729411AbeJaXUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:20:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 07:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208,223";a="277207785"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga006.fm.intel.com with ESMTP; 31 Oct 2018 07:22:30 -0700
Subject: Re: [PATCH 4/5] perf intel-pt: Insert callchain context into
 synthesized callchains
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-5-adrian.hunter@intel.com>
 <20181031132803.GG10660@kernel.org>
 <850eed86-fb8f-e328-316c-378890d4f15f@intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <100ea2ec-ed14-b56d-d810-e0a6d2f4b069@intel.com>
Date:   Wed, 31 Oct 2018 16:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <850eed86-fb8f-e328-316c-378890d4f15f@intel.com>
Content-Type: multipart/mixed;
 boundary="------------39258EA51B193AEA822AE914"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------39258EA51B193AEA822AE914
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 31/10/18 4:15 PM, Adrian Hunter wrote:
> On 31/10/18 3:28 PM, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Oct 31, 2018 at 11:10:42AM +0200, Adrian Hunter escreveu:
>>> In the absence of a fallback, callchains must encode also the callchain
>>> context. Do that now there is no fallback.
>>
>> So, this one is independent of the first 3 patches, right?
> 
> Yes.  I was just going to test it separately when I noticed I had
> screwed up my earlier testing.  When I re-tested I discovered this patch
> has an off-by-one error:
> 
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index afdf36852ac8..61a4286a74dc 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -337,7 +337,7 @@ void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
>  
>  	last_context = context;
>  
> -	for (i = 2, j = 0; i < sz && j < thread->ts->cnt; i++, j++) {
> +	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
>  		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
>  		context = callchain_context(ip, kernel_start);
>  		if (context != last_context) {
> 
> Shall I send V2?

I have attached it

--------------39258EA51B193AEA822AE914
Content-Type: text/x-patch;
 name="0004-perf-intel-pt-Insert-callchain-context-into-synthesi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-perf-intel-pt-Insert-callchain-context-into-synthesi.pa";
 filename*1="tch"

From 19a9fbdbd3729c7f14c9c1f0ac79c18cce91ff60 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 31 Oct 2018 09:31:25 +0200
Subject: [PATCH V2 4/5] perf intel-pt: Insert callchain context into
 synthesized callchains

In the absence of a fallback, callchains must encode also the callchain
context. Do that now there is no fallback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # 4.19
---


Changes in V2:

	Fix off-by-one error


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
-- 
2.17.1


--------------39258EA51B193AEA822AE914--
