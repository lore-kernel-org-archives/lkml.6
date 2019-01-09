Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1868C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC9E20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfAIJUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730226AbfAIJUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163041"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
Date:   Wed,  9 Jan 2019 11:18:32 +0200
Message-Id: <20190109091835.5570-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make thread_stack__no_call_return() more readable by adding more local
variables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/thread-stack.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 93ba3ab6a602..7f8eff018c16 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -591,34 +591,36 @@ static int thread_stack__no_call_return(struct thread *thread,
 					struct addr_location *to_al, u64 ref)
 {
 	struct call_path_root *cpr = ts->crp->cpr;
+	struct call_path *root = &cpr->call_path;
+	struct symbol *fsym = from_al->sym;
+	struct symbol *tsym = to_al->sym;
 	struct call_path *cp, *parent;
 	u64 ks = ts->kernel_start;
+	u64 addr = sample->addr;
+	u64 tm = sample->time;
+	u64 ip = sample->ip;
 	int err;
 
-	if (sample->ip >= ks && sample->addr < ks) {
+	if (ip >= ks && addr < ks) {
 		/* Return to userspace, so pop all kernel addresses */
 		while (thread_stack__in_kernel(ts)) {
 			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							sample->time, ref,
-							true);
+							tm, ref, true);
 			if (err)
 				return err;
 		}
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
-			cp = call_path__findnew(cpr, &cpr->call_path,
-						to_al->sym, sample->addr,
-						ts->kernel_start);
-			return thread_stack__push_cp(ts, 0, sample->time, ref,
-						     cp, true, false);
+			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+			return thread_stack__push_cp(ts, 0, tm, ref, cp, true,
+						     false);
 		}
-	} else if (thread_stack__in_kernel(ts) && sample->ip < ks) {
+	} else if (thread_stack__in_kernel(ts) && ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
 		while (thread_stack__in_kernel(ts)) {
 			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							sample->time, ref,
-							true);
+							tm, ref, true);
 			if (err)
 				return err;
 		}
@@ -627,19 +629,16 @@ static int thread_stack__no_call_return(struct thread *thread,
 	if (ts->cnt)
 		parent = ts->stack[ts->cnt - 1].cp;
 	else
-		parent = &cpr->call_path;
+		parent = root;
 
 	/* This 'return' had no 'call', so push and pop top of stack */
-	cp = call_path__findnew(cpr, parent, from_al->sym, sample->ip,
-				ts->kernel_start);
+	cp = call_path__findnew(cpr, parent, fsym, ip, ks);
 
-	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
-				    true, false);
+	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	return thread_stack__pop_cp(thread, ts, sample->addr, sample->time, ref,
-				    to_al->sym);
+	return thread_stack__pop_cp(thread, ts, addr, tm, ref, tsym);
 }
 
 static int thread_stack__trace_begin(struct thread *thread,
-- 
2.17.1

