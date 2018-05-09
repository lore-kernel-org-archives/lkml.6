Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934714AbeEILpk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445944"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RFC 09/19] perf tools: Allow for special kernel maps
Date: Wed,  9 May 2018 14:43:38 +0300
Message-Id: <1525866228-30321-10-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify special kernel maps by name so that they can be distinguished from
the kernel map and module maps.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
index 1bf15aa0b099..f8c8e95062d0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -855,6 +855,7 @@ struct special_kernal_map {
 	u64 start;
 	u64 end;
 	u64 pgoff;
+	char name[KMAP_NAME_LEN];
 };
 
 static int machine__create_special_kernel_map(struct machine *machine,
@@ -874,11 +875,12 @@ static int machine__create_special_kernel_map(struct machine *machine,
 	kmap = map__kmap(map);
 
 	kmap->kmaps = &machine->kmaps;
+	strlcpy(kmap->name, sm->name, KMAP_NAME_LEN);
 
 	map_groups__insert(&machine->kmaps, map);
 
-	pr_debug2("Added special kernel map %" PRIx64 "-%" PRIx64 "\n",
-		  map->start, map->end);
+	pr_debug2("Added special kernel map %s %" PRIx64 "-%" PRIx64 "\n",
+		  kmap->name, map->start, map->end);
 
 	map__put(map);
 
@@ -948,6 +950,8 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			.pgoff = pgoff,
 		};
 
+		strlcpy(sm.name, ENTRY_TRAMPOLINE_NAME, KMAP_NAME_LEN);
+
 		if (machine__create_special_kernel_map(machine, kernel, &sm) < 0)
 			return -1;
 	}
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c8fe836e4c3c..8f36c12b4223 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -252,6 +252,13 @@ bool __map__is_kernel(const struct map *map)
 	return machine__kernel_map(map->groups->machine) == map;
 }
 
+bool __map__is_special_kernel_map(const struct map *map)
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
index fafcc375ed37..e6dd5998ebf9 100644
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
+bool __map__is_special_kernel_map(const struct map *map);
 
 static inline bool __map__is_kmodule(const struct map *map)
 {
-	return !__map__is_kernel(map);
+	return !__map__is_kernel(map) && !__map__is_special_kernel_map(map);
 }
 
 bool map__has_symbols(const struct map *map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e393f37b273b..35a91c1b7d3e 100644
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
1.9.1
