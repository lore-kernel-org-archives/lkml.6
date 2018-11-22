Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3710E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xdFrH6l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3710E20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404461AbeKVOOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbeKVOOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:48 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B9F20892;
        Thu, 22 Nov 2018 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857842;
        bh=0IShT6vxjtaJNY6X3QhU/DjRp+q0dki6xowns7nf2pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xdFrH6l/NrREzoTFxzK+MBH7O6J87B8hO6LHIAVmIDeLNOA2j3cfI+rTsmUfZvfp+
         x8MYcsATieuZkKD73VfR3x2mN7YR5Gyk17P8gBYnd2FNaLg+Y35JMfk3L82IEKKTwZ
         5q9mB1gfFM89n4iXCZi8feMV5ZAF+W4HYDSEjJ14=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/28] perf bench: Add epoll_ctl(2) benchmark
Date:   Thu, 22 Nov 2018 00:36:03 -0300
Message-Id: <20181122033611.15890-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

Benchmark the various operations allowed for epoll_ctl(2).  The idea is
to concurrently stress a single epoll instance doing add/mod/del
operations.

Committer testing:

  # perf bench epoll ctl
  # Running 'epoll/ctl' benchmark:
  Run summary [PID 20344]: 4 threads doing epoll_ctl ops 64 file-descriptors for 8 secs.

  [thread  0] fdmap: 0x21a46b0 ... 0x21a47ac [ add: 1680960 ops; mod: 1680960 ops; del: 1680960 ops ]
  [thread  1] fdmap: 0x21a4960 ... 0x21a4a5c [ add: 1685440 ops; mod: 1685440 ops; del: 1685440 ops ]
  [thread  2] fdmap: 0x21a4c10 ... 0x21a4d0c [ add: 1674368 ops; mod: 1674368 ops; del: 1674368 ops ]
  [thread  3] fdmap: 0x21a4ec0 ... 0x21a4fbc [ add: 1677568 ops; mod: 1677568 ops; del: 1677568 ops ]

  Averaged 1679584 ADD operations (+- 0.14%)
  Averaged 1679584 MOD operations (+- 0.14%)
  Averaged 1679584 DEL operations (+- 0.14%)
  #

Lets measure those calls with 'perf trace' to get a glympse at what this
benchmark is doing in terms of syscalls:

  # perf trace -m32768 -s perf bench epoll ctl
  # Running 'epoll/ctl' benchmark:
  Run summary [PID 20405]: 4 threads doing epoll_ctl ops 64 file-descriptors for 8 secs.

  [thread  0] fdmap: 0x21764e0 ... 0x21765dc [ add: 1100480 ops; mod: 1100480 ops; del: 1100480 ops ]
  [thread  1] fdmap: 0x2176790 ... 0x217688c [ add: 1250176 ops; mod: 1250176 ops; del: 1250176 ops ]
  [thread  2] fdmap: 0x2176a40 ... 0x2176b3c [ add: 1022464 ops; mod: 1022464 ops; del: 1022464 ops ]
  [thread  3] fdmap: 0x2176cf0 ... 0x2176dec [ add: 705472 ops; mod: 705472 ops; del: 705472 ops ]

  Averaged 1019648 ADD operations (+- 11.27%)
  Averaged 1019648 MOD operations (+- 11.27%)
  Averaged 1019648 DEL operations (+- 11.27%)

  Summary of events:

  epoll-ctl (20405), 1264 events, 0.0%

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   eventfd2             256     9.514     0.001     0.037     5.243     68.00%
   clone                  4     1.245     0.204     0.311     0.531     24.13%
   mprotect              66     0.345     0.002     0.005     0.021      7.43%
   openat                45     0.313     0.004     0.007     0.073     21.93%
   mmap                  88     0.302     0.002     0.003     0.013      5.02%
   futex                  4     0.160     0.002     0.040     0.140     83.43%
   sched_setaffinity      4     0.124     0.005     0.031     0.070     49.39%
   read                  44     0.103     0.001     0.002     0.013     15.54%
   fstat                 40     0.052     0.001     0.001     0.003      5.43%
   close                 39     0.039     0.001     0.001     0.001      1.48%
   stat                   9     0.034     0.003     0.004     0.006      7.30%
   access                 3     0.023     0.007     0.008     0.008      4.25%
   open                   2     0.021     0.008     0.011     0.013     22.60%
   getdents               4     0.019     0.001     0.005     0.009     37.15%
   write                  2     0.013     0.004     0.007     0.009     38.48%
   munmap                 1     0.010     0.010     0.010     0.010      0.00%
   brk                    3     0.006     0.001     0.002     0.003     26.34%
   rt_sigprocmask         2     0.004     0.001     0.002     0.003     43.95%
   rt_sigaction           3     0.004     0.001     0.001     0.002     16.07%
   prlimit64              3     0.004     0.001     0.001     0.001      5.39%
   prctl                  1     0.003     0.003     0.003     0.003      0.00%
   epoll_create           1     0.003     0.003     0.003     0.003      0.00%
   lseek                  2     0.002     0.001     0.001     0.001     11.42%
   sched_getaffinity        1     0.002     0.002     0.002     0.002      0.00%
   arch_prctl             1     0.002     0.002     0.002     0.002      0.00%
   set_tid_address        1     0.001     0.001     0.001     0.001      0.00%
   getpid                 1     0.001     0.001     0.001     0.001      0.00%
   set_robust_list        1     0.001     0.001     0.001     0.001      0.00%
   execve                 1     0.000     0.000     0.000     0.000      0.00%

 epoll-ctl (20406), 1245480 events, 14.6%

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   epoll_ctl         619511  1034.927     0.001     0.002     6.691      0.67%
   nanosleep           3226   616.114     0.006     0.191    10.376      7.57%
   futex                  2    11.336     0.002     5.668    11.334     99.97%
   set_robust_list        1     0.001     0.001     0.001     0.001      0.00%
   clone                  1     0.000     0.000     0.000     0.000      0.00%

 epoll-ctl (20407), 1243151 events, 14.5%

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   epoll_ctl         618350  1042.181     0.001     0.002     2.512      0.40%
   nanosleep           3220   366.261     0.012     0.114    18.162      9.59%
   futex                  4     5.463     0.001     1.366     5.427     99.12%
   set_robust_list        1     0.002     0.002     0.002     0.002      0.00%

 epoll-ctl (20408), 1801690 events, 21.1%

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   epoll_ctl         896174  1540.581     0.001     0.002     6.987      0.74%
   nanosleep           4667   783.393     0.006     0.168    10.419      7.10%
   futex                  2     4.682     0.002     2.341     4.681     99.93%
   set_robust_list        1     0.002     0.002     0.002     0.002      0.00%
   clone                  1     0.000     0.000     0.000     0.000      0.00%

 epoll-ctl (20409), 4254890 events, 49.8%

   syscall            calls    total       min       avg       max      stddev
                               (msec)    (msec)    (msec)    (msec)        (%)
   --------------- -------- --------- --------- --------- ---------     ------
   epoll_ctl        2116416  3768.097     0.001     0.002     9.956      0.41%
   nanosleep          11023  1141.778     0.006     0.104     9.447      4.95%
   futex                  3     0.037     0.002     0.012     0.029     70.50%
   set_robust_list        1     0.008     0.008     0.008     0.008      0.00%
   madvise                1     0.005     0.005     0.005     0.005      0.00%
   clone                  1     0.000     0.000     0.000     0.000      0.00%
  #

