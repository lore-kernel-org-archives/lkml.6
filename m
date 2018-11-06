Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96DC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE9C20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE9C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbeKGAsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:48:31 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:55279 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbeKGAsb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 6 Nov 2018 19:48:31 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 06 Nov 2018 08:22:41 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     akpm@linux-foundation.org, jbaron@akamai.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] perf-bench: Add epoll_ctl(2) benchmark
Date:   Tue,  6 Nov 2018 07:22:26 -0800
Message-Id: <20181106152226.20883-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181106152226.20883-1-dave@stgolabs.net>
References: <20181106152226.20883-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benchmark the various operations allowed for epoll_ctl(2).
The idea is to concurrently stress a single epoll instance
doing add/mod/del operations.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/Documentation/perf-bench.txt |   3 +
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/bench.h                |   1 +
 tools/perf/bench/epoll-ctl.c            | 411 ++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   1 +
 5 files changed, 417 insertions(+)
 create mode 100644 tools/perf/bench/epoll-ctl.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 3a6b2e73b2e8..0921a3c67381 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -211,6 +211,9 @@ SUITES FOR 'epoll'
 *wait*::
 Suite for evaluating concurrent epoll_wait calls.
 
+*ctl*::
+Suite for evaluating multiple epoll_ctl calls.
+
 SEE ALSO
 --------
 linkperf:perf[1]
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index 2bb79b542d53..e4e321b6f883 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -8,6 +8,7 @@ perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
 perf-y += epoll-wait.o
+perf-y += epoll-ctl.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index c9c276aa6d4e..0e415464931b 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -39,6 +39,7 @@ int bench_futex_requeue(int argc, const char **argv);
 int bench_futex_lock_pi(int argc, const char **argv);
 
 int bench_epoll_wait(int argc, const char **argv);
