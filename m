Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ACC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE02218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbeLTSST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:18:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeLTSSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:18:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKII2pK3683262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:18:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKII2tb3683230;
        Thu, 20 Dec 2018 10:18:02 -0800
Date:   Thu, 20 Dec 2018 10:18:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-q0gxws02ygodh94o0hzim5xd@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
        acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        lclaudio@redhat.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
          lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, hpa@zytor.com, namhyung@kernel.org,
          mingo@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow configuring if zeroed syscall
 args should be printed
Git-Commit-ID: e7c634fcc6ff921d725ba988cdb198ca8b59a39f
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

Commit-ID:  e7c634fcc6ff921d725ba988cdb198ca8b59a39f
Gitweb:     https://git.kernel.org/tip/e7c634fcc6ff921d725ba988cdb198ca8b59a39f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 10:12:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:00 -0300

perf trace: Allow configuring if zeroed syscall args should be printed

The default so far, since we show argument names followed by its values,
was to make the output more compact by suppressing most zeroed args.

Make this configurable so that users can choose what best suit their
needs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q0gxws02ygodh94o0hzim5xd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 2 ++
 tools/perf/builtin-trace.c               | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 423cb41f6e3f..b55bd16c77fe 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -528,6 +528,8 @@ trace.*::
 		The initial use case is to add augmented_raw_syscalls.o to
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
+	trace.show_zeros::
+		Do not suppress syscall arguments that are equal to zero.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d754a74aef46..4d97bdac205c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
+	bool			show_zeros;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1598,6 +1599,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
  			 * strarray for it.
  			 */
 			if (val == 0 &&
+			    !trace->show_zeros &&
 			    !(sc->arg_fmt &&
 			      (sc->arg_fmt[arg.idx].show_zero ||
 			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
@@ -3526,14 +3528,16 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
 
 static int trace__config(const char *var, const char *value, void *arg)
 {
+	struct trace *trace = arg;
 	int err = 0;
 
 	if (!strcmp(var, "trace.add_events")) {
-		struct trace *trace = arg;
 		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
 		err = parse_events_option(&o, value, 0);
+	} else if (!strcmp(var, "trace.show_zeros")) {
+		trace->show_zeros = perf_config_bool(var, value);
 	}
 
 	return err;
