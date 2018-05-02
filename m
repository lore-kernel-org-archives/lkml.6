Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751121AbeEBRpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:45:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeEBRpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:45:16 -0400
Date: Wed, 2 May 2018 10:45:05 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-q27xee34l4izpfau49w103s6@git.kernel.org>
Cc: hpa@zytor.com, dsahern@gmail.com, acme@redhat.com, mingo@kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: dsahern@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Introduce thread__find_map()
Git-Commit-ID: f07a2d32b521a54635c8efeb0a3180b0afcf780a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f07a2d32b521a54635c8efeb0a3180b0afcf780a
Gitweb:     https://git.kernel.org/tip/f07a2d32b521a54635c8efeb0a3180b0afcf780a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 24 Apr 2018 10:49:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:06 -0300

perf thread: Introduce thread__find_map()

Out of thread__find_add_map(..., MAP__FUNCTION, ...), idea here is to
continue removing references to MAP__{FUNCTION,VARIABLE} ahead of
getting both types of symbols in the same rbtree, as various places do
two lookups, looking first at MAP__FUNCTION, then at MAP__VARIABLE.

So thread__find_map() will eventually do just that, and 'struct symbol'
will have the symbol type, for code that cares about that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q27xee34l4izpfau49w103s6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c              |  2 +-
 tools/perf/builtin-script.c              | 19 +++++++++----------
 tools/perf/tests/code-reading.c          |  4 ++--
 tools/perf/tests/mmap-thread-lookup.c    |  7 +++----
 tools/perf/util/build-id.c               |  2 +-
 tools/perf/util/cs-etm.c                 |  2 +-
 tools/perf/util/event.c                  | 18 +++++++++---------
 tools/perf/util/intel-bts.c              |  2 +-
 tools/perf/util/intel-pt.c               |  4 ++--
 tools/perf/util/thread.h                 | 11 ++++++++---
 tools/perf/util/unwind-libdw.c           |  7 +++----
 tools/perf/util/unwind-libunwind-local.c |  7 +++----
 12 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 40fe919bbcf3..92677d8f9eae 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -440,7 +440,7 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
 		goto repipe;
 	}
 
-	thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, sample->ip, &al);
+	thread__find_map(thread, sample->cpumode, sample->ip, &al);
 
 	if (al.map != NULL) {
 		if (!al.map->dso->hit) {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e0a9845b6cbc..5ec1c73bbfaf 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -717,8 +717,8 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
 			memset(&alt, 0, sizeof(alt));
-			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, from, &alf);
-			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
+			thread__find_map(thread, sample->cpumode, from, &alf);
+			thread__find_map(thread, sample->cpumode, to, &alt);
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -764,11 +764,11 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, from, &alf);
+		thread__find_map(thread, sample->cpumode, from, &alf);
 		if (alf.map)
 			alf.sym = map__find_symbol(alf.map, alf.addr);
 
-		thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
+		thread__find_map(thread, sample->cpumode, to, &alt);
 		if (alt.map)
 			alt.sym = map__find_symbol(alt.map, alt.addr);
 
@@ -814,11 +814,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, from, &alf);
+		thread__find_map(thread, sample->cpumode, from, &alf);
 		if (alf.map && !alf.map->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
-		thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
+		thread__find_map(thread, sample->cpumode, to, &alt);
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
@@ -882,7 +882,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		return 0;
 	}
 
-	thread__find_addr_map(thread, *cpumode, MAP__FUNCTION, start, &al);
+	thread__find_map(thread, *cpumode, start, &al);
 	if (!al.map || !al.map->dso) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
@@ -933,10 +933,9 @@ static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 
 	memset(&al, 0, sizeof(al));
 
-	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, addr, &al);
+	thread__find_map(thread, cpumode, addr, &al);
 	if (!al.map)
-		thread__find_addr_map(thread, cpumode, MAP__VARIABLE,
-				      addr, &al);
+		__thread__find_map(thread, cpumode, MAP__VARIABLE, addr, &al);
 	if ((*lastsym) && al.addr >= (*lastsym)->start && al.addr < (*lastsym)->end)
 		return 0;
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 99936352df4f..5b0a55499486 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -236,14 +236,14 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
 
-	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, addr, &al);
+	thread__find_map(thread, cpumode, addr, &al);
 	if (!al.map || !al.map->dso) {
 		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
 			pr_debug("Hypervisor address can not be resolved - skipping\n");
 			return 0;
 		}
 
-		pr_debug("thread__find_addr_map failed\n");
+		pr_debug("thread__find_map failed\n");
 		return -1;
 	}
 
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 868d82b501f4..b1af2499a3c9 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -188,9 +188,8 @@ static int mmap_events(synth_cb synth)
 
 		pr_debug("looking for map %p\n", td->map);
 
-		thread__find_addr_map(thread,
-				      PERF_RECORD_MISC_USER, MAP__FUNCTION,
-				      (unsigned long) (td->map + 1), &al);
+		thread__find_map(thread, PERF_RECORD_MISC_USER,
+				 (unsigned long) (td->map + 1), &al);
 
 		thread__put(thread);
 
@@ -218,7 +217,7 @@ static int mmap_events(synth_cb synth)
  *   perf_event__synthesize_threads    (global)
  *
  * We test we can find all memory maps via:
