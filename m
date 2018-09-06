Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA0FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D122075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D122075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeIFSXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:23:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeIFSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:23:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DlUPT311157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:47:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DlUJ3311154;
        Thu, 6 Sep 2018 06:47:30 -0700
Date:   Thu, 6 Sep 2018 06:47:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p8uvt2a6ug3uwlhja3cno4la@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        dsahern@gmail.com, mingo@kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, tglx@linutronix.de, adrian.hunter@intel.com,
          acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          wangnan0@huawei.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Setup augmented_args in the
 raw_syscalls:sys_enter handler
Git-Commit-ID: db2da3f85cd6314321b6a9441a5af8841c93394d
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

Commit-ID:  db2da3f85cd6314321b6a9441a5af8841c93394d
Gitweb:     https://git.kernel.org/tip/db2da3f85cd6314321b6a9441a5af8841c93394d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 3 Sep 2018 16:24:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 4 Sep 2018 16:51:07 -0300

perf trace: Setup augmented_args in the raw_syscalls:sys_enter handler

Without using something to augment the raw_syscalls:sys_enter tracepoint
payload with the pointer contents, this will work just like before, i.e.
the augmented_args arg will be NULL and the augmented_args_size will be
0.

This just paves the way for the next cset where we will associate the
trace__sys_enter tracepoint handler with the augmented "bpf-output"
event named "__augmented_args__".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p8uvt2a6ug3uwlhja3cno4la@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 12356deb6046..2b99a02355cf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1697,6 +1697,8 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	size_t printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int augmented_args_size = 0;
+	void *augmented_args = NULL;
 	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	struct thread_trace *ttrace;
 
@@ -1720,13 +1722,24 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 
 	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
 		trace__printf_interrupted_entry(trace);
-
+	/*
+	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
+	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
+	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
+	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
+	 * so when handling, say the openat syscall, we end up getting 6 args for the
+	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
+	 * thinking that the extra 2 u64 args are the augmented filename, so just check
+	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
+	 */
+	if (evsel != trace->syscalls.events.sys_enter)
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
 
 	printed += syscall__scnprintf_args(sc, msg + printed, trace__entry_str_size - printed,
-					   args, NULL, 0, trace, thread);
+					   args, augmented_args, augmented_args_size, trace, thread);
 
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
