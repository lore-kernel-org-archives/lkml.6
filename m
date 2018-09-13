Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C81C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61CD20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61CD20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeIMSFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFCAD13AB3;
        Thu, 13 Sep 2018 12:55:50 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F1F5600C9;
        Thu, 13 Sep 2018 12:55:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 25/48] perf tools: Save timestamp of a map creation
Date:   Thu, 13 Sep 2018 14:54:27 +0200
Message-Id: <20180913125450.21342-26-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:55:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

It'll be used to support multiple maps on a same address like dlopen()
and/or JIT compile cases.

Cc: Stephane Eranian <eranian@google.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-p39jo653jdpz7uyzz7ih5xk9@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/thread-mg-time.c | 16 ++++++++--------
 tools/perf/util/dso.c             |  2 +-
 tools/perf/util/machine.c         | 27 ++++++++++++++++-----------
 tools/perf/util/machine.h         |  2 +-
 tools/perf/util/map.c             | 12 +++++++-----
 tools/perf/util/map.h             |  9 ++++++---
 tools/perf/util/symbol-elf.c      |  2 +-
 tools/perf/util/symbol.c          |  4 ++--
 8 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/thread-mg-time.c b/tools/perf/tests/thread-mg-time.c
index 6a735f59c097..19dc298756c8 100644
--- a/tools/perf/tests/thread-mg-time.c
+++ b/tools/perf/tests/thread-mg-time.c
@@ -40,16 +40,16 @@ int test__thread_mg_time(struct test *test __maybe_unused, int subtest __maybe_u
 	if (verbose > 1)
 		map_groups__fprintf(t->mg, stderr);
 
-	thread__find_addr_map(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
-			      PERF_MAP_START, &al);
+	thread__find_map(t, PERF_RECORD_MISC_USER,
+			 PERF_MAP_START, &al);
 
 	TEST_ASSERT_VAL("cannot find mapping for perf", al.map != NULL);
 	TEST_ASSERT_VAL("non matched mapping found", al.map == map);
 	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == mg);
 	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == t->mg);
 
-	thread__find_addr_map_by_time(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
-				      PERF_MAP_START, &al, -1ULL);
+	thread__find_map_by_time(t, PERF_RECORD_MISC_USER,
+				 PERF_MAP_START, &al, -1ULL);
 
 	TEST_ASSERT_VAL("cannot find timed mapping for perf", al.map != NULL);
 	TEST_ASSERT_VAL("non matched timed mapping", al.map == map);
