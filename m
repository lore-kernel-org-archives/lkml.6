Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9919C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CC0218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbeLTSJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:09:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51509 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeLTSJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:09:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI9T0x3681771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:09:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI9Sam3681768;
        Thu, 20 Dec 2018 10:09:28 -0800
Date:   Thu, 20 Dec 2018 10:09:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kjmnbrlgu0c38co1ye8egbsb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          namhyung@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
          acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Avoid using raw_syscalls in duplicity
 with eBPF augmentation
Git-Commit-ID: 0df50e0b0e0f315c0d5e2ce8556aafe1403b4a4b
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

Commit-ID:  0df50e0b0e0f315c0d5e2ce8556aafe1403b4a4b
Gitweb:     https://git.kernel.org/tip/0df50e0b0e0f315c0d5e2ce8556aafe1403b4a4b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 13:47:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:57 -0300

perf trace: Avoid using raw_syscalls in duplicity with eBPF augmentation

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
