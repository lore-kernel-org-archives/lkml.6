Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCHTzv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:55:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbeCHTwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632F32178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/54] perf tools: Add refcnt into struct mem_info
Date: Thu,  8 Mar 2018 16:50:19 -0300
Message-Id: <20180308195029.14991-45-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It's passed along several hists entries in --hierarchy mode, so it's
better we keep track of it.

The current fail I see is that it gets removed in hierarchy --mem-mode
mode, where it's shared in the different hierarchies, but removed from
the template hist entry, so the report crashes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-6-jolsa@kernel.org
[ Rename mem_info__aloc() to mem_info__new(), to fix the typo and use the convention for constructors ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 12b7427444a3..43fbbee409ec 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1697,7 +1697,7 @@ static void ip__resolve_data(struct thread *thread,
 struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 				     struct addr_location *al)
 {
-	struct mem_info *mi = zalloc(sizeof(*mi));
+	struct mem_info *mi = mem_info__new();
 
 	if (!mi)
 		return NULL;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a1a312d99f30..62b2dd2253eb 100644
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
+struct mem_info *mem_info__new(void)
+{
+	struct mem_info *mi = zalloc(sizeof(*mi));
+
+	if (mi)
+		refcount_set(&mi->refcnt, 1);
+	return mi;
+}
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 0563f33c1eb3..70c16741f50a 100644
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
 
+struct mem_info *mem_info__new(void);
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
2.14.3