@@ -71,8 +71,8 @@ int test__thread_mg_time(struct test *test __maybe_unused, int subtest __maybe_u
 	if (verbose > 1)
 		map_groups__fprintf(t->mg, stderr);
 
-	thread__find_addr_map(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
-			      PERF_MAP_START + 4, &al);
+	thread__find_map(t, PERF_RECORD_MISC_USER,
+			 PERF_MAP_START + 4, &al);
 
 	TEST_ASSERT_VAL("cannot find mapping for perf-test", al.map != NULL);
 	TEST_ASSERT_VAL("invalid mapping found", al.map == map);
@@ -80,8 +80,8 @@ int test__thread_mg_time(struct test *test __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("incorrect map groups", al.map->groups == t->mg);
 
 	pr_debug("searching map in the old mag groups\n");
-	thread__find_addr_map_by_time(t, PERF_RECORD_MISC_USER, MAP__FUNCTION,
-				      PERF_MAP_START, &al, 5000);
+	thread__find_map_by_time(t, PERF_RECORD_MISC_USER,
+				 PERF_MAP_START, &al, 5000);
 
 	TEST_ASSERT_VAL("cannot find timed mapping for perf-test", al.map != NULL);
 	TEST_ASSERT_VAL("non matched timed mapping", al.map == old_map);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index bbed90e5d9bb..2729239daf0b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1010,7 +1010,7 @@ struct map *dso__new_map(const char *name)
 	struct dso *dso = dso__new(name);
 
 	if (dso)
-		map = map__new2(0, dso);
+		map = map__new2(0, dso, 0);
 
 	return map;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc46a7967e10..abf66c7dd26a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -854,7 +854,7 @@ static void dso__adjust_kmod_long_name(struct dso *dso, const char *filename)
 }
 
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
-					const char *filename)
+					const char *filename, u64 timestamp)
 {
 	struct map *map = NULL;
 	struct dso *dso = NULL;
@@ -878,7 +878,7 @@ struct map *machine__findnew_module_map(struct machine *machine, u64 start,
 	if (dso == NULL)
 		goto out;
 
-	map = map__new2(start, dso);
+	map = map__new2(start, dso, timestamp);
 	if (map == NULL)
 		goto out;
 
@@ -1050,7 +1050,7 @@ int machine__create_extra_kernel_map(struct machine *machine,
 	struct kmap *kmap;
 	struct map *map;
 
-	map = map__new2(xm->start, kernel);
+	map = map__new2(xm->start, kernel, 0);
 	if (!map)
 		return -1;
 
@@ -1176,7 +1176,7 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	/* In case of renewal the kernel map, destroy previous one */
 	machine__destroy_kernel_maps(machine);
 
-	machine->vmlinux_map = map__new2(0, kernel);
+	machine->vmlinux_map = map__new2(0, kernel, 0);
 	if (machine->vmlinux_map == NULL)
 		return -1;
 
@@ -1463,7 +1463,7 @@ static int machine__create_module(void *arg, const char *name, u64 start,
 	if (arch__fix_module_text_start(&start, name) < 0)
 		return -1;
 
-	map = machine__findnew_module_map(machine, start, name);
+	map = machine__findnew_module_map(machine, start, name, 0);
 	if (map == NULL)
 		return -1;
 	map->end = start + size;
@@ -1608,7 +1608,8 @@ static int machine__process_extra_kernel_map(struct machine *machine,
 }
 
 static int machine__process_kernel_mmap_event(struct machine *machine,
-					      union perf_event *event)
+					      union perf_event *event,
+					      u64 timestamp)
 {
 	struct map *map;
 	enum dso_kernel_type kernel_type;
@@ -1629,7 +1630,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	if (event->mmap.filename[0] == '/' ||
 	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
 		map = machine__findnew_module_map(machine, event->mmap.start,
-						  event->mmap.filename);
+						  event->mmap.filename,
+						  timestamp);
 		if (map == NULL)
 			goto out_problem;
 
@@ -1731,7 +1733,8 @@ int machine__process_mmap2_event(struct machine *machine,
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
-		ret = machine__process_kernel_mmap_event(machine, event);
+		ret = machine__process_kernel_mmap_event(machine, event,
+							 sample->time);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1749,7 +1752,8 @@ int machine__process_mmap2_event(struct machine *machine,
 			event->mmap2.ino_generation,
 			event->mmap2.prot,
 			event->mmap2.flags,
-			event->mmap2.filename, thread);
+			event->mmap2.filename, thread,
+			sample->time);
 
 	if (map == NULL)
 		goto out_problem_map;
@@ -1784,7 +1788,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
-		ret = machine__process_kernel_mmap_event(machine, event);
+		ret = machine__process_kernel_mmap_event(machine, event,
+							 sample->time);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1802,7 +1807,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 			event->mmap.len, event->mmap.pgoff,
 			0, 0, 0, 0, prot, 0,
 			event->mmap.filename,
-			thread);
+			thread, sample->time);
 
 	if (map == NULL)
 		goto out_problem_map;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 9aed55d9facc..733d5814542b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -221,7 +221,7 @@ struct symbol *machine__find_kernel_symbol_by_name(struct machine *machine,
 }
 
 struct map *machine__findnew_module_map(struct machine *machine, u64 start,
-					const char *filename);
+					const char *filename, u64 timestamp);
 int arch__fix_module_text_start(u64 *start, const char *name);
 
 int machine__load_kallsyms(struct machine *machine, const char *filename);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6d6a0f65a9a0..2821919156c9 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -124,7 +124,8 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 	return false;
 }
 
