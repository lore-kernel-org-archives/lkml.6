Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeCLJr3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:47:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752415AbeCLJnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:21 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 03/13] perf tools: Add bpf command
Date: Mon, 12 Mar 2018 10:43:03 +0100
Message-Id: <20180312094313.18738-4-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf bpf command to allow to provide some
fucs over ebpf objects, like compile, disassembly
and loading, which is comming in following patches.

Link: http://lkml.kernel.org/n/tip-51vi69jgn3nfa00azjlikfck@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Build            |   1 +
 tools/perf/builtin-bpf.c    | 199 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin.h        |   1 +
 tools/perf/command-list.txt |   1 +
 tools/perf/perf.c           |   1 +
 5 files changed, 203 insertions(+)
 create mode 100644 tools/perf/builtin-bpf.c

diff --git a/tools/perf/Build b/tools/perf/Build
index e5232d567611..7f521ac16466 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -24,6 +24,7 @@ perf-y += builtin-mem.o
 perf-y += builtin-data.o
 perf-y += builtin-version.o
 perf-y += builtin-c2c.o
+perf-y += builtin-bpf.o
 
 perf-$(CONFIG_TRACE) += builtin-trace.o
 perf-$(CONFIG_LIBELF) += builtin-probe.o
diff --git a/tools/perf/builtin-bpf.c b/tools/perf/builtin-bpf.c
new file mode 100644
index 000000000000..6f02352caf79
--- /dev/null
+++ b/tools/perf/builtin-bpf.c
@@ -0,0 +1,199 @@
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <time.h>
+#include <linux/compiler.h>
+#include <subcmd/parse-options.h>
+#include "builtin.h"
+#include "perf.h"
+#include "target.h"
+#include "debug.h"
+#include "parse-events.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "bpf-loader.h"
+
+struct perf_bpf {
+	struct target		 target;
+	struct perf_evlist	*evlist;
+};
+
+struct perf_bpf bpf = {
+	.target = { .uid = UINT_MAX, },
+};
+
+static volatile int done;
+static volatile int workload_exec_errno;
+
+static void sig_handler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+/*
+ * perf_evlist__prepare_workload will send a SIGUSR1
+ * if the fork fails, since we asked by setting its
+ * want_signal to true.
+ */
+static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *info,
+					void *ucontext __maybe_unused)
+{
+	workload_exec_errno = info->si_value.sival_int;
+}
+
+static int create_perf_bpf_counter(struct perf_evsel *evsel)
+{
+	if (target__has_cpu(&bpf.target) && !target__has_per_thread(&bpf.target))
+		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+
+	return perf_evsel__open_per_thread(evsel, bpf.evlist->threads);
+}
+
+static int __cmd_bpf(int argc , const char **argv)
+{
+	struct perf_evsel *evsel;
+	bool forks = argc > 0;
+	int err, status;
+	int child_pid = -1;
+	char msg[BUFSIZ];
+	struct timespec ts = { .tv_sec = 0, .tv_nsec = 500 };
+
+	if (forks) {
+		err = perf_evlist__prepare_workload(bpf.evlist, &bpf.target,
+						    argv, true,
+						    workload_exec_failed_signal);
+		if (err < 0) {
+			pr_err("Couldn't run the workload!\n");
+			status = err;
+			goto out;
+		}
+
+		child_pid = bpf.evlist->workload.pid;
+	}
+
+        evlist__for_each_entry(bpf.evlist, evsel) {
+                err =create_perf_bpf_counter(evsel);
+		if (err < 0) {
+                        perf_evsel__open_strerror(evsel, &bpf.target,
+                                                  errno, msg, sizeof(msg));
+                        pr_err("%s\n", msg);
+			goto out_child;
+                }
+	}
+
+	err = bpf__apply_obj_config();
+	if (err) {
+		char errbuf[BUFSIZ];
+
+		bpf__strerror_apply_obj_config(err, errbuf, sizeof(errbuf));
+					       pr_err("ERROR: Apply config to BPF failed: %s\n",
+					       errbuf);
+		goto out_child;
+	}
+
+	if (forks) {
+		perf_evlist__start_workload(bpf.evlist);
+
+		if (!target__none(&bpf.target))
+			perf_evlist__enable(bpf.evlist);
+
+                waitpid(child_pid, &status, 0);
+        } else {
+		if (!target__none(&bpf.target))
+			perf_evlist__enable(bpf.evlist);
+
+                while (!done) {
+                        nanosleep(&ts, NULL);
+                }
+        }
+
+	if (!target__none(&bpf.target))
+		perf_evlist__disable(bpf.evlist);
+
+	child_pid = -1;
+
+out_child:
+	if (forks) {
+                if (workload_exec_errno) {
+                        const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
+                        pr_err("Workload failed: %s\n", emsg);
+                        return -1;
+                }
+
+		if (child_pid != -1) {
+			kill(child_pid, SIGTERM);
+			waitpid(child_pid, &status, 0);
+		}
+
+                if (WIFSIGNALED(status))
+                        psignal(WTERMSIG(status), argv[0]);
+	}
+
+out:
+	perf_evlist__close(bpf.evlist);
+
+	if (err)
+		status = err;
+	return WEXITSTATUS(status);
+}
+
+int cmd_bpf(int argc, const char **argv)
+{
+	int err = -1;
+	const char * const bpf_usage[] = {
+		"perf bpf [<options>] [<command>]",
+		"perf bpf [<options>] -- <command> [<options>]",
+		NULL
+	};
+	const struct option bpf_options[] = {
+		OPT_CALLBACK('e', "event", &bpf.evlist, "event",
+			     "event selector. use 'perf list' to list available events",
+			     parse_events_option),
+		OPT_STRING('C', "cpu", &bpf.target.cpu_list, "cpu",
+			   "list of cpus to monitor"),
+		OPT_BOOLEAN('a', "all-cpus", &bpf.target.system_wide,
+			    "system-wide collection from all CPUs"),
+		OPT_STRING('p', "pid", &bpf.target.pid, "pid",
+			   "record events on existing process id"),
+		OPT_STRING('t', "tid", &bpf.target.tid, "tid",
+			   "record events on existing thread id"),
+		OPT_INCR('v', "verbose", &verbose,
+			 "be more verbose"),
+		OPT_END()
+	};
+
+	signal(SIGINT, sig_handler);
+
+	bpf.evlist = perf_evlist__new();
+	if (bpf.evlist == NULL)
+		return -ENOMEM;
+
+	argc = parse_options(argc, argv, bpf_options, bpf_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (!argc && target__none(&bpf.target))
+		usage_with_options(bpf_usage, bpf_options);
+
+	if (bpf.evlist->nr_entries == 0) {
+		pr_err("failed: No event specified\n");
+		goto out;
+	}
+
+	if (perf_evlist__create_maps(bpf.evlist, &bpf.target) < 0) {
+		if (target__has_task(&bpf.target)) {
+			pr_err("Problems finding threads of monitor\n");
+			parse_options_usage(bpf_usage, bpf_options, "p", 1);
+			parse_options_usage(NULL, bpf_options, "t", 1);
+		} else if (target__has_cpu(&bpf.target)) {
+			perror("failed to parse CPUs map");
+			parse_options_usage(bpf_usage, bpf_options, "C", 1);
+			parse_options_usage(NULL, bpf_options, "a", 1);
+		}
+	}
+
+	target__validate(&bpf.target);
+
+	err = __cmd_bpf(argc, argv);
+out:
+	perf_evlist__delete(bpf.evlist);
+	return err;
+}
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 05745f3ce912..1805c65f4d01 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -39,6 +39,7 @@ int cmd_inject(int argc, const char **argv);
 int cmd_mem(int argc, const char **argv);
 int cmd_data(int argc, const char **argv);
 int cmd_ftrace(int argc, const char **argv);
+int cmd_bpf(int argc, const char **argv);
 
 int find_scripts(char **scripts_array, char **scripts_path_array);
 #endif
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index 2d0caf20ff3a..4e8e398d4f45 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -30,3 +30,4 @@ perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
 perf-trace			mainporcelain audit
+perf-bpf			mainporcelain common
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 1b3fc8ec0fa2..144cf71af0f7 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -80,6 +80,7 @@ static struct cmd_struct commands[] = {
 	{ "mem",	cmd_mem,	0 },
 	{ "data",	cmd_data,	0 },
 	{ "ftrace",	cmd_ftrace,	0 },
+	{ "bpf",	cmd_bpf,	0 },
 };
 
 struct pager_config {
-- 
2.13.6
