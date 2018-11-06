Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65214C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165112081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165112081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeKGAsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:48:37 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:60660 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbeKGAsb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 6 Nov 2018 19:48:31 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 06 Nov 2018 08:22:40 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     akpm@linux-foundation.org, jbaron@akamai.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/2] perf-bench: Add epoll parallel epoll_wait benchmark
Date:   Tue,  6 Nov 2018 07:22:25 -0800
Message-Id: <20181106152226.20883-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181106152226.20883-1-dave@stgolabs.net>
References: <20181106152226.20883-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This program benchmarks concurrent epoll_wait(2) for file
descriptors that are monitored with with EPOLLIN along various
semantics, by a single epoll instance. Such conditions can be
found when using single/combined or multiple queuing when load
balancing.

Each thread has a number of private, nonblocking file descriptors,
referred to as fdmap. A writer thread will constantly be writing to
the fdmaps of all threads, minimizing each threads's chances of
epoll_wait not finding any ready read events and blocking as this
is not what we want to stress. Full details in the start of the
C file.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/Documentation/perf-bench.txt |   7 +
 tools/perf/bench/Build                  |   2 +
 tools/perf/bench/bench.h                |   2 +
 tools/perf/bench/epoll-wait.c           | 536 ++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   8 +
 5 files changed, 555 insertions(+)
 create mode 100644 tools/perf/bench/epoll-wait.c

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index 34750fc32714..3a6b2e73b2e8 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -58,6 +58,9 @@ SUBSYSTEM
 'futex'::
 	Futex stressing benchmarks.
 
+'epoll'::
+	Eventpoll (epoll) stressing benchmarks.
+
 'all'::
 	All benchmark subsystems.
 
@@ -203,6 +206,10 @@ Suite for evaluating requeue calls.
 *lock-pi*::
 Suite for evaluating futex lock_pi calls.
 
+SUITES FOR 'epoll'
+~~~~~~~~~~~~~~~~~~
+*wait*::
+Suite for evaluating concurrent epoll_wait calls.
 
 SEE ALSO
 --------
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index eafce1a130a1..2bb79b542d53 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -7,6 +7,8 @@ perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
+perf-y += epoll-wait.o
+
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
 perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index 6c9fcd757f31..c9c276aa6d4e 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -38,6 +38,8 @@ int bench_futex_requeue(int argc, const char **argv);
 /* pi futexes */
 int bench_futex_lock_pi(int argc, const char **argv);
 