Committer notes:

Fix build on fedora:24-x-ARC-uClibc, debian:experimental-x-mips,
debian:experimental-x-mipsel, ubuntu:16.04-x-arm and ubuntu:16.04-x-powerpc

    CC       /tmp/build/perf/bench/epoll-ctl.o
  bench/epoll-ctl.c: In function 'init_fdmaps':
  bench/epoll-ctl.c:214:16: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
    for (i = 0; i < nfds; i+=inc) {
                  ^
  bench/epoll-ctl.c: In function 'bench_epoll_ctl':
  bench/epoll-ctl.c:377:16: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
    for (i = 0; i < nthreads; i++) {
                  ^
  bench/epoll-ctl.c:388:16: error: comparison between signed and unsigned integer expressions [-Werror=sign-compare]
    for (i = 0; i < nthreads; i++) {
                  ^
  cc1: all warnings being treated as errors

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Link: http://lkml.kernel.org/r/20181106152226.20883-3-dave@stgolabs.net
[ Use inttypes.h to print rlim_t fields, fixing the build on Alpine Linux / musl libc ]
[ Check if eventfd() is available, i.e. if HAVE_EVENTFD is defined ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-bench.txt |   3 +
 tools/perf/bench/Build                  |   1 +
 tools/perf/bench/bench.h                |   1 +
 tools/perf/bench/epoll-ctl.c            | 413 ++++++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c              |   1 +
 5 files changed, 419 insertions(+)
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
index 6e1f091ced96..fddb3ced9db6 100644
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
index 000000000000..0c0a6e824934
--- /dev/null
+++ b/tools/perf/bench/epoll-ctl.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Davidlohr Bueso.
+ *
+ * Benchmark the various operations allowed for epoll_ctl(2).
+ * The idea is to concurrently stress a single epoll instance
+ */
+#ifdef HAVE_EVENTFD
+/* For the CLR_() macros */
+#include <string.h>
+#include <pthread.h>
+
+#include <errno.h>
+#include <inttypes.h>
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
+	unsigned int i;
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
+	unsigned int i;
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
+	printinfo("Setting RLIMIT_NOFILE rlimit from %" PRIu64 " to: %" PRIu64 "\n",
+		  (uint64_t)prevrl.rlim_max, (uint64_t)rl.rlim_max);
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
+#endif // HAVE_EVENTFD
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 55efd23c3efb..334c77ffc1d9 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -71,6 +71,7 @@ static struct bench futex_benchmarks[] = {
 #ifdef HAVE_EVENTFD
 static struct bench epoll_benchmarks[] = {
 	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
+	{ "ctl",	"Benchmark epoll concurrent epoll_ctls",        bench_epoll_ctl		},
 	{ "all",	"Run all futex benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			}
 };
-- 
2.14.5

