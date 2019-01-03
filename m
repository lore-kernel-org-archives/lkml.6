Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8401C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DFA2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfACPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:00:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:32990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732013AbfACPAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:00:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6368ADBD;
        Thu,  3 Jan 2019 15:00:36 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf bench: rename epoll-wait bench to epoll-wait-1pmc
Date:   Thu,  3 Jan 2019 16:00:29 +0100
Message-Id: <20190103150030.17030-2-rpenyaev@suse.de>
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

I want to rename this in order to add another epoll-wait bench in next
patch and to stress in the name, that the bench corresponds to 1 producer
and many consumers.

In the following patch I plan to add epoll-wait-mp1c bench.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/bench/Build                               | 2 +-
 tools/perf/bench/bench.h                             | 2 +-
 tools/perf/bench/{epoll-wait.c => epoll-wait-1pmc.c} | 6 +++++-
 tools/perf/builtin-bench.c                           | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)
 rename tools/perf/bench/{epoll-wait.c => epoll-wait-1pmc.c} (98%)

diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index e4e321b6f883..ef07fc40bc35 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -7,7 +7,7 @@ perf-y += futex-wake-parallel.o
 perf-y += futex-requeue.o
 perf-y += futex-lock-pi.o
 
-perf-y += epoll-wait.o
+perf-y += epoll-wait-1pmc.o
 perf-y += epoll-ctl.o
 
 perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index fddb3ced9db6..fb9782624644 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -38,7 +38,7 @@ int bench_futex_requeue(int argc, const char **argv);
 /* pi futexes */
 int bench_futex_lock_pi(int argc, const char **argv);
 
-int bench_epoll_wait(int argc, const char **argv);
+int bench_epoll_wait_1pmc(int argc, const char **argv);
 int bench_epoll_ctl(int argc, const char **argv);
 
 #define BENCH_FORMAT_DEFAULT_STR	"default"
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait-1pmc.c
similarity index 98%
rename from tools/perf/bench/epoll-wait.c
rename to tools/perf/bench/epoll-wait-1pmc.c
index 5a11534e96a0..1b88cdd2ef78 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait-1pmc.c
@@ -26,6 +26,10 @@
  *             [queue D]  ---> [worker]
  *             [queue E]  ---> [worker]
  *
+ * Both models correspond to 1 producer and many consumers, where a single
+ * producer is a writer thread and consumers are many workers threads
+ * waiting for events.
+ *
  * Naturally, the single queue will enforce more concurrency on the epoll
  * instance, and can therefore scale poorly compared to multiple queues.
  * However, this is a benchmark raw data and must be taken with a grain of
@@ -409,7 +413,7 @@ static int cmpworker(const void *p1, const void *p2)
 	return w1->tid > w2->tid;
 }
 
-int bench_epoll_wait(int argc, const char **argv)
+int bench_epoll_wait_1pmc(int argc, const char **argv)
 {
 	int ret = 0;
 	struct sigaction act;
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334c77ffc1d9..6926b5a5eebf 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -70,7 +70,7 @@ static struct bench futex_benchmarks[] = {
 
 #ifdef HAVE_EVENTFD
 static struct bench epoll_benchmarks[] = {
-	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
+	{ "wait-1pmc",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait_1pmc	},
 	{ "ctl",	"Benchmark epoll concurrent epoll_ctls",        bench_epoll_ctl		},
 	{ "all",	"Run all futex benchmarks",			NULL			},
 	{ NULL,		NULL,						NULL			}
-- 
2.19.1

