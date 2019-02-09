Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928B221919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBIM6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:58:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:58:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CwDHH2633881
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:58:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CwDlt2633877;
        Sat, 9 Feb 2019 04:58:13 -0800
Date:   Sat, 9 Feb 2019 04:58:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-e7a3a055f2b88ebd0bdae8b0aade1e7d80c8a81e@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190109091835.5570-3-adrian.hunter@intel.com>
References: <20190109091835.5570-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Tidy thread_stack__push_cp()
 usage
Git-Commit-ID: e7a3a055f2b88ebd0bdae8b0aade1e7d80c8a81e
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

Commit-ID:  e7a3a055f2b88ebd0bdae8b0aade1e7d80c8a81e
Gitweb:     https://git.kernel.org/tip/e7a3a055f2b88ebd0bdae8b0aade1e7d80c8a81e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 9 Jan 2019 11:18:31 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf thread-stack: Tidy thread_stack__push_cp() usage

If 'cp' is checked in thread_stack__push_cp() a number of error checks
can be removed, reducing code size and improving readability.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
