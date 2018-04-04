Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeDDF3M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:29:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:29:10 -0400
Date: Tue, 3 Apr 2018 22:28:24 -0700
From: tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-b74d12d598143c2dd30b9cb9636a50dded4cc49f@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, yao.jin@linux.intel.com,
        milian.wolff@kdab.com, namhyung@kernel.org, tglx@linutronix.de,
        kim.phillips@arm.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        maxim.kuvyrkov@linaro.org, ak@linux.intel.com, jolsa@redhat.com,
        acme@redhat.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, kim.phillips@arm.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        maxim.kuvyrkov@linaro.org, linux-kernel@vger.kernel.org,
        acme@redhat.com, ak@linux.intel.com, jolsa@redhat.com, hpa@zytor.com,
        peterz@infradead.org, yao.jin@linux.intel.com, milian.wolff@kdab.com
In-Reply-To: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
References: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add a "dso_size" sort order
Git-Commit-ID: b74d12d598143c2dd30b9cb9636a50dded4cc49f
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

Commit-ID:  b74d12d598143c2dd30b9cb9636a50dded4cc49f
Gitweb:     https://git.kernel.org/tip/b74d12d598143c2dd30b9cb9636a50dded4cc49f
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Tue, 27 Mar 2018 06:09:56 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 07:57:37 -0300

perf tools: Add a "dso_size" sort order

Add DSO size to perf report/top sort output list.

This includes adding a map__size fn to map.h, which is
approximately equal to the DSO data file_size:

  DSO				file size	map (end-start)	file / (end-start)
  libwebkit2gtk-4.0.so.37.24.9	43260072	41295872	95%
  libglib-2.0.so.0.5400.1		 1125680	 1118208	99%
  libc-2.26.so			 1960656 	 1925120	101%
  libdbus-1.so.3.14.13		  309456 	  303104	102%

Sample output:

  $ ./perf report -s dso_size,dso
  Samples: 2K of event 'cycles:uppp', Event count (approx.): 128373340
  Overhead  DSO size  Shared Object
    90.62%   unknown  [unknown]
     2.87%   1118208  libglib-2.0.so.0.5400.1
     1.92%    303104  libdbus-1.so.3.14.13
     1.42%   1925120  libc-2.26.so
     0.77%  41295872  libwebkit2gtk-4.0.so.37.24.9
     0.61%    335872  libgobject-2.0.so.0.5400.1
     0.41%   1052672  libgdk-3.so.0.2200.25
     0.36%    106496  libpthread-2.26.so
     0.29%    221184  dbus-daemon
     0.17%    159744  ld-2.26.so
     0.13%     49152  libwayland-client.so.0.3.0
     0.12%   1642496  libgio-2.0.so.0.5400.1
     0.09%   7327744  libgtk-3.so.0.2200.25
     0.09%  12324864  libmozjs-52.so.0.0.0
     0.05%   4796416  perf
     0.04%    843776  libgjs.so.0.0.0
     0.03%   1409024  libmutter-clutter-1.so

Committer testing:

