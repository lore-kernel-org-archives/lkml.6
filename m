Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5822DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2A8218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbeLTSVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:21:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:21:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIKtI63683669
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:20:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIKsg73683666;
        Thu, 20 Dec 2018 10:20:54 -0800
Date:   Thu, 20 Dec 2018 10:20:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ta9tbdwgodpw719sr2bjm8eb@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        acme@redhat.com, lclaudio@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, lclaudio@redhat.com, acme@redhat.com,
          wangnan0@huawei.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow suppressing the syscall argument
 names
Git-Commit-ID: 9d6dc178f0c9e40e61f45d2ac86baa8ad77cb052
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

Commit-ID:  9d6dc178f0c9e40e61f45d2ac86baa8ad77cb052
Gitweb:     https://git.kernel.org/tip/9d6dc178f0c9e40e61f45d2ac86baa8ad77cb052
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 11:32:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:01 -0300

perf trace: Allow suppressing the syscall argument names

To show just the values:

Default:

  # trace -e open*,close,*sleep sleep 1
  openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
  close(fd: 3                                                           ) = 0
  nanosleep(rqtp: 0x7ffc0c4ea0d0, rmtp: 0                               ) = 0
  close(fd: 1                                                           ) = 0
  close(fd: 2                                                           ) = 0
  #

Remove it:

  # perf config trace.show_arg_names=no
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC                   ) = 3
  close(3                                                               ) = 0
  nanosleep(0x7ffced3a8c40, 0                                           ) = 0
  close(1                                                               ) = 0
  close(2                                                               ) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ta9tbdwgodpw719sr2bjm8eb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index ecd1e9514925..35108fd61fa6 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -532,6 +532,10 @@ trace.*::
 	trace.no_inherit::
 		Do not follow children threads.
 
+	trace.show_arg_names::
+		Should syscall argument names be printed? If not then trace.show_zeros
+		will be set.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e978ce034863..95dfcb851604 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -130,6 +130,7 @@ struct trace {
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
+	bool			show_arg_names;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1613,8 +1614,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			      sc->arg_fmt[arg.idx].parm))
 				continue;
 
-			printed += scnprintf(bf + printed, size - printed,
-					     "%s%s: ", printed ? ", " : "", field->name);
+			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
 			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
@@ -3546,12 +3550,21 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
 		trace->show_duration = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.show_arg_names")) {
+		trace->show_arg_names = perf_config_bool(var, value);
+		if (!trace->show_arg_names)
+			trace->show_zeros = true;
 	} else if (!strcmp(var, "trace.show_zeros")) {
-		trace->show_zeros = perf_config_bool(var, value);
+		bool new_show_zeros = perf_config_bool(var, value);
+		if (!trace->show_arg_names && !new_show_zeros) {
+			pr_warning("trace.show_zeros has to be set when trace.show_arg_names=no\n");
+			goto out;
+		}
+		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
-
+out:
 	return err;
 }
 
@@ -3582,6 +3595,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_comm = true,
 		.show_tstamp = true,
 		.show_duration = true,
+		.show_arg_names = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
