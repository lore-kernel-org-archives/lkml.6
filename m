Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEBR4P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:56:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:56:12 -0400
Date: Wed, 2 May 2018 10:55:58 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-i0ocxs00b4a0tlrx31lyh2cs@git.kernel.org>
Cc: acme@redhat.com, dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, jolsa@kernel.org, dsahern@gmail.com, acme@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf thread: Remove addr_type arg from
 thread__find_cpumode_addr_location()
Git-Commit-ID: 26bd93316451256f92d18a331a3fd2f7e3b563ab
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

Commit-ID:  26bd93316451256f92d18a331a3fd2f7e3b563ab
Gitweb:     https://git.kernel.org/tip/26bd93316451256f92d18a331a3fd2f7e3b563ab
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 17:58:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:16 -0300

perf thread: Remove addr_type arg from thread__find_cpumode_addr_location()

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
