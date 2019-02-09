Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CBAC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA26E21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBIM7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:59:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:59:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CwrhI2633950
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:58:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Cwq1s2633947;
        Sat, 9 Feb 2019 04:58:52 -0800
Date:   Sat, 9 Feb 2019 04:58:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-90c2cda7056e3a7555d874a27aae12fd46ca802e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, acme@redhat.com
In-Reply-To: <20190109091835.5570-4-adrian.hunter@intel.com>
References: <20190109091835.5570-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread-stack: Tidy
 thread_stack__no_call_return() by adding more local variables
Git-Commit-ID: 90c2cda7056e3a7555d874a27aae12fd46ca802e
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

Commit-ID:  90c2cda7056e3a7555d874a27aae12fd46ca802e
Gitweb:     https://git.kernel.org/tip/90c2cda7056e3a7555d874a27aae12fd46ca802e
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 9 Jan 2019 11:18:32 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables

Make thread_stack__no_call_return() more readable by adding more local
variables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 35 +++++++++++++++++------------------
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