-void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
+void map__init(struct map *map, u64 start, u64 end, u64 pgoff,
+	       struct dso *dso, u64 timestamp)
 {
 	map->start    = start;
 	map->end      = end;
@@ -137,12 +138,13 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
 	map->groups   = NULL;
 	map->erange_warned = false;
 	refcount_set(&map->refcnt, 1);
+	map->timestamp = timestamp;
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags, char *filename,
-		     struct thread *thread)
+		     struct thread *thread, u64 timestamp)
 {
 	struct map *map = malloc(sizeof(*map));
 	struct nsinfo *nsi = NULL;
@@ -196,7 +198,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		if (dso == NULL)
 			goto out_delete;
 
-		map__init(map, start, start + len, pgoff, dso);
+		map__init(map, start, start + len, pgoff, dso, timestamp);
 
 		if (anon || no_dso) {
 			map->map_ip = map->unmap_ip = identity__map_ip;
@@ -224,7 +226,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
  * they are loaded) and for vmlinux, where only after we load all the
  * symbols we'll know where it starts and ends.
  */
-struct map *map__new2(u64 start, struct dso *dso)
+struct map *map__new2(u64 start, struct dso *dso, u64 timestamp)
 {
 	struct map *map = calloc(1, (sizeof(*map) +
 				     (dso->kernel ? sizeof(struct kmap) : 0)));
@@ -232,7 +234,7 @@ struct map *map__new2(u64 start, struct dso *dso)
 		/*
 		 * ->end will be filled after we load all the symbols
 		 */
-		map__init(map, start, 0, 0, dso);
+		map__init(map, start, 0, 0, dso, timestamp);
 	}
 
 	return map;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fb5f40fea2e3..0d35064cf813 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -36,6 +36,7 @@ struct map {
 	u32			maj, min; /* only valid for MMAP2 record */
 	u64			ino;      /* only valid for MMAP2 record */
 	u64			ino_generation;/* only valid for MMAP2 record */
+	u64			timestamp;
 
 	/* ip -> dso rip */
 	u64			(*map_ip)(struct map *, u64);
@@ -142,12 +143,14 @@ struct thread;
 	__map__for_each_symbol_by_name(map, sym_name, (pos))
 
 void map__init(struct map *map,
-	       u64 start, u64 end, u64 pgoff, struct dso *dso);
+	       u64 start, u64 end, u64 pgoff, struct dso *dso,
+	       u64 timestamp);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags,
-		     char *filename, struct thread *thread);
-struct map *map__new2(u64 start, struct dso *dso);
+		     char *filename, struct thread *thread,
+		     u64 timestamp);
+struct map *map__new2(u64 start, struct dso *dso, u64 timestamp);
 void map__delete(struct map *map);
 struct map *map__clone(struct map *map);
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..7214942e1ddf 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -870,7 +870,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		curr_dso->kernel = dso->kernel;
 		curr_dso->long_name = dso->long_name;
 		curr_dso->long_name_len = dso->long_name_len;
-		curr_map = map__new2(start, curr_dso);
+		curr_map = map__new2(start, curr_dso, map->timestamp);
 		dso__put(curr_dso);
 		if (curr_map == NULL)
 			return -1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d188b7588152..91252507b3ab 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -832,7 +832,7 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 
 			ndso->kernel = dso->kernel;
 
-			curr_map = map__new2(pos->start, ndso);
+			curr_map = map__new2(pos->start, ndso, 0);
 			if (curr_map == NULL) {
 				dso__put(ndso);
 				return -1;
@@ -1139,7 +1139,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 	struct kcore_mapfn_data *md = data;
 	struct map *map;
 
-	map = map__new2(start, md->dso);
+	map = map__new2(start, md->dso, 0);
 	if (map == NULL)
 		return -ENOMEM;
 
-- 
2.17.1