+int bench_epoll_ctl(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
new file mode 100644
index 000000000000..b6f6fc4a7129
--- /dev/null
+++ b/tools/perf/bench/epoll-ctl.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Davidlohr Bueso.
+ *
+ * Benchmark the various operations allowed for epoll_ctl(2).
+ * The idea is to concurrently stress a single epoll instance
+ */
+
+/* For the CLR_() macros */
+#include <string.h>
+#include <pthread.h>
+
+#include <errno.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/epoll.h>
+#include <sys/eventfd.h>
+
+#include "../util/stat.h"
+#include <subcmd/parse-options.h>
+#include "bench.h"
+#include "cpumap.h"
+
+#include <err.h>
+
+#define printinfo(fmt, arg...) \
+	do { if (__verbose) printf(fmt, ## arg); } while (0)
+
+static unsigned int nthreads = 0;
+static unsigned int nsecs    = 8;
+struct timeval start, end, runtime;
+static bool done, __verbose, randomize;
+
+/*
+ * epoll related shared variables.
+ */
+
+/* Maximum number of nesting allowed inside epoll sets */
+#define EPOLL_MAXNESTS 4
+
+enum {
+	OP_EPOLL_ADD,
+	OP_EPOLL_MOD,
+	OP_EPOLL_DEL,
+	EPOLL_NR_OPS,
+};
+
+static int epollfd;
+static int *epollfdp;
+static bool noaffinity;
+static unsigned int nested = 0;
+
+/* amount of fds to monitor, per thread */
+static unsigned int nfds = 64;
+
+static pthread_mutex_t thread_lock;
+static unsigned int threads_starting;
+static struct stats all_stats[EPOLL_NR_OPS];
+static pthread_cond_t thread_parent, thread_worker;
+
+struct worker {
+	int tid;
+	pthread_t thread;
+	unsigned long ops[EPOLL_NR_OPS];
+	int *fdmap;
+};
+
+static const struct option options[] = {
+	OPT_UINTEGER('t', "threads", &nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('r', "runtime", &nsecs,    "Specify runtime (in seconds)"),
+	OPT_UINTEGER('f', "nfds", &nfds, "Specify amount of file descriptors to monitor for each thread"),
+	OPT_BOOLEAN( 'n', "noaffinity",  &noaffinity,   "Disables CPU affinity"),
+	OPT_UINTEGER( 'N', "nested",  &nested,   "Nesting level epoll hierarchy (default is 0, no nesting)"),
+	OPT_BOOLEAN( 'R', "randomize", &randomize,   "Perform random operations on random fds"),
+	OPT_BOOLEAN( 'v', "verbose",  &__verbose,   "Verbose mode"),
+	OPT_END()
+};
+
+static const char * const bench_epoll_ctl_usage[] = {
+	"perf bench epoll ctl <options>",
+	NULL
+};
+
+static void toggle_done(int sig __maybe_unused,
+			siginfo_t *info __maybe_unused,
+			void *uc __maybe_unused)
+{
+	/* inform all threads that we're done for the day */
+	done = true;
+	gettimeofday(&end, NULL);
+	timersub(&end, &start, &runtime);
+}
+
+static void nest_epollfd(void)
+{
+	unsigned int i;
+	struct epoll_event ev;
+
+	if (nested > EPOLL_MAXNESTS)
+		nested = EPOLL_MAXNESTS;
+	printinfo("Nesting level(s): %d\n", nested);
+
+	epollfdp = calloc(nested, sizeof(int));
+	if (!epollfd)
+		err(EXIT_FAILURE, "calloc");
+
+	for (i = 0; i < nested; i++) {
+		epollfdp[i] = epoll_create(1);
+		if (epollfd < 0)
+			err(EXIT_FAILURE, "epoll_create");
+	}
+
+	ev.events = EPOLLHUP; /* anything */
+	ev.data.u64 = i; /* any number */
+
+	for (i = nested - 1; i; i--) {
+		if (epoll_ctl(epollfdp[i - 1], EPOLL_CTL_ADD,
+			      epollfdp[i], &ev) < 0)
+			err(EXIT_FAILURE, "epoll_ctl");
+	}
+
+	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, *epollfdp, &ev) < 0)
+		err(EXIT_FAILURE, "epoll_ctl");
+}
+
+static inline void do_epoll_op(struct worker *w, int op, int fd)
+{
+	int error;
+	struct epoll_event ev;
+
+	ev.events = EPOLLIN;
+	ev.data.u64 = fd;
+
+	switch (op) {
+	case OP_EPOLL_ADD:
+		error = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+		break;
+	case OP_EPOLL_MOD:
+		ev.events = EPOLLOUT;
+		error = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
+		break;
+	case OP_EPOLL_DEL:
+		error = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, NULL);
+		break;
+	default:
+		error = 1;
+		break;
+	}
+
+	if (!error)
+		w->ops[op]++;
+}
+
+static inline void do_random_epoll_op(struct worker *w)
+{
+	unsigned long rnd1 = random(), rnd2 = random();
+	int op, fd;
+
+	fd = w->fdmap[rnd1 % nfds];
+	op = rnd2 % EPOLL_NR_OPS;
+
+	do_epoll_op(w, op, fd);
+}
+
+static void *workerfn(void *arg)
+{
+	unsigned int i;
+	struct worker *w = (struct worker *) arg;
+	struct timespec ts = { .tv_sec = 0,
+			       .tv_nsec = 250 };
+
+	pthread_mutex_lock(&thread_lock);
+	threads_starting--;
+	if (!threads_starting)
+		pthread_cond_signal(&thread_parent);
+	pthread_cond_wait(&thread_worker, &thread_lock);
+	pthread_mutex_unlock(&thread_lock);
+
+	/* Let 'em loose */
+	do {
+		/* random */
+		if (randomize) {
+			do_random_epoll_op(w);
+		} else {
+			for (i = 0; i < nfds; i++) {
+				do_epoll_op(w, OP_EPOLL_ADD, w->fdmap[i]);
+				do_epoll_op(w, OP_EPOLL_MOD, w->fdmap[i]);
+				do_epoll_op(w, OP_EPOLL_DEL, w->fdmap[i]);
+			}
+		}
+
+		nanosleep(&ts, NULL);
+	}  while (!done);
+
+	return NULL;
+}
+
+static void init_fdmaps(struct worker *w, int pct)
+{
+	ssize_t i;
+	int inc;
+	struct epoll_event ev;
+
+	if (!pct)
+		return;
+
+	inc = 100/pct;
+	for (i = 0; i < nfds; i+=inc) {
+		ev.data.fd = w->fdmap[i];
+		ev.events = EPOLLIN;
+
+		if (epoll_ctl(epollfd, EPOLL_CTL_ADD, w->fdmap[i], &ev) < 0)
+			err(EXIT_FAILURE, "epoll_ct");
+	}
+}
+
+static int do_threads(struct worker *worker, struct cpu_map *cpu)
+{
+	pthread_attr_t thread_attr, *attrp = NULL;
+	cpu_set_t cpuset;
+	unsigned int i, j;
+	int ret;
+
+	if (!noaffinity)
+		pthread_attr_init(&thread_attr);
+
+	for (i = 0; i < nthreads; i++) {
+		struct worker *w = &worker[i];
+
+		w->tid = i;
+		w->fdmap = calloc(nfds, sizeof(int));
+		if (!w->fdmap)
+			return 1;
+
+		for (j = 0; j < nfds; j++) {
+			w->fdmap[j] = eventfd(0, EFD_NONBLOCK);
+			if (w->fdmap[j] < 0)
+				err(EXIT_FAILURE, "eventfd");
+		}
+
+		/*
+		 * Lets add 50% of the fdmap to the epoll instance, and
+		 * do it before any threads are started; otherwise there is
+		 * an initial bias of the call failing  (mod and del ops).
+		 */
+		if (randomize)
+			init_fdmaps(w, 50);
+
+		if (!noaffinity) {
+			CPU_ZERO(&cpuset);
+			CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+
+			ret = pthread_attr_setaffinity_np(&thread_attr, sizeof(cpu_set_t), &cpuset);
+			if (ret)
+				err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
+
+			attrp = &thread_attr;
+		}
+
+		ret = pthread_create(&w->thread, attrp, workerfn,
+				     (void *)(struct worker *) w);
+		if (ret)
+			err(EXIT_FAILURE, "pthread_create");
+	}
+
+	if (!noaffinity)
+		pthread_attr_destroy(&thread_attr);
+
+	return ret;
+}
+
+static void print_summary(void)
+{
+	int i;
+	unsigned long avg[EPOLL_NR_OPS];
+	double stddev[EPOLL_NR_OPS];
+
+	for (i = 0; i < EPOLL_NR_OPS; i++) {
+		avg[i] = avg_stats(&all_stats[i]);
+		stddev[i] = stddev_stats(&all_stats[i]);
+	}
+
+	printf("\nAveraged %ld ADD operations (+- %.2f%%)\n",
+	       avg[OP_EPOLL_ADD], rel_stddev_stats(stddev[OP_EPOLL_ADD],
+						   avg[OP_EPOLL_ADD]));
+	printf("Averaged %ld MOD operations (+- %.2f%%)\n",
+	       avg[OP_EPOLL_MOD], rel_stddev_stats(stddev[OP_EPOLL_MOD],
+						   avg[OP_EPOLL_MOD]));
+	printf("Averaged %ld DEL operations (+- %.2f%%)\n",
+	       avg[OP_EPOLL_DEL], rel_stddev_stats(stddev[OP_EPOLL_DEL],
+						   avg[OP_EPOLL_DEL]));
+}
+
+int bench_epoll_ctl(int argc, const char **argv)
+{
+	int j, ret = 0;
+	struct sigaction act;
+	struct worker *worker = NULL;
+	struct cpu_map *cpu;
+	struct rlimit rl, prevrl;
+	ssize_t i;
+
+	argc = parse_options(argc, argv, options, bench_epoll_ctl_usage, 0);
+	if (argc) {
+		usage_with_options(bench_epoll_ctl_usage, options);
+		exit(EXIT_FAILURE);
+	}
+
+	sigfillset(&act.sa_mask);
+	act.sa_sigaction = toggle_done;
+	sigaction(SIGINT, &act, NULL);
+
+	cpu = cpu_map__new(NULL);
+	if (!cpu)
+		goto errmem;
+
+	/* a single, main epoll instance */
+	epollfd = epoll_create(1);
+	if (epollfd < 0)
+		err(EXIT_FAILURE, "epoll_create");
+
+	/*
+	 * Deal with nested epolls, if any.
+	 */
+	if (nested)
+		nest_epollfd();
+
+	/* default to the number of CPUs */
+	if (!nthreads)
+		nthreads = cpu->nr;
+
+	worker = calloc(nthreads, sizeof(*worker));
+	if (!worker)
+		goto errmem;
+
+	if (getrlimit(RLIMIT_NOFILE, &prevrl))
+	    err(EXIT_FAILURE, "getrlimit");
+	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
+	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n",
+		  prevrl.rlim_max, rl.rlim_max);
+	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
+		err(EXIT_FAILURE, "setrlimit");
+
+	printf("Run summary [PID %d]: %d threads doing epoll_ctl ops "
+	       "%d file-descriptors for %d secs.\n\n",
+	       getpid(), nthreads, nfds, nsecs);
+
+	for (i = 0; i < EPOLL_NR_OPS; i++)
+		init_stats(&all_stats[i]);
+
+	pthread_mutex_init(&thread_lock, NULL);
+	pthread_cond_init(&thread_parent, NULL);
+	pthread_cond_init(&thread_worker, NULL);
+
+	threads_starting = nthreads;
+
+	gettimeofday(&start, NULL);
+
+	do_threads(worker, cpu);
+
+	pthread_mutex_lock(&thread_lock);
+	while (threads_starting)
+		pthread_cond_wait(&thread_parent, &thread_lock);
+	pthread_cond_broadcast(&thread_worker);
+	pthread_mutex_unlock(&thread_lock);
+
+	sleep(nsecs);
+	toggle_done(0, NULL, NULL);
+	printinfo("main thread: toggling done\n");
+
+	for (i = 0; i < nthreads; i++) {
+		ret = pthread_join(worker[i].thread, NULL);
+		if (ret)
+			err(EXIT_FAILURE, "pthread_join");
+	}
+
+	/* cleanup & report results */
+	pthread_cond_destroy(&thread_parent);
+	pthread_cond_destroy(&thread_worker);
+	pthread_mutex_destroy(&thread_lock);
+
+	for (i = 0; i < nthreads; i++) {
+		unsigned long t[EPOLL_NR_OPS];
+
+		for (j = 0; j < EPOLL_NR_OPS; j++) {
+			t[j] = worker[i].ops[j];
+			update_stats(&all_stats[j], t[j]);
+		}
+
+		if (nfds == 1)
+			printf("[thread %2d] fdmap: %p [ add: %04ld; mod: %04ld; del: %04lds ops ]\n",
+			       worker[i].tid, &worker[i].fdmap[0],
+			       t[OP_EPOLL_ADD], t[OP_EPOLL_MOD], t[OP_EPOLL_DEL]);
+		else
+			printf("[thread %2d] fdmap: %p ... %p [ add: %04ld ops; mod: %04ld ops; del: %04ld ops ]\n",
+			       worker[i].tid, &worker[i].fdmap[0],
+			       &worker[i].fdmap[nfds-1],
+			       t[OP_EPOLL_ADD], t[OP_EPOLL_MOD], t[OP_EPOLL_DEL]);
+	}
+
+	print_summary();
+
+	close(epollfd);
+	return ret;
+errmem:
+	err(EXIT_FAILURE, "calloc");
+}
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index aeb92e531b7c..ca1d8f52173a 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -70,6 +70,7 @@ static struct bench futex_benchmarks[] = {
 
 static struct bench epoll_benchmarks[] = {
 	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
+	{ "ctl",	"Benchmark epoll concurrent epoll_ctls",        bench_epoll_ctl		},
 	{ "all",	"Run all futex benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.16.4

