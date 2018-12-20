Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF821901
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeLTSRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:17:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:17:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIHSTl3683091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:17:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIHSBD3683088;
        Thu, 20 Dec 2018 10:17:28 -0800
Date:   Thu, 20 Dec 2018 10:17:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0lgj7vh64hg3ce44gsmvj7ud@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, lclaudio@redhat.com, acme@redhat.com,
        wangnan0@huawei.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          lclaudio@redhat.com, acme@redhat.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow specifying a set of events to add
 in perfconfig
Git-Commit-ID: ac96287cae0851797262da37347b83797db931b3
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

Commit-ID:  ac96287cae0851797262da37347b83797db931b3
Gitweb:     https://git.kernel.org/tip/ac96287cae0851797262da37347b83797db931b3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Dec 2018 17:30:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:00 -0300

perf trace: Allow specifying a set of events to add in perfconfig

To add augmented_raw_syscalls to the events speficied by the user, or be
the only one if no events were specified by the user, one can add this
to perfconfig:

  # cat ~/.perfconfig
  [trace]
	  add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

I.e. pre-compile the augmented_raw_syscalls.c BPF program and make it
always load, this way:

  # perf trace -e open* cat /etc/passwd > /dev/null
     0.000 ( 0.013 ms): cat/31557 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.035 ( 0.007 ms): cat/31557 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.353 ( 0.009 ms): cat/31557 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
     0.424 ( 0.006 ms): cat/31557 openat(dfd: CWD, filename: /etc/passwd) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0lgj7vh64hg3ce44gsmvj7ud@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  8 ++++++++
 tools/perf/builtin-trace.c               | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 661b1fb3f8ba..423cb41f6e3f 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -521,6 +521,14 @@ diff.*::
 		Possible values are 'delta', 'delta-abs', 'ratio' and
 		'wdiff'.  Default is 'delta'.
 
+trace.*::
+	trace.add_events::
+		Allows adding a set of events to add to the ones specified
+		by the user, or use as a default one if none was specified.
+		The initial use case is to add augmented_raw_syscalls.o to
+		activate the 'perf trace' logic that looks for syscall
+		pointer contents after the normal tracepoint payload.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 096380e8c213..d754a74aef46 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -22,6 +22,7 @@
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
+#include "util/config.h"
 #include "util/debug.h"
 #include "util/env.h"
 #include "util/event.h"
@@ -3523,6 +3524,21 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
 	trace->syscalls.map = bpf__find_map_by_name("syscalls");
 }
 
+static int trace__config(const char *var, const char *value, void *arg)
+{
+	int err = 0;
+
+	if (!strcmp(var, "trace.add_events")) {
+		struct trace *trace = arg;
+		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
+					       "event selector. use 'perf list' to list available events",
+					       parse_events_option);
+		err = parse_events_option(&o, value, 0);
+	}
+
+	return err;
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3645,6 +3661,10 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	err = perf_config(trace__config, &trace);
+	if (err)
+		goto out;
+
 	argc = parse_options_subcommand(argc, argv, trace_options, trace_subcommands,
 				 trace_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
