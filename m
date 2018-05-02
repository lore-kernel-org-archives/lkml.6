Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEBPWD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbeEBPV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:21:56 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 37/52] perf map: Remove map_type arg from map_groups__find()
Date: Wed,  2 May 2018 12:19:27 -0300
Message-Id: <20180502151942.20542-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in ditching the split.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4pour7egur07tkrpbynawemv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/tests/dwarf-unwind.c     | 2 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c   | 2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c     | 2 +-
 tools/perf/util/map.h                        | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
index 7d7a65ca2e8d..9a0242e74cfc 100644
--- a/tools/perf/arch/arm/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index f053eae3b6eb..5522ce384723 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -25,7 +25,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_ARM64_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
index b22d643cb602..5f39efef0856 100644
--- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index 7da845026323..7879df34569a 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -26,7 +26,7 @@ static int sample_ustack(struct perf_sample *sample,
 
 	sp = (unsigned long) regs[PERF_REG_X86_SP];
 
-	map = __map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	map = map_groups__find(thread->mg, (u64)sp);
 	if (!map) {
 		pr_debug("failed to get stack map\n");
 		free(buf);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 579ad7d2711d..d035d8f0d5b2 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -222,7 +222,8 @@ static inline struct map *__map_groups__find(struct map_groups *mg,
 
 static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 {
-	return __map_groups__find(mg, MAP__FUNCTION, addr);
+	struct map *map = __map_groups__find(mg, MAP__FUNCTION, addr);
+	return map ?: __map_groups__find(mg, MAP__VARIABLE, addr);
 }
 
 struct map *map_groups__first(struct map_groups *mg);
-- 
2.14.3
