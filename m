Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2FBC4151A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FA020823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479162;
	bh=ykpzrW1iNH2hxE6ltJ1grjJMWh3PzyccGH5CPIYOak8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ypRK9hlICng5FqMGX3o3Ubf4Xtc6G7czLFuTRkpfnqx5lrbtqrUS94L4/a9AtQazM
	 sYHaKTEnUe6t51uY3Ad2xjQvM9vOsbwH+MOjZ+SF4irgXQ8QFn4gCx/7dZBY6ZRQzM
	 Al6Mb+YGAM3So8KL8nGyUPug7WC2fLnuTC3iWAwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBFSwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:52:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfBFSvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E676206DD;
        Wed,  6 Feb 2019 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479109;
        bh=ykpzrW1iNH2hxE6ltJ1grjJMWh3PzyccGH5CPIYOak8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrAgH59MeYtDE6iUORoSJKLOSU6HQ1kgOqKn4uuSxSrIOO+3qsfJhGsV783Df/Kpr
         JE5dRlwvQW6Jy4V/1VtOT+gcy3aG26ApBkyxZ2cq02G1KmuTN68PVnA6sssQppY0CX
         7iQ7BBvPH7gRSk5Nt0l1mAKZgiYSEEi08RqZOHvQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 47/53] perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
Date:   Wed,  6 Feb 2019 15:48:57 -0300
Message-Id: <20190206184903.24054-48-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Make thread_stack__no_call_return() more readable by adding more local
variables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

