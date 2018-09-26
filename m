Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31532C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78CA206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78CA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIZPHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:07:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeIZPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:07:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8tTf03772924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:55:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8tSC53772920;
        Wed, 26 Sep 2018 01:55:28 -0700
Date:   Wed, 26 Sep 2018 01:55:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-2dcde4e152a3e319cc7e76c7c6b8548a3c72310d@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
        tglx@linutronix.de, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com
Reply-To: mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
          tglx@linutronix.de, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          acme@redhat.com
In-Reply-To: <20180920130048.31432-5-adrian.hunter@intel.com>
References: <20180920130048.31432-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Improve thread_stack__process() for
 trace begin / end
Git-Commit-ID: 2dcde4e152a3e319cc7e76c7c6b8548a3c72310d
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

Commit-ID:  2dcde4e152a3e319cc7e76c7c6b8548a3c72310d
Gitweb:     https://git.kernel.org/tip/2dcde4e152a3e319cc7e76c7c6b8548a3c72310d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 20 Sep 2018 16:00:46 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 15:19:50 -0300

perf tools: Improve thread_stack__process() for trace begin / end

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
