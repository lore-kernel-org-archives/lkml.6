Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110FAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D337A218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170987;
	bh=M5IOW4ASL4nOl4fRdyI73jAB3zrQva+YEAyfTIEL3sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p8K+r4NqJBNCdM1cGoXSkezQ5jUPfmc9PJjWoUA0sVdUBu4u91Zd62DWaD2FKvcpe
	 xqNKZtLFFE6SH1OAtEKR05LzrBF0d7MJ7uNR+uHeAQYe+MTHLfsJwFyRs2tKyfFy6j
	 FMUyws3P7dUrWtJvUGxJUQ+QK9LpY6xRYWUXpEAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeLRWJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:38042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeLRWJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:44 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06F96218AC;
        Tue, 18 Dec 2018 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170983;
        bh=M5IOW4ASL4nOl4fRdyI73jAB3zrQva+YEAyfTIEL3sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVWUJfPp1DmeTEZG3BDRw9zUeI/TlwCd1nt6vgMg+sLM/oXigY1bg0vF7sBdmx2si
         xBqn5FfKoRx+wAy3EafeBuUar9Vk2qv3Bmxr1N5F3lYgFcygCtNqGGpEVQ2rkTXQ0z
         Y16z0idN7W+zYA+r9VTwj1wwZIOtKQu+OZMtWYIE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/63] perf trace: Avoid using raw_syscalls in duplicity with eBPF augmentation
Date:   Tue, 18 Dec 2018 19:06:51 -0300
Message-Id: <20181218220733.15839-22-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So when we do something like:

   # perf trace -e open*,augmented_raw_syscalls.o

We need to set trace->trace_syscalls because there is logic that use
that when mixing strace-like output with other events, such as scheduler
tracepoints, but with that set we ended up having multiple
raw_syscalls:sys_{enter,exit} setup, which garbled the output, so
check if trace->augmented_raw_syscalls is set and avoid the two extra
tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kjmnbrlgu0c38co1ye8egbsb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 76e4fa04d824..f9eb5bc4fefb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2721,11 +2721,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->live = true;
 
-	if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
-		goto out_error_raw_syscalls;
+	if (!trace->raw_augmented_syscalls) {
+		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
+			goto out_error_raw_syscalls;
 
-	if (trace->trace_syscalls)
-		trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+		if (trace->trace_syscalls)
+			trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
 		pgfault_maj = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
@@ -2825,8 +2827,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (err < 0)
 			goto out_errno;
 
-		pr_debug("event qualifier tracepoint filter: %s\n",
-			 trace->syscalls.events.sys_exit->filter);
+		if (trace->syscalls.events.sys_exit) {
+			pr_debug("event qualifier tracepoint filter: %s\n",
+				 trace->syscalls.events.sys_exit->filter);
+		}
 	}
 
 	err = perf_evlist__apply_filters(evlist, &evsel);
-- 
2.19.2

