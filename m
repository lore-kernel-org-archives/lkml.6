Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CFBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06572070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbfACPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:00:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:33002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732015AbfACPAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:00:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 151BFADE2;
        Thu,  3 Jan 2019 15:00:37 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf bench: Add epoll-wait-mp1c benchmark calling epoll_wait(2)
Date:   Thu,  3 Jan 2019 16:00:30 +0100
Message-Id: <20190103150030.17030-3-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190103150030.17030-1-rpenyaev@suse.de>
References: <20190103150030.17030-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intention of this benchmark is to measure events delivery
bandwidth: N threads produce events and 1 thread consumes events
calling epoll_wait(2).

Benchmark does measurements for 8, 16, 32, 64 and 128 threads in
a loop.

This one differs from epoll-wait-1pmc in that it produces events
from many threads and consumes from one, thus mp1c (many producers
1 consumer).

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/bench/Build             |   1 +
 tools/perf/bench/bench.h           |   1 +
 tools/perf/bench/epoll-wait-mp1c.c | 175 +++++++++++++++++++++++++++++
 tools/perf/builtin-bench.c         |   1 +
 4 files changed, 178 insertions(+)
 create mode 100644 tools/perf/bench/epoll-wait-mp1c.c

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index ef07fc40bc35..570df3f475b8 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -8,6 +8,7 @@ perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
 perf-y += epoll-wait-1pmc.o
+perf-y += epoll-wait-mp1c.o
 perf-y += epoll-ctl.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index fb9782624644..2ee7e7256e23 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -39,6 +39,7 @@ int bench_futex_requeue(int argc, const char **argv);
 int bench_futex_lock_pi(int argc, const char **argv);
 
 int bench_epoll_wait_1pmc(int argc, const char **argv);
