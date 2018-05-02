Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeEBRrs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:47:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeEBRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:47:41 -0400
Date: Wed, 2 May 2018 10:47:31 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4axi2sigslffdixzxbehvgoj@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org, dsahern@gmail.com, adrian.hunter@intel.com,
        mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Make thread__find_symbol() return the
 symbol searched
Git-Commit-ID: d9a5f274603bea1c89d59baaf37eef8f57851a09
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

Commit-ID:  d9a5f274603bea1c89d59baaf37eef8f57851a09
Gitweb:     https://git.kernel.org/tip/d9a5f274603bea1c89d59baaf37eef8f57851a09
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 24 Apr 2018 12:05:48 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:09 -0300

perf thread: Make thread__find_symbol() return the symbol searched

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
@@ -1566,14 +1566,14 @@ try_again:
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
