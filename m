Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1055CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAAE20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAAE20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeKGEih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:38:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44927 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGEih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:38:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JBlDV910319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:11:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JBlD2910316;
        Tue, 6 Nov 2018 11:11:47 -0800
Date:   Tue, 6 Nov 2018 11:11:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-nlslrg8apxdsobt4pwl3n7ur@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, wangnan0@huawei.com, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, dsahern@gmail.com,
          jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Fix setting of augmented payload when
 using eBPF + raw_syscalls
Git-Commit-ID: cd26ea6d50a207ee37e0364ecc2d196d6c9671e8
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

Commit-ID:  cd26ea6d50a207ee37e0364ecc2d196d6c9671e8
Gitweb:     https://git.kernel.org/tip/cd26ea6d50a207ee37e0364ecc2d196d6c9671e8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sat, 3 Nov 2018 08:19:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Sat, 3 Nov 2018 08:19:56 -0300

perf trace: Fix setting of augmented payload when using eBPF + raw_syscalls

For now with BPF raw_augmented we hook into raw_syscalls:sys_enter and
there we get all 6 syscall args plus the tracepoint common fields
(sizeof(long)) and the syscall_nr (another long). So we check if that is
the case and if so don't look after the sc->args_size, but always after
the full raw_syscalls:sys_enter payload, which is fixed.

We'll revisit this later to pass s->args_size to the BPF augmenter (now
tools/perf/examples/bpf/augmented_raw_syscalls.c, so that it copies only
what we need for each syscall, like what happens when we use
syscalls:sys_enter_NAME, so that we reduce the kernel/userspace traffic
to just what is needed for each syscall.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nlslrg8apxdsobt4pwl3n7ur@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f582ca575883..835619476370 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -108,6 +108,7 @@ struct trace {
 	} stats;
 	unsigned int		max_stack;
 	unsigned int		min_stack;
+	bool			raw_augmented_syscalls;
 	bool			not_ev_qualifier;
 	bool			live;
 	bool			full_time;
@@ -1724,13 +1725,28 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
-static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size)
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, bool raw_augmented)
 {
 	void *augmented_args = NULL;
+	/*
+	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
+	 * and there we get all 6 syscall args plus the tracepoint common
+	 * fields (sizeof(long)) and the syscall_nr (another long). So we check
+	 * if that is the case and if so don't look after the sc->args_size,
+	 * but always after the full raw_syscalls:sys_enter payload, which is
+	 * fixed.
+	 *
+	 * We'll revisit this later to pass s->args_size to the BPF augmenter
+	 * (now tools/perf/examples/bpf/augmented_raw_syscalls.c, so that it
+	 * copies only what we need for each syscall, like what happens when we
+	 * use syscalls:sys_enter_NAME, so that we reduce the kernel/userspace
+	 * traffic to just what is needed for each syscall.
+	 */
+	int args_size = raw_augmented ? (8 * (int)sizeof(long)) : sc->args_size;
 
-	*augmented_args_size = sample->raw_size - sc->args_size;
+	*augmented_args_size = sample->raw_size - args_size;
 	if (*augmented_args_size > 0)
-		augmented_args = sample->raw_data + sc->args_size;
+		augmented_args = sample->raw_data + args_size;
 
 	return augmented_args;
 }
@@ -1780,7 +1796,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
 	 */
 	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
@@ -1833,7 +1849,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
@@ -3501,8 +3517,15 @@ int cmd_trace(int argc, const char **argv)
 		evsel->handler = trace__sys_enter;
 
 		evlist__for_each_entry(trace.evlist, evsel) {
-			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_") ||
-			    strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0) {
+			bool raw_syscalls_sys_exit = strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
+
+			if (raw_syscalls_sys_exit) {
+				trace.raw_augmented_syscalls = true;
+				goto init_augmented_syscall_tp;
+			}
+
+			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+init_augmented_syscall_tp:
 				perf_evsel__init_augmented_syscall_tp(evsel);
 				perf_evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
