Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeEBPVA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751911AbeEBPUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:54 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/52] perf thread: Make thread__find_map() return the map
Date: Wed,  2 May 2018 12:19:06 -0300
Message-Id: <20180502151942.20542-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It was returning the searched map just on the addr_location passed, with
the function itself returning void.

Make it return the map so that we can make the code more compact.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tzlrrzdeoof4i6ktyqv1t6ks@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c              |  4 +---
 tools/perf/builtin-script.c              | 14 ++++++--------
 tools/perf/tests/code-reading.c          |  3 +--
 tools/perf/util/build-id.c               |  4 +---
 tools/perf/util/cs-etm.c                 |  4 +---
 tools/perf/util/event.c                  | 16 ++++++++--------
 tools/perf/util/intel-bts.c              |  3 +--
 tools/perf/util/intel-pt.c               |  6 ++----
 tools/perf/util/thread.h                 | 10 +++++-----
 tools/perf/util/unwind-libdw.c           |  3 +--
 tools/perf/util/unwind-libunwind-local.c |  3 +--
 11 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 92677d8f9eae..a3b346359ba0 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -440,9 +440,7 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 		goto repipe;
 	}
 
-	thread__find_map(thread, sample->cpumode, sample->ip, &al);
-
-	if (al.map != NULL) {
+	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
 		if (!al.map->dso->hit) {
 			al.map->dso->hit = 1;
 			if (map__load(al.map) >= 0) {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ffd02faee87b..07cb083ac89c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -809,12 +809,12 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_map(thread, sample->cpumode, from, &alf);
-		if (alf.map && !alf.map->dso->adjust_symbols)
+		if (thread__find_map(thread, sample->cpumode, from, &alf) &&
+		    !alf.map->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
-		thread__find_map(thread, sample->cpumode, to, &alt);
-		if (alt.map && !alt.map->dso->adjust_symbols)
+		if (thread__find_map(thread, sample->cpumode, to, &alt) &&
+		    !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -877,8 +877,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		return 0;
 	}
 
-	thread__find_map(thread, *cpumode, start, &al);
-	if (!al.map || !al.map->dso) {
+	if (!thread__find_map(thread, *cpumode, start, &al) || !al.map->dso) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
@@ -928,8 +927,7 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 
 	memset(&al, 0, sizeof(al));
 
-	thread__find_map(thread, cpumode, addr, &al);
-	if (!al.map)
+	if (!thread__find_map(thread, cpumode, addr, &al))
 		__thread__find_map(thread, cpumode, MAP__VARIABLE, addr, &al);
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		return 0;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 5b0a55499486..afa4ce21ba7c 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -236,8 +236,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
-	thread__find_map(thread, cpumode, addr, &al);
-	if (!al.map || !al.map->dso) {
+	if (!thread__find_map(thread, cpumode, addr, &al) || !al.map->dso) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			return 0;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index b512dc8fa6c3..04b1d53e4bf9 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -47,9 +47,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
-	thread__find_map(thread, sample->cpumode, sample->ip, &al);
-
-	if (al.map != NULL)
+	if (thread__find_map(thread, sample->cpumode, sample->ip, &al))
 		al.map->dso->hit = 1;
 
 	thread__put(thread);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8fe573d040b6..6533b1adb50b 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -269,9 +269,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 		thread = etmq->etm->unknown_thread;
 	}
 
-	thread__find_map(thread, cpumode, address, &al);
-
-	if (!al.map || !al.map->dso)
+	if (!thread__find_map(thread, cpumode, address, &al) || !al.map->dso)
 		return 0;
 
 	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2d860fbeb227..48e4b252f6ff 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1489,8 +1489,8 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
-			u64 addr, struct addr_location *al)
+struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
+			       u64 addr, struct addr_location *al)
 {
 	struct map_groups *mg = thread->mg;
 	struct machine *machine = mg->machine;
@@ -1504,7 +1504,7 @@ void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
 
 	if (machine == NULL) {
 		al->map = NULL;
-		return;
+		return NULL;
 	}
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
@@ -1532,7 +1532,7 @@ void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
 			!perf_host)
 			al->filtered |= (1 << HIST_FILTER__HOST);
 
-		return;
+		return NULL;
 	}
 try_again:
 	al->map = map_groups__find(mg, type, al->addr);
@@ -1562,14 +1562,15 @@ void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
 			map__load(al->map);
 		al->addr = al->map->map_ip(al->map, al->addr);
 	}
+
+	return al->map;
 }
 
 void __thread__find_symbol(struct thread *thread, u8 cpumode,
 			   enum map_type type, u64 addr,
 			   struct addr_location *al)
 {
-	__thread__find_map(thread, cpumode, type, addr, al);
-	if (al->map != NULL)
+	if (__thread__find_map(thread, cpumode, type, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	else
 		al->sym = NULL;
@@ -1668,8 +1669,7 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map(thread, sample->cpumode, sample->addr, al);
-	if (!al->map) {
+	if (!thread__find_map(thread, sample->cpumode, sample->addr, al)) {
 		__thread__find_map(thread, sample->cpumode, MAP__VARIABLE,
 				   sample->addr, al);
 	}
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index ea0ce8572bf2..7f0c83b6332b 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -335,8 +335,7 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 	if (!thread)
 		return -1;
 
-	thread__find_map(thread, cpumode, ip, &al);
-	if (!al.map || !al.map->dso)
+	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
 		goto out_put;
 
 	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 441e681a46a0..a272b35f6c5a 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -442,8 +442,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	}
 
 	while (1) {
-		thread__find_map(thread, cpumode, *ip, &al);
-		if (!al.map || !al.map->dso)
+		if (!thread__find_map(thread, cpumode, *ip, &al) || !al.map->dso)
 			return -EINVAL;
 
 		if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
@@ -596,8 +595,7 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	if (!thread)
 		return -EINVAL;
 
-	thread__find_map(thread, cpumode, ip, &al);
-	if (!al.map || !al.map->dso)
+	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
 		return -EINVAL;
 
 	offset = al.map->map_ip(al.map, ip);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index b69e65c821f9..1961e4bc1c2c 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -92,13 +92,13 @@ size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
 
-void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
-			u64 addr, struct addr_location *al);
+struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
+			       u64 addr, struct addr_location *al);
 
-static inline void thread__find_map(struct thread *thread, u8 cpumode,
-				    u64 addr, struct addr_location *al)
+static inline struct map *thread__find_map(struct thread *thread, u8 cpumode,
+					   u64 addr, struct addr_location *al)
 {
-	__thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
+	return __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
 }
 
 void __thread__find_symbol(struct thread *thread, u8 cpumode, enum map_type type,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index bdc22f1864df..17401922cd42 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -104,8 +104,7 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	struct addr_location al;
 	ssize_t size;
 
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al);
-	if (!al.map) {
+	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al)) {
 		/*
 		 * We've seen cases (softice) where DWARF unwinder went
 		 * through non executable mmaps, which we need to lookup
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 0007c64f3220..4662590ef091 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -367,8 +367,7 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 {
 	struct addr_location al;
 
-	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
-	if (!al.map) {
+	if (!thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al)) {
 		/*
 		 * We've seen cases (softice) where DWARF unwinder went
 		 * through non executable mmaps, which we need to lookup
-- 
2.14.3
