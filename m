Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41749C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E364218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbeLTSLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:11:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36623 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbeLTSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:11:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIBCo33682001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:11:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIBCCc3681998;
        Thu, 20 Dec 2018 10:11:12 -0800
Date:   Thu, 20 Dec 2018 10:11:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-k8mwu04l8es29rje5loq9vg7@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Switch to using a struct
 for the syscalls map values
Git-Commit-ID: 27f2992e7bb12ca28e886e48838ba740d2eb95f4
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

Commit-ID:  27f2992e7bb12ca28e886e48838ba740d2eb95f4
Gitweb:     https://git.kernel.org/tip/27f2992e7bb12ca28e886e48838ba740d2eb95f4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 16:46:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:58 -0300

perf augmented_syscalls: Switch to using a struct for the syscalls map values

We'll start adding more perf-syscall stuff, so lets do this prep step so
that the next ones are just about adding more fields.

Run it with the .c file once to cache the .o file:

  # trace --filter-pids 2834,2199 -e openat,augmented_raw_syscalls.c
  LLVM: dumping augmented_raw_syscalls.o
       0.000 ( 0.021 ms): tmux: server/4952 openat(dfd: CWD, filename: /proc/5691/cmdline                         ) = 11
     349.807 ( 0.040 ms): DNS Res~er #39/11082 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 44
    4988.759 ( 0.052 ms): gsd-color/2431 openat(dfd: CWD, filename: /etc/localtime                             ) = 18
    4988.976 ( 0.029 ms): gsd-color/2431 openat(dfd: CWD, filename: /etc/localtime                             ) = 18
  ^C[root@quaco bpf]#

From now on, we can use just the newly built .o file, skipping the
compilation step for a faster startup:

  # trace --filter-pids 2834,2199 -e openat,augmented_raw_syscalls.o
       0.000 ( 0.046 ms): DNS Res~er #39/11088 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 44
    1946.408 ( 0.190 ms): systemd/1 openat(dfd: CWD, filename: /proc/1071/cgroup, flags: CLOEXEC          ) = 20
    1946.792 ( 0.215 ms): systemd/1 openat(dfd: CWD, filename: /proc/954/cgroup, flags: CLOEXEC           ) = 20
  ^C#

Now on to do the same in the builtin-trace.c side of things.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-k8mwu04l8es29rje5loq9vg7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index bb3dcc4ec256..a91c5874433e 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -26,10 +26,14 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
 	.max_entries = __NR_CPUS__,
 };
 
+struct syscall {
+	bool	enabled;
+};
+
 struct bpf_map SEC("maps") syscalls = {
 	.type	     = BPF_MAP_TYPE_ARRAY,
 	.key_size    = sizeof(int),
-	.value_size  = sizeof(bool),
+	.value_size  = sizeof(struct syscall),
 	.max_entries = 512,
 };
 
@@ -63,7 +67,7 @@ int sys_enter(struct syscall_enter_args *args)
 		struct syscall_enter_args args;
 		struct augmented_filename filename;
 	} augmented_args;
-	bool *enabled;
+	struct syscall *syscall;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
@@ -72,8 +76,8 @@ int sys_enter(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
 
-	enabled = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
-	if (enabled == NULL || !*enabled)
+	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
+	if (syscall == NULL || !syscall->enabled)
 		return 0;
 	/*
 	 * Yonghong and Edward Cree sayz:
@@ -144,15 +148,15 @@ SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
-	bool *enabled;
+	struct syscall *syscall;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
 	probe_read(&exit_args, sizeof(exit_args), args);
 
-	enabled = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
-	if (enabled == NULL || !*enabled)
+	syscall = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
+	if (syscall == NULL || !syscall->enabled)
 		return 0;
 
 	return 1;