To sort by DSO size, use:

  # perf report -F dso_size,dso,overhead -s dso_size
  <SNIP>
     3465216  libdns-export.so.174.0.1   0.00%
     3522560  libgc.so.1.0.3             0.00%
     3538944  libbfd-2.29-13.fc27.so     0.59%
     3670016  libunistring.so.2.1.0      0.00%
     3723264  libguile-2.0.so.22.8.1     0.00%
     3776512  libgio-2.0.so.0.5400.3     0.00%
     3891200  libc-2.26.so               0.96%
     3944448  libmozjs-17.0.so           0.00%
     4218880  libperl.so.5.26.1          0.18%
     4452352  libpython2.7.so.1.0        0.02%
     4472832  perf                       0.02%
     4603904  git                        0.01%
     4751360  libcrypto.so.1.1.0g        0.00%
     5005312  libslang.so.2.3.1          0.00%
     7315456  libgtk-3.so.0.2200.26      0.09%
     8818688  i965_dri.so                2.46%
     8818688  i965_dri.so (deleted)      1.26%
    12414976  libmozjs-52.so.0.0.0       0.03%
    23642112  cc1                        2.02%
    27889664  [kernel.kallsyms]         25.41%
    80834560  libxul.so (deleted)       15.68%
    98078720  chrome                    32.03%
  1056964608  [kernel.kallsyms]          1.59%
  #

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180327060956.1c01ebe67a2a941bb4468c6f@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/map.h                    |  4 ++++
 tools/perf/util/sort.c                   | 41 ++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 5 files changed, 48 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index e1a660e60849..917e36fde6d8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -80,6 +80,7 @@ OPTIONS
 	- comm: command (name) of the task which can be read via /proc/<pid>/comm
 	- pid: command and tid of the task
 	- dso: name of library or module executed at the time of sample
+	- dso_size: size of library or module executed at the time of sample
 	- symbol: name of function executed at the time of sample
 	- symbol_size: size of function executed at the time of sample
 	- parent: name of function matched to the parent regex filter. Unmatched
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index e869cad4d89f..32fbf26e0c18 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -61,6 +61,7 @@ enum hist_column {
 	HISTC_SRCLINE_TO,
 	HISTC_TRACE,
 	HISTC_SYM_SIZE,
+	HISTC_DSO_SIZE,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index edeb7291c8e1..0e9bbe01b0ab 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -103,6 +103,10 @@ static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
 	return ip;
 }
 
+static inline size_t map__size(const struct map *map)
+{
+	return map->end - map->start;
+}
 
 /* rip/ip <-> addr suitable for passing to `objdump --start-address=` */
 u64 map__rip_2objdump(struct map *map, u64 rip);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e8514f651865..26a68dfd8a4f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1545,6 +1545,46 @@ struct sort_entry sort_sym_size = {
 	.se_width_idx	= HISTC_SYM_SIZE,
 };
 
+/* --sort dso_size */
+
+static int64_t _sort__dso_size_cmp(struct map *map_l, struct map *map_r)
+{
+	int64_t size_l = map_l != NULL ? map__size(map_l) : 0;
+	int64_t size_r = map_r != NULL ? map__size(map_r) : 0;
+
+	return size_l < size_r ? -1 :
+		size_l == size_r ? 0 : 1;
+}
+
+static int64_t
+sort__dso_size_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return _sort__dso_size_cmp(right->ms.map, left->ms.map);
+}
+
+static int _hist_entry__dso_size_snprintf(struct map *map, char *bf,
+					  size_t bf_size, unsigned int width)
+{
+	if (map && map->dso)
+		return repsep_snprintf(bf, bf_size, "%*d", width,
+				       map__size(map));
+
+	return repsep_snprintf(bf, bf_size, "%*s", width, "unknown");
+}
+
+static int hist_entry__dso_size_snprintf(struct hist_entry *he, char *bf,
+					 size_t size, unsigned int width)
+{
+	return _hist_entry__dso_size_snprintf(he->ms.map, bf, size, width);
+}
+
+struct sort_entry sort_dso_size = {
+	.se_header	= "DSO size",
+	.se_cmp		= sort__dso_size_cmp,
+	.se_snprintf	= hist_entry__dso_size_snprintf,
+	.se_width_idx	= HISTC_DSO_SIZE,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -1569,6 +1609,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_TRANSACTION, "transaction", sort_transaction),
 	DIM(SORT_TRACE, "trace", sort_trace),
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
+	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 };
 
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index f5901c10a563..035b62e2c60b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -220,6 +220,7 @@ enum sort_type {
 	SORT_TRANSACTION,
 	SORT_TRACE,
 	SORT_SYM_SIZE,
+	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 
 	/* branch stack specific sort keys */
