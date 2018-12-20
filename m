Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D462B218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbeLTSUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:20:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:20:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIKLBC3683603
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:20:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIKKJm3683600;
        Thu, 20 Dec 2018 10:20:20 -0800
Date:   Thu, 20 Dec 2018 10:20:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mjjnicy48367jah6ls4k0nk8@git.kernel.org>
Cc:     wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, lclaudio@redhat.com, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, lclaudio@redhat.com, adrian.hunter@intel.com,
          tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow configuring if the syscall start
 timestamp should be printed
Git-Commit-ID: b036146fd0f99209e87877115d090c69da2ab747
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

Commit-ID:  b036146fd0f99209e87877115d090c69da2ab747
Gitweb:     https://git.kernel.org/tip/b036146fd0f99209e87877115d090c69da2ab747
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 11:17:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:01 -0300

perf trace: Allow configuring if the syscall start timestamp should be printed

  # trace -e open*,close,*sleep sleep 1
     0.000 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
     0.016 close(fd: 3                                                           ) = 0
     0.024 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
     0.074 close(fd: 3                                                           ) = 0
     0.235 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
     0.251 close(fd: 3                                                           ) = 0
     0.285 nanosleep(rqtp: 0x7ffd68e6d620, rmtp: 0                               ) = 0
  1000.386 close(fd: 1                                                           ) = 0
  1000.395 close(fd: 2                                                           ) = 0
  #

  # perf config trace.show_timestamp=no
  # trace -e open*,close,*sleep sleep 1
  openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: , flags: CLOEXEC                           ) = 3
  close(fd: 3                                                           ) = 0
  nanosleep(rqtp: 0x7fffa79c38e0, rmtp: 0                               ) = 0
  close(fd: 1                                                           ) = 0
  close(fd: 2                                                           ) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mjjnicy48367jah6ls4k0nk8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 3 +++
 tools/perf/builtin-trace.c               | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index cd9bf12fb255..ecd1e9514925 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -535,6 +535,9 @@ trace.*::
 	trace.show_duration::
 		Show syscall duration.
 
+	trace.show_timestamp::
+		Show syscall start timestamp.
+
 	trace.show_zeros::
 		Do not suppress syscall arguments that are equal to zero.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a4e2290e57e0..e978ce034863 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
 	bool			force;
@@ -1215,7 +1216,10 @@ static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread
 static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
 					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
 {
-	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	size_t printed = 0;
+
+	if (trace->show_tstamp)
+		printed = trace__fprintf_tstamp(trace, tstamp, fp);
 	if (trace->show_duration)
 		printed += fprintf_duration(duration, duration_calculated, fp);
 	return printed + trace__fprintf_comm_tid(trace, thread, fp);
@@ -3538,6 +3542,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_timestamp")) {
+		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
 		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
@@ -3574,6 +3580,7 @@ int cmd_trace(int argc, const char **argv)
 		},
 		.output = stderr,
 		.show_comm = true,
+		.show_tstamp = true,
 		.show_duration = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
