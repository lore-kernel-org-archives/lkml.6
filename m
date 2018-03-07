Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeCGP5M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:57:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933937AbeCGPuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:35 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 05/19] perf tools: Add refcnt into struct mem_info
Date: Wed,  7 Mar 2018 16:50:06 +0100
Message-Id: <20180307155020.32613-6-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's passed along several hists entries in --hierarchy mode,
so it's better we keep track of it.

The current fail I see is that it gets removed in hierarchy
--mem-mode mode, where it's shared in the different hierarchies,
but removed from the template hist entry, so the report crashes.

Link: http://lkml.kernel.org/n/tip-vwr82ygpfv4kisaxfyopaef6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/hist.c    |  4 ++--
 tools/perf/util/machine.c |  2 +-
 tools/perf/util/symbol.c  | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h  | 19 ++++++++++++++++---
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 44a8456cea10..7d968892ee39 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -536,7 +536,7 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
 			 * This mem info was allocated from sample__resolve_mem
 			 * and will not be used anymore.
 			 */
-			zfree(&entry->mem_info);
+			mem_info__zput(entry->mem_info);
 
 			/* If the map of an existing hist_entry has
 			 * become out-of-date due to an exec() or
@@ -1139,7 +1139,7 @@ void hist_entry__delete(struct hist_entry *he)
 	if (he->mem_info) {
 		map__zput(he->mem_info->iaddr.map);
 		map__zput(he->mem_info->daddr.map);
-		zfree(&he->mem_info);
+		mem_info__zput(he->mem_info);
 	}
 
 	zfree(&he->stat_acc);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 12b7427444a3..d46c98d6dedd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1697,7 +1697,7 @@ static void ip__resolve_data(struct thread *thread,
 struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 				     struct addr_location *al)
 {
-	struct mem_info *mi = zalloc(sizeof(*mi));
+	struct mem_info *mi = mem_info__aloc();
 
 	if (!mi)
 		return NULL;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a1a312d99f30..117cd25cd21a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2221,3 +2221,25 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 	free(bf);
 	return 0;
 }
+
+struct mem_info *mem_info__get(struct mem_info *mi)
+{
+	if (mi)
+		refcount_inc(&mi->refcnt);
+	return mi;
+}
+
+void mem_info__put(struct mem_info *mi)
+{
+	if (mi && refcount_dec_and_test(&mi->refcnt))
+		free(mi);
+}
+
+struct mem_info *mem_info__aloc(void)
+{
+	struct mem_info *mi = zalloc(sizeof(*mi));
+
+	if (mi)
+		refcount_set(&mi->refcnt, 1);
+	return mi;
+}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0563f33c1eb3..7e3ac7f35d63 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -200,9 +200,10 @@ struct branch_info {
 };
 
 struct mem_info {
-	struct addr_map_symbol iaddr;
-	struct addr_map_symbol daddr;
-	union perf_mem_data_src data_src;
+	struct addr_map_symbol	iaddr;
+	struct addr_map_symbol	daddr;
+	union perf_mem_data_src	data_src;
+	refcount_t		refcnt;
 };
 
 struct addr_location {
@@ -389,4 +390,16 @@ int sdt_notes__get_count(struct list_head *start);
 #define SDT_NOTE_NAME "stapsdt"
 #define NR_ADDR 3
 
+struct mem_info *mem_info__aloc(void);
+struct mem_info *mem_info__get(struct mem_info *mi);
+void   mem_info__put(struct mem_info *mi);
+
+static inline void __mem_info__zput(struct mem_info **mi)
+{
+	mem_info__put(*mi);
+	*mi = NULL;
+}
+
+#define mem_info__zput(mi) __mem_info__zput(&mi)
+
 #endif /* __PERF_SYMBOL */
-- 
2.13.6
