Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F12C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57928218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbeLTSKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:10:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbeLTSKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:10:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIA3ip3681868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:10:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIA2ip3681864;
        Thu, 20 Dec 2018 10:10:02 -0800
Date:   Thu, 20 Dec 2018 10:10:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cy222g9ucvnym3raqvxp0hpg@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Implement syscall filtering in
 augmented_syscalls
Git-Commit-ID: b27b38ed9427b32e0194e03281e3a79dd49887b2
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

Commit-ID:  b27b38ed9427b32e0194e03281e3a79dd49887b2
Gitweb:     https://git.kernel.org/tip/b27b38ed9427b32e0194e03281e3a79dd49887b2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 12 Dec 2018 13:39:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:58 -0300

perf trace: Implement syscall filtering in augmented_syscalls

Just another map, this time an BPF_MAP_TYPE_ARRAY, stating with
one bool per syscall, stating if it should be filtered or not.

So, with a pre-built augmented_raw_syscalls.o file, we use:

  # perf trace -e open*,augmented_raw_syscalls.o
     0.000 ( 0.016 ms): DNS Res~er #37/29652 openat(dfd: CWD, filename: /etc/hosts, flags: CLOEXEC                 ) = 138
   187.039 ( 0.048 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /etc/fstab, flags: CLOEXEC                 ) = 11
   187.348 ( 0.041 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   188.793 ( 0.036 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   189.803 ( 0.029 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   190.774 ( 0.027 ms): gsd-housekeepi/2436 openat(dfd: CWD, filename: /proc/self/mountinfo, flags: CLOEXEC       ) = 11
   284.620 ( 0.149 ms): DataStorage/3076 openat(dfd: CWD, filename: /home/acme/.mozilla/firefox/ina67tev.default/SiteSecurityServiceState.txt, flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUSR|IWGRP) = 167
  ^C#

What is it that this gsd-housekeeping thingy needs to open
/proc/self/mountinfo four times periodically? :-)

This map will be extended to tell per-syscall parameters, i.e. how many
bytes to copy per arg, using the function signature to get the types and
then the size of those types, via BTF.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cy222g9ucvnym3raqvxp0hpg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       | 66 ++++++++++++++++++++++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 26 +++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f9eb5bc4fefb..de81918c7ad4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -76,6 +76,7 @@ struct trace {
 	struct {
 		int		max;
 		struct syscall  *table;
+		struct bpf_map  *map;
 		struct {
 			struct perf_evsel *sys_enter,
 					  *sys_exit,
@@ -2578,8 +2579,64 @@ out_enomem:
 	goto out;
 }
 
+#ifdef HAVE_LIBBPF_SUPPORT
+static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
+{
+	int fd = bpf_map__fd(trace->syscalls.map);
+	bool value = !trace->not_ev_qualifier;
+	int err = 0;
+	size_t i;
+
+	for (i = 0; i < trace->ev_qualifier_ids.nr; ++i) {
+		int key = trace->ev_qualifier_ids.entries[i];
+
+		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
+{
+	int fd = bpf_map__fd(trace->syscalls.map);
+	int err = 0, key;
+
+	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		err = bpf_map_update_elem(fd, &key, &enabled, BPF_ANY);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int trace__init_syscalls_bpf_map(struct trace *trace)
+{
+	bool enabled = true;
+
+	if (trace->ev_qualifier_ids.nr)
+		enabled = trace->not_ev_qualifier;
+
+	return __trace__init_syscalls_bpf_map(trace, enabled);
+}
+#else
+static int trace__set_ev_qualifier_bpf_filter(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
+
+static int trace__init_syscalls_bpf_map(struct trace *trace __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
+	if (trace->syscalls.map)
+		return trace__set_ev_qualifier_bpf_filter(trace);
 	return trace__set_ev_qualifier_tp_filter(trace);
 }
 
@@ -2822,6 +2879,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_mem;
 
+	if (trace->syscalls.map)
+		trace__init_syscalls_bpf_map(trace);
+
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3449,6 +3509,11 @@ static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
 }
 
+static void trace__set_bpf_map_syscalls(struct trace *trace)
+{
+	trace->syscalls.map = bpf__find_map_by_name("syscalls");
+}
+
 int cmd_trace(int argc, const char **argv)
 {
 	const char *trace_usage[] = {
@@ -3589,6 +3654,7 @@ int cmd_trace(int argc, const char **argv)
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
 		trace__set_bpf_map_filtered_pids(&trace);
+		trace__set_bpf_map_syscalls(&trace);
 	}
 
 	err = bpf__setup_stdout(trace.evlist);
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 74ce7574073d..bb3dcc4ec256 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -26,6 +26,13 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
 	.max_entries = __NR_CPUS__,
 };
 
+struct bpf_map SEC("maps") syscalls = {
+	.type	     = BPF_MAP_TYPE_ARRAY,
+	.key_size    = sizeof(int),
+	.value_size  = sizeof(bool),
+	.max_entries = 512,
+};
+
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
@@ -56,6 +63,7 @@ int sys_enter(struct syscall_enter_args *args)
 		struct syscall_enter_args args;
 		struct augmented_filename filename;
 	} augmented_args;
+	bool *enabled;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
@@ -63,6 +71,10 @@ int sys_enter(struct syscall_enter_args *args)
 		return 0;
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+
+	enabled = bpf_map_lookup_elem(&syscalls, &augmented_args.args.syscall_nr);
+	if (enabled == NULL || !*enabled)
+		return 0;
 	/*
 	 * Yonghong and Edward Cree sayz:
 	 *
@@ -131,7 +143,19 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return !pid_filter__has(&pids_filtered, getpid());
+	struct syscall_exit_args exit_args;
+	bool *enabled;
+
+	if (pid_filter__has(&pids_filtered, getpid()))
+		return 0;
+
+	probe_read(&exit_args, sizeof(exit_args), args);
+
+	enabled = bpf_map_lookup_elem(&syscalls, &exit_args.syscall_nr);
+	if (enabled == NULL || !*enabled)
+		return 0;
+
+	return 1;
 }
 
 license(GPL);
