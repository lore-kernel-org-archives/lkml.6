Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2ECC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F262133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F262133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeIMSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25BFDC050006;
        Thu, 13 Sep 2018 12:55:48 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C358600C8;
        Thu, 13 Sep 2018 12:55:45 +0000 (UTC)
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
Subject: [PATCH 24/48] perf tools: Add a test case for timed map groups handling
Date:   Thu, 13 Sep 2018 14:54:26 +0200
Message-Id: <20180913125450.21342-25-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Sep 2018 12:55:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

A test case for verifying thread->mg and ->mg_list handling during
time change and new thread__find_addr_map_by_time() and friends.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-20jkz8hzs9njsvmrseo2o3s8@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build            |  1 +
 tools/perf/tests/builtin-test.c   |  4 ++
 tools/perf/tests/tests.h          |  1 +
 tools/perf/tests/thread-mg-time.c | 94 +++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)
 create mode 100644 tools/perf/tests/thread-mg-time.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 715eb17d8047..d14a532f87f1 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -27,6 +27,7 @@ perf-y += mmap-thread-lookup.o
 perf-y += thread-comm.o
 perf-y += thread-mg-share.o
 perf-y += thread-lookup-time.o
+perf-y += thread-mg-time.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
 perf-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c985ece3fab8..ee58cb40ebc2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -287,6 +287,10 @@ static struct test generic_tests[] = {
 		.desc = "Test thread lookup with time",
 		.func = test__thread_lookup_time,
 	},
+	{
+		.desc = "Test thread map group handling with time",
+		.func = test__thread_mg_time,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 60fdc7bea1d8..cd7cca258398 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -106,6 +106,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__thread_comm(struct test *test, int subtest);
 int test__thread_lookup_time(struct test *test, int subtest);
+int test__thread_mg_time(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 
diff --git a/tools/perf/tests/thread-mg-time.c b/tools/perf/tests/thread-mg-time.c
new file mode 100644
index 000000000000..6a735f59c097
--- /dev/null
+++ b/tools/perf/tests/thread-mg-time.c
@@ -0,0 +1,94 @@
+#include <linux/compiler.h>
+#include "tests.h"
+#include "machine.h"
+#include "thread.h"
+#include "map.h"
+#include "debug.h"
+
+#define PERF_MAP_START  0x40000
+
+int test__thread_mg_time(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct machines machines;
+	struct machine *machine;
+	struct thread *t;
+	struct map_groups *mg;
+	struct map *map, *old_map;
+	struct addr_location al = { .map = NULL, };
+
+	/*
+	 * This test is to check whether it can retrieve a correct map
+	 * for a given time.  When multi-file data storage is enabled,
+	 * those task/comm/mmap events are processed first so the
+	 * later sample should find a matching comm properly.
+	 */
+	machines__init(&machines);
+	machine = &machines.host;
+
+	/* this is needed to add/find map by time */
+	perf_has_index = true;
+
+	t = machine__findnew_thread(machine, 0, 0);
+	mg = t->mg;
+
+	map = dso__new_map("/usr/bin/perf");
+	map->start = PERF_MAP_START;
+	map->end = PERF_MAP_START + 0x1000;
+
+	thread__insert_map(t, map);
+
+	if (verbose > 1)
+		map_groups__fprintf(t->mg, stderr);
+
+	thread__find_addr_map(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
+			      PERF_MAP_START, &al);
+
+	TEST_ASSERT_VAL("cannot find mapping for perf", al.map != NULL);
+	TEST_ASSERT_VAL("non matched mapping found", al.map == map);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == mg);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == t->mg);
+
+	thread__find_addr_map_by_time(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
+				      PERF_MAP_START, &al, -1ULL);
+
+	TEST_ASSERT_VAL("cannot find timed mapping for perf", al.map != NULL);
+	TEST_ASSERT_VAL("non matched timed mapping", al.map == map);
+	TEST_ASSERT_VAL("incorrect timed map groups", al.map->groups == mg);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == t->mg);
+
+
+	pr_debug("simulate EXEC event (generate new mg)\n");
+	__thread__set_comm(t, "perf-test", 10000, true);
+
+	old_map = map;
+
+	map = dso__new_map("/usr/bin/perf-test");
+	map->start = PERF_MAP_START;
+	map->end = PERF_MAP_START + 0x2000;
+
+	thread__insert_map(t, map);
+
+	if (verbose > 1)
+		map_groups__fprintf(t->mg, stderr);
+
+	thread__find_addr_map(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
+			      PERF_MAP_START + 4, &al);
+
+	TEST_ASSERT_VAL("cannot find mapping for perf-test", al.map != NULL);
+	TEST_ASSERT_VAL("invalid mapping found", al.map == map);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups != mg);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == t->mg);
+
+	pr_debug("searching map in the old mag groups\n");
+	thread__find_addr_map_by_time(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
+				      PERF_MAP_START, &al, 5000);
+
+	TEST_ASSERT_VAL("cannot find timed mapping for perf-test", al.map != NULL);
+	TEST_ASSERT_VAL("non matched timed mapping", al.map == old_map);
+	TEST_ASSERT_VAL("incorrect timed map groups", al.map->groups == mg);
+	TEST_ASSERT_VAL("incorrect map groups", al.map->groups != t->mg);
+
+	machine__delete_threads(machine);
+	machines__exit(&machines);
+	return 0;
+}
-- 
2.17.1