- *   thread__find_addr_map
+ *   thread__find_map
  *
  * by using all thread objects.
  */
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 537eadd81914..b512dc8fa6c3 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -47,7 +47,7 @@ int build_id__mark_dso_hit(struct perf_tool *tool __maybe_unused,
 		return -1;
 	}
 
-	thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, sample->ip, &al);
+	thread__find_map(thread, sample->cpumode, sample->ip, &al);
 
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 40020b1ca54f..8fe573d040b6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -269,7 +269,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 		thread = etmq->etm->unknown_thread;
 	}
 
-	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address, &al);
+	thread__find_map(thread, cpumode, address, &al);
 
 	if (!al.map || !al.map->dso)
 		return 0;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 98ff3a6a3d50..baa97d0b6114 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1489,9 +1489,8 @@ int perf_event__process(struct perf_tool *tool __maybe_unused,
 	return machine__process_event(machine, event, sample);
 }
 
-void thread__find_addr_map(struct thread *thread, u8 cpumode,
-			   enum map_type type, u64 addr,
-			   struct addr_location *al)
+void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
+			u64 addr, struct addr_location *al)
 {
 	struct map_groups *mg = thread->mg;
 	struct machine *machine = mg->machine;
@@ -1569,7 +1568,7 @@ void thread__find_addr_location(struct thread *thread,
 				u8 cpumode, enum map_type type, u64 addr,
 				struct addr_location *al)
 {
-	thread__find_addr_map(thread, cpumode, type, addr, al);
+	__thread__find_map(thread, cpumode, type, addr, al);
 	if (al->map != NULL)
 		al->sym = map__find_symbol(al->map, al->addr);
 	else
@@ -1590,7 +1589,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 		return -1;
 
 	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread->tid);
-	thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, sample->ip, al);
+	thread__find_map(thread, sample->cpumode, sample->ip, al);
 	dump_printf(" ...... dso: %s\n",
 		    al->map ? al->map->dso->long_name :
 			al->level == 'H' ? "[hypervisor]" : "<not found>");
@@ -1669,10 +1668,11 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, sample->addr, al);
-	if (!al->map)
-		thread__find_addr_map(thread, sample->cpumode, MAP__VARIABLE,
-				      sample->addr, al);
+	thread__find_map(thread, sample->cpumode, sample->addr, al);
+	if (!al->map) {
+		__thread__find_map(thread, sample->cpumode, MAP__VARIABLE,
+				   sample->addr, al);
+	}
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 72db2744876d..ea0ce8572bf2 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -335,7 +335,7 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 	if (!thread)
 		return -1;
 
-	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, ip, &al);
+	thread__find_map(thread, cpumode, ip, &al);
 	if (!al.map || !al.map->dso)
 		goto out_put;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 0effaff57020..441e681a46a0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -442,7 +442,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	}
 
 	while (1) {
-		thread__find_addr_map(thread, cpumode, MAP__FUNCTION, *ip, &al);
+		thread__find_map(thread, cpumode, *ip, &al);
 		if (!al.map || !al.map->dso)
 			return -EINVAL;
 
@@ -596,7 +596,7 @@ static int __intel_pt_pgd_ip(uint64_t ip, void *data)
 	if (!thread)
 		return -EINVAL;
 
-	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, ip, &al);
+	thread__find_map(thread, cpumode, ip, &al);
 	if (!al.map || !al.map->dso)
 		return -EINVAL;
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 14d44c3235b8..52c788f955de 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -92,9 +92,14 @@ size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
 
-void thread__find_addr_map(struct thread *thread,
-			   u8 cpumode, enum map_type type, u64 addr,
-			   struct addr_location *al);
+void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
+			u64 addr, struct addr_location *al);
+
+static inline void thread__find_map(struct thread *thread, u8 cpumode,
+				    u64 addr, struct addr_location *al)
+{
+	__thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
+}
 
 void thread__find_addr_location(struct thread *thread,
 				u8 cpumode, enum map_type type, u64 addr,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 7bdd239c795c..1ce8744649b5 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -103,16 +103,15 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	struct addr_location al;
 	ssize_t size;
 
-	thread__find_addr_map(ui->thread, PERF_RECORD_MISC_USER,
-			      MAP__FUNCTION, addr, &al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, addr, &al);
 	if (!al.map) {
 		/*
 		 * We've seen cases (softice) where DWARF unwinder went
 		 * through non executable mmaps, which we need to lookup
 		 * in MAP__VARIABLE tree.
 		 */
-		thread__find_addr_map(ui->thread, PERF_RECORD_MISC_USER,
-				      MAP__VARIABLE, addr, &al);
+		__thread__find_map(ui->thread, PERF_RECORD_MISC_USER,
+				   MAP__VARIABLE, addr, &al);
 	}
 
 	if (!al.map) {
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index af873044d33a..33afca5c04f6 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -367,16 +367,15 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 {
 	struct addr_location al;
 
-	thread__find_addr_map(ui->thread, PERF_RECORD_MISC_USER,
-			      MAP__FUNCTION, ip, &al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
 	if (!al.map) {
 		/*
 		 * We've seen cases (softice) where DWARF unwinder went
 		 * through non executable mmaps, which we need to lookup
 		 * in MAP__VARIABLE tree.
 		 */
-		thread__find_addr_map(ui->thread, PERF_RECORD_MISC_USER,
-				      MAP__VARIABLE, ip, &al);
+		__thread__find_map(ui->thread, PERF_RECORD_MISC_USER,
+				   MAP__VARIABLE, ip, &al);
 	}
 	return al.map;
 }
