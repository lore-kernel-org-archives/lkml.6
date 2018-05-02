Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEBR5J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:57:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeEBR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:57:05 -0400
Date: Wed, 2 May 2018 10:56:55 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uss70e8tvzzbzs326330t83q@git.kernel.org>
Cc: mingo@kernel.org, acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, acme@redhat.com, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, dsahern@gmail.com, wangnan0@huawei.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Ditch __thread__find_symbol()
Git-Commit-ID: 117d3c2474a24ab842af00972598c25abffee1e6
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

Commit-ID:  117d3c2474a24ab842af00972598c25abffee1e6
Gitweb:     https://git.kernel.org/tip/117d3c2474a24ab842af00972598c25abffee1e6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 18:16:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:17 -0300

perf thread: Ditch __thread__find_symbol()

Simulate having all symbols in just one tree by searching the still
existing two trees.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uss70e8tvzzbzs326330t83q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/event.c    |  8 ++++----
 tools/perf/util/machine.c  | 10 +---------
 tools/perf/util/thread.h   | 10 ++--------
 4 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index afec6f9ffd89..c7effcfc40ed 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2036,7 +2036,7 @@ static int trace__pgfault(struct trace *trace,
 
 	fprintf(trace->output, "] => ");
 
-	__thread__find_symbol(thread, sample->cpumode, MAP__VARIABLE, sample->addr, &al);
+	thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
 
 	if (!al.map) {
 		thread__find_symbol(thread, sample->cpumode, sample->addr, &al);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 241d3c827fae..7b67771cd478 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1565,12 +1565,12 @@ try_again:
 	return al->map;
 }
 
-struct symbol *__thread__find_symbol(struct thread *thread, u8 cpumode,
-				     enum map_type type, u64 addr,
-				     struct addr_location *al)
+struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
+				   u64 addr, struct addr_location *al)
 {
 	al->sym = NULL;
-	if (__thread__find_map(thread, cpumode, type, addr, al))
+	if (__thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al) ||
+	    __thread__find_map(thread, cpumode, MAP__VARIABLE, addr, al))
 		al->sym = map__find_symbol(al->map, al->addr);
 	return al->sym;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a00e82b83e0a..3422ef67ec21 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1677,15 +1677,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	memset(&al, 0, sizeof(al));
 
-	__thread__find_symbol(thread, m, MAP__VARIABLE, addr, &al);
-	if (al.map == NULL) {
-		/*
-		 * some shared data regions have execute bit set which puts
-		 * their mapping in the MAP__FUNCTION type array.
-		 * Check there as a fallback option before dropping the sample.
-		 */
-		thread__find_symbol(thread, m, addr, &al);
-	}
+	thread__find_symbol(thread, m, addr, &al);
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d6209c73f32d..54aa24d6151e 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -101,14 +101,8 @@ static inline struct map *thread__find_map(struct thread *thread, u8 cpumode,
 	return __thread__find_map(thread, cpumode, MAP__FUNCTION, addr, al);
 }
 
-struct symbol *__thread__find_symbol(struct thread *thread, u8 cpumode, enum map_type type,
-				     u64 addr, struct addr_location *al);
-
-static inline struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
-						 u64 addr, struct addr_location *al)
-{
-	return __thread__find_symbol(thread, cpumode, MAP__FUNCTION, addr, al);
-}
+struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
+				   u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
