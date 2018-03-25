Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeCYWKh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:10:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeCYWKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:10:31 -0400
Date: Sun, 25 Mar 2018 15:10:19 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0jahghvqdodb8vu2591pkv3d@git.kernel.org>
Cc: wangnan0@huawei.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, mingo@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        dsahern@gmail.com
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        yao.jin@linux.intel.com, namhyung@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, dsahern@gmail.com, tglx@linutronix.de,
        jolsa@kernel.org, ak@linux.intel.com, mingo@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move compute_ipc() to annotation
 library
Git-Commit-ID: f56c083bc4f9bca6f4d75d13b93720915185a8e8
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

Commit-ID:  f56c083bc4f9bca6f4d75d13b93720915185a8e8
Gitweb:     https://git.kernel.org/tip/f56c083bc4f9bca6f4d75d13b93720915185a8e8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 11:46:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:28 -0300

perf annotate: Move compute_ipc() to annotation library

Out of the TUI code, as it has nothing specific to that UI and should be
used in the other output modes as well.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0jahghvqdodb8vu2591pkv3d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 69 +--------------------------------------
 tools/perf/util/annotate.c        | 60 ++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  2 ++
 3 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e89b68612408..353edff3fdbb 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -967,73 +967,6 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
 }
 
-
-static unsigned count_insn(struct annotation *notes, u64 start, u64 end)
-{
-	unsigned n_insn = 0;
-	u64 offset;
-
-	for (offset = start; offset <= end; offset++) {
-		if (notes->offsets[offset])
-			n_insn++;
-	}
-	return n_insn;
-}
-
-static void count_and_fill(struct annotation *notes, u64 start, u64 end,
-			   struct cyc_hist *ch)
-{
-	unsigned n_insn;
-	u64 offset;
-
-	n_insn = count_insn(notes, start, end);
-	if (n_insn && ch->num && ch->cycles) {
-		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
-
-		/* Hide data when there are too many overlaps. */
-		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
-			return;
-
-		for (offset = start; offset <= end; offset++) {
-			struct annotation_line *al = notes->offsets[offset];
-
-			if (al)
-				al->ipc = ipc;
-		}
-	}
-}
-
-/*
- * This should probably be in util/annotate.c to share with the tty
- * annotate, but right now we need the per byte offsets arrays,
- * which are only here.
- */
-static void annotate__compute_ipc(struct annotation *notes, size_t size)
-{
-	u64 offset;
-
-	if (!notes->src || !notes->src->cycles_hist)
-		return;
-
-	pthread_mutex_lock(&notes->lock);
-	for (offset = 0; offset < size; ++offset) {
-		struct cyc_hist *ch;
-
-		ch = &notes->src->cycles_hist[offset];
-		if (ch && ch->cycles) {
-			struct annotation_line *al;
-
-			if (ch->have_start)
-				count_and_fill(notes, ch->start, offset, ch);
-			al = notes->offsets[offset];
-			if (al && ch->num_aggr)
-				al->cycles = ch->cycles_aggr / ch->num_aggr;
-			notes->have_cycles = true;
-		}
-	}
-	pthread_mutex_unlock(&notes->lock);
-}
-
 static void annotate_browser__mark_jump_targets(struct annotate_browser *browser,
 						size_t size)
 {
@@ -1161,7 +1094,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	}
 
 	annotate_browser__mark_jump_targets(&browser, size);
-	annotate__compute_ipc(notes, size);
+	annotation__compute_ipc(notes, size);
 
 	browser.addr_width = browser.target_width = browser.min_addr_width = hex_width(size);
 	browser.max_addr_width = hex_width(sym->end);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 535357c6ce02..d737c33c87d0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -833,6 +833,66 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 	return err;
 }
 
+static unsigned annotation__count_insn(struct annotation *notes, u64 start, u64 end)
+{
+	unsigned n_insn = 0;
+	u64 offset;
+
+	for (offset = start; offset <= end; offset++) {
+		if (notes->offsets[offset])
+			n_insn++;
+	}
+	return n_insn;
+}
+
+static void annotation__count_and_fill(struct annotation *notes, u64 start, u64 end, struct cyc_hist *ch)
+{
+	unsigned n_insn;
+	u64 offset;
+
+	n_insn = annotation__count_insn(notes, start, end);
+	if (n_insn && ch->num && ch->cycles) {
+		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
+
+		/* Hide data when there are too many overlaps. */
+		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
+			return;
+
+		for (offset = start; offset <= end; offset++) {
+			struct annotation_line *al = notes->offsets[offset];
+
+			if (al)
+				al->ipc = ipc;
+		}
+	}
+}
+
+void annotation__compute_ipc(struct annotation *notes, size_t size)
+{
+	u64 offset;
+
+	if (!notes->src || !notes->src->cycles_hist)
+		return;
+
+	pthread_mutex_lock(&notes->lock);
+	for (offset = 0; offset < size; ++offset) {
+		struct cyc_hist *ch;
+
+		ch = &notes->src->cycles_hist[offset];
+		if (ch && ch->cycles) {
+			struct annotation_line *al;
+
+			if (ch->have_start)
+				annotation__count_and_fill(notes, ch->start, offset, ch);
+			al = notes->offsets[offset];
+			if (al && ch->num_aggr)
+				al->cycles = ch->cycles_aggr / ch->num_aggr;
+			notes->have_cycles = true;
+		}
+	}
+	pthread_mutex_unlock(&notes->lock);
+}
+
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
 				 int evidx)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d2c3436830a9..21fa5d7cd9e0 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -174,6 +174,8 @@ static inline int annotation__cycles_width(struct annotation *notes)
 	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
 }
 
+void annotation__compute_ipc(struct annotation *notes, size_t size);
+
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
 	return (((void *)&notes->src->histograms) +
