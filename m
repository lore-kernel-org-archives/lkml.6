Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeEBPZx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeEBPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:53 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 36/52] perf thread: Make thread__find_map() search all maps
Date: Wed,  2 May 2018 12:19:26 -0300
Message-Id: <20180502151942.20542-37-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We still have the split internally, but users don't see it anymore,
simplifying the growing number of cases where we end up searching
in the MAP__VARIABLE maps.

This further paves the way for ditching the split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-86mfxrztf310konutxvhr5ua@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c              |  4 ++--
 tools/perf/util/event.c                  | 19 +++++++++++--------
 tools/perf/util/thread.h                 | 10 ++--------
 tools/perf/util/unwind-libdw.c           | 10 ----------
 tools/perf/util/unwind-libunwind-local.c | 12 +-----------
 5 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 07cb083ac89c..fa2c7a288750 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -927,8 +927,8 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 
 	memset(&al, 0, sizeof(al));
 
-	if (!thread__find_map(thread, cpumode, addr, &al))
-		__thread__find_map(thread, cpumode, MAP__VARIABLE, addr, &al);
+	thread__find_map(thread, cpumode, addr, &al);
+
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		return 0;
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7b67771cd478..7831c2266118 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1488,8 +1488,8 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
-			       u64 addr, struct addr_location *al)
+static struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
+				      u64 addr, struct addr_location *al)
 {
 	struct map_groups *mg = thread->mg;
 	struct machine *machine = mg->machine;
@@ -1565,12 +1565,18 @@ struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type
 	return al->map;
 }
 
+struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+			     struct addr_location *al)
+{
+	struct map *map = __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
+	return map ?: __thread__find_map(thread, cpumode, MAP__VARIABLE, addr, al);
+}
+
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al)
 {
 	al->sym = NULL;
-	if (__thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al) ||
-	    __thread__find_map(thread, cpumode, MAP__VARIABLE, addr, al))
+	if (thread__find_map(thread, cpumode, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
@@ -1668,10 +1674,7 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	if (!thread__find_map(thread, sample->cpumode, sample->addr, al)) {
-		__thread__find_map(thread, sample->cpumode, MAP__VARIABLE,
-				   sample->addr, al);
-	}
+	thread__find_map(thread, sample->cpumode, sample->addr, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 54aa24d6151e..07606aa6998d 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -92,14 +92,8 @@ size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
 
-struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
-			       u64 addr, struct addr_location *al);
-
-static inline struct map *thread__find_map(struct thread *thread, u8 cpumode,
-					   u64 addr, struct addr_location *al)
-{
-	return __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
-}
+struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
+			     struct addr_location *al);
 
 struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 				   u64 addr, struct addr_location *al);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 17401922cd42..538db4e5d1e6 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -105,16 +105,6 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	ssize_t size;
 
 	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
-		/*
-		 * We've seen cases (softice) where DWARF unwinder went
-		 * through non executable mmaps, which we need to lookup
-		 * in MAP__VARIABLE tree.
-		 */
-		__thread__find_map(ui->thread, PERF_RECORD_MISC_USER,
-				   MAP__VARIABLE, addr, &al);
-	}
-
-	if (!al.map) {
 		pr_debug("unwind: no map for %lx\n", (unsigned long)addr);
 		return -1;
 	}
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 2afb22b0a1a9..6a11bc7e6b27 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -366,17 +366,7 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 {
 	struct addr_location al;
-
-	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al)) {
-		/*
-		 * We've seen cases (softice) where DWARF unwinder went
-		 * through non executable mmaps, which we need to lookup
-		 * in MAP__VARIABLE tree.
-		 */
-		__thread__find_map(ui->thread, PERF_RECORD_MISC_USER,
-				   MAP__VARIABLE, ip, &al);
-	}
-	return al.map;
+	return thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
 }
 
 static int
-- 
2.14.3
