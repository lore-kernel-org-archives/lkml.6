Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD0D206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479148;
	bh=T+NeTDAoKrKIppjIwh43TIWRIrfcv2V7GEJoDr+UmpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=broeVyAeoBs9qtVxaVoW9VoaQtZBqWa+xfzA9YKxXyggwOG0ZdFui9HV4kKh3Udcl
	 X6yFOt01snRHnqtwzfefxMimz527L04Sc71Zko2KN0VX/4lFwdfBBgYOy7pffrrk4o
	 ArKfOYljTRuVuYPf8YDerkAC0tGeeDdeeRhCtXQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfBFSvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfBFSvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:47 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A7C2186A;
        Wed,  6 Feb 2019 18:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479106;
        bh=T+NeTDAoKrKIppjIwh43TIWRIrfcv2V7GEJoDr+UmpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHmgdXOCY7P7FxUDM1hDniDO4aXsukMBjtdnQ6vDV73ChMvDRSiofW6rkeF+myRfD
         L25QGAl6nZ4lcnXD8A9OZgbans5PpxVDtiQZod5jcpwg7qDtoA1xaf3B/c2fs0vrxl
         DqHqoPCmKtI7kcNs+AaGyV+1jyCiW23lIuRtvVP4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 46/53] perf thread-stack: Tidy thread_stack__push_cp() usage
Date:   Wed,  6 Feb 2019 15:48:56 -0300
Message-Id: <20190206184903.24054-47-acme@kernel.org>
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
-- 
2.20.1

