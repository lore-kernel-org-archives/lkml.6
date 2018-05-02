Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeEBPUx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751911AbeEBPUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:48 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/52] perf thread: Introduce thread__find_symbol()
Date: Wed,  2 May 2018 12:19:04 -0300
Message-Id: <20180502151942.20542-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of thread__find_addr_location(..., MAP__FUNCTION, ...), idea here is to
continue removing references to MAP__{FUNCTION,VARIABLE} ahead of
getting both types of symbols in the same rbtree, as various places do
two lookups, looking first at MAP__FUNCTION, then at MAP__VARIABLE.

So thread__find_symbol() will eventually do just that, and 'struct
symbol' will have the symbol type, for code that cares about that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-n7528en9e08yd3flzmb26tth@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c |  3 +--
 tools/perf/builtin-timechart.c                    |  3 +--
 tools/perf/builtin-trace.c                        |  9 +++------
 tools/perf/util/event.c                           |  6 +++---
 tools/perf/util/machine.c                         |  7 +++----
 tools/perf/util/thread.c                          |  2 +-
 tools/perf/util/thread.h                          | 11 ++++++++---
 tools/perf/util/unwind-libdw.c                    |  9 +++++----
 tools/perf/util/unwind-libunwind-local.c          |  3 +--
 9 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 0c370f81e002..3598b8b75d27 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -248,8 +248,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 
 	ip = chain->ips[2];
 
-	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
-			MAP__FUNCTION, ip, &al);
+	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
 	if (al.map)
 		dso = al.map->dso;
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 813698a9b8c7..38fcbb5ddce8 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -533,8 +533,7 @@ static const char *cat_backtrace(union perf_event *event,
 		}
 
 		tal.filtered = 0;
-		thread__find_addr_location(al.thread, cpumode,
-					   MAP__FUNCTION, ip, &tal);
+		thread__find_symbol(al.thread, cpumode, ip, &tal);
 
 		if (tal.sym)
 			fprintf(f, "..... %016" PRIx64 " %s\n", ip,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3ad17ee89403..afec6f9ffd89 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2024,8 +2024,7 @@ static int trace__pgfault(struct trace *trace,
 	if (trace->summary_only)
 		goto out;
 
-	thread__find_addr_location(thread, sample->cpumode, MAP__FUNCTION,
-			      sample->ip, &al);
+	thread__find_symbol(thread, sample->cpumode, sample->ip, &al);
 
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
 
@@ -2037,12 +2036,10 @@ static int trace__pgfault(struct trace *trace,
 
 	fprintf(trace->output, "] => ");
 
-	thread__find_addr_location(thread, sample->cpumode, MAP__VARIABLE,
-				   sample->addr, &al);
+	__thread__find_symbol(thread, sample->cpumode, MAP__VARIABLE, sample->addr, &al);
 
 	if (!al.map) {
-		thread__find_addr_location(thread, sample->cpumode,
-					   MAP__FUNCTION, sample->addr, &al);
+		thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
 
 		if (al.map)
 			map_type = 'x';
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index baa97d0b6114..2d860fbeb227 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1564,9 +1564,9 @@ void __thread__find_map(struct thread *thread, u8 cpumode, enum map_type type,
 	}
 }
 
-void thread__find_addr_location(struct thread *thread,
-				u8 cpumode, enum map_type type, u64 addr,
-				struct addr_location *al)
+void __thread__find_symbol(struct thread *thread, u8 cpumode,
+			   enum map_type type, u64 addr,
+			   struct addr_location *al)
 {
 	__thread__find_map(thread, cpumode, type, addr, al);
 	if (al->map != NULL)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 32d50492505d..e354d94a68e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1681,14 +1681,14 @@ static void ip__resolve_data(struct thread *thread,
 
 	memset(&al, 0, sizeof(al));
 
-	thread__find_addr_location(thread, m, MAP__VARIABLE, addr, &al);
+	__thread__find_symbol(thread, m, MAP__VARIABLE, addr, &al);
 	if (al.map == NULL) {
 		/*
 		 * some shared data regions have execute bit set which puts
 		 * their mapping in the MAP__FUNCTION type array.
 		 * Check there as a fallback option before dropping the sample.
 		 */
-		thread__find_addr_location(thread, m, MAP__FUNCTION, addr, &al);
+		thread__find_symbol(thread, m, addr, &al);
 	}
 
 	ams->addr = addr;
@@ -1784,8 +1784,7 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			return 0;
 		}
-		thread__find_addr_location(thread, *cpumode, MAP__FUNCTION,
-					   ip, &al);
+		thread__find_symbol(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 68b65b10579b..2a3fb7c6b39d 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -384,7 +384,7 @@ void thread__find_cpumode_addr_location(struct thread *thread,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		thread__find_addr_location(thread, cpumodes[i], type, addr, al);
+		__thread__find_symbol(thread, cpumodes[i], type, addr, al);
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 52c788f955de..b69e65c821f9 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -101,9 +101,14 @@ static inline void thread__find_map(struct thread *thread, u8 cpumode,
 	__thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
 }
 
-void thread__find_addr_location(struct thread *thread,
-				u8 cpumode, enum map_type type, u64 addr,
-				struct addr_location *al);
+void __thread__find_symbol(struct thread *thread, u8 cpumode, enum map_type type,
+			   u64 addr, struct addr_location *al);
+
+static inline void thread__find_symbol(struct thread *thread, u8 cpumode,
+				       u64 addr, struct addr_location *al)
+{
+	return __thread__find_symbol(thread, cpumode, MAP__FUNCTION, addr, al);
+}
 
 void thread__find_cpumode_addr_location(struct thread *thread,
 					enum map_type type, u64 addr,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 1ce8744649b5..bdc22f1864df 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -28,10 +28,11 @@ static int __report_module(struct addr_location *al, u64 ip,
 {
 	Dwfl_Module *mod;
 	struct dso *dso = NULL;
-
-	thread__find_addr_location(ui->thread,
-				   PERF_RECORD_MISC_USER,
-				   MAP__FUNCTION, ip, al);
+	/*
+	 * Some callers will use al->sym, so we can't just use the
+	 * cheaper thread__find_map() here.
+	 */
+	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
 
 	if (al->map)
 		dso = al->map->dso;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 33afca5c04f6..0007c64f3220 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -585,8 +585,7 @@ static int entry(u64 ip, struct thread *thread,
 	struct unwind_entry e;
 	struct addr_location al;
 
-	thread__find_addr_location(thread, PERF_RECORD_MISC_USER,
-				   MAP__FUNCTION, ip, &al);
+	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
 	e.ip = al.addr;
 	e.map = al.map;
-- 
2.14.3
