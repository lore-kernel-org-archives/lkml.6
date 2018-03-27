Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeC0LKA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:10:00 -0400
Received: from foss.arm.com ([217.140.101.70]:52970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752004AbeC0LJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:09:59 -0400
Date: Tue, 27 Mar 2018 06:09:56 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf tools: Add a dso_size option to perf report --sort
Message-Id: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
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
-- 
2.16.2
