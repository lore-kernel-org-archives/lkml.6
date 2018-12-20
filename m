Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAF5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F84218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbeLTSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:18:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:18:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIIaHL3683376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:18:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIIaLH3683373;
        Thu, 20 Dec 2018 10:18:36 -0800
Date:   Thu, 20 Dec 2018 10:18:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2c7h1m8fhzb9puxtj9nlevi8@git.kernel.org>
Cc:     adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        tglx@linutronix.de, acme@redhat.com, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
          tglx@linutronix.de, acme@redhat.com, lclaudio@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow configuring if the syscall
 duration should be printed
Git-Commit-ID: 42e4a52d01d087e7ce069049799e3e336eaec101
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

Commit-ID:  42e4a52d01d087e7ce069049799e3e336eaec101
Gitweb:     https://git.kernel.org/tip/42e4a52d01d087e7ce069049799e3e336eaec101
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 10:22:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:00 -0300

perf trace: Allow configuring if the syscall duration should be printed

  # perf config trace.show_duration=no
  # perf config -l | grep trace
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=true
  trace.show_duration=no
  # trace -e *sleep sleep 1
     0.000 sleep/8729 nanosleep(rqtp: 0x7ffcb0b4c940, rmtp: 0) = 0
  # perf config trace.show_duration=yes
  # trace -e *sleep sleep 1
     0.000 (1000.212 ms): sleep/8735 nanosleep(rqtp: 0x7ffca15fa770, rmtp: 0) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2c7h1m8fhzb9puxtj9nlevi8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 4 ++++
 tools/perf/builtin-trace.c               | 9 +++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index b55bd16c77fe..0d641b0d15ae 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -528,6 +528,10 @@ trace.*::
 		The initial use case is to add augmented_raw_syscalls.o to
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
+
+	trace.show_duration::
+		Show syscall duration.
+
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4d97bdac205c..4355dadad232 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_duration;
 	bool			show_zeros;
 	bool			force;
 	bool			vfs_getname;
@@ -1215,7 +1216,8 @@ static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thre
 					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
 {
 	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, duration_calculated, fp);
+	if (trace->show_duration)
+		printed += fprintf_duration(duration, duration_calculated, fp);
 	return printed + trace__fprintf_comm_tid(trace, thread, fp);
 }
 
@@ -2190,7 +2192,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
-	if (trace->trace_syscalls)
+	if (trace->trace_syscalls && trace->show_duration)
 		fprintf(trace->output, "(         ): ");
 
 	if (thread)
@@ -3536,6 +3538,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_duration")) {
+		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		trace->show_zeros = perf_config_bool(var, value);
 	}
@@ -3568,6 +3572,7 @@ int cmd_trace(int argc, const char **argv)
 		},
 		.output = stderr,
 		.show_comm = true,
+		.show_duration = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
