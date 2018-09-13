Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED32C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820A21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2820A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeIMSFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C74783B73A;
        Thu, 13 Sep 2018 12:55:38 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C546B600C8;
        Thu, 13 Sep 2018 12:55:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 20/48] perf tools: Add a test case for timed thread handling
Date:   Thu, 13 Sep 2018 14:54:22 +0200
Message-Id: <20180913125450.21342-21-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 13 Sep 2018 12:55:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

A test case for verifying live and dead thread tree management during
time change and new machine__find{,new}_thread_time().

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-owolpbhyg7e46jp1egd3zhyp@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build                |   1 +
 tools/perf/tests/builtin-test.c       |   4 +
 tools/perf/tests/tests.h              |   1 +
 tools/perf/tests/thread-lookup-time.c | 181 ++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 tools/perf/tests/thread-lookup-time.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 713fc29871e2..715eb17d8047 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -26,6 +26,7 @@ perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
 perf-y += thread-comm.o
 perf-y += thread-mg-share.o
+perf-y += thread-lookup-time.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
 perf-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 982e5f64df62..c985ece3fab8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -283,6 +283,10 @@ static struct test generic_tests[] = {
 		.desc = "Test thread comm handling",
 		.func = test__thread_comm,
 	},
+	{
+		.desc = "Test thread lookup with time",
+		.func = test__thread_lookup_time,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5d16a56f262f..60fdc7bea1d8 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -105,6 +105,7 @@ int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__thread_comm(struct test *test, int subtest);
+int test__thread_lookup_time(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 
diff --git a/tools/perf/tests/thread-lookup-time.c b/tools/perf/tests/thread-lookup-time.c
new file mode 100644
index 000000000000..88e5bd5a7432
--- /dev/null
+++ b/tools/perf/tests/thread-lookup-time.c
@@ -0,0 +1,181 @@
+#include <linux/compiler.h>
+#include <inttypes.h>
+#include "tests.h"
+#include "machine.h"
+#include "thread.h"
+#include "map.h"
+#include "debug.h"
+
+static int thread__print_cb(struct thread *th, void *arg __maybe_unused)
+{
+	printf("thread: %d, start time: %"PRIu64" %s\n",
+	       th->tid, th->start_time,
+	       th->dead ? "(dead)" : th->exited ? "(exited)" : "");
+	return 0;
+}
+
+static int lookup_with_timestamp(struct machine *machine)
+{
+	struct thread *t1, *t2, *t3;
+	union perf_event fork_event = {
+		.fork = {
+			.pid = 0,
+			.tid = 0,
+			.ppid = 1,
+			.ptid = 1,
+		},
+	};
+	struct perf_sample sample = {
+		.time = 50000,
+	};
+
+	/* this is needed to keep dead threads in rbtree */
+	perf_has_index = true;
+
+	/* start_time is set to 0 */
+	t1 = machine__findnew_thread(machine, 0, 0);
+
+	if (verbose > 1) {
+		printf("========= after t1 created ==========\n");
+		machine__for_each_thread(machine, thread__print_cb, NULL);
+	}
+
+	TEST_ASSERT_VAL("wrong start time of old thread", t1->start_time == 0);
+
+	TEST_ASSERT_VAL("cannot find current thread",
+			machine__find_thread(machine, 0, 0) == t1);
+
+	TEST_ASSERT_VAL("cannot find current thread with time",
+			machine__findnew_thread_by_time(machine, 0, 0, 10000) == t1);
+
+	/* start_time is overwritten to new value */
+	thread__set_comm(t1, "/usr/bin/perf", 20000);
+
+	if (verbose > 1) {
+		printf("========= after t1 set comm ==========\n");
+		machine__for_each_thread(machine, thread__print_cb, NULL);
+	}
+
+	TEST_ASSERT_VAL("failed to update start time", t1->start_time == 20000);
+
+	TEST_ASSERT_VAL("should not find passed thread",
+			/* this will create yet another dead thread */
+			machine__findnew_thread_by_time(machine, 0, 0, 10000) != t1);
+
+	TEST_ASSERT_VAL("cannot find overwritten thread with time",
+			machine__find_thread_by_time(machine, 0, 0, 20000) == t1);
+
+	/* now t1 goes to dead thread tree, and create t2 */
+	machine__process_fork_event(machine, &fork_event, &sample);
+
+	if (verbose > 1) {
+		printf("========= after t2 forked ==========\n");
+		machine__for_each_thread(machine, thread__print_cb, NULL);
+	}
+
+	t2 = machine__find_thread(machine, 0, 0);
+
+	TEST_ASSERT_VAL("cannot find current thread", t2 != NULL);
+
+	TEST_ASSERT_VAL("wrong start time of new thread", t2->start_time == 50000);
+
+	TEST_ASSERT_VAL("dead thread cannot be found",
+			machine__find_thread_by_time(machine, 0, 0, 10000) != t1);
+
+	TEST_ASSERT_VAL("cannot find dead thread after new thread",
+			machine__find_thread_by_time(machine, 0, 0, 30000) == t1);
+
+	TEST_ASSERT_VAL("cannot find current thread after new thread",
+			machine__find_thread_by_time(machine, 0, 0, 50000) == t2);
+
+	/* now t2 goes to dead thread tree, and create t3 */
+	sample.time = 60000;
+	machine__process_fork_event(machine, &fork_event, &sample);
+
+	if (verbose > 1) {
+		printf("========= after t3 forked ==========\n");
+		machine__for_each_thread(machine, thread__print_cb, NULL);
+	}
+
+	t3 = machine__find_thread(machine, 0, 0);
+	TEST_ASSERT_VAL("cannot find current thread", t3 != NULL);
+
+	TEST_ASSERT_VAL("wrong start time of new thread", t3->start_time == 60000);
+
+	TEST_ASSERT_VAL("cannot find dead thread after new thread",
+			machine__findnew_thread_by_time(machine, 0, 0, 30000) == t1);
+
+	TEST_ASSERT_VAL("cannot find dead thread after new thread",
+			machine__findnew_thread_by_time(machine, 0, 0, 50000) == t2);
+
+	TEST_ASSERT_VAL("cannot find current thread after new thread",
+			machine__findnew_thread_by_time(machine, 0, 0, 70000) == t3);
+
+	machine__delete_threads(machine);
+	return 0;
+}
+
+static int lookup_without_timestamp(struct machine *machine)
+{
+	struct thread *t1, *t2, *t3;
+	union perf_event fork_event = {
+		.fork = {
+			.pid = 0,
+			.tid = 0,
+			.ppid = 1,
+			.ptid = 1,
+		},
+	};
+	struct perf_sample sample = {
+		.time = -1ULL,
+	};
+
+	t1 = machine__findnew_thread(machine, 0, 0);
+	TEST_ASSERT_VAL("cannot find current thread", t1 != NULL);
+
+	TEST_ASSERT_VAL("cannot find new thread with time",
+			machine__findnew_thread_by_time(machine, 0, 0, -1ULL) == t1);
+
+	machine__process_fork_event(machine, &fork_event, &sample);
+
+	t2 = machine__find_thread(machine, 0, 0);
+	TEST_ASSERT_VAL("cannot find current thread", t2 != NULL);
+
+	TEST_ASSERT_VAL("cannot find new thread with time",
+			machine__find_thread_by_time(machine, 0, 0, -1ULL) == t2);
+
+	machine__process_fork_event(machine, &fork_event, &sample);
+
+	t3 = machine__find_thread(machine, 0, 0);
+	TEST_ASSERT_VAL("cannot find current thread", t3 != NULL);
+
+	TEST_ASSERT_VAL("cannot find new thread with time",
+			machine__findnew_thread_by_time(machine, 0, 0, -1ULL) == t3);
+
+	machine__delete_threads(machine);
+	return 0;
+}
+
+int test__thread_lookup_time(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct machines machines;
+	struct machine *machine;
+
+	/*
+	 * This test is to check whether it can retrieve a correct
+	 * thread for a given time.  When multi-file data storage is
+	 * enabled, those task/comm/mmap events are processed first so
+	 * the later sample should find a matching thread properly.
+	 */
+	machines__init(&machines);
+	machine = &machines.host;
+
+	if (lookup_with_timestamp(machine) < 0)
+		return -1;
+
+	if (lookup_without_timestamp(machine) < 0)
+		return -1;
+
+	machines__exit(&machines);
+	return 0;
+}
-- 
2.17.1

