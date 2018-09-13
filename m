Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC17C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EED20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EED20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeIMSFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3761C057FAB;
        Thu, 13 Sep 2018 12:55:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2B6600CD;
        Thu, 13 Sep 2018 12:55:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 28/48] perf tools: Add testcase for managing maps with time
Date:   Thu, 13 Sep 2018 14:54:30 +0200
Message-Id: <20180913125450.21342-29-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Sep 2018 12:55:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

This tests new map_groups__{insert,find}_by_time() API working
correctly by using 3 * 100 maps.

Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-h0fna591s3uf1zyaftvos9hj@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build             |  1 +
 tools/perf/tests/builtin-test.c    |  4 ++
 tools/perf/tests/tests.h           |  1 +
 tools/perf/tests/thread-map-time.c | 90 ++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 tools/perf/tests/thread-map-time.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index d14a532f87f1..edaec95c8812 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -28,6 +28,7 @@ perf-y += thread-comm.o
 perf-y += thread-mg-share.o
 perf-y += thread-lookup-time.o
 perf-y += thread-mg-time.o
+perf-y += thread-map-time.o
 perf-y += switch-tracking.o
 perf-y += keep-tracking.o
 perf-y += code-reading.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index ee58cb40ebc2..fe8ef107e61b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -291,6 +291,10 @@ static struct test generic_tests[] = {
 		.desc = "Test thread map group handling with time",
 		.func = test__thread_mg_time,
 	},
+	{
+		.desc = "Test thread map lookup with time",
+		.func = test__thread_map_lookup_time,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index cd7cca258398..3c831a08f37a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -107,6 +107,7 @@ int test__mem2node(struct test *t, int subtest);
 int test__thread_comm(struct test *test, int subtest);
 int test__thread_lookup_time(struct test *test, int subtest);
 int test__thread_mg_time(struct test *test, int subtest);
+int test__thread_map_lookup_time(struct test *test, int subtest);
 
 bool test__bp_signal_is_supported(void);
 
diff --git a/tools/perf/tests/thread-map-time.c b/tools/perf/tests/thread-map-time.c
new file mode 100644
index 000000000000..f1e59944268c
--- /dev/null
+++ b/tools/perf/tests/thread-map-time.c
@@ -0,0 +1,90 @@
+#include <linux/compiler.h>
+#include "debug.h"
+#include "tests.h"
+#include "machine.h"
+#include "thread.h"
+#include "map.h"
+
+#define PERF_MAP_START  0x40000
+#define LIBC_MAP_START  0x80000
+#define VDSO_MAP_START  0x7F000
+
+#define NR_MAPS  100
+
+static int lookup_maps(struct map_groups *mg)
+{
+	struct map *map;
+	int i, ret = -1;
+	size_t n;
+	struct {
+		const char *path;
+		u64 start;
+	} maps[] = {
+		{ "/usr/bin/perf",	PERF_MAP_START },
+		{ "/usr/lib/libc.so",	LIBC_MAP_START },
+		{ "[vdso]",		VDSO_MAP_START },
+	};
+
+	/* this is needed to insert/find map by time */
+	perf_has_index = true;
+
+	for (n = 0; n < ARRAY_SIZE(maps); n++) {
+		for (i = 0; i < NR_MAPS; i++) {
+			map = map__new2(maps[n].start, dso__new(maps[n].path),
+					i * 10000);
+			if (map == NULL) {
+				pr_debug("memory allocation failed\n");
+				goto out;
+			}
+
+			map->end = map->start + 0x1000;
+			map_groups__insert_by_time(mg, map);
+		}
+	}
+
+	if (verbose > 1)
+		map_groups__fprintf(mg, stderr);
+
+	for (n = 0; n < ARRAY_SIZE(maps); n++) {
+		for (i = 0; i < NR_MAPS; i++) {
+			u64 timestamp = i * 10000;
+
+			map = map_groups__find_by_time(mg, maps[n].start,
+						       timestamp);
+
+			TEST_ASSERT_VAL("cannot find map", map);
+			TEST_ASSERT_VAL("addr not matched",
+					map->start == maps[n].start);
+			TEST_ASSERT_VAL("pathname not matched",
+					!strcmp(map->dso->name, maps[n].path));
+			TEST_ASSERT_VAL("timestamp not matched",
+					map->timestamp == timestamp);
+		}
+	}
+
+	ret = 0;
+out:
+	return ret;
+}
+
+/*
+ * This test creates large number of overlapping maps for increasing
+ * time and find a map based on timestamp.
+ */
+int test__thread_map_lookup_time(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct machines machines;
+	struct machine *machine;
+	struct thread *t;
+	int ret;
+
+	machines__init(&machines);
+	machine = &machines.host;
+
+	t = machine__findnew_thread(machine, 0, 0);
+
+	ret = lookup_maps(t->mg);
+
+	machine__delete_threads(machine);
+	return ret;
+}
-- 
2.17.1