+int bench_epoll_wait(int argc, const char **argv);
+
 #define BENCH_FORMAT_DEFAULT_STR	"default"
 #define BENCH_FORMAT_DEFAULT		0
 #define BENCH_FORMAT_SIMPLE_STR		"simple"
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
new file mode 100644
index 000000000000..c4c5ef60feb4
--- /dev/null
+++ b/tools/perf/bench/epoll-wait.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Davidlohr Bueso.
+ *
+ * This program benchmarks concurrent epoll_wait(2) monitoring multiple
+ * file descriptors under one or two load balancing models. The first,
+ * and default, is the single/combined queueing (which refers to a single
+ * epoll instance for N worker threads):
+ *
+ *                          |---> [worker A]
+ *                          |---> [worker B]
+ *        [combined queue]  .---> [worker C]
+ *                          |---> [worker D]
+ *                          |---> [worker E]
+ *
+ * While the second model, enabled via --multiq option, uses multiple
+ * queueing (which refers to one epoll instance per worker). For example,
+ * short lived tcp connections in a high throughput httpd server will
+ * ditribute the accept()'ing  connections across CPUs. In this case each
+ * worker does a limited  amount of processing.
+ *
+ *             [queue A]  ---> [worker]
+ *             [queue B]  ---> [worker]
+ *             [queue C]  ---> [worker]
+ *             [queue D]  ---> [worker]
+ *             [queue E]  ---> [worker]
+ *
+ * Naturally, the single queue will enforce more concurrency on the epoll
+ * instance, and can therefore scale poorly compared to multiple queues.
+ * However, this is a benchmark raw data and must be taken with a grain of
+ * salt when choosing how to make use of sys_epoll.
+
+ * Each thread has a number of private, nonblocking file descriptors,
+ * referred to as fdmap. A writer thread will constantly be writing to
+ * the fdmaps of all threads, minimizing each threads's chances of
+ * epoll_wait not finding any ready read events and blocking as this
+ * is not what we want to stress. The size of the fdmap can be adjusted
+ * by the user; enlarging the value will increase the chances of
+ * epoll_wait(2) blocking as the lineal writer thread will take "longer",
+ * at least at a high level.
+ *
+ * Note that because fds are private to each thread, this workload does
+ * not stress scenarios where multiple tasks are awoken per ready IO; ie:
+ * EPOLLEXCLUSIVE semantics.
+ *
+ * The end result/metric is throughput: number of ops/second where an
+ * operation consists of:
+ *
+ *   epoll_wait(2) + [others]
+ *
+ *        ... where [others] is the cost of re-adding the fd (EPOLLET),
+ *            or rearming it (EPOLLONESHOT).
+ *
+ *
+ * The purpose of this is program is that it be useful for measuring
+ * kernel related changes to the sys_epoll, and not comparing different
+ * IO polling methods, for example. Hence everything is very adhoc and
+ * outputs raw microbenchmark numbers. Also this uses eventfd, similar
+ * tools tend to use pipes or sockets, but the result is the same.
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
+#include <sys/types.h>
+
+#include "../util/stat.h"
+#include <subcmd/parse-options.h>
+#include "bench.h"
+#include "cpumap.h"
+
+#include <err.h>
+
+#define printinfo(fmt, arg...) \
+	do { if (__verbose) { printf(fmt, ## arg); fflush(stdout); } } while (0)
+
+static unsigned int nthreads = 0;
+static unsigned int nsecs    = 8;
+struct timeval start, end, runtime;
+static bool wdone, done, __verbose, randomize, nonblocking;
+
+/*
+ * epoll related shared variables.
+ */
+
+/* Maximum number of nesting allowed inside epoll sets */
+#define EPOLL_MAXNESTS 4
+
+static int epollfd;
+static int *epollfdp;
+static bool noaffinity;
+static unsigned int nested = 0;
+static bool et; /* edge-trigger */
+static bool oneshot;
+static bool multiq; /* use an epoll instance per thread */
+
+/* amount of fds to monitor, per thread */
+static unsigned int nfds = 64;
+
+static pthread_mutex_t thread_lock;
+static unsigned int threads_starting;
+static struct stats throughput_stats;
+static pthread_cond_t thread_parent, thread_worker;
+
+struct worker {
+	int tid;
+	int epollfd; /* for --multiq */
+	pthread_t thread;
+	unsigned long ops;
+	int *fdmap;
+};
+
+static const struct option options[] = {
+	/* general benchmark options */
+	OPT_UINTEGER('t', "threads", &nthreads, "Specify amount of threads"),
+	OPT_UINTEGER('r', "runtime", &nsecs, "Specify runtime (in seconds)"),
+	OPT_UINTEGER('f', "nfds",    &nfds,  "Specify amount of file descriptors to monitor for each thread"),
+	OPT_BOOLEAN( 'n', "noaffinity",  &noaffinity,   "Disables CPU affinity"),
+	OPT_BOOLEAN('R', "randomize", &randomize,   "Enable random write behaviour (default is lineal)"),
+	OPT_BOOLEAN( 'v', "verbose", &__verbose, "Verbose mode"),
+
+	/* epoll specific options */
+	OPT_BOOLEAN( 'm', "multiq",  &multiq,   "Use multiple epoll instances (one per thread)"),
+	OPT_BOOLEAN( 'B', "nonblocking", &nonblocking, "Nonblocking epoll_wait(2) behaviour"),
+	OPT_UINTEGER( 'N', "nested",  &nested,   "Nesting level epoll hierarchy (default is 0, no nesting)"),
+	OPT_BOOLEAN( 'S', "oneshot",  &oneshot,   "Use EPOLLONESHOT semantics"),
+	OPT_BOOLEAN( 'E', "edge",  &et,   "Use Edge-triggered interface (default is LT)"),
+
+	OPT_END()
+};
+
+static const char * const bench_epoll_wait_usage[] = {
+	"perf bench epoll wait <options>",
+	NULL
+};
+
+
+/*
+ * Arrange the N elements of ARRAY in random order.
+ * Only effective if N is much smaller than RAND_MAX;
+ * if this may not be the case, use a better random
+ * number generator. -- Ben Pfaff.
+ */
+static void shuffle(void *array, size_t n, size_t size)
+{
+	char *carray = array;
+	void *aux;
+	size_t i;
+
+	if (n <= 1)
+		return;
+
+	aux = calloc(1, size);
+	if (!aux)
+		err(EXIT_FAILURE, "calloc");
+
+	for (i = 1; i < n; ++i) {
+		size_t j =   i + rand() / (RAND_MAX / (n - i) + 1);
+		j *= size;
+
+		memcpy(aux, &carray[j], size);
+		memcpy(&carray[j], &carray[i*size], size);
+		memcpy(&carray[i*size], aux, size);
+	}
+
+	free(aux);
+}
+
+
+static void *workerfn(void *arg)
+{
+	int fd, ret, r;
+	struct worker *w = (struct worker *) arg;
+	unsigned long ops = w->ops;
+	struct epoll_event ev;
+	uint64_t val;
+	int to = nonblocking? 0 : -1;
+	int efd = multiq ? w->epollfd : epollfd;
+
+	pthread_mutex_lock(&thread_lock);
+	threads_starting--;
+	if (!threads_starting)
+		pthread_cond_signal(&thread_parent);
+	pthread_cond_wait(&thread_worker, &thread_lock);
+	pthread_mutex_unlock(&thread_lock);
+
+	do {
+		/*
+		 * Block undefinitely waiting for the IN event.
+		 * In order to stress the epoll_wait(2) syscall,
+		 * call it event per event, instead of a larger
+		 * batch (max)limit.
+		 */
+		do {
+			ret = epoll_wait(efd, &ev, 1, to);
+		} while (ret < 0 && errno == EINTR);
+		if (ret < 0)
+			err(EXIT_FAILURE, "epoll_wait");
+
+		fd = ev.data.fd;
+
+		do {
+			r = read(fd, &val, sizeof(val));
+		} while (!done && (r < 0 && errno == EAGAIN));
+
+		if (et) {
+			ev.events = EPOLLIN | EPOLLET;
+			ret = epoll_ctl(epollfd, EPOLL_CTL_ADD, fd, &ev);
+		}
+
+		if (oneshot) {
+			/* rearm the file descriptor with a new event mask */
+			ev.events |= EPOLLIN | EPOLLONESHOT;
+			ret = epoll_ctl(epollfd, EPOLL_CTL_MOD, fd, &ev);
+		}
+
+		ops++;
+	}  while (!done);
+
+	if (multiq)
+		close(w->epollfd);
+
+	w->ops = ops;
+	return NULL;
+}
+
+static void nest_epollfd(struct worker *w)
+{
+	unsigned int i;
+	struct epoll_event ev;
+	int efd = multiq ? w->epollfd : epollfd;
+
+	if (nested > EPOLL_MAXNESTS)
+		nested = EPOLL_MAXNESTS;
+
+	epollfdp = calloc(nested, sizeof(*epollfdp));
+	if (!epollfdp)
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
+	if (epoll_ctl(efd, EPOLL_CTL_ADD, *epollfdp, &ev) < 0)
+		err(EXIT_FAILURE, "epoll_ctl");
+}
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
+static void print_summary(void)
+{
+	unsigned long avg = avg_stats(&throughput_stats);
+	double stddev = stddev_stats(&throughput_stats);
+
+	printf("\nAveraged %ld operations/sec (+- %.2f%%), total secs = %d\n",
+	       avg, rel_stddev_stats(stddev, avg),
+	       (int) runtime.tv_sec);
+}
+
+static int do_threads(struct worker *worker, struct cpu_map *cpu)
+{
+	pthread_attr_t thread_attr, *attrp = NULL;
+	cpu_set_t cpuset;
+	unsigned int i, j;
+	int ret, events = EPOLLIN;
+
+	if (oneshot)
+		events |= EPOLLONESHOT;
+	if (et)
+		events |= EPOLLET;
+
+	printinfo("starting worker/consumer %sthreads%s\n",
+		  noaffinity ?  "":"CPU affinity ",
+		  nonblocking ? " (nonblocking)":"");
+	if (!noaffinity)
+		pthread_attr_init(&thread_attr);
+
+	for (i = 0; i < nthreads; i++) {
+		struct worker *w = &worker[i];
+
+		if (multiq) {
+			w->epollfd = epoll_create(1);
+			if (w->epollfd < 0)
+				err(EXIT_FAILURE, "epoll_create");
+
+			if (nested)
+				nest_epollfd(w);
+		}
+
+		w->tid = i;
+		w->fdmap = calloc(nfds, sizeof(int));
+		if (!w->fdmap)
+			return 1;
+
+		for (j = 0; j < nfds; j++) {
+			int efd = multiq ? w->epollfd : epollfd;
+			struct epoll_event ev;
+
+			w->fdmap[j] = eventfd(0, EFD_NONBLOCK);
+			if (w->fdmap[j] < 0)
+				err(EXIT_FAILURE, "eventfd");
+
+			ev.data.fd = w->fdmap[j];
+			ev.events = events;
+
+			ret = epoll_ctl(efd, EPOLL_CTL_ADD,
+					w->fdmap[j], &ev);
+			if (ret < 0)
+				err(EXIT_FAILURE, "epoll_ctl");
+		}
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
+static void *writerfn(void *p)
+{
+	struct worker *worker = p;
+	size_t i, j, iter;
+	const uint64_t val = 1;
+	ssize_t sz;
+	struct timespec ts = { .tv_sec = 0,
+			       .tv_nsec = 500 };
+
+	printinfo("starting writer-thread: doing %s writes ...\n",
+		  randomize? "random":"lineal");
+
+	for (iter = 0; !wdone; iter++) {
+		if (randomize) {
+			shuffle((void *)worker, nthreads, sizeof(*worker));
+		}
+
+		for (i = 0; i < nthreads; i++) {
+			struct worker *w = &worker[i];
+
+			if (randomize) {
+				shuffle((void *)w->fdmap, nfds, sizeof(int));
+			}
+
+			for (j = 0; j < nfds; j++) {
+				do {
+					sz = write(w->fdmap[j], &val, sizeof(val));
+				} while (!wdone && (sz < 0 && errno == EAGAIN));
+			}
+		}
+
+		nanosleep(&ts, NULL);
+	}
+
+	printinfo("exiting writer-thread (total full-loops: %ld)\n", iter);
+	return NULL;
+}
+
+static int cmpworker(const void *p1, const void *p2)
+{
+
+	struct worker *w1 = (struct worker *) p1;
+	struct worker *w2 = (struct worker *) p2;
+	return w1->tid > w2->tid;
+}
+
+int bench_epoll_wait(int argc, const char **argv)
+{
+	int ret = 0;
+	struct sigaction act;
+	unsigned int i;
+	struct worker *worker = NULL;
+	struct cpu_map *cpu;
+	pthread_t wthread;
+	struct rlimit rl, prevrl;
+
+	argc = parse_options(argc, argv, options, bench_epoll_wait_usage, 0);
+	if (argc) {
+		usage_with_options(bench_epoll_wait_usage, options);
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
+	if (!multiq) {
+		epollfd = epoll_create(1);
+		if (epollfd < 0)
+			err(EXIT_FAILURE, "epoll_create");
+
+		/*
+		 * Deal with nested epolls, if any.
+		 */
+		if (nested)
+			nest_epollfd(NULL);
+	}
+
+	printinfo("Using %s queue model\n", multiq ? "multi" : "single");
+	printinfo("Nesting level(s): %d\n", nested);
+
+	/* default to the number of CPUs and leave one for the writer pthread */
+	if (!nthreads)
+		nthreads = cpu->nr - 1;
+
+	worker = calloc(nthreads, sizeof(*worker));
+	if (!worker) {
+		goto errmem;
+	}
+
+	if (getrlimit(RLIMIT_NOFILE, &prevrl))
+		err(EXIT_FAILURE, "getrlimit");
+	rl.rlim_cur = rl.rlim_max = nfds * nthreads * 2 + 50;
+	printinfo("Setting RLIMIT_NOFILE rlimit from %lu to: %lu\n", prevrl.rlim_max, rl.rlim_max);
+	if (setrlimit(RLIMIT_NOFILE, &rl) < 0)
+		err(EXIT_FAILURE, "setrlimit");
+
+	printf("Run summary [PID %d]: %d threads monitoring%s on "
+	       "%d file-descriptors for %d secs.\n\n",
+	       getpid(), nthreads, oneshot ? " (EPOLLONESHOT semantics)": "", nfds, nsecs);
+
+	init_stats(&throughput_stats);
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
+	/*
+	 * At this point the workers should be blocked waiting for read events
+	 * to become ready. Launch the writer which will constantly be writing
+	 * to each thread's fdmap.
+	 */
+	ret = pthread_create(&wthread, NULL, writerfn,
+			     (void *)(struct worker *) worker);
+	if (ret)
+		err(EXIT_FAILURE, "pthread_create");
+
+	sleep(nsecs);
+	toggle_done(0, NULL, NULL);
+	printinfo("main thread: toggling done\n");
+
+	sleep(1); /* meh */
+	wdone = true;
+	ret = pthread_join(wthread, NULL);
+	if (ret)
+		err(EXIT_FAILURE, "pthread_join");
+
+	/* cleanup & report results */
+	pthread_cond_destroy(&thread_parent);
+	pthread_cond_destroy(&thread_worker);
+	pthread_mutex_destroy(&thread_lock);
+
+	/* sort the array back before reporting */
+	if (randomize)
+		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
+
+	for (i = 0; i < nthreads; i++) {
+		unsigned long t = worker[i].ops/runtime.tv_sec;
+
+		update_stats(&throughput_stats, t);
+
+		if (nfds == 1)
+			printf("[thread %2d] fdmap: %p [ %04ld ops/sec ]\n",
+			       worker[i].tid, &worker[i].fdmap[0], t);
+		else
+			printf("[thread %2d] fdmap: %p ... %p [ %04ld ops/sec ]\n",
+			       worker[i].tid, &worker[i].fdmap[0],
+			       &worker[i].fdmap[nfds-1], t);
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
index 17a6bcd01aa6..aeb92e531b7c 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -14,6 +14,7 @@
  *  mem   ... memory access performance
  *  numa  ... NUMA scheduling and MM performance
  *  futex ... Futex performance
+ *  epoll ... Event poll performance
  */
 #include "perf.h"
 #include "util/util.h"
@@ -67,6 +68,12 @@ static struct bench futex_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
+static struct bench epoll_benchmarks[] = {
+	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
+	{ "all",	"Run all futex benchmarks",			NULL			},
+	{ NULL,		NULL,						NULL			}
+};
+
 struct collection {
 	const char	*name;
 	const char	*summary;
@@ -80,6 +87,7 @@ static struct collection collections[] = {
 	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
 #endif
 	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
+	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
 	{ "all",	"All benchmarks",				NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.16.4

