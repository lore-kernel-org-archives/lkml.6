Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCIIyP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:54:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCIIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:54:13 -0500
Date: Fri, 9 Mar 2018 00:53:51 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9f87498f1cb72958c6f8725eb93d2f7ef81fa11e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        jolsa@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
        dsahern@gmail.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, namhyung@kernel.org, mingo@kernel.org,
        dsahern@gmail.com
In-Reply-To: <20180307155020.32613-6-jolsa@kernel.org>
References: <20180307155020.32613-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add refcnt into struct mem_info
Git-Commit-ID: 9f87498f1cb72958c6f8725eb93d2f7ef81fa11e
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

Commit-ID:  9f87498f1cb72958c6f8725eb93d2f7ef81fa11e
Gitweb:     https://git.kernel.org/tip/9f87498f1cb72958c6f8725eb93d2f7ef81fa11e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Mar 2018 16:50:06 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 11:30:44 -0300

perf tools: Add refcnt into struct mem_info

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
