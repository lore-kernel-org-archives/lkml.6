Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8624FECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B044214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B044214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbeISRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:03:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:57783 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731466AbeISRDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:03:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 04:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="74247618"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 04:25:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] perf tools: Improve thread_stack__process() for trace begin / end
Date:   Wed, 19 Sep 2018 14:23:36 +0300
Message-Id: <20180919112338.20347-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919112338.20347-1-adrian.hunter@intel.com>
References: <20180919112338.20347-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thread_stack__process() is used to create call paths for database export.
Improve the handling of trace begin / end to allow for a trace that ends in
a call.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index cea28b9074c1..45a97d15c6c8 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -357,7 +357,7 @@ void call_return_processor__free(struct call_return_processor *crp)
 
 static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 				 u64 timestamp, u64 ref, struct call_path *cp,
-				 bool no_call)
+				 bool no_call, bool trace_end)
 {
 	struct thread_stack_entry *tse;
 	int err;
@@ -375,6 +375,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->branch_count = ts->branch_count;
 	tse->cp = cp;
 	tse->no_call = no_call;
+	tse->trace_end = trace_end;
 
 	return 0;
 }
@@ -448,7 +449,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 		return -ENOMEM;
 
 	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
-				     true);
+				     true, false);
 }
 
 static int thread_stack__no_call_return(struct thread *thread,
@@ -480,7 +481,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 			if (!cp)
 				return -ENOMEM;
 			return thread_stack__push_cp(ts, 0, sample->time, ref,
-						     cp, true);
+						     cp, true, false);
 		}
 	} else if (thread_stack__in_kernel(ts) && sample->ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
@@ -505,7 +506,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 		return -ENOMEM;
 
 	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
-				    true);
+				    true, false);
 	if (err)
 		return err;
 
@@ -525,7 +526,7 @@ static int thread_stack__trace_begin(struct thread *thread,
 
 	/* Pop trace end */
 	tse = &ts->stack[ts->cnt - 1];
-	if (tse->cp->sym == NULL && tse->cp->ip == 0) {
+	if (tse->trace_end) {
 		err = thread_stack__call_return(thread, ts, --ts->cnt,
 						timestamp, ref, false);
 		if (err)
@@ -554,7 +555,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 	ret_addr = sample->ip + sample->insn_len;
 
 	return thread_stack__push_cp(ts, ret_addr, sample->time, ref, cp,
-				     false);
+				     false, true);
 }
 
 int thread_stack__process(struct thread *thread, struct comm *comm,
@@ -604,6 +605,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	ts->last_time = sample->time;
 
 	if (sample->flags & PERF_IP_FLAG_CALL) {
+		bool trace_end = sample->flags & PERF_IP_FLAG_TRACE_END;
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
 		u64 ret_addr;
@@ -621,7 +623,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		if (!cp)
 			return -ENOMEM;
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
-					    cp, false);
+					    cp, false, trace_end);
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
 		if (!sample->ip || !sample->addr)
 			return 0;
-- 
2.17.1

