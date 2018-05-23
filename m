Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934922AbeEWUVr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934434AbeEWUVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/18] perf machine: Allow for extra kernel maps
Date: Wed, 23 May 2018 17:20:55 -0300
Message-Id: <20180523202106.17286-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Identify extra kernel maps by name so that they can be distinguished
from the kernel map and module maps.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-8-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c   |  2 +-
 tools/perf/util/machine.c |  8 ++++++--
 tools/perf/util/map.c     | 22 ++++++++++++++++++----
 tools/perf/util/map.h     |  7 ++++++-
 tools/perf/util/symbol.c  |  7 +++----
 5 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 244135b5ea43..aafa9878465f 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -487,7 +487,7 @@ int perf_event__synthesize_modules(struct perf_tool *tool,
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		size_t size;
 
-		if (__map__is_kernel(pos))
+		if (!__map__is_kmodule(pos))
 			continue;
 
 		size = PERF_ALIGN(pos->dso->long_name_len + 1, sizeof(u64));
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index db695603873b..355d23bcd443 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -856,6 +856,7 @@ struct extra_kernel_map {
 	u64 start;
 	u64 end;
 	u64 pgoff;
+	char name[KMAP_NAME_LEN];
 };
 
 static int machine__create_extra_kernel_map(struct machine *machine,
@@ -875,11 +876,12 @@ static int machine__create_extra_kernel_map(struct machine *machine,
 	kmap = map__kmap(map);
 
 	kmap->kmaps = &machine->kmaps;
+	strlcpy(kmap->name, xm->name, KMAP_NAME_LEN);
 
 	map_groups__insert(&machine->kmaps, map);
 
-	pr_debug2("Added extra kernel map %" PRIx64 "-%" PRIx64 "\n",
-		  map->start, map->end);
+	pr_debug2("Added extra kernel map %s %" PRIx64 "-%" PRIx64 "\n",
+		  kmap->name, map->start, map->end);
 
 	map__put(map);
 
@@ -940,6 +942,8 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			.pgoff = pgoff,
 		};
 
+		strlcpy(xm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
+
 		if (machine__create_extra_kernel_map(machine, kernel, &xm) < 0)
 			return -1;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c8fe836e4c3c..6ae97eda370b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -252,6 +252,13 @@ bool __map__is_kernel(const struct map *map)
 	return machine__kernel_map(map->groups->machine) == map;
 }
 
+bool __map__is_extra_kernel_map(const struct map *map)
+{
+	struct kmap *kmap = __map__kmap((struct map *)map);
+
+	return kmap && kmap->name[0];
+}
+
 bool map__has_symbols(const struct map *map)
 {
 	return dso__has_symbols(map->dso);
@@ -846,15 +853,22 @@ struct map *map__next(struct map *map)
 	return NULL;
 }
 
-struct kmap *map__kmap(struct map *map)
+struct kmap *__map__kmap(struct map *map)
 {
-	if (!map->dso || !map->dso->kernel) {
-		pr_err("Internal error: map__kmap with a non-kernel map\n");
+	if (!map->dso || !map->dso->kernel)
 		return NULL;
-	}
 	return (struct kmap *)(map + 1);
 }
 
+struct kmap *map__kmap(struct map *map)
+{
+	struct kmap *kmap = __map__kmap(map);
+
+	if (!kmap)
+		pr_err("Internal error: map__kmap with a non-kernel map\n");
+	return kmap;
+}
+
 struct map_groups *map__kmaps(struct map *map)
 {
 	struct kmap *kmap = map__kmap(map);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fafcc375ed37..97e2a063bd65 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -47,9 +47,12 @@ struct map {
 	refcount_t		refcnt;
 };
 
+#define KMAP_NAME_LEN 256
+
 struct kmap {
 	struct ref_reloc_sym	*ref_reloc_sym;
 	struct map_groups	*kmaps;
+	char			name[KMAP_NAME_LEN];
 };
 
 struct maps {
@@ -76,6 +79,7 @@ static inline struct map_groups *map_groups__get(struct map_groups *mg)
 
 void map_groups__put(struct map_groups *mg);
 
+struct kmap *__map__kmap(struct map *map);
 struct kmap *map__kmap(struct map *map);
 struct map_groups *map__kmaps(struct map *map);
 
@@ -232,10 +236,11 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
 struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
 
 bool __map__is_kernel(const struct map *map);
+bool __map__is_extra_kernel_map(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
-	return !__map__is_kernel(map);
+	return !__map__is_kernel(map) && !__map__is_extra_kernel_map(map);
 }
 
 bool map__has_symbols(const struct map *map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 929058da6727..cdddae67f40c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1030,7 +1030,7 @@ struct map *map_groups__first(struct map_groups *mg)
 	return maps__first(&mg->maps);
 }
 
-static int do_validate_kcore_modules(const char *filename, struct map *map,
+static int do_validate_kcore_modules(const char *filename,
 				  struct map_groups *kmaps)
 {
 	struct rb_root modules = RB_ROOT;
@@ -1046,8 +1046,7 @@ static int do_validate_kcore_modules(const char *filename, struct map *map,
 		struct map *next = map_groups__next(old_map);
 		struct module_info *mi;
 
-		if (old_map == map || old_map->start == map->start) {
-			/* The kernel map */
+		if (!__map__is_kmodule(old_map)) {
 			old_map = next;
 			continue;
 		}
@@ -1104,7 +1103,7 @@ static int validate_kcore_modules(const char *kallsyms_filename,
 					     kallsyms_filename))
 		return -EINVAL;
 
-	if (do_validate_kcore_modules(modules_filename, map, kmaps))
+	if (do_validate_kcore_modules(modules_filename, kmaps))
 		return -EINVAL;
 
 	return 0;
-- 
2.14.3