+int bench_epoll_wait_mp1c(int argc, const char **argv);
 int bench_epoll_ctl(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
diff --git a/tools/perf/bench/epoll-wait-mp1c.c b/tools/perf/bench/epoll-wait-mp1c.c
new file mode 100644
index 000000000000..44b06ae86e5b
--- /dev/null
+++ b/tools/perf/bench/epoll-wait-mp1c.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef HAVE_EVENTFD
+/*
+ * Copyright (C) 2019 Roman Penyaev
+ *
+ * This program benchmarks bandwidth of events delivered from many threads
+ * (many producers) to a single consumer, which monitors for events calling
+ * epoll_wait(2).
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <assert.h>
+#include <sys/epoll.h>
+#include <sys/eventfd.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <errno.h>
+#include <err.h>
+#include <linux/kernel.h> /* For ARRAY_SIZE only */
+#include "bench.h"
+#include "cpumap.h"
+
+#define ITERS     1000000ull
+
+struct thread_ctx {
+	pthread_t thread;
+	int efd;
+};
+
+static volatile unsigned int thr_ready;
+static volatile unsigned int start;
+
+static inline unsigned long long nsecs(void)
+{
+	struct timespec ts = {0, 0};
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ((unsigned long long)ts.tv_sec * 1000000000ull) + ts.tv_nsec;
+}
+
+static void *thread_work(void *arg)
+{
+	struct thread_ctx *ctx = arg;
+	uint64_t ucnt = 1;
+	unsigned int i;
+	int rc;
+
+	__atomic_add_fetch(&thr_ready, 1, __ATOMIC_RELAXED);
+
+	while (!start)
+		;
+
+	for (i = 0; i < ITERS; i++) {
+		rc = write(ctx->efd, &ucnt, sizeof(ucnt));
+		assert(rc == sizeof(ucnt));
+	}
+
+	return NULL;
+}
+
+static int do_bench(struct cpu_map *cpu, unsigned int nthreads)
+{
+	struct epoll_event ev, events[nthreads];
+	struct thread_ctx threads[nthreads];
+	pthread_attr_t thrattr;
+	struct thread_ctx *ctx;
+	int rc, epfd, nfds;
+	cpu_set_t cpuset;
+	unsigned int i;
+
+	unsigned long long epoll_calls = 0, epoll_nsecs;
+	unsigned long long ucnt, ucnt_sum = 0;
+
+	epfd = epoll_create1(0);
+	if (epfd < 0)
+		err(EXIT_FAILURE, "epoll_create1");
+
+	for (i = 0; i < nthreads; i++) {
+		ctx = &threads[i];
+
+		ctx->efd = eventfd(0, EFD_NONBLOCK);
+		if (ctx->efd < 0)
+			err(EXIT_FAILURE, "eventfd");
+
+		ev.events = EPOLLIN;
+		ev.data.ptr = ctx;
+		rc = epoll_ctl(epfd, EPOLL_CTL_ADD, ctx->efd, &ev);
+		if (rc)
+			err(EXIT_FAILURE, "epoll_ctl");
+
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu->map[i % cpu->nr], &cpuset);
+
+		pthread_attr_init(&thrattr);
+		rc = pthread_attr_setaffinity_np(&thrattr, sizeof(cpu_set_t),
+						 &cpuset);
+		if (rc) {
+			errno = rc;
+			err(EXIT_FAILURE, "pthread_attr_setaffinity_np");
+		}
+
+		rc = pthread_create(&ctx->thread, &thrattr, thread_work, ctx);
+		if (rc) {
+			errno = rc;
+			err(EXIT_FAILURE, "pthread_create");
+		}
+	}
+
+	while (thr_ready == nthreads)
+		;
+
+	/* Signal start for all threads */
+	start = 1;
+
+	epoll_nsecs = nsecs();
+	while (1) {
+		nfds = epoll_wait(epfd, events, nthreads, -1);
+		if (nfds < 0)
+			err(EXIT_FAILURE, "epoll_wait");
+
+		epoll_calls++;
+
+		for (i = 0; i < (unsigned int)nfds; ++i) {
+			ctx = events[i].data.ptr;
+			rc = read(ctx->efd, &ucnt, sizeof(ucnt));
+			assert(rc == sizeof(ucnt));
+			ucnt_sum += ucnt;
+			if (ucnt_sum == nthreads * ITERS)
+				goto end;
+		}
+	}
+end:
+	epoll_nsecs = nsecs() - epoll_nsecs;
+
+	for (i = 0; i < nthreads; i++) {
+		ctx = &threads[i];
+		pthread_join(ctx->thread, NULL);
+		close(ctx->efd);
+	}
+	close(epfd);
+
+	printf("%7d   %8lld     %8lld\n",
+		   nthreads,
+		   ITERS*nthreads/(epoll_nsecs/1000/1000),
+		   epoll_nsecs/1000/1000);
+
+	return 0;
+}
+
+int bench_epoll_wait_mp1c(int argc, const char **argv)
+{
+	unsigned int i, nthreads_arr[] = {8, 16, 32, 64, 128};
+	struct cpu_map *cpu;
+
+	(void)argc; (void)argv;
+
+	cpu = cpu_map__new(NULL);
+	if (!cpu) {
+		errno = ENOMEM;
+		err(EXIT_FAILURE, "cpu_map__new");
+	}
+
+	printf("threads  events/ms  run-time ms\n");
+	for (i = 0; i < ARRAY_SIZE(nthreads_arr); i++)
+		do_bench(cpu, nthreads_arr[i]);
+
+	cpu_map__put(cpu);
+
+	return 0;
+}
+
+#endif // HAVE_EVENTFD
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 6926b5a5eebf..4426b7afadf3 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -71,6 +71,7 @@ static struct bench futex_benchmarks[] = {
 #ifdef HAVE_EVENTFD
 static struct bench epoll_benchmarks[] = {
 	{ "wait-1pmc",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait_1pmc	},
+	{ "wait-mp1c",	"Benchmark epoll events delivery bandwidth",    bench_epoll_wait_mp1c	},
 	{ "ctl",	"Benchmark epoll concurrent epoll_ctls",        bench_epoll_ctl		},
 	{ "all",	"Run all futex benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			}
-- 
2.19.1

