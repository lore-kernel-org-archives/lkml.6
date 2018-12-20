Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8087C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3170218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbeLTSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:21:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbeLTSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:21:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKILToM3683921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:21:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKILT3a3683917;
        Thu, 20 Dec 2018 10:21:29 -0800
Date:   Thu, 20 Dec 2018 10:21:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-r8cbhoz1lr5npq9tutpvoigr@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, wangnan0@huawei.com,
        adrian.hunter@intel.com, lclaudio@redhat.com, mingo@kernel.org,
        acme@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com,
          wangnan0@huawei.com, tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Make the alignment of the syscall args
 be configurable
Git-Commit-ID: 9ed45d59aeae2211933b032acc4e5b40a1a2fcd3
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

Commit-ID:  9ed45d59aeae2211933b032acc4e5b40a1a2fcd3
Gitweb:     https://git.kernel.org/tip/9ed45d59aeae2211933b032acc4e5b40a1a2fcd3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 13:40:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:07:26 -0300

perf trace: Make the alignment of the syscall args be configurable

Since the start 'perf trace' aligns the parens enclosing the list of
syscall args to align the syscall results, allow this to be
configurable, keeping the default of 70. Using:

  # perf config
  llvm.dump-obj=true
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  trace.no_inherit=yes
  trace.show_timestamp=no
  trace.show_arg_names=no
  trace.args_alignment=0
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC) = 3
  close(3) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC) = 3
  close(3) = 0
  nanosleep(0x7ffc00de66f0, 0) = 0
  close(1) = 0
  close(2) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r8cbhoz1lr5npq9tutpvoigr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 35108fd61fa6..0098eab8e5b1 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,10 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.args_alignment::
+		Number of columns to align the argument list, default is 70,
+		use 40 for the strace default, zero to no alignment.
+
 	trace.no_inherit::
 		Do not follow children threads.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 95dfcb851604..2d8fd48a4727 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	s16			args_alignment;
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
@@ -1731,7 +1732,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
+	printed += fprintf(trace->output, "%-*s) ...\n", trace->args_alignment, ttrace->entry_str);
 	ttrace->entry_pending = false;
 
 	++trace->nr_events_printed;
@@ -1838,7 +1839,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
-			fprintf(trace->output, "%-70s)\n", ttrace->entry_str);
+			fprintf(trace->output, "%-*s)\n", trace->args_alignment, ttrace->entry_str);
 		}
 	} else {
 		ttrace->entry_pending = true;
@@ -1981,7 +1982,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 
 	if (ttrace->entry_pending) {
-		fprintf(trace->output, "%-70s", ttrace->entry_str);
+		fprintf(trace->output, "%-*s", trace->args_alignment, ttrace->entry_str);
 	} else {
 		fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
@@ -3563,6 +3564,10 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.args_alignment")) {
+		int args_alignment = 0;
+		if (perf_config_int(&args_alignment, var, value) == 0)
+			trace->args_alignment = args_alignment;
 	}
 out:
 	return err;
@@ -3596,6 +3601,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_tstamp = true,
 		.show_duration = true,
 		.show_arg_names = true,
+		.args_alignment = 70,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
