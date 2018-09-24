Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B869C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C2C2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX+WLrtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C2C2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbeIXVH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeIXVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:56 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823B82064D;
        Mon, 24 Sep 2018 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801520;
        bh=Zhn+aKscOqLBQqpVI2Tue6wXAaKPrmigoja6P10ZD4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qX+WLrtrJrLTGFUswpIDP1ZTS3cNG19jQnlgFKbVlM6K42S1InW9K7eeJwRiVoIlh
         /ZZNUaAklcCVhEASbtwPYP2c71muXRliCemVOae7zh1iWANLrfWHqoA+m+BZGIjQH1
         iFmpH9ZykWS0K/RhZIt9rpTjmlbrQ/Gw1deqMWvI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/27] perf tools: Improve thread_stack__process() for trace begin / end
Date:   Mon, 24 Sep 2018 12:02:39 -0300
Message-Id: <20180924150242.14235-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

thread_stack__process() is used to create call paths for database
export.  Improve the handling of trace begin / end to allow for a trace
that ends in a call.

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, enhance the thread stack
so that it identifies the trace end by the flag instead of by ip == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index e3f7dfecafa9..c091635bf7dc 100644
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
2.14.4

