Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbeEBPVF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeEBPU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:57 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 17/52] perf thread: Make thread__find_symbol() return the symbol searched
Date: Wed,  2 May 2018 12:19:07 -0300
Message-Id: <20180502151942.20542-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of just returning it in al.sym, allowing for some simplification
in its users, and to make it consistent with thread__find_map().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4axi2sigslffdixzxbehvgoj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c           |  7 ++-----
 tools/perf/util/event.c                  | 10 +++++-----
 tools/perf/util/thread.h                 |  8 ++++----
 tools/perf/util/unwind-libunwind-local.c |  4 +---
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 38fcbb5ddce8..a827919c6263 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -533,11 +533,8 @@ static const char *cat_backtrace(union perf_event *event,
 		}
 
 		tal.filtered = 0;
-		thread__find_symbol(al.thread, cpumode, ip, &tal);
-
-		if (tal.sym)
-			fprintf(f, "..... %016" PRIx64 " %s\n", ip,
-				tal.sym->name);
+		if (thread__find_symbol(al.thread, cpumode, ip, &tal))
+			fprintf(f, "..... %016" PRIx64 " %s\n", ip, tal.sym->name);
 		else
 			fprintf(f, "..... %016" PRIx64 "\n", ip);
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 48e4b252f6ff..9d94c59046d1 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1566,14 +1566,14 @@ struct map *__thread__find_map(struct thread *thread, u8 cpumode, enum map_type
 	return al->map;
 }
 
-void __thread__find_symbol(struct thread *thread, u8 cpumode,
-			   enum map_type type, u64 addr,
-			   struct addr_location *al)
+struct symbol *__thread__find_symbol(struct thread *thread, u8 cpumode,
+				     enum map_type type, u64 addr,
+				     struct addr_location *al)
 {
+	al->sym = NULL;
 	if (__thread__find_map(thread, cpumode, type, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
-	else
-		al->sym = NULL;
+	return al->sym;
 }
 
 /*
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 1961e4bc1c2c..1b130b0a4a48 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -101,11 +101,11 @@ static inline struct map *thread__find_map(struct thread *thread, u8 cpumode,
 	return __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
 }
 
-void __thread__find_symbol(struct thread *thread, u8 cpumode, enum map_type type,
-			   u64 addr, struct addr_location *al);
+struct symbol *__thread__find_symbol(struct thread *thread, u8 cpumode, enum map_type type,
+				     u64 addr, struct addr_location *al);
 
-static inline void thread__find_symbol(struct thread *thread, u8 cpumode,
-				       u64 addr, struct addr_location *al)
+static inline struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
+						 u64 addr, struct addr_location *al)
 {
 	return __thread__find_symbol(thread, cpumode, MAP__FUNCTION, addr, al);
 }
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 4662590ef091..2afb22b0a1a9 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -584,11 +584,9 @@ static int entry(u64 ip, struct thread *thread,
 	struct unwind_entry e;
 	struct addr_location al;
 
-	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
-
+	e.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip = al.addr;
 	e.map = al.map;
-	e.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
-- 
2.14.3
