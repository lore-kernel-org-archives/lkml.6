Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9CD214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfAIJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbfAIJUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163031"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:15 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf thread-stack: Tidy thread_stack__push_cp() usage
Date:   Wed,  9 Jan 2019 11:18:31 +0200
Message-Id: <20190109091835.5570-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'cp' is checked in thread_stack__push_cp() a number of error checks can
be removed, reducing code size and improving readability.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d52f27f373ce..93ba3ab6a602 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -493,6 +493,9 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	struct thread_stack_entry *tse;
 	int err;
 
+	if (!cp)
+		return -ENOMEM;
+
 	if (ts->cnt == ts->sz) {
 		err = thread_stack__grow(ts);
 		if (err)
@@ -576,8 +579,6 @@ static int thread_stack__bottom(struct thread_stack *ts,
 
 	cp = call_path__findnew(cpr, &cpr->call_path, sym, ip,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
@@ -609,8 +610,6 @@ static int thread_stack__no_call_return(struct thread *thread,
 			cp = call_path__findnew(cpr, &cpr->call_path,
 						to_al->sym, sample->addr,
 						ts->kernel_start);
-			if (!cp)
-				return -ENOMEM;
 			return thread_stack__push_cp(ts, 0, sample->time, ref,
 						     cp, true, false);
 		}
@@ -633,8 +632,6 @@ static int thread_stack__no_call_return(struct thread *thread,
 	/* This 'return' had no 'call', so push and pop top of stack */
 	cp = call_path__findnew(cpr, parent, from_al->sym, sample->ip,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
 				    true, false);
@@ -680,8 +677,6 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 
 	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp, NULL, 0,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	ret_addr = sample->ip + sample->insn_len;
 
@@ -745,8 +740,6 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
 					to_al->sym, sample->addr,
 					ts->kernel_start);
-		if (!cp)
-			return -ENOMEM;
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
 					    cp, false, trace_end);
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
-- 
2.17.1

