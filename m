Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbeEBPVt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeEBPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 33/52] perf thread: Remove addr_type arg from thread__find_cpumode_addr_location()
Date: Wed,  2 May 2018 12:19:23 -0300
Message-Id: <20180502151942.20542-34-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All callers are for MAP__FUNCTION, so just ditch it and use
thread__find_symbol(), that already ditched MAP__FUNCTION, i.e.
internally uses it till we ditch it for good.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i0ocxs00b4a0tlrx31lyh2cs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 5 ++---
 tools/perf/util/thread.c  | 5 ++---
 tools/perf/util/thread.h  | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0017c4a1fb97..10364e829aba 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1660,7 +1660,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, MAP__FUNCTION, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -1754,8 +1754,7 @@ static int add_callchain_ip(struct thread *thread,
 	al.filtered = 0;
 	al.sym = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, MAP__FUNCTION,
-						   ip, &al);
+		thread__find_cpumode_addr_location(thread, ip, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2a3fb7c6b39d..ddbf0470b048 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -371,8 +371,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	return thread__clone_map_groups(thread, parent);
 }
 
-void thread__find_cpumode_addr_location(struct thread *thread,
-					enum map_type type, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al)
 {
 	size_t i;
@@ -384,7 +383,7 @@ void thread__find_cpumode_addr_location(struct thread *thread,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		__thread__find_symbol(thread, cpumodes[i], type, addr, al);
+		thread__find_symbol(thread, cpumodes[i], addr, al);
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 1b130b0a4a48..d6209c73f32d 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -110,8 +110,7 @@ static inline struct symbol *thread__find_symbol(struct thread *thread, u8 cpumo
 	return __thread__find_symbol(thread, cpumode, MAP__FUNCTION, addr, al);
 }
 
-void thread__find_cpumode_addr_location(struct thread *thread,
-					enum map_type type, u64 addr,
+void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
 
 static inline void *thread__priv(struct thread *thread)
-- 
2.14.3
