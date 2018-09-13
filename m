Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C2BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9826820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9826820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeIMSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeIMSEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60947307D980;
        Thu, 13 Sep 2018 12:55:27 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4FB35600C6;
        Thu, 13 Sep 2018 12:55:25 +0000 (UTC)
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
Subject: [PATCH 15/48] perf tools: Add a test case for thread comm handling
Date:   Thu, 13 Sep 2018 14:54:17 +0200
Message-Id: <20180913125450.21342-16-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 13 Sep 2018 12:55:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The new test case checks various thread comm handling APIs like
overridding and time sorting.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-b31f0pktgl0k2dba3lqp159w@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/tests/thread-comm.c  | 48 +++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 tools/perf/tests/thread-comm.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 6c108fa79ae3..713fc29871e2 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -24,6 +24,7 @@ perf-y += bp_account.o
 perf-y += task-exit.o
 perf-y += sw-clock.o
 perf-y += mmap-thread-lookup.o
+perf-y += thread-comm.o
 perf-y += thread-mg-share.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d7a5e1b9aa6f..982e5f64df62 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -279,6 +279,10 @@ static struct test generic_tests[] = {
 		.desc = "mem2node",
 		.func = test__mem2node,
 	},
+	{
+		.desc = "Test thread comm handling",
+		.func = test__thread_comm,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index a9760e790563..5d16a56f262f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -104,6 +104,7 @@ const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
+int test__thread_comm(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 
diff --git a/tools/perf/tests/thread-comm.c b/tools/perf/tests/thread-comm.c
new file mode 100644
index 000000000000..9fcfd2c43488
--- /dev/null
+++ b/tools/perf/tests/thread-comm.c
@@ -0,0 +1,48 @@
+#include <linux/compiler.h>
+#include "tests.h"
+#include "machine.h"
+#include "thread.h"
+#include "debug.h"
+
+int test__thread_comm(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct machines machines;
+	struct machine *machine;
+	struct thread *t;
+
+	/*
+	 * This test is to check whether it can retrieve a correct
+	 * comm for a given time.  When multi-file data storage is
+	 * enabled, those task/comm events are processed first so the
+	 * later sample should find a matching comm properly.
+	 */
+	machines__init(&machines);
+	machine = &machines.host;
+
+	t = machine__findnew_thread(machine, 100, 100);
+	TEST_ASSERT_VAL("wrong init thread comm",
+			!strcmp(thread__comm_str(t), ":100"));
+
+	thread__set_comm(t, "perf-test1", 10000);
+	TEST_ASSERT_VAL("failed to override thread comm",
+			!strcmp(thread__comm_str(t), "perf-test1"));
+
+	thread__set_comm(t, "perf-test2", 20000);
+	thread__set_comm(t, "perf-test3", 30000);
+	thread__set_comm(t, "perf-test4", 40000);
+
+	TEST_ASSERT_VAL("failed to find timed comm",
+			!strcmp(thread__comm_str_by_time(t, 20000), "perf-test2"));
+	TEST_ASSERT_VAL("failed to find timed comm",
+			!strcmp(thread__comm_str_by_time(t, 35000), "perf-test3"));
+	TEST_ASSERT_VAL("failed to find timed comm",
+			!strcmp(thread__comm_str_by_time(t, 50000), "perf-test4"));
+
+	thread__set_comm(t, "perf-test1.5", 15000);
+	TEST_ASSERT_VAL("failed to sort timed comm",
+			!strcmp(thread__comm_str_by_time(t, 15000), "perf-test1.5"));
+
+	machine__delete_threads(machine);
+	machines__exit(&machines);
+	return 0;
+}
-- 
2.17.1

