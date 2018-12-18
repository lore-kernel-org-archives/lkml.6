Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A85C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170991;
	bh=aRijuydFcdIGUnfO31WU1EqXSS/PRyvCf3K/WgnL9IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IW5LTzaBmxyp7SKxkjWKG/6CUdGG4cf/PZfL5z2QT6MhopfNKvuauB4CDy4hnKBDd
	 54A6OnOe472Ph5f8KdR3wMkzN3Bq4uN2Y73aNn0ou5t0mlQykHqcvRyYHH2isas4z6
	 ci9S9atBJQeJ/g+82XKCe3cwMF54yywr4R6ZuyeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeLRWJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeLRWJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:48 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804D1217D9;
        Tue, 18 Dec 2018 22:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170987;
        bh=aRijuydFcdIGUnfO31WU1EqXSS/PRyvCf3K/WgnL9IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MpQMZvhS+AtNTY8sOLNH+Pem4M+IEop/1lJkvZWlOdMxDGQzGAJmHdxNyOeMACGaH
         0eQyheGrCNNsFXFB5fJbOoARvGIoO43fKh2r1qedCmkSk2cxFJefP1IfJaimeZc+KF
         k6E02nAIs7umMsLBH9MGi6rUrFYBSq2acGuMRVz0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 22/63] perf trace: Implement syscall filtering in augmented_syscalls
Date:   Tue, 18 Dec 2018 19:06:52 -0300
Message-Id: <20181218220733.15839-23-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-trace.c                    | 66 +++++++++++++++++++
 .../examples/bpf/augmented_raw_syscalls.c     | 26 +++++++-
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
@@ -2578,8 +2579,64 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
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
-- 
2.19.2

